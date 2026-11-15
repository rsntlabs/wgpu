#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

const int Initial_1 = 6;

layout(std430) buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_4_block_1Compute { int _group_0_binding_1_cs[]; };


uint chain_6_6u_6_() {
    return uint(6);
}

uint chain_7_7u_7_() {
    return uint(7);
}

int merged_8_8_() {
    return 8;
}

uint flag_0_false() {
    return uint(false);
}

uint flag_1_true() {
    return uint(true);
}

uint cross_u002d_1_7u() {
    return 7u;
}

uint wide_65535ULL_65535u() {
    return 65535u;
}

uint mixed_unsigned_4_4_() {
    return uint(4);
}

int mixed_int_9_9_() {
    return 9;
}

uint choose_3_3_unsigned(uint value) {
    return (value + uint(3));
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int Initial = 0;
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
    int state = 0;
    uint local_11 = 0u;
    bool local_12 = false;
    int local_13 = 0;
    bool local_14 = false;
    int local_15 = 0;
    uint local_16 = 0u;
    int index = 0;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    int old = 0;
    int old_1 = 0;
    int local_20 = 0;
    int local_21 = 0;
    int old_2 = 0;
    int local_22 = 0;
    int local_23 = 0;
    int old_3 = 0;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 16u));
    Initial = 99;
    uint _e8 = chain_6_6u_6_();
    _group_0_binding_0_cs[base] = _e8;
    uint _e11 = chain_6_6u_6_();
    local = uint((base + 1u));
    uint _e16 = local;
    _group_0_binding_0_cs[_e16] = _e11;
    uint _e18 = chain_6_6u_6_();
    local_1 = uint((base + 2u));
    uint _e23 = local_1;
    _group_0_binding_0_cs[_e23] = _e18;
    uint _e25 = chain_7_7u_7_();
    local_2 = uint((base + 3u));
    uint _e30 = local_2;
    _group_0_binding_0_cs[_e30] = _e25;
    int _e32 = merged_8_8_();
    local_3 = uint((base + 4u));
    uint _e38 = local_3;
    _group_0_binding_0_cs[_e38] = uint(_e32);
    uint _e40 = flag_0_false();
    local_4 = uint((base + 5u));
    uint _e45 = local_4;
    _group_0_binding_0_cs[_e45] = _e40;
    uint _e47 = flag_1_true();
    local_5 = uint((base + 6u));
    uint _e52 = local_5;
    _group_0_binding_0_cs[_e52] = _e47;
    uint _e54 = cross_u002d_1_7u();
    local_6 = uint((base + 7u));
    uint _e59 = local_6;
    _group_0_binding_0_cs[_e59] = _e54;
    uint _e61 = wide_65535ULL_65535u();
    local_7 = uint((base + 8u));
    uint _e66 = local_7;
    _group_0_binding_0_cs[_e66] = _e61;
    uint _e68 = mixed_unsigned_4_4_();
    local_8 = uint((base + 9u));
    uint _e73 = local_8;
    _group_0_binding_0_cs[_e73] = _e68;
    int _e75 = mixed_int_9_9_();
    local_9 = uint((base + 10u));
    uint _e81 = local_9;
    _group_0_binding_0_cs[_e81] = uint(_e75);
    uint _e84 = choose_3_3_unsigned(2u);
    local_10 = uint((base + 11u));
    uint _e89 = local_10;
    _group_0_binding_0_cs[_e89] = _e84;
    state = (int(lane) + 1);
    old = 0;
    int _e97 = state;
    old = _e97;
    int _e99 = state;
    state = (_e99 + 2);
    int _e102 = old;
    local_11 = uint((base + 12u));
    uint _e108 = local_11;
    _group_0_binding_0_cs[_e108] = uint(_e102);
    local_12 = false;
    if (false) {
        old_1 = 0;
        int _e114 = state;
        local_20 = _e114;
        int _e116 = local_20;
        old_1 = _e116;
        int _e118 = state;
        local_21 = _e118;
        int _e120 = local_21;
        state = (_e120 + 99);
        int _e123 = old_1;
        local_13 = _e123;
        int _e125 = local_13;
        local_12 = (_e125 != 0);
    }
    local_14 = true;
    if (true) {
    } else {
        old_2 = 0;
        int _e132 = state;
        local_22 = _e132;
        int _e134 = local_22;
        old_2 = _e134;
        int _e136 = state;
        local_23 = _e136;
        int _e138 = local_23;
        state = (_e138 + 99);
        int _e141 = old_2;
        local_15 = _e141;
        int _e143 = local_15;
        local_14 = (_e143 != 0);
    }
    old_3 = 0;
    int _e148 = state;
    old_3 = _e148;
    int _e150 = state;
    state = (_e150 + 3);
    int _e153 = state;
    local_16 = uint((base + 13u));
    uint _e159 = local_16;
    _group_0_binding_0_cs[_e159] = uint(_e153);
    index = 0;
    int _e163 = index;
    index = (_e163 + 1);
    local_18 = uint(_e163);
    uint _e168 = local_18;
    int _e171 = _group_0_binding_1_cs[_e168];
    uint _e173 = choose_3_3_unsigned(uint(_e171));
    local_17 = uint((base + 14u));
    uint _e178 = local_17;
    _group_0_binding_0_cs[_e178] = _e173;
    int _e180 = index;
    local_19 = uint((base + 15u));
    uint _e186 = local_19;
    _group_0_binding_0_cs[_e186] = uint(_e180);
}

