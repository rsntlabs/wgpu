RWByteAddressBuffer out_ : register(u0);

typedef uint ret_ZeroValuearray12_uint_[12];
ret_ZeroValuearray12_uint_ ZeroValuearray12_uint_() {
    return (uint[12])0;
}

typedef uint ret_ZeroValuearray24_uint_[24];
ret_ZeroValuearray24_uint_ ZeroValuearray24_uint_() {
    return (uint[24])0;
}

uint ZeroValueuint() {
    return (uint)0;
}

typedef uint ret_naga_trig_multiply[12];
ret_naga_trig_multiply _naga_trig_multiply(uint left[12], uint right[12])
{
    uint left_digits[12] = ZeroValuearray12_uint_();
    uint right_digits[12] = ZeroValuearray12_uint_();
    uint product[24] = ZeroValuearray24_uint_();
    uint carry = ZeroValueuint();
    uint left_index = ZeroValueuint();
    uint right_index = ZeroValueuint();
    uint result[12] = ZeroValuearray12_uint_();
    uint result_index = ZeroValueuint();

    left_digits = left;
    right_digits = right;
    left_index = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e46 = left_index;
            left_index = (_e46 + 1u);
        }
        loop_init = false;
        uint _e13 = left_index;
        if ((_e13 >= 12u)) {
            break;
        }
        carry = 0u;
        uint _e18 = left_digits[min(uint(_e13), 11u)];
        right_index = 0u;
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                uint _e39 = right_index;
                right_index = (_e39 + 1u);
            }
            loop_init_1 = false;
            uint _e22 = right_index;
            if ((_e22 >= 12u)) {
                break;
            }
            uint _e26 = right_digits[min(uint(_e22), 11u)];
            uint _e27 = (_e13 + _e22);
            uint _e29 = product[min(uint(_e27), 23u)];
            uint _e30 = carry;
            uint _e33 = (((_e18 * _e26) + _e29) + _e30);
            product[min(uint(_e27), 23u)] = (_e33 & 65535u);
            carry = (_e33 >> 16u);
        }
        uint _e44 = carry;
        product[min(uint((_e13 + 12u)), 23u)] = _e44;
    }
    result_index = 0u;
    uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
    bool loop_init_2 = true;
    while(true) {
        if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_2) {
            uint _e62 = result_index;
            result_index = (_e62 + 1u);
        }
        loop_init_2 = false;
        uint _e54 = result_index;
        if ((_e54 >= 12u)) {
            break;
        }
        uint _e60 = product[min(uint((_e54 + 11u)), 23u)];
        result[min(uint(_e54), 11u)] = _e60;
    }
    uint _e65[12] = result;
    return _e65;
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

typedef uint ret_ZeroValuearray20_uint_[20];
ret_ZeroValuearray20_uint_ ZeroValuearray20_uint_() {
    return (uint[20])0;
}

typedef uint ret_ZeroValuearray22_uint_[22];
ret_ZeroValuearray22_uint_ ZeroValuearray22_uint_() {
    return (uint[22])0;
}

