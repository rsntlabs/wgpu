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
, device type_8 const& input [[user(fake0)]]
, device type_8& output [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_10 local = {};
    type_10 local_1 = {};
    uint lane = {};
    Packet_cuda_record_1_ original = {};
    type_10 local_2 = {};
    uint local_3 = {};
    Packet_cuda_record_1_ changed = {};
    Packet_cuda_record_2_ local_4 = {};
    Packet_cuda_record_1_ combined = {};
    uint slot = {};
    type_10 local_5 = {};
    uint local_6 = {};
    type_10 local_7 = {};
    uint local_8 = {};
    int sample = {};
    type_10 local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    int row = {};
    int column = {};
    type_10 local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    type_10 local_16 = {};
    uint local_17 = {};
    Packet_cuda_record_1_ local_18 = {};
    type_10 local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    Packet_cuda_record_1_ local_22 = {};
    type_10 local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    type_10 local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    type_10 local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    type_10 local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    type_10 local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    local = type_10 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    local_1 = type_10 {};
    local_1.inner[0] = 1u;
    local_1.inner[1] = 0u;
    lane = threadIdx.x;
    uint _e17 = lane;
    if (_e17 >= 2u) {
        return;
    }
    type_10 _e22 = local;
    local_2 = _e22;
    uint _e23 = lane;
    local_3 = static_cast<uint>(_e23);
    type_10 _e27 = local_2;
    local_19 = _e27;
    uint _e28 = local_3;
    uint _e30 = local_19.inner[1];
    local_19.inner[1] = _e30 + _e28;
    uint _e34 = local_19.inner[0];
    local_20 = static_cast<uint>(_e34);
    uint _e38 = local_19.inner[1];
    local_21 = static_cast<uint>(_e38);
    uint _e42 = local_21;
    Packet_cuda_record_1_ _e44 = input[_e42];
    local_22 = _e44;
    Packet_cuda_record_1_ _e45 = local_22;
    local_18 = _e45;
    Packet_cuda_record_1_ _e47 = local_18;
    original = _e47;
    Packet_cuda_record_1_ _e49 = original;
    uint _e50 = lane;
    Packet_cuda_record_1_ _e54 = adjust(_e49, as_type<int>(as_type<uint>(3) + as_type<uint>(static_cast<int>(_e50))));
    changed = _e54;
    {
        local_4.w = 7;
        local_4.x = 11;
        int _e63 = local_4.w;
        int _e64 = local_4.x;
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
    type_10 _e100 = local_1;
    local_5 = _e100;
    uint _e101 = slot;
    local_6 = static_cast<uint>(_e101);
    type_10 _e105 = local_5;
    local_23 = _e105;
    uint _e106 = local_6;
    uint _e108 = local_23.inner[1];
    local_23.inner[1] = _e108 + _e106;
    uint _e112 = local_23.inner[0];
    local_24 = static_cast<uint>(_e112);
    uint _e116 = local_23.inner[1];
    local_25 = static_cast<uint>(_e116);
    uint _e119 = local_25;
    output[_e119].serial = _e97;
    metal::float2 _e123 = combined.uv;
    type_10 _e125 = local_1;
    local_7 = _e125;
    uint _e126 = slot;
    local_8 = static_cast<uint>(_e126);
    type_10 _e130 = local_7;
    local_26 = _e130;
    uint _e131 = local_8;
    uint _e133 = local_26.inner[1];
    local_26.inner[1] = _e133 + _e131;
    uint _e137 = local_26.inner[0];
    local_27 = static_cast<uint>(_e137);
    uint _e141 = local_26.inner[1];
    local_28 = static_cast<uint>(_e141);
    uint _e144 = local_28;
    output[_e144].uv = _e123;
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
            type_10 _e157 = local_1;
            local_9 = _e157;
            uint _e158 = slot;
            local_10 = static_cast<uint>(_e158);
            int _e161 = sample;
            local_11 = static_cast<uint>(_e161);
            type_10 _e165 = local_9;
            local_29 = _e165;
            uint _e166 = local_10;
            uint _e168 = local_29.inner[1];
            local_29.inner[1] = _e168 + _e166;
            uint _e172 = local_29.inner[0];
            local_30 = static_cast<uint>(_e172);
            uint _e176 = local_29.inner[1];
            local_31 = static_cast<uint>(_e176);
            uint _e179 = local_31;
            uint _e182 = local_11;
            output[_e179].samples.inner[_e182] = _e155;
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
                    type_10 _e204 = local_1;
                    local_12 = _e204;
                    uint _e205 = slot;
                    local_13 = static_cast<uint>(_e205);
                    int _e208 = row;
                    local_14 = static_cast<uint>(_e208);
                    int _e211 = column;
                    local_15 = static_cast<uint>(_e211);
                    type_10 _e215 = local_12;
                    local_32 = _e215;
                    uint _e216 = local_13;
                    uint _e218 = local_32.inner[1];
                    local_32.inner[1] = _e218 + _e216;
                    uint _e222 = local_32.inner[0];
                    local_33 = static_cast<uint>(_e222);
                    uint _e226 = local_32.inner[1];
                    local_34 = static_cast<uint>(_e226);
                    uint _e229 = local_34;
                    uint _e232 = local_14;
                    uint _e234 = local_15;
                    output[_e229].weights.inner[_e232].inner[_e234] = _e202;
                }
            }
        }
    }
    metal::float4 _e243 = combined.colour;
    type_10 _e245 = local_1;
    local_16 = _e245;
    uint _e246 = slot;
    local_17 = static_cast<uint>(_e246);
    type_10 _e250 = local_16;
    local_35 = _e250;
    uint _e251 = local_17;
    uint _e253 = local_35.inner[1];
    local_35.inner[1] = _e253 + _e251;
    uint _e257 = local_35.inner[0];
    local_36 = static_cast<uint>(_e257);
    uint _e261 = local_35.inner[1];
    local_37 = static_cast<uint>(_e261);
    uint _e264 = local_37;
    output[_e264].colour = _e243;
}
