// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_3[1];
typedef int type_4[1];
constant int Initial_1 = 6;

uint chain_6_6u_6_(
) {
    return static_cast<uint>(6);
}

uint chain_7_7u_7_(
) {
    return static_cast<uint>(7);
}

int merged_8_8_(
) {
    return 8;
}

uint flag_0_false(
) {
    return static_cast<uint>(false);
}

uint flag_1_true(
) {
    return static_cast<uint>(true);
}

uint cross_u002d_1_7u(
) {
    return 7u;
}

uint wide_65535ULL_65535u(
) {
    return 65535u;
}

uint mixed_unsigned_4_4_(
) {
    return static_cast<uint>(4);
}

int mixed_int_9_9_(
) {
    return 9;
}

uint choose_3_3_unsigned(
    uint value
) {
    return value + static_cast<uint>(3);
}

struct dependent_integral_defaultsInput {
};
kernel void dependent_integral_defaults(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_3& output [[buffer(0)]]
, device type_4 const& input [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    int Initial = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    int state = {};
    uint local_11 = {};
    bool local_12 = {};
    int local_13 = {};
    bool local_14 = {};
    int local_15 = {};
    uint local_16 = {};
    int index = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    int old = {};
    int old_1 = {};
    int local_20 = {};
    int local_21 = {};
    int old_2 = {};
    int local_22 = {};
    int local_23 = {};
    int old_3 = {};
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 16u);
    Initial = 99;
    uint _e8 = chain_6_6u_6_();
    output[base] = _e8;
    uint _e11 = chain_6_6u_6_();
    local = static_cast<uint>(base + 1u);
    uint _e16 = local;
    output[_e16] = _e11;
    uint _e18 = chain_6_6u_6_();
    local_1 = static_cast<uint>(base + 2u);
    uint _e23 = local_1;
    output[_e23] = _e18;
    uint _e25 = chain_7_7u_7_();
    local_2 = static_cast<uint>(base + 3u);
    uint _e30 = local_2;
    output[_e30] = _e25;
    int _e32 = merged_8_8_();
    local_3 = static_cast<uint>(base + 4u);
    uint _e38 = local_3;
    output[_e38] = static_cast<uint>(_e32);
    uint _e40 = flag_0_false();
    local_4 = static_cast<uint>(base + 5u);
    uint _e45 = local_4;
    output[_e45] = _e40;
    uint _e47 = flag_1_true();
    local_5 = static_cast<uint>(base + 6u);
    uint _e52 = local_5;
    output[_e52] = _e47;
    uint _e54 = cross_u002d_1_7u();
    local_6 = static_cast<uint>(base + 7u);
    uint _e59 = local_6;
    output[_e59] = _e54;
    uint _e61 = wide_65535ULL_65535u();
    local_7 = static_cast<uint>(base + 8u);
    uint _e66 = local_7;
    output[_e66] = _e61;
    uint _e68 = mixed_unsigned_4_4_();
    local_8 = static_cast<uint>(base + 9u);
    uint _e73 = local_8;
    output[_e73] = _e68;
    int _e75 = mixed_int_9_9_();
    local_9 = static_cast<uint>(base + 10u);
    uint _e81 = local_9;
    output[_e81] = static_cast<uint>(_e75);
    uint _e84 = choose_3_3_unsigned(2u);
    local_10 = static_cast<uint>(base + 11u);
    uint _e89 = local_10;
    output[_e89] = _e84;
    state = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    old = int {};
    int _e97 = state;
    old = _e97;
    int _e99 = state;
    state = as_type<int>(as_type<uint>(_e99) + as_type<uint>(2));
    int _e102 = old;
    local_11 = static_cast<uint>(base + 12u);
    uint _e108 = local_11;
    output[_e108] = static_cast<uint>(_e102);
    local_12 = false;
    if (false) {
        old_1 = int {};
        int _e114 = state;
        local_20 = _e114;
        int _e116 = local_20;
        old_1 = _e116;
        int _e118 = state;
        local_21 = _e118;
        int _e120 = local_21;
        state = as_type<int>(as_type<uint>(_e120) + as_type<uint>(99));
        int _e123 = old_1;
        local_13 = _e123;
        int _e125 = local_13;
        local_12 = _e125 != 0;
    }
    local_14 = true;
    if (true) {
    } else {
        old_2 = int {};
        int _e132 = state;
        local_22 = _e132;
        int _e134 = local_22;
        old_2 = _e134;
        int _e136 = state;
        local_23 = _e136;
        int _e138 = local_23;
        state = as_type<int>(as_type<uint>(_e138) + as_type<uint>(99));
        int _e141 = old_2;
        local_15 = _e141;
        int _e143 = local_15;
        local_14 = _e143 != 0;
    }
    old_3 = int {};
    int _e148 = state;
    old_3 = _e148;
    int _e150 = state;
    state = as_type<int>(as_type<uint>(_e150) + as_type<uint>(3));
    int _e153 = state;
    local_16 = static_cast<uint>(base + 13u);
    uint _e159 = local_16;
    output[_e159] = static_cast<uint>(_e153);
    index = 0;
    int _e163 = index;
    index = as_type<int>(as_type<uint>(_e163) + as_type<uint>(1));
    local_18 = static_cast<uint>(_e163);
    uint _e168 = local_18;
    int _e171 = input[_e168];
    uint _e173 = choose_3_3_unsigned(static_cast<uint>(_e171));
    local_17 = static_cast<uint>(base + 14u);
    uint _e178 = local_17;
    output[_e178] = _e173;
    int _e180 = index;
    local_19 = static_cast<uint>(base + 15u);
    uint _e186 = local_19;
    output[_e186] = static_cast<uint>(_e180);
}
