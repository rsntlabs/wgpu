@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn from_bits(value_1: u32) -> f32 {
    return bitcast<f32>(value_1);
}

fn _float_as_int(first: i32, second: i32) -> i32 {
    return (first + second);
}

@compute @workgroup_size(1, 1, 1)
fn bitcasts() {
    var local: i32;
    var local_1: i32;
    var local_2: i32;
    var local_3: i32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var value: f32;
    var signed_bits: i32;
    var unsigned_bits: u32;
    var local_8: i32;
    var local_9: u32;
    var local_10: u32;

    out[u32(0i)] = u32(bitcast<i32>(f32(true)));
    out[u32(1i)] = u32(bitcast<i32>(f32(3i)));
    out[u32(2i)] = u32(bitcast<i32>(f32(5u)));
    out[u32(3i)] = u32(bitcast<i32>(2.75f));
    out[u32(4i)] = bitcast<u32>(f32(true));
    out[u32(5i)] = bitcast<u32>(f32(3i));
    out[u32(6i)] = bitcast<u32>(f32(5u));
    out[u32(7i)] = bitcast<u32>(2.75f);
    local = i32(true);
    let _e54 = local;
    out[u32(8i)] = bitcast<u32>(bitcast<f32>(_e54));
    local_1 = 3i;
    let _e62 = local_1;
    out[u32(9i)] = bitcast<u32>(bitcast<f32>(_e62));
    local_2 = i32(5u);
    let _e71 = local_2;
    out[u32(10i)] = bitcast<u32>(bitcast<f32>(_e71));
    local_3 = i32(2.75f);
    let _e80 = local_3;
    out[u32(11i)] = bitcast<u32>(bitcast<f32>(_e80));
    local_4 = u32(true);
    let _e89 = local_4;
    out[u32(12i)] = bitcast<u32>(bitcast<f32>(_e89));
    local_5 = u32(3i);
    let _e98 = local_5;
    out[u32(13i)] = bitcast<u32>(bitcast<f32>(_e98));
    local_6 = 5u;
    let _e106 = local_6;
    out[u32(14i)] = bitcast<u32>(bitcast<f32>(_e106));
    local_7 = u32(2.75f);
    let _e115 = local_7;
    out[u32(15i)] = bitcast<u32>(bitcast<f32>(_e115));
    value = 1.5f;
    let _e123 = value;
    value = (_e123 + f32(1i));
    out[u32(16i)] = u32(bitcast<i32>(_e123));
    let _e132 = value;
    out[u32(17i)] = bitcast<u32>(_e132);
    let _e137 = value;
    value = (_e137 + f32(1i));
    out[u32(18i)] = bitcast<u32>(_e137);
    let _e145 = value;
    out[u32(19i)] = bitcast<u32>(_e145);
    signed_bits = 1065353216i;
    let _e152 = signed_bits;
    signed_bits = (_e152 + 1i);
    out[u32(20i)] = bitcast<u32>(bitcast<f32>(_e152));
    let _e160 = signed_bits;
    out[u32(21i)] = u32(_e160);
    unsigned_bits = 1073741824u;
    let _e167 = unsigned_bits;
    unsigned_bits = (_e167 + u32(1i));
    out[u32(22i)] = bitcast<u32>(bitcast<f32>(_e167));
    let _e176 = unsigned_bits;
    out[u32(23i)] = _e176;
    let _e182 = _float_as_int(3i, 4i);
    out[u32(24i)] = u32(_e182);
    let copied = from_bits(3212836864u);
    out[u32(25i)] = bitcast<u32>(copied);
    local_8 = 2139095040i;
    let _e195 = local_8;
    out[u32(26i)] = bitcast<u32>(bitcast<f32>(_e195));
    local_9 = 2143363909u;
    let _e203 = local_9;
    out[u32(27i)] = bitcast<u32>(bitcast<f32>(_e203));
    local_10 = u32(1065353200f);
    let _e212 = local_10;
    out[u32(28i)] = bitcast<u32>(bitcast<f32>(_e212));
    out[u32(29i)] = u32(bitcast<i32>(f32(1u)));
}
