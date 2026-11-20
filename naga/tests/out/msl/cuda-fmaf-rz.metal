// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_4[1];

uint _naga_fmaf_rz(
    uint left_bits,
    uint right_bits,
    uint addend_bits
) {
    uint stage = {};
    uint stage_1 = {};
    uint stage_2 = {};
    uint stage_3 = {};
    uint stage_4 = {};
    uint stage_5 = {};
    int stage_6 = {};
    int stage_7 = {};
    uint stage_8 = {};
    int stage_9 = {};
    uint stage_10 = {};
    uint stage_11 = {};
    uint stage_12 = {};
    uint stage_13 = {};
    int stage_14 = {};
    int stage_15 = {};
    uint stage_16 = {};
    uint stage_17 = {};
    uint _e12 = left_bits & 2147483647u;
    bool _e14 = _e12 == 2139095040u;
    bool _e15 = _e12 == 0u;
    uint _e16 = right_bits & 2147483647u;
    bool _e18 = _e16 == 2139095040u;
    bool _e19 = _e16 == 0u;
    uint _e20 = addend_bits & 2147483647u;
    bool _e22 = _e20 == 2139095040u;
    bool _e23 = _e20 == 0u;
    if (((_e12 > 2139095040u) || (_e16 > 2139095040u)) || (_e20 > 2139095040u)) {
        return 2143289344u;
    }
    if ((_e15 && _e18) || (_e19 && _e14)) {
        return 2143289344u;
    }
    uint _e30 = (left_bits ^ right_bits) & 2147483648u;
    uint _e31 = addend_bits & 2147483648u;
    bool _e32 = _e30 != _e31;
    bool _e33 = _e14 || _e18;
    if (_e33 && (_e22 && _e32)) {
        return 2143289344u;
    }
    if (_e33) {
        return _e30 | 2139095040u;
    }
    if (_e22) {
        return addend_bits;
    }
    bool _e37 = _e15 || _e19;
    if (_e37 && _e23) {
        return _e30 & _e31;
    }
    if (_e37) {
        return addend_bits;
    }
    uint _e40 = _e12 >> 23u;
    bool _e41 = _e40 != 0u;
    uint _e44 = (_e12 & 8388607u) | (_e41 ? 8388608u : 0u);
    uint _e49 = _e16 >> 23u;
    bool _e50 = _e49 != 0u;
    uint _e53 = (_e16 & 8388607u) | (_e50 ? 8388608u : 0u);
    uint _e58 = _e20 >> 23u;
    bool _e59 = _e58 != 0u;
    uint _e62 = (_e20 & 8388607u) | (_e59 ? 8388608u : 0u);
    uint _e69 = _e44 & 4095u;
    uint _e70 = _e44 >> 12u;
    uint _e71 = _e53 & 4095u;
    uint _e72 = _e53 >> 12u;
    uint _e73 = _e69 * _e71;
    uint _e78 = ((_e69 * _e72) + (_e70 * _e71)) + (_e73 >> 12u);
    uint _e81 = (_e70 * _e72) + (_e78 >> 12u);
    stage = ((_e73 & 4095u) | ((_e78 & 4095u) << 12u)) | (_e81 << 24u);
    uint _e92 = stage;
    stage_1 = _e81 >> 8u;
    uint _e94 = stage_1;
    int _e107 = static_cast<int>((_e94 != 0u) ? (63u - metal::clz(_e94 | 1u)) : (31u - metal::clz(_e92 | 1u)));
    int _e109 = as_type<int>(as_type<uint>(50) - as_type<uint>(_e107));
    uint _e119 = static_cast<uint>(metal::min(metal::max(_e109, 0), 31)) & 31u;
    bool _e143 = _e109 < 32;
    stage_2 = _e143 ? (_e92 << _e119) : 0u;
    uint _e147 = stage_2;
    stage_3 = _e143 ? ((_e94 << _e119) | ((_e109 > 0) ? (_e92 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e109)), 0), 31)) & 31u)) : 0u)) : (_e92 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e109) - as_type<uint>(32)), 0), 31)) & 31u));
    uint _e149 = stage_3;
    int _e151 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e41 ? _e40 : 1u)) - as_type<uint>(150))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e50 ? _e49 : 1u)) - as_type<uint>(150))))) + as_type<uint>(_e107));
    int _e164 = static_cast<int>((0u != 0u) ? (63u - metal::clz(0u | 1u)) : (31u - metal::clz(_e62 | 1u)));
    int _e165 = as_type<int>(as_type<uint>(50) - as_type<uint>(_e164));
    uint _e175 = static_cast<uint>(metal::min(metal::max(_e165, 0), 31)) & 31u;
    bool _e199 = _e165 < 32;
    stage_4 = _e199 ? (_e62 << _e175) : 0u;
    uint _e203 = stage_4;
    stage_5 = _e199 ? ((0u << _e175) | ((_e165 > 0) ? (_e62 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e165)), 0), 31)) & 31u)) : 0u)) : (_e62 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e165) - as_type<uint>(32)), 0), 31)) & 31u));
    uint _e205 = stage_5;
    int _e207 = _e23 ? _e151 : as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e59 ? _e58 : 1u)) - as_type<uint>(150))) + as_type<uint>(_e164));
    bool _e216 = (_e151 < _e207) || ((_e151 == _e207) && ((_e149 < _e205) || ((_e149 == _e205) && (_e147 < _e203))));
    uint _e217 = _e216 ? _e203 : _e147;
    uint _e218 = _e216 ? _e205 : _e149;
    uint _e219 = _e216 ? _e147 : _e203;
    uint _e220 = _e216 ? _e149 : _e205;
    stage_6 = _e216 ? _e207 : _e151;
    int _e225 = stage_6;
    stage_7 = _e216 ? _e151 : _e207;
    int _e227 = stage_7;
    stage_8 = _e216 ? _e31 : _e30;
    uint _e229 = stage_8;
    stage_9 = as_type<int>(as_type<uint>(_e225) - as_type<uint>(_e227));
    int _e232 = stage_9;
    uint _e244 = static_cast<uint>(metal::min(metal::max(_e232, 0), 31)) & 31u;
    uint _e272 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e232) - as_type<uint>(32)), 0), 31)) & 31u;
    bool _e281 = _e232 < 32;
    bool _e287 = _e232 < 64;
    int _e290 = as_type<int>(as_type<uint>(0) - as_type<uint>(_e232));
    uint _e300 = static_cast<uint>(metal::min(metal::max(_e290, 0), 31)) & 31u;
    bool _e324 = _e290 < 32;
    bool _e327 = _e232 <= 0;
    stage_10 = _e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > 0) ? (_e220 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e232)), 0), 31)) & 31u)) : 0u)) | static_cast<uint>((_e219 & ((1u << _e244) - 1u)) != 0u)) : ((_e220 >> _e272) | static_cast<uint>(((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u))) : static_cast<uint>((_e220 | _e219) != 0u));
    uint _e331 = stage_10;
    stage_11 = _e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > 0) ? (_e219 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e290)), 0), 31)) & 31u)) : 0u)) : (_e219 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e290) - as_type<uint>(32)), 0), 31)) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u);
    uint _e333 = stage_11;
    uint _e334 = _e217 + _e331;
    stage_12 = _e32 ? (_e217 - _e331) : _e334;
    uint _e347 = stage_12;
    stage_13 = _e32 ? ((_e218 - _e333) - static_cast<uint>(_e217 < _e331)) : ((_e218 + _e333) + static_cast<uint>(_e334 < _e217));
    uint _e349 = stage_13;
    if ((_e347 | _e349) == 0u) {
        return 0u;
    }
    int _e365 = as_type<int>(as_type<uint>(_e225) - as_type<uint>(50));
    int _e370 = metal::max(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e349 != 0u) ? (63u - metal::clz(_e349 | 1u)) : (31u - metal::clz(_e347 | 1u)))) + as_type<uint>(_e365))) - as_type<uint>(23)), -149);
    stage_14 = _e370;
    int _e375 = stage_14;
    stage_15 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e370) - as_type<uint>(_e365))) - as_type<uint>(3));
    int _e377 = stage_15;
    uint _e389 = static_cast<uint>(metal::min(metal::max(_e377, 0), 31)) & 31u;
    uint _e417 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e377) - as_type<uint>(32)), 0), 31)) & 31u;
    bool _e426 = _e377 < 32;
    bool _e432 = _e377 < 64;
    int _e435 = as_type<int>(as_type<uint>(0) - as_type<uint>(_e377));
    uint _e445 = static_cast<uint>(metal::min(metal::max(_e435, 0), 31)) & 31u;
    bool _e469 = _e435 < 32;
    bool _e472 = _e377 <= 0;
    stage_16 = _e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > 0) ? (_e349 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e377)), 0), 31)) & 31u)) : 0u)) | static_cast<uint>((_e347 & ((1u << _e389) - 1u)) != 0u)) : ((_e349 >> _e417) | static_cast<uint>(((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u))) : static_cast<uint>((_e349 | _e347) != 0u));
    uint _e476 = stage_16;
    stage_17 = _e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > 0) ? (_e347 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e435)), 0), 31)) & 31u)) : 0u)) : (_e347 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e435) - as_type<uint>(32)), 0), 31)) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u);
    uint _e479 = _e476 >> 3u;
    int _e481 = as_type<int>(as_type<uint>(_e375) + as_type<uint>(150));
    if (_e481 >= 255) {
        return _e229 | 2139095039u;
    }
    return _e229 | ((((_e479 >= 8388608u) ? static_cast<uint>(metal::max(_e481, 0)) : 0u) << 23u) | (_e479 & 8388607u));
}

