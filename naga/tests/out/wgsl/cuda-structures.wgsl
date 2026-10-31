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
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var lane: u32;
    var original: Packet_cuda_record_1_;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var changed: Packet_cuda_record_1_;
    var local_4: Packet_cuda_record_2_;
    var combined: Packet_cuda_record_1_;
    var slot: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var sample: i32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var local_11: u32;
    var row: i32;
    var column: i32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var local_18: Packet_cuda_record_1_;
    var local_19: array<u32, 2>;
    var local_20: u32;
    var local_21: u32;
    var local_22: Packet_cuda_record_1_;
    var local_23: array<u32, 2>;
    var local_24: u32;
    var local_25: u32;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var local_28: u32;
    var local_29: array<u32, 2>;
    var local_30: u32;
    var local_31: u32;
    var local_32: array<u32, 2>;
    var local_33: u32;
    var local_34: u32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var local_37: u32;

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = array<u32, 2>();
    local_1[0] = 1u;
    local_1[1] = 0u;
    lane = threadIdx.x;
    let _e17 = lane;
    if (_e17 >= 2u) {
        return;
    }
    let _e22 = local;
    local_2 = _e22;
    let _e23 = lane;
    local_3 = u32(_e23);
    let _e27 = local_2;
    local_19 = _e27;
    let _e28 = local_3;
    let _e30 = local_19[1];
    local_19[1] = (_e30 + _e28);
    let _e34 = local_19[0];
    local_20 = u32(_e34);
    let _e38 = local_19[1];
    local_21 = u32(_e38);
    let _e42 = local_21;
    let _e44 = input[_e42];
    local_22 = _e44;
    let _e45 = local_22;
    local_18 = _e45;
    let _e47 = local_18;
    original = _e47;
    let _e49 = original;
    let _e50 = lane;
    let _e54 = adjust(_e49, (3i + i32(_e50)));
    changed = _e54;
    {
        local_4.w = 7i;
        local_4.x = 11i;
        let _e63 = local_4.w;
        let _e64 = local_4.x;
        let _e71 = changed.samples[0i].tag;
        changed.samples[0i].tag = (_e71 + u32((_e63 + _e64)));
    }
    let _e73 = changed;
    let _e74 = original;
    let _e75 = operator_u002b(_e73, _e74);
    combined = _e75;
    let _e78 = original.serial;
    let _e85 = combined.weights[0i][0i];
    combined.weights[0i][0i] = (_e85 + f32(_e78));
    let _e88 = combined.serial;
    combined.colour.w = f32(_e88);
    let _e92 = lane;
    slot = (_e92 + 1u);
    let _e97 = combined.serial;
    let _e100 = local_1;
    local_5 = _e100;
    let _e101 = slot;
    local_6 = u32(_e101);
    let _e105 = local_5;
    local_23 = _e105;
    let _e106 = local_6;
    let _e108 = local_23[1];
    local_23[1] = (_e108 + _e106);
    let _e112 = local_23[0];
    local_24 = u32(_e112);
    let _e116 = local_23[1];
    local_25 = u32(_e116);
    let _e119 = local_25;
    output[_e119].serial = _e97;
    let _e123 = combined.uv;
    let _e125 = local_1;
    local_7 = _e125;
    let _e126 = slot;
    local_8 = u32(_e126);
    let _e130 = local_7;
    local_26 = _e130;
    let _e131 = local_8;
    let _e133 = local_26[1];
    local_26[1] = (_e133 + _e131);
    let _e137 = local_26[0];
    local_27 = u32(_e137);
    let _e141 = local_26[1];
    local_28 = u32(_e141);
    let _e144 = local_28;
    output[_e144].uv = _e123;
    {
        sample = 0i;
        loop {
            let _e149 = sample;
            if (_e149 < 2i) {
            } else {
                break;
            }
            let _e153 = sample;
            let _e155 = combined.samples[_e153];
            let _e157 = local_1;
            local_9 = _e157;
            let _e158 = slot;
            local_10 = u32(_e158);
            let _e161 = sample;
            local_11 = u32(_e161);
            let _e165 = local_9;
            local_29 = _e165;
            let _e166 = local_10;
            let _e168 = local_29[1];
            local_29[1] = (_e168 + _e166);
            let _e172 = local_29[0];
            local_30 = u32(_e172);
            let _e176 = local_29[1];
            local_31 = u32(_e176);
            let _e179 = local_31;
            let _e182 = local_11;
            output[_e179].samples[_e182] = _e155;
            continuing {
                let _e184 = sample;
                sample = (_e184 + 1i);
            }
        }
    }
    {
        row = 0i;
        loop {
            let _e189 = row;
            if (_e189 < 2i) {
            } else {
                break;
            }
            {
                column = 0i;
                loop {
                    let _e194 = column;
                    if (_e194 < 2i) {
                    } else {
                        break;
                    }
                    let _e198 = row;
                    let _e200 = column;
                    let _e202 = combined.weights[_e198][_e200];
                    let _e204 = local_1;
                    local_12 = _e204;
                    let _e205 = slot;
                    local_13 = u32(_e205);
                    let _e208 = row;
                    local_14 = u32(_e208);
                    let _e211 = column;
                    local_15 = u32(_e211);
                    let _e215 = local_12;
                    local_32 = _e215;
                    let _e216 = local_13;
                    let _e218 = local_32[1];
                    local_32[1] = (_e218 + _e216);
                    let _e222 = local_32[0];
                    local_33 = u32(_e222);
                    let _e226 = local_32[1];
                    local_34 = u32(_e226);
                    let _e229 = local_34;
                    let _e232 = local_14;
                    let _e234 = local_15;
                    output[_e229].weights[_e232][_e234] = _e202;
                    continuing {
                        let _e236 = column;
                        column = (_e236 + 1i);
                    }
                }
            }
            continuing {
                let _e239 = row;
                row = (_e239 + 1i);
            }
        }
    }
    let _e243 = combined.colour;
    let _e245 = local_1;
    local_16 = _e245;
    let _e246 = slot;
    local_17 = u32(_e246);
    let _e250 = local_16;
    local_35 = _e250;
    let _e251 = local_17;
    let _e253 = local_35[1];
    local_35[1] = (_e253 + _e251);
    let _e257 = local_35[0];
    local_36 = u32(_e257);
    let _e261 = local_35[1];
    local_37 = u32(_e261);
    let _e264 = local_37;
    output[_e264].colour = _e243;
}
