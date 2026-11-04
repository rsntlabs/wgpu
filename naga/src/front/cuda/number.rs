use alloc::borrow::Cow;

use crate::{Literal, Scalar, ScalarKind};

#[derive(Clone, Copy, Debug, Eq, Hash, PartialEq)]
pub(super) enum SourceScalar {
    Scalar(Scalar),
    Long(ScalarKind),
}

impl SourceScalar {
    pub(super) const fn scalar(self) -> Scalar {
        match self {
            Self::Scalar(scalar) => scalar,
            Self::Long(kind) => Scalar { kind, width: 8 },
        }
    }
}

pub(super) struct Number {
    pub(super) literal: Literal,
    pub(super) scalar: SourceScalar,
}

impl From<Literal> for Number {
    fn from(literal: Literal) -> Self {
        Self {
            literal,
            scalar: SourceScalar::Scalar(literal.scalar()),
        }
    }
}

mod hexadecimal;

pub(super) fn parse(input: &str) -> Option<Number> {
    if matches!(input.get(..2), Some("0x" | "0X")) && input.contains(['p', 'P']) {
        return hexadecimal::parse(input).map(|value| Literal::F32(value).into());
    }
    if matches!(input.get(..2), Some("0x" | "0X" | "0b" | "0B")) {
        return parse_integer(input);
    }
    if let Some(body) = input.strip_suffix(['f', 'F']) {
        if !body.contains(['.', 'e', 'E']) {
            return None;
        }
        let body = if body.contains('\'') {
            let bytes = body.as_bytes();
            if bytes.iter().enumerate().any(|(index, &byte)| {
                byte == b'\''
                    && (index == 0
                        || index + 1 == bytes.len()
                        || !bytes[index - 1].is_ascii_digit()
                        || !bytes[index + 1].is_ascii_digit())
            }) {
                return None;
            }
            Cow::Owned(body.replace('\'', ""))
        } else {
            Cow::Borrowed(body)
        };
        let value = body.parse::<f32>().ok()?;
        return value.is_finite().then_some(Literal::F32(value).into());
    }
    parse_integer(input)
}

pub(super) fn parse_integer(input: &str) -> Option<Number> {
    let (mut body, mut unsigned) = match input.strip_suffix(['u', 'U']) {
        Some(body) => (body, true),
        None => (input, false),
    };
    let long_count = if matches!(
        body.get(body.len().saturating_sub(2)..),
        Some("ll" | "LL" | "lL" | "Ll")
    ) {
        body = &body[..body.len() - 2];
        2
    } else if let Some(digits) = body.strip_suffix(['l', 'L']) {
        body = digits;
        1
    } else {
        0
    };
    if long_count != 0 && !unsigned {
        if let Some(digits) = body.strip_suffix(['u', 'U']) {
            body = digits;
            unsigned = true;
        }
    }
    let (digits, radix) = match body.get(..2) {
        Some("0x" | "0X") => (&body[2..], 16),
        Some("0b" | "0B") => (&body[2..], 2),
        _ if body.starts_with('0') => (body, 8),
        _ => (body, 10),
    };
    if !digits
        .split('\'')
        .all(|part| !part.is_empty() && part.chars().all(|c| c.is_ascii() && c.is_digit(radix)))
    {
        return None;
    }
    let digits = if digits.contains('\'') {
        Cow::Owned(digits.replace('\'', ""))
    } else {
        Cow::Borrowed(digits)
    };
    let value = u64::from_str_radix(&digits, radix).ok()?;
    let scalar = match long_count {
        2 if unsigned || value > i64::MAX as u64 => SourceScalar::Scalar(Scalar::U64),
        2 => SourceScalar::Scalar(Scalar::I64),
        1 if unsigned || (radix != 10 && value > i64::MAX as u64) => {
            SourceScalar::Long(ScalarKind::Uint)
        }
        1 if value <= i64::MAX as u64 => SourceScalar::Long(ScalarKind::Sint),
        1 => SourceScalar::Scalar(Scalar::U64),
        _ if unsigned && value <= u32::MAX as u64 => SourceScalar::Scalar(Scalar::U32),
        _ if unsigned => SourceScalar::Long(ScalarKind::Uint),
        _ if value <= i32::MAX as u64 => SourceScalar::Scalar(Scalar::I32),
        _ if radix != 10 && value <= u32::MAX as u64 => SourceScalar::Scalar(Scalar::U32),
        _ if value <= i64::MAX as u64 => SourceScalar::Long(ScalarKind::Sint),
        _ if radix != 10 => SourceScalar::Long(ScalarKind::Uint),
        _ => SourceScalar::Scalar(Scalar::U64),
    };
    let literal = match scalar.scalar() {
        Scalar::I32 => Literal::I32(value as i32),
        Scalar::U32 => Literal::U32(value as u32),
        Scalar::I64 => Literal::I64(value as i64),
        Scalar::U64 => Literal::U64(value),
        _ => unreachable!(),
    };
    Some(Number { literal, scalar })
}
