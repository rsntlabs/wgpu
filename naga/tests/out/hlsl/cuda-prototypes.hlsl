struct Packet_cuda_record_0_ {
    int key;
    int values[2];
};

RWByteAddressBuffer out_ : register(u0);
static uint3 blockIdx_1 = (uint3)0;
static uint3 threadIdx_1 = (uint3)0;

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int route(float value)
{
    float value_1 = (float)0;

    value_1 = value;
    float _e3 = value_1;
    return asint(asuint(int(10)) + asuint(naga_f2i32(_e3)));
}

int earlier(int value_2)
{
    int value_3 = (int)0;

    value_3 = value_2;
    int _e2 = value_3;
    const int _e4 = route(float(_e2));
    return _e4;
}

int route_1(int value_4)
{
    int value_5 = (int)0;

    value_5 = value_4;
    int _e3 = value_5;
    return asint(asuint(int(20)) + asuint(_e3));
}

int forward(int value_6)
{
    int value_7 = (int)0;

    value_7 = value_6;
    int _e2 = value_7;
    const int _e3 = route_1(_e2);
    int _e4 = value_7;
    const int _e5 = earlier(_e4);
    return asint(asuint(_e3) + asuint(_e5));
}

Packet_cuda_record_0_ packet(int value_8)
{
    int value_9 = (int)0;
    Packet_cuda_record_0_ local_65 = (Packet_cuda_record_0_)0;

    value_9 = value_8;
    int _e3 = value_9;
    local_65.key = _e3;
    int _e7 = value_9;
    local_65.values[0] = asint(asuint(_e7) + asuint(int(1)));
    int _e12 = value_9;
    local_65.values[1] = asint(asuint(_e12) + asuint(int(2)));
    Packet_cuda_record_0_ _e14 = local_65;
    const Packet_cuda_record_0_ packet_cuda_record_0_ = _e14;
    return packet_cuda_record_0_;
}

Packet_cuda_record_0_ adjust(Packet_cuda_record_0_ value_10)
{
    Packet_cuda_record_0_ value_11 = (Packet_cuda_record_0_)0;

    value_11 = value_10;
    int _e4 = value_11.key;
    value_11.key = asint(asuint(_e4) + asuint(int(4)));
    int _e10 = value_11.values[int(1)];
    value_11.values[int(1)] = asint(asuint(_e10) + asuint(int(6)));
    Packet_cuda_record_0_ _e12 = value_11;
    const Packet_cuda_record_0_ packet_cuda_record_0_1 = _e12;
    return packet_cuda_record_0_1;
}

Packet_cuda_record_0_ operator_u002b(Packet_cuda_record_0_ left, Packet_cuda_record_0_ right)
{
    Packet_cuda_record_0_ left_1 = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ right_1 = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ local_66 = (Packet_cuda_record_0_)0;

    left_1 = left;
    right_1 = right;
    int _e7 = left_1.key;
    int _e8 = right_1.key;
    local_66.key = asint(asuint(_e7) + asuint(_e8));
    int _e18 = left_1.values[int(0)];
    int _e19 = right_1.values[int(0)];
    local_66.values[0] = asint(asuint(_e18) + asuint(_e19));
    int _e29 = left_1.values[int(1)];
    int _e30 = right_1.values[int(1)];
    local_66.values[1] = asint(asuint(_e29) + asuint(_e30));
    Packet_cuda_record_0_ _e32 = local_66;
    const Packet_cuda_record_0_ packet_cuda_record_0_2 = _e32;
    return packet_cuda_record_0_2;
}

int pair(int first_1, int second_1)
{
    int first_2 = (int)0;
    int second_2 = (int)0;

    first_2 = first_1;
    second_2 = second_1;
    int _e5 = first_2;
    int _e7 = second_2;
    return asint(asuint(asint(asuint(_e5) * asuint(int(10)))) + asuint(_e7));
}

void consume(int value_12)
{
    int value_13 = (int)0;

    value_13 = value_12;
    int _e2 = value_13;
    if ((_e2 != int(0))) {
        return;
    } else {
        return;
    }
}

