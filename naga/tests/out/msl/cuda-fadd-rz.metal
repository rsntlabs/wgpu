// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_5[1];

uint _naga_fadd_rz(
    uint left_bits,
    uint right_bits
) {
    uint _e9 = left_bits & 2147483647u;
    uint _e10 = right_bits & 2147483647u;
    uint _e11 = left_bits & 2147483648u;
    uint _e12 = right_bits & 2147483648u;
    if ((_e9 > 2139095040u) || (_e10 > 2139095040u)) {
        return 2143289344u;
    }
    bool _e16 = _e9 == 2139095040u;
    bool _e17 = _e10 == 2139095040u;
    if ((_e16 && _e17) && (_e11 != _e12)) {
        return 2143289344u;
    }
    if (_e16) {
        return left_bits;
    }
    if (_e17) {
        return right_bits;
    }
    bool _e22 = _e9 >= _e10;
    uint _e23 = _e22 ? _e9 : _e10;
    uint _e24 = _e22 ? _e10 : _e9;
    uint _e25 = _e22 ? _e11 : _e12;
    uint _e29 = _e23 >> 23u;
    uint _e30 = _e24 >> 23u;
    bool _e31 = _e29 != 0u;
    bool _e32 = _e30 != 0u;
    uint _e39 = ((_e23 & 8388607u) | (_e31 ? 8388608u : 0u)) << 3u;
    uint _e40 = ((_e24 & 8388607u) | (_e32 ? 8388608u : 0u)) << 3u;
    uint _e41 = _e31 ? _e29 : 1u;
    uint _e43 = _e41 - (_e32 ? _e30 : 1u);
    uint _e48 = _e43 & 31u;
    uint _e59 = (_e43 < 32u) ? ((_e40 >> _e48) | static_cast<uint>((_e40 & ((1u << _e48) - 1u)) != 0u)) : static_cast<uint>(_e40 != 0u);
    uint _e62 = (_e11 == _e12) ? (_e39 + _e59) : (_e39 - _e59);
    if (_e62 == 0u) {
        return _e11 & _e12;
    }
    bool _e66 = _e62 >= 134217728u;
    uint _e71 = 1u & 31u;
    uint _e83 = _e66 ? ((1u < 32u) ? ((_e62 >> _e71) | static_cast<uint>((_e62 & ((1u << _e71) - 1u)) != 0u)) : static_cast<uint>(_e62 != 0u)) : _e62;
    uint _e85 = _e41 + static_cast<uint>(_e66);
    uint _e90 = metal::min(metal::clz(_e83) - 5u, _e85 - 1u);
    uint _e92 = _e85 - _e90;
    uint _e93 = (_e83 << _e90) >> 3u;
    if (_e92 >= 255u) {
        return _e25 | 2139095039u;
    }
    return _e25 | ((((_e93 >= 8388608u) ? _e92 : 0u) << 23u) | (_e93 & 8388607u));
}

float truncate_value(
    float first,
    float second
) {
    uint _e4 = _naga_fadd_rz(as_type<uint>(first), as_type<uint>(second));
    return as_type<float>(_e4);
}

int _fadd_rz(
    bool first_1,
    bool second_1
) {
    int local_54 = {};
    if (first_1) {
        local_54 = 7;
    } else {
        local_54 = 9;
    }
    int _e6 = local_54;
    return _e6;
}

uint _naga_fabsf(
    uint input_bits
) {
    uint _e2 = input_bits & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}

