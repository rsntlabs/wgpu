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
        local = i;
        uint _e12 = local;
        local_20 = _e12;
        uint _e14 = local_20;
        uint _e17 = input[_e14];
        local_21 = _e17;
        uint _e19 = local_21;
        local_19 = _e19;
        uint _e21 = local_19;
        value = _e21;
        uint _e23 = value;
        shift = _e23 & 3u;
        base = i * 18u;
        uint _e30 = value;
        shared_values.inner[threadIdx.x] = _e30 ^ static_cast<uint>(255);
        uint _e39 = shared_values.inner[threadIdx.x];
        uint _e40 = base;
        local_1 = _e40;
        uint _e42 = local_1;
        local_22 = _e42;
        uint _e44 = local_22;
        out[_e44] = _e39;
        uint _e47 = value;
        uint _e51 = base;
        local_2 = static_cast<uint>(_e51 + 1u);
        uint _e56 = local_2;
        local_23 = _e56;
        uint _e58 = local_23;
        out[_e58] = _e47 & static_cast<uint>(255);
        uint _e60 = value;
        uint _e63 = base;
        local_3 = static_cast<uint>(_e63 + 2u);
        uint _e68 = local_3;
        local_24 = _e68;
        uint _e70 = local_24;
        out[_e70] = _e60 & 240u;
        uint _e72 = value;
        uint _e75 = base;
        local_4 = static_cast<uint>(_e75 + 3u);
        uint _e80 = local_4;
        local_25 = _e80;
        uint _e82 = local_25;
        out[_e82] = _e72 + 1000u;
        uint _e84 = shift;
        uint _e87 = base;
        local_5 = static_cast<uint>(_e87 + 4u);
        uint _e92 = local_5;
        local_26 = _e92;
        uint _e94 = local_26;
        out[_e94] = 2147483648u >> _e84;
        uint _e98 = shift;
        uint _e100 = base;
        local_6 = static_cast<uint>(_e100 + 5u);
        uint _e106 = local_6;
        local_27 = _e106;
        uint _e108 = local_27;
        out[_e108] = static_cast<uint>(static_cast<int>(2147483648u) >> _e98);
        uint _e110 = value;
        uint _e113 = base;
        local_7 = static_cast<uint>(_e113 + 6u);
        uint _e118 = local_7;
        local_28 = _e118;
        uint _e120 = local_28;
        out[_e120] = 4294967295u ^ _e110;
        uint _e122 = value;
        uint _e125 = base;
        local_8 = static_cast<uint>(_e125 + 7u);
        uint _e131 = local_8;
        local_29 = _e131;
        uint _e133 = local_29;
        out[_e133] = static_cast<uint>(_e122 < 2147483648u);
        uint _e135 = value;
        uint _e139 = base;
        local_9 = static_cast<uint>(_e139 + 8u);
        uint _e145 = local_9;
        local_30 = _e145;
        uint _e147 = local_30;
        out[_e147] = static_cast<uint>(static_cast<int>(_e135) < 2147483647);
        uint _e149 = shift;
        uint _e152 = base;
        local_10 = static_cast<uint>(_e152 + 9u);
        uint _e157 = local_10;
        local_31 = _e157;
        uint _e159 = local_31;
        out[_e159] = 2147483648u >> _e149;
        uint _e161 = value;
        uint _e164 = base;
        local_11 = static_cast<uint>(_e164 + 10u);
        uint _e169 = local_11;
        local_32 = _e169;
        uint _e171 = local_32;
        out[_e171] = 255u + _e161;
        uint _e173 = value;
        uint _e180 = base;
        local_12 = static_cast<uint>(_e180 + 11u);
        uint _e185 = local_12;
        local_33 = _e185;
        uint _e187 = local_33;
        out[_e187] = ((_e173 + 10u) + 8u) + 10u;
        uint _e189 = value;
        uint _e193 = base;
        local_13 = static_cast<uint>(_e193 + 12u);
        uint _e198 = local_13;
        local_34 = _e198;
        uint _e200 = local_34;
        out[_e200] = _e189 + static_cast<uint>(15);
        uint _e202 = value;
        uint _e205 = base;
        local_14 = static_cast<uint>(_e205 + 13u);
        uint _e210 = local_14;
        local_35 = _e210;
        uint _e212 = local_35;
        out[_e212] = 4294967295u - _e202;
        uint _e214 = value;
        uint _e217 = base;
        local_15 = static_cast<uint>(_e217 + 14u);
        uint _e222 = local_15;
        local_36 = _e222;
        uint _e224 = local_36;
        out[_e224] = 3735928559u ^ _e214;
        uint _e228 = value;
        uint _e231 = base;
        local_16 = static_cast<uint>(_e231 + 15u);
        uint _e237 = local_16;
        local_37 = _e237;
        uint _e239 = local_37;
        out[_e239] = static_cast<uint>(~(2147483647) < static_cast<int>(_e228));
        uint _e241 = value;
        uint _e248 = base;
        local_17 = static_cast<uint>(_e248 + 16u);
        uint _e253 = local_17;
        local_38 = _e253;
        uint _e255 = local_38;
        out[_e255] = (_e241 + static_cast<uint>(30)) + static_cast<uint>(2);
        uint _e257 = value;
        uint _e264 = base;
        local_18 = static_cast<uint>(_e264 + 17u);
        uint _e269 = local_18;
        local_39 = _e269;
        uint _e271 = local_39;
        out[_e271] = (_e257 + static_cast<uint>(30)) - static_cast<uint>(2);
    }
}
