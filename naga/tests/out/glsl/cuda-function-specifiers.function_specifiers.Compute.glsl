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


int increment(int value_1) {
    int value_2 = 0;
    value_2 = value_1;
    int _e3 = value_2;
    value_2 = (_e3 + 2);
    int _e5 = value_2;
    return _e5;
}

int twice(int value_3) {
    int value_4 = 0;
    value_4 = value_3;
    int _e2 = value_4;
    int _e3 = increment(_e2);
    return (_e3 * 2);
}

int advance(int value_5) {
    int value_6 = 0;
    value_6 = value_5;
    int _e2 = value_6;
    int _e3 = twice(_e2);
    return (_e3 + 1);
}

int retreat(int value_7) {
    int value_8 = 0;
    value_8 = value_7;
    int _e3 = value_8;
    return (_e3 - 3);
}

float scaled(float value_9) {
    float value_10 = 0.0;
    value_10 = value_9;
    float _e3 = value_10;
    return ((_e3 * 1.5) + 0.5);
}

bool differs(int value_11, int other) {
    int value_12 = 0;
    int other_1 = 0;
    value_12 = value_11;
    other_1 = other;
    int _e4 = value_12;
    int _e5 = other_1;
    return (_e4 != _e5);
}

void consume(bool stop, int value_13) {
    bool stop_1 = false;
    int value_14 = 0;
    stop_1 = stop;
    value_14 = value_13;
    bool _e4 = stop_1;
    if (_e4) {
        return;
    }
    int _e5 = value_14;
    int _e6 = advance(_e5);
    value_14 = _e6;
    return;
}

void forward(bool stop_2, int value_15) {
    bool stop_3 = false;
    int value_16 = 0;
    stop_3 = stop_2;
    value_16 = value_15;
    bool _e4 = stop_3;
    int _e5 = value_16;
    int _e6 = retreat(_e5);
    consume(_e4, _e6);
    return;
}

