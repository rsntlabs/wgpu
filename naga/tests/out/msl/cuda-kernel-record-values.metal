// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size5;
};

struct One_cuda_record_0_ {
    int x;
};
struct Two_cuda_record_1_ {
    uint x;
    float y;
};
struct Trio_cuda_record_2_ {
    int x;
    uint y;
    float z;
};
struct Four_cuda_record_3_ {
    int x;
    uint y;
    float z;
    uint w;
};
struct Twin_cuda_record_4_ {
    int x;
    uint y;
    float z;
};
typedef uint type_3[1];
struct type_4 {
    One_cuda_record_0_ value;
    char _pad1[12];
};
struct type_5 {
    Two_cuda_record_1_ value;
    char _pad1[8];
};
struct type_6 {
    Trio_cuda_record_2_ value;
    char _pad1[4];
};
struct type_7 {
    Four_cuda_record_3_ value;
};
typedef Trio_cuda_record_2_ type_8[1];

uint kind(
    Trio_cuda_record_2_ param
) {
    return 11u;
}

uint kind_1(
    Twin_cuda_record_4_ param_1
) {
    return 22u;
}
uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}


struct record_valuesInput {
};
kernel void record_values(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_3& output [[buffer(0)]]
, constant type_4& one_1 [[buffer(1)]]
, constant type_5& two_1 [[buffer(2)]]
, constant type_6& three_1 [[buffer(3)]]
, constant type_7& four_1 [[buffer(4)]]
, device type_8 const& input [[buffer(5)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(6)]]
) {
    One_cuda_record_0_ one = {};
    Two_cuda_record_1_ two = {};
    Trio_cuda_record_2_ three = {};
    Four_cuda_record_3_ four = {};
    Trio_cuda_record_2_ original = {};
    Four_cuda_record_3_ changed = {};
    Twin_cuda_record_4_ other = {};
    Trio_cuda_record_2_ stored = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint lane = {};
    Trio_cuda_record_2_ local_11 = {};
    Trio_cuda_record_2_ local_12 = {};
    One_cuda_record_0_ _e4 = one_1.value;
    one = _e4;
    Two_cuda_record_1_ _e8 = two_1.value;
    two = _e8;
    Trio_cuda_record_2_ _e12 = three_1.value;
    three = _e12;
    Four_cuda_record_3_ _e16 = four_1.value;
    four = _e16;
    uint lane_1 = threadIdx.x + (blockIdx.x * 4u);
    if (lane_1 >= 4u) {
        return;
    }
    uint base = 4u + (lane_1 * 12u);
    Trio_cuda_record_2_ _e29 = three;
    original = _e29;
    int _e33 = one.x;
    one.x = as_type<int>(as_type<uint>(_e33) + as_type<uint>(static_cast<int>(lane_1)));
    lane = uint {};
    lane = lane_1;
    uint _e38 = lane;
    uint _e40 = three.y;
    three.y = _e40 + _e38;
    int _e45 = three.x;
    three.x = as_type<int>(as_type<uint>(_e45) - as_type<uint>(static_cast<int>(lane_1)));
    Four_cuda_record_3_ _e47 = four;
    changed = _e47;
    int _e51 = changed.x;
    changed.x = as_type<int>(as_type<uint>(_e51) + as_type<uint>(static_cast<int>(lane_1)));
    uint _e54 = changed.y;
    changed.y = _e54 + 1u;
    float _e58 = changed.z;
    changed.z = _e58 * 2.0;
    Four_cuda_record_3_ _e61 = changed;
    four = _e61;
    int _e63 = original.x;
    other.x = _e63;
    uint _e67 = original.y;
    other.y = _e67;
    float _e70 = original.z;
    other.z = _e70;
    Trio_cuda_record_2_ _e74 = input[lane_1];
    local_12 = _e74;
    Trio_cuda_record_2_ _e76 = local_12;
    local_11 = _e76;
    Trio_cuda_record_2_ _e78 = local_11;
    stored = _e78;
    int _e81 = one.x;
    output[base] = static_cast<uint>(as_type<int>(as_type<uint>(_e81) + as_type<uint>(10)));
    uint _e88 = two.x;
    local = static_cast<uint>(base + 1u);
    uint _e93 = local;
    output[_e93] = _e88;
    float _e96 = two.y;
    local_1 = static_cast<uint>(base + 2u);
    uint _e102 = local_1;
    output[_e102] = as_type<uint>(_e96);
    int _e105 = three.x;
    local_2 = static_cast<uint>(base + 3u);
    uint _e113 = local_2;
    output[_e113] = static_cast<uint>(as_type<int>(as_type<uint>(_e105) + as_type<uint>(20)));
    uint _e116 = three.y;
    local_3 = static_cast<uint>(base + 4u);
    uint _e121 = local_3;
    output[_e121] = _e116;
    float _e124 = three.z;
    local_4 = static_cast<uint>(base + 5u);
    uint _e130 = local_4;
    output[_e130] = as_type<uint>(_e124);
    int _e133 = four.x;
    local_5 = static_cast<uint>(base + 6u);
    uint _e141 = local_5;
    output[_e141] = static_cast<uint>(as_type<int>(as_type<uint>(_e133) + as_type<uint>(20)));
    uint _e144 = four.y;
    local_6 = static_cast<uint>(base + 7u);
    uint _e149 = local_6;
    output[_e149] = _e144;
    float _e152 = four.z;
    local_7 = static_cast<uint>(base + 8u);
    uint _e158 = local_7;
    output[_e158] = as_type<uint>(_e152);
    uint _e161 = four.w;
    local_8 = static_cast<uint>(base + 9u);
    uint _e166 = local_8;
    output[_e166] = _e161;
    uint _e169 = original.y;
    local_9 = static_cast<uint>(base + 10u);
    uint _e174 = local_9;
    output[_e174] = _e169;
    Trio_cuda_record_2_ _e176 = three;
    uint _e177 = kind(_e176);
    Twin_cuda_record_4_ _e178 = other;
    uint _e179 = kind_1(_e178);
    int _e182 = stored.x;
    uint _e186 = stored.y;
    float _e189 = stored.z;
    local_10 = static_cast<uint>(base + 11u);
    uint _e196 = local_10;
    output[_e196] = (((_e177 + _e179) + static_cast<uint>(_e182)) + _e186) + naga_f2u32(_e189);
}
