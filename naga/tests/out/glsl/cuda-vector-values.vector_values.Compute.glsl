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
    vec2 f2_ = vec2(0.0);
    float3_ f3_ = float3_(0.0, 0.0, 0.0);
    vec4 f4_ = vec4(0.0);
    ivec2 i2_ = ivec2(0);
    int3_ i3_ = int3_(0, 0, 0);
    ivec4 i4_ = ivec4(0);
    uvec2 u2_ = uvec2(0u);
    uint3_ u3_ = uint3_(0u, 0u, 0u);
    uvec4 u4_ = uvec4(0u);
    float3_ frozen = float3_(0.0, 0.0, 0.0);
    float3_ copied = float3_(0.0, 0.0, 0.0);
    int3_ changed = int3_(0, 0, 0);
    float3_ samples[2] = float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
    int index = 0;
    bool choose_first = false;
    float local = 0.0;
    float local_1 = 0.0;
    float3_ local_2 = float3_(0.0, 0.0, 0.0);
    int local_3 = 0;
    uint local_4 = 0u;
    int argument = 0;
    int3_ captured = int3_(0, 0, 0);
    uint local_5 = 0u;
    int seed = _group_0_binding_0_cs[uint(0)];
    f2_ = vec2(float(seed), 1.5);
    f3_ = float3_(1.0, 2.0, 3.0);
    f4_ = vec4(float(1), float(2), float(3), float(4));
    i2_ = ivec2(seed, -(2));
    i3_ = int3_(1, 2, 3);
    i4_ = ivec4(1, 2, 3, 4);
    u2_ = uvec2(uint(-(1)), uint(2));
    u3_ = uint3_(uint(1), uint(2), uint(3));
    u4_ = uvec4(uint(1), uint(2), uint(3), uint(4));
    float _e66 = f2_.x;
    float _e67 = f2_.y;
    _group_0_binding_0_cs[uint(0)] = int((_e66 + _e67));
    float _e75 = f3_.x;
    float _e76 = f3_.y;
    float _e79 = f3_.z;
    _group_0_binding_0_cs[uint(1)] = int(((_e75 + _e76) + _e79));
    float _e86 = f4_.w;
    _group_0_binding_0_cs[uint(2)] = int(_e86);
    int _e93 = i2_.x;
    int _e94 = i2_.y;
    _group_0_binding_0_cs[uint(3)] = (_e93 + _e94);
    int _e100 = i3_.z;
    _group_0_binding_0_cs[uint(4)] = _e100;
    int _e106 = i4_.x;
    int _e107 = i4_.w;
    _group_0_binding_0_cs[uint(5)] = (_e106 + _e107);
    uint _e113 = u2_.x;
    _group_0_binding_0_cs[uint(6)] = int((_e113 == 4294967295u));
    uint _e122 = u3_.x;
    uint _e123 = u3_.z;
    _group_0_binding_0_cs[uint(7)] = int((_e122 + _e123));
    uint _e130 = u4_.w;
    _group_0_binding_0_cs[uint(8)] = int(_e130);
    float3_ _e135 = f3_;
    frozen = _e135;
    float3_ _e137 = frozen;
    copied = _e137;
    copied.x = 9.0;
    float _e142 = frozen.x;
    float _e146 = copied.x;
    _group_0_binding_0_cs[uint(9)] = int(((_e142 * 10.0) + _e146));
    int3_ _e152 = i3_;
    int3_ _e153 = bump(_e152);
    changed = _e153;
    int _e156 = changed.y;
    int _e160 = i3_.y;
    _group_0_binding_0_cs[uint(10)] = ((_e156 * 10) + _e160);
    float3_ _e165 = f3_;
    float3_ _e166 = shift(_e165);
    _group_0_binding_0_cs[uint(11)] = int(_e166.z);
    ivec2 _e172 = i2_;
    int _e173 = choose(_e172);
    uint3_ _e174 = u3_;
    int _e175 = choose_1(_e174);
    vec4 _e177 = f4_;
    int _e178 = choose_2(_e177);
    _group_0_binding_0_cs[uint(12)] = ((_e173 + _e175) + _e178);
    float3_ _e183 = f3_;
    samples[0] = _e183;
    samples[1] = float3_(float(5), float(6), float(7));
    index = 0;
    int _e198 = index;
    index = (_e198 + 1);
    int _e201 = index;
    int _e202 = index;
    index = (_e202 + 1);
    float _e207 = samples[_e202].x;
    samples[_e202].x = (_e207 + float(_e201));
    float _e210 = samples[_e202].x;
    _group_0_binding_0_cs[uint(13)] = int(_e210);
    int _e215 = index;
    float _e221 = samples[0].x;
    float _e229 = samples[1].x;
    _group_0_binding_0_cs[uint(14)] = (((_e215 * 100) + (int(_e221) * 10)) + int(_e229));
    choose_first = false;
    bool _e237 = choose_first;
    if (_e237) {
        float _e241 = samples[0].y;
        samples[0].y = (_e241 + float(1));
        local = _e241;
    } else {
        float _e249 = samples[1].y;
        samples[1].y = (_e249 + float(1));
        local = _e249;
    }
    float _e255 = local;
    _group_0_binding_0_cs[uint(15)] = int(_e255);
    float _e263 = samples[1].y;
    _group_0_binding_0_cs[uint(16)] = int(_e263);
    float3_ _e268 = f3_;
    bool _e269 = choose_first;
    if (_e269) {
        samples[0] = _e268;
        float _e273 = samples[0].z;
        local_1 = _e273;
    } else {
        samples[1] = _e268;
        float _e278 = samples[1].z;
        local_1 = _e278;
    }
    float _e281 = local_1;
    _group_0_binding_0_cs[uint(17)] = int(_e281);
    if (true) {
        local_2 = float3_(float(7), float(8), float(9));
    } else {
        float3_ _e295 = f3_;
        local_2 = _e295;
    }
    float3_ _e298 = local_2;
    _group_0_binding_0_cs[uint(18)] = int(_e298.y);
    {
        local_3 = (seed + 2);
        int _e307 = local_3;
        local_4 = uint(19);
        uint _e311 = local_4;
        local_5 = _e311;
        uint _e313 = local_5;
        _group_0_binding_0_cs[_e313] = _e307;
    }
    argument = 3;
    int _e317 = argument;
    int _e318 = argument;
    argument = (_e318 + 1);
    int _e321 = argument;
    captured = int3_(_e317, _e318, _e321);
    int _e325 = captured.x;
    int _e329 = captured.y;
    int _e334 = captured.z;
    _group_0_binding_0_cs[uint(20)] = (((_e325 * 100) + (_e329 * 10)) + _e334);
    int _e339 = argument;
    _group_0_binding_0_cs[uint(21)] = _e339;
    float3_ _e343 = f3_;
    f3_.x = 9.0;
    int _e347 = pair(_e343, 4);
    _group_0_binding_0_cs[uint(22)] = _e347;
    float _e352 = f3_.x;
    _group_0_binding_0_cs[uint(23)] = int(_e352);
}

