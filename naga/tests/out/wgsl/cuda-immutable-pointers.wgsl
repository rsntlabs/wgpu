@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage, read_write> other: array<i32>;

@compute @workgroup_size(1, 1, 1)
fn kernel() {
    var destination_index: u32;
    var source_index: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: i32;

    destination_index = u32(1i);
    source_index = u32(8i);
    let _e6 = destination_index;
    destination_index = (_e6 + u32(1i));
    let _e10 = source_index;
    source_index = (_e10 + u32(1i));
    let _e16 = other[_e10];
    out[_e6] = _e16;
    let _e20 = u32(8i);
    let first = out[_e20];
    out[_e20] = 7i;
    out[u32(0i)] = first;
    let _e29 = out[_e20];
    out[u32(2i)] = _e29;
    let _e36 = out[u32(3i)];
    let choose = (_e36 != 0i);
    if choose {
        local = u32(8i);
        local_3 = 0u;
        local_2 = 1u;
    } else {
        local_1 = u32(9i);
        local_3 = 0u;
        local_2 = 0u;
    }
    let _e54 = local_3;
    let _e56 = local_2;
    if (_e56 != 0u) {
        let _e60 = local;
        local_4 = u32((_e54 + _e60));
        local_6 = 8u;
    } else {
        let _e67 = local_1;
        local_5 = u32((_e54 + _e67));
        local_6 = 9u;
    }
    let _e74 = local_6;
    switch _e74 {
        case 8u: {
            let _e76 = local_4;
            let _e78 = out[_e76];
            local_7 = _e78;
        }
        default: {
            let _e81 = local_5;
            let _e83 = other[_e81];
            local_7 = _e83;
        }
    }
    let _e86 = local_7;
    out[u32(4i)] = _e86;
    let _e90 = destination_index;
    let _e94 = source_index;
    out[u32(5i)] = i32(((_e90 * u32(100i)) + _e94));
    let _e100 = source_index;
    source_index = (_e100 + u32(1i));
    let _e104 = source_index;
    source_index = (_e104 + u32(1i));
    let _e109 = other[_e100];
    out[u32(6i)] = _e109;
    let _e113 = source_index;
    out[u32(7i)] = i32(_e113);
}
