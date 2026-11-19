#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct Record_cuda_record_0_ {
    int first;
    uint second;
    float third;
};
layout(std430) readonly buffer type_3_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int counter = 0;
    int matrix[2][3] = int[2][3](int[3](0, 0, 0), int[3](0, 0, 0));
    uint local = 0u;
    uint local_1 = 0u;
    Record_cuda_record_0_ record = Record_cuda_record_0_(0, 0u, 0.0);
    uint Scalar = 0u;
    uint Boolean = 0u;
    uint Array = 0u;
    uint Row = 0u;
    uint Element = 0u;
    uint Member = 0u;
    uint Pointer = 0u;
    uint Null = 0u;
    uint Middle = 0u;
    uint Outer = 0u;
    uint Nested = 0u;
    uint NoRead = 0u;
    uint InvalidMath = 0u;
    uint NullArm = 0u;
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
    bool flag = (seed != 0);
    counter = 7;
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
            matrix[_e15][_e22] = 0;
        }
    }
    record = Record_cuda_record_0_(0, 0u, 0.0);
    Scalar = 4u;
    Boolean = 1u;
    Array = 24u;
    Row = 12u;
    Element = 4u;
    Member = 4u;
    Pointer = 8u;
    Null = 8u;
    Middle = 1u;
    Outer = 1u;
    Nested = 1u;
    NoRead = 4u;
    InvalidMath = 1u;
    NullArm = 8u;
    uint _e63 = Scalar;
    _group_0_binding_1_cs[base] = _e63;
    uint _e66 = Boolean;
    local_2 = uint((base + 1u));
    uint _e71 = local_2;
    _group_0_binding_1_cs[_e71] = _e66;
    uint _e73 = Array;
    local_3 = uint((base + 2u));
    uint _e78 = local_3;
    _group_0_binding_1_cs[_e78] = _e73;
    uint _e80 = Row;
    local_4 = uint((base + 3u));
    uint _e85 = local_4;
    _group_0_binding_1_cs[_e85] = _e80;
    uint _e87 = Element;
    local_5 = uint((base + 4u));
    uint _e92 = local_5;
    _group_0_binding_1_cs[_e92] = _e87;
    uint _e94 = Member;
    local_6 = uint((base + 5u));
    uint _e99 = local_6;
    _group_0_binding_1_cs[_e99] = _e94;
    uint _e101 = Pointer;
    local_7 = uint((base + 6u));
    uint _e106 = local_7;
    _group_0_binding_1_cs[_e106] = _e101;
    uint _e108 = Null;
    local_8 = uint((base + 7u));
    uint _e113 = local_8;
    _group_0_binding_1_cs[_e113] = _e108;
    uint _e115 = Middle;
    local_9 = uint((base + 8u));
    uint _e120 = local_9;
    _group_0_binding_1_cs[_e120] = _e115;
    uint _e122 = Outer;
    local_10 = uint((base + 9u));
    uint _e127 = local_10;
    _group_0_binding_1_cs[_e127] = _e122;
    uint _e129 = Nested;
    local_11 = uint((base + 10u));
    uint _e134 = local_11;
    _group_0_binding_1_cs[_e134] = _e129;
    uint _e136 = NoRead;
    local_12 = uint((base + 11u));
    uint _e141 = local_12;
    _group_0_binding_1_cs[_e141] = _e136;
    uint _e143 = InvalidMath;
    local_13 = uint((base + 12u));
    uint _e148 = local_13;
    _group_0_binding_1_cs[_e148] = _e143;
    uint _e150 = NullArm;
    local_14 = uint((base + 13u));
    uint _e155 = local_14;
    _group_0_binding_1_cs[_e155] = _e150;
    int _e157 = counter;
    local_15 = uint((base + 14u));
    uint _e163 = local_15;
    _group_0_binding_1_cs[_e163] = uint(_e157);
    int _e166 = _group_0_binding_0_cs[lane];
    local_16 = uint((base + 15u));
    uint _e172 = local_16;
    _group_0_binding_1_cs[_e172] = uint(_e166);
}

