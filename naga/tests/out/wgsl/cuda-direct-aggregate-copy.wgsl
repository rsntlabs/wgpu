struct Packet_cuda_record_0_ {
    tag: u32,
    samples: array<i32, 2>,
    pair: vec2<i32>,
}

struct uint3_ {
    x: u32,
    y: u32,
    z: u32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

@compute @workgroup_size(1, 1, 1)
fn direct_aggregate_copy() {
    var counter: u32;
    var original: Packet_cuda_record_0_;
    var copied: Packet_cuda_record_0_;
    var following: Packet_cuda_record_0_;
    var frozen: Packet_cuda_record_0_;
    var called: Packet_cuda_record_0_;
    var local: Packet_cuda_record_0_;
    var called_copy: Packet_cuda_record_0_;
    var point: vec2<i32>;
    var point_copy: vec2<i32>;
    var changed: vec2<i32>;
    var frozen_point: vec2<i32>;
    var from_call: vec2<i32>;
    var local_1: vec2<i32>;
    var triple: uint3_;
    var triple_copy: uint3_;
    var seed: i32;
    var result: Packet_cuda_record_0_;
    var seed_1: i32;

    counter = 0u;
    original.tag = 3u;
    original.samples[0] = 5i;
    original.samples[1] = 7i;
    original.pair.x = 11i;
    original.pair.y = 13i;
    let _e15 = original;
    copied = _e15;
    original.samples[0i] = 17i;
    let _e21 = original;
    following = _e21;
    let _e23 = copied;
    frozen = _e23;
    original.pair.x = 19i;
    original.samples[1i] = 23i;
    original.tag = 29u;
    let _e37 = copied.samples[1i];
    copied.samples[1i] = (_e37 + 1i);
    seed = i32();
    result = Packet_cuda_record_0_();
    seed = 31i;
    let _e46 = counter;
    counter = (_e46 + u32(1i));
    let _e50 = counter;
    result.tag = _e50;
    let _e54 = seed;
    result.samples[0] = _e54;
    let _e57 = seed;
    result.samples[1] = (_e57 + 1i);
    let _e61 = seed;
    result.pair.x = (_e61 + 2i);
    let _e66 = seed;
    result.pair.y = (_e66 + 3i);
    let _e69 = result;
    local = _e69;
    let _e71 = local;
    called = _e71;
    let _e73 = called;
    called_copy = _e73;
    called.samples[0i] = 41i;
    point.x = 43i;
    point.y = 47i;
    let _e84 = point;
    point_copy = _e84;
    point.x = 53i;
    let _e88 = point;
    changed = _e88;
    let _e90 = point_copy;
    frozen_point = _e90;
    point_copy.y = 59i;
    seed_1 = i32();
    seed_1 = 61i;
    let _e98 = counter;
    counter = (_e98 + u32(1i));
    let _e102 = seed_1;
    let _e103 = seed_1;
    local_1 = vec2<i32>(_e102, (_e103 + 1i));
    let _e108 = local_1;
    from_call = _e108;
    triple.x = 67u;
    triple.y = 71u;
    triple.z = 73u;
    let _e117 = triple;
    triple_copy = _e117;
    triple.y = 79u;
    let _e122 = copied.tag;
    output[u32(0i)] = _e122;
    let _e130 = copied.samples[0i];
    output[u32(1i)] = u32(_e130);
    let _e138 = copied.samples[1i];
    output[u32(2i)] = u32(_e138);
    let _e146 = frozen.samples[1i];
    output[u32(3i)] = u32(_e146);
    let _e153 = copied.pair.x;
    output[u32(4i)] = u32(_e153);
    let _e160 = frozen.pair.y;
    output[u32(5i)] = u32(_e160);
    let _e168 = following.samples[0i];
    output[u32(6i)] = u32(_e168);
    let _e175 = following.pair.x;
    output[u32(7i)] = u32(_e175);
    let _e183 = original.samples[1i];
    output[u32(8i)] = u32(_e183);
    let _e190 = original.pair.x;
    output[u32(9i)] = u32(_e190);
    let _e196 = called.tag;
    output[u32(10i)] = _e196;
    let _e203 = called_copy.samples[0i];
    output[u32(11i)] = u32(_e203);
    let _e211 = called.samples[0i];
    output[u32(12i)] = u32(_e211);
    let _e218 = called_copy.pair.y;
    output[u32(13i)] = u32(_e218);
    let _e224 = point_copy.x;
    output[u32(14i)] = u32(_e224);
    let _e230 = point_copy.y;
    output[u32(15i)] = u32(_e230);
    let _e236 = changed.x;
    output[u32(16i)] = u32(_e236);
    let _e242 = frozen_point.y;
    output[u32(17i)] = u32(_e242);
    let _e248 = from_call.x;
    output[u32(18i)] = u32(_e248);
    let _e254 = from_call.y;
    output[u32(19i)] = u32(_e254);
    let _e259 = counter;
    output[u32(20i)] = _e259;
    let _e264 = triple_copy.x;
    output[u32(21i)] = _e264;
    let _e269 = triple_copy.y;
    output[u32(22i)] = _e269;
    let _e274 = triple.y;
    output[u32(23i)] = _e274;
}
