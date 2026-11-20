#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

const uint RowIndex = 1u;
const int ColumnIndex = 2;

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };


uint selected_offset_0u() {
    uint offset = 0u;
    offset = 16u;
    uint _e2 = offset;
    return _e2;
}

uint selected_offset_1u() {
    uint offset_1 = 0u;
    offset_1 = 32u;
    uint _e2 = offset_1;
    return _e2;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int cursor = 0;
    uint LocalColumn = 0u;
    int LocalRow = 0;
    uint Zero = 0u;
    bool LastRow = false;
    uint Global = 0u;
    uint Local = 0u;
    uint Mixed = 0u;
    uint ZeroIndex = 0u;
    uint BoolIndex = 0u;
    uint Macro = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 10u));
    cursor = 7;
    LocalColumn = 1u;
    LocalRow = 1;
    Zero = 0u;
    LastRow = true;
    Global = 56u;
    Local = 52u;
    Mixed = 28u;
    ZeroIndex = 8u;
    BoolIndex = 48u;
    Macro = 56u;
    uint _e28 = Global;
    _group_0_binding_0_cs[base] = _e28;
    uint _e31 = Local;
    local = uint((base + 1u));
    uint _e36 = local;
    _group_0_binding_0_cs[_e36] = _e31;
    uint _e38 = Mixed;
    local_1 = uint((base + 2u));
    uint _e43 = local_1;
    _group_0_binding_0_cs[_e43] = _e38;
    uint _e45 = ZeroIndex;
    local_2 = uint((base + 3u));
    uint _e50 = local_2;
    _group_0_binding_0_cs[_e50] = _e45;
    uint _e52 = BoolIndex;
    local_3 = uint((base + 4u));
    uint _e57 = local_3;
    _group_0_binding_0_cs[_e57] = _e52;
    uint _e59 = Macro;
    local_4 = uint((base + 5u));
    uint _e64 = local_4;
    _group_0_binding_0_cs[_e64] = _e59;
    uint _e66 = selected_offset_0u();
    local_5 = uint((base + 6u));
    uint _e71 = local_5;
    _group_0_binding_0_cs[_e71] = _e66;
    uint _e73 = selected_offset_1u();
    local_6 = uint((base + 7u));
    uint _e78 = local_6;
    _group_0_binding_0_cs[_e78] = _e73;
    int _e80 = cursor;
    local_7 = uint((base + 8u));
    uint _e86 = local_7;
    _group_0_binding_0_cs[_e86] = uint(_e80);
    local_8 = uint((base + 9u));
    uint _e92 = local_8;
    _group_0_binding_0_cs[_e92] = lane;
}