uint _naga_fadd_rn(
    uint left_bits_1,
    uint right_bits_1
) {
    uint _e9 = left_bits_1 & 2147483647u;
    uint _e10 = right_bits_1 & 2147483647u;
    uint _e11 = left_bits_1 & 2147483648u;
    uint _e12 = right_bits_1 & 2147483648u;
    if ((_e9 > 2139095040u) || (_e10 > 2139095040u)) {
        return 2143289344u;
    }
    bool _e16 = _e9 == 2139095040u;
    bool _e17 = _e10 == 2139095040u;
    if ((_e16 && _e17) && (_e11 != _e12)) {
        return 2143289344u;
    }
    if (_e16) {
        return left_bits_1;
    }
    if (_e17) {
        return right_bits_1;
    }
    bool _e22 = _e9 >= _e10;
    uint _e23 = _e22 ? _e9 : _e10;
    uint _e24 = _e22 ? _e10 : _e9;
    uint _e25 = _e22 ? _e11 : _e12;
    uint _e29 = _e23 >> 23u;
    uint _e30 = _e24 >> 23u;
    bool _e31 = _e29 != 0u;
    bool _e32 = _e30 != 0u;
    uint _e39 = ((_e23 & 8388607u) | (_e31 ? 8388608u : 0u)) << 3u;
    uint _e40 = ((_e24 & 8388607u) | (_e32 ? 8388608u : 0u)) << 3u;
    uint _e41 = _e31 ? _e29 : 1u;
    uint _e43 = _e41 - (_e32 ? _e30 : 1u);
    uint _e48 = _e43 & 31u;
    uint _e59 = (_e43 < 32u) ? ((_e40 >> _e48) | static_cast<uint>((_e40 & ((1u << _e48) - 1u)) != 0u)) : static_cast<uint>(_e40 != 0u);
    uint _e62 = (_e11 == _e12) ? (_e39 + _e59) : (_e39 - _e59);
    if (_e62 == 0u) {
        return _e11 & _e12;
    }
    bool _e66 = _e62 >= 134217728u;
    uint _e71 = 1u & 31u;
    uint _e83 = _e66 ? ((1u < 32u) ? ((_e62 >> _e71) | static_cast<uint>((_e62 & ((1u << _e71) - 1u)) != 0u)) : static_cast<uint>(_e62 != 0u)) : _e62;
    uint _e85 = _e41 + static_cast<uint>(_e66);
    uint _e90 = metal::min(metal::clz(_e83) - 5u, _e85 - 1u);
    uint _e91 = _e83 << _e90;
    uint _e95 = _e91 & 7u;
    uint _e96 = _e91 >> 3u;
    uint _e104 = _e96 + static_cast<uint>((_e95 > 4u) || ((_e95 == 4u) && ((_e96 & 1u) != 0u)));
    bool _e106 = _e104 >= 16777216u;
    uint _e108 = _e106 ? (_e104 >> 1u) : _e104;
    uint _e110 = (_e85 - _e90) + static_cast<uint>(_e106);
    if (_e110 >= 255u) {
        return _e25 | 2139095040u;
    }
    return _e25 | ((((_e108 >= 8388608u) ? _e110 : 0u) << 23u) | (_e108 & 8388607u));
}

uint _naga_fadd_rd(
    uint left_bits_2,
    uint right_bits_2
) {
    uint _e9 = left_bits_2 & 2147483647u;
    uint _e10 = right_bits_2 & 2147483647u;
    uint _e11 = left_bits_2 & 2147483648u;
    uint _e12 = right_bits_2 & 2147483648u;
    if ((_e9 > 2139095040u) || (_e10 > 2139095040u)) {
        return 2143289344u;
    }
    bool _e16 = _e9 == 2139095040u;
    bool _e17 = _e10 == 2139095040u;
    if ((_e16 && _e17) && (_e11 != _e12)) {
        return 2143289344u;
    }
    if (_e16) {
        return left_bits_2;
    }
    if (_e17) {
        return right_bits_2;
    }
    bool _e22 = _e9 >= _e10;
    uint _e23 = _e22 ? _e9 : _e10;
    uint _e24 = _e22 ? _e10 : _e9;
    uint _e25 = _e22 ? _e11 : _e12;
    uint _e29 = _e23 >> 23u;
    uint _e30 = _e24 >> 23u;
    bool _e31 = _e29 != 0u;
    bool _e32 = _e30 != 0u;
    uint _e39 = ((_e23 & 8388607u) | (_e31 ? 8388608u : 0u)) << 3u;
    uint _e40 = ((_e24 & 8388607u) | (_e32 ? 8388608u : 0u)) << 3u;
    uint _e41 = _e31 ? _e29 : 1u;
    uint _e43 = _e41 - (_e32 ? _e30 : 1u);
    uint _e48 = _e43 & 31u;
    uint _e59 = (_e43 < 32u) ? ((_e40 >> _e48) | static_cast<uint>((_e40 & ((1u << _e48) - 1u)) != 0u)) : static_cast<uint>(_e40 != 0u);
    uint _e62 = (_e11 == _e12) ? (_e39 + _e59) : (_e39 - _e59);
    if (_e62 == 0u) {
        return _e11 | _e12;
    }
    bool _e66 = _e62 >= 134217728u;
    uint _e71 = 1u & 31u;
    uint _e83 = _e66 ? ((1u < 32u) ? ((_e62 >> _e71) | static_cast<uint>((_e62 & ((1u << _e71) - 1u)) != 0u)) : static_cast<uint>(_e62 != 0u)) : _e62;
    uint _e85 = _e41 + static_cast<uint>(_e66);
    uint _e90 = metal::min(metal::clz(_e83) - 5u, _e85 - 1u);
    uint _e91 = _e83 << _e90;
    bool _e93 = _e25 != 0u;
    uint _e100 = (_e91 >> 3u) + static_cast<uint>(_e93 && ((_e91 & 7u) > 0u));
    bool _e102 = _e100 >= 16777216u;
    uint _e104 = _e102 ? (_e100 >> 1u) : _e100;
    uint _e106 = (_e85 - _e90) + static_cast<uint>(_e102);
    if (_e106 >= 255u) {
        return _e25 | (_e93 ? 2139095040u : 2139095039u);
    }
    return _e25 | ((((_e104 >= 8388608u) ? _e106 : 0u) << 23u) | (_e104 & 8388607u));
}

