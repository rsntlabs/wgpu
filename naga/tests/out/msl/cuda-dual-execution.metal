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

int step(
    int value_1
) {
    int value_2 = {};
    value_2 = value_1;
    int _e3 = value_2;
    value_2 = as_type<int>(as_type<uint>(_e3) + as_type<uint>(3));
    int _e5 = value_2;
    return _e5;
}

int doubled(
    int value_3
) {
    int _e1 = step(value_3);
    return as_type<int>(as_type<uint>(_e1) * as_type<uint>(2));
}

uint advance(
    uint value_4
) {
    return value_4 + 5u;
}

uint retreat(
    uint value_5
) {
    return value_5 - 2u;
}

float scale(
    float value_6,
    int bias
) {
    return (value_6 * 2.0) + static_cast<float>(bias);
}

bool same(
    int left,
    int right
) {
    return left == right;
}

void consume(
    bool stop,
    int value_7
) {
    int value_8 = {};
    value_8 = value_7;
    if (stop) {
        return;
    }
    int _e3 = value_8;
    int _e4 = doubled(_e3);
    value_8 = _e4;
    return;
}

void forward(
    bool stop_1,
    int value_9
) {
    int _e2 = step(value_9);
    consume(stop_1, _e2);
    return;
}

int device_only(
    int value_10
) {
    int _e1 = step(value_10);
    return as_type<int>(as_type<uint>(_e1) + as_type<uint>(1));
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct dual_executionInput {
};
kernel void dual_execution(
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
        int _e55 = value;
        int _e56 = step(_e55);
        type_7 _e58 = out;
        local_2 = _e58;
        uint _e60 = base;
        local_3 = static_cast<uint>(_e60);
        type_7 _e63 = local_2;
        local_37 = _e63;
        uint _e65 = local_3;
        uint _e67 = local_37.inner[1];
        local_37.inner[1] = _e67 + _e65;
        uint _e71 = local_37.inner[0];
        local_38 = static_cast<uint>(_e71);
        uint _e75 = local_37.inner[1];
        local_39 = static_cast<uint>(_e75);
        uint _e78 = local_39;
        out_1[_e78] = _e56;
        int _e81 = value;
        type_7 _e82 = out;
        local_4 = _e82;
        uint _e84 = base;
        local_5 = static_cast<uint>(_e84 + 1u);
        type_7 _e89 = local_4;
        local_40 = _e89;
        uint _e91 = local_5;
        uint _e93 = local_40.inner[1];
        local_40.inner[1] = _e93 + _e91;
        uint _e97 = local_40.inner[0];
        local_41 = static_cast<uint>(_e97);
        uint _e101 = local_40.inner[1];
        local_42 = static_cast<uint>(_e101);
        uint _e104 = local_42;
        out_1[_e104] = _e81;
        int _e106 = value;
        int _e107 = doubled(_e106);
        type_7 _e108 = out;
        local_6 = _e108;
        uint _e110 = base;
        local_7 = static_cast<uint>(_e110 + 2u);
        type_7 _e115 = local_6;
        local_43 = _e115;
        uint _e117 = local_7;
        uint _e119 = local_43.inner[1];
        local_43.inner[1] = _e119 + _e117;
        uint _e123 = local_43.inner[0];
        local_44 = static_cast<uint>(_e123);
        uint _e127 = local_43.inner[1];
        local_45 = static_cast<uint>(_e127);
        uint _e130 = local_45;
        out_1[_e130] = _e107;
        int _e132 = value;
        uint _e134 = advance(static_cast<uint>(_e132));
        type_7 _e135 = out;
        local_8 = _e135;
        uint _e137 = base;
        local_9 = static_cast<uint>(_e137 + 3u);
        type_7 _e143 = local_8;
        local_46 = _e143;
        uint _e145 = local_9;
        uint _e147 = local_46.inner[1];
        local_46.inner[1] = _e147 + _e145;
        uint _e151 = local_46.inner[0];
        local_47 = static_cast<uint>(_e151);
        uint _e155 = local_46.inner[1];
        local_48 = static_cast<uint>(_e155);
        uint _e158 = local_48;
        out_1[_e158] = static_cast<int>(_e134);
        int _e160 = value;
        uint _e162 = retreat(static_cast<uint>(_e160));
        type_7 _e163 = out;
        local_10 = _e163;
        uint _e165 = base;
        local_11 = static_cast<uint>(_e165 + 4u);
        type_7 _e171 = local_10;
        local_49 = _e171;
        uint _e173 = local_11;
        uint _e175 = local_49.inner[1];
        local_49.inner[1] = _e175 + _e173;
        uint _e179 = local_49.inner[0];
        local_50 = static_cast<uint>(_e179);
        uint _e183 = local_49.inner[1];
        local_51 = static_cast<uint>(_e183);
        uint _e186 = local_51;
        out_1[_e186] = static_cast<int>(_e162);
        int _e188 = value;
        float _e191 = scale(static_cast<float>(_e188), 4);
        type_7 _e192 = out;
        local_12 = _e192;
        uint _e194 = base;
        local_13 = static_cast<uint>(_e194 + 5u);
        type_7 _e200 = local_12;
        local_52 = _e200;
        uint _e202 = local_13;
        uint _e204 = local_52.inner[1];
        local_52.inner[1] = _e204 + _e202;
        uint _e208 = local_52.inner[0];
        local_53 = static_cast<uint>(_e208);
        uint _e212 = local_52.inner[1];
        local_54 = static_cast<uint>(_e212);
        uint _e215 = local_54;
        out_1[_e215] = naga_f2i32(_e191);
        int _e217 = value;
        type_7 _e218 = input;
        local_16 = _e218;
        local_17 = static_cast<uint>(i);
        type_7 _e222 = local_16;
        local_55 = _e222;
        uint _e224 = local_17;
        uint _e226 = local_55.inner[1];
        local_55.inner[1] = _e226 + _e224;
        uint _e230 = local_55.inner[0];
        local_56 = static_cast<uint>(_e230);
        uint _e234 = local_55.inner[1];
        local_57 = static_cast<uint>(_e234);
        uint _e237 = local_57;
        int _e239 = input_1[_e237];
        local_58 = _e239;
        int _e241 = local_58;
        local_31 = _e241;
        int _e243 = local_31;
        bool _e244 = same(_e217, _e243);
        type_7 _e245 = out;
        local_14 = _e245;
        uint _e247 = base;
        local_15 = static_cast<uint>(_e247 + 6u);
        type_7 _e253 = local_14;
        local_59 = _e253;
        uint _e255 = local_15;
        uint _e257 = local_59.inner[1];
        local_59.inner[1] = _e257 + _e255;
        uint _e261 = local_59.inner[0];
        local_60 = static_cast<uint>(_e261);
        uint _e265 = local_59.inner[1];
        local_61 = static_cast<uint>(_e265);
        uint _e268 = local_61;
        out_1[_e268] = static_cast<int>(_e244);
        int _e274 = value;
        value = as_type<int>(as_type<uint>(_e274) + as_type<uint>(1));
        consume(naga_mod(i, 2u) == 0u, _e274);
        int _e277 = value;
        type_7 _e278 = out;
        local_18 = _e278;
        uint _e280 = base;
        local_19 = static_cast<uint>(_e280 + 7u);
        type_7 _e285 = local_18;
        local_62 = _e285;
        uint _e287 = local_19;
        uint _e289 = local_62.inner[1];
        local_62.inner[1] = _e289 + _e287;
        uint _e293 = local_62.inner[0];
        local_63 = static_cast<uint>(_e293);
        uint _e297 = local_62.inner[1];
        local_64 = static_cast<uint>(_e297);
        uint _e300 = local_64;
        out_1[_e300] = _e277;
        int _e306 = value;
        value = as_type<int>(as_type<uint>(_e306) + as_type<uint>(1));
        forward(naga_mod(i, 2u) != 0u, _e306);
        int _e309 = value;
        type_7 _e310 = out;
        local_20 = _e310;
        uint _e312 = base;
        local_21 = static_cast<uint>(_e312 + 8u);
        type_7 _e317 = local_20;
        local_65 = _e317;
        uint _e319 = local_21;
        uint _e321 = local_65.inner[1];
        local_65.inner[1] = _e321 + _e319;
        uint _e325 = local_65.inner[0];
        local_66 = static_cast<uint>(_e325);
        uint _e329 = local_65.inner[1];
        local_67 = static_cast<uint>(_e329);
        uint _e332 = local_67;
        out_1[_e332] = _e309;
        int _e334 = value;
        type_7 _e335 = input;
        local_24 = _e335;
        local_25 = static_cast<uint>(i);
        type_7 _e339 = local_24;
        local_68 = _e339;
        uint _e341 = local_25;
        uint _e343 = local_68.inner[1];
        local_68.inner[1] = _e343 + _e341;
        uint _e347 = local_68.inner[0];
        local_69 = static_cast<uint>(_e347);
        uint _e351 = local_68.inner[1];
        local_70 = static_cast<uint>(_e351);
        uint _e354 = local_70;
        int _e356 = input_1[_e354];
        local_71 = _e356;
        int _e358 = local_71;
        local_32 = _e358;
        int _e360 = local_32;
        bool _e361 = same(_e334, _e360);
        type_7 _e362 = out;
        local_22 = _e362;
        uint _e364 = base;
        local_23 = static_cast<uint>(_e364 + 9u);
        type_7 _e370 = local_22;
        local_72 = _e370;
        uint _e372 = local_23;
        uint _e374 = local_72.inner[1];
        local_72.inner[1] = _e374 + _e372;
        uint _e378 = local_72.inner[0];
        local_73 = static_cast<uint>(_e378);
        uint _e382 = local_72.inner[1];
        local_74 = static_cast<uint>(_e382);
        uint _e385 = local_74;
        out_1[_e385] = static_cast<int>(_e361);
        int _e387 = value;
        int _e388 = step(_e387);
        int _e389 = device_only(_e388);
        type_7 _e390 = out;
        local_26 = _e390;
        uint _e392 = base;
        local_27 = static_cast<uint>(_e392 + 10u);
        type_7 _e397 = local_26;
        local_75 = _e397;
        uint _e399 = local_27;
        uint _e401 = local_75.inner[1];
        local_75.inner[1] = _e401 + _e399;
        uint _e405 = local_75.inner[0];
        local_76 = static_cast<uint>(_e405);
        uint _e409 = local_75.inner[1];
        local_77 = static_cast<uint>(_e409);
        uint _e412 = local_77;
        out_1[_e412] = _e389;
        int _e414 = value;
        type_7 _e415 = out;
        local_28 = _e415;
        uint _e417 = base;
        local_29 = static_cast<uint>(_e417 + 11u);
        type_7 _e422 = local_28;
        local_78 = _e422;
        uint _e424 = local_29;
        uint _e426 = local_78.inner[1];
        local_78.inner[1] = _e426 + _e424;
        uint _e430 = local_78.inner[0];
        local_79 = static_cast<uint>(_e430);
        uint _e434 = local_78.inner[1];
        local_80 = static_cast<uint>(_e434);
        uint _e437 = local_80;
        out_1[_e437] = _e414;
    }
}
