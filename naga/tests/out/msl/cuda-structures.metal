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
struct type_10 {
    uint inner[2];
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
, device type_8 const& input_1 [[user(fake0)]]
, device type_8& output_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_10 input = {};
    type_10 output = {};
    Packet_cuda_record_1_ original = {};
    type_10 local = {};
    uint local_1 = {};
    Packet_cuda_record_1_ changed = {};
    Packet_cuda_record_2_ local_2 = {};
    Packet_cuda_record_1_ combined = {};
    type_10 local_3 = {};
    uint local_4 = {};
    type_10 local_5 = {};
    uint local_6 = {};
    int sample = {};
    type_10 local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    int row = {};
    int column = {};
    type_10 local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    type_10 local_14 = {};
    uint local_15 = {};
    Packet_cuda_record_1_ local_16 = {};
    type_10 local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    Packet_cuda_record_1_ local_20 = {};
    type_10 local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    type_10 local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    type_10 local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    type_10 local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    type_10 local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    input = type_10 {};
    input.inner[0] = 0u;
    input.inner[1] = 0u;
    output = type_10 {};
    output.inner[0] = 1u;
    output.inner[1] = 0u;
    uint lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    type_10 _e17 = input;
    local = _e17;
    local_1 = static_cast<uint>(lane);
    type_10 _e21 = local;
    local_17 = _e21;
    uint _e23 = local_1;
    uint _e25 = local_17.inner[1];
    local_17.inner[1] = _e25 + _e23;
    uint _e29 = local_17.inner[0];
    local_18 = static_cast<uint>(_e29);
    uint _e33 = local_17.inner[1];
    local_19 = static_cast<uint>(_e33);
    uint _e36 = local_19;
    Packet_cuda_record_1_ _e39 = input_1[_e36];
    local_20 = _e39;
    Packet_cuda_record_1_ _e41 = local_20;
    local_16 = _e41;
    Packet_cuda_record_1_ _e43 = local_16;
    original = _e43;
    Packet_cuda_record_1_ _e45 = original;
    Packet_cuda_record_1_ _e49 = adjust(_e45, as_type<int>(as_type<uint>(3) + as_type<uint>(static_cast<int>(lane))));
    changed = _e49;
    {
        local_2.w = 7;
        local_2.x = 11;
        int _e58 = local_2.w;
        int _e59 = local_2.x;
        uint _e66 = changed.samples.inner[0].tag;
        changed.samples.inner[0].tag = _e66 + static_cast<uint>(as_type<int>(as_type<uint>(_e58) + as_type<uint>(_e59)));
    }
    Packet_cuda_record_1_ _e68 = changed;
    Packet_cuda_record_1_ _e69 = original;
    Packet_cuda_record_1_ _e70 = operator_u002b(_e68, _e69);
    combined = _e70;
    uint _e73 = original.serial;
    float _e80 = combined.weights.inner[0].inner[0];
    combined.weights.inner[0].inner[0] = _e80 + static_cast<float>(_e73);
    uint _e83 = combined.serial;
    combined.colour.w = static_cast<float>(_e83);
    uint slot = lane + 1u;
    uint _e90 = combined.serial;
    type_10 _e92 = output;
    local_3 = _e92;
    local_4 = static_cast<uint>(slot);
    type_10 _e96 = local_3;
    local_21 = _e96;
    uint _e98 = local_4;
    uint _e100 = local_21.inner[1];
    local_21.inner[1] = _e100 + _e98;
    uint _e104 = local_21.inner[0];
    local_22 = static_cast<uint>(_e104);
    uint _e108 = local_21.inner[1];
    local_23 = static_cast<uint>(_e108);
    uint _e111 = local_23;
    output_1[_e111].serial = _e90;
    metal::float2 _e116 = combined.uv;
    type_10 _e117 = output;
    local_5 = _e117;
    local_6 = static_cast<uint>(slot);
    type_10 _e121 = local_5;
    local_24 = _e121;
    uint _e123 = local_6;
    uint _e125 = local_24.inner[1];
    local_24.inner[1] = _e125 + _e123;
    uint _e129 = local_24.inner[0];
    local_25 = static_cast<uint>(_e129);
    uint _e133 = local_24.inner[1];
    local_26 = static_cast<uint>(_e133);
    uint _e136 = local_26;
    output_1[_e136].uv = _e116;
    {
        sample = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e175 = sample;
                sample = as_type<int>(as_type<uint>(_e175) + as_type<uint>(1));
            }
            loop_init = false;
            int _e141 = sample;
            if (_e141 < 2) {
            } else {
                break;
            }
            int _e145 = sample;
            Sample_cuda_record_0_ _e147 = combined.samples.inner[_e145];
            type_10 _e148 = output;
            local_7 = _e148;
            local_8 = static_cast<uint>(slot);
            int _e152 = sample;
            local_9 = static_cast<uint>(_e152);
            type_10 _e155 = local_7;
            local_27 = _e155;
            uint _e157 = local_8;
            uint _e159 = local_27.inner[1];
            local_27.inner[1] = _e159 + _e157;
            uint _e163 = local_27.inner[0];
            local_28 = static_cast<uint>(_e163);
            uint _e167 = local_27.inner[1];
            local_29 = static_cast<uint>(_e167);
            uint _e170 = local_29;
            uint _e173 = local_9;
            output_1[_e170].samples.inner[_e173] = _e147;
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
                int _e229 = row;
                row = as_type<int>(as_type<uint>(_e229) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e180 = row;
            if (_e180 < 2) {
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
                        int _e226 = column;
                        column = as_type<int>(as_type<uint>(_e226) + as_type<uint>(1));
                    }
                    loop_init_2 = false;
                    int _e185 = column;
                    if (_e185 < 2) {
                    } else {
                        break;
                    }
                    int _e189 = row;
                    int _e191 = column;
                    float _e193 = combined.weights.inner[_e189].inner[_e191];
                    type_10 _e194 = output;
                    local_10 = _e194;
                    local_11 = static_cast<uint>(slot);
                    int _e198 = row;
                    local_12 = static_cast<uint>(_e198);
                    int _e201 = column;
                    local_13 = static_cast<uint>(_e201);
                    type_10 _e204 = local_10;
                    local_30 = _e204;
                    uint _e206 = local_11;
                    uint _e208 = local_30.inner[1];
                    local_30.inner[1] = _e208 + _e206;
                    uint _e212 = local_30.inner[0];
                    local_31 = static_cast<uint>(_e212);
                    uint _e216 = local_30.inner[1];
                    local_32 = static_cast<uint>(_e216);
                    uint _e219 = local_32;
                    uint _e222 = local_12;
                    uint _e224 = local_13;
                    output_1[_e219].weights.inner[_e222].inner[_e224] = _e193;
                }
            }
        }
    }
    metal::float4 _e233 = combined.colour;
    type_10 _e234 = output;
    local_14 = _e234;
    local_15 = static_cast<uint>(slot);
    type_10 _e238 = local_14;
    local_33 = _e238;
    uint _e240 = local_15;
    uint _e242 = local_33.inner[1];
    local_33.inner[1] = _e242 + _e240;
    uint _e246 = local_33.inner[0];
    local_34 = static_cast<uint>(_e246);
    uint _e250 = local_33.inner[1];
    local_35 = static_cast<uint>(_e250);
    uint _e253 = local_35;
    output_1[_e253].colour = _e233;
}