float truncate_fused(
    float first,
    float second,
    float third
) {
    uint _e6 = _naga_fmaf_rz(as_type<uint>(first), as_type<uint>(second), as_type<uint>(third));
    return as_type<float>(_e6);
}

int _fmaf_rz(
    bool first_1,
    bool second_1,
    bool third_1
) {
    int local_48 = {};
    if (first_1) {
        local_48 = 7;
    } else {
        local_48 = 9;
    }
    int _e6 = local_48;
    return _e6;
}

uint _naga_fabsf(
    uint input_bits
) {
    uint _e2 = input_bits & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}

uint _naga_fmaf_rn(
    uint left_bits_1,
    uint right_bits_1,
    uint addend_bits_1
) {
    uint stage_18 = {};
    uint stage_19 = {};
    uint stage_20 = {};
    uint stage_21 = {};
    uint stage_22 = {};
    uint stage_23 = {};
    int stage_24 = {};
    int stage_25 = {};
    uint stage_26 = {};
    int stage_27 = {};
    uint stage_28 = {};
    uint stage_29 = {};
    uint stage_30 = {};
    uint stage_31 = {};
    int stage_32 = {};
    int stage_33 = {};
    uint stage_34 = {};
    uint stage_35 = {};
    uint _e12 = left_bits_1 & 2147483647u;
    bool _e14 = _e12 == 2139095040u;
    bool _e15 = _e12 == 0u;
    uint _e16 = right_bits_1 & 2147483647u;
    bool _e18 = _e16 == 2139095040u;
    bool _e19 = _e16 == 0u;
    uint _e20 = addend_bits_1 & 2147483647u;
    bool _e22 = _e20 == 2139095040u;
    bool _e23 = _e20 == 0u;
    if (((_e12 > 2139095040u) || (_e16 > 2139095040u)) || (_e20 > 2139095040u)) {
        return 2143289344u;
    }
    if ((_e15 && _e18) || (_e19 && _e14)) {
        return 2143289344u;
    }
    uint _e30 = (left_bits_1 ^ right_bits_1) & 2147483648u;
    uint _e31 = addend_bits_1 & 2147483648u;
    bool _e32 = _e30 != _e31;
    bool _e33 = _e14 || _e18;
    if (_e33 && (_e22 && _e32)) {
        return 2143289344u;
    }
    if (_e33) {
        return _e30 | 2139095040u;
    }
    if (_e22) {
        return addend_bits_1;
    }
    bool _e37 = _e15 || _e19;
    if (_e37 && _e23) {
        return _e30 & _e31;
    }
    if (_e37) {
        return addend_bits_1;
    }
    uint _e40 = _e12 >> 23u;
    bool _e41 = _e40 != 0u;
    uint _e44 = (_e12 & 8388607u) | (_e41 ? 8388608u : 0u);
    uint _e49 = _e16 >> 23u;
    bool _e50 = _e49 != 0u;
    uint _e53 = (_e16 & 8388607u) | (_e50 ? 8388608u : 0u);
    uint _e58 = _e20 >> 23u;
    bool _e59 = _e58 != 0u;
    uint _e62 = (_e20 & 8388607u) | (_e59 ? 8388608u : 0u);
    uint _e69 = _e44 & 4095u;
    uint _e70 = _e44 >> 12u;
    uint _e71 = _e53 & 4095u;
    uint _e72 = _e53 >> 12u;
    uint _e73 = _e69 * _e71;
    uint _e78 = ((_e69 * _e72) + (_e70 * _e71)) + (_e73 >> 12u);
    uint _e81 = (_e70 * _e72) + (_e78 >> 12u);
    stage_18 = ((_e73 & 4095u) | ((_e78 & 4095u) << 12u)) | (_e81 << 24u);
    uint _e92 = stage_18;
    stage_19 = _e81 >> 8u;
    uint _e94 = stage_19;
    int _e107 = static_cast<int>((_e94 != 0u) ? (63u - metal::clz(_e94 | 1u)) : (31u - metal::clz(_e92 | 1u)));
    int _e109 = as_type<int>(as_type<uint>(50) - as_type<uint>(_e107));
    uint _e119 = static_cast<uint>(metal::min(metal::max(_e109, 0), 31)) & 31u;
    bool _e143 = _e109 < 32;
    stage_20 = _e143 ? (_e92 << _e119) : 0u;
    uint _e147 = stage_20;
    stage_21 = _e143 ? ((_e94 << _e119) | ((_e109 > 0) ? (_e92 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e109)), 0), 31)) & 31u)) : 0u)) : (_e92 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e109) - as_type<uint>(32)), 0), 31)) & 31u));
    uint _e149 = stage_21;
    int _e151 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e41 ? _e40 : 1u)) - as_type<uint>(150))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e50 ? _e49 : 1u)) - as_type<uint>(150))))) + as_type<uint>(_e107));
    int _e164 = static_cast<int>((0u != 0u) ? (63u - metal::clz(0u | 1u)) : (31u - metal::clz(_e62 | 1u)));
    int _e165 = as_type<int>(as_type<uint>(50) - as_type<uint>(_e164));
    uint _e175 = static_cast<uint>(metal::min(metal::max(_e165, 0), 31)) & 31u;
    bool _e199 = _e165 < 32;
    stage_22 = _e199 ? (_e62 << _e175) : 0u;
    uint _e203 = stage_22;
    stage_23 = _e199 ? ((0u << _e175) | ((_e165 > 0) ? (_e62 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e165)), 0), 31)) & 31u)) : 0u)) : (_e62 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e165) - as_type<uint>(32)), 0), 31)) & 31u));
    uint _e205 = stage_23;
    int _e207 = _e23 ? _e151 : as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e59 ? _e58 : 1u)) - as_type<uint>(150))) + as_type<uint>(_e164));
    bool _e216 = (_e151 < _e207) || ((_e151 == _e207) && ((_e149 < _e205) || ((_e149 == _e205) && (_e147 < _e203))));
    uint _e217 = _e216 ? _e203 : _e147;
    uint _e218 = _e216 ? _e205 : _e149;
    uint _e219 = _e216 ? _e147 : _e203;
    uint _e220 = _e216 ? _e149 : _e205;
    stage_24 = _e216 ? _e207 : _e151;
    int _e225 = stage_24;
    stage_25 = _e216 ? _e151 : _e207;
    int _e227 = stage_25;
    stage_26 = _e216 ? _e31 : _e30;
    uint _e229 = stage_26;
    stage_27 = as_type<int>(as_type<uint>(_e225) - as_type<uint>(_e227));
    int _e232 = stage_27;
    uint _e244 = static_cast<uint>(metal::min(metal::max(_e232, 0), 31)) & 31u;
    uint _e272 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e232) - as_type<uint>(32)), 0), 31)) & 31u;
    bool _e281 = _e232 < 32;
    bool _e287 = _e232 < 64;
    int _e290 = as_type<int>(as_type<uint>(0) - as_type<uint>(_e232));
    uint _e300 = static_cast<uint>(metal::min(metal::max(_e290, 0), 31)) & 31u;
    bool _e324 = _e290 < 32;
    bool _e327 = _e232 <= 0;
    stage_28 = _e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > 0) ? (_e220 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e232)), 0), 31)) & 31u)) : 0u)) | static_cast<uint>((_e219 & ((1u << _e244) - 1u)) != 0u)) : ((_e220 >> _e272) | static_cast<uint>(((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u))) : static_cast<uint>((_e220 | _e219) != 0u));
    uint _e331 = stage_28;
    stage_29 = _e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > 0) ? (_e219 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e290)), 0), 31)) & 31u)) : 0u)) : (_e219 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e290) - as_type<uint>(32)), 0), 31)) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u);
    uint _e333 = stage_29;
    uint _e334 = _e217 + _e331;
    stage_30 = _e32 ? (_e217 - _e331) : _e334;
    uint _e347 = stage_30;
    stage_31 = _e32 ? ((_e218 - _e333) - static_cast<uint>(_e217 < _e331)) : ((_e218 + _e333) + static_cast<uint>(_e334 < _e217));
    uint _e349 = stage_31;
    if ((_e347 | _e349) == 0u) {
        return 0u;
    }
    int _e365 = as_type<int>(as_type<uint>(_e225) - as_type<uint>(50));
    int _e370 = metal::max(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e349 != 0u) ? (63u - metal::clz(_e349 | 1u)) : (31u - metal::clz(_e347 | 1u)))) + as_type<uint>(_e365))) - as_type<uint>(23)), -149);
    stage_32 = _e370;
    int _e375 = stage_32;
    stage_33 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e370) - as_type<uint>(_e365))) - as_type<uint>(3));
    int _e377 = stage_33;
    uint _e389 = static_cast<uint>(metal::min(metal::max(_e377, 0), 31)) & 31u;
    uint _e417 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e377) - as_type<uint>(32)), 0), 31)) & 31u;
    bool _e426 = _e377 < 32;
    bool _e432 = _e377 < 64;
    int _e435 = as_type<int>(as_type<uint>(0) - as_type<uint>(_e377));
    uint _e445 = static_cast<uint>(metal::min(metal::max(_e435, 0), 31)) & 31u;
    bool _e469 = _e435 < 32;
    bool _e472 = _e377 <= 0;
    stage_34 = _e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > 0) ? (_e349 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e377)), 0), 31)) & 31u)) : 0u)) | static_cast<uint>((_e347 & ((1u << _e389) - 1u)) != 0u)) : ((_e349 >> _e417) | static_cast<uint>(((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u))) : static_cast<uint>((_e349 | _e347) != 0u));
    uint _e476 = stage_34;
    stage_35 = _e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > 0) ? (_e347 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e435)), 0), 31)) & 31u)) : 0u)) : (_e347 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e435) - as_type<uint>(32)), 0), 31)) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u);
    uint _e481 = _e476 >> 3u;
    uint _e482 = _e476 & 7u;
    uint _e490 = _e481 + static_cast<uint>((_e482 > 4u) || ((_e482 == 4u) && ((_e481 & 1u) != 0u)));
    bool _e492 = _e490 >= 16777216u;
    uint _e494 = _e492 ? (_e490 >> 1u) : _e490;
    int _e498 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e375) + as_type<uint>(static_cast<int>(_e492)))) + as_type<uint>(150));
    if (_e498 >= 255) {
        return _e229 | 2139095040u;
    }
    return _e229 | ((((_e494 >= 8388608u) ? static_cast<uint>(metal::max(_e498, 0)) : 0u) << 23u) | (_e494 & 8388607u));
}

