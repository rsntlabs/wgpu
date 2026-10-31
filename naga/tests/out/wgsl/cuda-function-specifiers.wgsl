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
        local = u32(i);
        let _e16 = local;
        local_18 = u32(_e16);
        let _e19 = local_18;
        let _e22 = input[_e19];
        local_19 = _e22;
        let _e24 = local_19;
        local_15 = _e24;
        let _e26 = local_15;
        value = _e26;
        choose = ((i % 2u) == 0u);
        let _e33 = value;
        let _e34 = increment(_e33);
        let _e35 = base;
        local_1 = u32(_e35);
        let _e38 = local_1;
        local_20 = u32(_e38);
        let _e41 = local_20;
        out[_e41] = _e34;
        let _e44 = value;
        let _e45 = twice(_e44);
        let _e46 = base;
        local_2 = u32((_e46 + 1u));
        let _e51 = local_2;
        local_21 = u32(_e51);
        let _e54 = local_21;
        out[_e54] = _e45;
        let _e56 = value;
        let _e57 = advance(_e56);
        let _e58 = base;
        local_3 = u32((_e58 + 2u));
        let _e63 = local_3;
        local_22 = u32(_e63);
        let _e66 = local_22;
        out[_e66] = _e57;
        let _e68 = value;
        let _e69 = retreat(_e68);
        let _e70 = base;
        local_4 = u32((_e70 + 3u));
        let _e75 = local_4;
        local_23 = u32(_e75);
        let _e78 = local_23;
        out[_e78] = _e69;
        let _e80 = value;
        let _e82 = scaled(f32(_e80));
        let _e83 = base;
        local_5 = u32((_e83 + 4u));
        let _e89 = local_5;
        local_24 = u32(_e89);
        let _e92 = local_24;
        out[_e92] = i32(_e82);
        let _e94 = value;
        local_7 = u32(i);
        let _e97 = local_7;
        local_25 = u32(_e97);
        let _e100 = local_25;
        let _e102 = input[_e100];
        local_26 = _e102;
        let _e104 = local_26;
        local_16 = _e104;
        let _e106 = local_16;
        let _e107 = differs(_e94, _e106);
        let _e108 = base;
        local_6 = u32((_e108 + 5u));
        let _e114 = local_6;
        local_27 = u32(_e114);
        let _e117 = local_27;
        out[_e117] = i32(_e107);
        let _e119 = value;
        effect = _e119;
        let _e121 = choose;
        let _e122 = effect;
        effect = (_e122 + 1i);
        consume(_e121, _e122);
        let _e125 = effect;
        let _e126 = base;
        local_8 = u32((_e126 + 6u));
        let _e131 = local_8;
        local_28 = u32(_e131);
        let _e134 = local_28;
        out[_e134] = _e125;
        let _e136 = choose;
        let _e138 = effect;
        effect = (_e138 + 1i);
        forward(!(_e136), _e138);
        let _e141 = effect;
        let _e142 = base;
        local_9 = u32((_e142 + 7u));
        let _e147 = local_9;
        local_29 = u32(_e147);
        let _e150 = local_29;
        out[_e150] = _e141;
        let _e152 = effect;
        let _e153 = advance(_e152);
        let _e154 = base;
        local_10 = u32((_e154 + 8u));
        let _e159 = local_10;
        local_30 = u32(_e159);
        let _e162 = local_30;
        out[_e162] = _e153;
        let _e164 = effect;
        let _e168 = plus_one(u32((_e164 + 16i)));
        let _e169 = base;
        local_11 = u32((_e169 + 9u));
        let _e175 = local_11;
        local_31 = u32(_e175);
        let _e178 = local_31;
        out[_e178] = i32(_e168);
        let _e180 = effect;
        local_13 = u32(i);
        let _e183 = local_13;
        local_32 = u32(_e183);
        let _e186 = local_32;
        let _e188 = input[_e186];
        local_33 = _e188;
        let _e190 = local_33;
        local_17 = _e190;
        let _e192 = local_17;
        let _e193 = differs(_e180, _e192);
        let _e194 = base;
        local_12 = u32((_e194 + 10u));
        let _e200 = local_12;
        local_34 = u32(_e200);
        let _e203 = local_34;
        out[_e203] = i32(_e193);
        let _e205 = effect;
        let _e206 = base;
        local_14 = u32((_e206 + 11u));
        let _e211 = local_14;
        local_35 = u32(_e211);
        let _e214 = local_35;
        out[_e214] = _e205;
    }
}
