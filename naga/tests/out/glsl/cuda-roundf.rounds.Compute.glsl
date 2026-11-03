#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };


uint _naga_roundf(uint input_bits) {
    uint _e5 = (input_bits & 2147483647u);
    uint _e6 = (input_bits & 2147483648u);
    uint _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e14 = (_e13 - 1u);
    uint _e15 = (input_bits & _e14);
    uint _e18 = (input_bits & ~(_e14));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : ((_e5 >= 1056964608u) ? (_e6 | 1065353216u) : _e6)) : (((_e15 >= (_e13 >> 1u)) && (_e15 != 0u)) ? (_e18 + _e13) : _e18))));
}

float rounded(float value_1) {
    uint _e2 = _naga_roundf(floatBitsToUint(value_1));
    return uintBitsToFloat(_e2);
}

int roundf(bool value_2) {
    int local_18 = 0;
    if (value_2) {
        local_18 = 7;
    } else {
        local_18 = 9;
    }
    int _e6 = local_18;
    return _e6;
}

float roundf_1(float first, float second) {
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
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint _e2 = _naga_roundf(floatBitsToUint(0.0));
    _group_0_binding_0_cs[uint(0)] = floatBitsToUint(uintBitsToFloat(_e2));
    uint _e12 = _naga_roundf(floatBitsToUint(-(0.0)));
    _group_0_binding_0_cs[uint(1)] = floatBitsToUint(uintBitsToFloat(_e12));
    uint _e20 = _naga_roundf(floatBitsToUint(1.25));
    _group_0_binding_0_cs[uint(2)] = floatBitsToUint(uintBitsToFloat(_e20));
    uint _e29 = _naga_roundf(floatBitsToUint(-(1.75)));
    _group_0_binding_0_cs[uint(3)] = floatBitsToUint(uintBitsToFloat(_e29));
    float _e37 = rounded(float(3));
    _group_0_binding_0_cs[uint(4)] = floatBitsToUint(_e37);
    float _e44 = rounded(float(5u));
    _group_0_binding_0_cs[uint(5)] = floatBitsToUint(_e44);
    int _e50 = roundf(true);
    _group_0_binding_0_cs[uint(6)] = uint(_e50);
    int _e56 = roundf(false);
    _group_0_binding_0_cs[uint(7)] = uint(_e56);
    float _e63 = rounded(float(true));
    _group_0_binding_0_cs[uint(8)] = floatBitsToUint(_e63);
    float _e70 = rounded(float(false));
    _group_0_binding_0_cs[uint(9)] = floatBitsToUint(_e70);
    local = 1u;
    uint _e77 = local;
    uint _e80 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e77)));
    _group_0_binding_0_cs[uint(10)] = floatBitsToUint(uintBitsToFloat(_e80));
    local_1 = 2147483649u;
    uint _e88 = local_1;
    uint _e91 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e88)));
    _group_0_binding_0_cs[uint(11)] = floatBitsToUint(uintBitsToFloat(_e91));
    local_2 = 8388607u;
    uint _e99 = local_2;
    uint _e102 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e99)));
    _group_0_binding_0_cs[uint(12)] = floatBitsToUint(uintBitsToFloat(_e102));
    local_3 = 2155872255u;
    uint _e110 = local_3;
    uint _e113 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e110)));
    _group_0_binding_0_cs[uint(13)] = floatBitsToUint(uintBitsToFloat(_e113));
    uint _e122 = _naga_roundf(floatBitsToUint(-(0.25)));
    _group_0_binding_0_cs[uint(14)] = floatBitsToUint(uintBitsToFloat(_e122));
    local_4 = 1258291199u;
    uint _e130 = local_4;
    uint _e133 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e130)));
    _group_0_binding_0_cs[uint(15)] = floatBitsToUint(uintBitsToFloat(_e133));
    local_5 = 3405774847u;
    uint _e141 = local_5;
    uint _e144 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e141)));
    _group_0_binding_0_cs[uint(16)] = floatBitsToUint(uintBitsToFloat(_e144));
    uint _e152 = _naga_roundf(floatBitsToUint(3.4028235e38));
    _group_0_binding_0_cs[uint(17)] = floatBitsToUint(uintBitsToFloat(_e152));
    uint _e161 = _naga_roundf(floatBitsToUint(-(3.4028235e38)));
    _group_0_binding_0_cs[uint(18)] = floatBitsToUint(uintBitsToFloat(_e161));
    local_6 = 2139095040u;
    uint _e169 = local_6;
    uint _e172 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e169)));
    _group_0_binding_0_cs[uint(19)] = floatBitsToUint(uintBitsToFloat(_e172));
    local_7 = 4286578688u;
    uint _e180 = local_7;
    uint _e183 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e180)));
    _group_0_binding_0_cs[uint(20)] = floatBitsToUint(uintBitsToFloat(_e183));
    local_8 = 2143363909u;
    uint _e191 = local_8;
    uint _e194 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e191)));
    _group_0_binding_0_cs[uint(21)] = floatBitsToUint(uintBitsToFloat(_e194));
    local_9 = 4286578689u;
    uint _e202 = local_9;
    uint _e205 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e202)));
    _group_0_binding_0_cs[uint(22)] = floatBitsToUint(uintBitsToFloat(_e205));
    value = 2.25;
    float _e213 = value;
    value = (_e213 + float(1));
    float _e217 = rounded(_e213);
    _group_0_binding_0_cs[uint(23)] = floatBitsToUint(_e217);
    float _e222 = value;
    _group_0_binding_0_cs[uint(24)] = floatBitsToUint(_e222);
    float _e229 = roundf_1(2.0, 3.0);
    _group_0_binding_0_cs[uint(25)] = floatBitsToUint(_e229);
    float _e236 = rounded(float(4294967295u));
    _group_0_binding_0_cs[uint(26)] = floatBitsToUint(_e236);
    float _e246 = rounded(float((-(2147483647) - 1)));
    _group_0_binding_0_cs[uint(27)] = floatBitsToUint(_e246);
    uint _e253 = _naga_roundf(floatBitsToUint(10000000000.0));
    _group_0_binding_0_cs[uint(28)] = floatBitsToUint(uintBitsToFloat(_e253));
    uint _e261 = _naga_roundf(floatBitsToUint(1.5));
    _group_0_binding_0_cs[uint(29)] = floatBitsToUint(uintBitsToFloat(_e261));
    uint _e270 = _naga_roundf(floatBitsToUint(-(1.5)));
    _group_0_binding_0_cs[uint(30)] = floatBitsToUint(uintBitsToFloat(_e270));
    uint _e278 = _naga_roundf(floatBitsToUint(2.5));
    _group_0_binding_0_cs[uint(31)] = floatBitsToUint(uintBitsToFloat(_e278));
    uint _e287 = _naga_roundf(floatBitsToUint(-(2.5)));
    _group_0_binding_0_cs[uint(32)] = floatBitsToUint(uintBitsToFloat(_e287));
    local_10 = 1056964607u;
    uint _e295 = local_10;
    uint _e298 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e295)));
    _group_0_binding_0_cs[uint(33)] = floatBitsToUint(uintBitsToFloat(_e298));
    local_11 = 1056964609u;
    uint _e306 = local_11;
    uint _e309 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e306)));
    _group_0_binding_0_cs[uint(34)] = floatBitsToUint(uintBitsToFloat(_e309));
    local_12 = 3204448255u;
    uint _e317 = local_12;
    uint _e320 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e317)));
    _group_0_binding_0_cs[uint(35)] = floatBitsToUint(uintBitsToFloat(_e320));
    local_13 = 3204448257u;
    uint _e328 = local_13;
    uint _e331 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e328)));
    _group_0_binding_0_cs[uint(36)] = floatBitsToUint(uintBitsToFloat(_e331));
    local_14 = 1249902593u;
    uint _e339 = local_14;
    uint _e342 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e339)));
    _group_0_binding_0_cs[uint(37)] = floatBitsToUint(uintBitsToFloat(_e342));
    local_15 = 3397386241u;
    uint _e350 = local_15;
    uint _e353 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e350)));
    _group_0_binding_0_cs[uint(38)] = floatBitsToUint(uintBitsToFloat(_e353));
    local_16 = 1258291197u;
    uint _e361 = local_16;
    uint _e364 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e361)));
    _group_0_binding_0_cs[uint(39)] = floatBitsToUint(uintBitsToFloat(_e364));
    local_17 = 3405774845u;
    uint _e372 = local_17;
    uint _e375 = _naga_roundf(floatBitsToUint(uintBitsToFloat(_e372)));
    _group_0_binding_0_cs[uint(40)] = floatBitsToUint(uintBitsToFloat(_e375));
}

