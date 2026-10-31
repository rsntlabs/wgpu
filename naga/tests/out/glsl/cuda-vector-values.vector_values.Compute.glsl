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
    int local_29 = 0;
    uint local_30 = 0u;
    int local_31 = 0;
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
    uint local_54 = 0u;
    uint local_55 = 0u;
    local = uint(0);
    uint _e3 = local;
    local_30 = uint(_e3);
    uint _e6 = local_30;
    int _e9 = _group_0_binding_0_cs[_e6];
    local_31 = _e9;
    int _e11 = local_31;
    local_29 = _e11;
    int seed = local_29;
    f2_ = vec2(float(seed), 1.5);
    f3_ = float3_(1.0, 2.0, 3.0);
    f4_ = vec4(float(1), float(2), float(3), float(4));
    i2_ = ivec2(seed, -(2));
    i3_ = int3_(1, 2, 3);
    i4_ = ivec4(1, 2, 3, 4);
    u2_ = uvec2(uint(-(1)), uint(2));
    u3_ = uint3_(uint(1), uint(2), uint(3));
    u4_ = uvec4(uint(1), uint(2), uint(3), uint(4));
    float _e75 = f2_.x;
    float _e76 = f2_.y;
    local_1 = uint(0);
    uint _e82 = local_1;
    local_32 = uint(_e82);
    uint _e85 = local_32;
    _group_0_binding_0_cs[_e85] = int((_e75 + _e76));
    float _e89 = f3_.x;
    float _e90 = f3_.y;
    float _e93 = f3_.z;
    local_2 = uint(1);
    uint _e99 = local_2;
    local_33 = uint(_e99);
    uint _e102 = local_33;
    _group_0_binding_0_cs[_e102] = int(((_e89 + _e90) + _e93));
    float _e105 = f4_.w;
    local_3 = uint(2);
    uint _e110 = local_3;
    local_34 = uint(_e110);
    uint _e113 = local_34;
    _group_0_binding_0_cs[_e113] = int(_e105);
    int _e117 = i2_.x;
    int _e118 = i2_.y;
    local_4 = uint(3);
    uint _e123 = local_4;
    local_35 = uint(_e123);
    uint _e126 = local_35;
    _group_0_binding_0_cs[_e126] = (_e117 + _e118);
    int _e129 = i3_.z;
    local_5 = uint(4);
    uint _e133 = local_5;
    local_36 = uint(_e133);
    uint _e136 = local_36;
    _group_0_binding_0_cs[_e136] = _e129;
    int _e140 = i4_.x;
    int _e141 = i4_.w;
    local_6 = uint(5);
    uint _e146 = local_6;
    local_37 = uint(_e146);
    uint _e149 = local_37;
    _group_0_binding_0_cs[_e149] = (_e140 + _e141);
    uint _e152 = u2_.x;
    local_7 = uint(6);
    uint _e159 = local_7;
    local_38 = uint(_e159);
    uint _e162 = local_38;
    _group_0_binding_0_cs[_e162] = int((_e152 == 4294967295u));
    uint _e166 = u3_.x;
    uint _e167 = u3_.z;
    local_8 = uint(7);
    uint _e173 = local_8;
    local_39 = uint(_e173);
    uint _e176 = local_39;
    _group_0_binding_0_cs[_e176] = int((_e166 + _e167));
    uint _e179 = u4_.w;
    local_9 = uint(8);
    uint _e184 = local_9;
    local_40 = uint(_e184);
    uint _e187 = local_40;
    _group_0_binding_0_cs[_e187] = int(_e179);
    float3_ _e189 = f3_;
    frozen = _e189;
    float3_ _e191 = frozen;
    copied = _e191;
    copied.x = 9.0;
    float _e196 = frozen.x;
    float _e200 = copied.x;
    local_10 = uint(9);
    uint _e206 = local_10;
    local_41 = uint(_e206);
    uint _e209 = local_41;
    _group_0_binding_0_cs[_e209] = int(((_e196 * 10.0) + _e200));
    int3_ _e211 = i3_;
    int3_ _e212 = bump(_e211);
    changed = _e212;
    int _e215 = changed.y;
    int _e219 = i3_.y;
    local_11 = uint(10);
    uint _e224 = local_11;
    local_42 = uint(_e224);
    uint _e227 = local_42;
    _group_0_binding_0_cs[_e227] = ((_e215 * 10) + _e219);
    float3_ _e229 = f3_;
    float3_ _e230 = shift(_e229);
    local_12 = uint(11);
    uint _e236 = local_12;
    local_43 = uint(_e236);
    uint _e239 = local_43;
    _group_0_binding_0_cs[_e239] = int(_e230.z);
    ivec2 _e241 = i2_;
    int _e242 = choose(_e241);
    uint3_ _e243 = u3_;
    int _e244 = choose_1(_e243);
    vec4 _e246 = f4_;
    int _e247 = choose_2(_e246);
    local_13 = uint(12);
    uint _e252 = local_13;
    local_44 = uint(_e252);
    uint _e255 = local_44;
    _group_0_binding_0_cs[_e255] = ((_e242 + _e244) + _e247);
    float3_ _e257 = f3_;
    samples[0] = _e257;
    samples[1] = float3_(float(5), float(6), float(7));
    index = 0;
    int _e272 = index;
    index = (_e272 + 1);
    int _e275 = index;
    int _e276 = index;
    index = (_e276 + 1);
    float _e281 = samples[_e276].x;
    samples[_e276].x = (_e281 + float(_e275));
    float _e284 = samples[_e276].x;
    local_14 = uint(13);
    uint _e289 = local_14;
    local_45 = uint(_e289);
    uint _e292 = local_45;
    _group_0_binding_0_cs[_e292] = int(_e284);
    int _e294 = index;
    float _e300 = samples[0].x;
    float _e308 = samples[1].x;
    local_15 = uint(14);
    uint _e314 = local_15;
    local_46 = uint(_e314);
    uint _e317 = local_46;
    _group_0_binding_0_cs[_e317] = (((_e294 * 100) + (int(_e300) * 10)) + int(_e308));
    choose_first = false;
    bool _e321 = choose_first;
    if (_e321) {
        float _e325 = samples[0].y;
        samples[0].y = (_e325 + float(1));
        local_17 = _e325;
    } else {
        float _e333 = samples[1].y;
        samples[1].y = (_e333 + float(1));
        local_17 = _e333;
    }
    float _e339 = local_17;
    local_16 = uint(15);
    uint _e344 = local_16;
    local_47 = uint(_e344);
    uint _e347 = local_47;
    _group_0_binding_0_cs[_e347] = int(_e339);
    float _e352 = samples[1].y;
    local_18 = uint(16);
    uint _e357 = local_18;
    local_48 = uint(_e357);
    uint _e360 = local_48;
    _group_0_binding_0_cs[_e360] = int(_e352);
    float3_ _e362 = f3_;
    bool _e363 = choose_first;
    if (_e363) {
        samples[0] = _e362;
        float _e367 = samples[0].z;
        local_20 = _e367;
    } else {
        samples[1] = _e362;
        float _e372 = samples[1].z;
        local_20 = _e372;
    }
    float _e375 = local_20;
    local_19 = uint(17);
    uint _e380 = local_19;
    local_49 = uint(_e380);
    uint _e383 = local_49;
    _group_0_binding_0_cs[_e383] = int(_e375);
    if (true) {
        local_22 = float3_(float(7), float(8), float(9));
    } else {
        float3_ _e394 = f3_;
        local_22 = _e394;
    }
    float3_ _e397 = local_22;
    local_21 = uint(18);
    uint _e403 = local_21;
    local_50 = uint(_e403);
    uint _e406 = local_50;
    _group_0_binding_0_cs[_e406] = int(_e397.y);
    {
        local_23 = (seed + 2);
        int _e411 = local_23;
        local_24 = uint(19);
        uint _e415 = local_24;
        local_51 = uint(_e415);
        uint _e418 = local_51;
        _group_0_binding_0_cs[_e418] = _e411;
    }
    argument = 3;
    int _e422 = argument;
    int _e423 = argument;
    argument = (_e423 + 1);
    int _e426 = argument;
    captured = int3_(_e422, _e423, _e426);
    int _e430 = captured.x;
    int _e434 = captured.y;
    int _e439 = captured.z;
    local_25 = uint(20);
    uint _e444 = local_25;
    local_52 = uint(_e444);
    uint _e447 = local_52;
    _group_0_binding_0_cs[_e447] = (((_e430 * 100) + (_e434 * 10)) + _e439);
    int _e449 = argument;
    local_26 = uint(21);
    uint _e453 = local_26;
    local_53 = uint(_e453);
    uint _e456 = local_53;
    _group_0_binding_0_cs[_e456] = _e449;
    float3_ _e458 = f3_;
    f3_.x = 9.0;
    int _e462 = pair(_e458, 4);
    local_27 = uint(22);
    uint _e466 = local_27;
    local_54 = uint(_e466);
    uint _e469 = local_54;
    _group_0_binding_0_cs[_e469] = _e462;
    float _e472 = f3_.x;
    local_28 = uint(23);
    uint _e477 = local_28;
    local_55 = uint(_e477);
    uint _e480 = local_55;
    _group_0_binding_0_cs[_e480] = int(_e472);
}

