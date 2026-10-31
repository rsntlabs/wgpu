struct Packet_cuda_record_0_ {
    int key;
    int values[2];
};

RWByteAddressBuffer out_1 : register(u0);
static uint3 blockIdx_1 = (uint3)0;
static uint3 threadIdx_1 = (uint3)0;

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int route(float value)
{
    return asint(asuint(int(10)) + asuint(naga_f2i32(value)));
}

int earlier(int value_1)
{
    const int _e2 = route(float(value_1));
    return _e2;
}

int route_1(int value_2)
{
    return asint(asuint(int(20)) + asuint(value_2));
}

int forward(int value_3)
{
    const int _e1 = route_1(value_3);
    const int _e2 = earlier(value_3);
    return asint(asuint(_e1) + asuint(_e2));
}

Packet_cuda_record_0_ packet(int value_4)
{
    Packet_cuda_record_0_ local_80 = (Packet_cuda_record_0_)0;

    local_80.key = value_4;
    local_80.values[0] = asint(asuint(value_4) + asuint(int(1)));
    local_80.values[1] = asint(asuint(value_4) + asuint(int(2)));
    Packet_cuda_record_0_ _e10 = local_80;
    const Packet_cuda_record_0_ packet_cuda_record_0_ = _e10;
    return packet_cuda_record_0_;
}

Packet_cuda_record_0_ adjust(Packet_cuda_record_0_ value_5)
{
    Packet_cuda_record_0_ value_6 = (Packet_cuda_record_0_)0;

    value_6 = value_5;
    int _e4 = value_6.key;
    value_6.key = asint(asuint(_e4) + asuint(int(4)));
    int _e10 = value_6.values[int(1)];
    value_6.values[int(1)] = asint(asuint(_e10) + asuint(int(6)));
    Packet_cuda_record_0_ _e12 = value_6;
    const Packet_cuda_record_0_ packet_cuda_record_0_1 = _e12;
    return packet_cuda_record_0_1;
}

Packet_cuda_record_0_ operator_u002b(Packet_cuda_record_0_ left, Packet_cuda_record_0_ right)
{
    Packet_cuda_record_0_ left_1 = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ right_1 = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ local_81 = (Packet_cuda_record_0_)0;

    left_1 = left;
    right_1 = right;
    int _e7 = left_1.key;
    int _e8 = right_1.key;
    local_81.key = asint(asuint(_e7) + asuint(_e8));
    int _e18 = left_1.values[int(0)];
    int _e19 = right_1.values[int(0)];
    local_81.values[0] = asint(asuint(_e18) + asuint(_e19));
    int _e29 = left_1.values[int(1)];
    int _e30 = right_1.values[int(1)];
    local_81.values[1] = asint(asuint(_e29) + asuint(_e30));
    Packet_cuda_record_0_ _e32 = local_81;
    const Packet_cuda_record_0_ packet_cuda_record_0_2 = _e32;
    return packet_cuda_record_0_2;
}

int pair(int first_1, int second_1)
{
    return asint(asuint(asint(asuint(first_1) * asuint(int(10)))) + asuint(second_1));
}

