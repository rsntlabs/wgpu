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

    local = u32(0i);
    let _e7 = local;
    out[_e7] = u32(countLeadingZeros(i32(true)));
    local_1 = u32(1i);
    let _e16 = local_1;
    out[_e16] = u32(countLeadingZeros(8i));
    local_2 = u32(2i);
    let _e25 = local_2;
    out[_e25] = u32(countLeadingZeros(i32(2147483648u)));
    local_3 = u32(3i);
    let _e34 = local_3;
    out[_e34] = u32(countLeadingZeros(i32(8.75f)));
    local_4 = u32(4i);
    let _e45 = local_4;
    out[_e45] = u32((firstTrailingBit(i32(true)) + 1i));
    local_5 = u32(5i);
    let _e55 = local_5;
    out[_e55] = u32((firstTrailingBit(8i) + 1i));
    local_6 = u32(6i);
    let _e66 = local_6;
    out[_e66] = u32((firstTrailingBit(i32(2147483648u)) + 1i));
    local_7 = u32(7i);
    let _e77 = local_7;
    out[_e77] = u32((firstTrailingBit(i32(8.75f)) + 1i));
    local_8 = u32(8i);
    let _e87 = local_8;
    out[_e87] = u32(i32(countOneBits(u32(true))));
    local_9 = u32(9i);
    let _e98 = local_9;
    out[_e98] = u32(i32(countOneBits(u32(-(1i)))));
    local_10 = u32(10i);
    let _e107 = local_10;
    out[_e107] = u32(i32(countOneBits(2147483649u)));
    local_11 = u32(11i);
    let _e117 = local_11;
    out[_e117] = u32(i32(countOneBits(u32(3.75f))));
    local_12 = u32(12i);
    let _e125 = local_12;
    out[_e125] = reverseBits(u32(true));
    local_13 = u32(13i);
    let _e134 = local_13;
    out[_e134] = reverseBits(u32(-(1i)));
    local_14 = u32(14i);
    let _e141 = local_14;
    out[_e141] = reverseBits(19088743u);
    local_15 = u32(15i);
    let _e149 = local_15;
    out[_e149] = reverseBits(u32(2.75f));
    let _e152 = count(2147483649u);
    local_16 = u32(16i);
    let _e157 = local_16;
    out[_e157] = u32(_e152);
    let _e161 = scan(i32(2147483648u));
    local_17 = u32(17i);
    let _e166 = local_17;
    out[_e166] = u32(_e161);
    local_18 = u32(18i);
    let _e174 = local_18;
    out[_e174] = u32(countLeadingZeros(0i));
    local_19 = u32(19i);
    let _e184 = local_19;
    out[_e184] = u32((firstTrailingBit(0i) + 1i));
    local_20 = u32(20i);
    let _e193 = local_20;
    out[_e193] = u32(i32(countOneBits(4294967295u)));
    local_21 = u32(21i);
    let _e200 = local_21;
    out[_e200] = reverseBits(0u);
    local_22 = u32(22i);
    let _e207 = local_22;
    out[_e207] = reverseBits(1u);
    local_23 = u32(23i);
    let _e214 = local_23;
    out[_e214] = reverseBits(2147483648u);
    local_24 = u32(24i);
    let _e223 = local_24;
    out[_e223] = u32(countLeadingZeros(-(2i)));
    local_25 = u32(25i);
    let _e234 = local_25;
    out[_e234] = u32((firstTrailingBit(-(2i)) + 1i));
    local_26 = u32(26i);
    let _e243 = local_26;
    out[_e243] = u32(i32(countOneBits(2863311530u)));
    local_27 = u32(27i);
    let _e250 = local_27;
    out[_e250] = reverseBits(2863311530u);
    let _e254 = _clz(3i, 4i);
    local_28 = u32(28i);
    let _e259 = local_28;
    out[_e259] = u32(_e254);
    local_29 = u32(29i);
    let _e272 = local_29;
    out[_e272] = u32(((i32(countOneBits(3u)) - 3i) < 0i));
}
