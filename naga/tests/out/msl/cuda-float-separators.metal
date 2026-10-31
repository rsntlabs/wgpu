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
        local = static_cast<uint>(_e14);
        uint _e17 = local;
        local_14 = static_cast<uint>(_e17);
        uint _e20 = local_14;
        out[_e20] = 1024.5;
        uint _e24 = base;
        local_1 = static_cast<uint>(_e24 + 1u);
        uint _e29 = local_1;
        local_15 = static_cast<uint>(_e29);
        uint _e32 = local_15;
        out[_e32] = 0.125;
        uint _e35 = base;
        local_2 = static_cast<uint>(_e35 + 2u);
        uint _e40 = local_2;
        local_16 = static_cast<uint>(_e40);
        uint _e43 = local_16;
        out[_e43] = 12.0;
        uint _e46 = base;
        local_3 = static_cast<uint>(_e46 + 3u);
        uint _e51 = local_3;
        local_17 = static_cast<uint>(_e51);
        uint _e54 = local_17;
        out[_e54] = 25.0;
        uint _e57 = base;
        local_4 = static_cast<uint>(_e57 + 4u);
        uint _e62 = local_4;
        local_18 = static_cast<uint>(_e62);
        uint _e65 = local_18;
        out[_e65] = 0.5;
        uint _e68 = base;
        local_5 = static_cast<uint>(_e68 + 5u);
        uint _e73 = local_5;
        local_19 = static_cast<uint>(_e73);
        uint _e76 = local_19;
        out[_e76] = 6.25;
        uint _e81 = base;
        local_6 = static_cast<uint>(_e81 + 6u);
        uint _e86 = local_6;
        local_20 = static_cast<uint>(_e86);
        uint _e89 = local_20;
        out[_e89] = -(1024.5);
        uint _e91 = base;
        local_7 = static_cast<uint>(_e91 + 7u);
        uint _e96 = local_7;
        local_21 = static_cast<uint>(_e96);
        uint _e99 = local_21;
        out[_e99] = 0.125;
        uint _e102 = base;
        local_8 = static_cast<uint>(_e102 + 8u);
        uint _e107 = local_8;
        local_22 = static_cast<uint>(_e107);
        uint _e110 = local_22;
        out[_e110] = 3.1415927;
        uint _e113 = base;
        local_9 = static_cast<uint>(_e113 + 9u);
        uint _e118 = local_9;
        local_23 = static_cast<uint>(_e118);
        uint _e121 = local_23;
        out[_e121] = 1.0;
        uint _e124 = base;
        local_10 = static_cast<uint>(_e124 + 10u);
        uint _e129 = local_10;
        local_24 = static_cast<uint>(_e129);
        uint _e132 = local_24;
        out[_e132] = 1.0000002;
        local_12 = static_cast<uint>(i);
        uint _e137 = local_12;
        local_25 = static_cast<uint>(_e137);
        uint _e140 = local_25;
        float _e143 = input[_e140];
        local_26 = _e143;
        float _e145 = local_26;
        local_13 = _e145;
        float _e147 = local_13;
        uint _e152 = base;
        local_11 = static_cast<uint>(_e152 + 11u);
        uint _e157 = local_11;
        local_27 = static_cast<uint>(_e157);
        uint _e160 = local_27;
        out[_e160] = (_e147 * 0.25) + 10.0;
    }
}
