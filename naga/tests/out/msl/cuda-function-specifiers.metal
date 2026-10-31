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
    int _e1 = increment(value_3);
    return as_type<int>(as_type<uint>(_e1) * as_type<uint>(2));
}

int advance(
    int value_4
) {
    int _e1 = twice(value_4);
    return as_type<int>(as_type<uint>(_e1) + as_type<uint>(1));
}

int retreat(
    int value_5
) {
    return as_type<int>(as_type<uint>(value_5) - as_type<uint>(3));
}

float scaled(
    float value_6
) {
    return (value_6 * 1.5) + 0.5;
}

bool differs(
    int value_7,
    int other
) {
    return value_7 != other;
}

void consume(
    bool stop,
    int value_8
) {
    int value_9 = {};
    value_9 = value_8;
    if (stop) {
        return;
    }
    int _e3 = value_9;
    int _e4 = advance(_e3);
    value_9 = _e4;
    return;
}

void forward(
    bool stop_1,
    int value_10
) {
    int _e2 = retreat(value_10);
    consume(stop_1, _e2);
    return;
}

uint plus_one(
    uint value_11
) {
    return value_11 + 1u;
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
, constant type_5& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 out = {};
    type_7 input = {};
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
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 12u;
        type_7 _e27 = input;
        local = _e27;
        local_1 = static_cast<uint>(i);
        type_7 _e31 = local;
        local_33 = _e31;
        uint _e33 = local_1;
        uint _e35 = local_33.inner[1];
        local_33.inner[1] = _e35 + _e33;
        uint _e39 = local_33.inner[0];
        local_34 = static_cast<uint>(_e39);
        uint _e43 = local_33.inner[1];
        local_35 = static_cast<uint>(_e43);
        uint _e46 = local_35;
        int _e49 = input_1[_e46];
        local_36 = _e49;
        int _e51 = local_36;
        local_30 = _e51;
        int _e53 = local_30;
        value = _e53;
        choose = naga_mod(i, 2u) == 0u;
        int _e60 = value;
        int _e61 = increment(_e60);
        type_7 _e63 = out;
        local_2 = _e63;
        uint _e65 = base;
        local_3 = static_cast<uint>(_e65);
        type_7 _e68 = local_2;
        local_37 = _e68;
        uint _e70 = local_3;
        uint _e72 = local_37.inner[1];
        local_37.inner[1] = _e72 + _e70;
        uint _e76 = local_37.inner[0];
        local_38 = static_cast<uint>(_e76);
        uint _e80 = local_37.inner[1];
        local_39 = static_cast<uint>(_e80);
        uint _e83 = local_39;
        out_1[_e83] = _e61;
        int _e86 = value;
        int _e87 = twice(_e86);
        type_7 _e88 = out;
        local_4 = _e88;
        uint _e90 = base;
        local_5 = static_cast<uint>(_e90 + 1u);
        type_7 _e95 = local_4;
        local_40 = _e95;
        uint _e97 = local_5;
        uint _e99 = local_40.inner[1];
        local_40.inner[1] = _e99 + _e97;
        uint _e103 = local_40.inner[0];
        local_41 = static_cast<uint>(_e103);
        uint _e107 = local_40.inner[1];
        local_42 = static_cast<uint>(_e107);
        uint _e110 = local_42;
        out_1[_e110] = _e87;
        int _e112 = value;
        int _e113 = advance(_e112);
        type_7 _e114 = out;
        local_6 = _e114;
        uint _e116 = base;
        local_7 = static_cast<uint>(_e116 + 2u);
        type_7 _e121 = local_6;
        local_43 = _e121;
        uint _e123 = local_7;
        uint _e125 = local_43.inner[1];
        local_43.inner[1] = _e125 + _e123;
        uint _e129 = local_43.inner[0];
        local_44 = static_cast<uint>(_e129);
        uint _e133 = local_43.inner[1];
        local_45 = static_cast<uint>(_e133);
        uint _e136 = local_45;
        out_1[_e136] = _e113;
        int _e138 = value;
        int _e139 = retreat(_e138);
        type_7 _e140 = out;
        local_8 = _e140;
        uint _e142 = base;
        local_9 = static_cast<uint>(_e142 + 3u);
        type_7 _e147 = local_8;
        local_46 = _e147;
        uint _e149 = local_9;
        uint _e151 = local_46.inner[1];
        local_46.inner[1] = _e151 + _e149;
        uint _e155 = local_46.inner[0];
        local_47 = static_cast<uint>(_e155);
        uint _e159 = local_46.inner[1];
        local_48 = static_cast<uint>(_e159);
        uint _e162 = local_48;
        out_1[_e162] = _e139;
        int _e164 = value;
        float _e166 = scaled(static_cast<float>(_e164));
        type_7 _e167 = out;
        local_10 = _e167;
        uint _e169 = base;
        local_11 = static_cast<uint>(_e169 + 4u);
        type_7 _e175 = local_10;
        local_49 = _e175;
        uint _e177 = local_11;
        uint _e179 = local_49.inner[1];
        local_49.inner[1] = _e179 + _e177;
        uint _e183 = local_49.inner[0];
        local_50 = static_cast<uint>(_e183);
        uint _e187 = local_49.inner[1];
        local_51 = static_cast<uint>(_e187);
        uint _e190 = local_51;
        out_1[_e190] = naga_f2i32(_e166);
        int _e192 = value;
        type_7 _e193 = input;
        local_14 = _e193;
        local_15 = static_cast<uint>(i);
        type_7 _e197 = local_14;
        local_52 = _e197;
        uint _e199 = local_15;
        uint _e201 = local_52.inner[1];
        local_52.inner[1] = _e201 + _e199;
        uint _e205 = local_52.inner[0];
        local_53 = static_cast<uint>(_e205);
        uint _e209 = local_52.inner[1];
        local_54 = static_cast<uint>(_e209);
        uint _e212 = local_54;
        int _e214 = input_1[_e212];
        local_55 = _e214;
        int _e216 = local_55;
        local_31 = _e216;
        int _e218 = local_31;
        bool _e219 = differs(_e192, _e218);
        type_7 _e220 = out;
        local_12 = _e220;
        uint _e222 = base;
        local_13 = static_cast<uint>(_e222 + 5u);
        type_7 _e228 = local_12;
        local_56 = _e228;
        uint _e230 = local_13;
        uint _e232 = local_56.inner[1];
        local_56.inner[1] = _e232 + _e230;
        uint _e236 = local_56.inner[0];
        local_57 = static_cast<uint>(_e236);
        uint _e240 = local_56.inner[1];
        local_58 = static_cast<uint>(_e240);
        uint _e243 = local_58;
        out_1[_e243] = static_cast<int>(_e219);
        int _e245 = value;
        effect = _e245;
        bool _e247 = choose;
        int _e248 = effect;
        effect = as_type<int>(as_type<uint>(_e248) + as_type<uint>(1));
        consume(_e247, _e248);
        int _e251 = effect;
        type_7 _e252 = out;
        local_16 = _e252;
        uint _e254 = base;
        local_17 = static_cast<uint>(_e254 + 6u);
        type_7 _e259 = local_16;
        local_59 = _e259;
        uint _e261 = local_17;
        uint _e263 = local_59.inner[1];
        local_59.inner[1] = _e263 + _e261;
        uint _e267 = local_59.inner[0];
        local_60 = static_cast<uint>(_e267);
        uint _e271 = local_59.inner[1];
        local_61 = static_cast<uint>(_e271);
        uint _e274 = local_61;
        out_1[_e274] = _e251;
        bool _e276 = choose;
        int _e278 = effect;
        effect = as_type<int>(as_type<uint>(_e278) + as_type<uint>(1));
        forward(!(_e276), _e278);
        int _e281 = effect;
        type_7 _e282 = out;
        local_18 = _e282;
        uint _e284 = base;
        local_19 = static_cast<uint>(_e284 + 7u);
        type_7 _e289 = local_18;
        local_62 = _e289;
        uint _e291 = local_19;
        uint _e293 = local_62.inner[1];
        local_62.inner[1] = _e293 + _e291;
        uint _e297 = local_62.inner[0];
        local_63 = static_cast<uint>(_e297);
        uint _e301 = local_62.inner[1];
        local_64 = static_cast<uint>(_e301);
        uint _e304 = local_64;
        out_1[_e304] = _e281;
        int _e306 = effect;
        int _e307 = advance(_e306);
        type_7 _e308 = out;
        local_20 = _e308;
        uint _e310 = base;
        local_21 = static_cast<uint>(_e310 + 8u);
        type_7 _e315 = local_20;
        local_65 = _e315;
        uint _e317 = local_21;
        uint _e319 = local_65.inner[1];
        local_65.inner[1] = _e319 + _e317;
        uint _e323 = local_65.inner[0];
        local_66 = static_cast<uint>(_e323);
        uint _e327 = local_65.inner[1];
        local_67 = static_cast<uint>(_e327);
        uint _e330 = local_67;
        out_1[_e330] = _e307;
        int _e332 = effect;
        uint _e336 = plus_one(static_cast<uint>(as_type<int>(as_type<uint>(_e332) + as_type<uint>(16))));
        type_7 _e337 = out;
        local_22 = _e337;
        uint _e339 = base;
        local_23 = static_cast<uint>(_e339 + 9u);
        type_7 _e345 = local_22;
        local_68 = _e345;
        uint _e347 = local_23;
        uint _e349 = local_68.inner[1];
        local_68.inner[1] = _e349 + _e347;
        uint _e353 = local_68.inner[0];
        local_69 = static_cast<uint>(_e353);
        uint _e357 = local_68.inner[1];
        local_70 = static_cast<uint>(_e357);
        uint _e360 = local_70;
        out_1[_e360] = static_cast<int>(_e336);
        int _e362 = effect;
        type_7 _e363 = input;
        local_26 = _e363;
        local_27 = static_cast<uint>(i);
        type_7 _e367 = local_26;
        local_71 = _e367;
        uint _e369 = local_27;
        uint _e371 = local_71.inner[1];
        local_71.inner[1] = _e371 + _e369;
        uint _e375 = local_71.inner[0];
        local_72 = static_cast<uint>(_e375);
        uint _e379 = local_71.inner[1];
        local_73 = static_cast<uint>(_e379);
        uint _e382 = local_73;
        int _e384 = input_1[_e382];
        local_74 = _e384;
        int _e386 = local_74;
        local_32 = _e386;
        int _e388 = local_32;
        bool _e389 = differs(_e362, _e388);
        type_7 _e390 = out;
        local_24 = _e390;
        uint _e392 = base;
        local_25 = static_cast<uint>(_e392 + 10u);
        type_7 _e398 = local_24;
        local_75 = _e398;
        uint _e400 = local_25;
        uint _e402 = local_75.inner[1];
        local_75.inner[1] = _e402 + _e400;
        uint _e406 = local_75.inner[0];
        local_76 = static_cast<uint>(_e406);
        uint _e410 = local_75.inner[1];
        local_77 = static_cast<uint>(_e410);
        uint _e413 = local_77;
        out_1[_e413] = static_cast<int>(_e389);
        int _e415 = effect;
        type_7 _e416 = out;
        local_28 = _e416;
        uint _e418 = base;
        local_29 = static_cast<uint>(_e418 + 11u);
        type_7 _e423 = local_28;
        local_78 = _e423;
        uint _e425 = local_29;
        uint _e427 = local_78.inner[1];
        local_78.inner[1] = _e427 + _e425;
        uint _e431 = local_78.inner[0];
        local_79 = static_cast<uint>(_e431);
        uint _e435 = local_78.inner[1];
        local_80 = static_cast<uint>(_e435);
        uint _e438 = local_80;
        out_1[_e438] = _e415;
    }
}
