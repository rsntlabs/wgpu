struct type_2 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_2;
var<workgroup> values: array<u32, 8>;

@compute @workgroup_size(8, 1, 1)
fn reduce(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var sum: u32;
    var index: u32;
    var local: u32;
    var stride: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;

    let count_1 = count.value;
    let lane = threadIdx.x;
    sum = 0u;
    {
        index = lane;
        loop {
            let _e9 = index;
            if (_e9 < count_1) {
            } else {
                break;
            }
            let _e13 = index;
            local = u32(((blockIdx.x * count_1) + _e13));
            let _e17 = local;
            local_3 = _e17;
            let _e19 = local_3;
            let _e22 = input[_e19];
            local_4 = _e22;
            let _e24 = local_4;
            local_2 = _e24;
            let _e26 = local_2;
            let _e27 = sum;
            sum = (_e27 + _e26);
            continuing {
                let _e29 = index;
                index = (_e29 + 8u);
            }
        }
    }
    let _e32 = sum;
    values[lane] = _e32;
    {
        stride = 4u;
        loop {
            let _e37 = stride;
            if (_e37 > 0u) {
            } else {
                break;
            }
            storageBarrier();
            workgroupBarrier();
            let _e40 = stride;
            if (lane < _e40) {
                let _e42 = stride;
                let _e45 = values[(lane + _e42)];
                let _e47 = values[lane];
                values[lane] = (_e47 + _e45);
            }
            continuing {
                let _e49 = stride;
                stride = (_e49 >> 1u);
            }
        }
    }
    if (lane == 0u) {
        let _e56 = values[0i];
        local_1 = u32(blockIdx.x);
        let _e60 = local_1;
        local_5 = _e60;
        let _e62 = local_5;
        output[_e62] = _e56;
    }
}