typedef uint ret_naga_trig_reduce_multiply[22];
ret_naga_trig_reduce_multiply _naga_trig_reduce_multiply(uint left_1[2], uint right_1[20])
{
    uint left_digits_1[2] = ZeroValuearray2_uint_();
    uint right_digits_1[20] = ZeroValuearray20_uint_();
    uint product_1[22] = ZeroValuearray22_uint_();
    uint carry_1 = ZeroValueuint();
    uint left_index_1 = ZeroValueuint();
    uint right_index_1 = ZeroValueuint();
    uint result_1[22] = ZeroValuearray22_uint_();
    uint result_index_1 = ZeroValueuint();

    left_digits_1 = left_1;
    right_digits_1 = right_1;
    left_index_1 = 0u;
    uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e46 = left_index_1;
            left_index_1 = (_e46 + 1u);
        }
        loop_init_3 = false;
        uint _e13 = left_index_1;
        if ((_e13 >= 2u)) {
            break;
        }
        carry_1 = 0u;
        uint _e18 = left_digits_1[min(uint(_e13), 1u)];
        right_index_1 = 0u;
        uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
        bool loop_init_4 = true;
        while(true) {
            if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
            loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
            if (!loop_init_4) {
                uint _e39 = right_index_1;
                right_index_1 = (_e39 + 1u);
            }
            loop_init_4 = false;
            uint _e22 = right_index_1;
            if ((_e22 >= 20u)) {
                break;
            }
            uint _e26 = right_digits_1[min(uint(_e22), 19u)];
            uint _e27 = (_e13 + _e22);
            uint _e29 = product_1[min(uint(_e27), 21u)];
            uint _e30 = carry_1;
            uint _e33 = (((_e18 * _e26) + _e29) + _e30);
            product_1[min(uint(_e27), 21u)] = (_e33 & 65535u);
            carry_1 = (_e33 >> 16u);
        }
        uint _e44 = carry_1;
        product_1[min(uint((_e13 + 20u)), 21u)] = _e44;
    }
    result_index_1 = 0u;
    uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e62 = result_index_1;
            result_index_1 = (_e62 + 1u);
        }
        loop_init_5 = false;
        uint _e54 = result_index_1;
        if ((_e54 >= 22u)) {
            break;
        }
        uint _e60 = product_1[min(uint((_e54 + 0u)), 21u)];
        result_1[min(uint(_e54), 21u)] = _e60;
    }
    uint _e65[22] = result_1;
    return _e65;
}

