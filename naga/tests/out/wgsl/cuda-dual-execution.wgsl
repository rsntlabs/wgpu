struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
@group(0) @binding(2)
var<uniform> n: type_5;

fn step_(value_1: i32) -> i32 {
    var value_2: i32;

    value_2 = value_1;
    let _e3 = value_2;
    value_2 = (_e3 + 3i);
    let _e5 = value_2;
    return _e5;
}

fn doubled(value_3: i32) -> i32 {
    let _e1 = step_(value_3);
    return (_e1 * 2i);
}

fn advance(value_4: u32) -> u32 {
    return (value_4 + 5u);
}

fn retreat(value_5: u32) -> u32 {
    return (value_5 - 2u);
}

fn scale(value_6: f32, bias: i32) -> f32 {
    return ((value_6 * 2f) + f32(bias));
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
    let _e2 = step_(value_9);
    consume(stop_1, _e2);
    return;
}

fn device_only(value_10: i32) -> i32 {
    let _e1 = step_(value_10);
    return (_e1 + 1i);
}

@compute @workgroup_size(64, 1, 1)
fn dual_execution(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
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
        let _e28 = value;
        let _e29 = step_(_e28);
        let _e30 = base;
        local_1 = u32(_e30);
        let _e33 = local_1;
        local_20 = u32(_e33);
        let _e36 = local_20;
        out[_e36] = _e29;
        let _e39 = value;
        let _e40 = base;
        local_2 = u32((_e40 + 1u));
        let _e45 = local_2;
        local_21 = u32(_e45);
        let _e48 = local_21;
        out[_e48] = _e39;
        let _e50 = value;
        let _e51 = doubled(_e50);
        let _e52 = base;
        local_3 = u32((_e52 + 2u));
        let _e57 = local_3;
        local_22 = u32(_e57);
        let _e60 = local_22;
        out[_e60] = _e51;
        let _e62 = value;
        let _e64 = advance(u32(_e62));
        let _e65 = base;
        local_4 = u32((_e65 + 3u));
        let _e71 = local_4;
        local_23 = u32(_e71);
        let _e74 = local_23;
        out[_e74] = i32(_e64);
        let _e76 = value;
        let _e78 = retreat(u32(_e76));
        let _e79 = base;
        local_5 = u32((_e79 + 4u));
        let _e85 = local_5;
        local_24 = u32(_e85);
        let _e88 = local_24;
        out[_e88] = i32(_e78);
        let _e90 = value;
        let _e93 = scale(f32(_e90), 4i);
        let _e94 = base;
        local_6 = u32((_e94 + 5u));
        let _e100 = local_6;
        local_25 = u32(_e100);
        let _e103 = local_25;
        out[_e103] = i32(_e93);
        let _e105 = value;
        local_8 = u32(i);
        let _e108 = local_8;
        local_26 = u32(_e108);
        let _e111 = local_26;
        let _e113 = input[_e111];
        local_27 = _e113;
        let _e115 = local_27;
        local_16 = _e115;
        let _e117 = local_16;
        let _e118 = same(_e105, _e117);
        let _e119 = base;
        local_7 = u32((_e119 + 6u));
        let _e125 = local_7;
        local_28 = u32(_e125);
        let _e128 = local_28;
        out[_e128] = i32(_e118);
        let _e134 = value;
        value = (_e134 + 1i);
        consume(((i % 2u) == 0u), _e134);
        let _e137 = value;
        let _e138 = base;
        local_9 = u32((_e138 + 7u));
        let _e143 = local_9;
        local_29 = u32(_e143);
        let _e146 = local_29;
        out[_e146] = _e137;
        let _e152 = value;
        value = (_e152 + 1i);
        forward(((i % 2u) != 0u), _e152);
        let _e155 = value;
        let _e156 = base;
        local_10 = u32((_e156 + 8u));
        let _e161 = local_10;
        local_30 = u32(_e161);
        let _e164 = local_30;
        out[_e164] = _e155;
        let _e166 = value;
        local_12 = u32(i);
        let _e169 = local_12;
        local_31 = u32(_e169);
        let _e172 = local_31;
        let _e174 = input[_e172];
        local_32 = _e174;
        let _e176 = local_32;
        local_17 = _e176;
        let _e178 = local_17;
        let _e179 = same(_e166, _e178);
        let _e180 = base;
        local_11 = u32((_e180 + 9u));
        let _e186 = local_11;
        local_33 = u32(_e186);
        let _e189 = local_33;
        out[_e189] = i32(_e179);
        let _e191 = value;
        let _e192 = step_(_e191);
        let _e193 = device_only(_e192);
        let _e194 = base;
        local_13 = u32((_e194 + 10u));
        let _e199 = local_13;
        local_34 = u32(_e199);
        let _e202 = local_34;
        out[_e202] = _e193;
        let _e204 = value;
        let _e205 = base;
        local_14 = u32((_e205 + 11u));
        let _e210 = local_14;
        local_35 = u32(_e210);
        let _e213 = local_35;
        out[_e213] = _e204;
    }
}
