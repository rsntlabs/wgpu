@group(0) @binding(0)
var<storage, read_write> output: array<atomic<i32>>;

@compute @workgroup_size(1, 1, 1)
fn kernel() {
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
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: i32;
    var local_29: i32;
    var local_30: i32;
    var local_31: i32;
    var local_32: i32;

    let _e1 = -(3i);
    local_13 = u32(0u);
    let _e7 = local_13;
    loop {
        let _e10 = atomicCompareExchangeWeak((&output[_e7]), _e1, i32(7.75f));
        local_28 = _e10.old_value;
        if (_e10.exchanged || (_e10.old_value != _e1)) {
            break;
        }
    }
    let _e17 = local_28;
    local = u32(8i);
    let _e21 = local;
    local_14 = u32(_e21);
    let _e24 = local_14;
    atomicStore((&output[_e24]), _e17);
    let _e27 = -(3i);
    local_15 = u32(0u);
    let _e31 = local_15;
    loop {
        let _e34 = atomicCompareExchangeWeak((&output[_e31]), _e27, 11i);
        local_29 = _e34.old_value;
        if (_e34.exchanged || (_e34.old_value != _e27)) {
            break;
        }
    }
    let _e41 = local_29;
    local_1 = u32(9i);
    let _e45 = local_1;
    local_16 = u32(_e45);
    let _e48 = local_16;
    atomicStore((&output[_e48]), _e41);
    local_3 = u32(1i);
    let _e56 = (-(2147483647i) - 1i);
    let _e59 = local_3;
    local_17 = u32(_e59);
    let _e62 = local_17;
    loop {
        let _e64 = atomicCompareExchangeWeak((&output[_e62]), _e56, -(7i));
        local_30 = _e64.old_value;
        if (_e64.exchanged || (_e64.old_value != _e56)) {
            break;
        }
    }
    let _e71 = local_30;
    local_2 = u32(10i);
    let _e75 = local_2;
    local_18 = u32(_e75);
    let _e78 = local_18;
    atomicStore((&output[_e78]), _e71);
    local_4 = u32(2i);
    let _e85 = local_4;
    local_19 = u32(_e85);
    let _e88 = local_19;
    loop {
        let _e91 = atomicCompareExchangeWeak((&output[_e88]), 5i, -(4i));
        local_31 = _e91.old_value;
        if (_e91.exchanged || (_e91.old_value != 5i)) {
            break;
        }
    }
    local_6 = u32(2i);
    let _e102 = i32(-(4.75f));
    let _e105 = local_6;
    local_20 = u32(_e105);
    let _e108 = local_20;
    loop {
        let _e110 = atomicCompareExchangeWeak((&output[_e108]), _e102, i32(9.75f));
        local_32 = _e110.old_value;
        if (_e110.exchanged || (_e110.old_value != _e102)) {
            break;
        }
    }
    let _e117 = local_32;
    local_5 = u32(11i);
    let _e121 = local_5;
    local_21 = u32(_e121);
    let _e124 = local_21;
    atomicStore((&output[_e124]), _e117);
    local_8 = u32(0i);
    let _e129 = local_8;
    local_22 = u32(_e129);
    let _e132 = local_22;
    let _e134 = atomicLoad((&output[_e132]));
    local_7 = u32(12i);
    let _e138 = local_7;
    local_23 = u32(_e138);
    let _e141 = local_23;
    atomicStore((&output[_e141]), _e134);
    local_10 = u32(1i);
    let _e146 = local_10;
    local_24 = u32(_e146);
    let _e149 = local_24;
    let _e151 = atomicLoad((&output[_e149]));
    local_9 = u32(13i);
    let _e155 = local_9;
    local_25 = u32(_e155);
    let _e158 = local_25;
    atomicStore((&output[_e158]), _e151);
    local_12 = u32(2i);
    let _e163 = local_12;
    local_26 = u32(_e163);
    let _e166 = local_26;
    let _e168 = atomicLoad((&output[_e166]));
    local_11 = u32(14i);
    let _e172 = local_11;
    local_27 = u32(_e172);
    let _e175 = local_27;
    atomicStore((&output[_e175]), _e168);
}
