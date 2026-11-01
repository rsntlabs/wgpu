var<workgroup> helper_values: array<u32, 4>;
@group(0) @binding(0)
var<storage, read_write> output_1: array<u32>;
var<workgroup> fixed_values: array<u32, 4>;

fn initialize(index: u32, value: u32) {
    helper_values[index] = value;
    return;
}

@compute @workgroup_size(4, 1, 1)
fn exchange(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var output: array<u32, 2>;
    var neighbor: u32;
    var local: array<u32, 2>;
    var local_1: u32;
    var pointer: array<u32, 2>;
    var local_2: array<u32, 2>;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var local_7: u32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var local_10: u32;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: u32;

    output = array<u32, 2>();
    output[0] = 0u;
    output[1] = 0u;
    let lane = threadIdx.x;
    let base = (blockIdx.x * 8u);
    initialize(lane, (((blockIdx.x * 10u) + lane) + 1u));
    fixed_values[lane] = (100u + lane);
    storageBarrier();
    workgroupBarrier();
    {
        neighbor = ((lane + 1u) % 4u);
        let _e27 = neighbor;
        let _e31 = helper_values[_e27];
        let _e32 = fixed_values[lane];
        let _e35 = output;
        local = _e35;
        local_1 = u32((base + lane));
        let _e40 = local;
        local_5 = _e40;
        let _e42 = local_1;
        let _e44 = local_5[1];
        local_5[1] = (_e44 + _e42);
        let _e48 = local_5[0];
        local_6 = u32(_e48);
        let _e52 = local_5[1];
        local_7 = u32(_e52);
        let _e55 = local_7;
        output_1[_e55] = (_e31 + _e32);
    }
    storageBarrier();
    workgroupBarrier();
    pointer = array<u32, 2>();
    pointer[0] = 1u;
    pointer[1] = 0u;
    let _e65 = pointer;
    local_2 = _e65;
    let _e67 = local_2;
    local_8 = _e67;
    let _e70 = local_8[1];
    local_8[1] = (_e70 + lane);
    let _e74 = local_8[0];
    local_9 = u32(_e74);
    let _e78 = local_8[1];
    local_10 = u32(_e78);
    let _e81 = local_10;
    let _e84 = helper_values[_e81];
    let _e88 = local_10;
    helper_values[_e88] = (_e84 + u32(1i));
    let _e92 = helper_values[lane];
    let _e93 = output;
    local_3 = _e93;
    local_4 = u32(((base + 4u) + lane));
    let _e100 = local_3;
    local_11 = _e100;
    let _e102 = local_4;
    let _e104 = local_11[1];
    local_11[1] = (_e104 + _e102);
    let _e108 = local_11[0];
    local_12 = u32(_e108);
    let _e112 = local_11[1];
    local_13 = u32(_e112);
    let _e115 = local_13;
    output_1[_e115] = _e92;
}