uint _naga_fmaf_rd(
    uint left_bits_2,
    uint right_bits_2,
    uint addend_bits_2
) {
    uint stage_36 = {};
    uint stage_37 = {};
    uint stage_38 = {};
    uint stage_39 = {};
    uint stage_40 = {};
    uint stage_41 = {};
    int stage_42 = {};
    int stage_43 = {};
    uint stage_44 = {};
    int stage_45 = {};
    uint stage_46 = {};
    uint stage_47 = {};
    uint stage_48 = {};
    uint stage_49 = {};
    int stage_50 = {};
    int stage_51 = {};
    uint stage_52 = {};
    uint stage_53 = {};
    uint _e12 = left_bits_2 & 2147483647u;
    bool _e14 = _e12 == 2139095040u;
    bool _e15 = _e12 == 0u;
    uint _e16 = right_bits_2 & 2147483647u;
    bool _e18 = _e16 == 2139095040u;
    bool _e19 = _e16 == 0u;
    uint _e20 = addend_bits_2 & 2147483647u;
    bool _e22 = _e20 == 2139095040u;
    bool _e23 = _e20 == 0u;
    if (((_e12 > 2139095040u) || (_e16 > 2139095040u)) || (_e20 > 2139095040u)) {
        return 2143289344u;
    }
    if ((_e15 && _e18) || (_e19 && _e14)) {
        return 2143289344u;
    }
    uint _e30 = (left_bits_2 ^ right_bits_2) & 2147483648u;
    uint _e31 = addend_bits_2 & 2147483648u;
    bool _e32 = _e30 != _e31;
    bool _e33 = _e14 || _e18;
    if (_e33 && (_e22 && _e32)) {
        return 2143289344u;
    }
    if (_e33) {
        return _e30 | 2139095040u;
    }
    if (_e22) {
        return addend_bits_2;
    }
    bool _e37 = _e15 || _e19;
    if (_e37 && _e23) {
        return _e30 | _e31;
    }
    if (_e37) {
        return addend_bits_2;
    }
    uint _e40 = _e12 >> 23u;
    bool _e41 = _e40 != 0u;
    uint _e44 = (_e12 & 8388607u) | (_e41 ? 8388608u : 0u);
    uint _e49 = _e16 >> 23u;
    bool _e50 = _e49 != 0u;
    uint _e53 = (_e16 & 8388607u) | (_e50 ? 8388608u : 0u);
    uint _e58 = _e20 >> 23u;
    bool _e59 = _e58 != 0u;
    uint _e62 = (_e20 & 8388607u) | (_e59 ? 8388608u : 0u);
    uint _e69 = _e44 & 4095u;
    uint _e70 = _e44 >> 12u;
    uint _e71 = _e53 & 4095u;
    uint _e72 = _e53 >> 12u;
    uint _e73 = _e69 * _e71;
    uint _e78 = ((_e69 * _e72) + (_e70 * _e71)) + (_e73 >> 12u);
    uint _e81 = (_e70 * _e72) + (_e78 >> 12u);
    stage_36 = ((_e73 & 4095u) | ((_e78 & 4095u) << 12u)) | (_e81 << 24u);
    uint _e92 = stage_36;
    stage_37 = _e81 >> 8u;
    uint _e94 = stage_37;
    int _e107 = static_cast<int>((_e94 != 0u) ? (63u - metal::clz(_e94 | 1u)) : (31u - metal::clz(_e92 | 1u)));
    int _e109 = as_type<int>(as_type<uint>(50) - as_type<uint>(_e107));
    uint _e119 = static_cast<uint>(metal::min(metal::max(_e109, 0), 31)) & 31u;
    bool _e143 = _e109 < 32;
    stage_38 = _e143 ? (_e92 << _e119) : 0u;
    uint _e147 = stage_38;
    stage_39 = _e143 ? ((_e94 << _e119) | ((_e109 > 0) ? (_e92 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e109)), 0), 31)) & 31u)) : 0u)) : (_e92 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e109) - as_type<uint>(32)), 0), 31)) & 31u));
    uint _e149 = stage_39;
    int _e151 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e41 ? _e40 : 1u)) - as_type<uint>(150))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e50 ? _e49 : 1u)) - as_type<uint>(150))))) + as_type<uint>(_e107));
    int _e164 = static_cast<int>((0u != 0u) ? (63u - metal::clz(0u | 1u)) : (31u - metal::clz(_e62 | 1u)));
    int _e165 = as_type<int>(as_type<uint>(50) - as_type<uint>(_e164));
    uint _e175 = static_cast<uint>(metal::min(metal::max(_e165, 0), 31)) & 31u;
    bool _e199 = _e165 < 32;
    stage_40 = _e199 ? (_e62 << _e175) : 0u;
    uint _e203 = stage_40;
    stage_41 = _e199 ? ((0u << _e175) | ((_e165 > 0) ? (_e62 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e165)), 0), 31)) & 31u)) : 0u)) : (_e62 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e165) - as_type<uint>(32)), 0), 31)) & 31u));
    uint _e205 = stage_41;
    int _e207 = _e23 ? _e151 : as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e59 ? _e58 : 1u)) - as_type<uint>(150))) + as_type<uint>(_e164));
    bool _e216 = (_e151 < _e207) || ((_e151 == _e207) && ((_e149 < _e205) || ((_e149 == _e205) && (_e147 < _e203))));
    uint _e217 = _e216 ? _e203 : _e147;
    uint _e218 = _e216 ? _e205 : _e149;
    uint _e219 = _e216 ? _e147 : _e203;
    uint _e220 = _e216 ? _e149 : _e205;
    stage_42 = _e216 ? _e207 : _e151;
    int _e225 = stage_42;
    stage_43 = _e216 ? _e151 : _e207;
    int _e227 = stage_43;
    stage_44 = _e216 ? _e31 : _e30;
    uint _e229 = stage_44;
    stage_45 = as_type<int>(as_type<uint>(_e225) - as_type<uint>(_e227));
    int _e232 = stage_45;
    uint _e244 = static_cast<uint>(metal::min(metal::max(_e232, 0), 31)) & 31u;
    uint _e272 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e232) - as_type<uint>(32)), 0), 31)) & 31u;
    bool _e281 = _e232 < 32;
    bool _e287 = _e232 < 64;
    int _e290 = as_type<int>(as_type<uint>(0) - as_type<uint>(_e232));
    uint _e300 = static_cast<uint>(metal::min(metal::max(_e290, 0), 31)) & 31u;
    bool _e324 = _e290 < 32;
    bool _e327 = _e232 <= 0;
    stage_46 = _e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > 0) ? (_e220 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e232)), 0), 31)) & 31u)) : 0u)) | static_cast<uint>((_e219 & ((1u << _e244) - 1u)) != 0u)) : ((_e220 >> _e272) | static_cast<uint>(((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u))) : static_cast<uint>((_e220 | _e219) != 0u));
    uint _e331 = stage_46;
    stage_47 = _e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > 0) ? (_e219 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e290)), 0), 31)) & 31u)) : 0u)) : (_e219 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e290) - as_type<uint>(32)), 0), 31)) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u);
    uint _e333 = stage_47;
    uint _e334 = _e217 + _e331;
    stage_48 = _e32 ? (_e217 - _e331) : _e334;
    uint _e347 = stage_48;
    stage_49 = _e32 ? ((_e218 - _e333) - static_cast<uint>(_e217 < _e331)) : ((_e218 + _e333) + static_cast<uint>(_e334 < _e217));
    uint _e349 = stage_49;
    if ((_e347 | _e349) == 0u) {
        return 2147483648u;
    }
    int _e365 = as_type<int>(as_type<uint>(_e225) - as_type<uint>(50));
    int _e370 = metal::max(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e349 != 0u) ? (63u - metal::clz(_e349 | 1u)) : (31u - metal::clz(_e347 | 1u)))) + as_type<uint>(_e365))) - as_type<uint>(23)), -149);
    stage_50 = _e370;
    int _e375 = stage_50;
    stage_51 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e370) - as_type<uint>(_e365))) - as_type<uint>(3));
    int _e377 = stage_51;
    uint _e389 = static_cast<uint>(metal::min(metal::max(_e377, 0), 31)) & 31u;
    uint _e417 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e377) - as_type<uint>(32)), 0), 31)) & 31u;
    bool _e426 = _e377 < 32;
    bool _e432 = _e377 < 64;
    int _e435 = as_type<int>(as_type<uint>(0) - as_type<uint>(_e377));
    uint _e445 = static_cast<uint>(metal::min(metal::max(_e435, 0), 31)) & 31u;
    bool _e469 = _e435 < 32;
    bool _e472 = _e377 <= 0;
    stage_52 = _e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > 0) ? (_e349 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e377)), 0), 31)) & 31u)) : 0u)) | static_cast<uint>((_e347 & ((1u << _e389) - 1u)) != 0u)) : ((_e349 >> _e417) | static_cast<uint>(((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u))) : static_cast<uint>((_e349 | _e347) != 0u));
    uint _e476 = stage_52;
    stage_53 = _e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > 0) ? (_e347 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e435)), 0), 31)) & 31u)) : 0u)) : (_e347 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e435) - as_type<uint>(32)), 0), 31)) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u);
    bool _e479 = _e229 != 0u;
    uint _e486 = (_e476 >> 3u) + static_cast<uint>(_e479 && ((_e476 & 7u) > 0u));
    bool _e488 = _e486 >= 16777216u;
    uint _e490 = _e488 ? (_e486 >> 1u) : _e486;
    int _e494 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e375) + as_type<uint>(static_cast<int>(_e488)))) + as_type<uint>(150));
    if (_e494 >= 255) {
        return _e229 | (_e479 ? 2139095040u : 2139095039u);
    }
    return _e229 | ((((_e490 >= 8388608u) ? static_cast<uint>(metal::max(_e494, 0)) : 0u) << 23u) | (_e490 & 8388607u));
}

