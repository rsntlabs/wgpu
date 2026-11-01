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
    var local_10: i32;

    if value_2 {
        local_10 = 7i;
    } else {
        local_10 = 9i;
    }
    let _e6 = local_10;
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
    var value: f32;

    let _e2 = gen__naga_ceilf(bitcast<u32>(0f));
    output[u32(0i)] = bitcast<u32>(bitcast<f32>(_e2));
    let _e12 = gen__naga_ceilf(bitcast<u32>(-(0f)));
    output[u32(1i)] = bitcast<u32>(bitcast<f32>(_e12));
    let _e20 = gen__naga_ceilf(bitcast<u32>(1.25f));
    output[u32(2i)] = bitcast<u32>(bitcast<f32>(_e20));
    let _e29 = gen__naga_ceilf(bitcast<u32>(-(1.75f)));
    output[u32(3i)] = bitcast<u32>(bitcast<f32>(_e29));
    let _e37 = rounded(f32(3i));
    output[u32(4i)] = bitcast<u32>(_e37);
    let _e44 = rounded(f32(5u));
    output[u32(5i)] = bitcast<u32>(_e44);
    let _e50 = ceilf(true);
    output[u32(6i)] = u32(_e50);
    let _e56 = ceilf(false);
    output[u32(7i)] = u32(_e56);
    let _e63 = rounded(f32(true));
    output[u32(8i)] = bitcast<u32>(_e63);
    let _e70 = rounded(f32(false));
    output[u32(9i)] = bitcast<u32>(_e70);
    local = 1u;
    let _e77 = local;
    let _e80 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e77)));
    output[u32(10i)] = bitcast<u32>(bitcast<f32>(_e80));
    local_1 = 2147483649u;
    let _e88 = local_1;
    let _e91 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e88)));
    output[u32(11i)] = bitcast<u32>(bitcast<f32>(_e91));
    local_2 = 8388607u;
    let _e99 = local_2;
    let _e102 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e99)));
    output[u32(12i)] = bitcast<u32>(bitcast<f32>(_e102));
    local_3 = 2155872255u;
    let _e110 = local_3;
    let _e113 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e110)));
    output[u32(13i)] = bitcast<u32>(bitcast<f32>(_e113));
    let _e122 = gen__naga_ceilf(bitcast<u32>(-(0.25f)));
    output[u32(14i)] = bitcast<u32>(bitcast<f32>(_e122));
    local_4 = 1258291199u;
    let _e130 = local_4;
    let _e133 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e130)));
    output[u32(15i)] = bitcast<u32>(bitcast<f32>(_e133));
    local_5 = 3405774847u;
    let _e141 = local_5;
    let _e144 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e141)));
    output[u32(16i)] = bitcast<u32>(bitcast<f32>(_e144));
    let _e152 = gen__naga_ceilf(bitcast<u32>(340282350000000000000000000000000000000f));
    output[u32(17i)] = bitcast<u32>(bitcast<f32>(_e152));
    let _e161 = gen__naga_ceilf(bitcast<u32>(-(340282350000000000000000000000000000000f)));
    output[u32(18i)] = bitcast<u32>(bitcast<f32>(_e161));
    local_6 = 2139095040u;
    let _e169 = local_6;
    let _e172 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e169)));
    output[u32(19i)] = bitcast<u32>(bitcast<f32>(_e172));
    local_7 = 4286578688u;
    let _e180 = local_7;
    let _e183 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e180)));
    output[u32(20i)] = bitcast<u32>(bitcast<f32>(_e183));
    local_8 = 2143363909u;
    let _e191 = local_8;
    let _e194 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e191)));
    output[u32(21i)] = bitcast<u32>(bitcast<f32>(_e194));
    local_9 = 4286578689u;
    let _e202 = local_9;
    let _e205 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(_e202)));
    output[u32(22i)] = bitcast<u32>(bitcast<f32>(_e205));
    value = 2.25f;
    let _e213 = value;
    value = (_e213 + f32(1i));
    let _e217 = rounded(_e213);
    output[u32(23i)] = bitcast<u32>(_e217);
    let _e222 = value;
    output[u32(24i)] = bitcast<u32>(_e222);
    let _e229 = ceilf_1(2f, 3f);
    output[u32(25i)] = bitcast<u32>(_e229);
    let _e236 = rounded(f32(4294967295u));
    output[u32(26i)] = bitcast<u32>(_e236);
    let _e246 = rounded(f32((-(2147483647i) - 1i)));
    output[u32(27i)] = bitcast<u32>(_e246);
    let _e253 = gen__naga_ceilf(bitcast<u32>(10000000000f));
    output[u32(28i)] = bitcast<u32>(bitcast<f32>(_e253));
}
