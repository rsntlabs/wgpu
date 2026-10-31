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
    int local_29 = {};
    uint local_30 = {};
    int local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_30 = static_cast<uint>(_e3);
    uint _e6 = local_30;
    int _e9 = out[_e6];
    local_31 = _e9;
    int _e11 = local_31;
    local_29 = _e11;
    int seed = local_29;
    f2_ = metal::float2(static_cast<float>(seed), 1.5);
    f3_ = float3_ {1.0, 2.0, 3.0};
    f4_ = metal::float4(static_cast<float>(1), static_cast<float>(2), static_cast<float>(3), static_cast<float>(4));
    i2_ = metal::int2(seed, naga_neg(2));
    i3_ = int3_ {1, 2, 3};
    i4_ = metal::int4(1, 2, 3, 4);
    u2_ = metal::uint2(static_cast<uint>(naga_neg(1)), static_cast<uint>(2));
    u3_ = uint3_ {static_cast<uint>(1), static_cast<uint>(2), static_cast<uint>(3)};
    u4_ = metal::uint4(static_cast<uint>(1), static_cast<uint>(2), static_cast<uint>(3), static_cast<uint>(4));
    float _e75 = f2_.x;
    float _e76 = f2_.y;
    local_1 = static_cast<uint>(0);
    uint _e82 = local_1;
    local_32 = static_cast<uint>(_e82);
    uint _e85 = local_32;
    out[_e85] = naga_f2i32(_e75 + _e76);
    float _e89 = f3_.x;
    float _e90 = f3_.y;
    float _e93 = f3_.z;
    local_2 = static_cast<uint>(1);
    uint _e99 = local_2;
    local_33 = static_cast<uint>(_e99);
    uint _e102 = local_33;
    out[_e102] = naga_f2i32((_e89 + _e90) + _e93);
    float _e105 = f4_.w;
    local_3 = static_cast<uint>(2);
    uint _e110 = local_3;
    local_34 = static_cast<uint>(_e110);
    uint _e113 = local_34;
    out[_e113] = naga_f2i32(_e105);
    int _e117 = i2_.x;
    int _e118 = i2_.y;
    local_4 = static_cast<uint>(3);
    uint _e123 = local_4;
    local_35 = static_cast<uint>(_e123);
    uint _e126 = local_35;
    out[_e126] = as_type<int>(as_type<uint>(_e117) + as_type<uint>(_e118));
    int _e129 = i3_.z;
    local_5 = static_cast<uint>(4);
    uint _e133 = local_5;
    local_36 = static_cast<uint>(_e133);
    uint _e136 = local_36;
    out[_e136] = _e129;
    int _e140 = i4_.x;
    int _e141 = i4_.w;
    local_6 = static_cast<uint>(5);
    uint _e146 = local_6;
    local_37 = static_cast<uint>(_e146);
    uint _e149 = local_37;
    out[_e149] = as_type<int>(as_type<uint>(_e140) + as_type<uint>(_e141));
    uint _e152 = u2_.x;
    local_7 = static_cast<uint>(6);
    uint _e159 = local_7;
    local_38 = static_cast<uint>(_e159);
    uint _e162 = local_38;
    out[_e162] = static_cast<int>(_e152 == 4294967295u);
    uint _e166 = u3_.x;
    uint _e167 = u3_.z;
    local_8 = static_cast<uint>(7);
    uint _e173 = local_8;
    local_39 = static_cast<uint>(_e173);
    uint _e176 = local_39;
    out[_e176] = static_cast<int>(_e166 + _e167);
    uint _e179 = u4_.w;
    local_9 = static_cast<uint>(8);
    uint _e184 = local_9;
    local_40 = static_cast<uint>(_e184);
    uint _e187 = local_40;
    out[_e187] = static_cast<int>(_e179);
    float3_ _e189 = f3_;
    frozen = _e189;
    float3_ _e191 = frozen;
    copied = _e191;
    copied.x = 9.0;
    float _e196 = frozen.x;
    float _e200 = copied.x;
    local_10 = static_cast<uint>(9);
    uint _e206 = local_10;
    local_41 = static_cast<uint>(_e206);
    uint _e209 = local_41;
    out[_e209] = naga_f2i32((_e196 * 10.0) + _e200);
    int3_ _e211 = i3_;
    int3_ _e212 = bump(_e211);
    changed = _e212;
    int _e215 = changed.y;
    int _e219 = i3_.y;
    local_11 = static_cast<uint>(10);
    uint _e224 = local_11;
    local_42 = static_cast<uint>(_e224);
    uint _e227 = local_42;
    out[_e227] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e215) * as_type<uint>(10))) + as_type<uint>(_e219));
    float3_ _e229 = f3_;
    float3_ _e230 = shift(_e229);
    local_12 = static_cast<uint>(11);
    uint _e236 = local_12;
    local_43 = static_cast<uint>(_e236);
    uint _e239 = local_43;
    out[_e239] = naga_f2i32(_e230.z);
    metal::int2 _e241 = i2_;
    int _e242 = choose(_e241);
    uint3_ _e243 = u3_;
    int _e244 = choose_1(_e243);
    metal::float4 _e246 = f4_;
    int _e247 = choose_2(_e246);
    local_13 = static_cast<uint>(12);
    uint _e252 = local_13;
    local_44 = static_cast<uint>(_e252);
    uint _e255 = local_44;
    out[_e255] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e242) + as_type<uint>(_e244))) + as_type<uint>(_e247));
    float3_ _e257 = f3_;
    samples.inner[0] = _e257;
    samples.inner[1] = float3_ {static_cast<float>(5), static_cast<float>(6), static_cast<float>(7)};
    index = 0;
    int _e272 = index;
    index = as_type<int>(as_type<uint>(_e272) + as_type<uint>(1));
    int _e275 = index;
    int _e276 = index;
    index = as_type<int>(as_type<uint>(_e276) + as_type<uint>(1));
    float _e281 = samples.inner[_e276].x;
    samples.inner[_e276].x = _e281 + static_cast<float>(_e275);
    float _e284 = samples.inner[_e276].x;
    local_14 = static_cast<uint>(13);
    uint _e289 = local_14;
    local_45 = static_cast<uint>(_e289);
    uint _e292 = local_45;
    out[_e292] = naga_f2i32(_e284);
    int _e294 = index;
    float _e300 = samples.inner[0].x;
    float _e308 = samples.inner[1].x;
    local_15 = static_cast<uint>(14);
    uint _e314 = local_15;
    local_46 = static_cast<uint>(_e314);
    uint _e317 = local_46;
    out[_e317] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e294) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(naga_f2i32(_e300)) * as_type<uint>(10))))) + as_type<uint>(naga_f2i32(_e308)));
    choose_first = false;
    bool _e321 = choose_first;
    if (_e321) {
        float _e325 = samples.inner[0].y;
        samples.inner[0].y = _e325 + static_cast<float>(1);
        local_17 = _e325;
    } else {
        float _e333 = samples.inner[1].y;
        samples.inner[1].y = _e333 + static_cast<float>(1);
        local_17 = _e333;
    }
    float _e339 = local_17;
    local_16 = static_cast<uint>(15);
    uint _e344 = local_16;
    local_47 = static_cast<uint>(_e344);
    uint _e347 = local_47;
    out[_e347] = naga_f2i32(_e339);
    float _e352 = samples.inner[1].y;
    local_18 = static_cast<uint>(16);
    uint _e357 = local_18;
    local_48 = static_cast<uint>(_e357);
    uint _e360 = local_48;
    out[_e360] = naga_f2i32(_e352);
    float3_ _e362 = f3_;
    bool _e363 = choose_first;
    if (_e363) {
        samples.inner[0] = _e362;
        float _e367 = samples.inner[0].z;
        local_20 = _e367;
    } else {
        samples.inner[1] = _e362;
        float _e372 = samples.inner[1].z;
        local_20 = _e372;
    }
    float _e375 = local_20;
    local_19 = static_cast<uint>(17);
    uint _e380 = local_19;
    local_49 = static_cast<uint>(_e380);
    uint _e383 = local_49;
    out[_e383] = naga_f2i32(_e375);
    if (true) {
        local_22 = float3_ {static_cast<float>(7), static_cast<float>(8), static_cast<float>(9)};
    } else {
        float3_ _e394 = f3_;
        local_22 = _e394;
    }
    float3_ _e397 = local_22;
    local_21 = static_cast<uint>(18);
    uint _e403 = local_21;
    local_50 = static_cast<uint>(_e403);
    uint _e406 = local_50;
    out[_e406] = naga_f2i32(_e397.y);
    {
        local_23 = as_type<int>(as_type<uint>(seed) + as_type<uint>(2));
        int _e411 = local_23;
        local_24 = static_cast<uint>(19);
        uint _e415 = local_24;
        local_51 = static_cast<uint>(_e415);
        uint _e418 = local_51;
        out[_e418] = _e411;
    }
    argument = 3;
    int _e422 = argument;
    int _e423 = argument;
    argument = as_type<int>(as_type<uint>(_e423) + as_type<uint>(1));
    int _e426 = argument;
    captured = int3_ {_e422, _e423, _e426};
    int _e430 = captured.x;
    int _e434 = captured.y;
    int _e439 = captured.z;
    local_25 = static_cast<uint>(20);
    uint _e444 = local_25;
    local_52 = static_cast<uint>(_e444);
    uint _e447 = local_52;
    out[_e447] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e430) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e434) * as_type<uint>(10))))) + as_type<uint>(_e439));
    int _e449 = argument;
    local_26 = static_cast<uint>(21);
    uint _e453 = local_26;
    local_53 = static_cast<uint>(_e453);
    uint _e456 = local_53;
    out[_e456] = _e449;
    float3_ _e458 = f3_;
    f3_.x = 9.0;
    int _e462 = pair(_e458, 4);
    local_27 = static_cast<uint>(22);
    uint _e466 = local_27;
    local_54 = static_cast<uint>(_e466);
    uint _e469 = local_54;
    out[_e469] = _e462;
    float _e472 = f3_.x;
    local_28 = static_cast<uint>(23);
    uint _e477 = local_28;
    local_55 = static_cast<uint>(_e477);
    uint _e480 = local_55;
    out[_e480] = naga_f2i32(_e472);
}
