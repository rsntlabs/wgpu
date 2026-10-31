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
        local = i;
        let _e15 = local;
        local_15 = _e15;
        let _e17 = local_15;
        let _e20 = input[_e17];
        local_16 = _e20;
        let _e22 = local_16;
        local_14 = _e22;
        let _e24 = local_14;
        value = _e24;
        choose = ((i % 2u) == 0u);
        let _e31 = choose;
        let _e32 = classify(_e31);
        let _e33 = base;
        local_1 = _e33;
        let _e36 = local_1;
        local_17 = _e36;
        let _e38 = local_17;
        out[_e38] = i32(_e32);
        let _e41 = value;
        let _e42 = classify_1(_e41);
        let _e43 = base;
        local_2 = u32((_e43 + 1u));
        let _e48 = local_2;
        local_18 = _e48;
        let _e50 = local_18;
        out[_e50] = _e42;
        let _e52 = value;
        let _e56 = classify_2(u32((_e52 + 16i)));
        let _e57 = base;
        local_3 = u32((_e57 + 2u));
        let _e63 = local_3;
        local_19 = _e63;
        let _e65 = local_19;
        out[_e65] = i32(_e56);
        let _e67 = value;
        let _e69 = classify_3(f32(_e67));
        let _e70 = base;
        local_4 = u32((_e70 + 3u));
        let _e76 = local_4;
        local_20 = _e76;
        let _e78 = local_20;
        out[_e78] = i32(_e69);
        let _e80 = choose;
        let _e81 = value;
        let _e86 = rank(i32(_e80), (f32(_e81) + 0.5f));
        let _e87 = base;
        local_5 = u32((_e87 + 4u));
        let _e92 = local_5;
        local_21 = _e92;
        let _e94 = local_21;
        out[_e94] = _e86;
        let _e96 = value;
        let _e100 = choose;
        let _e102 = rank_1((f32(_e96) + 0.5f), i32(_e100));
        let _e103 = base;
        local_6 = u32((_e103 + 5u));
        let _e108 = local_6;
        local_22 = _e108;
        let _e110 = local_22;
        out[_e110] = _e102;
        let _e112 = value;
        let _e116 = value;
        let _e118 = promote(u32((_e112 + 16i)), f32(_e116));
        let _e119 = base;
        local_7 = u32((_e119 + 6u));
        let _e124 = local_7;
        local_23 = _e124;
        let _e126 = local_23;
        out[_e126] = _e118;
        let _e128 = value;
        effect = _e128;
        let _e130 = choose;
        let _e131 = effect;
        effect = (_e131 + 1i);
        touch(_e130, _e131);
        let _e134 = effect;
        let _e135 = base;
        local_8 = u32((_e135 + 7u));
        let _e140 = local_8;
        local_24 = _e140;
        let _e142 = local_24;
        out[_e142] = _e134;
        let _e144 = effect;
        let _e145 = touch_1(_e144);
        let _e146 = base;
        local_9 = u32((_e146 + 8u));
        let _e151 = local_9;
        local_25 = _e151;
        let _e153 = local_25;
        out[_e153] = _e145;
        let _e155 = value;
        let _e159 = frozen((f32(_e155) + 0.75f));
        let _e160 = base;
        local_10 = u32((_e160 + 9u));
        let _e165 = local_10;
        local_26 = _e165;
        let _e167 = local_26;
        out[_e167] = _e159;
        let _e169 = value;
        let _e173 = stage_1((f32(_e169) + 0.75f));
        let _e174 = base;
        local_11 = u32((_e174 + 10u));
        let _e179 = local_11;
        local_27 = _e179;
        let _e181 = local_27;
        out[_e181] = _e173;
        let _e183 = effect;
        effect = (_e183 + 1i);
        let _e186 = classify_1(_e183);
        let _e187 = touch_1(_e186);
        nested = _e187;
        let _e189 = nested;
        let _e192 = effect;
        let _e194 = base;
        local_12 = u32((_e194 + 11u));
        let _e199 = local_12;
        local_28 = _e199;
        let _e201 = local_28;
        out[_e201] = ((_e189 * 10i) + _e192);
        let _e203 = value;
        argument = (_e203 + 8i);
        let _e207 = argument;
        let _e208 = argument;
        argument = (_e208 + 1i);
        let _e212 = pair(f32(_e207), _e208);
        captured = _e212;
        let _e214 = captured;
        let _e217 = argument;
        let _e219 = base;
        local_13 = u32((_e219 + 12u));
        let _e224 = local_13;
        local_29 = _e224;
        let _e226 = local_29;
        out[_e226] = ((_e214 * 100i) + _e217);
    }
}
