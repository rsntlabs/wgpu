struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
@group(0) @binding(2)
var<uniform> n: type_5;
var<workgroup> shared_values: array<u32, 64>;

fn transform(value: f32, multiplier: f32, offset: i32) -> i32 {
    return i32(((value * multiplier) + f32(offset)));
}

@compute @workgroup_size(64, 1, 1)
fn scalar_aliases(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var base: u32;
    var lane: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var signed_count: i32;
    var local_3: u32;
    var fraction: f32;
    var local_4: u32;
    var after_block: i32;
    var local_5: u32;
    var coefficient: f32;
    var local_6: u32;
    var selected: bool;
    var local_7: u32;
    var total: i32;
    var current: i32;
    var local_8: u32;
    var after_loop: f32;
    var local_9: u32;
    var local_10: u32;
    var local_11: i32;
    var local_12: u32;
    var local_13: u32;
    var local_14: i32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;

    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 10u);
        lane = threadIdx.x;
        let _e18 = lane;
        shared_values[_e18] = (i + 10u);
        let _e21 = lane;
        let _e23 = shared_values[_e21];
        let _e24 = base;
        local = u32(_e24);
        let _e27 = local;
        local_12 = u32(_e27);
        let _e30 = local_12;
        out[_e30] = _e23;
        local_2 = u32(i);
        let _e35 = local_2;
        local_13 = u32(_e35);
        let _e38 = local_13;
        let _e41 = input[_e38];
        local_14 = _e41;
        let _e43 = local_14;
        local_11 = _e43;
        let _e45 = local_11;
        let _e49 = transform(f32(_e45), 2f, 1i);
        let _e51 = base;
        local_1 = u32((_e51 + 1u));
        let _e56 = local_1;
        local_15 = u32(_e56);
        let _e59 = local_15;
        out[_e59] = u32(_e49);
        signed_count = -(3i);
        let _e64 = signed_count;
        let _e66 = base;
        local_3 = u32((_e66 + 2u));
        let _e71 = local_3;
        local_16 = u32(_e71);
        let _e74 = local_16;
        out[_e74] = u32(_e64);
        {
            fraction = 3.75f;
            let _e78 = fraction;
            let _e80 = base;
            local_4 = u32((_e80 + 3u));
            let _e85 = local_4;
            local_17 = u32(_e85);
            let _e88 = local_17;
            out[_e88] = u32(_e78);
        }
        after_block = -(5i);
        let _e93 = after_block;
        let _e95 = base;
        local_5 = u32((_e95 + 4u));
        let _e100 = local_5;
        local_18 = u32(_e100);
        let _e103 = local_18;
        out[_e103] = u32(_e93);
        coefficient = 1.25f;
        let _e107 = coefficient;
        let _e111 = base;
        local_6 = u32((_e111 + 5u));
        let _e116 = local_6;
        local_19 = u32(_e116);
        let _e119 = local_19;
        out[_e119] = u32((_e107 * 4f));
        selected = ((i % 2u) == 0u);
        let _e126 = selected;
        let _e128 = base;
        local_7 = u32((_e128 + 6u));
        let _e133 = local_7;
        local_20 = u32(_e133);
        let _e136 = local_20;
        out[_e136] = u32(_e126);
        total = 0i;
        {
            loop {
                let _e140 = total;
                if (_e140 < 3i) {
                } else {
                    break;
                }
                let _e143 = total;
                current = _e143;
                let _e145 = current;
                total = (_e145 + 1i);
            }
        }
        let _e148 = total;
        let _e150 = base;
        local_8 = u32((_e150 + 7u));
        let _e155 = local_8;
        local_21 = u32(_e155);
        let _e158 = local_21;
        out[_e158] = u32(_e148);
        after_loop = 1.5f;
        let _e162 = after_loop;
        let _e166 = base;
        local_9 = u32((_e166 + 8u));
        let _e171 = local_9;
        local_22 = u32(_e171);
        let _e174 = local_22;
        out[_e174] = u32((_e162 * 2f));
        let _e178 = base;
        local_10 = u32((_e178 + 9u));
        let _e183 = local_10;
        local_23 = u32(_e183);
        let _e186 = local_23;
        out[_e186] = u32(f32(n_1));
    }
}