uint _naga_sqrtf(uint input_bits)
{
    uint significand = (uint)0;
    uint adjusted_exponent = (uint)0;
    uint upper_word = (uint)0;
    uint lower_word = (uint)0;
    uint root = (uint)0;
    uint remainder = (uint)0;
    uint iteration = (uint)0;

    uint _e5 = (input_bits & 2147483647u);
    if (((_e5 == 0u) || (input_bits == 2139095040u))) {
        return input_bits;
    }
    if ((((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u))) {
        return 2143289344u;
    }
    uint _e19 = (input_bits & 8388607u);
    uint _e20 = (_e5 >> 23u);
    significand = (_e19 | 8388608u);
    adjusted_exponent = (_e20 + 127u);
    if ((_e20 == 0u)) {
        uint _e28 = ((31u - firstbithigh(_e19)) - 8u);
        significand = (_e19 << _e28);
        adjusted_exponent = (128u - _e28);
    }
    uint _e32 = significand;
    uint _e33 = adjusted_exponent;
    uint _e34 = (_e33 & 1u);
    upper_word = (_e32 >> (9u - _e34));
    lower_word = (_e32 << (23u + _e34));
    root = 0u;
    remainder = 0u;
    iteration = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e72 = iteration;
            iteration = (_e72 + 1u);
        }
        loop_init = false;
        uint _e50 = iteration;
        if ((_e50 >= 24u)) {
            break;
        }
        uint _e52 = upper_word;
        uint _e53 = lower_word;
        uint _e54 = root;
        uint _e55 = remainder;
        uint _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        uint _e65 = ((_e54 << 2u) | 1u);
        bool _e66 = (_e63 >= _e65);
        uint _e69 = (_e54 << 1u);
        upper_word = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word = (_e53 << 2u);
        remainder = (_e66 ? (_e63 - _e65) : _e63);
        root = (_e66 ? (_e69 | 1u) : _e69);
    }
    uint _e74 = root;
    uint _e75 = remainder;
    return (((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u));
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

uint ZeroValueuint() {
    return (uint)0;
}

typedef uint ret_naga_trig_reduce_multiply[22];
ret_naga_trig_reduce_multiply _naga_trig_reduce_multiply(uint left_2[2], uint right_2[20])
{
    uint left_digits[2] = ZeroValuearray2_uint_();
    uint right_digits[20] = ZeroValuearray20_uint_();
    uint product[22] = ZeroValuearray22_uint_();
    uint carry = ZeroValueuint();
    uint left_index = ZeroValueuint();
    uint right_index = ZeroValueuint();
    uint result[22] = ZeroValuearray22_uint_();
    uint result_index = ZeroValueuint();

    left_digits = left_2;
    right_digits = right_2;
    left_index = 0u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e46 = left_index;
            left_index = (_e46 + 1u);
        }
        loop_init_1 = false;
        uint _e13 = left_index;
        if ((_e13 >= 2u)) {
            break;
        }
        carry = 0u;
        uint _e18 = left_digits[min(uint(_e13), 1u)];
        right_index = 0u;
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e39 = right_index;
                right_index = (_e39 + 1u);
            }
            loop_init_2 = false;
            uint _e22 = right_index;
            if ((_e22 >= 20u)) {
                break;
            }
            uint _e26 = right_digits[min(uint(_e22), 19u)];
            uint _e27 = (_e13 + _e22);
            uint _e29 = product[min(uint(_e27), 21u)];
            uint _e30 = carry;
            uint _e33 = (((_e18 * _e26) + _e29) + _e30);
            product[min(uint(_e27), 21u)] = (_e33 & 65535u);
            carry = (_e33 >> 16u);
        }
        uint _e44 = carry;
        product[min(uint((_e13 + 20u)), 21u)] = _e44;
    }
    result_index = 0u;
    uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e62 = result_index;
            result_index = (_e62 + 1u);
        }
        loop_init_3 = false;
        uint _e54 = result_index;
        if ((_e54 >= 22u)) {
            break;
        }
        uint _e60 = product[min(uint((_e54 + 0u)), 21u)];
        result[min(uint(_e54), 21u)] = _e60;
    }
    uint _e65[22] = result;
    return _e65;
}

