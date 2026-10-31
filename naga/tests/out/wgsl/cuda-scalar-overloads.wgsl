struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
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
    var base: u32;
    var value: i32;
    var local: u32;
    var choose: bool;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var effect: i32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var nested: i32;
    var local_12: u32;
    var argument: i32;
    var captured: i32;
    var local_13: u32;
    var local_14: i32;
    var local_15: u32;
    var local_16: i32;
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

    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 13u);
        local = u32(i);
        let _e16 = local;
        local_15 = u32(_e16);
        let _e19 = local_15;
        let _e22 = input[_e19];
        local_16 = _e22;
        let _e24 = local_16;
        local_14 = _e24;
        let _e26 = local_14;
        value = _e26;
        choose = ((i % 2u) == 0u);
        let _e33 = choose;
        let _e34 = classify(_e33);
        let _e35 = base;
        local_1 = u32(_e35);
        let _e39 = local_1;
        local_17 = u32(_e39);
        let _e42 = local_17;
        out[_e42] = i32(_e34);
        let _e45 = value;
        let _e46 = classify_1(_e45);
        let _e47 = base;
        local_2 = u32((_e47 + 1u));
        let _e52 = local_2;
        local_18 = u32(_e52);
        let _e55 = local_18;
        out[_e55] = _e46;
        let _e57 = value;
        let _e61 = classify_2(u32((_e57 + 16i)));
        let _e62 = base;
        local_3 = u32((_e62 + 2u));
        let _e68 = local_3;
        local_19 = u32(_e68);
        let _e71 = local_19;
        out[_e71] = i32(_e61);
        let _e73 = value;
        let _e75 = classify_3(f32(_e73));
        let _e76 = base;
        local_4 = u32((_e76 + 3u));
        let _e82 = local_4;
        local_20 = u32(_e82);
        let _e85 = local_20;
        out[_e85] = i32(_e75);
        let _e87 = choose;
        let _e88 = value;
        let _e93 = rank(i32(_e87), (f32(_e88) + 0.5f));
        let _e94 = base;
        local_5 = u32((_e94 + 4u));
        let _e99 = local_5;
        local_21 = u32(_e99);
        let _e102 = local_21;
        out[_e102] = _e93;
        let _e104 = value;
        let _e108 = choose;
        let _e110 = rank_1((f32(_e104) + 0.5f), i32(_e108));
        let _e111 = base;
        local_6 = u32((_e111 + 5u));
        let _e116 = local_6;
        local_22 = u32(_e116);
        let _e119 = local_22;
        out[_e119] = _e110;
        let _e121 = value;
        let _e125 = value;
        let _e127 = promote(u32((_e121 + 16i)), f32(_e125));
        let _e128 = base;
        local_7 = u32((_e128 + 6u));
        let _e133 = local_7;
        local_23 = u32(_e133);
        let _e136 = local_23;
        out[_e136] = _e127;
        let _e138 = value;
        effect = _e138;
        let _e140 = choose;
        let _e141 = effect;
        effect = (_e141 + 1i);
        touch(_e140, _e141);
        let _e144 = effect;
        let _e145 = base;
        local_8 = u32((_e145 + 7u));
        let _e150 = local_8;
        local_24 = u32(_e150);
        let _e153 = local_24;
        out[_e153] = _e144;
        let _e155 = effect;
        let _e156 = touch_1(_e155);
        let _e157 = base;
        local_9 = u32((_e157 + 8u));
        let _e162 = local_9;
        local_25 = u32(_e162);
        let _e165 = local_25;
        out[_e165] = _e156;
        let _e167 = value;
        let _e171 = frozen((f32(_e167) + 0.75f));
        let _e172 = base;
        local_10 = u32((_e172 + 9u));
        let _e177 = local_10;
        local_26 = u32(_e177);
        let _e180 = local_26;
        out[_e180] = _e171;
        let _e182 = value;
        let _e186 = stage_1((f32(_e182) + 0.75f));
        let _e187 = base;
        local_11 = u32((_e187 + 10u));
        let _e192 = local_11;
        local_27 = u32(_e192);
        let _e195 = local_27;
        out[_e195] = _e186;
        let _e197 = effect;
        effect = (_e197 + 1i);
        let _e200 = classify_1(_e197);
        let _e201 = touch_1(_e200);
        nested = _e201;
        let _e203 = nested;
        let _e206 = effect;
        let _e208 = base;
        local_12 = u32((_e208 + 11u));
        let _e213 = local_12;
        local_28 = u32(_e213);
        let _e216 = local_28;
        out[_e216] = ((_e203 * 10i) + _e206);
        let _e218 = value;
        argument = (_e218 + 8i);
        let _e222 = argument;
        let _e223 = argument;
        argument = (_e223 + 1i);
        let _e227 = pair(f32(_e222), _e223);
        captured = _e227;
        let _e229 = captured;
        let _e232 = argument;
        let _e234 = base;
        local_13 = u32((_e234 + 12u));
        let _e239 = local_13;
        local_29 = u32(_e239);
        let _e242 = local_29;
        out[_e242] = ((_e229 * 100i) + _e232);
    }
}
