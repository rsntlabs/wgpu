struct Settings_cuda_record_0_ {
    scale: u32,
    bias: u32,
}

struct type_3 {
    value: u32,
}

@group(1) @binding(0)
var<storage> addend: u32;
@group(1) @binding(1)
var<storage> weights: array<u32, 4>;
@group(1) @binding(2)
var<storage> settings: Settings_cuda_record_0_;
@group(0) @binding(0)
var<storage, read_write> output_2: array<u32>;
@group(0) @binding(1)
var<storage> input_3: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_3;
@group(0) @binding(0)
var<storage, read_write> output_3: array<u32>;
@group(0) @binding(1)
var<storage> input_4: array<u32>;
@group(0) @binding(2)
var<uniform> count_1: type_3;

fn weighted_unsigned(input_2: u32, index_1: u32) -> u32 {
    var index_2: u32;
    var local_31: u32;
    var local_32: u32;

    let _e4 = settings.scale;
    index_2 = u32();
    local_31 = u32();
    local_32 = u32();
    index_2 = index_1;
    let _e13 = index_2;
    local_31 = _e13;
    let _e15 = local_31;
    let _e18 = weights[_e15];
    local_32 = _e18;
    let _e20 = local_32;
    let _e23 = addend;
    return (((input_2 * _e4) + _e20) + _e23);
}

@compute @workgroup_size(4, 1, 1)
fn constant_memory(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var output: array<u32, 2>;
    var input: array<u32, 2>;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var value: array<u32, 2>;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: u32;

    output = array<u32, 2>();
    output[0] = 2u;
    output[1] = 0u;
    input = array<u32, 2>();
    input[0] = 3u;
    input[1] = 0u;
    let count_2 = count.value;
    let index_3 = ((blockIdx.x * 4u) + threadIdx.x);
    if (index_3 < count_2) {
        let _e24 = input;
        local_2 = _e24;
        local_3 = index_3;
        let _e27 = local_2;
        local_7 = _e27;
        let _e29 = local_3;
        let _e31 = local_7[1];
        local_7[1] = (_e31 + _e29);
        let _e35 = local_7[0];
        local_8 = u32(_e35);
        let _e39 = local_7[1];
        local_9 = u32(_e39);
        let _e42 = local_9;
        let _e45 = input_3[_e42];
        local_10 = _e45;
        let _e47 = local_10;
        local_6 = _e47;
        let _e49 = local_6;
        let _e52 = weighted_unsigned(_e49, (index_3 % 4u));
        let _e55 = settings.bias;
        value = array<u32, 2>();
        value[0] = 4u;
        value[1] = 0u;
        local_4 = 31u;
        let _e65 = local_4;
        local_5 = 41u;
        let _e69 = local_5;
        let _e72 = output;
        local = _e72;
        local_1 = index_3;
        let _e75 = local;
        local_11 = _e75;
        let _e77 = local_1;
        let _e79 = local_11[1];
        local_11[1] = (_e79 + _e77);
        let _e83 = local_11[0];
        local_12 = u32(_e83);
        let _e87 = local_11[1];
        local_13 = u32(_e87);
        let _e90 = local_13;
        output_2[_e90] = (((_e52 + _e55) + _e65) + _e69);
    }
}

@compute @workgroup_size(4, 1, 1)
fn constant_references(@builtin(workgroup_id) blockIdx_1: vec3<u32>, @builtin(local_invocation_id) threadIdx_1: vec3<u32>) {
    var output_1: array<u32, 2>;
    var input_1: array<u32, 2>;
    var current: Settings_cuda_record_0_;
    var view: array<u32, 2>;
    var local_14: array<u32, 2>;
    var local_15: array<u32, 2>;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var local_18: u32;
    var values: array<u32, 2>;
    var index: u32;
    var local_19: array<u32, 2>;
    var local_20: u32;
    var local_21: u32;
    var value_1: array<u32, 2>;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var local_24: u32;
    var local_25: array<u32, 2>;
    var local_26: u32;
    var local_27: u32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var local_30: u32;

    output_1 = array<u32, 2>();
    output_1[0] = 2u;
    output_1[1] = 0u;
    input_1 = array<u32, 2>();
    input_1[0] = 3u;
    input_1[1] = 0u;
    let count_3 = count_1.value;
    let index_4 = ((blockIdx_1.x * 4u) + threadIdx_1.x);
    if (index_4 >= count_3) {
        return;
    }
    let _e24 = settings;
    current = _e24;
    view = array<u32, 2>();
    view[0] = 4u;
    view[1] = 0u;
    let _e33 = input_1;
    local_15 = _e33;
    index = u32();
    local_20 = u32();
    local_21 = u32();
    values = array<u32, 2>();
    values[0] = 4u;
    values[1] = 0u;
    index = ((index_4 + 1u) % 4u);
    let _e53 = values;
    local_19 = _e53;
    let _e55 = index;
    local_20 = _e55;
    let _e57 = local_19;
    local_22 = _e57;
    let _e59 = local_20;
    let _e61 = local_22[1];
    local_22[1] = (_e61 + _e59);
    let _e65 = local_22[0];
    local_23 = u32(_e65);
    let _e69 = local_22[1];
    local_24 = u32(_e69);
    let _e72 = local_24;
    let _e75 = weights[_e72];
    local_21 = _e75;
    let _e77 = local_21;
    let _e78 = local_15;
    local_25 = _e78;
    let _e81 = local_25[1];
    local_25[1] = (_e81 + index_4);
    let _e85 = local_25[0];
    local_26 = u32(_e85);
    let _e89 = local_25[1];
    local_27 = u32(_e89);
    let _e92 = local_27;
    let _e95 = input_4[_e92];
    let _e98 = addend;
    let _e101 = current.scale;
    let _e104 = current.bias;
    let _e107 = view;
    local_16 = _e107;
    let _e109 = local_16;
    value_1 = _e109;
    local_17 = 37u;
    let _e113 = local_17;
    local_18 = 43u;
    let _e117 = local_18;
    let _e120 = output_1;
    local_14 = _e120;
    let _e122 = local_14;
    local_28 = _e122;
    let _e125 = local_28[1];
    local_28[1] = (_e125 + index_4);
    let _e129 = local_28[0];
    local_29 = u32(_e129);
    let _e133 = local_28[1];
    local_30 = u32(_e133);
    let _e136 = local_30;
    output_3[_e136] = ((((((_e95 + _e77) + _e98) + _e101) + _e104) + _e113) + _e117);
}
