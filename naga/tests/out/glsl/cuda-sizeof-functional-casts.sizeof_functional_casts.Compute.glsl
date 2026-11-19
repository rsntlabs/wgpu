#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint _group_0_binding_1_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int counter = 0;
    int matrix[2][3] = int[2][3](int[3](0, 0, 0), int[3](0, 0, 0));
    uint local = 0u;
    uint local_1 = 0u;
    uint Integer = 0u;
    uint Short = 0u;
    uint WideAlias = 0u;
    uint Real = 0u;
    uint Pointer = 0u;
    uint Array = 0u;
    uint Null = 0u;
    uint Group = 0u;
    uint Nested = 0u;
    uint Middle = 0u;
    uint Row = 0u;
    uint Range = 0u;
    uint Binding = 0u;
    uint Shift = 0u;
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
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 16u));
    int seed = _group_0_binding_0_cs[lane];
    counter = 7;
    local = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e28 = local;
            local = (_e28 + 1u);
        }
        loop_init = false;
        uint _e13 = local;
        if ((_e13 >= 2u)) {
            break;
        }
        local_1 = 0u;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                uint _e25 = local_1;
                local_1 = (_e25 + 1u);
            }
            loop_init_1 = false;
            uint _e20 = local_1;
            if ((_e20 >= 3u)) {
                break;
            }
            matrix[_e13][_e20] = 0;
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
    _group_0_binding_1_cs[base] = _e59;
    uint _e62 = Short;
    local_2 = uint((base + 1u));
    uint _e67 = local_2;
    _group_0_binding_1_cs[_e67] = _e62;
    uint _e69 = WideAlias;
    local_3 = uint((base + 2u));
    uint _e74 = local_3;
    _group_0_binding_1_cs[_e74] = _e69;
    uint _e76 = Real;
    local_4 = uint((base + 3u));
    uint _e81 = local_4;
    _group_0_binding_1_cs[_e81] = _e76;
    uint _e83 = Pointer;
    local_5 = uint((base + 4u));
    uint _e88 = local_5;
    _group_0_binding_1_cs[_e88] = _e83;
    uint _e90 = Array;
    local_6 = uint((base + 5u));
    uint _e95 = local_6;
    _group_0_binding_1_cs[_e95] = _e90;
    uint _e97 = Null;
    local_7 = uint((base + 6u));
    uint _e102 = local_7;
    _group_0_binding_1_cs[_e102] = _e97;
    uint _e104 = Group;
    local_8 = uint((base + 7u));
    uint _e109 = local_8;
    _group_0_binding_1_cs[_e109] = _e104;
    uint _e111 = Nested;
    local_9 = uint((base + 8u));
    uint _e116 = local_9;
    _group_0_binding_1_cs[_e116] = _e111;
    uint _e118 = Middle;
    local_10 = uint((base + 9u));
    uint _e123 = local_10;
    _group_0_binding_1_cs[_e123] = _e118;
    uint _e125 = Row;
    local_11 = uint((base + 10u));
    uint _e130 = local_11;
    _group_0_binding_1_cs[_e130] = _e125;
    uint _e132 = Range;
    local_12 = uint((base + 11u));
    uint _e137 = local_12;
    _group_0_binding_1_cs[_e137] = _e132;
    uint _e139 = Binding;
    local_13 = uint((base + 12u));
    uint _e144 = local_13;
    _group_0_binding_1_cs[_e144] = _e139;
    uint _e146 = Shift;
    local_14 = uint((base + 13u));
    uint _e151 = local_14;
    _group_0_binding_1_cs[_e151] = _e146;
    int _e153 = counter;
    local_15 = uint((base + 14u));
    uint _e159 = local_15;
    _group_0_binding_1_cs[_e159] = uint(_e153);
    int _e162 = _group_0_binding_0_cs[lane];
    local_16 = uint((base + 15u));
    uint _e168 = local_16;
    _group_0_binding_1_cs[_e168] = uint(_e162);
}

