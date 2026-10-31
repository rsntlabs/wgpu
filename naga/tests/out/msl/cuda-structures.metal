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
, device type_8 const& input_1 [[user(fake0)]]
, device type_8& output_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_10 input = {};
    type_10 output = {};
    uint lane = {};
    Packet_cuda_record_1_ original = {};
    type_10 local = {};
    uint local_1 = {};
    Packet_cuda_record_1_ changed = {};
    Packet_cuda_record_2_ local_2 = {};
    Packet_cuda_record_1_ combined = {};
    uint slot = {};
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
    lane = threadIdx.x;
    uint _e17 = lane;
    if (_e17 >= 2u) {
        return;
    }
    type_10 _e22 = input;
    local = _e22;
    uint _e23 = lane;
    local_1 = static_cast<uint>(_e23);
    type_10 _e27 = local;
    local_17 = _e27;
    uint _e28 = local_1;
    uint _e30 = local_17.inner[1];
    local_17.inner[1] = _e30 + _e28;
    uint _e34 = local_17.inner[0];
    local_18 = static_cast<uint>(_e34);
    uint _e38 = local_17.inner[1];
    local_19 = static_cast<uint>(_e38);
    uint _e42 = local_19;
    Packet_cuda_record_1_ _e44 = input_1[_e42];
    local_20 = _e44;
    Packet_cuda_record_1_ _e45 = local_20;
    local_16 = _e45;
    Packet_cuda_record_1_ _e47 = local_16;
    original = _e47;
    Packet_cuda_record_1_ _e49 = original;
    uint _e50 = lane;
    Packet_cuda_record_1_ _e54 = adjust(_e49, as_type<int>(as_type<uint>(3) + as_type<uint>(static_cast<int>(_e50))));
    changed = _e54;
    {
        local_2.w = 7;
        local_2.x = 11;
        int _e63 = local_2.w;
        int _e64 = local_2.x;
        uint _e71 = changed.samples.inner[0].tag;
        changed.samples.inner[0].tag = _e71 + static_cast<uint>(as_type<int>(as_type<uint>(_e63) + as_type<uint>(_e64)));
    }
    Packet_cuda_record_1_ _e73 = changed;
    Packet_cuda_record_1_ _e74 = original;
    Packet_cuda_record_1_ _e75 = operator_u002b(_e73, _e74);
    combined = _e75;
    uint _e78 = original.serial;
    float _e85 = combined.weights.inner[0].inner[0];
    combined.weights.inner[0].inner[0] = _e85 + static_cast<float>(_e78);
    uint _e88 = combined.serial;
    combined.colour.w = static_cast<float>(_e88);
    uint _e92 = lane;
    slot = _e92 + 1u;
    uint _e97 = combined.serial;
    type_10 _e100 = output;
    local_3 = _e100;
    uint _e101 = slot;
    local_4 = static_cast<uint>(_e101);
    type_10 _e105 = local_3;
    local_21 = _e105;
    uint _e106 = local_4;
    uint _e108 = local_21.inner[1];
    local_21.inner[1] = _e108 + _e106;
    uint _e112 = local_21.inner[0];
    local_22 = static_cast<uint>(_e112);
    uint _e116 = local_21.inner[1];
    local_23 = static_cast<uint>(_e116);
    uint _e119 = local_23;
    output_1[_e119].serial = _e97;
    metal::float2 _e123 = combined.uv;
    type_10 _e125 = output;
    local_5 = _e125;
    uint _e126 = slot;
    local_6 = static_cast<uint>(_e126);
    type_10 _e130 = local_5;
    local_24 = _e130;
    uint _e131 = local_6;
    uint _e133 = local_24.inner[1];
    local_24.inner[1] = _e133 + _e131;
    uint _e137 = local_24.inner[0];
    local_25 = static_cast<uint>(_e137);
    uint _e141 = local_24.inner[1];
    local_26 = static_cast<uint>(_e141);
    uint _e144 = local_26;
    output_1[_e144].uv = _e123;
    {
        sample = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e184 = sample;
                sample = as_type<int>(as_type<uint>(_e184) + as_type<uint>(1));
            }
            loop_init = false;
            int _e149 = sample;
            if (_e149 < 2) {
            } else {
                break;
            }
            int _e153 = sample;
            Sample_cuda_record_0_ _e155 = combined.samples.inner[_e153];
            type_10 _e157 = output;
            local_7 = _e157;
            uint _e158 = slot;
            local_8 = static_cast<uint>(_e158);
            int _e161 = sample;
            local_9 = static_cast<uint>(_e161);
            type_10 _e165 = local_7;
            local_27 = _e165;
            uint _e166 = local_8;
            uint _e168 = local_27.inner[1];
            local_27.inner[1] = _e168 + _e166;
            uint _e172 = local_27.inner[0];
            local_28 = static_cast<uint>(_e172);
            uint _e176 = local_27.inner[1];
            local_29 = static_cast<uint>(_e176);
            uint _e179 = local_29;
            uint _e182 = local_9;
            output_1[_e179].samples.inner[_e182] = _e155;
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
                int _e239 = row;
                row = as_type<int>(as_type<uint>(_e239) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e189 = row;
            if (_e189 < 2) {
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
                        int _e236 = column;
                        column = as_type<int>(as_type<uint>(_e236) + as_type<uint>(1));
                    }
                    loop_init_2 = false;
                    int _e194 = column;
                    if (_e194 < 2) {
                    } else {
                        break;
                    }
                    int _e198 = row;
                    int _e200 = column;
                    float _e202 = combined.weights.inner[_e198].inner[_e200];
                    type_10 _e204 = output;
                    local_10 = _e204;
                    uint _e205 = slot;
                    local_11 = static_cast<uint>(_e205);
                    int _e208 = row;
                    local_12 = static_cast<uint>(_e208);
                    int _e211 = column;
                    local_13 = static_cast<uint>(_e211);
                    type_10 _e215 = local_10;
                    local_30 = _e215;
                    uint _e216 = local_11;
                    uint _e218 = local_30.inner[1];
                    local_30.inner[1] = _e218 + _e216;
                    uint _e222 = local_30.inner[0];
                    local_31 = static_cast<uint>(_e222);
                    uint _e226 = local_30.inner[1];
                    local_32 = static_cast<uint>(_e226);
                    uint _e229 = local_32;
                    uint _e232 = local_12;
                    uint _e234 = local_13;
                    output_1[_e229].weights.inner[_e232].inner[_e234] = _e202;
                }
            }
        }
    }
    metal::float4 _e243 = combined.colour;
    type_10 _e245 = output;
    local_14 = _e245;
    uint _e246 = slot;
    local_15 = static_cast<uint>(_e246);
    type_10 _e250 = local_14;
    local_33 = _e250;
    uint _e251 = local_15;
    uint _e253 = local_33.inner[1];
    local_33.inner[1] = _e253 + _e251;
    uint _e257 = local_33.inner[0];
    local_34 = static_cast<uint>(_e257);
    uint _e261 = local_33.inner[1];
    local_35 = static_cast<uint>(_e261);
    uint _e264 = local_35;
    output_1[_e264].colour = _e243;
}
