const HexScale: f32 = 0.75f;

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

fn identity(value_1: f32) -> f32 {
    return value_1;
}

@compute @workgroup_size(1, 1, 1)
fn hex_float_literals() {
    var counter: u32;
    var value: f32;

    counter = 0u;
    output[u32(0i)] = bitcast<u32>(0f);
    output[u32(1i)] = bitcast<u32>(-(0f));
    output[u32(2i)] = bitcast<u32>(1f);
    output[u32(3i)] = bitcast<u32>(2f);
    output[u32(4i)] = bitcast<u32>(1f);
    output[u32(5i)] = bitcast<u32>(0.5f);
    output[u32(6i)] = bitcast<u32>(3f);
    output[u32(7i)] = bitcast<u32>(-(5f));
    output[u32(8i)] = bitcast<u32>(0.000000000000000000000000000000000000011754944f);
    output[u32(9i)] = bitcast<u32>(0.000000000000000000000000000000000000000000001f);
    output[u32(10i)] = bitcast<u32>(0.000000000000000000000000000000000000011754942f);
    output[u32(11i)] = bitcast<u32>(0.000000000000000000000000000000000000011754944f);
    output[u32(12i)] = bitcast<u32>(0f);
    output[u32(13i)] = bitcast<u32>(-(0f));
    output[u32(14i)] = bitcast<u32>(0.000000000000000000000000000000000000000000001f);
    output[u32(15i)] = bitcast<u32>(0f);
    output[u32(16i)] = bitcast<u32>(0.000000000000000000000000000000000000000000003f);
    output[u32(17i)] = bitcast<u32>(0.000000000000000000000000000000000000000000003f);
    output[u32(18i)] = bitcast<u32>(0.000000000000000000000000000000000000000000006f);
    output[u32(19i)] = bitcast<u32>(1f);
    output[u32(20i)] = bitcast<u32>(1.0000002f);
    output[u32(21i)] = bitcast<u32>(1.0000001f);
    output[u32(22i)] = bitcast<u32>(1f);
    output[u32(23i)] = bitcast<u32>(340282350000000000000000000000000000000f);
    output[u32(24i)] = bitcast<u32>(-(340282350000000000000000000000000000000f));
    output[u32(25i)] = bitcast<u32>(340282330000000000000000000000000000000f);
    output[u32(26i)] = bitcast<u32>(340282350000000000000000000000000000000f);
    output[u32(27i)] = bitcast<u32>(0.000000000000000000000000000000000000000000001f);
    output[u32(28i)] = bitcast<u32>(-(0.000000000000000000000000000000000000000000001f));
    output[u32(29i)] = bitcast<u32>(0f);
    output[u32(30i)] = bitcast<u32>(72.8125f);
    output[u32(31i)] = bitcast<u32>(0.25f);
    output[u32(32i)] = bitcast<u32>(6f);
    output[u32(33i)] = bitcast<u32>(4f);
    output[u32(34i)] = bitcast<u32>(HexScale);
    let _e184 = identity(9f);
    output[u32(35i)] = bitcast<u32>(_e184);
    value = f32();
    value = 3f;
    let _e193 = counter;
    counter = (_e193 + u32(1i));
    let _e197 = value;
    output[u32(36i)] = bitcast<u32>(_e197);
    output[u32(37i)] = bitcast<u32>((0.25f + 0.5f));
    output[u32(38i)] = bitcast<u32>(0f);
    let _e214 = counter;
    output[u32(39i)] = _e214;
}
