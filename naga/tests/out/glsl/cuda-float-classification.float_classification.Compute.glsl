#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


int finite_value(float value) {
    return int(((floatBitsToUint(value) & 2147483647u) < 2139095040u));
}

int infinite_value(float value_1) {
    return int(((floatBitsToUint(value_1) & 2147483647u) == 2139095040u));
}

int nan_value(float value_2) {
    return int(((floatBitsToUint(value_2) & 2147483647u) > 2139095040u));
}

int sign_value(float value_3) {
    return int(((floatBitsToUint(value_3) & 2147483648u) != 0u));
}

uint result_kind(int value_4) {
    return (10u + uint(value_4));
}

int signbit(bool value_5) {
    int local_44 = 0;
    if (value_5) {
        local_44 = 7;
    } else {
        local_44 = 9;
    }
    int _e6 = local_44;
    return _e6;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    int cursor = 0;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    bool local_16 = false;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    int alias_cursor = 0;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 544u)) {
        return;
    }
    uint bits = _group_0_binding_0_cs[index];
    uint base = (4u + (index * 33u));
    float value_6 = uintBitsToFloat(bits);
    _group_0_binding_1_cs[base] = uint(int(((floatBitsToUint(value_6) & 2147483647u) < 2139095040u)));
    local = uint((base + 1u));
    uint _e37 = local;
    _group_0_binding_1_cs[_e37] = uint(int(((floatBitsToUint(value_6) & 2147483647u) == 2139095040u)));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    _group_0_binding_1_cs[_e50] = uint(int(((floatBitsToUint(value_6) & 2147483647u) > 2139095040u)));
    local_2 = uint((base + 3u));
    uint _e63 = local_2;
    _group_0_binding_1_cs[_e63] = uint(int(((floatBitsToUint(value_6) & 2147483648u) != 0u)));
    int _e65 = finite_value(value_6);
    local_3 = uint((base + 4u));
    uint _e71 = local_3;
    _group_0_binding_1_cs[_e71] = uint(_e65);
    int _e73 = infinite_value(value_6);
    local_4 = uint((base + 5u));
    uint _e79 = local_4;
    _group_0_binding_1_cs[_e79] = uint(_e73);
    int _e81 = nan_value(value_6);
    local_5 = uint((base + 6u));
    uint _e87 = local_5;
    _group_0_binding_1_cs[_e87] = uint(_e81);
    int _e89 = sign_value(value_6);
    local_6 = uint((base + 7u));
    uint _e95 = local_6;
    _group_0_binding_1_cs[_e95] = uint(_e89);
    uint _e103 = result_kind(int(((floatBitsToUint(value_6) & 2147483647u) > 2139095040u)));
    local_7 = uint((base + 8u));
    uint _e108 = local_7;
    _group_0_binding_1_cs[_e108] = _e103;
    cursor = 0;
    int _e112 = cursor;
    cursor = (_e112 + 1);
    local_9 = uint((index + uint(_e112)));
    uint _e119 = local_9;
    uint _e121 = _group_0_binding_0_cs[_e119];
    local_8 = uint((base + 9u));
    uint _e134 = local_8;
    _group_0_binding_1_cs[_e134] = uint(int(((floatBitsToUint(uintBitsToFloat(_e121)) & 2147483648u) != 0u)));
    int _e136 = cursor;
    local_10 = uint((base + 10u));
    uint _e142 = local_10;
    _group_0_binding_1_cs[_e142] = uint(_e136);
    int _e145 = signbit(true);
    local_11 = uint((base + 11u));
    uint _e151 = local_11;
    _group_0_binding_1_cs[_e151] = uint(_e145);
    if ((int(((floatBitsToUint(value_6) & 2147483647u) < 2139095040u)) != 0)) {
        local_12 = uint((base + 12u));
        uint _e165 = local_12;
        local_41 = _e165;
        uint _e167 = local_41;
        _group_0_binding_1_cs[_e167] = 2u;
    } else {
        if ((int(((floatBitsToUint(value_6) & 2147483647u) == 2139095040u)) != 0)) {
            local_13 = uint((base + 12u));
            uint _e182 = local_13;
            local_42 = _e182;
            uint _e184 = local_42;
            _group_0_binding_1_cs[_e184] = 3u;
        } else {
            local_14 = uint((base + 12u));
            uint _e191 = local_14;
            local_43 = _e191;
            uint _e193 = local_43;
            _group_0_binding_1_cs[_e193] = 4u;
        }
    }
    local_16 = false;
    if (false) {
        int _e198 = cursor;
        cursor = (_e198 + 1);
        local_16 = (int(((floatBitsToUint((value_6 + float(_e198))) & 2147483647u) > 2139095040u)) != 0);
    }
    bool _e211 = local_16;
    local_15 = uint((base + 13u));
    uint _e217 = local_15;
    _group_0_binding_1_cs[_e217] = uint(_e211);
    int _e219 = cursor;
    local_17 = uint((base + 14u));
    uint _e225 = local_17;
    _group_0_binding_1_cs[_e225] = uint(_e219);
    local_18 = uint((base + 15u));
    uint _e240 = local_18;
    _group_0_binding_1_cs[_e240] = uint(int(((floatBitsToUint(float(3)) & 2147483647u) < 2139095040u)));
    local_19 = uint((base + 16u));
    uint _e254 = local_19;
    _group_0_binding_1_cs[_e254] = uint(int(((floatBitsToUint(0.0) & 2147483648u) != 0u)));
    local_20 = uint((base + 17u));
    uint _e269 = local_20;
    _group_0_binding_1_cs[_e269] = uint(int(((floatBitsToUint(-(0.0)) & 2147483648u) != 0u)));
    int _e273 = sign_value(-(0.0));
    local_21 = uint((base + 18u));
    uint _e279 = local_21;
    _group_0_binding_1_cs[_e279] = uint(_e273);
    local_23 = 2139095040u;
    uint _e283 = local_23;
    local_22 = uint((base + 19u));
    uint _e296 = local_22;
    _group_0_binding_1_cs[_e296] = uint(int(((floatBitsToUint(uintBitsToFloat(_e283)) & 2147483647u) < 2139095040u)));
    local_25 = 2139095040u;
    uint _e300 = local_25;
    local_24 = uint((base + 20u));
    uint _e313 = local_24;
    _group_0_binding_1_cs[_e313] = uint(int(((floatBitsToUint(uintBitsToFloat(_e300)) & 2147483647u) == 2139095040u)));
    local_27 = 4286578689u;
    uint _e317 = local_27;
    local_26 = uint((base + 21u));
    uint _e330 = local_26;
    _group_0_binding_1_cs[_e330] = uint(int(((floatBitsToUint(uintBitsToFloat(_e317)) & 2147483647u) > 2139095040u)));
    local_29 = 4286578689u;
    uint _e334 = local_29;
    local_28 = uint((base + 22u));
    uint _e347 = local_28;
    _group_0_binding_1_cs[_e347] = uint(int(((floatBitsToUint(uintBitsToFloat(_e334)) & 2147483648u) != 0u)));
    local_30 = uint((base + 23u));
    uint _e360 = local_30;
    _group_0_binding_1_cs[_e360] = uint(int(((floatBitsToUint(value_6) & 2147483647u) < 2139095040u)));
    local_31 = uint((base + 24u));
    uint _e373 = local_31;
    _group_0_binding_1_cs[_e373] = uint(int(((floatBitsToUint(value_6) & 2147483647u) == 2139095040u)));
    local_32 = uint((base + 25u));
    uint _e386 = local_32;
    _group_0_binding_1_cs[_e386] = uint(int(((floatBitsToUint(value_6) & 2147483647u) > 2139095040u)));
    local_33 = uint((base + 26u));
    uint _e399 = local_33;
    _group_0_binding_1_cs[_e399] = uint(int(((floatBitsToUint(value_6) & 2147483648u) != 0u)));
    local_34 = uint((base + 27u));
    uint _e414 = local_34;
    _group_0_binding_1_cs[_e414] = uint(int(((floatBitsToUint(float(3)) & 2147483647u) < 2139095040u)));
    local_35 = uint((base + 28u));
    uint _e429 = local_35;
    _group_0_binding_1_cs[_e429] = uint(int(((floatBitsToUint(float(0u)) & 2147483647u) == 2139095040u)));
    local_36 = uint((base + 29u));
    uint _e444 = local_36;
    _group_0_binding_1_cs[_e444] = uint(int(((floatBitsToUint(float(true)) & 2147483647u) > 2139095040u)));
    local_37 = uint((base + 30u));
    uint _e460 = local_37;
    _group_0_binding_1_cs[_e460] = uint(int(((floatBitsToUint(float(-(3))) & 2147483648u) != 0u)));
    alias_cursor = 0;
    int _e464 = alias_cursor;
    alias_cursor = (_e464 + 1);
    local_39 = uint((index + uint(_e464)));
    uint _e471 = local_39;
    uint _e473 = _group_0_binding_0_cs[_e471];
    local_38 = uint((base + 31u));
    uint _e486 = local_38;
    _group_0_binding_1_cs[_e486] = uint(int(((floatBitsToUint(uintBitsToFloat(_e473)) & 2147483648u) != 0u)));
    int _e488 = alias_cursor;
    local_40 = uint((base + 32u));
    uint _e494 = local_40;
    _group_0_binding_1_cs[_e494] = uint(_e488);
}

