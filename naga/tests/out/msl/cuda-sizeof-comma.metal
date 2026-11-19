// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

struct Record_cuda_record_0_ {
    int first;
    uint second;
    float third;
};
typedef int type_3[1];
typedef uint type_4[1];
struct type_6 {
    int inner[3];
};
struct type_7 {
    type_6 inner[2];
};

struct sizeof_commaInput {
};
kernel void sizeof_comma(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_3 const& input [[buffer(0)]]
, device type_4& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    int counter = {};
    type_7 matrix_ = {};
    uint local = {};
    uint local_1 = {};
    Record_cuda_record_0_ record = {};
    uint Scalar = {};
    uint Boolean = {};
    uint Array = {};
    uint Row = {};
    uint Element = {};
    uint Member = {};
    uint Pointer = {};
    uint Null = {};
    uint Middle = {};
    uint Outer = {};
    uint Nested = {};
    uint NoRead = {};
    uint InvalidMath = {};
    uint NullArm = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 16u);
    int seed = input[lane];
    bool flag = seed != 0;
    counter = 7;
    local = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e30 = local;
            local = _e30 + 1u;
        }
        loop_init = false;
        uint _e15 = local;
        if (_e15 >= 2u) {
            break;
        }
        local_1 = 0u;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                uint _e27 = local_1;
                local_1 = _e27 + 1u;
            }
            loop_init_1 = false;
            uint _e22 = local_1;
            if (_e22 >= 3u) {
                break;
            }
            matrix_.inner[_e15].inner[_e22] = int {};
        }
    }
    record = Record_cuda_record_0_ {};
    Scalar = 4u;
    Boolean = 1u;
    Array = 24u;
    Row = 12u;
    Element = 4u;
    Member = 4u;
    Pointer = 8u;
    Null = 8u;
    Middle = 1u;
    Outer = 1u;
    Nested = 1u;
    NoRead = 4u;
    InvalidMath = 1u;
    NullArm = 8u;
    uint _e63 = Scalar;
    output[base] = _e63;
    uint _e66 = Boolean;
    local_2 = static_cast<uint>(base + 1u);
    uint _e71 = local_2;
    output[_e71] = _e66;
    uint _e73 = Array;
    local_3 = static_cast<uint>(base + 2u);
    uint _e78 = local_3;
    output[_e78] = _e73;
    uint _e80 = Row;
    local_4 = static_cast<uint>(base + 3u);
    uint _e85 = local_4;
    output[_e85] = _e80;
    uint _e87 = Element;
    local_5 = static_cast<uint>(base + 4u);
    uint _e92 = local_5;
    output[_e92] = _e87;
    uint _e94 = Member;
    local_6 = static_cast<uint>(base + 5u);
    uint _e99 = local_6;
    output[_e99] = _e94;
    uint _e101 = Pointer;
    local_7 = static_cast<uint>(base + 6u);
    uint _e106 = local_7;
    output[_e106] = _e101;
    uint _e108 = Null;
    local_8 = static_cast<uint>(base + 7u);
    uint _e113 = local_8;
    output[_e113] = _e108;
    uint _e115 = Middle;
    local_9 = static_cast<uint>(base + 8u);
    uint _e120 = local_9;
    output[_e120] = _e115;
    uint _e122 = Outer;
    local_10 = static_cast<uint>(base + 9u);
    uint _e127 = local_10;
    output[_e127] = _e122;
    uint _e129 = Nested;
    local_11 = static_cast<uint>(base + 10u);
    uint _e134 = local_11;
    output[_e134] = _e129;
    uint _e136 = NoRead;
    local_12 = static_cast<uint>(base + 11u);
    uint _e141 = local_12;
    output[_e141] = _e136;
    uint _e143 = InvalidMath;
    local_13 = static_cast<uint>(base + 12u);
    uint _e148 = local_13;
    output[_e148] = _e143;
    uint _e150 = NullArm;
    local_14 = static_cast<uint>(base + 13u);
    uint _e155 = local_14;
    output[_e155] = _e150;
    int _e157 = counter;
    local_15 = static_cast<uint>(base + 14u);
    uint _e163 = local_15;
    output[_e163] = static_cast<uint>(_e157);
    int _e166 = input[lane];
    local_16 = static_cast<uint>(base + 15u);
    uint _e172 = local_16;
    output[_e172] = static_cast<uint>(_e166);
}
