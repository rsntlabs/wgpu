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
    uint local_56 = {};
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
    local_33 = static_cast<uint>(_e35);
    uint _e38 = local_33;
    out[_e38] = static_cast<uint>(_e29);
    int _e44 = both.payload.inner[1];
    local_1 = static_cast<uint>(base + 1u);
    uint _e50 = local_1;
    local_34 = static_cast<uint>(_e50);
    uint _e53 = local_34;
    out[_e53] = static_cast<uint>(_e44);
    int _e56 = either.value;
    local_2 = static_cast<uint>(base + 2u);
    uint _e62 = local_2;
    local_35 = static_cast<uint>(_e62);
    uint _e65 = local_35;
    out[_e65] = static_cast<uint>(_e56);
    int _e70 = either.payload.inner[0];
    local_3 = static_cast<uint>(base + 3u);
    uint _e76 = local_3;
    local_36 = static_cast<uint>(_e76);
    uint _e79 = local_36;
    out[_e79] = static_cast<uint>(_e70);
    int _e82 = left.value;
    local_4 = static_cast<uint>(base + 4u);
    uint _e88 = local_4;
    local_37 = static_cast<uint>(_e88);
    uint _e91 = local_37;
    out[_e91] = static_cast<uint>(_e82);
    int _e96 = left.payload.inner[1];
    local_5 = static_cast<uint>(base + 5u);
    uint _e102 = local_5;
    local_38 = static_cast<uint>(_e102);
    uint _e105 = local_38;
    out[_e105] = static_cast<uint>(_e96);
    Sample_cuda_record_0_ _e107 = left;
    int _e109 = operator_u0026_u0026_1(_e107, 9);
    local_6 = static_cast<uint>(base + 6u);
    uint _e115 = local_6;
    local_39 = static_cast<uint>(_e115);
    uint _e118 = local_39;
    out[_e118] = static_cast<uint>(_e109);
    Sample_cuda_record_0_ _e120 = right;
    int _e122 = operator_u007c_u007c_1(0, _e120);
    local_7 = static_cast<uint>(base + 7u);
    uint _e128 = local_7;
    local_40 = static_cast<uint>(_e128);
    uint _e131 = local_40;
    out[_e131] = static_cast<uint>(_e122);
    Sample_cuda_record_0_ _e133 = left;
    Sample_cuda_record_0_ _e134 = right;
    Sample_cuda_record_0_ _e135 = operator_u0026_u0026_(_e133, _e134);
    local_8 = static_cast<uint>(base + 8u);
    uint _e142 = local_8;
    local_41 = static_cast<uint>(_e142);
    uint _e145 = local_41;
    out[_e145] = static_cast<uint>(_e135.value);
    Sample_cuda_record_0_ _e147 = left;
    Sample_cuda_record_0_ _e148 = right;
    Sample_cuda_record_0_ _e149 = operator_u007c_u007c(_e147, _e148);
    local_9 = static_cast<uint>(base + 9u);
    uint _e158 = local_9;
    local_42 = static_cast<uint>(_e158);
    uint _e161 = local_42;
    out[_e161] = static_cast<uint>(_e149.payload.inner[0]);
    first = metal::int2(2, 3);
    second = metal::int2(4, 5);
    metal::int2 _e171 = first;
    metal::int2 _e172 = second;
    metal::int2 _e173 = operator_u0026_u0026_2(_e171, _e172);
    local_10 = static_cast<uint>(base + 10u);
    uint _e180 = local_10;
    local_43 = static_cast<uint>(_e180);
    uint _e183 = local_43;
    out[_e183] = static_cast<uint>(_e173.x);
    metal::int2 _e185 = first;
    metal::int2 _e186 = second;
    metal::int2 _e187 = operator_u007c_u007c_2(_e185, _e186);
    local_11 = static_cast<uint>(base + 11u);
    uint _e194 = local_11;
    local_44 = static_cast<uint>(_e194);
    uint _e197 = local_44;
    out[_e197] = static_cast<uint>(_e187.y);
    metal::int2 _e199 = first;
    metal::int2 _e200 = second;
    metal::int2 _e201 = operator_u0026_u0026_2(_e199, _e200);
    metal::int2 _e202 = first;
    metal::int2 _e203 = operator_u0026_u0026_2(_e201, _e202);
    local_12 = static_cast<uint>(base + 12u);
    uint _e210 = local_12;
    local_45 = static_cast<uint>(_e210);
    uint _e213 = local_45;
    out[_e213] = static_cast<uint>(_e203.x);
    metal::int2 _e215 = first;
    metal::int2 _e216 = second;
    metal::int2 _e217 = first;
    metal::int2 _e218 = operator_u0026_u0026_2(_e216, _e217);
    metal::int2 _e219 = operator_u007c_u007c_2(_e215, _e218);
    local_13 = static_cast<uint>(base + 13u);
    uint _e226 = local_13;
    local_46 = static_cast<uint>(_e226);
    uint _e229 = local_46;
    out[_e229] = static_cast<uint>(_e219.y);
    metal::int2 _e231 = first;
    metal::int2 _e232 = second;
    metal::int2 _e233 = operator_u007c_u007c_2(_e231, _e232);
    metal::int2 _e234 = first;
    metal::int2 _e235 = operator_u0026_u0026_2(_e233, _e234);
    local_14 = static_cast<uint>(base + 14u);
    uint _e242 = local_14;
    local_47 = static_cast<uint>(_e242);
    uint _e245 = local_47;
    out[_e245] = static_cast<uint>(_e235.x);
    if (true) {
        Sample_cuda_record_0_ _e248 = left;
        local_16 = _e248;
    } else {
        Sample_cuda_record_0_ _e250 = right;
        local_16 = _e250;
    }
    Sample_cuda_record_0_ _e253 = local_16;
    int _e255 = operator_u0026_u0026_1(_e253, 1);
    local_15 = static_cast<uint>(base + 15u);
    uint _e261 = local_15;
    local_48 = static_cast<uint>(_e261);
    uint _e264 = local_48;
    out[_e264] = static_cast<uint>(_e255);
    if (true) {
        Sample_cuda_record_0_ _e267 = left;
        Sample_cuda_record_0_ _e268 = right;
        Sample_cuda_record_0_ _e269 = operator_u0026_u0026_(_e267, _e268);
        local_18 = _e269;
    } else {
        Sample_cuda_record_0_ _e271 = right;
        Sample_cuda_record_0_ _e272 = left;
        Sample_cuda_record_0_ _e273 = operator_u007c_u007c(_e271, _e272);
        local_18 = _e273;
    }
    Sample_cuda_record_0_ _e276 = local_18;
    local_17 = static_cast<uint>(base + 16u);
    uint _e283 = local_17;
    local_49 = static_cast<uint>(_e283);
    uint _e286 = local_49;
    out[_e286] = static_cast<uint>(_e276.value);
    counter = 0;
    if (false) {
        int _e291 = counter;
        counter = as_type<int>(as_type<uint>(_e291) + as_type<uint>(1));
        local_19.value = _e291;
        local_19.payload.inner[0] = 1;
        local_19.payload.inner[1] = 2;
        Sample_cuda_record_0_ _e301 = local_19;
        Sample_cuda_record_0_ _e302 = right;
        Sample_cuda_record_0_ _e303 = operator_u0026_u0026_(_e301, _e302);
        local_21 = _e303;
    } else {
        Sample_cuda_record_0_ _e305 = left;
        int _e306 = counter;
        counter = as_type<int>(as_type<uint>(_e306) + as_type<uint>(1));
        local_20.value = _e306;
        local_20.payload.inner[0] = 1;
        local_20.payload.inner[1] = 2;
        Sample_cuda_record_0_ _e316 = local_20;
        Sample_cuda_record_0_ _e317 = operator_u007c_u007c(_e305, _e316);
        local_21 = _e317;
    }
    Sample_cuda_record_0_ _e320 = local_21;
    evaluated = _e320;
    int _e323 = evaluated.value;
    local_22 = static_cast<uint>(base + 17u);
    uint _e329 = local_22;
    local_50 = static_cast<uint>(_e329);
    uint _e332 = local_50;
    out[_e332] = static_cast<uint>(_e323);
    int _e334 = counter;
    local_23 = static_cast<uint>(base + 18u);
    uint _e340 = local_23;
    local_51 = static_cast<uint>(_e340);
    uint _e343 = local_51;
    out[_e343] = static_cast<uint>(_e334);
    local_25 = false;
    if (false) {
        Sample_cuda_record_0_ _e347 = left;
        Sample_cuda_record_0_ _e348 = right;
        Sample_cuda_record_0_ _e349 = operator_u0026_u0026_(_e347, _e348);
        local_25 = _e349.value != 0;
    }
    bool _e353 = local_25;
    local_24 = static_cast<uint>(base + 19u);
    uint _e359 = local_24;
    local_52 = static_cast<uint>(_e359);
    uint _e362 = local_52;
    out[_e362] = static_cast<uint>(_e353);
    local_27 = true;
    if (true) {
    } else {
        Sample_cuda_record_0_ _e366 = left;
        Sample_cuda_record_0_ _e367 = right;
        Sample_cuda_record_0_ _e368 = operator_u007c_u007c(_e366, _e367);
        local_27 = _e368.value != 0;
    }
    bool _e372 = local_27;
    local_26 = static_cast<uint>(base + 20u);
    uint _e378 = local_26;
    local_53 = static_cast<uint>(_e378);
    uint _e381 = local_53;
    out[_e381] = static_cast<uint>(_e372);
    bool _e385 = 2 != 0;
    local_29 = _e385;
    if (_e385) {
        local_29 = 3 != 0;
    }
    bool _e390 = local_29;
    local_28 = static_cast<uint>(base + 21u);
    uint _e396 = local_28;
    local_54 = static_cast<uint>(_e396);
    uint _e399 = local_54;
    out[_e399] = static_cast<uint>(_e390);
    bool _e403 = 0 != 0;
    local_31 = _e403;
    if (_e403) {
    } else {
        local_31 = 4 != 0;
    }
    bool _e408 = local_31;
    local_30 = static_cast<uint>(base + 22u);
    uint _e414 = local_30;
    local_55 = static_cast<uint>(_e414);
    uint _e417 = local_55;
    out[_e417] = static_cast<uint>(_e408);
    local_32 = static_cast<uint>(base + 23u);
    uint _e424 = local_32;
    local_56 = static_cast<uint>(_e424);
    uint _e427 = local_56;
    out[_e427] = threadIdx.x;
}
