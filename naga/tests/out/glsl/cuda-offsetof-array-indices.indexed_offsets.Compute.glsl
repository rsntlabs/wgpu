#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int cursor = 0;
    uint LeafValue = 0u;
    uint GridFirst = 0u;
    uint GridLast = 0u;
    uint Row = 0u;
    uint LeafObject = 0u;
    uint Hex = 0u;
    uint Octal = 0u;
    uint WideZero = 0u;
    uint Pair = 0u;
    uint Quad = 0u;
    uint Triple = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 12u));
    cursor = 7;
    LeafValue = 32u;
    GridFirst = 40u;
    GridLast = 56u;
    Row = 48u;
    LeafObject = 20u;
    Hex = 32u;
    Octal = 56u;
    WideZero = 8u;
    Pair = 16u;
    Quad = 48u;
    Triple = 76u;
    uint _e30 = LeafValue;
    _group_0_binding_0_cs[base] = _e30;
    uint _e33 = GridFirst;
    local = uint((base + 1u));
    uint _e38 = local;
    _group_0_binding_0_cs[_e38] = _e33;
    uint _e40 = GridLast;
    local_1 = uint((base + 2u));
    uint _e45 = local_1;
    _group_0_binding_0_cs[_e45] = _e40;
    uint _e47 = Row;
    local_2 = uint((base + 3u));
    uint _e52 = local_2;
    _group_0_binding_0_cs[_e52] = _e47;
    uint _e54 = LeafObject;
    local_3 = uint((base + 4u));
    uint _e59 = local_3;
    _group_0_binding_0_cs[_e59] = _e54;
    uint _e61 = Hex;
    local_4 = uint((base + 5u));
    uint _e66 = local_4;
    _group_0_binding_0_cs[_e66] = _e61;
    uint _e68 = Octal;
    local_5 = uint((base + 6u));
    uint _e73 = local_5;
    _group_0_binding_0_cs[_e73] = _e68;
    uint _e75 = WideZero;
    local_6 = uint((base + 7u));
    uint _e80 = local_6;
    _group_0_binding_0_cs[_e80] = _e75;
    uint _e82 = Pair;
    local_7 = uint((base + 8u));
    uint _e87 = local_7;
    _group_0_binding_0_cs[_e87] = _e82;
    uint _e89 = Quad;
    local_8 = uint((base + 9u));
    uint _e94 = local_8;
    _group_0_binding_0_cs[_e94] = _e89;
    uint _e96 = Triple;
    local_9 = uint((base + 10u));
    uint _e101 = local_9;
    _group_0_binding_0_cs[_e101] = _e96;
    int _e103 = cursor;
    local_10 = uint((base + 11u));
    uint _e110 = local_10;
    _group_0_binding_0_cs[_e110] = (uint(_e103) + lane);
}

