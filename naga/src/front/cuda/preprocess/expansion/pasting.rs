use alloc::{rc::Rc, string::String, vec::Vec};
use core::{cmp::Ordering, mem::size_of};

use super::super::{
    error, lex, Budget, Definition, ExpandedToken, ParseError, Spelling, MAX_DEPTH,
};
use super::{Context, Expander, Frame, Mode, Token};
use crate::Span;

#[derive(Clone, Default)]
pub(super) struct HideSet(Option<Rc<[usize]>>);

impl HideSet {
    fn values(&self) -> &[usize] {
        self.0.as_deref().unwrap_or(&[])
    }

    pub(super) fn contains(
        &self,
        identifier: usize,
        budget: &mut Budget,
        span: Span,
    ) -> Result<bool, ParseError> {
        for &hidden in self.values() {
            budget.step(span)?;
            match hidden.cmp(&identifier) {
                Ordering::Less => {}
                Ordering::Equal => return Ok(true),
                Ordering::Greater => break,
            }
        }
        Ok(false)
    }

    fn from_values(
        values: Vec<usize>,
        budget: &mut Budget,
        span: Span,
    ) -> Result<Self, ParseError> {
        if values.is_empty() {
            return Ok(Self::default());
        }
        let bytes = values
            .len()
            .checked_mul(size_of::<usize>())
            .and_then(|bytes| bytes.checked_add(2 * size_of::<usize>()))
            .ok_or_else(|| error("CUDA preprocessing resource limit exceeded", span))?;
        budget.own(bytes, span)?;
        Ok(Self(Some(Rc::from(values.into_boxed_slice()))))
    }

    fn with_macro(
        &self,
        identifier: usize,
        budget: &mut Budget,
        span: Span,
    ) -> Result<Self, ParseError> {
        if self.contains(identifier, budget, span)? {
            return Ok(self.clone());
        }
        let mut values = Vec::new();
        let mut inserted = false;
        for &hidden in self.values() {
            if !inserted && hidden > identifier {
                budget.push(&mut values, identifier, span)?;
                inserted = true;
            }
            budget.push(&mut values, hidden, span)?;
        }
        if !inserted {
            budget.push(&mut values, identifier, span)?;
        }
        Self::from_values(values, budget, span)
    }

    fn union(&self, other: &Self, budget: &mut Budget, span: Span) -> Result<Self, ParseError> {
        if self.0.is_none() {
            return Ok(other.clone());
        }
        if other.0.is_none() {
            return Ok(self.clone());
        }
        self.merge(other, false, budget, span)
    }

    fn intersection(
        &self,
        other: &Self,
        budget: &mut Budget,
        span: Span,
    ) -> Result<Self, ParseError> {
        if self.0.is_none() || other.0.is_none() {
            return Ok(Self::default());
        }
        self.merge(other, true, budget, span)
    }

    fn merge(
        &self,
        other: &Self,
        intersection: bool,
        budget: &mut Budget,
        span: Span,
    ) -> Result<Self, ParseError> {
        if let (Some(left), Some(right)) = (self.0.as_ref(), other.0.as_ref()) {
            if Rc::ptr_eq(left, right) {
                return Ok(self.clone());
            }
        }
        let mut left = self.values().iter().copied().peekable();
        let mut right = other.values().iter().copied().peekable();
        let mut values = Vec::new();
        while left.peek().is_some() || right.peek().is_some() {
            budget.step(span)?;
            let (value, common) = match (left.peek(), right.peek()) {
                (Some(&left_value), Some(&right_value)) => match left_value.cmp(&right_value) {
                    Ordering::Less => (left.next().unwrap(), false),
                    Ordering::Greater => (right.next().unwrap(), false),
                    Ordering::Equal => {
                        right.next();
                        (left.next().unwrap(), true)
                    }
                },
                (Some(_), None) => (left.next().unwrap(), false),
                (None, Some(_)) => (right.next().unwrap(), false),
                (None, None) => break,
            };
            if common || !intersection {
                budget.push(&mut values, value, span)?;
            }
        }
        Self::from_values(values, budget, span)
    }
}

#[derive(Default)]
struct Substitution<'a> {
    tokens: Vec<Option<Token<'a>>>,
    paste_pending: bool,
}

impl<'a> Substitution<'a> {
    fn paste(&mut self, span: Span) -> Result<(), ParseError> {
        if self.paste_pending || self.tokens.is_empty() {
            return Err(error("missing CUDA token-pasting operand", span));
        }
        self.paste_pending = true;
        Ok(())
    }

    fn push(
        &mut self,
        token: Option<Token<'a>>,
        budget: &mut Budget,
        span: Span,
    ) -> Result<(), ParseError> {
        let token = if self.paste_pending {
            self.paste_pending = false;
            let left = self
                .tokens
                .pop()
                .ok_or_else(|| error("missing CUDA token-pasting operand", span))?;
            match (left, token) {
                (None, token) | (token, None) => token,
                (Some(left), Some(right)) => Some(paste_tokens(left, right, budget, span)?),
            }
        } else {
            token
        };
        budget.push(&mut self.tokens, token, span)
    }

