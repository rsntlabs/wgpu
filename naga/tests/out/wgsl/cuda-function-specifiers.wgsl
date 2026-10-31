struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
@group(0) @binding(1)
var<storage> input_1: array<i32>;
@group(0) @binding(2)
var<uniform> n: type_5;

fn increment(value_1: i32) -> i32 {
    var value_2: i32;

    value_2 = value_1;
    let _e3 = value_2;
    value_2 = (_e3 + 2i);
    let _e5 = value_2;
    return _e5;
}

fn twice(value_3: i32) -> i32 {
    let _e1 = increment(value_3);
    return (_e1 * 2i);
}

fn advance(value_4: i32) -> i32 {
    let _e1 = twice(value_4);
    return (_e1 + 1i);
}

fn retreat(value_5: i32) -> i32 {
    return (value_5 - 3i);
}

fn scaled(value_6: f32) -> f32 {
    return ((value_6 * 1.5f) + 0.5f);
}

fn differs(value_7: i32, other: i32) -> bool {
    return (value_7 != other);
}

fn consume(stop: bool, value_8: i32) {
    var value_9: i32;

    value_9 = value_8;
    if stop {
        return;
    }
    let _e3 = value_9;
    let _e4 = advance(_e3);
    value_9 = _e4;
    return;
}

fn forward(stop_1: bool, value_10: i32) {
    let _e2 = retreat(value_10);
    consume(stop_1, _e2);
    return;
}

fn plus_one(value_11: u32) -> u32 {
    return (value_11 + 1u);
}

