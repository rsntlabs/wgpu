#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int value = 0;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    int index = 0;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    int Count = 0;
    int local_6 = 0;
    int array[3] = int[3](0, 0, 0);
    uint local_7 = 0u;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 6u));
    value = int(lane);
    int _e8 = value;
    value = (_e8 + 1);
    int _e11 = value;
    value = (_e11 + 1);
    int _e14 = value;
    _group_0_binding_0_cs[base] = _e14;
    int _e17 = value;
    value = (_e17 + 1);
    int _e20 = value;
    value = (_e20 + 1);
    int _e23 = value;
    local = uint((base + 1u));
    uint _e28 = local;
    _group_0_binding_0_cs[_e28] = _e23;
    if (((lane & 1u) == 0u)) {
        int _e34 = value;
        value = (_e34 + 3);
    } else {
        int _e37 = value;
        value = (_e37 + 7);
    }
    int _e40 = value;
    local_1 = uint((base + 2u));
    uint _e45 = local_1;
    _group_0_binding_0_cs[_e45] = _e40;
    int _e47 = value;
    value = (_e47 + 1);
    int _e50 = value;
    value = (_e50 + 1);
    int _e53 = value;
    local_2 = uint((base + 3u));
    uint _e58 = local_2;
    _group_0_binding_0_cs[_e58] = _e53;
    index = 0;
    int _e62 = index;
    index = (_e62 + 1);
    local_3 = uint(_e62);
    int _e67 = index;
    index = (_e67 + 1);
    local_4 = uint(_e67);
    int _e72 = index;
    local_5 = uint((base + 4u));
    uint _e77 = local_5;
    _group_0_binding_0_cs[_e77] = _e72;
    Count = 3;
    array = int[3](0, 0, 0);
    int _e85 = array[2];
    local_7 = uint((base + 5u));
    uint _e90 = local_7;
    _group_0_binding_0_cs[_e90] = _e85;
}

