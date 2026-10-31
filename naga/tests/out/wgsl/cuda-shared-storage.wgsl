@group(0) @binding(0)
var<storage, read_write> out: array<u32>;
var<workgroup> values: array<u32, 64>;
var<workgroup> signed_value: i32;
var<workgroup> float_value: f32;

@compute @workgroup_size(64, 1, 1)
fn shared_storage(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;

    let lane = threadIdx.x;
    let base = (blockIdx.x * 128u);
    values[lane] = (((blockIdx.x * 1000u) + lane) + 10u);
    let _e15 = values[lane];
    local = u32((base + lane));
    let _e19 = local;
    out[_e19] = _e15;
    if (lane == 0u) {
        signed_value = -(7i);
        float_value = 3.5f;
        let _e29 = signed_value;
        local_1 = u32((base + 64u));
        let _e37 = local_1;
        local_3 = _e37;
        let _e39 = local_3;
        out[_e39] = u32((_e29 + 10i));
        let _e41 = float_value;
        local_2 = u32((base + 65u));
        let _e49 = local_2;
        local_4 = _e49;
        let _e51 = local_4;
        out[_e51] = u32((_e41 * 2f));
    }
}
