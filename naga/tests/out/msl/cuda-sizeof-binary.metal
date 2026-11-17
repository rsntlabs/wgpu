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

struct sizeof_binaryInput {
};
kernel void sizeof_binary(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& input [[buffer(0)]]
, device type_3& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint other = {};
    float real = {};
    int counter = {};
    type_7 grid = {};
    uint local = {};
    uint local_1 = {};
    uint Add = {};
    uint Subtract = {};
    uint Multiply = {};
    uint Divide = {};
    uint Modulo = {};
    uint Left = {};
    uint Right = {};
    uint And = {};
    uint Or = {};
    uint Xor = {};
    uint Less = {};
    uint Equal = {};
    uint LogicalAnd = {};
    uint LogicalOr = {};
    uint Nested = {};
    uint Row = {};
    uint Element = {};
    uint Reference = {};
    uint BinaryIndex = {};
    uint InvalidShift = {};
    uint ReferenceDivide = {};
    uint GroupedComparison = {};
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
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 24u);
    int seed = input[lane];
    other = 33u;
    real = 2.0;
    counter = 7;
    local = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e32 = local;
            local = _e32 + 1u;
        }
        loop_init = false;
        uint _e17 = local;
        if (_e17 >= 2u) {
            break;
        }
        local_1 = 0u;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                uint _e29 = local_1;
                local_1 = _e29 + 1u;
            }
            loop_init_1 = false;
            uint _e24 = local_1;
            if (_e24 >= 3u) {
                break;
            }
            grid.inner[_e17].inner[_e24] = int {};
        }
    }
    Add = 4u;
    Subtract = 4u;
    Multiply = 4u;
    Divide = 4u;
    Modulo = 4u;
    Left = 4u;
    Right = 4u;
    And = 4u;
    Or = 4u;
    Xor = 4u;
    Less = 1u;
    Equal = 1u;
    LogicalAnd = 1u;
    LogicalOr = 1u;
    Nested = 4u;
    Row = 12u;
    Element = 4u;
    Reference = 4u;
    BinaryIndex = 12u;
    InvalidShift = 4u;
    ReferenceDivide = 4u;
    GroupedComparison = 1u;
    uint _e79 = Add;
    output[base] = _e79;
    uint _e82 = Subtract;
    local_2 = static_cast<uint>(base + 1u);
    uint _e87 = local_2;
    output[_e87] = _e82;
    uint _e89 = Multiply;
    local_3 = static_cast<uint>(base + 2u);
    uint _e94 = local_3;
    output[_e94] = _e89;
    uint _e96 = Divide;
    local_4 = static_cast<uint>(base + 3u);
    uint _e101 = local_4;
    output[_e101] = _e96;
    uint _e103 = Modulo;
    local_5 = static_cast<uint>(base + 4u);
    uint _e108 = local_5;
    output[_e108] = _e103;
    uint _e110 = Left;
    local_6 = static_cast<uint>(base + 5u);
    uint _e115 = local_6;
    output[_e115] = _e110;
    uint _e117 = Right;
    local_7 = static_cast<uint>(base + 6u);
    uint _e122 = local_7;
    output[_e122] = _e117;
    uint _e124 = And;
    local_8 = static_cast<uint>(base + 7u);
    uint _e129 = local_8;
    output[_e129] = _e124;
    uint _e131 = Or;
    local_9 = static_cast<uint>(base + 8u);
    uint _e136 = local_9;
    output[_e136] = _e131;
    uint _e138 = Xor;
    local_10 = static_cast<uint>(base + 9u);
    uint _e143 = local_10;
    output[_e143] = _e138;
    uint _e145 = Less;
    local_11 = static_cast<uint>(base + 10u);
    uint _e150 = local_11;
    output[_e150] = _e145;
    uint _e152 = Equal;
    local_12 = static_cast<uint>(base + 11u);
    uint _e157 = local_12;
    output[_e157] = _e152;
    uint _e159 = LogicalAnd;
    local_13 = static_cast<uint>(base + 12u);
    uint _e164 = local_13;
    output[_e164] = _e159;
    uint _e166 = LogicalOr;
    local_14 = static_cast<uint>(base + 13u);
    uint _e171 = local_14;
    output[_e171] = _e166;
    uint _e173 = Nested;
    local_15 = static_cast<uint>(base + 14u);
    uint _e178 = local_15;
    output[_e178] = _e173;
    uint _e180 = Row;
    local_16 = static_cast<uint>(base + 15u);
    uint _e185 = local_16;
    output[_e185] = _e180;
    uint _e187 = Element;
    local_17 = static_cast<uint>(base + 16u);
    uint _e192 = local_17;
    output[_e192] = _e187;
    uint _e194 = Reference;
    local_18 = static_cast<uint>(base + 17u);
    uint _e199 = local_18;
    output[_e199] = _e194;
    uint _e201 = BinaryIndex;
    local_19 = static_cast<uint>(base + 18u);
    uint _e206 = local_19;
    output[_e206] = _e201;
    uint _e208 = InvalidShift;
    local_20 = static_cast<uint>(base + 19u);
    uint _e213 = local_20;
    output[_e213] = _e208;
    int _e215 = counter;
    local_21 = static_cast<uint>(base + 20u);
    uint _e221 = local_21;
    output[_e221] = static_cast<uint>(_e215);
    local_22 = static_cast<uint>(base + 21u);
    uint _e228 = local_22;
    output[_e228] = static_cast<uint>(seed);
    uint _e230 = ReferenceDivide;
    local_23 = static_cast<uint>(base + 22u);
    uint _e235 = local_23;
    output[_e235] = _e230;
    uint _e237 = GroupedComparison;
    local_24 = static_cast<uint>(base + 23u);
    uint _e242 = local_24;
    output[_e242] = _e237;
}
