#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct Ratio_cuda_record_0_ {
    float value;
};
layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_divide_f32_(uint numerator_bits, uint denominator_bits) {
    uint numerator_significand = 0u;
    int numerator_exponent = 0;
    uint denominator_significand = 0u;
    int denominator_exponent = 0;
    uint quotient = 0u;
    uint remainder = 0u;
    uint iteration_1 = 0u;
    uint _e8 = (numerator_bits & 2147483647u);
    uint _e9 = (denominator_bits & 2147483647u);
    uint _e11 = ((numerator_bits ^ denominator_bits) & 2147483648u);
    uint _e12 = (_e11 | 2139095040u);
    bool _e16 = (_e8 == 0u);
    bool _e17 = (_e9 == 0u);
    bool _e19 = (_e8 == 2139095040u);
    bool _e20 = (_e9 == 2139095040u);
    if (((((_e8 > 2139095040u) || (_e9 > 2139095040u)) || (_e16 && _e17)) || (_e19 && _e20))) {
        return 2143289344u;
    }
    if ((_e19 || _e17)) {
        return _e12;
    }
    if ((_e16 || _e20)) {
        return _e11;
    }
    uint _e30 = (_e8 & 8388607u);
    uint _e31 = (_e8 >> 23u);
    numerator_significand = (_e30 | 8388608u);
    numerator_exponent = (int(_e31) - 127);
    if ((_e31 == 0u)) {
        uint _e41 = (uint(31 - findMSB(_e30)) - 8u);
        numerator_significand = (_e30 << _e41);
        numerator_exponent = (-126 - int(_e41));
    }
    uint _e46 = numerator_significand;
    int _e47 = numerator_exponent;
    uint _e52 = (_e9 & 8388607u);
    uint _e53 = (_e9 >> 23u);
    denominator_significand = (_e52 | 8388608u);
    denominator_exponent = (int(_e53) - 127);
    if ((_e53 == 0u)) {
        uint _e63 = (uint(31 - findMSB(_e52)) - 8u);
        denominator_significand = (_e52 << _e63);
        denominator_exponent = (-126 - int(_e63));
    }
    uint _e68 = denominator_significand;
    int _e69 = denominator_exponent;
    bool _e70 = (_e46 < _e68);
    int _e75 = ((_e47 - _e69) - int(_e70));
    if ((_e75 < -150)) {
        return _e11;
    }
    quotient = 1u;
    remainder = ((_e70 ? (_e46 << 1u) : _e46) - _e68);
    iteration_1 = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e94 = iteration_1;
            iteration_1 = (_e94 + 1u);
        }
        loop_init = false;
        uint _e83 = iteration_1;
        if ((_e83 >= 23u)) {
            break;
        }
        uint _e85 = remainder;
        uint _e86 = quotient;
        uint _e87 = (_e85 << 1u);
        bool _e88 = (_e87 >= _e68);
        remainder = (_e88 ? (_e87 - _e68) : _e87);
        quotient = ((_e86 << 1u) | (_e88 ? 1u : 0u));
    }
    uint _e96 = quotient;
    uint _e97 = remainder;
    if ((_e75 < -126)) {
        uint _e103 = (uint((-126 - _e75)) & 31u);
        uint _e104 = (1u << _e103);
        uint _e106 = (_e96 & (_e104 - 1u));
        uint _e107 = (_e104 >> 1u);
        uint _e108 = (_e96 >> _e103);
        return (_e11 | (_e108 + (((_e106 > _e107) || ((_e106 == _e107) && ((_e97 != 0u) || ((_e108 & 1u) != 0u)))) ? 1u : 0u)));
    }
    uint _e120 = (_e97 << 1u);
    uint _e128 = (_e96 + (((_e120 > _e68) || ((_e120 == _e68) && ((_e96 & 1u) != 0u))) ? 1u : 0u));
    uint _e130 = (_e128 >> 24u);
    int _e133 = (_e75 + int(_e130));
    if ((_e133 > 127)) {
        return _e12;
    }
    return (_e11 | ((uint((_e133 + 127)) << 23u) | ((_e128 >> _e130) & 8388607u)));
}

