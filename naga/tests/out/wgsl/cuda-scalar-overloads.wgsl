struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
@group(0) @binding(1)
var<storage> input_1: array<i32>;
@group(0) @binding(2)
var<uniform> n: type_5;

fn classify(value_1: bool) -> bool {
    return !(value_1);
}

fn classify_1(value_2: i32) -> i32 {
    return (value_2 + 10i);
}

fn classify_2(value_3: u32) -> u32 {
    return (value_3 + 20u);
}

fn classify_3(value_4: f32) -> f32 {
    return ((value_4 * 1.5f) + 0.5f);
}

fn rank(left: i32, right: f32) -> i32 {
    return ((left * 10i) + i32(right));
}

fn rank_1(left_1: f32, right_1: i32) -> i32 {
    return ((100i + (i32(left_1) * 10i)) + right_1);
}

fn pair(left_2: f32, right_2: i32) -> i32 {
    return ((i32(left_2) * 10i) + right_2);
}

fn promote(left_3: u32, right_3: f32) -> i32 {
    return ((200i + i32(left_3)) + i32(right_3));
}

fn touch(stop: bool, value_5: i32) {
    var value_6: i32;

    value_6 = value_5;
    if stop {
        return;
    }
    let _e3 = value_6;
    let _e4 = classify_1(_e3);
    value_6 = _e4;
    return;
}

fn touch_1(value_7: i32) -> i32 {
    let _e1 = classify_1(value_7);
    return (_e1 + 3i);
}

fn stage(value_8: i32) -> i32 {
    return (value_8 + 2i);
}

fn frozen(value_9: f32) -> i32 {
    let _e2 = stage(i32(value_9));
    return _e2;
}

fn stage_1(value_10: f32) -> i32 {
    return (i32(value_10) + 100i);
}

