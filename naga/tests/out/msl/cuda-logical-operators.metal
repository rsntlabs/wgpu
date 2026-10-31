// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_1 {
    int inner[2];
};
struct Sample_cuda_record_0_ {
    int value;
    type_1 payload;
};
typedef uint type_4[1];

Sample_cuda_record_0_ operator_u0026_u0026_(
    Sample_cuda_record_0_ left_1,
    Sample_cuda_record_0_ right_1
) {
    Sample_cuda_record_0_ left_2 = {};
    Sample_cuda_record_0_ right_2 = {};
    left_2 = left_1;
    right_2 = right_1;
    int _e7 = left_2.value;
    int _e10 = right_2.value;
    left_2.value = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e7) * as_type<uint>(10))) + as_type<uint>(_e10));
    int _e18 = right_2.payload.inner[0];
    int _e19 = left_2.payload.inner[1];
    left_2.payload.inner[1] = as_type<int>(as_type<uint>(_e19) + as_type<uint>(_e18));
    Sample_cuda_record_0_ _e21 = left_2;
    return _e21;
}

Sample_cuda_record_0_ operator_u007c_u007c(
    Sample_cuda_record_0_ left_3,
    Sample_cuda_record_0_ right_3
) {
    Sample_cuda_record_0_ left_4 = {};
    Sample_cuda_record_0_ right_4 = {};
    left_4 = left_3;
    right_4 = right_3;
    int _e7 = left_4.value;
    int _e10 = right_4.value;
    left_4.value = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e7) * as_type<uint>(100))) + as_type<uint>(_e10));
    int _e18 = right_4.payload.inner[1];
    int _e19 = left_4.payload.inner[0];
    left_4.payload.inner[0] = as_type<int>(as_type<uint>(_e19) + as_type<uint>(_e18));
    Sample_cuda_record_0_ _e21 = left_4;
    return _e21;
}

int operator_u0026_u0026_1(
    Sample_cuda_record_0_ left_5,
    int right_5
) {
    Sample_cuda_record_0_ left_6 = {};
    left_6 = left_5;
    int _e4 = left_6.value;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e4) * as_type<uint>(10))) + as_type<uint>(right_5));
}

int operator_u007c_u007c_1(
    int left_7,
    Sample_cuda_record_0_ right_6
) {
    Sample_cuda_record_0_ right_7 = {};
    right_7 = right_6;
    int _e6 = right_7.value;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(left_7) * as_type<uint>(100))) + as_type<uint>(_e6));
}

metal::int2 operator_u0026_u0026_2(
    metal::int2 left_8,
    metal::int2 right_8
) {
    metal::int2 left_9 = {};
    metal::int2 right_9 = {};
    left_9 = left_8;
    right_9 = right_8;
    int _e6 = left_9.x;
    int _e9 = right_9.x;
    int _e13 = left_9.y;
    int _e16 = right_9.y;
    return metal::int2(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e6) * as_type<uint>(10))) + as_type<uint>(_e9)), as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e13) * as_type<uint>(10))) + as_type<uint>(_e16)));
}

metal::int2 operator_u007c_u007c_2(
    metal::int2 left_10,
    metal::int2 right_10
) {
    metal::int2 left_11 = {};
    metal::int2 right_11 = {};
    left_11 = left_10;
    right_11 = right_10;
    int _e6 = left_11.x;
    int _e9 = right_11.x;
    int _e13 = left_11.y;
    int _e16 = right_11.y;
    return metal::int2(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e6) * as_type<uint>(100))) + as_type<uint>(_e9)), as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e13) * as_type<uint>(100))) + as_type<uint>(_e16)));
}

