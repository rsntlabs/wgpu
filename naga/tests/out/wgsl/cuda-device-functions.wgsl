struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<uniform> n: type_5;

fn affine(value_1: f32, scale: f32, offset: i32) -> f32 {
    var value_2: f32;

    value_2 = value_1;
    let _e4 = value_2;
    value_2 = (_e4 * scale);
    let _e6 = value_2;
    return (_e6 + f32(offset));
}

fn nonnegative(value_3: i32) -> bool {
    return (value_3 >= 0i);
}

fn sum_steps(count: u32, include_even: bool) -> u32 {
    var total: u32;
    var i: u32;
    var local_20: bool;

    total = 0u;
    {
        i = 0u;
        loop {
            let _e6 = i;
            if (_e6 < count) {
            } else {
                break;
            }
            local_20 = include_even;
            if include_even {
            } else {
                let _e9 = i;
                local_20 = ((_e9 % 2u) != 0u);
            }
            let _e14 = local_20;
            if _e14 {
                let _e15 = i;
                let _e16 = total;
                total = (_e16 + _e15);
            }
            continuing {
                let _e18 = i;
                i = (_e18 + u32(1i));
            }
        }
    }
    let _e22 = total;
    return _e22;
}

fn choose(value_4: i32) -> i32 {
    let _e1 = nonnegative(value_4);
    if _e1 {
        let _e5 = affine(f32(value_4), 2f, 1i);
        return i32(_e5);
    }
    return -(value_4);
}

fn pair(a: i32, b: i32) -> i32 {
    return ((a * 10i) + b);
}

@compute @workgroup_size(64, 1, 1)
fn device_functions(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var base: u32;
    var value: i32;
    var argument: i32;
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
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;

    let n_1 = n.value;
    let i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if (i_1 < n_1) {
        base = (i_1 * 10u);
        value = (i32(i_1) - 35i);
        argument = 3i;
        let _e20 = value;
        let _e21 = choose(_e20);
        let _e22 = base;
        local = u32(_e22);
        let _e25 = local;
        local_10 = u32(_e25);
        let _e28 = local_10;
        out[_e28] = _e21;
        let _e31 = value;
        let _e35 = affine(f32(_e31), 1.5f, 2i);
        let _e36 = base;
        local_1 = u32((_e36 + 1u));
        let _e42 = local_1;
        local_11 = u32(_e42);
        let _e45 = local_11;
        out[_e45] = i32(_e35);
        let _e50 = sum_steps(u32(5i), true);
        let _e51 = base;
        local_2 = u32((_e51 + 2u));
        let _e57 = local_2;
        local_12 = u32(_e57);
        let _e60 = local_12;
        out[_e60] = i32(_e50);
        let _e66 = sum_steps(5u, (0i != 0i));
        let _e67 = base;
        local_3 = u32((_e67 + 3u));
        let _e73 = local_3;
        local_13 = u32(_e73);
        let _e76 = local_13;
        out[_e76] = i32(_e66);
        let _e78 = value;
        let _e84 = affine(f32(_e78), f32(2u), i32(true));
        let _e85 = base;
        local_4 = u32((_e85 + 4u));
        let _e91 = local_4;
        local_14 = u32(_e91);
        let _e94 = local_14;
        out[_e94] = i32(_e84);
        let _e96 = value;
        let _e97 = base;
        local_5 = u32((_e97 + 5u));
        let _e102 = local_5;
        local_15 = u32(_e102);
        let _e105 = local_15;
        out[_e105] = _e96;
        let _e107 = value;
        let _e108 = choose(_e107);
        let _e109 = value;
        let _e112 = choose((_e109 + 1i));
        let _e114 = base;
        local_6 = u32((_e114 + 6u));
        let _e119 = local_6;
        local_16 = u32(_e119);
        let _e122 = local_16;
        out[_e122] = (_e108 + _e112);
        let _e124 = value;
        let _e125 = nonnegative(_e124);
        let _e126 = base;
        local_7 = u32((_e126 + 7u));
        let _e132 = local_7;
        local_17 = u32(_e132);
        let _e135 = local_17;
        out[_e135] = i32(_e125);
        let _e137 = argument;
        let _e138 = argument;
        argument = (_e138 + 1i);
        let _e141 = pair(_e137, _e138);
        let _e142 = base;
        local_8 = u32((_e142 + 8u));
        let _e147 = local_8;
        local_18 = u32(_e147);
        let _e150 = local_18;
        out[_e150] = _e141;
        let _e152 = argument;
        let _e153 = base;
        local_9 = u32((_e153 + 9u));
        let _e158 = local_9;
        local_19 = u32(_e158);
        let _e161 = local_19;
        out[_e161] = _e152;
    }
}
