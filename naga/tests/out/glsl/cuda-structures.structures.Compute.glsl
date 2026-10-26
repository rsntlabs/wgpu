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
    uint local = 0u;
    uint local_1 = 0u;
    uint lane = 0u;
    Packet_cuda_record_1_ original = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    Packet_cuda_record_1_ changed = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    Packet_cuda_record_2_ local_5 = Packet_cuda_record_2_(0, 0);
    Packet_cuda_record_1_ combined = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint slot = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    int sample_ = 0;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    int row = 0;
    int column = 0;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    Packet_cuda_record_1_ local_25 = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    local = 0u;
    local_1 = 0u;
    lane = threadIdx.x;
    uint _e7 = lane;
    if ((_e7 >= 2u)) {
        return;
    }
    uint _e10 = local;
    local_2 = _e10;
    uint _e12 = local_2;
    local_3 = uint(_e12);
    uint _e15 = lane;
    local_4 = uint(_e15);
    uint _e19 = local_3;
    uint _e20 = local_4;
    local_24 = uint((_e19 + _e20));
    uint _e25 = local_24;
    Packet_cuda_record_1_ _e27 = _group_0_binding_0_cs[_e25];
    local_25 = _e27;
    Packet_cuda_record_1_ _e28 = local_25;
    original = _e28;
    Packet_cuda_record_1_ _e30 = original;
    uint _e31 = lane;
    Packet_cuda_record_1_ _e35 = adjust(_e30, (3 + int(_e31)));
    changed = _e35;
    {
        local_5.w = 7;
        local_5.x = 11;
        int _e44 = local_5.w;
        int _e45 = local_5.x;
        uint _e52 = changed.samples[0].tag;
        changed.samples[0].tag = (_e52 + uint((_e44 + _e45)));
    }
    Packet_cuda_record_1_ _e54 = changed;
    Packet_cuda_record_1_ _e55 = original;
    Packet_cuda_record_1_ _e56 = operator_u002b(_e54, _e55);
    combined = _e56;
    uint _e59 = original.serial;
    float _e66 = combined.weights[0][0];
    combined.weights[0][0] = (_e66 + float(_e59));
    uint _e69 = combined.serial;
    combined.colour.w = float(_e69);
    uint _e73 = lane;
    slot = (_e73 + 1u);
    uint _e78 = combined.serial;
    uint _e79 = local_1;
    local_6 = _e79;
    uint _e81 = local_6;
    local_7 = uint(_e81);
    uint _e84 = slot;
    local_8 = uint(_e84);
    uint _e88 = local_7;
    uint _e89 = local_8;
    local_26 = uint((_e88 + _e89));
    uint _e93 = local_26;
    _group_0_binding_1_cs[_e93].serial = _e78;
    vec2 _e97 = combined.uv;
    uint _e98 = local_1;
    local_9 = _e98;
    uint _e100 = local_9;
    local_10 = uint(_e100);
    uint _e103 = slot;
    local_11 = uint(_e103);
    uint _e106 = local_10;
    uint _e107 = local_11;
    local_27 = uint((_e106 + _e107));
    uint _e111 = local_27;
    _group_0_binding_1_cs[_e111].uv = _e97;
    {
        sample_ = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e144 = sample_;
                sample_ = (_e144 + 1);
            }
            loop_init = false;
            int _e116 = sample_;
            if ((_e116 < 2)) {
            } else {
                break;
            }
            int _e120 = sample_;
            Sample_cuda_record_0_ _e122 = combined.samples[_e120];
            uint _e123 = local_1;
            local_12 = _e123;
            uint _e125 = local_12;
            local_13 = uint(_e125);
            uint _e128 = slot;
            local_14 = uint(_e128);
            int _e131 = sample_;
            local_15 = uint(_e131);
            uint _e134 = local_13;
            uint _e135 = local_14;
            local_28 = uint((_e134 + _e135));
            uint _e139 = local_28;
            uint _e142 = local_15;
            _group_0_binding_1_cs[_e139].samples[_e142] = _e122;
        }
    }
    {
        row = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e192 = row;
                row = (_e192 + 1);
            }
            loop_init_1 = false;
            int _e149 = row;
            if ((_e149 < 2)) {
            } else {
                break;
            }
            {
                column = 0;
                bool loop_init_2 = true;
                while(true) {
                    if (!loop_init_2) {
                        int _e189 = column;
                        column = (_e189 + 1);
                    }
                    loop_init_2 = false;
                    int _e154 = column;
                    if ((_e154 < 2)) {
                    } else {
                        break;
                    }
                    int _e158 = row;
                    int _e160 = column;
                    float _e162 = combined.weights[_e158][_e160];
                    uint _e163 = local_1;
                    local_16 = _e163;
                    uint _e165 = local_16;
                    local_17 = uint(_e165);
                    uint _e168 = slot;
                    local_18 = uint(_e168);
                    int _e171 = row;
                    local_19 = uint(_e171);
                    int _e174 = column;
                    local_20 = uint(_e174);
                    uint _e177 = local_17;
                    uint _e178 = local_18;
                    local_29 = uint((_e177 + _e178));
                    uint _e182 = local_29;
                    uint _e185 = local_19;
                    uint _e187 = local_20;
                    _group_0_binding_1_cs[_e182].weights[_e185][_e187] = _e162;
                }
            }
        }
    }
    vec4 _e196 = combined.colour;
    uint _e197 = local_1;
    local_21 = _e197;
    uint _e199 = local_21;
    local_22 = uint(_e199);
    uint _e202 = slot;
    local_23 = uint(_e202);
    uint _e205 = local_22;
    uint _e206 = local_23;
    local_30 = uint((_e205 + _e206));
    uint _e210 = local_30;
    _group_0_binding_1_cs[_e210].colour = _e196;
}

