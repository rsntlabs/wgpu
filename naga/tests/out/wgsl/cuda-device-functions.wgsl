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
    var local_41: bool;

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
            local_41 = _e15;
            if _e15 {
            } else {
                let _e18 = i_1;
                local_41 = ((_e18 % 2u) != 0u);
            }
            let _e22 = local_41;
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
    var local: u32;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var argument: i32;
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
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;

    local = 0u;
    let _e6 = n_1.value;
    n = _e6;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e14 = i;
    let _e15 = n;
    if (_e14 < _e15) {
        let _e17 = i;
        base = (_e17 * 10u);
        let _e21 = i;
        value = (i32(_e21) - 35i);
        argument = 3i;
        let _e28 = value;
        let _e29 = choose(_e28);
        let _e30 = local;
        local_1 = _e30;
        let _e32 = local_1;
        local_2 = u32(_e32);
        let _e35 = base;
        local_3 = u32(_e35);
        let _e39 = local_2;
        let _e40 = local_3;
        local_31 = u32((_e39 + _e40));
        let _e44 = local_31;
        out[_e44] = _e29;
        let _e46 = value;
        let _e50 = affine(f32(_e46), 1.5f, 2i);
        let _e51 = local;
        local_4 = _e51;
        let _e53 = local_4;
        local_5 = u32(_e53);
        let _e56 = base;
        local_6 = u32((_e56 + 1u));
        let _e62 = local_5;
        let _e63 = local_6;
        local_32 = u32((_e62 + _e63));
        let _e67 = local_32;
        out[_e67] = i32(_e50);
        let _e72 = sum_steps(u32(5i), true);
        let _e73 = local;
        local_7 = _e73;
        let _e75 = local_7;
        local_8 = u32(_e75);
        let _e78 = base;
        local_9 = u32((_e78 + 2u));
        let _e84 = local_8;
        let _e85 = local_9;
        local_33 = u32((_e84 + _e85));
        let _e89 = local_33;
        out[_e89] = i32(_e72);
        let _e95 = sum_steps(5u, (0i != 0i));
        let _e96 = local;
        local_10 = _e96;
        let _e98 = local_10;
        local_11 = u32(_e98);
        let _e101 = base;
        local_12 = u32((_e101 + 3u));
        let _e107 = local_11;
        let _e108 = local_12;
        local_34 = u32((_e107 + _e108));
        let _e112 = local_34;
        out[_e112] = i32(_e95);
        let _e114 = value;
        let _e120 = affine(f32(_e114), f32(2u), i32(true));
        let _e121 = local;
        local_13 = _e121;
        let _e123 = local_13;
        local_14 = u32(_e123);
        let _e126 = base;
        local_15 = u32((_e126 + 4u));
        let _e132 = local_14;
        let _e133 = local_15;
        local_35 = u32((_e132 + _e133));
        let _e137 = local_35;
        out[_e137] = i32(_e120);
        let _e139 = value;
        let _e140 = local;
        local_16 = _e140;
        let _e142 = local_16;
        local_17 = u32(_e142);
        let _e145 = base;
        local_18 = u32((_e145 + 5u));
        let _e150 = local_17;
        let _e151 = local_18;
        local_36 = u32((_e150 + _e151));
        let _e155 = local_36;
        out[_e155] = _e139;
        let _e157 = value;
        let _e158 = choose(_e157);
        let _e159 = value;
        let _e162 = choose((_e159 + 1i));
        let _e164 = local;
        local_19 = _e164;
        let _e166 = local_19;
        local_20 = u32(_e166);
        let _e169 = base;
        local_21 = u32((_e169 + 6u));
        let _e174 = local_20;
        let _e175 = local_21;
        local_37 = u32((_e174 + _e175));
        let _e179 = local_37;
        out[_e179] = (_e158 + _e162);
        let _e181 = value;
        let _e182 = nonnegative(_e181);
        let _e183 = local;
        local_22 = _e183;
        let _e185 = local_22;
        local_23 = u32(_e185);
        let _e188 = base;
        local_24 = u32((_e188 + 7u));
        let _e194 = local_23;
        let _e195 = local_24;
        local_38 = u32((_e194 + _e195));
        let _e199 = local_38;
        out[_e199] = i32(_e182);
        let _e201 = argument;
        let _e202 = argument;
        argument = (_e202 + 1i);
        let _e205 = pair(_e201, _e202);
        let _e206 = local;
        local_25 = _e206;
        let _e208 = local_25;
        local_26 = u32(_e208);
        let _e211 = base;
        local_27 = u32((_e211 + 8u));
        let _e216 = local_26;
        let _e217 = local_27;
        local_39 = u32((_e216 + _e217));
        let _e221 = local_39;
        out[_e221] = _e205;
        let _e223 = argument;
        let _e224 = local;
        local_28 = _e224;
        let _e226 = local_28;
        local_29 = u32(_e226);
        let _e229 = base;
        local_30 = u32((_e229 + 9u));
        let _e234 = local_29;
        let _e235 = local_30;
        local_40 = u32((_e234 + _e235));
        let _e239 = local_40;
        out[_e239] = _e223;
    }
}
