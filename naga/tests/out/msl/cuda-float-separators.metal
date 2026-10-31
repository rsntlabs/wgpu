// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef float type_1[1];
struct type_3 {
    uint value;
    char _pad1[12];
};

struct float_separatorsInput {
};
kernel void float_separators(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, device type_1 const& input [[user(fake0)]]
, constant type_3& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint base = {};
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
    float local_13 = {};
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
    float local_26 = {};
    uint local_27 = {};
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 12u;
        uint _e14 = base;
        local = _e14;
        uint _e16 = local;
        local_14 = _e16;
        uint _e18 = local_14;
        out[_e18] = 1024.5;
        uint _e22 = base;
        local_1 = static_cast<uint>(_e22 + 1u);
        uint _e27 = local_1;
        local_15 = _e27;
        uint _e29 = local_15;
        out[_e29] = 0.125;
        uint _e32 = base;
        local_2 = static_cast<uint>(_e32 + 2u);
        uint _e37 = local_2;
        local_16 = _e37;
        uint _e39 = local_16;
        out[_e39] = 12.0;
        uint _e42 = base;
        local_3 = static_cast<uint>(_e42 + 3u);
        uint _e47 = local_3;
        local_17 = _e47;
        uint _e49 = local_17;
        out[_e49] = 25.0;
        uint _e52 = base;
        local_4 = static_cast<uint>(_e52 + 4u);
        uint _e57 = local_4;
        local_18 = _e57;
        uint _e59 = local_18;
        out[_e59] = 0.5;
        uint _e62 = base;
        local_5 = static_cast<uint>(_e62 + 5u);
        uint _e67 = local_5;
        local_19 = _e67;
        uint _e69 = local_19;
        out[_e69] = 6.25;
        uint _e74 = base;
        local_6 = static_cast<uint>(_e74 + 6u);
        uint _e79 = local_6;
        local_20 = _e79;
        uint _e81 = local_20;
        out[_e81] = -(1024.5);
        uint _e83 = base;
        local_7 = static_cast<uint>(_e83 + 7u);
        uint _e88 = local_7;
        local_21 = _e88;
        uint _e90 = local_21;
        out[_e90] = 0.125;
        uint _e93 = base;
        local_8 = static_cast<uint>(_e93 + 8u);
        uint _e98 = local_8;
        local_22 = _e98;
        uint _e100 = local_22;
        out[_e100] = 3.1415927;
        uint _e103 = base;
        local_9 = static_cast<uint>(_e103 + 9u);
        uint _e108 = local_9;
        local_23 = _e108;
        uint _e110 = local_23;
        out[_e110] = 1.0;
        uint _e113 = base;
        local_10 = static_cast<uint>(_e113 + 10u);
        uint _e118 = local_10;
        local_24 = _e118;
        uint _e120 = local_24;
        out[_e120] = 1.0000002;
        local_12 = i;
        uint _e124 = local_12;
        local_25 = _e124;
        uint _e126 = local_25;
        float _e129 = input[_e126];
        local_26 = _e129;
        float _e131 = local_26;
        local_13 = _e131;
        float _e133 = local_13;
        uint _e138 = base;
        local_11 = static_cast<uint>(_e138 + 11u);
        uint _e143 = local_11;
        local_27 = _e143;
        uint _e145 = local_27;
        out[_e145] = (_e133 * 0.25) + 10.0;
    }
}
