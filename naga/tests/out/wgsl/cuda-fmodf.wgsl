@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

fn gen__naga_fmodf(dividend_bits: u32, divisor_bits: u32) -> u32 {
    var dividend_significand: u32;
    var dividend_exponent: i32;
    var divisor_significand: u32;
    var divisor_exponent: i32;
    var remainder: u32;
    var remaining_bits: u32;

    let _e8 = (dividend_bits & 2147483647u);
    let _e9 = (divisor_bits & 2147483647u);
    let _e10 = (dividend_bits & 2147483648u);
    if ((_e8 >= 2139095040u) || ((_e9 > 2139095040u) || (_e9 == 0u))) {
        return 2143289344u;
    }
    if (_e8 < _e9) {
        return dividend_bits;
    }
    if (_e8 == _e9) {
        return _e10;
    }
    let _e22 = (_e8 & 8388607u);
    let _e23 = (_e8 >> 23u);
    dividend_significand = (_e22 | 8388608u);
    dividend_exponent = (i32(_e23) - 127i);
    if (_e23 == 0u) {
        let _e33 = (countLeadingZeros(_e22) - 8u);
        dividend_significand = (_e22 << _e33);
        dividend_exponent = (-126i - i32(_e33));
    }
    let _e38 = dividend_significand;
    let _e39 = dividend_exponent;
    let _e44 = (_e9 & 8388607u);
    let _e45 = (_e9 >> 23u);
    divisor_significand = (_e44 | 8388608u);
    divisor_exponent = (i32(_e45) - 127i);
    if (_e45 == 0u) {
        let _e55 = (countLeadingZeros(_e44) - 8u);
        divisor_significand = (_e44 << _e55);
        divisor_exponent = (-126i - i32(_e55));
    }
    let _e60 = divisor_significand;
    let _e61 = divisor_exponent;
    remainder = _e38;
    remaining_bits = u32((_e39 - _e61));
    loop {
        let _e66 = remaining_bits;
        if (_e66 == 0u) {
            break;
        }
        let _e68 = remainder;
        remainder = (select(_e68, (_e68 - _e60), (_e68 >= _e60)) << 1u);
        remaining_bits = (_e66 - 1u);
    }
    let _e74 = remainder;
    let _e77 = select(_e74, (_e74 - _e60), (_e74 >= _e60));
    if (_e77 == 0u) {
        return _e10;
    }
    let _e81 = (countLeadingZeros(_e77) - 8u);
    let _e82 = (_e77 << _e81);
    let _e84 = (_e61 - i32(_e81));
    return (_e10 | select((_e82 >> (u32((-126i - _e84)) & 31u)), ((u32((_e84 + 127i)) << 23u) | (_e82 & 8388607u)), (_e84 >= -126i)));
}

fn sample_remainder(numerator: f32, denominator_1: f32) -> f32 {
    let _e4 = gen__naga_fmodf(bitcast<u32>(numerator), bitcast<u32>(denominator_1));
    return bitcast<f32>(_e4);
}

fn fmodf(numerator_1: bool, denominator_2: bool) -> i32 {
    var local_32: i32;

    if numerator_1 {
        local_32 = 7i;
    } else {
        local_32 = 9i;
    }
    let _e6 = local_32;
    return _e6;
}

fn fmodf_1(first: f32, second: f32, third: f32) -> f32 {
    return ((first + second) + third);
}

