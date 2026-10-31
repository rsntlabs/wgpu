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

    value_1 = value;
    let _e5 = value_1.serial;
    value_1.serial = (_e5 + u32(bias));
    let _e12 = value_1.weights[0i][1i];
    let _e18 = value_1.samples[1i].position.x;
    value_1.samples[1i].position.x = (_e18 + _e12);
    let _e24 = value_1.samples[0i].tag;
    value_1.weights[1i][0i] = f32(_e24);
    let _e31 = value_1;
    return _e31;
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
    var original: Packet_cuda_record_1_;
    var local: u32;
    var changed: Packet_cuda_record_1_;
    var local_1: Packet_cuda_record_2_;
    var combined: Packet_cuda_record_1_;
    var local_2: u32;
    var local_3: u32;
    var sample: i32;
    var local_4: u32;
    var local_5: u32;
    var row: i32;
    var column: i32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: Packet_cuda_record_1_;
    var local_11: u32;
    var local_12: Packet_cuda_record_1_;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;

    let lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    local = u32(lane);
    let _e6 = local;
    local_11 = u32(_e6);
    let _e9 = local_11;
    let _e12 = input[_e9];
    local_12 = _e12;
    let _e14 = local_12;
    local_10 = _e14;
    let _e16 = local_10;
    original = _e16;
    let _e18 = original;
    let _e22 = adjust(_e18, (3i + i32(lane)));
    changed = _e22;
    {
        local_1.w = 7i;
        local_1.x = 11i;
        let _e31 = local_1.w;
        let _e32 = local_1.x;
        let _e39 = changed.samples[0i].tag;
        changed.samples[0i].tag = (_e39 + u32((_e31 + _e32)));
    }
    let _e41 = changed;
    let _e42 = original;
    let _e43 = operator_u002b(_e41, _e42);
    combined = _e43;
    let _e46 = original.serial;
    let _e53 = combined.weights[0i][0i];
    combined.weights[0i][0i] = (_e53 + f32(_e46));
    let _e56 = combined.serial;
    combined.colour.w = f32(_e56);
    let slot = (lane + 1u);
    let _e63 = combined.serial;
    local_2 = u32(slot);
    let _e66 = local_2;
    local_13 = u32(_e66);
    let _e69 = local_13;
    output[_e69].serial = _e63;
    let _e74 = combined.uv;
    local_3 = u32(slot);
    let _e77 = local_3;
    local_14 = u32(_e77);
    let _e80 = local_14;
    output[_e80].uv = _e74;
    {
        sample = 0i;
        loop {
            let _e85 = sample;
            if (_e85 < 2i) {
            } else {
                break;
            }
            let _e89 = sample;
            let _e91 = combined.samples[_e89];
            local_4 = u32(slot);
            let _e94 = sample;
            local_5 = u32(_e94);
            let _e97 = local_4;
            local_15 = u32(_e97);
            let _e100 = local_15;
            let _e103 = local_5;
            output[_e100].samples[_e103] = _e91;
            continuing {
                let _e105 = sample;
                sample = (_e105 + 1i);
            }
        }
    }
    {
        row = 0i;
        loop {
            let _e110 = row;
            if (_e110 < 2i) {
            } else {
                break;
            }
            {
                column = 0i;
                loop {
                    let _e115 = column;
                    if (_e115 < 2i) {
                    } else {
                        break;
                    }
                    let _e119 = row;
                    let _e121 = column;
                    let _e123 = combined.weights[_e119][_e121];
                    local_6 = u32(slot);
                    let _e126 = row;
                    local_7 = u32(_e126);
                    let _e129 = column;
                    local_8 = u32(_e129);
                    let _e132 = local_6;
                    local_16 = u32(_e132);
                    let _e135 = local_16;
                    let _e138 = local_7;
                    let _e140 = local_8;
                    output[_e135].weights[_e138][_e140] = _e123;
                    continuing {
                        let _e142 = column;
                        column = (_e142 + 1i);
                    }
                }
            }
            continuing {
                let _e145 = row;
                row = (_e145 + 1i);
            }
        }
    }
    let _e149 = combined.colour;
    local_9 = u32(slot);
    let _e152 = local_9;
    local_17 = u32(_e152);
    let _e155 = local_17;
    output[_e155].colour = _e149;
}
