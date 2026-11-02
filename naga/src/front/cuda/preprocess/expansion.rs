use alloc::{string::String, vec::Vec};
use core::mem::size_of;

use crate::{FastHashMap, Span};

use super::{
    check_predefined, conditions, error,
    lex::{Kind, RawToken},
    Budget, Definition, ExpandedToken, ParseError, Spelling, MAX_DEPTH,
};

mod pasting;

use pasting::HideSet;

#[derive(Clone, Copy, PartialEq)]
pub(super) enum Mode {
    Shader,
    Condition,
    Argument,
}

#[derive(Clone)]
struct Token<'a> {
    value: ExpandedToken<'a>,
    original: bool,
    hidden: HideSet,
}

impl<'a> Token<'a> {
    fn original(raw: &'a RawToken) -> Self {
        Self {
            value: ExpandedToken {
                kind: raw.kind,
                spelling: Spelling::Borrowed(raw.spelling.as_str()),
                span: raw.span,
            },
            original: true,
            hidden: HideSet::default(),
        }
    }
}

struct Frame<'a> {
    tokens: Vec<Token<'a>>,
    next: usize,
    macro_identifier: Option<usize>,
    span: Span,
}

struct Context {
    pending_depth: usize,
    outer_span: Option<Span>,
    mode: Mode,
    directive: bool,
}

struct Expander<'a, 'budget> {
    definitions: &'a FastHashMap<String, Definition>,
    budget: &'budget mut Budget,
    frames: Vec<Frame<'a>>,
    pending_depth: usize,
    outer_span: Option<Span>,
    mode: Mode,
    directive: bool,
}

pub(super) fn expand<'a>(
    tokens: &'a [RawToken],
    definitions: &'a FastHashMap<String, Definition>,
    budget: &mut Budget,
    mode: Mode,
    directive: bool,
    emit: &mut impl FnMut(ExpandedToken<'a>) -> Result<(), ParseError>,
) -> Result<(), ParseError> {
    let mut input = Vec::new();
    for token in tokens {
        budget.push(&mut input, Token::original(token), token.span)?;
    }
    let mut expander = Expander::new(
        input,
        definitions,
        budget,
        Context {
            pending_depth: 0,
            outer_span: None,
            mode,
            directive,
        },
    )?;
    expander.run(&mut |token| emit(token.value))
}

impl<'a, 'budget> Expander<'a, 'budget> {
    fn new(
        tokens: Vec<Token<'a>>,
        definitions: &'a FastHashMap<String, Definition>,
        budget: &'budget mut Budget,
        context: Context,
    ) -> Result<Self, ParseError> {
        let Context {
            pending_depth,
            outer_span,
            mode,
            directive,
        } = context;
        let span = outer_span.unwrap_or_else(|| {
            tokens
                .first()
                .map_or(Span::UNDEFINED, |token| token.value.span)
        });
        let mut frames = Vec::new();
        budget.push(
            &mut frames,
            Frame {
                tokens,
                next: 0,
                macro_identifier: None,
                span,
            },
            span,
        )?;
        Ok(Self {
            definitions,
            budget,
            frames,
            pending_depth,
            outer_span,
            mode,
            directive,
        })
    }

    fn depth(&self) -> usize {
        self.pending_depth
            + self
                .frames
                .iter()
                .filter(|frame| frame.macro_identifier.is_some())
                .count()
    }