void consume(int value_7)
{
    if ((value_7 != int(0))) {
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
ret_naga_trig_divide _naga_trig_divide(uint value_8[12], uint divisor)
{
    uint source_1[12] = ZeroValuearray12_uint_();
    uint result_2[12] = ZeroValuearray12_uint_();
    uint remainder_1 = ZeroValueuint();
    uint step_ = ZeroValueuint();

    source_1 = value_8;
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

float generated(float value_9)
{
    const uint _e3 = _naga_sqrtf(asuint(4.0));
    const uint _e7 = _naga_trigonometry(asuint(value_9), 0u);
    const uint _e12 = _naga_trigonometry(asuint(value_9), 1u);
    return ((asfloat(_e3) + asfloat(_e7)) + asfloat(_e12));
}

int control(int count)
{
    int result_4 = (int)0;
    int index = (int)0;

    result_4 = int(0);
    {
        index = int(0);
        uint2 loop_bound_13 = uint2(4294967295u, 4294967295u);
        bool loop_init_13 = true;
        while(true) {
            if (all(loop_bound_13 == uint2(0u, 0u))) { break; }
            loop_bound_13 -= uint2(loop_bound_13.y == 0u, 1u);
            if (!loop_init_13) {
                int _e22 = index;
                index = asint(asuint(_e22) + asuint(int(1)));
            }
            loop_init_13 = false;
            int _e5 = index;
            if ((_e5 < count)) {
            } else {
                break;
            }
            int _e7 = index;
            if ((_e7 == int(1))) {
                continue;
            }
            int _e10 = index;
            bool should_continue = false;
            switch(_e10) {
                case 0: {
                    int _e11 = index;
                    const int _e12 = route_1(_e11);
                    int _e13 = result_4;
                    result_4 = asint(asuint(_e13) + asuint(_e12));
                    break;
                }
                default: {
                    int _e15 = index;
                    const int _e16 = forward(_e15);
                    int _e17 = index;
                    const int _e18 = earlier(_e17);
                    int _e20 = result_4;
                    result_4 = asint(asuint(_e20) + asuint(asint(asuint(_e16) - asuint(_e18))));
                    break;
                }
            }
        }
    }
    int _e25 = result_4;
    return _e25;
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
    uint out_[2] = (uint[2])0;
    int counter = (int)0;
    Packet_cuda_record_0_ first = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ second = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ total = (Packet_cuda_record_0_)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    uint local_28[2] = (uint[2])0;
    uint local_29 = (uint)0;
    uint local_30[2] = (uint[2])0;
    uint local_31 = (uint)0;
    uint local_32[2] = (uint[2])0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35[2] = (uint[2])0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38[2] = (uint[2])0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41[2] = (uint[2])0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44[2] = (uint[2])0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47[2] = (uint[2])0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50[2] = (uint[2])0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53[2] = (uint[2])0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56[2] = (uint[2])0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59[2] = (uint[2])0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62[2] = (uint[2])0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65[2] = (uint[2])0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68[2] = (uint[2])0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71[2] = (uint[2])0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    uint local_74[2] = (uint[2])0;
    uint local_75 = (uint)0;
    uint local_76 = (uint)0;
    uint local_77[2] = (uint[2])0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;

    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    const uint _e10 = late_index();
    uint base = (_e10 * 16u);
    counter = int(1);
    int _e15 = counter;
    counter = asint(asuint(_e15) + asuint(int(1)));
    const Packet_cuda_record_0_ _e18 = packet(_e15);
    first = _e18;
    Packet_cuda_record_0_ _e20 = first;
    const Packet_cuda_record_0_ _e21 = adjust(_e20);
    second = _e21;
    Packet_cuda_record_0_ _e23 = first;
    Packet_cuda_record_0_ _e24 = second;
    const Packet_cuda_record_0_ _e25 = operator_u002b(_e23, _e24);
    total = _e25;
    const int _e28 = earlier(int(3));
    uint _e30[2] = out_;
    local = _e30;
    local_1 = uint(base);
    uint _e35[2] = local;
    local_32 = _e35;
    uint _e37 = local_1;
    uint _e39 = local_32[1];
    local_32[1] = (_e39 + _e37);
    uint _e43 = local_32[0];
    local_33 = uint(_e43);
    uint _e47 = local_32[1];
    local_34 = uint(_e47);
    uint _e50 = local_34;
    out_1.Store(_e50*4, asuint(uint(_e28)));
    const int _e54 = route_1(int(3));
    uint _e55[2] = out_;
    local_2 = _e55;
    local_3 = uint((base + uint(int(1))));
    uint _e63[2] = local_2;
    local_35 = _e63;
    uint _e65 = local_3;
    uint _e67 = local_35[1];
    local_35[1] = (_e67 + _e65);
    uint _e71 = local_35[0];
    local_36 = uint(_e71);
    uint _e75 = local_35[1];
    local_37 = uint(_e75);
    uint _e78 = local_37;
    out_1.Store(_e78*4, asuint(uint(_e54)));
    const int _e81 = forward(int(4));
    uint _e82[2] = out_;
    local_4 = _e82;
    local_5 = uint((base + uint(int(2))));
    uint _e90[2] = local_4;
    local_38 = _e90;
    uint _e92 = local_5;
    uint _e94 = local_38[1];
    local_38[1] = (_e94 + _e92);
    uint _e98 = local_38[0];
    local_39 = uint(_e98);
    uint _e102 = local_38[1];
    local_40 = uint(_e102);
    uint _e105 = local_40;
    out_1.Store(_e105*4, asuint(uint(_e81)));
    int _e108 = first.key;
    uint _e109[2] = out_;
    local_6 = _e109;
    local_7 = uint((base + uint(int(3))));
    uint _e117[2] = local_6;
    local_41 = _e117;
    uint _e119 = local_7;
    uint _e121 = local_41[1];
    local_41[1] = (_e121 + _e119);
    uint _e125 = local_41[0];
    local_42 = uint(_e125);
    uint _e129 = local_41[1];
    local_43 = uint(_e129);
    uint _e132 = local_43;
    out_1.Store(_e132*4, asuint(uint(_e108)));
    int _e137 = first.values[int(1)];
    uint _e138[2] = out_;
    local_8 = _e138;
    local_9 = uint((base + uint(int(4))));
    uint _e146[2] = local_8;
    local_44 = _e146;
    uint _e148 = local_9;
    uint _e150 = local_44[1];
    local_44[1] = (_e150 + _e148);
    uint _e154 = local_44[0];
    local_45 = uint(_e154);
    uint _e158 = local_44[1];
    local_46 = uint(_e158);
    uint _e161 = local_46;
    out_1.Store(_e161*4, asuint(uint(_e137)));
    int _e164 = second.key;
    uint _e165[2] = out_;
    local_10 = _e165;
    local_11 = uint((base + uint(int(5))));
    uint _e173[2] = local_10;
    local_47 = _e173;
    uint _e175 = local_11;
    uint _e177 = local_47[1];
    local_47[1] = (_e177 + _e175);
    uint _e181 = local_47[0];
    local_48 = uint(_e181);
    uint _e185 = local_47[1];
    local_49 = uint(_e185);
    uint _e188 = local_49;
    out_1.Store(_e188*4, asuint(uint(_e164)));
    int _e193 = second.values[int(1)];
    uint _e194[2] = out_;
    local_12 = _e194;
    local_13 = uint((base + uint(int(6))));
    uint _e202[2] = local_12;
    local_50 = _e202;
    uint _e204 = local_13;
    uint _e206 = local_50[1];
    local_50[1] = (_e206 + _e204);
    uint _e210 = local_50[0];
    local_51 = uint(_e210);
    uint _e214 = local_50[1];
    local_52 = uint(_e214);
    uint _e217 = local_52;
    out_1.Store(_e217*4, asuint(uint(_e193)));
    int _e220 = total.key;
    uint _e221[2] = out_;
    local_14 = _e221;
    local_15 = uint((base + uint(int(7))));
    uint _e229[2] = local_14;
    local_53 = _e229;
    uint _e231 = local_15;
    uint _e233 = local_53[1];
    local_53[1] = (_e233 + _e231);
    uint _e237 = local_53[0];
    local_54 = uint(_e237);
    uint _e241 = local_53[1];
    local_55 = uint(_e241);
    uint _e244 = local_55;
    out_1.Store(_e244*4, asuint(uint(_e220)));
    int _e249 = total.values[int(0)];
    uint _e250[2] = out_;
    local_16 = _e250;
    local_17 = uint((base + uint(int(8))));
    uint _e258[2] = local_16;
    local_56 = _e258;
    uint _e260 = local_17;
    uint _e262 = local_56[1];
    local_56[1] = (_e262 + _e260);
    uint _e266 = local_56[0];
    local_57 = uint(_e266);
    uint _e270 = local_56[1];
    local_58 = uint(_e270);
    uint _e273 = local_58;
    out_1.Store(_e273*4, asuint(uint(_e249)));
    int _e278 = total.values[int(1)];
    uint _e279[2] = out_;
    local_18 = _e279;
    local_19 = uint((base + uint(int(9))));
    uint _e287[2] = local_18;
    local_59 = _e287;
    uint _e289 = local_19;
    uint _e291 = local_59[1];
    local_59[1] = (_e291 + _e289);
    uint _e295 = local_59[0];
    local_60 = uint(_e295);
    uint _e299 = local_59[1];
    local_61 = uint(_e299);
    uint _e302 = local_61;
    out_1.Store(_e302*4, asuint(uint(_e278)));
    int first_argument = counter;
    counter = asint(asuint(first_argument) + asuint(int(1)));
    int _e307 = counter;
    counter = asint(asuint(_e307) + asuint(int(1)));
    const int _e310 = pair(first_argument, _e307);
    uint _e311[2] = out_;
    local_20 = _e311;
    local_21 = uint((base + uint(int(10))));
    uint _e319[2] = local_20;
    local_62 = _e319;
    uint _e321 = local_21;
    uint _e323 = local_62[1];
    local_62[1] = (_e323 + _e321);
    uint _e327 = local_62[0];
    local_63 = uint(_e327);
    uint _e331 = local_62[1];
    local_64 = uint(_e331);
    uint _e334 = local_64;
    out_1.Store(_e334*4, asuint(uint(_e310)));
    int _e336 = counter;
    counter = asint(asuint(_e336) + asuint(int(1)));
    consume(_e336);
    int _e339 = counter;
    uint _e340[2] = out_;
    local_22 = _e340;
    local_23 = uint((base + uint(int(11))));
    uint _e348[2] = local_22;
    local_65 = _e348;
    uint _e350 = local_23;
    uint _e352 = local_65[1];
    local_65[1] = (_e352 + _e350);
    uint _e356 = local_65[0];
    local_66 = uint(_e356);
    uint _e360 = local_65[1];
    local_67 = uint(_e360);
    uint _e363 = local_67;
    out_1.Store(_e363*4, asuint(uint(_e339)));
    const float _e366 = generated(0.0);
    uint _e368[2] = out_;
    local_24 = _e368;
    local_25 = uint((base + uint(int(12))));
    uint _e375[2] = local_24;
    local_68 = _e375;
    uint _e377 = local_25;
    uint _e379 = local_68[1];
    local_68[1] = (_e379 + _e377);
    uint _e383 = local_68[0];
    local_69 = uint(_e383);
    uint _e387 = local_68[1];
    local_70 = uint(_e387);
    uint _e390 = local_70;
    out_1.Store(_e390*4, asuint(asuint(_e366)));
    const int _e393 = control(int(3));
    uint _e394[2] = out_;
    local_26 = _e394;
    local_27 = uint((base + uint(int(13))));
    uint _e402[2] = local_26;
    local_71 = _e402;
    uint _e404 = local_27;
    uint _e406 = local_71[1];
    local_71[1] = (_e406 + _e404);
    uint _e410 = local_71[0];
    local_72 = uint(_e410);
    uint _e414 = local_71[1];
    local_73 = uint(_e414);
    uint _e417 = local_73;
    out_1.Store(_e417*4, asuint(uint(_e393)));
    uint _e419[2] = out_;
    local_28 = _e419;
    local_29 = uint((base + uint(int(14))));
    uint _e426[2] = local_28;
    local_74 = _e426;
    uint _e428 = local_29;
    uint _e430 = local_74[1];
    local_74[1] = (_e430 + _e428);
    uint _e434 = local_74[0];
    local_75 = uint(_e434);
    uint _e438 = local_74[1];
    local_76 = uint(_e438);
    uint _e441 = local_76;
    out_1.Store(_e441*4, asuint(_e10));
    int _e443 = counter;
    counter = asint(asuint(_e443) + asuint(int(1)));
    int _e446 = counter;
    const int _e447 = forward(_e446);
    uint _e448[2] = out_;
    local_30 = _e448;
    local_31 = uint((base + uint(int(15))));
    uint _e456[2] = local_30;
    local_77 = _e456;
    uint _e458 = local_31;
    uint _e460 = local_77[1];
    local_77[1] = (_e460 + _e458);
    uint _e464 = local_77[0];
    local_78 = uint(_e464);
    uint _e468 = local_77[1];
    local_79 = uint(_e468);
    uint _e471 = local_79;
    out_1.Store(_e471*4, asuint(uint(_e447)));
}
