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
    var local: u32;
    var lane: u32;
    var group: u32;
    var base: f32;
    var next: u32;
    var copied: float3_;
    var offset: i32;
    var choose_shared: bool;
    var row: u32;
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
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;

    local = 0u;
    lane = threadIdx.x;
    group = blockIdx.x;
    let _e8 = group;
    let _e11 = lane;
    base = f32(((_e8 * 16u) + _e11));
    let _e15 = base;
    let _e18 = base;
    let _e22 = base;
    let _e26 = lane;
    values[_e26] = float3_((_e15 + 0.5f), (-(_e18) - 1.25f), (_e22 + 2.5f));
    let _e29 = lane;
    if (_e29 == 0u) {
        let _e32 = group;
        let _e36 = group;
        let _e40 = group;
        broadcast = float3_((f32(_e32) + 0.25f), (f32(_e36) + 0.5f), (f32(_e40) + 0.75f));
    }
    storageBarrier();
    workgroupBarrier();
    let _e46 = lane;
    next = ((_e46 + 1u) % 8u);
    let _e52 = next;
    let _e54 = values[_e52];
    let _e55 = shift(_e54);
    copied = _e55;
    {
        offset = 1i;
        let _e59 = offset;
        let _e61 = copied.x;
        copied.x = (_e61 + f32(_e59));
    }
    storageBarrier();
    workgroupBarrier();
    let _e64 = lane;
    choose_shared = ((_e64 & 1u) != 0u);
    let _e72 = broadcast.x;
    let _e73 = choose_shared;
    if _e73 {
        let _e74 = lane;
        let _e77 = values[_e74].y;
        values[_e74].y = (_e77 + _e72);
    } else {
        let _e80 = copied.y;
        copied.y = (_e80 + _e72);
    }
    let _e83 = copied.x;
    let _e84 = lane;
    values[_e84].z = _e83;
    let _e87 = group;
    let _e90 = lane;
    row = (((_e87 * 8u) + _e90) * 9u);
    let _e96 = copied.x;
    let _e97 = local;
    local_1 = _e97;
    let _e99 = local_1;
    local_2 = u32(_e99);
    let _e102 = row;
    local_3 = u32(_e102);
    let _e106 = local_2;
    let _e107 = local_3;
    local_28 = u32((_e106 + _e107));
    let _e111 = local_28;
    output[_e111] = _e96;
    let _e114 = copied.y;
    let _e115 = local;
    local_4 = _e115;
    let _e117 = local_4;
    local_5 = u32(_e117);
    let _e120 = row;
    local_6 = u32((_e120 + 1u));
    let _e125 = local_5;
    let _e126 = local_6;
    local_29 = u32((_e125 + _e126));
    let _e130 = local_29;
    output[_e130] = _e114;
    let _e133 = copied.z;
    let _e134 = local;
    local_7 = _e134;
    let _e136 = local_7;
    local_8 = u32(_e136);
    let _e139 = row;
    local_9 = u32((_e139 + 2u));
    let _e144 = local_8;
    let _e145 = local_9;
    local_30 = u32((_e144 + _e145));
    let _e149 = local_30;
    output[_e149] = _e133;
    storageBarrier();
    workgroupBarrier();
    let _e151 = next;
    let _e154 = values[_e151].x;
    let _e155 = local;
    local_10 = _e155;
    let _e157 = local_10;
    local_11 = u32(_e157);
    let _e160 = row;
    local_12 = u32((_e160 + 3u));
    let _e165 = local_11;
    let _e166 = local_12;
    local_31 = u32((_e165 + _e166));
    let _e170 = local_31;
    output[_e170] = _e154;
    let _e172 = next;
    let _e175 = values[_e172].y;
    let _e176 = local;
    local_13 = _e176;
    let _e178 = local_13;
    local_14 = u32(_e178);
    let _e181 = row;
    local_15 = u32((_e181 + 4u));
    let _e186 = local_14;
    let _e187 = local_15;
    local_32 = u32((_e186 + _e187));
    let _e191 = local_32;
    output[_e191] = _e175;
    let _e193 = next;
    let _e196 = values[_e193].z;
    let _e197 = local;
    local_16 = _e197;
    let _e199 = local_16;
    local_17 = u32(_e199);
    let _e202 = row;
    local_18 = u32((_e202 + 5u));
    let _e207 = local_17;
    let _e208 = local_18;
    local_33 = u32((_e207 + _e208));
    let _e212 = local_33;
    output[_e212] = _e196;
    let _e215 = broadcast.x;
    let _e216 = local;
    local_19 = _e216;
    let _e218 = local_19;
    local_20 = u32(_e218);
    let _e221 = row;
    local_21 = u32((_e221 + 6u));
    let _e226 = local_20;
    let _e227 = local_21;
    local_34 = u32((_e226 + _e227));
    let _e231 = local_34;
    output[_e231] = _e215;
    let _e234 = broadcast.y;
    let _e235 = local;
    local_22 = _e235;
    let _e237 = local_22;
    local_23 = u32(_e237);
    let _e240 = row;
    local_24 = u32((_e240 + 7u));
    let _e245 = local_23;
    let _e246 = local_24;
    local_35 = u32((_e245 + _e246));
    let _e250 = local_35;
    output[_e250] = _e234;
    let _e253 = broadcast.z;
    let _e254 = local;
    local_25 = _e254;
    let _e256 = local_25;
    local_26 = u32(_e256);
    let _e259 = row;
    local_27 = u32((_e259 + 8u));
    let _e264 = local_26;
    let _e265 = local_27;
    local_36 = u32((_e264 + _e265));
    let _e269 = local_36;
    output[_e269] = _e253;
}
