#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

struct float3_ {
    float x;
    float y;
    float z;
};
struct Sample_cuda_record_0_ {
    float3_ position;
    uint tag;
};
struct Packet_cuda_record_1_ {
    uint serial;
    vec2 uv;
    Sample_cuda_record_0_ samples[2];
    float weights[2][2];
    vec4 colour;
};
struct Packet_cuda_record_2_ {
    int w;
    int x;
};
layout(std430) readonly buffer type_8_block_0Compute { Packet_cuda_record_1_ _group_0_binding_0_cs[]; };

layout(std430) buffer type_8_block_1Compute { Packet_cuda_record_1_ _group_0_binding_1_cs[]; };


Packet_cuda_record_1_ adjust(Packet_cuda_record_1_ value, int bias) {
    Packet_cuda_record_1_ value_1 = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    value_1 = value;
    uint _e5 = value_1.serial;
    value_1.serial = (_e5 + uint(bias));
    float _e12 = value_1.weights[0][1];
    float _e18 = value_1.samples[1].position.x;
    value_1.samples[1].position.x = (_e18 + _e12);
    uint _e24 = value_1.samples[0].tag;
    value_1.weights[1][0] = float(_e24);
    Packet_cuda_record_1_ _e31 = value_1;
    return _e31;
}

Packet_cuda_record_1_ operator_u002b(Packet_cuda_record_1_ left, Packet_cuda_record_1_ right) {
    Packet_cuda_record_1_ left_1 = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    Packet_cuda_record_1_ right_1 = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    left_1 = left;
    right_1 = right;
    uint _e6 = right_1.serial;
    uint _e7 = left_1.serial;
    left_1.serial = (_e7 + _e6);
    float _e13 = right_1.uv.y;
    float _e14 = left_1.uv.x;
    left_1.uv.x = (_e14 + _e13);
    Packet_cuda_record_1_ _e16 = left_1;
    return _e16;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint input_[2] = uint[2](0u, 0u);
    uint output_[2] = uint[2](0u, 0u);
    Packet_cuda_record_1_ original = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    Packet_cuda_record_1_ changed = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    Packet_cuda_record_2_ local_2 = Packet_cuda_record_2_(0, 0);
    Packet_cuda_record_1_ combined = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local_3[2] = uint[2](0u, 0u);
    uint local_4 = 0u;
    uint local_5[2] = uint[2](0u, 0u);
    uint local_6 = 0u;
    int sample_ = 0;
    uint local_7[2] = uint[2](0u, 0u);
    uint local_8 = 0u;
    uint local_9 = 0u;
    int row = 0;
    int column = 0;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14[2] = uint[2](0u, 0u);
    uint local_15 = 0u;
    Packet_cuda_record_1_ local_16 = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local_17[2] = uint[2](0u, 0u);
    uint local_18 = 0u;
    uint local_19 = 0u;
    Packet_cuda_record_1_ local_20 = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local_21[2] = uint[2](0u, 0u);
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24[2] = uint[2](0u, 0u);
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27[2] = uint[2](0u, 0u);
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30[2] = uint[2](0u, 0u);
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33[2] = uint[2](0u, 0u);
    uint local_34 = 0u;
    uint local_35 = 0u;
    input_ = uint[2](0u, 0u);
    input_[0] = 0u;
    input_[1] = 0u;
    output_ = uint[2](0u, 0u);
    output_[0] = 1u;
    output_[1] = 0u;
    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    uint _e17[2] = input_;
    local = _e17;
    local_1 = uint(lane);
    uint _e21[2] = local;
    local_17 = _e21;
    uint _e23 = local_1;
    uint _e25 = local_17[1];
    local_17[1] = (_e25 + _e23);
    uint _e29 = local_17[0];
    local_18 = uint(_e29);
    uint _e33 = local_17[1];
    local_19 = uint(_e33);
    uint _e36 = local_19;
    Packet_cuda_record_1_ _e39 = _group_0_binding_0_cs[_e36];
    local_20 = _e39;
    Packet_cuda_record_1_ _e41 = local_20;
    local_16 = _e41;
    Packet_cuda_record_1_ _e43 = local_16;
    original = _e43;
    Packet_cuda_record_1_ _e45 = original;
    Packet_cuda_record_1_ _e49 = adjust(_e45, (3 + int(lane)));
    changed = _e49;
    {
        local_2.w = 7;
        local_2.x = 11;
        int _e58 = local_2.w;
        int _e59 = local_2.x;
        uint _e66 = changed.samples[0].tag;
        changed.samples[0].tag = (_e66 + uint((_e58 + _e59)));
    }
    Packet_cuda_record_1_ _e68 = changed;
    Packet_cuda_record_1_ _e69 = original;
    Packet_cuda_record_1_ _e70 = operator_u002b(_e68, _e69);
    combined = _e70;
    uint _e73 = original.serial;
    float _e80 = combined.weights[0][0];
    combined.weights[0][0] = (_e80 + float(_e73));
    uint _e83 = combined.serial;
    combined.colour.w = float(_e83);
    uint slot = (lane + 1u);
    uint _e90 = combined.serial;
    uint _e92[2] = output_;
    local_3 = _e92;
    local_4 = uint(slot);
    uint _e96[2] = local_3;
    local_21 = _e96;
    uint _e98 = local_4;
    uint _e100 = local_21[1];
    local_21[1] = (_e100 + _e98);
    uint _e104 = local_21[0];
    local_22 = uint(_e104);
    uint _e108 = local_21[1];
    local_23 = uint(_e108);
    uint _e111 = local_23;
    _group_0_binding_1_cs[_e111].serial = _e90;
    vec2 _e116 = combined.uv;
    uint _e117[2] = output_;
    local_5 = _e117;
    local_6 = uint(slot);
    uint _e121[2] = local_5;
    local_24 = _e121;
    uint _e123 = local_6;
    uint _e125 = local_24[1];
    local_24[1] = (_e125 + _e123);
    uint _e129 = local_24[0];
    local_25 = uint(_e129);
    uint _e133 = local_24[1];
    local_26 = uint(_e133);
    uint _e136 = local_26;
    _group_0_binding_1_cs[_e136].uv = _e116;
    {
        sample_ = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e175 = sample_;
                sample_ = (_e175 + 1);
            }
            loop_init = false;
            int _e141 = sample_;
            if ((_e141 < 2)) {
            } else {
                break;
            }
            int _e145 = sample_;
            Sample_cuda_record_0_ _e147 = combined.samples[_e145];
            uint _e148[2] = output_;
            local_7 = _e148;
            local_8 = uint(slot);
            int _e152 = sample_;
            local_9 = uint(_e152);
            uint _e155[2] = local_7;
            local_27 = _e155;
            uint _e157 = local_8;
            uint _e159 = local_27[1];
            local_27[1] = (_e159 + _e157);
            uint _e163 = local_27[0];
            local_28 = uint(_e163);
            uint _e167 = local_27[1];
            local_29 = uint(_e167);
            uint _e170 = local_29;
            uint _e173 = local_9;
            _group_0_binding_1_cs[_e170].samples[_e173] = _e147;
        }
    }
    {
        row = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e229 = row;
                row = (_e229 + 1);
            }
            loop_init_1 = false;
            int _e180 = row;
            if ((_e180 < 2)) {
            } else {
                break;
            }
            {
                column = 0;
                bool loop_init_2 = true;
                while(true) {
                    if (!loop_init_2) {
                        int _e226 = column;
                        column = (_e226 + 1);
                    }
                    loop_init_2 = false;
                    int _e185 = column;
                    if ((_e185 < 2)) {
                    } else {
                        break;
                    }
                    int _e189 = row;
                    int _e191 = column;
                    float _e193 = combined.weights[_e189][_e191];
                    uint _e194[2] = output_;
                    local_10 = _e194;
                    local_11 = uint(slot);
                    int _e198 = row;
                    local_12 = uint(_e198);
                    int _e201 = column;
                    local_13 = uint(_e201);
                    uint _e204[2] = local_10;
                    local_30 = _e204;
                    uint _e206 = local_11;
                    uint _e208 = local_30[1];
                    local_30[1] = (_e208 + _e206);
                    uint _e212 = local_30[0];
                    local_31 = uint(_e212);
                    uint _e216 = local_30[1];
                    local_32 = uint(_e216);
                    uint _e219 = local_32;
                    uint _e222 = local_12;
                    uint _e224 = local_13;
                    _group_0_binding_1_cs[_e219].weights[_e222][_e224] = _e193;
                }
            }
        }
    }
    vec4 _e233 = combined.colour;
    uint _e234[2] = output_;
    local_14 = _e234;
    local_15 = uint(slot);
    uint _e238[2] = local_14;
    local_33 = _e238;
    uint _e240 = local_15;
    uint _e242 = local_33[1];
    local_33[1] = (_e242 + _e240);
    uint _e246 = local_33[0];
    local_34 = uint(_e246);
    uint _e250 = local_33[1];
    local_35 = uint(_e250);
    uint _e253 = local_35;
    _group_0_binding_1_cs[_e253].colour = _e233;
}

