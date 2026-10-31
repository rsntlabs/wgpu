struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<f32>;
var<workgroup> values: array<float3_, 8>;
var<workgroup> broadcast: float3_;

fn shift(value: float3_) -> float3_ {
    var value_1: float3_;

    value_1 = value;
    let _e4 = value_1.x;
    value_1.x = (_e4 + 1f);
    let _e9 = value_1.z;
    let _e10 = value_1.y;
    value_1.y = (_e9 - _e10);
    let _e12 = value_1;
    return _e12;
}

@compute @workgroup_size(8, 1, 1)
fn shared_vectors(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var copied: float3_;
    var offset: i32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;

    let lane = threadIdx.x;
    let group = blockIdx.x;
    let base = f32(((group * 16u) + lane));
    values[lane] = float3_((base + 0.5f), (-(base) - 1.25f), (base + 2.5f));
    if (lane == 0u) {
        broadcast = float3_((f32(group) + 0.25f), (f32(group) + 0.5f), (f32(group) + 0.75f));
    }
    storageBarrier();
    workgroupBarrier();
    let next = ((lane + 1u) % 8u);
    let _e36 = values[next];
    let _e37 = shift(_e36);
    copied = _e37;
    {
        offset = 1i;
        let _e41 = offset;
        let _e43 = copied.x;
        copied.x = (_e43 + f32(_e41));
    }
    storageBarrier();
    workgroupBarrier();
    let choose_shared = ((lane & 1u) != 0u);
    let _e52 = broadcast.x;
    if choose_shared {
        let _e55 = values[lane].y;
        values[lane].y = (_e55 + _e52);
    } else {
        let _e58 = copied.y;
        copied.y = (_e58 + _e52);
    }
    let _e61 = copied.x;
    values[lane].z = _e61;
    let row = (((group * 8u) + lane) * 9u);
    let _e70 = copied.x;
    output[row] = _e70;
    let _e74 = copied.y;
    local = u32((row + 1u));
    let _e79 = local;
    output[_e79] = _e74;
    let _e82 = copied.z;
    local_1 = u32((row + 2u));
    let _e87 = local_1;
    output[_e87] = _e82;
    storageBarrier();
    workgroupBarrier();
    let _e91 = values[next].x;
    local_2 = u32((row + 3u));
    let _e96 = local_2;
    output[_e96] = _e91;
    let _e100 = values[next].y;
    local_3 = u32((row + 4u));
    let _e105 = local_3;
    output[_e105] = _e100;
    let _e109 = values[next].z;
    local_4 = u32((row + 5u));
    let _e114 = local_4;
    output[_e114] = _e109;
    let _e117 = broadcast.x;
    local_5 = u32((row + 6u));
    let _e122 = local_5;
    output[_e122] = _e117;
    let _e125 = broadcast.y;
    local_6 = u32((row + 7u));
    let _e130 = local_6;
    output[_e130] = _e125;
    let _e133 = broadcast.z;
    local_7 = u32((row + 8u));
    let _e138 = local_7;
    output[_e138] = _e133;
}
