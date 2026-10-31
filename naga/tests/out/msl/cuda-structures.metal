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
    uint local = {};
    Packet_cuda_record_1_ changed = {};
    Packet_cuda_record_2_ local_1 = {};
    Packet_cuda_record_1_ combined = {};
    uint local_2 = {};
    uint local_3 = {};
    int sample = {};
    uint local_4 = {};
    uint local_5 = {};
    int row = {};
    int column = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    Packet_cuda_record_1_ local_10 = {};
    uint local_11 = {};
    Packet_cuda_record_1_ local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    local = static_cast<uint>(lane);
    uint _e6 = local;
    local_11 = static_cast<uint>(_e6);
    uint _e9 = local_11;
    Packet_cuda_record_1_ _e12 = input[_e9];
    local_12 = _e12;
    Packet_cuda_record_1_ _e14 = local_12;
    local_10 = _e14;
    Packet_cuda_record_1_ _e16 = local_10;
    original = _e16;
    Packet_cuda_record_1_ _e18 = original;
    Packet_cuda_record_1_ _e22 = adjust(_e18, as_type<int>(as_type<uint>(3) + as_type<uint>(static_cast<int>(lane))));
    changed = _e22;
    {
        local_1.w = 7;
        local_1.x = 11;
        int _e31 = local_1.w;
        int _e32 = local_1.x;
        uint _e39 = changed.samples.inner[0].tag;
        changed.samples.inner[0].tag = _e39 + static_cast<uint>(as_type<int>(as_type<uint>(_e31) + as_type<uint>(_e32)));
    }
    Packet_cuda_record_1_ _e41 = changed;
    Packet_cuda_record_1_ _e42 = original;
    Packet_cuda_record_1_ _e43 = operator_u002b(_e41, _e42);
    combined = _e43;
    uint _e46 = original.serial;
    float _e53 = combined.weights.inner[0].inner[0];
    combined.weights.inner[0].inner[0] = _e53 + static_cast<float>(_e46);
    uint _e56 = combined.serial;
    combined.colour.w = static_cast<float>(_e56);
    uint slot = lane + 1u;
    uint _e63 = combined.serial;
    local_2 = static_cast<uint>(slot);
    uint _e66 = local_2;
    local_13 = static_cast<uint>(_e66);
    uint _e69 = local_13;
    output[_e69].serial = _e63;
    metal::float2 _e74 = combined.uv;
    local_3 = static_cast<uint>(slot);
    uint _e77 = local_3;
    local_14 = static_cast<uint>(_e77);
    uint _e80 = local_14;
    output[_e80].uv = _e74;
    {
        sample = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e105 = sample;
                sample = as_type<int>(as_type<uint>(_e105) + as_type<uint>(1));
            }
            loop_init = false;
            int _e85 = sample;
            if (_e85 < 2) {
            } else {
                break;
            }
            int _e89 = sample;
            Sample_cuda_record_0_ _e91 = combined.samples.inner[_e89];
            local_4 = static_cast<uint>(slot);
            int _e94 = sample;
            local_5 = static_cast<uint>(_e94);
            uint _e97 = local_4;
            local_15 = static_cast<uint>(_e97);
            uint _e100 = local_15;
            uint _e103 = local_5;
            output[_e100].samples.inner[_e103] = _e91;
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
                int _e145 = row;
                row = as_type<int>(as_type<uint>(_e145) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e110 = row;
            if (_e110 < 2) {
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
                        int _e142 = column;
                        column = as_type<int>(as_type<uint>(_e142) + as_type<uint>(1));
                    }
                    loop_init_2 = false;
                    int _e115 = column;
                    if (_e115 < 2) {
                    } else {
                        break;
                    }
                    int _e119 = row;
                    int _e121 = column;
                    float _e123 = combined.weights.inner[_e119].inner[_e121];
                    local_6 = static_cast<uint>(slot);
                    int _e126 = row;
                    local_7 = static_cast<uint>(_e126);
                    int _e129 = column;
                    local_8 = static_cast<uint>(_e129);
                    uint _e132 = local_6;
                    local_16 = static_cast<uint>(_e132);
                    uint _e135 = local_16;
                    uint _e138 = local_7;
                    uint _e140 = local_8;
                    output[_e135].weights.inner[_e138].inner[_e140] = _e123;
                }
            }
        }
    }
    metal::float4 _e149 = combined.colour;
    local_9 = static_cast<uint>(slot);
    uint _e152 = local_9;
    local_17 = static_cast<uint>(_e152);
    uint _e155 = local_17;
    output[_e155].colour = _e149;
}
