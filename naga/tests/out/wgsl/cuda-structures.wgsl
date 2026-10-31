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
    var changed: Packet_cuda_record_1_;
    var local: Packet_cuda_record_2_;
    var combined: Packet_cuda_record_1_;
    var sample: i32;
    var local_1: u32;
    var local_2: u32;
    var row: i32;
    var column: i32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: Packet_cuda_record_1_;
    var local_7: Packet_cuda_record_1_;
    var local_8: u32;
    var local_9: u32;

    let lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    let _e6 = input[lane];
    local_7 = _e6;
    let _e8 = local_7;
    local_6 = _e8;
    let _e10 = local_6;
    original = _e10;
    let _e12 = original;
    let _e16 = adjust(_e12, (3i + i32(lane)));
    changed = _e16;
    {
        local.w = 7i;
        local.x = 11i;
        let _e25 = local.w;
        let _e26 = local.x;
        let _e33 = changed.samples[0i].tag;
        changed.samples[0i].tag = (_e33 + u32((_e25 + _e26)));
    }
    let _e35 = changed;
    let _e36 = original;
    let _e37 = operator_u002b(_e35, _e36);
    combined = _e37;
    let _e40 = original.serial;
    let _e47 = combined.weights[0i][0i];
    combined.weights[0i][0i] = (_e47 + f32(_e40));
    let _e50 = combined.serial;
    combined.colour.w = f32(_e50);
    let slot = (lane + 1u);
    let _e57 = combined.serial;
    output[slot].serial = _e57;
    let _e62 = combined.uv;
    output[slot].uv = _e62;
    {
        sample = 0i;
        loop {
            let _e67 = sample;
            if (_e67 < 2i) {
            } else {
                break;
            }
            let _e71 = sample;
            let _e73 = combined.samples[_e71];
            local_1 = slot;
            let _e75 = sample;
            local_2 = u32(_e75);
            let _e78 = local_1;
            local_8 = _e78;
            let _e80 = local_8;
            let _e83 = local_2;
            output[_e80].samples[_e83] = _e73;
            continuing {
                let _e85 = sample;
                sample = (_e85 + 1i);
            }
        }
    }
    {
        row = 0i;
        loop {
            let _e90 = row;
            if (_e90 < 2i) {
            } else {
                break;
            }
            {
                column = 0i;
                loop {
                    let _e95 = column;
                    if (_e95 < 2i) {
                    } else {
                        break;
                    }
                    let _e99 = row;
                    let _e101 = column;
                    let _e103 = combined.weights[_e99][_e101];
                    local_3 = slot;
                    let _e105 = row;
                    local_4 = u32(_e105);
                    let _e108 = column;
                    local_5 = u32(_e108);
                    let _e111 = local_3;
                    local_9 = _e111;
                    let _e113 = local_9;
                    let _e116 = local_4;
                    let _e118 = local_5;
                    output[_e113].weights[_e116][_e118] = _e103;
                    continuing {
                        let _e120 = column;
                        column = (_e120 + 1i);
                    }
                }
            }
            continuing {
                let _e123 = row;
                row = (_e123 + 1i);
            }
        }
    }
    let _e127 = combined.colour;
    output[slot].colour = _e127;
}
