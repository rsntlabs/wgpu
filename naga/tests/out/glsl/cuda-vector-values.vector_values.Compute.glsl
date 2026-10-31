#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct uint3_ {
    uint x;
    uint y;
    uint z;
};
struct int3_ {
    int x;
    int y;
    int z;
};
struct float3_ {
    float x;
    float y;
    float z;
};
layout(std430) buffer type_5_block_0Compute { int _group_0_binding_0_cs[]; };


int choose(ivec2 value) {
    ivec2 value_1 = ivec2(0);
    value_1 = value;
    int _e4 = value_1.x;
    int _e7 = value_1.y;
    return ((_e4 * 10) + _e7);
}

int choose_1(uint3_ value_2) {
    uint3_ value_3 = uint3_(0u, 0u, 0u);
    value_3 = value_2;
    uint _e3 = value_3.z;
    return int(_e3);
}

int choose_2(vec4 value_4) {
    vec4 value_5 = vec4(0.0);
    value_5 = value_4;
    float _e3 = value_5.w;
    return int(_e3);
}

int3_ bump(int3_ value_6) {
    int3_ value_7 = int3_(0, 0, 0);
    value_7 = value_6;
    int _e4 = value_7.y;
    value_7.y = (_e4 + 1);
    int3_ _e6 = value_7;
    return _e6;
}

float3_ shift(float3_ value_8) {
    float3_ value_9 = float3_(0.0, 0.0, 0.0);
    value_9 = value_8;
    float _e4 = value_9.x;
    value_9.x = (_e4 + 2.0);
    float _e9 = value_9.x;
    float _e10 = value_9.y;
    value_9.z = (_e9 + _e10);
    float3_ _e12 = value_9;
    return _e12;
}

int pair(float3_ first, int second) {
    float3_ first_1 = float3_(0.0, 0.0, 0.0);
    first_1 = first;
    float _e4 = first_1.x;
    return ((int(_e4) * 10) + second);
}