uint _naga_fadd_ru(
    uint left_bits_3,
    uint right_bits_3
) {
    uint _e9 = left_bits_3 & 2147483647u;
    uint _e10 = right_bits_3 & 2147483647u;
    uint _e11 = left_bits_3 & 2147483648u;
    uint _e12 = right_bits_3 & 2147483648u;
    if ((_e9 > 2139095040u) || (_e10 > 2139095040u)) {
        return 2143289344u;
    }
    bool _e16 = _e9 == 2139095040u;
    bool _e17 = _e10 == 2139095040u;
    if ((_e16 && _e17) && (_e11 != _e12)) {
        return 2143289344u;
    }
    if (_e16) {
        return left_bits_3;
    }
    if (_e17) {
        return right_bits_3;
    }
    bool _e22 = _e9 >= _e10;
    uint _e23 = _e22 ? _e9 : _e10;
    uint _e24 = _e22 ? _e10 : _e9;
    uint _e25 = _e22 ? _e11 : _e12;
    uint _e29 = _e23 >> 23u;
    uint _e30 = _e24 >> 23u;
    bool _e31 = _e29 != 0u;
    bool _e32 = _e30 != 0u;
    uint _e39 = ((_e23 & 8388607u) | (_e31 ? 8388608u : 0u)) << 3u;
    uint _e40 = ((_e24 & 8388607u) | (_e32 ? 8388608u : 0u)) << 3u;
    uint _e41 = _e31 ? _e29 : 1u;
    uint _e43 = _e41 - (_e32 ? _e30 : 1u);
    uint _e48 = _e43 & 31u;
    uint _e59 = (_e43 < 32u) ? ((_e40 >> _e48) | static_cast<uint>((_e40 & ((1u << _e48) - 1u)) != 0u)) : static_cast<uint>(_e40 != 0u);
    uint _e62 = (_e11 == _e12) ? (_e39 + _e59) : (_e39 - _e59);
    if (_e62 == 0u) {
        return _e11 & _e12;
    }
    bool _e66 = _e62 >= 134217728u;
    uint _e71 = 1u & 31u;
    uint _e83 = _e66 ? ((1u < 32u) ? ((_e62 >> _e71) | static_cast<uint>((_e62 & ((1u << _e71) - 1u)) != 0u)) : static_cast<uint>(_e62 != 0u)) : _e62;
    uint _e85 = _e41 + static_cast<uint>(_e66);
    uint _e90 = metal::min(metal::clz(_e83) - 5u, _e85 - 1u);
    uint _e91 = _e83 << _e90;
    bool _e93 = _e25 == 0u;
    uint _e100 = (_e91 >> 3u) + static_cast<uint>(_e93 && ((_e91 & 7u) > 0u));
    bool _e102 = _e100 >= 16777216u;
    uint _e104 = _e102 ? (_e100 >> 1u) : _e100;
    uint _e106 = (_e85 - _e90) + static_cast<uint>(_e102);
    if (_e106 >= 255u) {
        return _e25 | (_e93 ? 2139095040u : 2139095039u);
    }
    return _e25 | ((((_e104 >= 8388608u) ? _e106 : 0u) << 23u) | (_e104 & 8388607u));
}

