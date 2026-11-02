RWByteAddressBuffer output_1 : register(u0);
groupshared uint shared_[3];

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

uint absent_unsigned_u002a()
{
    uint value_2[2] = (uint[2])0;
    uint local_493[2] = (uint[2])0;
    bool local_494 = (bool)0;
    uint local_495 = (uint)0;
    uint local_496[2] = (uint[2])0;

    value_2 = ZeroValuearray2_uint_();
    value_2[0] = 1u;
    uint _e6[2] = value_2;
    local_493 = _e6;
    uint _e9[2] = local_493;
    local_496 = _e9;
    uint _e11 = local_496[0];
    local_494 = (_e11 != 1u);
    bool _e14 = local_494;
    if (_e14) {
        local_495 = 37u;
    } else {
        local_495 = 41u;
    }
    uint _e20 = local_495;
    return _e20;
}

uint absent_const_u0020_unsigned_u002a()
{
    uint value_3[2] = (uint[2])0;
    uint local_497[2] = (uint[2])0;
    bool local_498 = (bool)0;
    uint local_499 = (uint)0;
    uint local_500[2] = (uint[2])0;

    value_3 = ZeroValuearray2_uint_();
    value_3[0] = 1u;
    uint _e6[2] = value_3;
    local_497 = _e6;
    uint _e9[2] = local_497;
    local_500 = _e9;
    uint _e11 = local_500[0];
    local_498 = (_e11 != 1u);
    bool _e14 = local_498;
    if (_e14) {
        local_499 = 37u;
    } else {
        local_499 = 41u;
    }
    uint _e20 = local_499;
    return _e20;
}

uint ZeroValueuint() {
    return (uint)0;
}

bool ZeroValuebool() {
    return (bool)0;
}

