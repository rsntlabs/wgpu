@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn signed_conversion(first_1: f32, second_1: f32) -> i32 {
    return bitcast<i32>((bitcast<u32>(extractBits(i32(first_1), 0u, 24u)) * bitcast<u32>(extractBits(i32(second_1), 0u, 24u))));
}

fn unsigned_conversion(first_2: f32, second_2: f32) -> u32 {
    return (extractBits(u32(first_2), 0u, 24u) * extractBits(u32(second_2), 0u, 24u));
}

fn _mul24_(first_3: bool, second_3: bool) -> i32 {
    var local_35: i32;
    var local_36: i32;

    if first_3 {
        if second_3 {
            local_35 = 71i;
        } else {
            local_35 = 73i;
        }
        let _e7 = local_35;
        local_36 = _e7;
    } else {
        local_36 = 79i;
    }
    let _e12 = local_36;
    return _e12;
}

fn _mul24_1(first_4: f32, second_4: f32) -> i32 {
    return i32(((first_4 * 10f) + second_4));
}

fn _umul24_(first_5: i32, second_5: i32) -> u32 {
    return u32(((first_5 + second_5) + 100i));
}

fn signed_pair(first_6: i32, second_6: i32) -> i32 {
    return bitcast<i32>((bitcast<u32>(extractBits(first_6, 0u, 24u)) * bitcast<u32>(extractBits(second_6, 0u, 24u))));
}

