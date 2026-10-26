#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    uint value;
};
layout(std430) buffer type_4_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_4_block_1Compute { int _group_0_binding_1_cs[]; };

layout(std140) uniform type_5_block_2Compute { type_5 _group_0_binding_2_cs; };


bool classify(bool value_1) {
    bool value_2 = false;
    value_2 = value_1;
    bool _e2 = value_2;
    return !(_e2);
}

int classify_1(int value_3) {
    int value_4 = 0;
    value_4 = value_3;
    int _e3 = value_4;
    return (_e3 + 10);
}

uint classify_2(uint value_5) {
    uint value_6 = 0u;
    value_6 = value_5;
    uint _e3 = value_6;
    return (_e3 + 20u);
}

float classify_3(float value_7) {
    float value_8 = 0.0;
    value_8 = value_7;
    float _e3 = value_8;
    return ((_e3 * 1.5) + 0.5);
}

int rank(int left, float right) {
    int left_1 = 0;
    float right_1 = 0.0;
    left_1 = left;
    right_1 = right;
    int _e5 = left_1;
    float _e7 = right_1;
    return ((_e5 * 10) + int(_e7));
}

int rank_1(float left_2, int right_2) {
    float left_3 = 0.0;
    int right_3 = 0;
    left_3 = left_2;
    right_3 = right_2;
    float _e5 = left_3;
    int _e10 = right_3;
    return ((100 + (int(_e5) * 10)) + _e10);
}

int pair(float left_4, int right_4) {
    float left_5 = 0.0;
    int right_5 = 0;
    left_5 = left_4;
    right_5 = right_4;
    float _e4 = left_5;
    int _e8 = right_5;
    return ((int(_e4) * 10) + _e8);
}

int promote(uint left_6, float right_6) {
    uint left_7 = 0u;
    float right_7 = 0.0;
    left_7 = left_6;
    right_7 = right_6;
    uint _e5 = left_7;
    float _e8 = right_7;
    return ((200 + int(_e5)) + int(_e8));
}

void touch(bool stop, int value_9) {
    bool stop_1 = false;
    int value_10 = 0;
    stop_1 = stop;
    value_10 = value_9;
    bool _e4 = stop_1;
    if (_e4) {
        return;
    }
    int _e5 = value_10;
    int _e6 = classify_1(_e5);
    value_10 = _e6;
    return;
}

int touch_1(int value_11) {
    int value_12 = 0;
    value_12 = value_11;
    int _e2 = value_12;
    int _e3 = classify_1(_e2);
    return (_e3 + 3);
}

int stage(int value_13) {
    int value_14 = 0;
    value_14 = value_13;
    int _e3 = value_14;
    return (_e3 + 2);
}

int frozen(float value_15) {
    float value_16 = 0.0;
    value_16 = value_15;
    float _e2 = value_16;
    int _e4 = stage(int(_e2));
    return _e4;
}

