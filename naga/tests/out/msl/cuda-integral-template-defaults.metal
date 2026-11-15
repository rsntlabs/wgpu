// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size1;
    uint size2;
};

typedef uint type_4[1];
typedef int type_5[1];
constant int N_1 = 4;

int choose(
    int value
) {
    return as_type<int>(as_type<uint>(value) + as_type<uint>(10));
}

int self_named_4_(
) {
    return 4;
}

int inherited_5_(
) {
    return 5;
}

int value_7_(
) {
    return 7;
}

int add_3_int(
    int value_1
) {
    return as_type<int>(as_type<uint>(value_1) + as_type<uint>(3));
}

uint add_7_unsigned(
    uint value_2
) {
    return value_2 + static_cast<uint>(7);
}

uint mixed_unsigned_5_(
) {
    return static_cast<uint>(5);
}

int mixed_int_8_(
) {
    return 8;
}

uint flags_true_4u(
) {
    return static_cast<uint>(true) + 4u;
}

int cast_value_3_(
) {
    return 3;
}

int comma_value_2_(
) {
    return 2;
}

int shifted_4_(
) {
    return 4;
}

int choose_20_unsigned(
    uint value_3
) {
    return as_type<int>(as_type<uint>(static_cast<int>(value_3)) + as_type<uint>(20));
}

int choose_20_int(
    int value_4
) {
    return as_type<int>(as_type<uint>(value_4) + as_type<uint>(20));
}

int skipped_thread_true(
) {
    return static_cast<int>(true);
}

int skipped_grid_false(
) {
    return static_cast<int>(false);
}

int skipped_call_true(
) {
    return static_cast<int>(true);
}

