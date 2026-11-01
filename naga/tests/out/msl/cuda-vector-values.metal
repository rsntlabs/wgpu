// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

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
typedef int type_5[1];
struct type_10 {
    float3_ inner[2];
};

int choose(
    metal::int2 value
) {
    metal::int2 value_1 = {};
    value_1 = value;
    int _e4 = value_1.x;
    int _e7 = value_1.y;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e4) * as_type<uint>(10))) + as_type<uint>(_e7));
}

int choose_1(
    uint3_ value_2
) {
    uint3_ value_3 = {};
    value_3 = value_2;
    uint _e3 = value_3.z;
    return static_cast<int>(_e3);
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int choose_2(
    metal::float4 value_4
) {
    metal::float4 value_5 = {};
    value_5 = value_4;
    float _e3 = value_5.w;
    return naga_f2i32(_e3);
}

int3_ bump(
    int3_ value_6
) {
    int3_ value_7 = {};
    value_7 = value_6;
    int _e4 = value_7.y;
    value_7.y = as_type<int>(as_type<uint>(_e4) + as_type<uint>(1));
    int3_ _e6 = value_7;
    return _e6;
}

float3_ shift(
    float3_ value_8
) {
    float3_ value_9 = {};
    value_9 = value_8;
    float _e4 = value_9.x;
    value_9.x = _e4 + 2.0;
    float _e9 = value_9.x;
    float _e10 = value_9.y;
    value_9.z = _e9 + _e10;
    float3_ _e12 = value_9;
    return _e12;
}

int pair(
    float3_ first,
    int second
) {
    float3_ first_1 = {};
    first_1 = first;
    float _e4 = first_1.x;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(naga_f2i32(_e4)) * as_type<uint>(10))) + as_type<uint>(second));
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void vector_values(
  device type_5& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::float2 f2_ = {};
    float3_ f3_ = {};
    metal::float4 f4_ = {};
    metal::int2 i2_ = {};
    int3_ i3_ = {};
    metal::int4 i4_ = {};
    metal::uint2 u2_ = {};
    uint3_ u3_ = {};
    metal::uint4 u4_ = {};
    float3_ frozen = {};
    float3_ copied = {};
    int3_ changed = {};
    type_10 samples = {};
    int index = {};
    bool choose_first = {};
    float local = {};
    float local_1 = {};
    float3_ local_2 = {};
    int local_3 = {};
    uint local_4 = {};
    int argument = {};
    int3_ captured = {};
    uint local_5 = {};
    int seed = out[static_cast<uint>(0)];
    f2_ = metal::float2(static_cast<float>(seed), 1.5);
    f3_ = float3_ {1.0, 2.0, 3.0};
    f4_ = metal::float4(static_cast<float>(1), static_cast<float>(2), static_cast<float>(3), static_cast<float>(4));
    i2_ = metal::int2(seed, naga_neg(2));
    i3_ = int3_ {1, 2, 3};
    i4_ = metal::int4(1, 2, 3, 4);
    u2_ = metal::uint2(static_cast<uint>(naga_neg(1)), static_cast<uint>(2));
    u3_ = uint3_ {static_cast<uint>(1), static_cast<uint>(2), static_cast<uint>(3)};
    u4_ = metal::uint4(static_cast<uint>(1), static_cast<uint>(2), static_cast<uint>(3), static_cast<uint>(4));
    float _e66 = f2_.x;
    float _e67 = f2_.y;
    out[static_cast<uint>(0)] = naga_f2i32(_e66 + _e67);
    float _e75 = f3_.x;
    float _e76 = f3_.y;
    float _e79 = f3_.z;
    out[static_cast<uint>(1)] = naga_f2i32((_e75 + _e76) + _e79);
    float _e86 = f4_.w;
    out[static_cast<uint>(2)] = naga_f2i32(_e86);
    int _e93 = i2_.x;
    int _e94 = i2_.y;
    out[static_cast<uint>(3)] = as_type<int>(as_type<uint>(_e93) + as_type<uint>(_e94));
    int _e100 = i3_.z;
    out[static_cast<uint>(4)] = _e100;
    int _e106 = i4_.x;
    int _e107 = i4_.w;
    out[static_cast<uint>(5)] = as_type<int>(as_type<uint>(_e106) + as_type<uint>(_e107));
    uint _e113 = u2_.x;
    out[static_cast<uint>(6)] = static_cast<int>(_e113 == 4294967295u);
    uint _e122 = u3_.x;
    uint _e123 = u3_.z;
    out[static_cast<uint>(7)] = static_cast<int>(_e122 + _e123);
    uint _e130 = u4_.w;
    out[static_cast<uint>(8)] = static_cast<int>(_e130);
    float3_ _e135 = f3_;
    frozen = _e135;
    float3_ _e137 = frozen;
    copied = _e137;
    copied.x = 9.0;
    float _e142 = frozen.x;
    float _e146 = copied.x;
    out[static_cast<uint>(9)] = naga_f2i32((_e142 * 10.0) + _e146);
    int3_ _e152 = i3_;
    int3_ _e153 = bump(_e152);
    changed = _e153;
    int _e156 = changed.y;
    int _e160 = i3_.y;
    out[static_cast<uint>(10)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e156) * as_type<uint>(10))) + as_type<uint>(_e160));
    float3_ _e165 = f3_;
    float3_ _e166 = shift(_e165);
    out[static_cast<uint>(11)] = naga_f2i32(_e166.z);
    metal::int2 _e172 = i2_;
    int _e173 = choose(_e172);
    uint3_ _e174 = u3_;
    int _e175 = choose_1(_e174);
    metal::float4 _e177 = f4_;
    int _e178 = choose_2(_e177);
    out[static_cast<uint>(12)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e173) + as_type<uint>(_e175))) + as_type<uint>(_e178));
    float3_ _e183 = f3_;
    samples.inner[0] = _e183;
    samples.inner[1] = float3_ {static_cast<float>(5), static_cast<float>(6), static_cast<float>(7)};
    index = 0;
    int _e198 = index;
    index = as_type<int>(as_type<uint>(_e198) + as_type<uint>(1));
    int _e201 = index;
    int _e202 = index;
    index = as_type<int>(as_type<uint>(_e202) + as_type<uint>(1));
    float _e207 = samples.inner[_e202].x;
    samples.inner[_e202].x = _e207 + static_cast<float>(_e201);
    float _e210 = samples.inner[_e202].x;
    out[static_cast<uint>(13)] = naga_f2i32(_e210);
    int _e215 = index;
    float _e221 = samples.inner[0].x;
    float _e229 = samples.inner[1].x;
    out[static_cast<uint>(14)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e215) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(naga_f2i32(_e221)) * as_type<uint>(10))))) + as_type<uint>(naga_f2i32(_e229)));
    choose_first = false;
    bool _e237 = choose_first;
    if (_e237) {
        float _e241 = samples.inner[0].y;
        samples.inner[0].y = _e241 + static_cast<float>(1);
        local = _e241;
    } else {
        float _e249 = samples.inner[1].y;
        samples.inner[1].y = _e249 + static_cast<float>(1);
        local = _e249;
    }
    float _e255 = local;
    out[static_cast<uint>(15)] = naga_f2i32(_e255);
    float _e263 = samples.inner[1].y;
    out[static_cast<uint>(16)] = naga_f2i32(_e263);
    float3_ _e268 = f3_;
    bool _e269 = choose_first;
    if (_e269) {
        samples.inner[0] = _e268;
        float _e273 = samples.inner[0].z;
        local_1 = _e273;
    } else {
        samples.inner[1] = _e268;
        float _e278 = samples.inner[1].z;
        local_1 = _e278;
    }
    float _e281 = local_1;
    out[static_cast<uint>(17)] = naga_f2i32(_e281);
    if (true) {
        local_2 = float3_ {static_cast<float>(7), static_cast<float>(8), static_cast<float>(9)};
    } else {
        float3_ _e295 = f3_;
        local_2 = _e295;
    }
    float3_ _e298 = local_2;
    out[static_cast<uint>(18)] = naga_f2i32(_e298.y);
    {
        local_3 = as_type<int>(as_type<uint>(seed) + as_type<uint>(2));
        int _e307 = local_3;
        local_4 = static_cast<uint>(19);
        uint _e311 = local_4;
        local_5 = _e311;
        uint _e313 = local_5;
        out[_e313] = _e307;
    }
    argument = 3;
    int _e317 = argument;
    int _e318 = argument;
    argument = as_type<int>(as_type<uint>(_e318) + as_type<uint>(1));
    int _e321 = argument;
    captured = int3_ {_e317, _e318, _e321};
    int _e325 = captured.x;
    int _e329 = captured.y;
    int _e334 = captured.z;
    out[static_cast<uint>(20)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e325) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e329) * as_type<uint>(10))))) + as_type<uint>(_e334));
    int _e339 = argument;
    out[static_cast<uint>(21)] = _e339;
    float3_ _e343 = f3_;
    f3_.x = 9.0;
    int _e347 = pair(_e343, 4);
    out[static_cast<uint>(22)] = _e347;
    float _e352 = f3_.x;
    out[static_cast<uint>(23)] = naga_f2i32(_e352);
}