@compute @workgroup_size(1, 1, 1)
fn multiply24_() {
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
    var first: i32;
    var second: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: i32;
    var values: array<i32, 2>;
    var local_26: u32;
    var Count: i32;
    var local_27: i32;
    var scratch: array<i32, 2>;
    var local_28: u32;
    var counter: i32;
    var local_29: u32;
    var local_30: u32;
    var total: i32;
    var index: i32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;

    local = u32(0i);
    let _e14 = local;
    out[_e14] = u32(bitcast<i32>((bitcast<u32>(extractBits(8388608i, 0u, 24u)) * bitcast<u32>(extractBits(1i, 0u, 24u)))));
    local_1 = u32(1i);
    let _e27 = local_1;
    out[_e27] = (extractBits(16777215u, 0u, 24u) * extractBits(16777215u, 0u, 24u));
    local_2 = u32(2i);
    let _e43 = local_2;
    out[_e43] = u32(bitcast<i32>((bitcast<u32>(extractBits(8388607i, 0u, 24u)) * bitcast<u32>(extractBits(8388607i, 0u, 24u)))));
    local_3 = u32(3i);
    let _e55 = local_3;
    out[_e55] = (extractBits(16777216u, 0u, 24u) * extractBits(13u, 0u, 24u));
    let _e60 = signed_conversion(3.75f, -(2.75f));
    local_4 = u32(4i);
    let _e65 = local_4;
    out[_e65] = u32(_e60);
    let _e70 = signed_conversion(-(3.75f), 2.75f);
    local_5 = u32(5i);
    let _e75 = local_5;
    out[_e75] = u32(_e70);
    let _e79 = unsigned_conversion(3.75f, 2.75f);
    local_6 = u32(6i);
    let _e83 = local_6;
    out[_e83] = _e79;
    let _e87 = unsigned_conversion(16777215f, 1f);
    local_7 = u32(7i);
    let _e91 = local_7;
    out[_e91] = _e87;
    let _e95 = _mul24_(true, true);
    local_8 = u32(8i);
    let _e100 = local_8;
    out[_e100] = u32(_e95);
    let _e104 = _mul24_(false, true);
    local_9 = u32(9i);
    let _e109 = local_9;
    out[_e109] = u32(_e104);
    local_10 = u32(10i);
    let _e126 = local_10;
    out[_e126] = u32(bitcast<i32>((bitcast<u32>(extractBits(3i, 0u, 24u)) * bitcast<u32>(extractBits(i32(true), 0u, 24u)))));
    local_11 = u32(11i);
    let _e143 = local_11;
    out[_e143] = u32(bitcast<i32>((bitcast<u32>(extractBits(i32(true), 0u, 24u)) * bitcast<u32>(extractBits(3i, 0u, 24u)))));
    let _e147 = _mul24_1(3.75f, 2f);
    local_12 = u32(12i);
    let _e152 = local_12;
    out[_e152] = u32(_e147);
    let _e156 = _umul24_(3i, 4i);
    local_13 = u32(13i);
    let _e160 = local_13;
    out[_e160] = _e156;
    local_14 = u32(14i);
    let _e172 = local_14;
    out[_e172] = (extractBits(3u, 0u, 24u) * extractBits(4u, 0u, 24u));
    let _e178 = _umul24_(i32(true), i32(true));
    local_15 = u32(15i);
    let _e182 = local_15;
    out[_e182] = _e178;
    local_16 = u32(16i);
    let _e195 = local_16;
    out[_e195] = (extractBits(3u, 0u, 24u) * extractBits(u32(4i), 0u, 24u));
    let _e200 = signed_pair(-(7i), 3i);
    local_17 = u32(17i);
    let _e205 = local_17;
    out[_e205] = u32(_e200);
    local_18 = u32(18i);
    let _e230 = local_18;
    out[_e230] = u32(bitcast<i32>((bitcast<u32>(extractBits(bitcast<i32>((bitcast<u32>(extractBits(3i, 0u, 24u)) * bitcast<u32>(extractBits(4i, 0u, 24u)))), 0u, 24u)) * bitcast<u32>(extractBits(5i, 0u, 24u)))));
    local_19 = u32(19i);
    let _e248 = local_19;
    out[_e248] = (extractBits((extractBits(16777215u, 0u, 24u) * extractBits(2u, 0u, 24u)), 0u, 24u) * extractBits(2u, 0u, 24u));
    first = -3i;
    second = 5u;
    let _e254 = first;
    let _e255 = second;
    local_20 = u32(20i);
    let _e269 = local_20;
    out[_e269] = u32(bitcast<i32>((bitcast<u32>(extractBits(_e254, 0u, 24u)) * bitcast<u32>(extractBits(i32(_e255), 0u, 24u)))));
    let _e271 = first;
    let _e273 = second;
    local_21 = u32(21i);
    let _e282 = local_21;
    out[_e282] = (extractBits(u32(_e271), 0u, 24u) * extractBits(_e273, 0u, 24u));
    local_22 = u32(22i);
    let _e298 = local_22;
    out[_e298] = u32(bitcast<i32>((bitcast<u32>(extractBits(25165824i, 0u, 24u)) * bitcast<u32>(extractBits(16777217i, 0u, 24u)))));
    local_23 = u32(23i);
    let _e310 = local_23;
    out[_e310] = (extractBits(4286578688u, 0u, 24u) * extractBits(4278190081u, 0u, 24u));
    if true {
        local_25 = bitcast<i32>((bitcast<u32>(extractBits(-(3i), 0u, 24u)) * bitcast<u32>(extractBits(7i, 0u, 24u))));
    } else {
        local_25 = bitcast<i32>((bitcast<u32>(extractBits(0i, 0u, 24u)) * bitcast<u32>(extractBits(0i, 0u, 24u))));
    }
    let _e337 = local_25;
    local_24 = u32(24i);
    let _e342 = local_24;
    out[_e342] = u32(_e337);
    values[0] = bitcast<i32>((bitcast<u32>(extractBits(2i, 0u, 24u)) * bitcast<u32>(extractBits(3i, 0u, 24u))));
    values[1] = bitcast<i32>((bitcast<u32>(extractBits(3i, 0u, 24u)) * bitcast<u32>(extractBits(4i, 0u, 24u))));
    let _e371 = values[0i];
    let _e372 = values[1i];
    local_26 = u32(25i);
    let _e378 = local_26;
    out[_e378] = u32((_e371 + _e372));
    Count = 2i;
    scratch = array<i32, 2>();
    let _e386 = Count;
    let _e387 = scratch[0i];
    local_28 = u32(26i);
    let _e393 = local_28;
    out[_e393] = u32((_e386 + _e387));
    counter = 2i;
    let _e397 = counter;
    counter = (_e397 + 1i);
    let _e400 = counter;
    counter = (_e400 + 1i);
    local_29 = u32(27i);
    let _e415 = local_29;
    out[_e415] = u32(bitcast<i32>((bitcast<u32>(extractBits(_e397, 0u, 24u)) * bitcast<u32>(extractBits(_e400, 0u, 24u)))));
    let _e417 = counter;
    local_30 = u32(28i);
    let _e422 = local_30;
    out[_e422] = u32(_e417);
    total = 0i;
    {
        index = 0i;
        loop {
            let _e428 = index;
            if (_e428 < 3i) {
            } else {
                break;
            }
            let _e431 = index;
            let _e443 = total;
            total = (_e443 + bitcast<i32>((bitcast<u32>(extractBits((_e431 + 1i), 0u, 24u)) * bitcast<u32>(extractBits(2i, 0u, 24u)))));
            continuing {
                let _e445 = index;
                index = (_e445 + 1i);
            }
        }
    }
    let _e448 = total;
    local_31 = u32(29i);
    let _e453 = local_31;
    out[_e453] = u32(_e448);
    {
        local_32 = u32(30i);
        let _e461 = local_32;
        local_34 = _e461;
        let _e463 = local_34;
        out[_e463] = u32(i32(9.75f));
    }
    local_33 = u32(31i);
    let _e479 = local_33;
    out[_e479] = u32(bitcast<i32>((bitcast<u32>(extractBits(16777215i, 0u, 24u)) * bitcast<u32>(extractBits(3i, 0u, 24u)))));
}
