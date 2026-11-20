#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int pair = 0;
    uint MiddleStart = 0u;
    uint LeafStart = 0u;
    uint First = 0u;
    uint Pair = 0u;
    uint Tail = 0u;
    uint Last = 0u;
    uint End = 0u;
    uint LocalPair = 0u;
    uint LeafPair = 0u;
    uint Sum = 0u;
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
    pair = 7;
    MiddleStart = 16u;
    LeafStart = 32u;
    First = 32u;
    Pair = 40u;
    Tail = 48u;
    Last = 64u;
    End = 80u;
    LocalPair = 56u;
    LeafPair = 8u;
    Sum = 40u;
    uint _e28 = MiddleStart;
    _group_0_binding_0_cs[base] = _e28;
    uint _e31 = LeafStart;
    local = uint((base + 1u));
    uint _e36 = local;
    _group_0_binding_0_cs[_e36] = _e31;
    uint _e38 = First;
    local_1 = uint((base + 2u));
    uint _e43 = local_1;
    _group_0_binding_0_cs[_e43] = _e38;
    uint _e45 = Pair;
    local_2 = uint((base + 3u));
    uint _e50 = local_2;
    _group_0_binding_0_cs[_e50] = _e45;
    uint _e52 = Tail;
    local_3 = uint((base + 4u));
    uint _e57 = local_3;
    _group_0_binding_0_cs[_e57] = _e52;
    uint _e59 = Last;
    local_4 = uint((base + 5u));
    uint _e64 = local_4;
    _group_0_binding_0_cs[_e64] = _e59;
    uint _e66 = End;
    local_5 = uint((base + 6u));
    uint _e71 = local_5;
    _group_0_binding_0_cs[_e71] = _e66;
    uint _e73 = LocalPair;
    local_6 = uint((base + 7u));
    uint _e78 = local_6;
    _group_0_binding_0_cs[_e78] = _e73;
    uint _e80 = LeafPair;
    local_7 = uint((base + 8u));
    uint _e85 = local_7;
    _group_0_binding_0_cs[_e85] = _e80;
    uint _e87 = Sum;
    local_8 = uint((base + 9u));
    uint _e92 = local_8;
    _group_0_binding_0_cs[_e92] = _e87;
    int _e94 = pair;
    local_9 = uint((base + 10u));
    uint _e100 = local_9;
    _group_0_binding_0_cs[_e100] = uint(_e94);
    local_10 = uint((base + 11u));
    uint _e106 = local_10;
    _group_0_binding_0_cs[_e106] = lane;
}

