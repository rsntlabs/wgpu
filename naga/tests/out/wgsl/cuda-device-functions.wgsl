struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
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
    var local_50: bool;

    total = 0u;
    {
        i = 0u;
        loop {
            let _e6 = i;
            if (_e6 < count) {
            } else {
                break;
            }
            local_50 = include_even;
            if include_even {
            } else {
                let _e9 = i;
                local_50 = ((_e9 % 2u) != 0u);
            }
            let _e14 = local_50;
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
    var out: array<u32, 2>;
    var base: u32;
    var value: i32;
    var argument: i32;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var local_20: array<u32, 2>;
    var local_21: u32;
    var local_22: u32;
    var local_23: array<u32, 2>;
    var local_24: u32;
    var local_25: u32;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var local_28: u32;
    var local_29: array<u32, 2>;
    var local_30: u32;
    var local_31: u32;
    var local_32: array<u32, 2>;
    var local_33: u32;
    var local_34: u32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var local_37: u32;
    var local_38: array<u32, 2>;
    var local_39: u32;
    var local_40: u32;
    var local_41: array<u32, 2>;
    var local_42: u32;
    var local_43: u32;
    var local_44: array<u32, 2>;
    var local_45: u32;
    var local_46: u32;
    var local_47: array<u32, 2>;
    var local_48: u32;
    var local_49: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    let n_1 = n.value;
    let i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if (i_1 < n_1) {
        base = (i_1 * 10u);
        value = (i32(i_1) - 35i);
        argument = 3i;
        let _e26 = value;
        let _e27 = choose(_e26);
        let _e29 = out;
        local = _e29;
        let _e31 = base;
        local_1 = u32(_e31);
        let _e34 = local;
        local_20 = _e34;
        let _e36 = local_1;
        let _e38 = local_20[1];
        local_20[1] = (_e38 + _e36);
        let _e42 = local_20[0];
        local_21 = u32(_e42);
        let _e46 = local_20[1];
        local_22 = u32(_e46);
        let _e49 = local_22;
        out_1[_e49] = _e27;
        let _e52 = value;
        let _e56 = affine(f32(_e52), 1.5f, 2i);
        let _e57 = out;
        local_2 = _e57;
        let _e59 = base;
        local_3 = u32((_e59 + 1u));
        let _e65 = local_2;
        local_23 = _e65;
        let _e67 = local_3;
        let _e69 = local_23[1];
        local_23[1] = (_e69 + _e67);
        let _e73 = local_23[0];
        local_24 = u32(_e73);
        let _e77 = local_23[1];
        local_25 = u32(_e77);
        let _e80 = local_25;
        out_1[_e80] = i32(_e56);
        let _e85 = sum_steps(u32(5i), true);
        let _e86 = out;
        local_4 = _e86;
        let _e88 = base;
        local_5 = u32((_e88 + 2u));
        let _e94 = local_4;
        local_26 = _e94;
        let _e96 = local_5;
        let _e98 = local_26[1];
        local_26[1] = (_e98 + _e96);
        let _e102 = local_26[0];
        local_27 = u32(_e102);
        let _e106 = local_26[1];
        local_28 = u32(_e106);
        let _e109 = local_28;
        out_1[_e109] = i32(_e85);
        let _e115 = sum_steps(5u, (0i != 0i));
        let _e116 = out;
        local_6 = _e116;
        let _e118 = base;
        local_7 = u32((_e118 + 3u));
        let _e124 = local_6;
        local_29 = _e124;
        let _e126 = local_7;
        let _e128 = local_29[1];
        local_29[1] = (_e128 + _e126);
        let _e132 = local_29[0];
        local_30 = u32(_e132);
        let _e136 = local_29[1];
        local_31 = u32(_e136);
        let _e139 = local_31;
        out_1[_e139] = i32(_e115);
        let _e141 = value;
        let _e147 = affine(f32(_e141), f32(2u), i32(true));
        let _e148 = out;
        local_8 = _e148;
        let _e150 = base;
        local_9 = u32((_e150 + 4u));
        let _e156 = local_8;
        local_32 = _e156;
        let _e158 = local_9;
        let _e160 = local_32[1];
        local_32[1] = (_e160 + _e158);
        let _e164 = local_32[0];
        local_33 = u32(_e164);
        let _e168 = local_32[1];
        local_34 = u32(_e168);
        let _e171 = local_34;
        out_1[_e171] = i32(_e147);
        let _e173 = value;
        let _e174 = out;
        local_10 = _e174;
        let _e176 = base;
        local_11 = u32((_e176 + 5u));
        let _e181 = local_10;
        local_35 = _e181;
        let _e183 = local_11;
        let _e185 = local_35[1];
        local_35[1] = (_e185 + _e183);
        let _e189 = local_35[0];
        local_36 = u32(_e189);
        let _e193 = local_35[1];
        local_37 = u32(_e193);
        let _e196 = local_37;
        out_1[_e196] = _e173;
        let _e198 = value;
        let _e199 = choose(_e198);
        let _e200 = value;
        let _e203 = choose((_e200 + 1i));
        let _e205 = out;
        local_12 = _e205;
        let _e207 = base;
        local_13 = u32((_e207 + 6u));
        let _e212 = local_12;
        local_38 = _e212;
        let _e214 = local_13;
        let _e216 = local_38[1];
        local_38[1] = (_e216 + _e214);
        let _e220 = local_38[0];
        local_39 = u32(_e220);
        let _e224 = local_38[1];
        local_40 = u32(_e224);
        let _e227 = local_40;
        out_1[_e227] = (_e199 + _e203);
        let _e229 = value;
        let _e230 = nonnegative(_e229);
        let _e231 = out;
        local_14 = _e231;
        let _e233 = base;
        local_15 = u32((_e233 + 7u));
        let _e239 = local_14;
        local_41 = _e239;
        let _e241 = local_15;
        let _e243 = local_41[1];
        local_41[1] = (_e243 + _e241);
        let _e247 = local_41[0];
        local_42 = u32(_e247);
        let _e251 = local_41[1];
        local_43 = u32(_e251);
        let _e254 = local_43;
        out_1[_e254] = i32(_e230);
        let _e256 = argument;
        let _e257 = argument;
        argument = (_e257 + 1i);
        let _e260 = pair(_e256, _e257);
        let _e261 = out;
        local_16 = _e261;
        let _e263 = base;
        local_17 = u32((_e263 + 8u));
        let _e268 = local_16;
        local_44 = _e268;
        let _e270 = local_17;
        let _e272 = local_44[1];
        local_44[1] = (_e272 + _e270);
        let _e276 = local_44[0];
        local_45 = u32(_e276);
        let _e280 = local_44[1];
        local_46 = u32(_e280);
        let _e283 = local_46;
        out_1[_e283] = _e260;
        let _e285 = argument;
        let _e286 = out;
        local_18 = _e286;
        let _e288 = base;
        local_19 = u32((_e288 + 9u));
        let _e293 = local_18;
        local_47 = _e293;
        let _e295 = local_19;
        let _e297 = local_47[1];
        local_47[1] = (_e297 + _e295);
        let _e301 = local_47[0];
        local_48 = u32(_e301);
        let _e305 = local_47[1];
        local_49 = u32(_e305);
        let _e308 = local_49;
        out_1[_e308] = _e285;
    }
}
