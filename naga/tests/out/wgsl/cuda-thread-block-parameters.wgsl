struct dim3_ {
    x: u32,
    y: u32,
    z: u32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
var<private> blockIdx_3: vec3<u32>;
var<private> gridDim_3: vec3<u32>;
var<private> threadIdx_1: vec3<u32>;
var<workgroup> values: array<u32, 4>;

fn synchronize(blockIdx_1: vec3<u32>, gridDim_1: vec3<u32>) {
    if (dim3_(blockIdx_1.x, blockIdx_1.y, blockIdx_1.z).x < gridDim_1.x) {
        storageBarrier();
        workgroupBarrier();
        return;
    } else {
        return;
    }
}

fn reduce(input: u32, width: u32, blockIdx_2: vec3<u32>, gridDim_2: vec3<u32>) -> u32 {
    var stride: u32;

    let _e5 = threadIdx_1;
    let lane = (_e5.x + (4u * (_e5.y + (1u * _e5.z))));
    values[lane] = input;
    synchronize(blockIdx_2, gridDim_2);
    {
        stride = (width / 2u);
        loop {
            let _e20 = stride;
            if (_e20 > 0u) {
            } else {
                break;
            }
            let _e23 = stride;
            if (lane < _e23) {
                let _e25 = stride;
                let _e29 = values[(lane + _e25)];
                let _e32 = values[lane];
                values[lane] = (_e32 + _e29);
            }
            storageBarrier();
            workgroupBarrier();
            continuing {
                let _e34 = stride;
                stride = (_e34 >> 1u);
            }
        }
    }
    let _e40 = values[0i];
    return _e40;
}

@compute @workgroup_size(4, 1, 1)
fn exchange(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(num_workgroups) gridDim: vec3<u32>) {
    var local: u32;
    var local_1: u32;

    threadIdx_1 = threadIdx;
    blockIdx_3 = blockIdx;
    gridDim_3 = gridDim;
    let lane_1 = (threadIdx.x + (4u * (threadIdx.y + (1u * threadIdx.z))));
    let value = (((blockIdx.x * 10u) + lane_1) + 1u);
    let sum = reduce(value, 4u, blockIdx, gridDim);
    let base = (blockIdx.x * 8u);
    local = u32((base + lane_1));
    let _e29 = local;
    output[_e29] = sum;
    local_1 = u32(((base + 4u) + lane_1));
    let _e42 = local_1;
    output[_e42] = (((value * 10u) + lane_1) + 4u);
}