uint naga_div(uint lhs, uint rhs) {
    return lhs / (rhs == 0u ? 1u : rhs);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

uint _naga_trig_extract_product(uint digits[22], uint offset)
{
    uint source[22] = ZeroValuearray22_uint_();
    uint low = ZeroValueuint();
    uint high = ZeroValueuint();

    source = digits;
    uint _e5 = naga_div(offset, 16u);
    uint _e7 = naga_mod(offset, 16u);
    uint _e13 = (_e5 + 0u);
    if ((_e13 < 22u)) {
        uint _e17 = source[min(uint(_e13), 21u)];
        low = _e17;
    }
    uint _e19 = (_e5 + 1u);
    if ((_e19 < 22u)) {
        uint _e23 = source[min(uint(_e19), 21u)];
        high = _e23;
    }
    uint _e24 = low;
    uint _e25 = high;
    return (((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u);
}

typedef uint ret_ZeroValuearray12_uint_[12];
ret_ZeroValuearray12_uint_ ZeroValuearray12_uint_() {
    return (uint[12])0;
}

typedef uint ret_ZeroValuearray24_uint_[24];
ret_ZeroValuearray24_uint_ ZeroValuearray24_uint_() {
    return (uint[24])0;
}

typedef uint ret_naga_trig_multiply[12];
ret_naga_trig_multiply _naga_trig_multiply(uint left_3[12], uint right_3[12])
{
    uint left_digits_1[12] = ZeroValuearray12_uint_();
    uint right_digits_1[12] = ZeroValuearray12_uint_();
    uint product_1[24] = ZeroValuearray24_uint_();
    uint carry_1 = ZeroValueuint();
    uint left_index_1 = ZeroValueuint();
    uint right_index_1 = ZeroValueuint();
    uint result_1[12] = ZeroValuearray12_uint_();
    uint result_index_1 = ZeroValueuint();

    left_digits_1 = left_3;
    right_digits_1 = right_3;
    left_index_1 = 0u;
    uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e46 = left_index_1;
            left_index_1 = (_e46 + 1u);
        }
        loop_init_4 = false;
        uint _e13 = left_index_1;
        if ((_e13 >= 12u)) {
            break;
        }
        carry_1 = 0u;
        uint _e18 = left_digits_1[min(uint(_e13), 11u)];
        right_index_1 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u, 4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (all(loop_bound_5 == uint2(0u, 0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e39 = right_index_1;
                right_index_1 = (_e39 + 1u);
            }
            loop_init_5 = false;
            uint _e22 = right_index_1;
            if ((_e22 >= 12u)) {
                break;
            }
            uint _e26 = right_digits_1[min(uint(_e22), 11u)];
            uint _e27 = (_e13 + _e22);
            uint _e29 = product_1[min(uint(_e27), 23u)];
            uint _e30 = carry_1;
            uint _e33 = (((_e18 * _e26) + _e29) + _e30);
            product_1[min(uint(_e27), 23u)] = (_e33 & 65535u);
            carry_1 = (_e33 >> 16u);
        }
        uint _e44 = carry_1;
        product_1[min(uint((_e13 + 12u)), 23u)] = _e44;
    }
    result_index_1 = 0u;
    uint2 loop_bound_6 = uint2(4294967295u, 4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (all(loop_bound_6 == uint2(0u, 0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e62 = result_index_1;
            result_index_1 = (_e62 + 1u);
        }
        loop_init_6 = false;
        uint _e54 = result_index_1;
        if ((_e54 >= 12u)) {
            break;
        }
        uint _e60 = product_1[min(uint((_e54 + 11u)), 23u)];
        result_1[min(uint(_e54), 11u)] = _e60;
    }
    uint _e65[12] = result_1;
    return _e65;
}

typedef uint ret_naga_trig_divide[12];
ret_naga_trig_divide _naga_trig_divide(uint value_14[12], uint divisor)
{
    uint source_1[12] = ZeroValuearray12_uint_();
    uint result_2[12] = ZeroValuearray12_uint_();
    uint remainder_1 = ZeroValueuint();
    uint step_ = ZeroValueuint();

    source_1 = value_14;
    step_ = 0u;
    uint2 loop_bound_7 = uint2(4294967295u, 4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (all(loop_bound_7 == uint2(0u, 0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e25 = step_;
            step_ = (_e25 + 1u);
        }
        loop_init_7 = false;
        uint _e11 = step_;
        if ((_e11 >= 12u)) {
            break;
        }
        uint _e15 = (11u - _e11);
        uint _e16 = remainder_1;
        uint _e20 = source_1[min(uint(_e15), 11u)];
        uint _e21 = ((_e16 << 16u) | _e20);
        result_2[min(uint(_e15), 11u)] = naga_div(_e21, divisor);
        remainder_1 = naga_mod(_e21, divisor);
    }
    uint _e28[12] = result_2;
    return _e28;
}

typedef uint ret_naga_trig_combine[12];
ret_naga_trig_combine _naga_trig_combine(uint left_4[12], uint right_4[12], uint subtract)
{
    uint left_digits_2[12] = ZeroValuearray12_uint_();
    uint right_digits_2[12] = ZeroValuearray12_uint_();
    uint result_3[12] = ZeroValuearray12_uint_();
    uint carry_2 = ZeroValueuint();
    uint digit_index = ZeroValueuint();

    left_digits_2 = left_4;
    right_digits_2 = right_4;
    bool _e12 = (subtract != 0u);
    digit_index = 0u;
    uint2 loop_bound_8 = uint2(4294967295u, 4294967295u);
    bool loop_init_8 = true;
    while(true) {
        if (all(loop_bound_8 == uint2(0u, 0u))) { break; }
        loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
        if (!loop_init_8) {
            uint _e38 = digit_index;
            digit_index = (_e38 + 1u);
        }
        loop_init_8 = false;
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

typedef uint ret_Constructarray12_uint_[12];
ret_Constructarray12_uint_ Constructarray12_uint_(uint arg0, uint arg1, uint arg2, uint arg3, uint arg4, uint arg5, uint arg6, uint arg7, uint arg8, uint arg9, uint arg10, uint arg11) {
    uint ret[12] = { arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 };
    return ret;
}

typedef uint ret_naga_trig_kernel[12];
ret_naga_trig_kernel _naga_trig_kernel(uint angle[12], uint sine)
{
    uint term[12] = ZeroValuearray12_uint_();
    uint total_1[12] = ZeroValuearray12_uint_();
    uint step_1 = ZeroValueuint();

    bool _e7 = (sine != 0u);
    if (_e7) {
        term = angle;
    } else {
        term = Constructarray12_uint_(0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u);
    }
    uint _e21[12] = term;
    total_1 = _e21;
    const uint _e22[12] = _naga_trig_multiply(angle, angle);
    step_1 = 0u;
    uint2 loop_bound_9 = uint2(4294967295u, 4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (all(loop_bound_9 == uint2(0u, 0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e46 = step_1;
            step_1 = (_e46 + 1u);
        }
        loop_init_9 = false;
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
        uint _e42[12] = total_1;
        const uint _e45[12] = _naga_trig_combine(_e42, _e41, (_e30 & 1u));
        total_1 = _e45;
    }
    uint _e49[12] = total_1;
    return _e49;
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
    uint2 loop_bound_10 = uint2(4294967295u, 4294967295u);
    bool loop_init_10 = true;
    while(true) {
        if (all(loop_bound_10 == uint2(0u, 0u))) { break; }
        loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
        if (!loop_init_10) {
            uint _e25 = digit_index_1;
            digit_index_1 = (_e25 + 1u);
        }
        loop_init_10 = false;
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
    uint2 loop_bound_11 = uint2(4294967295u, 4294967295u);
    bool loop_init_11 = true;
    while(true) {
        if (all(loop_bound_11 == uint2(0u, 0u))) { break; }
        loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
        if (!loop_init_11) {
            uint _e80 = sticky_index;
            sticky_index = (_e80 + 1u);
        }
        loop_init_11 = false;
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

uint _naga_trigonometry(uint input_bits_1, uint cosine)
{
    uint quadrant = ZeroValueuint();
    uint fraction[12] = ZeroValuearray12_uint_();
    uint fraction_index = ZeroValueuint();

    uint _e3 = (input_bits_1 & 2147483647u);
    if ((_e3 >= 2139095040u)) {
        return 2143289344u;
    }
    bool _e8 = (cosine != 0u);
    if ((_e3 <= 956301312u)) {
        return (_e8 ? 1065353216u : input_bits_1);
    }
    uint _e16 = (470u - (_e3 >> 23u));
    uint _e20 = ((_e3 & 8388607u) | 8388608u);
    const uint _e47[22] = _naga_trig_reduce_multiply(Constructarray2_uint_((_e20 & 65535u), (_e20 >> 16u)), Constructarray20_uint_(53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    const uint _e50 = _naga_trig_extract_product(_e47, _e16);
    quadrant = (_e50 & 3u);
    fraction_index = 0u;
    uint2 loop_bound_12 = uint2(4294967295u, 4294967295u);
    bool loop_init_12 = true;
    while(true) {
        if (all(loop_bound_12 == uint2(0u, 0u))) { break; }
        loop_bound_12 -= uint2(loop_bound_12.y == 0u, 1u);
        if (!loop_init_12) {
            uint _e68 = fraction_index;
            fraction_index = (_e68 + 1u);
        }
        loop_init_12 = false;
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
    return (_e120 | ((((_e75 && _e115) ? 2147483648u : 0u) ^ (((_e8 ? (_e112 + 1u) : _e112) & 2u) << 30u)) ^ (_e8 ? 0u : (input_bits_1 & 2147483648u))));
}

float generated(float value_15)
{
    float value_16 = (float)0;

    value_16 = value_15;
    const uint _e4 = _naga_sqrtf(asuint(4.0));
    float _e6 = value_16;
    const uint _e9 = _naga_trigonometry(asuint(_e6), 0u);
    float _e12 = value_16;
    const uint _e15 = _naga_trigonometry(asuint(_e12), 1u);
    return ((asfloat(_e4) + asfloat(_e9)) + asfloat(_e15));
}

int control(int count)
{
    int count_1 = (int)0;
    int result_4 = (int)0;
    int index = (int)0;

    count_1 = count;
    result_4 = int(0);
    {
        index = int(0);
        uint2 loop_bound_13 = uint2(4294967295u, 4294967295u);
        bool loop_init_13 = true;
        while(true) {
            if (all(loop_bound_13 == uint2(0u, 0u))) { break; }
            loop_bound_13 -= uint2(loop_bound_13.y == 0u, 1u);
            if (!loop_init_13) {
                int _e9 = index;
                index = asint(asuint(_e9) + asuint(int(1)));
            }
            loop_init_13 = false;
            int _e6 = index;
            int _e7 = count_1;
            if ((_e6 < _e7)) {
            } else {
                break;
            }
            int _e13 = index;
            if ((_e13 == int(1))) {
                continue;
            }
            int _e15 = index;
            bool should_continue = false;
            switch(_e15) {
                case 0: {
                    int _e16 = index;
                    const int _e17 = route_1(_e16);
                    int _e18 = result_4;
                    result_4 = asint(asuint(_e18) + asuint(_e17));
                    break;
                }
                default: {
                    int _e20 = index;
                    const int _e21 = forward(_e20);
                    int _e22 = index;
                    const int _e23 = earlier(_e22);
                    int _e25 = result_4;
                    result_4 = asint(asuint(_e25) + asuint(asint(asuint(_e21) - asuint(_e23))));
                    break;
                }
            }
        }
    }
    int _e27 = result_4;
    return _e27;
}

uint late_index()
{
    uint3 _e1 = blockIdx_1;
    uint3 _e6 = threadIdx_1;
    return ((_e1.x * 2u) + _e6.x);
}

[numthreads(2, 1, 1)]
void prototypes(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint local = (uint)0;
    uint lane = (uint)0;
    uint base = (uint)0;
    int counter = (int)0;
    Packet_cuda_record_0_ first = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ second = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ total = (Packet_cuda_record_0_)0;
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
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    int first_argument = (int)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;

    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    local = 0u;
    const uint _e6 = late_index();
    lane = _e6;
    uint _e8 = lane;
    base = (_e8 * 16u);
    counter = int(1);
    int _e14 = counter;
    counter = asint(asuint(_e14) + asuint(int(1)));
    const Packet_cuda_record_0_ _e17 = packet(_e14);
    first = _e17;
    Packet_cuda_record_0_ _e19 = first;
    const Packet_cuda_record_0_ _e20 = adjust(_e19);
    second = _e20;
    Packet_cuda_record_0_ _e22 = first;
    Packet_cuda_record_0_ _e23 = second;
    const Packet_cuda_record_0_ _e24 = operator_u002b(_e22, _e23);
    total = _e24;
    const int _e27 = earlier(int(3));
    uint _e28 = local;
    local_1 = _e28;
    uint _e30 = local_1;
    local_2 = uint(_e30);
    uint _e33 = base;
    local_3 = uint(_e33);
    uint _e38 = local_2;
    uint _e39 = local_3;
    local_49 = uint((_e38 + _e39));
    uint _e43 = local_49;
    out_.Store(_e43*4, asuint(uint(_e27)));
    const int _e46 = route_1(int(3));
    uint _e47 = local;
    local_4 = _e47;
    uint _e49 = local_4;
    local_5 = uint(_e49);
    uint _e52 = base;
    local_6 = uint((_e52 + uint(int(1))));
    uint _e59 = local_5;
    uint _e60 = local_6;
    local_50 = uint((_e59 + _e60));
    uint _e64 = local_50;
    out_.Store(_e64*4, asuint(uint(_e46)));
    const int _e67 = forward(int(4));
    uint _e68 = local;
    local_7 = _e68;
    uint _e70 = local_7;
    local_8 = uint(_e70);
    uint _e73 = base;
    local_9 = uint((_e73 + uint(int(2))));
    uint _e80 = local_8;
    uint _e81 = local_9;
    local_51 = uint((_e80 + _e81));
    uint _e85 = local_51;
    out_.Store(_e85*4, asuint(uint(_e67)));
    int _e88 = first.key;
    uint _e89 = local;
    local_10 = _e89;
    uint _e91 = local_10;
    local_11 = uint(_e91);
    uint _e94 = base;
    local_12 = uint((_e94 + uint(int(3))));
    uint _e101 = local_11;
    uint _e102 = local_12;
    local_52 = uint((_e101 + _e102));
    uint _e106 = local_52;
    out_.Store(_e106*4, asuint(uint(_e88)));
    int _e111 = first.values[int(1)];
    uint _e112 = local;
    local_13 = _e112;
    uint _e114 = local_13;
    local_14 = uint(_e114);
    uint _e117 = base;
    local_15 = uint((_e117 + uint(int(4))));
    uint _e124 = local_14;
    uint _e125 = local_15;
    local_53 = uint((_e124 + _e125));
    uint _e129 = local_53;
    out_.Store(_e129*4, asuint(uint(_e111)));
    int _e132 = second.key;
    uint _e133 = local;
    local_16 = _e133;
    uint _e135 = local_16;
    local_17 = uint(_e135);
    uint _e138 = base;
    local_18 = uint((_e138 + uint(int(5))));
    uint _e145 = local_17;
    uint _e146 = local_18;
    local_54 = uint((_e145 + _e146));
    uint _e150 = local_54;
    out_.Store(_e150*4, asuint(uint(_e132)));
    int _e155 = second.values[int(1)];
    uint _e156 = local;
    local_19 = _e156;
    uint _e158 = local_19;
    local_20 = uint(_e158);
    uint _e161 = base;
    local_21 = uint((_e161 + uint(int(6))));
    uint _e168 = local_20;
    uint _e169 = local_21;
    local_55 = uint((_e168 + _e169));
    uint _e173 = local_55;
    out_.Store(_e173*4, asuint(uint(_e155)));
    int _e176 = total.key;
    uint _e177 = local;
    local_22 = _e177;
    uint _e179 = local_22;
    local_23 = uint(_e179);
    uint _e182 = base;
    local_24 = uint((_e182 + uint(int(7))));
    uint _e189 = local_23;
    uint _e190 = local_24;
    local_56 = uint((_e189 + _e190));
    uint _e194 = local_56;
    out_.Store(_e194*4, asuint(uint(_e176)));
    int _e199 = total.values[int(0)];
    uint _e200 = local;
    local_25 = _e200;
    uint _e202 = local_25;
    local_26 = uint(_e202);
    uint _e205 = base;
    local_27 = uint((_e205 + uint(int(8))));
    uint _e212 = local_26;
    uint _e213 = local_27;
    local_57 = uint((_e212 + _e213));
    uint _e217 = local_57;
    out_.Store(_e217*4, asuint(uint(_e199)));
    int _e222 = total.values[int(1)];
    uint _e223 = local;
    local_28 = _e223;
    uint _e225 = local_28;
    local_29 = uint(_e225);
    uint _e228 = base;
    local_30 = uint((_e228 + uint(int(9))));
    uint _e235 = local_29;
    uint _e236 = local_30;
    local_58 = uint((_e235 + _e236));
    uint _e240 = local_58;
    out_.Store(_e240*4, asuint(uint(_e222)));
    int _e242 = counter;
    counter = asint(asuint(_e242) + asuint(int(1)));
    first_argument = _e242;
    int _e246 = first_argument;
    int _e247 = counter;
    counter = asint(asuint(_e247) + asuint(int(1)));
    const int _e250 = pair(_e246, _e247);
    uint _e251 = local;
    local_31 = _e251;
    uint _e253 = local_31;
    local_32 = uint(_e253);
    uint _e256 = base;
    local_33 = uint((_e256 + uint(int(10))));
    uint _e263 = local_32;
    uint _e264 = local_33;
    local_59 = uint((_e263 + _e264));
    uint _e268 = local_59;
    out_.Store(_e268*4, asuint(uint(_e250)));
    int _e270 = counter;
    counter = asint(asuint(_e270) + asuint(int(1)));
    consume(_e270);
    int _e273 = counter;
    uint _e274 = local;
    local_34 = _e274;
    uint _e276 = local_34;
    local_35 = uint(_e276);
    uint _e279 = base;
    local_36 = uint((_e279 + uint(int(11))));
    uint _e286 = local_35;
    uint _e287 = local_36;
    local_60 = uint((_e286 + _e287));
    uint _e291 = local_60;
    out_.Store(_e291*4, asuint(uint(_e273)));
    const float _e294 = generated(0.0);
    uint _e296 = local;
    local_37 = _e296;
    uint _e298 = local_37;
    local_38 = uint(_e298);
    uint _e301 = base;
    local_39 = uint((_e301 + uint(int(12))));
    uint _e307 = local_38;
    uint _e308 = local_39;
    local_61 = uint((_e307 + _e308));
    uint _e312 = local_61;
    out_.Store(_e312*4, asuint(asuint(_e294)));
    const int _e315 = control(int(3));
    uint _e316 = local;
    local_40 = _e316;
    uint _e318 = local_40;
    local_41 = uint(_e318);
    uint _e321 = base;
    local_42 = uint((_e321 + uint(int(13))));
    uint _e328 = local_41;
    uint _e329 = local_42;
    local_62 = uint((_e328 + _e329));
    uint _e333 = local_62;
    out_.Store(_e333*4, asuint(uint(_e315)));
    uint _e335 = lane;
    uint _e336 = local;
    local_43 = _e336;
    uint _e338 = local_43;
    local_44 = uint(_e338);
    uint _e341 = base;
    local_45 = uint((_e341 + uint(int(14))));
    uint _e347 = local_44;
    uint _e348 = local_45;
    local_63 = uint((_e347 + _e348));
    uint _e352 = local_63;
    out_.Store(_e352*4, asuint(_e335));
    int _e354 = counter;
    counter = asint(asuint(_e354) + asuint(int(1)));
    int _e357 = counter;
    const int _e358 = forward(_e357);
    uint _e359 = local;
    local_46 = _e359;
    uint _e361 = local_46;
    local_47 = uint(_e361);
    uint _e364 = base;
    local_48 = uint((_e364 + uint(int(15))));
    uint _e371 = local_47;
    uint _e372 = local_48;
    local_64 = uint((_e371 + _e372));
    uint _e376 = local_64;
    out_.Store(_e376*4, asuint(uint(_e358)));
}
