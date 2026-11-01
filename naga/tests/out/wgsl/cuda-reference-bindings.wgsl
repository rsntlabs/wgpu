struct Record_cuda_record_0_ {
    value: i32,
    samples: array<i32, 2>,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn adjust(value_1: i32) -> i32 {
    var value_2: i32;

    value_2 = value_1;
    let _e2 = value_2;
    value_2 = (_e2 + 2i);
    let _e5 = value_2;
    return _e5;
}

@compute @workgroup_size(1, 1, 1)
fn reference_bindings() {
    var value: i32;
    var left: i32;
    var right: i32;
    var source: i32;
    var local: f32;
    var uninitialized: i32;
    var original: i32;
    var replacement: i32;
    var local_1: i32;
    var local_2: f32;
    var local_3: i32;
    var updated: i32;
    var comma_left: i32;
    var comma_right: i32;
    var counter: i32;
    var enabled: bool;
    var bits: u32;
    var floating: f32;
    var record: Record_cuda_record_0_;

    value = 1i;
    value = 5i;
    let _e3 = value;
    value = (_e3 + 2i);
    let _e6 = value;
    let _e7 = value;
    value = (_e7 + _e6);
    let _e9 = value;
    out[u32(0i)] = u32(_e9);
    let _e15 = value;
    out[u32(1i)] = u32(_e15);
    let _e20 = value;
    out[u32(2i)] = u32(_e20);
    left = 1i;
    right = 2i;
    left = 5i;
    let _e30 = right;
    right = (_e30 + 2i);
    let _e33 = right;
    let _e34 = left;
    left = (_e34 + _e33);
    let _e36 = left;
    out[u32(3i)] = u32(_e36);
    let _e41 = right;
    out[u32(4i)] = u32(_e41);
    source = 3i;
    let _e48 = source;
    local = f32(_e48);
    source = 9i;
    let _e52 = local;
    out[u32(5i)] = u32(_e52);
    let _e57 = source;
    out[u32(6i)] = u32(_e57);
    let _e62 = source;
    out[u32(7i)] = u32(_e62);
    uninitialized = 7i;
    let _e71 = uninitialized;
    out[u32(8i)] = u32(_e71);
    original = 2i;
    replacement = 8i;
    let _e78 = replacement;
    original = _e78;
    replacement = 10i;
    let _e80 = original;
    out[u32(9i)] = u32(_e80);
    let _e85 = original;
    out[u32(10i)] = u32(_e85);
    let _e90 = replacement;
    out[u32(11i)] = u32(_e90);
    local_1 = i32();
    local_2 = 1.5f;
    local_3 = i32(3.75f);
    let _e102 = local_1;
    out[u32(12i)] = u32(_e102);
    let _e107 = local_2;
    out[u32(13i)] = bitcast<u32>(_e107);
    let _e112 = local_3;
    out[u32(14i)] = u32(_e112);
    updated = 1i;
    let _e119 = updated;
    updated = (_e119 + 1i);
    let _e122 = updated;
    updated = (_e122 + 3i);
    let _e125 = updated;
    out[u32(15i)] = u32(_e125);
    updated = 9i;
    let _e131 = updated;
    updated = (_e131 + 2i);
    let _e134 = updated;
    out[u32(16i)] = u32(_e134);
    comma_left = 3i;
    comma_right = 4i;
    counter = 0i;
    let _e145 = counter;
    counter = (_e145 + 1i);
    let _e148 = comma_right;
    comma_right = (_e148 + 5i);
    let _e151 = comma_left;
    out[u32(17i)] = u32(_e151);
    let _e156 = comma_right;
    out[u32(18i)] = u32(_e156);
    let _e161 = counter;
    out[u32(19i)] = u32(_e161);
    enabled = false;
    enabled = true;
    let _e169 = enabled;
    out[u32(20i)] = u32(_e169);
    bits = 4294901760u;
    let _e176 = bits;
    bits = (_e176 + 3u);
    let _e179 = bits;
    out[u32(21i)] = _e179;
    floating = 2f;
    let _e185 = floating;
    floating = (_e185 * 0.5f);
    let _e188 = floating;
    out[u32(22i)] = bitcast<u32>(_e188);
    record.value = 10i;
    record.samples[0] = 2i;
    record.samples[1] = 3i;
    let _e202 = record.value;
    let _e203 = adjust(_e202);
    record.value = _e203;
    let _e206 = record.value;
    out[u32(23i)] = u32(_e206);
}
