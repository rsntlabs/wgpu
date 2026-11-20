@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn finite_value(value: f32) -> i32 {
    return i32(((bitcast<u32>(value) & 2147483647u) < 2139095040u));
}

fn infinite_value(value_1: f32) -> i32 {
    return i32(((bitcast<u32>(value_1) & 2147483647u) == 2139095040u));
}

fn nan_value(value_2: f32) -> i32 {
    return i32(((bitcast<u32>(value_2) & 2147483647u) > 2139095040u));
}

fn sign_value(value_3: f32) -> i32 {
    return i32(((bitcast<u32>(value_3) & 2147483648u) != 0u));
}

fn result_kind(value_4: i32) -> u32 {
    return (10u + u32(value_4));
}

fn signbit(value_5: bool) -> i32 {
    var local_44: i32;

    if value_5 {
        local_44 = 7i;
    } else {
        local_44 = 9i;
    }
    let _e6 = local_44;
    return _e6;
}

@compute @workgroup_size(32, 1, 1)
fn float_classification(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var cursor: i32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: bool;
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
    var alias_cursor: i32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;

    let index = (threadIdx.x + (blockIdx.x * 32u));
    if (index >= 544u) {
        return;
    }
    let bits = input[index];
    let base = (4u + (index * 33u));
    let value_6 = bitcast<f32>(bits);
    output[base] = u32(i32(((bitcast<u32>(value_6) & 2147483647u) < 2139095040u)));
    local = u32((base + 1u));
    let _e37 = local;
    output[_e37] = u32(i32(((bitcast<u32>(value_6) & 2147483647u) == 2139095040u)));
    local_1 = u32((base + 2u));
    let _e50 = local_1;
    output[_e50] = u32(i32(((bitcast<u32>(value_6) & 2147483647u) > 2139095040u)));
    local_2 = u32((base + 3u));
    let _e63 = local_2;
    output[_e63] = u32(i32(((bitcast<u32>(value_6) & 2147483648u) != 0u)));
    let _e65 = finite_value(value_6);
    local_3 = u32((base + 4u));
    let _e71 = local_3;
    output[_e71] = u32(_e65);
    let _e73 = infinite_value(value_6);
    local_4 = u32((base + 5u));
    let _e79 = local_4;
    output[_e79] = u32(_e73);
    let _e81 = nan_value(value_6);
    local_5 = u32((base + 6u));
    let _e87 = local_5;
    output[_e87] = u32(_e81);
    let _e89 = sign_value(value_6);
    local_6 = u32((base + 7u));
    let _e95 = local_6;
    output[_e95] = u32(_e89);
    let _e103 = result_kind(i32(((bitcast<u32>(value_6) & 2147483647u) > 2139095040u)));
    local_7 = u32((base + 8u));
    let _e108 = local_7;
    output[_e108] = _e103;
    cursor = 0i;
    let _e112 = cursor;
    cursor = (_e112 + 1i);
    local_9 = u32((index + u32(_e112)));
    let _e119 = local_9;
    let _e121 = input[_e119];
    local_8 = u32((base + 9u));
    let _e134 = local_8;
    output[_e134] = u32(i32(((bitcast<u32>(bitcast<f32>(_e121)) & 2147483648u) != 0u)));
    let _e136 = cursor;
    local_10 = u32((base + 10u));
    let _e142 = local_10;
    output[_e142] = u32(_e136);
    let _e145 = signbit(true);
    local_11 = u32((base + 11u));
    let _e151 = local_11;
    output[_e151] = u32(_e145);
    if (i32(((bitcast<u32>(value_6) & 2147483647u) < 2139095040u)) != 0i) {
        local_12 = u32((base + 12u));
        let _e165 = local_12;
        local_41 = _e165;
        let _e167 = local_41;
        output[_e167] = 2u;
    } else {
        if (i32(((bitcast<u32>(value_6) & 2147483647u) == 2139095040u)) != 0i) {
            local_13 = u32((base + 12u));
            let _e182 = local_13;
            local_42 = _e182;
            let _e184 = local_42;
            output[_e184] = 3u;
        } else {
            local_14 = u32((base + 12u));
            let _e191 = local_14;
            local_43 = _e191;
            let _e193 = local_43;
            output[_e193] = 4u;
        }
    }
    local_16 = false;
    if false {
        let _e198 = cursor;
        cursor = (_e198 + 1i);
        local_16 = (i32(((bitcast<u32>((value_6 + f32(_e198))) & 2147483647u) > 2139095040u)) != 0i);
    }
    let _e211 = local_16;
    local_15 = u32((base + 13u));
    let _e217 = local_15;
    output[_e217] = u32(_e211);
    let _e219 = cursor;
    local_17 = u32((base + 14u));
    let _e225 = local_17;
    output[_e225] = u32(_e219);
    local_18 = u32((base + 15u));
    let _e240 = local_18;
    output[_e240] = u32(i32(((bitcast<u32>(f32(3i)) & 2147483647u) < 2139095040u)));
    local_19 = u32((base + 16u));
    let _e254 = local_19;
    output[_e254] = u32(i32(((bitcast<u32>(0f) & 2147483648u) != 0u)));
    local_20 = u32((base + 17u));
    let _e269 = local_20;
    output[_e269] = u32(i32(((bitcast<u32>(-(0f)) & 2147483648u) != 0u)));
    let _e273 = sign_value(-(0f));
    local_21 = u32((base + 18u));
    let _e279 = local_21;
    output[_e279] = u32(_e273);
    local_23 = 2139095040u;
    let _e283 = local_23;
    local_22 = u32((base + 19u));
    let _e296 = local_22;
    output[_e296] = u32(i32(((bitcast<u32>(bitcast<f32>(_e283)) & 2147483647u) < 2139095040u)));
    local_25 = 2139095040u;
    let _e300 = local_25;
    local_24 = u32((base + 20u));
    let _e313 = local_24;
    output[_e313] = u32(i32(((bitcast<u32>(bitcast<f32>(_e300)) & 2147483647u) == 2139095040u)));
    local_27 = 4286578689u;
    let _e317 = local_27;
    local_26 = u32((base + 21u));
    let _e330 = local_26;
    output[_e330] = u32(i32(((bitcast<u32>(bitcast<f32>(_e317)) & 2147483647u) > 2139095040u)));
    local_29 = 4286578689u;
    let _e334 = local_29;
    local_28 = u32((base + 22u));
    let _e347 = local_28;
    output[_e347] = u32(i32(((bitcast<u32>(bitcast<f32>(_e334)) & 2147483648u) != 0u)));
    local_30 = u32((base + 23u));
    let _e360 = local_30;
    output[_e360] = u32(i32(((bitcast<u32>(value_6) & 2147483647u) < 2139095040u)));
    local_31 = u32((base + 24u));
    let _e373 = local_31;
    output[_e373] = u32(i32(((bitcast<u32>(value_6) & 2147483647u) == 2139095040u)));
    local_32 = u32((base + 25u));
    let _e386 = local_32;
    output[_e386] = u32(i32(((bitcast<u32>(value_6) & 2147483647u) > 2139095040u)));
    local_33 = u32((base + 26u));
    let _e399 = local_33;
    output[_e399] = u32(i32(((bitcast<u32>(value_6) & 2147483648u) != 0u)));
    local_34 = u32((base + 27u));
    let _e414 = local_34;
    output[_e414] = u32(i32(((bitcast<u32>(f32(3i)) & 2147483647u) < 2139095040u)));
    local_35 = u32((base + 28u));
    let _e429 = local_35;
    output[_e429] = u32(i32(((bitcast<u32>(f32(0u)) & 2147483647u) == 2139095040u)));
    local_36 = u32((base + 29u));
    let _e444 = local_36;
    output[_e444] = u32(i32(((bitcast<u32>(f32(true)) & 2147483647u) > 2139095040u)));
    local_37 = u32((base + 30u));
    let _e460 = local_37;
    output[_e460] = u32(i32(((bitcast<u32>(f32(-(3i))) & 2147483648u) != 0u)));
    alias_cursor = 0i;
    let _e464 = alias_cursor;
    alias_cursor = (_e464 + 1i);
    local_39 = u32((index + u32(_e464)));
    let _e471 = local_39;
    let _e473 = input[_e471];
    local_38 = u32((base + 31u));
    let _e486 = local_38;
    output[_e486] = u32(i32(((bitcast<u32>(bitcast<f32>(_e473)) & 2147483648u) != 0u)));
    let _e488 = alias_cursor;
    local_40 = u32((base + 32u));
    let _e494 = local_40;
    output[_e494] = u32(_e488);
}
