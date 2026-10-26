struct Record_cuda_record_0_ {
    value: i32,
    history: array<i32, 2>,
}

@group(0) @binding(0)
var<storage> input: array<vec2<i32>>;
@group(0) @binding(1)
var<storage, read_write> out: array<u32>;

fn operator_u002b(value: vec2<i32>) -> vec2<i32> {
    var value_1: vec2<i32>;

    value_1 = value;
    let _e3 = value_1.x;
    let _e5 = value_1.y;
    return vec2<i32>(_e3, _e5);
}

fn operator_u002d(value_2: vec2<i32>) -> vec2<i32> {
    var value_3: vec2<i32>;

    value_3 = value_2;
    let _e3 = value_3.x;
    let _e6 = value_3.y;
    return vec2<i32>(-(_e3), -(_e6));
}

fn operator_u007e(value_4: vec2<i32>) -> vec2<i32> {
    var value_5: vec2<i32>;

    value_5 = value_4;
    let _e3 = value_5.x;
    let _e6 = value_5.y;
    return vec2<i32>(~(_e3), ~(_e6));
}

fn operator_u0021_(value_6: vec2<i32>) -> bool {
    var value_7: vec2<i32>;
    var local_152: bool;

    value_7 = value_6;
    let _e4 = value_7.x;
    let _e5 = (_e4 == 0i);
    local_152 = _e5;
    if _e5 {
        let _e9 = value_7.y;
        local_152 = (_e9 == 0i);
    }
    let _e11 = local_152;
    return _e11;
}

fn operator_u002a(value_8: vec2<i32>) -> i32 {
    var value_9: vec2<i32>;

    value_9 = value_8;
    let _e4 = value_9.x;
    let _e7 = value_9.y;
    return ((_e4 * 10i) + _e7);
}

fn operator_u0026_(value_10: vec2<i32>) -> vec2<i32> {
    var value_11: vec2<i32>;

    value_11 = value_10;
    let _e3 = value_11.y;
    let _e5 = value_11.x;
    return vec2<i32>(_e3, _e5);
}

fn operator_u002b_1(left_1: vec2<i32>, right_1: vec2<i32>) -> vec2<i32> {
    var left_2: vec2<i32>;
    var right_2: vec2<i32>;

    left_2 = left_1;
    right_2 = right_1;
    let _e6 = left_2.x;
    let _e7 = right_2.x;
    let _e11 = left_2.y;
    let _e12 = right_2.y;
    return vec2<i32>((_e6 + _e7), (_e11 + _e12));
}

fn operator_u002d_1(left_3: vec2<i32>, right_3: vec2<i32>) -> vec2<i32> {
    var left_4: vec2<i32>;
    var right_4: vec2<i32>;

    left_4 = left_3;
    right_4 = right_3;
    let _e6 = left_4.x;
    let _e7 = right_4.x;
    let _e11 = left_4.y;
    let _e12 = right_4.y;
    return vec2<i32>((_e6 - _e7), (_e11 - _e12));
}

fn operator_u002a_1(left_5: vec2<i32>, right_5: vec2<i32>) -> vec2<i32> {
    var left_6: vec2<i32>;
    var right_6: vec2<i32>;

    left_6 = left_5;
    right_6 = right_5;
    let _e6 = left_6.x;
    let _e7 = right_6.x;
    let _e11 = left_6.y;
    let _e12 = right_6.y;
    return vec2<i32>((_e6 * _e7), (_e11 * _e12));
}

fn operator_u002f(left_7: vec2<i32>, right_7: vec2<i32>) -> vec2<i32> {
    var left_8: vec2<i32>;
    var right_8: vec2<i32>;

    left_8 = left_7;
    right_8 = right_7;
    let _e6 = left_8.x;
    let _e7 = right_8.x;
    let _e11 = left_8.y;
    let _e12 = right_8.y;
    return vec2<i32>((_e6 / _e7), (_e11 / _e12));
}

