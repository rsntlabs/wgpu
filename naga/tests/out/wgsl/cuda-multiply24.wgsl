@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn signed_conversion(first_1: f32, second_1: f32) -> i32 {
    return bitcast<i32>((bitcast<u32>(extractBits(i32(first_1), 0u, 24u)) * bitcast<u32>(extractBits(i32(second_1), 0u, 24u))));
}

fn unsigned_conversion(first_2: f32, second_2: f32) -> u32 {
    return (extractBits(u32(first_2), 0u, 24u) * extractBits(u32(second_2), 0u, 24u));
}

fn _mul24_(first_3: bool, second_3: bool) -> i32 {
    var local_66: i32;
    var local_67: i32;

    if first_3 {
        if second_3 {
            local_66 = 71i;
        } else {
            local_66 = 73i;
        }
        let _e7 = local_66;
        local_67 = _e7;
    } else {
        local_67 = 79i;
    }
    let _e12 = local_67;
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
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;

    local = u32(0i);
    let _e15 = local;
    local_34 = u32(_e15);
    let _e18 = local_34;
    out[_e18] = u32(bitcast<i32>((bitcast<u32>(extractBits(8388608i, 0u, 24u)) * bitcast<u32>(extractBits(1i, 0u, 24u)))));
    local_1 = u32(1i);
    let _e30 = local_1;
    local_35 = u32(_e30);
    let _e33 = local_35;
    out[_e33] = (extractBits(16777215u, 0u, 24u) * extractBits(16777215u, 0u, 24u));
    local_2 = u32(2i);
    let _e49 = local_2;
    local_36 = u32(_e49);
    let _e52 = local_36;
    out[_e52] = u32(bitcast<i32>((bitcast<u32>(extractBits(8388607i, 0u, 24u)) * bitcast<u32>(extractBits(8388607i, 0u, 24u)))));
    local_3 = u32(3i);
    let _e64 = local_3;
    local_37 = u32(_e64);
    let _e67 = local_37;
    out[_e67] = (extractBits(16777216u, 0u, 24u) * extractBits(13u, 0u, 24u));
    let _e72 = signed_conversion(3.75f, -(2.75f));
    local_4 = u32(4i);
    let _e77 = local_4;
    local_38 = u32(_e77);
    let _e80 = local_38;
    out[_e80] = u32(_e72);
    let _e85 = signed_conversion(-(3.75f), 2.75f);
    local_5 = u32(5i);
    let _e90 = local_5;
    local_39 = u32(_e90);
    let _e93 = local_39;
    out[_e93] = u32(_e85);
    let _e97 = unsigned_conversion(3.75f, 2.75f);
    local_6 = u32(6i);
    let _e101 = local_6;
    local_40 = u32(_e101);
    let _e104 = local_40;
    out[_e104] = _e97;
    let _e108 = unsigned_conversion(16777215f, 1f);
    local_7 = u32(7i);
    let _e112 = local_7;
    local_41 = u32(_e112);
    let _e115 = local_41;
    out[_e115] = _e108;
    let _e119 = _mul24_(true, true);
    local_8 = u32(8i);
    let _e124 = local_8;
    local_42 = u32(_e124);
    let _e127 = local_42;
    out[_e127] = u32(_e119);
    let _e131 = _mul24_(false, true);
    local_9 = u32(9i);
    let _e136 = local_9;
    local_43 = u32(_e136);
    let _e139 = local_43;
    out[_e139] = u32(_e131);
    local_10 = u32(10i);
    let _e156 = local_10;
    local_44 = u32(_e156);
    let _e159 = local_44;
    out[_e159] = u32(bitcast<i32>((bitcast<u32>(extractBits(3i, 0u, 24u)) * bitcast<u32>(extractBits(i32(true), 0u, 24u)))));
    local_11 = u32(11i);
    let _e176 = local_11;
    local_45 = u32(_e176);
    let _e179 = local_45;
    out[_e179] = u32(bitcast<i32>((bitcast<u32>(extractBits(i32(true), 0u, 24u)) * bitcast<u32>(extractBits(3i, 0u, 24u)))));
    let _e183 = _mul24_1(3.75f, 2f);
    local_12 = u32(12i);
    let _e188 = local_12;
    local_46 = u32(_e188);
    let _e191 = local_46;
    out[_e191] = u32(_e183);
    let _e195 = _umul24_(3i, 4i);
    local_13 = u32(13i);
    let _e199 = local_13;
    local_47 = u32(_e199);
    let _e202 = local_47;
    out[_e202] = _e195;
    local_14 = u32(14i);
    let _e214 = local_14;
    local_48 = u32(_e214);
    let _e217 = local_48;
    out[_e217] = (extractBits(3u, 0u, 24u) * extractBits(4u, 0u, 24u));
    let _e223 = _umul24_(i32(true), i32(true));
    local_15 = u32(15i);
    let _e227 = local_15;
    local_49 = u32(_e227);
    let _e230 = local_49;
    out[_e230] = _e223;
    local_16 = u32(16i);
    let _e243 = local_16;
    local_50 = u32(_e243);
    let _e246 = local_50;
    out[_e246] = (extractBits(3u, 0u, 24u) * extractBits(u32(4i), 0u, 24u));
    let _e251 = signed_pair(-(7i), 3i);
    local_17 = u32(17i);
    let _e256 = local_17;
    local_51 = u32(_e256);
    let _e259 = local_51;
    out[_e259] = u32(_e251);
    local_18 = u32(18i);
    let _e284 = local_18;
    local_52 = u32(_e284);
    let _e287 = local_52;
    out[_e287] = u32(bitcast<i32>((bitcast<u32>(extractBits(bitcast<i32>((bitcast<u32>(extractBits(3i, 0u, 24u)) * bitcast<u32>(extractBits(4i, 0u, 24u)))), 0u, 24u)) * bitcast<u32>(extractBits(5i, 0u, 24u)))));
    local_19 = u32(19i);
    let _e305 = local_19;
    local_53 = u32(_e305);
    let _e308 = local_53;
    out[_e308] = (extractBits((extractBits(16777215u, 0u, 24u) * extractBits(2u, 0u, 24u)), 0u, 24u) * extractBits(2u, 0u, 24u));
    first = -3i;
    second = 5u;
    let _e314 = first;
    let _e315 = second;
    local_20 = u32(20i);
    let _e329 = local_20;
    local_54 = u32(_e329);
    let _e332 = local_54;
    out[_e332] = u32(bitcast<i32>((bitcast<u32>(extractBits(_e314, 0u, 24u)) * bitcast<u32>(extractBits(i32(_e315), 0u, 24u)))));
    let _e334 = first;
    let _e336 = second;
    local_21 = u32(21i);
    let _e345 = local_21;
    local_55 = u32(_e345);
    let _e348 = local_55;
    out[_e348] = (extractBits(u32(_e334), 0u, 24u) * extractBits(_e336, 0u, 24u));
    local_22 = u32(22i);
    let _e364 = local_22;
    local_56 = u32(_e364);
    let _e367 = local_56;
    out[_e367] = u32(bitcast<i32>((bitcast<u32>(extractBits(25165824i, 0u, 24u)) * bitcast<u32>(extractBits(16777217i, 0u, 24u)))));
    local_23 = u32(23i);
    let _e379 = local_23;
    local_57 = u32(_e379);
    let _e382 = local_57;
    out[_e382] = (extractBits(4286578688u, 0u, 24u) * extractBits(4278190081u, 0u, 24u));
    if true {
        local_25 = bitcast<i32>((bitcast<u32>(extractBits(-(3i), 0u, 24u)) * bitcast<u32>(extractBits(7i, 0u, 24u))));
    } else {
        local_25 = bitcast<i32>((bitcast<u32>(extractBits(0i, 0u, 24u)) * bitcast<u32>(extractBits(0i, 0u, 24u))));
    }
    let _e409 = local_25;
    local_24 = u32(24i);
    let _e414 = local_24;
    local_58 = u32(_e414);
    let _e417 = local_58;
    out[_e417] = u32(_e409);
    values[0] = bitcast<i32>((bitcast<u32>(extractBits(2i, 0u, 24u)) * bitcast<u32>(extractBits(3i, 0u, 24u))));
    values[1] = bitcast<i32>((bitcast<u32>(extractBits(3i, 0u, 24u)) * bitcast<u32>(extractBits(4i, 0u, 24u))));
    let _e446 = values[0i];
    let _e447 = values[1i];
    local_26 = u32(25i);
    let _e453 = local_26;
    local_59 = u32(_e453);
    let _e456 = local_59;
    out[_e456] = u32((_e446 + _e447));
    Count = 2i;
    scratch = array<i32, 2>();
    let _e464 = Count;
    let _e465 = scratch[0i];
    local_28 = u32(26i);
    let _e471 = local_28;
    local_60 = u32(_e471);
    let _e474 = local_60;
    out[_e474] = u32((_e464 + _e465));
    counter = 2i;
    let _e478 = counter;
    counter = (_e478 + 1i);
    let _e481 = counter;
    counter = (_e481 + 1i);
    local_29 = u32(27i);
    let _e496 = local_29;
    local_61 = u32(_e496);
    let _e499 = local_61;
    out[_e499] = u32(bitcast<i32>((bitcast<u32>(extractBits(_e478, 0u, 24u)) * bitcast<u32>(extractBits(_e481, 0u, 24u)))));
    let _e501 = counter;
    local_30 = u32(28i);
    let _e506 = local_30;
    local_62 = u32(_e506);
    let _e509 = local_62;
    out[_e509] = u32(_e501);
    total = 0i;
    {
        index = 0i;
        loop {
            let _e515 = index;
            if (_e515 < 3i) {
            } else {
                break;
            }
            let _e518 = index;
            let _e530 = total;
            total = (_e530 + bitcast<i32>((bitcast<u32>(extractBits((_e518 + 1i), 0u, 24u)) * bitcast<u32>(extractBits(2i, 0u, 24u)))));
            continuing {
                let _e532 = index;
                index = (_e532 + 1i);
            }
        }
    }
    let _e535 = total;
    local_31 = u32(29i);
    let _e540 = local_31;
    local_63 = u32(_e540);
    let _e543 = local_63;
    out[_e543] = u32(_e535);
    {
        local_32 = u32(30i);
        let _e551 = local_32;
        local_64 = u32(_e551);
        let _e554 = local_64;
        out[_e554] = u32(i32(9.75f));
    }
    local_33 = u32(31i);
    let _e570 = local_33;
    local_65 = u32(_e570);
    let _e573 = local_65;
    out[_e573] = u32(bitcast<i32>((bitcast<u32>(extractBits(16777215i, 0u, 24u)) * bitcast<u32>(extractBits(3i, 0u, 24u)))));
}
