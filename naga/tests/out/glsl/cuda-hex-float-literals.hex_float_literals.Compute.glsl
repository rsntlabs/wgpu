#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

const float HexScale = 0.75;

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };


float identity(float value_1) {
    return value_1;
}

void main() {
    uint counter = 0u;
    float value = 0.0;
    counter = 0u;
    _group_0_binding_0_cs[uint(0)] = floatBitsToUint(0.0);
    _group_0_binding_0_cs[uint(1)] = floatBitsToUint(-(0.0));
    _group_0_binding_0_cs[uint(2)] = floatBitsToUint(1.0);
    _group_0_binding_0_cs[uint(3)] = floatBitsToUint(2.0);
    _group_0_binding_0_cs[uint(4)] = floatBitsToUint(1.0);
    _group_0_binding_0_cs[uint(5)] = floatBitsToUint(0.5);
    _group_0_binding_0_cs[uint(6)] = floatBitsToUint(3.0);
    _group_0_binding_0_cs[uint(7)] = floatBitsToUint(-(5.0));
    _group_0_binding_0_cs[uint(8)] = floatBitsToUint(1.1754944e-38);
    _group_0_binding_0_cs[uint(9)] = floatBitsToUint(1e-45);
    _group_0_binding_0_cs[uint(10)] = floatBitsToUint(1.1754942e-38);
    _group_0_binding_0_cs[uint(11)] = floatBitsToUint(1.1754944e-38);
    _group_0_binding_0_cs[uint(12)] = floatBitsToUint(0.0);
    _group_0_binding_0_cs[uint(13)] = floatBitsToUint(-(0.0));
    _group_0_binding_0_cs[uint(14)] = floatBitsToUint(1e-45);
    _group_0_binding_0_cs[uint(15)] = floatBitsToUint(0.0);
    _group_0_binding_0_cs[uint(16)] = floatBitsToUint(3e-45);
    _group_0_binding_0_cs[uint(17)] = floatBitsToUint(3e-45);
    _group_0_binding_0_cs[uint(18)] = floatBitsToUint(6e-45);
    _group_0_binding_0_cs[uint(19)] = floatBitsToUint(1.0);
    _group_0_binding_0_cs[uint(20)] = floatBitsToUint(1.0000002);
    _group_0_binding_0_cs[uint(21)] = floatBitsToUint(1.0000001);
    _group_0_binding_0_cs[uint(22)] = floatBitsToUint(1.0);
    _group_0_binding_0_cs[uint(23)] = floatBitsToUint(3.4028235e38);
    _group_0_binding_0_cs[uint(24)] = floatBitsToUint(-(3.4028235e38));
    _group_0_binding_0_cs[uint(25)] = floatBitsToUint(3.4028233e38);
    _group_0_binding_0_cs[uint(26)] = floatBitsToUint(3.4028235e38);
    _group_0_binding_0_cs[uint(27)] = floatBitsToUint(1e-45);
    _group_0_binding_0_cs[uint(28)] = floatBitsToUint(-(1e-45));
    _group_0_binding_0_cs[uint(29)] = floatBitsToUint(0.0);
    _group_0_binding_0_cs[uint(30)] = floatBitsToUint(72.8125);
    _group_0_binding_0_cs[uint(31)] = floatBitsToUint(0.25);
    _group_0_binding_0_cs[uint(32)] = floatBitsToUint(6.0);
    _group_0_binding_0_cs[uint(33)] = floatBitsToUint(4.0);
    _group_0_binding_0_cs[uint(34)] = floatBitsToUint(HexScale);
    float _e184 = identity(9.0);
    _group_0_binding_0_cs[uint(35)] = floatBitsToUint(_e184);
    value = 0.0;
    value = 3.0;
    uint _e193 = counter;
    counter = (_e193 + uint(1));
    float _e197 = value;
    _group_0_binding_0_cs[uint(36)] = floatBitsToUint(_e197);
    _group_0_binding_0_cs[uint(37)] = floatBitsToUint((0.25 + 0.5));
    _group_0_binding_0_cs[uint(38)] = floatBitsToUint(0.0);
    uint _e214 = counter;
    _group_0_binding_0_cs[uint(39)] = _e214;
}

