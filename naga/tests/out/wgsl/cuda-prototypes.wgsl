struct Packet_cuda_record_0_ {
    key: i32,
    values: array<i32, 2>,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;
var<private> blockIdx_1: vec3<u32>;
var<private> threadIdx_1: vec3<u32>;

fn route(value: f32) -> i32 {
    return (10i + i32(value));
}

fn earlier(value_1: i32) -> i32 {
    let _e2 = route(f32(value_1));
    return _e2;
}

fn route_1(value_2: i32) -> i32 {
    return (20i + value_2);
}

fn forward(value_3: i32) -> i32 {
    let _e1 = route_1(value_3);
    let _e2 = earlier(value_3);
    return (_e1 + _e2);
}

fn packet(value_4: i32) -> Packet_cuda_record_0_ {
    var local_32: Packet_cuda_record_0_;

    local_32.key = value_4;
    local_32.values[0] = (value_4 + 1i);
    local_32.values[1] = (value_4 + 2i);
    let _e10 = local_32;
    return _e10;
}

fn adjust(value_5: Packet_cuda_record_0_) -> Packet_cuda_record_0_ {
    var value_6: Packet_cuda_record_0_;

    value_6 = value_5;
    let _e4 = value_6.key;
    value_6.key = (_e4 + 4i);
    let _e10 = value_6.values[1i];
    value_6.values[1i] = (_e10 + 6i);
    let _e12 = value_6;
    return _e12;
}

fn operator_u002b(left: Packet_cuda_record_0_, right: Packet_cuda_record_0_) -> Packet_cuda_record_0_ {
    var left_1: Packet_cuda_record_0_;
    var right_1: Packet_cuda_record_0_;
    var local_33: Packet_cuda_record_0_;

    left_1 = left;
    right_1 = right;
    let _e7 = left_1.key;
    let _e8 = right_1.key;
    local_33.key = (_e7 + _e8);
    let _e18 = left_1.values[0i];
    let _e19 = right_1.values[0i];
    local_33.values[0] = (_e18 + _e19);
    let _e29 = left_1.values[1i];
    let _e30 = right_1.values[1i];
    local_33.values[1] = (_e29 + _e30);
    let _e32 = local_33;
    return _e32;
}

fn pair(first_1: i32, second_1: i32) -> i32 {
    return ((first_1 * 10i) + second_1);
}

fn consume(value_7: i32) {
    if (value_7 != 0i) {
        return;
    } else {
        return;
    }
}

fn gen__naga_sqrtf(input_bits: u32) -> u32 {
    var significand: u32;
    var adjusted_exponent: u32;
    var upper_word: u32;
    var lower_word: u32;
    var root: u32;
    var remainder: u32;
    var iteration: u32;

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
    iteration = 0u;
    loop {
        let _e50 = iteration;
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
            let _e72 = iteration;
            iteration = (_e72 + 1u);
        }
    }
    let _e74 = root;
    let _e75 = remainder;
    return (((_e33 >> 1u) << 23u) | (select(_e74, (_e74 + 1u), (_e75 > _e74)) & 8388607u));
}

fn gen__naga_trig_reduce_multiply(left_2: array<u32, 2>, right_2: array<u32, 20>) -> array<u32, 22> {
    var left_digits: array<u32, 2> = array<u32, 2>();
    var right_digits: array<u32, 20> = array<u32, 20>();
    var product: array<u32, 22> = array<u32, 22>();
    var carry: u32 = u32();
    var left_index: u32 = u32();
    var right_index: u32 = u32();
    var result: array<u32, 22> = array<u32, 22>();
    var result_index: u32 = u32();

    left_digits = left_2;
    right_digits = right_2;
    left_index = 0u;
    loop {
        let _e13 = left_index;
        if (_e13 >= 2u) {
            break;
        }
        carry = 0u;
        let _e18 = left_digits[_e13];
        right_index = 0u;
        loop {
            let _e22 = right_index;
            if (_e22 >= 20u) {
                break;
            }
            let _e26 = right_digits[_e22];
            let _e27 = (_e13 + _e22);
            let _e29 = product[_e27];
            let _e30 = carry;
            let _e33 = (((_e18 * _e26) + _e29) + _e30);
            product[_e27] = (_e33 & 65535u);
            carry = (_e33 >> 16u);
            continuing {
                let _e39 = right_index;
                right_index = (_e39 + 1u);
            }
        }
        let _e44 = carry;
        product[(_e13 + 20u)] = _e44;
        continuing {
            let _e46 = left_index;
            left_index = (_e46 + 1u);
        }
    }
    result_index = 0u;
    loop {
        let _e54 = result_index;
        if (_e54 >= 22u) {
            break;
        }
        let _e60 = product[(_e54 + 0u)];
        result[_e54] = _e60;
        continuing {
            let _e62 = result_index;
            result_index = (_e62 + 1u);
        }
    }
    let _e65 = result;
    return _e65;
}

