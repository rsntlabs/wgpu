// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

struct float3_ {
    float x;
    float y;
    float z;
};
struct Sample_cuda_record_0_ {
    float3_ position;
    uint tag;
};
struct type_3 {
    Sample_cuda_record_0_ inner[2];
};
struct type_4 {
    float inner[2];
};
struct type_5 {
    type_4 inner[2];
};
struct Packet_cuda_record_1_ {
    uint serial;
    char _pad1[4];
    metal::float2 uv;
    type_3 samples;
    type_5 weights;
    metal::float4 colour;
};
typedef Packet_cuda_record_1_ type_8[1];
struct Packet_cuda_record_2_ {
    int w;
    int x;
};

Packet_cuda_record_1_ adjust(
    Packet_cuda_record_1_ value,
    int bias
) {
    Packet_cuda_record_1_ value_1 = {};
    value_1 = value;
    uint _e5 = value_1.serial;
    value_1.serial = _e5 + static_cast<uint>(bias);
    float _e12 = value_1.weights.inner[0].inner[1];
    float _e18 = value_1.samples.inner[1].position.x;
    value_1.samples.inner[1].position.x = _e18 + _e12;
    uint _e24 = value_1.samples.inner[0].tag;
    value_1.weights.inner[1].inner[0] = static_cast<float>(_e24);
    Packet_cuda_record_1_ _e31 = value_1;
    return _e31;
}

Packet_cuda_record_1_ operator_u002b(
    Packet_cuda_record_1_ left,
    Packet_cuda_record_1_ right
) {
    Packet_cuda_record_1_ left_1 = {};
    Packet_cuda_record_1_ right_1 = {};
    left_1 = left;
    right_1 = right;
    uint _e6 = right_1.serial;
    uint _e7 = left_1.serial;
    left_1.serial = _e7 + _e6;
    float _e13 = right_1.uv.y;
    float _e14 = left_1.uv.x;
    left_1.uv.x = _e14 + _e13;
    Packet_cuda_record_1_ _e16 = left_1;
    return _e16;
}

struct structuresInput {
};
kernel void structures(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_8 const& input [[user(fake0)]]
, device type_8& output [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    Packet_cuda_record_1_ original = {};
    Packet_cuda_record_1_ changed = {};
    Packet_cuda_record_2_ local = {};
    Packet_cuda_record_1_ combined = {};
    int sample = {};
    uint local_1 = {};
    uint local_2 = {};
    int row = {};
    int column = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    Packet_cuda_record_1_ local_6 = {};
    Packet_cuda_record_1_ local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    Packet_cuda_record_1_ _e6 = input[lane];
    local_7 = _e6;
    Packet_cuda_record_1_ _e8 = local_7;
    local_6 = _e8;
    Packet_cuda_record_1_ _e10 = local_6;
    original = _e10;
    Packet_cuda_record_1_ _e12 = original;
    Packet_cuda_record_1_ _e16 = adjust(_e12, as_type<int>(as_type<uint>(3) + as_type<uint>(static_cast<int>(lane))));
    changed = _e16;
    {
        local.w = 7;
        local.x = 11;
        int _e25 = local.w;
        int _e26 = local.x;
        uint _e33 = changed.samples.inner[0].tag;
        changed.samples.inner[0].tag = _e33 + static_cast<uint>(as_type<int>(as_type<uint>(_e25) + as_type<uint>(_e26)));
    }
    Packet_cuda_record_1_ _e35 = changed;
    Packet_cuda_record_1_ _e36 = original;
    Packet_cuda_record_1_ _e37 = operator_u002b(_e35, _e36);
    combined = _e37;
    uint _e40 = original.serial;
    float _e47 = combined.weights.inner[0].inner[0];
    combined.weights.inner[0].inner[0] = _e47 + static_cast<float>(_e40);
    uint _e50 = combined.serial;
    combined.colour.w = static_cast<float>(_e50);
    uint slot = lane + 1u;
    uint _e57 = combined.serial;
    output[slot].serial = _e57;
    metal::float2 _e62 = combined.uv;
    output[slot].uv = _e62;
    {
        sample = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e85 = sample;
                sample = as_type<int>(as_type<uint>(_e85) + as_type<uint>(1));
            }
            loop_init = false;
            int _e67 = sample;
            if (_e67 < 2) {
            } else {
                break;
            }
            int _e71 = sample;
            Sample_cuda_record_0_ _e73 = combined.samples.inner[_e71];
            local_1 = slot;
            int _e75 = sample;
            local_2 = static_cast<uint>(_e75);
            uint _e78 = local_1;
            local_8 = _e78;
            uint _e80 = local_8;
            uint _e83 = local_2;
            output[_e80].samples.inner[_e83] = _e73;
        }
    }
    {
        row = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e123 = row;
                row = as_type<int>(as_type<uint>(_e123) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e90 = row;
            if (_e90 < 2) {
            } else {
                break;
            }
            {
                column = 0;
                uint2 loop_bound_2 = uint2(4294967295u);
                bool loop_init_2 = true;
                while(true) {
                    if (metal::all(loop_bound_2 == uint2(0u))) { break; }
                    loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
                    if (!loop_init_2) {
                        int _e120 = column;
                        column = as_type<int>(as_type<uint>(_e120) + as_type<uint>(1));
                    }
                    loop_init_2 = false;
                    int _e95 = column;
                    if (_e95 < 2) {
                    } else {
                        break;
                    }
                    int _e99 = row;
                    int _e101 = column;
                    float _e103 = combined.weights.inner[_e99].inner[_e101];
                    local_3 = slot;
                    int _e105 = row;
                    local_4 = static_cast<uint>(_e105);
                    int _e108 = column;
                    local_5 = static_cast<uint>(_e108);
                    uint _e111 = local_3;
                    local_9 = _e111;
                    uint _e113 = local_9;
                    uint _e116 = local_4;
                    uint _e118 = local_5;
                    output[_e113].weights.inner[_e116].inner[_e118] = _e103;
                }
            }
        }
    }
    metal::float4 _e127 = combined.colour;
    output[slot].colour = _e127;
}
