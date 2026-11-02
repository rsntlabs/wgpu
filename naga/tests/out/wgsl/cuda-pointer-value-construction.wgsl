@group(0) @binding(0)
var<storage, read_write> output_1: array<u32>;
var<workgroup> shared_: array<u32, 3>;

fn absent_unsigned_u002a() -> u32 {
    var value_2: array<u32, 2>;
    var local_493: array<u32, 2>;
    var local_494: bool;
    var local_495: u32;
    var local_496: array<u32, 2>;

    value_2 = array<u32, 2>();
    value_2[0] = 1u;
    let _e6 = value_2;
    local_493 = _e6;
    let _e9 = local_493;
    local_496 = _e9;
    let _e11 = local_496[0];
    local_494 = (_e11 != 1u);
    let _e14 = local_494;
    if _e14 {
        local_495 = 37u;
    } else {
        local_495 = 41u;
    }
    let _e20 = local_495;
    return _e20;
}

fn absent_const_u0020_unsigned_u002a() -> u32 {
    var value_3: array<u32, 2>;
    var local_497: array<u32, 2>;
    var local_498: bool;
    var local_499: u32;
    var local_500: array<u32, 2>;

    value_3 = array<u32, 2>();
    value_3[0] = 1u;
    let _e6 = value_3;
    local_497 = _e6;
    let _e9 = local_497;
    local_500 = _e9;
    let _e11 = local_500[0];
    local_498 = (_e11 != 1u);
    let _e14 = local_498;
    if _e14 {
        local_499 = 37u;
    } else {
        local_499 = 41u;
    }
    let _e20 = local_499;
    return _e20;
}