uint plus_one(uint value_17) {
    uint value_18 = 0u;
    value_18 = value_17;
    uint _e3 = value_18;
    return (_e3 + 1u);
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
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47 = 0u;
    int local_48 = 0;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54 = 0u;
    int local_55 = 0;
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    int local_62 = 0;
    uint local_63 = 0u;
    uint local_64 = 0u;
    local = 0u;
    local_1 = 0u;
    uint _e8 = _group_0_binding_2_cs.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e16 = i;
    uint _e17 = n;
    if ((_e16 < _e17)) {
        uint _e19 = i;
        base = (_e19 * 12u);
        uint _e23 = local_1;
        local_2 = _e23;
        uint _e25 = local_2;
        local_3 = uint(_e25);
        uint _e28 = i;
        local_4 = uint(_e28);
        uint _e32 = local_3;
        uint _e33 = local_4;
        local_47 = uint((_e32 + _e33));
        uint _e38 = local_47;
        int _e40 = _group_0_binding_1_cs[_e38];
        local_48 = _e40;
        int _e41 = local_48;
        value = _e41;
        uint _e43 = i;
        choose = ((_e43 - 2u * (_e43 / 2u)) == 0u);
        int _e49 = value;
        int _e50 = increment(_e49);
        uint _e51 = local;
        local_5 = _e51;
        uint _e53 = local_5;
        local_6 = uint(_e53);
        uint _e56 = base;
        local_7 = uint(_e56);
        uint _e60 = local_6;
        uint _e61 = local_7;
        local_49 = uint((_e60 + _e61));
        uint _e65 = local_49;
        _group_0_binding_0_cs[_e65] = _e50;
        int _e67 = value;
        int _e68 = twice(_e67);
        uint _e69 = local;
        local_8 = _e69;
        uint _e71 = local_8;
        local_9 = uint(_e71);
        uint _e74 = base;
        local_10 = uint((_e74 + 1u));
        uint _e79 = local_9;
        uint _e80 = local_10;
        local_50 = uint((_e79 + _e80));
        uint _e84 = local_50;
        _group_0_binding_0_cs[_e84] = _e68;
        int _e86 = value;
        int _e87 = advance(_e86);
        uint _e88 = local;
        local_11 = _e88;
        uint _e90 = local_11;
        local_12 = uint(_e90);
        uint _e93 = base;
        local_13 = uint((_e93 + 2u));
        uint _e98 = local_12;
        uint _e99 = local_13;
        local_51 = uint((_e98 + _e99));
        uint _e103 = local_51;
        _group_0_binding_0_cs[_e103] = _e87;
        int _e105 = value;
        int _e106 = retreat(_e105);
        uint _e107 = local;
        local_14 = _e107;
        uint _e109 = local_14;
        local_15 = uint(_e109);
        uint _e112 = base;
        local_16 = uint((_e112 + 3u));
        uint _e117 = local_15;
        uint _e118 = local_16;
        local_52 = uint((_e117 + _e118));
        uint _e122 = local_52;
        _group_0_binding_0_cs[_e122] = _e106;
        int _e124 = value;
        float _e126 = scaled(float(_e124));
        uint _e127 = local;
        local_17 = _e127;
        uint _e129 = local_17;
        local_18 = uint(_e129);
        uint _e132 = base;
        local_19 = uint((_e132 + 4u));
        uint _e138 = local_18;
        uint _e139 = local_19;
        local_53 = uint((_e138 + _e139));
        uint _e143 = local_53;
        _group_0_binding_0_cs[_e143] = int(_e126);
        int _e145 = value;
        uint _e146 = local_1;
        local_23 = _e146;
        uint _e148 = local_23;
        local_24 = uint(_e148);
        uint _e151 = i;
        local_25 = uint(_e151);
        uint _e154 = local_24;
        uint _e155 = local_25;
        local_54 = uint((_e154 + _e155));
        uint _e160 = local_54;
        int _e162 = _group_0_binding_1_cs[_e160];
        local_55 = _e162;
        int _e163 = local_55;
        bool _e164 = differs(_e145, _e163);
        uint _e165 = local;
        local_20 = _e165;
        uint _e167 = local_20;
        local_21 = uint(_e167);
        uint _e170 = base;
        local_22 = uint((_e170 + 5u));
        uint _e176 = local_21;
        uint _e177 = local_22;
        local_56 = uint((_e176 + _e177));
        uint _e181 = local_56;
        _group_0_binding_0_cs[_e181] = int(_e164);
        int _e183 = value;
        effect = _e183;
        bool _e185 = choose;
        int _e186 = effect;
        effect = (_e186 + 1);
        consume(_e185, _e186);
        int _e189 = effect;
        uint _e190 = local;
        local_26 = _e190;
        uint _e192 = local_26;
        local_27 = uint(_e192);
        uint _e195 = base;
        local_28 = uint((_e195 + 6u));
        uint _e200 = local_27;
        uint _e201 = local_28;
        local_57 = uint((_e200 + _e201));
        uint _e205 = local_57;
        _group_0_binding_0_cs[_e205] = _e189;
        bool _e207 = choose;
        int _e209 = effect;
        effect = (_e209 + 1);
        forward(!(_e207), _e209);
        int _e212 = effect;
        uint _e213 = local;
        local_29 = _e213;
        uint _e215 = local_29;
        local_30 = uint(_e215);
        uint _e218 = base;
        local_31 = uint((_e218 + 7u));
        uint _e223 = local_30;
        uint _e224 = local_31;
        local_58 = uint((_e223 + _e224));
        uint _e228 = local_58;
        _group_0_binding_0_cs[_e228] = _e212;
        int _e230 = effect;
        int _e231 = advance(_e230);
        uint _e232 = local;
        local_32 = _e232;
        uint _e234 = local_32;
        local_33 = uint(_e234);
        uint _e237 = base;
        local_34 = uint((_e237 + 8u));
        uint _e242 = local_33;
        uint _e243 = local_34;
        local_59 = uint((_e242 + _e243));
        uint _e247 = local_59;
        _group_0_binding_0_cs[_e247] = _e231;
        int _e249 = effect;
        uint _e253 = plus_one(uint((_e249 + 16)));
        uint _e254 = local;
        local_35 = _e254;
        uint _e256 = local_35;
        local_36 = uint(_e256);
        uint _e259 = base;
        local_37 = uint((_e259 + 9u));
        uint _e265 = local_36;
        uint _e266 = local_37;
        local_60 = uint((_e265 + _e266));
        uint _e270 = local_60;
        _group_0_binding_0_cs[_e270] = int(_e253);
        int _e272 = effect;
        uint _e273 = local_1;
        local_41 = _e273;
        uint _e275 = local_41;
        local_42 = uint(_e275);
        uint _e278 = i;
        local_43 = uint(_e278);
        uint _e281 = local_42;
        uint _e282 = local_43;
        local_61 = uint((_e281 + _e282));
        uint _e287 = local_61;
        int _e289 = _group_0_binding_1_cs[_e287];
        local_62 = _e289;
        int _e290 = local_62;
        bool _e291 = differs(_e272, _e290);
        uint _e292 = local;
        local_38 = _e292;
        uint _e294 = local_38;
        local_39 = uint(_e294);
        uint _e297 = base;
        local_40 = uint((_e297 + 10u));
        uint _e303 = local_39;
        uint _e304 = local_40;
        local_63 = uint((_e303 + _e304));
        uint _e308 = local_63;
        _group_0_binding_0_cs[_e308] = int(_e291);
        int _e310 = effect;
        uint _e311 = local;
        local_44 = _e311;
        uint _e313 = local_44;
        local_45 = uint(_e313);
        uint _e316 = base;
        local_46 = uint((_e316 + 11u));
        uint _e321 = local_45;
        uint _e322 = local_46;
        local_64 = uint((_e321 + _e322));
        uint _e326 = local_64;
        _group_0_binding_0_cs[_e326] = _e310;
    }
}

