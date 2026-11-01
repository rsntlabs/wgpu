#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };


uint _naga_floorf(uint input_bits) {
    uint _e5 = (input_bits & 2147483647u);
    bool _e7 = ((input_bits & 2147483648u) != 0u);
    uint _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e15 = (_e14 - 1u);
    uint _e19 = (input_bits & ~(_e15));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e7 ? 3212836864u : 0u)) : ((_e7 && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19))));
}

float floor_value(float value_1) {
    uint _e2 = _naga_floorf(floatBitsToUint(value_1));
    return uintBitsToFloat(_e2);
}

float floor_value_1(int value_2) {
    uint _e3 = _naga_floorf(floatBitsToUint(float(value_2)));
    return uintBitsToFloat(_e3);
}

float floor_value_2(uint value_3) {
    uint _e3 = _naga_floorf(floatBitsToUint(float(value_3)));
    return uintBitsToFloat(_e3);
}

float floor_value_3(bool value_4) {
    uint _e3 = _naga_floorf(floatBitsToUint(float(value_4)));
    return uintBitsToFloat(_e3);
}

int floorf(bool value_5) {
    int local_12 = 0;
    if (value_5) {
        local_12 = 7;
    } else {
        local_12 = 9;
    }
    int _e6 = local_12;
    return _e6;
}

float floorf_1(float first, float second) {
    return (first + second);
}

void main() {
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    float value = 0.0;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint _e2 = _naga_floorf(floatBitsToUint(0.0));
    _group_0_binding_0_cs[uint(0)] = floatBitsToUint(uintBitsToFloat(_e2));
    uint _e12 = _naga_floorf(floatBitsToUint(-(0.0)));
    _group_0_binding_0_cs[uint(1)] = floatBitsToUint(uintBitsToFloat(_e12));
    uint _e20 = _naga_floorf(floatBitsToUint(1.75));
    _group_0_binding_0_cs[uint(2)] = floatBitsToUint(uintBitsToFloat(_e20));
    uint _e29 = _naga_floorf(floatBitsToUint(-(1.25)));
    _group_0_binding_0_cs[uint(3)] = floatBitsToUint(uintBitsToFloat(_e29));
    float _e36 = floor_value_1(3);
    _group_0_binding_0_cs[uint(4)] = floatBitsToUint(_e36);
    float _e42 = floor_value_2(5u);
    _group_0_binding_0_cs[uint(5)] = floatBitsToUint(_e42);
    float _e48 = floor_value_3(true);
    _group_0_binding_0_cs[uint(6)] = floatBitsToUint(_e48);
    float _e54 = floor_value_3(false);
    _group_0_binding_0_cs[uint(7)] = floatBitsToUint(_e54);
    local = 1u;
    uint _e61 = local;
    uint _e64 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e61)));
    _group_0_binding_0_cs[uint(8)] = floatBitsToUint(uintBitsToFloat(_e64));
    local_1 = 2147483649u;
    uint _e72 = local_1;
    uint _e75 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e72)));
    _group_0_binding_0_cs[uint(9)] = floatBitsToUint(uintBitsToFloat(_e75));
    local_2 = 8388607u;
    uint _e83 = local_2;
    uint _e86 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e83)));
    _group_0_binding_0_cs[uint(10)] = floatBitsToUint(uintBitsToFloat(_e86));
    local_3 = 2155872255u;
    uint _e94 = local_3;
    uint _e97 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e94)));
    _group_0_binding_0_cs[uint(11)] = floatBitsToUint(uintBitsToFloat(_e97));
    uint _e105 = _naga_floorf(floatBitsToUint(3.4028235e38));
    _group_0_binding_0_cs[uint(12)] = floatBitsToUint(uintBitsToFloat(_e105));
    uint _e114 = _naga_floorf(floatBitsToUint(-(3.4028235e38)));
    _group_0_binding_0_cs[uint(13)] = floatBitsToUint(uintBitsToFloat(_e114));
    local_4 = 2139095039u;
    uint _e122 = local_4;
    uint _e125 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e122)));
    _group_0_binding_0_cs[uint(14)] = floatBitsToUint(uintBitsToFloat(_e125));
    local_5 = 4286578687u;
    uint _e133 = local_5;
    uint _e136 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e133)));
    _group_0_binding_0_cs[uint(15)] = floatBitsToUint(uintBitsToFloat(_e136));
    local_6 = 2139095040u;
    uint _e144 = local_6;
    uint _e147 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e144)));
    _group_0_binding_0_cs[uint(16)] = floatBitsToUint(uintBitsToFloat(_e147));
    local_7 = 4286578688u;
    uint _e155 = local_7;
    uint _e158 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e155)));
    _group_0_binding_0_cs[uint(17)] = floatBitsToUint(uintBitsToFloat(_e158));
    local_8 = 2143363909u;
    uint _e166 = local_8;
    uint _e169 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e166)));
    _group_0_binding_0_cs[uint(18)] = floatBitsToUint(uintBitsToFloat(_e169));
    local_9 = 2139095041u;
    uint _e177 = local_9;
    uint _e180 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e177)));
    _group_0_binding_0_cs[uint(19)] = floatBitsToUint(uintBitsToFloat(_e180));
    value = 2.75;
    float _e188 = value;
    value = (_e188 + float(1));
    float _e192 = floor_value(_e188);
    _group_0_binding_0_cs[uint(20)] = floatBitsToUint(_e192);
    float _e197 = value;
    _group_0_binding_0_cs[uint(21)] = floatBitsToUint(_e197);
    int _e203 = floorf(true);
    _group_0_binding_0_cs[uint(22)] = uint(_e203);
    int _e209 = floorf(false);
    _group_0_binding_0_cs[uint(23)] = uint(_e209);
    float _e216 = floorf_1(2.0, 3.0);
    _group_0_binding_0_cs[uint(24)] = floatBitsToUint(_e216);
    local_10 = 1258291199u;
    uint _e223 = local_10;
    uint _e226 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e223)));
    _group_0_binding_0_cs[uint(25)] = floatBitsToUint(uintBitsToFloat(_e226));
    local_11 = 3405774847u;
    uint _e234 = local_11;
    uint _e237 = _naga_floorf(floatBitsToUint(uintBitsToFloat(_e234)));
    _group_0_binding_0_cs[uint(26)] = floatBitsToUint(uintBitsToFloat(_e237));
    float _e244 = floor_value_2(4294967295u);
    _group_0_binding_0_cs[uint(27)] = floatBitsToUint(_e244);
    float _e253 = floor_value_1((-(2147483647) - 1));
    _group_0_binding_0_cs[uint(28)] = floatBitsToUint(_e253);
    uint _e260 = _naga_floorf(floatBitsToUint(10000000000.0));
    _group_0_binding_0_cs[uint(29)] = floatBitsToUint(uintBitsToFloat(_e260));
}

