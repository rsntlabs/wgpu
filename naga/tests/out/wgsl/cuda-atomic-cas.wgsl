@group(0) @binding(0)
var<storage, read_write> output: array<atomic<i32>>;

@compute @workgroup_size(1, 1, 1)
fn kernel() {
    var local: u32;
    var local_1: i32;
    var local_2: u32;
    var local_3: i32;
    var local_4: u32;
    var local_5: u32;
    var local_6: i32;
    var local_7: u32;
    var local_8: i32;
    var local_9: u32;
    var local_10: u32;
    var local_11: i32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: i32;
    var local_19: i32;
    var local_20: i32;
    var local_21: u32;
    var local_22: i32;
    var local_23: u32;
    var local_24: u32;
    var local_25: i32;
    var local_26: u32;
    var local_27: u32;
    var local_28: i32;
    var local_29: u32;
    var local_30: u32;
    var local_31: i32;
    var local_32: u32;
    var local_33: i32;
    var local_34: u32;
    var local_35: u32;
    var local_36: i32;
    var local_37: u32;
    var local_38: u32;
    var local_39: i32;
    var local_40: u32;
    var local_41: u32;
    var local_42: i32;
    var local_43: u32;
    var local_44: i32;
    var local_45: i32;
    var local_46: i32;
    var local_47: i32;
    var local_48: i32;

    let _e1 = -(3i);
    local_21 = u32(0u);
    let _e7 = local_21;
    loop {
        let _e11 = atomicCompareExchangeWeak((&output[_e7]), _e1, i32(7.75f));
        local_44 = _e11.old_value;
        if (_e11.exchanged || (_e11.old_value != _e1)) {
            break;
        }
    }
    let _e16 = local_44;
    local_22 = _e16;
    let _e18 = local_22;
    local_1 = _e18;
    let _e20 = local_1;
    local = u32(8i);
    let _e24 = local;
    local_23 = u32(_e24);
    let _e27 = local_23;
    atomicStore((&output[_e27]), _e20);
    let _e30 = -(3i);
    local_24 = u32(0u);
    let _e34 = local_24;
    loop {
        let _e38 = atomicCompareExchangeWeak((&output[_e34]), _e30, 11i);
        local_45 = _e38.old_value;
        if (_e38.exchanged || (_e38.old_value != _e30)) {
            break;
        }
    }
    let _e43 = local_45;
    local_25 = _e43;
    let _e45 = local_25;
    local_3 = _e45;
    let _e47 = local_3;
    local_2 = u32(9i);
    let _e51 = local_2;
    local_26 = u32(_e51);
    let _e54 = local_26;
    atomicStore((&output[_e54]), _e47);
    local_5 = u32(1i);
    let _e62 = (-(2147483647i) - 1i);
    let _e65 = local_5;
    local_27 = u32(_e65);
    let _e68 = local_27;
    loop {
        let _e71 = atomicCompareExchangeWeak((&output[_e68]), _e62, -(7i));
        local_46 = _e71.old_value;
        if (_e71.exchanged || (_e71.old_value != _e62)) {
            break;
        }
    }
    let _e76 = local_46;
    local_28 = _e76;
    let _e78 = local_28;
    local_6 = _e78;
    let _e80 = local_6;
    local_4 = u32(10i);
    let _e84 = local_4;
    local_29 = u32(_e84);
    let _e87 = local_29;
    atomicStore((&output[_e87]), _e80);
    local_7 = u32(2i);
    let _e94 = local_7;
    local_30 = u32(_e94);
    let _e97 = local_30;
    loop {
        let _e101 = atomicCompareExchangeWeak((&output[_e97]), 5i, -(4i));
        local_47 = _e101.old_value;
        if (_e101.exchanged || (_e101.old_value != 5i)) {
            break;
        }
    }
    let _e106 = local_47;
    local_31 = _e106;
    let _e108 = local_31;
    local_8 = _e108;
    local_10 = u32(2i);
    let _e115 = i32(-(4.75f));
    let _e118 = local_10;
    local_32 = u32(_e118);
    let _e121 = local_32;
    loop {
        let _e124 = atomicCompareExchangeWeak((&output[_e121]), _e115, i32(9.75f));
        local_48 = _e124.old_value;
        if (_e124.exchanged || (_e124.old_value != _e115)) {
            break;
        }
    }
    let _e129 = local_48;
    local_33 = _e129;
    let _e131 = local_33;
    local_11 = _e131;
    let _e133 = local_11;
    local_9 = u32(11i);
    let _e137 = local_9;
    local_34 = u32(_e137);
    let _e140 = local_34;
    atomicStore((&output[_e140]), _e133);
    local_13 = u32(0i);
    let _e145 = local_13;
    local_35 = u32(_e145);
    let _e148 = local_35;
    let _e150 = atomicLoad((&output[_e148]));
    local_36 = _e150;
    let _e152 = local_36;
    local_18 = _e152;
    let _e154 = local_18;
    local_12 = u32(12i);
    let _e158 = local_12;
    local_37 = u32(_e158);
    let _e161 = local_37;
    atomicStore((&output[_e161]), _e154);
    local_15 = u32(1i);
    let _e166 = local_15;
    local_38 = u32(_e166);
    let _e169 = local_38;
    let _e171 = atomicLoad((&output[_e169]));
    local_39 = _e171;
    let _e173 = local_39;
    local_19 = _e173;
    let _e175 = local_19;
    local_14 = u32(13i);
    let _e179 = local_14;
    local_40 = u32(_e179);
    let _e182 = local_40;
    atomicStore((&output[_e182]), _e175);
    local_17 = u32(2i);
    let _e187 = local_17;
    local_41 = u32(_e187);
    let _e190 = local_41;
    let _e192 = atomicLoad((&output[_e190]));
    local_42 = _e192;
    let _e194 = local_42;
    local_20 = _e194;
    let _e196 = local_20;
    local_16 = u32(14i);
    let _e200 = local_16;
    local_43 = u32(_e200);
    let _e203 = local_43;
    atomicStore((&output[_e203]), _e196);
}
