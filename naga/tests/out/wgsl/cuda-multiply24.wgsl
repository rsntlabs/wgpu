@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn signed_conversion(first_1: f32, second_1: f32) -> i32 {
    return bitcast<i32>((bitcast<u32>(extractBits(i32(first_1), 0u, 24u)) * bitcast<u32>(extractBits(i32(second_1), 0u, 24u))));
}

fn unsigned_conversion(first_2: f32, second_2: f32) -> u32 {
    return (extractBits(u32(first_2), 0u, 24u) * extractBits(u32(second_2), 0u, 24u));
}

fn _mul24_(first_3: bool, second_3: bool) -> i32 {
    var local_4: i32;
    var local_5: i32;

    if first_3 {
        if second_3 {
            local_4 = 71i;
        } else {
            local_4 = 73i;
        }
        let _e7 = local_4;
        local_5 = _e7;
    } else {
        local_5 = 79i;
    }
    let _e12 = local_5;
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
    var first: i32;
    var second: u32;
    var local: i32;
    var values: array<i32, 2>;
    var Count: i32;
    var local_1: i32;
    var scratch: array<i32, 2>;
    var counter: i32;
    var total: i32;
    var index: i32;
    var local_2: u32;
    var local_3: u32;

    out[u32(0i)] = u32(bitcast<i32>((bitcast<u32>(extractBits(8388608i, 0u, 24u)) * bitcast<u32>(extractBits(1i, 0u, 24u)))));
    out[u32(1i)] = (extractBits(16777215u, 0u, 24u) * extractBits(16777215u, 0u, 24u));
    out[u32(2i)] = u32(bitcast<i32>((bitcast<u32>(extractBits(8388607i, 0u, 24u)) * bitcast<u32>(extractBits(8388607i, 0u, 24u)))));
    out[u32(3i)] = (extractBits(16777216u, 0u, 24u) * extractBits(13u, 0u, 24u));
    let _e52 = signed_conversion(3.75f, -(2.75f));
    out[u32(4i)] = u32(_e52);
    let _e60 = signed_conversion(-(3.75f), 2.75f);
    out[u32(5i)] = u32(_e60);
    let _e67 = unsigned_conversion(3.75f, 2.75f);
    out[u32(6i)] = _e67;
    let _e73 = unsigned_conversion(16777215f, 1f);
    out[u32(7i)] = _e73;
    let _e79 = _mul24_(true, true);
    out[u32(8i)] = u32(_e79);
    let _e86 = _mul24_(false, true);
    out[u32(9i)] = u32(_e86);
    out[u32(10i)] = u32(bitcast<i32>((bitcast<u32>(extractBits(3i, 0u, 24u)) * bitcast<u32>(extractBits(i32(true), 0u, 24u)))));
    out[u32(11i)] = u32(bitcast<i32>((bitcast<u32>(extractBits(i32(true), 0u, 24u)) * bitcast<u32>(extractBits(3i, 0u, 24u)))));
    let _e123 = _mul24_1(3.75f, 2f);
    out[u32(12i)] = u32(_e123);
    let _e130 = _umul24_(3i, 4i);
    out[u32(13i)] = _e130;
    out[u32(14i)] = (extractBits(3u, 0u, 24u) * extractBits(4u, 0u, 24u));
    let _e148 = _umul24_(i32(true), i32(true));
    out[u32(15i)] = _e148;
    out[u32(16i)] = (extractBits(3u, 0u, 24u) * extractBits(u32(4i), 0u, 24u));
    let _e166 = signed_pair(-(7i), 3i);
    out[u32(17i)] = u32(_e166);
    out[u32(18i)] = u32(bitcast<i32>((bitcast<u32>(extractBits(bitcast<i32>((bitcast<u32>(extractBits(3i, 0u, 24u)) * bitcast<u32>(extractBits(4i, 0u, 24u)))), 0u, 24u)) * bitcast<u32>(extractBits(5i, 0u, 24u)))));
    out[u32(19i)] = (extractBits((extractBits(16777215u, 0u, 24u) * extractBits(2u, 0u, 24u)), 0u, 24u) * extractBits(2u, 0u, 24u));
    first = -3i;
    second = 5u;
    let _e214 = first;
    let _e215 = second;
    out[u32(20i)] = u32(bitcast<i32>((bitcast<u32>(extractBits(_e214, 0u, 24u)) * bitcast<u32>(extractBits(i32(_e215), 0u, 24u)))));
    let _e229 = first;
    let _e231 = second;
    out[u32(21i)] = (extractBits(u32(_e229), 0u, 24u) * extractBits(_e231, 0u, 24u));
    out[u32(22i)] = u32(bitcast<i32>((bitcast<u32>(extractBits(25165824i, 0u, 24u)) * bitcast<u32>(extractBits(16777217i, 0u, 24u)))));
    out[u32(23i)] = (extractBits(4286578688u, 0u, 24u) * extractBits(4278190081u, 0u, 24u));
    if true {
        local = bitcast<i32>((bitcast<u32>(extractBits(-(3i), 0u, 24u)) * bitcast<u32>(extractBits(7i, 0u, 24u))));
    } else {
        local = bitcast<i32>((bitcast<u32>(extractBits(0i, 0u, 24u)) * bitcast<u32>(extractBits(0i, 0u, 24u))));
    }
    let _e289 = local;
    out[u32(24i)] = u32(_e289);
    values[0] = bitcast<i32>((bitcast<u32>(extractBits(2i, 0u, 24u)) * bitcast<u32>(extractBits(3i, 0u, 24u))));
    values[1] = bitcast<i32>((bitcast<u32>(extractBits(3i, 0u, 24u)) * bitcast<u32>(extractBits(4i, 0u, 24u))));
    let _e321 = values[0i];
    let _e322 = values[1i];
    out[u32(25i)] = u32((_e321 + _e322));
    Count = 2i;
    scratch = array<i32, 2>();
    let _e334 = Count;
    let _e335 = scratch[0i];
    out[u32(26i)] = u32((_e334 + _e335));
    counter = 2i;
    let _e343 = counter;
    counter = (_e343 + 1i);
    let _e346 = counter;
    counter = (_e346 + 1i);
    out[u32(27i)] = u32(bitcast<i32>((bitcast<u32>(extractBits(_e343, 0u, 24u)) * bitcast<u32>(extractBits(_e346, 0u, 24u)))));
    let _e361 = counter;
    out[u32(28i)] = u32(_e361);
    total = 0i;
    {
        index = 0i;
        loop {
            let _e370 = index;
            if (_e370 < 3i) {
            } else {
                break;
            }
            let _e373 = index;
            let _e385 = total;
            total = (_e385 + bitcast<i32>((bitcast<u32>(extractBits((_e373 + 1i), 0u, 24u)) * bitcast<u32>(extractBits(2i, 0u, 24u)))));
            continuing {
                let _e387 = index;
                index = (_e387 + 1i);
            }
        }
    }
    let _e390 = total;
    out[u32(29i)] = u32(_e390);
    {
        local_2 = u32(30i);
        let _e401 = local_2;
        local_3 = _e401;
        let _e403 = local_3;
        out[_e403] = u32(i32(9.75f));
    }
    out[u32(31i)] = u32(bitcast<i32>((bitcast<u32>(extractBits(16777215i, 0u, 24u)) * bitcast<u32>(extractBits(3i, 0u, 24u)))));
}
