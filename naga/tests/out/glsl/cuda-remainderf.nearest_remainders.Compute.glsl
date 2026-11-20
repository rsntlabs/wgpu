#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_6 {
    uint value;
};
layout(std430) readonly buffer type_4_block_0Compute { uvec2 _group_0_binding_0_cs[]; };

layout(std430) buffer type_5_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_6_block_2Compute { type_6 _group_0_binding_2_cs; };


uint kind(float value_2) {
    return 1u;
}

uint _naga_remainderf(uint dividend_bits, uint divisor_bits) {
    uint dividend_significand = 0u;
    int dividend_exponent = 0;
    uint divisor_significand = 0u;
    int divisor_exponent = 0;
    uint remainder = 0u;
    uint remaining_bits = 0u;
    uint _e8 = (dividend_bits & 2147483647u);
    uint _e9 = (divisor_bits & 2147483647u);
    uint _e10 = (dividend_bits & 2147483648u);
    if (((_e8 >= 2139095040u) || ((_e9 > 2139095040u) || (_e9 == 0u)))) {
        return 2143289344u;
    }
    if (((_e8 == 0u) || (_e9 == 2139095040u))) {
        return dividend_bits;
    }
    if ((_e8 == _e9)) {
        return _e10;
    }
    uint _e24 = (_e8 & 8388607u);
    uint _e25 = (_e8 >> 23u);
    dividend_significand = (_e24 | 8388608u);
    dividend_exponent = (int(_e25) - 127);
    if ((_e25 == 0u)) {
        uint _e35 = (uint(31 - findMSB(_e24)) - 8u);
        dividend_significand = (_e24 << _e35);
        dividend_exponent = (-126 - int(_e35));
    }
    uint _e40 = dividend_significand;
    int _e41 = dividend_exponent;
    uint _e46 = (_e9 & 8388607u);
    uint _e47 = (_e9 >> 23u);
    divisor_significand = (_e46 | 8388608u);
    divisor_exponent = (int(_e47) - 127);
    if ((_e47 == 0u)) {
        uint _e57 = (uint(31 - findMSB(_e46)) - 8u);
        divisor_significand = (_e46 << _e57);
        divisor_exponent = (-126 - int(_e57));
    }
    uint _e62 = divisor_significand;
    int _e63 = divisor_exponent;
    remainder = _e40;
    int _e66 = (_e41 - _e63);
    if ((_e66 < -1)) {
        return dividend_bits;
    }
    bool _e70 = (_e66 == -1);
    uint _e72 = (_e70 ? (_e62 << 1u) : _e62);
    remaining_bits = uint((_e70 ? 0 : _e66));
    while(true) {
        uint _e76 = remaining_bits;
        if ((_e76 == 0u)) {
            break;
        }
        uint _e78 = remainder;
        remainder = (((_e78 >= _e72) ? (_e78 - _e72) : _e78) << 1u);
        remaining_bits = (_e76 - 1u);
    }
    uint _e84 = remainder;
    bool _e85 = (_e84 >= _e72);
    uint _e87 = (_e85 ? (_e84 - _e72) : _e84);
    uint _e88 = (_e87 + _e87);
    bool _e92 = ((_e88 > _e72) || ((_e88 == _e72) && _e85));
    uint _e96 = (_e92 ? (_e72 - _e87) : _e87);
    uint _e97 = (_e92 ? (_e10 ^ 2147483648u) : _e10);
    if ((_e96 == 0u)) {
        return _e97;
    }
    uint _e101 = (uint(31 - findMSB(_e96)) - 8u);
    uint _e102 = (_e96 << _e101);
    int _e104 = ((_e70 ? _e41 : _e63) - int(_e101));
    return (_e97 | ((_e104 >= -126) ? ((uint((_e104 + 127)) << 23u) | (_e102 & 8388607u)) : (_e102 >> (uint((-126 - _e104)) & 31u))));
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
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 4u));
    uint _e18 = _group_0_binding_0_cs[index].x;
    float x = uintBitsToFloat(_e18);
    uint _e22 = _group_0_binding_0_cs[index].y;
    float y = uintBitsToFloat(_e22);
    counter = 0u;
    uint _e28 = _naga_remainderf(floatBitsToUint(x), floatBitsToUint(y));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e28));
    value = 0.0;
    value = x;
    uint _e36 = counter;
    counter = (_e36 + uint(1));
    float _e40 = value;
    value_1 = 0.0;
    value_1 = y;
    uint _e44 = counter;
    counter = (_e44 + uint(1));
    float _e48 = value_1;
    uint _e51 = _naga_remainderf(floatBitsToUint(_e40), floatBitsToUint(_e48));
    local = uint((base + 1u));
    uint _e58 = local;
    _group_0_binding_1_cs[_e58] = floatBitsToUint(uintBitsToFloat(_e51));
    uint _e60 = counter;
    local_1 = uint((base + 2u));
    uint _e65 = local_1;
    _group_0_binding_1_cs[_e65] = _e60;
    uint _e69 = _naga_remainderf(floatBitsToUint(x), floatBitsToUint(y));
    uint _e71 = kind(uintBitsToFloat(_e69));
    local_2 = uint((base + 3u));
    uint _e76 = local_2;
    _group_0_binding_1_cs[_e76] = _e71;
}

