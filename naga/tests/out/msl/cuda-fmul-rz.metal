// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_4[1];

uint _naga_fmul_rz(
    uint left_bits,
    uint right_bits
) {
    uint _e8 = left_bits & 2147483647u;
    uint _e9 = right_bits & 2147483647u;
    uint _e11 = (left_bits ^ right_bits) & 2147483648u;
    if ((_e8 > 2139095040u) || (_e9 > 2139095040u)) {
        return 2143289344u;
    }
    bool _e17 = (_e8 == 2139095040u) || (_e9 == 2139095040u);
    bool _e20 = (_e8 == 0u) || (_e9 == 0u);
    if (_e17 && _e20) {
        return 2143289344u;
    }
    if (_e17) {
        return _e11 | 2139095040u;
    }
    if (_e20) {
        return _e11;
    }
    uint _e26 = _e8 >> 23u;
    uint _e27 = _e9 >> 23u;
    bool _e28 = _e26 != 0u;
    bool _e29 = _e27 != 0u;
    uint _e34 = (_e8 & 8388607u) | (_e28 ? 8388608u : 0u);
    uint _e35 = (_e9 & 8388607u) | (_e29 ? 8388608u : 0u);
    uint _e38 = _e34 & 4095u;
    uint _e39 = _e35 & 4095u;
    uint _e40 = _e34 >> 12u;
    uint _e41 = _e35 >> 12u;
    uint _e42 = _e38 * _e39;
    uint _e47 = ((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u);
    uint _e50 = (_e40 * _e41) + (_e47 >> 12u);
    uint _e54 = (_e42 & 4095u) | ((_e47 & 4095u) << 12u);
    int _e64 = static_cast<int>((_e50 != 0u) ? (55u - metal::clz(_e50)) : (31u - metal::clz(_e54 | 1u)));
    int _e69 = as_type<int>(as_type<uint>(static_cast<int>(_e28 ? _e26 : 1u)) + as_type<uint>(static_cast<int>(_e29 ? _e27 : 1u)));
    int _e72 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e64) + as_type<uint>(_e69))) - as_type<uint>(173));
    int _e79 = as_type<int>(as_type<uint>(metal::max(as_type<int>(as_type<uint>(_e64) - as_type<uint>(23)), as_type<int>(as_type<uint>(151) - as_type<uint>(_e69)))) - as_type<uint>(3));
    uint _e103 = static_cast<uint>(metal::min(metal::max(_e79, 0), 31)) & 31u;
    uint _e131 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e79) - as_type<uint>(24)), 0), 31)) & 31u;
    uint _e153 = ((_e79 <= 0) ? (((_e50 << 24u) | _e54) << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(0) - as_type<uint>(_e79)), 0), 31)) & 31u)) : ((_e79 < 24) ? (((_e50 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(24) - as_type<uint>(_e79)), 0), 31)) & 31u)) | (_e54 >> _e103)) | static_cast<uint>((_e54 & ((1u << _e103) - 1u)) != 0u)) : ((_e79 == 24) ? (_e50 | static_cast<uint>(_e54 != 0u)) : ((_e79 < 48) ? ((_e50 >> _e131) | static_cast<uint>(((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u))) : static_cast<uint>((_e50 | _e54) != 0u))))) >> 3u;
    if (_e72 >= 255) {
        return _e11 | 2139095039u;
    }
    return _e11 | ((((_e153 >= 8388608u) ? static_cast<uint>(metal::max(_e72, 1)) : 0u) << 23u) | (_e153 & 8388607u));
}

float truncate_product(
    float first,
    float second
) {
    uint _e4 = _naga_fmul_rz(as_type<uint>(first), as_type<uint>(second));
    return as_type<float>(_e4);
}

int _fmul_rz(
    bool first_1,
    bool second_1
) {
    int local_23 = {};
    if (first_1) {
        local_23 = 7;
    } else {
        local_23 = 9;
    }
    int _e6 = local_23;
    return _e6;
}

uint _naga_fabsf(
    uint input_bits
) {
    uint _e2 = input_bits & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}

