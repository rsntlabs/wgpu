#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) readonly buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_2_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_2Compute { type_3 _group_0_binding_2_cs; };


uint kind(float value_1) {
    return 1u;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint counter = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
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
    bool _e38 = (_e23 > 2139095040u);
    local = (((_e23 == 0u) || _e38) ? (_e38 ? 2143289344u : 4286578688u) : ((_e23 == 2139095040u) ? 2139095040u : floatBitsToUint(float(((_e25 == 0u) ? (-118 - int(uint(31 - findMSB(_e23)))) : (int(_e25) - 127))))));
    uint _e50 = local;
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e50));
    value = 0.0;
    value = value_2;
    uint _e58 = counter;
    counter = (_e58 + uint(1));
    float _e62 = value;
    uint _e65 = (floatBitsToUint(_e62) & 2147483647u);
    uint _e67 = (_e65 >> 23u);
    bool _e80 = (_e65 > 2139095040u);
    local_2 = (((_e65 == 0u) || _e80) ? (_e80 ? 2143289344u : 4286578688u) : ((_e65 == 2139095040u) ? 2139095040u : floatBitsToUint(float(((_e67 == 0u) ? (-118 - int(uint(31 - findMSB(_e65)))) : (int(_e67) - 127))))));
    uint _e92 = local_2;
    local_1 = uint((base + 1u));
    uint _e99 = local_1;
    _group_0_binding_1_cs[_e99] = floatBitsToUint(uintBitsToFloat(_e92));
    uint _e101 = counter;
    local_3 = uint((base + 2u));
    uint _e106 = local_3;
    _group_0_binding_1_cs[_e106] = _e101;
    uint _e110 = (floatBitsToUint(value_2) & 2147483647u);
    uint _e112 = (_e110 >> 23u);
    bool _e125 = (_e110 > 2139095040u);
    local_5 = (((_e110 == 0u) || _e125) ? (_e125 ? 2143289344u : 4286578688u) : ((_e110 == 2139095040u) ? 2139095040u : floatBitsToUint(float(((_e112 == 0u) ? (-118 - int(uint(31 - findMSB(_e110)))) : (int(_e112) - 127))))));
    uint _e137 = local_5;
    uint _e139 = kind(uintBitsToFloat(_e137));
    local_4 = uint((base + 3u));
    uint _e144 = local_4;
    _group_0_binding_1_cs[_e144] = _e139;
}