struct add_round_zeroInput {
};
kernel void add_round_zero(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_5 const& input [[buffer(0)]]
, device type_5& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    int cursor = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    bool local_6 = {};
    bool local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    float local_14 = {};
    uint local_15 = {};
    int directed_cursor = {};
    uint local_16 = {};
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
    metal::float2 pair_first = {};
    uint local_32 = {};
    metal::float2 pair_second = {};
    uint local_33 = {};
    metal::float2 pair_rn = {};
    metal::float2 local_34 = {};
    metal::float2 local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    metal::float2 pair_rz = {};
    metal::float2 local_39 = {};
    metal::float2 local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    metal::float2 pair_rd = {};
    metal::float2 local_44 = {};
    metal::float2 local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    metal::float2 pair_ru = {};
    metal::float2 local_49 = {};
    metal::float2 local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    metal::float2 value = {};
    metal::float2 value_1 = {};
    metal::float2 value_2 = {};
    metal::float2 value_3 = {};
    metal::float2 value_4 = {};
    metal::float2 value_5 = {};
    metal::float2 value_6 = {};
    metal::float2 value_7 = {};
    uint index = threadIdx.x + (blockIdx.x * 32u);
    if (index >= 4096u) {
        return;
    }
    uint base = 4u + (index * 30u);
    local = static_cast<uint>(index * 2u);
    uint _e17 = local;
    uint _e20 = input[_e17];
    float first_2 = as_type<float>(_e20);
    local_1 = static_cast<uint>((index * 2u) + 1u);
    uint _e28 = local_1;
    uint _e30 = input[_e28];
    float second_2 = as_type<float>(_e30);
    uint _e34 = _naga_fadd_rz(as_type<uint>(first_2), as_type<uint>(second_2));
    output[base] = as_type<uint>(as_type<float>(_e34));
    float _e39 = truncate_value(first_2, second_2);
    local_2 = static_cast<uint>(base + 1u);
    uint _e45 = local_2;
    output[_e45] = as_type<uint>(_e39);
    cursor = 0;
    int _e51 = cursor;
    cursor = as_type<int>(as_type<uint>(_e51) + as_type<uint>(1));
    local_4 = static_cast<uint>((index * 2u) + static_cast<uint>(_e51));
    uint _e58 = local_4;
    uint _e60 = input[_e58];
    int _e64 = cursor;
    cursor = as_type<int>(as_type<uint>(_e64) + as_type<uint>(1));
    local_5 = static_cast<uint>((index * 2u) + static_cast<uint>(_e64));
    uint _e71 = local_5;
    uint _e73 = input[_e71];
    float _e75 = truncate_value(as_type<float>(_e60), as_type<float>(_e73));
    local_3 = static_cast<uint>(base + 2u);
    uint _e81 = local_3;
    output[_e81] = as_type<uint>(_e75);
    local_6 = false;
    if (false) {
        int _e85 = cursor;
        cursor = as_type<int>(as_type<uint>(_e85) + as_type<uint>(1));
        uint _e91 = _naga_fadd_rz(as_type<uint>(static_cast<float>(_e85)), as_type<uint>(first_2));
        uint _e94 = _naga_fabsf(as_type<uint>(as_type<float>(_e91)));
        local_6 = _e94 != 0u;
    }
    local_7 = true;
    if (true) {
    } else {
        int _e99 = cursor;
        cursor = as_type<int>(as_type<uint>(_e99) + as_type<uint>(1));
        uint _e105 = _naga_fadd_rz(as_type<uint>(first_2), as_type<uint>(static_cast<float>(_e99)));
        uint _e108 = _naga_fabsf(as_type<uint>(as_type<float>(_e105)));
        local_7 = _e108 != 0u;
    }
    int _e111 = cursor;
    local_8 = static_cast<uint>(base + 3u);
    uint _e117 = local_8;
    output[_e117] = static_cast<uint>(_e111);
    uint _e125 = _naga_fadd_rz(as_type<uint>(-(0.0)), as_type<uint>(-(0.0)));
    local_9 = static_cast<uint>(base + 4u);
    uint _e132 = local_9;
    output[_e132] = as_type<uint>(as_type<float>(_e125));
    uint _e139 = _naga_fadd_rz(as_type<uint>(-(0.0)), as_type<uint>(0.0));
    local_10 = static_cast<uint>(base + 5u);
    uint _e146 = local_10;
    output[_e146] = as_type<uint>(as_type<float>(_e139));
    float _e152 = truncate_value(static_cast<float>(1), static_cast<float>(2u));
    local_11 = static_cast<uint>(base + 6u);
    uint _e158 = local_11;
    output[_e158] = as_type<uint>(_e152);
    int _e162 = _fadd_rz(true, false);
    local_12 = static_cast<uint>(base + 7u);
    uint _e168 = local_12;
    output[_e168] = static_cast<uint>(_e162);
    if (true) {
        uint _e173 = _naga_fadd_rz(as_type<uint>(first_2), as_type<uint>(second_2));
        local_14 = as_type<float>(_e173);
    } else {
        int _e176 = cursor;
        cursor = as_type<int>(as_type<uint>(_e176) + as_type<uint>(1));
        uint _e182 = _naga_fadd_rz(as_type<uint>(static_cast<float>(_e176)), as_type<uint>(first_2));
        local_14 = as_type<float>(_e182);
    }
    float _e186 = local_14;
    local_13 = static_cast<uint>(base + 8u);
    uint _e192 = local_13;
    output[_e192] = as_type<uint>(_e186);
    uint _e196 = _naga_fadd_rn(as_type<uint>(first_2), as_type<uint>(second_2));
    local_15 = static_cast<uint>(base + 9u);
    uint _e203 = local_15;
    output[_e203] = as_type<uint>(as_type<float>(_e196));
    directed_cursor = 0;
    int _e209 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e209) + as_type<uint>(1));
    local_17 = static_cast<uint>((index * 2u) + static_cast<uint>(_e209));
    uint _e216 = local_17;
    uint _e218 = input[_e216];
    int _e222 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e222) + as_type<uint>(1));
    local_18 = static_cast<uint>((index * 2u) + static_cast<uint>(_e222));
    uint _e229 = local_18;
    uint _e231 = input[_e229];
    uint _e235 = _naga_fadd_rd(as_type<uint>(as_type<float>(_e218)), as_type<uint>(as_type<float>(_e231)));
    local_16 = static_cast<uint>(base + 10u);
    uint _e242 = local_16;
    output[_e242] = as_type<uint>(as_type<float>(_e235));
    int _e244 = directed_cursor;
    local_19 = static_cast<uint>(base + 11u);
    uint _e250 = local_19;
    output[_e250] = static_cast<uint>(_e244);
    directed_cursor = 0;
    int _e255 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e255) + as_type<uint>(1));
    local_21 = static_cast<uint>((index * 2u) + static_cast<uint>(_e255));
    uint _e262 = local_21;
    uint _e264 = input[_e262];
    int _e268 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e268) + as_type<uint>(1));
    local_22 = static_cast<uint>((index * 2u) + static_cast<uint>(_e268));
    uint _e275 = local_22;
    uint _e277 = input[_e275];
    uint _e281 = _naga_fadd_ru(as_type<uint>(as_type<float>(_e264)), as_type<uint>(as_type<float>(_e277)));
    local_20 = static_cast<uint>(base + 12u);
    uint _e288 = local_20;
    output[_e288] = as_type<uint>(as_type<float>(_e281));
    int _e290 = directed_cursor;
    local_23 = static_cast<uint>(base + 13u);
    uint _e296 = local_23;
    output[_e296] = static_cast<uint>(_e290);
    directed_cursor = 0;
    int _e301 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e301) + as_type<uint>(1));
    local_25 = static_cast<uint>((index * 2u) + static_cast<uint>(_e301));
    uint _e308 = local_25;
    uint _e310 = input[_e308];
    int _e314 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e314) + as_type<uint>(1));
    local_26 = static_cast<uint>((index * 2u) + static_cast<uint>(_e314));
    uint _e321 = local_26;
    uint _e323 = input[_e321];
    uint _e329 = _naga_fadd_rd(as_type<uint>(as_type<float>(_e310)), as_type<uint>(as_type<float>(_e323)) ^ 2147483648u);
    local_24 = static_cast<uint>(base + 14u);
    uint _e336 = local_24;
    output[_e336] = as_type<uint>(as_type<float>(_e329));
    int _e338 = directed_cursor;
    local_27 = static_cast<uint>(base + 15u);
    uint _e344 = local_27;
    output[_e344] = static_cast<uint>(_e338);
    directed_cursor = 0;
    int _e349 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e349) + as_type<uint>(1));
    local_29 = static_cast<uint>((index * 2u) + static_cast<uint>(_e349));
    uint _e356 = local_29;
    uint _e358 = input[_e356];
    int _e362 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e362) + as_type<uint>(1));
    local_30 = static_cast<uint>((index * 2u) + static_cast<uint>(_e362));
    uint _e369 = local_30;
    uint _e371 = input[_e369];
    uint _e377 = _naga_fadd_ru(as_type<uint>(as_type<float>(_e358)), as_type<uint>(as_type<float>(_e371)) ^ 2147483648u);
    local_28 = static_cast<uint>(base + 16u);
    uint _e384 = local_28;
    output[_e384] = as_type<uint>(as_type<float>(_e377));
    int _e386 = directed_cursor;
    local_31 = static_cast<uint>(base + 17u);
    uint _e392 = local_31;
    output[_e392] = static_cast<uint>(_e386);
    uint other = index ^ 1u;
    local_32 = static_cast<uint>(other * 2u);
    uint _e400 = local_32;
    uint _e402 = input[_e400];
    pair_first = metal::float2(first_2, as_type<float>(_e402));
    local_33 = static_cast<uint>((other * 2u) + 1u);
    uint _e412 = local_33;
    uint _e414 = input[_e412];
    pair_second = metal::float2(second_2, as_type<float>(_e414));
    directed_cursor = 0;
    metal::float2 _e419 = pair_first;
    value = metal::float2 {};
    value = _e419;
    int _e423 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e423) + as_type<uint>(1));
    metal::float2 _e426 = value;
    local_34 = _e426;
    metal::float2 _e428 = local_34;
    metal::float2 _e429 = pair_second;
    value_1 = metal::float2 {};
    value_1 = _e429;
    int _e433 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e433) + as_type<uint>(1));
    metal::float2 _e436 = value_1;
    local_35 = _e436;
    metal::float2 _e438 = local_35;
    uint _e443 = _naga_fadd_rn(as_type<uint>(_e428.x), as_type<uint>(_e438.x));
    uint _e449 = _naga_fadd_rn(as_type<uint>(_e428.y), as_type<uint>(_e438.y));
    pair_rn = metal::float2(as_type<float>(_e443), as_type<float>(_e449));
    float _e454 = pair_rn.x;
    local_36 = static_cast<uint>(base + 18u);
    uint _e460 = local_36;
    output[_e460] = as_type<uint>(_e454);
    float _e463 = pair_rn.y;
    local_37 = static_cast<uint>(base + 19u);
    uint _e469 = local_37;
    output[_e469] = as_type<uint>(_e463);
    int _e471 = directed_cursor;
    local_38 = static_cast<uint>(base + 20u);
    uint _e477 = local_38;
    output[_e477] = static_cast<uint>(_e471);
    directed_cursor = 0;
    metal::float2 _e480 = pair_first;
    value_2 = metal::float2 {};
    value_2 = _e480;
    int _e484 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e484) + as_type<uint>(1));
    metal::float2 _e487 = value_2;
    local_39 = _e487;
    metal::float2 _e489 = local_39;
    metal::float2 _e490 = pair_second;
    value_3 = metal::float2 {};
    value_3 = _e490;
    int _e494 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e494) + as_type<uint>(1));
    metal::float2 _e497 = value_3;
    local_40 = _e497;
    metal::float2 _e499 = local_40;
    uint _e504 = _naga_fadd_rz(as_type<uint>(_e489.x), as_type<uint>(_e499.x));
    uint _e510 = _naga_fadd_rz(as_type<uint>(_e489.y), as_type<uint>(_e499.y));
    pair_rz = metal::float2(as_type<float>(_e504), as_type<float>(_e510));
    float _e515 = pair_rz.x;
    local_41 = static_cast<uint>(base + 21u);
    uint _e521 = local_41;
    output[_e521] = as_type<uint>(_e515);
    float _e524 = pair_rz.y;
    local_42 = static_cast<uint>(base + 22u);
    uint _e530 = local_42;
    output[_e530] = as_type<uint>(_e524);
    int _e532 = directed_cursor;
    local_43 = static_cast<uint>(base + 23u);
    uint _e538 = local_43;
    output[_e538] = static_cast<uint>(_e532);
    directed_cursor = 0;
    metal::float2 _e541 = pair_first;
    value_4 = metal::float2 {};
    value_4 = _e541;
    int _e545 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e545) + as_type<uint>(1));
    metal::float2 _e548 = value_4;
    local_44 = _e548;
    metal::float2 _e550 = local_44;
    metal::float2 _e551 = pair_second;
    value_5 = metal::float2 {};
    value_5 = _e551;
    int _e555 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e555) + as_type<uint>(1));
    metal::float2 _e558 = value_5;
    local_45 = _e558;
    metal::float2 _e560 = local_45;
    uint _e565 = _naga_fadd_rd(as_type<uint>(_e550.x), as_type<uint>(_e560.x));
    uint _e571 = _naga_fadd_rd(as_type<uint>(_e550.y), as_type<uint>(_e560.y));
    pair_rd = metal::float2(as_type<float>(_e565), as_type<float>(_e571));
    float _e576 = pair_rd.x;
    local_46 = static_cast<uint>(base + 24u);
    uint _e582 = local_46;
    output[_e582] = as_type<uint>(_e576);
    float _e585 = pair_rd.y;
    local_47 = static_cast<uint>(base + 25u);
    uint _e591 = local_47;
    output[_e591] = as_type<uint>(_e585);
    int _e593 = directed_cursor;
    local_48 = static_cast<uint>(base + 26u);
    uint _e599 = local_48;
    output[_e599] = static_cast<uint>(_e593);
    directed_cursor = 0;
    metal::float2 _e602 = pair_first;
    value_6 = metal::float2 {};
    value_6 = _e602;
    int _e606 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e606) + as_type<uint>(1));
    metal::float2 _e609 = value_6;
    local_49 = _e609;
    metal::float2 _e611 = local_49;
    metal::float2 _e612 = pair_second;
    value_7 = metal::float2 {};
    value_7 = _e612;
    int _e616 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e616) + as_type<uint>(1));
    metal::float2 _e619 = value_7;
    local_50 = _e619;
    metal::float2 _e621 = local_50;
    uint _e626 = _naga_fadd_ru(as_type<uint>(_e611.x), as_type<uint>(_e621.x));
    uint _e632 = _naga_fadd_ru(as_type<uint>(_e611.y), as_type<uint>(_e621.y));
    pair_ru = metal::float2(as_type<float>(_e626), as_type<float>(_e632));
    float _e637 = pair_ru.x;
    local_51 = static_cast<uint>(base + 27u);
    uint _e643 = local_51;
    output[_e643] = as_type<uint>(_e637);
    float _e646 = pair_ru.y;
    local_52 = static_cast<uint>(base + 28u);
    uint _e652 = local_52;
    output[_e652] = as_type<uint>(_e646);
    int _e654 = directed_cursor;
    local_53 = static_cast<uint>(base + 29u);
    uint _e660 = local_53;
    output[_e660] = static_cast<uint>(_e654);
}
