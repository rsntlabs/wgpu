// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_2[1];
struct type_3 {
    uint inner[4];
};
struct type_4 {
    uint inner[3];
};
struct type_5 {
    uint inner[2];
};

uint absent_unsigned_u002a(
) {
    type_5 value_2 = {};
    type_5 local_493 = {};
    bool local_494 = {};
    uint local_495 = {};
    type_5 local_496 = {};
    value_2 = type_5 {};
    value_2.inner[0] = 1u;
    type_5 _e6 = value_2;
    local_493 = _e6;
    type_5 _e9 = local_493;
    local_496 = _e9;
    uint _e11 = local_496.inner[0];
    local_494 = _e11 != 1u;
    bool _e14 = local_494;
    if (_e14) {
        local_495 = 37u;
    } else {
        local_495 = 41u;
    }
    uint _e20 = local_495;
    return _e20;
}

uint absent_const_u0020_unsigned_u002a(
) {
    type_5 value_3 = {};
    type_5 local_497 = {};
    bool local_498 = {};
    uint local_499 = {};
    type_5 local_500 = {};
    value_3 = type_5 {};
    value_3.inner[0] = 1u;
    type_5 _e6 = value_3;
    local_497 = _e6;
    type_5 _e9 = local_497;
    local_500 = _e9;
    uint _e11 = local_500.inner[0];
    local_498 = _e11 != 1u;
    bool _e14 = local_498;
    if (_e14) {
        local_499 = 37u;
    } else {
        local_499 = 41u;
    }
    uint _e20 = local_499;
    return _e20;
}

