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
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: i32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;

    destination_index = u32(1i);
    source_index = u32(8i);
    let _e6 = destination_index;
    destination_index = (_e6 + u32(1i));
    local = u32(_e6);
    let _e12 = source_index;
    source_index = (_e12 + u32(1i));
    local_1 = u32(_e12);
    let _e18 = local_1;
    local_15 = u32(_e18);
    let _e21 = local_15;
    let _e24 = other[_e21];
    let _e25 = local;
    local_16 = u32(_e25);
    let _e28 = local_16;
    out[_e28] = _e24;
    local_2 = u32(8i);
    let _e34 = local_2;
    local_17 = u32(_e34);
    let _e37 = local_17;
    let first = out[_e37];
    let _e40 = local_17;
    out[_e40] = 7i;
    local_3 = u32(0i);
    let _e46 = local_3;
    local_18 = u32(_e46);
    let _e49 = local_18;
    out[_e49] = first;
    let _e51 = local_17;
    let _e53 = out[_e51];
    local_4 = u32(2i);
    let _e57 = local_4;
    local_19 = u32(_e57);
    let _e60 = local_19;
    out[_e60] = _e53;
    local_5 = u32(3i);
    let _e65 = local_5;
    local_20 = u32(_e65);
    let _e68 = local_20;
    let _e70 = out[_e68];
    let choose = (_e70 != 0i);
    if choose {
        local_7 = u32(8i);
        local_10 = 0u;
        local_9 = 1u;
    } else {
        local_8 = u32(9i);
        local_10 = 0u;
        local_9 = 0u;
    }
    let _e88 = local_10;
    let _e90 = local_9;
    if (_e90 != 0u) {
        let _e94 = local_7;
        local_21 = u32((_e88 + _e94));
        local_23 = 8u;
    } else {
        let _e101 = local_8;
        local_22 = u32((_e88 + _e101));
        local_23 = 9u;
    }
    let _e108 = local_23;
    switch _e108 {
        case 8u: {
            let _e110 = local_21;
            let _e112 = out[_e110];
            local_24 = _e112;
        }
        default: {
            let _e115 = local_22;
            let _e117 = other[_e115];
            local_24 = _e117;
        }
    }
    let _e120 = local_24;
    local_6 = u32(4i);
    let _e124 = local_6;
    local_25 = u32(_e124);
    let _e127 = local_25;
    out[_e127] = _e120;
    let _e129 = destination_index;
    let _e133 = source_index;
    local_11 = u32(5i);
    let _e139 = local_11;
    local_26 = u32(_e139);
    let _e142 = local_26;
    out[_e142] = i32(((_e129 * u32(100i)) + _e133));
    let _e144 = source_index;
    source_index = (_e144 + u32(1i));
    local_12 = u32(_e144);
    let _e150 = source_index;
    source_index = (_e150 + u32(1i));
    let _e154 = local_12;
    local_27 = u32(_e154);
    let _e157 = local_27;
    let _e159 = other[_e157];
    local_13 = u32(6i);
    let _e163 = local_13;
    local_28 = u32(_e163);
    let _e166 = local_28;
    out[_e166] = _e159;
    let _e168 = source_index;
    local_14 = u32(7i);
    let _e173 = local_14;
    local_29 = u32(_e173);
    let _e176 = local_29;
    out[_e176] = i32(_e168);
}
