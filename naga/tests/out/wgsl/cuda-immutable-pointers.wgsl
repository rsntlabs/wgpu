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
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: i32;

    destination_index = u32(1i);
    source_index = u32(8i);
    let _e6 = destination_index;
    destination_index = (_e6 + u32(1i));
    let _e10 = source_index;
    source_index = (_e10 + u32(1i));
    let _e16 = other[_e10];
    out[_e6] = _e16;
    local = u32(8i);
    let _e22 = local;
    let first = out[_e22];
    out[_e22] = 7i;
    local_1 = u32(0i);
    let _e30 = local_1;
    out[_e30] = first;
    let _e33 = out[_e22];
    local_2 = u32(2i);
    let _e37 = local_2;
    out[_e37] = _e33;
    local_3 = u32(3i);
    let _e42 = local_3;
    let _e44 = out[_e42];
    let choose = (_e44 != 0i);
    if choose {
        local_5 = u32(8i);
        local_8 = 0u;
        local_7 = 1u;
    } else {
        local_6 = u32(9i);
        local_8 = 0u;
        local_7 = 0u;
    }
    let _e62 = local_8;
    let _e64 = local_7;
    if (_e64 != 0u) {
        let _e68 = local_5;
        local_12 = u32((_e62 + _e68));
        local_14 = 8u;
    } else {
        let _e75 = local_6;
        local_13 = u32((_e62 + _e75));
        local_14 = 9u;
    }
    let _e82 = local_14;
    switch _e82 {
        case 8u: {
            let _e84 = local_12;
            let _e86 = out[_e84];
            local_15 = _e86;
        }
        default: {
            let _e89 = local_13;
            let _e91 = other[_e89];
            local_15 = _e91;
        }
    }
    let _e94 = local_15;
    local_4 = u32(4i);
    let _e98 = local_4;
    out[_e98] = _e94;
    let _e100 = destination_index;
    let _e104 = source_index;
    local_9 = u32(5i);
    let _e110 = local_9;
    out[_e110] = i32(((_e100 * u32(100i)) + _e104));
    let _e112 = source_index;
    source_index = (_e112 + u32(1i));
    let _e116 = source_index;
    source_index = (_e116 + u32(1i));
    let _e121 = other[_e112];
    local_10 = u32(6i);
    let _e125 = local_10;
    out[_e125] = _e121;
    let _e127 = source_index;
    local_11 = u32(7i);
    let _e132 = local_11;
    out[_e132] = i32(_e127);
}
