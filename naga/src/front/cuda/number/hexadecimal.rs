struct Significand {
    leading_bits: u32,
    discarded_digits: i64,
    fractional_digits: i64,
    sticky: bool,
}

pub(super) fn parse(input: &str) -> Option<f32> {
    let body = input
        .strip_prefix("0x")
        .or_else(|| input.strip_prefix("0X"))?;
    let body = body.strip_suffix(['f', 'F'])?;
    let (significand, exponent) = body.split_once(['p', 'P'])?;
    let significand = parse_significand(significand.as_bytes())?;
    let exponent = parse_exponent(exponent.as_bytes())?;
    if significand.leading_bits == 0 {
        return Some(0.0);
    }

    let bit_length = i64::from(u32::BITS - significand.leading_bits.leading_zeros())
        .checked_add(significand.discarded_digits.checked_mul(4)?)?;
    let mut exponent = exponent
        .saturating_sub(significand.fractional_digits.checked_mul(4)?)
        .saturating_add(bit_length - 1);
    if exponent > 127 {
        return None;
    }
    if exponent < -150 {
        return Some(0.0);
    }

    let precision = if exponent >= -126 {
        24
    } else {
        u32::try_from(exponent + 150).ok()?
    };
    let mut rounded = round_significand(&significand, precision);
    if exponent < -126 {
        return Some(f32::from_bits(rounded));
    }
    if rounded == 1 << 24 {
        rounded >>= 1;
        exponent += 1;
        if exponent > 127 {
            return None;
        }
    }
    let exponent_bits = u32::try_from(exponent + 127).ok()? << 23;
    Some(f32::from_bits(exponent_bits | (rounded & 0x7f_ffff)))
}

fn hexadecimal_digit(byte: u8) -> Option<u32> {
    match byte {
        b'0'..=b'9' => Some(u32::from(byte - b'0')),
        b'a'..=b'f' => Some(u32::from(byte - b'a' + 10)),
        b'A'..=b'F' => Some(u32::from(byte - b'A' + 10)),
        _ => None,
    }
}

fn parse_significand(input: &[u8]) -> Option<Significand> {
    let mut significand = Significand {
        leading_bits: 0,
        discarded_digits: 0,
        fractional_digits: 0,
        sticky: false,
    };
    let mut digit_seen = false;
    let mut period_seen = false;
    let mut retained_digits = 0;
    for (index, &byte) in input.iter().enumerate() {
        match byte {
            b'.' if !period_seen => {
                period_seen = true;
            }
            b'\'' => {
                if index == 0
                    || index + 1 == input.len()
                    || hexadecimal_digit(input[index - 1]).is_none()
                    || hexadecimal_digit(input[index + 1]).is_none()
                {
                    return None;
                }
            }
            _ => {
                let digit = hexadecimal_digit(byte)?;
                digit_seen = true;
                if period_seen {
                    significand.fractional_digits = significand.fractional_digits.checked_add(1)?;
                }
                if retained_digits == 0 && digit == 0 {
                    continue;
                }
                // Eight hex digits retain at least 29 bits, enough for f32 rounding.
                if retained_digits < 8 {
                    significand.leading_bits = (significand.leading_bits << 4) | digit;
                    retained_digits += 1;
                } else {
                    significand.discarded_digits = significand.discarded_digits.checked_add(1)?;
                    significand.sticky |= digit != 0;
                }
            }
        }
    }
    digit_seen.then_some(significand)
}

fn parse_exponent(input: &[u8]) -> Option<i64> {
    let (negative, digits) = match input.split_first()? {
        (&b'-', rest) => (true, rest),
        (&b'+', rest) => (false, rest),
        _ => (false, input),
    };
    let mut exponent = 0i64;
    let mut digit_seen = false;
    for (index, &byte) in digits.iter().enumerate() {
        if byte.is_ascii_digit() {
            digit_seen = true;
            // The bounded significand cannot cancel an exponent this large.
            exponent = exponent
                .saturating_mul(10)
                .saturating_add(i64::from(byte - b'0'));
        } else if byte != b'\''
            || index == 0
            || index + 1 == digits.len()
            || !digits[index - 1].is_ascii_digit()
            || !digits[index + 1].is_ascii_digit()
        {
            return None;
        }
    }
    digit_seen.then_some(if negative { -exponent } else { exponent })
}

fn round_significand(significand: &Significand, precision: u32) -> u32 {
    let leading = u64::from(significand.leading_bits) << significand.leading_bits.leading_zeros();
    let discarded_bits = u32::BITS - precision;
    let retained = leading >> discarded_bits;
    let rounding_bit = 1u64 << (discarded_bits - 1);
    let sticky = significand.sticky || leading & (rounding_bit - 1) != 0;
    let round_up = leading & rounding_bit != 0 && (sticky || retained & 1 != 0);
    (retained + u64::from(round_up)) as u32
}
