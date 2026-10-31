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
    Packet_cuda_record_1_ changed = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    Packet_cuda_record_2_ local = Packet_cuda_record_2_(0, 0);
    Packet_cuda_record_1_ combined = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    int sample_ = 0;
    uint local_1 = 0u;
    uint local_2 = 0u;
    int row = 0;
    int column = 0;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    Packet_cuda_record_1_ local_6 = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    Packet_cuda_record_1_ local_7 = Packet_cuda_record_1_(0u, vec2(0.0), Sample_cuda_record_0_[2](Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u), Sample_cuda_record_0_(float3_(0.0, 0.0, 0.0), 0u)), float[2][2](float[2](0.0, 0.0), float[2](0.0, 0.0)), vec4(0.0));
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint lane = threadIdx.x;
    if ((lane >= 2u)) {
        return;
    }
    Packet_cuda_record_1_ _e6 = _group_0_binding_0_cs[lane];
    local_7 = _e6;
    Packet_cuda_record_1_ _e8 = local_7;
    local_6 = _e8;
    Packet_cuda_record_1_ _e10 = local_6;
    original = _e10;
    Packet_cuda_record_1_ _e12 = original;
    Packet_cuda_record_1_ _e16 = adjust(_e12, (3 + int(lane)));
    changed = _e16;
    {
        local.w = 7;
        local.x = 11;
        int _e25 = local.w;
        int _e26 = local.x;
        uint _e33 = changed.samples[0].tag;
        changed.samples[0].tag = (_e33 + uint((_e25 + _e26)));
    }
    Packet_cuda_record_1_ _e35 = changed;
    Packet_cuda_record_1_ _e36 = original;
    Packet_cuda_record_1_ _e37 = operator_u002b(_e35, _e36);
    combined = _e37;
    uint _e40 = original.serial;
    float _e47 = combined.weights[0][0];
    combined.weights[0][0] = (_e47 + float(_e40));
    uint _e50 = combined.serial;
    combined.colour.w = float(_e50);
    uint slot = (lane + 1u);
    uint _e57 = combined.serial;
    _group_0_binding_1_cs[slot].serial = _e57;
    vec2 _e62 = combined.uv;
    _group_0_binding_1_cs[slot].uv = _e62;
    {
        sample_ = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e85 = sample_;
                sample_ = (_e85 + 1);
            }
            loop_init = false;
            int _e67 = sample_;
            if ((_e67 < 2)) {
            } else {
                break;
            }
            int _e71 = sample_;
            Sample_cuda_record_0_ _e73 = combined.samples[_e71];
            local_1 = slot;
            int _e75 = sample_;
            local_2 = uint(_e75);
            uint _e78 = local_1;
            local_8 = _e78;
            uint _e80 = local_8;
            uint _e83 = local_2;
            _group_0_binding_1_cs[_e80].samples[_e83] = _e73;
        }
    }
    {
        row = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e123 = row;
                row = (_e123 + 1);
            }
            loop_init_1 = false;
            int _e90 = row;
            if ((_e90 < 2)) {
            } else {
                break;
            }
            {
                column = 0;
                bool loop_init_2 = true;
                while(true) {
                    if (!loop_init_2) {
                        int _e120 = column;
                        column = (_e120 + 1);
                    }
                    loop_init_2 = false;
                    int _e95 = column;
                    if ((_e95 < 2)) {
                    } else {
                        break;
                    }
                    int _e99 = row;
                    int _e101 = column;
                    float _e103 = combined.weights[_e99][_e101];
                    local_3 = slot;
                    int _e105 = row;
                    local_4 = uint(_e105);
                    int _e108 = column;
                    local_5 = uint(_e108);
                    uint _e111 = local_3;
                    local_9 = _e111;
                    uint _e113 = local_9;
                    uint _e116 = local_4;
                    uint _e118 = local_5;
                    _group_0_binding_1_cs[_e113].weights[_e116][_e118] = _e103;
                }
            }
        }
    }
    vec4 _e127 = combined.colour;
    _group_0_binding_1_cs[slot].colour = _e127;
}

