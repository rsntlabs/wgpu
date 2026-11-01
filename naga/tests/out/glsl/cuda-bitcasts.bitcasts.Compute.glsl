#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };


float from_bits(uint value_1) {
    return uintBitsToFloat(value_1);
}

int _float_as_int(int first, int second) {
    return (first + second);
}

void main() {
    int local = 0;
    int local_1 = 0;
    int local_2 = 0;
    int local_3 = 0;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    float value = 0.0;
    int signed_bits = 0;
    uint unsigned_bits = 0u;
    int local_8 = 0;
    uint local_9 = 0u;
    uint local_10 = 0u;
    _group_0_binding_0_cs[uint(0)] = uint(floatBitsToInt(float(true)));
    _group_0_binding_0_cs[uint(1)] = uint(floatBitsToInt(float(3)));
    _group_0_binding_0_cs[uint(2)] = uint(floatBitsToInt(float(5u)));
    _group_0_binding_0_cs[uint(3)] = uint(floatBitsToInt(2.75));
    _group_0_binding_0_cs[uint(4)] = floatBitsToUint(float(true));
    _group_0_binding_0_cs[uint(5)] = floatBitsToUint(float(3));
    _group_0_binding_0_cs[uint(6)] = floatBitsToUint(float(5u));
    _group_0_binding_0_cs[uint(7)] = floatBitsToUint(2.75);
    local = int(true);
    int _e54 = local;
    _group_0_binding_0_cs[uint(8)] = floatBitsToUint(intBitsToFloat(_e54));
    local_1 = 3;
    int _e62 = local_1;
    _group_0_binding_0_cs[uint(9)] = floatBitsToUint(intBitsToFloat(_e62));
    local_2 = int(5u);
    int _e71 = local_2;
    _group_0_binding_0_cs[uint(10)] = floatBitsToUint(intBitsToFloat(_e71));
    local_3 = int(2.75);
    int _e80 = local_3;
    _group_0_binding_0_cs[uint(11)] = floatBitsToUint(intBitsToFloat(_e80));
    local_4 = uint(true);
    uint _e89 = local_4;
    _group_0_binding_0_cs[uint(12)] = floatBitsToUint(uintBitsToFloat(_e89));
    local_5 = uint(3);
    uint _e98 = local_5;
    _group_0_binding_0_cs[uint(13)] = floatBitsToUint(uintBitsToFloat(_e98));
    local_6 = 5u;
    uint _e106 = local_6;
    _group_0_binding_0_cs[uint(14)] = floatBitsToUint(uintBitsToFloat(_e106));
    local_7 = uint(2.75);
    uint _e115 = local_7;
    _group_0_binding_0_cs[uint(15)] = floatBitsToUint(uintBitsToFloat(_e115));
    value = 1.5;
    float _e123 = value;
    value = (_e123 + float(1));
    _group_0_binding_0_cs[uint(16)] = uint(floatBitsToInt(_e123));
    float _e132 = value;
    _group_0_binding_0_cs[uint(17)] = floatBitsToUint(_e132);
    float _e137 = value;
    value = (_e137 + float(1));
    _group_0_binding_0_cs[uint(18)] = floatBitsToUint(_e137);
    float _e145 = value;
    _group_0_binding_0_cs[uint(19)] = floatBitsToUint(_e145);
    signed_bits = 1065353216;
    int _e152 = signed_bits;
    signed_bits = (_e152 + 1);
    _group_0_binding_0_cs[uint(20)] = floatBitsToUint(intBitsToFloat(_e152));
    int _e160 = signed_bits;
    _group_0_binding_0_cs[uint(21)] = uint(_e160);
    unsigned_bits = 1073741824u;
    uint _e167 = unsigned_bits;
    unsigned_bits = (_e167 + uint(1));
    _group_0_binding_0_cs[uint(22)] = floatBitsToUint(uintBitsToFloat(_e167));
    uint _e176 = unsigned_bits;
    _group_0_binding_0_cs[uint(23)] = _e176;
    int _e182 = _float_as_int(3, 4);
    _group_0_binding_0_cs[uint(24)] = uint(_e182);
    float _e188 = from_bits(3212836864u);
    _group_0_binding_0_cs[uint(25)] = floatBitsToUint(_e188);
    local_8 = 2139095040;
    int _e195 = local_8;
    _group_0_binding_0_cs[uint(26)] = floatBitsToUint(intBitsToFloat(_e195));
    local_9 = 2143363909u;
    uint _e203 = local_9;
    _group_0_binding_0_cs[uint(27)] = floatBitsToUint(uintBitsToFloat(_e203));
    local_10 = uint(1065353200.0);
    uint _e212 = local_10;
    _group_0_binding_0_cs[uint(28)] = floatBitsToUint(uintBitsToFloat(_e212));
    _group_0_binding_0_cs[uint(29)] = uint(floatBitsToInt(float(1u)));
}