uint naga_div(uint lhs, uint rhs) {
    return lhs / (rhs == 0u ? 1u : rhs);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

typedef uint ret_naga_trig_divide[12];
ret_naga_trig_divide _naga_trig_divide(uint value_1[12], uint divisor)
{
    uint source[12] = ZeroValuearray12_uint_();
    uint result_2[12] = ZeroValuearray12_uint_();
    uint remainder = ZeroValueuint();
    uint step_ = ZeroValueuint();

    source = value_1;
    step_ = 0u;
    uint2 loop_bound_6 = uint2(4294967295u, 4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (all(loop_bound_6 == uint2(0u, 0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e25 = step_;
            step_ = (_e25 + 1u);
        }
        loop_init_6 = false;
        uint _e11 = step_;
        if ((_e11 >= 12u)) {
            break;
        }
        uint _e15 = (11u - _e11);
        uint _e16 = remainder;
        uint _e20 = source[min(uint(_e15), 11u)];
        uint _e21 = ((_e16 << 16u) | _e20);
        result_2[min(uint(_e15), 11u)] = naga_div(_e21, divisor);
        remainder = naga_mod(_e21, divisor);
    }
    uint _e28[12] = result_2;
    return _e28;
}

typedef uint ret_naga_trig_combine[12];
ret_naga_trig_combine _naga_trig_combine(uint left_2[12], uint right_2[12], uint subtract)
{
    uint left_digits_2[12] = ZeroValuearray12_uint_();
    uint right_digits_2[12] = ZeroValuearray12_uint_();
    uint result_3[12] = ZeroValuearray12_uint_();
    uint carry_2 = ZeroValueuint();
    uint digit_index = ZeroValueuint();

    left_digits_2 = left_2;
    right_digits_2 = right_2;
    bool _e12 = (subtract != 0u);
    digit_index = 0u;
    uint2 loop_bound_7 = uint2(4294967295u, 4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (all(loop_bound_7 == uint2(0u, 0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e38 = digit_index;
            digit_index = (_e38 + 1u);
        }
        loop_init_7 = false;
        uint _e16 = digit_index;
        if ((_e16 >= 12u)) {
            break;
        }
        uint _e20 = left_digits_2[min(uint(_e16), 11u)];
        uint _e22 = right_digits_2[min(uint(_e16), 11u)];
        uint _e23 = carry_2;
        uint _e24 = (_e22 + _e23);
        uint _e26 = (_e20 + _e24);
        result_3[min(uint(_e16), 11u)] = ((_e12 ? (_e20 - _e24) : _e26) & 65535u);
        carry_2 = (_e12 ? ((_e20 < _e24) ? 1u : 0u) : (_e26 >> 16u));
    }
    uint _e41[12] = result_3;
    return _e41;
}

uint _naga_trig_extract_product(uint digits[22], uint offset)
{
    uint source_1[22] = ZeroValuearray22_uint_();
    uint low = ZeroValueuint();
    uint high = ZeroValueuint();

    source_1 = digits;
    uint _e5 = naga_div(offset, 16u);
    uint _e7 = naga_mod(offset, 16u);
    uint _e13 = (_e5 + 0u);
    if ((_e13 < 22u)) {
        uint _e17 = source_1[min(uint(_e13), 21u)];
        low = _e17;
    }
    uint _e19 = (_e5 + 1u);
    if ((_e19 < 22u)) {
        uint _e23 = source_1[min(uint(_e19), 21u)];
        high = _e23;
    }
    uint _e24 = low;
    uint _e25 = high;
    return (((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u);
}

uint _naga_trig_extract_fixed(uint digits_1[12], uint offset_1)
{
    uint source_2[12] = ZeroValuearray12_uint_();
    uint low_1 = ZeroValueuint();
    uint high_1 = ZeroValueuint();

    source_2 = digits_1;
    uint _e5 = naga_div(offset_1, 16u);
    uint _e7 = naga_mod(offset_1, 16u);
    uint _e13 = (_e5 + 0u);
    if ((_e13 < 12u)) {
        uint _e17 = source_2[min(uint(_e13), 11u)];
        low_1 = _e17;
    }
    uint _e19 = (_e5 + 1u);
    if ((_e19 < 12u)) {
        uint _e23 = source_2[min(uint(_e19), 11u)];
        high_1 = _e23;
    }
    uint _e24 = low_1;
    uint _e25 = high_1;
    return (((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u);
}

typedef uint ret_Constructarray12_uint_[12];
ret_Constructarray12_uint_ Constructarray12_uint_(uint arg0, uint arg1, uint arg2, uint arg3, uint arg4, uint arg5, uint arg6, uint arg7, uint arg8, uint arg9, uint arg10, uint arg11) {
    uint ret[12] = { arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 };
    return ret;
}

typedef uint ret_naga_trig_kernel[12];
ret_naga_trig_kernel _naga_trig_kernel(uint angle[12], uint sine)
{
    uint term[12] = ZeroValuearray12_uint_();
    uint total[12] = ZeroValuearray12_uint_();
    uint step_1 = ZeroValueuint();

    bool _e7 = (sine != 0u);
    if (_e7) {
        term = angle;
    } else {
        term = Constructarray12_uint_(0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u);
    }
    uint _e21[12] = term;
    total = _e21;
    const uint _e22[12] = _naga_trig_multiply(angle, angle);
    step_1 = 0u;
    uint2 loop_bound_8 = uint2(4294967295u, 4294967295u);
    bool loop_init_8 = true;
    while(true) {
        if (all(loop_bound_8 == uint2(0u, 0u))) { break; }
        loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
        if (!loop_init_8) {
            uint _e46 = step_1;
            step_1 = (_e46 + 1u);
        }
        loop_init_8 = false;
        uint _e26 = step_1;
        if ((_e26 >= 8u)) {
            break;
        }
        uint _e30 = (_e26 + 1u);
        uint _e32 = (_e30 * 2u);
        uint _e39[12] = term;
        const uint _e40[12] = _naga_trig_multiply(_e39, _e22);
        const uint _e41[12] = _naga_trig_divide(_e40, (_e32 * (_e7 ? (_e32 + 1u) : (_e32 - 1u))));
        term = _e41;
        uint _e42[12] = total;
        const uint _e45[12] = _naga_trig_combine(_e42, _e41, (_e30 & 1u));
        total = _e45;
    }
    uint _e49[12] = total;
    return _e49;
}

uint _naga_trig_round(uint digits_2[12])
{
    uint source_3[12] = ZeroValuearray12_uint_();
    uint highest_bit = ZeroValueuint();
    uint nonzero = ZeroValueuint();
    uint digit_index_1 = ZeroValueuint();
    uint sticky = ZeroValueuint();
    uint sticky_index = ZeroValueuint();

    source_3 = digits_2;
    digit_index_1 = 0u;
    uint2 loop_bound_9 = uint2(4294967295u, 4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (all(loop_bound_9 == uint2(0u, 0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e25 = digit_index_1;
            digit_index_1 = (_e25 + 1u);
        }
        loop_init_9 = false;
        uint _e10 = digit_index_1;
        if ((_e10 >= 12u)) {
            break;
        }
        uint _e14 = source_3[min(uint(_e10), 11u)];
        uint _e15 = nonzero;
        nonzero = (_e15 | _e14);
        if ((_e14 != 0u)) {
            highest_bit = ((_e10 * 16u) + (31u - (31u - firstbithigh(_e14))));
        }
    }
    uint _e28 = nonzero;
    if ((_e28 == 0u)) {
        return 0u;
    }
    uint _e32 = highest_bit;
    uint _e38 = ((_e32 >= 50u) ? (_e32 - 23u) : 27u);
    const uint _e39 = _naga_trig_extract_fixed(digits_2, _e38);
    const uint _e42 = _naga_trig_extract_fixed(digits_2, (_e38 + 16u));
    uint _e45 = (_e39 | (_e42 << 16u));
    uint _e47 = (_e38 - 1u);
    const uint _e48 = _naga_trig_extract_fixed(digits_2, _e47);
    uint _e54 = naga_div(_e47, 16u);
    sticky_index = 0u;
    uint2 loop_bound_10 = uint2(4294967295u, 4294967295u);
    bool loop_init_10 = true;
    while(true) {
        if (all(loop_bound_10 == uint2(0u, 0u))) { break; }
        loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
        if (!loop_init_10) {
            uint _e80 = sticky_index;
            sticky_index = (_e80 + 1u);
        }
        loop_init_10 = false;
        uint _e66 = sticky_index;
        if ((_e66 >= 12u)) {
            break;
        }
        uint _e76 = source_3[min(uint(_e66), 11u)];
        uint _e78 = sticky;
        sticky = (_e78 | (_e76 & ((_e66 < _e54) ? 65535u : ((_e66 == _e54) ? ((1u << naga_mod(_e47, 16u)) - 1u) : 0u))));
    }
    uint _e83 = sticky;
    uint _e93 = (_e45 + ((((_e48 & 1u) != 0u) && ((_e83 | (_e45 & 1u)) != 0u)) ? 1u : 0u));
    if ((_e32 < 50u)) {
        return _e93;
    }
    bool _e97 = (_e93 == 16777216u);
    uint _e102 = (_e32 - 49u);
    return (((_e97 ? (_e102 + 1u) : _e102) << 23u) | ((_e97 ? (_e93 >> 1u) : _e93) & 8388607u));
}

typedef uint ret_Constructarray2_uint_[2];
ret_Constructarray2_uint_ Constructarray2_uint_(uint arg0, uint arg1) {
    uint ret[2] = { arg0, arg1 };
    return ret;
}

typedef uint ret_Constructarray20_uint_[20];
ret_Constructarray20_uint_ Constructarray20_uint_(uint arg0, uint arg1, uint arg2, uint arg3, uint arg4, uint arg5, uint arg6, uint arg7, uint arg8, uint arg9, uint arg10, uint arg11, uint arg12, uint arg13, uint arg14, uint arg15, uint arg16, uint arg17, uint arg18, uint arg19) {
    uint ret[20] = { arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19 };
    return ret;
}

uint _naga_trigonometry(uint input_bits, uint cosine)
{
    uint quadrant = ZeroValueuint();
    uint fraction[12] = ZeroValuearray12_uint_();
    uint fraction_index = ZeroValueuint();

    uint _e3 = (input_bits & 2147483647u);
    if ((_e3 >= 2139095040u)) {
        return 2143289344u;
    }
    bool _e8 = (cosine != 0u);
    if ((_e3 <= 956301312u)) {
        return (_e8 ? 1065353216u : input_bits);
    }
    uint _e16 = (470u - (_e3 >> 23u));
    uint _e20 = ((_e3 & 8388607u) | 8388608u);
    const uint _e47[22] = _naga_trig_reduce_multiply(Constructarray2_uint_((_e20 & 65535u), (_e20 >> 16u)), Constructarray20_uint_(53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    const uint _e50 = _naga_trig_extract_product(_e47, _e16);
    quadrant = (_e50 & 3u);
    fraction_index = 0u;
    uint2 loop_bound_11 = uint2(4294967295u, 4294967295u);
    bool loop_init_11 = true;
    while(true) {
        if (all(loop_bound_11 == uint2(0u, 0u))) { break; }
        loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
        if (!loop_init_11) {
            uint _e68 = fraction_index;
            fraction_index = (_e68 + 1u);
        }
        loop_init_11 = false;
        uint _e60 = fraction_index;
        if ((_e60 >= 11u)) {
            break;
        }
        const uint _e66 = _naga_trig_extract_product(_e47, ((_e16 - 176u) + (_e60 * 16u)));
        fraction[min(uint(_e60), 11u)] = _e66;
    }
    uint _e73 = fraction[10u];
    bool _e75 = (_e73 >= 32768u);
    if (_e75) {
        uint _e89 = quadrant;
        quadrant = ((_e89 + 1u) & 3u);
        uint _e94[12] = fraction;
        const uint _e96[12] = _naga_trig_combine(Constructarray12_uint_(0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u), _e94, 1u);
        fraction = _e96;
    }
    uint _e97[12] = fraction;
    const uint _e111[12] = _naga_trig_multiply(_e97, Constructarray12_uint_(5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u));
    uint _e112 = quadrant;
    bool _e115 = ((_e112 & 1u) == cosine);
    const uint _e119[12] = _naga_trig_kernel(_e111, (_e115 ? 1u : 0u));
    const uint _e120 = _naga_trig_round(_e119);
    return (_e120 | ((((_e75 && _e115) ? 2147483648u : 0u) ^ (((_e8 ? (_e112 + 1u) : _e112) & 2u) << 30u)) ^ (_e8 ? 0u : (input_bits & 2147483648u))));
}

float sine_value(float value_2)
{
    const uint _e3 = _naga_trigonometry(asuint(value_2), 0u);
    return asfloat(_e3);
}

float cosine_value(float value_3)
{
    const uint _e3 = _naga_trigonometry(asuint(value_3), 1u);
    return asfloat(_e3);
}

int sinf(bool value_4)
{
    int local_33 = (int)0;

    if (value_4) {
        local_33 = int(17);
    } else {
        local_33 = int(19);
    }
    int _e6 = local_33;
    return _e6;
}

int cosf(int value_5)
{
    return asint(asuint(value_5) + asuint(int(23)));
}

float sinf_1(float first, float second)
{
    return (first + second);
}

float cosf_1(float2 value_6)
{
    float2 value_7 = (float2)0;

    value_7 = value_6;
    float _e4 = value_7.x;
    float _e5 = value_7.y;
    return (_e4 + _e5);
}

float identity(float value_8)
{
    return value_8;
}

float pair(float first_1, float second_1)
{
    return ((first_1 * 10.0) + second_1);
}

typedef float ret_ZeroValuearray2_float_[2];
ret_ZeroValuearray2_float_ ZeroValuearray2_float_() {
    return (float[2])0;
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(1, 1, 1)]
void trigonometry()
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    float value = (float)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    bool choose = (bool)0;
    int counter = (int)0;
    uint local_18 = (uint)0;
    bool local_19 = (bool)0;
    uint local_20 = (uint)0;
    bool local_21 = (bool)0;
    uint local_22 = (uint)0;
    float local_23 = (float)0;
    uint local_24 = (uint)0;
    float values[2] = (float[2])0;
    uint local_25 = (uint)0;
    int Count = (int)0;
    float scratch[2] = (float[2])0;
    uint local_26 = (uint)0;
    int repeated = (int)0;
    int index = (int)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    float local_31 = (float)0;
    uint local_32 = (uint)0;

    const uint _e3 = _naga_trigonometry(asuint(0.0), 0u);
    local = uint(int(0));
    uint _e9 = local;
    out_.Store(_e9*4, asuint(asuint(asfloat(_e3))));
    const uint _e16 = _naga_trigonometry(asuint(-(0.0)), 0u);
    local_1 = uint(int(1));
    uint _e22 = local_1;
    out_.Store(_e22*4, asuint(asuint(asfloat(_e16))));
    const uint _e27 = _naga_trigonometry(asuint(0.0), 1u);
    local_2 = uint(int(2));
    uint _e33 = local_2;
    out_.Store(_e33*4, asuint(asuint(asfloat(_e27))));
    const uint _e39 = _naga_trigonometry(asuint(-(0.0)), 1u);
    local_3 = uint(int(3));
    uint _e45 = local_3;
    out_.Store(_e45*4, asuint(asuint(asfloat(_e39))));
    const float _e49 = sine_value(float(int(0)));
    local_4 = uint(int(4));
    uint _e54 = local_4;
    out_.Store(_e54*4, asuint(asuint(_e49)));
    const float _e58 = cosine_value(float(0u));
    local_5 = uint(int(5));
    uint _e63 = local_5;
    out_.Store(_e63*4, asuint(asuint(_e58)));
    const int _e66 = sinf(true);
    local_6 = uint(int(6));
    uint _e71 = local_6;
    out_.Store(_e71*4, asuint(uint(_e66)));
    const int _e74 = sinf(false);
    local_7 = uint(int(7));
    uint _e79 = local_7;
    out_.Store(_e79*4, asuint(uint(_e74)));
    const int _e82 = cosf(int(4));
    local_8 = uint(int(8));
    uint _e87 = local_8;
    out_.Store(_e87*4, asuint(uint(_e82)));
    const uint _e92 = _naga_trigonometry(asuint(0.0), 1u);
    local_9 = uint(int(9));
    uint _e98 = local_9;
    out_.Store(_e98*4, asuint(asuint(asfloat(_e92))));
    const float _e102 = sinf_1(2.0, 3.0);
    local_10 = uint(int(10));
    uint _e107 = local_10;
    out_.Store(_e107*4, asuint(asuint(_e102)));
    const float _e112 = cosf_1(float2(2.0, 3.0));
    local_11 = uint(int(11));
    uint _e117 = local_11;
    out_.Store(_e117*4, asuint(asuint(_e112)));
    value = 0.0;
    float _e121 = value;
    value = (_e121 + float(int(1)));
    const uint _e127 = _naga_trigonometry(asuint(_e121), 0u);
    local_12 = uint(int(12));
    uint _e133 = local_12;
    out_.Store(_e133*4, asuint(asuint(asfloat(_e127))));
    float _e135 = value;
    local_13 = uint(int(13));
    uint _e140 = local_13;
    out_.Store(_e140*4, asuint(asuint(_e135)));
    value = -(1.0);
    float _e144 = value;
    value = (_e144 + float(int(1)));
    float _e148 = value;
    const uint _e151 = _naga_trigonometry(asuint(_e148), 1u);
    local_14 = uint(int(14));
    uint _e157 = local_14;
    out_.Store(_e157*4, asuint(asuint(asfloat(_e151))));
    float _e159 = value;
    local_15 = uint(int(15));
    uint _e164 = local_15;
    out_.Store(_e164*4, asuint(asuint(_e159)));
    float _e166 = value;
    value = (_e166 + float(int(1)));
    const float _e170 = identity(_e166);
    const uint _e173 = _naga_trigonometry(asuint(_e170), 0u);
    float _e175 = value;
    value = (_e175 + float(int(1)));
    const float _e179 = pair(asfloat(_e173), _e175);
    local_16 = uint(int(16));
    uint _e184 = local_16;
    out_.Store(_e184*4, asuint(asuint(_e179)));
    float _e186 = value;
    local_17 = uint(int(17));
    uint _e191 = local_17;
    out_.Store(_e191*4, asuint(asuint(_e186)));
    choose = false;
    counter = int(0);
    bool _e197 = choose;
    local_19 = _e197;
    if (_e197) {
        int _e199 = counter;
        counter = asint(asuint(_e199) + asuint(int(1)));
        const uint _e205 = _naga_trigonometry(asuint(float(_e199)), 0u);
        local_19 = (asfloat(_e205) != 0.0);
    }
    bool _e209 = local_19;
    local_18 = uint(int(18));
    uint _e214 = local_18;
    out_.Store(_e214*4, asuint(uint(_e209)));
    local_21 = true;
    if (true) {
    } else {
        int _e218 = counter;
        counter = asint(asuint(_e218) + asuint(int(1)));
        const uint _e224 = _naga_trigonometry(asuint(float(_e218)), 1u);
        local_21 = (asfloat(_e224) != 0.0);
    }
    bool _e228 = local_21;
    local_20 = uint(int(19));
    uint _e233 = local_20;
    out_.Store(_e233*4, asuint(uint(_e228)));
    bool _e235 = choose;
    if (_e235) {
        int _e236 = counter;
        counter = asint(asuint(_e236) + asuint(int(1)));
        int _e239 = counter;
        const uint _e243 = _naga_trigonometry(asuint(float(_e239)), 0u);
        local_23 = asfloat(_e243);
    } else {
        int _e246 = counter;
        const uint _e250 = _naga_trigonometry(asuint(float(_e246)), 1u);
        local_23 = asfloat(_e250);
    }
    float _e254 = local_23;
    local_22 = uint(int(20));
    uint _e259 = local_22;
    out_.Store(_e259*4, asuint(naga_f2u32(_e254)));
    int _e261 = counter;
    local_24 = uint(int(21));
    uint _e266 = local_24;
    out_.Store(_e266*4, asuint(uint(_e261)));
    const uint _e273 = _naga_trigonometry(asuint(0.0), 0u);
    values[0] = asfloat(_e273);
    const uint _e279 = _naga_trigonometry(asuint(0.0), 1u);
    values[1] = asfloat(_e279);
    float _e285 = values[int(0)];
    float _e286 = values[int(1)];
    local_25 = uint(int(22));
    uint _e292 = local_25;
    out_.Store(_e292*4, asuint(asuint((_e285 + _e286))));
    Count = int(2);
    scratch = ZeroValuearray2_float_();
    float _e300 = scratch[int(1)];
    local_26 = uint(int(23));
    uint _e305 = local_26;
    out_.Store(_e305*4, asuint(asuint(_e300)));
    repeated = int(0);
    {
        index = int(0);
        uint2 loop_bound_12 = uint2(4294967295u, 4294967295u);
        bool loop_init_12 = true;
        while(true) {
            if (all(loop_bound_12 == uint2(0u, 0u))) { break; }
            loop_bound_12 -= uint2(loop_bound_12.y == 0u, 1u);
            if (!loop_init_12) {
                int _e325 = index;
                index = asint(asuint(_e325) + asuint(int(1)));
            }
            loop_init_12 = false;
            int _e311 = index;
            if ((_e311 < int(3))) {
            } else {
                break;
            }
            int _e314 = index;
            if ((_e314 == int(0))) {
                continue;
            }
            const uint _e320 = _naga_trigonometry(asuint(0.0), 1u);
            int _e323 = repeated;
            repeated = asint(asuint(_e323) + asuint(naga_f2i32(asfloat(_e320))));
        }
    }
    int _e328 = repeated;
    local_27 = uint(int(24));
    uint _e333 = local_27;
    out_.Store(_e333*4, asuint(uint(_e328)));
    value = 0.0;
    float _e336 = value;
    value = (_e336 + float(int(1)));
    const uint _e342 = _naga_trigonometry(asuint(_e336), 0u);
    float _e343 = value;
    value = (_e343 - float(int(1)));
    float _e347 = value;
    const uint _e350 = _naga_trigonometry(asuint(_e347), 1u);
    local_28 = uint(int(25));
    uint _e356 = local_28;
    out_.Store(_e356*4, asuint(asuint(asfloat(_e350))));
    float _e358 = value;
    local_29 = uint(int(26));
    uint _e363 = local_29;
    out_.Store(_e363*4, asuint(asuint(_e358)));
    if (true) {
        const uint _e369 = _naga_trigonometry(asuint(0.0), 1u);
        local_31 = asfloat(_e369);
    } else {
        const uint _e375 = _naga_trigonometry(asuint(99.0), 0u);
        local_31 = asfloat(_e375);
    }
    float _e379 = local_31;
    local_30 = uint(int(27));
    uint _e384 = local_30;
    out_.Store(_e384*4, asuint(naga_f2u32(_e379)));
    const float _e388 = cosine_value(float(false));
    local_32 = uint(int(28));
    uint _e393 = local_32;
    out_.Store(_e393*4, asuint(asuint(_e388)));
}
