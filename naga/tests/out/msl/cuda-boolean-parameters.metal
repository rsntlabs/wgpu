// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size2;
};

struct type_3 {
    uint value;
    char _pad1[12];
};
typedef uint type_4[1];

int flag_overload(
    bool value
) {
    int local_8 = {};
    if (value) {
        local_8 = 31;
    } else {
        local_8 = 17;
    }
    int _e6 = local_8;
    return _e6;
}

struct boolean_parametersInput {
};
kernel void boolean_parameters(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, constant type_3& enabled_1 [[buffer(0)]]
, constant type_3& frozen [[buffer(1)]]
, device type_4& output [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(3)]]
) {
    bool enabled = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    int local_7 = {};
    uint _e3 = enabled_1.value;
    enabled = (_e3 & 255u) != 0u;
    uint _e11 = frozen.value;
    bool frozen_1 = (_e11 & 255u) != 0u;
    uint index = 4u + (threadIdx.x * 8u);
    bool original = enabled;
    bool _e22 = enabled;
    output[index] = static_cast<uint>(_e22);
    bool _e26 = enabled;
    int _e27 = flag_overload(_e26);
    local = static_cast<uint>(index + 1u);
    uint _e33 = local;
    output[_e33] = static_cast<uint>(_e27);
    bool _e35 = enabled;
    enabled = !(_e35);
    bool _e37 = enabled;
    local_1 = static_cast<uint>(index + 2u);
    uint _e43 = local_1;
    output[_e43] = static_cast<uint>(_e37);
    bool _e45 = enabled;
    int _e46 = flag_overload(_e45);
    local_2 = static_cast<uint>(index + 3u);
    uint _e52 = local_2;
    output[_e52] = static_cast<uint>(_e46);
    local_3 = static_cast<uint>(index + 4u);
    uint _e59 = local_3;
    output[_e59] = static_cast<uint>(frozen_1);
    local_7 = int {};
    if (frozen_1) {
        local_7 = 7;
    } else {
        local_7 = 9;
    }
    int _e68 = local_7;
    local_4 = static_cast<uint>(index + 5u);
    uint _e74 = local_4;
    output[_e74] = static_cast<uint>(_e68);
    int _e76 = flag_overload(original);
    local_5 = static_cast<uint>(index + 6u);
    uint _e82 = local_5;
    output[_e82] = static_cast<uint>(_e76);
    bool _e84 = enabled;
    local_6 = static_cast<uint>(index + 7u);
    uint _e93 = local_6;
    output[_e93] = static_cast<uint>(static_cast<int>(_e84) != static_cast<int>(frozen_1));
}