void main() {
    uint local = 0u;
    vec2 f2_ = vec2(0.0);
    float3_ f3_ = float3_(0.0, 0.0, 0.0);
    vec4 f4_ = vec4(0.0);
    ivec2 i2_ = ivec2(0);
    int3_ i3_ = int3_(0, 0, 0);
    ivec4 i4_ = ivec4(0);
    uvec2 u2_ = uvec2(0u);
    uint3_ u3_ = uint3_(0u, 0u, 0u);
    uvec4 u4_ = uvec4(0u);
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    float3_ frozen = float3_(0.0, 0.0, 0.0);
    float3_ copied = float3_(0.0, 0.0, 0.0);
    uint local_10 = 0u;
    int3_ changed = int3_(0, 0, 0);
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    float3_ samples[2] = float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
    int index = 0;
    uint local_14 = 0u;
    uint local_15 = 0u;
    bool choose_first = false;
    uint local_16 = 0u;
    float local_17 = 0.0;
    uint local_18 = 0u;
    uint local_19 = 0u;
    float local_20 = 0.0;
    uint local_21 = 0u;
    float3_ local_22 = float3_(0.0, 0.0, 0.0);
    int local_23 = 0;
    uint local_24 = 0u;
    int argument = 0;
    int3_ captured = int3_(0, 0, 0);
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
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53 = 0u;
    local = uint(0);
    uint _e3 = local;
    local_29 = uint(_e3);
    uint _e6 = local_29;
    int seed = _group_0_binding_0_cs[_e6];
    f2_ = vec2(float(seed), 1.5);
    f3_ = float3_(1.0, 2.0, 3.0);
    f4_ = vec4(float(1), float(2), float(3), float(4));
    i2_ = ivec2(seed, -(2));
    i3_ = int3_(1, 2, 3);
    i4_ = ivec4(1, 2, 3, 4);
    u2_ = uvec2(uint(-(1)), uint(2));
    u3_ = uint3_(uint(1), uint(2), uint(3));
    u4_ = uvec4(uint(1), uint(2), uint(3), uint(4));
    float _e71 = f2_.x;
    float _e72 = f2_.y;
    local_1 = uint(0);
    uint _e78 = local_1;
    local_30 = uint(_e78);
    uint _e81 = local_30;
    _group_0_binding_0_cs[_e81] = int((_e71 + _e72));
    float _e85 = f3_.x;
    float _e86 = f3_.y;
    float _e89 = f3_.z;
    local_2 = uint(1);
    uint _e95 = local_2;
    local_31 = uint(_e95);
    uint _e98 = local_31;
    _group_0_binding_0_cs[_e98] = int(((_e85 + _e86) + _e89));
    float _e101 = f4_.w;
    local_3 = uint(2);
    uint _e106 = local_3;
    local_32 = uint(_e106);
    uint _e109 = local_32;
    _group_0_binding_0_cs[_e109] = int(_e101);
    int _e113 = i2_.x;
    int _e114 = i2_.y;
    local_4 = uint(3);
    uint _e119 = local_4;
    local_33 = uint(_e119);
    uint _e122 = local_33;
    _group_0_binding_0_cs[_e122] = (_e113 + _e114);
    int _e125 = i3_.z;
    local_5 = uint(4);
    uint _e129 = local_5;
    local_34 = uint(_e129);
    uint _e132 = local_34;
    _group_0_binding_0_cs[_e132] = _e125;
    int _e136 = i4_.x;
    int _e137 = i4_.w;
    local_6 = uint(5);
    uint _e142 = local_6;
    local_35 = uint(_e142);
    uint _e145 = local_35;
    _group_0_binding_0_cs[_e145] = (_e136 + _e137);
    uint _e148 = u2_.x;
    local_7 = uint(6);
    uint _e155 = local_7;
    local_36 = uint(_e155);
    uint _e158 = local_36;
    _group_0_binding_0_cs[_e158] = int((_e148 == 4294967295u));
    uint _e162 = u3_.x;
    uint _e163 = u3_.z;
    local_8 = uint(7);
    uint _e169 = local_8;
    local_37 = uint(_e169);
    uint _e172 = local_37;
    _group_0_binding_0_cs[_e172] = int((_e162 + _e163));
    uint _e175 = u4_.w;
    local_9 = uint(8);
    uint _e180 = local_9;
    local_38 = uint(_e180);
    uint _e183 = local_38;
    _group_0_binding_0_cs[_e183] = int(_e175);
    float3_ _e185 = f3_;
    frozen = _e185;
    float3_ _e187 = frozen;
    copied = _e187;
    copied.x = 9.0;
    float _e192 = frozen.x;
    float _e196 = copied.x;
    local_10 = uint(9);
    uint _e202 = local_10;
    local_39 = uint(_e202);
    uint _e205 = local_39;
    _group_0_binding_0_cs[_e205] = int(((_e192 * 10.0) + _e196));
    int3_ _e207 = i3_;
    int3_ _e208 = bump(_e207);
    changed = _e208;
    int _e211 = changed.y;
    int _e215 = i3_.y;
    local_11 = uint(10);
    uint _e220 = local_11;
    local_40 = uint(_e220);
    uint _e223 = local_40;
    _group_0_binding_0_cs[_e223] = ((_e211 * 10) + _e215);
    float3_ _e225 = f3_;
    float3_ _e226 = shift(_e225);
    local_12 = uint(11);
    uint _e232 = local_12;
    local_41 = uint(_e232);
    uint _e235 = local_41;
    _group_0_binding_0_cs[_e235] = int(_e226.z);
    ivec2 _e237 = i2_;
    int _e238 = choose(_e237);
    uint3_ _e239 = u3_;
    int _e240 = choose_1(_e239);
    vec4 _e242 = f4_;
    int _e243 = choose_2(_e242);
    local_13 = uint(12);
    uint _e248 = local_13;
    local_42 = uint(_e248);
    uint _e251 = local_42;
    _group_0_binding_0_cs[_e251] = ((_e238 + _e240) + _e243);
    float3_ _e253 = f3_;
    samples[0] = _e253;
    samples[1] = float3_(float(5), float(6), float(7));
    index = 0;
    int _e268 = index;
    index = (_e268 + 1);
    int _e271 = index;
    int _e272 = index;
    index = (_e272 + 1);
    float _e277 = samples[_e272].x;
    samples[_e272].x = (_e277 + float(_e271));
    float _e280 = samples[_e272].x;
    local_14 = uint(13);
    uint _e285 = local_14;
    local_43 = uint(_e285);
    uint _e288 = local_43;
    _group_0_binding_0_cs[_e288] = int(_e280);
    int _e290 = index;
    float _e296 = samples[0].x;
    float _e304 = samples[1].x;
    local_15 = uint(14);
    uint _e310 = local_15;
    local_44 = uint(_e310);
    uint _e313 = local_44;
    _group_0_binding_0_cs[_e313] = (((_e290 * 100) + (int(_e296) * 10)) + int(_e304));
    choose_first = false;
    bool _e317 = choose_first;
    if (_e317) {
        float _e321 = samples[0].y;
        samples[0].y = (_e321 + float(1));
        local_17 = _e321;
    } else {
        float _e329 = samples[1].y;
        samples[1].y = (_e329 + float(1));
        local_17 = _e329;
    }
    float _e335 = local_17;
    local_16 = uint(15);
    uint _e340 = local_16;
    local_45 = uint(_e340);
    uint _e343 = local_45;
    _group_0_binding_0_cs[_e343] = int(_e335);
    float _e348 = samples[1].y;
    local_18 = uint(16);
    uint _e353 = local_18;
    local_46 = uint(_e353);
    uint _e356 = local_46;
    _group_0_binding_0_cs[_e356] = int(_e348);
    float3_ _e358 = f3_;
    bool _e359 = choose_first;
    if (_e359) {
        samples[0] = _e358;
        float _e363 = samples[0].z;
        local_20 = _e363;
    } else {
        samples[1] = _e358;
        float _e368 = samples[1].z;
        local_20 = _e368;
    }
    float _e371 = local_20;
    local_19 = uint(17);
    uint _e376 = local_19;
    local_47 = uint(_e376);
    uint _e379 = local_47;
    _group_0_binding_0_cs[_e379] = int(_e371);
    if (true) {
        local_22 = float3_(float(7), float(8), float(9));
    } else {
        float3_ _e390 = f3_;
        local_22 = _e390;
    }
    float3_ _e393 = local_22;
    local_21 = uint(18);
    uint _e399 = local_21;
    local_48 = uint(_e399);
    uint _e402 = local_48;
    _group_0_binding_0_cs[_e402] = int(_e393.y);
    {
        local_23 = (seed + 2);
        int _e407 = local_23;
        local_24 = uint(19);
        uint _e411 = local_24;
        local_49 = uint(_e411);
        uint _e414 = local_49;
        _group_0_binding_0_cs[_e414] = _e407;
    }
    argument = 3;
    int _e418 = argument;
    int _e419 = argument;
    argument = (_e419 + 1);
    int _e422 = argument;
    captured = int3_(_e418, _e419, _e422);
    int _e426 = captured.x;
    int _e430 = captured.y;
    int _e435 = captured.z;
    local_25 = uint(20);
    uint _e440 = local_25;
    local_50 = uint(_e440);
    uint _e443 = local_50;
    _group_0_binding_0_cs[_e443] = (((_e426 * 100) + (_e430 * 10)) + _e435);
    int _e445 = argument;
    local_26 = uint(21);
    uint _e449 = local_26;
    local_51 = uint(_e449);
    uint _e452 = local_51;
    _group_0_binding_0_cs[_e452] = _e445;
    float3_ _e454 = f3_;
    f3_.x = 9.0;
    int _e458 = pair(_e454, 4);
    local_27 = uint(22);
    uint _e462 = local_27;
    local_52 = uint(_e462);
    uint _e465 = local_52;
    _group_0_binding_0_cs[_e465] = _e458;
    float _e468 = f3_.x;
    local_28 = uint(23);
    uint _e473 = local_28;
    local_53 = uint(_e473);
    uint _e476 = local_53;
    _group_0_binding_0_cs[_e476] = int(_e468);
}