    fn finish(
        self,
        hidden: &HideSet,
        budget: &mut Budget,
        span: Span,
    ) -> Result<Vec<Token<'a>>, ParseError> {
        if self.paste_pending {
            return Err(error("missing CUDA token-pasting operand", span));
        }
        let mut result = Vec::new();
        for mut token in self.tokens.into_iter().flatten() {
            token.hidden = token.hidden.union(hidden, budget, span)?;
            token.original = false;
            token.value.span = span;
            budget.push(&mut result, token, span)?;
        }
        Ok(result)
    }
}

fn paste_tokens<'a>(
    left: Token<'a>,
    right: Token<'a>,
    budget: &mut Budget,
    span: Span,
) -> Result<Token<'a>, ParseError> {
    let left_spelling = left.value.spelling.as_str();
    let right_spelling = right.value.spelling.as_str();
    let length = left_spelling
        .len()
        .checked_add(right_spelling.len())
        .ok_or_else(|| error("CUDA preprocessing resource limit exceeded", span))?;
    budget.own(length, span)?;
    budget.visit(length, span)?;
    let mut spelling = String::with_capacity(length);
    spelling.push_str(left_spelling);
    spelling.push_str(right_spelling);
    let token = lex::relex_pasted(&spelling, budget, span)?;
    let allocation = length
        .checked_add(2 * size_of::<usize>())
        .ok_or_else(|| error("CUDA preprocessing resource limit exceeded", span))?;
    budget.own(allocation, span)?;
    Ok(Token {
        value: ExpandedToken {
            kind: token.kind,
            spelling: Spelling::Shared(Rc::from(token.spelling.as_str())),
            span,
        },
        original: false,
        hidden: left.hidden.intersection(&right.hidden, budget, span)?,
    })
}

fn paste_adjacent(definition: &Definition, index: usize) -> bool {
    index
        .checked_sub(1)
        .and_then(|index| definition.replacement.get(index))
        .is_some_and(|token| token.spelling == "##")
        || definition
            .replacement
            .get(index + 1)
            .is_some_and(|token| token.spelling == "##")
}

impl<'a> Expander<'a, '_> {
    pub(super) fn invoke(
        &mut self,
        token: Token<'a>,
        definition: &'a Definition,
    ) -> Result<(), ParseError> {
        if self.depth() == MAX_DEPTH {
            return Err(error(
                "CUDA macro expansion depth limit exceeded",
                token.value.span,
            ));
        }
        let mut span = token.value.span;
        let mut arguments = Vec::new();
        let mut expanded_arguments: Vec<Option<Vec<Token<'a>>>> = Vec::new();
        let mut hidden = token.hidden;
        if let Some(ref parameters) = definition.parameters {
            let (raw, invocation_span, closing_hidden) = self.arguments(span, parameters.len())?;
            span = invocation_span;
            arguments = raw;
            hidden = hidden.intersection(&closing_hidden, self.budget, span)?;
            for _ in parameters {
                self.budget.push(&mut expanded_arguments, None, span)?;
            }
            for (position, &slot) in definition.parameter_slots.iter().enumerate() {
                self.budget.step(span)?;
                if let Some(index) = slot {
                    if !paste_adjacent(definition, position) && expanded_arguments[index].is_none()
                    {
                        let mut input = Vec::new();
                        for argument_token in &arguments[index] {
                            self.budget.push(&mut input, argument_token.clone(), span)?;
                        }
                        let depth = self.depth() + 1;
                        let mut expanded = Vec::new();
                        let mut prescan = Expander::new(
                            input,
                            self.definitions,
                            self.budget,
                            Context {
                                mode: Mode::Argument,
                                pending_depth: depth,
                                outer_span: Some(span),
                                directive: false,
                            },
                        )?;
                        prescan.run(&mut |token| {
                            expanded.push(token);
                            Ok(())
                        })?;
                        expanded_arguments[index] = Some(expanded);
                    }
                }
            }
        }
        hidden = hidden.with_macro(definition.identifier, self.budget, span)?;
        let mut substitution = Substitution::default();
        for (position, (raw, &slot)) in definition
            .replacement
            .iter()
            .zip(&definition.parameter_slots)
            .enumerate()
        {
            self.budget.step(span)?;
            if raw.spelling == "##" {
                substitution.paste(span)?;
            } else if let Some(index) = slot {
                let pasted = paste_adjacent(definition, position);
                let argument = if pasted {
                    &arguments[index]
                } else {
                    expanded_arguments[index].as_ref().unwrap()
                };
                if pasted && argument.is_empty() {
                    substitution.push(None, self.budget, span)?;
                } else {
                    for argument_token in argument {
                        substitution.push(Some(argument_token.clone()), self.budget, span)?;
                    }
                }
            } else {
                substitution.push(Some(Token::original(raw)), self.budget, span)?;
            }
        }
        let replacement = substitution.finish(&hidden, self.budget, span)?;
        self.budget.push(
            &mut self.frames,
            Frame {
                tokens: replacement,
                next: 0,
                macro_identifier: Some(definition.identifier),
                span,
            },
            span,
        )?;
        Ok(())
    }
}
