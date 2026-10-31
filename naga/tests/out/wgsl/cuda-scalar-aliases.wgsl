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
        local = _e24;
        let _e26 = local;
        local_12 = _e26;
        let _e28 = local_12;
        out[_e28] = _e23;
        local_2 = i;
        let _e32 = local_2;
        local_13 = _e32;
        let _e34 = local_13;
        let _e37 = input[_e34];
        local_14 = _e37;
        let _e39 = local_14;
        local_11 = _e39;
        let _e41 = local_11;
        let _e45 = transform(f32(_e41), 2f, 1i);
        let _e47 = base;
        local_1 = u32((_e47 + 1u));
        let _e52 = local_1;
        local_15 = _e52;
        let _e54 = local_15;
        out[_e54] = u32(_e45);
        signed_count = -(3i);
        let _e59 = signed_count;
        let _e61 = base;
        local_3 = u32((_e61 + 2u));
        let _e66 = local_3;
        local_16 = _e66;
        let _e68 = local_16;
        out[_e68] = u32(_e59);
        {
            fraction = 3.75f;
            let _e72 = fraction;
            let _e74 = base;
            local_4 = u32((_e74 + 3u));
            let _e79 = local_4;
            local_17 = _e79;
            let _e81 = local_17;
            out[_e81] = u32(_e72);
        }
        after_block = -(5i);
        let _e86 = after_block;
        let _e88 = base;
        local_5 = u32((_e88 + 4u));
        let _e93 = local_5;
        local_18 = _e93;
        let _e95 = local_18;
        out[_e95] = u32(_e86);
        coefficient = 1.25f;
        let _e99 = coefficient;
        let _e103 = base;
        local_6 = u32((_e103 + 5u));
        let _e108 = local_6;
        local_19 = _e108;
        let _e110 = local_19;
        out[_e110] = u32((_e99 * 4f));
        selected = ((i % 2u) == 0u);
        let _e117 = selected;
        let _e119 = base;
        local_7 = u32((_e119 + 6u));
        let _e124 = local_7;
        local_20 = _e124;
        let _e126 = local_20;
        out[_e126] = u32(_e117);
        total = 0i;
        {
            loop {
                let _e130 = total;
                if (_e130 < 3i) {
                } else {
                    break;
                }
                let _e133 = total;
                current = _e133;
                let _e135 = current;
                total = (_e135 + 1i);
            }
        }
        let _e138 = total;
        let _e140 = base;
        local_8 = u32((_e140 + 7u));
        let _e145 = local_8;
        local_21 = _e145;
        let _e147 = local_21;
        out[_e147] = u32(_e138);
        after_loop = 1.5f;
        let _e151 = after_loop;
        let _e155 = base;
        local_9 = u32((_e155 + 8u));
        let _e160 = local_9;
        local_22 = _e160;
        let _e162 = local_22;
        out[_e162] = u32((_e151 * 2f));
        let _e166 = base;
        local_10 = u32((_e166 + 9u));
        let _e171 = local_10;
        local_23 = _e171;
        let _e173 = local_23;
        out[_e173] = u32(f32(n_1));
    }
}
