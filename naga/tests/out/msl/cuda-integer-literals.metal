// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_1[1];
struct type_2 {
    uint value;
    char _pad1[12];
};
struct type_3 {
    uint inner[64];
};

struct integer_literalsInput {
};
kernel void integer_literals(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, device type_1 const& input [[user(fake0)]]
, constant type_2& n [[user(fake0)]]
, threadgroup type_3& shared_values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint value = {};
    uint local = {};
    uint shift = {};
    uint base = {};
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
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        local = static_cast<uint>(i);
        uint _e13 = local;
        local_20 = static_cast<uint>(_e13);
        uint _e16 = local_20;
        uint _e19 = input[_e16];
        local_21 = _e19;
        uint _e21 = local_21;
        local_19 = _e21;
        uint _e23 = local_19;
        value = _e23;
        uint _e25 = value;
        shift = _e25 & 3u;
        base = i * 18u;
        uint _e32 = value;
        shared_values.inner[threadIdx.x] = _e32 ^ static_cast<uint>(255);
        uint _e41 = shared_values.inner[threadIdx.x];
        uint _e42 = base;
        local_1 = static_cast<uint>(_e42);
        uint _e45 = local_1;
        local_22 = static_cast<uint>(_e45);
        uint _e48 = local_22;
        out[_e48] = _e41;
        uint _e51 = value;
        uint _e55 = base;
        local_2 = static_cast<uint>(_e55 + 1u);
        uint _e60 = local_2;
        local_23 = static_cast<uint>(_e60);
        uint _e63 = local_23;
        out[_e63] = _e51 & static_cast<uint>(255);
        uint _e65 = value;
        uint _e68 = base;
        local_3 = static_cast<uint>(_e68 + 2u);
        uint _e73 = local_3;
        local_24 = static_cast<uint>(_e73);
        uint _e76 = local_24;
        out[_e76] = _e65 & 240u;
        uint _e78 = value;
        uint _e81 = base;
        local_4 = static_cast<uint>(_e81 + 3u);
        uint _e86 = local_4;
        local_25 = static_cast<uint>(_e86);
        uint _e89 = local_25;
        out[_e89] = _e78 + 1000u;
        uint _e91 = shift;
        uint _e94 = base;
        local_5 = static_cast<uint>(_e94 + 4u);
        uint _e99 = local_5;
        local_26 = static_cast<uint>(_e99);
        uint _e102 = local_26;
        out[_e102] = 2147483648u >> _e91;
        uint _e106 = shift;
        uint _e108 = base;
        local_6 = static_cast<uint>(_e108 + 5u);
        uint _e114 = local_6;
        local_27 = static_cast<uint>(_e114);
        uint _e117 = local_27;
        out[_e117] = static_cast<uint>(static_cast<int>(2147483648u) >> _e106);
        uint _e119 = value;
        uint _e122 = base;
        local_7 = static_cast<uint>(_e122 + 6u);
        uint _e127 = local_7;
        local_28 = static_cast<uint>(_e127);
        uint _e130 = local_28;
        out[_e130] = 4294967295u ^ _e119;
        uint _e132 = value;
        uint _e135 = base;
        local_8 = static_cast<uint>(_e135 + 7u);
        uint _e141 = local_8;
        local_29 = static_cast<uint>(_e141);
        uint _e144 = local_29;
        out[_e144] = static_cast<uint>(_e132 < 2147483648u);
        uint _e146 = value;
        uint _e150 = base;
        local_9 = static_cast<uint>(_e150 + 8u);
        uint _e156 = local_9;
        local_30 = static_cast<uint>(_e156);
        uint _e159 = local_30;
        out[_e159] = static_cast<uint>(static_cast<int>(_e146) < 2147483647);
        uint _e161 = shift;
        uint _e164 = base;
        local_10 = static_cast<uint>(_e164 + 9u);
        uint _e169 = local_10;
        local_31 = static_cast<uint>(_e169);
        uint _e172 = local_31;
        out[_e172] = 2147483648u >> _e161;
        uint _e174 = value;
        uint _e177 = base;
        local_11 = static_cast<uint>(_e177 + 10u);
        uint _e182 = local_11;
        local_32 = static_cast<uint>(_e182);
        uint _e185 = local_32;
        out[_e185] = 255u + _e174;
        uint _e187 = value;
        uint _e194 = base;
        local_12 = static_cast<uint>(_e194 + 11u);
        uint _e199 = local_12;
        local_33 = static_cast<uint>(_e199);
        uint _e202 = local_33;
        out[_e202] = ((_e187 + 10u) + 8u) + 10u;
        uint _e204 = value;
        uint _e208 = base;
        local_13 = static_cast<uint>(_e208 + 12u);
        uint _e213 = local_13;
        local_34 = static_cast<uint>(_e213);
        uint _e216 = local_34;
        out[_e216] = _e204 + static_cast<uint>(15);
        uint _e218 = value;
        uint _e221 = base;
        local_14 = static_cast<uint>(_e221 + 13u);
        uint _e226 = local_14;
        local_35 = static_cast<uint>(_e226);
        uint _e229 = local_35;
        out[_e229] = 4294967295u - _e218;
        uint _e231 = value;
        uint _e234 = base;
        local_15 = static_cast<uint>(_e234 + 14u);
        uint _e239 = local_15;
        local_36 = static_cast<uint>(_e239);
        uint _e242 = local_36;
        out[_e242] = 3735928559u ^ _e231;
        uint _e246 = value;
        uint _e249 = base;
        local_16 = static_cast<uint>(_e249 + 15u);
        uint _e255 = local_16;
        local_37 = static_cast<uint>(_e255);
        uint _e258 = local_37;
        out[_e258] = static_cast<uint>(~(2147483647) < static_cast<int>(_e246));
        uint _e260 = value;
        uint _e267 = base;
        local_17 = static_cast<uint>(_e267 + 16u);
        uint _e272 = local_17;
        local_38 = static_cast<uint>(_e272);
        uint _e275 = local_38;
        out[_e275] = (_e260 + static_cast<uint>(30)) + static_cast<uint>(2);
        uint _e277 = value;
        uint _e284 = base;
        local_18 = static_cast<uint>(_e284 + 17u);
        uint _e289 = local_18;
        local_39 = static_cast<uint>(_e289);
        uint _e292 = local_39;
        out[_e292] = (_e277 + static_cast<uint>(30)) - static_cast<uint>(2);
    }
}
