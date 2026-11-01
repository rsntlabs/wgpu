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
    var local_12: i32;

    if value_5 {
        local_12 = 7i;
    } else {
        local_12 = 9i;
    }
    let _e6 = local_12;
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
    var value: f32;
    var local_10: u32;
    var local_11: u32;

    let _e2 = gen__naga_floorf(bitcast<u32>(0f));
    out[u32(0i)] = bitcast<u32>(bitcast<f32>(_e2));
    let _e12 = gen__naga_floorf(bitcast<u32>(-(0f)));
    out[u32(1i)] = bitcast<u32>(bitcast<f32>(_e12));
    let _e20 = gen__naga_floorf(bitcast<u32>(1.75f));
    out[u32(2i)] = bitcast<u32>(bitcast<f32>(_e20));
    let _e29 = gen__naga_floorf(bitcast<u32>(-(1.25f)));
    out[u32(3i)] = bitcast<u32>(bitcast<f32>(_e29));
    let _e36 = floor_value_1(3i);
    out[u32(4i)] = bitcast<u32>(_e36);
    let _e42 = floor_value_2(5u);
    out[u32(5i)] = bitcast<u32>(_e42);
    let _e48 = floor_value_3(true);
    out[u32(6i)] = bitcast<u32>(_e48);
    let _e54 = floor_value_3(false);
    out[u32(7i)] = bitcast<u32>(_e54);
    local = 1u;
    let _e61 = local;
    let _e64 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e61)));
    out[u32(8i)] = bitcast<u32>(bitcast<f32>(_e64));
    local_1 = 2147483649u;
    let _e72 = local_1;
    let _e75 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e72)));
    out[u32(9i)] = bitcast<u32>(bitcast<f32>(_e75));
    local_2 = 8388607u;
    let _e83 = local_2;
    let _e86 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e83)));
    out[u32(10i)] = bitcast<u32>(bitcast<f32>(_e86));
    local_3 = 2155872255u;
    let _e94 = local_3;
    let _e97 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e94)));
    out[u32(11i)] = bitcast<u32>(bitcast<f32>(_e97));
    let _e105 = gen__naga_floorf(bitcast<u32>(340282350000000000000000000000000000000f));
    out[u32(12i)] = bitcast<u32>(bitcast<f32>(_e105));
    let _e114 = gen__naga_floorf(bitcast<u32>(-(340282350000000000000000000000000000000f)));
    out[u32(13i)] = bitcast<u32>(bitcast<f32>(_e114));
    local_4 = 2139095039u;
    let _e122 = local_4;
    let _e125 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e122)));
    out[u32(14i)] = bitcast<u32>(bitcast<f32>(_e125));
    local_5 = 4286578687u;
    let _e133 = local_5;
    let _e136 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e133)));
    out[u32(15i)] = bitcast<u32>(bitcast<f32>(_e136));
    local_6 = 2139095040u;
    let _e144 = local_6;
    let _e147 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e144)));
    out[u32(16i)] = bitcast<u32>(bitcast<f32>(_e147));
    local_7 = 4286578688u;
    let _e155 = local_7;
    let _e158 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e155)));
    out[u32(17i)] = bitcast<u32>(bitcast<f32>(_e158));
    local_8 = 2143363909u;
    let _e166 = local_8;
    let _e169 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e166)));
    out[u32(18i)] = bitcast<u32>(bitcast<f32>(_e169));
    local_9 = 2139095041u;
    let _e177 = local_9;
    let _e180 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e177)));
    out[u32(19i)] = bitcast<u32>(bitcast<f32>(_e180));
    value = 2.75f;
    let _e188 = value;
    value = (_e188 + f32(1i));
    let _e192 = floor_value(_e188);
    out[u32(20i)] = bitcast<u32>(_e192);
    let _e197 = value;
    out[u32(21i)] = bitcast<u32>(_e197);
    let _e203 = floorf(true);
    out[u32(22i)] = u32(_e203);
    let _e209 = floorf(false);
    out[u32(23i)] = u32(_e209);
    let _e216 = floorf_1(2f, 3f);
    out[u32(24i)] = bitcast<u32>(_e216);
    local_10 = 1258291199u;
    let _e223 = local_10;
    let _e226 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e223)));
    out[u32(25i)] = bitcast<u32>(bitcast<f32>(_e226));
    local_11 = 3405774847u;
    let _e234 = local_11;
    let _e237 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(_e234)));
    out[u32(26i)] = bitcast<u32>(bitcast<f32>(_e237));
    let _e244 = floor_value_2(4294967295u);
    out[u32(27i)] = bitcast<u32>(_e244);
    let _e253 = floor_value_1((-(2147483647i) - 1i));
    out[u32(28i)] = bitcast<u32>(_e253);
    let _e260 = gen__naga_floorf(bitcast<u32>(10000000000f));
    out[u32(29i)] = bitcast<u32>(bitcast<f32>(_e260));
}
