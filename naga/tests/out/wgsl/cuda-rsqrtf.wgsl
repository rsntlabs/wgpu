@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn gen__naga_sqrtf(input_bits: u32) -> u32 {
    var significand: u32;
    var adjusted_exponent: u32;
    var upper_word: u32;
    var lower_word: u32;
    var root: u32;
    var remainder: u32;
    var iteration_1: u32;

    let _e5 = (input_bits & 2147483647u);
    if ((_e5 == 0u) || (input_bits == 2139095040u)) {
        return input_bits;
    }
    if (((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u)) {
        return 2143289344u;
    }
    let _e19 = (input_bits & 8388607u);
    let _e20 = (_e5 >> 23u);
    significand = (_e19 | 8388608u);
    adjusted_exponent = (_e20 + 127u);
    if (_e20 == 0u) {
        let _e28 = (countLeadingZeros(_e19) - 8u);
        significand = (_e19 << _e28);
        adjusted_exponent = (128u - _e28);
    }
    let _e32 = significand;
    let _e33 = adjusted_exponent;
    let _e34 = (_e33 & 1u);
    upper_word = (_e32 >> (9u - _e34));
    lower_word = (_e32 << (23u + _e34));
    root = 0u;
    remainder = 0u;
    iteration_1 = 0u;
    loop {
        let _e50 = iteration_1;
        if (_e50 >= 24u) {
            break;
        }
        let _e52 = upper_word;
        let _e53 = lower_word;
        let _e54 = root;
        let _e55 = remainder;
        let _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        let _e65 = ((_e54 << 2u) | 1u);
        let _e66 = (_e63 >= _e65);
        let _e69 = (_e54 << 1u);
        upper_word = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word = (_e53 << 2u);
        remainder = select(_e63, (_e63 - _e65), _e66);
        root = select(_e69, (_e69 | 1u), _e66);
        continuing {
            let _e72 = iteration_1;
            iteration_1 = (_e72 + 1u);
        }
    }
    let _e74 = root;
    let _e75 = remainder;
    return (((_e33 >> 1u) << 23u) | (select(_e74, (_e74 + 1u), (_e75 > _e74)) & 8388607u));
}

fn gen__naga_divide_f32_(numerator_bits: u32, denominator_bits: u32) -> u32 {
    var numerator_significand: u32;
    var numerator_exponent: i32;
    var denominator_significand: u32;
    var denominator_exponent: i32;
    var quotient: u32;
    var remainder_1: u32;
    var iteration_2: u32;

    let _e8 = (numerator_bits & 2147483647u);
    let _e9 = (denominator_bits & 2147483647u);
    let _e11 = ((numerator_bits ^ denominator_bits) & 2147483648u);
    let _e12 = (_e11 | 2139095040u);
    let _e16 = (_e8 == 0u);
    let _e17 = (_e9 == 0u);
    let _e19 = (_e8 == 2139095040u);
    let _e20 = (_e9 == 2139095040u);
    if ((((_e8 > 2139095040u) || (_e9 > 2139095040u)) || (_e16 && _e17)) || (_e19 && _e20)) {
        return 2143289344u;
    }
    if (_e19 || _e17) {
        return _e12;
    }
    if (_e16 || _e20) {
        return _e11;
    }
    let _e30 = (_e8 & 8388607u);
    let _e31 = (_e8 >> 23u);
    numerator_significand = (_e30 | 8388608u);
    numerator_exponent = (i32(_e31) - 127i);
    if (_e31 == 0u) {
        let _e41 = (countLeadingZeros(_e30) - 8u);
        numerator_significand = (_e30 << _e41);
        numerator_exponent = (-126i - i32(_e41));
    }
    let _e46 = numerator_significand;
    let _e47 = numerator_exponent;
    let _e52 = (_e9 & 8388607u);
    let _e53 = (_e9 >> 23u);
    denominator_significand = (_e52 | 8388608u);
    denominator_exponent = (i32(_e53) - 127i);
    if (_e53 == 0u) {
        let _e63 = (countLeadingZeros(_e52) - 8u);
        denominator_significand = (_e52 << _e63);
        denominator_exponent = (-126i - i32(_e63));
    }
    let _e68 = denominator_significand;
    let _e69 = denominator_exponent;
    let _e70 = (_e46 < _e68);
    let _e75 = ((_e47 - _e69) - i32(_e70));
    if (_e75 < -150i) {
        return _e11;
    }
    quotient = 1u;
    remainder_1 = (select(_e46, (_e46 << 1u), _e70) - _e68);
    iteration_2 = 0u;
    loop {
        let _e83 = iteration_2;
        if (_e83 >= 23u) {
            break;
        }
        let _e85 = remainder_1;
        let _e86 = quotient;
        let _e87 = (_e85 << 1u);
        let _e88 = (_e87 >= _e68);
        remainder_1 = select(_e87, (_e87 - _e68), _e88);
        quotient = ((_e86 << 1u) | select(0u, 1u, _e88));
        continuing {
            let _e94 = iteration_2;
            iteration_2 = (_e94 + 1u);
        }
    }
    let _e96 = quotient;
    let _e97 = remainder_1;
    if (_e75 < -126i) {
        let _e103 = (u32((-126i - _e75)) & 31u);
        let _e104 = (1u << _e103);
        let _e106 = (_e96 & (_e104 - 1u));
        let _e107 = (_e104 >> 1u);
        let _e108 = (_e96 >> _e103);
        return (_e11 | (_e108 + select(0u, 1u, ((_e106 > _e107) || ((_e106 == _e107) && ((_e97 != 0u) || ((_e108 & 1u) != 0u)))))));
    }
    let _e120 = (_e97 << 1u);
    let _e128 = (_e96 + select(0u, 1u, ((_e120 > _e68) || ((_e120 == _e68) && ((_e96 & 1u) != 0u)))));
    let _e130 = (_e128 >> 24u);
    let _e133 = (_e75 + i32(_e130));
    if (_e133 > 127i) {
        return _e12;
    }
    return (_e11 | ((u32((_e133 + 127i)) << 23u) | ((_e128 >> _e130) & 8388607u)));
}

fn inverse_root(value_1: f32) -> f32 {
    let _e2 = gen__naga_sqrtf(bitcast<u32>(value_1));
    let _e7 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e2)));
    return bitcast<f32>(_e7);
}

