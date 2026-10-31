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
    local = uint(0);
    uint _e3 = local;
    int seed = _group_0_binding_0_cs[_e3];
    f2_ = vec2(float(seed), 1.5);
    f3_ = float3_(1.0, 2.0, 3.0);
    f4_ = vec4(float(1), float(2), float(3), float(4));
    i2_ = ivec2(seed, -(2));
    i3_ = int3_(1, 2, 3);
    i4_ = ivec4(1, 2, 3, 4);
    u2_ = uvec2(uint(-(1)), uint(2));
    u3_ = uint3_(uint(1), uint(2), uint(3));
    u4_ = uvec4(uint(1), uint(2), uint(3), uint(4));
    float _e68 = f2_.x;
    float _e69 = f2_.y;
    local_1 = uint(0);
    uint _e75 = local_1;
    _group_0_binding_0_cs[_e75] = int((_e68 + _e69));
    float _e79 = f3_.x;
    float _e80 = f3_.y;
    float _e83 = f3_.z;
    local_2 = uint(1);
    uint _e89 = local_2;
    _group_0_binding_0_cs[_e89] = int(((_e79 + _e80) + _e83));
    float _e92 = f4_.w;
    local_3 = uint(2);
    uint _e97 = local_3;
    _group_0_binding_0_cs[_e97] = int(_e92);
    int _e101 = i2_.x;
    int _e102 = i2_.y;
    local_4 = uint(3);
    uint _e107 = local_4;
    _group_0_binding_0_cs[_e107] = (_e101 + _e102);
    int _e110 = i3_.z;
    local_5 = uint(4);
    uint _e114 = local_5;
    _group_0_binding_0_cs[_e114] = _e110;
    int _e118 = i4_.x;
    int _e119 = i4_.w;
    local_6 = uint(5);
    uint _e124 = local_6;
    _group_0_binding_0_cs[_e124] = (_e118 + _e119);
    uint _e127 = u2_.x;
    local_7 = uint(6);
    uint _e134 = local_7;
    _group_0_binding_0_cs[_e134] = int((_e127 == 4294967295u));
    uint _e138 = u3_.x;
    uint _e139 = u3_.z;
    local_8 = uint(7);
    uint _e145 = local_8;
    _group_0_binding_0_cs[_e145] = int((_e138 + _e139));
    uint _e148 = u4_.w;
    local_9 = uint(8);
    uint _e153 = local_9;
    _group_0_binding_0_cs[_e153] = int(_e148);
    float3_ _e155 = f3_;
    frozen = _e155;
    float3_ _e157 = frozen;
    copied = _e157;
    copied.x = 9.0;
    float _e162 = frozen.x;
    float _e166 = copied.x;
    local_10 = uint(9);
    uint _e172 = local_10;
    _group_0_binding_0_cs[_e172] = int(((_e162 * 10.0) + _e166));
    int3_ _e174 = i3_;
    int3_ _e175 = bump(_e174);
    changed = _e175;
    int _e178 = changed.y;
    int _e182 = i3_.y;
    local_11 = uint(10);
    uint _e187 = local_11;
    _group_0_binding_0_cs[_e187] = ((_e178 * 10) + _e182);
    float3_ _e189 = f3_;
    float3_ _e190 = shift(_e189);
    local_12 = uint(11);
    uint _e196 = local_12;
    _group_0_binding_0_cs[_e196] = int(_e190.z);
    ivec2 _e198 = i2_;
    int _e199 = choose(_e198);
    uint3_ _e200 = u3_;
    int _e201 = choose_1(_e200);
    vec4 _e203 = f4_;
    int _e204 = choose_2(_e203);
    local_13 = uint(12);
    uint _e209 = local_13;
    _group_0_binding_0_cs[_e209] = ((_e199 + _e201) + _e204);
    float3_ _e211 = f3_;
    samples[0] = _e211;
    samples[1] = float3_(float(5), float(6), float(7));
    index = 0;
    int _e226 = index;
    index = (_e226 + 1);
    int _e229 = index;
    int _e230 = index;
    index = (_e230 + 1);
    float _e235 = samples[_e230].x;
    samples[_e230].x = (_e235 + float(_e229));
    float _e238 = samples[_e230].x;
    local_14 = uint(13);
    uint _e243 = local_14;
    _group_0_binding_0_cs[_e243] = int(_e238);
    int _e245 = index;
    float _e251 = samples[0].x;
    float _e259 = samples[1].x;
    local_15 = uint(14);
    uint _e265 = local_15;
    _group_0_binding_0_cs[_e265] = (((_e245 * 100) + (int(_e251) * 10)) + int(_e259));
    choose_first = false;
    bool _e269 = choose_first;
    if (_e269) {
        float _e273 = samples[0].y;
        samples[0].y = (_e273 + float(1));
        local_17 = _e273;
    } else {
        float _e281 = samples[1].y;
        samples[1].y = (_e281 + float(1));
        local_17 = _e281;
    }
    float _e287 = local_17;
    local_16 = uint(15);
    uint _e292 = local_16;
    _group_0_binding_0_cs[_e292] = int(_e287);
    float _e297 = samples[1].y;
    local_18 = uint(16);
    uint _e302 = local_18;
    _group_0_binding_0_cs[_e302] = int(_e297);
    float3_ _e304 = f3_;
    bool _e305 = choose_first;
    if (_e305) {
        samples[0] = _e304;
        float _e309 = samples[0].z;
        local_20 = _e309;
    } else {
        samples[1] = _e304;
        float _e314 = samples[1].z;
        local_20 = _e314;
    }
    float _e317 = local_20;
    local_19 = uint(17);
    uint _e322 = local_19;
    _group_0_binding_0_cs[_e322] = int(_e317);
    if (true) {
        local_22 = float3_(float(7), float(8), float(9));
    } else {
        float3_ _e333 = f3_;
        local_22 = _e333;
    }
    float3_ _e336 = local_22;
    local_21 = uint(18);
    uint _e342 = local_21;
    _group_0_binding_0_cs[_e342] = int(_e336.y);
    {
        local_23 = (seed + 2);
        int _e347 = local_23;
        local_24 = uint(19);
        uint _e351 = local_24;
        local_29 = _e351;
        uint _e353 = local_29;
        _group_0_binding_0_cs[_e353] = _e347;
    }
    argument = 3;
    int _e357 = argument;
    int _e358 = argument;
    argument = (_e358 + 1);
    int _e361 = argument;
    captured = int3_(_e357, _e358, _e361);
    int _e365 = captured.x;
    int _e369 = captured.y;
    int _e374 = captured.z;
    local_25 = uint(20);
    uint _e379 = local_25;
    _group_0_binding_0_cs[_e379] = (((_e365 * 100) + (_e369 * 10)) + _e374);
    int _e381 = argument;
    local_26 = uint(21);
    uint _e385 = local_26;
    _group_0_binding_0_cs[_e385] = _e381;
    float3_ _e387 = f3_;
    f3_.x = 9.0;
    int _e391 = pair(_e387, 4);
    local_27 = uint(22);
    uint _e395 = local_27;
    _group_0_binding_0_cs[_e395] = _e391;
    float _e398 = f3_.x;
    local_28 = uint(23);
    uint _e403 = local_28;
    _group_0_binding_0_cs[_e403] = int(_e398);
}