uint _naga_fmul_rn(
    uint left_bits_1,
    uint right_bits_1
) {
    uint _e8 = left_bits_1 & 2147483647u;
    uint _e9 = right_bits_1 & 2147483647u;
    uint _e11 = (left_bits_1 ^ right_bits_1) & 2147483648u;
    if ((_e8 > 2139095040u) || (_e9 > 2139095040u)) {
        return 2143289344u;
    }
    bool _e17 = (_e8 == 2139095040u) || (_e9 == 2139095040u);
    bool _e20 = (_e8 == 0u) || (_e9 == 0u);
    if (_e17 && _e20) {
        return 2143289344u;
    }
    uint _e22 = _e11 | 2139095040u;
    if (_e17) {
        return _e22;
    }
    if (_e20) {
        return _e11;
    }
    uint _e26 = _e8 >> 23u;
    uint _e27 = _e9 >> 23u;
    bool _e28 = _e26 != 0u;
    bool _e29 = _e27 != 0u;
    uint _e34 = (_e8 & 8388607u) | (_e28 ? 8388608u : 0u);
    uint _e35 = (_e9 & 8388607u) | (_e29 ? 8388608u : 0u);
    uint _e38 = _e34 & 4095u;
    uint _e39 = _e35 & 4095u;
    uint _e40 = _e34 >> 12u;
    uint _e41 = _e35 >> 12u;
    uint _e42 = _e38 * _e39;
    uint _e47 = ((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u);
    uint _e50 = (_e40 * _e41) + (_e47 >> 12u);
    uint _e54 = (_e42 & 4095u) | ((_e47 & 4095u) << 12u);
    int _e64 = static_cast<int>((_e50 != 0u) ? (55u - metal::clz(_e50)) : (31u - metal::clz(_e54 | 1u)));
    int _e69 = as_type<int>(as_type<uint>(static_cast<int>(_e28 ? _e26 : 1u)) + as_type<uint>(static_cast<int>(_e29 ? _e27 : 1u)));
    int _e79 = as_type<int>(as_type<uint>(metal::max(as_type<int>(as_type<uint>(_e64) - as_type<uint>(23)), as_type<int>(as_type<uint>(151) - as_type<uint>(_e69)))) - as_type<uint>(3));
    uint _e103 = static_cast<uint>(metal::min(metal::max(_e79, 0), 31)) & 31u;
    uint _e131 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e79) - as_type<uint>(24)), 0), 31)) & 31u;
    uint _e151 = (_e79 <= 0) ? (((_e50 << 24u) | _e54) << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(0) - as_type<uint>(_e79)), 0), 31)) & 31u)) : ((_e79 < 24) ? (((_e50 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(24) - as_type<uint>(_e79)), 0), 31)) & 31u)) | (_e54 >> _e103)) | static_cast<uint>((_e54 & ((1u << _e103) - 1u)) != 0u)) : ((_e79 == 24) ? (_e50 | static_cast<uint>(_e54 != 0u)) : ((_e79 < 48) ? ((_e50 >> _e131) | static_cast<uint>(((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u))) : static_cast<uint>((_e50 | _e54) != 0u))));
    uint _e155 = _e151 & 7u;
    uint _e156 = _e151 >> 3u;
    uint _e164 = _e156 + static_cast<uint>((_e155 > 4u) || ((_e155 == 4u) && ((_e156 & 1u) != 0u)));
    bool _e166 = _e164 >= 16777216u;
    uint _e168 = _e166 ? (_e164 >> 1u) : _e164;
    int _e170 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e64) + as_type<uint>(_e69))) - as_type<uint>(173))) + as_type<uint>(static_cast<int>(_e166)));
    if (_e170 >= 255) {
        return _e22;
    }
    return _e11 | ((((_e168 >= 8388608u) ? static_cast<uint>(metal::max(_e170, 1)) : 0u) << 23u) | (_e168 & 8388607u));
}

