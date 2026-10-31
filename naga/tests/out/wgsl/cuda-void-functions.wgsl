struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<uniform> n_1: type_5;

fn next_value(value_1: i32) -> i32 {
    var value_2: i32;

    value_2 = value_1;
    let _e3 = value_2;
    return (_e3 + 1i);
}

fn consume(stop: bool, value_3: i32, count: u32, scale: f32) {
    var stop_1: bool;
    var value_4: i32;
    var count_1: u32;
    var scale_1: f32;

    stop_1 = stop;
    value_4 = value_3;
    count_1 = count;
    scale_1 = scale;
    let _e8 = count_1;
    let _e9 = value_4;
    value_4 = i32((u32(_e9) + _e8));
    let _e13 = stop_1;
    if _e13 {
        return;
    }
    let _e14 = scale_1;
    let _e15 = value_4;
    value_4 = i32((f32(_e15) * _e14));
    return;
}

fn forward(stop_2: bool, value_5: i32) {
    var stop_3: bool;
    var value_6: i32;

    stop_3 = stop_2;
    value_6 = value_5;
    let _e4 = stop_3;
    let _e5 = value_6;
    let _e6 = next_value(_e5);
    consume(_e4, _e6, 2u, 0.5f);
    return;
}

@compute @workgroup_size(64, 1, 1)
fn void_functions(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: array<u32, 2>;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var local_1: array<u32, 2>;
    var local_2: u32;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var iterations: i32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: array<u32, 2>;
    var local_14: u32;
    var local_15: u32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var local_18: u32;
    var local_19: array<u32, 2>;
    var local_20: u32;
    var local_21: u32;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var local_24: u32;
    var local_25: array<u32, 2>;
    var local_26: u32;
    var local_27: u32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var local_30: u32;

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    let _e11 = n_1.value;
    n = _e11;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e19 = i;
    let _e20 = n;
    if (_e19 < _e20) {
        let _e22 = i;
        base = (_e22 * 6u);
        value = 2i;
        let _e28 = value;
        value = (_e28 + 1i);
        consume(false, _e28, 1u, 1.5f);
        let _e34 = value;
        let _e37 = local;
        local_1 = _e37;
        let _e38 = base;
        local_2 = u32(_e38);
        let _e42 = local_1;
        local_13 = _e42;
        let _e43 = local_2;
        let _e45 = local_13[1];
        local_13[1] = (_e45 + _e43);
        let _e49 = local_13[0];
        local_14 = u32(_e49);
        let _e53 = local_13[1];
        local_15 = u32(_e53);
        let _e56 = local_15;
        out[_e56] = _e34;
        let _e58 = value;
        value = (_e58 + 1i);
        let _e61 = next_value(_e58);
        consume(true, _e61, 2u, 0.5f);
        let _e65 = value;
        let _e67 = local;
        local_3 = _e67;
        let _e68 = base;
        local_4 = u32((_e68 + 1u));
        let _e74 = local_3;
        local_16 = _e74;
        let _e75 = local_4;
        let _e77 = local_16[1];
        local_16[1] = (_e77 + _e75);
        let _e81 = local_16[0];
        local_17 = u32(_e81);
        let _e85 = local_16[1];
        local_18 = u32(_e85);
        let _e88 = local_18;
        out[_e88] = _e65;
        let _e90 = i;
        let _e95 = value;
        value = (_e95 + 1i);
        forward(((_e90 % 2u) == 0u), _e95);
        let _e98 = value;
        let _e100 = local;
        local_5 = _e100;
        let _e101 = base;
        local_6 = u32((_e101 + 2u));
        let _e107 = local_5;
        local_19 = _e107;
        let _e108 = local_6;
        let _e110 = local_19[1];
        local_19[1] = (_e110 + _e108);
        let _e114 = local_19[0];
        local_20 = u32(_e114);
        let _e118 = local_19[1];
        local_21 = u32(_e118);
        let _e121 = local_21;
        out[_e121] = _e98;
        iterations = 0i;
        {
            let _e125 = value;
            value = (_e125 + 1i);
            consume((0i != 0i), _e125, u32(0i), f32(1u));
            loop {
                let _e135 = iterations;
                if (_e135 < 3i) {
                } else {
                    break;
                }
                let _e138 = iterations;
                iterations = (_e138 + 1i);
                let _e141 = iterations;
                if (_e141 == 1i) {
                    continue;
                }
                continuing {
                    let _e144 = value;
                    value = (_e144 + 1i);
                    let _e147 = value;
                    consume(false, _e147, 0u, 1f);
                }
            }
        }
        let _e151 = value;
        let _e153 = local;
        local_7 = _e153;
        let _e154 = base;
        local_8 = u32((_e154 + 3u));
        let _e160 = local_7;
        local_22 = _e160;
        let _e161 = local_8;
        let _e163 = local_22[1];
        local_22[1] = (_e163 + _e161);
        let _e167 = local_22[0];
        local_23 = u32(_e167);
        let _e171 = local_22[1];
        local_24 = u32(_e171);
        let _e174 = local_24;
        out[_e174] = _e151;
        let _e176 = iterations;
        let _e178 = local;
        local_9 = _e178;
        let _e179 = base;
        local_10 = u32((_e179 + 4u));
        let _e185 = local_9;
        local_25 = _e185;
        let _e186 = local_10;
        let _e188 = local_25[1];
        local_25[1] = (_e188 + _e186);
        let _e192 = local_25[0];
        local_26 = u32(_e192);
        let _e196 = local_25[1];
        local_27 = u32(_e196);
        let _e199 = local_27;
        out[_e199] = _e176;
        let _e201 = value;
        let _e202 = next_value(_e201);
        let _e204 = local;
        local_11 = _e204;
        let _e205 = base;
        local_12 = u32((_e205 + 5u));
        let _e211 = local_11;
        local_28 = _e211;
        let _e212 = local_12;
        let _e214 = local_28[1];
        local_28[1] = (_e214 + _e212);
        let _e218 = local_28[0];
        local_29 = u32(_e218);
        let _e222 = local_28[1];
        local_30 = u32(_e222);
        let _e225 = local_30;
        out[_e225] = _e202;
    }
}