struct integral_template_defaultsInput {
};
kernel void integral_template_defaults(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4& output [[buffer(0)]]
, device type_5 const& input [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    metal::uint3 threadIdx_1 = {};
    int N = {};
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
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    int state = {};
    uint local_15 = {};
    uint local_16 = {};
    bool local_17 = {};
    int local_18 = {};
    bool local_19 = {};
    int local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    int index = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    int old = {};
    int old_1 = {};
    int old_2 = {};
    int local_28 = {};
    int local_29 = {};
    int old_3 = {};
    int local_30 = {};
    int local_31 = {};
    int old_4 = {};
    threadIdx_1 = threadIdx;
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 24u);
    N = 99;
    int _e9 = self_named_4_();
    output[base] = static_cast<uint>(_e9);
    int _e13 = inherited_5_();
    local = static_cast<uint>(base + 1u);
    uint _e19 = local;
    output[_e19] = static_cast<uint>(_e13);
    int _e21 = value_7_();
    local_1 = static_cast<uint>(base + 2u);
    uint _e27 = local_1;
    output[_e27] = static_cast<uint>(_e21);
    int _e29 = value_7_();
    local_2 = static_cast<uint>(base + 3u);
    uint _e35 = local_2;
    output[_e35] = static_cast<uint>(_e29);
    int _e37 = value_7_();
    local_3 = static_cast<uint>(base + 4u);
    uint _e43 = local_3;
    output[_e43] = static_cast<uint>(_e37);
    int _e46 = add_3_int(2);
    local_4 = static_cast<uint>(base + 5u);
    uint _e52 = local_4;
    output[_e52] = static_cast<uint>(_e46);
    uint _e55 = add_7_unsigned(3u);
    local_5 = static_cast<uint>(base + 6u);
    uint _e60 = local_5;
    output[_e60] = _e55;
    uint _e62 = mixed_unsigned_5_();
    local_6 = static_cast<uint>(base + 7u);
    uint _e67 = local_6;
    output[_e67] = _e62;
    int _e69 = mixed_int_8_();
    local_7 = static_cast<uint>(base + 8u);
    uint _e75 = local_7;
    output[_e75] = static_cast<uint>(_e69);
    uint _e77 = flags_true_4u();
    local_8 = static_cast<uint>(base + 9u);
    uint _e82 = local_8;
    output[_e82] = _e77;
    int _e84 = cast_value_3_();
    local_9 = static_cast<uint>(base + 10u);
    uint _e90 = local_9;
    output[_e90] = static_cast<uint>(_e84);
    int _e92 = comma_value_2_();
    local_10 = static_cast<uint>(base + 11u);
    uint _e98 = local_10;
    output[_e98] = static_cast<uint>(_e92);
    int _e100 = shifted_4_();
    local_11 = static_cast<uint>(base + 12u);
    uint _e106 = local_11;
    output[_e106] = static_cast<uint>(_e100);
    int _e109 = choose(1);
    local_12 = static_cast<uint>(base + 13u);
    uint _e115 = local_12;
    output[_e115] = static_cast<uint>(_e109);
    int _e118 = choose_20_unsigned(1u);
    local_13 = static_cast<uint>(base + 14u);
    uint _e124 = local_13;
    output[_e124] = static_cast<uint>(_e118);
    int _e127 = choose_20_int(1);
    local_14 = static_cast<uint>(base + 15u);
    uint _e133 = local_14;
    output[_e133] = static_cast<uint>(_e127);
    state = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    old = int {};
    int _e141 = state;
    old = _e141;
    int _e143 = state;
    state = as_type<int>(as_type<uint>(_e143) + as_type<uint>(2));
    int _e146 = old;
    local_15 = static_cast<uint>(base + 16u);
    uint _e152 = local_15;
    output[_e152] = static_cast<uint>(_e146);
    old_1 = int {};
    int _e156 = state;
    old_1 = _e156;
    int _e158 = state;
    state = as_type<int>(as_type<uint>(_e158) + as_type<uint>(3));
    int _e161 = old_1;
    local_16 = static_cast<uint>(base + 17u);
    uint _e167 = local_16;
    output[_e167] = static_cast<uint>(_e161);
    local_17 = false;
    if (false) {
        old_2 = int {};
        int _e173 = state;
        local_28 = _e173;
        int _e175 = local_28;
        old_2 = _e175;
        int _e177 = state;
        local_29 = _e177;
        int _e179 = local_29;
        state = as_type<int>(as_type<uint>(_e179) + as_type<uint>(2));
        int _e182 = old_2;
        local_18 = _e182;
        int _e184 = local_18;
        local_17 = _e184 != 0;
    }
    local_19 = true;
    if (true) {
    } else {
        old_3 = int {};
        int _e191 = state;
        local_30 = _e191;
        int _e193 = local_30;
        old_3 = _e193;
        int _e195 = state;
        local_31 = _e195;
        int _e197 = local_31;
        state = as_type<int>(as_type<uint>(_e197) + as_type<uint>(2));
        int _e200 = old_3;
        local_20 = _e200;
        int _e202 = local_20;
        local_19 = _e202 != 0;
    }
    old_4 = int {};
    int _e207 = state;
    old_4 = _e207;
    int _e209 = state;
    state = as_type<int>(as_type<uint>(_e209) + as_type<uint>(2));
    int _e212 = state;
    local_21 = static_cast<uint>(base + 18u);
    uint _e218 = local_21;
    output[_e218] = static_cast<uint>(_e212);
    int _e220 = skipped_thread_true();
    local_22 = static_cast<uint>(base + 19u);
    uint _e226 = local_22;
    output[_e226] = static_cast<uint>(_e220);
    int _e228 = skipped_grid_false();
    local_23 = static_cast<uint>(base + 20u);
    uint _e234 = local_23;
    output[_e234] = static_cast<uint>(_e228);
    int _e236 = skipped_call_true();
    local_24 = static_cast<uint>(base + 21u);
    uint _e242 = local_24;
    output[_e242] = static_cast<uint>(_e236);
    index = 0;
    int _e246 = index;
    index = as_type<int>(as_type<uint>(_e246) + as_type<uint>(1));
    local_26 = static_cast<uint>(_e246);
    uint _e251 = local_26;
    int _e254 = input[_e251];
    int _e255 = add_3_int(_e254);
    local_25 = static_cast<uint>(base + 22u);
    uint _e261 = local_25;
    output[_e261] = static_cast<uint>(_e255);
    int _e263 = index;
    local_27 = static_cast<uint>(base + 23u);
    uint _e269 = local_27;
    output[_e269] = static_cast<uint>(_e263);
}