fn inverse_root_1(value_2: i32) -> f32 {
    let _e3 = gen__naga_sqrtf(bitcast<u32>(f32(value_2)));
    let _e8 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e3)));
    return bitcast<f32>(_e8);
}

fn inverse_root_2(value_3: u32) -> f32 {
    let _e3 = gen__naga_sqrtf(bitcast<u32>(f32(value_3)));
    let _e8 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e3)));
    return bitcast<f32>(_e8);
}

fn inverse_root_3(value_4: bool) -> f32 {
    let _e3 = gen__naga_sqrtf(bitcast<u32>(f32(value_4)));
    let _e8 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e3)));
    return bitcast<f32>(_e8);
}

fn rsqrtf(value_5: bool) -> i32 {
    var local_17: i32;

    if value_5 {
        local_17 = 7i;
    } else {
        local_17 = 9i;
    }
    let _e6 = local_17;
    return _e6;
}

fn rsqrtf_1(first: f32, second: f32) -> f32 {
    return (first + second);
}

fn pair(first_1: f32, second_1: f32) -> f32 {
    return ((first_1 * 10f) + second_1);
}

@compute @workgroup_size(1, 1, 1)
fn inverse_roots() {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var value: f32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var choose: bool;
    var local_10: f32;
    var local_11: bool;
    var local_12: bool;
    var left: f32;
    var right: f32;
    var iteration: i32;
    var local_13: u32;
    var local_14: f32;
    var local_15: bool;
    var local_16: u32;

    let _e2 = gen__naga_sqrtf(bitcast<u32>(0f));
    let _e7 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e2)));
    out[u32(0i)] = bitcast<u32>(bitcast<f32>(_e7));
    let _e17 = gen__naga_sqrtf(bitcast<u32>(-(0f)));
    let _e22 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e17)));
    out[u32(1i)] = bitcast<u32>(bitcast<f32>(_e22));
    let _e30 = gen__naga_sqrtf(bitcast<u32>(1f));
    let _e35 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e30)));
    out[u32(2i)] = bitcast<u32>(bitcast<f32>(_e35));
    let _e42 = inverse_root_1(4i);
    out[u32(3i)] = bitcast<u32>(_e42);
    let _e48 = inverse_root_2(9u);
    out[u32(4i)] = bitcast<u32>(_e48);
    let _e55 = gen__naga_sqrtf(bitcast<u32>(6.25f));
    let _e60 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e55)));
    out[u32(5i)] = bitcast<u32>(bitcast<f32>(_e60));
    let _e68 = gen__naga_sqrtf(bitcast<u32>(2f));
    let _e73 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e68)));
    out[u32(6i)] = bitcast<u32>(bitcast<f32>(_e73));
    local = 1u;
    let _e81 = local;
    let _e84 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e81)));
    let _e89 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e84)));
    out[u32(7i)] = bitcast<u32>(bitcast<f32>(_e89));
    local_1 = 8388607u;
    let _e97 = local_1;
    let _e100 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e97)));
    let _e105 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e100)));
    out[u32(8i)] = bitcast<u32>(bitcast<f32>(_e105));
    local_2 = 8388608u;
    let _e113 = local_2;
    let _e116 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e113)));
    let _e121 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e116)));
    out[u32(9i)] = bitcast<u32>(bitcast<f32>(_e121));
    local_3 = 2139095039u;
    let _e129 = local_3;
    let _e132 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e129)));
    let _e137 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e132)));
    out[u32(10i)] = bitcast<u32>(bitcast<f32>(_e137));
    local_4 = 2139095040u;
    let _e145 = local_4;
    let _e148 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e145)));
    let _e153 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e148)));
    out[u32(11i)] = bitcast<u32>(bitcast<f32>(_e153));
    let _e162 = gen__naga_sqrtf(bitcast<u32>(-(1f)));
    let _e167 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e162)));
    out[u32(12i)] = bitcast<u32>(bitcast<f32>(_e167));
    local_5 = 2139095041u;
    let _e175 = local_5;
    let _e178 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e175)));
    let _e183 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e178)));
    out[u32(13i)] = bitcast<u32>(bitcast<f32>(_e183));
    value = 4f;
    let _e191 = value;
    value = (_e191 + f32(1i));
    let _e195 = inverse_root(_e191);
    out[u32(14i)] = bitcast<u32>(_e195);
    let _e200 = value;
    out[u32(15i)] = bitcast<u32>(_e200);
    let _e206 = rsqrtf(true);
    out[u32(16i)] = u32(_e206);
    let _e212 = rsqrtf(false);
    out[u32(17i)] = u32(_e212);
    let _e219 = rsqrtf_1(2f, 3f);
    out[u32(18i)] = bitcast<u32>(_e219);
    local_6 = 1065353217u;
    let _e226 = local_6;
    let _e229 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e226)));
    let _e234 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e229)));
    out[u32(19i)] = bitcast<u32>(bitcast<f32>(_e234));
    local_7 = 1065353218u;
    let _e242 = local_7;
    let _e245 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e242)));
    let _e250 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e245)));
    out[u32(20i)] = bitcast<u32>(bitcast<f32>(_e250));
    local_8 = 1065353215u;
    let _e258 = local_8;
    let _e261 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e258)));
    let _e266 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e261)));
    out[u32(21i)] = bitcast<u32>(bitcast<f32>(_e266));
    let _e273 = inverse_root_2(4294967295u);
    out[u32(22i)] = bitcast<u32>(_e273);
    let _e280 = inverse_root_1(-(4i));
    out[u32(23i)] = bitcast<u32>(_e280);
    let _e286 = inverse_root(16f);
    out[u32(24i)] = bitcast<u32>(_e286);
    let _e293 = gen__naga_sqrtf(bitcast<u32>(0.25f));
    let _e298 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e293)));
    out[u32(25i)] = bitcast<u32>(bitcast<f32>(_e298));
    local_9 = 2147483649u;
    let _e306 = local_9;
    let _e309 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e306)));
    let _e314 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e309)));
    out[u32(26i)] = bitcast<u32>(bitcast<f32>(_e314));
    let _e321 = inverse_root_3(false);
    out[u32(27i)] = bitcast<u32>(_e321);
    let _e327 = inverse_root_3(true);
    out[u32(28i)] = bitcast<u32>(_e327);
    let _e333 = inverse_root(0.5f);
    out[u32(29i)] = bitcast<u32>(_e333);
    let _e340 = gen__naga_sqrtf(bitcast<u32>(2f));
    out[u32(30i)] = bitcast<u32>(bitcast<f32>(_e340));
    let _e348 = gen__naga_sqrtf(bitcast<u32>(2f));
    let _e353 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e348)));
    out[u32(31i)] = bitcast<u32>(bitcast<f32>(_e353));
    let _e361 = gen__naga_sqrtf(bitcast<u32>(2f));
    let _e366 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e361)));
    out[u32(32i)] = bitcast<u32>(bitcast<f32>(_e366));
    value = 4f;
    choose = false;
    let _e375 = choose;
    if _e375 {
        let _e376 = value;
        value = (_e376 + f32(1i));
        let _e381 = gen__naga_sqrtf(bitcast<u32>(_e376));
        let _e386 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e381)));
        local_10 = bitcast<f32>(_e386);
    } else {
        let _e389 = value;
        value = (_e389 + f32(1i));
        let _e394 = gen__naga_sqrtf(bitcast<u32>(_e389));
        let _e399 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e394)));
        local_10 = bitcast<f32>(_e399);
    }
    let _e403 = local_10;
    out[u32(33i)] = bitcast<u32>(_e403);
    let _e408 = value;
    out[u32(34i)] = bitcast<u32>(_e408);
    local_11 = false;
    if false {
        let _e415 = value;
        value = (_e415 + f32(1i));
        let _e420 = gen__naga_sqrtf(bitcast<u32>(_e415));
        let _e425 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e420)));
        local_11 = (bitcast<f32>(_e425) != 0f);
    }
    let _e429 = local_11;
    out[u32(35i)] = u32(_e429);
    local_12 = true;
    if true {
    } else {
        let _e436 = value;
        value = (_e436 + f32(1i));
        let _e441 = gen__naga_sqrtf(bitcast<u32>(_e436));
        let _e446 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e441)));
        local_12 = (bitcast<f32>(_e446) != 0f);
    }
    let _e450 = local_12;
    out[u32(36i)] = u32(_e450);
    let _e455 = value;
    out[u32(37i)] = bitcast<u32>(_e455);
    left = 4f;
    right = 9f;
    let _e464 = left;
    left = (_e464 + f32(1i));
    let _e469 = gen__naga_sqrtf(bitcast<u32>(_e464));
    let _e474 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e469)));
    let _e476 = right;
    right = (_e476 + f32(1i));
    let _e481 = gen__naga_sqrtf(bitcast<u32>(_e476));
    let _e486 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e481)));
    let _e488 = pair(bitcast<f32>(_e474), bitcast<f32>(_e486));
    out[u32(38i)] = bitcast<u32>(_e488);
    let _e493 = left;
    out[u32(39i)] = bitcast<u32>(_e493);
    let _e498 = right;
    out[u32(40i)] = bitcast<u32>(_e498);
    let _e503 = value;
    value = (_e503 + f32(1i));
    let _e508 = gen__naga_sqrtf(bitcast<u32>(_e503));
    let _e513 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e508)));
    let _e514 = value;
    value = (_e514 + f32(1i));
    let _e519 = gen__naga_sqrtf(bitcast<u32>(_e514));
    let _e524 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e519)));
    out[u32(41i)] = bitcast<u32>(bitcast<f32>(_e524));
    let _e530 = value;
    out[u32(42i)] = bitcast<u32>(_e530);
    {
        iteration = 0i;
        loop {
            let _e537 = iteration;
            if (_e537 < 2i) {
            } else {
                break;
            }
            let _e540 = iteration;
            if (_e540 == 0i) {
                continue;
            }
            let _e543 = value;
            value = (_e543 + f32(1i));
            let _e548 = gen__naga_sqrtf(bitcast<u32>(_e543));
            let _e553 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e548)));
            local_13 = u32(43i);
            let _e559 = local_13;
            local_16 = _e559;
            let _e561 = local_16;
            out[_e561] = bitcast<u32>(bitcast<f32>(_e553));
            continuing {
                let _e563 = iteration;
                iteration = (_e563 + 1i);
            }
        }
    }
    let _e566 = value;
    out[u32(44i)] = bitcast<u32>(_e566);
    let _e571 = value;
    value = (_e571 + f32(1i));
    let _e576 = gen__naga_sqrtf(bitcast<u32>(_e571));
    let _e581 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e576)));
    local_14 = bitcast<f32>(_e581);
    let _e584 = local_14;
    out[u32(45i)] = bitcast<u32>(_e584);
    let _e589 = value;
    out[u32(46i)] = bitcast<u32>(_e589);
    local_15 = true;
    if true {
        let _e596 = value;
        value = (_e596 + f32(1i));
        let _e601 = gen__naga_sqrtf(bitcast<u32>(_e596));
        let _e606 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e601)));
        local_15 = (bitcast<f32>(_e606) != 0f);
    }
    let _e610 = local_15;
    out[u32(47i)] = u32(_e610);
    let _e615 = value;
    out[u32(48i)] = bitcast<u32>(_e615);
}
