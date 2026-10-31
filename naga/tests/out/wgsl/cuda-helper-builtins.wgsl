struct type_5 {
    value: f32,
}

struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

struct type_7 {
    value: u32,
}

var<private> threadIdx_1: vec3<u32>;
var<private> blockIdx_1: vec3<u32>;
var<private> gridDim_1: vec3<u32>;
@group(0) @binding(0)
var<storage> input: array<i32>;
@group(0) @binding(1)
var<uniform> scale: type_5;
@group(0) @binding(2)
var<storage> points: array<float3_>;
@group(0) @binding(3)
var<uniform> limit: type_7;
@group(0) @binding(4)
var<storage, read_write> out: array<u32>;

fn thread_component(axis: u32) -> u32 {
    if (axis == 0u) {
        let _e4 = threadIdx_1;
        return _e4.x;
    }
    if (axis == 1u) {
        let _e9 = threadIdx_1;
        return _e9.y;
    }
    let _e12 = threadIdx_1;
    return _e12.z;
}

fn group_component(axis_1: u32) -> u32 {
    if (axis_1 == 0u) {
        let _e4 = blockIdx_1;
        return _e4.x;
    }
    if (axis_1 == 1u) {
        let _e9 = blockIdx_1;
        return _e9.y;
    }
    let _e12 = blockIdx_1;
    return _e12.z;
}

fn shape_component(axis_2: u32) -> u32 {
    if (axis_2 == 0u) {
        return 1u;
    }
    if (axis_2 == 1u) {
        return 1u;
    }
    return 1u;
}

fn grid_component(axis_3: u32) -> u32 {
    if (axis_3 == 0u) {
        let _e4 = gridDim_1;
        return _e4.x;
    }
    if (axis_3 == 1u) {
        let _e9 = gridDim_1;
        return _e9.y;
    }
    let _e12 = gridDim_1;
    return _e12.z;
}

fn component(axis_4: u32) -> u32 {
    let _e1 = thread_component(axis_4);
    return _e1;
}

fn component_1(offset: f32) -> f32 {
    let _e2 = blockIdx_1;
    return (f32(_e2.x) + offset);
}

fn global_x() -> u32 {
    let _e1 = group_component(0u);
    let _e3 = shape_component(0u);
    let _e6 = component(0u);
    return ((_e1 * _e3) + _e6);
}

fn kind(value: u32) -> u32 {
    return 11u;
}

fn observe() {
    let _e1 = gridDim_1;
    if (_e1.z != 0u) {
        return;
    } else {
        return;
    }
}

@compute @workgroup_size(1, 1, 1)
fn coordinates(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(num_workgroups) gridDim: vec3<u32>) {
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

    let scale_1 = scale.value;
    let limit_1 = limit.value;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    gridDim_1 = gridDim;
    let _e12 = global_x();
    if (_e12 >= limit_1) {
        return;
    }
    observe();
    let _e15 = thread_component(0u);
    local = u32(0i);
    let _e19 = local;
    out[_e19] = _e15;
    let _e23 = thread_component(1u);
    local_1 = u32(1i);
    let _e27 = local_1;
    out[_e27] = _e23;
    let _e30 = thread_component(2u);
    local_2 = u32(2i);
    let _e34 = local_2;
    out[_e34] = _e30;
    let _e37 = group_component(0u);
    local_3 = u32(3i);
    let _e41 = local_3;
    out[_e41] = _e37;
    let _e44 = group_component(1u);
    local_4 = u32(4i);
    let _e48 = local_4;
    out[_e48] = _e44;
    let _e51 = group_component(2u);
    local_5 = u32(5i);
    let _e55 = local_5;
    out[_e55] = _e51;
    let _e58 = shape_component(0u);
    local_6 = u32(6i);
    let _e62 = local_6;
    out[_e62] = _e58;
    let _e65 = shape_component(1u);
    local_7 = u32(7i);
    let _e69 = local_7;
    out[_e69] = _e65;
    let _e72 = shape_component(2u);
    local_8 = u32(8i);
    let _e76 = local_8;
    out[_e76] = _e72;
    let _e79 = grid_component(0u);
    local_9 = u32(9i);
    let _e83 = local_9;
    out[_e83] = _e79;
    let _e86 = grid_component(1u);
    local_10 = u32(10i);
    let _e90 = local_10;
    out[_e90] = _e86;
    let _e93 = grid_component(2u);
    local_11 = u32(11i);
    let _e97 = local_11;
    out[_e97] = _e93;
    let _e99 = global_x();
    local_12 = u32(12i);
    let _e103 = local_12;
    out[_e103] = _e99;
    let _e106 = component(0u);
    local_13 = u32(13i);
    let _e110 = local_13;
    out[_e110] = _e106;
    let _e113 = component_1(2.5f);
    local_14 = u32(14i);
    let _e118 = local_14;
    out[_e118] = bitcast<u32>(_e113);
    local_15 = u32(15i);
    let _e124 = local_15;
    out[_e124] = threadIdx.x;
    local_16 = u32(16i);
    let _e130 = local_16;
    out[_e130] = blockIdx.y;
    local_17 = u32(17i);
    let _e136 = local_17;
    out[_e136] = gridDim.z;
    local_18 = u32(18i);
    let _e141 = local_18;
    out[_e141] = 1u;
    local_20 = u32(0i);
    let _e147 = local_20;
    let _e150 = input[_e147];
    local_19 = u32(19i);
    let _e155 = local_19;
    out[_e155] = u32(_e150);
    local_21 = u32(20i);
    let _e161 = local_21;
    out[_e161] = bitcast<u32>(scale_1);
    local_23 = u32(0i);
    let _e166 = local_23;
    let _e170 = points[_e166].x;
    local_22 = u32(21i);
    let _e175 = local_22;
    out[_e175] = bitcast<u32>(_e170);
    local_25 = u32(0i);
    let _e180 = local_25;
    let _e183 = points[_e180].y;
    local_24 = u32(22i);
    let _e188 = local_24;
    out[_e188] = bitcast<u32>(_e183);
    local_27 = u32(0i);
    let _e193 = local_27;
    let _e196 = points[_e193].z;
    local_26 = u32(23i);
    let _e201 = local_26;
    out[_e201] = bitcast<u32>(_e196);
    local_28 = u32(24i);
    let _e206 = local_28;
    out[_e206] = limit_1;
    let _e209 = thread_component(0u);
    let _e211 = group_component(1u);
    let _e214 = shape_component(2u);
    let _e217 = grid_component(0u);
    local_29 = u32(25i);
    let _e222 = local_29;
    out[_e222] = (((_e209 + _e211) + _e214) + _e217);
    let _e224 = global_x();
    let _e225 = global_x();
    local_30 = u32(26i);
    let _e230 = local_30;
    out[_e230] = (_e224 + _e225);
    local_32 = u32(0i);
    let _e235 = local_32;
    let _e237 = input[_e235];
    local_33 = u32(0i);
    let _e243 = local_33;
    let _e246 = points[_e243].x;
    local_31 = u32(27i);
    let _e252 = local_31;
    out[_e252] = bitcast<u32>(((f32(_e237) * scale_1) + _e246));
    let _e255 = kind(threadIdx.x);
    local_34 = u32(28i);
    let _e259 = local_34;
    out[_e259] = _e255;
    let _e262 = grid_component(2u);
    local_35 = u32(29i);
    let _e266 = local_35;
    out[_e266] = _e262;
}
