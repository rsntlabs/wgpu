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
        local = _e22;
        let _e24 = local;
        local_10 = _e24;
        let _e26 = local_10;
        out[_e26] = _e21;
        let _e29 = value;
        let _e33 = affine(f32(_e29), 1.5f, 2i);
        let _e34 = base;
        local_1 = u32((_e34 + 1u));
        let _e40 = local_1;
        local_11 = _e40;
        let _e42 = local_11;
        out[_e42] = i32(_e33);
        let _e47 = sum_steps(u32(5i), true);
        let _e48 = base;
        local_2 = u32((_e48 + 2u));
        let _e54 = local_2;
        local_12 = _e54;
        let _e56 = local_12;
        out[_e56] = i32(_e47);
        let _e62 = sum_steps(5u, (0i != 0i));
        let _e63 = base;
        local_3 = u32((_e63 + 3u));
        let _e69 = local_3;
        local_13 = _e69;
        let _e71 = local_13;
        out[_e71] = i32(_e62);
        let _e73 = value;
        let _e79 = affine(f32(_e73), f32(2u), i32(true));
        let _e80 = base;
        local_4 = u32((_e80 + 4u));
        let _e86 = local_4;
        local_14 = _e86;
        let _e88 = local_14;
        out[_e88] = i32(_e79);
        let _e90 = value;
        let _e91 = base;
        local_5 = u32((_e91 + 5u));
        let _e96 = local_5;
        local_15 = _e96;
        let _e98 = local_15;
        out[_e98] = _e90;
        let _e100 = value;
        let _e101 = choose(_e100);
        let _e102 = value;
        let _e105 = choose((_e102 + 1i));
        let _e107 = base;
        local_6 = u32((_e107 + 6u));
        let _e112 = local_6;
        local_16 = _e112;
        let _e114 = local_16;
        out[_e114] = (_e101 + _e105);
        let _e116 = value;
        let _e117 = nonnegative(_e116);
        let _e118 = base;
        local_7 = u32((_e118 + 7u));
        let _e124 = local_7;
        local_17 = _e124;
        let _e126 = local_17;
        out[_e126] = i32(_e117);
        let _e128 = argument;
        let _e129 = argument;
        argument = (_e129 + 1i);
        let _e132 = pair(_e128, _e129);
        let _e133 = base;
        local_8 = u32((_e133 + 8u));
        let _e138 = local_8;
        local_18 = _e138;
        let _e140 = local_18;
        out[_e140] = _e132;
        let _e142 = argument;
        let _e143 = base;
        local_9 = u32((_e143 + 9u));
        let _e148 = local_9;
        local_19 = _e148;
        let _e150 = local_19;
        out[_e150] = _e142;
    }
}
