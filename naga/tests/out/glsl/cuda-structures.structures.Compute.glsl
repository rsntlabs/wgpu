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
    int bias_1 = 0;
    value_1 = value;
    bias_1 = bias;
    int _e5 = bias_1;
    uint _e7 = value_1.serial;
    value_1.serial = (_e7 + uint(_e5));
    float _e19 = value_1.weights[0][1];
    float _e20 = value_1.samples[1].position.x;
    value_1.samples[1].position.x = (_e20 + _e19);
    uint _e31 = value_1.samples[0].tag;
    value_1.weights[1][0] = float(_e31);
    Packet_cuda_record_1_ _e33 = value_1;
    return _e33;
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
    uint lane = 0u;
    Packet_cuda_record_1_ original = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    Packet_cuda_record_1_ changed = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    Packet_cuda_record_2_ local_2 = Packet_cuda_record_2_(0, 0);
    Packet_cuda_record_1_ combined = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint slot = 0u;
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
    lane = threadIdx.x;
    uint _e17 = lane;
    if ((_e17 >= 2u)) {
        return;
    }
    uint _e22[2] = input_;
    local = _e22;
    uint _e23 = lane;
    local_1 = uint(_e23);
    uint _e27[2] = local;
    local_17 = _e27;
    uint _e28 = local_1;
    uint _e30 = local_17[1];
    local_17[1] = (_e30 + _e28);
    uint _e34 = local_17[0];
    local_18 = uint(_e34);
    uint _e38 = local_17[1];
    local_19 = uint(_e38);
    uint _e42 = local_19;
    Packet_cuda_record_1_ _e44 = _group_0_binding_0_cs[_e42];
    local_20 = _e44;
    Packet_cuda_record_1_ _e45 = local_20;
    local_16 = _e45;
    Packet_cuda_record_1_ _e47 = local_16;
    original = _e47;
    Packet_cuda_record_1_ _e49 = original;
    uint _e50 = lane;
    Packet_cuda_record_1_ _e54 = adjust(_e49, (3 + int(_e50)));
    changed = _e54;
    {
        local_2.w = 7;
        local_2.x = 11;
        int _e63 = local_2.w;
        int _e64 = local_2.x;
        uint _e71 = changed.samples[0].tag;
        changed.samples[0].tag = (_e71 + uint((_e63 + _e64)));
    }
    Packet_cuda_record_1_ _e73 = changed;
    Packet_cuda_record_1_ _e74 = original;
    Packet_cuda_record_1_ _e75 = operator_u002b(_e73, _e74);
    combined = _e75;
    uint _e78 = original.serial;
    float _e85 = combined.weights[0][0];
    combined.weights[0][0] = (_e85 + float(_e78));
    uint _e88 = combined.serial;
    combined.colour.w = float(_e88);
    uint _e92 = lane;
    slot = (_e92 + 1u);
    uint _e97 = combined.serial;
    uint _e100[2] = output_;
    local_3 = _e100;
    uint _e101 = slot;
    local_4 = uint(_e101);
    uint _e105[2] = local_3;
    local_21 = _e105;
    uint _e106 = local_4;
    uint _e108 = local_21[1];
    local_21[1] = (_e108 + _e106);
    uint _e112 = local_21[0];
    local_22 = uint(_e112);
    uint _e116 = local_21[1];
    local_23 = uint(_e116);
    uint _e119 = local_23;
    _group_0_binding_1_cs[_e119].serial = _e97;
    vec2 _e123 = combined.uv;
    uint _e125[2] = output_;
    local_5 = _e125;
    uint _e126 = slot;
    local_6 = uint(_e126);
    uint _e130[2] = local_5;
    local_24 = _e130;
    uint _e131 = local_6;
    uint _e133 = local_24[1];
    local_24[1] = (_e133 + _e131);
    uint _e137 = local_24[0];
    local_25 = uint(_e137);
    uint _e141 = local_24[1];
    local_26 = uint(_e141);
    uint _e144 = local_26;
    _group_0_binding_1_cs[_e144].uv = _e123;
    {
        sample_ = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e184 = sample_;
                sample_ = (_e184 + 1);
            }
            loop_init = false;
            int _e149 = sample_;
            if ((_e149 < 2)) {
            } else {
                break;
            }
            int _e153 = sample_;
            Sample_cuda_record_0_ _e155 = combined.samples[_e153];
            uint _e157[2] = output_;
            local_7 = _e157;
            uint _e158 = slot;
            local_8 = uint(_e158);
            int _e161 = sample_;
            local_9 = uint(_e161);
            uint _e165[2] = local_7;
            local_27 = _e165;
            uint _e166 = local_8;
            uint _e168 = local_27[1];
            local_27[1] = (_e168 + _e166);
            uint _e172 = local_27[0];
            local_28 = uint(_e172);
            uint _e176 = local_27[1];
            local_29 = uint(_e176);
            uint _e179 = local_29;
            uint _e182 = local_9;
            _group_0_binding_1_cs[_e179].samples[_e182] = _e155;
        }
    }
    {
        row = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e239 = row;
                row = (_e239 + 1);
            }
            loop_init_1 = false;
            int _e189 = row;
            if ((_e189 < 2)) {
            } else {
                break;
            }
            {
                column = 0;
                bool loop_init_2 = true;
                while(true) {
                    if (!loop_init_2) {
                        int _e236 = column;
                        column = (_e236 + 1);
                    }
                    loop_init_2 = false;
                    int _e194 = column;
                    if ((_e194 < 2)) {
                    } else {
                        break;
                    }
                    int _e198 = row;
                    int _e200 = column;
                    float _e202 = combined.weights[_e198][_e200];
                    uint _e204[2] = output_;
                    local_10 = _e204;
                    uint _e205 = slot;
                    local_11 = uint(_e205);
                    int _e208 = row;
                    local_12 = uint(_e208);
                    int _e211 = column;
                    local_13 = uint(_e211);
                    uint _e215[2] = local_10;
                    local_30 = _e215;
                    uint _e216 = local_11;
                    uint _e218 = local_30[1];
                    local_30[1] = (_e218 + _e216);
                    uint _e222 = local_30[0];
                    local_31 = uint(_e222);
                    uint _e226 = local_30[1];
                    local_32 = uint(_e226);
                    uint _e229 = local_32;
                    uint _e232 = local_12;
                    uint _e234 = local_13;
                    _group_0_binding_1_cs[_e229].weights[_e232][_e234] = _e202;
                }
            }
        }
    }
    vec4 _e243 = combined.colour;
    uint _e245[2] = output_;
    local_14 = _e245;
    uint _e246 = slot;
    local_15 = uint(_e246);
    uint _e250[2] = local_14;
    local_33 = _e250;
    uint _e251 = local_15;
    uint _e253 = local_33[1];
    local_33[1] = (_e253 + _e251);
    uint _e257 = local_33[0];
    local_34 = uint(_e257);
    uint _e261 = local_33[1];
    local_35 = uint(_e261);
    uint _e264 = local_35;
    _group_0_binding_1_cs[_e264].colour = _e243;
}

