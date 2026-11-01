#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };


uint _naga_sqrtf(uint input_bits) {
    uint significand = 0u;
    uint adjusted_exponent = 0u;
    uint upper_word = 0u;
    uint lower_word = 0u;
    uint root = 0u;
    uint remainder = 0u;
    uint iteration = 0u;
    uint _e5 = (input_bits & 2147483647u);
    if (((_e5 == 0u) || (input_bits == 2139095040u))) {
        return input_bits;
    }
    if ((((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u))) {
        return 2143289344u;
    }
    uint _e19 = (input_bits & 8388607u);
    uint _e20 = (_e5 >> 23u);
    significand = (_e19 | 8388608u);
    adjusted_exponent = (_e20 + 127u);
    if ((_e20 == 0u)) {
        uint _e28 = (uint(31 - findMSB(_e19)) - 8u);
        significand = (_e19 << _e28);
        adjusted_exponent = (128u - _e28);
    }
    uint _e32 = significand;
    uint _e33 = adjusted_exponent;
    uint _e34 = (_e33 & 1u);
    upper_word = (_e32 >> (9u - _e34));
    lower_word = (_e32 << (23u + _e34));
    root = 0u;
    remainder = 0u;
    iteration = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e72 = iteration;
            iteration = (_e72 + 1u);
        }
        loop_init = false;
        uint _e50 = iteration;
        if ((_e50 >= 24u)) {
            break;
        }
        uint _e52 = upper_word;
        uint _e53 = lower_word;
        uint _e54 = root;
        uint _e55 = remainder;
        uint _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        uint _e65 = ((_e54 << 2u) | 1u);
        bool _e66 = (_e63 >= _e65);
        uint _e69 = (_e54 << 1u);
        upper_word = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word = (_e53 << 2u);
        remainder = (_e66 ? (_e63 - _e65) : _e63);
        root = (_e66 ? (_e69 | 1u) : _e69);
    }
    uint _e74 = root;
    uint _e75 = remainder;
    return (((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u));
}

float root_1(float value_1) {
    uint _e2 = _naga_sqrtf(floatBitsToUint(value_1));
    return uintBitsToFloat(_e2);
}

float root_2(int value_2) {
    uint _e3 = _naga_sqrtf(floatBitsToUint(float(value_2)));
    return uintBitsToFloat(_e3);
}

float root_3(uint value_3) {
    uint _e3 = _naga_sqrtf(floatBitsToUint(float(value_3)));
    return uintBitsToFloat(_e3);
}

float root_4(bool value_4) {
    uint _e3 = _naga_sqrtf(floatBitsToUint(float(value_4)));
    return uintBitsToFloat(_e3);
}

int sqrtf(bool value_5) {
    int local_10 = 0;
    if (value_5) {
        local_10 = 7;
    } else {
        local_10 = 9;
    }
    int _e6 = local_10;
    return _e6;
}

float sqrtf_1(float first, float second) {
    return (first + second);
}

