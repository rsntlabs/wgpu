#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_3_block_0Compute { uvec2 _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint kind(float value_2) {
    return 1u;
}

uint _naga_nextafterf(uint from_bits, uint toward_bits) {
    uint _e8 = (from_bits & 2147483647u);
    uint _e9 = (toward_bits & 2147483647u);
    if (((_e8 > 2139095040u) || (_e9 > 2139095040u))) {
        return 2143289344u;
    }
    bool _e13 = (_e8 == 0u);
    if (((_e13 && (_e9 == 0u)) || (from_bits == toward_bits))) {
        return toward_bits;
    }
    if (_e13) {
        return ((toward_bits & 2147483648u) | 1u);
    }
    return ((((from_bits ^ toward_bits) < 2147483648u) && (_e9 > _e8)) ? (from_bits + 1u) : (from_bits - 1u));
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint counter = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    float value = 0.0;
    float value_1 = 0.0;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= 24u)) {
        return;
    }
    uint base = (4u + (index * 4u));
    uint _e16 = _group_0_binding_0_cs[index].x;
    float x = uintBitsToFloat(_e16);
    uint _e20 = _group_0_binding_0_cs[index].y;
    float y = uintBitsToFloat(_e20);
    counter = 0u;
    uint _e26 = _naga_nextafterf(floatBitsToUint(x), floatBitsToUint(y));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e26));
    value = 0.0;
    value = x;
    uint _e34 = counter;
    counter = (_e34 + uint(1));
    float _e38 = value;
    value_1 = 0.0;
    value_1 = y;
    uint _e42 = counter;
    counter = (_e42 + uint(1));
    float _e46 = value_1;
    uint _e49 = _naga_nextafterf(floatBitsToUint(_e38), floatBitsToUint(_e46));
    local = uint((base + 1u));
    uint _e56 = local;
    _group_0_binding_1_cs[_e56] = floatBitsToUint(uintBitsToFloat(_e49));
    uint _e58 = counter;
    local_1 = uint((base + 2u));
    uint _e63 = local_1;
    _group_0_binding_1_cs[_e63] = _e58;
    uint _e67 = _naga_nextafterf(floatBitsToUint(x), floatBitsToUint(y));
    uint _e69 = kind(uintBitsToFloat(_e67));
    local_2 = uint((base + 3u));
    uint _e74 = local_2;
    _group_0_binding_1_cs[_e74] = _e69;
}

