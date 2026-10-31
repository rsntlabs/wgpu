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
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;

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
    local = u32(row);
    let _e73 = local;
    local_9 = u32(_e73);
    let _e76 = local_9;
    output[_e76] = _e70;
    let _e80 = copied.y;
    local_1 = u32((row + 1u));
    let _e85 = local_1;
    local_10 = u32(_e85);
    let _e88 = local_10;
    output[_e88] = _e80;
    let _e91 = copied.z;
    local_2 = u32((row + 2u));
    let _e96 = local_2;
    local_11 = u32(_e96);
    let _e99 = local_11;
    output[_e99] = _e91;
    storageBarrier();
    workgroupBarrier();
    let _e103 = values[next].x;
    local_3 = u32((row + 3u));
    let _e108 = local_3;
    local_12 = u32(_e108);
    let _e111 = local_12;
    output[_e111] = _e103;
    let _e115 = values[next].y;
    local_4 = u32((row + 4u));
    let _e120 = local_4;
    local_13 = u32(_e120);
    let _e123 = local_13;
    output[_e123] = _e115;
    let _e127 = values[next].z;
    local_5 = u32((row + 5u));
    let _e132 = local_5;
    local_14 = u32(_e132);
    let _e135 = local_14;
    output[_e135] = _e127;
    let _e138 = broadcast.x;
    local_6 = u32((row + 6u));
    let _e143 = local_6;
    local_15 = u32(_e143);
    let _e146 = local_15;
    output[_e146] = _e138;
    let _e149 = broadcast.y;
    local_7 = u32((row + 7u));
    let _e154 = local_7;
    local_16 = u32(_e154);
    let _e157 = local_16;
    output[_e157] = _e149;
    let _e160 = broadcast.z;
    local_8 = u32((row + 8u));
    let _e165 = local_8;
    local_17 = u32(_e165);
    let _e168 = local_17;
    output[_e168] = _e160;
}