kernel void pointer_value_construction(
  uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_2& output_1 [[user(fake0)]]
, threadgroup type_4& shared
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_5 output = {};
    type_3 local = {};
    type_5 local_1 = {};
    uint local_2 = {};
    type_5 local_3 = {};
    uint local_4 = {};
    type_5 local_5 = {};
    uint local_6 = {};
    type_5 empty = {};
    type_5 braced_empty = {};
    type_5 from_zero = {};
    type_5 from_braced_zero = {};
    type_5 qualified_null = {};
    type_5 cast_null = {};
    type_5 cursor = {};
    type_5 local_7 = {};
    type_5 functional = {};
    type_5 local_8 = {};
    uint local_9 = {};
    type_5 braced = {};
    type_5 local_10 = {};
    uint local_11 = {};
    type_5 named = {};
    type_5 local_12 = {};
    uint local_13 = {};
    type_5 c_style = {};
    type_5 local_14 = {};
    type_5 local_15 = {};
    type_5 local_16 = {};
    type_5 local_17 = {};
    type_5 local_18 = {};
    type_5 local_19 = {};
    type_5 read_functional = {};
    type_5 local_20 = {};
    type_5 read_braced = {};
    type_5 local_21 = {};
    type_5 read_named = {};
    type_5 local_22 = {};
    type_5 read_c_style = {};
    type_5 local_23 = {};
    type_5 local_24 = {};
    type_5 local_25 = {};
    type_5 local_26 = {};
    uint local_27 = {};
    type_5 fixed = {};
    type_5 local_28 = {};
    type_5 mutable_copy = {};
    type_5 local_29 = {};
    type_5 local_30 = {};
    type_5 braced_fixed = {};
    type_5 local_31 = {};
    type_5 local_32 = {};
    uint local_33 = {};
    type_5 local_34 = {};
    type_5 local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    type_5 local_38 = {};
    uint local_39 = {};
    type_5 local_40 = {};
    uint local_41 = {};
    type_5 local_42 = {};
    uint local_43 = {};
    uint counter = {};
    uint index = {};
    type_5 captured = {};
    type_5 local_44 = {};
    uint local_45 = {};
    type_5 frozen = {};
    type_5 local_46 = {};
    type_5 selected = {};
    uint guarded_total = {};
    uint branch = {};
    uint local_47 = {};
    type_5 local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    type_5 local_54 = {};
    type_5 saved = {};
    type_5 local_55 = {};
    bool local_56 = {};
    type_5 local_57 = {};
    type_5 local_58 = {};
    type_5 local_59 = {};
    uint local_60 = {};
    type_5 local_61 = {};
    bool local_62 = {};
    type_5 local_63 = {};
    bool local_64 = {};
    type_5 local_65 = {};
    uint local_66 = {};
    type_5 kept = {};
    type_5 local_67 = {};
    type_5 old_null = {};
    type_5 local_68 = {};
    type_5 local_69 = {};
    bool local_70 = {};
    type_5 local_71 = {};
    uint local_72 = {};
    type_5 local_73 = {};
    bool local_74 = {};
    type_5 local_75 = {};
    type_5 local_76 = {};
    type_5 local_77 = {};
    bool local_78 = {};
    type_5 local_79 = {};
    uint local_80 = {};
    type_5 local_81 = {};
    uint local_82 = {};
    type_5 local_83 = {};
    bool local_84 = {};
    type_5 local_85 = {};
    bool local_86 = {};
    type_5 local_87 = {};
    bool local_88 = {};
    type_5 local_89 = {};
    bool local_90 = {};
    type_5 local_91 = {};
    bool local_92 = {};
    type_5 local_93 = {};
    bool local_94 = {};
    type_5 local_95 = {};
    uint local_96 = {};
    type_5 local_97 = {};
    uint local_98 = {};
    type_5 local_99 = {};
    uint local_100 = {};
    type_5 local_101 = {};
    type_5 local_102 = {};
    uint local_103 = {};
    type_5 local_104 = {};
    type_5 local_105 = {};
    uint local_106 = {};
    type_5 local_107 = {};
    type_5 local_108 = {};
    uint local_109 = {};
    type_5 local_110 = {};
    type_5 local_111 = {};
    uint local_112 = {};
    type_5 local_113 = {};
    uint local_114 = {};
    type_5 local_115 = {};
    uint local_116 = {};
    type_5 local_117 = {};
    type_5 local_118 = {};
    uint local_119 = {};
    type_5 local_120 = {};
    type_5 local_121 = {};
    uint local_122 = {};
    type_5 local_123 = {};
    uint local_124 = {};
    type_5 local_125 = {};
    uint local_126 = {};
    type_5 local_127 = {};
    uint local_128 = {};
    type_5 local_129 = {};
    uint local_130 = {};
    type_5 local_131 = {};
    type_5 local_132 = {};
    uint local_133 = {};
    type_5 local_134 = {};
    uint local_135 = {};
    type_5 local_136 = {};
    type_5 local_137 = {};
    uint local_138 = {};
    type_5 local_139 = {};
    type_5 local_140 = {};
    uint local_141 = {};
    type_5 local_142 = {};
    uint local_143 = {};
    type_5 local_144 = {};
    uint local_145 = {};
    type_5 local_146 = {};
    uint local_147 = {};
    type_5 local_148 = {};
    uint local_149 = {};
    type_5 local_150 = {};
    bool local_151 = {};
    type_5 local_152 = {};
    bool local_153 = {};
    type_5 local_154 = {};
    uint local_155 = {};
    type_5 local_156 = {};
    uint local_157 = {};
    type_5 local_158 = {};
    bool local_159 = {};
    type_5 local_160 = {};
    uint local_161 = {};
    type_5 local_162 = {};
    uint local_163 = {};
    uint local_164 = {};
    type_5 local_165 = {};
    uint local_166 = {};
    bool local_167 = {};
    bool local_168 = {};
    type_5 local_169 = {};
    uint local_170 = {};
    type_5 local_171 = {};
    uint local_172 = {};
    type_5 local_173 = {};
    uint local_174 = {};
    type_5 local_175 = {};
    uint local_176 = {};
    type_5 local_177 = {};
    uint local_178 = {};
    type_5 local_179 = {};
    bool local_180 = {};
    type_5 local_181 = {};
    bool local_182 = {};
    uint local_183 = {};
    uint local_184 = {};
    uint local_185 = {};
    uint local_186 = {};
    type_5 value = {};
    uint amount = {};
    type_5 local_187 = {};
    bool local_188 = {};
    type_5 local_189 = {};
    uint local_190 = {};
    uint local_191 = {};
    type_5 value_1 = {};
    uint amount_1 = {};
    type_5 local_192 = {};
    bool local_193 = {};
    type_5 local_194 = {};
    uint local_195 = {};
    uint local_196 = {};
    type_5 source = {};
    type_5 local_197 = {};
    type_5 copy = {};
    type_5 local_198 = {};
    uint local_199 = {};
    type_5 source_1 = {};
    type_5 local_200 = {};
    type_5 copy_1 = {};
    type_5 local_201 = {};
    uint local_202 = {};
    type_5 source_2 = {};
    type_5 local_203 = {};
    type_5 copy_2 = {};
    type_5 local_204 = {};
    uint local_205 = {};
    type_5 local_206 = {};
    uint local_207 = {};
    uint local_208 = {};
    type_5 local_209 = {};
    uint local_210 = {};
    uint local_211 = {};
    type_5 local_212 = {};
    uint local_213 = {};
    uint local_214 = {};
    type_5 local_215 = {};
    type_5 local_216 = {};
    uint local_217 = {};
    uint local_218 = {};
    uint local_219 = {};
    type_5 local_220 = {};
    uint local_221 = {};
    uint local_222 = {};
    uint local_223 = {};
    type_5 local_224 = {};
    uint local_225 = {};
    uint local_226 = {};
    uint local_227 = {};
    type_5 local_228 = {};
    uint local_229 = {};
    uint local_230 = {};
    uint local_231 = {};
    type_5 local_232 = {};
    uint local_233 = {};
    uint local_234 = {};
    uint local_235 = {};
    type_5 local_236 = {};
    uint local_237 = {};
    uint local_238 = {};
    uint local_239 = {};
    type_5 local_240 = {};
    uint local_241 = {};
    uint local_242 = {};
    uint local_243 = {};
    type_5 local_244 = {};
    uint local_245 = {};
    uint local_246 = {};
    uint local_247 = {};
    type_5 local_248 = {};
    uint local_249 = {};
    uint local_250 = {};
    uint local_251 = {};
    type_5 local_252 = {};
    uint local_253 = {};
    uint local_254 = {};
    type_5 local_255 = {};
    uint local_256 = {};
    uint local_257 = {};
    type_5 local_258 = {};
    type_5 local_259 = {};
    type_5 local_260 = {};
    uint local_261 = {};
    uint local_262 = {};
    uint local_263 = {};
    type_5 local_264 = {};
    type_5 local_265 = {};
    type_5 local_266 = {};
    uint local_267 = {};
    uint local_268 = {};
    uint local_269 = {};
    type_5 local_270 = {};
    type_5 local_271 = {};
    type_5 local_272 = {};
    uint local_273 = {};
    uint local_274 = {};
    uint local_275 = {};
    type_5 local_276 = {};
    type_5 local_277 = {};
    type_5 local_278 = {};
    uint local_279 = {};
    uint local_280 = {};
    uint local_281 = {};
    type_5 local_282 = {};
    type_5 local_283 = {};
    uint local_284 = {};
    uint local_285 = {};
    uint local_286 = {};
    type_5 local_287 = {};
    uint local_288 = {};
    uint local_289 = {};
    uint local_290 = {};
    type_5 local_291 = {};
    type_5 local_292 = {};
    type_5 local_293 = {};
    type_5 local_294 = {};
    uint local_295 = {};
    uint local_296 = {};
    uint local_297 = {};
    type_5 local_298 = {};
    uint local_299 = {};
    uint local_300 = {};
    uint local_301 = {};
    type_5 local_302 = {};
    type_5 local_303 = {};
    type_5 local_304 = {};
    uint local_305 = {};
    uint local_306 = {};
    type_5 local_307 = {};
    type_5 local_308 = {};
    type_5 local_309 = {};
    type_5 local_310 = {};
    uint local_311 = {};
    uint local_312 = {};
    uint local_313 = {};
    type_5 local_314 = {};
    type_5 local_315 = {};
    uint local_316 = {};
    uint local_317 = {};
    uint local_318 = {};
    type_5 local_319 = {};
    uint local_320 = {};
    uint local_321 = {};
    uint local_322 = {};
    type_5 local_323 = {};
    type_5 local_324 = {};
    type_5 local_325 = {};
    type_5 local_326 = {};
    uint local_327 = {};
    uint local_328 = {};
    uint local_329 = {};
    type_5 local_330 = {};
    type_5 local_331 = {};
    uint local_332 = {};
    uint local_333 = {};
    uint local_334 = {};
    type_5 local_335 = {};
    type_5 local_336 = {};
    type_5 local_337 = {};
    type_5 local_338 = {};
    type_5 local_339 = {};
    type_5 local_340 = {};
    type_5 local_341 = {};
    uint local_342 = {};
    uint local_343 = {};
    type_5 local_344 = {};
    uint local_345 = {};
    uint local_346 = {};
    type_5 local_347 = {};
    uint local_348 = {};
    uint local_349 = {};
    type_5 local_350 = {};
    uint local_351 = {};
    uint local_352 = {};
    uint local_353 = {};
    type_5 local_354 = {};
    uint local_355 = {};
    uint local_356 = {};
    type_5 local_357 = {};
    uint local_358 = {};
    uint local_359 = {};
    uint local_360 = {};
    type_5 local_361 = {};
    uint local_362 = {};
    uint local_363 = {};
    type_5 local_364 = {};
    uint local_365 = {};
    uint local_366 = {};
    uint local_367 = {};
    type_5 local_368 = {};
    uint local_369 = {};
    uint local_370 = {};
    type_5 local_371 = {};
    uint local_372 = {};
    uint local_373 = {};
    uint local_374 = {};
    type_5 local_375 = {};
    uint local_376 = {};
    uint local_377 = {};
    type_5 local_378 = {};
    uint local_379 = {};
    uint local_380 = {};
    type_5 local_381 = {};
    uint local_382 = {};
    uint local_383 = {};
    type_5 local_384 = {};
    uint local_385 = {};
    uint local_386 = {};
    type_5 local_387 = {};
    uint local_388 = {};
    uint local_389 = {};
    type_5 local_390 = {};
    uint local_391 = {};
    uint local_392 = {};
    type_5 local_393 = {};
    uint local_394 = {};
    uint local_395 = {};
    type_5 local_396 = {};
    uint local_397 = {};
    uint local_398 = {};
    type_5 local_399 = {};
    uint local_400 = {};
    uint local_401 = {};
    type_5 local_402 = {};
    uint local_403 = {};
    uint local_404 = {};
    type_5 local_405 = {};
    uint local_406 = {};
    uint local_407 = {};
    type_5 local_408 = {};
    uint local_409 = {};
    uint local_410 = {};
    uint local_411 = {};
    type_5 local_412 = {};
    uint local_413 = {};
    uint local_414 = {};
    uint local_415 = {};
    type_5 local_416 = {};
    uint local_417 = {};
    uint local_418 = {};
    type_5 local_419 = {};
    uint local_420 = {};
    uint local_421 = {};
    uint local_422 = {};
    type_5 local_423 = {};
    uint local_424 = {};
    uint local_425 = {};
    type_5 local_426 = {};
    uint local_427 = {};
    uint local_428 = {};
    type_5 local_429 = {};
    uint local_430 = {};
    uint local_431 = {};
    type_5 local_432 = {};
    uint local_433 = {};
    uint local_434 = {};
    type_5 local_435 = {};
    uint local_436 = {};
    uint local_437 = {};
    type_5 local_438 = {};
    uint local_439 = {};
    uint local_440 = {};
    type_5 local_441 = {};
    uint local_442 = {};
    uint local_443 = {};
    type_5 local_444 = {};
    uint local_445 = {};
    uint local_446 = {};
    type_5 local_447 = {};
    uint local_448 = {};
    uint local_449 = {};
    type_5 local_450 = {};
    type_5 local_451 = {};
    type_5 local_452 = {};
    uint local_453 = {};
    uint local_454 = {};
    type_5 local_455 = {};
    uint local_456 = {};
    uint local_457 = {};
    type_5 local_458 = {};
    type_5 local_459 = {};
    uint local_460 = {};
    uint local_461 = {};
    type_5 local_462 = {};
    uint local_463 = {};
    uint local_464 = {};
    type_5 local_465 = {};
    uint local_466 = {};
    uint local_467 = {};
    type_5 local_468 = {};
    uint local_469 = {};
    uint local_470 = {};
    type_5 local_471 = {};
    type_5 local_472 = {};
    type_5 local_473 = {};
    uint local_474 = {};
    uint local_475 = {};
    type_5 local_476 = {};
    uint local_477 = {};
    uint local_478 = {};
    type_5 local_479 = {};
    uint local_480 = {};
    uint local_481 = {};
    type_5 local_482 = {};
    uint local_483 = {};
    uint local_484 = {};
    type_5 local_485 = {};
    uint local_486 = {};
    uint local_487 = {};
    type_5 local_488 = {};
    type_5 local_489 = {};
    type_5 local_490 = {};
    uint local_491 = {};
    uint local_492 = {};
    output = type_5 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    local.inner[0] = 3u;
    local.inner[1] = 5u;
    local.inner[2] = 7u;
    local.inner[3] = 11u;
    shared.inner[0] = 13u;
    shared.inner[1] = 17u;
    shared.inner[2] = 19u;
    type_5 _e26 = output;
    local_1 = _e26;
    local_2 = static_cast<uint>(32);
    type_5 _e31 = local_1;
    local_206 = _e31;
    uint _e33 = local_2;
    uint _e35 = local_206.inner[1];
    local_206.inner[1] = _e35 + _e33;
    uint _e39 = local_206.inner[0];
    local_207 = static_cast<uint>(_e39);
    uint _e43 = local_206.inner[1];
    local_208 = static_cast<uint>(_e43);
    uint _e46 = local_208;
    output_1[_e46] = 23u;
    type_5 _e50 = output;
    local_3 = _e50;
    local_4 = static_cast<uint>(33);
    type_5 _e55 = local_3;
    local_209 = _e55;
    uint _e57 = local_4;
    uint _e59 = local_209.inner[1];
    local_209.inner[1] = _e59 + _e57;
    uint _e63 = local_209.inner[0];
    local_210 = static_cast<uint>(_e63);
    uint _e67 = local_209.inner[1];
    local_211 = static_cast<uint>(_e67);
    uint _e70 = local_211;
    output_1[_e70] = 29u;
    type_5 _e73 = output;
    local_5 = _e73;
    local_6 = static_cast<uint>(34);
    type_5 _e78 = local_5;
    local_212 = _e78;
    uint _e80 = local_6;
    uint _e82 = local_212.inner[1];
    local_212.inner[1] = _e82 + _e80;
    uint _e86 = local_212.inner[0];
    local_213 = static_cast<uint>(_e86);
    uint _e90 = local_212.inner[1];
    local_214 = static_cast<uint>(_e90);
    uint _e93 = local_214;
    output_1[_e93] = 31u;
    empty = type_5 {};
    empty.inner[0] = 1u;
    braced_empty = type_5 {};
    braced_empty.inner[0] = 1u;
    from_zero = type_5 {};
    from_zero.inner[0] = 1u;
    from_braced_zero = type_5 {};
    from_braced_zero.inner[0] = 1u;
    qualified_null = type_5 {};
    qualified_null.inner[0] = 1u;
    cast_null = type_5 {};
    cast_null.inner[0] = 1u;
    cursor = type_5 {};
    cursor.inner[0] = 3u;
    cursor.inner[1] = 0u;
    type_5 _e127 = cursor;
    local_7 = _e127;
    type_5 _e129 = local_7;
    functional = _e129;
    type_5 _e131 = cursor;
    local_8 = _e131;
    local_9 = static_cast<uint>(1);
    type_5 _e136 = local_8;
    braced = _e136;
    uint _e138 = local_9;
    uint _e140 = braced.inner[1];
    braced.inner[1] = _e140 + _e138;
    type_5 _e143 = cursor;
    local_10 = _e143;
    local_11 = static_cast<uint>(2);
    type_5 _e148 = local_10;
    named = _e148;
    uint _e150 = local_11;
    uint _e152 = named.inner[1];
    named.inner[1] = _e152 + _e150;
    type_5 _e155 = cursor;
    local_12 = _e155;
    local_13 = static_cast<uint>(3);
    type_5 _e160 = local_12;
    c_style = _e160;
    uint _e162 = local_13;
    uint _e164 = c_style.inner[1];
    c_style.inner[1] = _e164 + _e162;
    local_215 = type_5 {};
    local_215.inner[0] = 4u;
    local_215.inner[1] = 0u;
    type_5 _e173 = local_215;
    cursor = _e173;
    type_5 _e175 = functional;
    local_14 = _e175;
    type_5 _e177 = local_14;
    local_216 = _e177;
    uint _e180 = local_216.inner[0];
    local_217 = static_cast<uint>(_e180);
    uint _e184 = local_216.inner[1];
    local_218 = static_cast<uint>(_e184);
    uint _e187 = local_217;
    switch(_e187) {
        case 4u: {
            uint _e188 = local_218;
            uint _e190 = shared.inner[_e188];
            local_219 = _e190;
            break;
        }
        case 3u: {
            uint _e192 = local_218;
            uint _e194 = local.inner[_e192];
            local_219 = _e194;
            break;
        }
        default: {
            uint _e196 = local_218;
            uint _e198 = output_1[_e196];
            local_219 = _e198;
            break;
        }
    }
    uint _e201 = local_219;
    uint _e203 = _e201 + 2u;
    uint _e204 = local_217;
    switch(_e204) {
        case 4u: {
            uint _e205 = local_218;
            shared.inner[_e205] = _e203;
            break;
        }
        case 3u: {
            uint _e207 = local_218;
            local.inner[_e207] = _e203;
            break;
        }
        default: {
            uint _e209 = local_218;
            output_1[_e209] = _e203;
            break;
        }
    }
    type_5 _e212 = braced;
    local_15 = _e212;
    type_5 _e214 = local_15;
    local_220 = _e214;
    uint _e217 = local_220.inner[0];
    local_221 = static_cast<uint>(_e217);
    uint _e221 = local_220.inner[1];
    local_222 = static_cast<uint>(_e221);
    uint _e224 = local_221;
    switch(_e224) {
        case 4u: {
            uint _e225 = local_222;
            uint _e227 = shared.inner[_e225];
            local_223 = _e227;
            break;
        }
        case 3u: {
            uint _e229 = local_222;
            uint _e231 = local.inner[_e229];
            local_223 = _e231;
            break;
        }
        default: {
            uint _e233 = local_222;
            uint _e235 = output_1[_e233];
            local_223 = _e235;
            break;
        }
    }
    uint _e238 = local_223;
    uint _e240 = _e238 + 3u;
    uint _e241 = local_221;
    switch(_e241) {
        case 4u: {
            uint _e242 = local_222;
            shared.inner[_e242] = _e240;
            break;
        }
        case 3u: {
            uint _e244 = local_222;
            local.inner[_e244] = _e240;
            break;
        }
        default: {
            uint _e246 = local_222;
            output_1[_e246] = _e240;
            break;
        }
    }
    type_5 _e249 = named;
    local_16 = _e249;
    type_5 _e251 = local_16;
    local_224 = _e251;
    uint _e254 = local_224.inner[0];
    local_225 = static_cast<uint>(_e254);
    uint _e258 = local_224.inner[1];
    local_226 = static_cast<uint>(_e258);
    uint _e261 = local_225;
    switch(_e261) {
        case 4u: {
            uint _e262 = local_226;
            uint _e264 = shared.inner[_e262];
            local_227 = _e264;
            break;
        }
        case 3u: {
            uint _e266 = local_226;
            uint _e268 = local.inner[_e266];
            local_227 = _e268;
            break;
        }
        default: {
            uint _e270 = local_226;
            uint _e272 = output_1[_e270];
            local_227 = _e272;
            break;
        }
    }
    uint _e275 = local_227;
    uint _e277 = _e275 + 5u;
    uint _e278 = local_225;
    switch(_e278) {
        case 4u: {
            uint _e279 = local_226;
            shared.inner[_e279] = _e277;
            break;
        }
        case 3u: {
            uint _e281 = local_226;
            local.inner[_e281] = _e277;
            break;
        }
        default: {
            uint _e283 = local_226;
            output_1[_e283] = _e277;
            break;
        }
    }
    type_5 _e286 = c_style;
    local_17 = _e286;
    type_5 _e288 = local_17;
    local_228 = _e288;
    uint _e291 = local_228.inner[0];
    local_229 = static_cast<uint>(_e291);
    uint _e295 = local_228.inner[1];
    local_230 = static_cast<uint>(_e295);
    uint _e298 = local_229;
    switch(_e298) {
        case 4u: {
            uint _e299 = local_230;
            uint _e301 = shared.inner[_e299];
            local_231 = _e301;
            break;
        }
        case 3u: {
            uint _e303 = local_230;
            uint _e305 = local.inner[_e303];
            local_231 = _e305;
            break;
        }
        default: {
            uint _e307 = local_230;
            uint _e309 = output_1[_e307];
            local_231 = _e309;
            break;
        }
    }
    uint _e312 = local_231;
    uint _e314 = _e312 + 7u;
    uint _e315 = local_229;
    switch(_e315) {
        case 4u: {
            uint _e316 = local_230;
            shared.inner[_e316] = _e314;
            break;
        }
        case 3u: {
            uint _e318 = local_230;
            local.inner[_e318] = _e314;
            break;
        }
        default: {
            uint _e320 = local_230;
            output_1[_e320] = _e314;
            break;
        }
    }
    type_5 _e322 = functional;
    local_18 = _e322;
    type_5 _e324 = local_18;
    local_232 = _e324;
    uint _e327 = local_232.inner[0];
    local_233 = static_cast<uint>(_e327);
    uint _e331 = local_232.inner[1];
    local_234 = static_cast<uint>(_e331);
    uint _e334 = local_233;
    switch(_e334) {
        case 4u: {
            uint _e335 = local_234;
            uint _e337 = shared.inner[_e335];
            local_235 = _e337;
            break;
        }
        case 3u: {
            uint _e339 = local_234;
            uint _e341 = local.inner[_e339];
            local_235 = _e341;
            break;
        }
        default: {
            uint _e343 = local_234;
            uint _e345 = output_1[_e343];
            local_235 = _e345;
            break;
        }
    }
    uint first_copy = local_235;
    type_5 _e349 = functional;
    local_19 = _e349;
    type_5 _e351 = local_19;
    read_functional = _e351;
    type_5 _e353 = braced;
    local_20 = _e353;
    type_5 _e355 = local_20;
    read_braced = _e355;
    type_5 _e357 = named;
    local_21 = _e357;
    type_5 _e359 = local_21;
    read_named = _e359;
    type_5 _e361 = c_style;
    local_22 = _e361;
    type_5 _e363 = local_22;
    read_c_style = _e363;
    type_5 _e366 = read_functional;
    local_23 = _e366;
    type_5 _e369 = read_braced;
    local_24 = _e369;
    type_5 _e371 = local_23;
    local_236 = _e371;
    uint _e374 = local_236.inner[0];
    local_237 = static_cast<uint>(_e374);
    uint _e378 = local_236.inner[1];
    local_238 = static_cast<uint>(_e378);
    uint _e381 = local_237;
    switch(_e381) {
        case 4u: {
            uint _e382 = local_238;
            uint _e384 = shared.inner[_e382];
            local_239 = _e384;
            break;
        }
        case 3u: {
            uint _e386 = local_238;
            uint _e388 = local.inner[_e386];
            local_239 = _e388;
            break;
        }
        default: {
            uint _e390 = local_238;
            uint _e392 = output_1[_e390];
            local_239 = _e392;
            break;
        }
    }
    uint _e395 = local_239;
    type_5 _e396 = local_24;
    local_240 = _e396;
    uint _e399 = local_240.inner[0];
    local_241 = static_cast<uint>(_e399);
    uint _e403 = local_240.inner[1];
    local_242 = static_cast<uint>(_e403);
    uint _e406 = local_241;
    switch(_e406) {
        case 4u: {
            uint _e407 = local_242;
            uint _e409 = shared.inner[_e407];
            local_243 = _e409;
            break;
        }
        case 3u: {
            uint _e411 = local_242;
            uint _e413 = local.inner[_e411];
            local_243 = _e413;
            break;
        }
        default: {
            uint _e415 = local_242;
            uint _e417 = output_1[_e415];
            local_243 = _e417;
            break;
        }
    }
    uint _e420 = local_243;
    type_5 _e423 = read_named;
    local_25 = _e423;
    type_5 _e425 = local_25;
    local_244 = _e425;
    uint _e428 = local_244.inner[0];
    local_245 = static_cast<uint>(_e428);
    uint _e432 = local_244.inner[1];
    local_246 = static_cast<uint>(_e432);
    uint _e435 = local_245;
    switch(_e435) {
        case 4u: {
            uint _e436 = local_246;
            uint _e438 = shared.inner[_e436];
            local_247 = _e438;
            break;
        }
        case 3u: {
            uint _e440 = local_246;
            uint _e442 = local.inner[_e440];
            local_247 = _e442;
            break;
        }
        default: {
            uint _e444 = local_246;
            uint _e446 = output_1[_e444];
            local_247 = _e446;
            break;
        }
    }
    uint _e449 = local_247;
    type_5 _e452 = read_c_style;
    local_26 = _e452;
    type_5 _e454 = local_26;
    local_248 = _e454;
    uint _e457 = local_248.inner[0];
    local_249 = static_cast<uint>(_e457);
    uint _e461 = local_248.inner[1];
    local_250 = static_cast<uint>(_e461);
    uint _e464 = local_249;
    switch(_e464) {
        case 4u: {
            uint _e465 = local_250;
            uint _e467 = shared.inner[_e465];
            local_251 = _e467;
            break;
        }
        case 3u: {
            uint _e469 = local_250;
            uint _e471 = local.inner[_e469];
            local_251 = _e471;
            break;
        }
        default: {
            uint _e473 = local_250;
            uint _e475 = output_1[_e473];
            local_251 = _e475;
            break;
        }
    }
    uint _e478 = local_251;
    uint qualified_sum = ((_e395 + _e420) + _e449) + _e478;
    local_27 = static_cast<uint>(1);
    fixed = type_5 {};
    fixed.inner[0] = 4u;
    fixed.inner[1] = 0u;
    uint _e489 = local_27;
    uint _e491 = fixed.inner[1];
    fixed.inner[1] = _e491 + _e489;
    type_5 _e495 = fixed;
    local_28 = _e495;
    type_5 _e497 = local_28;
    mutable_copy = _e497;
    uint _e501 = mutable_copy.inner[1];
    mutable_copy.inner[1] = _e501 + 1u;
    type_5 _e505 = mutable_copy;
    local_29 = _e505;
    type_5 _e507 = local_29;
    local_252 = _e507;
    uint _e510 = local_252.inner[0];
    local_253 = static_cast<uint>(_e510);
    uint _e514 = local_252.inner[1];
    local_254 = static_cast<uint>(_e514);
    uint _e517 = local_254;
    uint _e519 = shared.inner[_e517];
    uint _e522 = local_254;
    shared.inner[_e522] = _e519 + 11u;
    type_5 _e524 = fixed;
    local_30 = _e524;
    type_5 _e526 = local_30;
    braced_fixed = _e526;
    uint _e530 = braced_fixed.inner[1];
    braced_fixed.inner[1] = _e530 + 1u;
    type_5 _e534 = fixed;
    local_31 = _e534;
    type_5 _e536 = local_31;
    local_255 = _e536;
    uint _e539 = local_255.inner[0];
    local_256 = static_cast<uint>(_e539);
    uint _e543 = local_255.inner[1];
    local_257 = static_cast<uint>(_e543);
    uint _e546 = local_257;
    uint fixed_snapshot = shared.inner[_e546];
    local_258 = type_5 {};
    local_258.inner[0] = 3u;
    local_258.inner[1] = 0u;
    type_5 _e555 = local_258;
    cursor = _e555;
    type_5 _e556 = cursor;
    local_32 = _e556;
    local_259 = type_5 {};
    local_259.inner[0] = 4u;
    local_259.inner[1] = 0u;
    type_5 _e564 = local_259;
    cursor = _e564;
    local_33 = static_cast<uint>(1u);
    type_5 _e568 = local_32;
    local_260 = _e568;
    uint _e570 = local_33;
    uint _e572 = local_260.inner[1];
    local_260.inner[1] = _e572 + _e570;
    uint _e576 = local_260.inner[0];
    local_261 = static_cast<uint>(_e576);
    uint _e580 = local_260.inner[1];
    local_262 = static_cast<uint>(_e580);
    uint _e583 = local_261;
    switch(_e583) {
        case 4u: {
            uint _e584 = local_262;
            uint _e586 = shared.inner[_e584];
            local_263 = _e586;
            break;
        }
        case 3u: {
            uint _e588 = local_262;
            uint _e590 = local.inner[_e588];
            local_263 = _e590;
            break;
        }
        default: {
            uint _e592 = local_262;
            uint _e594 = output_1[_e592];
            local_263 = _e594;
            break;
        }
    }
    uint functional_snapshot = local_263;
    local_264 = type_5 {};
    local_264.inner[0] = 4u;
    local_264.inner[1] = 0u;
    type_5 _e604 = local_264;
    cursor = _e604;
    type_5 _e605 = cursor;
    local_34 = _e605;
    type_5 _e607 = output;
    local_35 = _e607;
    local_36 = static_cast<uint>(32);
    type_5 _e612 = local_35;
    local_265 = _e612;
    uint _e614 = local_36;
    uint _e616 = local_265.inner[1];
    local_265.inner[1] = _e616 + _e614;
    type_5 _e619 = local_265;
    cursor = _e619;
    local_37 = static_cast<uint>(2u);
    type_5 _e623 = local_34;
    local_266 = _e623;
    uint _e625 = local_37;
    uint _e627 = local_266.inner[1];
    local_266.inner[1] = _e627 + _e625;
    uint _e631 = local_266.inner[0];
    local_267 = static_cast<uint>(_e631);
    uint _e635 = local_266.inner[1];
    local_268 = static_cast<uint>(_e635);
    uint _e638 = local_267;
    switch(_e638) {
        case 4u: {
            uint _e639 = local_268;
            uint _e641 = shared.inner[_e639];
            local_269 = _e641;
            break;
        }
        case 3u: {
            uint _e643 = local_268;
            uint _e645 = local.inner[_e643];
            local_269 = _e645;
            break;
        }
        default: {
            uint _e647 = local_268;
            uint _e649 = output_1[_e647];
            local_269 = _e649;
            break;
        }
    }
    uint braced_snapshot = local_269;
    type_5 _e653 = output;
    local_38 = _e653;
    local_39 = static_cast<uint>(32);
    type_5 _e658 = local_38;
    local_270 = _e658;
    uint _e660 = local_39;
    uint _e662 = local_270.inner[1];
    local_270.inner[1] = _e662 + _e660;
    type_5 _e665 = local_270;
    cursor = _e665;
    type_5 _e666 = cursor;
    local_40 = _e666;
    local_271 = type_5 {};
    local_271.inner[0] = 3u;
    local_271.inner[1] = 0u;
    type_5 _e674 = local_271;
    cursor = _e674;
    local_41 = static_cast<uint>(1u);
    type_5 _e678 = local_40;
    local_272 = _e678;
    uint _e680 = local_41;
    uint _e682 = local_272.inner[1];
    local_272.inner[1] = _e682 + _e680;
    uint _e686 = local_272.inner[0];
    local_273 = static_cast<uint>(_e686);
    uint _e690 = local_272.inner[1];
    local_274 = static_cast<uint>(_e690);
    uint _e693 = local_273;
    switch(_e693) {
        case 4u: {
            uint _e694 = local_274;
            uint _e696 = shared.inner[_e694];
            local_275 = _e696;
            break;
        }
        case 3u: {
            uint _e698 = local_274;
            uint _e700 = local.inner[_e698];
            local_275 = _e700;
            break;
        }
        default: {
            uint _e702 = local_274;
            uint _e704 = output_1[_e702];
            local_275 = _e704;
            break;
        }
    }
    uint named_snapshot = local_275;
    local_276 = type_5 {};
    local_276.inner[0] = 3u;
    local_276.inner[1] = 0u;
    type_5 _e714 = local_276;
    cursor = _e714;
    type_5 _e715 = cursor;
    local_42 = _e715;
    local_277 = type_5 {};
    local_277.inner[0] = 4u;
    local_277.inner[1] = 0u;
    type_5 _e723 = local_277;
    cursor = _e723;
    local_43 = static_cast<uint>(0u);
    type_5 _e727 = local_42;
    local_278 = _e727;
    uint _e729 = local_43;
    uint _e731 = local_278.inner[1];
    local_278.inner[1] = _e731 + _e729;
    uint _e735 = local_278.inner[0];
    local_279 = static_cast<uint>(_e735);
    uint _e739 = local_278.inner[1];
    local_280 = static_cast<uint>(_e739);
    uint _e742 = local_279;
    switch(_e742) {
        case 4u: {
            uint _e743 = local_280;
            uint _e745 = shared.inner[_e743];
            local_281 = _e745;
            break;
        }
        case 3u: {
            uint _e747 = local_280;
            uint _e749 = local.inner[_e747];
            local_281 = _e749;
            break;
        }
        default: {
            uint _e751 = local_280;
            uint _e753 = output_1[_e751];
            local_281 = _e753;
            break;
        }
    }
    uint c_style_snapshot = local_281;
    counter = 0u;
    index = 0u;
    uint _e761 = counter;
    counter = _e761 + static_cast<uint>(1);
    uint _e765 = index;
    index = _e765 + static_cast<uint>(1);
    captured = type_5 {};
    captured.inner[0] = 3u;
    captured.inner[1] = 0u;
    uint _e776 = captured.inner[1];
    captured.inner[1] = _e776 + _e765;
    type_5 _e780 = captured;
    local_44 = _e780;
    local_45 = static_cast<uint>(1);
    local_282 = type_5 {};
    local_282.inner[0] = 4u;
    local_282.inner[1] = 0u;
    uint _e791 = local_45;
    uint _e793 = local_282.inner[1];
    local_282.inner[1] = _e793 + _e791;
    type_5 _e796 = local_282;
    captured = _e796;
    index = 3u;
    type_5 _e798 = local_44;
    local_283 = _e798;
    uint _e801 = local_283.inner[0];
    local_284 = static_cast<uint>(_e801);
    uint _e805 = local_283.inner[1];
    local_285 = static_cast<uint>(_e805);
    uint _e808 = local_284;
    switch(_e808) {
        case 3u: {
            uint _e809 = local_285;
            uint _e811 = local.inner[_e809];
            local_286 = _e811;
            break;
        }
        default: {
            uint _e813 = local_285;
            uint _e815 = shared.inner[_e813];
            local_286 = _e815;
            break;
        }
    }
    uint _e818 = local_286;
    uint _e820 = _e818 + 13u;
    uint _e821 = local_284;
    switch(_e821) {
        case 3u: {
            uint _e822 = local_285;
            local.inner[_e822] = _e820;
            break;
        }
        default: {
            uint _e824 = local_285;
            shared.inner[_e824] = _e820;
            break;
        }
    }
    uint _e826 = counter;
    counter = _e826 + static_cast<uint>(1);
    uint _e830 = index;
    index = _e830 - static_cast<uint>(1);
    frozen = type_5 {};
    frozen.inner[0] = 3u;
    frozen.inner[1] = 0u;
    uint _e841 = frozen.inner[1];
    frozen.inner[1] = _e841 + _e830;
    index = 0u;
    type_5 _e845 = functional;
    local_46 = _e845;
    type_5 _e847 = local_46;
    local_287 = _e847;
    uint _e850 = local_287.inner[0];
    local_288 = static_cast<uint>(_e850);
    uint _e854 = local_287.inner[1];
    local_289 = static_cast<uint>(_e854);
    uint _e857 = local_288;
    switch(_e857) {
        case 4u: {
            uint _e858 = local_289;
            uint _e860 = shared.inner[_e858];
            local_290 = _e860;
            break;
        }
        case 3u: {
            uint _e862 = local_289;
            uint _e864 = local.inner[_e862];
            local_290 = _e864;
            break;
        }
        default: {
            uint _e866 = local_289;
            uint _e868 = output_1[_e866];
            local_290 = _e868;
            break;
        }
    }
    uint _e871 = local_290;
    uint _e873 = _e871 + 2u;
    uint _e874 = local_288;
    switch(_e874) {
        case 4u: {
            uint _e875 = local_289;
            shared.inner[_e875] = _e873;
            break;
        }
        case 3u: {
            uint _e877 = local_289;
            local.inner[_e877] = _e873;
            break;
        }
        default: {
            uint _e879 = local_289;
            output_1[_e879] = _e873;
            break;
        }
    }
    uint after_capture = counter;
    selected = type_5 {};
    selected.inner[0] = 1u;
    guarded_total = 0u;
    {
        branch = 0u;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e1093 = branch;
                branch = _e1093 + static_cast<uint>(1);
            }
            loop_init = false;
            uint _e890 = branch;
            if (_e890 < 3u) {
            } else {
                break;
            }
            uint _e893 = branch;
            if (_e893 == 0u) {
                local_53 = 0u;
                local_52 = 1u;
            } else {
                uint _e900 = branch;
                if (_e900 == 1u) {
                    local_47 = static_cast<uint>(1);
                    local_51 = 0u;
                    local_50 = 1u;
                } else {
                    type_5 _e910 = output;
                    local_48 = _e910;
                    local_49 = static_cast<uint>(32);
                    local_51 = 0u;
                    local_50 = 0u;
                }
                uint _e920 = local_51;
                local_53 = _e920;
                local_52 = 0u;
            }
            uint _e925 = local_52;
            if (_e925 != 0u) {
                local_291 = type_5 {};
                local_291.inner[0] = 1u;
            } else {
                uint _e933 = local_50;
                if (_e933 != 0u) {
                    local_291 = type_5 {};
                    local_291.inner[0] = 4u;
                    local_291.inner[1] = 0u;
                    uint _e943 = local_47;
                    uint _e945 = local_291.inner[1];
                    local_291.inner[1] = _e945 + _e943;
                } else {
                    type_5 _e949 = local_48;
                    local_291 = _e949;
                    uint _e952 = local_49;
                    uint _e954 = local_291.inner[1];
                    local_291.inner[1] = _e954 + _e952;
                }
            }
            uint _e958 = local_53;
            uint _e961 = local_291.inner[1];
            local_291.inner[1] = _e961 + _e958;
            type_5 _e964 = local_291;
            selected = _e964;
            type_5 _e966 = selected;
            local_54 = _e966;
            type_5 _e968 = local_54;
            saved = _e968;
            local_292 = type_5 {};
            local_292.inner[0] = 1u;
            type_5 _e974 = local_292;
            selected = _e974;
            type_5 _e976 = saved;
            local_55 = _e976;
            type_5 _e978 = local_55;
            local_293 = _e978;
            uint _e981 = local_293.inner[0];
            local_56 = _e981 != 1u;
            bool _e985 = local_56;
            if (_e985) {
                uint _e986 = branch;
                type_5 _e987 = saved;
                local_57 = _e987;
                type_5 _e989 = local_57;
                local_294 = _e989;
                uint _e992 = local_294.inner[0];
                local_295 = static_cast<uint>(_e992);
                uint _e996 = local_294.inner[1];
                local_296 = static_cast<uint>(_e996);
                local_297 = uint {};
                uint _e1001 = local_295;
                switch(_e1001) {
                    case 4u: {
                        uint _e1002 = local_296;
                        uint _e1004 = shared.inner[_e1002];
                        local_297 = _e1004;
                        break;
                    }
                    case 2u: {
                        uint _e1005 = local_296;
                        uint _e1007 = output_1[_e1005];
                        local_297 = _e1007;
                        break;
                    }
                    default: {
                        break;
                    }
                }
                uint _e1008 = local_297;
                local_183 = _e1008;
                uint _e1010 = local_183;
                uint _e1011 = _e1010 + _e986;
                uint _e1012 = local_295;
                switch(_e1012) {
                    case 4u: {
                        uint _e1013 = local_296;
                        shared.inner[_e1013] = _e1011;
                        break;
                    }
                    case 2u: {
                        uint _e1015 = local_296;
                        output_1[_e1015] = _e1011;
                        break;
                    }
                    default: {
                        break;
                    }
                }
                type_5 _e1017 = saved;
                local_58 = _e1017;
                type_5 _e1019 = local_58;
                local_298 = _e1019;
                uint _e1022 = local_298.inner[0];
                local_299 = static_cast<uint>(_e1022);
                uint _e1026 = local_298.inner[1];
                local_300 = static_cast<uint>(_e1026);
                local_301 = uint {};
                uint _e1031 = local_299;
                switch(_e1031) {
                    case 4u: {
                        uint _e1032 = local_300;
                        uint _e1034 = shared.inner[_e1032];
                        local_301 = _e1034;
                        break;
                    }
                    case 2u: {
                        uint _e1035 = local_300;
                        uint _e1037 = output_1[_e1035];
                        local_301 = _e1037;
                        break;
                    }
                    default: {
                        break;
                    }
                }
                uint _e1038 = local_301;
                local_184 = _e1038;
                uint _e1040 = local_184;
                uint _e1041 = guarded_total;
                guarded_total = _e1041 + _e1040;
            }
            type_5 _e1043 = selected;
            local_61 = _e1043;
            type_5 _e1045 = local_61;
            local_302 = _e1045;
            uint _e1048 = local_302.inner[0];
            local_62 = _e1048 != 1u;
            bool _e1052 = local_62;
            type_5 _e1055 = saved;
            local_63 = _e1055;
            type_5 _e1057 = local_63;
            local_303 = _e1057;
            uint _e1060 = local_303.inner[0];
            local_64 = _e1060 != 1u;
            bool _e1064 = local_64;
            type_5 _e1069 = output;
            local_59 = _e1069;
            uint _e1071 = branch;
            local_60 = static_cast<uint>(22u + _e1071);
            type_5 _e1076 = local_59;
            local_304 = _e1076;
            uint _e1078 = local_60;
            uint _e1080 = local_304.inner[1];
            local_304.inner[1] = _e1080 + _e1078;
            uint _e1084 = local_304.inner[0];
            local_305 = static_cast<uint>(_e1084);
            uint _e1088 = local_304.inner[1];
            local_306 = static_cast<uint>(_e1088);
            uint _e1091 = local_306;
            output_1[_e1091] = static_cast<uint>(!(_e1052)) + (2u * static_cast<uint>(_e1064));
        }
    }
    type_5 _e1097 = output;
    local_65 = _e1097;
    local_66 = static_cast<uint>(33);
    type_5 _e1102 = local_65;
    kept = _e1102;
    uint _e1104 = local_66;
    uint _e1106 = kept.inner[1];
    kept.inner[1] = _e1106 + _e1104;
    type_5 _e1110 = selected;
    local_67 = _e1110;
    type_5 _e1112 = local_67;
    old_null = _e1112;
    type_5 _e1115 = kept;
    local_68 = _e1115;
    type_5 _e1117 = local_68;
    local_307 = _e1117;
    type_5 _e1119 = local_307;
    selected = _e1119;
    local_308 = type_5 {};
    local_308.inner[0] = 1u;
    type_5 _e1124 = local_308;
    kept = _e1124;
    type_5 _e1126 = old_null;
    local_69 = _e1126;
    type_5 _e1128 = local_69;
    local_309 = _e1128;
    uint _e1131 = local_309.inner[0];
    local_70 = _e1131 != 1u;
    bool _e1135 = local_70;
    if (_e1135) {
        type_5 _e1136 = output;
        local_71 = _e1136;
        local_72 = static_cast<uint>(34);
        type_5 _e1141 = local_71;
        local_310 = _e1141;
        uint _e1143 = local_72;
        uint _e1145 = local_310.inner[1];
        local_310.inner[1] = _e1145 + _e1143;
        uint _e1149 = local_310.inner[0];
        local_311 = static_cast<uint>(_e1149);
        uint _e1153 = local_310.inner[1];
        local_312 = static_cast<uint>(_e1153);
        uint _e1156 = local_312;
        uint _e1158 = output_1[_e1156];
        local_313 = _e1158;
        uint _e1160 = local_313;
        local_185 = _e1160;
        uint _e1162 = local_185;
        uint _e1165 = local_312;
        output_1[_e1165] = _e1162 + 1000u;
    }
    type_5 _e1167 = selected;
    local_73 = _e1167;
    type_5 _e1169 = local_73;
    local_314 = _e1169;
    uint _e1172 = local_314.inner[0];
    local_74 = _e1172 != 1u;
    bool _e1176 = local_74;
    if (_e1176) {
        type_5 _e1177 = selected;
        local_75 = _e1177;
        type_5 _e1179 = local_75;
        local_315 = _e1179;
        uint _e1182 = local_315.inner[0];
        local_316 = static_cast<uint>(_e1182);
        uint _e1186 = local_315.inner[1];
        local_317 = static_cast<uint>(_e1186);
        local_318 = uint {};
        uint _e1191 = local_316;
        switch(_e1191) {
            case 4u: {
                uint _e1192 = local_317;
                uint _e1194 = shared.inner[_e1192];
                local_318 = _e1194;
                break;
            }
            case 2u: {
                uint _e1195 = local_317;
                uint _e1197 = output_1[_e1195];
                local_318 = _e1197;
                break;
            }
            default: {
                break;
            }
        }
        uint _e1198 = local_318;
        local_186 = _e1198;
        uint _e1200 = local_186;
        uint _e1202 = _e1200 + 5u;
        uint _e1203 = local_316;
        switch(_e1203) {
            case 4u: {
                uint _e1204 = local_317;
                shared.inner[_e1204] = _e1202;
                break;
            }
            case 2u: {
                uint _e1206 = local_317;
                output_1[_e1206] = _e1202;
                break;
            }
            default: {
                break;
            }
        }
    }
    type_5 _e1208 = selected;
    local_76 = _e1208;
    type_5 _e1210 = local_76;
    local_319 = _e1210;
    uint _e1213 = local_319.inner[0];
    local_320 = static_cast<uint>(_e1213);
    uint _e1217 = local_319.inner[1];
    local_321 = static_cast<uint>(_e1217);
    local_322 = uint {};
    uint _e1222 = local_320;
    switch(_e1222) {
        case 4u: {
            uint _e1223 = local_321;
            uint _e1225 = shared.inner[_e1223];
            local_322 = _e1225;
            break;
        }
        case 2u: {
            uint _e1226 = local_321;
            uint _e1228 = output_1[_e1226];
            local_322 = _e1228;
            break;
        }
        default: {
            break;
        }
    }
    uint selected_snapshot = local_322;
    type_5 _e1230 = selected;
    local_77 = _e1230;
    type_5 _e1232 = local_77;
    local_323 = _e1232;
    uint _e1235 = local_323.inner[0];
    local_78 = _e1235 != 1u;
    bool _e1239 = local_78;
    local_324 = type_5 {};
    local_324.inner[0] = 1u;
    type_5 _e1244 = local_324;
    selected = _e1244;
    uint _e1245 = counter;
    counter = _e1245 + static_cast<uint>(1);
    type_5 _e1249 = output;
    local_79 = _e1249;
    local_80 = static_cast<uint>(34);
    amount = uint {};
    local_188 = bool {};
    local_190 = uint {};
    type_5 _e1260 = local_79;
    value = _e1260;
    uint _e1262 = local_80;
    uint _e1264 = value.inner[1];
    value.inner[1] = _e1264 + _e1262;
    amount = 7u;
    uint _e1269 = counter;
    counter = _e1269 + static_cast<uint>(1);
    type_5 _e1274 = value;
    local_187 = _e1274;
    type_5 _e1276 = local_187;
    local_325 = _e1276;
    uint _e1279 = local_325.inner[0];
    local_188 = _e1279 != 1u;
    bool _e1283 = local_188;
    if (_e1283) {
        uint _e1284 = amount;
        type_5 _e1285 = value;
        local_189 = _e1285;
        type_5 _e1287 = local_189;
        local_326 = _e1287;
        uint _e1290 = local_326.inner[0];
        local_327 = static_cast<uint>(_e1290);
        uint _e1294 = local_326.inner[1];
        local_328 = static_cast<uint>(_e1294);
        uint _e1297 = local_328;
        uint _e1299 = output_1[_e1297];
        local_329 = _e1299;
        uint _e1301 = local_329;
        local_191 = _e1301;
        uint _e1303 = local_191;
        local_190 = _e1303;
        uint _e1305 = local_190;
        uint _e1307 = local_328;
        output_1[_e1307] = _e1305 + _e1284;
    }
    amount_1 = uint {};
    local_193 = bool {};
    local_195 = uint {};
    value_1 = type_5 {};
    value_1.inner[0] = 1u;
    amount_1 = 1000u;
    uint _e1321 = counter;
    counter = _e1321 + static_cast<uint>(1);
    type_5 _e1326 = value_1;
    local_192 = _e1326;
    type_5 _e1328 = local_192;
    local_330 = _e1328;
    uint _e1331 = local_330.inner[0];
    local_193 = _e1331 != 1u;
    bool _e1335 = local_193;
    if (_e1335) {
        type_5 _e1336 = value_1;
        local_194 = _e1336;
        type_5 _e1338 = local_194;
        local_331 = _e1338;
        uint _e1341 = local_331.inner[0];
        local_332 = static_cast<uint>(_e1341);
        uint _e1345 = local_331.inner[1];
        local_333 = static_cast<uint>(_e1345);
        local_334 = uint {};
        uint _e1350 = local_334;
        local_196 = _e1350;
        uint _e1352 = local_196;
        local_195 = _e1352;
    }
    type_5 _e1355 = empty;
    local_83 = _e1355;
    type_5 _e1357 = local_83;
    local_335 = _e1357;
    uint _e1360 = local_335.inner[0];
    local_84 = _e1360 != 1u;
    bool _e1364 = local_84;
    type_5 _e1368 = braced_empty;
    local_85 = _e1368;
    type_5 _e1370 = local_85;
    local_336 = _e1370;
    uint _e1373 = local_336.inner[0];
    local_86 = _e1373 != 1u;
    bool _e1377 = local_86;
    type_5 _e1382 = from_zero;
    local_87 = _e1382;
    type_5 _e1384 = local_87;
    local_337 = _e1384;
    uint _e1387 = local_337.inner[0];
    local_88 = _e1387 != 1u;
    bool _e1391 = local_88;
    type_5 _e1396 = from_braced_zero;
    local_89 = _e1396;
    type_5 _e1398 = local_89;
    local_338 = _e1398;
    uint _e1401 = local_338.inner[0];
    local_90 = _e1401 != 1u;
    bool _e1405 = local_90;
    type_5 _e1410 = qualified_null;
    local_91 = _e1410;
    type_5 _e1412 = local_91;
    local_339 = _e1412;
    uint _e1415 = local_339.inner[0];
    local_92 = _e1415 != 1u;
    bool _e1419 = local_92;
    type_5 _e1424 = cast_null;
    local_93 = _e1424;
    type_5 _e1426 = local_93;
    local_340 = _e1426;
    uint _e1429 = local_340.inner[0];
    local_94 = _e1429 != 1u;
    bool _e1433 = local_94;
    type_5 _e1437 = output;
    local_81 = _e1437;
    local_82 = static_cast<uint>(0);
    type_5 _e1442 = local_81;
    local_341 = _e1442;
    uint _e1444 = local_82;
    uint _e1446 = local_341.inner[1];
    local_341.inner[1] = _e1446 + _e1444;
    uint _e1450 = local_341.inner[0];
    local_342 = static_cast<uint>(_e1450);
    uint _e1454 = local_341.inner[1];
    local_343 = static_cast<uint>(_e1454);
    uint _e1457 = local_343;
    output_1[_e1457] = ((((static_cast<uint>(!(_e1364)) + static_cast<uint>(!(_e1377))) + static_cast<uint>(!(_e1391))) + static_cast<uint>(!(_e1405))) + static_cast<uint>(!(_e1419))) + static_cast<uint>(!(_e1433));
    uint _e1459 = absent_unsigned_u002a();
    uint _e1460 = absent_const_u0020_unsigned_u002a();
    type_5 _e1462 = output;
    local_95 = _e1462;
    local_96 = static_cast<uint>(1);
    type_5 _e1467 = local_95;
    local_344 = _e1467;
    uint _e1469 = local_96;
    uint _e1471 = local_344.inner[1];
    local_344.inner[1] = _e1471 + _e1469;
    uint _e1475 = local_344.inner[0];
    local_345 = static_cast<uint>(_e1475);
    uint _e1479 = local_344.inner[1];
    local_346 = static_cast<uint>(_e1479);
    uint _e1482 = local_346;
    output_1[_e1482] = _e1459 + _e1460;
    type_5 _e1484 = output;
    local_97 = _e1484;
    local_98 = static_cast<uint>(2);
    type_5 _e1489 = local_97;
    local_347 = _e1489;
    uint _e1491 = local_98;
    uint _e1493 = local_347.inner[1];
    local_347.inner[1] = _e1493 + _e1491;
    uint _e1497 = local_347.inner[0];
    local_348 = static_cast<uint>(_e1497);
    uint _e1501 = local_347.inner[1];
    local_349 = static_cast<uint>(_e1501);
    uint _e1504 = local_349;
    output_1[_e1504] = first_copy;
    type_5 _e1506 = braced;
    local_101 = _e1506;
    type_5 _e1508 = local_101;
    local_350 = _e1508;
    uint _e1511 = local_350.inner[0];
    local_351 = static_cast<uint>(_e1511);
    uint _e1515 = local_350.inner[1];
    local_352 = static_cast<uint>(_e1515);
    uint _e1518 = local_351;
    switch(_e1518) {
        case 4u: {
            uint _e1519 = local_352;
            uint _e1521 = shared.inner[_e1519];
            local_353 = _e1521;
            break;
        }
        case 3u: {
            uint _e1523 = local_352;
            uint _e1525 = local.inner[_e1523];
            local_353 = _e1525;
            break;
        }
        default: {
            uint _e1527 = local_352;
            uint _e1529 = output_1[_e1527];
            local_353 = _e1529;
            break;
        }
    }
    uint _e1532 = local_353;
    type_5 _e1533 = output;
    local_99 = _e1533;
    local_100 = static_cast<uint>(3);
    type_5 _e1538 = local_99;
    local_354 = _e1538;
    uint _e1540 = local_100;
    uint _e1542 = local_354.inner[1];
    local_354.inner[1] = _e1542 + _e1540;
    uint _e1546 = local_354.inner[0];
    local_355 = static_cast<uint>(_e1546);
    uint _e1550 = local_354.inner[1];
    local_356 = static_cast<uint>(_e1550);
    uint _e1553 = local_356;
    output_1[_e1553] = _e1532;
    type_5 _e1555 = named;
    local_104 = _e1555;
    type_5 _e1557 = local_104;
    local_357 = _e1557;
    uint _e1560 = local_357.inner[0];
    local_358 = static_cast<uint>(_e1560);
    uint _e1564 = local_357.inner[1];
    local_359 = static_cast<uint>(_e1564);
    uint _e1567 = local_358;
    switch(_e1567) {
        case 4u: {
            uint _e1568 = local_359;
            uint _e1570 = shared.inner[_e1568];
            local_360 = _e1570;
            break;
        }
        case 3u: {
            uint _e1572 = local_359;
            uint _e1574 = local.inner[_e1572];
            local_360 = _e1574;
            break;
        }
        default: {
            uint _e1576 = local_359;
            uint _e1578 = output_1[_e1576];
            local_360 = _e1578;
            break;
        }
    }
    uint _e1581 = local_360;
    type_5 _e1582 = output;
    local_102 = _e1582;
    local_103 = static_cast<uint>(4);
    type_5 _e1587 = local_102;
    local_361 = _e1587;
    uint _e1589 = local_103;
    uint _e1591 = local_361.inner[1];
    local_361.inner[1] = _e1591 + _e1589;
    uint _e1595 = local_361.inner[0];
    local_362 = static_cast<uint>(_e1595);
    uint _e1599 = local_361.inner[1];
    local_363 = static_cast<uint>(_e1599);
    uint _e1602 = local_363;
    output_1[_e1602] = _e1581;
    type_5 _e1604 = c_style;
    local_107 = _e1604;
    type_5 _e1606 = local_107;
    local_364 = _e1606;
    uint _e1609 = local_364.inner[0];
    local_365 = static_cast<uint>(_e1609);
    uint _e1613 = local_364.inner[1];
    local_366 = static_cast<uint>(_e1613);
    uint _e1616 = local_365;
    switch(_e1616) {
        case 4u: {
            uint _e1617 = local_366;
            uint _e1619 = shared.inner[_e1617];
            local_367 = _e1619;
            break;
        }
        case 3u: {
            uint _e1621 = local_366;
            uint _e1623 = local.inner[_e1621];
            local_367 = _e1623;
            break;
        }
        default: {
            uint _e1625 = local_366;
            uint _e1627 = output_1[_e1625];
            local_367 = _e1627;
            break;
        }
    }
    uint _e1630 = local_367;
    type_5 _e1631 = output;
    local_105 = _e1631;
    local_106 = static_cast<uint>(5);
    type_5 _e1636 = local_105;
    local_368 = _e1636;
    uint _e1638 = local_106;
    uint _e1640 = local_368.inner[1];
    local_368.inner[1] = _e1640 + _e1638;
    uint _e1644 = local_368.inner[0];
    local_369 = static_cast<uint>(_e1644);
    uint _e1648 = local_368.inner[1];
    local_370 = static_cast<uint>(_e1648);
    uint _e1651 = local_370;
    output_1[_e1651] = _e1630;
    type_5 _e1653 = cursor;
    local_110 = _e1653;
    type_5 _e1655 = local_110;
    local_371 = _e1655;
    uint _e1658 = local_371.inner[0];
    local_372 = static_cast<uint>(_e1658);
    uint _e1662 = local_371.inner[1];
    local_373 = static_cast<uint>(_e1662);
    uint _e1665 = local_372;
    switch(_e1665) {
        case 4u: {
            uint _e1666 = local_373;
            uint _e1668 = shared.inner[_e1666];
            local_374 = _e1668;
            break;
        }
        case 3u: {
            uint _e1670 = local_373;
            uint _e1672 = local.inner[_e1670];
            local_374 = _e1672;
            break;
        }
        default: {
            uint _e1674 = local_373;
            uint _e1676 = output_1[_e1674];
            local_374 = _e1676;
            break;
        }
    }
    uint _e1679 = local_374;
    type_5 _e1680 = output;
    local_108 = _e1680;
    local_109 = static_cast<uint>(6);
    type_5 _e1685 = local_108;
    local_375 = _e1685;
    uint _e1687 = local_109;
    uint _e1689 = local_375.inner[1];
    local_375.inner[1] = _e1689 + _e1687;
    uint _e1693 = local_375.inner[0];
    local_376 = static_cast<uint>(_e1693);
    uint _e1697 = local_375.inner[1];
    local_377 = static_cast<uint>(_e1697);
    uint _e1700 = local_377;
    output_1[_e1700] = _e1679;
    type_5 _e1702 = output;
    local_111 = _e1702;
    local_112 = static_cast<uint>(7);
    type_5 _e1707 = local_111;
    local_378 = _e1707;
    uint _e1709 = local_112;
    uint _e1711 = local_378.inner[1];
    local_378.inner[1] = _e1711 + _e1709;
    uint _e1715 = local_378.inner[0];
    local_379 = static_cast<uint>(_e1715);
    uint _e1719 = local_378.inner[1];
    local_380 = static_cast<uint>(_e1719);
    uint _e1722 = local_380;
    output_1[_e1722] = qualified_sum;
    type_5 _e1724 = output;
    local_113 = _e1724;
    local_114 = static_cast<uint>(8);
    type_5 _e1729 = local_113;
    local_381 = _e1729;
    uint _e1731 = local_114;
    uint _e1733 = local_381.inner[1];
    local_381.inner[1] = _e1733 + _e1731;
    uint _e1737 = local_381.inner[0];
    local_382 = static_cast<uint>(_e1737);
    uint _e1741 = local_381.inner[1];
    local_383 = static_cast<uint>(_e1741);
    uint _e1744 = local_383;
    output_1[_e1744] = fixed_snapshot;
    type_5 _e1746 = mutable_copy;
    local_117 = _e1746;
    type_5 _e1748 = local_117;
    local_384 = _e1748;
    uint _e1751 = local_384.inner[0];
    local_385 = static_cast<uint>(_e1751);
    uint _e1755 = local_384.inner[1];
    local_386 = static_cast<uint>(_e1755);
    uint _e1758 = local_386;
    uint _e1760 = shared.inner[_e1758];
    type_5 _e1761 = output;
    local_115 = _e1761;
    local_116 = static_cast<uint>(9);
    type_5 _e1766 = local_115;
    local_387 = _e1766;
    uint _e1768 = local_116;
    uint _e1770 = local_387.inner[1];
    local_387.inner[1] = _e1770 + _e1768;
    uint _e1774 = local_387.inner[0];
    local_388 = static_cast<uint>(_e1774);
    uint _e1778 = local_387.inner[1];
    local_389 = static_cast<uint>(_e1778);
    uint _e1781 = local_389;
    output_1[_e1781] = _e1760;
    type_5 _e1783 = braced_fixed;
    local_120 = _e1783;
    type_5 _e1785 = local_120;
    local_390 = _e1785;
    uint _e1788 = local_390.inner[0];
    local_391 = static_cast<uint>(_e1788);
    uint _e1792 = local_390.inner[1];
    local_392 = static_cast<uint>(_e1792);
    uint _e1795 = local_392;
    uint _e1797 = shared.inner[_e1795];
    type_5 _e1798 = output;
    local_118 = _e1798;
    local_119 = static_cast<uint>(10);
    type_5 _e1803 = local_118;
    local_393 = _e1803;
    uint _e1805 = local_119;
    uint _e1807 = local_393.inner[1];
    local_393.inner[1] = _e1807 + _e1805;
    uint _e1811 = local_393.inner[0];
    local_394 = static_cast<uint>(_e1811);
    uint _e1815 = local_393.inner[1];
    local_395 = static_cast<uint>(_e1815);
    uint _e1818 = local_395;
    output_1[_e1818] = _e1797;
    type_5 _e1820 = output;
    local_121 = _e1820;
    local_122 = static_cast<uint>(11);
    type_5 _e1825 = local_121;
    local_396 = _e1825;
    uint _e1827 = local_122;
    uint _e1829 = local_396.inner[1];
    local_396.inner[1] = _e1829 + _e1827;
    uint _e1833 = local_396.inner[0];
    local_397 = static_cast<uint>(_e1833);
    uint _e1837 = local_396.inner[1];
    local_398 = static_cast<uint>(_e1837);
    uint _e1840 = local_398;
    output_1[_e1840] = functional_snapshot;
    type_5 _e1842 = output;
    local_123 = _e1842;
    local_124 = static_cast<uint>(12);
    type_5 _e1847 = local_123;
    local_399 = _e1847;
    uint _e1849 = local_124;
    uint _e1851 = local_399.inner[1];
    local_399.inner[1] = _e1851 + _e1849;
    uint _e1855 = local_399.inner[0];
    local_400 = static_cast<uint>(_e1855);
    uint _e1859 = local_399.inner[1];
    local_401 = static_cast<uint>(_e1859);
    uint _e1862 = local_401;
    output_1[_e1862] = braced_snapshot;
    type_5 _e1864 = output;
    local_125 = _e1864;
    local_126 = static_cast<uint>(13);
    type_5 _e1869 = local_125;
    local_402 = _e1869;
    uint _e1871 = local_126;
    uint _e1873 = local_402.inner[1];
    local_402.inner[1] = _e1873 + _e1871;
    uint _e1877 = local_402.inner[0];
    local_403 = static_cast<uint>(_e1877);
    uint _e1881 = local_402.inner[1];
    local_404 = static_cast<uint>(_e1881);
    uint _e1884 = local_404;
    output_1[_e1884] = named_snapshot;
    type_5 _e1886 = output;
    local_127 = _e1886;
    local_128 = static_cast<uint>(14);
    type_5 _e1891 = local_127;
    local_405 = _e1891;
    uint _e1893 = local_128;
    uint _e1895 = local_405.inner[1];
    local_405.inner[1] = _e1895 + _e1893;
    uint _e1899 = local_405.inner[0];
    local_406 = static_cast<uint>(_e1899);
    uint _e1903 = local_405.inner[1];
    local_407 = static_cast<uint>(_e1903);
    uint _e1906 = local_407;
    output_1[_e1906] = c_style_snapshot;
    type_5 _e1908 = cursor;
    local_131 = _e1908;
    type_5 _e1910 = local_131;
    local_408 = _e1910;
    uint _e1913 = local_408.inner[0];
    local_409 = static_cast<uint>(_e1913);
    uint _e1917 = local_408.inner[1];
    local_410 = static_cast<uint>(_e1917);
    uint _e1920 = local_409;
    switch(_e1920) {
        case 4u: {
            uint _e1921 = local_410;
            uint _e1923 = shared.inner[_e1921];
            local_411 = _e1923;
            break;
        }
        case 3u: {
            uint _e1925 = local_410;
            uint _e1927 = local.inner[_e1925];
            local_411 = _e1927;
            break;
        }
        default: {
            uint _e1929 = local_410;
            uint _e1931 = output_1[_e1929];
            local_411 = _e1931;
            break;
        }
    }
    uint _e1934 = local_411;
    type_5 _e1935 = output;
    local_129 = _e1935;
    local_130 = static_cast<uint>(15);
    type_5 _e1940 = local_129;
    local_412 = _e1940;
    uint _e1942 = local_130;
    uint _e1944 = local_412.inner[1];
    local_412.inner[1] = _e1944 + _e1942;
    uint _e1948 = local_412.inner[0];
    local_413 = static_cast<uint>(_e1948);
    uint _e1952 = local_412.inner[1];
    local_414 = static_cast<uint>(_e1952);
    uint _e1955 = local_414;
    output_1[_e1955] = _e1934;
    uint _e1957 = local_284;
    switch(_e1957) {
        case 3u: {
            uint _e1958 = local_285;
            uint _e1960 = local.inner[_e1958];
            local_415 = _e1960;
            break;
        }
        default: {
            uint _e1962 = local_285;
            uint _e1964 = shared.inner[_e1962];
            local_415 = _e1964;
            break;
        }
    }
    uint _e1967 = local_415;
    type_5 _e1968 = output;
    local_132 = _e1968;
    local_133 = static_cast<uint>(16);
    type_5 _e1973 = local_132;
    local_416 = _e1973;
    uint _e1975 = local_133;
    uint _e1977 = local_416.inner[1];
    local_416.inner[1] = _e1977 + _e1975;
    uint _e1981 = local_416.inner[0];
    local_417 = static_cast<uint>(_e1981);
    uint _e1985 = local_416.inner[1];
    local_418 = static_cast<uint>(_e1985);
    uint _e1988 = local_418;
    output_1[_e1988] = _e1967;
    type_5 _e1990 = captured;
    local_136 = _e1990;
    type_5 _e1992 = local_136;
    local_419 = _e1992;
    uint _e1995 = local_419.inner[0];
    local_420 = static_cast<uint>(_e1995);
    uint _e1999 = local_419.inner[1];
    local_421 = static_cast<uint>(_e1999);
    uint _e2002 = local_420;
    switch(_e2002) {
        case 3u: {
            uint _e2003 = local_421;
            uint _e2005 = local.inner[_e2003];
            local_422 = _e2005;
            break;
        }
        default: {
            uint _e2007 = local_421;
            uint _e2009 = shared.inner[_e2007];
            local_422 = _e2009;
            break;
        }
    }
    uint _e2012 = local_422;
    type_5 _e2013 = output;
    local_134 = _e2013;
    local_135 = static_cast<uint>(17);
    type_5 _e2018 = local_134;
    local_423 = _e2018;
    uint _e2020 = local_135;
    uint _e2022 = local_423.inner[1];
    local_423.inner[1] = _e2022 + _e2020;
    uint _e2026 = local_423.inner[0];
    local_424 = static_cast<uint>(_e2026);
    uint _e2030 = local_423.inner[1];
    local_425 = static_cast<uint>(_e2030);
    uint _e2033 = local_425;
    output_1[_e2033] = _e2012;
    type_5 _e2036 = frozen;
    local_139 = _e2036;
    type_5 _e2038 = local_139;
    local_426 = _e2038;
    uint _e2041 = local_426.inner[0];
    local_427 = static_cast<uint>(_e2041);
    uint _e2045 = local_426.inner[1];
    local_428 = static_cast<uint>(_e2045);
    uint _e2048 = local_428;
    uint _e2050 = local.inner[_e2048];
    type_5 _e2051 = output;
    local_137 = _e2051;
    local_138 = static_cast<uint>(18);
    type_5 _e2056 = local_137;
    local_429 = _e2056;
    uint _e2058 = local_138;
    uint _e2060 = local_429.inner[1];
    local_429.inner[1] = _e2060 + _e2058;
    uint _e2064 = local_429.inner[0];
    local_430 = static_cast<uint>(_e2064);
    uint _e2068 = local_429.inner[1];
    local_431 = static_cast<uint>(_e2068);
    uint _e2071 = local_431;
    output_1[_e2071] = _e2050;
    uint _e2073 = index;
    type_5 _e2074 = output;
    local_140 = _e2074;
    local_141 = static_cast<uint>(19);
    type_5 _e2079 = local_140;
    local_432 = _e2079;
    uint _e2081 = local_141;
    uint _e2083 = local_432.inner[1];
    local_432.inner[1] = _e2083 + _e2081;
    uint _e2087 = local_432.inner[0];
    local_433 = static_cast<uint>(_e2087);
    uint _e2091 = local_432.inner[1];
    local_434 = static_cast<uint>(_e2091);
    uint _e2094 = local_434;
    output_1[_e2094] = _e2073;
    type_5 _e2096 = output;
    local_142 = _e2096;
    local_143 = static_cast<uint>(20);
    type_5 _e2101 = local_142;
    local_435 = _e2101;
    uint _e2103 = local_143;
    uint _e2105 = local_435.inner[1];
    local_435.inner[1] = _e2105 + _e2103;
    uint _e2109 = local_435.inner[0];
    local_436 = static_cast<uint>(_e2109);
    uint _e2113 = local_435.inner[1];
    local_437 = static_cast<uint>(_e2113);
    uint _e2116 = local_437;
    output_1[_e2116] = after_capture;
    local_199 = uint {};
    source = type_5 {};
    source.inner[0] = 3u;
    source.inner[1] = 0u;
    type_5 _e2127 = source;
    local_197 = _e2127;
    type_5 _e2129 = local_197;
    copy = _e2129;
    type_5 _e2132 = copy;
    local_198 = _e2132;
    type_5 _e2134 = local_198;
    local_438 = _e2134;
    uint _e2137 = local_438.inner[0];
    local_439 = static_cast<uint>(_e2137);
    uint _e2141 = local_438.inner[1];
    local_440 = static_cast<uint>(_e2141);
    uint _e2144 = local_440;
    uint _e2146 = local.inner[_e2144];
    local_199 = _e2146;
    uint _e2148 = local_199;
    local_202 = uint {};
    source_1 = type_5 {};
    source_1.inner[0] = 4u;
    source_1.inner[1] = 0u;
    type_5 _e2158 = source_1;
    local_200 = _e2158;
    type_5 _e2160 = local_200;
    copy_1 = _e2160;
    type_5 _e2163 = copy_1;
    local_201 = _e2163;
    type_5 _e2165 = local_201;
    local_441 = _e2165;
    uint _e2168 = local_441.inner[0];
    local_442 = static_cast<uint>(_e2168);
    uint _e2172 = local_441.inner[1];
    local_443 = static_cast<uint>(_e2172);
    uint _e2175 = local_443;
    uint _e2177 = shared.inner[_e2175];
    local_202 = _e2177;
    uint _e2179 = local_202;
    type_5 _e2181 = output;
    local_144 = _e2181;
    local_145 = static_cast<uint>(21);
    type_5 _e2186 = local_144;
    local_444 = _e2186;
    uint _e2188 = local_145;
    uint _e2190 = local_444.inner[1];
    local_444.inner[1] = _e2190 + _e2188;
    uint _e2194 = local_444.inner[0];
    local_445 = static_cast<uint>(_e2194);
    uint _e2198 = local_444.inner[1];
    local_446 = static_cast<uint>(_e2198);
    uint _e2201 = local_446;
    output_1[_e2201] = _e2148 + _e2179;
    uint _e2203 = guarded_total;
    type_5 _e2204 = output;
    local_146 = _e2204;
    local_147 = static_cast<uint>(25);
    type_5 _e2209 = local_146;
    local_447 = _e2209;
    uint _e2211 = local_147;
    uint _e2213 = local_447.inner[1];
    local_447.inner[1] = _e2213 + _e2211;
    uint _e2217 = local_447.inner[0];
    local_448 = static_cast<uint>(_e2217);
    uint _e2221 = local_447.inner[1];
    local_449 = static_cast<uint>(_e2221);
    uint _e2224 = local_449;
    output_1[_e2224] = _e2203;
    type_5 _e2226 = kept;
    local_150 = _e2226;
    type_5 _e2228 = local_150;
    local_450 = _e2228;
    uint _e2231 = local_450.inner[0];
    local_151 = _e2231 != 1u;
    bool _e2235 = local_151;
    type_5 _e2238 = old_null;
    local_152 = _e2238;
    type_5 _e2240 = local_152;
    local_451 = _e2240;
    uint _e2243 = local_451.inner[0];
    local_153 = _e2243 != 1u;
    bool _e2247 = local_153;
    type_5 _e2251 = output;
    local_148 = _e2251;
    local_149 = static_cast<uint>(26);
    type_5 _e2256 = local_148;
    local_452 = _e2256;
    uint _e2258 = local_149;
    uint _e2260 = local_452.inner[1];
    local_452.inner[1] = _e2260 + _e2258;
    uint _e2264 = local_452.inner[0];
    local_453 = static_cast<uint>(_e2264);
    uint _e2268 = local_452.inner[1];
    local_454 = static_cast<uint>(_e2268);
    uint _e2271 = local_454;
    output_1[_e2271] = static_cast<uint>(!(_e2235)) + static_cast<uint>(!(_e2247));
    type_5 _e2273 = output;
    local_154 = _e2273;
    local_155 = static_cast<uint>(27);
    type_5 _e2278 = local_154;
    local_455 = _e2278;
    uint _e2280 = local_155;
    uint _e2282 = local_455.inner[1];
    local_455.inner[1] = _e2282 + _e2280;
    uint _e2286 = local_455.inner[0];
    local_456 = static_cast<uint>(_e2286);
    uint _e2290 = local_455.inner[1];
    local_457 = static_cast<uint>(_e2290);
    uint _e2293 = local_457;
    output_1[_e2293] = selected_snapshot;
    type_5 _e2296 = selected;
    local_158 = _e2296;
    type_5 _e2298 = local_158;
    local_458 = _e2298;
    uint _e2301 = local_458.inner[0];
    local_159 = _e2301 != 1u;
    bool _e2305 = local_159;
    type_5 _e2311 = output;
    local_156 = _e2311;
    local_157 = static_cast<uint>(28);
    type_5 _e2316 = local_156;
    local_459 = _e2316;
    uint _e2318 = local_157;
    uint _e2320 = local_459.inner[1];
    local_459.inner[1] = _e2320 + _e2318;
    uint _e2324 = local_459.inner[0];
    local_460 = static_cast<uint>(_e2324);
    uint _e2328 = local_459.inner[1];
    local_461 = static_cast<uint>(_e2328);
    uint _e2331 = local_461;
    output_1[_e2331] = static_cast<uint>(_e1239) + (2u * static_cast<uint>(!(_e2305)));
    uint _e2333 = counter;
    type_5 _e2334 = output;
    local_160 = _e2334;
    local_161 = static_cast<uint>(29);
    type_5 _e2339 = local_160;
    local_462 = _e2339;
    uint _e2341 = local_161;
    uint _e2343 = local_462.inner[1];
    local_462.inner[1] = _e2343 + _e2341;
    uint _e2347 = local_462.inner[0];
    local_463 = static_cast<uint>(_e2347);
    uint _e2351 = local_462.inner[1];
    local_464 = static_cast<uint>(_e2351);
    uint _e2354 = local_464;
    output_1[_e2354] = _e2333;
    local_164 = static_cast<uint>(2);
    local_205 = uint {};
    source_2 = type_5 {};
    source_2.inner[0] = 3u;
    source_2.inner[1] = 0u;
    uint _e2367 = local_164;
    uint _e2369 = source_2.inner[1];
    source_2.inner[1] = _e2369 + _e2367;
    type_5 _e2373 = source_2;
    local_203 = _e2373;
    type_5 _e2375 = local_203;
    copy_2 = _e2375;
    type_5 _e2378 = copy_2;
    local_204 = _e2378;
    type_5 _e2380 = local_204;
    local_465 = _e2380;
    uint _e2383 = local_465.inner[0];
    local_466 = static_cast<uint>(_e2383);
    uint _e2387 = local_465.inner[1];
    local_467 = static_cast<uint>(_e2387);
    uint _e2390 = local_467;
    uint _e2392 = local.inner[_e2390];
    local_205 = _e2392;
    uint _e2394 = local_205;
    type_5 _e2395 = output;
    local_162 = _e2395;
    local_163 = static_cast<uint>(30);
    type_5 _e2400 = local_162;
    local_468 = _e2400;
    uint _e2402 = local_163;
    uint _e2404 = local_468.inner[1];
    local_468.inner[1] = _e2404 + _e2402;
    uint _e2408 = local_468.inner[0];
    local_469 = static_cast<uint>(_e2408);
    uint _e2412 = local_468.inner[1];
    local_470 = static_cast<uint>(_e2412);
    uint _e2415 = local_470;
    output_1[_e2415] = _e2394;
    local_471 = type_5 {};
    local_471.inner[0] = 1u;
    uint _e2422 = local_471.inner[0];
    local_167 = _e2422 != 1u;
    bool _e2426 = local_167;
    local_472 = type_5 {};
    local_472.inner[0] = 1u;
    uint _e2434 = local_472.inner[0];
    local_168 = _e2434 != 1u;
    bool _e2438 = local_168;
    type_5 _e2442 = output;
    local_165 = _e2442;
    local_166 = static_cast<uint>(31);
    type_5 _e2447 = local_165;
    local_473 = _e2447;
    uint _e2449 = local_166;
    uint _e2451 = local_473.inner[1];
    local_473.inner[1] = _e2451 + _e2449;
    uint _e2455 = local_473.inner[0];
    local_474 = static_cast<uint>(_e2455);
    uint _e2459 = local_473.inner[1];
    local_475 = static_cast<uint>(_e2459);
    uint _e2462 = local_475;
    output_1[_e2462] = static_cast<uint>(!(_e2426)) + static_cast<uint>(!(_e2438));
    uint _e2466 = local.inner[0];
    type_5 _e2467 = output;
    local_169 = _e2467;
    local_170 = static_cast<uint>(35);
    type_5 _e2472 = local_169;
    local_476 = _e2472;
    uint _e2474 = local_170;
    uint _e2476 = local_476.inner[1];
    local_476.inner[1] = _e2476 + _e2474;
    uint _e2480 = local_476.inner[0];
    local_477 = static_cast<uint>(_e2480);
    uint _e2484 = local_476.inner[1];
    local_478 = static_cast<uint>(_e2484);
    uint _e2487 = local_478;
    output_1[_e2487] = _e2466;
    uint _e2491 = local.inner[1];
    type_5 _e2492 = output;
    local_171 = _e2492;
    local_172 = static_cast<uint>(36);
    type_5 _e2497 = local_171;
    local_479 = _e2497;
    uint _e2499 = local_172;
    uint _e2501 = local_479.inner[1];
    local_479.inner[1] = _e2501 + _e2499;
    uint _e2505 = local_479.inner[0];
    local_480 = static_cast<uint>(_e2505);
    uint _e2509 = local_479.inner[1];
    local_481 = static_cast<uint>(_e2509);
    uint _e2512 = local_481;
    output_1[_e2512] = _e2491;
    uint _e2516 = shared.inner[1];
    type_5 _e2517 = output;
    local_173 = _e2517;
    local_174 = static_cast<uint>(37);
    type_5 _e2522 = local_173;
    local_482 = _e2522;
    uint _e2524 = local_174;
    uint _e2526 = local_482.inner[1];
    local_482.inner[1] = _e2526 + _e2524;
    uint _e2530 = local_482.inner[0];
    local_483 = static_cast<uint>(_e2530);
    uint _e2534 = local_482.inner[1];
    local_484 = static_cast<uint>(_e2534);
    uint _e2537 = local_484;
    output_1[_e2537] = _e2516;
    uint _e2541 = shared.inner[2];
    type_5 _e2542 = output;
    local_175 = _e2542;
    local_176 = static_cast<uint>(38);
    type_5 _e2547 = local_175;
    local_485 = _e2547;
    uint _e2549 = local_176;
    uint _e2551 = local_485.inner[1];
    local_485.inner[1] = _e2551 + _e2549;
    uint _e2555 = local_485.inner[0];
    local_486 = static_cast<uint>(_e2555);
    uint _e2559 = local_485.inner[1];
    local_487 = static_cast<uint>(_e2559);
    uint _e2562 = local_487;
    output_1[_e2562] = _e2541;
    type_5 _e2564 = old_null;
    local_179 = _e2564;
    type_5 _e2566 = local_179;
    local_488 = _e2566;
    uint _e2569 = local_488.inner[0];
    local_180 = _e2569 != 1u;
    bool _e2573 = local_180;
    type_5 _e2578 = selected;
    local_181 = _e2578;
    type_5 _e2580 = local_181;
    local_489 = _e2580;
    uint _e2583 = local_489.inner[0];
    local_182 = _e2583 != 1u;
    bool _e2587 = local_182;
    type_5 _e2591 = output;
    local_177 = _e2591;
    local_178 = static_cast<uint>(39);
    type_5 _e2596 = local_177;
    local_490 = _e2596;
    uint _e2598 = local_178;
    uint _e2600 = local_490.inner[1];
    local_490.inner[1] = _e2600 + _e2598;
    uint _e2604 = local_490.inner[0];
    local_491 = static_cast<uint>(_e2604);
    uint _e2608 = local_490.inner[1];
    local_492 = static_cast<uint>(_e2608);
    uint _e2611 = local_492;
    output_1[_e2611] = (static_cast<uint>(!(_e2573)) + static_cast<uint>(_e1239)) + static_cast<uint>(!(_e2587));
}
