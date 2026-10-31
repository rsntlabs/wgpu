struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<uniform> n_1: type_5;

fn affine(value_1: f32, scale: f32, offset: i32) -> f32 {
    var value_2: f32;
    var scale_1: f32;
    var offset_1: i32;

    value_2 = value_1;
    scale_1 = scale;
    offset_1 = offset;
    let _e6 = scale_1;
    let _e7 = value_2;
    value_2 = (_e7 * _e6);
    let _e9 = value_2;
    let _e10 = offset_1;
    return (_e9 + f32(_e10));
}

fn nonnegative(value_3: i32) -> bool {
    var value_4: i32;

    value_4 = value_3;
    let _e3 = value_4;
    return (_e3 >= 0i);
}

fn sum_steps(count: u32, include_even: bool) -> u32 {
    var count_1: u32;
    var include_even_1: bool;
    var total: u32;
    var i_1: u32;
    var local_51: bool;

    count_1 = count;
    include_even_1 = include_even;
    total = 0u;
    {
        i_1 = 0u;
        loop {
            let _e8 = i_1;
            let _e9 = count_1;
            if (_e8 < _e9) {
            } else {
                break;
            }
            let _e15 = include_even_1;
            local_51 = _e15;
            if _e15 {
            } else {
                let _e18 = i_1;
                local_51 = ((_e18 % 2u) != 0u);
            }
            let _e22 = local_51;
            if _e22 {
                let _e23 = i_1;
                let _e24 = total;
                total = (_e24 + _e23);
            }
            continuing {
                let _e11 = i_1;
                i_1 = (_e11 + u32(1i));
            }
        }
    }
    let _e26 = total;
    return _e26;
}

fn choose(value_5: i32) -> i32 {
    var value_6: i32;

    value_6 = value_5;
    let _e2 = value_6;
    let _e3 = nonnegative(_e2);
    if _e3 {
        let _e4 = value_6;
        let _e8 = affine(f32(_e4), 2f, 1i);
        return i32(_e8);
    }
    let _e10 = value_6;
    return -(_e10);
}

fn pair(a: i32, b: i32) -> i32 {
    var a_1: i32;
    var b_1: i32;

    a_1 = a;
    b_1 = b;
    let _e5 = a_1;
    let _e7 = b_1;
    return ((_e5 * 10i) + _e7);
}