fn operator_u0025_(left_9: vec2<i32>, right_9: vec2<i32>) -> vec2<i32> {
    var left_10: vec2<i32>;
    var right_10: vec2<i32>;

    left_10 = left_9;
    right_10 = right_9;
    let _e6 = left_10.x;
    let _e7 = right_10.x;
    let _e11 = left_10.y;
    let _e12 = right_10.y;
    return vec2<i32>((_e6 % _e7), (_e11 % _e12));
}

fn operator_u0026_1(left_11: vec2<i32>, right_11: vec2<i32>) -> vec2<i32> {
    var left_12: vec2<i32>;
    var right_12: vec2<i32>;

    left_12 = left_11;
    right_12 = right_11;
    let _e6 = left_12.x;
    let _e7 = right_12.x;
    let _e11 = left_12.y;
    let _e12 = right_12.y;
    return vec2<i32>((_e6 & _e7), (_e11 & _e12));
}

fn operator_u007c(left_13: vec2<i32>, right_13: vec2<i32>) -> vec2<i32> {
    var left_14: vec2<i32>;
    var right_14: vec2<i32>;

    left_14 = left_13;
    right_14 = right_13;
    let _e6 = left_14.x;
    let _e7 = right_14.x;
    let _e11 = left_14.y;
    let _e12 = right_14.y;
    return vec2<i32>((_e6 | _e7), (_e11 | _e12));
}

fn operator_u005e(left_15: vec2<i32>, right_15: vec2<i32>) -> vec2<i32> {
    var left_16: vec2<i32>;
    var right_16: vec2<i32>;

    left_16 = left_15;
    right_16 = right_15;
    let _e6 = left_16.x;
    let _e7 = right_16.x;
    let _e11 = left_16.y;
    let _e12 = right_16.y;
    return vec2<i32>((_e6 ^ _e7), (_e11 ^ _e12));
}

fn operator_(left_17: vec2<i32>, right_17: vec2<i32>) -> vec2<i32> {
    var left_18: vec2<i32>;
    var right_18: vec2<i32>;
    var local_153: u32;
    var local_154: u32;

    left_18 = left_17;
    right_18 = right_17;
    let _e5 = left_18.x;
    let _e7 = right_18.x;
    local_153 = u32(_e7);
    let _e10 = local_153;
    let _e13 = left_18.y;
    let _e15 = right_18.y;
    local_154 = u32(_e15);
    let _e18 = local_154;
    return vec2<i32>((_e5 << _e10), (_e13 << _e18));
}

fn operator_1(left_19: vec2<i32>, right_19: vec2<i32>) -> vec2<i32> {
    var left_20: vec2<i32>;
    var right_20: vec2<i32>;

    left_20 = left_19;
    right_20 = right_19;
    let _e5 = left_20.x;
    let _e7 = right_20.x;
    let _e11 = left_20.y;
    let _e13 = right_20.y;
    return vec2<i32>((_e5 >> u32(_e7)), (_e11 >> u32(_e13)));
}

fn operator_u002a_2(value_12: Record_cuda_record_0_) -> Record_cuda_record_0_ {
    var value_13: Record_cuda_record_0_;

    value_13 = value_12;
    let _e3 = value_13.value;
    value_13.value = (_e3 + 1i);
    let _e6 = value_13;
    return _e6;
}

fn operator_u0026_2(value_14: Record_cuda_record_0_) -> i32 {
    var value_15: Record_cuda_record_0_;

    value_15 = value_14;
    let _e3 = value_15.value;
    return _e3;
}

fn operator_u002d_2(value_16: Record_cuda_record_0_) -> Record_cuda_record_0_ {
    var value_17: Record_cuda_record_0_;

    value_17 = value_16;
    let _e4 = value_17.value;
    value_17.value = -(_e4);
    let _e6 = value_17;
    return _e6;
}

fn operator_u002a_3(value_18: Record_cuda_record_0_, factor: i32) -> Record_cuda_record_0_ {
    var value_19: Record_cuda_record_0_;
    var factor_1: i32;

    value_19 = value_18;
    factor_1 = factor;
    let _e5 = factor_1;
    let _e6 = value_19.value;
    value_19.value = (_e6 * _e5);
    let _e11 = factor_1;
    let _e12 = value_19.history[1i];
    value_19.history[1i] = (_e12 + _e11);
    let _e14 = value_19;
    return _e14;
}

