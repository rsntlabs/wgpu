struct Ratio_cuda_record_0_ {
    float value;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint _naga_divide_f32_(uint numerator_bits, uint denominator_bits)
{
    uint numerator_significand = (uint)0;
    int numerator_exponent = (int)0;
    uint denominator_significand = (uint)0;
    int denominator_exponent = (int)0;
    uint quotient = (uint)0;
    uint remainder = (uint)0;
    uint iteration_1 = (uint)0;

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
    numerator_exponent = asint(asuint(int(_e31)) - asuint(int(127)));
    if ((_e31 == 0u)) {
        uint _e41 = ((31u - firstbithigh(_e30)) - 8u);
        numerator_significand = (_e30 << _e41);
        numerator_exponent = asint(asuint(int(-126)) - asuint(int(_e41)));
    }
    uint _e46 = numerator_significand;
    int _e47 = numerator_exponent;
    uint _e52 = (_e9 & 8388607u);
    uint _e53 = (_e9 >> 23u);
    denominator_significand = (_e52 | 8388608u);
    denominator_exponent = asint(asuint(int(_e53)) - asuint(int(127)));
    if ((_e53 == 0u)) {
        uint _e63 = ((31u - firstbithigh(_e52)) - 8u);
        denominator_significand = (_e52 << _e63);
        denominator_exponent = asint(asuint(int(-126)) - asuint(int(_e63)));
    }
    uint _e68 = denominator_significand;
    int _e69 = denominator_exponent;
    bool _e70 = (_e46 < _e68);
    int _e75 = asint(asuint(asint(asuint(_e47) - asuint(_e69))) - asuint(int(_e70)));
    if ((_e75 < int(-150))) {
        return _e11;
    }
    quotient = 1u;
    remainder = ((_e70 ? (_e46 << 1u) : _e46) - _e68);
    iteration_1 = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
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
    if ((_e75 < int(-126))) {
        uint _e103 = (uint(asint(asuint(int(-126)) - asuint(_e75))) & 31u);
        uint _e104 = (1u << _e103);
        uint _e106 = (_e96 & (_e104 - 1u));
        uint _e107 = (_e104 >> 1u);
        uint _e108 = (_e96 >> _e103);
        return (_e11 | (_e108 + (((_e106 > _e107) || ((_e106 == _e107) && ((_e97 != 0u) || ((_e108 & 1u) != 0u)))) ? 1u : 0u)));
    }
    uint _e120 = (_e97 << 1u);
    uint _e128 = (_e96 + (((_e120 > _e68) || ((_e120 == _e68) && ((_e96 & 1u) != 0u))) ? 1u : 0u));
    uint _e130 = (_e128 >> 24u);
    int _e133 = asint(asuint(_e75) + asuint(int(_e130)));
    if ((_e133 > int(127))) {
        return _e12;
    }
    return (_e11 | ((uint(asint(asuint(_e133) + asuint(int(127)))) << 23u) | ((_e128 >> _e130) & 8388607u)));
}

float quotient_1(float numerator, float denominator)
{
    const uint _e4 = _naga_divide_f32_(asuint(numerator), asuint(denominator));
    return asfloat(_e4);
}

float4 operator_u002f(float4 left_1, float4 right_4)
{
    float4 left_2 = (float4)0;
    float4 right_5 = (float4)0;

    left_2 = left_1;
    right_5 = right_4;
    float _e6 = left_2.x;
    float _e7 = right_5.x;
    const uint _e10 = _naga_divide_f32_(asuint(_e6), asuint(_e7));
    float _e14 = left_2.y;
    float _e15 = right_5.y;
    const uint _e18 = _naga_divide_f32_(asuint(_e14), asuint(_e15));
    float _e22 = left_2.z;
    float _e23 = right_5.z;
    const uint _e26 = _naga_divide_f32_(asuint(_e22), asuint(_e23));
    float _e30 = left_2.w;
    float _e31 = right_5.w;
    const uint _e34 = _naga_divide_f32_(asuint(_e30), asuint(_e31));
    return float4(asfloat(_e10), asfloat(_e18), asfloat(_e26), asfloat(_e34));
}

float4 operator_u002f_1(float4 left_3, float right_6)
{
    float4 left_4 = (float4)0;

    left_4 = left_3;
    float _e4 = left_4.x;
    const uint _e7 = _naga_divide_f32_(asuint(_e4), asuint(right_6));
    float _e10 = left_4.y;
    const uint _e13 = _naga_divide_f32_(asuint(_e10), asuint(right_6));
    float _e16 = left_4.z;
    const uint _e19 = _naga_divide_f32_(asuint(_e16), asuint(right_6));
    float _e22 = left_4.w;
    const uint _e25 = _naga_divide_f32_(asuint(_e22), asuint(right_6));
    return float4(asfloat(_e7), asfloat(_e13), asfloat(_e19), asfloat(_e25));
}

float4 operator_u002f_2(float left_5, float4 right_7)
{
    float4 right_8 = (float4)0;

    right_8 = right_7;
    float _e4 = right_8.x;
    const uint _e7 = _naga_divide_f32_(asuint(left_5), asuint(_e4));
    float _e10 = right_8.y;
    const uint _e13 = _naga_divide_f32_(asuint(left_5), asuint(_e10));
    float _e16 = right_8.z;
    const uint _e19 = _naga_divide_f32_(asuint(left_5), asuint(_e16));
    float _e22 = right_8.w;
    const uint _e25 = _naga_divide_f32_(asuint(left_5), asuint(_e22));
    return float4(asfloat(_e7), asfloat(_e13), asfloat(_e19), asfloat(_e25));
}

float operator_u002f_3(Ratio_cuda_record_0_ left_6, Ratio_cuda_record_0_ right_9)
{
    Ratio_cuda_record_0_ left_7 = (Ratio_cuda_record_0_)0;
    Ratio_cuda_record_0_ right_10 = (Ratio_cuda_record_0_)0;

    left_7 = left_6;
    right_10 = right_9;
    float _e6 = left_7.value;
    float _e7 = right_10.value;
    return (_e6 + _e7);
}

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

int naga_div(int lhs, int rhs) {
    return lhs / (((lhs == int(-2147483647 - 1) & rhs == -1) | (rhs == 0)) ? 1 : rhs);
}

uint naga_div(uint lhs, uint rhs) {
    return lhs / (rhs == 0u ? 1u : rhs);
}

float4 ZeroValuefloat4() {
    return (float4)0;
}

float ZeroValuefloat() {
    return (float)0;
}

[numthreads(1, 1, 1)]
void divisions()
{
    float4 values = (float4)0;
    float4 divisors = (float4)0;
    float4 divided = (float4)0;
    float scalar = (float)0;
    float bank[2] = (float[2])0;
    uint index = (uint)0;
    float divisor = (float)0;
    Ratio_cuda_record_0_ first = (Ratio_cuda_record_0_)0;
    Ratio_cuda_record_0_ second = (Ratio_cuda_record_0_)0;
    Ratio_cuda_record_0_ updated = (Ratio_cuda_record_0_)0;
    Ratio_cuda_record_0_ local = (Ratio_cuda_record_0_)0;
    float third = (float)0;
    float left = (float)0;
    float right = (float)0;
    float selected_numerator = (float)0;
    float selected_denominator = (float)0;
    bool choose = (bool)0;
    float local_1 = (float)0;
    bool local_2 = (bool)0;
    bool local_3 = (bool)0;
    float scale = (float)0;
    int iteration = (int)0;
    float local_4 = (float)0;
    float4 right_1 = (float4)0;
    float4 local_5 = (float4)0;
    float right_2 = (float)0;
    float4 local_6 = (float4)0;
    float right_3 = (float)0;
    Ratio_cuda_record_0_ local_7 = (Ratio_cuda_record_0_)0;

    uint _e4 = asuint(input.Load(uint(int(0))*4));
    float numerator_1 = asfloat(_e4);
    uint _e9 = asuint(input.Load(uint(int(1))*4));
    float denominator_1 = asfloat(_e9);
    const uint _e13 = _naga_divide_f32_(asuint(numerator_1), asuint(denominator_1));
    output.Store(uint(int(0))*4, asuint(asuint(asfloat(_e13))));
    const float _e20 = quotient_1(numerator_1, denominator_1);
    output.Store(uint(int(1))*4, asuint(asuint(_e20)));
    const uint _e29 = _naga_divide_f32_(asuint(numerator_1), asuint(float(int(3))));
    output.Store(uint(int(2))*4, asuint(asuint(asfloat(_e29))));
    const uint _e39 = _naga_divide_f32_(asuint(float(int(3))), asuint(numerator_1));
    output.Store(uint(int(3))*4, asuint(asuint(asfloat(_e39))));
    uint _e50 = asuint(input.Load(uint(int(3))*4));
    values = float4(numerator_1, 1.0, -(0.0), asfloat(_e50));
    divisors = float4(denominator_1, 3.0, 3.0, 2.0);
    float4 _e60 = values;
    float4 _e61 = divisors;
    const float4 _e62 = operator_u002f(_e60, _e61);
    divided = _e62;
    float _e65 = divided.x;
    output.Store(uint(int(4))*4, asuint(asuint(_e65)));
    float _e71 = divided.y;
    output.Store(uint(int(5))*4, asuint(asuint(_e71)));
    float _e77 = divided.z;
    output.Store(uint(int(6))*4, asuint(asuint(_e77)));
    float _e83 = divided.w;
    output.Store(uint(int(7))*4, asuint(asuint(_e83)));
    float4 _e88 = values;
    const float4 _e90 = operator_u002f_1(_e88, 3.0);
    divided = _e90;
    float _e92 = divided.x;
    output.Store(uint(int(8))*4, asuint(asuint(_e92)));
    float _e98 = divided.y;
    output.Store(uint(int(9))*4, asuint(asuint(_e98)));
    float _e104 = divided.z;
    output.Store(uint(int(10))*4, asuint(asuint(_e104)));
    float _e110 = divided.w;
    output.Store(uint(int(11))*4, asuint(asuint(_e110)));
    float4 _e115 = divisors;
    const float4 _e117 = operator_u002f_2(3.0, _e115);
    divided = _e117;
    float _e119 = divided.x;
    output.Store(uint(int(12))*4, asuint(asuint(_e119)));
    float _e125 = divided.y;
    output.Store(uint(int(13))*4, asuint(asuint(_e125)));
    float _e131 = divided.z;
    output.Store(uint(int(14))*4, asuint(asuint(_e131)));
    float _e137 = divided.w;
    output.Store(uint(int(15))*4, asuint(asuint(_e137)));
    float4 _e142 = values;
    divided = _e142;
    float4 _e143 = divisors;
    right_1 = ZeroValuefloat4();
    right_1 = _e143;
    float4 _e147 = divided;
    local_5 = _e147;
    float4 _e149 = local_5;
    float4 _e150 = right_1;
    const float4 _e151 = operator_u002f(_e149, _e150);
    divided = _e151;
    float _e153 = divided.x;
    output.Store(uint(int(16))*4, asuint(asuint(_e153)));
    float _e159 = divided.y;
    output.Store(uint(int(17))*4, asuint(asuint(_e159)));
    float _e165 = divided.z;
    output.Store(uint(int(18))*4, asuint(asuint(_e165)));
    float _e171 = divided.w;
    output.Store(uint(int(19))*4, asuint(asuint(_e171)));
    float4 _e176 = values;
    divided = _e176;
    right_2 = ZeroValuefloat();
    right_2 = 3.0;
    float4 _e181 = divided;
    local_6 = _e181;
    float4 _e183 = local_6;
    float _e184 = right_2;
    const float4 _e185 = operator_u002f_1(_e183, _e184);
    divided = _e185;
    float _e187 = divided.x;
    output.Store(uint(int(20))*4, asuint(asuint(_e187)));
    float _e193 = divided.y;
    output.Store(uint(int(21))*4, asuint(asuint(_e193)));
    float _e199 = divided.z;
    output.Store(uint(int(22))*4, asuint(asuint(_e199)));
    float _e205 = divided.w;
    output.Store(uint(int(23))*4, asuint(asuint(_e205)));
    scalar = numerator_1;
    float _e211 = scalar;
    const uint _e214 = _naga_divide_f32_(asuint(_e211), asuint(denominator_1));
    scalar = asfloat(_e214);
    float _e216 = scalar;
    output.Store(uint(int(24))*4, asuint(asuint(_e216)));
    float _e221 = scalar;
    output.Store(uint(int(25))*4, asuint(asuint(_e221)));
    bank[0] = numerator_1;
    bank[1] = 7.0;
    index = 0u;
    divisor = denominator_1;
    float _e233 = divisor;
    divisor = (_e233 + float(int(1)));
    uint _e237 = index;
    index = (_e237 + uint(int(1)));
    float _e242 = bank[min(uint(_e237), 1u)];
    const uint _e245 = _naga_divide_f32_(asuint(_e242), asuint(_e233));
    bank[min(uint(_e237), 1u)] = asfloat(_e245);
    float _e247 = bank[min(uint(_e237), 1u)];
    output.Store(uint(int(26))*4, asuint(asuint(_e247)));
    float _e254 = bank[int(0)];
    output.Store(uint(int(27))*4, asuint(asuint(_e254)));
    uint _e259 = index;
    output.Store(uint(int(28))*4, asuint(_e259));
    float _e263 = divisor;
    output.Store(uint(int(29))*4, asuint(asuint(_e263)));
    float _e270 = bank[int(1)];
    output.Store(uint(int(30))*4, asuint(asuint(_e270)));
    output.Store(uint(int(31))*4, asuint(uint(naga_div(naga_neg(int(7)), int(3)))));
    output.Store(uint(int(32))*4, asuint(naga_div(4294967295u, 3u)));
    first.value = 2.0;
    second.value = 3.0;
    Ratio_cuda_record_0_ _e295 = first;
    Ratio_cuda_record_0_ _e296 = second;
    const float _e297 = operator_u002f_3(_e295, _e296);
    output.Store(uint(int(33))*4, asuint(asuint(_e297)));
    right_3 = ZeroValuefloat();
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
    output.Store(uint(int(34))*4, asuint(asuint(_e318)));
    float _e324 = first.value;
    output.Store(uint(int(35))*4, asuint(asuint(_e324)));
    third = 0.33333334;
    float _e331 = third;
    output.Store(uint(int(36))*4, asuint(asuint(_e331)));
    left = 2.0;
    right = 3.0;
    float _e340 = left;
    left = (_e340 + float(int(1)));
    float _e344 = right;
    right = (_e344 + float(int(1)));
    const uint _e350 = _naga_divide_f32_(asuint(_e340), asuint(_e344));
    output.Store(uint(int(37))*4, asuint(asuint(asfloat(_e350))));
    float _e356 = left;
    output.Store(uint(int(38))*4, asuint(asuint(_e356)));
    float _e361 = right;
    output.Store(uint(int(39))*4, asuint(asuint(_e361)));
    selected_numerator = numerator_1;
    selected_denominator = denominator_1;
    choose = false;
    bool _e370 = choose;
    if (_e370) {
        float _e371 = selected_numerator;
        selected_numerator = (_e371 + float(int(1)));
        float _e375 = selected_denominator;
        selected_denominator = (_e375 + float(int(1)));
        const float _e379 = quotient_1(_e371, _e375);
        local_1 = _e379;
    } else {
        float _e381 = selected_numerator;
        selected_numerator = (_e381 + float(int(1)));
        float _e385 = selected_denominator;
        selected_denominator = (_e385 + float(int(1)));
        const uint _e391 = _naga_divide_f32_(asuint(_e381), asuint(_e385));
        local_1 = asfloat(_e391);
    }
    float _e395 = local_1;
    output.Store(uint(int(40))*4, asuint(asuint(_e395)));
    float _e400 = selected_numerator;
    output.Store(uint(int(41))*4, asuint(asuint(_e400)));
    float _e405 = selected_denominator;
    output.Store(uint(int(42))*4, asuint(asuint(_e405)));
    local_2 = false;
    if (false) {
        float _e412 = selected_numerator;
        selected_numerator = (_e412 + float(int(1)));
        float _e416 = selected_denominator;
        selected_denominator = (_e416 + float(int(1)));
        const float _e420 = quotient_1(_e412, _e416);
        const uint _e422 = _naga_fabsf(asuint(_e420));
        local_2 = (_e422 != 0u);
    }
    bool _e425 = local_2;
    output.Store(uint(int(43))*4, asuint(uint(_e425)));
    float _e430 = selected_numerator;
    output.Store(uint(int(44))*4, asuint(asuint(_e430)));
    local_3 = true;
    if (true) {
    } else {
        float _e437 = selected_numerator;
        selected_numerator = (_e437 + float(int(1)));
        float _e441 = selected_denominator;
        selected_denominator = (_e441 + float(int(1)));
        const float _e445 = quotient_1(_e437, _e441);
        const uint _e447 = _naga_fabsf(asuint(_e445));
        local_3 = (_e447 != 0u);
    }
    bool _e450 = local_3;
    output.Store(uint(int(45))*4, asuint(uint(_e450)));
    float _e455 = selected_denominator;
    output.Store(uint(int(46))*4, asuint(asuint(_e455)));
    scale = 6.0;
    float _e462 = scale;
    const uint _e466 = _naga_divide_f32_(asuint(_e462), asuint(2.0));
    scale = asfloat(_e466);
    float _e468 = scale;
    const uint _e472 = _naga_divide_f32_(asuint(_e468), asuint(3.0));
    scale = asfloat(_e472);
    float _e474 = scale;
    output.Store(uint(int(47))*4, asuint(asuint(_e474)));
    float _e479 = scale;
    output.Store(uint(int(48))*4, asuint(asuint(_e479)));
    scale = 8.0;
    {
        iteration = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e499 = iteration;
                iteration = asint(asuint(_e499) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e487 = iteration;
            if ((_e487 < int(2))) {
            } else {
                break;
            }
            int _e490 = iteration;
            if ((_e490 == int(0))) {
                continue;
            }
            float _e493 = scale;
            const uint _e497 = _naga_divide_f32_(asuint(_e493), asuint(2.0));
            scale = asfloat(_e497);
        }
    }
    float _e502 = scale;
    output.Store(uint(int(49))*4, asuint(asuint(_e502)));
    left = 2.0;
    right = 3.0;
    float _e509 = left;
    left = (_e509 + float(int(1)));
    float _e513 = right;
    right = (_e513 + float(int(1)));
    const uint _e519 = _naga_divide_f32_(asuint(_e509), asuint(_e513));
    local_4 = asfloat(_e519);
    float _e522 = local_4;
    output.Store(uint(int(50))*4, asuint(asuint(_e522)));
    float _e527 = left;
    output.Store(uint(int(51))*4, asuint(asuint(_e527)));
    float _e532 = right;
    output.Store(uint(int(52))*4, asuint(asuint(_e532)));
    const uint _e539 = _naga_divide_f32_(asuint(numerator_1), asuint(denominator_1));
    const uint _e544 = _naga_divide_f32_(asuint(asfloat(_e539)), asuint(3.0));
    output.Store(uint(int(53))*4, asuint(asuint(asfloat(_e544))));
    const uint _e553 = _naga_divide_f32_(asuint(24.0), asuint(denominator_1));
    const uint _e558 = _naga_divide_f32_(asuint(asfloat(_e553)), asuint(2.0));
    output.Store(uint(int(54))*4, asuint(asuint(asfloat(_e558))));
    const uint _e567 = _naga_divide_f32_(asuint(denominator_1), asuint(2.0));
    const uint _e572 = _naga_divide_f32_(asuint(24.0), asuint(asfloat(_e567)));
    output.Store(uint(int(55))*4, asuint(asuint(asfloat(_e572))));
    const uint _e582 = _naga_divide_f32_(asuint(numerator_1), asuint(float(true)));
    output.Store(uint(int(56))*4, asuint(asuint(asfloat(_e582))));
    const uint _e592 = _naga_divide_f32_(asuint(float(4294967295u)), asuint(denominator_1));
    output.Store(uint(int(57))*4, asuint(asuint(asfloat(_e592))));
    uint _e601 = asuint(input.Load(uint(int(2))*4));
    const uint _e605 = _naga_divide_f32_(asuint(numerator_1), asuint(asfloat(_e601)));
    output.Store(uint(int(58))*4, asuint(asuint(asfloat(_e605))));
    uint _e614 = asuint(input.Load(uint(int(2))*4));
    uint _e619 = asuint(input.Load(uint(int(2))*4));
    const uint _e623 = _naga_divide_f32_(asuint(asfloat(_e614)), asuint(asfloat(_e619)));
    output.Store(uint(int(59))*4, asuint(asuint(asfloat(_e623))));
    uint _e632 = asuint(input.Load(uint(int(3))*4));
    uint _e637 = asuint(input.Load(uint(int(3))*4));
    const uint _e641 = _naga_divide_f32_(asuint(asfloat(_e632)), asuint(asfloat(_e637)));
    output.Store(uint(int(60))*4, asuint(asuint(asfloat(_e641))));
}
