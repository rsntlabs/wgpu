// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_2[1];
typedef int type_3[1];
constant int Count_1 = 5;

int kind(
    uint value_6
) {
    return 2;
}

uint value_unsigned_5_(
) {
    return static_cast<uint>(5);
}

uint self_named_unsigned(
) {
    return static_cast<uint>(9);
}

int choose_3_(
    int value_7
) {
    return as_type<int>(as_type<uint>(3) + as_type<uint>(value_7));
}

int choose_5_(
    uint value_8
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(20) + as_type<uint>(5))) + as_type<uint>(static_cast<int>(value_8)));
}

int choose_7_(
    int value_9
) {
    return as_type<int>(as_type<uint>(7) + as_type<uint>(value_9));
}

uint caller_1_(
) {
    uint _e0 = value_unsigned_5_();
    return _e0;
}

struct template_default_mergingInput {
};
kernel void template_default_merging(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2& output [[buffer(0)]]
, device type_3 const& input [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    int Count = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    int state = {};
    uint local_9 = {};
    uint local_10 = {};
    bool local_11 = {};
    int local_12 = {};
    bool local_13 = {};
    int local_14 = {};
    uint local_15 = {};
    int index = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    int value = {};
    int old = {};
    uint value_1 = {};
    int old_1 = {};
    int value_2 = {};
    int old_2 = {};
    int local_20 = {};
    int local_21 = {};
    int value_3 = {};
    int old_3 = {};
    int local_22 = {};
    int local_23 = {};
    int value_4 = {};
    int old_4 = {};
    int value_5 = {};
    int old_5 = {};
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 16u);
    Count = 99;
    uint _e8 = value_unsigned_5_();
    output[base] = _e8;
    uint _e11 = value_unsigned_5_();
    local = static_cast<uint>(base + 1u);
    uint _e16 = local;
    output[_e16] = _e11;
    uint _e18 = value_unsigned_5_();
    local_1 = static_cast<uint>(base + 2u);
    uint _e23 = local_1;
    output[_e23] = _e18;
    uint _e25 = value_unsigned_5_();
    local_2 = static_cast<uint>(base + 3u);
    uint _e30 = local_2;
    output[_e30] = _e25;
    uint _e32 = self_named_unsigned();
    local_3 = static_cast<uint>(base + 4u);
    uint _e37 = local_3;
    output[_e37] = _e32;
    uint _e39 = value_unsigned_5_();
    int _e40 = kind(_e39);
    local_4 = static_cast<uint>(base + 5u);
    uint _e46 = local_4;
    output[_e46] = static_cast<uint>(_e40);
    int _e49 = choose_3_(1);
    local_5 = static_cast<uint>(base + 6u);
    uint _e55 = local_5;
    output[_e55] = static_cast<uint>(_e49);
    int _e58 = choose_5_(1u);
    local_6 = static_cast<uint>(base + 7u);
    uint _e64 = local_6;
    output[_e64] = static_cast<uint>(_e58);
    int _e67 = choose_7_(1);
    local_7 = static_cast<uint>(base + 8u);
    uint _e73 = local_7;
    output[_e73] = static_cast<uint>(_e67);
    uint _e75 = caller_1_();
    local_8 = static_cast<uint>(base + 9u);
    uint _e80 = local_8;
    output[_e80] = _e75;
    state = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    value = int {};
    old = int {};
    value = 1;
    int _e92 = state;
    old = _e92;
    int _e94 = value;
    int _e97 = state;
    state = as_type<int>(as_type<uint>(_e97) + as_type<uint>(as_type<int>(as_type<uint>(2) + as_type<uint>(_e94))));
    int _e99 = old;
    local_9 = static_cast<uint>(base + 10u);
    uint _e105 = local_9;
    output[_e105] = static_cast<uint>(_e99);
    value_1 = uint {};
    old_1 = int {};
    value_1 = 2u;
    int _e113 = state;
    old_1 = _e113;
    uint _e115 = value_1;
    int _e119 = state;
    state = as_type<int>(as_type<uint>(_e119) + as_type<uint>(as_type<int>(as_type<uint>(3) + as_type<uint>(static_cast<int>(_e115)))));
    int _e121 = old_1;
    local_10 = static_cast<uint>(base + 11u);
    uint _e127 = local_10;
    output[_e127] = static_cast<uint>(_e121);
    local_11 = false;
    if (false) {
        value_2 = int {};
        old_2 = int {};
        value_2 = 9;
        int _e137 = state;
        local_20 = _e137;
        int _e139 = local_20;
        old_2 = _e139;
        int _e141 = value_2;
        int _e144 = state;
        local_21 = _e144;
        int _e146 = local_21;
        state = as_type<int>(as_type<uint>(_e146) + as_type<uint>(as_type<int>(as_type<uint>(2) + as_type<uint>(_e141))));
        int _e148 = old_2;
        local_12 = _e148;
        int _e150 = local_12;
        local_11 = _e150 != 0;
    }
    local_13 = true;
    if (true) {
    } else {
        value_3 = int {};
        old_3 = int {};
        value_3 = 9;
        int _e161 = state;
        local_22 = _e161;
        int _e163 = local_22;
        old_3 = _e163;
        int _e165 = value_3;
        int _e168 = state;
        local_23 = _e168;
        int _e170 = local_23;
        state = as_type<int>(as_type<uint>(_e170) + as_type<uint>(as_type<int>(as_type<uint>(2) + as_type<uint>(_e165))));
        int _e172 = old_3;
        local_14 = _e172;
        int _e174 = local_14;
        local_13 = _e174 != 0;
    }
    value_4 = int {};
    old_4 = int {};
    value_4 = 0;
    int _e183 = state;
    old_4 = _e183;
    int _e185 = value_4;
    int _e188 = state;
    state = as_type<int>(as_type<uint>(_e188) + as_type<uint>(as_type<int>(as_type<uint>(2) + as_type<uint>(_e185))));
    int _e190 = state;
    local_15 = static_cast<uint>(base + 12u);
    uint _e196 = local_15;
    output[_e196] = static_cast<uint>(_e190);
    index = 0;
    int _e200 = index;
    index = as_type<int>(as_type<uint>(_e200) + as_type<uint>(1));
    local_17 = static_cast<uint>(_e200);
    uint _e205 = local_17;
    int _e208 = input[_e205];
    value_5 = int {};
    old_5 = int {};
    value_5 = _e208;
    int _e214 = state;
    old_5 = _e214;
    int _e216 = value_5;
    int _e219 = state;
    state = as_type<int>(as_type<uint>(_e219) + as_type<uint>(as_type<int>(as_type<uint>(2) + as_type<uint>(_e216))));
    int _e221 = old_5;
    local_16 = static_cast<uint>(base + 13u);
    uint _e227 = local_16;
    output[_e227] = static_cast<uint>(_e221);
    int _e229 = state;
    local_18 = static_cast<uint>(base + 14u);
    uint _e235 = local_18;
    output[_e235] = static_cast<uint>(_e229);
    int _e237 = index;
    local_19 = static_cast<uint>(base + 15u);
    uint _e243 = local_19;
    output[_e243] = static_cast<uint>(_e237);
}
