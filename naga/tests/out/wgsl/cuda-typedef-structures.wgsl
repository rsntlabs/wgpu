struct Pair_cuda_record_0_ {
    low: u32,
    high: u32,
}

struct PacketTag_cuda_record_1_ {
    pair: Pair_cuda_record_0_,
    samples: array<u32, 2>,
}

struct type_3 {
    value: u32,
}

struct Bias_cuda_record_2_ {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<PacketTag_cuda_record_1_>;
@group(0) @binding(1)
var<storage> input: array<PacketTag_cuda_record_1_>;
@group(0) @binding(2)
var<uniform> count: type_3;
@group(0) @binding(0)
var<storage, read_write> output_1: array<Pair_cuda_record_0_>;
@group(0) @binding(1)
var<storage> input_1: array<Pair_cuda_record_0_>;
@group(0) @binding(2)
var<uniform> count_1: type_3;
@group(0) @binding(0)
var<storage, read_write> output_2: array<PacketTag_cuda_record_1_>;
@group(0) @binding(1)
var<storage> input_2: array<PacketTag_cuda_record_1_>;
@group(0) @binding(2)
var<uniform> count_2: type_3;

fn rotated_pair(value: Pair_cuda_record_0_) -> Pair_cuda_record_0_ {
    var value_1: Pair_cuda_record_0_;
    var local_14: Pair_cuda_record_0_;

    value_1 = value;
    let _e4 = value_1.high;
    local_14.low = _e4;
    let _e8 = value_1.low;
    local_14.high = _e8;
    let _e9 = local_14;
    return _e9;
}

@compute @workgroup_size(4, 1, 1)
fn copy_records_Pair(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: Pair_cuda_record_0_;
    var local_3: u32;
    var local_4: Pair_cuda_record_0_;
    var local_5: u32;

    let count_3 = count_1.value;
    let index = ((blockIdx.x * 4u) + threadIdx.x);
    if (index < count_3) {
        local_1 = index;
        let _e12 = local_1;
        local_3 = _e12;
        let _e14 = local_3;
        let _e17 = input_1[_e14];
        local_4 = _e17;
        let _e19 = local_4;
        local_2 = _e19;
        let _e21 = local_2;
        local = index;
        let _e23 = local;
        local_5 = _e23;
        let _e25 = local_5;
        output_1[_e25] = _e21;
    }
}

@compute @workgroup_size(4, 1, 1)
fn copy_records_PacketTag(@builtin(workgroup_id) blockIdx_1: vec3<u32>, @builtin(local_invocation_id) threadIdx_1: vec3<u32>) {
    var local_6: u32;
    var local_7: u32;
    var local_8: PacketTag_cuda_record_1_;
    var local_9: u32;
    var local_10: PacketTag_cuda_record_1_;
    var local_11: u32;

    let count_4 = count_2.value;
    let index_1 = ((blockIdx_1.x * 4u) + threadIdx_1.x);
    if (index_1 < count_4) {
        local_7 = index_1;
        let _e12 = local_7;
        local_9 = _e12;
        let _e14 = local_9;
        let _e17 = input_2[_e14];
        local_10 = _e17;
        let _e19 = local_10;
        local_8 = _e19;
        let _e21 = local_8;
        local_6 = index_1;
        let _e23 = local_6;
        local_11 = _e23;
        let _e25 = local_11;
        output_2[_e25] = _e21;
    }
}

@compute @workgroup_size(4, 1, 1)
fn transform_records(@builtin(workgroup_id) blockIdx_2: vec3<u32>, @builtin(local_invocation_id) threadIdx_2: vec3<u32>) {
    var bias: Bias_cuda_record_2_;
    var packet: PacketTag_cuda_record_1_;
    var local_12: PacketTag_cuda_record_1_;
    var local_13: PacketTag_cuda_record_1_;

    let count_5 = count.value;
    let index_2 = ((blockIdx_2.x * 4u) + threadIdx_2.x);
    if (index_2 >= count_5) {
        return;
    }
    bias.value = (index_2 + 1u);
    let _e17 = input[index_2];
    local_13 = _e17;
    let _e19 = local_13;
    local_12 = _e19;
    let _e21 = local_12;
    packet = _e21;
    let _e24 = packet.pair;
    let _e25 = rotated_pair(_e24);
    packet.pair = _e25;
    let _e28 = bias.value;
    let _e32 = packet.samples[0i];
    packet.samples[0i] = (_e32 + _e28);
    let _e37 = packet.samples[1i];
    packet.samples[1i] = (_e37 ^ 2779077210u);
    let _e40 = packet;
    output[index_2] = _e40;
}
