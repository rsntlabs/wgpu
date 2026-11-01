@group(0) @binding(0)
var<storage, read_write> output: array<atomic<i32>>;

@compute @workgroup_size(1, 1, 1)
fn kernel() {
    var local: i32;
    var local_1: i32;
    var local_2: i32;
    var local_3: i32;
    var local_4: i32;

    let _e1 = -(3i);
    loop {
        let _e8 = atomicCompareExchangeWeak((&output[u32(0u)]), _e1, i32(7.75f));
        local = _e8.old_value;
        if (_e8.exchanged || (_e8.old_value != _e1)) {
            break;
        }
    }
    let _e15 = local;
    atomicStore((&output[u32(8i)]), _e15);
    let _e20 = -(3i);
    loop {
        let _e25 = atomicCompareExchangeWeak((&output[u32(0u)]), _e20, 11i);
        local_1 = _e25.old_value;
        if (_e25.exchanged || (_e25.old_value != _e20)) {
            break;
        }
    }
    let _e32 = local_1;
    atomicStore((&output[u32(9i)]), _e32);
    let _e41 = (-(2147483647i) - 1i);
    loop {
        let _e45 = atomicCompareExchangeWeak((&output[u32(1i)]), _e41, -(7i));
        local_2 = _e45.old_value;
        if (_e45.exchanged || (_e45.old_value != _e41)) {
            break;
        }
    }
    let _e52 = local_2;
    atomicStore((&output[u32(10i)]), _e52);
    loop {
        let _e62 = atomicCompareExchangeWeak((&output[u32(2i)]), 5i, -(4i));
        local_3 = _e62.old_value;
        if (_e62.exchanged || (_e62.old_value != 5i)) {
            break;
        }
    }
    let _e72 = i32(-(4.75f));
    loop {
        let _e76 = atomicCompareExchangeWeak((&output[u32(2i)]), _e72, i32(9.75f));
        local_4 = _e76.old_value;
        if (_e76.exchanged || (_e76.old_value != _e72)) {
            break;
        }
    }
    let _e83 = local_4;
    atomicStore((&output[u32(11i)]), _e83);
    let _e90 = atomicLoad((&output[u32(0i)]));
    atomicStore((&output[u32(12i)]), _e90);
    let _e97 = atomicLoad((&output[u32(1i)]));
    atomicStore((&output[u32(13i)]), _e97);
    let _e104 = atomicLoad((&output[u32(2i)]));
    atomicStore((&output[u32(14i)]), _e104);
}