@compute @workgroup_size(64, 1, 1)
fn scalar_overloads(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
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
    var nested: i32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var argument: i32;
    var captured: i32;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var local_28: i32;
    var local_29: array<u32, 2>;
    var local_30: u32;
    var local_31: u32;
    var local_32: i32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var local_35: u32;
    var local_36: array<u32, 2>;
    var local_37: u32;
    var local_38: u32;
    var local_39: array<u32, 2>;
    var local_40: u32;
    var local_41: u32;
    var local_42: array<u32, 2>;
    var local_43: u32;
    var local_44: u32;
    var local_45: array<u32, 2>;
    var local_46: u32;
    var local_47: u32;
    var local_48: array<u32, 2>;
    var local_49: u32;
    var local_50: u32;
    var local_51: array<u32, 2>;
    var local_52: u32;
    var local_53: u32;
    var local_54: array<u32, 2>;
    var local_55: u32;
    var local_56: u32;
    var local_57: array<u32, 2>;
    var local_58: u32;
    var local_59: u32;
    var local_60: array<u32, 2>;
    var local_61: u32;
    var local_62: u32;
    var local_63: array<u32, 2>;
    var local_64: u32;
    var local_65: u32;
    var local_66: array<u32, 2>;
    var local_67: u32;
    var local_68: u32;
    var local_69: array<u32, 2>;
    var local_70: u32;
    var local_71: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    input = array<u32, 2>();
    input[0] = 1u;
    input[1] = 0u;
    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 13u);
        let _e27 = input;
        local = _e27;
        local_1 = u32(i);
        let _e31 = local;
        local_29 = _e31;
        let _e33 = local_1;
        let _e35 = local_29[1];
        local_29[1] = (_e35 + _e33);
        let _e39 = local_29[0];
        local_30 = u32(_e39);
        let _e43 = local_29[1];
        local_31 = u32(_e43);
        let _e46 = local_31;
        let _e49 = input_1[_e46];
        local_32 = _e49;
        let _e51 = local_32;
        local_28 = _e51;
        let _e53 = local_28;
        value = _e53;
        choose = ((i % 2u) == 0u);
        let _e60 = choose;
        let _e61 = classify(_e60);
        let _e63 = out;
        local_2 = _e63;
        let _e65 = base;
        local_3 = u32(_e65);
        let _e69 = local_2;
        local_33 = _e69;
        let _e71 = local_3;
        let _e73 = local_33[1];
        local_33[1] = (_e73 + _e71);
        let _e77 = local_33[0];
        local_34 = u32(_e77);
        let _e81 = local_33[1];
        local_35 = u32(_e81);
        let _e84 = local_35;
        out_1[_e84] = i32(_e61);
        let _e87 = value;
        let _e88 = classify_1(_e87);
        let _e89 = out;
        local_4 = _e89;
        let _e91 = base;
        local_5 = u32((_e91 + 1u));
        let _e96 = local_4;
        local_36 = _e96;
        let _e98 = local_5;
        let _e100 = local_36[1];
        local_36[1] = (_e100 + _e98);
        let _e104 = local_36[0];
        local_37 = u32(_e104);
        let _e108 = local_36[1];
        local_38 = u32(_e108);
        let _e111 = local_38;
        out_1[_e111] = _e88;
        let _e113 = value;
        let _e117 = classify_2(u32((_e113 + 16i)));
        let _e118 = out;
        local_6 = _e118;
        let _e120 = base;
        local_7 = u32((_e120 + 2u));
        let _e126 = local_6;
        local_39 = _e126;
        let _e128 = local_7;
        let _e130 = local_39[1];
        local_39[1] = (_e130 + _e128);
        let _e134 = local_39[0];
        local_40 = u32(_e134);
        let _e138 = local_39[1];
        local_41 = u32(_e138);
        let _e141 = local_41;
        out_1[_e141] = i32(_e117);
        let _e143 = value;
        let _e145 = classify_3(f32(_e143));
        let _e146 = out;
        local_8 = _e146;
        let _e148 = base;
        local_9 = u32((_e148 + 3u));
        let _e154 = local_8;
        local_42 = _e154;
        let _e156 = local_9;
        let _e158 = local_42[1];
        local_42[1] = (_e158 + _e156);
        let _e162 = local_42[0];
        local_43 = u32(_e162);
        let _e166 = local_42[1];
        local_44 = u32(_e166);
        let _e169 = local_44;
        out_1[_e169] = i32(_e145);
        let _e171 = choose;
        let _e172 = value;
        let _e177 = rank(i32(_e171), (f32(_e172) + 0.5f));
        let _e178 = out;
        local_10 = _e178;
        let _e180 = base;
        local_11 = u32((_e180 + 4u));
        let _e185 = local_10;
        local_45 = _e185;
        let _e187 = local_11;
        let _e189 = local_45[1];
        local_45[1] = (_e189 + _e187);
        let _e193 = local_45[0];
        local_46 = u32(_e193);
        let _e197 = local_45[1];
        local_47 = u32(_e197);
        let _e200 = local_47;
        out_1[_e200] = _e177;
        let _e202 = value;
        let _e206 = choose;
        let _e208 = rank_1((f32(_e202) + 0.5f), i32(_e206));
        let _e209 = out;
        local_12 = _e209;
        let _e211 = base;
        local_13 = u32((_e211 + 5u));
        let _e216 = local_12;
        local_48 = _e216;
        let _e218 = local_13;
        let _e220 = local_48[1];
        local_48[1] = (_e220 + _e218);
        let _e224 = local_48[0];
        local_49 = u32(_e224);
        let _e228 = local_48[1];
        local_50 = u32(_e228);
        let _e231 = local_50;
        out_1[_e231] = _e208;
        let _e233 = value;
        let _e237 = value;
        let _e239 = promote(u32((_e233 + 16i)), f32(_e237));
        let _e240 = out;
        local_14 = _e240;
        let _e242 = base;
        local_15 = u32((_e242 + 6u));
        let _e247 = local_14;
        local_51 = _e247;
        let _e249 = local_15;
        let _e251 = local_51[1];
        local_51[1] = (_e251 + _e249);
        let _e255 = local_51[0];
        local_52 = u32(_e255);
        let _e259 = local_51[1];
        local_53 = u32(_e259);
        let _e262 = local_53;
        out_1[_e262] = _e239;
        let _e264 = value;
        effect = _e264;
        let _e266 = choose;
        let _e267 = effect;
        effect = (_e267 + 1i);
        touch(_e266, _e267);
        let _e270 = effect;
        let _e271 = out;
        local_16 = _e271;
        let _e273 = base;
        local_17 = u32((_e273 + 7u));
        let _e278 = local_16;
        local_54 = _e278;
        let _e280 = local_17;
        let _e282 = local_54[1];
        local_54[1] = (_e282 + _e280);
        let _e286 = local_54[0];
        local_55 = u32(_e286);
        let _e290 = local_54[1];
        local_56 = u32(_e290);
        let _e293 = local_56;
        out_1[_e293] = _e270;
        let _e295 = effect;
        let _e296 = touch_1(_e295);
        let _e297 = out;
        local_18 = _e297;
        let _e299 = base;
        local_19 = u32((_e299 + 8u));
        let _e304 = local_18;
        local_57 = _e304;
        let _e306 = local_19;
        let _e308 = local_57[1];
        local_57[1] = (_e308 + _e306);
        let _e312 = local_57[0];
        local_58 = u32(_e312);
        let _e316 = local_57[1];
        local_59 = u32(_e316);
        let _e319 = local_59;
        out_1[_e319] = _e296;
        let _e321 = value;
        let _e325 = frozen((f32(_e321) + 0.75f));
        let _e326 = out;
        local_20 = _e326;
        let _e328 = base;
        local_21 = u32((_e328 + 9u));
        let _e333 = local_20;
        local_60 = _e333;
        let _e335 = local_21;
        let _e337 = local_60[1];
        local_60[1] = (_e337 + _e335);
        let _e341 = local_60[0];
        local_61 = u32(_e341);
        let _e345 = local_60[1];
        local_62 = u32(_e345);
        let _e348 = local_62;
        out_1[_e348] = _e325;
        let _e350 = value;
        let _e354 = stage_1((f32(_e350) + 0.75f));
        let _e355 = out;
        local_22 = _e355;
        let _e357 = base;
        local_23 = u32((_e357 + 10u));
        let _e362 = local_22;
        local_63 = _e362;
        let _e364 = local_23;
        let _e366 = local_63[1];
        local_63[1] = (_e366 + _e364);
        let _e370 = local_63[0];
        local_64 = u32(_e370);
        let _e374 = local_63[1];
        local_65 = u32(_e374);
        let _e377 = local_65;
        out_1[_e377] = _e354;
        let _e379 = effect;
        effect = (_e379 + 1i);
        let _e382 = classify_1(_e379);
        let _e383 = touch_1(_e382);
        nested = _e383;
        let _e385 = nested;
        let _e388 = effect;
        let _e390 = out;
        local_24 = _e390;
        let _e392 = base;
        local_25 = u32((_e392 + 11u));
        let _e397 = local_24;
        local_66 = _e397;
        let _e399 = local_25;
        let _e401 = local_66[1];
        local_66[1] = (_e401 + _e399);
        let _e405 = local_66[0];
        local_67 = u32(_e405);
        let _e409 = local_66[1];
        local_68 = u32(_e409);
        let _e412 = local_68;
        out_1[_e412] = ((_e385 * 10i) + _e388);
        let _e414 = value;
        argument = (_e414 + 8i);
        let _e418 = argument;
        let _e419 = argument;
        argument = (_e419 + 1i);
        let _e423 = pair(f32(_e418), _e419);
        captured = _e423;
        let _e425 = captured;
        let _e428 = argument;
        let _e430 = out;
        local_26 = _e430;
        let _e432 = base;
        local_27 = u32((_e432 + 12u));
        let _e437 = local_26;
        local_69 = _e437;
        let _e439 = local_27;
        let _e441 = local_69[1];
        local_69[1] = (_e441 + _e439);
        let _e445 = local_69[0];
        local_70 = u32(_e445);
        let _e449 = local_69[1];
        local_71 = u32(_e449);
        let _e452 = local_71;
        out_1[_e452] = ((_e425 * 100i) + _e428);
    }
}
