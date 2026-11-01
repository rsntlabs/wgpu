@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn gen__naga_floorf(input_bits: u32) -> u32 {
    let _e5 = (input_bits & 2147483647u);
    let _e7 = ((input_bits & 2147483648u) != 0u);
    let _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e15 = (_e14 - 1u);
    let _e19 = (input_bits & ~(_e15));
    return select(select(select(select(_e19, (_e19 + _e14), (_e7 && ((input_bits & _e15) != 0u))), select(select(0u, 3212836864u, _e7), input_bits, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

fn floor_value(value_1: f32) -> f32 {
    let _e2 = gen__naga_floorf(bitcast<u32>(value_1));
    return bitcast<f32>(_e2);
}

fn floor_value_1(value_2: i32) -> f32 {
    let _e3 = gen__naga_floorf(bitcast<u32>(f32(value_2)));
    return bitcast<f32>(_e3);
}

fn floor_value_2(value_3: u32) -> f32 {
    let _e3 = gen__naga_floorf(bitcast<u32>(f32(value_3)));
    return bitcast<f32>(_e3);
}

fn floor_value_3(value_4: bool) -> f32 {
    let _e3 = gen__naga_floorf(bitcast<u32>(f32(value_4)));
    return bitcast<f32>(_e3);
}

fn floorf(value_5: bool) -> i32 {
    var local_42: i32;

    if value_5 {
        local_42 = 7i;
    } else {
        local_42 = 9i;
    }
    let _e6 = local_42;
    return _e6;
}

fn floorf_1(first: f32, second: f32) -> f32 {
    return (first + second);
}

@compute @workgroup_size(1, 1, 1)
fn floors() {
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
    var value: f32;
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
    var local_41: u32;

    let _e2 = gen__naga_floorf(bitcast<u32>(0f));
    local = u32(0i);
    let _e8 = local;
    out[_e8] = bitcast<u32>(bitcast<f32>(_e2));
    let _e14 = gen__naga_floorf(bitcast<u32>(-(0f)));
    local_1 = u32(1i);
    let _e20 = local_1;
    out[_e20] = bitcast<u32>(bitcast<f32>(_e14));
    let _e24 = gen__naga_floorf(bitcast<u32>(1.75f));
    local_2 = u32(2i);
    let _e30 = local_2;
    out[_e30] = bitcast<u32>(bitcast<f32>(_e24));
    let _e35 = gen__naga_floorf(bitcast<u32>(-(1.25f)));
    local_3 = u32(3i);
    let _e41 = local_3;
    out[_e41] = bitcast<u32>(bitcast<f32>(_e35));
    let _e44 = floor_value_1(3i);
    local_4 = u32(4i);
    let _e49 = local_4;
    out[_e49] = bitcast<u32>(_e44);
    let _e52 = floor_value_2(5u);
    local_5 = u32(5i);
    let _e57 = local_5;
    out[_e57] = bitcast<u32>(_e52);
    let _e60 = floor_value_3(true);
    local_6 = u32(6i);
    let _e65 = local_6;
    out[_e65] = bitcast<u32>(_e60);
    let _e68 = floor_value_3(false);
    local_7 = u32(7i);
    let _e73 = local_7;
    out[_e73] = bitcast<u32>(_e68);
    local_9 = 1u;
    let _e77 = local_9;
    let _e80 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e77)));
    local_8 = u32(8i);
    let _e86 = local_8;
    out[_e86] = bitcast<u32>(bitcast<f32>(_e80));
    local_11 = 2147483649u;
    let _e90 = local_11;
    let _e93 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e90)));
    local_10 = u32(9i);
    let _e99 = local_10;
    out[_e99] = bitcast<u32>(bitcast<f32>(_e93));
    local_13 = 8388607u;
    let _e103 = local_13;
    let _e106 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e103)));
    local_12 = u32(10i);
    let _e112 = local_12;
    out[_e112] = bitcast<u32>(bitcast<f32>(_e106));
    local_15 = 2155872255u;
    let _e116 = local_15;
    let _e119 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e116)));
    local_14 = u32(11i);
    let _e125 = local_14;
    out[_e125] = bitcast<u32>(bitcast<f32>(_e119));
    let _e129 = gen__naga_floorf(bitcast<u32>(340282350000000000000000000000000000000f));
    local_16 = u32(12i);
    let _e135 = local_16;
    out[_e135] = bitcast<u32>(bitcast<f32>(_e129));
    let _e140 = gen__naga_floorf(bitcast<u32>(-(340282350000000000000000000000000000000f)));
    local_17 = u32(13i);
    let _e146 = local_17;
    out[_e146] = bitcast<u32>(bitcast<f32>(_e140));
    local_19 = 2139095039u;
    let _e150 = local_19;
    let _e153 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e150)));
    local_18 = u32(14i);
    let _e159 = local_18;
    out[_e159] = bitcast<u32>(bitcast<f32>(_e153));
    local_21 = 4286578687u;
    let _e163 = local_21;
    let _e166 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e163)));
    local_20 = u32(15i);
    let _e172 = local_20;
    out[_e172] = bitcast<u32>(bitcast<f32>(_e166));
    local_23 = 2139095040u;
    let _e176 = local_23;
    let _e179 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e176)));
    local_22 = u32(16i);
    let _e185 = local_22;
    out[_e185] = bitcast<u32>(bitcast<f32>(_e179));
    local_25 = 4286578688u;
    let _e189 = local_25;
    let _e192 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e189)));
    local_24 = u32(17i);
    let _e198 = local_24;
    out[_e198] = bitcast<u32>(bitcast<f32>(_e192));
    local_27 = 2143363909u;
    let _e202 = local_27;
    let _e205 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e202)));
    local_26 = u32(18i);
    let _e211 = local_26;
    out[_e211] = bitcast<u32>(bitcast<f32>(_e205));
    local_29 = 2139095041u;
    let _e215 = local_29;
    let _e218 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e215)));
    local_28 = u32(19i);
    let _e224 = local_28;
    out[_e224] = bitcast<u32>(bitcast<f32>(_e218));
    value = 2.75f;
    let _e228 = value;
    value = (_e228 + f32(1i));
    let _e232 = floor_value(_e228);
    local_30 = u32(20i);
    let _e237 = local_30;
    out[_e237] = bitcast<u32>(_e232);
    let _e239 = value;
    local_31 = u32(21i);
    let _e244 = local_31;
    out[_e244] = bitcast<u32>(_e239);
    let _e247 = floorf(true);
    local_32 = u32(22i);
    let _e252 = local_32;
    out[_e252] = u32(_e247);
    let _e255 = floorf(false);
    local_33 = u32(23i);
    let _e260 = local_33;
    out[_e260] = u32(_e255);
    let _e264 = floorf_1(2f, 3f);
    local_34 = u32(24i);
    let _e269 = local_34;
    out[_e269] = bitcast<u32>(_e264);
    local_36 = 1258291199u;
    let _e273 = local_36;
    let _e276 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e273)));
    local_35 = u32(25i);
    let _e282 = local_35;
    out[_e282] = bitcast<u32>(bitcast<f32>(_e276));
    local_38 = 3405774847u;
    let _e286 = local_38;
    let _e289 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e286)));
    local_37 = u32(26i);
    let _e295 = local_37;
    out[_e295] = bitcast<u32>(bitcast<f32>(_e289));
    let _e298 = floor_value_2(4294967295u);
    local_39 = u32(27i);
    let _e303 = local_39;
    out[_e303] = bitcast<u32>(_e298);
    let _e309 = floor_value_1((-(2147483647i) - 1i));
    local_40 = u32(28i);
    let _e314 = local_40;
    out[_e314] = bitcast<u32>(_e309);
    let _e318 = gen__naga_floorf(bitcast<u32>(10000000000f));
    local_41 = u32(29i);
    let _e324 = local_41;
    out[_e324] = bitcast<u32>(bitcast<f32>(_e318));
}
