struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

struct Sample_cuda_record_0_ {
    position: float3_,
    tag: u32,
}

struct Packet_cuda_record_1_ {
    serial: u32,
    uv: vec2<f32>,
    samples: array<Sample_cuda_record_0_, 2>,
    weights: array<array<f32, 2>, 2>,
    colour: vec4<f32>,
}

struct Packet_cuda_record_2_ {
    w: i32,
    x: i32,
}

@group(0) @binding(0)
var<storage> input: array<Packet_cuda_record_1_>;
@group(0) @binding(1)
var<storage, read_write> output: array<Packet_cuda_record_1_>;

fn adjust(value: Packet_cuda_record_1_, bias: i32) -> Packet_cuda_record_1_ {
    var value_1: Packet_cuda_record_1_;
    var bias_1: i32;

    value_1 = value;
    bias_1 = bias;
    let _e5 = bias_1;
    let _e7 = value_1.serial;
    value_1.serial = (_e7 + u32(_e5));
    let _e19 = value_1.weights[0i][1i];
    let _e20 = value_1.samples[1i].position.x;
    value_1.samples[1i].position.x = (_e20 + _e19);
    let _e31 = value_1.samples[0i].tag;
    value_1.weights[1i][0i] = f32(_e31);
    let _e33 = value_1;
    return _e33;
}

fn operator_u002b(left: Packet_cuda_record_1_, right: Packet_cuda_record_1_) -> Packet_cuda_record_1_ {
    var left_1: Packet_cuda_record_1_;
    var right_1: Packet_cuda_record_1_;

    left_1 = left;
    right_1 = right;
    let _e6 = right_1.serial;
    let _e7 = left_1.serial;
    left_1.serial = (_e7 + _e6);
    let _e13 = right_1.uv.y;
    let _e14 = left_1.uv.x;
    left_1.uv.x = (_e14 + _e13);
    let _e16 = left_1;
    return _e16;
}

@compute @workgroup_size(2, 1, 1)
fn structures(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var lane: u32;
    var original: Packet_cuda_record_1_;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var changed: Packet_cuda_record_1_;
    var local_5: Packet_cuda_record_2_;
    var combined: Packet_cuda_record_1_;
    var slot: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var sample: i32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var row: i32;
    var column: i32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: Packet_cuda_record_1_;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;

    local = 0u;
    local_1 = 0u;
    lane = threadIdx.x;
    let _e7 = lane;
    if (_e7 >= 2u) {
        return;
    }
    let _e10 = local;
    local_2 = _e10;
    let _e12 = local_2;
    local_3 = u32(_e12);
    let _e15 = lane;
    local_4 = u32(_e15);
    let _e19 = local_3;
    let _e20 = local_4;
    local_24 = u32((_e19 + _e20));
    let _e25 = local_24;
    let _e27 = input[_e25];
    local_25 = _e27;
    let _e28 = local_25;
    original = _e28;
    let _e30 = original;
    let _e31 = lane;
    let _e35 = adjust(_e30, (3i + i32(_e31)));
    changed = _e35;
    {
        local_5.w = 7i;
        local_5.x = 11i;
        let _e44 = local_5.w;
        let _e45 = local_5.x;
        let _e52 = changed.samples[0i].tag;
        changed.samples[0i].tag = (_e52 + u32((_e44 + _e45)));
    }
    let _e54 = changed;
    let _e55 = original;
    let _e56 = operator_u002b(_e54, _e55);
    combined = _e56;
    let _e59 = original.serial;
    let _e66 = combined.weights[0i][0i];
    combined.weights[0i][0i] = (_e66 + f32(_e59));
    let _e69 = combined.serial;
    combined.colour.w = f32(_e69);
    let _e73 = lane;
    slot = (_e73 + 1u);
    let _e78 = combined.serial;
    let _e79 = local_1;
    local_6 = _e79;
    let _e81 = local_6;
    local_7 = u32(_e81);
    let _e84 = slot;
    local_8 = u32(_e84);
    let _e88 = local_7;
    let _e89 = local_8;
    local_26 = u32((_e88 + _e89));
    let _e93 = local_26;
    output[_e93].serial = _e78;
    let _e97 = combined.uv;
    let _e98 = local_1;
    local_9 = _e98;
    let _e100 = local_9;
    local_10 = u32(_e100);
    let _e103 = slot;
    local_11 = u32(_e103);
    let _e106 = local_10;
    let _e107 = local_11;
    local_27 = u32((_e106 + _e107));
    let _e111 = local_27;
    output[_e111].uv = _e97;
    {
        sample = 0i;
        loop {
            let _e116 = sample;
            if (_e116 < 2i) {
            } else {
                break;
            }
            let _e120 = sample;
            let _e122 = combined.samples[_e120];
            let _e123 = local_1;
            local_12 = _e123;
            let _e125 = local_12;
            local_13 = u32(_e125);
            let _e128 = slot;
            local_14 = u32(_e128);
            let _e131 = sample;
            local_15 = u32(_e131);
            let _e134 = local_13;
            let _e135 = local_14;
            local_28 = u32((_e134 + _e135));
            let _e139 = local_28;
            let _e142 = local_15;
            output[_e139].samples[_e142] = _e122;
            continuing {
                let _e144 = sample;
                sample = (_e144 + 1i);
            }
        }
    }
    {
        row = 0i;
        loop {
            let _e149 = row;
            if (_e149 < 2i) {
            } else {
                break;
            }
            {
                column = 0i;
                loop {
                    let _e154 = column;
                    if (_e154 < 2i) {
                    } else {
                        break;
                    }
                    let _e158 = row;
                    let _e160 = column;
                    let _e162 = combined.weights[_e158][_e160];
                    let _e163 = local_1;
                    local_16 = _e163;
                    let _e165 = local_16;
                    local_17 = u32(_e165);
                    let _e168 = slot;
                    local_18 = u32(_e168);
                    let _e171 = row;
                    local_19 = u32(_e171);
                    let _e174 = column;
                    local_20 = u32(_e174);
                    let _e177 = local_17;
                    let _e178 = local_18;
                    local_29 = u32((_e177 + _e178));
                    let _e182 = local_29;
                    let _e185 = local_19;
                    let _e187 = local_20;
                    output[_e182].weights[_e185][_e187] = _e162;
                    continuing {
                        let _e189 = column;
                        column = (_e189 + 1i);
                    }
                }
            }
            continuing {
                let _e192 = row;
                row = (_e192 + 1i);
            }
        }
    }
    let _e196 = combined.colour;
    let _e197 = local_1;
    local_21 = _e197;
    let _e199 = local_21;
    local_22 = u32(_e199);
    let _e202 = slot;
    local_23 = u32(_e202);
    let _e205 = local_22;
    let _e206 = local_23;
    local_30 = u32((_e205 + _e206));
    let _e210 = local_30;
    output[_e210].colour = _e196;
}
