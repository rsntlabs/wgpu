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

int doubled(
    int value_3
) {
    int value_4 = {};
    value_4 = value_3;
    int _e2 = value_4;
    int _e3 = increment(_e2);
    return as_type<int>(as_type<uint>(_e3) * as_type<uint>(2));
}

uint advance(
    uint value_5
) {
    uint value_6 = {};
    value_6 = value_5;
    uint _e3 = value_6;
    return _e3 + 3u;
}

uint retreat(
    uint value_7
) {
    uint value_8 = {};
    value_8 = value_7;
    uint _e3 = value_8;
    return _e3 - 1u;
}

float scale(
    float value_9,
    int bias
) {
    float value_10 = {};
    int bias_1 = {};
    value_10 = value_9;
    bias_1 = bias;
    float _e5 = value_10;
    int _e7 = bias_1;
    return (_e5 * 1.5) + static_cast<float>(_e7);
}

bool same(
    int left,
    int right
) {
    int left_1 = {};
    int right_1 = {};
    left_1 = left;
    right_1 = right;
    int _e4 = left_1;
    int _e5 = right_1;
    return _e4 == _e5;
}

void consume(
    bool stop,
    int value_11
) {
    bool stop_1 = {};
    int value_12 = {};
    stop_1 = stop;
    value_12 = value_11;
    bool _e4 = stop_1;
    if (_e4) {
        return;
    }
    int _e5 = value_12;
    int _e6 = doubled(_e5);
    value_12 = _e6;
    return;
}

