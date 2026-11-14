struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

struct Inner_cuda_record_0_ {
    vector: float3_,
    row: array<i32, 3>,
}

struct Record_cuda_record_1_ {
    scalar: i32,
    vector: float3_,
    matrix: array<array<i32, 3>, 2>,
    nested: Inner_cuda_record_0_,
}

struct Local_cuda_record_2_ {
    token: u32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

@compute @workgroup_size(4, 1, 1)
fn record_assertions(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var value: Record_cuda_record_1_;
    var local: Local_cuda_record_2_;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;

    let lane = threadIdx.x;
    value.scalar = i32((lane + 3u));
    value.vector = float3_(1f, 2f, f32((lane + 5u)));
    value.matrix[1i][2i] = i32((lane + 9u));
    value.nested.row[2i] = i32((lane + 15u));
    local.token = (lane + 21u);
    let index = (4u + (lane * 8u));
    let _e38 = value.scalar;
    output[index] = u32(_e38);
    let _e44 = value.vector.z;
    local_1 = u32((index + 1u));
    let _e50 = local_1;
    output[_e50] = u32(_e44);
    let _e57 = value.matrix[1i][2i];
    local_2 = u32((index + 2u));
    let _e63 = local_2;
    output[_e63] = u32(_e57);
    let _e69 = value.nested.row[2i];
    local_3 = u32((index + 3u));
    let _e75 = local_3;
    output[_e75] = u32(_e69);
    local_4 = u32((index + 4u));
    let _e83 = local_4;
    output[_e83] = u32(64lu);
    local_5 = u32((index + 5u));
    let _e91 = local_5;
    output[_e91] = u32(24lu);
    local_6 = u32((index + 6u));
    let _e99 = local_6;
    output[_e99] = u32(12lu);
    let _e102 = local.token;
    local_7 = u32((index + 7u));
    let _e107 = local_7;
    output[_e107] = _e102;
}