[numthreads(1, 1, 1)]
void pointer_value_construction(uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        shared_ = (uint[3])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint output[2] = (uint[2])0;
    uint local[4] = (uint[4])0;
    uint local_1[2] = (uint[2])0;
    uint local_2 = (uint)0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint empty[2] = (uint[2])0;
    uint braced_empty[2] = (uint[2])0;
    uint from_zero[2] = (uint[2])0;
    uint from_braced_zero[2] = (uint[2])0;
    uint qualified_null[2] = (uint[2])0;
    uint cast_null[2] = (uint[2])0;
    uint cursor[2] = (uint[2])0;
    uint local_7[2] = (uint[2])0;
    uint functional[2] = (uint[2])0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint braced[2] = (uint[2])0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint named[2] = (uint[2])0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint c_style[2] = (uint[2])0;
    uint local_14[2] = (uint[2])0;
    uint local_15[2] = (uint[2])0;
    uint local_16[2] = (uint[2])0;
    uint local_17[2] = (uint[2])0;
    uint local_18[2] = (uint[2])0;
    uint local_19[2] = (uint[2])0;
    uint read_functional[2] = (uint[2])0;
    uint local_20[2] = (uint[2])0;
    uint read_braced[2] = (uint[2])0;
    uint local_21[2] = (uint[2])0;
    uint read_named[2] = (uint[2])0;
    uint local_22[2] = (uint[2])0;
    uint read_c_style[2] = (uint[2])0;
    uint local_23[2] = (uint[2])0;
    uint local_24[2] = (uint[2])0;
    uint local_25[2] = (uint[2])0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    uint fixed[2] = (uint[2])0;
    uint local_28[2] = (uint[2])0;
    uint mutable_copy[2] = (uint[2])0;
    uint local_29[2] = (uint[2])0;
    uint local_30[2] = (uint[2])0;
    uint braced_fixed[2] = (uint[2])0;
    uint local_31[2] = (uint[2])0;
    uint local_32[2] = (uint[2])0;
    uint local_33 = (uint)0;
    uint local_34[2] = (uint[2])0;
    uint local_35[2] = (uint[2])0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38[2] = (uint[2])0;
    uint local_39 = (uint)0;
    uint local_40[2] = (uint[2])0;
    uint local_41 = (uint)0;
    uint local_42[2] = (uint[2])0;
    uint local_43 = (uint)0;
    uint counter = (uint)0;
    uint index = (uint)0;
    uint captured[2] = (uint[2])0;
    uint local_44[2] = (uint[2])0;
    uint local_45 = (uint)0;
    uint frozen[2] = (uint[2])0;
    uint local_46[2] = (uint[2])0;
    uint selected[2] = (uint[2])0;
    uint guarded_total = (uint)0;
    uint branch = (uint)0;
    uint local_47 = (uint)0;
    uint local_48[2] = (uint[2])0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54[2] = (uint[2])0;
    uint saved[2] = (uint[2])0;
    uint local_55[2] = (uint[2])0;
    bool local_56 = (bool)0;
    uint local_57[2] = (uint[2])0;
    uint local_58[2] = (uint[2])0;
    uint local_59[2] = (uint[2])0;
    uint local_60 = (uint)0;
    uint local_61[2] = (uint[2])0;
    bool local_62 = (bool)0;
    uint local_63[2] = (uint[2])0;
    bool local_64 = (bool)0;
    uint local_65[2] = (uint[2])0;
    uint local_66 = (uint)0;
    uint kept[2] = (uint[2])0;
    uint local_67[2] = (uint[2])0;
    uint old_null[2] = (uint[2])0;
    uint local_68[2] = (uint[2])0;
    uint local_69[2] = (uint[2])0;
    bool local_70 = (bool)0;
    uint local_71[2] = (uint[2])0;
    uint local_72 = (uint)0;
    uint local_73[2] = (uint[2])0;
    bool local_74 = (bool)0;
    uint local_75[2] = (uint[2])0;
    uint local_76[2] = (uint[2])0;
    uint local_77[2] = (uint[2])0;
    bool local_78 = (bool)0;
    uint local_79[2] = (uint[2])0;
    uint local_80 = (uint)0;
    uint local_81[2] = (uint[2])0;
    uint local_82 = (uint)0;
    uint local_83[2] = (uint[2])0;
    bool local_84 = (bool)0;
    uint local_85[2] = (uint[2])0;
    bool local_86 = (bool)0;
    uint local_87[2] = (uint[2])0;
    bool local_88 = (bool)0;
    uint local_89[2] = (uint[2])0;
    bool local_90 = (bool)0;
    uint local_91[2] = (uint[2])0;
    bool local_92 = (bool)0;
    uint local_93[2] = (uint[2])0;
    bool local_94 = (bool)0;
    uint local_95[2] = (uint[2])0;
    uint local_96 = (uint)0;
    uint local_97[2] = (uint[2])0;
    uint local_98 = (uint)0;
    uint local_99[2] = (uint[2])0;
    uint local_100 = (uint)0;
    uint local_101[2] = (uint[2])0;
    uint local_102[2] = (uint[2])0;
    uint local_103 = (uint)0;
    uint local_104[2] = (uint[2])0;
    uint local_105[2] = (uint[2])0;
    uint local_106 = (uint)0;
    uint local_107[2] = (uint[2])0;
    uint local_108[2] = (uint[2])0;
    uint local_109 = (uint)0;
    uint local_110[2] = (uint[2])0;
    uint local_111[2] = (uint[2])0;
    uint local_112 = (uint)0;
    uint local_113[2] = (uint[2])0;
    uint local_114 = (uint)0;
    uint local_115[2] = (uint[2])0;
    uint local_116 = (uint)0;
    uint local_117[2] = (uint[2])0;
    uint local_118[2] = (uint[2])0;
    uint local_119 = (uint)0;
    uint local_120[2] = (uint[2])0;
    uint local_121[2] = (uint[2])0;
    uint local_122 = (uint)0;
    uint local_123[2] = (uint[2])0;
    uint local_124 = (uint)0;
    uint local_125[2] = (uint[2])0;
    uint local_126 = (uint)0;
    uint local_127[2] = (uint[2])0;
    uint local_128 = (uint)0;
    uint local_129[2] = (uint[2])0;
    uint local_130 = (uint)0;
    uint local_131[2] = (uint[2])0;
    uint local_132[2] = (uint[2])0;
    uint local_133 = (uint)0;
    uint local_134[2] = (uint[2])0;
    uint local_135 = (uint)0;
    uint local_136[2] = (uint[2])0;
    uint local_137[2] = (uint[2])0;
    uint local_138 = (uint)0;
    uint local_139[2] = (uint[2])0;
    uint local_140[2] = (uint[2])0;
    uint local_141 = (uint)0;
    uint local_142[2] = (uint[2])0;
    uint local_143 = (uint)0;
    uint local_144[2] = (uint[2])0;
    uint local_145 = (uint)0;
    uint local_146[2] = (uint[2])0;
    uint local_147 = (uint)0;
    uint local_148[2] = (uint[2])0;
    uint local_149 = (uint)0;
    uint local_150[2] = (uint[2])0;
    bool local_151 = (bool)0;
    uint local_152[2] = (uint[2])0;
    bool local_153 = (bool)0;
    uint local_154[2] = (uint[2])0;
    uint local_155 = (uint)0;
    uint local_156[2] = (uint[2])0;
    uint local_157 = (uint)0;
    uint local_158[2] = (uint[2])0;
    bool local_159 = (bool)0;
    uint local_160[2] = (uint[2])0;
    uint local_161 = (uint)0;
    uint local_162[2] = (uint[2])0;
    uint local_163 = (uint)0;
    uint local_164 = (uint)0;
    uint local_165[2] = (uint[2])0;
    uint local_166 = (uint)0;
    bool local_167 = (bool)0;
    bool local_168 = (bool)0;
    uint local_169[2] = (uint[2])0;
    uint local_170 = (uint)0;
    uint local_171[2] = (uint[2])0;
    uint local_172 = (uint)0;
    uint local_173[2] = (uint[2])0;
    uint local_174 = (uint)0;
    uint local_175[2] = (uint[2])0;
    uint local_176 = (uint)0;
    uint local_177[2] = (uint[2])0;
    uint local_178 = (uint)0;
    uint local_179[2] = (uint[2])0;
    bool local_180 = (bool)0;
    uint local_181[2] = (uint[2])0;
    bool local_182 = (bool)0;
    uint local_183 = (uint)0;
    uint local_184 = (uint)0;
    uint local_185 = (uint)0;
    uint local_186 = (uint)0;
    uint value[2] = (uint[2])0;
    uint amount = (uint)0;
    uint local_187[2] = (uint[2])0;
    bool local_188 = (bool)0;
    uint local_189[2] = (uint[2])0;
    uint local_190 = (uint)0;
    uint local_191 = (uint)0;
    uint value_1[2] = (uint[2])0;
    uint amount_1 = (uint)0;
    uint local_192[2] = (uint[2])0;
    bool local_193 = (bool)0;
    uint local_194[2] = (uint[2])0;
    uint local_195 = (uint)0;
    uint local_196 = (uint)0;
    uint source[2] = (uint[2])0;
    uint local_197[2] = (uint[2])0;
    uint copy[2] = (uint[2])0;
    uint local_198[2] = (uint[2])0;
    uint local_199 = (uint)0;
    uint source_1[2] = (uint[2])0;
    uint local_200[2] = (uint[2])0;
    uint copy_1[2] = (uint[2])0;
    uint local_201[2] = (uint[2])0;
    uint local_202 = (uint)0;
    uint source_2[2] = (uint[2])0;
    uint local_203[2] = (uint[2])0;
    uint copy_2[2] = (uint[2])0;
    uint local_204[2] = (uint[2])0;
    uint local_205 = (uint)0;
    uint local_206[2] = (uint[2])0;
    uint local_207 = (uint)0;
    uint local_208 = (uint)0;
    uint local_209[2] = (uint[2])0;
    uint local_210 = (uint)0;
    uint local_211 = (uint)0;
    uint local_212[2] = (uint[2])0;
    uint local_213 = (uint)0;
    uint local_214 = (uint)0;
    uint local_215[2] = (uint[2])0;
    uint local_216[2] = (uint[2])0;
    uint local_217 = (uint)0;
    uint local_218 = (uint)0;
    uint local_219 = (uint)0;
    uint local_220[2] = (uint[2])0;
    uint local_221 = (uint)0;
    uint local_222 = (uint)0;
    uint local_223 = (uint)0;
    uint local_224[2] = (uint[2])0;
    uint local_225 = (uint)0;
    uint local_226 = (uint)0;
    uint local_227 = (uint)0;
    uint local_228[2] = (uint[2])0;
    uint local_229 = (uint)0;
    uint local_230 = (uint)0;
    uint local_231 = (uint)0;
    uint local_232[2] = (uint[2])0;
    uint local_233 = (uint)0;
    uint local_234 = (uint)0;
    uint local_235 = (uint)0;
    uint local_236[2] = (uint[2])0;
    uint local_237 = (uint)0;
    uint local_238 = (uint)0;
    uint local_239 = (uint)0;
    uint local_240[2] = (uint[2])0;
    uint local_241 = (uint)0;
    uint local_242 = (uint)0;
    uint local_243 = (uint)0;
    uint local_244[2] = (uint[2])0;
    uint local_245 = (uint)0;
    uint local_246 = (uint)0;
    uint local_247 = (uint)0;
    uint local_248[2] = (uint[2])0;
    uint local_249 = (uint)0;
    uint local_250 = (uint)0;
    uint local_251 = (uint)0;
    uint local_252[2] = (uint[2])0;
    uint local_253 = (uint)0;
    uint local_254 = (uint)0;
    uint local_255[2] = (uint[2])0;
    uint local_256 = (uint)0;
    uint local_257 = (uint)0;
    uint local_258[2] = (uint[2])0;
    uint local_259[2] = (uint[2])0;
    uint local_260[2] = (uint[2])0;
    uint local_261 = (uint)0;
    uint local_262 = (uint)0;
    uint local_263 = (uint)0;
    uint local_264[2] = (uint[2])0;
    uint local_265[2] = (uint[2])0;
    uint local_266[2] = (uint[2])0;
    uint local_267 = (uint)0;
    uint local_268 = (uint)0;
    uint local_269 = (uint)0;
    uint local_270[2] = (uint[2])0;
    uint local_271[2] = (uint[2])0;
    uint local_272[2] = (uint[2])0;
    uint local_273 = (uint)0;
    uint local_274 = (uint)0;
    uint local_275 = (uint)0;
    uint local_276[2] = (uint[2])0;
    uint local_277[2] = (uint[2])0;
    uint local_278[2] = (uint[2])0;
    uint local_279 = (uint)0;
    uint local_280 = (uint)0;
    uint local_281 = (uint)0;
    uint local_282[2] = (uint[2])0;
    uint local_283[2] = (uint[2])0;
    uint local_284 = (uint)0;
    uint local_285 = (uint)0;
    uint local_286 = (uint)0;
    uint local_287[2] = (uint[2])0;
    uint local_288 = (uint)0;
    uint local_289 = (uint)0;
    uint local_290 = (uint)0;
    uint local_291[2] = (uint[2])0;
    uint local_292[2] = (uint[2])0;
    uint local_293[2] = (uint[2])0;
    uint local_294[2] = (uint[2])0;
    uint local_295 = (uint)0;
    uint local_296 = (uint)0;
    uint local_297 = (uint)0;
    uint local_298[2] = (uint[2])0;
    uint local_299 = (uint)0;
    uint local_300 = (uint)0;
    uint local_301 = (uint)0;
    uint local_302[2] = (uint[2])0;
    uint local_303[2] = (uint[2])0;
    uint local_304[2] = (uint[2])0;
    uint local_305 = (uint)0;
    uint local_306 = (uint)0;
    uint local_307[2] = (uint[2])0;
    uint local_308[2] = (uint[2])0;
    uint local_309[2] = (uint[2])0;
    uint local_310[2] = (uint[2])0;
    uint local_311 = (uint)0;
    uint local_312 = (uint)0;
    uint local_313 = (uint)0;
    uint local_314[2] = (uint[2])0;
    uint local_315[2] = (uint[2])0;
    uint local_316 = (uint)0;
    uint local_317 = (uint)0;
    uint local_318 = (uint)0;
    uint local_319[2] = (uint[2])0;
    uint local_320 = (uint)0;
    uint local_321 = (uint)0;
    uint local_322 = (uint)0;
    uint local_323[2] = (uint[2])0;
    uint local_324[2] = (uint[2])0;
    uint local_325[2] = (uint[2])0;
    uint local_326[2] = (uint[2])0;
    uint local_327 = (uint)0;
    uint local_328 = (uint)0;
    uint local_329 = (uint)0;
    uint local_330[2] = (uint[2])0;
    uint local_331[2] = (uint[2])0;
    uint local_332 = (uint)0;
    uint local_333 = (uint)0;
    uint local_334 = (uint)0;
    uint local_335[2] = (uint[2])0;
    uint local_336[2] = (uint[2])0;
    uint local_337[2] = (uint[2])0;
    uint local_338[2] = (uint[2])0;
    uint local_339[2] = (uint[2])0;
    uint local_340[2] = (uint[2])0;
    uint local_341[2] = (uint[2])0;
    uint local_342 = (uint)0;
    uint local_343 = (uint)0;
    uint local_344[2] = (uint[2])0;
    uint local_345 = (uint)0;
    uint local_346 = (uint)0;
    uint local_347[2] = (uint[2])0;
    uint local_348 = (uint)0;
    uint local_349 = (uint)0;
    uint local_350[2] = (uint[2])0;
    uint local_351 = (uint)0;
    uint local_352 = (uint)0;
    uint local_353 = (uint)0;
    uint local_354[2] = (uint[2])0;
    uint local_355 = (uint)0;
    uint local_356 = (uint)0;
    uint local_357[2] = (uint[2])0;
    uint local_358 = (uint)0;
    uint local_359 = (uint)0;
    uint local_360 = (uint)0;
    uint local_361[2] = (uint[2])0;
    uint local_362 = (uint)0;
    uint local_363 = (uint)0;
    uint local_364[2] = (uint[2])0;
    uint local_365 = (uint)0;
    uint local_366 = (uint)0;
    uint local_367 = (uint)0;
    uint local_368[2] = (uint[2])0;
    uint local_369 = (uint)0;
    uint local_370 = (uint)0;
    uint local_371[2] = (uint[2])0;
    uint local_372 = (uint)0;
    uint local_373 = (uint)0;
    uint local_374 = (uint)0;
    uint local_375[2] = (uint[2])0;
    uint local_376 = (uint)0;
    uint local_377 = (uint)0;
    uint local_378[2] = (uint[2])0;
    uint local_379 = (uint)0;
    uint local_380 = (uint)0;
    uint local_381[2] = (uint[2])0;
    uint local_382 = (uint)0;
    uint local_383 = (uint)0;
    uint local_384[2] = (uint[2])0;
    uint local_385 = (uint)0;
    uint local_386 = (uint)0;
    uint local_387[2] = (uint[2])0;
    uint local_388 = (uint)0;
    uint local_389 = (uint)0;
    uint local_390[2] = (uint[2])0;
    uint local_391 = (uint)0;
    uint local_392 = (uint)0;
    uint local_393[2] = (uint[2])0;
    uint local_394 = (uint)0;
    uint local_395 = (uint)0;
    uint local_396[2] = (uint[2])0;
    uint local_397 = (uint)0;
    uint local_398 = (uint)0;
    uint local_399[2] = (uint[2])0;
    uint local_400 = (uint)0;
    uint local_401 = (uint)0;
    uint local_402[2] = (uint[2])0;
    uint local_403 = (uint)0;
    uint local_404 = (uint)0;
    uint local_405[2] = (uint[2])0;
    uint local_406 = (uint)0;
    uint local_407 = (uint)0;
    uint local_408[2] = (uint[2])0;
    uint local_409 = (uint)0;
    uint local_410 = (uint)0;
    uint local_411 = (uint)0;
    uint local_412[2] = (uint[2])0;
    uint local_413 = (uint)0;
    uint local_414 = (uint)0;
    uint local_415 = (uint)0;
    uint local_416[2] = (uint[2])0;
    uint local_417 = (uint)0;
    uint local_418 = (uint)0;
    uint local_419[2] = (uint[2])0;
    uint local_420 = (uint)0;
    uint local_421 = (uint)0;
    uint local_422 = (uint)0;
    uint local_423[2] = (uint[2])0;
    uint local_424 = (uint)0;
    uint local_425 = (uint)0;
    uint local_426[2] = (uint[2])0;
    uint local_427 = (uint)0;
    uint local_428 = (uint)0;
    uint local_429[2] = (uint[2])0;
    uint local_430 = (uint)0;
    uint local_431 = (uint)0;
    uint local_432[2] = (uint[2])0;
    uint local_433 = (uint)0;
    uint local_434 = (uint)0;
    uint local_435[2] = (uint[2])0;
    uint local_436 = (uint)0;
    uint local_437 = (uint)0;
    uint local_438[2] = (uint[2])0;
    uint local_439 = (uint)0;
    uint local_440 = (uint)0;
    uint local_441[2] = (uint[2])0;
    uint local_442 = (uint)0;
    uint local_443 = (uint)0;
    uint local_444[2] = (uint[2])0;
    uint local_445 = (uint)0;
    uint local_446 = (uint)0;
    uint local_447[2] = (uint[2])0;
    uint local_448 = (uint)0;
    uint local_449 = (uint)0;
    uint local_450[2] = (uint[2])0;
    uint local_451[2] = (uint[2])0;
    uint local_452[2] = (uint[2])0;
    uint local_453 = (uint)0;
    uint local_454 = (uint)0;
    uint local_455[2] = (uint[2])0;
    uint local_456 = (uint)0;
    uint local_457 = (uint)0;
    uint local_458[2] = (uint[2])0;
    uint local_459[2] = (uint[2])0;
    uint local_460 = (uint)0;
    uint local_461 = (uint)0;
    uint local_462[2] = (uint[2])0;
    uint local_463 = (uint)0;
    uint local_464 = (uint)0;
    uint local_465[2] = (uint[2])0;
    uint local_466 = (uint)0;
    uint local_467 = (uint)0;
    uint local_468[2] = (uint[2])0;
    uint local_469 = (uint)0;
    uint local_470 = (uint)0;
    uint local_471[2] = (uint[2])0;
    uint local_472[2] = (uint[2])0;
    uint local_473[2] = (uint[2])0;
    uint local_474 = (uint)0;
    uint local_475 = (uint)0;
    uint local_476[2] = (uint[2])0;
    uint local_477 = (uint)0;
    uint local_478 = (uint)0;
    uint local_479[2] = (uint[2])0;
    uint local_480 = (uint)0;
    uint local_481 = (uint)0;
    uint local_482[2] = (uint[2])0;
    uint local_483 = (uint)0;
    uint local_484 = (uint)0;
    uint local_485[2] = (uint[2])0;
    uint local_486 = (uint)0;
    uint local_487 = (uint)0;
    uint local_488[2] = (uint[2])0;
    uint local_489[2] = (uint[2])0;
    uint local_490[2] = (uint[2])0;
    uint local_491 = (uint)0;
    uint local_492 = (uint)0;

    output = ZeroValuearray2_uint_();
    output[0] = 2u;
    output[1] = 0u;
    local[0] = 3u;
    local[1] = 5u;
    local[2] = 7u;
    local[3] = 11u;
    shared_[int(0)] = 13u;
    shared_[int(1)] = 17u;
    shared_[int(2)] = 19u;
    uint _e26[2] = output;
    local_1 = _e26;
    local_2 = uint(int(32));
    uint _e31[2] = local_1;
    local_206 = _e31;
    uint _e33 = local_2;
    uint _e35 = local_206[1];
    local_206[1] = (_e35 + _e33);
    uint _e39 = local_206[0];
    local_207 = uint(_e39);
    uint _e43 = local_206[1];
    local_208 = uint(_e43);
    uint _e46 = local_208;
    output_1.Store(_e46*4, asuint(23u));
    uint _e50[2] = output;
    local_3 = _e50;
    local_4 = uint(int(33));
    uint _e55[2] = local_3;
    local_209 = _e55;
    uint _e57 = local_4;
    uint _e59 = local_209[1];
    local_209[1] = (_e59 + _e57);
    uint _e63 = local_209[0];
    local_210 = uint(_e63);
    uint _e67 = local_209[1];
    local_211 = uint(_e67);
    uint _e70 = local_211;
    output_1.Store(_e70*4, asuint(29u));
    uint _e73[2] = output;
    local_5 = _e73;
    local_6 = uint(int(34));
    uint _e78[2] = local_5;
    local_212 = _e78;
    uint _e80 = local_6;
    uint _e82 = local_212[1];
    local_212[1] = (_e82 + _e80);
    uint _e86 = local_212[0];
    local_213 = uint(_e86);
    uint _e90 = local_212[1];
    local_214 = uint(_e90);
    uint _e93 = local_214;
    output_1.Store(_e93*4, asuint(31u));
    empty = ZeroValuearray2_uint_();
    empty[0] = 1u;
    braced_empty = ZeroValuearray2_uint_();
    braced_empty[0] = 1u;
    from_zero = ZeroValuearray2_uint_();
    from_zero[0] = 1u;
    from_braced_zero = ZeroValuearray2_uint_();
    from_braced_zero[0] = 1u;
    qualified_null = ZeroValuearray2_uint_();
    qualified_null[0] = 1u;
    cast_null = ZeroValuearray2_uint_();
    cast_null[0] = 1u;
    cursor = ZeroValuearray2_uint_();
    cursor[0] = 3u;
    cursor[1] = 0u;
    uint _e127[2] = cursor;
    local_7 = _e127;
    uint _e129[2] = local_7;
    functional = _e129;
    uint _e131[2] = cursor;
    local_8 = _e131;
    local_9 = uint(int(1));
    uint _e136[2] = local_8;
    braced = _e136;
    uint _e138 = local_9;
    uint _e140 = braced[1];
    braced[1] = (_e140 + _e138);
    uint _e143[2] = cursor;
    local_10 = _e143;
    local_11 = uint(int(2));
    uint _e148[2] = local_10;
    named = _e148;
    uint _e150 = local_11;
    uint _e152 = named[1];
    named[1] = (_e152 + _e150);
    uint _e155[2] = cursor;
    local_12 = _e155;
    local_13 = uint(int(3));
    uint _e160[2] = local_12;
    c_style = _e160;
    uint _e162 = local_13;
    uint _e164 = c_style[1];
    c_style[1] = (_e164 + _e162);
    local_215 = ZeroValuearray2_uint_();
    local_215[0] = 4u;
    local_215[1] = 0u;
    uint _e173[2] = local_215;
    cursor = _e173;
    uint _e175[2] = functional;
    local_14 = _e175;
    uint _e177[2] = local_14;
    local_216 = _e177;
    uint _e180 = local_216[0];
    local_217 = uint(_e180);
    uint _e184 = local_216[1];
    local_218 = uint(_e184);
    uint _e187 = local_217;
    switch(_e187) {
        case 4u: {
            uint _e188 = local_218;
            uint _e190 = shared_[min(uint(_e188), 2u)];
            local_219 = _e190;
            break;
        }
        case 3u: {
            uint _e192 = local_218;
            uint _e194 = local[min(uint(_e192), 3u)];
            local_219 = _e194;
            break;
        }
        default: {
            uint _e196 = local_218;
            uint _e198 = asuint(output_1.Load(_e196*4));
            local_219 = _e198;
            break;
        }
    }
    uint _e201 = local_219;
    uint _e203 = (_e201 + 2u);
    uint _e204 = local_217;
    switch(_e204) {
        case 4u: {
            uint _e205 = local_218;
            shared_[min(uint(_e205), 2u)] = _e203;
            break;
        }
        case 3u: {
            uint _e207 = local_218;
            local[min(uint(_e207), 3u)] = _e203;
            break;
        }
        default: {
            uint _e209 = local_218;
            output_1.Store(_e209*4, asuint(_e203));
            break;
        }
    }
    uint _e212[2] = braced;
    local_15 = _e212;
    uint _e214[2] = local_15;
    local_220 = _e214;
    uint _e217 = local_220[0];
    local_221 = uint(_e217);
    uint _e221 = local_220[1];
    local_222 = uint(_e221);
    uint _e224 = local_221;
    switch(_e224) {
        case 4u: {
            uint _e225 = local_222;
            uint _e227 = shared_[min(uint(_e225), 2u)];
            local_223 = _e227;
            break;
        }
        case 3u: {
            uint _e229 = local_222;
            uint _e231 = local[min(uint(_e229), 3u)];
            local_223 = _e231;
            break;
        }
        default: {
            uint _e233 = local_222;
            uint _e235 = asuint(output_1.Load(_e233*4));
            local_223 = _e235;
            break;
        }
    }
    uint _e238 = local_223;
    uint _e240 = (_e238 + 3u);
    uint _e241 = local_221;
    switch(_e241) {
        case 4u: {
            uint _e242 = local_222;
            shared_[min(uint(_e242), 2u)] = _e240;
            break;
        }
        case 3u: {
            uint _e244 = local_222;
            local[min(uint(_e244), 3u)] = _e240;
            break;
        }
        default: {
            uint _e246 = local_222;
            output_1.Store(_e246*4, asuint(_e240));
            break;
        }
    }
    uint _e249[2] = named;
    local_16 = _e249;
    uint _e251[2] = local_16;
    local_224 = _e251;
    uint _e254 = local_224[0];
    local_225 = uint(_e254);
    uint _e258 = local_224[1];
    local_226 = uint(_e258);
    uint _e261 = local_225;
    switch(_e261) {
        case 4u: {
            uint _e262 = local_226;
            uint _e264 = shared_[min(uint(_e262), 2u)];
            local_227 = _e264;
            break;
        }
        case 3u: {
            uint _e266 = local_226;
            uint _e268 = local[min(uint(_e266), 3u)];
            local_227 = _e268;
            break;
        }
        default: {
            uint _e270 = local_226;
            uint _e272 = asuint(output_1.Load(_e270*4));
            local_227 = _e272;
            break;
        }
    }
    uint _e275 = local_227;
    uint _e277 = (_e275 + 5u);
    uint _e278 = local_225;
    switch(_e278) {
        case 4u: {
            uint _e279 = local_226;
            shared_[min(uint(_e279), 2u)] = _e277;
            break;
        }
        case 3u: {
            uint _e281 = local_226;
            local[min(uint(_e281), 3u)] = _e277;
            break;
        }
        default: {
            uint _e283 = local_226;
            output_1.Store(_e283*4, asuint(_e277));
            break;
        }
    }
    uint _e286[2] = c_style;
    local_17 = _e286;
    uint _e288[2] = local_17;
    local_228 = _e288;
    uint _e291 = local_228[0];
    local_229 = uint(_e291);
    uint _e295 = local_228[1];
    local_230 = uint(_e295);
    uint _e298 = local_229;
    switch(_e298) {
        case 4u: {
            uint _e299 = local_230;
            uint _e301 = shared_[min(uint(_e299), 2u)];
            local_231 = _e301;
            break;
        }
        case 3u: {
            uint _e303 = local_230;
            uint _e305 = local[min(uint(_e303), 3u)];
            local_231 = _e305;
            break;
        }
        default: {
            uint _e307 = local_230;
            uint _e309 = asuint(output_1.Load(_e307*4));
            local_231 = _e309;
            break;
        }
    }
    uint _e312 = local_231;
    uint _e314 = (_e312 + 7u);
    uint _e315 = local_229;
    switch(_e315) {
        case 4u: {
            uint _e316 = local_230;
            shared_[min(uint(_e316), 2u)] = _e314;
            break;
        }
        case 3u: {
            uint _e318 = local_230;
            local[min(uint(_e318), 3u)] = _e314;
            break;
        }
        default: {
            uint _e320 = local_230;
            output_1.Store(_e320*4, asuint(_e314));
            break;
        }
    }
    uint _e322[2] = functional;
    local_18 = _e322;
    uint _e324[2] = local_18;
    local_232 = _e324;
    uint _e327 = local_232[0];
    local_233 = uint(_e327);
    uint _e331 = local_232[1];
    local_234 = uint(_e331);
    uint _e334 = local_233;
    switch(_e334) {
        case 4u: {
            uint _e335 = local_234;
            uint _e337 = shared_[min(uint(_e335), 2u)];
            local_235 = _e337;
            break;
        }
        case 3u: {
            uint _e339 = local_234;
            uint _e341 = local[min(uint(_e339), 3u)];
            local_235 = _e341;
            break;
        }
        default: {
            uint _e343 = local_234;
            uint _e345 = asuint(output_1.Load(_e343*4));
            local_235 = _e345;
            break;
        }
    }
    uint first_copy = local_235;
    uint _e349[2] = functional;
    local_19 = _e349;
    uint _e351[2] = local_19;
    read_functional = _e351;
    uint _e353[2] = braced;
    local_20 = _e353;
    uint _e355[2] = local_20;
    read_braced = _e355;
    uint _e357[2] = named;
    local_21 = _e357;
    uint _e359[2] = local_21;
    read_named = _e359;
    uint _e361[2] = c_style;
    local_22 = _e361;
    uint _e363[2] = local_22;
    read_c_style = _e363;
    uint _e366[2] = read_functional;
    local_23 = _e366;
    uint _e369[2] = read_braced;
    local_24 = _e369;
    uint _e371[2] = local_23;
    local_236 = _e371;
    uint _e374 = local_236[0];
    local_237 = uint(_e374);
    uint _e378 = local_236[1];
    local_238 = uint(_e378);
    uint _e381 = local_237;
    switch(_e381) {
        case 4u: {
            uint _e382 = local_238;
            uint _e384 = shared_[min(uint(_e382), 2u)];
            local_239 = _e384;
            break;
        }
        case 3u: {
            uint _e386 = local_238;
            uint _e388 = local[min(uint(_e386), 3u)];
            local_239 = _e388;
            break;
        }
        default: {
            uint _e390 = local_238;
            uint _e392 = asuint(output_1.Load(_e390*4));
            local_239 = _e392;
            break;
        }
    }
    uint _e395 = local_239;
    uint _e396[2] = local_24;
    local_240 = _e396;
    uint _e399 = local_240[0];
    local_241 = uint(_e399);
    uint _e403 = local_240[1];
    local_242 = uint(_e403);
    uint _e406 = local_241;
    switch(_e406) {
        case 4u: {
            uint _e407 = local_242;
            uint _e409 = shared_[min(uint(_e407), 2u)];
            local_243 = _e409;
            break;
        }
        case 3u: {
            uint _e411 = local_242;
            uint _e413 = local[min(uint(_e411), 3u)];
            local_243 = _e413;
            break;
        }
        default: {
            uint _e415 = local_242;
            uint _e417 = asuint(output_1.Load(_e415*4));
            local_243 = _e417;
            break;
        }
    }
    uint _e420 = local_243;
    uint _e423[2] = read_named;
    local_25 = _e423;
    uint _e425[2] = local_25;
    local_244 = _e425;
    uint _e428 = local_244[0];
    local_245 = uint(_e428);
    uint _e432 = local_244[1];
    local_246 = uint(_e432);
    uint _e435 = local_245;
    switch(_e435) {
        case 4u: {
            uint _e436 = local_246;
            uint _e438 = shared_[min(uint(_e436), 2u)];
            local_247 = _e438;
            break;
        }
        case 3u: {
            uint _e440 = local_246;
            uint _e442 = local[min(uint(_e440), 3u)];
            local_247 = _e442;
            break;
        }
        default: {
            uint _e444 = local_246;
            uint _e446 = asuint(output_1.Load(_e444*4));
            local_247 = _e446;
            break;
        }
    }
    uint _e449 = local_247;
    uint _e452[2] = read_c_style;
    local_26 = _e452;
    uint _e454[2] = local_26;
    local_248 = _e454;
    uint _e457 = local_248[0];
    local_249 = uint(_e457);
    uint _e461 = local_248[1];
    local_250 = uint(_e461);
    uint _e464 = local_249;
    switch(_e464) {
        case 4u: {
            uint _e465 = local_250;
            uint _e467 = shared_[min(uint(_e465), 2u)];
            local_251 = _e467;
            break;
        }
        case 3u: {
            uint _e469 = local_250;
            uint _e471 = local[min(uint(_e469), 3u)];
            local_251 = _e471;
            break;
        }
        default: {
            uint _e473 = local_250;
            uint _e475 = asuint(output_1.Load(_e473*4));
            local_251 = _e475;
            break;
        }
    }
    uint _e478 = local_251;
    uint qualified_sum = (((_e395 + _e420) + _e449) + _e478);
    local_27 = uint(int(1));
    fixed = ZeroValuearray2_uint_();
    fixed[0] = 4u;
    fixed[1] = 0u;
    uint _e489 = local_27;
    uint _e491 = fixed[1];
    fixed[1] = (_e491 + _e489);
    uint _e495[2] = fixed;
    local_28 = _e495;
    uint _e497[2] = local_28;
    mutable_copy = _e497;
    uint _e501 = mutable_copy[1];
    mutable_copy[1] = (_e501 + 1u);
    uint _e505[2] = mutable_copy;
    local_29 = _e505;
    uint _e507[2] = local_29;
    local_252 = _e507;
    uint _e510 = local_252[0];
    local_253 = uint(_e510);
    uint _e514 = local_252[1];
    local_254 = uint(_e514);
    uint _e517 = local_254;
    uint _e519 = shared_[min(uint(_e517), 2u)];
    uint _e522 = local_254;
    shared_[min(uint(_e522), 2u)] = (_e519 + 11u);
    uint _e524[2] = fixed;
    local_30 = _e524;
    uint _e526[2] = local_30;
    braced_fixed = _e526;
    uint _e530 = braced_fixed[1];
    braced_fixed[1] = (_e530 + 1u);
    uint _e534[2] = fixed;
    local_31 = _e534;
    uint _e536[2] = local_31;
    local_255 = _e536;
    uint _e539 = local_255[0];
    local_256 = uint(_e539);
    uint _e543 = local_255[1];
    local_257 = uint(_e543);
    uint _e546 = local_257;
    uint fixed_snapshot = shared_[min(uint(_e546), 2u)];
    local_258 = ZeroValuearray2_uint_();
    local_258[0] = 3u;
    local_258[1] = 0u;
    uint _e555[2] = local_258;
    cursor = _e555;
    uint _e556[2] = cursor;
    local_32 = _e556;
    local_259 = ZeroValuearray2_uint_();
    local_259[0] = 4u;
    local_259[1] = 0u;
    uint _e564[2] = local_259;
    cursor = _e564;
    local_33 = uint(1u);
    uint _e568[2] = local_32;
    local_260 = _e568;
    uint _e570 = local_33;
    uint _e572 = local_260[1];
    local_260[1] = (_e572 + _e570);
    uint _e576 = local_260[0];
    local_261 = uint(_e576);
    uint _e580 = local_260[1];
    local_262 = uint(_e580);
    uint _e583 = local_261;
    switch(_e583) {
        case 4u: {
            uint _e584 = local_262;
            uint _e586 = shared_[min(uint(_e584), 2u)];
            local_263 = _e586;
            break;
        }
        case 3u: {
            uint _e588 = local_262;
            uint _e590 = local[min(uint(_e588), 3u)];
            local_263 = _e590;
            break;
        }
        default: {
            uint _e592 = local_262;
            uint _e594 = asuint(output_1.Load(_e592*4));
            local_263 = _e594;
            break;
        }
    }
    uint functional_snapshot = local_263;
    local_264 = ZeroValuearray2_uint_();
    local_264[0] = 4u;
    local_264[1] = 0u;
    uint _e604[2] = local_264;
    cursor = _e604;
    uint _e605[2] = cursor;
    local_34 = _e605;
    uint _e607[2] = output;
    local_35 = _e607;
    local_36 = uint(int(32));
    uint _e612[2] = local_35;
    local_265 = _e612;
    uint _e614 = local_36;
    uint _e616 = local_265[1];
    local_265[1] = (_e616 + _e614);
    uint _e619[2] = local_265;
    cursor = _e619;
    local_37 = uint(2u);
    uint _e623[2] = local_34;
    local_266 = _e623;
    uint _e625 = local_37;
    uint _e627 = local_266[1];
    local_266[1] = (_e627 + _e625);
    uint _e631 = local_266[0];
    local_267 = uint(_e631);
    uint _e635 = local_266[1];
    local_268 = uint(_e635);
    uint _e638 = local_267;
    switch(_e638) {
        case 4u: {
            uint _e639 = local_268;
            uint _e641 = shared_[min(uint(_e639), 2u)];
            local_269 = _e641;
            break;
        }
        case 3u: {
            uint _e643 = local_268;
            uint _e645 = local[min(uint(_e643), 3u)];
            local_269 = _e645;
            break;
        }
        default: {
            uint _e647 = local_268;
            uint _e649 = asuint(output_1.Load(_e647*4));
            local_269 = _e649;
            break;
        }
    }
    uint braced_snapshot = local_269;
    uint _e653[2] = output;
    local_38 = _e653;
    local_39 = uint(int(32));
    uint _e658[2] = local_38;
    local_270 = _e658;
    uint _e660 = local_39;
    uint _e662 = local_270[1];
    local_270[1] = (_e662 + _e660);
    uint _e665[2] = local_270;
    cursor = _e665;
    uint _e666[2] = cursor;
    local_40 = _e666;
    local_271 = ZeroValuearray2_uint_();
    local_271[0] = 3u;
    local_271[1] = 0u;
    uint _e674[2] = local_271;
    cursor = _e674;
    local_41 = uint(1u);
    uint _e678[2] = local_40;
    local_272 = _e678;
    uint _e680 = local_41;
    uint _e682 = local_272[1];
    local_272[1] = (_e682 + _e680);
    uint _e686 = local_272[0];
    local_273 = uint(_e686);
    uint _e690 = local_272[1];
    local_274 = uint(_e690);
    uint _e693 = local_273;
    switch(_e693) {
        case 4u: {
            uint _e694 = local_274;
            uint _e696 = shared_[min(uint(_e694), 2u)];
            local_275 = _e696;
            break;
        }
        case 3u: {
            uint _e698 = local_274;
            uint _e700 = local[min(uint(_e698), 3u)];
            local_275 = _e700;
            break;
        }
        default: {
            uint _e702 = local_274;
            uint _e704 = asuint(output_1.Load(_e702*4));
            local_275 = _e704;
            break;
        }
    }
    uint named_snapshot = local_275;
    local_276 = ZeroValuearray2_uint_();
    local_276[0] = 3u;
    local_276[1] = 0u;
    uint _e714[2] = local_276;
    cursor = _e714;
    uint _e715[2] = cursor;
    local_42 = _e715;
    local_277 = ZeroValuearray2_uint_();
    local_277[0] = 4u;
    local_277[1] = 0u;
    uint _e723[2] = local_277;
    cursor = _e723;
    local_43 = uint(0u);
    uint _e727[2] = local_42;
    local_278 = _e727;
    uint _e729 = local_43;
    uint _e731 = local_278[1];
    local_278[1] = (_e731 + _e729);
    uint _e735 = local_278[0];
    local_279 = uint(_e735);
    uint _e739 = local_278[1];
    local_280 = uint(_e739);
    uint _e742 = local_279;
    switch(_e742) {
        case 4u: {
            uint _e743 = local_280;
            uint _e745 = shared_[min(uint(_e743), 2u)];
            local_281 = _e745;
            break;
        }
        case 3u: {
            uint _e747 = local_280;
            uint _e749 = local[min(uint(_e747), 3u)];
            local_281 = _e749;
            break;
        }
        default: {
            uint _e751 = local_280;
            uint _e753 = asuint(output_1.Load(_e751*4));
            local_281 = _e753;
            break;
        }
    }
    uint c_style_snapshot = local_281;
    counter = 0u;
    index = 0u;
    uint _e761 = counter;
    counter = (_e761 + uint(int(1)));
    uint _e765 = index;
    index = (_e765 + uint(int(1)));
    captured = ZeroValuearray2_uint_();
    captured[0] = 3u;
    captured[1] = 0u;
    uint _e776 = captured[1];
    captured[1] = (_e776 + _e765);
    uint _e780[2] = captured;
    local_44 = _e780;
    local_45 = uint(int(1));
    local_282 = ZeroValuearray2_uint_();
    local_282[0] = 4u;
    local_282[1] = 0u;
    uint _e791 = local_45;
    uint _e793 = local_282[1];
    local_282[1] = (_e793 + _e791);
    uint _e796[2] = local_282;
    captured = _e796;
    index = 3u;
    uint _e798[2] = local_44;
    local_283 = _e798;
    uint _e801 = local_283[0];
    local_284 = uint(_e801);
    uint _e805 = local_283[1];
    local_285 = uint(_e805);
    uint _e808 = local_284;
    switch(_e808) {
        case 3u: {
            uint _e809 = local_285;
            uint _e811 = local[min(uint(_e809), 3u)];
            local_286 = _e811;
            break;
        }
        default: {
            uint _e813 = local_285;
            uint _e815 = shared_[min(uint(_e813), 2u)];
            local_286 = _e815;
            break;
        }
    }
    uint _e818 = local_286;
    uint _e820 = (_e818 + 13u);
    uint _e821 = local_284;
    switch(_e821) {
        case 3u: {
            uint _e822 = local_285;
            local[min(uint(_e822), 3u)] = _e820;
            break;
        }
        default: {
            uint _e824 = local_285;
            shared_[min(uint(_e824), 2u)] = _e820;
            break;
        }
    }
    uint _e826 = counter;
    counter = (_e826 + uint(int(1)));
    uint _e830 = index;
    index = (_e830 - uint(int(1)));
    frozen = ZeroValuearray2_uint_();
    frozen[0] = 3u;
    frozen[1] = 0u;
    uint _e841 = frozen[1];
    frozen[1] = (_e841 + _e830);
    index = 0u;
    uint _e845[2] = functional;
    local_46 = _e845;
    uint _e847[2] = local_46;
    local_287 = _e847;
    uint _e850 = local_287[0];
    local_288 = uint(_e850);
    uint _e854 = local_287[1];
    local_289 = uint(_e854);
    uint _e857 = local_288;
    switch(_e857) {
        case 4u: {
            uint _e858 = local_289;
            uint _e860 = shared_[min(uint(_e858), 2u)];
            local_290 = _e860;
            break;
        }
        case 3u: {
            uint _e862 = local_289;
            uint _e864 = local[min(uint(_e862), 3u)];
            local_290 = _e864;
            break;
        }
        default: {
            uint _e866 = local_289;
            uint _e868 = asuint(output_1.Load(_e866*4));
            local_290 = _e868;
            break;
        }
    }
    uint _e871 = local_290;
    uint _e873 = (_e871 + 2u);
    uint _e874 = local_288;
    switch(_e874) {
        case 4u: {
            uint _e875 = local_289;
            shared_[min(uint(_e875), 2u)] = _e873;
            break;
        }
        case 3u: {
            uint _e877 = local_289;
            local[min(uint(_e877), 3u)] = _e873;
            break;
        }
        default: {
            uint _e879 = local_289;
            output_1.Store(_e879*4, asuint(_e873));
            break;
        }
    }
    uint after_capture = counter;
    selected = ZeroValuearray2_uint_();
    selected[0] = 1u;
    guarded_total = 0u;
    {
        branch = 0u;
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e1093 = branch;
                branch = (_e1093 + uint(int(1)));
            }
            loop_init = false;
            uint _e890 = branch;
            if ((_e890 < 3u)) {
            } else {
                break;
            }
            uint _e893 = branch;
            if ((_e893 == 0u)) {
                local_53 = 0u;
                local_52 = 1u;
            } else {
                uint _e900 = branch;
                if ((_e900 == 1u)) {
                    local_47 = uint(int(1));
                    local_51 = 0u;
                    local_50 = 1u;
                } else {
                    uint _e910[2] = output;
                    local_48 = _e910;
                    local_49 = uint(int(32));
                    local_51 = 0u;
                    local_50 = 0u;
                }
                uint _e920 = local_51;
                local_53 = _e920;
                local_52 = 0u;
            }
            uint _e925 = local_52;
            if ((_e925 != 0u)) {
                local_291 = ZeroValuearray2_uint_();
                local_291[0] = 1u;
            } else {
                uint _e933 = local_50;
                if ((_e933 != 0u)) {
                    local_291 = ZeroValuearray2_uint_();
                    local_291[0] = 4u;
                    local_291[1] = 0u;
                    uint _e943 = local_47;
                    uint _e945 = local_291[1];
                    local_291[1] = (_e945 + _e943);
                } else {
                    uint _e949[2] = local_48;
                    local_291 = _e949;
                    uint _e952 = local_49;
                    uint _e954 = local_291[1];
                    local_291[1] = (_e954 + _e952);
                }
            }
            uint _e958 = local_53;
            uint _e961 = local_291[1];
            local_291[1] = (_e961 + _e958);
            uint _e964[2] = local_291;
            selected = _e964;
            uint _e966[2] = selected;
            local_54 = _e966;
            uint _e968[2] = local_54;
            saved = _e968;
            local_292 = ZeroValuearray2_uint_();
            local_292[0] = 1u;
            uint _e974[2] = local_292;
            selected = _e974;
            uint _e976[2] = saved;
            local_55 = _e976;
            uint _e978[2] = local_55;
            local_293 = _e978;
            uint _e981 = local_293[0];
            local_56 = (_e981 != 1u);
            bool _e985 = local_56;
            if (_e985) {
                uint _e986 = branch;
                uint _e987[2] = saved;
                local_57 = _e987;
                uint _e989[2] = local_57;
                local_294 = _e989;
                uint _e992 = local_294[0];
                local_295 = uint(_e992);
                uint _e996 = local_294[1];
                local_296 = uint(_e996);
                local_297 = ZeroValueuint();
                uint _e1001 = local_295;
                bool should_continue = false;
                switch(_e1001) {
                    case 4u: {
                        uint _e1002 = local_296;
                        uint _e1004 = shared_[min(uint(_e1002), 2u)];
                        local_297 = _e1004;
                        break;
                    }
                    case 2u: {
                        uint _e1005 = local_296;
                        uint _e1007 = asuint(output_1.Load(_e1005*4));
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
                uint _e1011 = (_e1010 + _e986);
                uint _e1012 = local_295;
                bool should_continue_1 = false;
                switch(_e1012) {
                    case 4u: {
                        uint _e1013 = local_296;
                        shared_[min(uint(_e1013), 2u)] = _e1011;
                        break;
                    }
                    case 2u: {
                        uint _e1015 = local_296;
                        output_1.Store(_e1015*4, asuint(_e1011));
                        break;
                    }
                    default: {
                        break;
                    }
                }
                uint _e1017[2] = saved;
                local_58 = _e1017;
                uint _e1019[2] = local_58;
                local_298 = _e1019;
                uint _e1022 = local_298[0];
                local_299 = uint(_e1022);
                uint _e1026 = local_298[1];
                local_300 = uint(_e1026);
                local_301 = ZeroValueuint();
                uint _e1031 = local_299;
                bool should_continue_2 = false;
                switch(_e1031) {
                    case 4u: {
                        uint _e1032 = local_300;
                        uint _e1034 = shared_[min(uint(_e1032), 2u)];
                        local_301 = _e1034;
                        break;
                    }
                    case 2u: {
                        uint _e1035 = local_300;
                        uint _e1037 = asuint(output_1.Load(_e1035*4));
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
                guarded_total = (_e1041 + _e1040);
            }
            uint _e1043[2] = selected;
            local_61 = _e1043;
            uint _e1045[2] = local_61;
            local_302 = _e1045;
            uint _e1048 = local_302[0];
            local_62 = (_e1048 != 1u);
            bool _e1052 = local_62;
            uint _e1055[2] = saved;
            local_63 = _e1055;
            uint _e1057[2] = local_63;
            local_303 = _e1057;
            uint _e1060 = local_303[0];
            local_64 = (_e1060 != 1u);
            bool _e1064 = local_64;
            uint _e1069[2] = output;
            local_59 = _e1069;
            uint _e1071 = branch;
            local_60 = uint((22u + _e1071));
            uint _e1076[2] = local_59;
            local_304 = _e1076;
            uint _e1078 = local_60;
            uint _e1080 = local_304[1];
            local_304[1] = (_e1080 + _e1078);
            uint _e1084 = local_304[0];
            local_305 = uint(_e1084);
            uint _e1088 = local_304[1];
            local_306 = uint(_e1088);
            uint _e1091 = local_306;
            output_1.Store(_e1091*4, asuint((uint(!(_e1052)) + (2u * uint(_e1064)))));
        }
    }
    uint _e1097[2] = output;
    local_65 = _e1097;
    local_66 = uint(int(33));
    uint _e1102[2] = local_65;
    kept = _e1102;
    uint _e1104 = local_66;
    uint _e1106 = kept[1];
    kept[1] = (_e1106 + _e1104);
    uint _e1110[2] = selected;
    local_67 = _e1110;
    uint _e1112[2] = local_67;
    old_null = _e1112;
    uint _e1115[2] = kept;
    local_68 = _e1115;
    uint _e1117[2] = local_68;
    local_307 = _e1117;
    uint _e1119[2] = local_307;
    selected = _e1119;
    local_308 = ZeroValuearray2_uint_();
    local_308[0] = 1u;
    uint _e1124[2] = local_308;
    kept = _e1124;
    uint _e1126[2] = old_null;
    local_69 = _e1126;
    uint _e1128[2] = local_69;
    local_309 = _e1128;
    uint _e1131 = local_309[0];
    local_70 = (_e1131 != 1u);
    bool _e1135 = local_70;
    if (_e1135) {
        uint _e1136[2] = output;
        local_71 = _e1136;
        local_72 = uint(int(34));
        uint _e1141[2] = local_71;
        local_310 = _e1141;
        uint _e1143 = local_72;
        uint _e1145 = local_310[1];
        local_310[1] = (_e1145 + _e1143);
        uint _e1149 = local_310[0];
        local_311 = uint(_e1149);
        uint _e1153 = local_310[1];
        local_312 = uint(_e1153);
        uint _e1156 = local_312;
        uint _e1158 = asuint(output_1.Load(_e1156*4));
        local_313 = _e1158;
        uint _e1160 = local_313;
        local_185 = _e1160;
        uint _e1162 = local_185;
        uint _e1165 = local_312;
        output_1.Store(_e1165*4, asuint((_e1162 + 1000u)));
    }
    uint _e1167[2] = selected;
    local_73 = _e1167;
    uint _e1169[2] = local_73;
    local_314 = _e1169;
    uint _e1172 = local_314[0];
    local_74 = (_e1172 != 1u);
    bool _e1176 = local_74;
    if (_e1176) {
        uint _e1177[2] = selected;
        local_75 = _e1177;
        uint _e1179[2] = local_75;
        local_315 = _e1179;
        uint _e1182 = local_315[0];
        local_316 = uint(_e1182);
        uint _e1186 = local_315[1];
        local_317 = uint(_e1186);
        local_318 = ZeroValueuint();
        uint _e1191 = local_316;
        switch(_e1191) {
            case 4u: {
                uint _e1192 = local_317;
                uint _e1194 = shared_[min(uint(_e1192), 2u)];
                local_318 = _e1194;
                break;
            }
            case 2u: {
                uint _e1195 = local_317;
                uint _e1197 = asuint(output_1.Load(_e1195*4));
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
        uint _e1202 = (_e1200 + 5u);
        uint _e1203 = local_316;
        switch(_e1203) {
            case 4u: {
                uint _e1204 = local_317;
                shared_[min(uint(_e1204), 2u)] = _e1202;
                break;
            }
            case 2u: {
                uint _e1206 = local_317;
                output_1.Store(_e1206*4, asuint(_e1202));
                break;
            }
            default: {
                break;
            }
        }
    }
    uint _e1208[2] = selected;
    local_76 = _e1208;
    uint _e1210[2] = local_76;
    local_319 = _e1210;
    uint _e1213 = local_319[0];
    local_320 = uint(_e1213);
    uint _e1217 = local_319[1];
    local_321 = uint(_e1217);
    local_322 = ZeroValueuint();
    uint _e1222 = local_320;
    switch(_e1222) {
        case 4u: {
            uint _e1223 = local_321;
            uint _e1225 = shared_[min(uint(_e1223), 2u)];
            local_322 = _e1225;
            break;
        }
        case 2u: {
            uint _e1226 = local_321;
            uint _e1228 = asuint(output_1.Load(_e1226*4));
            local_322 = _e1228;
            break;
        }
        default: {
            break;
        }
    }
    uint selected_snapshot = local_322;
    uint _e1230[2] = selected;
    local_77 = _e1230;
    uint _e1232[2] = local_77;
    local_323 = _e1232;
    uint _e1235 = local_323[0];
    local_78 = (_e1235 != 1u);
    bool _e1239 = local_78;
    local_324 = ZeroValuearray2_uint_();
    local_324[0] = 1u;
    uint _e1244[2] = local_324;
    selected = _e1244;
    uint _e1245 = counter;
    counter = (_e1245 + uint(int(1)));
    uint _e1249[2] = output;
    local_79 = _e1249;
    local_80 = uint(int(34));
    amount = ZeroValueuint();
    local_188 = ZeroValuebool();
    local_190 = ZeroValueuint();
    uint _e1260[2] = local_79;
    value = _e1260;
    uint _e1262 = local_80;
    uint _e1264 = value[1];
    value[1] = (_e1264 + _e1262);
    amount = 7u;
    uint _e1269 = counter;
    counter = (_e1269 + uint(int(1)));
    uint _e1274[2] = value;
    local_187 = _e1274;
    uint _e1276[2] = local_187;
    local_325 = _e1276;
    uint _e1279 = local_325[0];
    local_188 = (_e1279 != 1u);
    bool _e1283 = local_188;
    if (_e1283) {
        uint _e1284 = amount;
        uint _e1285[2] = value;
        local_189 = _e1285;
        uint _e1287[2] = local_189;
        local_326 = _e1287;
        uint _e1290 = local_326[0];
        local_327 = uint(_e1290);
        uint _e1294 = local_326[1];
        local_328 = uint(_e1294);
        uint _e1297 = local_328;
        uint _e1299 = asuint(output_1.Load(_e1297*4));
        local_329 = _e1299;
        uint _e1301 = local_329;
        local_191 = _e1301;
        uint _e1303 = local_191;
        local_190 = _e1303;
        uint _e1305 = local_190;
        uint _e1307 = local_328;
        output_1.Store(_e1307*4, asuint((_e1305 + _e1284)));
    }
    amount_1 = ZeroValueuint();
    local_193 = ZeroValuebool();
    local_195 = ZeroValueuint();
    value_1 = ZeroValuearray2_uint_();
    value_1[0] = 1u;
    amount_1 = 1000u;
    uint _e1321 = counter;
    counter = (_e1321 + uint(int(1)));
    uint _e1326[2] = value_1;
    local_192 = _e1326;
    uint _e1328[2] = local_192;
    local_330 = _e1328;
    uint _e1331 = local_330[0];
    local_193 = (_e1331 != 1u);
    bool _e1335 = local_193;
    if (_e1335) {
        uint _e1336[2] = value_1;
        local_194 = _e1336;
        uint _e1338[2] = local_194;
        local_331 = _e1338;
        uint _e1341 = local_331[0];
        local_332 = uint(_e1341);
        uint _e1345 = local_331[1];
        local_333 = uint(_e1345);
        local_334 = ZeroValueuint();
        uint _e1350 = local_334;
        local_196 = _e1350;
        uint _e1352 = local_196;
        local_195 = _e1352;
    }
    uint _e1355[2] = empty;
    local_83 = _e1355;
    uint _e1357[2] = local_83;
    local_335 = _e1357;
    uint _e1360 = local_335[0];
    local_84 = (_e1360 != 1u);
    bool _e1364 = local_84;
    uint _e1368[2] = braced_empty;
    local_85 = _e1368;
    uint _e1370[2] = local_85;
    local_336 = _e1370;
    uint _e1373 = local_336[0];
    local_86 = (_e1373 != 1u);
    bool _e1377 = local_86;
    uint _e1382[2] = from_zero;
    local_87 = _e1382;
    uint _e1384[2] = local_87;
    local_337 = _e1384;
    uint _e1387 = local_337[0];
    local_88 = (_e1387 != 1u);
    bool _e1391 = local_88;
    uint _e1396[2] = from_braced_zero;
    local_89 = _e1396;
    uint _e1398[2] = local_89;
    local_338 = _e1398;
    uint _e1401 = local_338[0];
    local_90 = (_e1401 != 1u);
    bool _e1405 = local_90;
    uint _e1410[2] = qualified_null;
    local_91 = _e1410;
    uint _e1412[2] = local_91;
    local_339 = _e1412;
    uint _e1415 = local_339[0];
    local_92 = (_e1415 != 1u);
    bool _e1419 = local_92;
    uint _e1424[2] = cast_null;
    local_93 = _e1424;
    uint _e1426[2] = local_93;
    local_340 = _e1426;
    uint _e1429 = local_340[0];
    local_94 = (_e1429 != 1u);
    bool _e1433 = local_94;
    uint _e1437[2] = output;
    local_81 = _e1437;
    local_82 = uint(int(0));
    uint _e1442[2] = local_81;
    local_341 = _e1442;
    uint _e1444 = local_82;
    uint _e1446 = local_341[1];
    local_341[1] = (_e1446 + _e1444);
    uint _e1450 = local_341[0];
    local_342 = uint(_e1450);
    uint _e1454 = local_341[1];
    local_343 = uint(_e1454);
    uint _e1457 = local_343;
    output_1.Store(_e1457*4, asuint((((((uint(!(_e1364)) + uint(!(_e1377))) + uint(!(_e1391))) + uint(!(_e1405))) + uint(!(_e1419))) + uint(!(_e1433)))));
    const uint _e1459 = absent_unsigned_u002a();
    const uint _e1460 = absent_const_u0020_unsigned_u002a();
    uint _e1462[2] = output;
    local_95 = _e1462;
    local_96 = uint(int(1));
    uint _e1467[2] = local_95;
    local_344 = _e1467;
    uint _e1469 = local_96;
    uint _e1471 = local_344[1];
    local_344[1] = (_e1471 + _e1469);
    uint _e1475 = local_344[0];
    local_345 = uint(_e1475);
    uint _e1479 = local_344[1];
    local_346 = uint(_e1479);
    uint _e1482 = local_346;
    output_1.Store(_e1482*4, asuint((_e1459 + _e1460)));
    uint _e1484[2] = output;
    local_97 = _e1484;
    local_98 = uint(int(2));
    uint _e1489[2] = local_97;
    local_347 = _e1489;
    uint _e1491 = local_98;
    uint _e1493 = local_347[1];
    local_347[1] = (_e1493 + _e1491);
    uint _e1497 = local_347[0];
    local_348 = uint(_e1497);
    uint _e1501 = local_347[1];
    local_349 = uint(_e1501);
    uint _e1504 = local_349;
    output_1.Store(_e1504*4, asuint(first_copy));
    uint _e1506[2] = braced;
    local_101 = _e1506;
    uint _e1508[2] = local_101;
    local_350 = _e1508;
    uint _e1511 = local_350[0];
    local_351 = uint(_e1511);
    uint _e1515 = local_350[1];
    local_352 = uint(_e1515);
    uint _e1518 = local_351;
    switch(_e1518) {
        case 4u: {
            uint _e1519 = local_352;
            uint _e1521 = shared_[min(uint(_e1519), 2u)];
            local_353 = _e1521;
            break;
        }
        case 3u: {
            uint _e1523 = local_352;
            uint _e1525 = local[min(uint(_e1523), 3u)];
            local_353 = _e1525;
            break;
        }
        default: {
            uint _e1527 = local_352;
            uint _e1529 = asuint(output_1.Load(_e1527*4));
            local_353 = _e1529;
            break;
        }
    }
    uint _e1532 = local_353;
    uint _e1533[2] = output;
    local_99 = _e1533;
    local_100 = uint(int(3));
    uint _e1538[2] = local_99;
    local_354 = _e1538;
    uint _e1540 = local_100;
    uint _e1542 = local_354[1];
    local_354[1] = (_e1542 + _e1540);
    uint _e1546 = local_354[0];
    local_355 = uint(_e1546);
    uint _e1550 = local_354[1];
    local_356 = uint(_e1550);
    uint _e1553 = local_356;
    output_1.Store(_e1553*4, asuint(_e1532));
    uint _e1555[2] = named;
    local_104 = _e1555;
    uint _e1557[2] = local_104;
    local_357 = _e1557;
    uint _e1560 = local_357[0];
    local_358 = uint(_e1560);
    uint _e1564 = local_357[1];
    local_359 = uint(_e1564);
    uint _e1567 = local_358;
    switch(_e1567) {
        case 4u: {
            uint _e1568 = local_359;
            uint _e1570 = shared_[min(uint(_e1568), 2u)];
            local_360 = _e1570;
            break;
        }
        case 3u: {
            uint _e1572 = local_359;
            uint _e1574 = local[min(uint(_e1572), 3u)];
            local_360 = _e1574;
            break;
        }
        default: {
            uint _e1576 = local_359;
            uint _e1578 = asuint(output_1.Load(_e1576*4));
            local_360 = _e1578;
            break;
        }
    }
    uint _e1581 = local_360;
    uint _e1582[2] = output;
    local_102 = _e1582;
    local_103 = uint(int(4));
    uint _e1587[2] = local_102;
    local_361 = _e1587;
    uint _e1589 = local_103;
    uint _e1591 = local_361[1];
    local_361[1] = (_e1591 + _e1589);
    uint _e1595 = local_361[0];
    local_362 = uint(_e1595);
    uint _e1599 = local_361[1];
    local_363 = uint(_e1599);
    uint _e1602 = local_363;
    output_1.Store(_e1602*4, asuint(_e1581));
    uint _e1604[2] = c_style;
    local_107 = _e1604;
    uint _e1606[2] = local_107;
    local_364 = _e1606;
    uint _e1609 = local_364[0];
    local_365 = uint(_e1609);
    uint _e1613 = local_364[1];
    local_366 = uint(_e1613);
    uint _e1616 = local_365;
    switch(_e1616) {
        case 4u: {
            uint _e1617 = local_366;
            uint _e1619 = shared_[min(uint(_e1617), 2u)];
            local_367 = _e1619;
            break;
        }
        case 3u: {
            uint _e1621 = local_366;
            uint _e1623 = local[min(uint(_e1621), 3u)];
            local_367 = _e1623;
            break;
        }
        default: {
            uint _e1625 = local_366;
            uint _e1627 = asuint(output_1.Load(_e1625*4));
            local_367 = _e1627;
            break;
        }
    }
    uint _e1630 = local_367;
    uint _e1631[2] = output;
    local_105 = _e1631;
    local_106 = uint(int(5));
    uint _e1636[2] = local_105;
    local_368 = _e1636;
    uint _e1638 = local_106;
    uint _e1640 = local_368[1];
    local_368[1] = (_e1640 + _e1638);
    uint _e1644 = local_368[0];
    local_369 = uint(_e1644);
    uint _e1648 = local_368[1];
    local_370 = uint(_e1648);
    uint _e1651 = local_370;
    output_1.Store(_e1651*4, asuint(_e1630));
    uint _e1653[2] = cursor;
    local_110 = _e1653;
    uint _e1655[2] = local_110;
    local_371 = _e1655;
    uint _e1658 = local_371[0];
    local_372 = uint(_e1658);
    uint _e1662 = local_371[1];
    local_373 = uint(_e1662);
    uint _e1665 = local_372;
    switch(_e1665) {
        case 4u: {
            uint _e1666 = local_373;
            uint _e1668 = shared_[min(uint(_e1666), 2u)];
            local_374 = _e1668;
            break;
        }
        case 3u: {
            uint _e1670 = local_373;
            uint _e1672 = local[min(uint(_e1670), 3u)];
            local_374 = _e1672;
            break;
        }
        default: {
            uint _e1674 = local_373;
            uint _e1676 = asuint(output_1.Load(_e1674*4));
            local_374 = _e1676;
            break;
        }
    }
    uint _e1679 = local_374;
    uint _e1680[2] = output;
    local_108 = _e1680;
    local_109 = uint(int(6));
    uint _e1685[2] = local_108;
    local_375 = _e1685;
    uint _e1687 = local_109;
    uint _e1689 = local_375[1];
    local_375[1] = (_e1689 + _e1687);
    uint _e1693 = local_375[0];
    local_376 = uint(_e1693);
    uint _e1697 = local_375[1];
    local_377 = uint(_e1697);
    uint _e1700 = local_377;
    output_1.Store(_e1700*4, asuint(_e1679));
    uint _e1702[2] = output;
    local_111 = _e1702;
    local_112 = uint(int(7));
    uint _e1707[2] = local_111;
    local_378 = _e1707;
    uint _e1709 = local_112;
    uint _e1711 = local_378[1];
    local_378[1] = (_e1711 + _e1709);
    uint _e1715 = local_378[0];
    local_379 = uint(_e1715);
    uint _e1719 = local_378[1];
    local_380 = uint(_e1719);
    uint _e1722 = local_380;
    output_1.Store(_e1722*4, asuint(qualified_sum));
    uint _e1724[2] = output;
    local_113 = _e1724;
    local_114 = uint(int(8));
    uint _e1729[2] = local_113;
    local_381 = _e1729;
    uint _e1731 = local_114;
    uint _e1733 = local_381[1];
    local_381[1] = (_e1733 + _e1731);
    uint _e1737 = local_381[0];
    local_382 = uint(_e1737);
    uint _e1741 = local_381[1];
    local_383 = uint(_e1741);
    uint _e1744 = local_383;
    output_1.Store(_e1744*4, asuint(fixed_snapshot));
    uint _e1746[2] = mutable_copy;
    local_117 = _e1746;
    uint _e1748[2] = local_117;
    local_384 = _e1748;
    uint _e1751 = local_384[0];
    local_385 = uint(_e1751);
    uint _e1755 = local_384[1];
    local_386 = uint(_e1755);
    uint _e1758 = local_386;
    uint _e1760 = shared_[min(uint(_e1758), 2u)];
    uint _e1761[2] = output;
    local_115 = _e1761;
    local_116 = uint(int(9));
    uint _e1766[2] = local_115;
    local_387 = _e1766;
    uint _e1768 = local_116;
    uint _e1770 = local_387[1];
    local_387[1] = (_e1770 + _e1768);
    uint _e1774 = local_387[0];
    local_388 = uint(_e1774);
    uint _e1778 = local_387[1];
    local_389 = uint(_e1778);
    uint _e1781 = local_389;
    output_1.Store(_e1781*4, asuint(_e1760));
    uint _e1783[2] = braced_fixed;
    local_120 = _e1783;
    uint _e1785[2] = local_120;
    local_390 = _e1785;
    uint _e1788 = local_390[0];
    local_391 = uint(_e1788);
    uint _e1792 = local_390[1];
    local_392 = uint(_e1792);
    uint _e1795 = local_392;
    uint _e1797 = shared_[min(uint(_e1795), 2u)];
    uint _e1798[2] = output;
    local_118 = _e1798;
    local_119 = uint(int(10));
    uint _e1803[2] = local_118;
    local_393 = _e1803;
    uint _e1805 = local_119;
    uint _e1807 = local_393[1];
    local_393[1] = (_e1807 + _e1805);
    uint _e1811 = local_393[0];
    local_394 = uint(_e1811);
    uint _e1815 = local_393[1];
    local_395 = uint(_e1815);
    uint _e1818 = local_395;
    output_1.Store(_e1818*4, asuint(_e1797));
    uint _e1820[2] = output;
    local_121 = _e1820;
    local_122 = uint(int(11));
    uint _e1825[2] = local_121;
    local_396 = _e1825;
    uint _e1827 = local_122;
    uint _e1829 = local_396[1];
    local_396[1] = (_e1829 + _e1827);
    uint _e1833 = local_396[0];
    local_397 = uint(_e1833);
    uint _e1837 = local_396[1];
    local_398 = uint(_e1837);
    uint _e1840 = local_398;
    output_1.Store(_e1840*4, asuint(functional_snapshot));
    uint _e1842[2] = output;
    local_123 = _e1842;
    local_124 = uint(int(12));
    uint _e1847[2] = local_123;
    local_399 = _e1847;
    uint _e1849 = local_124;
    uint _e1851 = local_399[1];
    local_399[1] = (_e1851 + _e1849);
    uint _e1855 = local_399[0];
    local_400 = uint(_e1855);
    uint _e1859 = local_399[1];
    local_401 = uint(_e1859);
    uint _e1862 = local_401;
    output_1.Store(_e1862*4, asuint(braced_snapshot));
    uint _e1864[2] = output;
    local_125 = _e1864;
    local_126 = uint(int(13));
    uint _e1869[2] = local_125;
    local_402 = _e1869;
    uint _e1871 = local_126;
    uint _e1873 = local_402[1];
    local_402[1] = (_e1873 + _e1871);
    uint _e1877 = local_402[0];
    local_403 = uint(_e1877);
    uint _e1881 = local_402[1];
    local_404 = uint(_e1881);
    uint _e1884 = local_404;
    output_1.Store(_e1884*4, asuint(named_snapshot));
    uint _e1886[2] = output;
    local_127 = _e1886;
    local_128 = uint(int(14));
    uint _e1891[2] = local_127;
    local_405 = _e1891;
    uint _e1893 = local_128;
    uint _e1895 = local_405[1];
    local_405[1] = (_e1895 + _e1893);
    uint _e1899 = local_405[0];
    local_406 = uint(_e1899);
    uint _e1903 = local_405[1];
    local_407 = uint(_e1903);
    uint _e1906 = local_407;
    output_1.Store(_e1906*4, asuint(c_style_snapshot));
    uint _e1908[2] = cursor;
    local_131 = _e1908;
    uint _e1910[2] = local_131;
    local_408 = _e1910;
    uint _e1913 = local_408[0];
    local_409 = uint(_e1913);
    uint _e1917 = local_408[1];
    local_410 = uint(_e1917);
    uint _e1920 = local_409;
    switch(_e1920) {
        case 4u: {
            uint _e1921 = local_410;
            uint _e1923 = shared_[min(uint(_e1921), 2u)];
            local_411 = _e1923;
            break;
        }
        case 3u: {
            uint _e1925 = local_410;
            uint _e1927 = local[min(uint(_e1925), 3u)];
            local_411 = _e1927;
            break;
        }
        default: {
            uint _e1929 = local_410;
            uint _e1931 = asuint(output_1.Load(_e1929*4));
            local_411 = _e1931;
            break;
        }
    }
    uint _e1934 = local_411;
    uint _e1935[2] = output;
    local_129 = _e1935;
    local_130 = uint(int(15));
    uint _e1940[2] = local_129;
    local_412 = _e1940;
    uint _e1942 = local_130;
    uint _e1944 = local_412[1];
    local_412[1] = (_e1944 + _e1942);
    uint _e1948 = local_412[0];
    local_413 = uint(_e1948);
    uint _e1952 = local_412[1];
    local_414 = uint(_e1952);
    uint _e1955 = local_414;
    output_1.Store(_e1955*4, asuint(_e1934));
    uint _e1957 = local_284;
    switch(_e1957) {
        case 3u: {
            uint _e1958 = local_285;
            uint _e1960 = local[min(uint(_e1958), 3u)];
            local_415 = _e1960;
            break;
        }
        default: {
            uint _e1962 = local_285;
            uint _e1964 = shared_[min(uint(_e1962), 2u)];
            local_415 = _e1964;
            break;
        }
    }
    uint _e1967 = local_415;
    uint _e1968[2] = output;
    local_132 = _e1968;
    local_133 = uint(int(16));
    uint _e1973[2] = local_132;
    local_416 = _e1973;
    uint _e1975 = local_133;
    uint _e1977 = local_416[1];
    local_416[1] = (_e1977 + _e1975);
    uint _e1981 = local_416[0];
    local_417 = uint(_e1981);
    uint _e1985 = local_416[1];
    local_418 = uint(_e1985);
    uint _e1988 = local_418;
    output_1.Store(_e1988*4, asuint(_e1967));
    uint _e1990[2] = captured;
    local_136 = _e1990;
    uint _e1992[2] = local_136;
    local_419 = _e1992;
    uint _e1995 = local_419[0];
    local_420 = uint(_e1995);
    uint _e1999 = local_419[1];
    local_421 = uint(_e1999);
    uint _e2002 = local_420;
    switch(_e2002) {
        case 3u: {
            uint _e2003 = local_421;
            uint _e2005 = local[min(uint(_e2003), 3u)];
            local_422 = _e2005;
            break;
        }
        default: {
            uint _e2007 = local_421;
            uint _e2009 = shared_[min(uint(_e2007), 2u)];
            local_422 = _e2009;
            break;
        }
    }
    uint _e2012 = local_422;
    uint _e2013[2] = output;
    local_134 = _e2013;
    local_135 = uint(int(17));
    uint _e2018[2] = local_134;
    local_423 = _e2018;
    uint _e2020 = local_135;
    uint _e2022 = local_423[1];
    local_423[1] = (_e2022 + _e2020);
    uint _e2026 = local_423[0];
    local_424 = uint(_e2026);
    uint _e2030 = local_423[1];
    local_425 = uint(_e2030);
    uint _e2033 = local_425;
    output_1.Store(_e2033*4, asuint(_e2012));
    uint _e2036[2] = frozen;
    local_139 = _e2036;
    uint _e2038[2] = local_139;
    local_426 = _e2038;
    uint _e2041 = local_426[0];
    local_427 = uint(_e2041);
    uint _e2045 = local_426[1];
    local_428 = uint(_e2045);
    uint _e2048 = local_428;
    uint _e2050 = local[min(uint(_e2048), 3u)];
    uint _e2051[2] = output;
    local_137 = _e2051;
    local_138 = uint(int(18));
    uint _e2056[2] = local_137;
    local_429 = _e2056;
    uint _e2058 = local_138;
    uint _e2060 = local_429[1];
    local_429[1] = (_e2060 + _e2058);
    uint _e2064 = local_429[0];
    local_430 = uint(_e2064);
    uint _e2068 = local_429[1];
    local_431 = uint(_e2068);
    uint _e2071 = local_431;
    output_1.Store(_e2071*4, asuint(_e2050));
    uint _e2073 = index;
    uint _e2074[2] = output;
    local_140 = _e2074;
    local_141 = uint(int(19));
    uint _e2079[2] = local_140;
    local_432 = _e2079;
    uint _e2081 = local_141;
    uint _e2083 = local_432[1];
    local_432[1] = (_e2083 + _e2081);
    uint _e2087 = local_432[0];
    local_433 = uint(_e2087);
    uint _e2091 = local_432[1];
    local_434 = uint(_e2091);
    uint _e2094 = local_434;
    output_1.Store(_e2094*4, asuint(_e2073));
    uint _e2096[2] = output;
    local_142 = _e2096;
    local_143 = uint(int(20));
    uint _e2101[2] = local_142;
    local_435 = _e2101;
    uint _e2103 = local_143;
    uint _e2105 = local_435[1];
    local_435[1] = (_e2105 + _e2103);
    uint _e2109 = local_435[0];
    local_436 = uint(_e2109);
    uint _e2113 = local_435[1];
    local_437 = uint(_e2113);
    uint _e2116 = local_437;
    output_1.Store(_e2116*4, asuint(after_capture));
    local_199 = ZeroValueuint();
    source = ZeroValuearray2_uint_();
    source[0] = 3u;
    source[1] = 0u;
    uint _e2127[2] = source;
    local_197 = _e2127;
    uint _e2129[2] = local_197;
    copy = _e2129;
    uint _e2132[2] = copy;
    local_198 = _e2132;
    uint _e2134[2] = local_198;
    local_438 = _e2134;
    uint _e2137 = local_438[0];
    local_439 = uint(_e2137);
    uint _e2141 = local_438[1];
    local_440 = uint(_e2141);
    uint _e2144 = local_440;
    uint _e2146 = local[min(uint(_e2144), 3u)];
    local_199 = _e2146;
    uint _e2148 = local_199;
    local_202 = ZeroValueuint();
    source_1 = ZeroValuearray2_uint_();
    source_1[0] = 4u;
    source_1[1] = 0u;
    uint _e2158[2] = source_1;
    local_200 = _e2158;
    uint _e2160[2] = local_200;
    copy_1 = _e2160;
    uint _e2163[2] = copy_1;
    local_201 = _e2163;
    uint _e2165[2] = local_201;
    local_441 = _e2165;
    uint _e2168 = local_441[0];
    local_442 = uint(_e2168);
    uint _e2172 = local_441[1];
    local_443 = uint(_e2172);
    uint _e2175 = local_443;
    uint _e2177 = shared_[min(uint(_e2175), 2u)];
    local_202 = _e2177;
    uint _e2179 = local_202;
    uint _e2181[2] = output;
    local_144 = _e2181;
    local_145 = uint(int(21));
    uint _e2186[2] = local_144;
    local_444 = _e2186;
    uint _e2188 = local_145;
    uint _e2190 = local_444[1];
    local_444[1] = (_e2190 + _e2188);
    uint _e2194 = local_444[0];
    local_445 = uint(_e2194);
    uint _e2198 = local_444[1];
    local_446 = uint(_e2198);
    uint _e2201 = local_446;
    output_1.Store(_e2201*4, asuint((_e2148 + _e2179)));
    uint _e2203 = guarded_total;
    uint _e2204[2] = output;
    local_146 = _e2204;
    local_147 = uint(int(25));
    uint _e2209[2] = local_146;
    local_447 = _e2209;
    uint _e2211 = local_147;
    uint _e2213 = local_447[1];
    local_447[1] = (_e2213 + _e2211);
    uint _e2217 = local_447[0];
    local_448 = uint(_e2217);
    uint _e2221 = local_447[1];
    local_449 = uint(_e2221);
    uint _e2224 = local_449;
    output_1.Store(_e2224*4, asuint(_e2203));
    uint _e2226[2] = kept;
    local_150 = _e2226;
    uint _e2228[2] = local_150;
    local_450 = _e2228;
    uint _e2231 = local_450[0];
    local_151 = (_e2231 != 1u);
    bool _e2235 = local_151;
    uint _e2238[2] = old_null;
    local_152 = _e2238;
    uint _e2240[2] = local_152;
    local_451 = _e2240;
    uint _e2243 = local_451[0];
    local_153 = (_e2243 != 1u);
    bool _e2247 = local_153;
    uint _e2251[2] = output;
    local_148 = _e2251;
    local_149 = uint(int(26));
    uint _e2256[2] = local_148;
    local_452 = _e2256;
    uint _e2258 = local_149;
    uint _e2260 = local_452[1];
    local_452[1] = (_e2260 + _e2258);
    uint _e2264 = local_452[0];
    local_453 = uint(_e2264);
    uint _e2268 = local_452[1];
    local_454 = uint(_e2268);
    uint _e2271 = local_454;
    output_1.Store(_e2271*4, asuint((uint(!(_e2235)) + uint(!(_e2247)))));
    uint _e2273[2] = output;
    local_154 = _e2273;
    local_155 = uint(int(27));
    uint _e2278[2] = local_154;
    local_455 = _e2278;
    uint _e2280 = local_155;
    uint _e2282 = local_455[1];
    local_455[1] = (_e2282 + _e2280);
    uint _e2286 = local_455[0];
    local_456 = uint(_e2286);
    uint _e2290 = local_455[1];
    local_457 = uint(_e2290);
    uint _e2293 = local_457;
    output_1.Store(_e2293*4, asuint(selected_snapshot));
    uint _e2296[2] = selected;
    local_158 = _e2296;
    uint _e2298[2] = local_158;
    local_458 = _e2298;
    uint _e2301 = local_458[0];
    local_159 = (_e2301 != 1u);
    bool _e2305 = local_159;
    uint _e2311[2] = output;
    local_156 = _e2311;
    local_157 = uint(int(28));
    uint _e2316[2] = local_156;
    local_459 = _e2316;
    uint _e2318 = local_157;
    uint _e2320 = local_459[1];
    local_459[1] = (_e2320 + _e2318);
    uint _e2324 = local_459[0];
    local_460 = uint(_e2324);
    uint _e2328 = local_459[1];
    local_461 = uint(_e2328);
    uint _e2331 = local_461;
    output_1.Store(_e2331*4, asuint((uint(_e1239) + (2u * uint(!(_e2305))))));
    uint _e2333 = counter;
    uint _e2334[2] = output;
    local_160 = _e2334;
    local_161 = uint(int(29));
    uint _e2339[2] = local_160;
    local_462 = _e2339;
    uint _e2341 = local_161;
    uint _e2343 = local_462[1];
    local_462[1] = (_e2343 + _e2341);
    uint _e2347 = local_462[0];
    local_463 = uint(_e2347);
    uint _e2351 = local_462[1];
    local_464 = uint(_e2351);
    uint _e2354 = local_464;
    output_1.Store(_e2354*4, asuint(_e2333));
    local_164 = uint(int(2));
    local_205 = ZeroValueuint();
    source_2 = ZeroValuearray2_uint_();
    source_2[0] = 3u;
    source_2[1] = 0u;
    uint _e2367 = local_164;
    uint _e2369 = source_2[1];
    source_2[1] = (_e2369 + _e2367);
    uint _e2373[2] = source_2;
    local_203 = _e2373;
    uint _e2375[2] = local_203;
    copy_2 = _e2375;
    uint _e2378[2] = copy_2;
    local_204 = _e2378;
    uint _e2380[2] = local_204;
    local_465 = _e2380;
    uint _e2383 = local_465[0];
    local_466 = uint(_e2383);
    uint _e2387 = local_465[1];
    local_467 = uint(_e2387);
    uint _e2390 = local_467;
    uint _e2392 = local[min(uint(_e2390), 3u)];
    local_205 = _e2392;
    uint _e2394 = local_205;
    uint _e2395[2] = output;
    local_162 = _e2395;
    local_163 = uint(int(30));
    uint _e2400[2] = local_162;
    local_468 = _e2400;
    uint _e2402 = local_163;
    uint _e2404 = local_468[1];
    local_468[1] = (_e2404 + _e2402);
    uint _e2408 = local_468[0];
    local_469 = uint(_e2408);
    uint _e2412 = local_468[1];
    local_470 = uint(_e2412);
    uint _e2415 = local_470;
    output_1.Store(_e2415*4, asuint(_e2394));
    local_471 = ZeroValuearray2_uint_();
    local_471[0] = 1u;
    uint _e2422 = local_471[0];
    local_167 = (_e2422 != 1u);
    bool _e2426 = local_167;
    local_472 = ZeroValuearray2_uint_();
    local_472[0] = 1u;
    uint _e2434 = local_472[0];
    local_168 = (_e2434 != 1u);
    bool _e2438 = local_168;
    uint _e2442[2] = output;
    local_165 = _e2442;
    local_166 = uint(int(31));
    uint _e2447[2] = local_165;
    local_473 = _e2447;
    uint _e2449 = local_166;
    uint _e2451 = local_473[1];
    local_473[1] = (_e2451 + _e2449);
    uint _e2455 = local_473[0];
    local_474 = uint(_e2455);
    uint _e2459 = local_473[1];
    local_475 = uint(_e2459);
    uint _e2462 = local_475;
    output_1.Store(_e2462*4, asuint((uint(!(_e2426)) + uint(!(_e2438)))));
    uint _e2466 = local[int(0)];
    uint _e2467[2] = output;
    local_169 = _e2467;
    local_170 = uint(int(35));
    uint _e2472[2] = local_169;
    local_476 = _e2472;
    uint _e2474 = local_170;
    uint _e2476 = local_476[1];
    local_476[1] = (_e2476 + _e2474);
    uint _e2480 = local_476[0];
    local_477 = uint(_e2480);
    uint _e2484 = local_476[1];
    local_478 = uint(_e2484);
    uint _e2487 = local_478;
    output_1.Store(_e2487*4, asuint(_e2466));
    uint _e2491 = local[int(1)];
    uint _e2492[2] = output;
    local_171 = _e2492;
    local_172 = uint(int(36));
    uint _e2497[2] = local_171;
    local_479 = _e2497;
    uint _e2499 = local_172;
    uint _e2501 = local_479[1];
    local_479[1] = (_e2501 + _e2499);
    uint _e2505 = local_479[0];
    local_480 = uint(_e2505);
    uint _e2509 = local_479[1];
    local_481 = uint(_e2509);
    uint _e2512 = local_481;
    output_1.Store(_e2512*4, asuint(_e2491));
    uint _e2516 = shared_[int(1)];
    uint _e2517[2] = output;
    local_173 = _e2517;
    local_174 = uint(int(37));
    uint _e2522[2] = local_173;
    local_482 = _e2522;
    uint _e2524 = local_174;
    uint _e2526 = local_482[1];
    local_482[1] = (_e2526 + _e2524);
    uint _e2530 = local_482[0];
    local_483 = uint(_e2530);
    uint _e2534 = local_482[1];
    local_484 = uint(_e2534);
    uint _e2537 = local_484;
    output_1.Store(_e2537*4, asuint(_e2516));
    uint _e2541 = shared_[int(2)];
    uint _e2542[2] = output;
    local_175 = _e2542;
    local_176 = uint(int(38));
    uint _e2547[2] = local_175;
    local_485 = _e2547;
    uint _e2549 = local_176;
    uint _e2551 = local_485[1];
    local_485[1] = (_e2551 + _e2549);
    uint _e2555 = local_485[0];
    local_486 = uint(_e2555);
    uint _e2559 = local_485[1];
    local_487 = uint(_e2559);
    uint _e2562 = local_487;
    output_1.Store(_e2562*4, asuint(_e2541));
    uint _e2564[2] = old_null;
    local_179 = _e2564;
    uint _e2566[2] = local_179;
    local_488 = _e2566;
    uint _e2569 = local_488[0];
    local_180 = (_e2569 != 1u);
    bool _e2573 = local_180;
    uint _e2578[2] = selected;
    local_181 = _e2578;
    uint _e2580[2] = local_181;
    local_489 = _e2580;
    uint _e2583 = local_489[0];
    local_182 = (_e2583 != 1u);
    bool _e2587 = local_182;
    uint _e2591[2] = output;
    local_177 = _e2591;
    local_178 = uint(int(39));
    uint _e2596[2] = local_177;
    local_490 = _e2596;
    uint _e2598 = local_178;
    uint _e2600 = local_490[1];
    local_490[1] = (_e2600 + _e2598);
    uint _e2604 = local_490[0];
    local_491 = uint(_e2604);
    uint _e2608 = local_490[1];
    local_492 = uint(_e2608);
    uint _e2611 = local_492;
    output_1.Store(_e2611*4, asuint(((uint(!(_e2573)) + uint(_e1239)) + uint(!(_e2587)))));
}
