struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
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
    var base: u32;
    var value: i32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var iterations: i32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;

    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 6u);
        value = 2i;
        let _e16 = value;
        value = (_e16 + 1i);
        consume(false, _e16, 1u, 1.5f);
        let _e22 = value;
        let _e23 = base;
        local = u32(_e23);
        let _e26 = local;
        local_6 = u32(_e26);
        let _e29 = local_6;
        out[_e29] = _e22;
        let _e32 = value;
        value = (_e32 + 1i);
        let _e35 = next_value(_e32);
        consume(true, _e35, 2u, 0.5f);
        let _e39 = value;
        let _e40 = base;
        local_1 = u32((_e40 + 1u));
        let _e45 = local_1;
        local_7 = u32(_e45);
        let _e48 = local_7;
        out[_e48] = _e39;
        let _e54 = value;
        value = (_e54 + 1i);
        forward(((i % 2u) == 0u), _e54);
        let _e57 = value;
        let _e58 = base;
        local_2 = u32((_e58 + 2u));
        let _e63 = local_2;
        local_8 = u32(_e63);
        let _e66 = local_8;
        out[_e66] = _e57;
        iterations = 0i;
        {
            let _e70 = value;
            value = (_e70 + 1i);
            consume((0i != 0i), _e70, u32(0i), f32(1u));
            loop {
                let _e80 = iterations;
                if (_e80 < 3i) {
                } else {
                    break;
                }
                let _e83 = iterations;
                iterations = (_e83 + 1i);
                let _e86 = iterations;
                if (_e86 == 1i) {
                    continue;
                }
                continuing {
                    let _e89 = value;
                    value = (_e89 + 1i);
                    let _e92 = value;
                    consume(false, _e92, 0u, 1f);
                }
            }
        }
        let _e96 = value;
        let _e97 = base;
        local_3 = u32((_e97 + 3u));
        let _e102 = local_3;
        local_9 = u32(_e102);
        let _e105 = local_9;
        out[_e105] = _e96;
        let _e107 = iterations;
        let _e108 = base;
        local_4 = u32((_e108 + 4u));
        let _e113 = local_4;
        local_10 = u32(_e113);
        let _e116 = local_10;
        out[_e116] = _e107;
        let _e118 = value;
        let _e119 = next_value(_e118);
        let _e120 = base;
        local_5 = u32((_e120 + 5u));
        let _e125 = local_5;
        local_11 = u32(_e125);
        let _e128 = local_11;
        out[_e128] = _e119;
    }
}
