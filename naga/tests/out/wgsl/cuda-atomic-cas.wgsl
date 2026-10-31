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
    var local_15: i32;
    var local_16: i32;
    var local_17: i32;
    var local_18: i32;
    var local_19: i32;

    let _e1 = -(3i);
    local_13 = u32(0u);
    let _e7 = local_13;
    loop {
        let _e10 = atomicCompareExchangeWeak((&output[_e7]), _e1, i32(7.75f));
        local_15 = _e10.old_value;
        if (_e10.exchanged || (_e10.old_value != _e1)) {
            break;
        }
    }
    let _e17 = local_15;
    local = u32(8i);
    let _e21 = local;
    atomicStore((&output[_e21]), _e17);
    let _e24 = -(3i);
    local_14 = u32(0u);
    let _e28 = local_14;
    loop {
        let _e31 = atomicCompareExchangeWeak((&output[_e28]), _e24, 11i);
        local_16 = _e31.old_value;
        if (_e31.exchanged || (_e31.old_value != _e24)) {
            break;
        }
    }
    let _e38 = local_16;
    local_1 = u32(9i);
    let _e42 = local_1;
    atomicStore((&output[_e42]), _e38);
    local_3 = u32(1i);
    let _e50 = (-(2147483647i) - 1i);
    let _e53 = local_3;
    loop {
        let _e55 = atomicCompareExchangeWeak((&output[_e53]), _e50, -(7i));
        local_17 = _e55.old_value;
        if (_e55.exchanged || (_e55.old_value != _e50)) {
            break;
        }
    }
    let _e62 = local_17;
    local_2 = u32(10i);
    let _e66 = local_2;
    atomicStore((&output[_e66]), _e62);
    local_4 = u32(2i);
    let _e73 = local_4;
    loop {
        let _e76 = atomicCompareExchangeWeak((&output[_e73]), 5i, -(4i));
        local_18 = _e76.old_value;
        if (_e76.exchanged || (_e76.old_value != 5i)) {
            break;
        }
    }
    local_6 = u32(2i);
    let _e87 = i32(-(4.75f));
    let _e90 = local_6;
    loop {
        let _e92 = atomicCompareExchangeWeak((&output[_e90]), _e87, i32(9.75f));
        local_19 = _e92.old_value;
        if (_e92.exchanged || (_e92.old_value != _e87)) {
            break;
        }
    }
    let _e99 = local_19;
    local_5 = u32(11i);
    let _e103 = local_5;
    atomicStore((&output[_e103]), _e99);
    local_8 = u32(0i);
    let _e108 = local_8;
    let _e110 = atomicLoad((&output[_e108]));
    local_7 = u32(12i);
    let _e114 = local_7;
    atomicStore((&output[_e114]), _e110);
    local_10 = u32(1i);
    let _e119 = local_10;
    let _e121 = atomicLoad((&output[_e119]));
    local_9 = u32(13i);
    let _e125 = local_9;
    atomicStore((&output[_e125]), _e121);
    local_12 = u32(2i);
    let _e130 = local_12;
    let _e132 = atomicLoad((&output[_e130]));
    local_11 = u32(14i);
    let _e136 = local_11;
    atomicStore((&output[_e136]), _e132);
}
