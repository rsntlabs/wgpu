// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_1[1];
typedef uint type_3[1];
struct type_5 {
    int inner[3];
};
struct type_6 {
    type_5 inner[2];
};

struct sizeof_functional_castsInput {
};
kernel void sizeof_functional_casts(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& input [[buffer(0)]]
, device type_3& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    int counter = {};
    type_6 matrix_ = {};
    uint local = {};
    uint local_1 = {};
    uint Integer = {};
    uint Short = {};
    uint WideAlias = {};
    uint Real = {};
    uint Pointer = {};
    uint Array = {};
    uint Null = {};
    uint Group = {};
    uint Nested = {};
    uint Middle = {};
    uint Row = {};
    uint Range = {};
    uint Binding = {};
    uint Shift = {};
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
    counter = 7;
    local = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e28 = local;
            local = _e28 + 1u;
        }
        loop_init = false;
        uint _e13 = local;
        if (_e13 >= 2u) {
            break;
        }
        local_1 = 0u;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                uint _e25 = local_1;
                local_1 = _e25 + 1u;
            }
            loop_init_1 = false;
            uint _e20 = local_1;
            if (_e20 >= 3u) {
                break;
            }
            matrix_.inner[_e13].inner[_e20] = int {};
        }
    }
    Integer = 4u;
    Short = 2u;
    WideAlias = 8u;
    Real = 4u;
    Pointer = 1u;
    Array = 1u;
    Null = 1u;
    Group = 4u;
    Nested = 2u;
    Middle = 1u;
    Row = 12u;
    Range = 4u;
    Binding = 3u;
    Shift = 4u;
    uint _e59 = Integer;
    output[base] = _e59;
    uint _e62 = Short;
    local_2 = static_cast<uint>(base + 1u);
    uint _e67 = local_2;
    output[_e67] = _e62;
    uint _e69 = WideAlias;
    local_3 = static_cast<uint>(base + 2u);
    uint _e74 = local_3;
    output[_e74] = _e69;
    uint _e76 = Real;
    local_4 = static_cast<uint>(base + 3u);
    uint _e81 = local_4;
    output[_e81] = _e76;
    uint _e83 = Pointer;
    local_5 = static_cast<uint>(base + 4u);
    uint _e88 = local_5;
    output[_e88] = _e83;
    uint _e90 = Array;
    local_6 = static_cast<uint>(base + 5u);
    uint _e95 = local_6;
    output[_e95] = _e90;
    uint _e97 = Null;
    local_7 = static_cast<uint>(base + 6u);
    uint _e102 = local_7;
    output[_e102] = _e97;
    uint _e104 = Group;
    local_8 = static_cast<uint>(base + 7u);
    uint _e109 = local_8;
    output[_e109] = _e104;
    uint _e111 = Nested;
    local_9 = static_cast<uint>(base + 8u);
    uint _e116 = local_9;
    output[_e116] = _e111;
    uint _e118 = Middle;
    local_10 = static_cast<uint>(base + 9u);
    uint _e123 = local_10;
    output[_e123] = _e118;
    uint _e125 = Row;
    local_11 = static_cast<uint>(base + 10u);
    uint _e130 = local_11;
    output[_e130] = _e125;
    uint _e132 = Range;
    local_12 = static_cast<uint>(base + 11u);
    uint _e137 = local_12;
    output[_e137] = _e132;
    uint _e139 = Binding;
    local_13 = static_cast<uint>(base + 12u);
    uint _e144 = local_13;
    output[_e144] = _e139;
    uint _e146 = Shift;
    local_14 = static_cast<uint>(base + 13u);
    uint _e151 = local_14;
    output[_e151] = _e146;
    int _e153 = counter;
    local_15 = static_cast<uint>(base + 14u);
    uint _e159 = local_15;
    output[_e159] = static_cast<uint>(_e153);
    int _e162 = input[lane];
    local_16 = static_cast<uint>(base + 15u);
    uint _e168 = local_16;
    output[_e168] = static_cast<uint>(_e162);
}
