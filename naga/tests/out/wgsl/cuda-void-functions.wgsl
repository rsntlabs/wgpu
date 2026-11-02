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
        local = _e23;
        let _e25 = local;
        local_6 = _e25;
        let _e27 = local_6;
        out[_e27] = _e22;
        let _e30 = value;
        value = (_e30 + 1i);
        let _e33 = next_value(_e30);
        consume(true, _e33, 2u, 0.5f);
        let _e37 = value;
        let _e38 = base;
        local_1 = u32((_e38 + 1u));
        let _e43 = local_1;
        local_7 = _e43;
        let _e45 = local_7;
        out[_e45] = _e37;
        let _e51 = value;
        value = (_e51 + 1i);
        forward(((i % 2u) == 0u), _e51);
        let _e54 = value;
        let _e55 = base;
        local_2 = u32((_e55 + 2u));
        let _e60 = local_2;
        local_8 = _e60;
        let _e62 = local_8;
        out[_e62] = _e54;
        iterations = 0i;
        {
            let _e69 = value;
            value = (_e69 + 1i);
            consume((0i != 0i), _e69, u32(0i), f32(1u));
            loop {
                let _e76 = iterations;
                if (_e76 < 3i) {
                } else {
                    break;
                }
                let _e79 = iterations;
                iterations = (_e79 + 1i);
                let _e82 = iterations;
                if (_e82 == 1i) {
                    continue;
                }
                continuing {
                    let _e85 = value;
                    value = (_e85 + 1i);
                    let _e88 = value;
                    consume(false, _e88, 0u, 1f);
                }
            }
        }
        let _e92 = value;
        let _e93 = base;
        local_3 = u32((_e93 + 3u));
        let _e98 = local_3;
        local_9 = _e98;
        let _e100 = local_9;
        out[_e100] = _e92;
        let _e102 = iterations;
        let _e103 = base;
        local_4 = u32((_e103 + 4u));
        let _e108 = local_4;
        local_10 = _e108;
        let _e110 = local_10;
        out[_e110] = _e102;
        let _e112 = value;
        let _e113 = next_value(_e112);
        let _e114 = base;
        local_5 = u32((_e114 + 5u));
        let _e119 = local_5;
        local_11 = _e119;
        let _e121 = local_11;
        out[_e121] = _e113;
    }
}