    fn peek(&mut self) -> Result<Option<Token<'a>>, ParseError> {
        for frame in self.frames.iter().rev() {
            self.budget.step(frame.span)?;
            if let Some(token) = frame.tokens.get(frame.next) {
                return Ok(Some(token.clone()));
            }
        }
        Ok(None)
    }

    fn next(&mut self) -> Result<Option<Token<'a>>, ParseError> {
        loop {
            let Some(frame) = self.frames.last_mut() else {
                return Ok(None);
            };
            self.budget.step(frame.span)?;
            let Some(mut token) = frame.tokens.get(frame.next).cloned() else {
                self.frames.pop();
                continue;
            };
            frame.next += 1;
            if let Some(span) = self.outer_span {
                token.value.span = span;
            }
            self.budget
                .visit(token.value.spelling.as_str().len(), token.value.span)?;
            return Ok(Some(token));
        }
    }

    fn run(
        &mut self,
        emit: &mut dyn FnMut(Token<'a>) -> Result<(), ParseError>,
    ) -> Result<(), ParseError> {
        while let Some(mut token) = self.next()? {
            if token.value.kind == Kind::Word {
                if self.mode == Mode::Condition && token.value.spelling.as_str() == "defined" {
                    if !token.original {
                        return Err(error(
                            "macro expansion producing defined is unsupported",
                            token.value.span,
                        ));
                    }
                    token = self.query(token)?;
                } else {
                    check_predefined(token.value.spelling.as_str(), token.value.span)?;
                    self.budget
                        .visit(token.value.spelling.as_str().len(), token.value.span)?;
                    if let Some(definition) = self.definitions.get(token.value.spelling.as_str()) {
                        if !token.hidden.contains(
                            definition.identifier,
                            self.budget,
                            token.value.span,
                        )? {
                            let invoked = definition.parameters.is_none()
                                || self
                                    .peek()?
                                    .is_some_and(|next| next.value.spelling.as_str() == "(");
                            if invoked {
                                self.invoke(token, definition)?;
                                continue;
                            }
                        }
                    }
                }
            }
            self.budget.emit(token.value.span)?;
            self.budget.step(token.value.span)?;
            self.budget
                .visit(token.value.spelling.as_str().len(), token.value.span)?;
            self.budget.own(size_of::<Token<'_>>(), token.value.span)?;
            emit(token)?;
        }
        Ok(())
    }

    fn query(&mut self, operator: Token<'a>) -> Result<Token<'a>, ParseError> {
        let mut operand = self.next()?.ok_or_else(|| {
            error(
                "expected preprocessing macro name after defined",
                operator.value.span,
            )
        })?;
        let parenthesized = operand.value.spelling.as_str() == "(";
        if parenthesized {
            operand = self.next()?.ok_or_else(|| {
                error(
                    "expected preprocessing macro name after defined",
                    operator.value.span,
                )
            })?;
        }
        if operand.value.kind != Kind::Word
            || conditions::is_alternative(operand.value.spelling.as_str())
        {
            return Err(error(
                "expected preprocessing macro name after defined",
                operand.value.span,
            ));
        }
        check_predefined(operand.value.spelling.as_str(), operand.value.span)?;
        self.budget
            .visit(operand.value.spelling.as_str().len(), operand.value.span)?;
        let value = self
            .definitions
            .contains_key(operand.value.spelling.as_str());
        let mut span = operator.value.span;
        span.subsume(operand.value.span);
        if parenthesized {
            let closing = self
                .next()?
                .filter(|token| token.value.spelling.as_str() == ")")
                .ok_or_else(|| {
                    error(
                        "expected closing parenthesis after defined",
                        operator.value.span,
                    )
                })?;
            span.subsume(closing.value.span);
        }
        Ok(Token {
            value: ExpandedToken {
                kind: Kind::Number,
                spelling: Spelling::Borrowed(if value { "1" } else { "0" }),
                span,
            },
            original: false,
            hidden: HideSet::default(),
        })
    }

    fn arguments(
        &mut self,
        invocation: Span,
        parameter_count: usize,
    ) -> Result<(Vec<Vec<Token<'a>>>, Span, HideSet), ParseError> {
        let opening = self
            .next()?
            .ok_or_else(|| error("expected CUDA macro opening parenthesis", invocation))?;
        let mut span = invocation;
        span.subsume(opening.value.span);
        let mut arguments = Vec::new();
        let mut argument = Vec::new();
        let mut parentheses = 0;
        loop {
            let token = self.next()?.ok_or_else(|| {
                error(
                    if self.directive {
                        "directive inside CUDA macro invocation is unsupported"
                    } else {
                        "unterminated CUDA macro invocation"
                    },
                    span,
                )
            })?;
            span.subsume(token.value.span);
            match token.value.spelling.as_str() {
                "(" => {
                    if parentheses == MAX_DEPTH {
                        return Err(error(
                            "CUDA macro argument parenthesis limit exceeded",
                            span,
                        ));
                    }
                    parentheses += 1;
                }
                ")" if parentheses == 0 => {
                    self.budget.push(&mut arguments, argument, span)?;
                    if parameter_count == 0 && arguments.len() == 1 && arguments[0].is_empty() {
                        arguments.clear();
                    }
                    if arguments.len() != parameter_count {
                        return Err(error("incorrect CUDA macro argument count", span));
                    }
                    return Ok((arguments, span, token.hidden));
                }
                ")" => parentheses -= 1,
                "," if parentheses == 0 => {
                    self.budget
                        .push(&mut arguments, core::mem::take(&mut argument), span)?;
                    continue;
                }
                _ => {}
            }
            self.budget.push(&mut argument, token, span)?;
        }
    }
}