fn gen__naga_trig_extract_product(digits: array<u32, 22>, offset: u32) -> u32 {
    var source: array<u32, 22> = array<u32, 22>();
    var low: u32 = u32();
    var high: u32 = u32();

    source = digits;
    let _e5 = (offset / 16u);
    let _e7 = (offset % 16u);
    let _e13 = (_e5 + 0u);
    if (_e13 < 22u) {
        let _e17 = source[_e13];
        low = _e17;
    }
    let _e19 = (_e5 + 1u);
    if (_e19 < 22u) {
        let _e23 = source[_e19];
        high = _e23;
    }
    let _e24 = low;
    let _e25 = high;
    return (((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u);
}

fn gen__naga_trig_multiply(left_3: array<u32, 12>, right_3: array<u32, 12>) -> array<u32, 12> {
    var left_digits_1: array<u32, 12> = array<u32, 12>();
    var right_digits_1: array<u32, 12> = array<u32, 12>();
    var product_1: array<u32, 24> = array<u32, 24>();
    var carry_1: u32 = u32();
    var left_index_1: u32 = u32();
    var right_index_1: u32 = u32();
    var result_1: array<u32, 12> = array<u32, 12>();
    var result_index_1: u32 = u32();

    left_digits_1 = left_3;
    right_digits_1 = right_3;
    left_index_1 = 0u;
    loop {
        let _e13 = left_index_1;
        if (_e13 >= 12u) {
            break;
        }
        carry_1 = 0u;
        let _e18 = left_digits_1[_e13];
        right_index_1 = 0u;
        loop {
            let _e22 = right_index_1;
            if (_e22 >= 12u) {
                break;
            }
            let _e26 = right_digits_1[_e22];
            let _e27 = (_e13 + _e22);
            let _e29 = product_1[_e27];
            let _e30 = carry_1;
            let _e33 = (((_e18 * _e26) + _e29) + _e30);
            product_1[_e27] = (_e33 & 65535u);
            carry_1 = (_e33 >> 16u);
            continuing {
                let _e39 = right_index_1;
                right_index_1 = (_e39 + 1u);
            }
        }
        let _e44 = carry_1;
        product_1[(_e13 + 12u)] = _e44;
        continuing {
            let _e46 = left_index_1;
            left_index_1 = (_e46 + 1u);
        }
    }
    result_index_1 = 0u;
    loop {
        let _e54 = result_index_1;
        if (_e54 >= 12u) {
            break;
        }
        let _e60 = product_1[(_e54 + 11u)];
        result_1[_e54] = _e60;
        continuing {
            let _e62 = result_index_1;
            result_index_1 = (_e62 + 1u);
        }
    }
    let _e65 = result_1;
    return _e65;
}

fn gen__naga_trig_divide(value_8: array<u32, 12>, divisor: u32) -> array<u32, 12> {
    var source_1: array<u32, 12> = array<u32, 12>();
    var result_2: array<u32, 12> = array<u32, 12>();
    var remainder_1: u32 = u32();
    var step_: u32 = u32();

    source_1 = value_8;
    step_ = 0u;
    loop {
        let _e11 = step_;
        if (_e11 >= 12u) {
            break;
        }
        let _e15 = (11u - _e11);
        let _e16 = remainder_1;
        let _e20 = source_1[_e15];
        let _e21 = ((_e16 << 16u) | _e20);
        result_2[_e15] = (_e21 / divisor);
        remainder_1 = (_e21 % divisor);
        continuing {
            let _e25 = step_;
            step_ = (_e25 + 1u);
        }
    }
    let _e28 = result_2;
    return _e28;
}

fn gen__naga_trig_combine(left_4: array<u32, 12>, right_4: array<u32, 12>, subtract: u32) -> array<u32, 12> {
    var left_digits_2: array<u32, 12> = array<u32, 12>();
    var right_digits_2: array<u32, 12> = array<u32, 12>();
    var result_3: array<u32, 12> = array<u32, 12>();
    var carry_2: u32 = u32();
    var digit_index: u32 = u32();

    left_digits_2 = left_4;
    right_digits_2 = right_4;
    let _e12 = (subtract != 0u);
    digit_index = 0u;
    loop {
        let _e16 = digit_index;
        if (_e16 >= 12u) {
            break;
        }
        let _e20 = left_digits_2[_e16];
        let _e22 = right_digits_2[_e16];
        let _e23 = carry_2;
        let _e24 = (_e22 + _e23);
        let _e26 = (_e20 + _e24);
        result_3[_e16] = (select(_e26, (_e20 - _e24), _e12) & 65535u);
        carry_2 = select((_e26 >> 16u), select(0u, 1u, (_e20 < _e24)), _e12);
        continuing {
            let _e38 = digit_index;
            digit_index = (_e38 + 1u);
        }
    }
    let _e41 = result_3;
    return _e41;
}

fn gen__naga_trig_kernel(angle: array<u32, 12>, sine: u32) -> array<u32, 12> {
    var term: array<u32, 12> = array<u32, 12>();
    var total_1: array<u32, 12> = array<u32, 12>();
    var step_1: u32 = u32();

    let _e7 = (sine != 0u);
    if _e7 {
        term = angle;
    } else {
        term = array<u32, 12>(0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u);
    }
    let _e21 = term;
    total_1 = _e21;
    let _e22 = gen__naga_trig_multiply(angle, angle);
    step_1 = 0u;
    loop {
        let _e26 = step_1;
        if (_e26 >= 8u) {
            break;
        }
        let _e30 = (_e26 + 1u);
        let _e32 = (_e30 * 2u);
        let _e39 = term;
        let _e40 = gen__naga_trig_multiply(_e39, _e22);
        let _e41 = gen__naga_trig_divide(_e40, (_e32 * select((_e32 - 1u), (_e32 + 1u), _e7)));
        term = _e41;
        let _e42 = total_1;
        let _e45 = gen__naga_trig_combine(_e42, _e41, (_e30 & 1u));
        total_1 = _e45;
        continuing {
            let _e46 = step_1;
            step_1 = (_e46 + 1u);
        }
    }
    let _e49 = total_1;
    return _e49;
}

fn gen__naga_trig_extract_fixed(digits_1: array<u32, 12>, offset_1: u32) -> u32 {
    var source_2: array<u32, 12> = array<u32, 12>();
    var low_1: u32 = u32();
    var high_1: u32 = u32();

    source_2 = digits_1;
    let _e5 = (offset_1 / 16u);
    let _e7 = (offset_1 % 16u);
    let _e13 = (_e5 + 0u);
    if (_e13 < 12u) {
        let _e17 = source_2[_e13];
        low_1 = _e17;
    }
    let _e19 = (_e5 + 1u);
    if (_e19 < 12u) {
        let _e23 = source_2[_e19];
        high_1 = _e23;
    }
    let _e24 = low_1;
    let _e25 = high_1;
    return (((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u);
}

fn gen__naga_trig_round(digits_2: array<u32, 12>) -> u32 {
    var source_3: array<u32, 12> = array<u32, 12>();
    var highest_bit: u32 = u32();
    var nonzero: u32 = u32();
    var digit_index_1: u32 = u32();
    var sticky: u32 = u32();
    var sticky_index: u32 = u32();

    source_3 = digits_2;
    digit_index_1 = 0u;
    loop {
        let _e10 = digit_index_1;
        if (_e10 >= 12u) {
            break;
        }
        let _e14 = source_3[_e10];
        let _e15 = nonzero;
        nonzero = (_e15 | _e14);
        if (_e14 != 0u) {
            highest_bit = ((_e10 * 16u) + (31u - countLeadingZeros(_e14)));
        }
        continuing {
            let _e25 = digit_index_1;
            digit_index_1 = (_e25 + 1u);
        }
    }
    let _e28 = nonzero;
    if (_e28 == 0u) {
        return 0u;
    }
    let _e32 = highest_bit;
    let _e38 = select(27u, (_e32 - 23u), (_e32 >= 50u));
    let _e39 = gen__naga_trig_extract_fixed(digits_2, _e38);
    let _e42 = gen__naga_trig_extract_fixed(digits_2, (_e38 + 16u));
    let _e45 = (_e39 | (_e42 << 16u));
    let _e47 = (_e38 - 1u);
    let _e48 = gen__naga_trig_extract_fixed(digits_2, _e47);
    let _e54 = (_e47 / 16u);
    sticky_index = 0u;
    loop {
        let _e66 = sticky_index;
        if (_e66 >= 12u) {
            break;
        }
        let _e76 = source_3[_e66];
        let _e78 = sticky;
        sticky = (_e78 | (_e76 & select(select(0u, ((1u << (_e47 % 16u)) - 1u), (_e66 == _e54)), 65535u, (_e66 < _e54))));
        continuing {
            let _e80 = sticky_index;
            sticky_index = (_e80 + 1u);
        }
    }
    let _e83 = sticky;
    let _e93 = (_e45 + select(0u, 1u, (((_e48 & 1u) != 0u) && ((_e83 | (_e45 & 1u)) != 0u))));
    if (_e32 < 50u) {
        return _e93;
    }
    let _e97 = (_e93 == 16777216u);
    let _e102 = (_e32 - 49u);
    return ((select(_e102, (_e102 + 1u), _e97) << 23u) | (select(_e93, (_e93 >> 1u), _e97) & 8388607u));
}

fn gen__naga_trigonometry(input_bits_1: u32, cosine: u32) -> u32 {
    var quadrant: u32 = u32();
    var fraction: array<u32, 12> = array<u32, 12>();
    var fraction_index: u32 = u32();

    let _e3 = (input_bits_1 & 2147483647u);
    if (_e3 >= 2139095040u) {
        return 2143289344u;
    }
    let _e8 = (cosine != 0u);
    if (_e3 <= 956301312u) {
        return select(input_bits_1, 1065353216u, _e8);
    }
    let _e16 = (470u - (_e3 >> 23u));
    let _e20 = ((_e3 & 8388607u) | 8388608u);
    let _e47 = gen__naga_trig_reduce_multiply(array<u32, 2>((_e20 & 65535u), (_e20 >> 16u)), array<u32, 20>(53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    let _e50 = gen__naga_trig_extract_product(_e47, _e16);
    quadrant = (_e50 & 3u);
    fraction_index = 0u;
    loop {
        let _e60 = fraction_index;
        if (_e60 >= 11u) {
            break;
        }
        let _e66 = gen__naga_trig_extract_product(_e47, ((_e16 - 176u) + (_e60 * 16u)));
        fraction[_e60] = _e66;
        continuing {
            let _e68 = fraction_index;
            fraction_index = (_e68 + 1u);
        }
    }
    let _e73 = fraction[10u];
    let _e75 = (_e73 >= 32768u);
    if _e75 {
        let _e89 = quadrant;
        quadrant = ((_e89 + 1u) & 3u);
        let _e94 = fraction;
        let _e96 = gen__naga_trig_combine(array<u32, 12>(0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u), _e94, 1u);
        fraction = _e96;
    }
    let _e97 = fraction;
    let _e111 = gen__naga_trig_multiply(_e97, array<u32, 12>(5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u));
    let _e112 = quadrant;
    let _e115 = ((_e112 & 1u) == cosine);
    let _e119 = gen__naga_trig_kernel(_e111, select(0u, 1u, _e115));
    let _e120 = gen__naga_trig_round(_e119);
    return (_e120 | ((select(0u, 2147483648u, (_e75 && _e115)) ^ ((select(_e112, (_e112 + 1u), _e8) & 2u) << 30u)) ^ select((input_bits_1 & 2147483648u), 0u, _e8)));
}

fn generated(value_9: f32) -> f32 {
    let _e3 = gen__naga_sqrtf(bitcast<u32>(4f));
    let _e7 = gen__naga_trigonometry(bitcast<u32>(value_9), 0u);
    let _e12 = gen__naga_trigonometry(bitcast<u32>(value_9), 1u);
    return ((bitcast<f32>(_e3) + bitcast<f32>(_e7)) + bitcast<f32>(_e12));
}

fn control(count: i32) -> i32 {
    var result_4: i32;
    var index: i32;

    result_4 = 0i;
    {
        index = 0i;
        loop {
            let _e5 = index;
            if (_e5 < count) {
            } else {
                break;
            }
            let _e7 = index;
            if (_e7 == 1i) {
                continue;
            }
            let _e10 = index;
            switch _e10 {
                case 0: {
                    let _e11 = index;
                    let _e12 = route_1(_e11);
                    let _e13 = result_4;
                    result_4 = (_e13 + _e12);
                    break;
                }
                default: {
                    let _e15 = index;
                    let _e16 = forward(_e15);
                    let _e17 = index;
                    let _e18 = earlier(_e17);
                    let _e20 = result_4;
                    result_4 = (_e20 + (_e16 - _e18));
                    break;
                }
            }
            continuing {
                let _e22 = index;
                index = (_e22 + 1i);
            }
        }
    }
    let _e25 = result_4;
    return _e25;
}

fn late_index() -> u32 {
    let _e1 = blockIdx_1;
    let _e6 = threadIdx_1;
    return ((_e1.x * 2u) + _e6.x);
}

@compute @workgroup_size(2, 1, 1)
fn prototypes(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: i32;
    var first: Packet_cuda_record_0_;
    var second: Packet_cuda_record_0_;
    var total: Packet_cuda_record_0_;
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
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;

    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    let lane = late_index();
    let base = (lane * 16u);
    counter = 1i;
    let _e9 = counter;
    counter = (_e9 + 1i);
    let _e12 = packet(_e9);
    first = _e12;
    let _e14 = first;
    let _e15 = adjust(_e14);
    second = _e15;
    let _e17 = first;
    let _e18 = second;
    let _e19 = operator_u002b(_e17, _e18);
    total = _e19;
    let _e22 = earlier(3i);
    local = u32(base);
    let _e26 = local;
    local_16 = u32(_e26);
    let _e29 = local_16;
    out[_e29] = u32(_e22);
    let _e33 = route_1(3i);
    local_1 = u32((base + u32(1i)));
    let _e40 = local_1;
    local_17 = u32(_e40);
    let _e43 = local_17;
    out[_e43] = u32(_e33);
    let _e46 = forward(4i);
    local_2 = u32((base + u32(2i)));
    let _e53 = local_2;
    local_18 = u32(_e53);
    let _e56 = local_18;
    out[_e56] = u32(_e46);
    let _e59 = first.key;
    local_3 = u32((base + u32(3i)));
    let _e66 = local_3;
    local_19 = u32(_e66);
    let _e69 = local_19;
    out[_e69] = u32(_e59);
    let _e74 = first.values[1i];
    local_4 = u32((base + u32(4i)));
    let _e81 = local_4;
    local_20 = u32(_e81);
    let _e84 = local_20;
    out[_e84] = u32(_e74);
    let _e87 = second.key;
    local_5 = u32((base + u32(5i)));
    let _e94 = local_5;
    local_21 = u32(_e94);
    let _e97 = local_21;
    out[_e97] = u32(_e87);
    let _e102 = second.values[1i];
    local_6 = u32((base + u32(6i)));
    let _e109 = local_6;
    local_22 = u32(_e109);
    let _e112 = local_22;
    out[_e112] = u32(_e102);
    let _e115 = total.key;
    local_7 = u32((base + u32(7i)));
    let _e122 = local_7;
    local_23 = u32(_e122);
    let _e125 = local_23;
    out[_e125] = u32(_e115);
    let _e130 = total.values[0i];
    local_8 = u32((base + u32(8i)));
    let _e137 = local_8;
    local_24 = u32(_e137);
    let _e140 = local_24;
    out[_e140] = u32(_e130);
    let _e145 = total.values[1i];
    local_9 = u32((base + u32(9i)));
    let _e152 = local_9;
    local_25 = u32(_e152);
    let _e155 = local_25;
    out[_e155] = u32(_e145);
    let first_argument = counter;
    counter = (first_argument + 1i);
    let _e160 = counter;
    counter = (_e160 + 1i);
    let _e163 = pair(first_argument, _e160);
    local_10 = u32((base + u32(10i)));
    let _e170 = local_10;
    local_26 = u32(_e170);
    let _e173 = local_26;
    out[_e173] = u32(_e163);
    let _e175 = counter;
    counter = (_e175 + 1i);
    consume(_e175);
    let _e178 = counter;
    local_11 = u32((base + u32(11i)));
    let _e185 = local_11;
    local_27 = u32(_e185);
    let _e188 = local_27;
    out[_e188] = u32(_e178);
    let _e191 = generated(0f);
    local_12 = u32((base + u32(12i)));
    let _e198 = local_12;
    local_28 = u32(_e198);
    let _e201 = local_28;
    out[_e201] = bitcast<u32>(_e191);
    let _e204 = control(3i);
    local_13 = u32((base + u32(13i)));
    let _e211 = local_13;
    local_29 = u32(_e211);
    let _e214 = local_29;
    out[_e214] = u32(_e204);
    local_14 = u32((base + u32(14i)));
    let _e221 = local_14;
    local_30 = u32(_e221);
    let _e224 = local_30;
    out[_e224] = lane;
    let _e226 = counter;
    counter = (_e226 + 1i);
    let _e229 = counter;
    let _e230 = forward(_e229);
    local_15 = u32((base + u32(15i)));
    let _e237 = local_15;
    local_31 = u32(_e237);
    let _e240 = local_31;
    out[_e240] = u32(_e230);
}