@compute @workgroup_size(2, 1, 1)
fn operator_functions(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var base: u32;
    var left: vec2<i32>;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var right: vec2<i32>;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;
    var local_66: u32;
    var local_67: u32;
    var local_68: u32;
    var local_69: u32;
    var local_70: u32;
    var local_71: u32;
    var local_72: u32;
    var local_73: u32;
    var local_74: u32;
    var local_75: u32;
    var local_76: u32;
    var local_77: u32;
    var local_78: u32;
    var local_79: u32;
    var local_80: u32;
    var local_81: u32;
    var local_82: u32;
    var original: Record_cuda_record_0_;
    var scaled: Record_cuda_record_0_;
    var local_83: u32;
    var local_84: u32;
    var local_85: u32;
    var local_86: Record_cuda_record_0_;
    var local_87: u32;
    var local_88: u32;
    var local_89: u32;
    var local_90: u32;
    var local_91: u32;
    var local_92: u32;
    var local_93: u32;
    var local_94: u32;
    var local_95: u32;
    var local_96: u32;
    var local_97: u32;
    var local_98: u32;
    var local_99: u32;
    var local_100: u32;
    var local_101: u32;
    var local_102: u32;
    var local_103: u32;
    var local_104: u32;
    var local_105: u32;
    var local_106: u32;
    var local_107: u32;
    var local_108: u32;
    var local_109: u32;
    var local_110: u32;
    var local_111: u32;
    var local_112: u32;
    var local_113: u32;
    var local_114: u32;
    var local_115: vec2<i32>;
    var local_116: u32;
    var local_117: u32;
    var local_118: u32;
    var local_119: u32;
    var local_120: u32;
    var local_121: u32;
    var local_122: u32;
    var local_123: u32;
    var local_124: u32;
    var local_125: u32;
    var local_126: u32;
    var local_127: u32;
    var local_128: u32;
    var local_129: u32;
    var local_130: u32;
    var local_131: u32;
    var local_132: u32;
    var local_133: u32;
    var local_134: u32;
    var local_135: u32;
    var local_136: u32;
    var local_137: u32;
    var local_138: u32;
    var local_139: u32;
    var local_140: u32;
    var local_141: u32;
    var local_142: u32;
    var local_143: u32;
    var local_144: u32;
    var local_145: u32;
    var local_146: u32;
    var local_147: u32;
    var local_148: u32;
    var local_149: u32;
    var local_150: u32;
    var local_151: u32;

    local = 0u;
    local_1 = 0u;
    base = (threadIdx.x * 36u);
    let _e9 = local;
    local_2 = _e9;
    let _e11 = local_2;
    local_3 = u32(_e11);
    local_4 = u32(threadIdx.x);
    let _e18 = local_3;
    let _e19 = local_4;
    local_114 = u32((_e18 + _e19));
    let _e24 = local_114;
    let _e26 = input[_e24];
    local_115 = _e26;
    let _e27 = local_115;
    left = _e27;
    right = vec2<i32>(3i, 2i);
    let _e33 = left;
    let _e34 = operator_u002b(_e33);
    let _e36 = local_1;
    local_5 = _e36;
    let _e38 = local_5;
    local_6 = u32(_e38);
    let _e41 = base;
    local_7 = u32((_e41 + 0u));
    let _e48 = local_6;
    let _e49 = local_7;
    local_116 = u32((_e48 + _e49));
    let _e53 = local_116;
    out[_e53] = u32(_e34.x);
    let _e55 = left;
    let _e56 = operator_u002d(_e55);
    let _e58 = local_1;
    local_8 = _e58;
    let _e60 = local_8;
    local_9 = u32(_e60);
    let _e63 = base;
    local_10 = u32((_e63 + 1u));
    let _e69 = local_9;
    let _e70 = local_10;
    local_117 = u32((_e69 + _e70));
    let _e74 = local_117;
    out[_e74] = u32(_e56.y);
    let _e76 = left;
    let _e77 = operator_u007e(_e76);
    let _e79 = local_1;
    local_11 = _e79;
    let _e81 = local_11;
    local_12 = u32(_e81);
    let _e84 = base;
    local_13 = u32((_e84 + 2u));
    let _e90 = local_12;
    let _e91 = local_13;
    local_118 = u32((_e90 + _e91));
    let _e95 = local_118;
    out[_e95] = u32(_e77.x);
    let _e97 = left;
    let _e98 = operator_u0021_(_e97);
    let _e99 = local_1;
    local_14 = _e99;
    let _e101 = local_14;
    local_15 = u32(_e101);
    let _e104 = base;
    local_16 = u32((_e104 + 3u));
    let _e110 = local_15;
    let _e111 = local_16;
    local_119 = u32((_e110 + _e111));
    let _e115 = local_119;
    out[_e115] = u32(_e98);
    let _e117 = left;
    let _e118 = operator_u002a(_e117);
    let _e119 = local_1;
    local_17 = _e119;
    let _e121 = local_17;
    local_18 = u32(_e121);
    let _e124 = base;
    local_19 = u32((_e124 + 4u));
    let _e130 = local_18;
    let _e131 = local_19;
    local_120 = u32((_e130 + _e131));
    let _e135 = local_120;
    out[_e135] = u32(_e118);
    let _e137 = left;
    let _e138 = operator_u0026_(_e137);
    let _e140 = local_1;
    local_20 = _e140;
    let _e142 = local_20;
    local_21 = u32(_e142);
    let _e145 = base;
    local_22 = u32((_e145 + 5u));
    let _e151 = local_21;
    let _e152 = local_22;
    local_121 = u32((_e151 + _e152));
    let _e156 = local_121;
    out[_e156] = u32(_e138.x);
    let _e158 = left;
    let _e159 = right;
    let _e160 = operator_u002b_1(_e158, _e159);
    let _e162 = local_1;
    local_23 = _e162;
    let _e164 = local_23;
    local_24 = u32(_e164);
    let _e167 = base;
    local_25 = u32((_e167 + 6u));
    let _e173 = local_24;
    let _e174 = local_25;
    local_122 = u32((_e173 + _e174));
    let _e178 = local_122;
    out[_e178] = u32(_e160.x);
    let _e180 = left;
    let _e181 = right;
    let _e182 = operator_u002d_1(_e180, _e181);
    let _e184 = local_1;
    local_26 = _e184;
    let _e186 = local_26;
    local_27 = u32(_e186);
    let _e189 = base;
    local_28 = u32((_e189 + 7u));
    let _e195 = local_27;
    let _e196 = local_28;
    local_123 = u32((_e195 + _e196));
    let _e200 = local_123;
    out[_e200] = u32(_e182.y);
    let _e202 = left;
    let _e203 = right;
    let _e204 = operator_u002a_1(_e202, _e203);
    let _e206 = local_1;
    local_29 = _e206;
    let _e208 = local_29;
    local_30 = u32(_e208);
    let _e211 = base;
    local_31 = u32((_e211 + 8u));
    let _e217 = local_30;
    let _e218 = local_31;
    local_124 = u32((_e217 + _e218));
    let _e222 = local_124;
    out[_e222] = u32(_e204.x);
    let _e224 = left;
    let _e225 = right;
    let _e226 = operator_u002f(_e224, _e225);
    let _e228 = local_1;
    local_32 = _e228;
    let _e230 = local_32;
    local_33 = u32(_e230);
    let _e233 = base;
    local_34 = u32((_e233 + 9u));
    let _e239 = local_33;
    let _e240 = local_34;
    local_125 = u32((_e239 + _e240));
    let _e244 = local_125;
    out[_e244] = u32(_e226.y);
    let _e246 = left;
    let _e247 = right;
    let _e248 = operator_u0025_(_e246, _e247);
    let _e250 = local_1;
    local_35 = _e250;
    let _e252 = local_35;
    local_36 = u32(_e252);
    let _e255 = base;
    local_37 = u32((_e255 + 10u));
    let _e261 = local_36;
    let _e262 = local_37;
    local_126 = u32((_e261 + _e262));
    let _e266 = local_126;
    out[_e266] = u32(_e248.y);
    let _e268 = left;
    let _e269 = right;
    let _e270 = operator_u0026_1(_e268, _e269);
    let _e272 = local_1;
    local_38 = _e272;
    let _e274 = local_38;
    local_39 = u32(_e274);
    let _e277 = base;
    local_40 = u32((_e277 + 11u));
    let _e283 = local_39;
    let _e284 = local_40;
    local_127 = u32((_e283 + _e284));
    let _e288 = local_127;
    out[_e288] = u32(_e270.x);
    let _e290 = left;
    let _e291 = right;
    let _e292 = operator_u007c(_e290, _e291);
    let _e294 = local_1;
    local_41 = _e294;
    let _e296 = local_41;
    local_42 = u32(_e296);
    let _e299 = base;
    local_43 = u32((_e299 + 12u));
    let _e305 = local_42;
    let _e306 = local_43;
    local_128 = u32((_e305 + _e306));
    let _e310 = local_128;
    out[_e310] = u32(_e292.y);
    let _e312 = left;
    let _e313 = right;
    let _e314 = operator_u005e(_e312, _e313);
    let _e316 = local_1;
    local_44 = _e316;
    let _e318 = local_44;
    local_45 = u32(_e318);
    let _e321 = base;
    local_46 = u32((_e321 + 13u));
    let _e327 = local_45;
    let _e328 = local_46;
    local_129 = u32((_e327 + _e328));
    let _e332 = local_129;
    out[_e332] = u32(_e314.x);
    let _e334 = left;
    let _e335 = right;
    let _e336 = operator_(_e334, _e335);
    let _e338 = local_1;
    local_47 = _e338;
    let _e340 = local_47;
    local_48 = u32(_e340);
    let _e343 = base;
    local_49 = u32((_e343 + 14u));
    let _e349 = local_48;
    let _e350 = local_49;
    local_130 = u32((_e349 + _e350));
    let _e354 = local_130;
    out[_e354] = u32(_e336.x);
    let _e356 = left;
    let _e357 = right;
    let _e358 = operator_1(_e356, _e357);
    let _e360 = local_1;
    local_50 = _e360;
    let _e362 = local_50;
    local_51 = u32(_e362);
    let _e365 = base;
    local_52 = u32((_e365 + 15u));
    let _e371 = local_51;
    let _e372 = local_52;
    local_131 = u32((_e371 + _e372));
    let _e376 = local_131;
    out[_e376] = u32(_e358.y);
    let _e378 = left;
    let _e379 = operator_u002b(_e378);
    let _e381 = local_1;
    local_53 = _e381;
    let _e383 = local_53;
    local_54 = u32(_e383);
    let _e386 = base;
    local_55 = u32((_e386 + 16u));
    let _e392 = local_54;
    let _e393 = local_55;
    local_132 = u32((_e392 + _e393));
    let _e397 = local_132;
    out[_e397] = u32(_e379.y);
    let _e399 = left;
    let _e400 = right;
    let _e401 = operator_u002d_1(_e399, _e400);
    let _e403 = local_1;
    local_56 = _e403;
    let _e405 = local_56;
    local_57 = u32(_e405);
    let _e408 = base;
    local_58 = u32((_e408 + 17u));
    let _e414 = local_57;
    let _e415 = local_58;
    local_133 = u32((_e414 + _e415));
    let _e419 = local_133;
    out[_e419] = u32(_e401.x);
    let _e421 = left;
    let _e422 = operator_u002a(_e421);
    let _e423 = local_1;
    local_59 = _e423;
    let _e425 = local_59;
    local_60 = u32(_e425);
    let _e428 = base;
    local_61 = u32((_e428 + 18u));
    let _e434 = local_60;
    let _e435 = local_61;
    local_134 = u32((_e434 + _e435));
    let _e439 = local_134;
    out[_e439] = u32(_e422);
    let _e441 = left;
    let _e442 = right;
    let _e443 = operator_u0026_1(_e441, _e442);
    let _e445 = local_1;
    local_62 = _e445;
    let _e447 = local_62;
    local_63 = u32(_e447);
    let _e450 = base;
    local_64 = u32((_e450 + 19u));
    let _e456 = local_63;
    let _e457 = local_64;
    local_135 = u32((_e456 + _e457));
    let _e461 = local_135;
    out[_e461] = u32(_e443.y);
    let _e463 = left;
    let _e464 = operator_u0026_(_e463);
    let _e465 = operator_u002a(_e464);
    let _e466 = local_1;
    local_65 = _e466;
    let _e468 = local_65;
    local_66 = u32(_e468);
    let _e471 = base;
    local_67 = u32((_e471 + 20u));
    let _e477 = local_66;
    let _e478 = local_67;
    local_136 = u32((_e477 + _e478));
    let _e482 = local_136;
    out[_e482] = u32(_e465);
    let _e484 = left;
    let _e485 = operator_u0026_(_e484);
    let _e486 = operator_u0026_(_e485);
    let _e488 = local_1;
    local_68 = _e488;
    let _e490 = local_68;
    local_69 = u32(_e490);
    let _e493 = base;
    local_70 = u32((_e493 + 21u));
    let _e499 = local_69;
    let _e500 = local_70;
    local_137 = u32((_e499 + _e500));
    let _e504 = local_137;
    out[_e504] = u32(_e486.x);
    let _e506 = left;
    let _e507 = right;
    let _e508 = right;
    let _e509 = operator_u002a_1(_e507, _e508);
    let _e510 = operator_u002b_1(_e506, _e509);
    let _e512 = local_1;
    local_71 = _e512;
    let _e514 = local_71;
    local_72 = u32(_e514);
    let _e517 = base;
    local_73 = u32((_e517 + 22u));
    let _e523 = local_72;
    let _e524 = local_73;
    local_138 = u32((_e523 + _e524));
    let _e528 = local_138;
    out[_e528] = u32(_e510.x);
    let _e530 = left;
    let _e531 = right;
    let _e535 = operator_u002b_1(_e531, vec2<i32>(1i, 1i));
    let _e536 = operator_(_e530, _e535);
    let _e538 = local_1;
    local_74 = _e538;
    let _e540 = local_74;
    local_75 = u32(_e540);
    let _e543 = base;
    local_76 = u32((_e543 + 23u));
    let _e549 = local_75;
    let _e550 = local_76;
    local_139 = u32((_e549 + _e550));
    let _e554 = local_139;
    out[_e554] = u32(_e536.x);
    let _e556 = left;
    let _e557 = right;
    let _e561 = operator_u0026_1(_e557, vec2<i32>(1i, 1i));
    let _e562 = operator_u007c(_e556, _e561);
    let _e564 = local_1;
    local_77 = _e564;
    let _e566 = local_77;
    local_78 = u32(_e566);
    let _e569 = base;
    local_79 = u32((_e569 + 24u));
    let _e575 = local_78;
    let _e576 = local_79;
    local_140 = u32((_e575 + _e576));
    let _e580 = local_140;
    out[_e580] = u32(_e562.y);
    let _e582 = left;
    let _e583 = right;
    let _e584 = operator_u002d_1(_e582, _e583);
    let _e585 = right;
    let _e586 = operator_u002d_1(_e584, _e585);
    let _e588 = local_1;
    local_80 = _e588;
    let _e590 = local_80;
    local_81 = u32(_e590);
    let _e593 = base;
    local_82 = u32((_e593 + 25u));
    let _e599 = local_81;
    let _e600 = local_82;
    local_141 = u32((_e599 + _e600));
    let _e604 = local_141;
    out[_e604] = u32(_e586.x);
    original.value = 9i;
    original.history[0] = 1i;
    original.history[1] = 2i;
    let _e614 = original;
    let _e616 = operator_u002a_3(_e614, 3i);
    scaled = _e616;
    local_86.value = 9i;
    local_86.history[0] = 1i;
    local_86.history[1] = 2i;
    let _e626 = local_86;
    let _e627 = operator_u0026_2(_e626);
    let _e628 = local_1;
    local_83 = _e628;
    let _e630 = local_83;
    local_84 = u32(_e630);
    let _e633 = base;
    local_85 = u32((_e633 + 26u));
    let _e639 = local_84;
    let _e640 = local_85;
    local_142 = u32((_e639 + _e640));
    let _e644 = local_142;
    out[_e644] = u32(_e627);
    let _e646 = original;
    let _e647 = operator_u002a_2(_e646);
    let _e648 = operator_u0026_2(_e647);
    let _e649 = local_1;
    local_87 = _e649;
    let _e651 = local_87;
    local_88 = u32(_e651);
    let _e654 = base;
    local_89 = u32((_e654 + 27u));
    let _e660 = local_88;
    let _e661 = local_89;
    local_143 = u32((_e660 + _e661));
    let _e665 = local_143;
    out[_e665] = u32(_e648);
    let _e668 = scaled.value;
    let _e669 = local_1;
    local_90 = _e669;
    let _e671 = local_90;
    local_91 = u32(_e671);
    let _e674 = base;
    local_92 = u32((_e674 + 28u));
    let _e680 = local_91;
    let _e681 = local_92;
    local_144 = u32((_e680 + _e681));
    let _e685 = local_144;
    out[_e685] = u32(_e668);
    let _e690 = scaled.history[1i];
    let _e691 = local_1;
    local_93 = _e691;
    let _e693 = local_93;
    local_94 = u32(_e693);
    let _e696 = base;
    local_95 = u32((_e696 + 29u));
    let _e702 = local_94;
    let _e703 = local_95;
    local_145 = u32((_e702 + _e703));
    let _e707 = local_145;
    out[_e707] = u32(_e690);
    let _e710 = original.value;
    let _e711 = local_1;
    local_96 = _e711;
    let _e713 = local_96;
    local_97 = u32(_e713);
    let _e716 = base;
    local_98 = u32((_e716 + 30u));
    let _e722 = local_97;
    let _e723 = local_98;
    local_146 = u32((_e722 + _e723));
    let _e727 = local_146;
    out[_e727] = u32(_e710);
    let _e732 = original.history[1i];
    let _e733 = local_1;
    local_99 = _e733;
    let _e735 = local_99;
    local_100 = u32(_e735);
    let _e738 = base;
    local_101 = u32((_e738 + 31u));
    let _e744 = local_100;
    let _e745 = local_101;
    local_147 = u32((_e744 + _e745));
    let _e749 = local_147;
    out[_e749] = u32(_e732);
    let _e751 = original;
    let _e752 = operator_u002d_2(_e751);
    let _e754 = local_1;
    local_102 = _e754;
    let _e756 = local_102;
    local_103 = u32(_e756);
    let _e759 = base;
    local_104 = u32((_e759 + 32u));
    let _e765 = local_103;
    let _e766 = local_104;
    local_148 = u32((_e765 + _e766));
    let _e770 = local_148;
    out[_e770] = u32(_e752.value);
    let _e772 = original;
    let _e774 = operator_u002a_3(_e772, 2i);
    let _e776 = local_1;
    local_105 = _e776;
    let _e778 = local_105;
    local_106 = u32(_e778);
    let _e781 = base;
    local_107 = u32((_e781 + 33u));
    let _e787 = local_106;
    let _e788 = local_107;
    local_149 = u32((_e787 + _e788));
    let _e792 = local_149;
    out[_e792] = u32(_e774.value);
    let _e794 = original;
    let _e795 = operator_u002a_2(_e794);
    let _e796 = operator_u0026_2(_e795);
    let _e797 = local_1;
    local_108 = _e797;
    let _e799 = local_108;
    local_109 = u32(_e799);
    let _e802 = base;
    local_110 = u32((_e802 + 34u));
    let _e808 = local_109;
    let _e809 = local_110;
    local_150 = u32((_e808 + _e809));
    let _e813 = local_150;
    out[_e813] = u32(_e796);
    let _e818 = operator_u0021_(vec2<i32>(0i, 0i));
    let _e819 = local_1;
    local_111 = _e819;
    let _e821 = local_111;
    local_112 = u32(_e821);
    let _e824 = base;
    local_113 = u32((_e824 + 35u));
    let _e830 = local_112;
    let _e831 = local_113;
    local_151 = u32((_e830 + _e831));
    let _e835 = local_151;
    out[_e835] = u32(_e818);
}
