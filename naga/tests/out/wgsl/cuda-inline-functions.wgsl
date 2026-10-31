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

fn doubled(value_3: i32) -> i32 {
    let _e1 = increment(value_3);
    return (_e1 * 2i);
}

fn advance(value_4: u32) -> u32 {
    return (value_4 + 3u);
}

fn retreat(value_5: u32) -> u32 {
    return (value_5 - 1u);
}

fn scale(value_6: f32, bias: i32) -> f32 {
    return ((value_6 * 1.5f) + f32(bias));
}

fn same(left: i32, right: i32) -> bool {
    return (left == right);
}

fn consume(stop: bool, value_7: i32) {
    var value_8: i32;

    value_8 = value_7;
    if stop {
        return;
    }
    let _e3 = value_8;
    let _e4 = doubled(_e3);
    value_8 = _e4;
    return;
}

fn forward(stop_1: bool, value_9: i32) {
    let _e2 = increment(value_9);
    consume(stop_1, _e2);
    return;
}

@compute @workgroup_size(64, 1, 1)
fn inline_functions(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var base: u32;
    var value: i32;
    var local: u32;
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
    var local_26: u32;
    var local_27: i32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: i32;
    var local_33: u32;
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
        let _e26 = value;
        let _e27 = increment(_e26);
        let _e28 = base;
        local_1 = _e28;
        let _e30 = local_1;
        local_20 = _e30;
        let _e32 = local_20;
        out[_e32] = _e27;
        let _e35 = value;
        let _e36 = base;
        local_2 = u32((_e36 + 1u));
        let _e41 = local_2;
        local_21 = _e41;
        let _e43 = local_21;
        out[_e43] = _e35;
        let _e45 = value;
        let _e46 = doubled(_e45);
        let _e47 = base;
        local_3 = u32((_e47 + 2u));
        let _e52 = local_3;
        local_22 = _e52;
        let _e54 = local_22;
        out[_e54] = _e46;
        let _e56 = value;
        let _e58 = advance(u32(_e56));
        let _e59 = base;
        local_4 = u32((_e59 + 3u));
        let _e65 = local_4;
        local_23 = _e65;
        let _e67 = local_23;
        out[_e67] = i32(_e58);
        let _e69 = value;
        let _e71 = retreat(u32(_e69));
        let _e72 = base;
        local_5 = u32((_e72 + 4u));
        let _e78 = local_5;
        local_24 = _e78;
        let _e80 = local_24;
        out[_e80] = i32(_e71);
        let _e82 = value;
        let _e85 = scale(f32(_e82), 2i);
        let _e86 = base;
        local_6 = u32((_e86 + 5u));
        let _e92 = local_6;
        local_25 = _e92;
        let _e94 = local_25;
        out[_e94] = i32(_e85);
        let _e96 = value;
        local_8 = i;
        let _e98 = local_8;
        local_26 = _e98;
        let _e100 = local_26;
        let _e102 = input[_e100];
        local_27 = _e102;
        let _e104 = local_27;
        local_16 = _e104;
        let _e106 = local_16;
        let _e107 = same(_e96, _e106);
        let _e108 = base;
        local_7 = u32((_e108 + 6u));
        let _e114 = local_7;
        local_28 = _e114;
        let _e116 = local_28;
        out[_e116] = i32(_e107);
        let _e122 = value;
        value = (_e122 + 1i);
        consume(((i % 2u) == 0u), _e122);
        let _e125 = value;
        let _e126 = base;
        local_9 = u32((_e126 + 7u));
        let _e131 = local_9;
        local_29 = _e131;
        let _e133 = local_29;
        out[_e133] = _e125;
        let _e139 = value;
        value = (_e139 + 1i);
        forward(((i % 2u) != 0u), _e139);
        let _e142 = value;
        let _e143 = base;
        local_10 = u32((_e143 + 8u));
        let _e148 = local_10;
        local_30 = _e148;
        let _e150 = local_30;
        out[_e150] = _e142;
        let _e152 = value;
        local_12 = i;
        let _e154 = local_12;
        local_31 = _e154;
        let _e156 = local_31;
        let _e158 = input[_e156];
        local_32 = _e158;
        let _e160 = local_32;
        local_17 = _e160;
        let _e162 = local_17;
        let _e163 = same(_e152, _e162);
        let _e164 = base;
        local_11 = u32((_e164 + 9u));
        let _e170 = local_11;
        local_33 = _e170;
        let _e172 = local_33;
        out[_e172] = i32(_e163);
        let _e174 = value;
        let _e175 = increment(_e174);
        let _e176 = increment(_e175);
        let _e177 = base;
        local_13 = u32((_e177 + 10u));
        let _e182 = local_13;
        local_34 = _e182;
        let _e184 = local_34;
        out[_e184] = _e176;
        let _e186 = value;
        let _e187 = base;
        local_14 = u32((_e187 + 11u));
        let _e192 = local_14;
        local_35 = _e192;
        let _e194 = local_35;
        out[_e194] = _e186;
    }
}
