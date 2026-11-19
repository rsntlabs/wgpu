#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint _group_0_binding_1_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int small = 0;
    int other = 0;
    bool unknown = false;
    int cursor = 0;
    int grid[2][3] = int[2][3](int[3](0, 0, 0), int[3](0, 0, 0));
    uint local = 0u;
    uint local_1 = 0u;
    uint SameType = 0u;
    uint Boolean = 0u;
    uint Promoted = 0u;
    uint BoolInt = 0u;
    uint Real = 0u;
    uint NestedMiddle = 0u;
    uint NestedFinal = 0u;
    uint Grouped = 0u;
    uint Logical = 0u;
    uint Row = 0u;
    uint Element = 0u;
    uint InvalidDivide = 0u;
    uint InvalidShift = 0u;
    uint Reference = 0u;
    uint Storage = 0u;
    uint UnaryBinding = 0u;
    uint local_2 = 0u;
    uint AddBinding = 0u;
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
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 20u));
    int seed = _group_0_binding_0_cs[lane];
    bool flag = (seed != 0);
    cursor = 7;
    local = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e30 = local;
            local = (_e30 + 1u);
        }
        loop_init = false;
        uint _e15 = local;
        if ((_e15 >= 2u)) {
            break;
        }
        local_1 = 0u;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                uint _e27 = local_1;
                local_1 = (_e27 + 1u);
            }
            loop_init_1 = false;
            uint _e22 = local_1;
            if ((_e22 >= 3u)) {
                break;
            }
            grid[_e15][_e22] = 0;
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
    _group_0_binding_1_cs[base] = _e67;
    uint _e70 = Boolean;
    local_3 = uint((base + 1u));
    uint _e75 = local_3;
    _group_0_binding_1_cs[_e75] = _e70;
    uint _e77 = Promoted;
    local_4 = uint((base + 2u));
    uint _e82 = local_4;
    _group_0_binding_1_cs[_e82] = _e77;
    uint _e84 = BoolInt;
    local_5 = uint((base + 3u));
    uint _e89 = local_5;
    _group_0_binding_1_cs[_e89] = _e84;
    uint _e91 = Real;
    local_6 = uint((base + 4u));
    uint _e96 = local_6;
    _group_0_binding_1_cs[_e96] = _e91;
    uint _e98 = NestedMiddle;
    local_7 = uint((base + 5u));
    uint _e103 = local_7;
    _group_0_binding_1_cs[_e103] = _e98;
    uint _e105 = NestedFinal;
    local_8 = uint((base + 6u));
    uint _e110 = local_8;
    _group_0_binding_1_cs[_e110] = _e105;
    uint _e112 = Grouped;
    local_9 = uint((base + 7u));
    uint _e117 = local_9;
    _group_0_binding_1_cs[_e117] = _e112;
    uint _e119 = Logical;
    local_10 = uint((base + 8u));
    uint _e124 = local_10;
    _group_0_binding_1_cs[_e124] = _e119;
    uint _e126 = Row;
    local_11 = uint((base + 9u));
    uint _e131 = local_11;
    _group_0_binding_1_cs[_e131] = _e126;
    uint _e133 = Element;
    local_12 = uint((base + 10u));
    uint _e138 = local_12;
    _group_0_binding_1_cs[_e138] = _e133;
    uint _e140 = InvalidDivide;
    local_13 = uint((base + 11u));
    uint _e145 = local_13;
    _group_0_binding_1_cs[_e145] = _e140;
    uint _e147 = InvalidShift;
    local_14 = uint((base + 12u));
    uint _e152 = local_14;
    _group_0_binding_1_cs[_e152] = _e147;
    uint _e154 = Reference;
    local_15 = uint((base + 13u));
    uint _e159 = local_15;
    _group_0_binding_1_cs[_e159] = _e154;
    uint _e161 = Storage;
    local_16 = uint((base + 14u));
    uint _e166 = local_16;
    _group_0_binding_1_cs[_e166] = _e161;
    uint _e168 = UnaryBinding;
    local_17 = uint((base + 15u));
    uint _e173 = local_17;
    _group_0_binding_1_cs[_e173] = _e168;
    uint _e175 = AddBinding;
    local_18 = uint((base + 16u));
    uint _e180 = local_18;
    _group_0_binding_1_cs[_e180] = _e175;
    int _e182 = cursor;
    local_19 = uint((base + 17u));
    uint _e188 = local_19;
    _group_0_binding_1_cs[_e188] = uint(_e182);
    local_20 = uint((base + 18u));
    uint _e195 = local_20;
    _group_0_binding_1_cs[_e195] = uint(seed);
    local_21 = uint((base + 19u));
    uint _e202 = local_21;
    _group_0_binding_1_cs[_e202] = uint(flag);
}

