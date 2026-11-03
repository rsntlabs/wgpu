// language: metal2.4
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size2;
};

struct Record_cuda_record_0_ {
    short signed_value;
    ushort unsigned_value;
    uint wide;
    short tail;
    ushort tag;
};
typedef Record_cuda_record_0_ type_4[1];
typedef uint type_5[1];
struct type_6 {
    ushort value;
    char _pad1[14];
};

int promoted(
    int value
) {
    return 31;
}

int exact(
    short value_1
) {
    return 41;
}

int exact_1(
    ushort value_2
) {
    return 43;
}

short identity_short(
    short value_3
) {
    return value_3;
}

ushort identity_unsigned_u0020_short(
    ushort value_4
) {
    return value_4;
}

int signed_type_u002d_1_(
) {
    int _e1 = exact(static_cast<short>(-1));
    return _e1;
}

int unsigned_type_65535u(
) {
    int _e1 = exact_1(static_cast<ushort>(65535));
    return _e1;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

int naga_div(int lhs, int rhs) {
    return lhs / metal::select(rhs, 1, (lhs == (-2147483647 - 1) & rhs == -1) | (rhs == 0));
}

short naga_f2i16(float value) {
    return static_cast<short>(metal::clamp(value, -32768.0, 32767.0));
}

ushort naga_f2u16(float value) {
    return static_cast<ushort>(metal::clamp(value, 0.0, 65535.0));
}


struct integer16_Input {
};
[[max_total_threads_per_threadgroup(4)]] kernel void integer16_(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
, device type_5& observations [[buffer(2)]]
, constant type_6& count [[buffer(3)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(4)]]
) {
    Record_cuda_record_0_ original = {};
    Record_cuda_record_0_ result = {};
    short signed_value = {};
    ushort unsigned_value = {};
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
    uint local_15 = {};
    short local_16 = {};
    Record_cuda_record_0_ local_17 = {};
    Record_cuda_record_0_ local_18 = {};
    ushort count_1 = count.value;
    uint index = (blockIdx.x * 4u) + threadIdx.x;
    if (index >= static_cast<uint>(count_1)) {
        return;
    }
    Record_cuda_record_0_ _e14 = input[index];
    local_18 = _e14;
    Record_cuda_record_0_ _e16 = local_18;
    local_17 = _e16;
    Record_cuda_record_0_ _e18 = local_17;
    original = _e18;
    Record_cuda_record_0_ _e20 = original;
    result = _e20;
    ushort _e24 = original.unsigned_value;
    ushort _e26 = original.unsigned_value;
    int promoted_sum = as_type<int>(as_type<uint>(static_cast<int>(_e24)) + as_type<uint>(static_cast<int>(_e26)));
    short _e30 = original.signed_value;
    short _e31 = identity_short(_e30);
    signed_value = _e31;
    ushort _e34 = original.unsigned_value;
    ushort _e35 = identity_unsigned_u0020_short(_e34);
    unsigned_value = _e35;
    short _e37 = signed_value;
    signed_value = static_cast<short>(as_type<int>(as_type<uint>(static_cast<int>(_e37)) + as_type<uint>(3)));
    short _e45 = signed_value;
    signed_value = static_cast<short>(naga_div(static_cast<int>(_e45), static_cast<int>(static_cast<short>(naga_neg(1)))));
    ushort _e52 = unsigned_value;
    unsigned_value = static_cast<ushort>(as_type<int>(as_type<uint>(static_cast<int>(_e52)) + as_type<uint>(static_cast<int>(static_cast<ushort>(1)))));
    ushort _e57 = unsigned_value;
    local = static_cast<uint>(1);
    uint _e62 = local;
    unsigned_value = static_cast<ushort>(static_cast<int>(_e57) << _e62);
    short _e65 = signed_value;
    result.signed_value = naga_f2i16(static_cast<float>(_e65));
    ushort _e69 = unsigned_value;
    result.unsigned_value = naga_f2u16(static_cast<float>(_e69));
    result.wide = static_cast<uint>(promoted_sum);
    short _e76 = original.tail;
    result.tail = static_cast<short>(~(static_cast<int>(_e76)));
    ushort _e82 = original.tag;
    result.tag = static_cast<ushort>(as_type<int>(as_type<uint>(static_cast<int>(_e82)) + as_type<uint>(1)));
    Record_cuda_record_0_ _e88 = result;
    output[index] = _e88;
    uint base = index * 16u;
    observations[base] = static_cast<uint>(promoted_sum);
    ushort _e97 = original.unsigned_value;
    int _e99 = promoted(static_cast<int>(_e97));
    local_1 = static_cast<uint>(base + 1u);
    uint _e105 = local_1;
    observations[_e105] = static_cast<uint>(_e99);
    short _e108 = original.signed_value;
    int _e109 = exact(_e108);
    local_2 = static_cast<uint>(base + 2u);
    uint _e115 = local_2;
    observations[_e115] = static_cast<uint>(_e109);
    ushort _e118 = original.unsigned_value;
    int _e119 = exact_1(_e118);
    local_3 = static_cast<uint>(base + 3u);
    uint _e125 = local_3;
    observations[_e125] = static_cast<uint>(_e119);
    int _e127 = signed_type_u002d_1_();
    local_4 = static_cast<uint>(base + 4u);
    uint _e133 = local_4;
    observations[_e133] = static_cast<uint>(_e127);
    int _e135 = unsigned_type_65535u();
    local_5 = static_cast<uint>(base + 5u);
    uint _e141 = local_5;
    observations[_e141] = static_cast<uint>(_e135);
    ushort _e144 = original.unsigned_value;
    local_6 = static_cast<uint>(base + 6u);
    uint _e151 = local_6;
    observations[_e151] = static_cast<uint>(static_cast<int>(_e144));
    ushort _e154 = original.unsigned_value;
    local_7 = static_cast<uint>(base + 7u);
    uint _e162 = local_7;
    observations[_e162] = static_cast<uint>(naga_neg(static_cast<int>(_e154)));
    ushort _e165 = original.unsigned_value;
    local_8 = static_cast<uint>(base + 8u);
    uint _e173 = local_8;
    observations[_e173] = static_cast<uint>(~(static_cast<int>(_e165)));
    local_9 = static_cast<uint>(base + 9u);
    uint _e189 = local_9;
    observations[_e189] = static_cast<uint>(naga_div(static_cast<int>(static_cast<short>(naga_neg(32768))), static_cast<int>(static_cast<short>(naga_neg(1)))));
    short _e193 = original.signed_value;
    ushort _e195 = original.unsigned_value;
    local_10 = static_cast<uint>(base + 10u);
    uint _e203 = local_10;
    observations[_e203] = static_cast<uint>(static_cast<int>(_e193) < static_cast<int>(_e195));
    short _e206 = original.signed_value;
    local_11 = static_cast<uint>(base + 11u);
    uint _e215 = local_11;
    observations[_e215] = static_cast<uint>(static_cast<uint>(_e206) < 1u);
    short _e218 = result.signed_value;
    local_12 = static_cast<uint>(base + 12u);
    uint _e224 = local_12;
    observations[_e224] = static_cast<uint>(_e218);
    ushort _e227 = result.unsigned_value;
    local_13 = static_cast<uint>(base + 13u);
    uint _e233 = local_13;
    observations[_e233] = static_cast<uint>(_e227);
    short _e236 = original.tail;
    local_14 = static_cast<uint>(base + 14u);
    uint _e242 = local_14;
    observations[_e242] = static_cast<uint>(_e236);
    if ((index & 1u) != 0u) {
        short _e249 = original.signed_value;
        local_16 = _e249;
    } else {
        short _e252 = result.tail;
        local_16 = _e252;
    }
    short _e255 = local_16;
    int _e256 = exact(_e255);
    local_15 = static_cast<uint>(base + 15u);
    uint _e262 = local_15;
    observations[_e262] = static_cast<uint>(_e256);
}
