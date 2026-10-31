// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_4[1];
struct type_5 {
    uint value;
    char _pad1[12];
};
struct type_7 {
    uint inner[2];
};

int increment(
    int value_1
) {
    int value_2 = {};
    value_2 = value_1;
    int _e3 = value_2;
    value_2 = as_type<int>(as_type<uint>(_e3) + as_type<uint>(2));
    int _e5 = value_2;
    return _e5;
}

int twice(
    int value_3
) {
    int value_4 = {};
    value_4 = value_3;
    int _e2 = value_4;
    int _e3 = increment(_e2);
    return as_type<int>(as_type<uint>(_e3) * as_type<uint>(2));
}

int advance(
    int value_5
) {
    int value_6 = {};
    value_6 = value_5;
    int _e2 = value_6;
    int _e3 = twice(_e2);
    return as_type<int>(as_type<uint>(_e3) + as_type<uint>(1));
}

int retreat(
    int value_7
) {
    int value_8 = {};
    value_8 = value_7;
    int _e3 = value_8;
    return as_type<int>(as_type<uint>(_e3) - as_type<uint>(3));
}

float scaled(
    float value_9
) {
    float value_10 = {};
    value_10 = value_9;
    float _e3 = value_10;
    return (_e3 * 1.5) + 0.5;
}

bool differs(
    int value_11,
    int other
) {
    int value_12 = {};
    int other_1 = {};
    value_12 = value_11;
    other_1 = other;
    int _e4 = value_12;
    int _e5 = other_1;
    return _e4 != _e5;
}

