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
    int bias_1 = {};
    value_1 = value;
    bias_1 = bias;
    int _e5 = bias_1;
    uint _e7 = value_1.serial;
    value_1.serial = _e7 + static_cast<uint>(_e5);
    float _e19 = value_1.weights.inner[0].inner[1];
    float _e20 = value_1.samples.inner[1].position.x;
    value_1.samples.inner[1].position.x = _e20 + _e19;
    uint _e31 = value_1.samples.inner[0].tag;
    value_1.weights.inner[1].inner[0] = static_cast<float>(_e31);
    Packet_cuda_record_1_ _e33 = value_1;
    return _e33;
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
    uint local = {};
    uint local_1 = {};
    uint lane = {};
    Packet_cuda_record_1_ original = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    Packet_cuda_record_1_ changed = {};
    Packet_cuda_record_2_ local_5 = {};
    Packet_cuda_record_1_ combined = {};
    uint slot = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    int sample = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    int row = {};
    int column = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    Packet_cuda_record_1_ local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    local = 0u;
    local_1 = 0u;
    lane = threadIdx.x;
    uint _e7 = lane;
    if (_e7 >= 2u) {
        return;
    }
    uint _e10 = local;
    local_2 = _e10;
    uint _e12 = local_2;
    local_3 = static_cast<uint>(_e12);
    uint _e15 = lane;
    local_4 = static_cast<uint>(_e15);
    uint _e19 = local_3;
    uint _e20 = local_4;
    local_24 = static_cast<uint>(_e19 + _e20);
    uint _e25 = local_24;
    Packet_cuda_record_1_ _e27 = input[_e25];
    local_25 = _e27;
    Packet_cuda_record_1_ _e28 = local_25;
    original = _e28;
    Packet_cuda_record_1_ _e30 = original;
    uint _e31 = lane;
    Packet_cuda_record_1_ _e35 = adjust(_e30, as_type<int>(as_type<uint>(3) + as_type<uint>(static_cast<int>(_e31))));
    changed = _e35;
    {
        local_5.w = 7;
        local_5.x = 11;
        int _e44 = local_5.w;
        int _e45 = local_5.x;
        uint _e52 = changed.samples.inner[0].tag;
        changed.samples.inner[0].tag = _e52 + static_cast<uint>(as_type<int>(as_type<uint>(_e44) + as_type<uint>(_e45)));
    }
    Packet_cuda_record_1_ _e54 = changed;
    Packet_cuda_record_1_ _e55 = original;
    Packet_cuda_record_1_ _e56 = operator_u002b(_e54, _e55);
    combined = _e56;
    uint _e59 = original.serial;
    float _e66 = combined.weights.inner[0].inner[0];
    combined.weights.inner[0].inner[0] = _e66 + static_cast<float>(_e59);
    uint _e69 = combined.serial;
    combined.colour.w = static_cast<float>(_e69);
    uint _e73 = lane;
    slot = _e73 + 1u;
    uint _e78 = combined.serial;
    uint _e79 = local_1;
    local_6 = _e79;
    uint _e81 = local_6;
    local_7 = static_cast<uint>(_e81);
    uint _e84 = slot;
    local_8 = static_cast<uint>(_e84);
    uint _e88 = local_7;
    uint _e89 = local_8;
    local_26 = static_cast<uint>(_e88 + _e89);
    uint _e93 = local_26;
    output[_e93].serial = _e78;
    metal::float2 _e97 = combined.uv;
    uint _e98 = local_1;
    local_9 = _e98;
    uint _e100 = local_9;
    local_10 = static_cast<uint>(_e100);
    uint _e103 = slot;
    local_11 = static_cast<uint>(_e103);
    uint _e106 = local_10;
    uint _e107 = local_11;
    local_27 = static_cast<uint>(_e106 + _e107);
    uint _e111 = local_27;
    output[_e111].uv = _e97;
    {
        sample = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e144 = sample;
                sample = as_type<int>(as_type<uint>(_e144) + as_type<uint>(1));
            }
            loop_init = false;
            int _e116 = sample;
            if (_e116 < 2) {
            } else {
                break;
            }
            int _e120 = sample;
            Sample_cuda_record_0_ _e122 = combined.samples.inner[_e120];
            uint _e123 = local_1;
            local_12 = _e123;
            uint _e125 = local_12;
            local_13 = static_cast<uint>(_e125);
            uint _e128 = slot;
            local_14 = static_cast<uint>(_e128);
            int _e131 = sample;
            local_15 = static_cast<uint>(_e131);
            uint _e134 = local_13;
            uint _e135 = local_14;
            local_28 = static_cast<uint>(_e134 + _e135);
            uint _e139 = local_28;
            uint _e142 = local_15;
            output[_e139].samples.inner[_e142] = _e122;
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
                int _e192 = row;
                row = as_type<int>(as_type<uint>(_e192) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e149 = row;
            if (_e149 < 2) {
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
                        int _e189 = column;
                        column = as_type<int>(as_type<uint>(_e189) + as_type<uint>(1));
                    }
                    loop_init_2 = false;
                    int _e154 = column;
                    if (_e154 < 2) {
                    } else {
                        break;
                    }
                    int _e158 = row;
                    int _e160 = column;
                    float _e162 = combined.weights.inner[_e158].inner[_e160];
                    uint _e163 = local_1;
                    local_16 = _e163;
                    uint _e165 = local_16;
                    local_17 = static_cast<uint>(_e165);
                    uint _e168 = slot;
                    local_18 = static_cast<uint>(_e168);
                    int _e171 = row;
                    local_19 = static_cast<uint>(_e171);
                    int _e174 = column;
                    local_20 = static_cast<uint>(_e174);
                    uint _e177 = local_17;
                    uint _e178 = local_18;
                    local_29 = static_cast<uint>(_e177 + _e178);
                    uint _e182 = local_29;
                    uint _e185 = local_19;
                    uint _e187 = local_20;
                    output[_e182].weights.inner[_e185].inner[_e187] = _e162;
                }
            }
        }
    }
    metal::float4 _e196 = combined.colour;
    uint _e197 = local_1;
    local_21 = _e197;
    uint _e199 = local_21;
    local_22 = static_cast<uint>(_e199);
    uint _e202 = slot;
    local_23 = static_cast<uint>(_e202);
    uint _e205 = local_22;
    uint _e206 = local_23;
    local_30 = static_cast<uint>(_e205 + _e206);
    uint _e210 = local_30;
    output[_e210].colour = _e196;
}