@compute @workgroup_size(64, 1, 1)
fn device_functions(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: array<u32, 2>;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var argument: i32;
    var local_1: array<u32, 2>;
    var local_2: u32;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: array<u32, 2>;
    var local_14: u32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var local_17: array<u32, 2>;
    var local_18: u32;
    var local_19: array<u32, 2>;
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
    var local_30: array<u32, 2>;
    var local_31: u32;
    var local_32: u32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var local_35: u32;
    var local_36: array<u32, 2>;
    var local_37: u32;
    var local_38: u32;
    var local_39: array<u32, 2>;
    var local_40: u32;
    var local_41: u32;
    var local_42: array<u32, 2>;
    var local_43: u32;
    var local_44: u32;
    var local_45: array<u32, 2>;
    var local_46: u32;
    var local_47: u32;
    var local_48: array<u32, 2>;
    var local_49: u32;
    var local_50: u32;

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
        base = (_e22 * 10u);
        let _e26 = i;
        value = (i32(_e26) - 35i);
        argument = 3i;
        let _e33 = value;
        let _e34 = choose(_e33);
        let _e37 = local;
        local_1 = _e37;
        let _e38 = base;
        local_2 = u32(_e38);
        let _e42 = local_1;
        local_21 = _e42;
        let _e43 = local_2;
        let _e45 = local_21[1];
        local_21[1] = (_e45 + _e43);
        let _e49 = local_21[0];
        local_22 = u32(_e49);
        let _e53 = local_21[1];
        local_23 = u32(_e53);
        let _e56 = local_23;
        out[_e56] = _e34;
        let _e58 = value;
        let _e62 = affine(f32(_e58), 1.5f, 2i);
        let _e64 = local;
        local_3 = _e64;
        let _e65 = base;
        local_4 = u32((_e65 + 1u));
        let _e72 = local_3;
        local_24 = _e72;
        let _e73 = local_4;
        let _e75 = local_24[1];
        local_24[1] = (_e75 + _e73);
        let _e79 = local_24[0];
        local_25 = u32(_e79);
        let _e83 = local_24[1];
        local_26 = u32(_e83);
        let _e86 = local_26;
        out[_e86] = i32(_e62);
        let _e91 = sum_steps(u32(5i), true);
        let _e93 = local;
        local_5 = _e93;
        let _e94 = base;
        local_6 = u32((_e94 + 2u));
        let _e101 = local_5;
        local_27 = _e101;
        let _e102 = local_6;
        let _e104 = local_27[1];
        local_27[1] = (_e104 + _e102);
        let _e108 = local_27[0];
        local_28 = u32(_e108);
        let _e112 = local_27[1];
        local_29 = u32(_e112);
        let _e115 = local_29;
        out[_e115] = i32(_e91);
        let _e121 = sum_steps(5u, (0i != 0i));
        let _e123 = local;
        local_7 = _e123;
        let _e124 = base;
        local_8 = u32((_e124 + 3u));
        let _e131 = local_7;
        local_30 = _e131;
        let _e132 = local_8;
        let _e134 = local_30[1];
        local_30[1] = (_e134 + _e132);
        let _e138 = local_30[0];
        local_31 = u32(_e138);
        let _e142 = local_30[1];
        local_32 = u32(_e142);
        let _e145 = local_32;
        out[_e145] = i32(_e121);
        let _e147 = value;
        let _e153 = affine(f32(_e147), f32(2u), i32(true));
        let _e155 = local;
        local_9 = _e155;
        let _e156 = base;
        local_10 = u32((_e156 + 4u));
        let _e163 = local_9;
        local_33 = _e163;
        let _e164 = local_10;
        let _e166 = local_33[1];
        local_33[1] = (_e166 + _e164);
        let _e170 = local_33[0];
        local_34 = u32(_e170);
        let _e174 = local_33[1];
        local_35 = u32(_e174);
        let _e177 = local_35;
        out[_e177] = i32(_e153);
        let _e179 = value;
        let _e181 = local;
        local_11 = _e181;
        let _e182 = base;
        local_12 = u32((_e182 + 5u));
        let _e188 = local_11;
        local_36 = _e188;
        let _e189 = local_12;
        let _e191 = local_36[1];
        local_36[1] = (_e191 + _e189);
        let _e195 = local_36[0];
        local_37 = u32(_e195);
        let _e199 = local_36[1];
        local_38 = u32(_e199);
        let _e202 = local_38;
        out[_e202] = _e179;
        let _e204 = value;
        let _e205 = choose(_e204);
        let _e206 = value;
        let _e209 = choose((_e206 + 1i));
        let _e212 = local;
        local_13 = _e212;
        let _e213 = base;
        local_14 = u32((_e213 + 6u));
        let _e219 = local_13;
        local_39 = _e219;
        let _e220 = local_14;
        let _e222 = local_39[1];
        local_39[1] = (_e222 + _e220);
        let _e226 = local_39[0];
        local_40 = u32(_e226);
        let _e230 = local_39[1];
        local_41 = u32(_e230);
        let _e233 = local_41;
        out[_e233] = (_e205 + _e209);
        let _e235 = value;
        let _e236 = nonnegative(_e235);
        let _e238 = local;
        local_15 = _e238;
        let _e239 = base;
        local_16 = u32((_e239 + 7u));
        let _e246 = local_15;
        local_42 = _e246;
        let _e247 = local_16;
        let _e249 = local_42[1];
        local_42[1] = (_e249 + _e247);
        let _e253 = local_42[0];
        local_43 = u32(_e253);
        let _e257 = local_42[1];
        local_44 = u32(_e257);
        let _e260 = local_44;
        out[_e260] = i32(_e236);
        let _e262 = argument;
        let _e263 = argument;
        argument = (_e263 + 1i);
        let _e266 = pair(_e262, _e263);
        let _e268 = local;
        local_17 = _e268;
        let _e269 = base;
        local_18 = u32((_e269 + 8u));
        let _e275 = local_17;
        local_45 = _e275;
        let _e276 = local_18;
        let _e278 = local_45[1];
        local_45[1] = (_e278 + _e276);
        let _e282 = local_45[0];
        local_46 = u32(_e282);
        let _e286 = local_45[1];
        local_47 = u32(_e286);
        let _e289 = local_47;
        out[_e289] = _e266;
        let _e291 = argument;
        let _e293 = local;
        local_19 = _e293;
        let _e294 = base;
        local_20 = u32((_e294 + 9u));
        let _e300 = local_19;
        local_48 = _e300;
        let _e301 = local_20;
        let _e303 = local_48[1];
        local_48[1] = (_e303 + _e301);
        let _e307 = local_48[0];
        local_49 = u32(_e307);
        let _e311 = local_48[1];
        local_50 = u32(_e311);
        let _e314 = local_50;
        out[_e314] = _e291;
    }
}
