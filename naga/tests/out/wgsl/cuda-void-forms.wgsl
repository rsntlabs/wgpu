@group(0) @binding(0)
var<storage, read_write> output: array<i32>;

@compute @workgroup_size(4, 1, 1)
fn void_forms(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var value: i32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var index: i32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var Count: i32;
    var local_6: i32;
    var array_: array<i32, 3>;
    var local_7: u32;

    let lane = threadIdx.x;
    let base = (4u + (lane * 6u));
    value = i32(lane);
    let _e8 = value;
    value = (_e8 + 1i);
    let _e11 = value;
    value = (_e11 + 1i);
    let _e14 = value;
    output[base] = _e14;
    let _e17 = value;
    value = (_e17 + 1i);
    let _e20 = value;
    value = (_e20 + 1i);
    let _e23 = value;
    local = u32((base + 1u));
    let _e28 = local;
    output[_e28] = _e23;
    if ((lane & 1u) == 0u) {
        let _e34 = value;
        value = (_e34 + 3i);
    } else {
        let _e37 = value;
        value = (_e37 + 7i);
    }
    let _e40 = value;
    local_1 = u32((base + 2u));
    let _e45 = local_1;
    output[_e45] = _e40;
    let _e47 = value;
    value = (_e47 + 1i);
    let _e50 = value;
    value = (_e50 + 1i);
    let _e53 = value;
    local_2 = u32((base + 3u));
    let _e58 = local_2;
    output[_e58] = _e53;
    index = 0i;
    let _e62 = index;
    index = (_e62 + 1i);
    local_3 = u32(_e62);
    let _e67 = index;
    index = (_e67 + 1i);
    local_4 = u32(_e67);
    let _e72 = index;
    local_5 = u32((base + 4u));
    let _e77 = local_5;
    output[_e77] = _e72;
    Count = 3i;
    array_ = array<i32, 3>();
    let _e85 = array_[2i];
    local_7 = u32((base + 5u));
    let _e90 = local_7;
    output[_e90] = _e85;
}