void consume(
    bool stop,
    int value_13
) {
    bool stop_1 = {};
    int value_14 = {};
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

void forward(
    bool stop_2,
    int value_15
) {
    bool stop_3 = {};
    int value_16 = {};
    stop_3 = stop_2;
    value_16 = value_15;
    bool _e4 = stop_3;
    int _e5 = value_16;
    int _e6 = retreat(_e5);
    consume(_e4, _e6);
    return;
}

uint plus_one(
    uint value_17
) {
    uint value_18 = {};
    value_18 = value_17;
    uint _e3 = value_18;
    return _e3 + 1u;
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


struct function_specifiersInput {
};
kernel void function_specifiers(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4& out_1 [[user(fake0)]]
, device type_4 const& input_1 [[user(fake0)]]
, constant type_5& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 out = {};
    type_7 input = {};
    uint n = {};
    uint i = {};
    uint base = {};
    int value = {};
    type_7 local = {};
    uint local_1 = {};
    bool choose = {};
    type_7 local_2 = {};
    uint local_3 = {};
    type_7 local_4 = {};
    uint local_5 = {};
    type_7 local_6 = {};
    uint local_7 = {};
    type_7 local_8 = {};
    uint local_9 = {};
    type_7 local_10 = {};
    uint local_11 = {};
    type_7 local_12 = {};
    uint local_13 = {};
    type_7 local_14 = {};
    uint local_15 = {};
    int effect = {};
    type_7 local_16 = {};
    uint local_17 = {};
    type_7 local_18 = {};
    uint local_19 = {};
    type_7 local_20 = {};
    uint local_21 = {};
    type_7 local_22 = {};
    uint local_23 = {};
    type_7 local_24 = {};
    uint local_25 = {};
    type_7 local_26 = {};
    uint local_27 = {};
    type_7 local_28 = {};
    uint local_29 = {};
    int local_30 = {};
    int local_31 = {};
    int local_32 = {};
    type_7 local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    int local_36 = {};
    type_7 local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    type_7 local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    type_7 local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    type_7 local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    type_7 local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    type_7 local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    int local_55 = {};
    type_7 local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    type_7 local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    type_7 local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    type_7 local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    type_7 local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    type_7 local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    int local_74 = {};
    type_7 local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    type_7 local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    out = type_7 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    input = type_7 {};
    input.inner[0] = 1u;
    input.inner[1] = 0u;
    uint _e18 = n_1.value;
    n = _e18;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e26 = i;
    uint _e27 = n;
    if (_e26 < _e27) {
        uint _e29 = i;
        base = _e29 * 12u;
        type_7 _e35 = input;
        local = _e35;
        uint _e36 = i;
        local_1 = static_cast<uint>(_e36);
        type_7 _e40 = local;
        local_33 = _e40;
        uint _e41 = local_1;
        uint _e43 = local_33.inner[1];
        local_33.inner[1] = _e43 + _e41;
        uint _e47 = local_33.inner[0];
        local_34 = static_cast<uint>(_e47);
        uint _e51 = local_33.inner[1];
        local_35 = static_cast<uint>(_e51);
        uint _e55 = local_35;
        int _e57 = input_1[_e55];
        local_36 = _e57;
        int _e58 = local_36;
        local_30 = _e58;
        int _e60 = local_30;
        value = _e60;
        uint _e62 = i;
        choose = naga_mod(_e62, 2u) == 0u;
        int _e68 = value;
        int _e69 = increment(_e68);
        type_7 _e72 = out;
        local_2 = _e72;
        uint _e73 = base;
        local_3 = static_cast<uint>(_e73);
        type_7 _e77 = local_2;
        local_37 = _e77;
        uint _e78 = local_3;
        uint _e80 = local_37.inner[1];
        local_37.inner[1] = _e80 + _e78;
        uint _e84 = local_37.inner[0];
        local_38 = static_cast<uint>(_e84);
        uint _e88 = local_37.inner[1];
        local_39 = static_cast<uint>(_e88);
        uint _e91 = local_39;
        out_1[_e91] = _e69;
        int _e93 = value;
        int _e94 = twice(_e93);
        type_7 _e96 = out;
        local_4 = _e96;
        uint _e97 = base;
        local_5 = static_cast<uint>(_e97 + 1u);
        type_7 _e103 = local_4;
        local_40 = _e103;
        uint _e104 = local_5;
        uint _e106 = local_40.inner[1];
        local_40.inner[1] = _e106 + _e104;
        uint _e110 = local_40.inner[0];
        local_41 = static_cast<uint>(_e110);
        uint _e114 = local_40.inner[1];
        local_42 = static_cast<uint>(_e114);
        uint _e117 = local_42;
        out_1[_e117] = _e94;
        int _e119 = value;
        int _e120 = advance(_e119);
        type_7 _e122 = out;
        local_6 = _e122;
        uint _e123 = base;
        local_7 = static_cast<uint>(_e123 + 2u);
        type_7 _e129 = local_6;
        local_43 = _e129;
        uint _e130 = local_7;
        uint _e132 = local_43.inner[1];
        local_43.inner[1] = _e132 + _e130;
        uint _e136 = local_43.inner[0];
        local_44 = static_cast<uint>(_e136);
        uint _e140 = local_43.inner[1];
        local_45 = static_cast<uint>(_e140);
        uint _e143 = local_45;
        out_1[_e143] = _e120;
        int _e145 = value;
        int _e146 = retreat(_e145);
        type_7 _e148 = out;
        local_8 = _e148;
        uint _e149 = base;
        local_9 = static_cast<uint>(_e149 + 3u);
        type_7 _e155 = local_8;
        local_46 = _e155;
        uint _e156 = local_9;
        uint _e158 = local_46.inner[1];
        local_46.inner[1] = _e158 + _e156;
        uint _e162 = local_46.inner[0];
        local_47 = static_cast<uint>(_e162);
        uint _e166 = local_46.inner[1];
        local_48 = static_cast<uint>(_e166);
        uint _e169 = local_48;
        out_1[_e169] = _e146;
        int _e171 = value;
        float _e173 = scaled(static_cast<float>(_e171));
        type_7 _e175 = out;
        local_10 = _e175;
        uint _e176 = base;
        local_11 = static_cast<uint>(_e176 + 4u);
        type_7 _e183 = local_10;
        local_49 = _e183;
        uint _e184 = local_11;
        uint _e186 = local_49.inner[1];
        local_49.inner[1] = _e186 + _e184;
        uint _e190 = local_49.inner[0];
        local_50 = static_cast<uint>(_e190);
        uint _e194 = local_49.inner[1];
        local_51 = static_cast<uint>(_e194);
        uint _e197 = local_51;
        out_1[_e197] = naga_f2i32(_e173);
        int _e199 = value;
        type_7 _e201 = input;
        local_14 = _e201;
        uint _e202 = i;
        local_15 = static_cast<uint>(_e202);
        type_7 _e206 = local_14;
        local_52 = _e206;
        uint _e207 = local_15;
        uint _e209 = local_52.inner[1];
        local_52.inner[1] = _e209 + _e207;
        uint _e213 = local_52.inner[0];
        local_53 = static_cast<uint>(_e213);
        uint _e217 = local_52.inner[1];
        local_54 = static_cast<uint>(_e217);
        uint _e221 = local_54;
        int _e223 = input_1[_e221];
        local_55 = _e223;
        int _e224 = local_55;
        local_31 = _e224;
        int _e226 = local_31;
        bool _e227 = differs(_e199, _e226);
        type_7 _e229 = out;
        local_12 = _e229;
        uint _e230 = base;
        local_13 = static_cast<uint>(_e230 + 5u);
        type_7 _e237 = local_12;
        local_56 = _e237;
        uint _e238 = local_13;
        uint _e240 = local_56.inner[1];
        local_56.inner[1] = _e240 + _e238;
        uint _e244 = local_56.inner[0];
        local_57 = static_cast<uint>(_e244);
        uint _e248 = local_56.inner[1];
        local_58 = static_cast<uint>(_e248);
        uint _e251 = local_58;
        out_1[_e251] = static_cast<int>(_e227);
        int _e253 = value;
        effect = _e253;
        bool _e255 = choose;
        int _e256 = effect;
        effect = as_type<int>(as_type<uint>(_e256) + as_type<uint>(1));
        consume(_e255, _e256);
        int _e259 = effect;
        type_7 _e261 = out;
        local_16 = _e261;
        uint _e262 = base;
        local_17 = static_cast<uint>(_e262 + 6u);
        type_7 _e268 = local_16;
        local_59 = _e268;
        uint _e269 = local_17;
        uint _e271 = local_59.inner[1];
        local_59.inner[1] = _e271 + _e269;
        uint _e275 = local_59.inner[0];
        local_60 = static_cast<uint>(_e275);
        uint _e279 = local_59.inner[1];
        local_61 = static_cast<uint>(_e279);
        uint _e282 = local_61;
        out_1[_e282] = _e259;
        bool _e284 = choose;
        int _e286 = effect;
        effect = as_type<int>(as_type<uint>(_e286) + as_type<uint>(1));
        forward(!(_e284), _e286);
        int _e289 = effect;
        type_7 _e291 = out;
        local_18 = _e291;
        uint _e292 = base;
        local_19 = static_cast<uint>(_e292 + 7u);
        type_7 _e298 = local_18;
        local_62 = _e298;
        uint _e299 = local_19;
        uint _e301 = local_62.inner[1];
        local_62.inner[1] = _e301 + _e299;
        uint _e305 = local_62.inner[0];
        local_63 = static_cast<uint>(_e305);
        uint _e309 = local_62.inner[1];
        local_64 = static_cast<uint>(_e309);
        uint _e312 = local_64;
        out_1[_e312] = _e289;
        int _e314 = effect;
        int _e315 = advance(_e314);
        type_7 _e317 = out;
        local_20 = _e317;
        uint _e318 = base;
        local_21 = static_cast<uint>(_e318 + 8u);
        type_7 _e324 = local_20;
        local_65 = _e324;
        uint _e325 = local_21;
        uint _e327 = local_65.inner[1];
        local_65.inner[1] = _e327 + _e325;
        uint _e331 = local_65.inner[0];
        local_66 = static_cast<uint>(_e331);
        uint _e335 = local_65.inner[1];
        local_67 = static_cast<uint>(_e335);
        uint _e338 = local_67;
        out_1[_e338] = _e315;
        int _e340 = effect;
        uint _e344 = plus_one(static_cast<uint>(as_type<int>(as_type<uint>(_e340) + as_type<uint>(16))));
        type_7 _e346 = out;
        local_22 = _e346;
        uint _e347 = base;
        local_23 = static_cast<uint>(_e347 + 9u);
        type_7 _e354 = local_22;
        local_68 = _e354;
        uint _e355 = local_23;
        uint _e357 = local_68.inner[1];
        local_68.inner[1] = _e357 + _e355;
        uint _e361 = local_68.inner[0];
        local_69 = static_cast<uint>(_e361);
        uint _e365 = local_68.inner[1];
        local_70 = static_cast<uint>(_e365);
        uint _e368 = local_70;
        out_1[_e368] = static_cast<int>(_e344);
        int _e370 = effect;
        type_7 _e372 = input;
        local_26 = _e372;
        uint _e373 = i;
        local_27 = static_cast<uint>(_e373);
        type_7 _e377 = local_26;
        local_71 = _e377;
        uint _e378 = local_27;
        uint _e380 = local_71.inner[1];
        local_71.inner[1] = _e380 + _e378;
        uint _e384 = local_71.inner[0];
        local_72 = static_cast<uint>(_e384);
        uint _e388 = local_71.inner[1];
        local_73 = static_cast<uint>(_e388);
        uint _e392 = local_73;
        int _e394 = input_1[_e392];
        local_74 = _e394;
        int _e395 = local_74;
        local_32 = _e395;
        int _e397 = local_32;
        bool _e398 = differs(_e370, _e397);
        type_7 _e400 = out;
        local_24 = _e400;
        uint _e401 = base;
        local_25 = static_cast<uint>(_e401 + 10u);
        type_7 _e408 = local_24;
        local_75 = _e408;
        uint _e409 = local_25;
        uint _e411 = local_75.inner[1];
        local_75.inner[1] = _e411 + _e409;
        uint _e415 = local_75.inner[0];
        local_76 = static_cast<uint>(_e415);
        uint _e419 = local_75.inner[1];
        local_77 = static_cast<uint>(_e419);
        uint _e422 = local_77;
        out_1[_e422] = static_cast<int>(_e398);
        int _e424 = effect;
        type_7 _e426 = out;
        local_28 = _e426;
        uint _e427 = base;
        local_29 = static_cast<uint>(_e427 + 11u);
        type_7 _e433 = local_28;
        local_78 = _e433;
        uint _e434 = local_29;
        uint _e436 = local_78.inner[1];
        local_78.inner[1] = _e436 + _e434;
        uint _e440 = local_78.inner[0];
        local_79 = static_cast<uint>(_e440);
        uint _e444 = local_78.inner[1];
        local_80 = static_cast<uint>(_e444);
        uint _e447 = local_80;
        out_1[_e447] = _e424;
    }
}
