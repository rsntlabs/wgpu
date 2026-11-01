@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

fn gen__naga_ceilf(input_bits: u32) -> u32 {
    let _e5 = (input_bits & 2147483647u);
    let _e6 = (input_bits & 2147483648u);
    let _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e15 = (_e14 - 1u);
    let _e19 = (input_bits & ~(_e15));
    return select(select(select(select(_e19, (_e19 + _e14), ((_e6 == 0u) && ((input_bits & _e15) != 0u))), select(select(1065353216u, 2147483648u, (_e6 != 0u)), input_bits, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

fn rounded(value_1: f32) -> f32 {
    let _e2 = gen__naga_ceilf(bitcast<u32>(value_1));
    return bitcast<f32>(_e2);
}

fn ceilf(value_2: bool) -> i32 {
    var local_39: i32;

    if value_2 {
        local_39 = 7i;
    } else {
        local_39 = 9i;
    }
    let _e6 = local_39;
    return _e6;
}

fn ceilf_1(first: f32, second: f32) -> f32 {
    return (first + second);
}

@compute @workgroup_size(1, 1, 1)
fn ceilings() {
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
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var value: f32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;

    let _e2 = gen__naga_ceilf(bitcast<u32>(0f));
    local = u32(0i);
    let _e8 = local;
    output[_e8] = bitcast<u32>(bitcast<f32>(_e2));
    let _e14 = gen__naga_ceilf(bitcast<u32>(-(0f)));
    local_1 = u32(1i);
    let _e20 = local_1;
    output[_e20] = bitcast<u32>(bitcast<f32>(_e14));
    let _e24 = gen__naga_ceilf(bitcast<u32>(1.25f));
    local_2 = u32(2i);
    let _e30 = local_2;
    output[_e30] = bitcast<u32>(bitcast<f32>(_e24));
    let _e35 = gen__naga_ceilf(bitcast<u32>(-(1.75f)));
    local_3 = u32(3i);
    let _e41 = local_3;
    output[_e41] = bitcast<u32>(bitcast<f32>(_e35));
    let _e45 = rounded(f32(3i));
    local_4 = u32(4i);
    let _e50 = local_4;
    output[_e50] = bitcast<u32>(_e45);
    let _e54 = rounded(f32(5u));
    local_5 = u32(5i);
    let _e59 = local_5;
    output[_e59] = bitcast<u32>(_e54);
    let _e62 = ceilf(true);
    local_6 = u32(6i);
    let _e67 = local_6;
    output[_e67] = u32(_e62);
    let _e70 = ceilf(false);
    local_7 = u32(7i);
    let _e75 = local_7;
    output[_e75] = u32(_e70);
    let _e79 = rounded(f32(true));
    local_8 = u32(8i);
    let _e84 = local_8;
    output[_e84] = bitcast<u32>(_e79);
    let _e88 = rounded(f32(false));
    local_9 = u32(9i);
    let _e93 = local_9;
    output[_e93] = bitcast<u32>(_e88);
    local_11 = 1u;
    let _e97 = local_11;
    let _e100 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e97)));
    local_10 = u32(10i);
    let _e106 = local_10;
    output[_e106] = bitcast<u32>(bitcast<f32>(_e100));
    local_13 = 2147483649u;
    let _e110 = local_13;
    let _e113 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e110)));
    local_12 = u32(11i);
    let _e119 = local_12;
    output[_e119] = bitcast<u32>(bitcast<f32>(_e113));
    local_15 = 8388607u;
    let _e123 = local_15;
    let _e126 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e123)));
    local_14 = u32(12i);
    let _e132 = local_14;
    output[_e132] = bitcast<u32>(bitcast<f32>(_e126));
    local_17 = 2155872255u;
    let _e136 = local_17;
    let _e139 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e136)));
    local_16 = u32(13i);
    let _e145 = local_16;
    output[_e145] = bitcast<u32>(bitcast<f32>(_e139));
    let _e150 = gen__naga_ceilf(bitcast<u32>(-(0.25f)));
    local_18 = u32(14i);
    let _e156 = local_18;
    output[_e156] = bitcast<u32>(bitcast<f32>(_e150));
    local_20 = 1258291199u;
    let _e160 = local_20;
    let _e163 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e160)));
    local_19 = u32(15i);
    let _e169 = local_19;
    output[_e169] = bitcast<u32>(bitcast<f32>(_e163));
    local_22 = 3405774847u;
    let _e173 = local_22;
    let _e176 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e173)));
    local_21 = u32(16i);
    let _e182 = local_21;
    output[_e182] = bitcast<u32>(bitcast<f32>(_e176));
    let _e186 = gen__naga_ceilf(bitcast<u32>(340282350000000000000000000000000000000f));
    local_23 = u32(17i);
    let _e192 = local_23;
    output[_e192] = bitcast<u32>(bitcast<f32>(_e186));
    let _e197 = gen__naga_ceilf(bitcast<u32>(-(340282350000000000000000000000000000000f)));
    local_24 = u32(18i);
    let _e203 = local_24;
    output[_e203] = bitcast<u32>(bitcast<f32>(_e197));
    local_26 = 2139095040u;
    let _e207 = local_26;
    let _e210 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e207)));
    local_25 = u32(19i);
    let _e216 = local_25;
    output[_e216] = bitcast<u32>(bitcast<f32>(_e210));
    local_28 = 4286578688u;
    let _e220 = local_28;
    let _e223 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e220)));
    local_27 = u32(20i);
    let _e229 = local_27;
    output[_e229] = bitcast<u32>(bitcast<f32>(_e223));
    local_30 = 2143363909u;
    let _e233 = local_30;
    let _e236 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e233)));
    local_29 = u32(21i);
    let _e242 = local_29;
    output[_e242] = bitcast<u32>(bitcast<f32>(_e236));
    local_32 = 4286578689u;
    let _e246 = local_32;
    let _e249 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e246)));
    local_31 = u32(22i);
    let _e255 = local_31;
    output[_e255] = bitcast<u32>(bitcast<f32>(_e249));
    value = 2.25f;
    let _e259 = value;
    value = (_e259 + f32(1i));
    let _e263 = rounded(_e259);
    local_33 = u32(23i);
    let _e268 = local_33;
    output[_e268] = bitcast<u32>(_e263);
    let _e270 = value;
    local_34 = u32(24i);
    let _e275 = local_34;
    output[_e275] = bitcast<u32>(_e270);
    let _e279 = ceilf_1(2f, 3f);
    local_35 = u32(25i);
    let _e284 = local_35;
    output[_e284] = bitcast<u32>(_e279);
    let _e288 = rounded(f32(4294967295u));
    local_36 = u32(26i);
    let _e293 = local_36;
    output[_e293] = bitcast<u32>(_e288);
    let _e300 = rounded(f32((-(2147483647i) - 1i)));
    local_37 = u32(27i);
    let _e305 = local_37;
    output[_e305] = bitcast<u32>(_e300);
    let _e309 = gen__naga_ceilf(bitcast<u32>(10000000000f));
    local_38 = u32(28i);
    let _e315 = local_38;
    output[_e315] = bitcast<u32>(bitcast<f32>(_e309));
}
