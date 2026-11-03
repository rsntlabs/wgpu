// language: metal2.4
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size2;
};

struct short3_ {
    short x;
    short y;
    short z;
};
typedef short3_ type_4[1];
typedef uint type_5[1];
struct type_6 {
    ushort value;
    char _pad1[14];
};
struct ushort3_ {
    ushort x;
    ushort y;
    ushort z;
};

uint promoted(
    int value
) {
    return 31u;
}

uint field_kind(
    ushort value_1
) {
    return 43u;
}

short3_ identity_short3_(
    short3_ value_2
) {
    short3_ value_3 = {};
    value_3 = value_2;
    short3_ _e2 = value_3;
    return _e2;
}

metal::ushort4 identity_ushort4_(
    metal::ushort4 value_4
) {
    metal::ushort4 value_5 = {};
    value_5 = value_4;
    metal::ushort4 _e2 = value_5;
    return _e2;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


struct integer16_vectorsInput {
};
[[max_total_threads_per_threadgroup(4)]] kernel void integer16_vectors(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
, device type_5& observations [[buffer(2)]]
, constant type_6& count [[buffer(3)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(4)]]
) {
    short3_ signed_triple = {};
    metal::short2 signed_pair = {};
    metal::short4 signed_quad = {};
    metal::short4 copied_quad = {};
    metal::ushort2 unsigned_pair = {};
    ushort3_ unsigned_triple = {};
    metal::ushort4 unsigned_quad = {};
    short3_ local = {};
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
    short3_ local_16 = {};
    short3_ result = {};
    short3_ local_17 = {};
    short3_ local_18 = {};
    ushort count_1 = count.value;
    uint index = (blockIdx.x * 4u) + threadIdx.x;
    if (index >= static_cast<uint>(count_1)) {
        return;
    }
    short3_ _e14 = input[index];
    local_18 = _e14;
    short3_ _e16 = local_18;
    local_16 = _e16;
    short3_ _e18 = local_16;
    short3_ _e19 = identity_short3_(_e18);
    signed_triple = _e19;
    short _e22 = signed_triple.x;
    short _e24 = signed_triple.y;
    signed_pair = metal::short2(_e22, _e24);
    short _e28 = signed_triple.x;
    short _e30 = signed_triple.y;
    short _e32 = signed_triple.z;
    signed_quad = metal::short4(_e28, _e30, _e32, static_cast<short>(7));
    metal::short4 _e37 = signed_quad;
    copied_quad = _e37;
    short _e40 = signed_triple.x;
    short _e42 = copied_quad.w;
    copied_quad.w = static_cast<short>(as_type<int>(as_type<uint>(static_cast<int>(_e42)) + as_type<uint>(static_cast<int>(_e40))));
    short _e48 = signed_triple.x;
    short _e50 = signed_triple.y;
    unsigned_pair = metal::ushort2(static_cast<ushort>(_e48), static_cast<ushort>(_e50));
    ushort _e56 = unsigned_pair.x;
    unsigned_pair.x = static_cast<ushort>(as_type<int>(as_type<uint>(static_cast<int>(_e56)) + as_type<uint>(1)));
    ushort _e62 = unsigned_pair.y;
    unsigned_pair.y = static_cast<ushort>(as_type<int>(as_type<uint>(static_cast<int>(_e62)) + as_type<uint>(1)));
    short _e68 = signed_triple.x;
    short _e70 = signed_triple.y;
    short _e72 = signed_triple.z;
    unsigned_triple = ushort3_ {static_cast<ushort>(_e68), static_cast<ushort>(_e70), static_cast<ushort>(_e72)};
    short _e79 = signed_triple.z;
    short _e81 = signed_triple.y;
    short _e83 = signed_triple.x;
    metal::ushort4 _e90 = identity_ushort4_(metal::ushort4(static_cast<ushort>(_e79), static_cast<ushort>(_e81), static_cast<ushort>(_e83), static_cast<ushort>(65535u)));
    unsigned_quad = _e90;
    ushort _e93 = unsigned_quad.w;
    unsigned_quad.w = static_cast<ushort>(as_type<int>(as_type<uint>(static_cast<int>(_e93)) + as_type<uint>(2)));
    result = short3_ {};
    short3_ _e100 = signed_triple;
    local_17 = _e100;
    short3_ _e102 = local_17;
    result = _e102;
    short _e105 = result.x;
    result.x = static_cast<short>(as_type<int>(as_type<uint>(static_cast<int>(_e105)) + as_type<uint>(3)));
    short _e111 = result.y;
    result.y = static_cast<short>(naga_neg(static_cast<int>(_e111)));
    short _e117 = result.z;
    result.z = static_cast<short>(static_cast<int>(_e117) ^ 4951);
    short3_ _e122 = result;
    local = _e122;
    short3_ _e124 = local;
    output[index] = _e124;
    uint base = index * 16u;
    short _e130 = signed_pair.x;
    observations[base] = static_cast<uint>(_e130);
    short _e135 = signed_pair.y;
    local_1 = static_cast<uint>(base + 1u);
    uint _e141 = local_1;
    observations[_e141] = static_cast<uint>(_e135);
    short _e144 = copied_quad.x;
    local_2 = static_cast<uint>(base + 2u);
    uint _e150 = local_2;
    observations[_e150] = static_cast<uint>(_e144);
    short _e153 = copied_quad.y;
    local_3 = static_cast<uint>(base + 3u);
    uint _e159 = local_3;
    observations[_e159] = static_cast<uint>(_e153);
    short _e162 = copied_quad.z;
    local_4 = static_cast<uint>(base + 4u);
    uint _e168 = local_4;
    observations[_e168] = static_cast<uint>(_e162);
    short _e171 = copied_quad.w;
    local_5 = static_cast<uint>(base + 5u);
    uint _e177 = local_5;
    observations[_e177] = static_cast<uint>(_e171);
    ushort _e180 = unsigned_pair.x;
    local_6 = static_cast<uint>(base + 6u);
    uint _e186 = local_6;
    observations[_e186] = static_cast<uint>(_e180);
    ushort _e189 = unsigned_pair.y;
    local_7 = static_cast<uint>(base + 7u);
    uint _e195 = local_7;
    observations[_e195] = static_cast<uint>(_e189);
    ushort _e199 = unsigned_triple.y;
    ushort _e203 = unsigned_triple.x;
    local_8 = static_cast<uint>(base + 8u);
    uint _e211 = local_8;
    observations[_e211] = static_cast<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e203)) + as_type<uint>(as_type<int>(as_type<uint>(3) * as_type<uint>(static_cast<int>(_e199))))));
    ushort _e214 = unsigned_triple.z;
    local_9 = static_cast<uint>(base + 9u);
    uint _e220 = local_9;
    observations[_e220] = static_cast<uint>(_e214);
    ushort _e223 = unsigned_quad.x;
    local_10 = static_cast<uint>(base + 10u);
    uint _e229 = local_10;
    observations[_e229] = static_cast<uint>(_e223);
    ushort _e232 = unsigned_quad.y;
    local_11 = static_cast<uint>(base + 11u);
    uint _e238 = local_11;
    observations[_e238] = static_cast<uint>(_e232);
    ushort _e241 = unsigned_quad.z;
    local_12 = static_cast<uint>(base + 12u);
    uint _e247 = local_12;
    observations[_e247] = static_cast<uint>(_e241);
    ushort _e250 = unsigned_quad.w;
    local_13 = static_cast<uint>(base + 13u);
    uint _e256 = local_13;
    observations[_e256] = static_cast<uint>(_e250);
    ushort _e259 = unsigned_triple.x;
    uint _e261 = promoted(static_cast<int>(_e259));
    local_14 = static_cast<uint>(base + 14u);
    uint _e266 = local_14;
    observations[_e266] = _e261;
    ushort _e269 = unsigned_triple.z;
    uint _e270 = field_kind(_e269);
    local_15 = static_cast<uint>(base + 15u);
    uint _e275 = local_15;
    observations[_e275] = _e270;
}
