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
    var local: u32;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var iterations: i32;
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

    local = 0u;
    let _e6 = n_1.value;
    n = _e6;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e14 = i;
    let _e15 = n;
    if (_e14 < _e15) {
        let _e17 = i;
        base = (_e17 * 6u);
        value = 2i;
        let _e23 = value;
        value = (_e23 + 1i);
        consume(false, _e23, 1u, 1.5f);
        let _e29 = value;
        let _e30 = local;
        local_1 = _e30;
        let _e32 = local_1;
        local_2 = u32(_e32);
        let _e35 = base;
        local_3 = u32(_e35);
        let _e39 = local_2;
        let _e40 = local_3;
        local_19 = u32((_e39 + _e40));
        let _e44 = local_19;
        out[_e44] = _e29;
        let _e46 = value;
        value = (_e46 + 1i);
        let _e49 = next_value(_e46);
        consume(true, _e49, 2u, 0.5f);
        let _e53 = value;
        let _e54 = local;
        local_4 = _e54;
        let _e56 = local_4;
        local_5 = u32(_e56);
        let _e59 = base;
        local_6 = u32((_e59 + 1u));
        let _e64 = local_5;
        let _e65 = local_6;
        local_20 = u32((_e64 + _e65));
        let _e69 = local_20;
        out[_e69] = _e53;
        let _e71 = i;
        let _e76 = value;
        value = (_e76 + 1i);
        forward(((_e71 % 2u) == 0u), _e76);
        let _e79 = value;
        let _e80 = local;
        local_7 = _e80;
        let _e82 = local_7;
        local_8 = u32(_e82);
        let _e85 = base;
        local_9 = u32((_e85 + 2u));
        let _e90 = local_8;
        let _e91 = local_9;
        local_21 = u32((_e90 + _e91));
        let _e95 = local_21;
        out[_e95] = _e79;
        iterations = 0i;
        {
            let _e99 = value;
            value = (_e99 + 1i);
            consume((0i != 0i), _e99, u32(0i), f32(1u));
            loop {
                let _e109 = iterations;
                if (_e109 < 3i) {
                } else {
                    break;
                }
                let _e112 = iterations;
                iterations = (_e112 + 1i);
                let _e115 = iterations;
                if (_e115 == 1i) {
                    continue;
                }
                continuing {
                    let _e118 = value;
                    value = (_e118 + 1i);
                    let _e121 = value;
                    consume(false, _e121, 0u, 1f);
                }
            }
        }
        let _e125 = value;
        let _e126 = local;
        local_10 = _e126;
        let _e128 = local_10;
        local_11 = u32(_e128);
        let _e131 = base;
        local_12 = u32((_e131 + 3u));
        let _e136 = local_11;
        let _e137 = local_12;
        local_22 = u32((_e136 + _e137));
        let _e141 = local_22;
        out[_e141] = _e125;
        let _e143 = iterations;
        let _e144 = local;
        local_13 = _e144;
        let _e146 = local_13;
        local_14 = u32(_e146);
        let _e149 = base;
        local_15 = u32((_e149 + 4u));
        let _e154 = local_14;
        let _e155 = local_15;
        local_23 = u32((_e154 + _e155));
        let _e159 = local_23;
        out[_e159] = _e143;
        let _e161 = value;
        let _e162 = next_value(_e161);
        let _e163 = local;
        local_16 = _e163;
        let _e165 = local_16;
        local_17 = u32(_e165);
        let _e168 = base;
        local_18 = u32((_e168 + 5u));
        let _e173 = local_17;
        let _e174 = local_18;
        local_24 = u32((_e173 + _e174));
        let _e178 = local_24;
        out[_e178] = _e162;
    }
}