uint _naga_fmaf_ru(
    uint left_bits_3,
    uint right_bits_3,
    uint addend_bits_3
) {
    uint stage_54 = {};
    uint stage_55 = {};
    uint stage_56 = {};
    uint stage_57 = {};
    uint stage_58 = {};
    uint stage_59 = {};
    int stage_60 = {};
    int stage_61 = {};
    uint stage_62 = {};
    int stage_63 = {};
    uint stage_64 = {};
    uint stage_65 = {};
    uint stage_66 = {};
    uint stage_67 = {};
    int stage_68 = {};
    int stage_69 = {};
    uint stage_70 = {};
    uint stage_71 = {};
    uint _e12 = left_bits_3 & 2147483647u;
    bool _e14 = _e12 == 2139095040u;
    bool _e15 = _e12 == 0u;
    uint _e16 = right_bits_3 & 2147483647u;
    bool _e18 = _e16 == 2139095040u;
    bool _e19 = _e16 == 0u;
    uint _e20 = addend_bits_3 & 2147483647u;
    bool _e22 = _e20 == 2139095040u;
    bool _e23 = _e20 == 0u;
    if (((_e12 > 2139095040u) || (_e16 > 2139095040u)) || (_e20 > 2139095040u)) {
        return 2143289344u;
    }
    if ((_e15 && _e18) || (_e19 && _e14)) {
        return 2143289344u;
    }
    uint _e30 = (left_bits_3 ^ right_bits_3) & 2147483648u;
    uint _e31 = addend_bits_3 & 2147483648u;
    bool _e32 = _e30 != _e31;
    bool _e33 = _e14 || _e18;
    if (_e33 && (_e22 && _e32)) {
        return 2143289344u;
    }
    if (_e33) {
        return _e30 | 2139095040u;
    }
    if (_e22) {
        return addend_bits_3;
    }
    bool _e37 = _e15 || _e19;
    if (_e37 && _e23) {
        return _e30 & _e31;
    }
    if (_e37) {
        return addend_bits_3;
    }
    uint _e40 = _e12 >> 23u;
    bool _e41 = _e40 != 0u;
    uint _e44 = (_e12 & 8388607u) | (_e41 ? 8388608u : 0u);
    uint _e49 = _e16 >> 23u;
    bool _e50 = _e49 != 0u;
    uint _e53 = (_e16 & 8388607u) | (_e50 ? 8388608u : 0u);
    uint _e58 = _e20 >> 23u;
    bool _e59 = _e58 != 0u;
    uint _e62 = (_e20 & 8388607u) | (_e59 ? 8388608u : 0u);
    uint _e69 = _e44 & 4095u;
    uint _e70 = _e44 >> 12u;
    uint _e71 = _e53 & 4095u;
    uint _e72 = _e53 >> 12u;
    uint _e73 = _e69 * _e71;
    uint _e78 = ((_e69 * _e72) + (_e70 * _e71)) + (_e73 >> 12u);
    uint _e81 = (_e70 * _e72) + (_e78 >> 12u);
    stage_54 = ((_e73 & 4095u) | ((_e78 & 4095u) << 12u)) | (_e81 << 24u);
    uint _e92 = stage_54;
    stage_55 = _e81 >> 8u;
    uint _e94 = stage_55;
    int _e107 = static_cast<int>((_e94 != 0u) ? (63u - metal::clz(_e94 | 1u)) : (31u - metal::clz(_e92 | 1u)));
    int _e109 = as_type<int>(as_type<uint>(50) - as_type<uint>(_e107));
    uint _e119 = static_cast<uint>(metal::min(metal::max(_e109, 0), 31)) & 31u;
    bool _e143 = _e109 < 32;
    stage_56 = _e143 ? (_e92 << _e119) : 0u;
    uint _e147 = stage_56;
    stage_57 = _e143 ? ((_e94 << _e119) | ((_e109 > 0) ? (_e92 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e109)), 0), 31)) & 31u)) : 0u)) : (_e92 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e109) - as_type<uint>(32)), 0), 31)) & 31u));
    uint _e149 = stage_57;
    int _e151 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e41 ? _e40 : 1u)) - as_type<uint>(150))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e50 ? _e49 : 1u)) - as_type<uint>(150))))) + as_type<uint>(_e107));
    int _e164 = static_cast<int>((0u != 0u) ? (63u - metal::clz(0u | 1u)) : (31u - metal::clz(_e62 | 1u)));
    int _e165 = as_type<int>(as_type<uint>(50) - as_type<uint>(_e164));
    uint _e175 = static_cast<uint>(metal::min(metal::max(_e165, 0), 31)) & 31u;
    bool _e199 = _e165 < 32;
    stage_58 = _e199 ? (_e62 << _e175) : 0u;
    uint _e203 = stage_58;
    stage_59 = _e199 ? ((0u << _e175) | ((_e165 > 0) ? (_e62 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e165)), 0), 31)) & 31u)) : 0u)) : (_e62 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e165) - as_type<uint>(32)), 0), 31)) & 31u));
    uint _e205 = stage_59;
    int _e207 = _e23 ? _e151 : as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e59 ? _e58 : 1u)) - as_type<uint>(150))) + as_type<uint>(_e164));
    bool _e216 = (_e151 < _e207) || ((_e151 == _e207) && ((_e149 < _e205) || ((_e149 == _e205) && (_e147 < _e203))));
    uint _e217 = _e216 ? _e203 : _e147;
    uint _e218 = _e216 ? _e205 : _e149;
    uint _e219 = _e216 ? _e147 : _e203;
    uint _e220 = _e216 ? _e149 : _e205;
    stage_60 = _e216 ? _e207 : _e151;
    int _e225 = stage_60;
    stage_61 = _e216 ? _e151 : _e207;
    int _e227 = stage_61;
    stage_62 = _e216 ? _e31 : _e30;
    uint _e229 = stage_62;
    stage_63 = as_type<int>(as_type<uint>(_e225) - as_type<uint>(_e227));
    int _e232 = stage_63;
    uint _e244 = static_cast<uint>(metal::min(metal::max(_e232, 0), 31)) & 31u;
    uint _e272 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e232) - as_type<uint>(32)), 0), 31)) & 31u;
    bool _e281 = _e232 < 32;
    bool _e287 = _e232 < 64;
    int _e290 = as_type<int>(as_type<uint>(0) - as_type<uint>(_e232));
    uint _e300 = static_cast<uint>(metal::min(metal::max(_e290, 0), 31)) & 31u;
    bool _e324 = _e290 < 32;
    bool _e327 = _e232 <= 0;
    stage_64 = _e327 ? (_e324 ? (_e219 << _e300) : 0u) : (_e287 ? (_e281 ? (((_e219 >> _e244) | ((_e232 > 0) ? (_e220 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e232)), 0), 31)) & 31u)) : 0u)) | static_cast<uint>((_e219 & ((1u << _e244) - 1u)) != 0u)) : ((_e220 >> _e272) | static_cast<uint>(((_e220 & ((1u << _e272) - 1u)) | _e219) != 0u))) : static_cast<uint>((_e220 | _e219) != 0u));
    uint _e331 = stage_64;
    stage_65 = _e327 ? (_e324 ? ((_e220 << _e300) | ((_e290 > 0) ? (_e219 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e290)), 0), 31)) & 31u)) : 0u)) : (_e219 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e290) - as_type<uint>(32)), 0), 31)) & 31u))) : (_e287 ? (_e281 ? (_e220 >> _e244) : 0u) : 0u);
    uint _e333 = stage_65;
    uint _e334 = _e217 + _e331;
    stage_66 = _e32 ? (_e217 - _e331) : _e334;
    uint _e347 = stage_66;
    stage_67 = _e32 ? ((_e218 - _e333) - static_cast<uint>(_e217 < _e331)) : ((_e218 + _e333) + static_cast<uint>(_e334 < _e217));
    uint _e349 = stage_67;
    if ((_e347 | _e349) == 0u) {
        return 0u;
    }
    int _e365 = as_type<int>(as_type<uint>(_e225) - as_type<uint>(50));
    int _e370 = metal::max(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e349 != 0u) ? (63u - metal::clz(_e349 | 1u)) : (31u - metal::clz(_e347 | 1u)))) + as_type<uint>(_e365))) - as_type<uint>(23)), -149);
    stage_68 = _e370;
    int _e375 = stage_68;
    stage_69 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e370) - as_type<uint>(_e365))) - as_type<uint>(3));
    int _e377 = stage_69;
    uint _e389 = static_cast<uint>(metal::min(metal::max(_e377, 0), 31)) & 31u;
    uint _e417 = static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e377) - as_type<uint>(32)), 0), 31)) & 31u;
    bool _e426 = _e377 < 32;
    bool _e432 = _e377 < 64;
    int _e435 = as_type<int>(as_type<uint>(0) - as_type<uint>(_e377));
    uint _e445 = static_cast<uint>(metal::min(metal::max(_e435, 0), 31)) & 31u;
    bool _e469 = _e435 < 32;
    bool _e472 = _e377 <= 0;
    stage_70 = _e472 ? (_e469 ? (_e347 << _e445) : 0u) : (_e432 ? (_e426 ? (((_e347 >> _e389) | ((_e377 > 0) ? (_e349 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e377)), 0), 31)) & 31u)) : 0u)) | static_cast<uint>((_e347 & ((1u << _e389) - 1u)) != 0u)) : ((_e349 >> _e417) | static_cast<uint>(((_e349 & ((1u << _e417) - 1u)) | _e347) != 0u))) : static_cast<uint>((_e349 | _e347) != 0u));
    uint _e476 = stage_70;
    stage_71 = _e472 ? (_e469 ? ((_e349 << _e445) | ((_e435 > 0) ? (_e347 >> (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(32) - as_type<uint>(_e435)), 0), 31)) & 31u)) : 0u)) : (_e347 << (static_cast<uint>(metal::min(metal::max(as_type<int>(as_type<uint>(_e435) - as_type<uint>(32)), 0), 31)) & 31u))) : (_e432 ? (_e426 ? (_e349 >> _e389) : 0u) : 0u);
    bool _e479 = _e229 == 0u;
    uint _e486 = (_e476 >> 3u) + static_cast<uint>(_e479 && ((_e476 & 7u) > 0u));
    bool _e488 = _e486 >= 16777216u;
    uint _e490 = _e488 ? (_e486 >> 1u) : _e486;
    int _e494 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e375) + as_type<uint>(static_cast<int>(_e488)))) + as_type<uint>(150));
    if (_e494 >= 255) {
        return _e229 | (_e479 ? 2139095040u : 2139095039u);
    }
    return _e229 | ((((_e490 >= 8388608u) ? static_cast<uint>(metal::max(_e494, 0)) : 0u) << 23u) | (_e490 & 8388607u));
}

