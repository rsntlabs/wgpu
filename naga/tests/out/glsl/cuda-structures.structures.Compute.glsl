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
    Packet_cuda_record_1_ original = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local = 0u;
    Packet_cuda_record_1_ changed = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    Packet_cuda_record_2_ local_1 = Packet_cuda_record_2_(0, 0);
    Packet_cuda_record_1_ combined = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local_2 = 0u;
    uint local_3 = 0u;
    int sample_ = 0;
    uint local_4 = 0u;
    uint local_5 = 0u;
    int row = 0;
    int column = 0;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    Packet_cuda_record_1_ local_10 = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local_11 = 0u;
    Packet_cuda_record_1_ local_12 = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    local = uint(lane);
    uint _e6 = local;
    local_11 = uint(_e6);
    uint _e9 = local_11;
    Packet_cuda_record_1_ _e12 = _group_0_binding_0_cs[_e9];
    local_12 = _e12;
    Packet_cuda_record_1_ _e14 = local_12;
    local_10 = _e14;
    Packet_cuda_record_1_ _e16 = local_10;
    original = _e16;
    Packet_cuda_record_1_ _e18 = original;
    Packet_cuda_record_1_ _e22 = adjust(_e18, (3 + int(lane)));
    changed = _e22;
    {
        local_1.w = 7;
        local_1.x = 11;
        int _e31 = local_1.w;
        int _e32 = local_1.x;
        uint _e39 = changed.samples[0].tag;
        changed.samples[0].tag = (_e39 + uint((_e31 + _e32)));
    }
    Packet_cuda_record_1_ _e41 = changed;
    Packet_cuda_record_1_ _e42 = original;
    Packet_cuda_record_1_ _e43 = operator_u002b(_e41, _e42);
    combined = _e43;
    uint _e46 = original.serial;
    float _e53 = combined.weights[0][0];
    combined.weights[0][0] = (_e53 + float(_e46));
    uint _e56 = combined.serial;
    combined.colour.w = float(_e56);
    uint slot = (lane + 1u);
    uint _e63 = combined.serial;
    local_2 = uint(slot);
    uint _e66 = local_2;
    local_13 = uint(_e66);
    uint _e69 = local_13;
    _group_0_binding_1_cs[_e69].serial = _e63;
    vec2 _e74 = combined.uv;
    local_3 = uint(slot);
    uint _e77 = local_3;
    local_14 = uint(_e77);
    uint _e80 = local_14;
    _group_0_binding_1_cs[_e80].uv = _e74;
    {
        sample_ = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e105 = sample_;
                sample_ = (_e105 + 1);
            }
            loop_init = false;
            int _e85 = sample_;
            if ((_e85 < 2)) {
            } else {
                break;
            }
            int _e89 = sample_;
            Sample_cuda_record_0_ _e91 = combined.samples[_e89];
            local_4 = uint(slot);
            int _e94 = sample_;
            local_5 = uint(_e94);
            uint _e97 = local_4;
            local_15 = uint(_e97);
            uint _e100 = local_15;
            uint _e103 = local_5;
            _group_0_binding_1_cs[_e100].samples[_e103] = _e91;
        }
    }
    {
        row = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e145 = row;
                row = (_e145 + 1);
            }
            loop_init_1 = false;
            int _e110 = row;
            if ((_e110 < 2)) {
            } else {
                break;
            }
            {
                column = 0;
                bool loop_init_2 = true;
                while(true) {
                    if (!loop_init_2) {
                        int _e142 = column;
                        column = (_e142 + 1);
                    }
                    loop_init_2 = false;
                    int _e115 = column;
                    if ((_e115 < 2)) {
                    } else {
                        break;
                    }
                    int _e119 = row;
                    int _e121 = column;
                    float _e123 = combined.weights[_e119][_e121];
                    local_6 = uint(slot);
                    int _e126 = row;
                    local_7 = uint(_e126);
                    int _e129 = column;
                    local_8 = uint(_e129);
                    uint _e132 = local_6;
                    local_16 = uint(_e132);
                    uint _e135 = local_16;
                    uint _e138 = local_7;
                    uint _e140 = local_8;
                    _group_0_binding_1_cs[_e135].weights[_e138][_e140] = _e123;
                }
            }
        }
    }
    vec4 _e149 = combined.colour;
    local_9 = uint(slot);
    uint _e152 = local_9;
    local_17 = uint(_e152);
    uint _e155 = local_17;
    _group_0_binding_1_cs[_e155].colour = _e149;
}

