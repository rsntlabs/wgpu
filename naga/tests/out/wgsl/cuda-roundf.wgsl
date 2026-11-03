@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

fn gen__naga_roundf(input_bits: u32) -> u32 {
    let _e5 = (input_bits & 2147483647u);
    let _e6 = (input_bits & 2147483648u);
    let _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e14 = (_e13 - 1u);
    let _e15 = (input_bits & _e14);
    let _e18 = (input_bits & ~(_e14));
    return select(select(select(select(_e18, (_e18 + _e13), ((_e15 >= (_e13 >> 1u)) && (_e15 != 0u))), select(select(_e6, (_e6 | 1065353216u), (_e5 >= 1056964608u)), input_bits, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

fn rounded(value_1: f32) -> f32 {
    let _e2 = gen__naga_roundf(bitcast<u32>(value_1));
    return bitcast<f32>(_e2);
}

fn roundf(value_2: bool) -> i32 {
    var local_18: i32;

    if value_2 {
        local_18 = 7i;
    } else {
        local_18 = 9i;
    }
    let _e6 = local_18;
    return _e6;
}

fn roundf_1(first: f32, second: f32) -> f32 {
    return (first + second);
}

@compute @workgroup_size(1, 1, 1)
fn rounds() {
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
    var value: f32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;

    let _e2 = gen__naga_roundf(bitcast<u32>(0f));
    output[u32(0i)] = bitcast<u32>(bitcast<f32>(_e2));
    let _e12 = gen__naga_roundf(bitcast<u32>(-(0f)));
    output[u32(1i)] = bitcast<u32>(bitcast<f32>(_e12));
    let _e20 = gen__naga_roundf(bitcast<u32>(1.25f));
    output[u32(2i)] = bitcast<u32>(bitcast<f32>(_e20));
    let _e29 = gen__naga_roundf(bitcast<u32>(-(1.75f)));
    output[u32(3i)] = bitcast<u32>(bitcast<f32>(_e29));
    let _e37 = rounded(f32(3i));
    output[u32(4i)] = bitcast<u32>(_e37);
    let _e44 = rounded(f32(5u));
    output[u32(5i)] = bitcast<u32>(_e44);
    let _e50 = roundf(true);
    output[u32(6i)] = u32(_e50);
    let _e56 = roundf(false);
    output[u32(7i)] = u32(_e56);
    let _e63 = rounded(f32(true));
    output[u32(8i)] = bitcast<u32>(_e63);
    let _e70 = rounded(f32(false));
    output[u32(9i)] = bitcast<u32>(_e70);
    local = 1u;
    let _e77 = local;
    let _e80 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e77)));
    output[u32(10i)] = bitcast<u32>(bitcast<f32>(_e80));
    local_1 = 2147483649u;
    let _e88 = local_1;
    let _e91 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e88)));
    output[u32(11i)] = bitcast<u32>(bitcast<f32>(_e91));
    local_2 = 8388607u;
    let _e99 = local_2;
    let _e102 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e99)));
    output[u32(12i)] = bitcast<u32>(bitcast<f32>(_e102));
    local_3 = 2155872255u;
    let _e110 = local_3;
    let _e113 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e110)));
    output[u32(13i)] = bitcast<u32>(bitcast<f32>(_e113));
    let _e122 = gen__naga_roundf(bitcast<u32>(-(0.25f)));
    output[u32(14i)] = bitcast<u32>(bitcast<f32>(_e122));
    local_4 = 1258291199u;
    let _e130 = local_4;
    let _e133 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e130)));
    output[u32(15i)] = bitcast<u32>(bitcast<f32>(_e133));
    local_5 = 3405774847u;
    let _e141 = local_5;
    let _e144 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e141)));
    output[u32(16i)] = bitcast<u32>(bitcast<f32>(_e144));
    let _e152 = gen__naga_roundf(bitcast<u32>(340282350000000000000000000000000000000f));
    output[u32(17i)] = bitcast<u32>(bitcast<f32>(_e152));
    let _e161 = gen__naga_roundf(bitcast<u32>(-(340282350000000000000000000000000000000f)));
    output[u32(18i)] = bitcast<u32>(bitcast<f32>(_e161));
    local_6 = 2139095040u;
    let _e169 = local_6;
    let _e172 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e169)));
    output[u32(19i)] = bitcast<u32>(bitcast<f32>(_e172));
    local_7 = 4286578688u;
    let _e180 = local_7;
    let _e183 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e180)));
    output[u32(20i)] = bitcast<u32>(bitcast<f32>(_e183));
    local_8 = 2143363909u;
    let _e191 = local_8;
    let _e194 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e191)));
    output[u32(21i)] = bitcast<u32>(bitcast<f32>(_e194));
    local_9 = 4286578689u;
    let _e202 = local_9;
    let _e205 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e202)));
    output[u32(22i)] = bitcast<u32>(bitcast<f32>(_e205));
    value = 2.25f;
    let _e213 = value;
    value = (_e213 + f32(1i));
    let _e217 = rounded(_e213);
    output[u32(23i)] = bitcast<u32>(_e217);
    let _e222 = value;
    output[u32(24i)] = bitcast<u32>(_e222);
    let _e229 = roundf_1(2f, 3f);
    output[u32(25i)] = bitcast<u32>(_e229);
    let _e236 = rounded(f32(4294967295u));
    output[u32(26i)] = bitcast<u32>(_e236);
    let _e246 = rounded(f32((-(2147483647i) - 1i)));
    output[u32(27i)] = bitcast<u32>(_e246);
    let _e253 = gen__naga_roundf(bitcast<u32>(10000000000f));
    output[u32(28i)] = bitcast<u32>(bitcast<f32>(_e253));
    let _e261 = gen__naga_roundf(bitcast<u32>(1.5f));
    output[u32(29i)] = bitcast<u32>(bitcast<f32>(_e261));
    let _e270 = gen__naga_roundf(bitcast<u32>(-(1.5f)));
    output[u32(30i)] = bitcast<u32>(bitcast<f32>(_e270));
    let _e278 = gen__naga_roundf(bitcast<u32>(2.5f));
    output[u32(31i)] = bitcast<u32>(bitcast<f32>(_e278));
    let _e287 = gen__naga_roundf(bitcast<u32>(-(2.5f)));
    output[u32(32i)] = bitcast<u32>(bitcast<f32>(_e287));
    local_10 = 1056964607u;
    let _e295 = local_10;
    let _e298 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e295)));
    output[u32(33i)] = bitcast<u32>(bitcast<f32>(_e298));
    local_11 = 1056964609u;
    let _e306 = local_11;
    let _e309 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e306)));
    output[u32(34i)] = bitcast<u32>(bitcast<f32>(_e309));
    local_12 = 3204448255u;
    let _e317 = local_12;
    let _e320 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e317)));
    output[u32(35i)] = bitcast<u32>(bitcast<f32>(_e320));
    local_13 = 3204448257u;
    let _e328 = local_13;
    let _e331 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e328)));
    output[u32(36i)] = bitcast<u32>(bitcast<f32>(_e331));
    local_14 = 1249902593u;
    let _e339 = local_14;
    let _e342 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e339)));
    output[u32(37i)] = bitcast<u32>(bitcast<f32>(_e342));
    local_15 = 3397386241u;
    let _e350 = local_15;
    let _e353 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e350)));
    output[u32(38i)] = bitcast<u32>(bitcast<f32>(_e353));
    local_16 = 1258291197u;
    let _e361 = local_16;
    let _e364 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e361)));
    output[u32(39i)] = bitcast<u32>(bitcast<f32>(_e364));
    local_17 = 3405774845u;
    let _e372 = local_17;
    let _e375 = gen__naga_roundf(bitcast<u32>(bitcast<f32>(_e372)));
    output[u32(40i)] = bitcast<u32>(bitcast<f32>(_e375));
}
