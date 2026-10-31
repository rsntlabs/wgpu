struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
@group(0) @binding(2)
var<uniform> n_1: type_5;

fn classify(value_1: bool) -> bool {
    var value_2: bool;

    value_2 = value_1;
    let _e2 = value_2;
    return !(_e2);
}

fn classify_1(value_3: i32) -> i32 {
    var value_4: i32;

    value_4 = value_3;
    let _e3 = value_4;
    return (_e3 + 10i);
}

fn classify_2(value_5: u32) -> u32 {
    var value_6: u32;

    value_6 = value_5;
    let _e3 = value_6;
    return (_e3 + 20u);
}

fn classify_3(value_7: f32) -> f32 {
    var value_8: f32;

    value_8 = value_7;
    let _e3 = value_8;
    return ((_e3 * 1.5f) + 0.5f);
}

fn rank(left: i32, right: f32) -> i32 {
    var left_1: i32;
    var right_1: f32;

    left_1 = left;
    right_1 = right;
    let _e5 = left_1;
    let _e7 = right_1;
    return ((_e5 * 10i) + i32(_e7));
}

fn rank_1(left_2: f32, right_2: i32) -> i32 {
    var left_3: f32;
    var right_3: i32;

    left_3 = left_2;
    right_3 = right_2;
    let _e5 = left_3;
    let _e10 = right_3;
    return ((100i + (i32(_e5) * 10i)) + _e10);
}

fn pair(left_4: f32, right_4: i32) -> i32 {
    var left_5: f32;
    var right_5: i32;

    left_5 = left_4;
    right_5 = right_4;
    let _e4 = left_5;
    let _e8 = right_5;
    return ((i32(_e4) * 10i) + _e8);
}

fn promote(left_6: u32, right_6: f32) -> i32 {
    var left_7: u32;
    var right_7: f32;

    left_7 = left_6;
    right_7 = right_6;
    let _e5 = left_7;
    let _e8 = right_7;
    return ((200i + i32(_e5)) + i32(_e8));
}

fn touch(stop: bool, value_9: i32) {
    var stop_1: bool;
    var value_10: i32;

    stop_1 = stop;
    value_10 = value_9;
    let _e4 = stop_1;
    if _e4 {
        return;
    }
    let _e5 = value_10;
    let _e6 = classify_1(_e5);
    value_10 = _e6;
    return;
}

fn touch_1(value_11: i32) -> i32 {
    var value_12: i32;

    value_12 = value_11;
    let _e2 = value_12;
    let _e3 = classify_1(_e2);
    return (_e3 + 3i);
}

fn stage(value_13: i32) -> i32 {
    var value_14: i32;

    value_14 = value_13;
    let _e3 = value_14;
    return (_e3 + 2i);
}

fn frozen(value_15: f32) -> i32 {
    var value_16: f32;

    value_16 = value_15;
    let _e2 = value_16;
    let _e4 = stage(i32(_e2));
    return _e4;
}

fn stage_1(value_17: f32) -> i32 {
    var value_18: f32;

    value_18 = value_17;
    let _e2 = value_18;
    return (i32(_e2) + 100i);
}

