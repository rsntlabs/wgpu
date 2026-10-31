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
    uint local = {};
    metal::float2 f2_ = {};
    float3_ f3_ = {};
    metal::float4 f4_ = {};
    metal::int2 i2_ = {};
    int3_ i3_ = {};
    metal::int4 i4_ = {};
    metal::uint2 u2_ = {};
    uint3_ u3_ = {};
    metal::uint4 u4_ = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    float3_ frozen = {};
    float3_ copied = {};
    uint local_10 = {};
    int3_ changed = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    type_10 samples = {};
    int index = {};
    uint local_14 = {};
    uint local_15 = {};
    bool choose_first = {};
    uint local_16 = {};
    float local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    float local_20 = {};
    uint local_21 = {};
    float3_ local_22 = {};
    int local_23 = {};
    uint local_24 = {};
    int argument = {};
    int3_ captured = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    local = static_cast<uint>(0);
    uint _e3 = local;
    int seed = out[_e3];
    f2_ = metal::float2(static_cast<float>(seed), 1.5);
    f3_ = float3_ {1.0, 2.0, 3.0};
    f4_ = metal::float4(static_cast<float>(1), static_cast<float>(2), static_cast<float>(3), static_cast<float>(4));
    i2_ = metal::int2(seed, naga_neg(2));
    i3_ = int3_ {1, 2, 3};
    i4_ = metal::int4(1, 2, 3, 4);
    u2_ = metal::uint2(static_cast<uint>(naga_neg(1)), static_cast<uint>(2));
    u3_ = uint3_ {static_cast<uint>(1), static_cast<uint>(2), static_cast<uint>(3)};
    u4_ = metal::uint4(static_cast<uint>(1), static_cast<uint>(2), static_cast<uint>(3), static_cast<uint>(4));
    float _e68 = f2_.x;
    float _e69 = f2_.y;
    local_1 = static_cast<uint>(0);
    uint _e75 = local_1;
    out[_e75] = naga_f2i32(_e68 + _e69);
    float _e79 = f3_.x;
    float _e80 = f3_.y;
    float _e83 = f3_.z;
    local_2 = static_cast<uint>(1);
    uint _e89 = local_2;
    out[_e89] = naga_f2i32((_e79 + _e80) + _e83);
    float _e92 = f4_.w;
    local_3 = static_cast<uint>(2);
    uint _e97 = local_3;
    out[_e97] = naga_f2i32(_e92);
    int _e101 = i2_.x;
    int _e102 = i2_.y;
    local_4 = static_cast<uint>(3);
    uint _e107 = local_4;
    out[_e107] = as_type<int>(as_type<uint>(_e101) + as_type<uint>(_e102));
    int _e110 = i3_.z;
    local_5 = static_cast<uint>(4);
    uint _e114 = local_5;
    out[_e114] = _e110;
    int _e118 = i4_.x;
    int _e119 = i4_.w;
    local_6 = static_cast<uint>(5);
    uint _e124 = local_6;
    out[_e124] = as_type<int>(as_type<uint>(_e118) + as_type<uint>(_e119));
    uint _e127 = u2_.x;
    local_7 = static_cast<uint>(6);
    uint _e134 = local_7;
    out[_e134] = static_cast<int>(_e127 == 4294967295u);
    uint _e138 = u3_.x;
    uint _e139 = u3_.z;
    local_8 = static_cast<uint>(7);
    uint _e145 = local_8;
    out[_e145] = static_cast<int>(_e138 + _e139);
    uint _e148 = u4_.w;
    local_9 = static_cast<uint>(8);
    uint _e153 = local_9;
    out[_e153] = static_cast<int>(_e148);
    float3_ _e155 = f3_;
    frozen = _e155;
    float3_ _e157 = frozen;
    copied = _e157;
    copied.x = 9.0;
    float _e162 = frozen.x;
    float _e166 = copied.x;
    local_10 = static_cast<uint>(9);
    uint _e172 = local_10;
    out[_e172] = naga_f2i32((_e162 * 10.0) + _e166);
    int3_ _e174 = i3_;
    int3_ _e175 = bump(_e174);
    changed = _e175;
    int _e178 = changed.y;
    int _e182 = i3_.y;
    local_11 = static_cast<uint>(10);
    uint _e187 = local_11;
    out[_e187] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e178) * as_type<uint>(10))) + as_type<uint>(_e182));
    float3_ _e189 = f3_;
    float3_ _e190 = shift(_e189);
    local_12 = static_cast<uint>(11);
    uint _e196 = local_12;
    out[_e196] = naga_f2i32(_e190.z);
    metal::int2 _e198 = i2_;
    int _e199 = choose(_e198);
    uint3_ _e200 = u3_;
    int _e201 = choose_1(_e200);
    metal::float4 _e203 = f4_;
    int _e204 = choose_2(_e203);
    local_13 = static_cast<uint>(12);
    uint _e209 = local_13;
    out[_e209] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e199) + as_type<uint>(_e201))) + as_type<uint>(_e204));
    float3_ _e211 = f3_;
    samples.inner[0] = _e211;
    samples.inner[1] = float3_ {static_cast<float>(5), static_cast<float>(6), static_cast<float>(7)};
    index = 0;
    int _e226 = index;
    index = as_type<int>(as_type<uint>(_e226) + as_type<uint>(1));
    int _e229 = index;
    int _e230 = index;
    index = as_type<int>(as_type<uint>(_e230) + as_type<uint>(1));
    float _e235 = samples.inner[_e230].x;
    samples.inner[_e230].x = _e235 + static_cast<float>(_e229);
    float _e238 = samples.inner[_e230].x;
    local_14 = static_cast<uint>(13);
    uint _e243 = local_14;
    out[_e243] = naga_f2i32(_e238);
    int _e245 = index;
    float _e251 = samples.inner[0].x;
    float _e259 = samples.inner[1].x;
    local_15 = static_cast<uint>(14);
    uint _e265 = local_15;
    out[_e265] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e245) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(naga_f2i32(_e251)) * as_type<uint>(10))))) + as_type<uint>(naga_f2i32(_e259)));
    choose_first = false;
    bool _e269 = choose_first;
    if (_e269) {
        float _e273 = samples.inner[0].y;
        samples.inner[0].y = _e273 + static_cast<float>(1);
        local_17 = _e273;
    } else {
        float _e281 = samples.inner[1].y;
        samples.inner[1].y = _e281 + static_cast<float>(1);
        local_17 = _e281;
    }
    float _e287 = local_17;
    local_16 = static_cast<uint>(15);
    uint _e292 = local_16;
    out[_e292] = naga_f2i32(_e287);
    float _e297 = samples.inner[1].y;
    local_18 = static_cast<uint>(16);
    uint _e302 = local_18;
    out[_e302] = naga_f2i32(_e297);
    float3_ _e304 = f3_;
    bool _e305 = choose_first;
    if (_e305) {
        samples.inner[0] = _e304;
        float _e309 = samples.inner[0].z;
        local_20 = _e309;
    } else {
        samples.inner[1] = _e304;
        float _e314 = samples.inner[1].z;
        local_20 = _e314;
    }
    float _e317 = local_20;
    local_19 = static_cast<uint>(17);
    uint _e322 = local_19;
    out[_e322] = naga_f2i32(_e317);
    if (true) {
        local_22 = float3_ {static_cast<float>(7), static_cast<float>(8), static_cast<float>(9)};
    } else {
        float3_ _e333 = f3_;
        local_22 = _e333;
    }
    float3_ _e336 = local_22;
    local_21 = static_cast<uint>(18);
    uint _e342 = local_21;
    out[_e342] = naga_f2i32(_e336.y);
    {
        local_23 = as_type<int>(as_type<uint>(seed) + as_type<uint>(2));
        int _e347 = local_23;
        local_24 = static_cast<uint>(19);
        uint _e351 = local_24;
        local_29 = _e351;
        uint _e353 = local_29;
        out[_e353] = _e347;
    }
    argument = 3;
    int _e357 = argument;
    int _e358 = argument;
    argument = as_type<int>(as_type<uint>(_e358) + as_type<uint>(1));
    int _e361 = argument;
    captured = int3_ {_e357, _e358, _e361};
    int _e365 = captured.x;
    int _e369 = captured.y;
    int _e374 = captured.z;
    local_25 = static_cast<uint>(20);
    uint _e379 = local_25;
    out[_e379] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e365) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e369) * as_type<uint>(10))))) + as_type<uint>(_e374));
    int _e381 = argument;
    local_26 = static_cast<uint>(21);
    uint _e385 = local_26;
    out[_e385] = _e381;
    float3_ _e387 = f3_;
    f3_.x = 9.0;
    int _e391 = pair(_e387, 4);
    local_27 = static_cast<uint>(22);
    uint _e395 = local_27;
    out[_e395] = _e391;
    float _e398 = f3_.x;
    local_28 = static_cast<uint>(23);
    uint _e403 = local_28;
    out[_e403] = naga_f2i32(_e398);
}
