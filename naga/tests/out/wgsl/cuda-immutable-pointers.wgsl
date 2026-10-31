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
    var local_3: i32;
    var local_4: u32;
    var local_5: u32;
    var local_6: i32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: i32;
    var local_17: u32;
    var local_18: i32;
    var local_19: i32;
    var local_20: i32;
    var local_21: i32;
    var local_22: i32;
    var local_23: i32;
    var local_24: u32;
    var local_25: i32;
    var local_26: u32;
    var local_27: u32;
    var local_28: i32;
    var local_29: u32;
    var local_30: i32;
    var local_31: u32;
    var local_32: u32;
    var local_33: i32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: i32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: i32;
    var local_42: u32;
    var local_43: u32;

    destination_index = u32(1i);
    source_index = u32(8i);
    let _e6 = destination_index;
    destination_index = (_e6 + u32(1i));
    local = u32(_e6);
    let _e12 = source_index;
    source_index = (_e12 + u32(1i));
    local_1 = u32(_e12);
    let _e18 = local_1;
    local_24 = u32(_e18);
    let _e21 = local_24;
    let _e24 = other[_e21];
    local_25 = _e24;
    let _e26 = local_25;
    local_18 = _e26;
    let _e28 = local_18;
    let _e29 = local;
    local_26 = u32(_e29);
    let _e32 = local_26;
    out[_e32] = _e28;
    local_2 = u32(8i);
    let _e38 = local_2;
    local_27 = u32(_e38);
    let _e41 = local_27;
    let _e43 = out[_e41];
    local_28 = _e43;
    let _e45 = local_28;
    local_19 = _e45;
    let _e47 = local_19;
    local_3 = _e47;
    let first = local_3;
    let _e50 = local_27;
    out[_e50] = 7i;
    local_4 = u32(0i);
    let _e56 = local_4;
    local_29 = u32(_e56);
    let _e59 = local_29;
    out[_e59] = first;
    let _e61 = local_27;
    let _e63 = out[_e61];
    local_30 = _e63;
    let _e65 = local_30;
    local_20 = _e65;
    let _e67 = local_20;
    local_6 = _e67;
    let _e69 = local_6;
    local_5 = u32(2i);
    let _e73 = local_5;
    local_31 = u32(_e73);
    let _e76 = local_31;
    out[_e76] = _e69;
    local_7 = u32(3i);
    let _e81 = local_7;
    local_32 = u32(_e81);
    let _e84 = local_32;
    let _e86 = out[_e84];
    local_33 = _e86;
    let _e88 = local_33;
    local_21 = _e88;
    let _e90 = local_21;
    let choose = (_e90 != 0i);
    if choose {
        local_9 = u32(8i);
        local_12 = 0u;
        local_11 = 1u;
    } else {
        local_10 = u32(9i);
        local_12 = 0u;
        local_11 = 0u;
    }
    let _e108 = local_12;
    let _e110 = local_11;
    if (_e110 != 0u) {
        let _e114 = local_9;
        local_34 = u32((_e108 + _e114));
        local_36 = 8u;
    } else {
        let _e121 = local_10;
        local_35 = u32((_e108 + _e121));
        local_36 = 9u;
    }
    let _e128 = local_36;
    switch _e128 {
        case 8u: {
            let _e130 = local_34;
            let _e132 = out[_e130];
            local_37 = _e132;
        }
        default: {
            let _e135 = local_35;
            let _e137 = other[_e135];
            local_37 = _e137;
        }
    }
    let _e140 = local_37;
    local_22 = _e140;
    let _e142 = local_22;
    local_8 = u32(4i);
    let _e146 = local_8;
    local_38 = u32(_e146);
    let _e149 = local_38;
    out[_e149] = _e142;
    let _e151 = destination_index;
    let _e155 = source_index;
    local_13 = u32(5i);
    let _e161 = local_13;
    local_39 = u32(_e161);
    let _e164 = local_39;
    out[_e164] = i32(((_e151 * u32(100i)) + _e155));
    let _e166 = source_index;
    source_index = (_e166 + u32(1i));
    local_14 = u32(_e166);
    let _e172 = source_index;
    source_index = (_e172 + u32(1i));
    let _e176 = local_14;
    local_40 = u32(_e176);
    let _e179 = local_40;
    let _e181 = other[_e179];
    local_41 = _e181;
    let _e183 = local_41;
    local_23 = _e183;
    let _e185 = local_23;
    local_16 = _e185;
    let _e187 = local_16;
    local_15 = u32(6i);
    let _e191 = local_15;
    local_42 = u32(_e191);
    let _e194 = local_42;
    out[_e194] = _e187;
    let _e196 = source_index;
    local_17 = u32(7i);
    let _e201 = local_17;
    local_43 = u32(_e201);
    let _e204 = local_43;
    out[_e204] = i32(_e196);
}
