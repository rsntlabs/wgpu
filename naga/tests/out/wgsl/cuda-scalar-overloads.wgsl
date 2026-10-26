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
    var local: u32;
    var local_1: u32;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var choose: bool;
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
    var effect: i32;
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
    var nested: i32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var argument: i32;
    var captured: i32;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: i32;
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

    local = 0u;
    local_1 = 0u;
    let _e8 = n_1.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e16 = i;
    let _e17 = n;
    if (_e16 < _e17) {
        let _e19 = i;
        base = (_e19 * 13u);
        let _e23 = local_1;
        local_2 = _e23;
        let _e25 = local_2;
        local_3 = u32(_e25);
        let _e28 = i;
        local_4 = u32(_e28);
        let _e32 = local_3;
        let _e33 = local_4;
        local_44 = u32((_e32 + _e33));
        let _e38 = local_44;
        let _e40 = input[_e38];
        local_45 = _e40;
        let _e41 = local_45;
        value = _e41;
        let _e43 = i;
        choose = ((_e43 % 2u) == 0u);
        let _e49 = choose;
        let _e50 = classify(_e49);
        let _e51 = local;
        local_5 = _e51;
        let _e53 = local_5;
        local_6 = u32(_e53);
        let _e56 = base;
        local_7 = u32(_e56);
        let _e61 = local_6;
        let _e62 = local_7;
        local_46 = u32((_e61 + _e62));
        let _e66 = local_46;
        out[_e66] = i32(_e50);
        let _e68 = value;
        let _e69 = classify_1(_e68);
        let _e70 = local;
        local_8 = _e70;
        let _e72 = local_8;
        local_9 = u32(_e72);
        let _e75 = base;
        local_10 = u32((_e75 + 1u));
        let _e80 = local_9;
        let _e81 = local_10;
        local_47 = u32((_e80 + _e81));
        let _e85 = local_47;
        out[_e85] = _e69;
        let _e87 = value;
        let _e91 = classify_2(u32((_e87 + 16i)));
        let _e92 = local;
        local_11 = _e92;
        let _e94 = local_11;
        local_12 = u32(_e94);
        let _e97 = base;
        local_13 = u32((_e97 + 2u));
        let _e103 = local_12;
        let _e104 = local_13;
        local_48 = u32((_e103 + _e104));
        let _e108 = local_48;
        out[_e108] = i32(_e91);
        let _e110 = value;
        let _e112 = classify_3(f32(_e110));
        let _e113 = local;
        local_14 = _e113;
        let _e115 = local_14;
        local_15 = u32(_e115);
        let _e118 = base;
        local_16 = u32((_e118 + 3u));
        let _e124 = local_15;
        let _e125 = local_16;
        local_49 = u32((_e124 + _e125));
        let _e129 = local_49;
        out[_e129] = i32(_e112);
        let _e131 = choose;
        let _e132 = value;
        let _e137 = rank(i32(_e131), (f32(_e132) + 0.5f));
        let _e138 = local;
        local_17 = _e138;
        let _e140 = local_17;
        local_18 = u32(_e140);
        let _e143 = base;
        local_19 = u32((_e143 + 4u));
        let _e148 = local_18;
        let _e149 = local_19;
        local_50 = u32((_e148 + _e149));
        let _e153 = local_50;
        out[_e153] = _e137;
        let _e155 = value;
        let _e159 = choose;
        let _e161 = rank_1((f32(_e155) + 0.5f), i32(_e159));
        let _e162 = local;
        local_20 = _e162;
        let _e164 = local_20;
        local_21 = u32(_e164);
        let _e167 = base;
        local_22 = u32((_e167 + 5u));
        let _e172 = local_21;
        let _e173 = local_22;
        local_51 = u32((_e172 + _e173));
        let _e177 = local_51;
        out[_e177] = _e161;
        let _e179 = value;
        let _e183 = value;
        let _e185 = promote(u32((_e179 + 16i)), f32(_e183));
        let _e186 = local;
        local_23 = _e186;
        let _e188 = local_23;
        local_24 = u32(_e188);
        let _e191 = base;
        local_25 = u32((_e191 + 6u));
        let _e196 = local_24;
        let _e197 = local_25;
        local_52 = u32((_e196 + _e197));
        let _e201 = local_52;
        out[_e201] = _e185;
        let _e203 = value;
        effect = _e203;
        let _e205 = choose;
        let _e206 = effect;
        effect = (_e206 + 1i);
        touch(_e205, _e206);
        let _e209 = effect;
        let _e210 = local;
        local_26 = _e210;
        let _e212 = local_26;
        local_27 = u32(_e212);
        let _e215 = base;
        local_28 = u32((_e215 + 7u));
        let _e220 = local_27;
        let _e221 = local_28;
        local_53 = u32((_e220 + _e221));
        let _e225 = local_53;
        out[_e225] = _e209;
        let _e227 = effect;
        let _e228 = touch_1(_e227);
        let _e229 = local;
        local_29 = _e229;
        let _e231 = local_29;
        local_30 = u32(_e231);
        let _e234 = base;
        local_31 = u32((_e234 + 8u));
        let _e239 = local_30;
        let _e240 = local_31;
        local_54 = u32((_e239 + _e240));
        let _e244 = local_54;
        out[_e244] = _e228;
        let _e246 = value;
        let _e250 = frozen((f32(_e246) + 0.75f));
        let _e251 = local;
        local_32 = _e251;
        let _e253 = local_32;
        local_33 = u32(_e253);
        let _e256 = base;
        local_34 = u32((_e256 + 9u));
        let _e261 = local_33;
        let _e262 = local_34;
        local_55 = u32((_e261 + _e262));
        let _e266 = local_55;
        out[_e266] = _e250;
        let _e268 = value;
        let _e272 = stage_1((f32(_e268) + 0.75f));
        let _e273 = local;
        local_35 = _e273;
        let _e275 = local_35;
        local_36 = u32(_e275);
        let _e278 = base;
        local_37 = u32((_e278 + 10u));
        let _e283 = local_36;
        let _e284 = local_37;
        local_56 = u32((_e283 + _e284));
        let _e288 = local_56;
        out[_e288] = _e272;
        let _e290 = effect;
        effect = (_e290 + 1i);
        let _e293 = classify_1(_e290);
        let _e294 = touch_1(_e293);
        nested = _e294;
        let _e296 = nested;
        let _e299 = effect;
        let _e301 = local;
        local_38 = _e301;
        let _e303 = local_38;
        local_39 = u32(_e303);
        let _e306 = base;
        local_40 = u32((_e306 + 11u));
        let _e311 = local_39;
        let _e312 = local_40;
        local_57 = u32((_e311 + _e312));
        let _e316 = local_57;
        out[_e316] = ((_e296 * 10i) + _e299);
        let _e318 = value;
        argument = (_e318 + 8i);
        let _e322 = argument;
        let _e323 = argument;
        argument = (_e323 + 1i);
        let _e327 = pair(f32(_e322), _e323);
        captured = _e327;
        let _e329 = captured;
        let _e332 = argument;
        let _e334 = local;
        local_41 = _e334;
        let _e336 = local_41;
        local_42 = u32(_e336);
        let _e339 = base;
        local_43 = u32((_e339 + 12u));
        let _e344 = local_42;
        let _e345 = local_43;
        local_58 = u32((_e344 + _e345));
        let _e349 = local_58;
        out[_e349] = ((_e329 * 100i) + _e332);
    }
}