void forward(
    bool stop_2,
    int value_13
) {
    bool stop_3 = {};
    int value_14 = {};
    stop_3 = stop_2;
    value_14 = value_13;
    bool _e4 = stop_3;
    int _e5 = value_14;
    int _e6 = increment(_e5);
    consume(_e4, _e6);
    return;
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct inline_functionsInput {
};
kernel void inline_functions(
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
    type_7 local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    int local_58 = {};
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
    int local_71 = {};
    type_7 local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
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
        int _e62 = value;
        int _e63 = increment(_e62);
        type_7 _e66 = out;
        local_2 = _e66;
        uint _e67 = base;
        local_3 = static_cast<uint>(_e67);
        type_7 _e71 = local_2;
        local_37 = _e71;
        uint _e72 = local_3;
        uint _e74 = local_37.inner[1];
        local_37.inner[1] = _e74 + _e72;
        uint _e78 = local_37.inner[0];
        local_38 = static_cast<uint>(_e78);
        uint _e82 = local_37.inner[1];
        local_39 = static_cast<uint>(_e82);
        uint _e85 = local_39;
        out_1[_e85] = _e63;
        int _e87 = value;
        type_7 _e89 = out;
        local_4 = _e89;
        uint _e90 = base;
        local_5 = static_cast<uint>(_e90 + 1u);
        type_7 _e96 = local_4;
        local_40 = _e96;
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
        int _e113 = doubled(_e112);
        type_7 _e115 = out;
        local_6 = _e115;
        uint _e116 = base;
        local_7 = static_cast<uint>(_e116 + 2u);
        type_7 _e122 = local_6;
        local_43 = _e122;
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
        uint _e140 = advance(static_cast<uint>(_e138));
        type_7 _e142 = out;
        local_8 = _e142;
        uint _e143 = base;
        local_9 = static_cast<uint>(_e143 + 3u);
        type_7 _e150 = local_8;
        local_46 = _e150;
        uint _e151 = local_9;
        uint _e153 = local_46.inner[1];
        local_46.inner[1] = _e153 + _e151;
        uint _e157 = local_46.inner[0];
        local_47 = static_cast<uint>(_e157);
        uint _e161 = local_46.inner[1];
        local_48 = static_cast<uint>(_e161);
        uint _e164 = local_48;
        out_1[_e164] = static_cast<int>(_e140);
        int _e166 = value;
        uint _e168 = retreat(static_cast<uint>(_e166));
        type_7 _e170 = out;
        local_10 = _e170;
        uint _e171 = base;
        local_11 = static_cast<uint>(_e171 + 4u);
        type_7 _e178 = local_10;
        local_49 = _e178;
        uint _e179 = local_11;
        uint _e181 = local_49.inner[1];
        local_49.inner[1] = _e181 + _e179;
        uint _e185 = local_49.inner[0];
        local_50 = static_cast<uint>(_e185);
        uint _e189 = local_49.inner[1];
        local_51 = static_cast<uint>(_e189);
        uint _e192 = local_51;
        out_1[_e192] = static_cast<int>(_e168);
        int _e194 = value;
        float _e197 = scale(static_cast<float>(_e194), 2);
        type_7 _e199 = out;
        local_12 = _e199;
        uint _e200 = base;
        local_13 = static_cast<uint>(_e200 + 5u);
        type_7 _e207 = local_12;
        local_52 = _e207;
        uint _e208 = local_13;
        uint _e210 = local_52.inner[1];
        local_52.inner[1] = _e210 + _e208;
        uint _e214 = local_52.inner[0];
        local_53 = static_cast<uint>(_e214);
        uint _e218 = local_52.inner[1];
        local_54 = static_cast<uint>(_e218);
        uint _e221 = local_54;
        out_1[_e221] = naga_f2i32(_e197);
        int _e223 = value;
        type_7 _e225 = input;
        local_16 = _e225;
        uint _e226 = i;
        local_17 = static_cast<uint>(_e226);
        type_7 _e230 = local_16;
        local_55 = _e230;
        uint _e231 = local_17;
        uint _e233 = local_55.inner[1];
        local_55.inner[1] = _e233 + _e231;
        uint _e237 = local_55.inner[0];
        local_56 = static_cast<uint>(_e237);
        uint _e241 = local_55.inner[1];
        local_57 = static_cast<uint>(_e241);
        uint _e245 = local_57;
        int _e247 = input_1[_e245];
        local_58 = _e247;
        int _e248 = local_58;
        local_31 = _e248;
        int _e250 = local_31;
        bool _e251 = same(_e223, _e250);
        type_7 _e253 = out;
        local_14 = _e253;
        uint _e254 = base;
        local_15 = static_cast<uint>(_e254 + 6u);
        type_7 _e261 = local_14;
        local_59 = _e261;
        uint _e262 = local_15;
        uint _e264 = local_59.inner[1];
        local_59.inner[1] = _e264 + _e262;
        uint _e268 = local_59.inner[0];
        local_60 = static_cast<uint>(_e268);
        uint _e272 = local_59.inner[1];
        local_61 = static_cast<uint>(_e272);
        uint _e275 = local_61;
        out_1[_e275] = static_cast<int>(_e251);
        uint _e277 = i;
        int _e282 = value;
        value = as_type<int>(as_type<uint>(_e282) + as_type<uint>(1));
        consume(naga_mod(_e277, 2u) == 0u, _e282);
        int _e285 = value;
        type_7 _e287 = out;
        local_18 = _e287;
        uint _e288 = base;
        local_19 = static_cast<uint>(_e288 + 7u);
        type_7 _e294 = local_18;
        local_62 = _e294;
        uint _e295 = local_19;
        uint _e297 = local_62.inner[1];
        local_62.inner[1] = _e297 + _e295;
        uint _e301 = local_62.inner[0];
        local_63 = static_cast<uint>(_e301);
        uint _e305 = local_62.inner[1];
        local_64 = static_cast<uint>(_e305);
        uint _e308 = local_64;
        out_1[_e308] = _e285;
        uint _e310 = i;
        int _e315 = value;
        value = as_type<int>(as_type<uint>(_e315) + as_type<uint>(1));
        forward(naga_mod(_e310, 2u) != 0u, _e315);
        int _e318 = value;
        type_7 _e320 = out;
        local_20 = _e320;
        uint _e321 = base;
        local_21 = static_cast<uint>(_e321 + 8u);
        type_7 _e327 = local_20;
        local_65 = _e327;
        uint _e328 = local_21;
        uint _e330 = local_65.inner[1];
        local_65.inner[1] = _e330 + _e328;
        uint _e334 = local_65.inner[0];
        local_66 = static_cast<uint>(_e334);
        uint _e338 = local_65.inner[1];
        local_67 = static_cast<uint>(_e338);
        uint _e341 = local_67;
        out_1[_e341] = _e318;
        int _e343 = value;
        type_7 _e345 = input;
        local_24 = _e345;
        uint _e346 = i;
        local_25 = static_cast<uint>(_e346);
        type_7 _e350 = local_24;
        local_68 = _e350;
        uint _e351 = local_25;
        uint _e353 = local_68.inner[1];
        local_68.inner[1] = _e353 + _e351;
        uint _e357 = local_68.inner[0];
        local_69 = static_cast<uint>(_e357);
        uint _e361 = local_68.inner[1];
        local_70 = static_cast<uint>(_e361);
        uint _e365 = local_70;
        int _e367 = input_1[_e365];
        local_71 = _e367;
        int _e368 = local_71;
        local_32 = _e368;
        int _e370 = local_32;
        bool _e371 = same(_e343, _e370);
        type_7 _e373 = out;
        local_22 = _e373;
        uint _e374 = base;
        local_23 = static_cast<uint>(_e374 + 9u);
        type_7 _e381 = local_22;
        local_72 = _e381;
        uint _e382 = local_23;
        uint _e384 = local_72.inner[1];
        local_72.inner[1] = _e384 + _e382;
        uint _e388 = local_72.inner[0];
        local_73 = static_cast<uint>(_e388);
        uint _e392 = local_72.inner[1];
        local_74 = static_cast<uint>(_e392);
        uint _e395 = local_74;
        out_1[_e395] = static_cast<int>(_e371);
        int _e397 = value;
        int _e398 = increment(_e397);
        int _e399 = increment(_e398);
        type_7 _e401 = out;
        local_26 = _e401;
        uint _e402 = base;
        local_27 = static_cast<uint>(_e402 + 10u);
        type_7 _e408 = local_26;
        local_75 = _e408;
        uint _e409 = local_27;
        uint _e411 = local_75.inner[1];
        local_75.inner[1] = _e411 + _e409;
        uint _e415 = local_75.inner[0];
        local_76 = static_cast<uint>(_e415);
        uint _e419 = local_75.inner[1];
        local_77 = static_cast<uint>(_e419);
        uint _e422 = local_77;
        out_1[_e422] = _e399;
        int _e424 = value;
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