struct logical_operatorsInput {
};
kernel void logical_operators(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    Sample_cuda_record_0_ left = {};
    Sample_cuda_record_0_ right = {};
    Sample_cuda_record_0_ both = {};
    Sample_cuda_record_0_ either = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    metal::int2 first = {};
    metal::int2 second = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    Sample_cuda_record_0_ local_16 = {};
    uint local_17 = {};
    Sample_cuda_record_0_ local_18 = {};
    int counter = {};
    Sample_cuda_record_0_ evaluated = {};
    Sample_cuda_record_0_ local_19 = {};
    Sample_cuda_record_0_ local_20 = {};
    Sample_cuda_record_0_ local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    bool local_25 = {};
    uint local_26 = {};
    bool local_27 = {};
    uint local_28 = {};
    bool local_29 = {};
    uint local_30 = {};
    bool local_31 = {};
    uint local_32 = {};
    uint base = threadIdx.x * 24u;
    left.value = 2;
    left.payload.inner[0] = 3;
    left.payload.inner[1] = 4;
    right.value = 5;
    right.payload.inner[0] = 6;
    right.payload.inner[1] = 7;
    Sample_cuda_record_0_ _e20 = left;
    Sample_cuda_record_0_ _e21 = right;
    Sample_cuda_record_0_ _e22 = operator_u0026_u0026_(_e20, _e21);
    both = _e22;
    Sample_cuda_record_0_ _e24 = left;
    Sample_cuda_record_0_ _e25 = right;
    Sample_cuda_record_0_ _e26 = operator_u007c_u007c(_e24, _e25);
    either = _e26;
    int _e29 = both.value;
    local = static_cast<uint>(base + 0u);
    uint _e35 = local;
    out[_e35] = static_cast<uint>(_e29);
    int _e41 = both.payload.inner[1];
    local_1 = static_cast<uint>(base + 1u);
    uint _e47 = local_1;
    out[_e47] = static_cast<uint>(_e41);
    int _e50 = either.value;
    local_2 = static_cast<uint>(base + 2u);
    uint _e56 = local_2;
    out[_e56] = static_cast<uint>(_e50);
    int _e61 = either.payload.inner[0];
    local_3 = static_cast<uint>(base + 3u);
    uint _e67 = local_3;
    out[_e67] = static_cast<uint>(_e61);
    int _e70 = left.value;
    local_4 = static_cast<uint>(base + 4u);
    uint _e76 = local_4;
    out[_e76] = static_cast<uint>(_e70);
    int _e81 = left.payload.inner[1];
    local_5 = static_cast<uint>(base + 5u);
    uint _e87 = local_5;
    out[_e87] = static_cast<uint>(_e81);
    Sample_cuda_record_0_ _e89 = left;
    int _e91 = operator_u0026_u0026_1(_e89, 9);
    local_6 = static_cast<uint>(base + 6u);
    uint _e97 = local_6;
    out[_e97] = static_cast<uint>(_e91);
    Sample_cuda_record_0_ _e99 = right;
    int _e101 = operator_u007c_u007c_1(0, _e99);
    local_7 = static_cast<uint>(base + 7u);
    uint _e107 = local_7;
    out[_e107] = static_cast<uint>(_e101);
    Sample_cuda_record_0_ _e109 = left;
    Sample_cuda_record_0_ _e110 = right;
    Sample_cuda_record_0_ _e111 = operator_u0026_u0026_(_e109, _e110);
    local_8 = static_cast<uint>(base + 8u);
    uint _e118 = local_8;
    out[_e118] = static_cast<uint>(_e111.value);
    Sample_cuda_record_0_ _e120 = left;
    Sample_cuda_record_0_ _e121 = right;
    Sample_cuda_record_0_ _e122 = operator_u007c_u007c(_e120, _e121);
    local_9 = static_cast<uint>(base + 9u);
    uint _e131 = local_9;
    out[_e131] = static_cast<uint>(_e122.payload.inner[0]);
    first = metal::int2(2, 3);
    second = metal::int2(4, 5);
    metal::int2 _e141 = first;
    metal::int2 _e142 = second;
    metal::int2 _e143 = operator_u0026_u0026_2(_e141, _e142);
    local_10 = static_cast<uint>(base + 10u);
    uint _e150 = local_10;
    out[_e150] = static_cast<uint>(_e143.x);
    metal::int2 _e152 = first;
    metal::int2 _e153 = second;
    metal::int2 _e154 = operator_u007c_u007c_2(_e152, _e153);
    local_11 = static_cast<uint>(base + 11u);
    uint _e161 = local_11;
    out[_e161] = static_cast<uint>(_e154.y);
    metal::int2 _e163 = first;
    metal::int2 _e164 = second;
    metal::int2 _e165 = operator_u0026_u0026_2(_e163, _e164);
    metal::int2 _e166 = first;
    metal::int2 _e167 = operator_u0026_u0026_2(_e165, _e166);
    local_12 = static_cast<uint>(base + 12u);
    uint _e174 = local_12;
    out[_e174] = static_cast<uint>(_e167.x);
    metal::int2 _e176 = first;
    metal::int2 _e177 = second;
    metal::int2 _e178 = first;
    metal::int2 _e179 = operator_u0026_u0026_2(_e177, _e178);
    metal::int2 _e180 = operator_u007c_u007c_2(_e176, _e179);
    local_13 = static_cast<uint>(base + 13u);
    uint _e187 = local_13;
    out[_e187] = static_cast<uint>(_e180.y);
    metal::int2 _e189 = first;
    metal::int2 _e190 = second;
    metal::int2 _e191 = operator_u007c_u007c_2(_e189, _e190);
    metal::int2 _e192 = first;
    metal::int2 _e193 = operator_u0026_u0026_2(_e191, _e192);
    local_14 = static_cast<uint>(base + 14u);
    uint _e200 = local_14;
    out[_e200] = static_cast<uint>(_e193.x);
    if (true) {
        Sample_cuda_record_0_ _e203 = left;
        local_16 = _e203;
    } else {
        Sample_cuda_record_0_ _e205 = right;
        local_16 = _e205;
    }
    Sample_cuda_record_0_ _e208 = local_16;
    int _e210 = operator_u0026_u0026_1(_e208, 1);
    local_15 = static_cast<uint>(base + 15u);
    uint _e216 = local_15;
    out[_e216] = static_cast<uint>(_e210);
    if (true) {
        Sample_cuda_record_0_ _e219 = left;
        Sample_cuda_record_0_ _e220 = right;
        Sample_cuda_record_0_ _e221 = operator_u0026_u0026_(_e219, _e220);
        local_18 = _e221;
    } else {
        Sample_cuda_record_0_ _e223 = right;
        Sample_cuda_record_0_ _e224 = left;
        Sample_cuda_record_0_ _e225 = operator_u007c_u007c(_e223, _e224);
        local_18 = _e225;
    }
    Sample_cuda_record_0_ _e228 = local_18;
    local_17 = static_cast<uint>(base + 16u);
    uint _e235 = local_17;
    out[_e235] = static_cast<uint>(_e228.value);
    counter = 0;
    if (false) {
        int _e240 = counter;
        counter = as_type<int>(as_type<uint>(_e240) + as_type<uint>(1));
        local_19.value = _e240;
        local_19.payload.inner[0] = 1;
        local_19.payload.inner[1] = 2;
        Sample_cuda_record_0_ _e250 = local_19;
        Sample_cuda_record_0_ _e251 = right;
        Sample_cuda_record_0_ _e252 = operator_u0026_u0026_(_e250, _e251);
        local_21 = _e252;
    } else {
        Sample_cuda_record_0_ _e254 = left;
        int _e255 = counter;
        counter = as_type<int>(as_type<uint>(_e255) + as_type<uint>(1));
        local_20.value = _e255;
        local_20.payload.inner[0] = 1;
        local_20.payload.inner[1] = 2;
        Sample_cuda_record_0_ _e265 = local_20;
        Sample_cuda_record_0_ _e266 = operator_u007c_u007c(_e254, _e265);
        local_21 = _e266;
    }
    Sample_cuda_record_0_ _e269 = local_21;
    evaluated = _e269;
    int _e272 = evaluated.value;
    local_22 = static_cast<uint>(base + 17u);
    uint _e278 = local_22;
    out[_e278] = static_cast<uint>(_e272);
    int _e280 = counter;
    local_23 = static_cast<uint>(base + 18u);
    uint _e286 = local_23;
    out[_e286] = static_cast<uint>(_e280);
    local_25 = false;
    if (false) {
        Sample_cuda_record_0_ _e290 = left;
        Sample_cuda_record_0_ _e291 = right;
        Sample_cuda_record_0_ _e292 = operator_u0026_u0026_(_e290, _e291);
        local_25 = _e292.value != 0;
    }
    bool _e296 = local_25;
    local_24 = static_cast<uint>(base + 19u);
    uint _e302 = local_24;
    out[_e302] = static_cast<uint>(_e296);
    local_27 = true;
    if (true) {
    } else {
        Sample_cuda_record_0_ _e306 = left;
        Sample_cuda_record_0_ _e307 = right;
        Sample_cuda_record_0_ _e308 = operator_u007c_u007c(_e306, _e307);
        local_27 = _e308.value != 0;
    }
    bool _e312 = local_27;
    local_26 = static_cast<uint>(base + 20u);
    uint _e318 = local_26;
    out[_e318] = static_cast<uint>(_e312);
    bool _e322 = 2 != 0;
    local_29 = _e322;
    if (_e322) {
        local_29 = 3 != 0;
    }
    bool _e327 = local_29;
    local_28 = static_cast<uint>(base + 21u);
    uint _e333 = local_28;
    out[_e333] = static_cast<uint>(_e327);
    bool _e337 = 0 != 0;
    local_31 = _e337;
    if (_e337) {
    } else {
        local_31 = 4 != 0;
    }
    bool _e342 = local_31;
    local_30 = static_cast<uint>(base + 22u);
    uint _e348 = local_30;
    out[_e348] = static_cast<uint>(_e342);
    local_32 = static_cast<uint>(base + 23u);
    uint _e355 = local_32;
    out[_e355] = threadIdx.x;
}