int stage_1(float value_17) {
    float value_18 = 0.0;
    value_18 = value_17;
    float _e2 = value_18;
    return (int(_e2) + 100);
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    uint local_1 = 0u;
    uint n = 0u;
    uint i = 0u;
    uint base = 0u;
    int value = 0;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    bool choose = false;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    int effect = 0;
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
    int nested = 0;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    int argument = 0;
    int captured = 0;
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    int local_45 = 0;
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54 = 0u;
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58 = 0u;
    local = 0u;
    local_1 = 0u;
    uint _e8 = _group_0_binding_2_cs.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e16 = i;
    uint _e17 = n;
    if ((_e16 < _e17)) {
        uint _e19 = i;
        base = (_e19 * 13u);
        uint _e23 = local_1;
        local_2 = _e23;
        uint _e25 = local_2;
        local_3 = uint(_e25);
        uint _e28 = i;
        local_4 = uint(_e28);
        uint _e32 = local_3;
        uint _e33 = local_4;
        local_44 = uint((_e32 + _e33));
        uint _e38 = local_44;
        int _e40 = _group_0_binding_1_cs[_e38];
        local_45 = _e40;
        int _e41 = local_45;
        value = _e41;
        uint _e43 = i;
        choose = ((_e43 - 2u * (_e43 / 2u)) == 0u);
        bool _e49 = choose;
        bool _e50 = classify(_e49);
        uint _e51 = local;
        local_5 = _e51;
        uint _e53 = local_5;
        local_6 = uint(_e53);
        uint _e56 = base;
        local_7 = uint(_e56);
        uint _e61 = local_6;
        uint _e62 = local_7;
        local_46 = uint((_e61 + _e62));
        uint _e66 = local_46;
        _group_0_binding_0_cs[_e66] = int(_e50);
        int _e68 = value;
        int _e69 = classify_1(_e68);
        uint _e70 = local;
        local_8 = _e70;
        uint _e72 = local_8;
        local_9 = uint(_e72);
        uint _e75 = base;
        local_10 = uint((_e75 + 1u));
        uint _e80 = local_9;
        uint _e81 = local_10;
        local_47 = uint((_e80 + _e81));
        uint _e85 = local_47;
        _group_0_binding_0_cs[_e85] = _e69;
        int _e87 = value;
        uint _e91 = classify_2(uint((_e87 + 16)));
        uint _e92 = local;
        local_11 = _e92;
        uint _e94 = local_11;
        local_12 = uint(_e94);
        uint _e97 = base;
        local_13 = uint((_e97 + 2u));
        uint _e103 = local_12;
        uint _e104 = local_13;
        local_48 = uint((_e103 + _e104));
        uint _e108 = local_48;
        _group_0_binding_0_cs[_e108] = int(_e91);
        int _e110 = value;
        float _e112 = classify_3(float(_e110));
        uint _e113 = local;
        local_14 = _e113;
        uint _e115 = local_14;
        local_15 = uint(_e115);
        uint _e118 = base;
        local_16 = uint((_e118 + 3u));
        uint _e124 = local_15;
        uint _e125 = local_16;
        local_49 = uint((_e124 + _e125));
        uint _e129 = local_49;
        _group_0_binding_0_cs[_e129] = int(_e112);
        bool _e131 = choose;
        int _e132 = value;
        int _e137 = rank(int(_e131), (float(_e132) + 0.5));
        uint _e138 = local;
        local_17 = _e138;
        uint _e140 = local_17;
        local_18 = uint(_e140);
        uint _e143 = base;
        local_19 = uint((_e143 + 4u));
        uint _e148 = local_18;
        uint _e149 = local_19;
        local_50 = uint((_e148 + _e149));
        uint _e153 = local_50;
        _group_0_binding_0_cs[_e153] = _e137;
        int _e155 = value;
        bool _e159 = choose;
        int _e161 = rank_1((float(_e155) + 0.5), int(_e159));
        uint _e162 = local;
        local_20 = _e162;
        uint _e164 = local_20;
        local_21 = uint(_e164);
        uint _e167 = base;
        local_22 = uint((_e167 + 5u));
        uint _e172 = local_21;
        uint _e173 = local_22;
        local_51 = uint((_e172 + _e173));
        uint _e177 = local_51;
        _group_0_binding_0_cs[_e177] = _e161;
        int _e179 = value;
        int _e183 = value;
        int _e185 = promote(uint((_e179 + 16)), float(_e183));
        uint _e186 = local;
        local_23 = _e186;
        uint _e188 = local_23;
        local_24 = uint(_e188);
        uint _e191 = base;
        local_25 = uint((_e191 + 6u));
        uint _e196 = local_24;
        uint _e197 = local_25;
        local_52 = uint((_e196 + _e197));
        uint _e201 = local_52;
        _group_0_binding_0_cs[_e201] = _e185;
        int _e203 = value;
        effect = _e203;
        bool _e205 = choose;
        int _e206 = effect;
        effect = (_e206 + 1);
        touch(_e205, _e206);
        int _e209 = effect;
        uint _e210 = local;
        local_26 = _e210;
        uint _e212 = local_26;
        local_27 = uint(_e212);
        uint _e215 = base;
        local_28 = uint((_e215 + 7u));
        uint _e220 = local_27;
        uint _e221 = local_28;
        local_53 = uint((_e220 + _e221));
        uint _e225 = local_53;
        _group_0_binding_0_cs[_e225] = _e209;
        int _e227 = effect;
        int _e228 = touch_1(_e227);
        uint _e229 = local;
        local_29 = _e229;
        uint _e231 = local_29;
        local_30 = uint(_e231);
        uint _e234 = base;
        local_31 = uint((_e234 + 8u));
        uint _e239 = local_30;
        uint _e240 = local_31;
        local_54 = uint((_e239 + _e240));
        uint _e244 = local_54;
        _group_0_binding_0_cs[_e244] = _e228;
        int _e246 = value;
        int _e250 = frozen((float(_e246) + 0.75));
        uint _e251 = local;
        local_32 = _e251;
        uint _e253 = local_32;
        local_33 = uint(_e253);
        uint _e256 = base;
        local_34 = uint((_e256 + 9u));
        uint _e261 = local_33;
        uint _e262 = local_34;
        local_55 = uint((_e261 + _e262));
        uint _e266 = local_55;
        _group_0_binding_0_cs[_e266] = _e250;
        int _e268 = value;
        int _e272 = stage_1((float(_e268) + 0.75));
        uint _e273 = local;
        local_35 = _e273;
        uint _e275 = local_35;
        local_36 = uint(_e275);
        uint _e278 = base;
        local_37 = uint((_e278 + 10u));
        uint _e283 = local_36;
        uint _e284 = local_37;
        local_56 = uint((_e283 + _e284));
        uint _e288 = local_56;
        _group_0_binding_0_cs[_e288] = _e272;
        int _e290 = effect;
        effect = (_e290 + 1);
        int _e293 = classify_1(_e290);
        int _e294 = touch_1(_e293);
        nested = _e294;
        int _e296 = nested;
        int _e299 = effect;
        uint _e301 = local;
        local_38 = _e301;
        uint _e303 = local_38;
        local_39 = uint(_e303);
        uint _e306 = base;
        local_40 = uint((_e306 + 11u));
        uint _e311 = local_39;
        uint _e312 = local_40;
        local_57 = uint((_e311 + _e312));
        uint _e316 = local_57;
        _group_0_binding_0_cs[_e316] = ((_e296 * 10) + _e299);
        int _e318 = value;
        argument = (_e318 + 8);
        int _e322 = argument;
        int _e323 = argument;
        argument = (_e323 + 1);
        int _e327 = pair(float(_e322), _e323);
        captured = _e327;
        int _e329 = captured;
        int _e332 = argument;
        uint _e334 = local;
        local_41 = _e334;
        uint _e336 = local_41;
        local_42 = uint(_e336);
        uint _e339 = base;
        local_43 = uint((_e339 + 12u));
        uint _e344 = local_42;
        uint _e345 = local_43;
        local_58 = uint((_e344 + _e345));
        uint _e349 = local_58;
        _group_0_binding_0_cs[_e349] = ((_e329 * 100) + _e332);
    }
}

