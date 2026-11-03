// language: metal2.4
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size2;
};

struct int1_ {
    int x;
};
struct float1_ {
    float x;
};
struct uint1_ {
    uint x;
};
struct short1_ {
    short x;
};
struct ushort1_ {
    ushort x;
};
typedef int1_ type_5[1];
typedef uint type_6[1];
struct type_7 {
    uint value;
    char _pad1[12];
};

uint kind(
    float1_ value
) {
    float1_ value_1 = {};
    value_1 = value;
    return 11u;
}

uint kind_1(
    int1_ value_2
) {
    int1_ value_3 = {};
    value_3 = value_2;
    return 13u;
}

uint kind_2(
    uint1_ value_4
) {
    uint1_ value_5 = {};
    value_5 = value_4;
    return 17u;
}

uint kind_3(
    short1_ value_6
) {
    short1_ value_7 = {};
    value_7 = value_6;
    return 19u;
}

uint kind_4(
    ushort1_ value_8
) {
    ushort1_ value_9 = {};
    value_9 = value_8;
    return 23u;
}

uint kind_5(
    float value_10
) {
    return 31u;
}

uint kind_6(
    int value_11
) {
    return 37u;
}

uint kind_7(
    uint value_12
) {
    return 41u;
}

uint kind_8(
    short value_13
) {
    return 43u;
}

uint kind_9(
    ushort value_14
) {
    return 47u;
}

int1_ identity_int1_(
    int1_ value_15
) {
    int1_ value_16 = {};
    value_16 = value_15;
    int1_ _e2 = value_16;
    return _e2;
}

uint1_ identity_uint1_(
    uint1_ value_17
) {
    uint1_ value_18 = {};
    value_18 = value_17;
    uint1_ _e2 = value_18;
    return _e2;
}

struct single_component_vectorsInput {
};
[[max_total_threads_per_threadgroup(4)]] kernel void single_component_vectors(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_5 const& input [[buffer(0)]]
, device type_5& output [[buffer(1)]]
, device type_6& observations [[buffer(2)]]
, constant type_7& count [[buffer(3)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(4)]]
) {
    int1_ signed_value = {};
    uint1_ unsigned_value = {};
    float1_ floating = {};
    short1_ signed_half = {};
    ushort1_ unsigned_half = {};
    int1_ changed = {};
    int1_ local = {};
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
    uint local_15 = {};
    int1_ result = {};
    int1_ local_16 = {};
    uint count_1 = count.value;
    uint index = (blockIdx.x * 4u) + threadIdx.x;
    if (index >= count_1) {
        return;
    }
    int _e14 = input[index].x;
    int1_ _e16 = identity_int1_(int1_ {_e14});
    signed_value = _e16;
    int _e19 = signed_value.x;
    uint1_ _e22 = identity_uint1_(uint1_ {static_cast<uint>(_e19)});
    unsigned_value = _e22;
    int _e25 = signed_value.x;
    floating = float1_ {static_cast<float>(_e25 & 7) + 0.5};
    int _e34 = signed_value.x;
    signed_half = short1_ {static_cast<short>(_e34)};
    int _e39 = signed_value.x;
    unsigned_half = ushort1_ {static_cast<ushort>(_e39)};
    short _e44 = signed_half.x;
    signed_half.x = static_cast<short>(as_type<int>(as_type<uint>(static_cast<int>(_e44)) + as_type<uint>(1)));
    ushort _e50 = unsigned_half.x;
    unsigned_half.x = static_cast<ushort>(as_type<int>(as_type<uint>(static_cast<int>(_e50)) + as_type<uint>(1)));
    result = int1_ {};
    int1_ _e57 = signed_value;
    local_16 = _e57;
    int1_ _e59 = local_16;
    result = _e59;
    int _e62 = result.x;
    result.x = _e62 ^ 324508639;
    int1_ _e65 = result;
    local = _e65;
    int1_ _e67 = local;
    changed = _e67;
    int1_ _e69 = changed;
    output[index] = _e69;
    uint base = index * 16u;
    int _e75 = signed_value.x;
    observations[base] = static_cast<uint>(_e75);
    int _e80 = changed.x;
    local_1 = static_cast<uint>(base + 1u);
    uint _e86 = local_1;
    observations[_e86] = static_cast<uint>(_e80);
    uint _e89 = unsigned_value.x;
    local_2 = static_cast<uint>(base + 2u);
    uint _e94 = local_2;
    observations[_e94] = _e89;
    float _e97 = floating.x;
    local_3 = static_cast<uint>(base + 3u);
    uint _e103 = local_3;
    observations[_e103] = as_type<uint>(_e97);
    short _e106 = signed_half.x;
    local_4 = static_cast<uint>(base + 4u);
    uint _e112 = local_4;
    observations[_e112] = static_cast<uint>(_e106);
    ushort _e115 = unsigned_half.x;
    local_5 = static_cast<uint>(base + 5u);
    uint _e121 = local_5;
    observations[_e121] = static_cast<uint>(_e115);
    float1_ _e123 = floating;
    uint _e124 = kind(_e123);
    local_6 = static_cast<uint>(base + 6u);
    uint _e129 = local_6;
    observations[_e129] = _e124;
    int1_ _e131 = signed_value;
    uint _e132 = kind_1(_e131);
    local_7 = static_cast<uint>(base + 7u);
    uint _e137 = local_7;
    observations[_e137] = _e132;
    uint1_ _e139 = unsigned_value;
    uint _e140 = kind_2(_e139);
    local_8 = static_cast<uint>(base + 8u);
    uint _e145 = local_8;
    observations[_e145] = _e140;
    short1_ _e147 = signed_half;
    uint _e148 = kind_3(_e147);
    local_9 = static_cast<uint>(base + 9u);
    uint _e153 = local_9;
    observations[_e153] = _e148;
    ushort1_ _e155 = unsigned_half;
    uint _e156 = kind_4(_e155);
    local_10 = static_cast<uint>(base + 10u);
    uint _e161 = local_10;
    observations[_e161] = _e156;
    float _e164 = floating.x;
    uint _e165 = kind_5(_e164);
    local_11 = static_cast<uint>(base + 11u);
    uint _e170 = local_11;
    observations[_e170] = _e165;
    int _e173 = signed_value.x;
    uint _e174 = kind_6(_e173);
    local_12 = static_cast<uint>(base + 12u);
    uint _e179 = local_12;
    observations[_e179] = _e174;
    uint _e182 = unsigned_value.x;
    uint _e183 = kind_7(_e182);
    local_13 = static_cast<uint>(base + 13u);
    uint _e188 = local_13;
    observations[_e188] = _e183;
    short _e191 = signed_half.x;
    uint _e192 = kind_8(_e191);
    local_14 = static_cast<uint>(base + 14u);
    uint _e197 = local_14;
    observations[_e197] = _e192;
    ushort _e200 = unsigned_half.x;
    uint _e201 = kind_9(_e200);
    local_15 = static_cast<uint>(base + 15u);
    uint _e206 = local_15;
    observations[_e206] = _e201;
}