float quotient_1(float numerator, float denominator) {
    uint _e4 = _naga_divide_f32_(floatBitsToUint(numerator), floatBitsToUint(denominator));
    return uintBitsToFloat(_e4);
}

vec4 operator_u002f(vec4 left_1, vec4 right_4) {
    vec4 left_2 = vec4(0.0);
    vec4 right_5 = vec4(0.0);
    left_2 = left_1;
    right_5 = right_4;
    float _e6 = left_2.x;
    float _e7 = right_5.x;
    uint _e10 = _naga_divide_f32_(floatBitsToUint(_e6), floatBitsToUint(_e7));
    float _e14 = left_2.y;
    float _e15 = right_5.y;
    uint _e18 = _naga_divide_f32_(floatBitsToUint(_e14), floatBitsToUint(_e15));
    float _e22 = left_2.z;
    float _e23 = right_5.z;
    uint _e26 = _naga_divide_f32_(floatBitsToUint(_e22), floatBitsToUint(_e23));
    float _e30 = left_2.w;
    float _e31 = right_5.w;
    uint _e34 = _naga_divide_f32_(floatBitsToUint(_e30), floatBitsToUint(_e31));
    return vec4(uintBitsToFloat(_e10), uintBitsToFloat(_e18), uintBitsToFloat(_e26), uintBitsToFloat(_e34));
}

vec4 operator_u002f_1(vec4 left_3, float right_6) {
    vec4 left_4 = vec4(0.0);
    left_4 = left_3;
    float _e4 = left_4.x;
    uint _e7 = _naga_divide_f32_(floatBitsToUint(_e4), floatBitsToUint(right_6));
    float _e10 = left_4.y;
    uint _e13 = _naga_divide_f32_(floatBitsToUint(_e10), floatBitsToUint(right_6));
    float _e16 = left_4.z;
    uint _e19 = _naga_divide_f32_(floatBitsToUint(_e16), floatBitsToUint(right_6));
    float _e22 = left_4.w;
    uint _e25 = _naga_divide_f32_(floatBitsToUint(_e22), floatBitsToUint(right_6));
    return vec4(uintBitsToFloat(_e7), uintBitsToFloat(_e13), uintBitsToFloat(_e19), uintBitsToFloat(_e25));
}

vec4 operator_u002f_2(float left_5, vec4 right_7) {
    vec4 right_8 = vec4(0.0);
    right_8 = right_7;
    float _e4 = right_8.x;
    uint _e7 = _naga_divide_f32_(floatBitsToUint(left_5), floatBitsToUint(_e4));
    float _e10 = right_8.y;
    uint _e13 = _naga_divide_f32_(floatBitsToUint(left_5), floatBitsToUint(_e10));
    float _e16 = right_8.z;
    uint _e19 = _naga_divide_f32_(floatBitsToUint(left_5), floatBitsToUint(_e16));
    float _e22 = right_8.w;
    uint _e25 = _naga_divide_f32_(floatBitsToUint(left_5), floatBitsToUint(_e22));
    return vec4(uintBitsToFloat(_e7), uintBitsToFloat(_e13), uintBitsToFloat(_e19), uintBitsToFloat(_e25));
}

float operator_u002f_3(Ratio_cuda_record_0_ left_6, Ratio_cuda_record_0_ right_9) {
    Ratio_cuda_record_0_ left_7 = Ratio_cuda_record_0_(0.0);
    Ratio_cuda_record_0_ right_10 = Ratio_cuda_record_0_(0.0);
    left_7 = left_6;
    right_10 = right_9;
    float _e6 = left_7.value;
    float _e7 = right_10.value;
    return (_e6 + _e7);
}