void main() {
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    float value = 0.0;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint _e2 = _naga_sqrtf(floatBitsToUint(0.0));
    _group_0_binding_0_cs[uint(0)] = floatBitsToUint(uintBitsToFloat(_e2));
    uint _e12 = _naga_sqrtf(floatBitsToUint(-(0.0)));
    _group_0_binding_0_cs[uint(1)] = floatBitsToUint(uintBitsToFloat(_e12));
    uint _e20 = _naga_sqrtf(floatBitsToUint(1.0));
    _group_0_binding_0_cs[uint(2)] = floatBitsToUint(uintBitsToFloat(_e20));
    float _e27 = root_2(4);
    _group_0_binding_0_cs[uint(3)] = floatBitsToUint(_e27);
    float _e33 = root_3(9u);
    _group_0_binding_0_cs[uint(4)] = floatBitsToUint(_e33);
    uint _e40 = _naga_sqrtf(floatBitsToUint(6.25));
    _group_0_binding_0_cs[uint(5)] = floatBitsToUint(uintBitsToFloat(_e40));
    uint _e48 = _naga_sqrtf(floatBitsToUint(2.0));
    _group_0_binding_0_cs[uint(6)] = floatBitsToUint(uintBitsToFloat(_e48));
    local = 1u;
    uint _e56 = local;
    uint _e59 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e56)));
    _group_0_binding_0_cs[uint(7)] = floatBitsToUint(uintBitsToFloat(_e59));
    local_1 = 8388607u;
    uint _e67 = local_1;
    uint _e70 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e67)));
    _group_0_binding_0_cs[uint(8)] = floatBitsToUint(uintBitsToFloat(_e70));
    local_2 = 8388608u;
    uint _e78 = local_2;
    uint _e81 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e78)));
    _group_0_binding_0_cs[uint(9)] = floatBitsToUint(uintBitsToFloat(_e81));
    local_3 = 2139095039u;
    uint _e89 = local_3;
    uint _e92 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e89)));
    _group_0_binding_0_cs[uint(10)] = floatBitsToUint(uintBitsToFloat(_e92));
    local_4 = 2139095040u;
    uint _e100 = local_4;
    uint _e103 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e100)));
    _group_0_binding_0_cs[uint(11)] = floatBitsToUint(uintBitsToFloat(_e103));
    uint _e112 = _naga_sqrtf(floatBitsToUint(-(1.0)));
    _group_0_binding_0_cs[uint(12)] = floatBitsToUint(uintBitsToFloat(_e112));
    local_5 = 2139095041u;
    uint _e120 = local_5;
    uint _e123 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e120)));
    _group_0_binding_0_cs[uint(13)] = floatBitsToUint(uintBitsToFloat(_e123));
    value = 4.0;
    float _e131 = value;
    value = (_e131 + float(1));
    float _e135 = root_1(_e131);
    _group_0_binding_0_cs[uint(14)] = floatBitsToUint(_e135);
    float _e140 = value;
    _group_0_binding_0_cs[uint(15)] = floatBitsToUint(_e140);
    int _e146 = sqrtf(true);
    _group_0_binding_0_cs[uint(16)] = uint(_e146);
    int _e152 = sqrtf(false);
    _group_0_binding_0_cs[uint(17)] = uint(_e152);
    float _e159 = sqrtf_1(2.0, 3.0);
    _group_0_binding_0_cs[uint(18)] = floatBitsToUint(_e159);
    local_6 = 1065353217u;
    uint _e166 = local_6;
    uint _e169 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e166)));
    _group_0_binding_0_cs[uint(19)] = floatBitsToUint(uintBitsToFloat(_e169));
    local_7 = 1065353218u;
    uint _e177 = local_7;
    uint _e180 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e177)));
    _group_0_binding_0_cs[uint(20)] = floatBitsToUint(uintBitsToFloat(_e180));
    local_8 = 1065353215u;
    uint _e188 = local_8;
    uint _e191 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e188)));
    _group_0_binding_0_cs[uint(21)] = floatBitsToUint(uintBitsToFloat(_e191));
    float _e198 = root_3(4294967295u);
    _group_0_binding_0_cs[uint(22)] = floatBitsToUint(_e198);
    float _e205 = root_2(-(4));
    _group_0_binding_0_cs[uint(23)] = floatBitsToUint(_e205);
    float _e211 = root_1(16.0);
    _group_0_binding_0_cs[uint(24)] = floatBitsToUint(_e211);
    uint _e218 = _naga_sqrtf(floatBitsToUint(0.25));
    _group_0_binding_0_cs[uint(25)] = floatBitsToUint(uintBitsToFloat(_e218));
    local_9 = 2147483649u;
    uint _e226 = local_9;
    uint _e229 = _naga_sqrtf(floatBitsToUint(uintBitsToFloat(_e226)));
    _group_0_binding_0_cs[uint(26)] = floatBitsToUint(uintBitsToFloat(_e229));
    float _e236 = root_4(false);
    _group_0_binding_0_cs[uint(27)] = floatBitsToUint(_e236);
    float _e242 = root_4(true);
    _group_0_binding_0_cs[uint(28)] = floatBitsToUint(_e242);
    float _e248 = root_1(0.5);
    _group_0_binding_0_cs[uint(29)] = floatBitsToUint(_e248);
}