@compute @workgroup_size(64, 1, 1)
fn function_specifiers(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var out: array<u32, 2>;
    var input: array<u32, 2>;
    var base: u32;
    var value: i32;
    var local: array<u32, 2>;
    var local_1: u32;
    var choose: bool;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var effect: i32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var local_20: array<u32, 2>;
    var local_21: u32;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var local_30: i32;
    var local_31: i32;
    var local_32: i32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var local_35: u32;
    var local_36: i32;
    var local_37: array<u32, 2>;
    var local_38: u32;
    var local_39: u32;
    var local_40: array<u32, 2>;
    var local_41: u32;
    var local_42: u32;
    var local_43: array<u32, 2>;
    var local_44: u32;
    var local_45: u32;
    var local_46: array<u32, 2>;
    var local_47: u32;
    var local_48: u32;
    var local_49: array<u32, 2>;
    var local_50: u32;
    var local_51: u32;
    var local_52: array<u32, 2>;
    var local_53: u32;
    var local_54: u32;
    var local_55: i32;
    var local_56: array<u32, 2>;
    var local_57: u32;
    var local_58: u32;
    var local_59: array<u32, 2>;
    var local_60: u32;
    var local_61: u32;
    var local_62: array<u32, 2>;
    var local_63: u32;
    var local_64: u32;
    var local_65: array<u32, 2>;
    var local_66: u32;
    var local_67: u32;
    var local_68: array<u32, 2>;
    var local_69: u32;
    var local_70: u32;
    var local_71: array<u32, 2>;
    var local_72: u32;
    var local_73: u32;
    var local_74: i32;
    var local_75: array<u32, 2>;
    var local_76: u32;
    var local_77: u32;
    var local_78: array<u32, 2>;
    var local_79: u32;
    var local_80: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    input = array<u32, 2>();
    input[0] = 1u;
    input[1] = 0u;
    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 12u);
        let _e27 = input;
        local = _e27;
        local_1 = u32(i);
        let _e31 = local;
        local_33 = _e31;
        let _e33 = local_1;
        let _e35 = local_33[1];
        local_33[1] = (_e35 + _e33);
        let _e39 = local_33[0];
        local_34 = u32(_e39);
        let _e43 = local_33[1];
        local_35 = u32(_e43);
        let _e46 = local_35;
        let _e49 = input_1[_e46];
        local_36 = _e49;
        let _e51 = local_36;
        local_30 = _e51;
        let _e53 = local_30;
        value = _e53;
        choose = ((i % 2u) == 0u);
        let _e60 = value;
        let _e61 = increment(_e60);
        let _e63 = out;
        local_2 = _e63;
        let _e65 = base;
        local_3 = u32(_e65);
        let _e68 = local_2;
        local_37 = _e68;
        let _e70 = local_3;
        let _e72 = local_37[1];
        local_37[1] = (_e72 + _e70);
        let _e76 = local_37[0];
        local_38 = u32(_e76);
        let _e80 = local_37[1];
        local_39 = u32(_e80);
        let _e83 = local_39;
        out_1[_e83] = _e61;
        let _e86 = value;
        let _e87 = twice(_e86);
        let _e88 = out;
        local_4 = _e88;
        let _e90 = base;
        local_5 = u32((_e90 + 1u));
        let _e95 = local_4;
        local_40 = _e95;
        let _e97 = local_5;
        let _e99 = local_40[1];
        local_40[1] = (_e99 + _e97);
        let _e103 = local_40[0];
        local_41 = u32(_e103);
        let _e107 = local_40[1];
        local_42 = u32(_e107);
        let _e110 = local_42;
        out_1[_e110] = _e87;
        let _e112 = value;
        let _e113 = advance(_e112);
        let _e114 = out;
        local_6 = _e114;
        let _e116 = base;
        local_7 = u32((_e116 + 2u));
        let _e121 = local_6;
        local_43 = _e121;
        let _e123 = local_7;
        let _e125 = local_43[1];
        local_43[1] = (_e125 + _e123);
        let _e129 = local_43[0];
        local_44 = u32(_e129);
        let _e133 = local_43[1];
        local_45 = u32(_e133);
        let _e136 = local_45;
        out_1[_e136] = _e113;
        let _e138 = value;
        let _e139 = retreat(_e138);
        let _e140 = out;
        local_8 = _e140;
        let _e142 = base;
        local_9 = u32((_e142 + 3u));
        let _e147 = local_8;
        local_46 = _e147;
        let _e149 = local_9;
        let _e151 = local_46[1];
        local_46[1] = (_e151 + _e149);
        let _e155 = local_46[0];
        local_47 = u32(_e155);
        let _e159 = local_46[1];
        local_48 = u32(_e159);
        let _e162 = local_48;
        out_1[_e162] = _e139;
        let _e164 = value;
        let _e166 = scaled(f32(_e164));
        let _e167 = out;
        local_10 = _e167;
        let _e169 = base;
        local_11 = u32((_e169 + 4u));
        let _e175 = local_10;
        local_49 = _e175;
        let _e177 = local_11;
        let _e179 = local_49[1];
        local_49[1] = (_e179 + _e177);
        let _e183 = local_49[0];
        local_50 = u32(_e183);
        let _e187 = local_49[1];
        local_51 = u32(_e187);
        let _e190 = local_51;
        out_1[_e190] = i32(_e166);
        let _e192 = value;
        let _e193 = input;
        local_14 = _e193;
        local_15 = u32(i);
        let _e197 = local_14;
        local_52 = _e197;
        let _e199 = local_15;
        let _e201 = local_52[1];
        local_52[1] = (_e201 + _e199);
        let _e205 = local_52[0];
        local_53 = u32(_e205);
        let _e209 = local_52[1];
        local_54 = u32(_e209);
        let _e212 = local_54;
        let _e214 = input_1[_e212];
        local_55 = _e214;
        let _e216 = local_55;
        local_31 = _e216;
        let _e218 = local_31;
        let _e219 = differs(_e192, _e218);
        let _e220 = out;
        local_12 = _e220;
        let _e222 = base;
        local_13 = u32((_e222 + 5u));
        let _e228 = local_12;
        local_56 = _e228;
        let _e230 = local_13;
        let _e232 = local_56[1];
        local_56[1] = (_e232 + _e230);
        let _e236 = local_56[0];
        local_57 = u32(_e236);
        let _e240 = local_56[1];
        local_58 = u32(_e240);
        let _e243 = local_58;
        out_1[_e243] = i32(_e219);
        let _e245 = value;
        effect = _e245;
        let _e247 = choose;
        let _e248 = effect;
        effect = (_e248 + 1i);
        consume(_e247, _e248);
        let _e251 = effect;
        let _e252 = out;
        local_16 = _e252;
        let _e254 = base;
        local_17 = u32((_e254 + 6u));
        let _e259 = local_16;
        local_59 = _e259;
        let _e261 = local_17;
        let _e263 = local_59[1];
        local_59[1] = (_e263 + _e261);
        let _e267 = local_59[0];
        local_60 = u32(_e267);
        let _e271 = local_59[1];
        local_61 = u32(_e271);
        let _e274 = local_61;
        out_1[_e274] = _e251;
        let _e276 = choose;
        let _e278 = effect;
        effect = (_e278 + 1i);
        forward(!(_e276), _e278);
        let _e281 = effect;
        let _e282 = out;
        local_18 = _e282;
        let _e284 = base;
        local_19 = u32((_e284 + 7u));
        let _e289 = local_18;
        local_62 = _e289;
        let _e291 = local_19;
        let _e293 = local_62[1];
        local_62[1] = (_e293 + _e291);
        let _e297 = local_62[0];
        local_63 = u32(_e297);
        let _e301 = local_62[1];
        local_64 = u32(_e301);
        let _e304 = local_64;
        out_1[_e304] = _e281;
        let _e306 = effect;
        let _e307 = advance(_e306);
        let _e308 = out;
        local_20 = _e308;
        let _e310 = base;
        local_21 = u32((_e310 + 8u));
        let _e315 = local_20;
        local_65 = _e315;
        let _e317 = local_21;
        let _e319 = local_65[1];
        local_65[1] = (_e319 + _e317);
        let _e323 = local_65[0];
        local_66 = u32(_e323);
        let _e327 = local_65[1];
        local_67 = u32(_e327);
        let _e330 = local_67;
        out_1[_e330] = _e307;
        let _e332 = effect;
        let _e336 = plus_one(u32((_e332 + 16i)));
        let _e337 = out;
        local_22 = _e337;
        let _e339 = base;
        local_23 = u32((_e339 + 9u));
        let _e345 = local_22;
        local_68 = _e345;
        let _e347 = local_23;
        let _e349 = local_68[1];
        local_68[1] = (_e349 + _e347);
        let _e353 = local_68[0];
        local_69 = u32(_e353);
        let _e357 = local_68[1];
        local_70 = u32(_e357);
        let _e360 = local_70;
        out_1[_e360] = i32(_e336);
        let _e362 = effect;
        let _e363 = input;
        local_26 = _e363;
        local_27 = u32(i);
        let _e367 = local_26;
        local_71 = _e367;
        let _e369 = local_27;
        let _e371 = local_71[1];
        local_71[1] = (_e371 + _e369);
        let _e375 = local_71[0];
        local_72 = u32(_e375);
        let _e379 = local_71[1];
        local_73 = u32(_e379);
        let _e382 = local_73;
        let _e384 = input_1[_e382];
        local_74 = _e384;
        let _e386 = local_74;
        local_32 = _e386;
        let _e388 = local_32;
        let _e389 = differs(_e362, _e388);
        let _e390 = out;
        local_24 = _e390;
        let _e392 = base;
        local_25 = u32((_e392 + 10u));
        let _e398 = local_24;
        local_75 = _e398;
        let _e400 = local_25;
        let _e402 = local_75[1];
        local_75[1] = (_e402 + _e400);
        let _e406 = local_75[0];
        local_76 = u32(_e406);
        let _e410 = local_75[1];
        local_77 = u32(_e410);
        let _e413 = local_77;
        out_1[_e413] = i32(_e389);
        let _e415 = effect;
        let _e416 = out;
        local_28 = _e416;
        let _e418 = base;
        local_29 = u32((_e418 + 11u));
        let _e423 = local_28;
        local_78 = _e423;
        let _e425 = local_29;
        let _e427 = local_78[1];
        local_78[1] = (_e427 + _e425);
        let _e431 = local_78[0];
        local_79 = u32(_e431);
        let _e435 = local_78[1];
        local_80 = u32(_e435);
        let _e438 = local_80;
        out_1[_e438] = _e415;
    }
}
