@group(0) @binding(0)
var<storage, read_write> out: array<i32>;

fn min_(first_1: i32, second_1: i32, third: i32) -> i32 {
    return (((first_1 + second_1) + third) + 100i);
}

fn bounded(value_1: i32) -> i32 {
    return min(max(value_1, -(2i)), 2i);
}

@compute @workgroup_size(1, 1, 1)
fn integer_minmax() {
    var first: i32;
    var second: i32;
    var value: i32;

    let seed = out[u32(0i)];
    out[u32(0i)] = min(seed, -(7i));
    out[u32(1i)] = max(seed, -(7i));
    out[u32(2i)] = i32(min(3u, 9u));
    out[u32(3i)] = i32(max(3u, 9u));
    out[u32(4i)] = i32((min(u32(-(1i)), 2u) == 2u));
    out[u32(5i)] = i32((max(u32(-(1i)), 2u) == 4294967295u));
    out[u32(6i)] = i32((min(2u, u32(-(1i))) == 2u));
    out[u32(7i)] = i32((max(2u, u32(-(1i))) == 4294967295u));
    out[u32(8i)] = min(i32(true), i32(false));
    out[u32(9i)] = max(i32(false), i32(true));
    out[u32(10i)] = min(max(seed, -(5i)), 2i);
    out[u32(11i)] = i32((min(u32(-(2i)), 4u) == 4u));
    let _e112 = min_(seed, 4i, 5i);
    out[u32(12i)] = _e112;
    let _e116 = bounded(seed);
    out[u32(13i)] = _e116;
    first = 3i;
    second = 7i;
    let _e124 = first;
    first = (_e124 + 1i);
    let _e127 = second;
    second = (_e127 + 1i);
    out[u32(14i)] = max(_e124, _e127);
    let _e134 = first;
    out[u32(15i)] = _e134;
    let _e138 = second;
    out[u32(16i)] = _e138;
    value = seed;
    let _e143 = value;
    let _e144 = value;
    value = (_e144 + 1i);
    out[u32(17i)] = max(_e143, _e144);
    let _e151 = value;
    out[u32(18i)] = _e151;
    out[u32(19i)] = i32((min((-(2147483647i) - 1i), 2147483647i) == (-(2147483647i) - 1i)));
    out[u32(20i)] = i32((max(4294967295u, 0u) == 4294967295u));
    out[u32(21i)] = i32((min(u32(false), 3u) == 0u));
    out[u32(22i)] = i32((max(u32(true), 0u) == 1u));
    out[u32(23i)] = min(seed, seed);
}
