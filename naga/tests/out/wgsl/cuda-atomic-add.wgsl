@group(0) @binding(0)
var<storage, read_write> output: array<atomic<i32>>;

@compute @workgroup_size(1, 1, 1)
fn kernel() {
    var index: u32;
    var amount: i32;
    var local: bool;
    var local_1: u32;
    var local_2: i32;
    var local_3: bool;
    var local_4: u32;
    var local_5: i32;
    var local_6: u32;
    var local_7: i32;
    var local_8: u32;
    var local_9: i32;
    var local_10: i32;
    var local_11: u32;
    var local_12: i32;
    var local_13: u32;
    var local_14: i32;
    var local_15: u32;
    var local_16: i32;
    var local_17: u32;
    var local_18: i32;

    let before = atomicLoad((&output[u32(0i)]));
    let previous = atomicAdd((&output[u32(0u)]), -(3i));
    atomicStore((&output[u32(1i)]), before);
    atomicStore((&output[u32(2i)]), previous);
    let _e22 = atomicAdd((&output[u32(0u)]), i32(2.75f));
    let _e26 = atomicLoad((&output[u32(0i)]));
    atomicStore((&output[u32(3i)]), _e26);
    atomicStore((&output[u32(0i)]), 11i);
    let _e38 = atomicAdd((&output[u32(0u)]), 4i);
    atomicStore((&output[u32(4i)]), _e38);
    let _e45 = atomicLoad((&output[u32(0i)]));
    atomicStore((&output[u32(5i)]), _e45);
    index = u32(8i);
    amount = 3i;
    let _e54 = index;
    index = (_e54 + u32(1i));
    let _e58 = amount;
    amount = (_e58 + 1i);
    let _e62 = atomicAdd((&output[_e54]), _e58);
    atomicStore((&output[u32(6i)]), _e62);
    let _e66 = index;
    atomicStore((&output[u32(7i)]), i32(_e66));
    let _e71 = amount;
    atomicStore((&output[u32(9i)]), _e71);
    local = false;
    if false {
        local_1 = u32(8i);
        let _e80 = local_1;
        local_11 = _e80;
        let _e82 = local_11;
        let _e85 = atomicAdd((&output[_e82]), 100i);
        local_12 = _e85;
        let _e87 = local_12;
        local_2 = _e87;
        let _e89 = local_2;
        local = (_e89 != 0i);
    }
    let skipped = local;
    local_3 = true;
    if true {
    } else {
        local_4 = u32(8i);
        let _e98 = local_4;
        local_13 = _e98;
        let _e100 = local_13;
        let _e103 = atomicAdd((&output[_e100]), 100i);
        local_14 = _e103;
        let _e105 = local_14;
        local_5 = _e105;
        let _e107 = local_5;
        local_3 = (_e107 != 0i);
    }
    let ready = local_3;
    atomicStore((&output[u32(10i)]), (i32(skipped) + i32(ready)));
    let _e122 = atomicAdd((&output[u32(0u)]), -(20i));
    atomicStore((&output[u32(11i)]), _e122);
    let _e129 = atomicLoad((&output[u32(0i)]));
    atomicStore((&output[u32(12i)]), _e129);
    let _e136 = atomicLoad((&output[u32(7i)]));
    if (_e136 == 9i) {
        local_6 = u32(8i);
        let _e142 = local_6;
        local_15 = _e142;
        let _e144 = local_15;
        let _e147 = atomicAdd((&output[_e144]), 2i);
        local_16 = _e147;
        let _e149 = local_16;
        local_7 = _e149;
        let _e151 = local_7;
        local_10 = _e151;
    } else {
        local_8 = u32(15i);
        let _e156 = local_8;
        local_17 = _e156;
        let _e158 = local_17;
        let _e161 = atomicAdd((&output[_e158]), 100i);
        local_18 = _e161;
        let _e163 = local_18;
        local_9 = _e163;
        let _e165 = local_9;
        local_10 = _e165;
    }
    let _e168 = local_10;
    atomicStore((&output[u32(13i)]), _e168);
    let _e175 = atomicLoad((&output[u32(8i)]));
    atomicStore((&output[u32(14i)]), _e175);
}