struct fused_round_zeroInput {
};
kernel void fused_round_zero(
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
    int cursor = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    bool local_8 = {};
    bool local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    float local_16 = {};
    uint local_17 = {};
    int directed_cursor = {};
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
    uint index = threadIdx.x + (blockIdx.x * 32u);
    if (index >= 4096u) {
        return;
    }
    uint base = 4u + (index * 22u);
    local = static_cast<uint>(index * 3u);
    uint _e17 = local;
    uint _e20 = input[_e17];
    float first_2 = as_type<float>(_e20);
    local_1 = static_cast<uint>((index * 3u) + 1u);
    uint _e28 = local_1;
    uint _e30 = input[_e28];
    float second_2 = as_type<float>(_e30);
    local_2 = static_cast<uint>((index * 3u) + 2u);
    uint _e38 = local_2;
    uint _e40 = input[_e38];
    float third_2 = as_type<float>(_e40);
    uint _e45 = _naga_fmaf_rz(as_type<uint>(first_2), as_type<uint>(second_2), as_type<uint>(third_2));
    output[base] = as_type<uint>(as_type<float>(_e45));
    float _e50 = truncate_fused(first_2, second_2, third_2);
    local_3 = static_cast<uint>(base + 1u);
    uint _e56 = local_3;
    output[_e56] = as_type<uint>(_e50);
    cursor = 0;
    int _e62 = cursor;
    cursor = as_type<int>(as_type<uint>(_e62) + as_type<uint>(1));
    local_5 = static_cast<uint>((index * 3u) + static_cast<uint>(_e62));
    uint _e69 = local_5;
    uint _e71 = input[_e69];
    int _e75 = cursor;
    cursor = as_type<int>(as_type<uint>(_e75) + as_type<uint>(1));
    local_6 = static_cast<uint>((index * 3u) + static_cast<uint>(_e75));
    uint _e82 = local_6;
    uint _e84 = input[_e82];
    int _e88 = cursor;
    cursor = as_type<int>(as_type<uint>(_e88) + as_type<uint>(1));
    local_7 = static_cast<uint>((index * 3u) + static_cast<uint>(_e88));
    uint _e95 = local_7;
    uint _e97 = input[_e95];
    float _e99 = truncate_fused(as_type<float>(_e71), as_type<float>(_e84), as_type<float>(_e97));
    local_4 = static_cast<uint>(base + 2u);
    uint _e105 = local_4;
    output[_e105] = as_type<uint>(_e99);
    local_8 = false;
    if (false) {
        int _e109 = cursor;
        cursor = as_type<int>(as_type<uint>(_e109) + as_type<uint>(1));
        uint _e116 = _naga_fmaf_rz(as_type<uint>(static_cast<float>(_e109)), as_type<uint>(first_2), as_type<uint>(second_2));
        uint _e119 = _naga_fabsf(as_type<uint>(as_type<float>(_e116)));
        local_8 = _e119 != 0u;
    }
    local_9 = true;
    if (true) {
    } else {
        int _e124 = cursor;
        cursor = as_type<int>(as_type<uint>(_e124) + as_type<uint>(1));
        uint _e131 = _naga_fmaf_rz(as_type<uint>(first_2), as_type<uint>(static_cast<float>(_e124)), as_type<uint>(second_2));
        uint _e134 = _naga_fabsf(as_type<uint>(as_type<float>(_e131)));
        local_9 = _e134 != 0u;
    }
    int _e137 = cursor;
    local_10 = static_cast<uint>(base + 3u);
    uint _e143 = local_10;
    output[_e143] = static_cast<uint>(_e137);
    uint _e153 = _naga_fmaf_rz(as_type<uint>(-(0.0)), as_type<uint>(1.0), as_type<uint>(-(0.0)));
    local_11 = static_cast<uint>(base + 4u);
    uint _e160 = local_11;
    output[_e160] = as_type<uint>(as_type<float>(_e153));
    uint _e169 = _naga_fmaf_rz(as_type<uint>(-(0.0)), as_type<uint>(1.0), as_type<uint>(0.0));
    local_12 = static_cast<uint>(base + 5u);
    uint _e176 = local_12;
    output[_e176] = as_type<uint>(as_type<float>(_e169));
    float _e184 = truncate_fused(static_cast<float>(2), static_cast<float>(3u), static_cast<float>(4));
    local_13 = static_cast<uint>(base + 6u);
    uint _e190 = local_13;
    output[_e190] = as_type<uint>(_e184);
    int _e195 = _fmaf_rz(true, false, true);
    local_14 = static_cast<uint>(base + 7u);
    uint _e201 = local_14;
    output[_e201] = static_cast<uint>(_e195);
    if (true) {
        uint _e207 = _naga_fmaf_rz(as_type<uint>(first_2), as_type<uint>(second_2), as_type<uint>(third_2));
        local_16 = as_type<float>(_e207);
    } else {
        int _e210 = cursor;
        cursor = as_type<int>(as_type<uint>(_e210) + as_type<uint>(1));
        uint _e217 = _naga_fmaf_rz(as_type<uint>(static_cast<float>(_e210)), as_type<uint>(first_2), as_type<uint>(second_2));
        local_16 = as_type<float>(_e217);
    }
    float _e221 = local_16;
    local_15 = static_cast<uint>(base + 8u);
    uint _e227 = local_15;
    output[_e227] = as_type<uint>(_e221);
    uint _e232 = _naga_fmaf_rn(as_type<uint>(first_2), as_type<uint>(second_2), as_type<uint>(third_2));
    local_17 = static_cast<uint>(base + 9u);
    uint _e239 = local_17;
    output[_e239] = as_type<uint>(as_type<float>(_e232));
    directed_cursor = 0;
    int _e245 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e245) + as_type<uint>(1));
    local_19 = static_cast<uint>((index * 3u) + static_cast<uint>(_e245));
    uint _e252 = local_19;
    uint _e254 = input[_e252];
    int _e258 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e258) + as_type<uint>(1));
    local_20 = static_cast<uint>((index * 3u) + static_cast<uint>(_e258));
    uint _e265 = local_20;
    uint _e267 = input[_e265];
    int _e271 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e271) + as_type<uint>(1));
    local_21 = static_cast<uint>((index * 3u) + static_cast<uint>(_e271));
    uint _e278 = local_21;
    uint _e280 = input[_e278];
    uint _e285 = _naga_fmaf_rd(as_type<uint>(as_type<float>(_e254)), as_type<uint>(as_type<float>(_e267)), as_type<uint>(as_type<float>(_e280)));
    local_18 = static_cast<uint>(base + 10u);
    uint _e292 = local_18;
    output[_e292] = as_type<uint>(as_type<float>(_e285));
    int _e294 = directed_cursor;
    local_22 = static_cast<uint>(base + 11u);
    uint _e300 = local_22;
    output[_e300] = static_cast<uint>(_e294);
    directed_cursor = 0;
    int _e305 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e305) + as_type<uint>(1));
    local_24 = static_cast<uint>((index * 3u) + static_cast<uint>(_e305));
    uint _e312 = local_24;
    uint _e314 = input[_e312];
    int _e318 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e318) + as_type<uint>(1));
    local_25 = static_cast<uint>((index * 3u) + static_cast<uint>(_e318));
    uint _e325 = local_25;
    uint _e327 = input[_e325];
    int _e331 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e331) + as_type<uint>(1));
    local_26 = static_cast<uint>((index * 3u) + static_cast<uint>(_e331));
    uint _e338 = local_26;
    uint _e340 = input[_e338];
    uint _e345 = _naga_fmaf_ru(as_type<uint>(as_type<float>(_e314)), as_type<uint>(as_type<float>(_e327)), as_type<uint>(as_type<float>(_e340)));
    local_23 = static_cast<uint>(base + 12u);
    uint _e352 = local_23;
    output[_e352] = as_type<uint>(as_type<float>(_e345));
    int _e354 = directed_cursor;
    local_27 = static_cast<uint>(base + 13u);
    uint _e360 = local_27;
    output[_e360] = static_cast<uint>(_e354);
    directed_cursor = 0;
    int _e365 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e365) + as_type<uint>(1));
    local_29 = static_cast<uint>((index * 3u) + static_cast<uint>(_e365));
    uint _e372 = local_29;
    uint _e374 = input[_e372];
    int _e378 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e378) + as_type<uint>(1));
    local_30 = static_cast<uint>((index * 3u) + static_cast<uint>(_e378));
    uint _e385 = local_30;
    uint _e387 = input[_e385];
    int _e391 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e391) + as_type<uint>(1));
    local_31 = static_cast<uint>((index * 3u) + static_cast<uint>(_e391));
    uint _e398 = local_31;
    uint _e400 = input[_e398];
    uint _e405 = _naga_fmaf_rn(as_type<uint>(as_type<float>(_e374)), as_type<uint>(as_type<float>(_e387)), as_type<uint>(as_type<float>(_e400)));
    local_28 = static_cast<uint>(base + 14u);
    uint _e412 = local_28;
    output[_e412] = as_type<uint>(as_type<float>(_e405));
    int _e414 = directed_cursor;
    local_32 = static_cast<uint>(base + 15u);
    uint _e420 = local_32;
    output[_e420] = static_cast<uint>(_e414);
    directed_cursor = 0;
    int _e425 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e425) + as_type<uint>(1));
    local_34 = static_cast<uint>((index * 3u) + static_cast<uint>(_e425));
    uint _e432 = local_34;
    uint _e434 = input[_e432];
    int _e438 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e438) + as_type<uint>(1));
    local_35 = static_cast<uint>((index * 3u) + static_cast<uint>(_e438));
    uint _e445 = local_35;
    uint _e447 = input[_e445];
    int _e451 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e451) + as_type<uint>(1));
    local_36 = static_cast<uint>((index * 3u) + static_cast<uint>(_e451));
    uint _e458 = local_36;
    uint _e460 = input[_e458];
    uint _e465 = _naga_fmaf_rz(as_type<uint>(as_type<float>(_e434)), as_type<uint>(as_type<float>(_e447)), as_type<uint>(as_type<float>(_e460)));
    local_33 = static_cast<uint>(base + 16u);
    uint _e472 = local_33;
    output[_e472] = as_type<uint>(as_type<float>(_e465));
    int _e474 = directed_cursor;
    local_37 = static_cast<uint>(base + 17u);
    uint _e480 = local_37;
    output[_e480] = static_cast<uint>(_e474);
    directed_cursor = 0;
    int _e485 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e485) + as_type<uint>(1));
    local_39 = static_cast<uint>((index * 3u) + static_cast<uint>(_e485));
    uint _e492 = local_39;
    uint _e494 = input[_e492];
    int _e498 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e498) + as_type<uint>(1));
    local_40 = static_cast<uint>((index * 3u) + static_cast<uint>(_e498));
    uint _e505 = local_40;
    uint _e507 = input[_e505];
    int _e511 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e511) + as_type<uint>(1));
    local_41 = static_cast<uint>((index * 3u) + static_cast<uint>(_e511));
    uint _e518 = local_41;
    uint _e520 = input[_e518];
    uint _e525 = _naga_fmaf_rd(as_type<uint>(as_type<float>(_e494)), as_type<uint>(as_type<float>(_e507)), as_type<uint>(as_type<float>(_e520)));
    local_38 = static_cast<uint>(base + 18u);
    uint _e532 = local_38;
    output[_e532] = as_type<uint>(as_type<float>(_e525));
    int _e534 = directed_cursor;
    local_42 = static_cast<uint>(base + 19u);
    uint _e540 = local_42;
    output[_e540] = static_cast<uint>(_e534);
    directed_cursor = 0;
    int _e545 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e545) + as_type<uint>(1));
    local_44 = static_cast<uint>((index * 3u) + static_cast<uint>(_e545));
    uint _e552 = local_44;
    uint _e554 = input[_e552];
    int _e558 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e558) + as_type<uint>(1));
    local_45 = static_cast<uint>((index * 3u) + static_cast<uint>(_e558));
    uint _e565 = local_45;
    uint _e567 = input[_e565];
    int _e571 = directed_cursor;
    directed_cursor = as_type<int>(as_type<uint>(_e571) + as_type<uint>(1));
    local_46 = static_cast<uint>((index * 3u) + static_cast<uint>(_e571));
    uint _e578 = local_46;
    uint _e580 = input[_e578];
    uint _e585 = _naga_fmaf_ru(as_type<uint>(as_type<float>(_e554)), as_type<uint>(as_type<float>(_e567)), as_type<uint>(as_type<float>(_e580)));
    local_43 = static_cast<uint>(base + 20u);
    uint _e592 = local_43;
    output[_e592] = as_type<uint>(as_type<float>(_e585));
    int _e594 = directed_cursor;
    local_47 = static_cast<uint>(base + 21u);
    uint _e600 = local_47;
    output[_e600] = static_cast<uint>(_e594);
}