uint _naga_fmul_rd(
    uint left_bits_2,
    uint right_bits_2
) {
    uint _e8 = left_bits_2 & 2147483647u;
    uint _e9 = right_bits_2 & 2147483647u;
    uint _e11 = (left_bits_2 ^ right_bits_2) & 2147483648u;
    if ((_e8 > 2139095040u) || (_e9 > 2139095040u)) {
        return 2143289344u;
    }
    bool _e17 = (_e8 == 2139095040u) || (_e9 == 2139095040u);
    bool _e20 = (_e8 == 0u) || (_e9 == 0u);
    if (_e17 && _e20) {
        return 2143289344u;
    }
    uint _e22 = _e11 | 2139095040u;
    if (_e17) {
        return _e22;
    }
    if (_e20) {
        return _e11;
    }
    uint _e26 = _e8 >> 23u;
    uint _e27 = _e9 >> 23u;
    bool _e28 = _e26 != 0u;
    bool _e29 = _e27 != 0u;
    uint _e34 = (_e8 & 8388607u) | (_e28 ? 8388608u : 0u);
    uint _e35 = (_e9 & 8388607u) | (_e29 ? 8388608u : 0u);
    uint _e38 = _e34 & 4095u;
    uint _e39 = _e35 & 4095u;
    uint _e40 = _e34 >> 12u;
    uint _e41 = _e35 >> 12u;
    uint _e42 = _e38 * _e39;
    uint _e47 = ((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u);
    uint _e50 = (_e40 * _e41) + (_e47 >> 12u);
    uint _e54 = (_e42 & 4095u) | ((_e47 & 4095u) << 12u);
    int _e64 = static_cast<int>((_e50 != 0u) ? (55u - metal::clz(_e50)) : (31u - metal::clz(_e54 | 1u)));
    int _e69 = as_type<int>(as_type<uint>(static_cast<int>(_e28 ? _e26 : 1u)) + as_type<uint>(static_cast<int>(_e29 ? _e27 : 1u)));
    int _e79 = as_type<int>(as_type<uint>(metal::max(as_type<int>(as_type<uint>(_e64) - as_type<uint>(23)), as_type<int>(as_type<uint>(151) - as_type<uint>(_e69)))) - as_type<uint>(3));
    uint _e103 = static_cast<uint>(metal::min(metal::max(_e79, 0), 31)) & 31u;
    uint _e131 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e79) - as_type<uint>(24)), 0), 31)) & 31u;
    uint _e151 = (_e79 <= 0) ? (((_e50 << 24u) | _e54) << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(0) - as_type<uint>(_e79)), 0), 31)) & 31u)) : ((_e79 < 24) ? (((_e50 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(24) - as_type<uint>(_e79)), 0), 31)) & 31u)) | (_e54 >> _e103)) | static_cast<uint>((_e54 & ((1u << _e103) - 1u)) != 0u)) : ((_e79 == 24) ? (_e50 | static_cast<uint>(_e54 != 0u)) : ((_e79 < 48) ? ((_e50 >> _e131) | static_cast<uint>(((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u))) : static_cast<uint>((_e50 | _e54) != 0u))));
    bool _e152 = _e11 != 0u;
    uint _e160 = (_e151 >> 3u) + static_cast<uint>(_e152 && ((_e151 & 7u) > 0u));
    bool _e162 = _e160 >= 16777216u;
    uint _e164 = _e162 ? (_e160 >> 1u) : _e160;
    int _e166 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e64) + as_type<uint>(_e69))) - as_type<uint>(173))) + as_type<uint>(static_cast<int>(_e162)));
    if (_e166 >= 255) {
        return _e152 ? _e22 : (_e11 | 2139095039u);
    }
    return _e11 | ((((_e164 >= 8388608u) ? static_cast<uint>(metal::max(_e166, 1)) : 0u) << 23u) | (_e164 & 8388607u));
}

