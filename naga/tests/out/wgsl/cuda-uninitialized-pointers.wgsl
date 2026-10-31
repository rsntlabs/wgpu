@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;

@compute @workgroup_size(1, 1, 1)
fn kernel() {
    var out: array<u32, 2>;
    var first: array<i32, 3>;
    var second: array<i32, 3>;
    var selected: array<u32, 2>;
    var local: u32;
    var saved: array<u32, 2>;
    var local_1: array<u32, 2>;
    var local_2: u32;
    var view: array<u32, 2>;
    var local_3: array<u32, 2>;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: array<u32, 2>;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: array<u32, 2>;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: array<u32, 2>;
    var local_13: i32;
    var local_14: i32;
    var local_15: i32;
    var local_16: array<u32, 2>;
    var local_17: array<u32, 2>;
    var local_18: array<u32, 2>;
    var local_19: array<u32, 2>;
    var local_20: array<u32, 2>;
    var local_21: u32;
    var local_22: u32;
    var local_23: i32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: u32;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: u32;
    var local_30: i32;
    var local_31: array<u32, 2>;
    var local_32: u32;
    var local_33: u32;
    var local_34: array<u32, 2>;
    var local_35: u32;
    var local_36: u32;
    var local_37: i32;
    var local_38: array<u32, 2>;
    var local_39: u32;
    var local_40: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    first[0] = 2i;
    first[1] = 3i;
    first[2] = 5i;
    second[0] = 7i;
    second[1] = 11i;
    second[2] = 13i;
    local = u32(1i);
    local_16 = array<u32, 2>();
    local_16[0] = 1u;
    local_16[1] = 0u;
    let _e30 = local;
    let _e32 = local_16[1];
    local_16[1] = (_e32 + _e30);
    let _e36 = local_16;
    selected = _e36;
    let _e38 = selected;
    local_1 = _e38;
    let _e40 = local_1;
    local_17 = _e40;
    let _e42 = local_17;
    saved = _e42;
    local_2 = u32(2i);
    local_18 = array<u32, 2>();
    local_18[0] = 2u;
    local_18[1] = 0u;
    let _e52 = local_2;
    let _e54 = local_18[1];
    local_18[1] = (_e54 + _e52);
    let _e57 = local_18;
    selected = _e57;
    let _e59 = selected;
    local_3 = _e59;
    let _e61 = local_3;
    local_19 = _e61;
    let _e63 = local_19;
    view = _e63;
    let _e65 = saved;
    local_6 = _e65;
    let _e67 = local_6;
    local_20 = _e67;
    let _e69 = local_20[0];
    local_21 = u32(_e69);
    let _e73 = local_20[1];
    local_22 = u32(_e73);
    let _e77 = local_21;
    switch _e77 {
        case 1u: {
            let _e78 = local_22;
            let _e80 = first[_e78];
            local_23 = _e80;
        }
        default: {
            let _e81 = local_22;
            let _e83 = second[_e81];
            local_23 = _e83;
        }
    }
    let _e84 = local_23;
    local_13 = _e84;
    let _e86 = local_13;
    let _e89 = out;
    local_4 = _e89;
    local_5 = u32(0i);
    let _e94 = local_4;
    local_24 = _e94;
    let _e95 = local_5;
    let _e97 = local_24[1];
    local_24[1] = (_e97 + _e95);
    let _e101 = local_24[0];
    local_25 = u32(_e101);
    let _e105 = local_24[1];
    local_26 = u32(_e105);
    let _e108 = local_26;
    out_1[_e108] = _e86;
    let _e111 = selected;
    local_9 = _e111;
    let _e113 = local_9;
    local_27 = _e113;
    let _e115 = local_27[0];
    local_28 = u32(_e115);
    let _e119 = local_27[1];
    local_29 = u32(_e119);
    let _e123 = local_28;
    switch _e123 {
        case 1u: {
            let _e124 = local_29;
            let _e126 = first[_e124];
            local_30 = _e126;
        }
        default: {
            let _e127 = local_29;
            let _e129 = second[_e127];
            local_30 = _e129;
        }
    }
    let _e130 = local_30;
    local_14 = _e130;
    let _e132 = local_14;
    let _e134 = out;
    local_7 = _e134;
    local_8 = u32(1i);
    let _e139 = local_7;
    local_31 = _e139;
    let _e140 = local_8;
    let _e142 = local_31[1];
    local_31[1] = (_e142 + _e140);
    let _e146 = local_31[0];
    local_32 = u32(_e146);
    let _e150 = local_31[1];
    local_33 = u32(_e150);
    let _e153 = local_33;
    out_1[_e153] = _e132;
    let _e156 = view;
    local_12 = _e156;
    let _e158 = local_12;
    local_34 = _e158;
    let _e160 = local_34[0];
    local_35 = u32(_e160);
    let _e164 = local_34[1];
    local_36 = u32(_e164);
    let _e168 = local_35;
    switch _e168 {
        case 1u: {
            let _e169 = local_36;
            let _e171 = first[_e169];
            local_37 = _e171;
        }
        default: {
            let _e172 = local_36;
            let _e174 = second[_e172];
            local_37 = _e174;
        }
    }
    let _e175 = local_37;
    local_15 = _e175;
    let _e177 = local_15;
    let _e179 = out;
    local_10 = _e179;
    local_11 = u32(2i);
    let _e184 = local_10;
    local_38 = _e184;
    let _e185 = local_11;
    let _e187 = local_38[1];
    local_38[1] = (_e187 + _e185);
    let _e191 = local_38[0];
    local_39 = u32(_e191);
    let _e195 = local_38[1];
    local_40 = u32(_e195);
    let _e198 = local_40;
    out_1[_e198] = _e177;
}
