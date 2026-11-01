@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn count(value: u32) -> i32 {
    return i32(countOneBits(value));
}

fn scan(value_1: i32) -> i32 {
    return (firstTrailingBit(value_1) + 1i);
}

fn _clz(first: i32, second: i32) -> i32 {
    return (first + second);
}

@compute @workgroup_size(1, 1, 1)
fn integer_intrinsics() {
    out[u32(0i)] = u32(countLeadingZeros(i32(true)));
    out[u32(1i)] = u32(countLeadingZeros(8i));
    out[u32(2i)] = u32(countLeadingZeros(i32(2147483648u)));
    out[u32(3i)] = u32(countLeadingZeros(i32(8.75f)));
    out[u32(4i)] = u32((firstTrailingBit(i32(true)) + 1i));
    out[u32(5i)] = u32((firstTrailingBit(8i) + 1i));
    out[u32(6i)] = u32((firstTrailingBit(i32(2147483648u)) + 1i));
    out[u32(7i)] = u32((firstTrailingBit(i32(8.75f)) + 1i));
    out[u32(8i)] = u32(i32(countOneBits(u32(true))));
    out[u32(9i)] = u32(i32(countOneBits(u32(-(1i)))));
    out[u32(10i)] = u32(i32(countOneBits(2147483649u)));
    out[u32(11i)] = u32(i32(countOneBits(u32(3.75f))));
    out[u32(12i)] = reverseBits(u32(true));
    out[u32(13i)] = reverseBits(u32(-(1i)));
    out[u32(14i)] = reverseBits(19088743u);
    out[u32(15i)] = reverseBits(u32(2.75f));
    let _e120 = count(2147483649u);
    out[u32(16i)] = u32(_e120);
    let _e127 = scan(i32(2147483648u));
    out[u32(17i)] = u32(_e127);
    out[u32(18i)] = u32(countLeadingZeros(0i));
    out[u32(19i)] = u32((firstTrailingBit(0i) + 1i));
    out[u32(20i)] = u32(i32(countOneBits(4294967295u)));
    out[u32(21i)] = reverseBits(0u);
    out[u32(22i)] = reverseBits(1u);
    out[u32(23i)] = reverseBits(2147483648u);
    out[u32(24i)] = u32(countLeadingZeros(-(2i)));
    out[u32(25i)] = u32((firstTrailingBit(-(2i)) + 1i));
    out[u32(26i)] = u32(i32(countOneBits(2863311530u)));
    out[u32(27i)] = reverseBits(2863311530u);
    let _e198 = _clz(3i, 4i);
    out[u32(28i)] = u32(_e198);
    out[u32(29i)] = u32(((i32(countOneBits(3u)) - 3i) < 0i));
}
