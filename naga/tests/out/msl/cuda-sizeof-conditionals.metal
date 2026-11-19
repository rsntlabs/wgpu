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
struct type_6 {
    int inner[3];
};
struct type_7 {
    type_6 inner[2];
};

struct sizeof_conditionalsInput {
};
kernel void sizeof_conditionals(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& input [[buffer(0)]]
, device type_3& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    int small = {};
    int other = {};
    bool unknown = {};
    int cursor = {};
    type_7 grid = {};
    uint local = {};
    uint local_1 = {};
    uint SameType = {};
    uint Boolean = {};
    uint Promoted = {};
    uint BoolInt = {};
    uint Real = {};
    uint NestedMiddle = {};
    uint NestedFinal = {};
    uint Grouped = {};
    uint Logical = {};
    uint Row = {};
    uint Element = {};
    uint InvalidDivide = {};
    uint InvalidShift = {};
    uint Reference = {};
    uint Storage = {};
    uint UnaryBinding = {};
    uint local_2 = {};
    uint AddBinding = {};
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
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 20u);
    int seed = input[lane];
    bool flag = seed != 0;
    cursor = 7;
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
            grid.inner[_e15].inner[_e22] = int {};
        }
    }
    SameType = 4u;
    Boolean = 1u;
    Promoted = 4u;
    BoolInt = 4u;
    Real = 4u;
    NestedMiddle = 4u;
    NestedFinal = 4u;
    Grouped = 4u;
    Logical = 4u;
    Row = 12u;
    Element = 4u;
    InvalidDivide = 4u;
    InvalidShift = 4u;
    Reference = 4u;
    Storage = 4u;
    UnaryBinding = 7u;
    AddBinding = 5u;
    uint _e67 = SameType;
    output[base] = _e67;
    uint _e70 = Boolean;
    local_3 = static_cast<uint>(base + 1u);
    uint _e75 = local_3;
    output[_e75] = _e70;
    uint _e77 = Promoted;
    local_4 = static_cast<uint>(base + 2u);
    uint _e82 = local_4;
    output[_e82] = _e77;
    uint _e84 = BoolInt;
    local_5 = static_cast<uint>(base + 3u);
    uint _e89 = local_5;
    output[_e89] = _e84;
    uint _e91 = Real;
    local_6 = static_cast<uint>(base + 4u);
    uint _e96 = local_6;
    output[_e96] = _e91;
    uint _e98 = NestedMiddle;
    local_7 = static_cast<uint>(base + 5u);
    uint _e103 = local_7;
    output[_e103] = _e98;
    uint _e105 = NestedFinal;
    local_8 = static_cast<uint>(base + 6u);
    uint _e110 = local_8;
    output[_e110] = _e105;
    uint _e112 = Grouped;
    local_9 = static_cast<uint>(base + 7u);
    uint _e117 = local_9;
    output[_e117] = _e112;
    uint _e119 = Logical;
    local_10 = static_cast<uint>(base + 8u);
    uint _e124 = local_10;
    output[_e124] = _e119;
    uint _e126 = Row;
    local_11 = static_cast<uint>(base + 9u);
    uint _e131 = local_11;
    output[_e131] = _e126;
    uint _e133 = Element;
    local_12 = static_cast<uint>(base + 10u);
    uint _e138 = local_12;
    output[_e138] = _e133;
    uint _e140 = InvalidDivide;
    local_13 = static_cast<uint>(base + 11u);
    uint _e145 = local_13;
    output[_e145] = _e140;
    uint _e147 = InvalidShift;
    local_14 = static_cast<uint>(base + 12u);
    uint _e152 = local_14;
    output[_e152] = _e147;
    uint _e154 = Reference;
    local_15 = static_cast<uint>(base + 13u);
    uint _e159 = local_15;
    output[_e159] = _e154;
    uint _e161 = Storage;
    local_16 = static_cast<uint>(base + 14u);
    uint _e166 = local_16;
    output[_e166] = _e161;
    uint _e168 = UnaryBinding;
    local_17 = static_cast<uint>(base + 15u);
    uint _e173 = local_17;
    output[_e173] = _e168;
    uint _e175 = AddBinding;
    local_18 = static_cast<uint>(base + 16u);
    uint _e180 = local_18;
    output[_e180] = _e175;
    int _e182 = cursor;
    local_19 = static_cast<uint>(base + 17u);
    uint _e188 = local_19;
    output[_e188] = static_cast<uint>(_e182);
    local_20 = static_cast<uint>(base + 18u);
    uint _e195 = local_20;
    output[_e195] = static_cast<uint>(seed);
    local_21 = static_cast<uint>(base + 19u);
    uint _e202 = local_21;
    output[_e202] = static_cast<uint>(flag);
}
