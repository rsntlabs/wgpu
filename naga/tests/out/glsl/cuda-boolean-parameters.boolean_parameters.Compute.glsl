#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std140) uniform type_3_block_0Compute { type_3 _group_0_binding_0_cs; };

layout(std140) uniform type_3_block_1Compute { type_3 _group_0_binding_1_cs; };

layout(std430) buffer type_4_block_2Compute { uint _group_0_binding_2_cs[]; };


int flag_overload(bool value) {
    int local_8 = 0;
    if (value) {
        local_8 = 31;
    } else {
        local_8 = 17;
    }
    int _e6 = local_8;
    return _e6;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    bool enabled = false;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    int local_7 = 0;
    uint _e3 = _group_0_binding_0_cs.value;
    enabled = ((_e3 & 255u) != 0u);
    uint _e11 = _group_0_binding_1_cs.value;
    bool frozen_1 = ((_e11 & 255u) != 0u);
    uint index = (4u + (threadIdx.x * 8u));
    bool original = enabled;
    bool _e22 = enabled;
    _group_0_binding_2_cs[index] = uint(_e22);
    bool _e26 = enabled;
    int _e27 = flag_overload(_e26);
    local = uint((index + 1u));
    uint _e33 = local;
    _group_0_binding_2_cs[_e33] = uint(_e27);
    bool _e35 = enabled;
    enabled = !(_e35);
    bool _e37 = enabled;
    local_1 = uint((index + 2u));
    uint _e43 = local_1;
    _group_0_binding_2_cs[_e43] = uint(_e37);
    bool _e45 = enabled;
    int _e46 = flag_overload(_e45);
    local_2 = uint((index + 3u));
    uint _e52 = local_2;
    _group_0_binding_2_cs[_e52] = uint(_e46);
    local_3 = uint((index + 4u));
    uint _e59 = local_3;
    _group_0_binding_2_cs[_e59] = uint(frozen_1);
    local_7 = 0;
    if (frozen_1) {
        local_7 = 7;
    } else {
        local_7 = 9;
    }
    int _e68 = local_7;
    local_4 = uint((index + 5u));
    uint _e74 = local_4;
    _group_0_binding_2_cs[_e74] = uint(_e68);
    int _e76 = flag_overload(original);
    local_5 = uint((index + 6u));
    uint _e82 = local_5;
    _group_0_binding_2_cs[_e82] = uint(_e76);
    bool _e84 = enabled;
    local_6 = uint((index + 7u));
    uint _e93 = local_6;
    _group_0_binding_2_cs[_e93] = uint((int(_e84) != int(frozen_1)));
}

