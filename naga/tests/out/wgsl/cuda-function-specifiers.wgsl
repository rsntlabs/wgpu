struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
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
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: i32;
    var local_16: i32;
    var local_17: i32;
    var local_18: u32;
    var local_19: i32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: i32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: i32;
    var local_34: u32;
    var local_35: u32;

    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 12u);
        local = i;
        let _e15 = local;
        local_18 = _e15;
        let _e17 = local_18;
        let _e20 = input[_e17];
        local_19 = _e20;
        let _e22 = local_19;
        local_15 = _e22;
        let _e24 = local_15;
        value = _e24;
        choose = ((i % 2u) == 0u);
        let _e31 = value;
        let _e32 = increment(_e31);
        let _e33 = base;
        local_1 = _e33;
        let _e35 = local_1;
        local_20 = _e35;
        let _e37 = local_20;
        out[_e37] = _e32;
        let _e40 = value;
        let _e41 = twice(_e40);
        let _e42 = base;
        local_2 = u32((_e42 + 1u));
        let _e47 = local_2;
        local_21 = _e47;
        let _e49 = local_21;
        out[_e49] = _e41;
        let _e51 = value;
        let _e52 = advance(_e51);
        let _e53 = base;
        local_3 = u32((_e53 + 2u));
        let _e58 = local_3;
        local_22 = _e58;
        let _e60 = local_22;
        out[_e60] = _e52;
        let _e62 = value;
        let _e63 = retreat(_e62);
        let _e64 = base;
        local_4 = u32((_e64 + 3u));
        let _e69 = local_4;
        local_23 = _e69;
        let _e71 = local_23;
        out[_e71] = _e63;
        let _e73 = value;
        let _e75 = scaled(f32(_e73));
        let _e76 = base;
        local_5 = u32((_e76 + 4u));
        let _e82 = local_5;
        local_24 = _e82;
        let _e84 = local_24;
        out[_e84] = i32(_e75);
        let _e86 = value;
        local_7 = i;
        let _e88 = local_7;
        local_25 = _e88;
        let _e90 = local_25;
        let _e92 = input[_e90];
        local_26 = _e92;
        let _e94 = local_26;
        local_16 = _e94;
        let _e96 = local_16;
        let _e97 = differs(_e86, _e96);
        let _e98 = base;
        local_6 = u32((_e98 + 5u));
        let _e104 = local_6;
        local_27 = _e104;
        let _e106 = local_27;
        out[_e106] = i32(_e97);
        let _e108 = value;
        effect = _e108;
        let _e110 = choose;
        let _e111 = effect;
        effect = (_e111 + 1i);
        consume(_e110, _e111);
        let _e114 = effect;
        let _e115 = base;
        local_8 = u32((_e115 + 6u));
        let _e120 = local_8;
        local_28 = _e120;
        let _e122 = local_28;
        out[_e122] = _e114;
        let _e124 = choose;
        let _e126 = effect;
        effect = (_e126 + 1i);
        forward(!(_e124), _e126);
        let _e129 = effect;
        let _e130 = base;
        local_9 = u32((_e130 + 7u));
        let _e135 = local_9;
        local_29 = _e135;
        let _e137 = local_29;
        out[_e137] = _e129;
        let _e139 = effect;
        let _e140 = advance(_e139);
        let _e141 = base;
        local_10 = u32((_e141 + 8u));
        let _e146 = local_10;
        local_30 = _e146;
        let _e148 = local_30;
        out[_e148] = _e140;
        let _e150 = effect;
        let _e154 = plus_one(u32((_e150 + 16i)));
        let _e155 = base;
        local_11 = u32((_e155 + 9u));
        let _e161 = local_11;
        local_31 = _e161;
        let _e163 = local_31;
        out[_e163] = i32(_e154);
        let _e165 = effect;
        local_13 = i;
        let _e167 = local_13;
        local_32 = _e167;
        let _e169 = local_32;
        let _e171 = input[_e169];
        local_33 = _e171;
        let _e173 = local_33;
        local_17 = _e173;
        let _e175 = local_17;
        let _e176 = differs(_e165, _e175);
        let _e177 = base;
        local_12 = u32((_e177 + 10u));
        let _e183 = local_12;
        local_34 = _e183;
        let _e185 = local_34;
        out[_e185] = i32(_e176);
        let _e187 = effect;
        let _e188 = base;
        local_14 = u32((_e188 + 11u));
        let _e193 = local_14;
        local_35 = _e193;
        let _e195 = local_35;
        out[_e195] = _e187;
    }
}
