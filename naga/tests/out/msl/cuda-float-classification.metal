// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_4[1];

int finite_value(
    float value
) {
    return static_cast<int>((as_type<uint>(value) & 2147483647u) < 2139095040u);
}

int infinite_value(
    float value_1
) {
    return static_cast<int>((as_type<uint>(value_1) & 2147483647u) == 2139095040u);
}

int nan_value(
    float value_2
) {
    return static_cast<int>((as_type<uint>(value_2) & 2147483647u) > 2139095040u);
}

int sign_value(
    float value_3
) {
    return static_cast<int>((as_type<uint>(value_3) & 2147483648u) != 0u);
}

uint result_kind(
    int value_4
) {
    return 10u + static_cast<uint>(value_4);
}

int signbit(
    bool value_5
) {
    int local_44 = {};
    if (value_5) {
        local_44 = 7;
    } else {
        local_44 = 9;
    }
    int _e6 = local_44;
    return _e6;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


struct float_classificationInput {
};
kernel void float_classification(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_4 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    int cursor = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    bool local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
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
    int alias_cursor = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint index = threadIdx.x + (blockIdx.x * 32u);
    if (index >= 544u) {
        return;
    }
    uint bits = input[index];
    uint base = 4u + (index * 33u);
    float value_6 = as_type<float>(bits);
    output[base] = static_cast<uint>(static_cast<int>((as_type<uint>(value_6) & 2147483647u) < 2139095040u));
    local = static_cast<uint>(base + 1u);
    uint _e37 = local;
    output[_e37] = static_cast<uint>(static_cast<int>((as_type<uint>(value_6) & 2147483647u) == 2139095040u));
    local_1 = static_cast<uint>(base + 2u);
    uint _e50 = local_1;
    output[_e50] = static_cast<uint>(static_cast<int>((as_type<uint>(value_6) & 2147483647u) > 2139095040u));
    local_2 = static_cast<uint>(base + 3u);
    uint _e63 = local_2;
    output[_e63] = static_cast<uint>(static_cast<int>((as_type<uint>(value_6) & 2147483648u) != 0u));
    int _e65 = finite_value(value_6);
    local_3 = static_cast<uint>(base + 4u);
    uint _e71 = local_3;
    output[_e71] = static_cast<uint>(_e65);
    int _e73 = infinite_value(value_6);
    local_4 = static_cast<uint>(base + 5u);
    uint _e79 = local_4;
    output[_e79] = static_cast<uint>(_e73);
    int _e81 = nan_value(value_6);
    local_5 = static_cast<uint>(base + 6u);
    uint _e87 = local_5;
    output[_e87] = static_cast<uint>(_e81);
    int _e89 = sign_value(value_6);
    local_6 = static_cast<uint>(base + 7u);
    uint _e95 = local_6;
    output[_e95] = static_cast<uint>(_e89);
    uint _e103 = result_kind(static_cast<int>((as_type<uint>(value_6) & 2147483647u) > 2139095040u));
    local_7 = static_cast<uint>(base + 8u);
    uint _e108 = local_7;
    output[_e108] = _e103;
    cursor = 0;
    int _e112 = cursor;
    cursor = as_type<int>(as_type<uint>(_e112) + as_type<uint>(1));
    local_9 = static_cast<uint>(index + static_cast<uint>(_e112));
    uint _e119 = local_9;
    uint _e121 = input[_e119];
    local_8 = static_cast<uint>(base + 9u);
    uint _e134 = local_8;
    output[_e134] = static_cast<uint>(static_cast<int>((as_type<uint>(as_type<float>(_e121)) & 2147483648u) != 0u));
    int _e136 = cursor;
    local_10 = static_cast<uint>(base + 10u);
    uint _e142 = local_10;
    output[_e142] = static_cast<uint>(_e136);
    int _e145 = signbit(true);
    local_11 = static_cast<uint>(base + 11u);
    uint _e151 = local_11;
    output[_e151] = static_cast<uint>(_e145);
    if (static_cast<int>((as_type<uint>(value_6) & 2147483647u) < 2139095040u) != 0) {
        local_12 = static_cast<uint>(base + 12u);
        uint _e165 = local_12;
        local_41 = _e165;
        uint _e167 = local_41;
        output[_e167] = 2u;
    } else {
        if (static_cast<int>((as_type<uint>(value_6) & 2147483647u) == 2139095040u) != 0) {
            local_13 = static_cast<uint>(base + 12u);
            uint _e182 = local_13;
            local_42 = _e182;
            uint _e184 = local_42;
            output[_e184] = 3u;
        } else {
            local_14 = static_cast<uint>(base + 12u);
            uint _e191 = local_14;
            local_43 = _e191;
            uint _e193 = local_43;
            output[_e193] = 4u;
        }
    }
    local_16 = false;
    if (false) {
        int _e198 = cursor;
        cursor = as_type<int>(as_type<uint>(_e198) + as_type<uint>(1));
        local_16 = static_cast<int>((as_type<uint>(value_6 + static_cast<float>(_e198)) & 2147483647u) > 2139095040u) != 0;
    }
    bool _e211 = local_16;
    local_15 = static_cast<uint>(base + 13u);
    uint _e217 = local_15;
    output[_e217] = static_cast<uint>(_e211);
    int _e219 = cursor;
    local_17 = static_cast<uint>(base + 14u);
    uint _e225 = local_17;
    output[_e225] = static_cast<uint>(_e219);
    local_18 = static_cast<uint>(base + 15u);
    uint _e240 = local_18;
    output[_e240] = static_cast<uint>(static_cast<int>((as_type<uint>(static_cast<float>(3)) & 2147483647u) < 2139095040u));
    local_19 = static_cast<uint>(base + 16u);
    uint _e254 = local_19;
    output[_e254] = static_cast<uint>(static_cast<int>((as_type<uint>(0.0) & 2147483648u) != 0u));
    local_20 = static_cast<uint>(base + 17u);
    uint _e269 = local_20;
    output[_e269] = static_cast<uint>(static_cast<int>((as_type<uint>(-(0.0)) & 2147483648u) != 0u));
    int _e273 = sign_value(-(0.0));
    local_21 = static_cast<uint>(base + 18u);
    uint _e279 = local_21;
    output[_e279] = static_cast<uint>(_e273);
    local_23 = 2139095040u;
    uint _e283 = local_23;
    local_22 = static_cast<uint>(base + 19u);
    uint _e296 = local_22;
    output[_e296] = static_cast<uint>(static_cast<int>((as_type<uint>(as_type<float>(_e283)) & 2147483647u) < 2139095040u));
    local_25 = 2139095040u;
    uint _e300 = local_25;
    local_24 = static_cast<uint>(base + 20u);
    uint _e313 = local_24;
    output[_e313] = static_cast<uint>(static_cast<int>((as_type<uint>(as_type<float>(_e300)) & 2147483647u) == 2139095040u));
    local_27 = 4286578689u;
    uint _e317 = local_27;
    local_26 = static_cast<uint>(base + 21u);
    uint _e330 = local_26;
    output[_e330] = static_cast<uint>(static_cast<int>((as_type<uint>(as_type<float>(_e317)) & 2147483647u) > 2139095040u));
    local_29 = 4286578689u;
    uint _e334 = local_29;
    local_28 = static_cast<uint>(base + 22u);
    uint _e347 = local_28;
    output[_e347] = static_cast<uint>(static_cast<int>((as_type<uint>(as_type<float>(_e334)) & 2147483648u) != 0u));
    local_30 = static_cast<uint>(base + 23u);
    uint _e360 = local_30;
    output[_e360] = static_cast<uint>(static_cast<int>((as_type<uint>(value_6) & 2147483647u) < 2139095040u));
    local_31 = static_cast<uint>(base + 24u);
    uint _e373 = local_31;
    output[_e373] = static_cast<uint>(static_cast<int>((as_type<uint>(value_6) & 2147483647u) == 2139095040u));
    local_32 = static_cast<uint>(base + 25u);
    uint _e386 = local_32;
    output[_e386] = static_cast<uint>(static_cast<int>((as_type<uint>(value_6) & 2147483647u) > 2139095040u));
    local_33 = static_cast<uint>(base + 26u);
    uint _e399 = local_33;
    output[_e399] = static_cast<uint>(static_cast<int>((as_type<uint>(value_6) & 2147483648u) != 0u));
    local_34 = static_cast<uint>(base + 27u);
    uint _e414 = local_34;
    output[_e414] = static_cast<uint>(static_cast<int>((as_type<uint>(static_cast<float>(3)) & 2147483647u) < 2139095040u));
    local_35 = static_cast<uint>(base + 28u);
    uint _e429 = local_35;
    output[_e429] = static_cast<uint>(static_cast<int>((as_type<uint>(static_cast<float>(0u)) & 2147483647u) == 2139095040u));
    local_36 = static_cast<uint>(base + 29u);
    uint _e444 = local_36;
    output[_e444] = static_cast<uint>(static_cast<int>((as_type<uint>(static_cast<float>(true)) & 2147483647u) > 2139095040u));
    local_37 = static_cast<uint>(base + 30u);
    uint _e460 = local_37;
    output[_e460] = static_cast<uint>(static_cast<int>((as_type<uint>(static_cast<float>(naga_neg(3))) & 2147483648u) != 0u));
    alias_cursor = 0;
    int _e464 = alias_cursor;
    alias_cursor = as_type<int>(as_type<uint>(_e464) + as_type<uint>(1));
    local_39 = static_cast<uint>(index + static_cast<uint>(_e464));
    uint _e471 = local_39;
    uint _e473 = input[_e471];
    local_38 = static_cast<uint>(base + 31u);
    uint _e486 = local_38;
    output[_e486] = static_cast<uint>(static_cast<int>((as_type<uint>(as_type<float>(_e473)) & 2147483648u) != 0u));
    int _e488 = alias_cursor;
    local_40 = static_cast<uint>(base + 32u);
    uint _e494 = local_40;
    output[_e494] = static_cast<uint>(_e488);
}
