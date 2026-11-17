#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint _group_0_binding_1_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint other = 0u;
    float real = 0.0;
    int counter = 0;
    int grid[2][3] = int[2][3](int[3](0, 0, 0), int[3](0, 0, 0));
    uint local = 0u;
    uint local_1 = 0u;
    uint Add = 0u;
    uint Subtract = 0u;
    uint Multiply = 0u;
    uint Divide = 0u;
    uint Modulo = 0u;
    uint Left = 0u;
    uint Right = 0u;
    uint And = 0u;
    uint Or = 0u;
    uint Xor = 0u;
    uint Less = 0u;
    uint Equal = 0u;
    uint LogicalAnd = 0u;
    uint LogicalOr = 0u;
    uint Nested = 0u;
    uint Row = 0u;
    uint Element = 0u;
    uint Reference = 0u;
    uint BinaryIndex = 0u;
    uint InvalidShift = 0u;
    uint ReferenceDivide = 0u;
    uint GroupedComparison = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 24u));
    int seed = _group_0_binding_0_cs[lane];
    other = 33u;
    real = 2.0;
    counter = 7;
    local = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e32 = local;
            local = (_e32 + 1u);
        }
        loop_init = false;
        uint _e17 = local;
        if ((_e17 >= 2u)) {
            break;
        }
        local_1 = 0u;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                uint _e29 = local_1;
                local_1 = (_e29 + 1u);
            }
            loop_init_1 = false;
            uint _e24 = local_1;
            if ((_e24 >= 3u)) {
                break;
            }
            grid[_e17][_e24] = 0;
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
    _group_0_binding_1_cs[base] = _e79;
    uint _e82 = Subtract;
    local_2 = uint((base + 1u));
    uint _e87 = local_2;
    _group_0_binding_1_cs[_e87] = _e82;
    uint _e89 = Multiply;
    local_3 = uint((base + 2u));
    uint _e94 = local_3;
    _group_0_binding_1_cs[_e94] = _e89;
    uint _e96 = Divide;
    local_4 = uint((base + 3u));
    uint _e101 = local_4;
    _group_0_binding_1_cs[_e101] = _e96;
    uint _e103 = Modulo;
    local_5 = uint((base + 4u));
    uint _e108 = local_5;
    _group_0_binding_1_cs[_e108] = _e103;
    uint _e110 = Left;
    local_6 = uint((base + 5u));
    uint _e115 = local_6;
    _group_0_binding_1_cs[_e115] = _e110;
    uint _e117 = Right;
    local_7 = uint((base + 6u));
    uint _e122 = local_7;
    _group_0_binding_1_cs[_e122] = _e117;
    uint _e124 = And;
    local_8 = uint((base + 7u));
    uint _e129 = local_8;
    _group_0_binding_1_cs[_e129] = _e124;
    uint _e131 = Or;
    local_9 = uint((base + 8u));
    uint _e136 = local_9;
    _group_0_binding_1_cs[_e136] = _e131;
    uint _e138 = Xor;
    local_10 = uint((base + 9u));
    uint _e143 = local_10;
    _group_0_binding_1_cs[_e143] = _e138;
    uint _e145 = Less;
    local_11 = uint((base + 10u));
    uint _e150 = local_11;
    _group_0_binding_1_cs[_e150] = _e145;
    uint _e152 = Equal;
    local_12 = uint((base + 11u));
    uint _e157 = local_12;
    _group_0_binding_1_cs[_e157] = _e152;
    uint _e159 = LogicalAnd;
    local_13 = uint((base + 12u));
    uint _e164 = local_13;
    _group_0_binding_1_cs[_e164] = _e159;
    uint _e166 = LogicalOr;
    local_14 = uint((base + 13u));
    uint _e171 = local_14;
    _group_0_binding_1_cs[_e171] = _e166;
    uint _e173 = Nested;
    local_15 = uint((base + 14u));
    uint _e178 = local_15;
    _group_0_binding_1_cs[_e178] = _e173;
    uint _e180 = Row;
    local_16 = uint((base + 15u));
    uint _e185 = local_16;
    _group_0_binding_1_cs[_e185] = _e180;
    uint _e187 = Element;
    local_17 = uint((base + 16u));
    uint _e192 = local_17;
    _group_0_binding_1_cs[_e192] = _e187;
    uint _e194 = Reference;
    local_18 = uint((base + 17u));
    uint _e199 = local_18;
    _group_0_binding_1_cs[_e199] = _e194;
    uint _e201 = BinaryIndex;
    local_19 = uint((base + 18u));
    uint _e206 = local_19;
    _group_0_binding_1_cs[_e206] = _e201;
    uint _e208 = InvalidShift;
    local_20 = uint((base + 19u));
    uint _e213 = local_20;
    _group_0_binding_1_cs[_e213] = _e208;
    int _e215 = counter;
    local_21 = uint((base + 20u));
    uint _e221 = local_21;
    _group_0_binding_1_cs[_e221] = uint(_e215);
    local_22 = uint((base + 21u));
    uint _e228 = local_22;
    _group_0_binding_1_cs[_e228] = uint(seed);
    uint _e230 = ReferenceDivide;
    local_23 = uint((base + 22u));
    uint _e235 = local_23;
    _group_0_binding_1_cs[_e235] = _e230;
    uint _e237 = GroupedComparison;
    local_24 = uint((base + 23u));
    uint _e242 = local_24;
    _group_0_binding_1_cs[_e242] = _e237;
}

