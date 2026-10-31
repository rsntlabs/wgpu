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
    uint local_30 = {};
    uint local_31 = {};
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
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_29 = static_cast<uint>(_e3);
    uint _e6 = local_29;
    int seed = out[_e6];
    f2_ = metal::float2(static_cast<float>(seed), 1.5);
    f3_ = float3_ {1.0, 2.0, 3.0};
    f4_ = metal::float4(static_cast<float>(1), static_cast<float>(2), static_cast<float>(3), static_cast<float>(4));
    i2_ = metal::int2(seed, naga_neg(2));
    i3_ = int3_ {1, 2, 3};
    i4_ = metal::int4(1, 2, 3, 4);
    u2_ = metal::uint2(static_cast<uint>(naga_neg(1)), static_cast<uint>(2));
    u3_ = uint3_ {static_cast<uint>(1), static_cast<uint>(2), static_cast<uint>(3)};
    u4_ = metal::uint4(static_cast<uint>(1), static_cast<uint>(2), static_cast<uint>(3), static_cast<uint>(4));
    float _e71 = f2_.x;
    float _e72 = f2_.y;
    local_1 = static_cast<uint>(0);
    uint _e78 = local_1;
    local_30 = static_cast<uint>(_e78);
    uint _e81 = local_30;
    out[_e81] = naga_f2i32(_e71 + _e72);
    float _e85 = f3_.x;
    float _e86 = f3_.y;
    float _e89 = f3_.z;
    local_2 = static_cast<uint>(1);
    uint _e95 = local_2;
    local_31 = static_cast<uint>(_e95);
    uint _e98 = local_31;
    out[_e98] = naga_f2i32((_e85 + _e86) + _e89);
    float _e101 = f4_.w;
    local_3 = static_cast<uint>(2);
    uint _e106 = local_3;
    local_32 = static_cast<uint>(_e106);
    uint _e109 = local_32;
    out[_e109] = naga_f2i32(_e101);
    int _e113 = i2_.x;
    int _e114 = i2_.y;
    local_4 = static_cast<uint>(3);
    uint _e119 = local_4;
    local_33 = static_cast<uint>(_e119);
    uint _e122 = local_33;
    out[_e122] = as_type<int>(as_type<uint>(_e113) + as_type<uint>(_e114));
    int _e125 = i3_.z;
    local_5 = static_cast<uint>(4);
    uint _e129 = local_5;
    local_34 = static_cast<uint>(_e129);
    uint _e132 = local_34;
    out[_e132] = _e125;
    int _e136 = i4_.x;
    int _e137 = i4_.w;
    local_6 = static_cast<uint>(5);
    uint _e142 = local_6;
    local_35 = static_cast<uint>(_e142);
    uint _e145 = local_35;
    out[_e145] = as_type<int>(as_type<uint>(_e136) + as_type<uint>(_e137));
    uint _e148 = u2_.x;
    local_7 = static_cast<uint>(6);
    uint _e155 = local_7;
    local_36 = static_cast<uint>(_e155);
    uint _e158 = local_36;
    out[_e158] = static_cast<int>(_e148 == 4294967295u);
    uint _e162 = u3_.x;
    uint _e163 = u3_.z;
    local_8 = static_cast<uint>(7);
    uint _e169 = local_8;
    local_37 = static_cast<uint>(_e169);
    uint _e172 = local_37;
    out[_e172] = static_cast<int>(_e162 + _e163);
    uint _e175 = u4_.w;
    local_9 = static_cast<uint>(8);
    uint _e180 = local_9;
    local_38 = static_cast<uint>(_e180);
    uint _e183 = local_38;
    out[_e183] = static_cast<int>(_e175);
    float3_ _e185 = f3_;
    frozen = _e185;
    float3_ _e187 = frozen;
    copied = _e187;
    copied.x = 9.0;
    float _e192 = frozen.x;
    float _e196 = copied.x;
    local_10 = static_cast<uint>(9);
    uint _e202 = local_10;
    local_39 = static_cast<uint>(_e202);
    uint _e205 = local_39;
    out[_e205] = naga_f2i32((_e192 * 10.0) + _e196);
    int3_ _e207 = i3_;
    int3_ _e208 = bump(_e207);
    changed = _e208;
    int _e211 = changed.y;
    int _e215 = i3_.y;
    local_11 = static_cast<uint>(10);
    uint _e220 = local_11;
    local_40 = static_cast<uint>(_e220);
    uint _e223 = local_40;
    out[_e223] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e211) * as_type<uint>(10))) + as_type<uint>(_e215));
    float3_ _e225 = f3_;
    float3_ _e226 = shift(_e225);
    local_12 = static_cast<uint>(11);
    uint _e232 = local_12;
    local_41 = static_cast<uint>(_e232);
    uint _e235 = local_41;
    out[_e235] = naga_f2i32(_e226.z);
    metal::int2 _e237 = i2_;
    int _e238 = choose(_e237);
    uint3_ _e239 = u3_;
    int _e240 = choose_1(_e239);
    metal::float4 _e242 = f4_;
    int _e243 = choose_2(_e242);
    local_13 = static_cast<uint>(12);
    uint _e248 = local_13;
    local_42 = static_cast<uint>(_e248);
    uint _e251 = local_42;
    out[_e251] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e238) + as_type<uint>(_e240))) + as_type<uint>(_e243));
    float3_ _e253 = f3_;
    samples.inner[0] = _e253;
    samples.inner[1] = float3_ {static_cast<float>(5), static_cast<float>(6), static_cast<float>(7)};
    index = 0;
    int _e268 = index;
    index = as_type<int>(as_type<uint>(_e268) + as_type<uint>(1));
    int _e271 = index;
    int _e272 = index;
    index = as_type<int>(as_type<uint>(_e272) + as_type<uint>(1));
    float _e277 = samples.inner[_e272].x;
    samples.inner[_e272].x = _e277 + static_cast<float>(_e271);
    float _e280 = samples.inner[_e272].x;
    local_14 = static_cast<uint>(13);
    uint _e285 = local_14;
    local_43 = static_cast<uint>(_e285);
    uint _e288 = local_43;
    out[_e288] = naga_f2i32(_e280);
    int _e290 = index;
    float _e296 = samples.inner[0].x;
    float _e304 = samples.inner[1].x;
    local_15 = static_cast<uint>(14);
    uint _e310 = local_15;
    local_44 = static_cast<uint>(_e310);
    uint _e313 = local_44;
    out[_e313] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e290) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(naga_f2i32(_e296)) * as_type<uint>(10))))) + as_type<uint>(naga_f2i32(_e304)));
    choose_first = false;
    bool _e317 = choose_first;
    if (_e317) {
        float _e321 = samples.inner[0].y;
        samples.inner[0].y = _e321 + static_cast<float>(1);
        local_17 = _e321;
    } else {
        float _e329 = samples.inner[1].y;
        samples.inner[1].y = _e329 + static_cast<float>(1);
        local_17 = _e329;
    }
    float _e335 = local_17;
    local_16 = static_cast<uint>(15);
    uint _e340 = local_16;
    local_45 = static_cast<uint>(_e340);
    uint _e343 = local_45;
    out[_e343] = naga_f2i32(_e335);
    float _e348 = samples.inner[1].y;
    local_18 = static_cast<uint>(16);
    uint _e353 = local_18;
    local_46 = static_cast<uint>(_e353);
    uint _e356 = local_46;
    out[_e356] = naga_f2i32(_e348);
    float3_ _e358 = f3_;
    bool _e359 = choose_first;
    if (_e359) {
        samples.inner[0] = _e358;
        float _e363 = samples.inner[0].z;
        local_20 = _e363;
    } else {
        samples.inner[1] = _e358;
        float _e368 = samples.inner[1].z;
        local_20 = _e368;
    }
    float _e371 = local_20;
    local_19 = static_cast<uint>(17);
    uint _e376 = local_19;
    local_47 = static_cast<uint>(_e376);
    uint _e379 = local_47;
    out[_e379] = naga_f2i32(_e371);
    if (true) {
        local_22 = float3_ {static_cast<float>(7), static_cast<float>(8), static_cast<float>(9)};
    } else {
        float3_ _e390 = f3_;
        local_22 = _e390;
    }
    float3_ _e393 = local_22;
    local_21 = static_cast<uint>(18);
    uint _e399 = local_21;
    local_48 = static_cast<uint>(_e399);
    uint _e402 = local_48;
    out[_e402] = naga_f2i32(_e393.y);
    {
        local_23 = as_type<int>(as_type<uint>(seed) + as_type<uint>(2));
        int _e407 = local_23;
        local_24 = static_cast<uint>(19);
        uint _e411 = local_24;
        local_49 = static_cast<uint>(_e411);
        uint _e414 = local_49;
        out[_e414] = _e407;
    }
    argument = 3;
    int _e418 = argument;
    int _e419 = argument;
    argument = as_type<int>(as_type<uint>(_e419) + as_type<uint>(1));
    int _e422 = argument;
    captured = int3_ {_e418, _e419, _e422};
    int _e426 = captured.x;
    int _e430 = captured.y;
    int _e435 = captured.z;
    local_25 = static_cast<uint>(20);
    uint _e440 = local_25;
    local_50 = static_cast<uint>(_e440);
    uint _e443 = local_50;
    out[_e443] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e426) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e430) * as_type<uint>(10))))) + as_type<uint>(_e435));
    int _e445 = argument;
    local_26 = static_cast<uint>(21);
    uint _e449 = local_26;
    local_51 = static_cast<uint>(_e449);
    uint _e452 = local_51;
    out[_e452] = _e445;
    float3_ _e454 = f3_;
    f3_.x = 9.0;
    int _e458 = pair(_e454, 4);
    local_27 = static_cast<uint>(22);
    uint _e462 = local_27;
    local_52 = static_cast<uint>(_e462);
    uint _e465 = local_52;
    out[_e465] = _e458;
    float _e468 = f3_.x;
    local_28 = static_cast<uint>(23);
    uint _e473 = local_28;
    local_53 = static_cast<uint>(_e473);
    uint _e476 = local_53;
    out[_e476] = naga_f2i32(_e468);
}
