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
    out[u32(0i)] = _e15;
    let _e21 = thread_component(1u);
    out[u32(1i)] = _e21;
    let _e26 = thread_component(2u);
    out[u32(2i)] = _e26;
    let _e31 = group_component(0u);
    out[u32(3i)] = _e31;
    let _e36 = group_component(1u);
    out[u32(4i)] = _e36;
    let _e41 = group_component(2u);
    out[u32(5i)] = _e41;
    let _e46 = shape_component(0u);
    out[u32(6i)] = _e46;
    let _e51 = shape_component(1u);
    out[u32(7i)] = _e51;
    let _e56 = shape_component(2u);
    out[u32(8i)] = _e56;
    let _e61 = grid_component(0u);
    out[u32(9i)] = _e61;
    let _e66 = grid_component(1u);
    out[u32(10i)] = _e66;
    let _e71 = grid_component(2u);
    out[u32(11i)] = _e71;
    let _e75 = global_x();
    out[u32(12i)] = _e75;
    let _e80 = component(0u);
    out[u32(13i)] = _e80;
    let _e85 = component_1(2.5f);
    out[u32(14i)] = bitcast<u32>(_e85);
    out[u32(15i)] = threadIdx.x;
    out[u32(16i)] = blockIdx.y;
    out[u32(17i)] = gridDim.z;
    out[u32(18i)] = 1u;
    let _e110 = input[u32(0i)];
    out[u32(19i)] = u32(_e110);
    out[u32(20i)] = bitcast<u32>(scale_1);
    let _e124 = points[u32(0i)].x;
    out[u32(21i)] = bitcast<u32>(_e124);
    let _e133 = points[u32(0i)].y;
    out[u32(22i)] = bitcast<u32>(_e133);
    let _e142 = points[u32(0i)].z;
    out[u32(23i)] = bitcast<u32>(_e142);
    out[u32(24i)] = limit_1;
    let _e151 = thread_component(0u);
    let _e153 = group_component(1u);
    let _e156 = shape_component(2u);
    let _e159 = grid_component(0u);
    out[u32(25i)] = (((_e151 + _e153) + _e156) + _e159);
    let _e164 = global_x();
    let _e165 = global_x();
    out[u32(26i)] = (_e164 + _e165);
    let _e173 = input[u32(0i)];
    let _e180 = points[u32(0i)].x;
    out[u32(27i)] = bitcast<u32>(((f32(_e173) * scale_1) + _e180));
    let _e187 = kind(threadIdx.x);
    out[u32(28i)] = _e187;
    let _e192 = grid_component(2u);
    out[u32(29i)] = _e192;
}