uint _naga_fmul_ru(
    uint left_bits_3,
    uint right_bits_3
) {
    uint _e8 = left_bits_3 & 2147483647u;
    uint _e9 = right_bits_3 & 2147483647u;
    uint _e11 = (left_bits_3 ^ right_bits_3) & 2147483648u;
    if ((_e8 > 2139095040u) || (_e9 > 2139095040u)) {
        return 2143289344u;
    }
    bool _e17 = (_e8 == 2139095040u) || (_e9 == 2139095040u);
    bool _e20 = (_e8 == 0u) || (_e9 == 0u);
    if (_e17 && _e20) {
        return 2143289344u;
    }
    uint _e22 = _e11 | 2139095040u;
    if (_e17) {
        return _e22;
    }
    if (_e20) {
        return _e11;
    }
    uint _e26 = _e8 >> 23u;
    uint _e27 = _e9 >> 23u;
    bool _e28 = _e26 != 0u;
    bool _e29 = _e27 != 0u;
    uint _e34 = (_e8 & 8388607u) | (_e28 ? 8388608u : 0u);
    uint _e35 = (_e9 & 8388607u) | (_e29 ? 8388608u : 0u);
    uint _e38 = _e34 & 4095u;
    uint _e39 = _e35 & 4095u;
    uint _e40 = _e34 >> 12u;
    uint _e41 = _e35 >> 12u;
    uint _e42 = _e38 * _e39;
    uint _e47 = ((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u);
    uint _e50 = (_e40 * _e41) + (_e47 >> 12u);
    uint _e54 = (_e42 & 4095u) | ((_e47 & 4095u) << 12u);
    int _e64 = static_cast<int>((_e50 != 0u) ? (55u - metal::clz(_e50)) : (31u - metal::clz(_e54 | 1u)));
    int _e69 = as_type<int>(as_type<uint>(static_cast<int>(_e28 ? _e26 : 1u)) + as_type<uint>(static_cast<int>(_e29 ? _e27 : 1u)));
    int _e79 = as_type<int>(as_type<uint>(metal::max(as_type<int>(as_type<uint>(_e64) - as_type<uint>(23)), as_type<int>(as_type<uint>(151) - as_type<uint>(_e69)))) - as_type<uint>(3));
    uint _e103 = static_cast<uint>(metal::min(metal::max(_e79, 0), 31)) & 31u;
    uint _e131 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e79) - as_type<uint>(24)), 0), 31)) & 31u;
    uint _e151 = (_e79 <= 0) ? (((_e50 << 24u) | _e54) << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(0) - as_type<uint>(_e79)), 0), 31)) & 31u)) : ((_e79 < 24) ? (((_e50 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(24) - as_type<uint>(_e79)), 0), 31)) & 31u)) | (_e54 >> _e103)) | static_cast<uint>((_e54 & ((1u << _e103) - 1u)) != 0u)) : ((_e79 == 24) ? (_e50 | static_cast<uint>(_e54 != 0u)) : ((_e79 < 48) ? ((_e50 >> _e131) | static_cast<uint>(((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u))) : static_cast<uint>((_e50 | _e54) != 0u))));
    bool _e152 = _e11 == 0u;
    uint _e160 = (_e151 >> 3u) + static_cast<uint>(_e152 && ((_e151 & 7u) > 0u));
    bool _e162 = _e160 >= 16777216u;
    uint _e164 = _e162 ? (_e160 >> 1u) : _e160;
    int _e166 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e64) + as_type<uint>(_e69))) - as_type<uint>(173))) + as_type<uint>(static_cast<int>(_e162)));
    if (_e166 >= 255) {
        return _e152 ? _e22 : (_e11 | 2139095039u);
    }
    return _e11 | ((((_e164 >= 8388608u) ? static_cast<uint>(metal::max(_e166, 1)) : 0u) << 23u) | (_e164 & 8388607u));
}

