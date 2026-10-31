struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
@group(0) @binding(1)
var<uniform> n: type_5;

fn next_value(value_1: i32) -> i32 {
    return (value_1 + 1i);
}

fn consume(stop: bool, value_2: i32, count: u32, scale: f32) {
    var value_3: i32;

    value_3 = value_2;
    let _e5 = value_3;
    value_3 = i32((u32(_e5) + count));
    if stop {
        return;
    }
    let _e9 = value_3;
    value_3 = i32((f32(_e9) * scale));
    return;
}

fn forward(stop_1: bool, value_4: i32) {
    let _e2 = next_value(value_4);
    consume(stop_1, _e2, 2u, 0.5f);
    return;
}

@compute @workgroup_size(64, 1, 1)
fn void_functions(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var out: array<u32, 2>;
    var base: u32;
    var value: i32;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var iterations: i32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: u32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var local_17: u32;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var local_20: u32;
    var local_21: array<u32, 2>;
    var local_22: u32;
    var local_23: u32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: u32;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 6u);
        value = 2i;
        let _e22 = value;
        value = (_e22 + 1i);
        consume(false, _e22, 1u, 1.5f);
        let _e28 = value;
        let _e30 = out;
        local = _e30;
        let _e32 = base;
        local_1 = u32(_e32);
        let _e35 = local;
        local_12 = _e35;
        let _e37 = local_1;
        let _e39 = local_12[1];
        local_12[1] = (_e39 + _e37);
        let _e43 = local_12[0];
        local_13 = u32(_e43);
        let _e47 = local_12[1];
        local_14 = u32(_e47);
        let _e50 = local_14;
        out_1[_e50] = _e28;
        let _e53 = value;
        value = (_e53 + 1i);
        let _e56 = next_value(_e53);
        consume(true, _e56, 2u, 0.5f);
        let _e60 = value;
        let _e61 = out;
        local_2 = _e61;
        let _e63 = base;
        local_3 = u32((_e63 + 1u));
        let _e68 = local_2;
        local_15 = _e68;
        let _e70 = local_3;
        let _e72 = local_15[1];
        local_15[1] = (_e72 + _e70);
        let _e76 = local_15[0];
        local_16 = u32(_e76);
        let _e80 = local_15[1];
        local_17 = u32(_e80);
        let _e83 = local_17;
        out_1[_e83] = _e60;
        let _e89 = value;
        value = (_e89 + 1i);
        forward(((i % 2u) == 0u), _e89);
        let _e92 = value;
        let _e93 = out;
        local_4 = _e93;
        let _e95 = base;
        local_5 = u32((_e95 + 2u));
        let _e100 = local_4;
        local_18 = _e100;
        let _e102 = local_5;
        let _e104 = local_18[1];
        local_18[1] = (_e104 + _e102);
        let _e108 = local_18[0];
        local_19 = u32(_e108);
        let _e112 = local_18[1];
        local_20 = u32(_e112);
        let _e115 = local_20;
        out_1[_e115] = _e92;
        iterations = 0i;
        {
            let _e119 = value;
            value = (_e119 + 1i);
            consume((0i != 0i), _e119, u32(0i), f32(1u));
            loop {
                let _e129 = iterations;
                if (_e129 < 3i) {
                } else {
                    break;
                }
                let _e132 = iterations;
                iterations = (_e132 + 1i);
                let _e135 = iterations;
                if (_e135 == 1i) {
                    continue;
                }
                continuing {
                    let _e138 = value;
                    value = (_e138 + 1i);
                    let _e141 = value;
                    consume(false, _e141, 0u, 1f);
                }
            }
        }
        let _e145 = value;
        let _e146 = out;
        local_6 = _e146;
        let _e148 = base;
        local_7 = u32((_e148 + 3u));
        let _e153 = local_6;
        local_21 = _e153;
        let _e155 = local_7;
        let _e157 = local_21[1];
        local_21[1] = (_e157 + _e155);
        let _e161 = local_21[0];
        local_22 = u32(_e161);
        let _e165 = local_21[1];
        local_23 = u32(_e165);
        let _e168 = local_23;
        out_1[_e168] = _e145;
        let _e170 = iterations;
        let _e171 = out;
        local_8 = _e171;
        let _e173 = base;
        local_9 = u32((_e173 + 4u));
        let _e178 = local_8;
        local_24 = _e178;
        let _e180 = local_9;
        let _e182 = local_24[1];
        local_24[1] = (_e182 + _e180);
        let _e186 = local_24[0];
        local_25 = u32(_e186);
        let _e190 = local_24[1];
        local_26 = u32(_e190);
        let _e193 = local_26;
        out_1[_e193] = _e170;
        let _e195 = value;
        let _e196 = next_value(_e195);
        let _e197 = out;
        local_10 = _e197;
        let _e199 = base;
        local_11 = u32((_e199 + 5u));
        let _e204 = local_10;
        local_27 = _e204;
        let _e206 = local_11;
        let _e208 = local_27[1];
        local_27[1] = (_e208 + _e206);
        let _e212 = local_27[0];
        local_28 = u32(_e212);
        let _e216 = local_27[1];
        local_29 = u32(_e216);
        let _e219 = local_29;
        out_1[_e219] = _e196;
    }
}
