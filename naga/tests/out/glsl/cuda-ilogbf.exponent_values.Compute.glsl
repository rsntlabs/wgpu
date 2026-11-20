#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_4 {
    uint value;
};
layout(std430) readonly buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_4_block_2Compute { type_4 _group_0_binding_2_cs; };


uint kind(int value_1) {
    return 2u;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint counter = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    float value = 0.0;
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 4u));
    uint _e17 = _group_0_binding_0_cs[index];
    float value_2 = uintBitsToFloat(_e17);
    counter = 0u;
    uint _e23 = (floatBitsToUint(value_2) & 2147483647u);
    uint _e25 = (_e23 >> 23u);
    _group_0_binding_1_cs[base] = uint((((_e23 == 0u) || (_e23 > 2139095040u)) ? -2147483648 : ((_e23 == 2139095040u) ? 2147483647 : ((_e25 == 0u) ? (-118 - int(uint(31 - findMSB(_e23)))) : (int(_e25) - 127)))));
    value = 0.0;
    value = value_2;
    uint _e51 = counter;
    counter = (_e51 + uint(1));
    float _e55 = value;
    uint _e58 = (floatBitsToUint(_e55) & 2147483647u);
    uint _e60 = (_e58 >> 23u);
    local = uint((base + 1u));
    uint _e85 = local;
    _group_0_binding_1_cs[_e85] = uint((((_e58 == 0u) || (_e58 > 2139095040u)) ? -2147483648 : ((_e58 == 2139095040u) ? 2147483647 : ((_e60 == 0u) ? (-118 - int(uint(31 - findMSB(_e58)))) : (int(_e60) - 127)))));
    uint _e87 = counter;
    local_1 = uint((base + 2u));
    uint _e92 = local_1;
    _group_0_binding_1_cs[_e92] = _e87;
    uint _e96 = (floatBitsToUint(value_2) & 2147483647u);
    uint _e98 = (_e96 >> 23u);
    uint _e118 = kind((((_e96 == 0u) || (_e96 > 2139095040u)) ? -2147483648 : ((_e96 == 2139095040u) ? 2147483647 : ((_e98 == 0u) ? (-118 - int(uint(31 - findMSB(_e96)))) : (int(_e98) - 127)))));
    local_2 = uint((base + 3u));
    uint _e123 = local_2;
    _group_0_binding_1_cs[_e123] = _e118;
}