uint _naga_fabsf(uint input_bits) {
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

void main() {
    vec4 values = vec4(0.0);
    vec4 divisors = vec4(0.0);
    vec4 divided = vec4(0.0);
    float scalar = 0.0;
    float bank[2] = float[2](0.0, 0.0);
    uint index = 0u;
    float divisor = 0.0;
    Ratio_cuda_record_0_ first = Ratio_cuda_record_0_(0.0);
    Ratio_cuda_record_0_ second = Ratio_cuda_record_0_(0.0);
    Ratio_cuda_record_0_ updated = Ratio_cuda_record_0_(0.0);
    Ratio_cuda_record_0_ local = Ratio_cuda_record_0_(0.0);
    float third = 0.0;
    float left = 0.0;
    float right = 0.0;
    float selected_numerator = 0.0;
    float selected_denominator = 0.0;
    bool choose = false;
    float local_1 = 0.0;
    bool local_2 = false;
    bool local_3 = false;
    float scale = 0.0;
    int iteration = 0;
    float local_4 = 0.0;
    vec4 right_1 = vec4(0.0);
    vec4 local_5 = vec4(0.0);
    float right_2 = 0.0;
    vec4 local_6 = vec4(0.0);
    float right_3 = 0.0;
    Ratio_cuda_record_0_ local_7 = Ratio_cuda_record_0_(0.0);
    uint _e4 = _group_0_binding_0_cs[uint(0)];
    float numerator_1 = uintBitsToFloat(_e4);
    uint _e9 = _group_0_binding_0_cs[uint(1)];
    float denominator_1 = uintBitsToFloat(_e9);
    uint _e13 = _naga_divide_f32_(floatBitsToUint(numerator_1), floatBitsToUint(denominator_1));
    _group_0_binding_1_cs[uint(0)] = floatBitsToUint(uintBitsToFloat(_e13));
    float _e20 = quotient_1(numerator_1, denominator_1);
    _group_0_binding_1_cs[uint(1)] = floatBitsToUint(_e20);
    uint _e29 = _naga_divide_f32_(floatBitsToUint(numerator_1), floatBitsToUint(float(3)));
    _group_0_binding_1_cs[uint(2)] = floatBitsToUint(uintBitsToFloat(_e29));
    uint _e39 = _naga_divide_f32_(floatBitsToUint(float(3)), floatBitsToUint(numerator_1));
    _group_0_binding_1_cs[uint(3)] = floatBitsToUint(uintBitsToFloat(_e39));
    uint _e50 = _group_0_binding_0_cs[uint(3)];
    values = vec4(numerator_1, 1.0, -(0.0), uintBitsToFloat(_e50));
    divisors = vec4(denominator_1, 3.0, 3.0, 2.0);
    vec4 _e60 = values;
    vec4 _e61 = divisors;
    vec4 _e62 = operator_u002f(_e60, _e61);
    divided = _e62;
    float _e65 = divided.x;
    _group_0_binding_1_cs[uint(4)] = floatBitsToUint(_e65);
    float _e71 = divided.y;
    _group_0_binding_1_cs[uint(5)] = floatBitsToUint(_e71);
    float _e77 = divided.z;
    _group_0_binding_1_cs[uint(6)] = floatBitsToUint(_e77);
    float _e83 = divided.w;
    _group_0_binding_1_cs[uint(7)] = floatBitsToUint(_e83);
    vec4 _e88 = values;
    vec4 _e90 = operator_u002f_1(_e88, 3.0);
    divided = _e90;
    float _e92 = divided.x;
    _group_0_binding_1_cs[uint(8)] = floatBitsToUint(_e92);
    float _e98 = divided.y;
    _group_0_binding_1_cs[uint(9)] = floatBitsToUint(_e98);
    float _e104 = divided.z;
    _group_0_binding_1_cs[uint(10)] = floatBitsToUint(_e104);
    float _e110 = divided.w;
    _group_0_binding_1_cs[uint(11)] = floatBitsToUint(_e110);
    vec4 _e115 = divisors;
    vec4 _e117 = operator_u002f_2(3.0, _e115);
    divided = _e117;
    float _e119 = divided.x;
    _group_0_binding_1_cs[uint(12)] = floatBitsToUint(_e119);
    float _e125 = divided.y;
    _group_0_binding_1_cs[uint(13)] = floatBitsToUint(_e125);
    float _e131 = divided.z;
    _group_0_binding_1_cs[uint(14)] = floatBitsToUint(_e131);
    float _e137 = divided.w;
    _group_0_binding_1_cs[uint(15)] = floatBitsToUint(_e137);
    vec4 _e142 = values;
    divided = _e142;
    vec4 _e143 = divisors;
    right_1 = vec4(0.0);
    right_1 = _e143;
    vec4 _e147 = divided;
    local_5 = _e147;
    vec4 _e149 = local_5;
    vec4 _e150 = right_1;
    vec4 _e151 = operator_u002f(_e149, _e150);
    divided = _e151;
    float _e153 = divided.x;
    _group_0_binding_1_cs[uint(16)] = floatBitsToUint(_e153);
    float _e159 = divided.y;
    _group_0_binding_1_cs[uint(17)] = floatBitsToUint(_e159);
    float _e165 = divided.z;
    _group_0_binding_1_cs[uint(18)] = floatBitsToUint(_e165);
    float _e171 = divided.w;
    _group_0_binding_1_cs[uint(19)] = floatBitsToUint(_e171);
    vec4 _e176 = values;
    divided = _e176;
    right_2 = 0.0;
    right_2 = 3.0;
    vec4 _e181 = divided;
    local_6 = _e181;
    vec4 _e183 = local_6;
    float _e184 = right_2;
    vec4 _e185 = operator_u002f_1(_e183, _e184);
    divided = _e185;
    float _e187 = divided.x;
    _group_0_binding_1_cs[uint(20)] = floatBitsToUint(_e187);
    float _e193 = divided.y;
    _group_0_binding_1_cs[uint(21)] = floatBitsToUint(_e193);
    float _e199 = divided.z;
    _group_0_binding_1_cs[uint(22)] = floatBitsToUint(_e199);
    float _e205 = divided.w;
    _group_0_binding_1_cs[uint(23)] = floatBitsToUint(_e205);
    scalar = numerator_1;
    float _e211 = scalar;
    uint _e214 = _naga_divide_f32_(floatBitsToUint(_e211), floatBitsToUint(denominator_1));
    scalar = uintBitsToFloat(_e214);
    float _e216 = scalar;
    _group_0_binding_1_cs[uint(24)] = floatBitsToUint(_e216);
    float _e221 = scalar;
    _group_0_binding_1_cs[uint(25)] = floatBitsToUint(_e221);
    bank[0] = numerator_1;
    bank[1] = 7.0;
    index = 0u;
    divisor = denominator_1;
    float _e233 = divisor;
    divisor = (_e233 + float(1));
    uint _e237 = index;
    index = (_e237 + uint(1));
    float _e242 = bank[_e237];
    uint _e245 = _naga_divide_f32_(floatBitsToUint(_e242), floatBitsToUint(_e233));
    bank[_e237] = uintBitsToFloat(_e245);
    float _e247 = bank[_e237];
    _group_0_binding_1_cs[uint(26)] = floatBitsToUint(_e247);
    float _e254 = bank[0];
    _group_0_binding_1_cs[uint(27)] = floatBitsToUint(_e254);
    uint _e259 = index;
    _group_0_binding_1_cs[uint(28)] = _e259;
    float _e263 = divisor;
    _group_0_binding_1_cs[uint(29)] = floatBitsToUint(_e263);
    float _e270 = bank[1];
    _group_0_binding_1_cs[uint(30)] = floatBitsToUint(_e270);
    _group_0_binding_1_cs[uint(31)] = uint((-(7) / 3));
    _group_0_binding_1_cs[uint(32)] = (4294967295u / 3u);
    first.value = 2.0;
    second.value = 3.0;
    Ratio_cuda_record_0_ _e295 = first;
    Ratio_cuda_record_0_ _e296 = second;
    float _e297 = operator_u002f_3(_e295, _e296);
    _group_0_binding_1_cs[uint(33)] = floatBitsToUint(_e297);
    right_3 = 0.0;
    right_3 = 3.0;
    float _e306 = right_3;
    float _e308 = first.value;
    first.value = (_e308 + _e306);
    Ratio_cuda_record_0_ _e311 = first;
    local_7 = _e311;
    Ratio_cuda_record_0_ _e313 = local_7;
    local = _e313;
    Ratio_cuda_record_0_ _e315 = local;
    updated = _e315;
    float _e318 = updated.value;
    _group_0_binding_1_cs[uint(34)] = floatBitsToUint(_e318);
    float _e324 = first.value;
    _group_0_binding_1_cs[uint(35)] = floatBitsToUint(_e324);
    third = 0.33333334;
    float _e331 = third;
    _group_0_binding_1_cs[uint(36)] = floatBitsToUint(_e331);
    left = 2.0;
    right = 3.0;
    float _e340 = left;
    left = (_e340 + float(1));
    float _e344 = right;
    right = (_e344 + float(1));
    uint _e350 = _naga_divide_f32_(floatBitsToUint(_e340), floatBitsToUint(_e344));
    _group_0_binding_1_cs[uint(37)] = floatBitsToUint(uintBitsToFloat(_e350));
    float _e356 = left;
    _group_0_binding_1_cs[uint(38)] = floatBitsToUint(_e356);
    float _e361 = right;
    _group_0_binding_1_cs[uint(39)] = floatBitsToUint(_e361);
    selected_numerator = numerator_1;
    selected_denominator = denominator_1;
    choose = false;
    bool _e370 = choose;
    if (_e370) {
        float _e371 = selected_numerator;
        selected_numerator = (_e371 + float(1));
        float _e375 = selected_denominator;
        selected_denominator = (_e375 + float(1));
        float _e379 = quotient_1(_e371, _e375);
        local_1 = _e379;
    } else {
        float _e381 = selected_numerator;
        selected_numerator = (_e381 + float(1));
        float _e385 = selected_denominator;
        selected_denominator = (_e385 + float(1));
        uint _e391 = _naga_divide_f32_(floatBitsToUint(_e381), floatBitsToUint(_e385));
        local_1 = uintBitsToFloat(_e391);
    }
    float _e395 = local_1;
    _group_0_binding_1_cs[uint(40)] = floatBitsToUint(_e395);
    float _e400 = selected_numerator;
    _group_0_binding_1_cs[uint(41)] = floatBitsToUint(_e400);
    float _e405 = selected_denominator;
    _group_0_binding_1_cs[uint(42)] = floatBitsToUint(_e405);
    local_2 = false;
    if (false) {
        float _e412 = selected_numerator;
        selected_numerator = (_e412 + float(1));
        float _e416 = selected_denominator;
        selected_denominator = (_e416 + float(1));
        float _e420 = quotient_1(_e412, _e416);
        uint _e422 = _naga_fabsf(floatBitsToUint(_e420));
        local_2 = (_e422 != 0u);
    }
    bool _e425 = local_2;
    _group_0_binding_1_cs[uint(43)] = uint(_e425);
    float _e430 = selected_numerator;
    _group_0_binding_1_cs[uint(44)] = floatBitsToUint(_e430);
    local_3 = true;
    if (true) {
    } else {
        float _e437 = selected_numerator;
        selected_numerator = (_e437 + float(1));
        float _e441 = selected_denominator;
        selected_denominator = (_e441 + float(1));
        float _e445 = quotient_1(_e437, _e441);
        uint _e447 = _naga_fabsf(floatBitsToUint(_e445));
        local_3 = (_e447 != 0u);
    }
    bool _e450 = local_3;
    _group_0_binding_1_cs[uint(45)] = uint(_e450);
    float _e455 = selected_denominator;
    _group_0_binding_1_cs[uint(46)] = floatBitsToUint(_e455);
    scale = 6.0;
    float _e462 = scale;
    uint _e466 = _naga_divide_f32_(floatBitsToUint(_e462), floatBitsToUint(2.0));
    scale = uintBitsToFloat(_e466);
    float _e468 = scale;
    uint _e472 = _naga_divide_f32_(floatBitsToUint(_e468), floatBitsToUint(3.0));
    scale = uintBitsToFloat(_e472);
    float _e474 = scale;
    _group_0_binding_1_cs[uint(47)] = floatBitsToUint(_e474);
    float _e479 = scale;
    _group_0_binding_1_cs[uint(48)] = floatBitsToUint(_e479);
    scale = 8.0;
    {
        iteration = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e499 = iteration;
                iteration = (_e499 + 1);
            }
            loop_init_1 = false;
            int _e487 = iteration;
            if ((_e487 < 2)) {
            } else {
                break;
            }
            int _e490 = iteration;
            if ((_e490 == 0)) {
                continue;
            }
            float _e493 = scale;
            uint _e497 = _naga_divide_f32_(floatBitsToUint(_e493), floatBitsToUint(2.0));
            scale = uintBitsToFloat(_e497);
        }
    }
    float _e502 = scale;
    _group_0_binding_1_cs[uint(49)] = floatBitsToUint(_e502);
    left = 2.0;
    right = 3.0;
    float _e509 = left;
    left = (_e509 + float(1));
    float _e513 = right;
    right = (_e513 + float(1));
    uint _e519 = _naga_divide_f32_(floatBitsToUint(_e509), floatBitsToUint(_e513));
    local_4 = uintBitsToFloat(_e519);
    float _e522 = local_4;
    _group_0_binding_1_cs[uint(50)] = floatBitsToUint(_e522);
    float _e527 = left;
    _group_0_binding_1_cs[uint(51)] = floatBitsToUint(_e527);
    float _e532 = right;
    _group_0_binding_1_cs[uint(52)] = floatBitsToUint(_e532);
    uint _e539 = _naga_divide_f32_(floatBitsToUint(numerator_1), floatBitsToUint(denominator_1));
    uint _e544 = _naga_divide_f32_(floatBitsToUint(uintBitsToFloat(_e539)), floatBitsToUint(3.0));
    _group_0_binding_1_cs[uint(53)] = floatBitsToUint(uintBitsToFloat(_e544));
    uint _e553 = _naga_divide_f32_(floatBitsToUint(24.0), floatBitsToUint(denominator_1));
    uint _e558 = _naga_divide_f32_(floatBitsToUint(uintBitsToFloat(_e553)), floatBitsToUint(2.0));
    _group_0_binding_1_cs[uint(54)] = floatBitsToUint(uintBitsToFloat(_e558));
    uint _e567 = _naga_divide_f32_(floatBitsToUint(denominator_1), floatBitsToUint(2.0));
    uint _e572 = _naga_divide_f32_(floatBitsToUint(24.0), floatBitsToUint(uintBitsToFloat(_e567)));
    _group_0_binding_1_cs[uint(55)] = floatBitsToUint(uintBitsToFloat(_e572));
    uint _e582 = _naga_divide_f32_(floatBitsToUint(numerator_1), floatBitsToUint(float(true)));
    _group_0_binding_1_cs[uint(56)] = floatBitsToUint(uintBitsToFloat(_e582));
    uint _e592 = _naga_divide_f32_(floatBitsToUint(float(4294967295u)), floatBitsToUint(denominator_1));
    _group_0_binding_1_cs[uint(57)] = floatBitsToUint(uintBitsToFloat(_e592));
    uint _e601 = _group_0_binding_0_cs[uint(2)];
    uint _e605 = _naga_divide_f32_(floatBitsToUint(numerator_1), floatBitsToUint(uintBitsToFloat(_e601)));
    _group_0_binding_1_cs[uint(58)] = floatBitsToUint(uintBitsToFloat(_e605));
    uint _e614 = _group_0_binding_0_cs[uint(2)];
    uint _e619 = _group_0_binding_0_cs[uint(2)];
    uint _e623 = _naga_divide_f32_(floatBitsToUint(uintBitsToFloat(_e614)), floatBitsToUint(uintBitsToFloat(_e619)));
    _group_0_binding_1_cs[uint(59)] = floatBitsToUint(uintBitsToFloat(_e623));
    uint _e632 = _group_0_binding_0_cs[uint(3)];
    uint _e637 = _group_0_binding_0_cs[uint(3)];
    uint _e641 = _naga_divide_f32_(floatBitsToUint(uintBitsToFloat(_e632)), floatBitsToUint(uintBitsToFloat(_e637)));
    _group_0_binding_1_cs[uint(60)] = floatBitsToUint(uintBitsToFloat(_e641));
}