struct multiply_round_zeroInput {
};
kernel void multiply_round_zero(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_4 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
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
    uint local_14 = {};
    int directed_cursor = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint index = threadIdx.x + (blockIdx.x * 32u);
    if (index >= 4096u) {
        return;
    }
    uint base = 4u + (index * 14u);
    local = static_cast<uint>(index * 2u);
    uint _e17 = local;
    uint _e20 = input[_e17];
    float first_2 = as_type<float>(_e20);
    local_1 = static_cast<uint>((index * 2u) + 1u);
    uint _e28 = local_1;
    uint _e30 = input[_e28];
    float second_2 = as_type<float>(_e30);
    uint _e34 = _naga_fmul_rz(as_type<uint>(first_2), as_type<uint>(second_2));
    output[base] = as_type<uint>(as_type<float>(_e34));
    float _e39 = truncate_product(first_2, second_2);
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
    float _e75 = truncate_product(as_type<float>(_e60), as_type<float>(_e73));
    local_3 = static_cast<uint>(base + 2u);
    uint _e81 = local_3;
    output[_e81] = as_type<uint>(_e75);
    local_6 = false;
    if (false) {
        int _e85 = cursor;
        cursor = as_type<int>(as_type<uint>(_e85) + as_type<uint>(1));
        uint _e91 = _naga_fmul_rz(as_type<uint>(static_cast<float>(_e85)), as_type<uint>(first_2));
        uint _e94 = _naga_fabsf(as_type<uint>(as_type<float>(_e91)));
        local_6 = _e94 != 0u;
    }
    local_7 = true;
    if (true) {
    } else {
        int _e99 = cursor;
        cursor = as_type<int>(as_type<uint>(_e99) + as_type<uint>(1));
        uint _e105 = _naga_fmul_rz(as_type<uint>(first_2), as_type<uint>(static_cast<float>(_e99)));
        uint _e108 = _naga_fabsf(as_type<uint>(as_type<float>(_e105)));
        local_7 = _e108 != 0u;
    }
    int _e111 = cursor;
    local_8 = static_cast<uint>(base + 3u);
    uint _e117 = local_8;
    output[_e117] = static_cast<uint>(_e111);
    uint _e125 = _naga_fmul_rz(as_type<uint>(-(0.0)), as_type<uint>(-(0.0)));
    local_9 = static_cast<uint>(base + 4u);
    uint _e132 = local_9;
    output[_e132] = as_type<uint>(as_type<float>(_e125));
    uint _e139 = _naga_fmul_rz(as_type<uint>(-(0.0)), as_type<uint>(0.0));
    local_10 = static_cast<uint>(base + 5u);
    uint _e146 = local_10;
    output[_e146] = as_type<uint>(as_type<float>(_e139));
    float _e152 = truncate_product(static_cast<float>(2), static_cast<float>(3u));
    local_11 = static_cast<uint>(base + 6u);
    uint _e158 = local_11;
    output[_e158] = as_type<uint>(_e152);
    int _e162 = _fmul_rz(true, false);
    local_12 = static_cast<uint>(base + 7u);
    uint _e168 = local_12;
    output[_e168] = static_cast<uint>(_e162);
    uint _e172 = _naga_fmul_rz(as_type<uint>(second_2), as_type<uint>(first_2));
    local_13 = static_cast<uint>(base + 8u);
    uint _e179 = local_13;
    output[_e179] = as_type<uint>(as_type<float>(_e172));
    uint _e183 = _naga_fmul_rn(as_type<uint>(first_2), as_type<uint>(second_2));
    local_14 = static_cast<uint>(base + 9u);
    uint _e190 = local_14;
    output[_e190] = as_type<uint>(as_type<float>(_e183));
    directed_cursor = 0;
    int _e196 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e196) + as_type<uint>(1));
    local_16 = static_cast<uint>((index * 2u) + static_cast<uint>(_e196));
    uint _e203 = local_16;
    uint _e205 = input[_e203];
    int _e209 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e209) + as_type<uint>(1));
    local_17 = static_cast<uint>((index * 2u) + static_cast<uint>(_e209));
    uint _e216 = local_17;
    uint _e218 = input[_e216];
    uint _e222 = _naga_fmul_rd(as_type<uint>(as_type<float>(_e205)), as_type<uint>(as_type<float>(_e218)));
    local_15 = static_cast<uint>(base + 10u);
    uint _e229 = local_15;
    output[_e229] = as_type<uint>(as_type<float>(_e222));
    int _e231 = directed_cursor;
    local_18 = static_cast<uint>(base + 11u);
    uint _e237 = local_18;
    output[_e237] = static_cast<uint>(_e231);
    directed_cursor = 0;
    int _e242 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e242) + as_type<uint>(1));
    local_20 = static_cast<uint>((index * 2u) + static_cast<uint>(_e242));
    uint _e249 = local_20;
    uint _e251 = input[_e249];
    int _e255 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e255) + as_type<uint>(1));
    local_21 = static_cast<uint>((index * 2u) + static_cast<uint>(_e255));
    uint _e262 = local_21;
    uint _e264 = input[_e262];
    uint _e268 = _naga_fmul_ru(as_type<uint>(as_type<float>(_e251)), as_type<uint>(as_type<float>(_e264)));
    local_19 = static_cast<uint>(base + 12u);
    uint _e275 = local_19;
    output[_e275] = as_type<uint>(as_type<float>(_e268));
    int _e277 = directed_cursor;
    local_22 = static_cast<uint>(base + 13u);
    uint _e283 = local_22;
    output[_e283] = static_cast<uint>(_e277);
}
