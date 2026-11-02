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
    var local_13: array<u32, 2>;
    var local_14: array<u32, 2>;
    var local_15: array<u32, 2>;
    var local_16: array<u32, 2>;
    var local_17: array<u32, 2>;
    var local_18: u32;
    var local_19: u32;
    var local_20: i32;
    var local_21: array<u32, 2>;
    var local_22: u32;
    var local_23: u32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: u32;
    var local_27: i32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var local_30: u32;
    var local_31: array<u32, 2>;
    var local_32: u32;
    var local_33: u32;
    var local_34: i32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var local_37: u32;

    out = array<u32, 2>();
    out[0] = 2u;
    out[1] = 0u;
    first[0] = 2i;
    first[1] = 3i;
    first[2] = 5i;
    second[0] = 7i;
    second[1] = 11i;
    second[2] = 13i;
    local = u32(1i);
    local_13 = array<u32, 2>();
    local_13[0] = 3u;
    local_13[1] = 0u;
    let _e29 = local;
    let _e31 = local_13[1];
    local_13[1] = (_e31 + _e29);
    let _e34 = local_13;
    selected = _e34;
    let _e36 = selected;
    local_1 = _e36;
    let _e38 = local_1;
    local_14 = _e38;
    let _e40 = local_14;
    saved = _e40;
    local_2 = u32(2i);
    local_15 = array<u32, 2>();
    local_15[0] = 4u;
    local_15[1] = 0u;
    let _e51 = local_2;
    let _e53 = local_15[1];
    local_15[1] = (_e53 + _e51);
    let _e56 = local_15;
    selected = _e56;
    let _e57 = selected;
    local_3 = _e57;
    let _e59 = local_3;
    local_16 = _e59;
    let _e61 = local_16;
    view = _e61;
    let _e63 = saved;
    local_6 = _e63;
    let _e65 = local_6;
    local_17 = _e65;
    let _e68 = local_17[0];
    local_18 = u32(_e68);
    let _e72 = local_17[1];
    local_19 = u32(_e72);
    let _e75 = local_18;
    switch _e75 {
        case 3u: {
            let _e76 = local_19;
            let _e78 = first[_e76];
            local_20 = _e78;
        }
        default: {
            let _e80 = local_19;
            let _e82 = second[_e80];
            local_20 = _e82;
        }
    }
    let _e85 = local_20;
    let _e87 = out;
    local_4 = _e87;
    local_5 = u32(0i);
    let _e92 = local_4;
    local_21 = _e92;
    let _e94 = local_5;
    let _e96 = local_21[1];
    local_21[1] = (_e96 + _e94);
    let _e100 = local_21[0];
    local_22 = u32(_e100);
    let _e104 = local_21[1];
    local_23 = u32(_e104);
    let _e107 = local_23;
    out_1[_e107] = _e85;
    let _e110 = selected;
    local_9 = _e110;
    let _e112 = local_9;
    local_24 = _e112;
    let _e115 = local_24[0];
    local_25 = u32(_e115);
    let _e119 = local_24[1];
    local_26 = u32(_e119);
    let _e122 = local_25;
    switch _e122 {
        case 3u: {
            let _e123 = local_26;
            let _e125 = first[_e123];
            local_27 = _e125;
        }
        default: {
            let _e127 = local_26;
            let _e129 = second[_e127];
            local_27 = _e129;
        }
    }
    let _e132 = local_27;
    let _e133 = out;
    local_7 = _e133;
    local_8 = u32(1i);
    let _e138 = local_7;
    local_28 = _e138;
    let _e140 = local_8;
    let _e142 = local_28[1];
    local_28[1] = (_e142 + _e140);
    let _e146 = local_28[0];
    local_29 = u32(_e146);
    let _e150 = local_28[1];
    local_30 = u32(_e150);
    let _e153 = local_30;
    out_1[_e153] = _e132;
    let _e155 = view;
    local_12 = _e155;
    let _e157 = local_12;
    local_31 = _e157;
    let _e160 = local_31[0];
    local_32 = u32(_e160);
    let _e164 = local_31[1];
    local_33 = u32(_e164);
    let _e167 = local_32;
    switch _e167 {
        case 3u: {
            let _e168 = local_33;
            let _e170 = first[_e168];
            local_34 = _e170;
        }
        default: {
            let _e172 = local_33;
            let _e174 = second[_e172];
            local_34 = _e174;
        }
    }
    let _e177 = local_34;
    let _e178 = out;
    local_10 = _e178;
    local_11 = u32(2i);
    let _e183 = local_10;
    local_35 = _e183;
    let _e185 = local_11;
    let _e187 = local_35[1];
    local_35[1] = (_e187 + _e185);
    let _e191 = local_35[0];
    local_36 = u32(_e191);
    let _e195 = local_35[1];
    local_37 = u32(_e195);
    let _e198 = local_37;
    out_1[_e198] = _e177;
}
