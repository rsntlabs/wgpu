struct Ratio_cuda_record_0_ {
    value: f32,
}

@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_divide_f32_(numerator_bits: u32, denominator_bits: u32) -> u32 {
    var numerator_significand: u32;
    var numerator_exponent: i32;
    var denominator_significand: u32;
    var denominator_exponent: i32;
    var quotient: u32;
    var remainder: u32;
    var iteration_1: u32;

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
    remainder = (select(_e46, (_e46 << 1u), _e70) - _e68);
    iteration_1 = 0u;
    loop {
        let _e83 = iteration_1;
        if (_e83 >= 23u) {
            break;
        }
        let _e85 = remainder;
        let _e86 = quotient;
        let _e87 = (_e85 << 1u);
        let _e88 = (_e87 >= _e68);
        remainder = select(_e87, (_e87 - _e68), _e88);
        quotient = ((_e86 << 1u) | select(0u, 1u, _e88));
        continuing {
            let _e94 = iteration_1;
            iteration_1 = (_e94 + 1u);
        }
    }
    let _e96 = quotient;
    let _e97 = remainder;
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

fn quotient_1(numerator: f32, denominator: f32) -> f32 {
    let _e4 = gen__naga_divide_f32_(bitcast<u32>(numerator), bitcast<u32>(denominator));
    return bitcast<f32>(_e4);
}

fn operator_u002f(left_1: vec4<f32>, right_4: vec4<f32>) -> vec4<f32> {
    var left_2: vec4<f32>;
    var right_5: vec4<f32>;

    left_2 = left_1;
    right_5 = right_4;
    let _e6 = left_2.x;
    let _e7 = right_5.x;
    let _e10 = gen__naga_divide_f32_(bitcast<u32>(_e6), bitcast<u32>(_e7));
    let _e14 = left_2.y;
    let _e15 = right_5.y;
    let _e18 = gen__naga_divide_f32_(bitcast<u32>(_e14), bitcast<u32>(_e15));
    let _e22 = left_2.z;
    let _e23 = right_5.z;
    let _e26 = gen__naga_divide_f32_(bitcast<u32>(_e22), bitcast<u32>(_e23));
    let _e30 = left_2.w;
    let _e31 = right_5.w;
    let _e34 = gen__naga_divide_f32_(bitcast<u32>(_e30), bitcast<u32>(_e31));
    return vec4<f32>(bitcast<f32>(_e10), bitcast<f32>(_e18), bitcast<f32>(_e26), bitcast<f32>(_e34));
}

fn operator_u002f_1(left_3: vec4<f32>, right_6: f32) -> vec4<f32> {
    var left_4: vec4<f32>;

    left_4 = left_3;
    let _e4 = left_4.x;
    let _e7 = gen__naga_divide_f32_(bitcast<u32>(_e4), bitcast<u32>(right_6));
    let _e10 = left_4.y;
    let _e13 = gen__naga_divide_f32_(bitcast<u32>(_e10), bitcast<u32>(right_6));
    let _e16 = left_4.z;
    let _e19 = gen__naga_divide_f32_(bitcast<u32>(_e16), bitcast<u32>(right_6));
    let _e22 = left_4.w;
    let _e25 = gen__naga_divide_f32_(bitcast<u32>(_e22), bitcast<u32>(right_6));
    return vec4<f32>(bitcast<f32>(_e7), bitcast<f32>(_e13), bitcast<f32>(_e19), bitcast<f32>(_e25));
}

fn operator_u002f_2(left_5: f32, right_7: vec4<f32>) -> vec4<f32> {
    var right_8: vec4<f32>;

    right_8 = right_7;
    let _e4 = right_8.x;
    let _e7 = gen__naga_divide_f32_(bitcast<u32>(left_5), bitcast<u32>(_e4));
    let _e10 = right_8.y;
    let _e13 = gen__naga_divide_f32_(bitcast<u32>(left_5), bitcast<u32>(_e10));
    let _e16 = right_8.z;
    let _e19 = gen__naga_divide_f32_(bitcast<u32>(left_5), bitcast<u32>(_e16));
    let _e22 = right_8.w;
    let _e25 = gen__naga_divide_f32_(bitcast<u32>(left_5), bitcast<u32>(_e22));
    return vec4<f32>(bitcast<f32>(_e7), bitcast<f32>(_e13), bitcast<f32>(_e19), bitcast<f32>(_e25));
}

fn operator_u002f_3(left_6: Ratio_cuda_record_0_, right_9: Ratio_cuda_record_0_) -> f32 {
    var left_7: Ratio_cuda_record_0_;
    var right_10: Ratio_cuda_record_0_;

    left_7 = left_6;
    right_10 = right_9;
    let _e6 = left_7.value;
    let _e7 = right_10.value;
    return (_e6 + _e7);
}

fn gen__naga_fabsf(input_bits: u32) -> u32 {
    let _e2 = (input_bits & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

@compute @workgroup_size(1, 1, 1)
fn divisions() {
    var values: vec4<f32>;
    var divisors: vec4<f32>;
    var divided: vec4<f32>;
    var scalar: f32;
    var bank: array<f32, 2>;
    var index: u32;
    var divisor: f32;
    var first: Ratio_cuda_record_0_;
    var second: Ratio_cuda_record_0_;
    var updated: Ratio_cuda_record_0_;
    var local: Ratio_cuda_record_0_;
    var third: f32;
    var left: f32;
    var right: f32;
    var selected_numerator: f32;
    var selected_denominator: f32;
    var choose: bool;
    var local_1: f32;
    var local_2: bool;
    var local_3: bool;
    var scale: f32;
    var iteration: i32;
    var local_4: f32;
    var right_1: vec4<f32>;
    var local_5: vec4<f32>;
    var right_2: f32;
    var local_6: vec4<f32>;
    var right_3: f32;
    var local_7: Ratio_cuda_record_0_;

    let _e4 = input[u32(0i)];
    let numerator_1 = bitcast<f32>(_e4);
    let _e9 = input[u32(1i)];
    let denominator_1 = bitcast<f32>(_e9);
    let _e13 = gen__naga_divide_f32_(bitcast<u32>(numerator_1), bitcast<u32>(denominator_1));
    output[u32(0i)] = bitcast<u32>(bitcast<f32>(_e13));
    let _e20 = quotient_1(numerator_1, denominator_1);
    output[u32(1i)] = bitcast<u32>(_e20);
    let _e29 = gen__naga_divide_f32_(bitcast<u32>(numerator_1), bitcast<u32>(f32(3i)));
    output[u32(2i)] = bitcast<u32>(bitcast<f32>(_e29));
    let _e39 = gen__naga_divide_f32_(bitcast<u32>(f32(3i)), bitcast<u32>(numerator_1));
    output[u32(3i)] = bitcast<u32>(bitcast<f32>(_e39));
    let _e50 = input[u32(3i)];
    values = vec4<f32>(numerator_1, 1f, -(0f), bitcast<f32>(_e50));
    divisors = vec4<f32>(denominator_1, 3f, 3f, 2f);
    let _e60 = values;
    let _e61 = divisors;
    let _e62 = operator_u002f(_e60, _e61);
    divided = _e62;
    let _e65 = divided.x;
    output[u32(4i)] = bitcast<u32>(_e65);
    let _e71 = divided.y;
    output[u32(5i)] = bitcast<u32>(_e71);
    let _e77 = divided.z;
    output[u32(6i)] = bitcast<u32>(_e77);
    let _e83 = divided.w;
    output[u32(7i)] = bitcast<u32>(_e83);
    let _e88 = values;
    let _e90 = operator_u002f_1(_e88, 3f);
    divided = _e90;
    let _e92 = divided.x;
    output[u32(8i)] = bitcast<u32>(_e92);
    let _e98 = divided.y;
    output[u32(9i)] = bitcast<u32>(_e98);
    let _e104 = divided.z;
    output[u32(10i)] = bitcast<u32>(_e104);
    let _e110 = divided.w;
    output[u32(11i)] = bitcast<u32>(_e110);
    let _e115 = divisors;
    let _e117 = operator_u002f_2(3f, _e115);
    divided = _e117;
    let _e119 = divided.x;
    output[u32(12i)] = bitcast<u32>(_e119);
    let _e125 = divided.y;
    output[u32(13i)] = bitcast<u32>(_e125);
    let _e131 = divided.z;
    output[u32(14i)] = bitcast<u32>(_e131);
    let _e137 = divided.w;
    output[u32(15i)] = bitcast<u32>(_e137);
    let _e142 = values;
    divided = _e142;
    let _e143 = divisors;
    right_1 = vec4<f32>();
    right_1 = _e143;
    let _e147 = divided;
    local_5 = _e147;
    let _e149 = local_5;
    let _e150 = right_1;
    let _e151 = operator_u002f(_e149, _e150);
    divided = _e151;
    let _e153 = divided.x;
    output[u32(16i)] = bitcast<u32>(_e153);
    let _e159 = divided.y;
    output[u32(17i)] = bitcast<u32>(_e159);
    let _e165 = divided.z;
    output[u32(18i)] = bitcast<u32>(_e165);
    let _e171 = divided.w;
    output[u32(19i)] = bitcast<u32>(_e171);
    let _e176 = values;
    divided = _e176;
    right_2 = f32();
    right_2 = 3f;
    let _e181 = divided;
    local_6 = _e181;
    let _e183 = local_6;
    let _e184 = right_2;
    let _e185 = operator_u002f_1(_e183, _e184);
    divided = _e185;
    let _e187 = divided.x;
    output[u32(20i)] = bitcast<u32>(_e187);
    let _e193 = divided.y;
    output[u32(21i)] = bitcast<u32>(_e193);
    let _e199 = divided.z;
    output[u32(22i)] = bitcast<u32>(_e199);
    let _e205 = divided.w;
    output[u32(23i)] = bitcast<u32>(_e205);
    scalar = numerator_1;
    let _e211 = scalar;
    let _e214 = gen__naga_divide_f32_(bitcast<u32>(_e211), bitcast<u32>(denominator_1));
    scalar = bitcast<f32>(_e214);
    let _e216 = scalar;
    output[u32(24i)] = bitcast<u32>(_e216);
    let _e221 = scalar;
    output[u32(25i)] = bitcast<u32>(_e221);
    bank[0] = numerator_1;
    bank[1] = 7f;
    index = 0u;
    divisor = denominator_1;
    let _e233 = divisor;
    divisor = (_e233 + f32(1i));
    let _e237 = index;
    index = (_e237 + u32(1i));
    let _e242 = bank[_e237];
    let _e245 = gen__naga_divide_f32_(bitcast<u32>(_e242), bitcast<u32>(_e233));
    bank[_e237] = bitcast<f32>(_e245);
    let _e247 = bank[_e237];
    output[u32(26i)] = bitcast<u32>(_e247);
    let _e254 = bank[0i];
    output[u32(27i)] = bitcast<u32>(_e254);
    let _e259 = index;
    output[u32(28i)] = _e259;
    let _e263 = divisor;
    output[u32(29i)] = bitcast<u32>(_e263);
    let _e270 = bank[1i];
    output[u32(30i)] = bitcast<u32>(_e270);
    output[u32(31i)] = u32((-(7i) / 3i));
    output[u32(32i)] = (4294967295u / 3u);
    first.value = 2f;
    second.value = 3f;
    let _e295 = first;
    let _e296 = second;
    let _e297 = operator_u002f_3(_e295, _e296);
    output[u32(33i)] = bitcast<u32>(_e297);
    right_3 = f32();
    right_3 = 3f;
    let _e306 = right_3;
    let _e308 = first.value;
    first.value = (_e308 + _e306);
    let _e311 = first;
    local_7 = _e311;
    let _e313 = local_7;
    local = _e313;
    let _e315 = local;
    updated = _e315;
    let _e318 = updated.value;
    output[u32(34i)] = bitcast<u32>(_e318);
    let _e324 = first.value;
    output[u32(35i)] = bitcast<u32>(_e324);
    third = 0.33333334f;
    let _e331 = third;
    output[u32(36i)] = bitcast<u32>(_e331);
    left = 2f;
    right = 3f;
    let _e340 = left;
    left = (_e340 + f32(1i));
    let _e344 = right;
    right = (_e344 + f32(1i));
    let _e350 = gen__naga_divide_f32_(bitcast<u32>(_e340), bitcast<u32>(_e344));
    output[u32(37i)] = bitcast<u32>(bitcast<f32>(_e350));
    let _e356 = left;
    output[u32(38i)] = bitcast<u32>(_e356);
    let _e361 = right;
    output[u32(39i)] = bitcast<u32>(_e361);
    selected_numerator = numerator_1;
    selected_denominator = denominator_1;
    choose = false;
    let _e370 = choose;
    if _e370 {
        let _e371 = selected_numerator;
        selected_numerator = (_e371 + f32(1i));
        let _e375 = selected_denominator;
        selected_denominator = (_e375 + f32(1i));
        let _e379 = quotient_1(_e371, _e375);
        local_1 = _e379;
    } else {
        let _e381 = selected_numerator;
        selected_numerator = (_e381 + f32(1i));
        let _e385 = selected_denominator;
        selected_denominator = (_e385 + f32(1i));
        let _e391 = gen__naga_divide_f32_(bitcast<u32>(_e381), bitcast<u32>(_e385));
        local_1 = bitcast<f32>(_e391);
    }
    let _e395 = local_1;
    output[u32(40i)] = bitcast<u32>(_e395);
    let _e400 = selected_numerator;
    output[u32(41i)] = bitcast<u32>(_e400);
    let _e405 = selected_denominator;
    output[u32(42i)] = bitcast<u32>(_e405);
    local_2 = false;
    if false {
        let _e412 = selected_numerator;
        selected_numerator = (_e412 + f32(1i));
        let _e416 = selected_denominator;
        selected_denominator = (_e416 + f32(1i));
        let _e420 = quotient_1(_e412, _e416);
        let _e422 = gen__naga_fabsf(bitcast<u32>(_e420));
        local_2 = (_e422 != 0u);
    }
    let _e425 = local_2;
    output[u32(43i)] = u32(_e425);
    let _e430 = selected_numerator;
    output[u32(44i)] = bitcast<u32>(_e430);
    local_3 = true;
    if true {
    } else {
        let _e437 = selected_numerator;
        selected_numerator = (_e437 + f32(1i));
        let _e441 = selected_denominator;
        selected_denominator = (_e441 + f32(1i));
        let _e445 = quotient_1(_e437, _e441);
        let _e447 = gen__naga_fabsf(bitcast<u32>(_e445));
        local_3 = (_e447 != 0u);
    }
    let _e450 = local_3;
    output[u32(45i)] = u32(_e450);
    let _e455 = selected_denominator;
    output[u32(46i)] = bitcast<u32>(_e455);
    scale = 6f;
    let _e462 = scale;
    let _e466 = gen__naga_divide_f32_(bitcast<u32>(_e462), bitcast<u32>(2f));
    scale = bitcast<f32>(_e466);
    let _e468 = scale;
    let _e472 = gen__naga_divide_f32_(bitcast<u32>(_e468), bitcast<u32>(3f));
    scale = bitcast<f32>(_e472);
    let _e474 = scale;
    output[u32(47i)] = bitcast<u32>(_e474);
    let _e479 = scale;
    output[u32(48i)] = bitcast<u32>(_e479);
    scale = 8f;
    {
        iteration = 0i;
        loop {
            let _e487 = iteration;
            if (_e487 < 2i) {
            } else {
                break;
            }
            let _e490 = iteration;
            if (_e490 == 0i) {
                continue;
            }
            let _e493 = scale;
            let _e497 = gen__naga_divide_f32_(bitcast<u32>(_e493), bitcast<u32>(2f));
            scale = bitcast<f32>(_e497);
            continuing {
                let _e499 = iteration;
                iteration = (_e499 + 1i);
            }
        }
    }
    let _e502 = scale;
    output[u32(49i)] = bitcast<u32>(_e502);
    left = 2f;
    right = 3f;
    let _e509 = left;
    left = (_e509 + f32(1i));
    let _e513 = right;
    right = (_e513 + f32(1i));
    let _e519 = gen__naga_divide_f32_(bitcast<u32>(_e509), bitcast<u32>(_e513));
    local_4 = bitcast<f32>(_e519);
    let _e522 = local_4;
    output[u32(50i)] = bitcast<u32>(_e522);
    let _e527 = left;
    output[u32(51i)] = bitcast<u32>(_e527);
    let _e532 = right;
    output[u32(52i)] = bitcast<u32>(_e532);
    let _e539 = gen__naga_divide_f32_(bitcast<u32>(numerator_1), bitcast<u32>(denominator_1));
    let _e544 = gen__naga_divide_f32_(bitcast<u32>(bitcast<f32>(_e539)), bitcast<u32>(3f));
    output[u32(53i)] = bitcast<u32>(bitcast<f32>(_e544));
    let _e553 = gen__naga_divide_f32_(bitcast<u32>(24f), bitcast<u32>(denominator_1));
    let _e558 = gen__naga_divide_f32_(bitcast<u32>(bitcast<f32>(_e553)), bitcast<u32>(2f));
    output[u32(54i)] = bitcast<u32>(bitcast<f32>(_e558));
    let _e567 = gen__naga_divide_f32_(bitcast<u32>(denominator_1), bitcast<u32>(2f));
    let _e572 = gen__naga_divide_f32_(bitcast<u32>(24f), bitcast<u32>(bitcast<f32>(_e567)));
    output[u32(55i)] = bitcast<u32>(bitcast<f32>(_e572));
    let _e582 = gen__naga_divide_f32_(bitcast<u32>(numerator_1), bitcast<u32>(f32(true)));
    output[u32(56i)] = bitcast<u32>(bitcast<f32>(_e582));
    let _e592 = gen__naga_divide_f32_(bitcast<u32>(f32(4294967295u)), bitcast<u32>(denominator_1));
    output[u32(57i)] = bitcast<u32>(bitcast<f32>(_e592));
    let _e601 = input[u32(2i)];
    let _e605 = gen__naga_divide_f32_(bitcast<u32>(numerator_1), bitcast<u32>(bitcast<f32>(_e601)));
    output[u32(58i)] = bitcast<u32>(bitcast<f32>(_e605));
    let _e614 = input[u32(2i)];
    let _e619 = input[u32(2i)];
    let _e623 = gen__naga_divide_f32_(bitcast<u32>(bitcast<f32>(_e614)), bitcast<u32>(bitcast<f32>(_e619)));
    output[u32(59i)] = bitcast<u32>(bitcast<f32>(_e623));
    let _e632 = input[u32(3i)];
    let _e637 = input[u32(3i)];
    let _e641 = gen__naga_divide_f32_(bitcast<u32>(bitcast<f32>(_e632)), bitcast<u32>(bitcast<f32>(_e637)));
    output[u32(60i)] = bitcast<u32>(bitcast<f32>(_e641));
}