@compute @workgroup_size(1, 1, 1)
fn pointer_value_construction() {
    var output: array<u32, 2>;
    var local: array<u32, 4>;
    var local_1: array<u32, 2>;
    var local_2: u32;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var empty: array<u32, 2>;
    var braced_empty: array<u32, 2>;
    var from_zero: array<u32, 2>;
    var from_braced_zero: array<u32, 2>;
    var qualified_null: array<u32, 2>;
    var cast_null: array<u32, 2>;
    var cursor: array<u32, 2>;
    var local_7: array<u32, 2>;
    var functional: array<u32, 2>;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var braced: array<u32, 2>;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var named: array<u32, 2>;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var c_style: array<u32, 2>;
    var local_14: array<u32, 2>;
    var local_15: array<u32, 2>;
    var local_16: array<u32, 2>;
    var local_17: array<u32, 2>;
    var local_18: array<u32, 2>;
    var local_19: array<u32, 2>;
    var read_functional: array<u32, 2>;
    var local_20: array<u32, 2>;
    var read_braced: array<u32, 2>;
    var local_21: array<u32, 2>;
    var read_named: array<u32, 2>;
    var local_22: array<u32, 2>;
    var read_c_style: array<u32, 2>;
    var local_23: array<u32, 2>;
    var local_24: array<u32, 2>;
    var local_25: array<u32, 2>;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var fixed: array<u32, 2>;
    var local_28: array<u32, 2>;
    var mutable_copy: array<u32, 2>;
    var local_29: array<u32, 2>;
    var local_30: array<u32, 2>;
    var braced_fixed: array<u32, 2>;
    var local_31: array<u32, 2>;
    var local_32: array<u32, 2>;
    var local_33: u32;
    var local_34: array<u32, 2>;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var local_37: u32;
    var local_38: array<u32, 2>;
    var local_39: u32;
    var local_40: array<u32, 2>;
    var local_41: u32;
    var local_42: array<u32, 2>;
    var local_43: u32;
    var counter: u32;
    var index: u32;
    var captured: array<u32, 2>;
    var local_44: array<u32, 2>;
    var local_45: u32;
    var frozen: array<u32, 2>;
    var local_46: array<u32, 2>;
    var selected: array<u32, 2>;
    var guarded_total: u32;
    var branch: u32;
    var local_47: u32;
    var local_48: array<u32, 2>;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: array<u32, 2>;
    var saved: array<u32, 2>;
    var local_55: array<u32, 2>;
    var local_56: bool;
    var local_57: array<u32, 2>;
    var local_58: array<u32, 2>;
    var local_59: array<u32, 2>;
    var local_60: u32;
    var local_61: array<u32, 2>;
    var local_62: bool;
    var local_63: array<u32, 2>;
    var local_64: bool;
    var local_65: array<u32, 2>;
    var local_66: u32;
    var kept: array<u32, 2>;
    var local_67: array<u32, 2>;
    var old_null: array<u32, 2>;
    var local_68: array<u32, 2>;
    var local_69: array<u32, 2>;
    var local_70: bool;
    var local_71: array<u32, 2>;
    var local_72: u32;
    var local_73: array<u32, 2>;
    var local_74: bool;
    var local_75: array<u32, 2>;
    var local_76: array<u32, 2>;
    var local_77: array<u32, 2>;
    var local_78: bool;
    var local_79: array<u32, 2>;
    var local_80: u32;
    var local_81: array<u32, 2>;
    var local_82: u32;
    var local_83: array<u32, 2>;
    var local_84: bool;
    var local_85: array<u32, 2>;
    var local_86: bool;
    var local_87: array<u32, 2>;
    var local_88: bool;
    var local_89: array<u32, 2>;
    var local_90: bool;
    var local_91: array<u32, 2>;
    var local_92: bool;
    var local_93: array<u32, 2>;
    var local_94: bool;
    var local_95: array<u32, 2>;
    var local_96: u32;
    var local_97: array<u32, 2>;
    var local_98: u32;
    var local_99: array<u32, 2>;
    var local_100: u32;
    var local_101: array<u32, 2>;
    var local_102: array<u32, 2>;
    var local_103: u32;
    var local_104: array<u32, 2>;
    var local_105: array<u32, 2>;
    var local_106: u32;
    var local_107: array<u32, 2>;
    var local_108: array<u32, 2>;
    var local_109: u32;
    var local_110: array<u32, 2>;
    var local_111: array<u32, 2>;
    var local_112: u32;
    var local_113: array<u32, 2>;
    var local_114: u32;
    var local_115: array<u32, 2>;
    var local_116: u32;
    var local_117: array<u32, 2>;
    var local_118: array<u32, 2>;
    var local_119: u32;
    var local_120: array<u32, 2>;
    var local_121: array<u32, 2>;
    var local_122: u32;
    var local_123: array<u32, 2>;
    var local_124: u32;
    var local_125: array<u32, 2>;
    var local_126: u32;
    var local_127: array<u32, 2>;
    var local_128: u32;
    var local_129: array<u32, 2>;
    var local_130: u32;
    var local_131: array<u32, 2>;
    var local_132: array<u32, 2>;
    var local_133: u32;
    var local_134: array<u32, 2>;
    var local_135: u32;
    var local_136: array<u32, 2>;
    var local_137: array<u32, 2>;
    var local_138: u32;
    var local_139: array<u32, 2>;
    var local_140: array<u32, 2>;
    var local_141: u32;
    var local_142: array<u32, 2>;
    var local_143: u32;
    var local_144: array<u32, 2>;
    var local_145: u32;
    var local_146: array<u32, 2>;
    var local_147: u32;
    var local_148: array<u32, 2>;
    var local_149: u32;
    var local_150: array<u32, 2>;
    var local_151: bool;
    var local_152: array<u32, 2>;
    var local_153: bool;
    var local_154: array<u32, 2>;
    var local_155: u32;
    var local_156: array<u32, 2>;
    var local_157: u32;
    var local_158: array<u32, 2>;
    var local_159: bool;
    var local_160: array<u32, 2>;
    var local_161: u32;
    var local_162: array<u32, 2>;
    var local_163: u32;
    var local_164: u32;
    var local_165: array<u32, 2>;
    var local_166: u32;
    var local_167: bool;
    var local_168: bool;
    var local_169: array<u32, 2>;
    var local_170: u32;
    var local_171: array<u32, 2>;
    var local_172: u32;
    var local_173: array<u32, 2>;
    var local_174: u32;
    var local_175: array<u32, 2>;
    var local_176: u32;
    var local_177: array<u32, 2>;
    var local_178: u32;
    var local_179: array<u32, 2>;
    var local_180: bool;
    var local_181: array<u32, 2>;
    var local_182: bool;
    var local_183: u32;
    var local_184: u32;
    var local_185: u32;
    var local_186: u32;
    var value: array<u32, 2>;
    var amount: u32;
    var local_187: array<u32, 2>;
    var local_188: bool;
    var local_189: array<u32, 2>;
    var local_190: u32;
    var local_191: u32;
    var value_1: array<u32, 2>;
    var amount_1: u32;
    var local_192: array<u32, 2>;
    var local_193: bool;
    var local_194: array<u32, 2>;
    var local_195: u32;
    var local_196: u32;
    var source: array<u32, 2>;
    var local_197: array<u32, 2>;
    var copy: array<u32, 2>;
    var local_198: array<u32, 2>;
    var local_199: u32;
    var source_1: array<u32, 2>;
    var local_200: array<u32, 2>;
    var copy_1: array<u32, 2>;
    var local_201: array<u32, 2>;
    var local_202: u32;
    var source_2: array<u32, 2>;
    var local_203: array<u32, 2>;
    var copy_2: array<u32, 2>;
    var local_204: array<u32, 2>;
    var local_205: u32;
    var local_206: array<u32, 2>;
    var local_207: u32;
    var local_208: u32;
    var local_209: array<u32, 2>;
    var local_210: u32;
    var local_211: u32;
    var local_212: array<u32, 2>;
    var local_213: u32;
    var local_214: u32;
    var local_215: array<u32, 2>;
    var local_216: array<u32, 2>;
    var local_217: u32;
    var local_218: u32;
    var local_219: u32;
    var local_220: array<u32, 2>;
    var local_221: u32;
    var local_222: u32;
    var local_223: u32;
    var local_224: array<u32, 2>;
    var local_225: u32;
    var local_226: u32;
    var local_227: u32;
    var local_228: array<u32, 2>;
    var local_229: u32;
    var local_230: u32;
    var local_231: u32;
    var local_232: array<u32, 2>;
    var local_233: u32;
    var local_234: u32;
    var local_235: u32;
    var local_236: array<u32, 2>;
    var local_237: u32;
    var local_238: u32;
    var local_239: u32;
    var local_240: array<u32, 2>;
    var local_241: u32;
    var local_242: u32;
    var local_243: u32;
    var local_244: array<u32, 2>;
    var local_245: u32;
    var local_246: u32;
    var local_247: u32;
    var local_248: array<u32, 2>;
    var local_249: u32;
    var local_250: u32;
    var local_251: u32;
    var local_252: array<u32, 2>;
    var local_253: u32;
    var local_254: u32;
    var local_255: array<u32, 2>;
    var local_256: u32;
    var local_257: u32;
    var local_258: array<u32, 2>;
    var local_259: array<u32, 2>;
    var local_260: array<u32, 2>;
    var local_261: u32;
    var local_262: u32;
    var local_263: u32;
    var local_264: array<u32, 2>;
    var local_265: array<u32, 2>;
    var local_266: array<u32, 2>;
    var local_267: u32;
    var local_268: u32;
    var local_269: u32;
    var local_270: array<u32, 2>;
    var local_271: array<u32, 2>;
    var local_272: array<u32, 2>;
    var local_273: u32;
    var local_274: u32;
    var local_275: u32;
    var local_276: array<u32, 2>;
    var local_277: array<u32, 2>;
    var local_278: array<u32, 2>;
    var local_279: u32;
    var local_280: u32;
    var local_281: u32;
    var local_282: array<u32, 2>;
    var local_283: array<u32, 2>;
    var local_284: u32;
    var local_285: u32;
    var local_286: u32;
    var local_287: array<u32, 2>;
    var local_288: u32;
    var local_289: u32;
    var local_290: u32;
    var local_291: array<u32, 2>;
    var local_292: array<u32, 2>;
    var local_293: array<u32, 2>;
    var local_294: array<u32, 2>;
    var local_295: u32;
    var local_296: u32;
    var local_297: u32;
    var local_298: array<u32, 2>;
    var local_299: u32;
    var local_300: u32;
    var local_301: u32;
    var local_302: array<u32, 2>;
    var local_303: array<u32, 2>;
    var local_304: array<u32, 2>;
    var local_305: u32;
    var local_306: u32;
    var local_307: array<u32, 2>;
    var local_308: array<u32, 2>;
    var local_309: array<u32, 2>;
    var local_310: array<u32, 2>;
    var local_311: u32;
    var local_312: u32;
    var local_313: u32;
    var local_314: array<u32, 2>;
    var local_315: array<u32, 2>;
    var local_316: u32;
    var local_317: u32;
    var local_318: u32;
    var local_319: array<u32, 2>;
    var local_320: u32;
    var local_321: u32;
    var local_322: u32;
    var local_323: array<u32, 2>;
    var local_324: array<u32, 2>;
    var local_325: array<u32, 2>;
    var local_326: array<u32, 2>;
    var local_327: u32;
    var local_328: u32;
    var local_329: u32;
    var local_330: array<u32, 2>;
    var local_331: array<u32, 2>;
    var local_332: u32;
    var local_333: u32;
    var local_334: u32;
    var local_335: array<u32, 2>;
    var local_336: array<u32, 2>;
    var local_337: array<u32, 2>;
    var local_338: array<u32, 2>;
    var local_339: array<u32, 2>;
    var local_340: array<u32, 2>;
    var local_341: array<u32, 2>;
    var local_342: u32;
    var local_343: u32;
    var local_344: array<u32, 2>;
    var local_345: u32;
    var local_346: u32;
    var local_347: array<u32, 2>;
    var local_348: u32;
    var local_349: u32;
    var local_350: array<u32, 2>;
    var local_351: u32;
    var local_352: u32;
    var local_353: u32;
    var local_354: array<u32, 2>;
    var local_355: u32;
    var local_356: u32;
    var local_357: array<u32, 2>;
    var local_358: u32;
    var local_359: u32;
    var local_360: u32;
    var local_361: array<u32, 2>;
    var local_362: u32;
    var local_363: u32;
    var local_364: array<u32, 2>;
    var local_365: u32;
    var local_366: u32;
    var local_367: u32;
    var local_368: array<u32, 2>;
    var local_369: u32;
    var local_370: u32;
    var local_371: array<u32, 2>;
    var local_372: u32;
    var local_373: u32;
    var local_374: u32;
    var local_375: array<u32, 2>;
    var local_376: u32;
    var local_377: u32;
    var local_378: array<u32, 2>;
    var local_379: u32;
    var local_380: u32;
    var local_381: array<u32, 2>;
    var local_382: u32;
    var local_383: u32;
    var local_384: array<u32, 2>;
    var local_385: u32;
    var local_386: u32;
    var local_387: array<u32, 2>;
    var local_388: u32;
    var local_389: u32;
    var local_390: array<u32, 2>;
    var local_391: u32;
    var local_392: u32;
    var local_393: array<u32, 2>;
    var local_394: u32;
    var local_395: u32;
    var local_396: array<u32, 2>;
    var local_397: u32;
    var local_398: u32;
    var local_399: array<u32, 2>;
    var local_400: u32;
    var local_401: u32;
    var local_402: array<u32, 2>;
    var local_403: u32;
    var local_404: u32;
    var local_405: array<u32, 2>;
    var local_406: u32;
    var local_407: u32;
    var local_408: array<u32, 2>;
    var local_409: u32;
    var local_410: u32;
    var local_411: u32;
    var local_412: array<u32, 2>;
    var local_413: u32;
    var local_414: u32;
    var local_415: u32;
    var local_416: array<u32, 2>;
    var local_417: u32;
    var local_418: u32;
    var local_419: array<u32, 2>;
    var local_420: u32;
    var local_421: u32;
    var local_422: u32;
    var local_423: array<u32, 2>;
    var local_424: u32;
    var local_425: u32;
    var local_426: array<u32, 2>;
    var local_427: u32;
    var local_428: u32;
    var local_429: array<u32, 2>;
    var local_430: u32;
    var local_431: u32;
    var local_432: array<u32, 2>;
    var local_433: u32;
    var local_434: u32;
    var local_435: array<u32, 2>;
    var local_436: u32;
    var local_437: u32;
    var local_438: array<u32, 2>;
    var local_439: u32;
    var local_440: u32;
    var local_441: array<u32, 2>;
    var local_442: u32;
    var local_443: u32;
    var local_444: array<u32, 2>;
    var local_445: u32;
    var local_446: u32;
    var local_447: array<u32, 2>;
    var local_448: u32;
    var local_449: u32;
    var local_450: array<u32, 2>;
    var local_451: array<u32, 2>;
    var local_452: array<u32, 2>;
    var local_453: u32;
    var local_454: u32;
    var local_455: array<u32, 2>;
    var local_456: u32;
    var local_457: u32;
    var local_458: array<u32, 2>;
    var local_459: array<u32, 2>;
    var local_460: u32;
    var local_461: u32;
    var local_462: array<u32, 2>;
    var local_463: u32;
    var local_464: u32;
    var local_465: array<u32, 2>;
    var local_466: u32;
    var local_467: u32;
    var local_468: array<u32, 2>;
    var local_469: u32;
    var local_470: u32;
    var local_471: array<u32, 2>;
    var local_472: array<u32, 2>;
    var local_473: array<u32, 2>;
    var local_474: u32;
    var local_475: u32;
    var local_476: array<u32, 2>;
    var local_477: u32;
    var local_478: u32;
    var local_479: array<u32, 2>;
    var local_480: u32;
    var local_481: u32;
    var local_482: array<u32, 2>;
    var local_483: u32;
    var local_484: u32;
    var local_485: array<u32, 2>;
    var local_486: u32;
    var local_487: u32;
    var local_488: array<u32, 2>;
    var local_489: array<u32, 2>;
    var local_490: array<u32, 2>;
    var local_491: u32;
    var local_492: u32;

    output = array<u32, 2>();
    output[0] = 2u;
    output[1] = 0u;
    local[0] = 3u;
    local[1] = 5u;
    local[2] = 7u;
    local[3] = 11u;
    shared_[0i] = 13u;
    shared_[1i] = 17u;
    shared_[2i] = 19u;
    let _e26 = output;
    local_1 = _e26;
    local_2 = u32(32i);
    let _e31 = local_1;
    local_206 = _e31;
    let _e33 = local_2;
    let _e35 = local_206[1];
    local_206[1] = (_e35 + _e33);
    let _e39 = local_206[0];
    local_207 = u32(_e39);
    let _e43 = local_206[1];
    local_208 = u32(_e43);
    let _e46 = local_208;
    output_1[_e46] = 23u;
    let _e50 = output;
    local_3 = _e50;
    local_4 = u32(33i);
    let _e55 = local_3;
    local_209 = _e55;
    let _e57 = local_4;
    let _e59 = local_209[1];
    local_209[1] = (_e59 + _e57);
    let _e63 = local_209[0];
    local_210 = u32(_e63);
    let _e67 = local_209[1];
    local_211 = u32(_e67);
    let _e70 = local_211;
    output_1[_e70] = 29u;
    let _e73 = output;
    local_5 = _e73;
    local_6 = u32(34i);
    let _e78 = local_5;
    local_212 = _e78;
    let _e80 = local_6;
    let _e82 = local_212[1];
    local_212[1] = (_e82 + _e80);
    let _e86 = local_212[0];
    local_213 = u32(_e86);
    let _e90 = local_212[1];
    local_214 = u32(_e90);
    let _e93 = local_214;
    output_1[_e93] = 31u;
    empty = array<u32, 2>();
    empty[0] = 1u;
    braced_empty = array<u32, 2>();
    braced_empty[0] = 1u;
    from_zero = array<u32, 2>();
    from_zero[0] = 1u;
    from_braced_zero = array<u32, 2>();
    from_braced_zero[0] = 1u;
    qualified_null = array<u32, 2>();
    qualified_null[0] = 1u;
    cast_null = array<u32, 2>();
    cast_null[0] = 1u;
    cursor = array<u32, 2>();
    cursor[0] = 3u;
    cursor[1] = 0u;
    let _e127 = cursor;
    local_7 = _e127;
    let _e129 = local_7;
    functional = _e129;
    let _e131 = cursor;
    local_8 = _e131;
    local_9 = u32(1i);
    let _e136 = local_8;
    braced = _e136;
    let _e138 = local_9;
    let _e140 = braced[1];
    braced[1] = (_e140 + _e138);
    let _e143 = cursor;
    local_10 = _e143;
    local_11 = u32(2i);
    let _e148 = local_10;
    named = _e148;
    let _e150 = local_11;
    let _e152 = named[1];
    named[1] = (_e152 + _e150);
    let _e155 = cursor;
    local_12 = _e155;
    local_13 = u32(3i);
    let _e160 = local_12;
    c_style = _e160;
    let _e162 = local_13;
    let _e164 = c_style[1];
    c_style[1] = (_e164 + _e162);
    local_215 = array<u32, 2>();
    local_215[0] = 4u;
    local_215[1] = 0u;
    let _e173 = local_215;
    cursor = _e173;
    let _e175 = functional;
    local_14 = _e175;
    let _e177 = local_14;
    local_216 = _e177;
    let _e180 = local_216[0];
    local_217 = u32(_e180);
    let _e184 = local_216[1];
    local_218 = u32(_e184);
    let _e187 = local_217;
    switch _e187 {
        case 4u: {
            let _e188 = local_218;
            let _e190 = shared_[_e188];
            local_219 = _e190;
        }
        case 3u: {
            let _e192 = local_218;
            let _e194 = local[_e192];
            local_219 = _e194;
        }
        default: {
            let _e196 = local_218;
            let _e198 = output_1[_e196];
            local_219 = _e198;
        }
    }
    let _e201 = local_219;
    let _e203 = (_e201 + 2u);
    let _e204 = local_217;
    switch _e204 {
        case 4u: {
            let _e205 = local_218;
            shared_[_e205] = _e203;
        }
        case 3u: {
            let _e207 = local_218;
            local[_e207] = _e203;
        }
        default: {
            let _e209 = local_218;
            output_1[_e209] = _e203;
        }
    }
    let _e212 = braced;
    local_15 = _e212;
    let _e214 = local_15;
    local_220 = _e214;
    let _e217 = local_220[0];
    local_221 = u32(_e217);
    let _e221 = local_220[1];
    local_222 = u32(_e221);
    let _e224 = local_221;
    switch _e224 {
        case 4u: {
            let _e225 = local_222;
            let _e227 = shared_[_e225];
            local_223 = _e227;
        }
        case 3u: {
            let _e229 = local_222;
            let _e231 = local[_e229];
            local_223 = _e231;
        }
        default: {
            let _e233 = local_222;
            let _e235 = output_1[_e233];
            local_223 = _e235;
        }
    }
    let _e238 = local_223;
    let _e240 = (_e238 + 3u);
    let _e241 = local_221;
    switch _e241 {
        case 4u: {
            let _e242 = local_222;
            shared_[_e242] = _e240;
        }
        case 3u: {
            let _e244 = local_222;
            local[_e244] = _e240;
        }
        default: {
            let _e246 = local_222;
            output_1[_e246] = _e240;
        }
    }
    let _e249 = named;
    local_16 = _e249;
    let _e251 = local_16;
    local_224 = _e251;
    let _e254 = local_224[0];
    local_225 = u32(_e254);
    let _e258 = local_224[1];
    local_226 = u32(_e258);
    let _e261 = local_225;
    switch _e261 {
        case 4u: {
            let _e262 = local_226;
            let _e264 = shared_[_e262];
            local_227 = _e264;
        }
        case 3u: {
            let _e266 = local_226;
            let _e268 = local[_e266];
            local_227 = _e268;
        }
        default: {
            let _e270 = local_226;
            let _e272 = output_1[_e270];
            local_227 = _e272;
        }
    }
    let _e275 = local_227;
    let _e277 = (_e275 + 5u);
    let _e278 = local_225;
    switch _e278 {
        case 4u: {
            let _e279 = local_226;
            shared_[_e279] = _e277;
        }
        case 3u: {
            let _e281 = local_226;
            local[_e281] = _e277;
        }
        default: {
            let _e283 = local_226;
            output_1[_e283] = _e277;
        }
    }
    let _e286 = c_style;
    local_17 = _e286;
    let _e288 = local_17;
    local_228 = _e288;
    let _e291 = local_228[0];
    local_229 = u32(_e291);
    let _e295 = local_228[1];
    local_230 = u32(_e295);
    let _e298 = local_229;
    switch _e298 {
        case 4u: {
            let _e299 = local_230;
            let _e301 = shared_[_e299];
            local_231 = _e301;
        }
        case 3u: {
            let _e303 = local_230;
            let _e305 = local[_e303];
            local_231 = _e305;
        }
        default: {
            let _e307 = local_230;
            let _e309 = output_1[_e307];
            local_231 = _e309;
        }
    }
    let _e312 = local_231;
    let _e314 = (_e312 + 7u);
    let _e315 = local_229;
    switch _e315 {
        case 4u: {
            let _e316 = local_230;
            shared_[_e316] = _e314;
        }
        case 3u: {
            let _e318 = local_230;
            local[_e318] = _e314;
        }
        default: {
            let _e320 = local_230;
            output_1[_e320] = _e314;
        }
    }
    let _e322 = functional;
    local_18 = _e322;
    let _e324 = local_18;
    local_232 = _e324;
    let _e327 = local_232[0];
    local_233 = u32(_e327);
    let _e331 = local_232[1];
    local_234 = u32(_e331);
    let _e334 = local_233;
    switch _e334 {
        case 4u: {
            let _e335 = local_234;
            let _e337 = shared_[_e335];
            local_235 = _e337;
        }
        case 3u: {
            let _e339 = local_234;
            let _e341 = local[_e339];
            local_235 = _e341;
        }
        default: {
            let _e343 = local_234;
            let _e345 = output_1[_e343];
            local_235 = _e345;
        }
    }
    let first_copy = local_235;
    let _e349 = functional;
    local_19 = _e349;
    let _e351 = local_19;
    read_functional = _e351;
    let _e353 = braced;
    local_20 = _e353;
    let _e355 = local_20;
    read_braced = _e355;
    let _e357 = named;
    local_21 = _e357;
    let _e359 = local_21;
    read_named = _e359;
    let _e361 = c_style;
    local_22 = _e361;
    let _e363 = local_22;
    read_c_style = _e363;
    let _e366 = read_functional;
    local_23 = _e366;
    let _e369 = read_braced;
    local_24 = _e369;
    let _e371 = local_23;
    local_236 = _e371;
    let _e374 = local_236[0];
    local_237 = u32(_e374);
    let _e378 = local_236[1];
    local_238 = u32(_e378);
    let _e381 = local_237;
    switch _e381 {
        case 4u: {
            let _e382 = local_238;
            let _e384 = shared_[_e382];
            local_239 = _e384;
        }
        case 3u: {
            let _e386 = local_238;
            let _e388 = local[_e386];
            local_239 = _e388;
        }
        default: {
            let _e390 = local_238;
            let _e392 = output_1[_e390];
            local_239 = _e392;
        }
    }
    let _e395 = local_239;
    let _e396 = local_24;
    local_240 = _e396;
    let _e399 = local_240[0];
    local_241 = u32(_e399);
    let _e403 = local_240[1];
    local_242 = u32(_e403);
    let _e406 = local_241;
    switch _e406 {
        case 4u: {
            let _e407 = local_242;
            let _e409 = shared_[_e407];
            local_243 = _e409;
        }
        case 3u: {
            let _e411 = local_242;
            let _e413 = local[_e411];
            local_243 = _e413;
        }
        default: {
            let _e415 = local_242;
            let _e417 = output_1[_e415];
            local_243 = _e417;
        }
    }
    let _e420 = local_243;
    let _e423 = read_named;
    local_25 = _e423;
    let _e425 = local_25;
    local_244 = _e425;
    let _e428 = local_244[0];
    local_245 = u32(_e428);
    let _e432 = local_244[1];
    local_246 = u32(_e432);
    let _e435 = local_245;
    switch _e435 {
        case 4u: {
            let _e436 = local_246;
            let _e438 = shared_[_e436];
            local_247 = _e438;
        }
        case 3u: {
            let _e440 = local_246;
            let _e442 = local[_e440];
            local_247 = _e442;
        }
        default: {
            let _e444 = local_246;
            let _e446 = output_1[_e444];
            local_247 = _e446;
        }
    }
    let _e449 = local_247;
    let _e452 = read_c_style;
    local_26 = _e452;
    let _e454 = local_26;
    local_248 = _e454;
    let _e457 = local_248[0];
    local_249 = u32(_e457);
    let _e461 = local_248[1];
    local_250 = u32(_e461);
    let _e464 = local_249;
    switch _e464 {
        case 4u: {
            let _e465 = local_250;
            let _e467 = shared_[_e465];
            local_251 = _e467;
        }
        case 3u: {
            let _e469 = local_250;
            let _e471 = local[_e469];
            local_251 = _e471;
        }
        default: {
            let _e473 = local_250;
            let _e475 = output_1[_e473];
            local_251 = _e475;
        }
    }
    let _e478 = local_251;
    let qualified_sum = (((_e395 + _e420) + _e449) + _e478);
    local_27 = u32(1i);
    fixed = array<u32, 2>();
    fixed[0] = 4u;
    fixed[1] = 0u;
    let _e489 = local_27;
    let _e491 = fixed[1];
    fixed[1] = (_e491 + _e489);
    let _e495 = fixed;
    local_28 = _e495;
    let _e497 = local_28;
    mutable_copy = _e497;
    let _e501 = mutable_copy[1];
    mutable_copy[1] = (_e501 + 1u);
    let _e505 = mutable_copy;
    local_29 = _e505;
    let _e507 = local_29;
    local_252 = _e507;
    let _e510 = local_252[0];
    local_253 = u32(_e510);
    let _e514 = local_252[1];
    local_254 = u32(_e514);
    let _e517 = local_254;
    let _e519 = shared_[_e517];
    let _e522 = local_254;
    shared_[_e522] = (_e519 + 11u);
    let _e524 = fixed;
    local_30 = _e524;
    let _e526 = local_30;
    braced_fixed = _e526;
    let _e530 = braced_fixed[1];
    braced_fixed[1] = (_e530 + 1u);
    let _e534 = fixed;
    local_31 = _e534;
    let _e536 = local_31;
    local_255 = _e536;
    let _e539 = local_255[0];
    local_256 = u32(_e539);
    let _e543 = local_255[1];
    local_257 = u32(_e543);
    let _e546 = local_257;
    let fixed_snapshot = shared_[_e546];
    local_258 = array<u32, 2>();
    local_258[0] = 3u;
    local_258[1] = 0u;
    let _e555 = local_258;
    cursor = _e555;
    let _e556 = cursor;
    local_32 = _e556;
    local_259 = array<u32, 2>();
    local_259[0] = 4u;
    local_259[1] = 0u;
    let _e564 = local_259;
    cursor = _e564;
    local_33 = u32(1u);
    let _e568 = local_32;
    local_260 = _e568;
    let _e570 = local_33;
    let _e572 = local_260[1];
    local_260[1] = (_e572 + _e570);
    let _e576 = local_260[0];
    local_261 = u32(_e576);
    let _e580 = local_260[1];
    local_262 = u32(_e580);
    let _e583 = local_261;
    switch _e583 {
        case 4u: {
            let _e584 = local_262;
            let _e586 = shared_[_e584];
            local_263 = _e586;
        }
        case 3u: {
            let _e588 = local_262;
            let _e590 = local[_e588];
            local_263 = _e590;
        }
        default: {
            let _e592 = local_262;
            let _e594 = output_1[_e592];
            local_263 = _e594;
        }
    }
    let functional_snapshot = local_263;
    local_264 = array<u32, 2>();
    local_264[0] = 4u;
    local_264[1] = 0u;
    let _e604 = local_264;
    cursor = _e604;
    let _e605 = cursor;
    local_34 = _e605;
    let _e607 = output;
    local_35 = _e607;
    local_36 = u32(32i);
    let _e612 = local_35;
    local_265 = _e612;
    let _e614 = local_36;
    let _e616 = local_265[1];
    local_265[1] = (_e616 + _e614);
    let _e619 = local_265;
    cursor = _e619;
    local_37 = u32(2u);
    let _e623 = local_34;
    local_266 = _e623;
    let _e625 = local_37;
    let _e627 = local_266[1];
    local_266[1] = (_e627 + _e625);
    let _e631 = local_266[0];
    local_267 = u32(_e631);
    let _e635 = local_266[1];
    local_268 = u32(_e635);
    let _e638 = local_267;
    switch _e638 {
        case 4u: {
            let _e639 = local_268;
            let _e641 = shared_[_e639];
            local_269 = _e641;
        }
        case 3u: {
            let _e643 = local_268;
            let _e645 = local[_e643];
            local_269 = _e645;
        }
        default: {
            let _e647 = local_268;
            let _e649 = output_1[_e647];
            local_269 = _e649;
        }
    }
    let braced_snapshot = local_269;
    let _e653 = output;
    local_38 = _e653;
    local_39 = u32(32i);
    let _e658 = local_38;
    local_270 = _e658;
    let _e660 = local_39;
    let _e662 = local_270[1];
    local_270[1] = (_e662 + _e660);
    let _e665 = local_270;
    cursor = _e665;
    let _e666 = cursor;
    local_40 = _e666;
    local_271 = array<u32, 2>();
    local_271[0] = 3u;
    local_271[1] = 0u;
    let _e674 = local_271;
    cursor = _e674;
    local_41 = u32(1u);
    let _e678 = local_40;
    local_272 = _e678;
    let _e680 = local_41;
    let _e682 = local_272[1];
    local_272[1] = (_e682 + _e680);
    let _e686 = local_272[0];
    local_273 = u32(_e686);
    let _e690 = local_272[1];
    local_274 = u32(_e690);
    let _e693 = local_273;
    switch _e693 {
        case 4u: {
            let _e694 = local_274;
            let _e696 = shared_[_e694];
            local_275 = _e696;
        }
        case 3u: {
            let _e698 = local_274;
            let _e700 = local[_e698];
            local_275 = _e700;
        }
        default: {
            let _e702 = local_274;
            let _e704 = output_1[_e702];
            local_275 = _e704;
        }
    }
    let named_snapshot = local_275;
    local_276 = array<u32, 2>();
    local_276[0] = 3u;
    local_276[1] = 0u;
    let _e714 = local_276;
    cursor = _e714;
    let _e715 = cursor;
    local_42 = _e715;
    local_277 = array<u32, 2>();
    local_277[0] = 4u;
    local_277[1] = 0u;
    let _e723 = local_277;
    cursor = _e723;
    local_43 = u32(0u);
    let _e727 = local_42;
    local_278 = _e727;
    let _e729 = local_43;
    let _e731 = local_278[1];
    local_278[1] = (_e731 + _e729);
    let _e735 = local_278[0];
    local_279 = u32(_e735);
    let _e739 = local_278[1];
    local_280 = u32(_e739);
    let _e742 = local_279;
    switch _e742 {
        case 4u: {
            let _e743 = local_280;
            let _e745 = shared_[_e743];
            local_281 = _e745;
        }
        case 3u: {
            let _e747 = local_280;
            let _e749 = local[_e747];
            local_281 = _e749;
        }
        default: {
            let _e751 = local_280;
            let _e753 = output_1[_e751];
            local_281 = _e753;
        }
    }
    let c_style_snapshot = local_281;
    counter = 0u;
    index = 0u;
    let _e761 = counter;
    counter = (_e761 + u32(1i));
    let _e765 = index;
    index = (_e765 + u32(1i));
    captured = array<u32, 2>();
    captured[0] = 3u;
    captured[1] = 0u;
    let _e776 = captured[1];
    captured[1] = (_e776 + _e765);
    let _e780 = captured;
    local_44 = _e780;
    local_45 = u32(1i);
    local_282 = array<u32, 2>();
    local_282[0] = 4u;
    local_282[1] = 0u;
    let _e791 = local_45;
    let _e793 = local_282[1];
    local_282[1] = (_e793 + _e791);
    let _e796 = local_282;
    captured = _e796;
    index = 3u;
    let _e798 = local_44;
    local_283 = _e798;
    let _e801 = local_283[0];
    local_284 = u32(_e801);
    let _e805 = local_283[1];
    local_285 = u32(_e805);
    let _e808 = local_284;
    switch _e808 {
        case 3u: {
            let _e809 = local_285;
            let _e811 = local[_e809];
            local_286 = _e811;
        }
        default: {
            let _e813 = local_285;
            let _e815 = shared_[_e813];
            local_286 = _e815;
        }
    }
    let _e818 = local_286;
    let _e820 = (_e818 + 13u);
    let _e821 = local_284;
    switch _e821 {
        case 3u: {
            let _e822 = local_285;
            local[_e822] = _e820;
        }
        default: {
            let _e824 = local_285;
            shared_[_e824] = _e820;
        }
    }
    let _e826 = counter;
    counter = (_e826 + u32(1i));
    let _e830 = index;
    index = (_e830 - u32(1i));
    frozen = array<u32, 2>();
    frozen[0] = 3u;
    frozen[1] = 0u;
    let _e841 = frozen[1];
    frozen[1] = (_e841 + _e830);
    index = 0u;
    let _e845 = functional;
    local_46 = _e845;
    let _e847 = local_46;
    local_287 = _e847;
    let _e850 = local_287[0];
    local_288 = u32(_e850);
    let _e854 = local_287[1];
    local_289 = u32(_e854);
    let _e857 = local_288;
    switch _e857 {
        case 4u: {
            let _e858 = local_289;
            let _e860 = shared_[_e858];
            local_290 = _e860;
        }
        case 3u: {
            let _e862 = local_289;
            let _e864 = local[_e862];
            local_290 = _e864;
        }
        default: {
            let _e866 = local_289;
            let _e868 = output_1[_e866];
            local_290 = _e868;
        }
    }
    let _e871 = local_290;
    let _e873 = (_e871 + 2u);
    let _e874 = local_288;
    switch _e874 {
        case 4u: {
            let _e875 = local_289;
            shared_[_e875] = _e873;
        }
        case 3u: {
            let _e877 = local_289;
            local[_e877] = _e873;
        }
        default: {
            let _e879 = local_289;
            output_1[_e879] = _e873;
        }
    }
    let after_capture = counter;
    selected = array<u32, 2>();
    selected[0] = 1u;
    guarded_total = 0u;
    {
        branch = 0u;
        loop {
            let _e890 = branch;
            if (_e890 < 3u) {
            } else {
                break;
            }
            let _e893 = branch;
            if (_e893 == 0u) {
                local_53 = 0u;
                local_52 = 1u;
            } else {
                let _e900 = branch;
                if (_e900 == 1u) {
                    local_47 = u32(1i);
                    local_51 = 0u;
                    local_50 = 1u;
                } else {
                    let _e910 = output;
                    local_48 = _e910;
                    local_49 = u32(32i);
                    local_51 = 0u;
                    local_50 = 0u;
                }
                let _e920 = local_51;
                local_53 = _e920;
                local_52 = 0u;
            }
            let _e925 = local_52;
            if (_e925 != 0u) {
                local_291 = array<u32, 2>();
                local_291[0] = 1u;
            } else {
                let _e933 = local_50;
                if (_e933 != 0u) {
                    local_291 = array<u32, 2>();
                    local_291[0] = 4u;
                    local_291[1] = 0u;
                    let _e943 = local_47;
                    let _e945 = local_291[1];
                    local_291[1] = (_e945 + _e943);
                } else {
                    let _e949 = local_48;
                    local_291 = _e949;
                    let _e952 = local_49;
                    let _e954 = local_291[1];
                    local_291[1] = (_e954 + _e952);
                }
            }
            let _e958 = local_53;
            let _e961 = local_291[1];
            local_291[1] = (_e961 + _e958);
            let _e964 = local_291;
            selected = _e964;
            let _e966 = selected;
            local_54 = _e966;
            let _e968 = local_54;
            saved = _e968;
            local_292 = array<u32, 2>();
            local_292[0] = 1u;
            let _e974 = local_292;
            selected = _e974;
            let _e976 = saved;
            local_55 = _e976;
            let _e978 = local_55;
            local_293 = _e978;
            let _e981 = local_293[0];
            local_56 = (_e981 != 1u);
            let _e985 = local_56;
            if _e985 {
                let _e986 = branch;
                let _e987 = saved;
                local_57 = _e987;
                let _e989 = local_57;
                local_294 = _e989;
                let _e992 = local_294[0];
                local_295 = u32(_e992);
                let _e996 = local_294[1];
                local_296 = u32(_e996);
                local_297 = u32();
                let _e1001 = local_295;
                switch _e1001 {
                    case 4u: {
                        let _e1002 = local_296;
                        let _e1004 = shared_[_e1002];
                        local_297 = _e1004;
                    }
                    case 2u: {
                        let _e1005 = local_296;
                        let _e1007 = output_1[_e1005];
                        local_297 = _e1007;
                    }
                    default: {
                    }
                }
                let _e1008 = local_297;
                local_183 = _e1008;
                let _e1010 = local_183;
                let _e1011 = (_e1010 + _e986);
                let _e1012 = local_295;
                switch _e1012 {
                    case 4u: {
                        let _e1013 = local_296;
                        shared_[_e1013] = _e1011;
                    }
                    case 2u: {
                        let _e1015 = local_296;
                        output_1[_e1015] = _e1011;
                    }
                    default: {
                    }
                }
                let _e1017 = saved;
                local_58 = _e1017;
                let _e1019 = local_58;
                local_298 = _e1019;
                let _e1022 = local_298[0];
                local_299 = u32(_e1022);
                let _e1026 = local_298[1];
                local_300 = u32(_e1026);
                local_301 = u32();
                let _e1031 = local_299;
                switch _e1031 {
                    case 4u: {
                        let _e1032 = local_300;
                        let _e1034 = shared_[_e1032];
                        local_301 = _e1034;
                    }
                    case 2u: {
                        let _e1035 = local_300;
                        let _e1037 = output_1[_e1035];
                        local_301 = _e1037;
                    }
                    default: {
                    }
                }
                let _e1038 = local_301;
                local_184 = _e1038;
                let _e1040 = local_184;
                let _e1041 = guarded_total;
                guarded_total = (_e1041 + _e1040);
            }
            let _e1043 = selected;
            local_61 = _e1043;
            let _e1045 = local_61;
            local_302 = _e1045;
            let _e1048 = local_302[0];
            local_62 = (_e1048 != 1u);
            let _e1052 = local_62;
            let _e1055 = saved;
            local_63 = _e1055;
            let _e1057 = local_63;
            local_303 = _e1057;
            let _e1060 = local_303[0];
            local_64 = (_e1060 != 1u);
            let _e1064 = local_64;
            let _e1069 = output;
            local_59 = _e1069;
            let _e1071 = branch;
            local_60 = u32((22u + _e1071));
            let _e1076 = local_59;
            local_304 = _e1076;
            let _e1078 = local_60;
            let _e1080 = local_304[1];
            local_304[1] = (_e1080 + _e1078);
            let _e1084 = local_304[0];
            local_305 = u32(_e1084);
            let _e1088 = local_304[1];
            local_306 = u32(_e1088);
            let _e1091 = local_306;
            output_1[_e1091] = (u32(!(_e1052)) + (2u * u32(_e1064)));
            continuing {
                let _e1093 = branch;
                branch = (_e1093 + u32(1i));
            }
        }
    }
    let _e1097 = output;
    local_65 = _e1097;
    local_66 = u32(33i);
    let _e1102 = local_65;
    kept = _e1102;
    let _e1104 = local_66;
    let _e1106 = kept[1];
    kept[1] = (_e1106 + _e1104);
    let _e1110 = selected;
    local_67 = _e1110;
    let _e1112 = local_67;
    old_null = _e1112;
    let _e1115 = kept;
    local_68 = _e1115;
    let _e1117 = local_68;
    local_307 = _e1117;
    let _e1119 = local_307;
    selected = _e1119;
    local_308 = array<u32, 2>();
    local_308[0] = 1u;
    let _e1124 = local_308;
    kept = _e1124;
    let _e1126 = old_null;
    local_69 = _e1126;
    let _e1128 = local_69;
    local_309 = _e1128;
    let _e1131 = local_309[0];
    local_70 = (_e1131 != 1u);
    let _e1135 = local_70;
    if _e1135 {
        let _e1136 = output;
        local_71 = _e1136;
        local_72 = u32(34i);
        let _e1141 = local_71;
        local_310 = _e1141;
        let _e1143 = local_72;
        let _e1145 = local_310[1];
        local_310[1] = (_e1145 + _e1143);
        let _e1149 = local_310[0];
        local_311 = u32(_e1149);
        let _e1153 = local_310[1];
        local_312 = u32(_e1153);
        let _e1156 = local_312;
        let _e1158 = output_1[_e1156];
        local_313 = _e1158;
        let _e1160 = local_313;
        local_185 = _e1160;
        let _e1162 = local_185;
        let _e1165 = local_312;
        output_1[_e1165] = (_e1162 + 1000u);
    }
    let _e1167 = selected;
    local_73 = _e1167;
    let _e1169 = local_73;
    local_314 = _e1169;
    let _e1172 = local_314[0];
    local_74 = (_e1172 != 1u);
    let _e1176 = local_74;
    if _e1176 {
        let _e1177 = selected;
        local_75 = _e1177;
        let _e1179 = local_75;
        local_315 = _e1179;
        let _e1182 = local_315[0];
        local_316 = u32(_e1182);
        let _e1186 = local_315[1];
        local_317 = u32(_e1186);
        local_318 = u32();
        let _e1191 = local_316;
        switch _e1191 {
            case 4u: {
                let _e1192 = local_317;
                let _e1194 = shared_[_e1192];
                local_318 = _e1194;
            }
            case 2u: {
                let _e1195 = local_317;
                let _e1197 = output_1[_e1195];
                local_318 = _e1197;
            }
            default: {
            }
        }
        let _e1198 = local_318;
        local_186 = _e1198;
        let _e1200 = local_186;
        let _e1202 = (_e1200 + 5u);
        let _e1203 = local_316;
        switch _e1203 {
            case 4u: {
                let _e1204 = local_317;
                shared_[_e1204] = _e1202;
            }
            case 2u: {
                let _e1206 = local_317;
                output_1[_e1206] = _e1202;
            }
            default: {
            }
        }
    }
    let _e1208 = selected;
    local_76 = _e1208;
    let _e1210 = local_76;
    local_319 = _e1210;
    let _e1213 = local_319[0];
    local_320 = u32(_e1213);
    let _e1217 = local_319[1];
    local_321 = u32(_e1217);
    local_322 = u32();
    let _e1222 = local_320;
    switch _e1222 {
        case 4u: {
            let _e1223 = local_321;
            let _e1225 = shared_[_e1223];
            local_322 = _e1225;
        }
        case 2u: {
            let _e1226 = local_321;
            let _e1228 = output_1[_e1226];
            local_322 = _e1228;
        }
        default: {
        }
    }
    let selected_snapshot = local_322;
    let _e1230 = selected;
    local_77 = _e1230;
    let _e1232 = local_77;
    local_323 = _e1232;
    let _e1235 = local_323[0];
    local_78 = (_e1235 != 1u);
    let _e1239 = local_78;
    local_324 = array<u32, 2>();
    local_324[0] = 1u;
    let _e1244 = local_324;
    selected = _e1244;
    let _e1245 = counter;
    counter = (_e1245 + u32(1i));
    let _e1249 = output;
    local_79 = _e1249;
    local_80 = u32(34i);
    amount = u32();
    local_188 = bool();
    local_190 = u32();
    let _e1260 = local_79;
    value = _e1260;
    let _e1262 = local_80;
    let _e1264 = value[1];
    value[1] = (_e1264 + _e1262);
    amount = 7u;
    let _e1269 = counter;
    counter = (_e1269 + u32(1i));
    let _e1274 = value;
    local_187 = _e1274;
    let _e1276 = local_187;
    local_325 = _e1276;
    let _e1279 = local_325[0];
    local_188 = (_e1279 != 1u);
    let _e1283 = local_188;
    if _e1283 {
        let _e1284 = amount;
        let _e1285 = value;
        local_189 = _e1285;
        let _e1287 = local_189;
        local_326 = _e1287;
        let _e1290 = local_326[0];
        local_327 = u32(_e1290);
        let _e1294 = local_326[1];
        local_328 = u32(_e1294);
        let _e1297 = local_328;
        let _e1299 = output_1[_e1297];
        local_329 = _e1299;
        let _e1301 = local_329;
        local_191 = _e1301;
        let _e1303 = local_191;
        local_190 = _e1303;
        let _e1305 = local_190;
        let _e1307 = local_328;
        output_1[_e1307] = (_e1305 + _e1284);
    }
    amount_1 = u32();
    local_193 = bool();
    local_195 = u32();
    value_1 = array<u32, 2>();
    value_1[0] = 1u;
    amount_1 = 1000u;
    let _e1321 = counter;
    counter = (_e1321 + u32(1i));
    let _e1326 = value_1;
    local_192 = _e1326;
    let _e1328 = local_192;
    local_330 = _e1328;
    let _e1331 = local_330[0];
    local_193 = (_e1331 != 1u);
    let _e1335 = local_193;
    if _e1335 {
        let _e1336 = value_1;
        local_194 = _e1336;
        let _e1338 = local_194;
        local_331 = _e1338;
        let _e1341 = local_331[0];
        local_332 = u32(_e1341);
        let _e1345 = local_331[1];
        local_333 = u32(_e1345);
        local_334 = u32();
        let _e1350 = local_334;
        local_196 = _e1350;
        let _e1352 = local_196;
        local_195 = _e1352;
    }
    let _e1355 = empty;
    local_83 = _e1355;
    let _e1357 = local_83;
    local_335 = _e1357;
    let _e1360 = local_335[0];
    local_84 = (_e1360 != 1u);
    let _e1364 = local_84;
    let _e1368 = braced_empty;
    local_85 = _e1368;
    let _e1370 = local_85;
    local_336 = _e1370;
    let _e1373 = local_336[0];
    local_86 = (_e1373 != 1u);
    let _e1377 = local_86;
    let _e1382 = from_zero;
    local_87 = _e1382;
    let _e1384 = local_87;
    local_337 = _e1384;
    let _e1387 = local_337[0];
    local_88 = (_e1387 != 1u);
    let _e1391 = local_88;
    let _e1396 = from_braced_zero;
    local_89 = _e1396;
    let _e1398 = local_89;
    local_338 = _e1398;
    let _e1401 = local_338[0];
    local_90 = (_e1401 != 1u);
    let _e1405 = local_90;
    let _e1410 = qualified_null;
    local_91 = _e1410;
    let _e1412 = local_91;
    local_339 = _e1412;
    let _e1415 = local_339[0];
    local_92 = (_e1415 != 1u);
    let _e1419 = local_92;
    let _e1424 = cast_null;
    local_93 = _e1424;
    let _e1426 = local_93;
    local_340 = _e1426;
    let _e1429 = local_340[0];
    local_94 = (_e1429 != 1u);
    let _e1433 = local_94;
    let _e1437 = output;
    local_81 = _e1437;
    local_82 = u32(0i);
    let _e1442 = local_81;
    local_341 = _e1442;
    let _e1444 = local_82;
    let _e1446 = local_341[1];
    local_341[1] = (_e1446 + _e1444);
    let _e1450 = local_341[0];
    local_342 = u32(_e1450);
    let _e1454 = local_341[1];
    local_343 = u32(_e1454);
    let _e1457 = local_343;
    output_1[_e1457] = (((((u32(!(_e1364)) + u32(!(_e1377))) + u32(!(_e1391))) + u32(!(_e1405))) + u32(!(_e1419))) + u32(!(_e1433)));
    let _e1459 = absent_unsigned_u002a();
    let _e1460 = absent_const_u0020_unsigned_u002a();
    let _e1462 = output;
    local_95 = _e1462;
    local_96 = u32(1i);
    let _e1467 = local_95;
    local_344 = _e1467;
    let _e1469 = local_96;
    let _e1471 = local_344[1];
    local_344[1] = (_e1471 + _e1469);
    let _e1475 = local_344[0];
    local_345 = u32(_e1475);
    let _e1479 = local_344[1];
    local_346 = u32(_e1479);
    let _e1482 = local_346;
    output_1[_e1482] = (_e1459 + _e1460);
    let _e1484 = output;
    local_97 = _e1484;
    local_98 = u32(2i);
    let _e1489 = local_97;
    local_347 = _e1489;
    let _e1491 = local_98;
    let _e1493 = local_347[1];
    local_347[1] = (_e1493 + _e1491);
    let _e1497 = local_347[0];
    local_348 = u32(_e1497);
    let _e1501 = local_347[1];
    local_349 = u32(_e1501);
    let _e1504 = local_349;
    output_1[_e1504] = first_copy;
    let _e1506 = braced;
    local_101 = _e1506;
    let _e1508 = local_101;
    local_350 = _e1508;
    let _e1511 = local_350[0];
    local_351 = u32(_e1511);
    let _e1515 = local_350[1];
    local_352 = u32(_e1515);
    let _e1518 = local_351;
    switch _e1518 {
        case 4u: {
            let _e1519 = local_352;
            let _e1521 = shared_[_e1519];
            local_353 = _e1521;
        }
        case 3u: {
            let _e1523 = local_352;
            let _e1525 = local[_e1523];
            local_353 = _e1525;
        }
        default: {
            let _e1527 = local_352;
            let _e1529 = output_1[_e1527];
            local_353 = _e1529;
        }
    }
    let _e1532 = local_353;
    let _e1533 = output;
    local_99 = _e1533;
    local_100 = u32(3i);
    let _e1538 = local_99;
    local_354 = _e1538;
    let _e1540 = local_100;
    let _e1542 = local_354[1];
    local_354[1] = (_e1542 + _e1540);
    let _e1546 = local_354[0];
    local_355 = u32(_e1546);
    let _e1550 = local_354[1];
    local_356 = u32(_e1550);
    let _e1553 = local_356;
    output_1[_e1553] = _e1532;
    let _e1555 = named;
    local_104 = _e1555;
    let _e1557 = local_104;
    local_357 = _e1557;
    let _e1560 = local_357[0];
    local_358 = u32(_e1560);
    let _e1564 = local_357[1];
    local_359 = u32(_e1564);
    let _e1567 = local_358;
    switch _e1567 {
        case 4u: {
            let _e1568 = local_359;
            let _e1570 = shared_[_e1568];
            local_360 = _e1570;
        }
        case 3u: {
            let _e1572 = local_359;
            let _e1574 = local[_e1572];
            local_360 = _e1574;
        }
        default: {
            let _e1576 = local_359;
            let _e1578 = output_1[_e1576];
            local_360 = _e1578;
        }
    }
    let _e1581 = local_360;
    let _e1582 = output;
    local_102 = _e1582;
    local_103 = u32(4i);
    let _e1587 = local_102;
    local_361 = _e1587;
    let _e1589 = local_103;
    let _e1591 = local_361[1];
    local_361[1] = (_e1591 + _e1589);
    let _e1595 = local_361[0];
    local_362 = u32(_e1595);
    let _e1599 = local_361[1];
    local_363 = u32(_e1599);
    let _e1602 = local_363;
    output_1[_e1602] = _e1581;
    let _e1604 = c_style;
    local_107 = _e1604;
    let _e1606 = local_107;
    local_364 = _e1606;
    let _e1609 = local_364[0];
    local_365 = u32(_e1609);
    let _e1613 = local_364[1];
    local_366 = u32(_e1613);
    let _e1616 = local_365;
    switch _e1616 {
        case 4u: {
            let _e1617 = local_366;
            let _e1619 = shared_[_e1617];
            local_367 = _e1619;
        }
        case 3u: {
            let _e1621 = local_366;
            let _e1623 = local[_e1621];
            local_367 = _e1623;
        }
        default: {
            let _e1625 = local_366;
            let _e1627 = output_1[_e1625];
            local_367 = _e1627;
        }
    }
    let _e1630 = local_367;
    let _e1631 = output;
    local_105 = _e1631;
    local_106 = u32(5i);
    let _e1636 = local_105;
    local_368 = _e1636;
    let _e1638 = local_106;
    let _e1640 = local_368[1];
    local_368[1] = (_e1640 + _e1638);
    let _e1644 = local_368[0];
    local_369 = u32(_e1644);
    let _e1648 = local_368[1];
    local_370 = u32(_e1648);
    let _e1651 = local_370;
    output_1[_e1651] = _e1630;
    let _e1653 = cursor;
    local_110 = _e1653;
    let _e1655 = local_110;
    local_371 = _e1655;
    let _e1658 = local_371[0];
    local_372 = u32(_e1658);
    let _e1662 = local_371[1];
    local_373 = u32(_e1662);
    let _e1665 = local_372;
    switch _e1665 {
        case 4u: {
            let _e1666 = local_373;
            let _e1668 = shared_[_e1666];
            local_374 = _e1668;
        }
        case 3u: {
            let _e1670 = local_373;
            let _e1672 = local[_e1670];
            local_374 = _e1672;
        }
        default: {
            let _e1674 = local_373;
            let _e1676 = output_1[_e1674];
            local_374 = _e1676;
        }
    }
    let _e1679 = local_374;
    let _e1680 = output;
    local_108 = _e1680;
    local_109 = u32(6i);
    let _e1685 = local_108;
    local_375 = _e1685;
    let _e1687 = local_109;
    let _e1689 = local_375[1];
    local_375[1] = (_e1689 + _e1687);
    let _e1693 = local_375[0];
    local_376 = u32(_e1693);
    let _e1697 = local_375[1];
    local_377 = u32(_e1697);
    let _e1700 = local_377;
    output_1[_e1700] = _e1679;
    let _e1702 = output;
    local_111 = _e1702;
    local_112 = u32(7i);
    let _e1707 = local_111;
    local_378 = _e1707;
    let _e1709 = local_112;
    let _e1711 = local_378[1];
    local_378[1] = (_e1711 + _e1709);
    let _e1715 = local_378[0];
    local_379 = u32(_e1715);
    let _e1719 = local_378[1];
    local_380 = u32(_e1719);
    let _e1722 = local_380;
    output_1[_e1722] = qualified_sum;
    let _e1724 = output;
    local_113 = _e1724;
    local_114 = u32(8i);
    let _e1729 = local_113;
    local_381 = _e1729;
    let _e1731 = local_114;
    let _e1733 = local_381[1];
    local_381[1] = (_e1733 + _e1731);
    let _e1737 = local_381[0];
    local_382 = u32(_e1737);
    let _e1741 = local_381[1];
    local_383 = u32(_e1741);
    let _e1744 = local_383;
    output_1[_e1744] = fixed_snapshot;
    let _e1746 = mutable_copy;
    local_117 = _e1746;
    let _e1748 = local_117;
    local_384 = _e1748;
    let _e1751 = local_384[0];
    local_385 = u32(_e1751);
    let _e1755 = local_384[1];
    local_386 = u32(_e1755);
    let _e1758 = local_386;
    let _e1760 = shared_[_e1758];
    let _e1761 = output;
    local_115 = _e1761;
    local_116 = u32(9i);
    let _e1766 = local_115;
    local_387 = _e1766;
    let _e1768 = local_116;
    let _e1770 = local_387[1];
    local_387[1] = (_e1770 + _e1768);
    let _e1774 = local_387[0];
    local_388 = u32(_e1774);
    let _e1778 = local_387[1];
    local_389 = u32(_e1778);
    let _e1781 = local_389;
    output_1[_e1781] = _e1760;
    let _e1783 = braced_fixed;
    local_120 = _e1783;
    let _e1785 = local_120;
    local_390 = _e1785;
    let _e1788 = local_390[0];
    local_391 = u32(_e1788);
    let _e1792 = local_390[1];
    local_392 = u32(_e1792);
    let _e1795 = local_392;
    let _e1797 = shared_[_e1795];
    let _e1798 = output;
    local_118 = _e1798;
    local_119 = u32(10i);
    let _e1803 = local_118;
    local_393 = _e1803;
    let _e1805 = local_119;
    let _e1807 = local_393[1];
    local_393[1] = (_e1807 + _e1805);
    let _e1811 = local_393[0];
    local_394 = u32(_e1811);
    let _e1815 = local_393[1];
    local_395 = u32(_e1815);
    let _e1818 = local_395;
    output_1[_e1818] = _e1797;
    let _e1820 = output;
    local_121 = _e1820;
    local_122 = u32(11i);
    let _e1825 = local_121;
    local_396 = _e1825;
    let _e1827 = local_122;
    let _e1829 = local_396[1];
    local_396[1] = (_e1829 + _e1827);
    let _e1833 = local_396[0];
    local_397 = u32(_e1833);
    let _e1837 = local_396[1];
    local_398 = u32(_e1837);
    let _e1840 = local_398;
    output_1[_e1840] = functional_snapshot;
    let _e1842 = output;
    local_123 = _e1842;
    local_124 = u32(12i);
    let _e1847 = local_123;
    local_399 = _e1847;
    let _e1849 = local_124;
    let _e1851 = local_399[1];
    local_399[1] = (_e1851 + _e1849);
    let _e1855 = local_399[0];
    local_400 = u32(_e1855);
    let _e1859 = local_399[1];
    local_401 = u32(_e1859);
    let _e1862 = local_401;
    output_1[_e1862] = braced_snapshot;
    let _e1864 = output;
    local_125 = _e1864;
    local_126 = u32(13i);
    let _e1869 = local_125;
    local_402 = _e1869;
    let _e1871 = local_126;
    let _e1873 = local_402[1];
    local_402[1] = (_e1873 + _e1871);
    let _e1877 = local_402[0];
    local_403 = u32(_e1877);
    let _e1881 = local_402[1];
    local_404 = u32(_e1881);
    let _e1884 = local_404;
    output_1[_e1884] = named_snapshot;
    let _e1886 = output;
    local_127 = _e1886;
    local_128 = u32(14i);
    let _e1891 = local_127;
    local_405 = _e1891;
    let _e1893 = local_128;
    let _e1895 = local_405[1];
    local_405[1] = (_e1895 + _e1893);
    let _e1899 = local_405[0];
    local_406 = u32(_e1899);
    let _e1903 = local_405[1];
    local_407 = u32(_e1903);
    let _e1906 = local_407;
    output_1[_e1906] = c_style_snapshot;
    let _e1908 = cursor;
    local_131 = _e1908;
    let _e1910 = local_131;
    local_408 = _e1910;
    let _e1913 = local_408[0];
    local_409 = u32(_e1913);
    let _e1917 = local_408[1];
    local_410 = u32(_e1917);
    let _e1920 = local_409;
    switch _e1920 {
        case 4u: {
            let _e1921 = local_410;
            let _e1923 = shared_[_e1921];
            local_411 = _e1923;
        }
        case 3u: {
            let _e1925 = local_410;
            let _e1927 = local[_e1925];
            local_411 = _e1927;
        }
        default: {
            let _e1929 = local_410;
            let _e1931 = output_1[_e1929];
            local_411 = _e1931;
        }
    }
    let _e1934 = local_411;
    let _e1935 = output;
    local_129 = _e1935;
    local_130 = u32(15i);
    let _e1940 = local_129;
    local_412 = _e1940;
    let _e1942 = local_130;
    let _e1944 = local_412[1];
    local_412[1] = (_e1944 + _e1942);
    let _e1948 = local_412[0];
    local_413 = u32(_e1948);
    let _e1952 = local_412[1];
    local_414 = u32(_e1952);
    let _e1955 = local_414;
    output_1[_e1955] = _e1934;
    let _e1957 = local_284;
    switch _e1957 {
        case 3u: {
            let _e1958 = local_285;
            let _e1960 = local[_e1958];
            local_415 = _e1960;
        }
        default: {
            let _e1962 = local_285;
            let _e1964 = shared_[_e1962];
            local_415 = _e1964;
        }
    }
    let _e1967 = local_415;
    let _e1968 = output;
    local_132 = _e1968;
    local_133 = u32(16i);
    let _e1973 = local_132;
    local_416 = _e1973;
    let _e1975 = local_133;
    let _e1977 = local_416[1];
    local_416[1] = (_e1977 + _e1975);
    let _e1981 = local_416[0];
    local_417 = u32(_e1981);
    let _e1985 = local_416[1];
    local_418 = u32(_e1985);
    let _e1988 = local_418;
    output_1[_e1988] = _e1967;
    let _e1990 = captured;
    local_136 = _e1990;
    let _e1992 = local_136;
    local_419 = _e1992;
    let _e1995 = local_419[0];
    local_420 = u32(_e1995);
    let _e1999 = local_419[1];
    local_421 = u32(_e1999);
    let _e2002 = local_420;
    switch _e2002 {
        case 3u: {
            let _e2003 = local_421;
            let _e2005 = local[_e2003];
            local_422 = _e2005;
        }
        default: {
            let _e2007 = local_421;
            let _e2009 = shared_[_e2007];
            local_422 = _e2009;
        }
    }
    let _e2012 = local_422;
    let _e2013 = output;
    local_134 = _e2013;
    local_135 = u32(17i);
    let _e2018 = local_134;
    local_423 = _e2018;
    let _e2020 = local_135;
    let _e2022 = local_423[1];
    local_423[1] = (_e2022 + _e2020);
    let _e2026 = local_423[0];
    local_424 = u32(_e2026);
    let _e2030 = local_423[1];
    local_425 = u32(_e2030);
    let _e2033 = local_425;
    output_1[_e2033] = _e2012;
    let _e2036 = frozen;
    local_139 = _e2036;
    let _e2038 = local_139;
    local_426 = _e2038;
    let _e2041 = local_426[0];
    local_427 = u32(_e2041);
    let _e2045 = local_426[1];
    local_428 = u32(_e2045);
    let _e2048 = local_428;
    let _e2050 = local[_e2048];
    let _e2051 = output;
    local_137 = _e2051;
    local_138 = u32(18i);
    let _e2056 = local_137;
    local_429 = _e2056;
    let _e2058 = local_138;
    let _e2060 = local_429[1];
    local_429[1] = (_e2060 + _e2058);
    let _e2064 = local_429[0];
    local_430 = u32(_e2064);
    let _e2068 = local_429[1];
    local_431 = u32(_e2068);
    let _e2071 = local_431;
    output_1[_e2071] = _e2050;
    let _e2073 = index;
    let _e2074 = output;
    local_140 = _e2074;
    local_141 = u32(19i);
    let _e2079 = local_140;
    local_432 = _e2079;
    let _e2081 = local_141;
    let _e2083 = local_432[1];
    local_432[1] = (_e2083 + _e2081);
    let _e2087 = local_432[0];
    local_433 = u32(_e2087);
    let _e2091 = local_432[1];
    local_434 = u32(_e2091);
    let _e2094 = local_434;
    output_1[_e2094] = _e2073;
    let _e2096 = output;
    local_142 = _e2096;
    local_143 = u32(20i);
    let _e2101 = local_142;
    local_435 = _e2101;
    let _e2103 = local_143;
    let _e2105 = local_435[1];
    local_435[1] = (_e2105 + _e2103);
    let _e2109 = local_435[0];
    local_436 = u32(_e2109);
    let _e2113 = local_435[1];
    local_437 = u32(_e2113);
    let _e2116 = local_437;
    output_1[_e2116] = after_capture;
    local_199 = u32();
    source = array<u32, 2>();
    source[0] = 3u;
    source[1] = 0u;
    let _e2127 = source;
    local_197 = _e2127;
    let _e2129 = local_197;
    copy = _e2129;
    let _e2132 = copy;
    local_198 = _e2132;
    let _e2134 = local_198;
    local_438 = _e2134;
    let _e2137 = local_438[0];
    local_439 = u32(_e2137);
    let _e2141 = local_438[1];
    local_440 = u32(_e2141);
    let _e2144 = local_440;
    let _e2146 = local[_e2144];
    local_199 = _e2146;
    let _e2148 = local_199;
    local_202 = u32();
    source_1 = array<u32, 2>();
    source_1[0] = 4u;
    source_1[1] = 0u;
    let _e2158 = source_1;
    local_200 = _e2158;
    let _e2160 = local_200;
    copy_1 = _e2160;
    let _e2163 = copy_1;
    local_201 = _e2163;
    let _e2165 = local_201;
    local_441 = _e2165;
    let _e2168 = local_441[0];
    local_442 = u32(_e2168);
    let _e2172 = local_441[1];
    local_443 = u32(_e2172);
    let _e2175 = local_443;
    let _e2177 = shared_[_e2175];
    local_202 = _e2177;
    let _e2179 = local_202;
    let _e2181 = output;
    local_144 = _e2181;
    local_145 = u32(21i);
    let _e2186 = local_144;
    local_444 = _e2186;
    let _e2188 = local_145;
    let _e2190 = local_444[1];
    local_444[1] = (_e2190 + _e2188);
    let _e2194 = local_444[0];
    local_445 = u32(_e2194);
    let _e2198 = local_444[1];
    local_446 = u32(_e2198);
    let _e2201 = local_446;
    output_1[_e2201] = (_e2148 + _e2179);
    let _e2203 = guarded_total;
    let _e2204 = output;
    local_146 = _e2204;
    local_147 = u32(25i);
    let _e2209 = local_146;
    local_447 = _e2209;
    let _e2211 = local_147;
    let _e2213 = local_447[1];
    local_447[1] = (_e2213 + _e2211);
    let _e2217 = local_447[0];
    local_448 = u32(_e2217);
    let _e2221 = local_447[1];
    local_449 = u32(_e2221);
    let _e2224 = local_449;
    output_1[_e2224] = _e2203;
    let _e2226 = kept;
    local_150 = _e2226;
    let _e2228 = local_150;
    local_450 = _e2228;
    let _e2231 = local_450[0];
    local_151 = (_e2231 != 1u);
    let _e2235 = local_151;
    let _e2238 = old_null;
    local_152 = _e2238;
    let _e2240 = local_152;
    local_451 = _e2240;
    let _e2243 = local_451[0];
    local_153 = (_e2243 != 1u);
    let _e2247 = local_153;
    let _e2251 = output;
    local_148 = _e2251;
    local_149 = u32(26i);
    let _e2256 = local_148;
    local_452 = _e2256;
    let _e2258 = local_149;
    let _e2260 = local_452[1];
    local_452[1] = (_e2260 + _e2258);
    let _e2264 = local_452[0];
    local_453 = u32(_e2264);
    let _e2268 = local_452[1];
    local_454 = u32(_e2268);
    let _e2271 = local_454;
    output_1[_e2271] = (u32(!(_e2235)) + u32(!(_e2247)));
    let _e2273 = output;
    local_154 = _e2273;
    local_155 = u32(27i);
    let _e2278 = local_154;
    local_455 = _e2278;
    let _e2280 = local_155;
    let _e2282 = local_455[1];
    local_455[1] = (_e2282 + _e2280);
    let _e2286 = local_455[0];
    local_456 = u32(_e2286);
    let _e2290 = local_455[1];
    local_457 = u32(_e2290);
    let _e2293 = local_457;
    output_1[_e2293] = selected_snapshot;
    let _e2296 = selected;
    local_158 = _e2296;
    let _e2298 = local_158;
    local_458 = _e2298;
    let _e2301 = local_458[0];
    local_159 = (_e2301 != 1u);
    let _e2305 = local_159;
    let _e2311 = output;
    local_156 = _e2311;
    local_157 = u32(28i);
    let _e2316 = local_156;
    local_459 = _e2316;
    let _e2318 = local_157;
    let _e2320 = local_459[1];
    local_459[1] = (_e2320 + _e2318);
    let _e2324 = local_459[0];
    local_460 = u32(_e2324);
    let _e2328 = local_459[1];
    local_461 = u32(_e2328);
    let _e2331 = local_461;
    output_1[_e2331] = (u32(_e1239) + (2u * u32(!(_e2305))));
    let _e2333 = counter;
    let _e2334 = output;
    local_160 = _e2334;
    local_161 = u32(29i);
    let _e2339 = local_160;
    local_462 = _e2339;
    let _e2341 = local_161;
    let _e2343 = local_462[1];
    local_462[1] = (_e2343 + _e2341);
    let _e2347 = local_462[0];
    local_463 = u32(_e2347);
    let _e2351 = local_462[1];
    local_464 = u32(_e2351);
    let _e2354 = local_464;
    output_1[_e2354] = _e2333;
    local_164 = u32(2i);
    local_205 = u32();
    source_2 = array<u32, 2>();
    source_2[0] = 3u;
    source_2[1] = 0u;
    let _e2367 = local_164;
    let _e2369 = source_2[1];
    source_2[1] = (_e2369 + _e2367);
    let _e2373 = source_2;
    local_203 = _e2373;
    let _e2375 = local_203;
    copy_2 = _e2375;
    let _e2378 = copy_2;
    local_204 = _e2378;
    let _e2380 = local_204;
    local_465 = _e2380;
    let _e2383 = local_465[0];
    local_466 = u32(_e2383);
    let _e2387 = local_465[1];
    local_467 = u32(_e2387);
    let _e2390 = local_467;
    let _e2392 = local[_e2390];
    local_205 = _e2392;
    let _e2394 = local_205;
    let _e2395 = output;
    local_162 = _e2395;
    local_163 = u32(30i);
    let _e2400 = local_162;
    local_468 = _e2400;
    let _e2402 = local_163;
    let _e2404 = local_468[1];
    local_468[1] = (_e2404 + _e2402);
    let _e2408 = local_468[0];
    local_469 = u32(_e2408);
    let _e2412 = local_468[1];
    local_470 = u32(_e2412);
    let _e2415 = local_470;
    output_1[_e2415] = _e2394;
    local_471 = array<u32, 2>();
    local_471[0] = 1u;
    let _e2422 = local_471[0];
    local_167 = (_e2422 != 1u);
    let _e2426 = local_167;
    local_472 = array<u32, 2>();
    local_472[0] = 1u;
    let _e2434 = local_472[0];
    local_168 = (_e2434 != 1u);
    let _e2438 = local_168;
    let _e2442 = output;
    local_165 = _e2442;
    local_166 = u32(31i);
    let _e2447 = local_165;
    local_473 = _e2447;
    let _e2449 = local_166;
    let _e2451 = local_473[1];
    local_473[1] = (_e2451 + _e2449);
    let _e2455 = local_473[0];
    local_474 = u32(_e2455);
    let _e2459 = local_473[1];
    local_475 = u32(_e2459);
    let _e2462 = local_475;
    output_1[_e2462] = (u32(!(_e2426)) + u32(!(_e2438)));
    let _e2466 = local[0i];
    let _e2467 = output;
    local_169 = _e2467;
    local_170 = u32(35i);
    let _e2472 = local_169;
    local_476 = _e2472;
    let _e2474 = local_170;
    let _e2476 = local_476[1];
    local_476[1] = (_e2476 + _e2474);
    let _e2480 = local_476[0];
    local_477 = u32(_e2480);
    let _e2484 = local_476[1];
    local_478 = u32(_e2484);
    let _e2487 = local_478;
    output_1[_e2487] = _e2466;
    let _e2491 = local[1i];
    let _e2492 = output;
    local_171 = _e2492;
    local_172 = u32(36i);
    let _e2497 = local_171;
    local_479 = _e2497;
    let _e2499 = local_172;
    let _e2501 = local_479[1];
    local_479[1] = (_e2501 + _e2499);
    let _e2505 = local_479[0];
    local_480 = u32(_e2505);
    let _e2509 = local_479[1];
    local_481 = u32(_e2509);
    let _e2512 = local_481;
    output_1[_e2512] = _e2491;
    let _e2516 = shared_[1i];
    let _e2517 = output;
    local_173 = _e2517;
    local_174 = u32(37i);
    let _e2522 = local_173;
    local_482 = _e2522;
    let _e2524 = local_174;
    let _e2526 = local_482[1];
    local_482[1] = (_e2526 + _e2524);
    let _e2530 = local_482[0];
    local_483 = u32(_e2530);
    let _e2534 = local_482[1];
    local_484 = u32(_e2534);
    let _e2537 = local_484;
    output_1[_e2537] = _e2516;
    let _e2541 = shared_[2i];
    let _e2542 = output;
    local_175 = _e2542;
    local_176 = u32(38i);
    let _e2547 = local_175;
    local_485 = _e2547;
    let _e2549 = local_176;
    let _e2551 = local_485[1];
    local_485[1] = (_e2551 + _e2549);
    let _e2555 = local_485[0];
    local_486 = u32(_e2555);
    let _e2559 = local_485[1];
    local_487 = u32(_e2559);
    let _e2562 = local_487;
    output_1[_e2562] = _e2541;
    let _e2564 = old_null;
    local_179 = _e2564;
    let _e2566 = local_179;
    local_488 = _e2566;
    let _e2569 = local_488[0];
    local_180 = (_e2569 != 1u);
    let _e2573 = local_180;
    let _e2578 = selected;
    local_181 = _e2578;
    let _e2580 = local_181;
    local_489 = _e2580;
    let _e2583 = local_489[0];
    local_182 = (_e2583 != 1u);
    let _e2587 = local_182;
    let _e2591 = output;
    local_177 = _e2591;
    local_178 = u32(39i);
    let _e2596 = local_177;
    local_490 = _e2596;
    let _e2598 = local_178;
    let _e2600 = local_490[1];
    local_490[1] = (_e2600 + _e2598);
    let _e2604 = local_490[0];
    local_491 = u32(_e2604);
    let _e2608 = local_490[1];
    local_492 = u32(_e2608);
    let _e2611 = local_492;
    output_1[_e2611] = ((u32(!(_e2573)) + u32(_e1239)) + u32(!(_e2587)));
}
