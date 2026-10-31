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
var<storage> input_1: array<Packet_cuda_record_1_>;
@group(0) @binding(1)
var<storage, read_write> output_1: array<Packet_cuda_record_1_>;

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
    var input: array<u32, 2>;
    var output: array<u32, 2>;
    var original: Packet_cuda_record_1_;
    var local: array<u32, 2>;
    var local_1: u32;
    var changed: Packet_cuda_record_1_;
    var local_2: Packet_cuda_record_2_;
    var combined: Packet_cuda_record_1_;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var sample: i32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: u32;
    var row: i32;
    var column: i32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var local_16: Packet_cuda_record_1_;
    var local_17: array<u32, 2>;
    var local_18: u32;
    var local_19: u32;
    var local_20: Packet_cuda_record_1_;
    var local_21: array<u32, 2>;
    var local_22: u32;
    var local_23: u32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: u32;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: u32;
    var local_30: array<u32, 2>;
    var local_31: u32;
    var local_32: u32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var local_35: u32;

    input = array<u32, 2>();
    input[0] = 0u;
    input[1] = 0u;
    output = array<u32, 2>();
    output[0] = 1u;
    output[1] = 0u;
    let lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    let _e17 = input;
    local = _e17;
    local_1 = u32(lane);
    let _e21 = local;
    local_17 = _e21;
    let _e23 = local_1;
    let _e25 = local_17[1];
    local_17[1] = (_e25 + _e23);
    let _e29 = local_17[0];
    local_18 = u32(_e29);
    let _e33 = local_17[1];
    local_19 = u32(_e33);
    let _e36 = local_19;
    let _e39 = input_1[_e36];
    local_20 = _e39;
    let _e41 = local_20;
    local_16 = _e41;
    let _e43 = local_16;
    original = _e43;
    let _e45 = original;
    let _e49 = adjust(_e45, (3i + i32(lane)));
    changed = _e49;
    {
        local_2.w = 7i;
        local_2.x = 11i;
        let _e58 = local_2.w;
        let _e59 = local_2.x;
        let _e66 = changed.samples[0i].tag;
        changed.samples[0i].tag = (_e66 + u32((_e58 + _e59)));
    }
    let _e68 = changed;
    let _e69 = original;
    let _e70 = operator_u002b(_e68, _e69);
    combined = _e70;
    let _e73 = original.serial;
    let _e80 = combined.weights[0i][0i];
    combined.weights[0i][0i] = (_e80 + f32(_e73));
    let _e83 = combined.serial;
    combined.colour.w = f32(_e83);
    let slot = (lane + 1u);
    let _e90 = combined.serial;
    let _e92 = output;
    local_3 = _e92;
    local_4 = u32(slot);
    let _e96 = local_3;
    local_21 = _e96;
    let _e98 = local_4;
    let _e100 = local_21[1];
    local_21[1] = (_e100 + _e98);
    let _e104 = local_21[0];
    local_22 = u32(_e104);
    let _e108 = local_21[1];
    local_23 = u32(_e108);
    let _e111 = local_23;
    output_1[_e111].serial = _e90;
    let _e116 = combined.uv;
    let _e117 = output;
    local_5 = _e117;
    local_6 = u32(slot);
    let _e121 = local_5;
    local_24 = _e121;
    let _e123 = local_6;
    let _e125 = local_24[1];
    local_24[1] = (_e125 + _e123);
    let _e129 = local_24[0];
    local_25 = u32(_e129);
    let _e133 = local_24[1];
    local_26 = u32(_e133);
    let _e136 = local_26;
    output_1[_e136].uv = _e116;
    {
        sample = 0i;
        loop {
            let _e141 = sample;
            if (_e141 < 2i) {
            } else {
                break;
            }
            let _e145 = sample;
            let _e147 = combined.samples[_e145];
            let _e148 = output;
            local_7 = _e148;
            local_8 = u32(slot);
            let _e152 = sample;
            local_9 = u32(_e152);
            let _e155 = local_7;
            local_27 = _e155;
            let _e157 = local_8;
            let _e159 = local_27[1];
            local_27[1] = (_e159 + _e157);
            let _e163 = local_27[0];
            local_28 = u32(_e163);
            let _e167 = local_27[1];
            local_29 = u32(_e167);
            let _e170 = local_29;
            let _e173 = local_9;
            output_1[_e170].samples[_e173] = _e147;
            continuing {
                let _e175 = sample;
                sample = (_e175 + 1i);
            }
        }
    }
    {
        row = 0i;
        loop {
            let _e180 = row;
            if (_e180 < 2i) {
            } else {
                break;
            }
            {
                column = 0i;
                loop {
                    let _e185 = column;
                    if (_e185 < 2i) {
                    } else {
                        break;
                    }
                    let _e189 = row;
                    let _e191 = column;
                    let _e193 = combined.weights[_e189][_e191];
                    let _e194 = output;
                    local_10 = _e194;
                    local_11 = u32(slot);
                    let _e198 = row;
                    local_12 = u32(_e198);
                    let _e201 = column;
                    local_13 = u32(_e201);
                    let _e204 = local_10;
                    local_30 = _e204;
                    let _e206 = local_11;
                    let _e208 = local_30[1];
                    local_30[1] = (_e208 + _e206);
                    let _e212 = local_30[0];
                    local_31 = u32(_e212);
                    let _e216 = local_30[1];
                    local_32 = u32(_e216);
                    let _e219 = local_32;
                    let _e222 = local_12;
                    let _e224 = local_13;
                    output_1[_e219].weights[_e222][_e224] = _e193;
                    continuing {
                        let _e226 = column;
                        column = (_e226 + 1i);
                    }
                }
            }
            continuing {
                let _e229 = row;
                row = (_e229 + 1i);
            }
        }
    }
    let _e233 = combined.colour;
    let _e234 = output;
    local_14 = _e234;
    local_15 = u32(slot);
    let _e238 = local_14;
    local_33 = _e238;
    let _e240 = local_15;
    let _e242 = local_33[1];
    local_33[1] = (_e242 + _e240);
    let _e246 = local_33[0];
    local_34 = u32(_e246);
    let _e250 = local_33[1];
    local_35 = u32(_e250);
    let _e253 = local_35;
    output_1[_e253].colour = _e233;
}