@compute @workgroup_size(64, 1, 1)
fn scalar_overloads(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var choose: bool;
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
    var local_16: array<u32, 2>;
    var local_17: u32;
    var effect: i32;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var local_20: array<u32, 2>;
    var local_21: u32;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var nested: i32;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var argument: i32;
    var captured: i32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var local_30: i32;
    var local_31: array<u32, 2>;
    var local_32: u32;
    var local_33: u32;
    var local_34: i32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var local_37: u32;
    var local_38: array<u32, 2>;
    var local_39: u32;
    var local_40: u32;
    var local_41: array<u32, 2>;
    var local_42: u32;
    var local_43: u32;
    var local_44: array<u32, 2>;
    var local_45: u32;
    var local_46: u32;
    var local_47: array<u32, 2>;
    var local_48: u32;
    var local_49: u32;
    var local_50: array<u32, 2>;
    var local_51: u32;
    var local_52: u32;
    var local_53: array<u32, 2>;
    var local_54: u32;
    var local_55: u32;
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

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = array<u32, 2>();
    local_1[0] = 1u;
    local_1[1] = 0u;
    let _e18 = n_1.value;
    n = _e18;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e26 = i;
    let _e27 = n;
    if (_e26 < _e27) {
        let _e29 = i;
        base = (_e29 * 13u);
        let _e35 = local_1;
        local_2 = _e35;
        let _e36 = i;
        local_3 = u32(_e36);
        let _e40 = local_2;
        local_31 = _e40;
        let _e41 = local_3;
        let _e43 = local_31[1];
        local_31[1] = (_e43 + _e41);
        let _e47 = local_31[0];
        local_32 = u32(_e47);
        let _e51 = local_31[1];
        local_33 = u32(_e51);
        let _e55 = local_33;
        let _e57 = input[_e55];
        local_34 = _e57;
        let _e58 = local_34;
        local_30 = _e58;
        let _e60 = local_30;
        value = _e60;
        let _e62 = i;
        choose = ((_e62 % 2u) == 0u);
        let _e68 = choose;
        let _e69 = classify(_e68);
        let _e72 = local;
        local_4 = _e72;
        let _e73 = base;
        local_5 = u32(_e73);
        let _e78 = local_4;
        local_35 = _e78;
        let _e79 = local_5;
        let _e81 = local_35[1];
        local_35[1] = (_e81 + _e79);
        let _e85 = local_35[0];
        local_36 = u32(_e85);
        let _e89 = local_35[1];
        local_37 = u32(_e89);
        let _e92 = local_37;
        out[_e92] = i32(_e69);
        let _e94 = value;
        let _e95 = classify_1(_e94);
        let _e97 = local;
        local_6 = _e97;
        let _e98 = base;
        local_7 = u32((_e98 + 1u));
        let _e104 = local_6;
        local_38 = _e104;
        let _e105 = local_7;
        let _e107 = local_38[1];
        local_38[1] = (_e107 + _e105);
        let _e111 = local_38[0];
        local_39 = u32(_e111);
        let _e115 = local_38[1];
        local_40 = u32(_e115);
        let _e118 = local_40;
        out[_e118] = _e95;
        let _e120 = value;
        let _e124 = classify_2(u32((_e120 + 16i)));
        let _e126 = local;
        local_8 = _e126;
        let _e127 = base;
        local_9 = u32((_e127 + 2u));
        let _e134 = local_8;
        local_41 = _e134;
        let _e135 = local_9;
        let _e137 = local_41[1];
        local_41[1] = (_e137 + _e135);
        let _e141 = local_41[0];
        local_42 = u32(_e141);
        let _e145 = local_41[1];
        local_43 = u32(_e145);
        let _e148 = local_43;
        out[_e148] = i32(_e124);
        let _e150 = value;
        let _e152 = classify_3(f32(_e150));
        let _e154 = local;
        local_10 = _e154;
        let _e155 = base;
        local_11 = u32((_e155 + 3u));
        let _e162 = local_10;
        local_44 = _e162;
        let _e163 = local_11;
        let _e165 = local_44[1];
        local_44[1] = (_e165 + _e163);
        let _e169 = local_44[0];
        local_45 = u32(_e169);
        let _e173 = local_44[1];
        local_46 = u32(_e173);
        let _e176 = local_46;
        out[_e176] = i32(_e152);
        let _e178 = choose;
        let _e179 = value;
        let _e184 = rank(i32(_e178), (f32(_e179) + 0.5f));
        let _e186 = local;
        local_12 = _e186;
        let _e187 = base;
        local_13 = u32((_e187 + 4u));
        let _e193 = local_12;
        local_47 = _e193;
        let _e194 = local_13;
        let _e196 = local_47[1];
        local_47[1] = (_e196 + _e194);
        let _e200 = local_47[0];
        local_48 = u32(_e200);
        let _e204 = local_47[1];
        local_49 = u32(_e204);
        let _e207 = local_49;
        out[_e207] = _e184;
        let _e209 = value;
        let _e213 = choose;
        let _e215 = rank_1((f32(_e209) + 0.5f), i32(_e213));
        let _e217 = local;
        local_14 = _e217;
        let _e218 = base;
        local_15 = u32((_e218 + 5u));
        let _e224 = local_14;
        local_50 = _e224;
        let _e225 = local_15;
        let _e227 = local_50[1];
        local_50[1] = (_e227 + _e225);
        let _e231 = local_50[0];
        local_51 = u32(_e231);
        let _e235 = local_50[1];
        local_52 = u32(_e235);
        let _e238 = local_52;
        out[_e238] = _e215;
        let _e240 = value;
        let _e244 = value;
        let _e246 = promote(u32((_e240 + 16i)), f32(_e244));
        let _e248 = local;
        local_16 = _e248;
        let _e249 = base;
        local_17 = u32((_e249 + 6u));
        let _e255 = local_16;
        local_53 = _e255;
        let _e256 = local_17;
        let _e258 = local_53[1];
        local_53[1] = (_e258 + _e256);
        let _e262 = local_53[0];
        local_54 = u32(_e262);
        let _e266 = local_53[1];
        local_55 = u32(_e266);
        let _e269 = local_55;
        out[_e269] = _e246;
        let _e271 = value;
        effect = _e271;
        let _e273 = choose;
        let _e274 = effect;
        effect = (_e274 + 1i);
        touch(_e273, _e274);
        let _e277 = effect;
        let _e279 = local;
        local_18 = _e279;
        let _e280 = base;
        local_19 = u32((_e280 + 7u));
        let _e286 = local_18;
        local_56 = _e286;
        let _e287 = local_19;
        let _e289 = local_56[1];
        local_56[1] = (_e289 + _e287);
        let _e293 = local_56[0];
        local_57 = u32(_e293);
        let _e297 = local_56[1];
        local_58 = u32(_e297);
        let _e300 = local_58;
        out[_e300] = _e277;
        let _e302 = effect;
        let _e303 = touch_1(_e302);
        let _e305 = local;
        local_20 = _e305;
        let _e306 = base;
        local_21 = u32((_e306 + 8u));
        let _e312 = local_20;
        local_59 = _e312;
        let _e313 = local_21;
        let _e315 = local_59[1];
        local_59[1] = (_e315 + _e313);
        let _e319 = local_59[0];
        local_60 = u32(_e319);
        let _e323 = local_59[1];
        local_61 = u32(_e323);
        let _e326 = local_61;
        out[_e326] = _e303;
        let _e328 = value;
        let _e332 = frozen((f32(_e328) + 0.75f));
        let _e334 = local;
        local_22 = _e334;
        let _e335 = base;
        local_23 = u32((_e335 + 9u));
        let _e341 = local_22;
        local_62 = _e341;
        let _e342 = local_23;
        let _e344 = local_62[1];
        local_62[1] = (_e344 + _e342);
        let _e348 = local_62[0];
        local_63 = u32(_e348);
        let _e352 = local_62[1];
        local_64 = u32(_e352);
        let _e355 = local_64;
        out[_e355] = _e332;
        let _e357 = value;
        let _e361 = stage_1((f32(_e357) + 0.75f));
        let _e363 = local;
        local_24 = _e363;
        let _e364 = base;
        local_25 = u32((_e364 + 10u));
        let _e370 = local_24;
        local_65 = _e370;
        let _e371 = local_25;
        let _e373 = local_65[1];
        local_65[1] = (_e373 + _e371);
        let _e377 = local_65[0];
        local_66 = u32(_e377);
        let _e381 = local_65[1];
        local_67 = u32(_e381);
        let _e384 = local_67;
        out[_e384] = _e361;
        let _e386 = effect;
        effect = (_e386 + 1i);
        let _e389 = classify_1(_e386);
        let _e390 = touch_1(_e389);
        nested = _e390;
        let _e392 = nested;
        let _e395 = effect;
        let _e398 = local;
        local_26 = _e398;
        let _e399 = base;
        local_27 = u32((_e399 + 11u));
        let _e405 = local_26;
        local_68 = _e405;
        let _e406 = local_27;
        let _e408 = local_68[1];
        local_68[1] = (_e408 + _e406);
        let _e412 = local_68[0];
        local_69 = u32(_e412);
        let _e416 = local_68[1];
        local_70 = u32(_e416);
        let _e419 = local_70;
        out[_e419] = ((_e392 * 10i) + _e395);
        let _e421 = value;
        argument = (_e421 + 8i);
        let _e425 = argument;
        let _e426 = argument;
        argument = (_e426 + 1i);
        let _e430 = pair(f32(_e425), _e426);
        captured = _e430;
        let _e432 = captured;
        let _e435 = argument;
        let _e438 = local;
        local_28 = _e438;
        let _e439 = base;
        local_29 = u32((_e439 + 12u));
        let _e445 = local_28;
        local_71 = _e445;
        let _e446 = local_29;
        let _e448 = local_71[1];
        local_71[1] = (_e448 + _e446);
        let _e452 = local_71[0];
        local_72 = u32(_e452);
        let _e456 = local_71[1];
        local_73 = u32(_e456);
        let _e459 = local_73;
        out[_e459] = ((_e432 * 100i) + _e435);
    }
}
