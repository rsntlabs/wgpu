@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<storage> input: array<u32>;
var<workgroup> values: array<u32, 4>;
@group(0) @binding(0)
var<storage, read_write> output_1: array<u32>;
@group(0) @binding(1)
var<storage> input_1: array<u32>;
var<workgroup> values_1: array<u32, 8>;

fn adjusted_4_(value: u32) -> u32 {
    return (value + u32(4i));
}

fn adjusted_8_(value_1: u32) -> u32 {
    return (value_1 + u32(8i));
}

@compute @workgroup_size(4, 1, 1)
fn reduce_4_(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var stride: u32;
    var local_1: u32;

    let lane = threadIdx.x;
    let base = (blockIdx.x * 4u);
    local = u32((base + lane));
    let _e9 = local;
    let _e12 = input[_e9];
    values[lane] = _e12;
    storageBarrier();
    workgroupBarrier();
    {
        stride = 2u;
        loop {
            let _e17 = stride;
            if (_e17 > 0u) {
            } else {
                break;
            }
            let _e20 = stride;
            if (lane < _e20) {
                let _e22 = stride;
                let _e25 = values[(lane + _e22)];
                let _e27 = values[lane];
                values[lane] = (_e27 + _e25);
            }
            storageBarrier();
            workgroupBarrier();
            continuing {
                let _e29 = stride;
                stride = (_e29 >> 1u);
            }
        }
    }
    let _e34 = values[0i];
    let _e35 = adjusted_4_(_e34);
    local_1 = u32((base + lane));
    let _e39 = local_1;
    output[_e39] = _e35;
}

@compute @workgroup_size(4, 1, 1)
fn reduce_8_(@builtin(local_invocation_id) threadIdx_1: vec3<u32>, @builtin(workgroup_id) blockIdx_1: vec3<u32>) {
    var local_2: u32;
    var stride_1: u32;
    var local_3: u32;

    let lane_1 = threadIdx_1.x;
    let base_1 = (blockIdx_1.x * 4u);
    local_2 = u32((base_1 + lane_1));
    let _e9 = local_2;
    let _e12 = input_1[_e9];
    values_1[lane_1] = _e12;
    storageBarrier();
    workgroupBarrier();
    {
        stride_1 = 2u;
        loop {
            let _e17 = stride_1;
            if (_e17 > 0u) {
            } else {
                break;
            }
            let _e20 = stride_1;
            if (lane_1 < _e20) {
                let _e22 = stride_1;
                let _e25 = values_1[(lane_1 + _e22)];
                let _e27 = values_1[lane_1];
                values_1[lane_1] = (_e27 + _e25);
            }
            storageBarrier();
            workgroupBarrier();
            continuing {
                let _e29 = stride_1;
                stride_1 = (_e29 >> 1u);
            }
        }
    }
    let _e34 = values_1[0i];
    let _e35 = adjusted_8_(_e34);
    local_3 = u32((base_1 + lane_1));
    let _e39 = local_3;
    output_1[_e39] = _e35;
}