@compute @workgroup_size(1, 1, 1)
fn remainders() {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var value: f32;
    var denominator: f32;
    var choose: bool;
    var local_19: f32;
    var local_20: bool;
    var local_21: bool;
    var local_22: f32;
    var iteration: i32;
    var local_23: u32;
    var local_24: bool;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;

    let _e4 = gen__naga_fmodf(bitcast<u32>(5.5f), bitcast<u32>(2f));
    output[u32(0i)] = bitcast<u32>(bitcast<f32>(_e4));
    let _e16 = gen__naga_fmodf(bitcast<u32>(-(5.5f)), bitcast<u32>(2f));
    output[u32(1i)] = bitcast<u32>(bitcast<f32>(_e16));
    let _e27 = gen__naga_fmodf(bitcast<u32>(5.5f), bitcast<u32>(-(2f)));
    output[u32(2i)] = bitcast<u32>(bitcast<f32>(_e27));
    let _e39 = gen__naga_fmodf(bitcast<u32>(-(5.5f)), bitcast<u32>(-(2f)));
    output[u32(3i)] = bitcast<u32>(bitcast<f32>(_e39));
    let _e49 = gen__naga_fmodf(bitcast<u32>(4f), bitcast<u32>(2f));
    output[u32(4i)] = bitcast<u32>(bitcast<f32>(_e49));
    let _e60 = gen__naga_fmodf(bitcast<u32>(-(4f)), bitcast<u32>(2f));
    output[u32(5i)] = bitcast<u32>(bitcast<f32>(_e60));
    let _e71 = gen__naga_fmodf(bitcast<u32>(0f), bitcast<u32>(-(2f)));
    output[u32(6i)] = bitcast<u32>(bitcast<f32>(_e71));
    let _e82 = gen__naga_fmodf(bitcast<u32>(-(0f)), bitcast<u32>(2f));
    output[u32(7i)] = bitcast<u32>(bitcast<f32>(_e82));
    let _e92 = gen__naga_fmodf(bitcast<u32>(1f), bitcast<u32>(3f));
    output[u32(8i)] = bitcast<u32>(bitcast<f32>(_e92));
    let _e102 = gen__naga_fmodf(bitcast<u32>(3f), bitcast<u32>(1f));
    output[u32(9i)] = bitcast<u32>(bitcast<f32>(_e102));
    local = 2139095039u;
    let _e110 = local;
    local_1 = 1u;
    let _e114 = local_1;
    let _e118 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e110)), bitcast<u32>(bitcast<f32>(_e114)));
    output[u32(10i)] = bitcast<u32>(bitcast<f32>(_e118));
    local_2 = 4286578687u;
    let _e126 = local_2;
    local_3 = 1u;
    let _e130 = local_3;
    let _e134 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e126)), bitcast<u32>(bitcast<f32>(_e130)));
    output[u32(11i)] = bitcast<u32>(bitcast<f32>(_e134));
    local_4 = 8388608u;
    let _e142 = local_4;
    local_5 = 3u;
    let _e146 = local_5;
    let _e150 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e142)), bitcast<u32>(bitcast<f32>(_e146)));
    output[u32(12i)] = bitcast<u32>(bitcast<f32>(_e150));
    local_6 = 8388607u;
    let _e158 = local_6;
    local_7 = 3u;
    let _e162 = local_7;
    let _e166 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e158)), bitcast<u32>(bitcast<f32>(_e162)));
    output[u32(13i)] = bitcast<u32>(bitcast<f32>(_e166));
    local_8 = 1u;
    let _e174 = local_8;
    local_9 = 8388608u;
    let _e178 = local_9;
    let _e182 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e174)), bitcast<u32>(bitcast<f32>(_e178)));
    output[u32(14i)] = bitcast<u32>(bitcast<f32>(_e182));
    local_10 = 1065353217u;
    let _e190 = local_10;
    let _e195 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e190)), bitcast<u32>(1f));
    output[u32(15i)] = bitcast<u32>(bitcast<f32>(_e195));
    local_11 = 1065353217u;
    let _e203 = local_11;
    let _e208 = gen__naga_fmodf(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e203)));
    output[u32(16i)] = bitcast<u32>(bitcast<f32>(_e208));
    local_12 = 2139095041u;
    let _e216 = local_12;
    let _e221 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e216)), bitcast<u32>(2f));
    output[u32(17i)] = bitcast<u32>(bitcast<f32>(_e221));
    local_13 = 2143363909u;
    let _e229 = local_13;
    let _e234 = gen__naga_fmodf(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e229)));
    output[u32(18i)] = bitcast<u32>(bitcast<f32>(_e234));
    local_14 = 2139095040u;
    let _e242 = local_14;
    let _e247 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e242)), bitcast<u32>(2f));
    output[u32(19i)] = bitcast<u32>(bitcast<f32>(_e247));
    local_15 = 4286578688u;
    let _e255 = local_15;
    local_16 = 2139095040u;
    let _e259 = local_16;
    let _e263 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e255)), bitcast<u32>(bitcast<f32>(_e259)));
    output[u32(20i)] = bitcast<u32>(bitcast<f32>(_e263));
    let _e273 = gen__naga_fmodf(bitcast<u32>(1f), bitcast<u32>(0f));
    output[u32(21i)] = bitcast<u32>(bitcast<f32>(_e273));
    let _e283 = gen__naga_fmodf(bitcast<u32>(0f), bitcast<u32>(0f));
    output[u32(22i)] = bitcast<u32>(bitcast<f32>(_e283));
    local_17 = 2139095040u;
    let _e291 = local_17;
    let _e296 = gen__naga_fmodf(bitcast<u32>(5.5f), bitcast<u32>(bitcast<f32>(_e291)));
    output[u32(23i)] = bitcast<u32>(bitcast<f32>(_e296));
    local_18 = 4286578688u;
    let _e306 = local_18;
    let _e310 = gen__naga_fmodf(bitcast<u32>(-(5.5f)), bitcast<u32>(bitcast<f32>(_e306)));
    output[u32(24i)] = bitcast<u32>(bitcast<f32>(_e310));
    let _e320 = sample_remainder(f32(7i), f32(3i));
    output[u32(25i)] = bitcast<u32>(_e320);
    let _e329 = sample_remainder(f32(7u), f32(3u));
    output[u32(26i)] = bitcast<u32>(_e329);
    let _e338 = sample_remainder(f32(true), f32(true));
    output[u32(27i)] = bitcast<u32>(_e338);
    let _e347 = sample_remainder(f32(false), f32(true));
    output[u32(28i)] = bitcast<u32>(_e347);
    let _e354 = fmodf(true, false);
    output[u32(29i)] = u32(_e354);
    let _e361 = fmodf(false, true);
    output[u32(30i)] = u32(_e361);
    let _e369 = fmodf_1(1f, 2f, 3f);
    output[u32(31i)] = bitcast<u32>(_e369);
    value = 5.5f;
    let _e376 = value;
    value = (_e376 + f32(1i));
    let _e383 = gen__naga_fmodf(bitcast<u32>(_e376), bitcast<u32>(2f));
    output[u32(32i)] = bitcast<u32>(bitcast<f32>(_e383));
    let _e389 = value;
    output[u32(33i)] = bitcast<u32>(_e389);
    denominator = 2f;
    let _e396 = denominator;
    denominator = (_e396 + f32(1i));
    let _e403 = gen__naga_fmodf(bitcast<u32>(7f), bitcast<u32>(_e396));
    output[u32(34i)] = bitcast<u32>(bitcast<f32>(_e403));
    let _e409 = denominator;
    output[u32(35i)] = bitcast<u32>(_e409);
    value = 5.5f;
    let _e415 = value;
    value = (_e415 + f32(1i));
    let _e419 = value;
    value = (_e419 + f32(1i));
    let _e425 = gen__naga_fmodf(bitcast<u32>(_e415), bitcast<u32>(_e419));
    output[u32(36i)] = bitcast<u32>(bitcast<f32>(_e425));
    let _e431 = value;
    output[u32(37i)] = bitcast<u32>(_e431);
    choose = false;
    let _e438 = choose;
    if _e438 {
        let _e439 = value;
        value = (_e439 + f32(1i));
        let _e446 = gen__naga_fmodf(bitcast<u32>(_e439), bitcast<u32>(2f));
        local_19 = bitcast<f32>(_e446);
    } else {
        let _e449 = value;
        value = (_e449 + f32(1i));
        let _e456 = gen__naga_fmodf(bitcast<u32>(_e449), bitcast<u32>(3f));
        local_19 = bitcast<f32>(_e456);
    }
    let _e460 = local_19;
    output[u32(38i)] = bitcast<u32>(_e460);
    let _e465 = value;
    output[u32(39i)] = bitcast<u32>(_e465);
    local_20 = false;
    if false {
        let _e472 = value;
        value = (_e472 + f32(1i));
        let _e479 = gen__naga_fmodf(bitcast<u32>(_e472), bitcast<u32>(2f));
        local_20 = (bitcast<f32>(_e479) != 0f);
    }
    let _e483 = local_20;
    output[u32(40i)] = u32(_e483);
    local_21 = true;
    if true {
    } else {
        let _e490 = value;
        value = (_e490 + f32(1i));
        let _e497 = gen__naga_fmodf(bitcast<u32>(_e490), bitcast<u32>(2f));
        local_21 = (bitcast<f32>(_e497) != 0f);
    }
    let _e501 = local_21;
    output[u32(41i)] = u32(_e501);
    let _e506 = value;
    output[u32(42i)] = bitcast<u32>(_e506);
    let _e511 = value;
    value = (_e511 + f32(1i));
    let _e518 = gen__naga_fmodf(bitcast<u32>(_e511), bitcast<u32>(2f));
    let _e519 = value;
    value = (_e519 + f32(1i));
    let _e526 = gen__naga_fmodf(bitcast<u32>(_e519), bitcast<u32>(3f));
    output[u32(43i)] = bitcast<u32>(bitcast<f32>(_e526));
    let _e532 = value;
    output[u32(44i)] = bitcast<u32>(_e532);
    let _e537 = value;
    value = (_e537 + f32(1i));
    let _e544 = gen__naga_fmodf(bitcast<u32>(_e537), bitcast<u32>(3f));
    local_22 = bitcast<f32>(_e544);
    let _e547 = local_22;
    output[u32(45i)] = bitcast<u32>(_e547);
    let _e552 = value;
    output[u32(46i)] = bitcast<u32>(_e552);
    {
        iteration = 0i;
        loop {
            let _e559 = iteration;
            if (_e559 < 2i) {
            } else {
                break;
            }
            let _e562 = iteration;
            if (_e562 == 0i) {
                continue;
            }
            let _e565 = value;
            value = (_e565 + f32(1i));
            let _e572 = gen__naga_fmodf(bitcast<u32>(_e565), bitcast<u32>(2f));
            local_23 = u32(47i);
            let _e578 = local_23;
            local_31 = _e578;
            let _e580 = local_31;
            output[_e580] = bitcast<u32>(bitcast<f32>(_e572));
            continuing {
                let _e582 = iteration;
                iteration = (_e582 + 1i);
            }
        }
    }
    let _e585 = value;
    output[u32(48i)] = bitcast<u32>(_e585);
    local_24 = true;
    if true {
        let _e592 = value;
        value = (_e592 + f32(1i));
        let _e599 = gen__naga_fmodf(bitcast<u32>(_e592), bitcast<u32>(2f));
        local_24 = (bitcast<f32>(_e599) != 0f);
    }
    let _e603 = local_24;
    output[u32(49i)] = u32(_e603);
    let _e608 = value;
    output[u32(50i)] = bitcast<u32>(_e608);
    let _e617 = sample_remainder(f32(4294967295u), f32(3u));
    output[u32(51i)] = bitcast<u32>(_e617);
    let _e629 = sample_remainder(f32((-(2147483647i) - 1i)), f32(3i));
    output[u32(52i)] = bitcast<u32>(_e629);
    let _e638 = gen__naga_fmodf(bitcast<u32>(0.5f), bitcast<u32>(0.25f));
    output[u32(53i)] = bitcast<u32>(bitcast<f32>(_e638));
    let _e649 = gen__naga_fmodf(bitcast<u32>(-(0.5f)), bitcast<u32>(0.25f));
    output[u32(54i)] = bitcast<u32>(bitcast<f32>(_e649));
    local_25 = 2147483647u;
    let _e657 = local_25;
    let _e662 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e657)), bitcast<u32>(1f));
    output[u32(55i)] = bitcast<u32>(bitcast<f32>(_e662));
    let _e670 = sample_remainder(3.25f, 2f);
    output[u32(56i)] = bitcast<u32>(_e670);
    let _e679 = gen__naga_fmodf(bitcast<u32>(5.5f), bitcast<u32>(2f));
    let _e684 = gen__naga_fmodf(bitcast<u32>(1.5f), bitcast<u32>(bitcast<f32>(_e679)));
    output[u32(57i)] = bitcast<u32>(bitcast<f32>(_e684));
    let _e694 = gen__naga_fmodf(bitcast<u32>(8.5f), bitcast<u32>(3f));
    let _e699 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e694)), bitcast<u32>(2f));
    output[u32(58i)] = bitcast<u32>(bitcast<f32>(_e699));
    local_26 = 2139095040u;
    let _e709 = local_26;
    let _e713 = gen__naga_fmodf(bitcast<u32>(-(0f)), bitcast<u32>(bitcast<f32>(_e709)));
    output[u32(59i)] = bitcast<u32>(bitcast<f32>(_e713));
    local_27 = 1u;
    let _e721 = local_27;
    local_28 = 4286578688u;
    let _e725 = local_28;
    let _e729 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e721)), bitcast<u32>(bitcast<f32>(_e725)));
    output[u32(60i)] = bitcast<u32>(bitcast<f32>(_e729));
    local_29 = 8388609u;
    let _e737 = local_29;
    local_30 = 8388607u;
    let _e741 = local_30;
    let _e745 = gen__naga_fmodf(bitcast<u32>(bitcast<f32>(_e737)), bitcast<u32>(bitcast<f32>(_e741)));
    output[u32(61i)] = bitcast<u32>(bitcast<f32>(_e745));
}
