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
    var local_77: bool;

    value_7 = value_6;
    let _e4 = value_7.x;
    let _e5 = (_e4 == 0i);
    local_77 = _e5;
    if _e5 {
        let _e9 = value_7.y;
        local_77 = (_e9 == 0i);
    }
    let _e11 = local_77;
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
    var local_78: u32;
    var local_79: u32;

    left_18 = left_17;
    right_18 = right_17;
    let _e5 = left_18.x;
    let _e7 = right_18.x;
    local_78 = u32(_e7);
    let _e10 = local_78;
    let _e13 = left_18.y;
    let _e15 = right_18.y;
    local_79 = u32(_e15);
    let _e18 = local_79;
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

    value_19 = value_18;
    let _e4 = value_19.value;
    value_19.value = (_e4 * factor);
    let _e9 = value_19.history[1i];
    value_19.history[1i] = (_e9 + factor);
    let _e11 = value_19;
    return _e11;
}

@compute @workgroup_size(2, 1, 1)
fn operator_functions(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var left: vec2<i32>;
    var local: u32;
    var right: vec2<i32>;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
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
    var original: Record_cuda_record_0_;
    var scaled: Record_cuda_record_0_;
    var local_27: u32;
    var local_28: Record_cuda_record_0_;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: vec2<i32>;
    var local_39: u32;
    var local_40: vec2<i32>;
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

    let base = (threadIdx.x * 36u);
    local = u32(threadIdx.x);
    let _e7 = local;
    local_39 = u32(_e7);
    let _e10 = local_39;
    let _e13 = input[_e10];
    local_40 = _e13;
    let _e15 = local_40;
    local_38 = _e15;
    let _e17 = local_38;
    left = _e17;
    right = vec2<i32>(3i, 2i);
    let _e23 = left;
    let _e24 = operator_u002b(_e23);
    local_1 = u32((base + 0u));
    let _e31 = local_1;
    local_41 = u32(_e31);
    let _e34 = local_41;
    out[_e34] = u32(_e24.x);
    let _e37 = left;
    let _e38 = operator_u002d(_e37);
    local_2 = u32((base + 1u));
    let _e45 = local_2;
    local_42 = u32(_e45);
    let _e48 = local_42;
    out[_e48] = u32(_e38.y);
    let _e50 = left;
    let _e51 = operator_u007e(_e50);
    local_3 = u32((base + 2u));
    let _e58 = local_3;
    local_43 = u32(_e58);
    let _e61 = local_43;
    out[_e61] = u32(_e51.x);
    let _e63 = left;
    let _e64 = operator_u0021_(_e63);
    local_4 = u32((base + 3u));
    let _e70 = local_4;
    local_44 = u32(_e70);
    let _e73 = local_44;
    out[_e73] = u32(_e64);
    let _e75 = left;
    let _e76 = operator_u002a(_e75);
    local_5 = u32((base + 4u));
    let _e82 = local_5;
    local_45 = u32(_e82);
    let _e85 = local_45;
    out[_e85] = u32(_e76);
    let _e87 = left;
    let _e88 = operator_u0026_(_e87);
    local_6 = u32((base + 5u));
    let _e95 = local_6;
    local_46 = u32(_e95);
    let _e98 = local_46;
    out[_e98] = u32(_e88.x);
    let _e100 = left;
    let _e101 = right;
    let _e102 = operator_u002b_1(_e100, _e101);
    local_7 = u32((base + 6u));
    let _e109 = local_7;
    local_47 = u32(_e109);
    let _e112 = local_47;
    out[_e112] = u32(_e102.x);
    let _e114 = left;
    let _e115 = right;
    let _e116 = operator_u002d_1(_e114, _e115);
    local_8 = u32((base + 7u));
    let _e123 = local_8;
    local_48 = u32(_e123);
    let _e126 = local_48;
    out[_e126] = u32(_e116.y);
    let _e128 = left;
    let _e129 = right;
    let _e130 = operator_u002a_1(_e128, _e129);
    local_9 = u32((base + 8u));
    let _e137 = local_9;
    local_49 = u32(_e137);
    let _e140 = local_49;
    out[_e140] = u32(_e130.x);
    let _e142 = left;
    let _e143 = right;
    let _e144 = operator_u002f(_e142, _e143);
    local_10 = u32((base + 9u));
    let _e151 = local_10;
    local_50 = u32(_e151);
    let _e154 = local_50;
    out[_e154] = u32(_e144.y);
    let _e156 = left;
    let _e157 = right;
    let _e158 = operator_u0025_(_e156, _e157);
    local_11 = u32((base + 10u));
    let _e165 = local_11;
    local_51 = u32(_e165);
    let _e168 = local_51;
    out[_e168] = u32(_e158.y);
    let _e170 = left;
    let _e171 = right;
    let _e172 = operator_u0026_1(_e170, _e171);
    local_12 = u32((base + 11u));
    let _e179 = local_12;
    local_52 = u32(_e179);
    let _e182 = local_52;
    out[_e182] = u32(_e172.x);
    let _e184 = left;
    let _e185 = right;
    let _e186 = operator_u007c(_e184, _e185);
    local_13 = u32((base + 12u));
    let _e193 = local_13;
    local_53 = u32(_e193);
    let _e196 = local_53;
    out[_e196] = u32(_e186.y);
    let _e198 = left;
    let _e199 = right;
    let _e200 = operator_u005e(_e198, _e199);
    local_14 = u32((base + 13u));
    let _e207 = local_14;
    local_54 = u32(_e207);
    let _e210 = local_54;
    out[_e210] = u32(_e200.x);
    let _e212 = left;
    let _e213 = right;
    let _e214 = operator_(_e212, _e213);
    local_15 = u32((base + 14u));
    let _e221 = local_15;
    local_55 = u32(_e221);
    let _e224 = local_55;
    out[_e224] = u32(_e214.x);
    let _e226 = left;
    let _e227 = right;
    let _e228 = operator_1(_e226, _e227);
    local_16 = u32((base + 15u));
    let _e235 = local_16;
    local_56 = u32(_e235);
    let _e238 = local_56;
    out[_e238] = u32(_e228.y);
    let _e240 = left;
    let _e241 = operator_u002b(_e240);
    local_17 = u32((base + 16u));
    let _e248 = local_17;
    local_57 = u32(_e248);
    let _e251 = local_57;
    out[_e251] = u32(_e241.y);
    let _e253 = left;
    let _e254 = right;
    let _e255 = operator_u002d_1(_e253, _e254);
    local_18 = u32((base + 17u));
    let _e262 = local_18;
    local_58 = u32(_e262);
    let _e265 = local_58;
    out[_e265] = u32(_e255.x);
    let _e267 = left;
    let _e268 = operator_u002a(_e267);
    local_19 = u32((base + 18u));
    let _e274 = local_19;
    local_59 = u32(_e274);
    let _e277 = local_59;
    out[_e277] = u32(_e268);
    let _e279 = left;
    let _e280 = right;
    let _e281 = operator_u0026_1(_e279, _e280);
    local_20 = u32((base + 19u));
    let _e288 = local_20;
    local_60 = u32(_e288);
    let _e291 = local_60;
    out[_e291] = u32(_e281.y);
    let _e293 = left;
    let _e294 = operator_u0026_(_e293);
    let _e295 = operator_u002a(_e294);
    local_21 = u32((base + 20u));
    let _e301 = local_21;
    local_61 = u32(_e301);
    let _e304 = local_61;
    out[_e304] = u32(_e295);
    let _e306 = left;
    let _e307 = operator_u0026_(_e306);
    let _e308 = operator_u0026_(_e307);
    local_22 = u32((base + 21u));
    let _e315 = local_22;
    local_62 = u32(_e315);
    let _e318 = local_62;
    out[_e318] = u32(_e308.x);
    let _e320 = left;
    let _e321 = right;
    let _e322 = right;
    let _e323 = operator_u002a_1(_e321, _e322);
    let _e324 = operator_u002b_1(_e320, _e323);
    local_23 = u32((base + 22u));
    let _e331 = local_23;
    local_63 = u32(_e331);
    let _e334 = local_63;
    out[_e334] = u32(_e324.x);
    let _e336 = left;
    let _e337 = right;
    let _e341 = operator_u002b_1(_e337, vec2<i32>(1i, 1i));
    let _e342 = operator_(_e336, _e341);
    local_24 = u32((base + 23u));
    let _e349 = local_24;
    local_64 = u32(_e349);
    let _e352 = local_64;
    out[_e352] = u32(_e342.x);
    let _e354 = left;
    let _e355 = right;
    let _e359 = operator_u0026_1(_e355, vec2<i32>(1i, 1i));
    let _e360 = operator_u007c(_e354, _e359);
    local_25 = u32((base + 24u));
    let _e367 = local_25;
    local_65 = u32(_e367);
    let _e370 = local_65;
    out[_e370] = u32(_e360.y);
    let _e372 = left;
    let _e373 = right;
    let _e374 = operator_u002d_1(_e372, _e373);
    let _e375 = right;
    let _e376 = operator_u002d_1(_e374, _e375);
    local_26 = u32((base + 25u));
    let _e383 = local_26;
    local_66 = u32(_e383);
    let _e386 = local_66;
    out[_e386] = u32(_e376.x);
    original.value = 9i;
    original.history[0] = 1i;
    original.history[1] = 2i;
    let _e396 = original;
    let _e398 = operator_u002a_3(_e396, 3i);
    scaled = _e398;
    local_28.value = 9i;
    local_28.history[0] = 1i;
    local_28.history[1] = 2i;
    let _e408 = local_28;
    let _e409 = operator_u0026_2(_e408);
    local_27 = u32((base + 26u));
    let _e415 = local_27;
    local_67 = u32(_e415);
    let _e418 = local_67;
    out[_e418] = u32(_e409);
    let _e420 = original;
    let _e421 = operator_u002a_2(_e420);
    let _e422 = operator_u0026_2(_e421);
    local_29 = u32((base + 27u));
    let _e428 = local_29;
    local_68 = u32(_e428);
    let _e431 = local_68;
    out[_e431] = u32(_e422);
    let _e434 = scaled.value;
    local_30 = u32((base + 28u));
    let _e440 = local_30;
    local_69 = u32(_e440);
    let _e443 = local_69;
    out[_e443] = u32(_e434);
    let _e448 = scaled.history[1i];
    local_31 = u32((base + 29u));
    let _e454 = local_31;
    local_70 = u32(_e454);
    let _e457 = local_70;
    out[_e457] = u32(_e448);
    let _e460 = original.value;
    local_32 = u32((base + 30u));
    let _e466 = local_32;
    local_71 = u32(_e466);
    let _e469 = local_71;
    out[_e469] = u32(_e460);
    let _e474 = original.history[1i];
    local_33 = u32((base + 31u));
    let _e480 = local_33;
    local_72 = u32(_e480);
    let _e483 = local_72;
    out[_e483] = u32(_e474);
    let _e485 = original;
    let _e486 = operator_u002d_2(_e485);
    local_34 = u32((base + 32u));
    let _e493 = local_34;
    local_73 = u32(_e493);
    let _e496 = local_73;
    out[_e496] = u32(_e486.value);
    let _e498 = original;
    let _e500 = operator_u002a_3(_e498, 2i);
    local_35 = u32((base + 33u));
    let _e507 = local_35;
    local_74 = u32(_e507);
    let _e510 = local_74;
    out[_e510] = u32(_e500.value);
    let _e512 = original;
    let _e513 = operator_u002a_2(_e512);
    let _e514 = operator_u0026_2(_e513);
    local_36 = u32((base + 34u));
    let _e520 = local_36;
    local_75 = u32(_e520);
    let _e523 = local_75;
    out[_e523] = u32(_e514);
    let _e528 = operator_u0021_(vec2<i32>(0i, 0i));
    local_37 = u32((base + 35u));
    let _e534 = local_37;
    local_76 = u32(_e534);
    let _e537 = local_76;
    out[_e537] = u32(_e528);
}
