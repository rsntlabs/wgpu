struct type_3 {
    value: i32,
}

@group(0) @binding(0)
var<storage, read_write> output_1: array<i32>;
@group(0) @binding(1)
var<storage> input_1: array<i32>;
@group(0) @binding(2)
var<uniform> offset: type_3;
var<workgroup> shared_values: array<i32, 4>;
@group(0) @binding(0)
var<storage, read_write> output_2: array<i32>;
@group(0) @binding(1)
var<storage> input_2: array<i32>;
@group(0) @binding(2)
var<uniform> offset_1: type_3;
var<workgroup> shared_values_1: array<i32, 4>;
var<private> threadIdx_2: vec3<u32>;
var<private> blockIdx_2: vec3<u32>;
var<private> gridDim_2: vec3<u32>;

fn coordinate() -> u32 {
    let _e1 = threadIdx_2;
    let _e4 = blockIdx_2;
    let _e10 = gridDim_2;
    return (((_e1.x + (_e4.x * 10u)) + _e10.x) + 4u);
}

@compute @workgroup_size(4, 1, 1)
fn next_neighbor(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(num_workgroups) gridDim: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var value: i32;
    var local_2: u32;
    var amount: i32;

    threadIdx_2 = threadIdx;
    blockIdx_2 = blockIdx;
    gridDim_2 = gridDim;
    let offset_2 = offset.value;
    let lane = threadIdx.x;
    let base = (blockIdx.x * 4u);
    local = u32((base + lane));
    let _e16 = local;
    let _e19 = input_1[_e16];
    shared_values[lane] = (_e19 + offset_2);
    storageBarrier();
    workgroupBarrier();
    local_1 = u32(((lane + 1u) % 4u));
    let _e29 = local_1;
    let _e31 = shared_values[_e29];
    value = _e31;
    let _e33 = coordinate();
    amount = i32();
    amount = i32(_e33);
    let _e38 = amount;
    let _e39 = value;
    value = (_e39 + _e38);
    let _e41 = value;
    local_2 = u32((base + lane));
    let _e45 = local_2;
    output_1[_e45] = _e41;
}

@compute @workgroup_size(4, 1, 1)
fn previous_neighbor(@builtin(local_invocation_id) threadIdx_1: vec3<u32>, @builtin(workgroup_id) blockIdx_1: vec3<u32>, @builtin(num_workgroups) gridDim_1: vec3<u32>) {
    var output: array<u32, 2>;
    var input: array<u32, 2>;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: u32;
    var selected: array<u32, 2>;
    var value_1: i32;
    var local_6: array<u32, 2>;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var amount_1: i32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var local_11: u32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: u32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var local_17: u32;

    threadIdx_2 = threadIdx_1;
    blockIdx_2 = blockIdx_1;
    gridDim_2 = gridDim_1;
    output = array<u32, 2>();
    output[0] = 2u;
    output[1] = 0u;
    input = array<u32, 2>();
    input[0] = 3u;
    input[1] = 0u;
    let offset_3 = offset_1.value;
    let lane_1 = threadIdx_1.x;
    let base_1 = (blockIdx_1.x * 4u);
    let _e26 = input;
    local_3 = _e26;
    local_4 = u32((base_1 + lane_1));
    let _e31 = local_3;
    local_9 = _e31;
    let _e33 = local_4;
    let _e35 = local_9[1];
    local_9[1] = (_e35 + _e33);
    let _e39 = local_9[0];
    local_10 = u32(_e39);
    let _e43 = local_9[1];
    local_11 = u32(_e43);
    let _e46 = local_11;
    let _e49 = input_2[_e46];
    shared_values_1[lane_1] = (_e49 - offset_3);
    storageBarrier();
    workgroupBarrier();
    local_5 = u32(((lane_1 + 3u) % 4u));
    selected = array<u32, 2>();
    selected[0] = 4u;
    selected[1] = 0u;
    let _e65 = local_5;
    let _e67 = selected[1];
    selected[1] = (_e67 + _e65);
    let _e71 = selected;
    local_6 = _e71;
    let _e73 = local_6;
    local_12 = _e73;
    let _e76 = local_12[0];
    local_13 = u32(_e76);
    let _e80 = local_12[1];
    local_14 = u32(_e80);
    let _e83 = local_14;
    let _e85 = shared_values_1[_e83];
    value_1 = _e85;
    let _e87 = coordinate();
    amount_1 = i32();
    amount_1 = i32(_e87);
    let _e92 = amount_1;
    let _e93 = value_1;
    value_1 = (_e93 + _e92);
    let _e95 = value_1;
    let _e97 = output;
    local_7 = _e97;
    local_8 = u32((base_1 + lane_1));
    let _e102 = local_7;
    local_15 = _e102;
    let _e104 = local_8;
    let _e106 = local_15[1];
    local_15[1] = (_e106 + _e104);
    let _e110 = local_15[0];
    local_16 = u32(_e110);
    let _e114 = local_15[1];
    local_17 = u32(_e114);
    let _e117 = local_17;
    output_2[_e117] = _e95;
}
