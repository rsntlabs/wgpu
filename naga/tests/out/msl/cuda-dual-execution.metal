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
    int value_4 = {};
    value_4 = value_3;
    int _e2 = value_4;
    int _e3 = step(_e2);
    return as_type<int>(as_type<uint>(_e3) * as_type<uint>(2));
}

uint advance(
    uint value_5
) {
    uint value_6 = {};
    value_6 = value_5;
    uint _e3 = value_6;
    return _e3 + 5u;
}

uint retreat(
    uint value_7
) {
    uint value_8 = {};
    value_8 = value_7;
    uint _e3 = value_8;
    return _e3 - 2u;
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
    return (_e5 * 2.0) + static_cast<float>(_e7);
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
    int _e6 = step(_e5);
    consume(_e4, _e6);
    return;
}

int device_only(
    int value_15
) {
    int value_16 = {};
    value_16 = value_15;
    int _e2 = value_16;
    int _e3 = step(_e2);
    return as_type<int>(as_type<uint>(_e3) + as_type<uint>(1));
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
, device type_4& out [[user(fake0)]]
, device type_4 const& input [[user(fake0)]]
, constant type_5& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 local = {};
    type_7 local_1 = {};
    uint n = {};
    uint i = {};
    uint base = {};
    int value = {};
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
    type_7 local_30 = {};
    uint local_31 = {};
    int local_32 = {};
    int local_33 = {};
    int local_34 = {};
    type_7 local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    int local_38 = {};
    type_7 local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    type_7 local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    type_7 local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    type_7 local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    type_7 local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    type_7 local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    type_7 local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    int local_60 = {};
    type_7 local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    type_7 local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    type_7 local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    type_7 local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    int local_73 = {};
    type_7 local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    type_7 local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    type_7 local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    local = type_7 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    local_1 = type_7 {};
    local_1.inner[0] = 1u;
    local_1.inner[1] = 0u;
    uint _e18 = n_1.value;
    n = _e18;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e26 = i;
    uint _e27 = n;
    if (_e26 < _e27) {
        uint _e29 = i;
        base = _e29 * 12u;
        type_7 _e35 = local_1;
        local_2 = _e35;
        uint _e36 = i;
        local_3 = static_cast<uint>(_e36);
        type_7 _e40 = local_2;
        local_35 = _e40;
        uint _e41 = local_3;
        uint _e43 = local_35.inner[1];
        local_35.inner[1] = _e43 + _e41;
        uint _e47 = local_35.inner[0];
        local_36 = static_cast<uint>(_e47);
        uint _e51 = local_35.inner[1];
        local_37 = static_cast<uint>(_e51);
        uint _e55 = local_37;
        int _e57 = input[_e55];
        local_38 = _e57;
        int _e58 = local_38;
        local_32 = _e58;
        int _e60 = local_32;
        value = _e60;
        int _e62 = value;
        int _e63 = step(_e62);
        type_7 _e66 = local;
        local_4 = _e66;
        uint _e67 = base;
        local_5 = static_cast<uint>(_e67);
        type_7 _e71 = local_4;
        local_39 = _e71;
        uint _e72 = local_5;
        uint _e74 = local_39.inner[1];
        local_39.inner[1] = _e74 + _e72;
        uint _e78 = local_39.inner[0];
        local_40 = static_cast<uint>(_e78);
        uint _e82 = local_39.inner[1];
        local_41 = static_cast<uint>(_e82);
        uint _e85 = local_41;
        out[_e85] = _e63;
        int _e87 = value;
        type_7 _e89 = local;
        local_6 = _e89;
        uint _e90 = base;
        local_7 = static_cast<uint>(_e90 + 1u);
        type_7 _e96 = local_6;
        local_42 = _e96;
        uint _e97 = local_7;
        uint _e99 = local_42.inner[1];
        local_42.inner[1] = _e99 + _e97;
        uint _e103 = local_42.inner[0];
        local_43 = static_cast<uint>(_e103);
        uint _e107 = local_42.inner[1];
        local_44 = static_cast<uint>(_e107);
        uint _e110 = local_44;
        out[_e110] = _e87;
        int _e112 = value;
        int _e113 = doubled(_e112);
        type_7 _e115 = local;
        local_8 = _e115;
        uint _e116 = base;
        local_9 = static_cast<uint>(_e116 + 2u);
        type_7 _e122 = local_8;
        local_45 = _e122;
        uint _e123 = local_9;
        uint _e125 = local_45.inner[1];
        local_45.inner[1] = _e125 + _e123;
        uint _e129 = local_45.inner[0];
        local_46 = static_cast<uint>(_e129);
        uint _e133 = local_45.inner[1];
        local_47 = static_cast<uint>(_e133);
        uint _e136 = local_47;
        out[_e136] = _e113;
        int _e138 = value;
        uint _e140 = advance(static_cast<uint>(_e138));
        type_7 _e142 = local;
        local_10 = _e142;
        uint _e143 = base;
        local_11 = static_cast<uint>(_e143 + 3u);
        type_7 _e150 = local_10;
        local_48 = _e150;
        uint _e151 = local_11;
        uint _e153 = local_48.inner[1];
        local_48.inner[1] = _e153 + _e151;
        uint _e157 = local_48.inner[0];
        local_49 = static_cast<uint>(_e157);
        uint _e161 = local_48.inner[1];
        local_50 = static_cast<uint>(_e161);
        uint _e164 = local_50;
        out[_e164] = static_cast<int>(_e140);
        int _e166 = value;
        uint _e168 = retreat(static_cast<uint>(_e166));
        type_7 _e170 = local;
        local_12 = _e170;
        uint _e171 = base;
        local_13 = static_cast<uint>(_e171 + 4u);
        type_7 _e178 = local_12;
        local_51 = _e178;
        uint _e179 = local_13;
        uint _e181 = local_51.inner[1];
        local_51.inner[1] = _e181 + _e179;
        uint _e185 = local_51.inner[0];
        local_52 = static_cast<uint>(_e185);
        uint _e189 = local_51.inner[1];
        local_53 = static_cast<uint>(_e189);
        uint _e192 = local_53;
        out[_e192] = static_cast<int>(_e168);
        int _e194 = value;
        float _e197 = scale(static_cast<float>(_e194), 4);
        type_7 _e199 = local;
        local_14 = _e199;
        uint _e200 = base;
        local_15 = static_cast<uint>(_e200 + 5u);
        type_7 _e207 = local_14;
        local_54 = _e207;
        uint _e208 = local_15;
        uint _e210 = local_54.inner[1];
        local_54.inner[1] = _e210 + _e208;
        uint _e214 = local_54.inner[0];
        local_55 = static_cast<uint>(_e214);
        uint _e218 = local_54.inner[1];
        local_56 = static_cast<uint>(_e218);
        uint _e221 = local_56;
        out[_e221] = naga_f2i32(_e197);
        int _e223 = value;
        type_7 _e225 = local_1;
        local_18 = _e225;
        uint _e226 = i;
        local_19 = static_cast<uint>(_e226);
        type_7 _e230 = local_18;
        local_57 = _e230;
        uint _e231 = local_19;
        uint _e233 = local_57.inner[1];
        local_57.inner[1] = _e233 + _e231;
        uint _e237 = local_57.inner[0];
        local_58 = static_cast<uint>(_e237);
        uint _e241 = local_57.inner[1];
        local_59 = static_cast<uint>(_e241);
        uint _e245 = local_59;
        int _e247 = input[_e245];
        local_60 = _e247;
        int _e248 = local_60;
        local_33 = _e248;
        int _e250 = local_33;
        bool _e251 = same(_e223, _e250);
        type_7 _e253 = local;
        local_16 = _e253;
        uint _e254 = base;
        local_17 = static_cast<uint>(_e254 + 6u);
        type_7 _e261 = local_16;
        local_61 = _e261;
        uint _e262 = local_17;
        uint _e264 = local_61.inner[1];
        local_61.inner[1] = _e264 + _e262;
        uint _e268 = local_61.inner[0];
        local_62 = static_cast<uint>(_e268);
        uint _e272 = local_61.inner[1];
        local_63 = static_cast<uint>(_e272);
        uint _e275 = local_63;
        out[_e275] = static_cast<int>(_e251);
        uint _e277 = i;
        int _e282 = value;
        value = as_type<int>(as_type<uint>(_e282) + as_type<uint>(1));
        consume(naga_mod(_e277, 2u) == 0u, _e282);
        int _e285 = value;
        type_7 _e287 = local;
        local_20 = _e287;
        uint _e288 = base;
        local_21 = static_cast<uint>(_e288 + 7u);
        type_7 _e294 = local_20;
        local_64 = _e294;
        uint _e295 = local_21;
        uint _e297 = local_64.inner[1];
        local_64.inner[1] = _e297 + _e295;
        uint _e301 = local_64.inner[0];
        local_65 = static_cast<uint>(_e301);
        uint _e305 = local_64.inner[1];
        local_66 = static_cast<uint>(_e305);
        uint _e308 = local_66;
        out[_e308] = _e285;
        uint _e310 = i;
        int _e315 = value;
        value = as_type<int>(as_type<uint>(_e315) + as_type<uint>(1));
        forward(naga_mod(_e310, 2u) != 0u, _e315);
        int _e318 = value;
        type_7 _e320 = local;
        local_22 = _e320;
        uint _e321 = base;
        local_23 = static_cast<uint>(_e321 + 8u);
        type_7 _e327 = local_22;
        local_67 = _e327;
        uint _e328 = local_23;
        uint _e330 = local_67.inner[1];
        local_67.inner[1] = _e330 + _e328;
        uint _e334 = local_67.inner[0];
        local_68 = static_cast<uint>(_e334);
        uint _e338 = local_67.inner[1];
        local_69 = static_cast<uint>(_e338);
        uint _e341 = local_69;
        out[_e341] = _e318;
        int _e343 = value;
        type_7 _e345 = local_1;
        local_26 = _e345;
        uint _e346 = i;
        local_27 = static_cast<uint>(_e346);
        type_7 _e350 = local_26;
        local_70 = _e350;
        uint _e351 = local_27;
        uint _e353 = local_70.inner[1];
        local_70.inner[1] = _e353 + _e351;
        uint _e357 = local_70.inner[0];
        local_71 = static_cast<uint>(_e357);
        uint _e361 = local_70.inner[1];
        local_72 = static_cast<uint>(_e361);
        uint _e365 = local_72;
        int _e367 = input[_e365];
        local_73 = _e367;
        int _e368 = local_73;
        local_34 = _e368;
        int _e370 = local_34;
        bool _e371 = same(_e343, _e370);
        type_7 _e373 = local;
        local_24 = _e373;
        uint _e374 = base;
        local_25 = static_cast<uint>(_e374 + 9u);
        type_7 _e381 = local_24;
        local_74 = _e381;
        uint _e382 = local_25;
        uint _e384 = local_74.inner[1];
        local_74.inner[1] = _e384 + _e382;
        uint _e388 = local_74.inner[0];
        local_75 = static_cast<uint>(_e388);
        uint _e392 = local_74.inner[1];
        local_76 = static_cast<uint>(_e392);
        uint _e395 = local_76;
        out[_e395] = static_cast<int>(_e371);
        int _e397 = value;
        int _e398 = step(_e397);
        int _e399 = device_only(_e398);
        type_7 _e401 = local;
        local_28 = _e401;
        uint _e402 = base;
        local_29 = static_cast<uint>(_e402 + 10u);
        type_7 _e408 = local_28;
        local_77 = _e408;
        uint _e409 = local_29;
        uint _e411 = local_77.inner[1];
        local_77.inner[1] = _e411 + _e409;
        uint _e415 = local_77.inner[0];
        local_78 = static_cast<uint>(_e415);
        uint _e419 = local_77.inner[1];
        local_79 = static_cast<uint>(_e419);
        uint _e422 = local_79;
        out[_e422] = _e399;
        int _e424 = value;
        type_7 _e426 = local;
        local_30 = _e426;
        uint _e427 = base;
        local_31 = static_cast<uint>(_e427 + 11u);
        type_7 _e433 = local_30;
        local_80 = _e433;
        uint _e434 = local_31;
        uint _e436 = local_80.inner[1];
        local_80.inner[1] = _e436 + _e434;
        uint _e440 = local_80.inner[0];
        local_81 = static_cast<uint>(_e440);
        uint _e444 = local_80.inner[1];
        local_82 = static_cast<uint>(_e444);
        uint _e447 = local_82;
        out[_e447] = _e424;
    }
}
