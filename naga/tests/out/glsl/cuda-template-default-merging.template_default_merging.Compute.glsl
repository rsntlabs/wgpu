#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

const int Count_1 = 5;

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_3_block_1Compute { int _group_0_binding_1_cs[]; };


int kind(uint value_6) {
    return 2;
}

uint value_unsigned_5_() {
    return uint(5);
}

uint self_named_unsigned() {
    return uint(9);
}

int choose_3_(int value_7) {
    return (3 + value_7);
}

int choose_5_(uint value_8) {
    return ((20 + 5) + int(value_8));
}

int choose_7_(int value_9) {
    return (7 + value_9);
}

uint caller_1_() {
    uint _e0 = value_unsigned_5_();
    return _e0;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int Count = 0;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    int state = 0;
    uint local_9 = 0u;
    uint local_10 = 0u;
    bool local_11 = false;
    int local_12 = 0;
    bool local_13 = false;
    int local_14 = 0;
    uint local_15 = 0u;
    int index = 0;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    int value = 0;
    int old = 0;
    uint value_1 = 0u;
    int old_1 = 0;
    int value_2 = 0;
    int old_2 = 0;
    int local_20 = 0;
    int local_21 = 0;
    int value_3 = 0;
    int old_3 = 0;
    int local_22 = 0;
    int local_23 = 0;
    int value_4 = 0;
    int old_4 = 0;
    int value_5 = 0;
    int old_5 = 0;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 16u));
    Count = 99;
    uint _e8 = value_unsigned_5_();
    _group_0_binding_0_cs[base] = _e8;
    uint _e11 = value_unsigned_5_();
    local = uint((base + 1u));
    uint _e16 = local;
    _group_0_binding_0_cs[_e16] = _e11;
    uint _e18 = value_unsigned_5_();
    local_1 = uint((base + 2u));
    uint _e23 = local_1;
    _group_0_binding_0_cs[_e23] = _e18;
    uint _e25 = value_unsigned_5_();
    local_2 = uint((base + 3u));
    uint _e30 = local_2;
    _group_0_binding_0_cs[_e30] = _e25;
    uint _e32 = self_named_unsigned();
    local_3 = uint((base + 4u));
    uint _e37 = local_3;
    _group_0_binding_0_cs[_e37] = _e32;
    uint _e39 = value_unsigned_5_();
    int _e40 = kind(_e39);
    local_4 = uint((base + 5u));
    uint _e46 = local_4;
    _group_0_binding_0_cs[_e46] = uint(_e40);
    int _e49 = choose_3_(1);
    local_5 = uint((base + 6u));
    uint _e55 = local_5;
    _group_0_binding_0_cs[_e55] = uint(_e49);
    int _e58 = choose_5_(1u);
    local_6 = uint((base + 7u));
    uint _e64 = local_6;
    _group_0_binding_0_cs[_e64] = uint(_e58);
    int _e67 = choose_7_(1);
    local_7 = uint((base + 8u));
    uint _e73 = local_7;
    _group_0_binding_0_cs[_e73] = uint(_e67);
    uint _e75 = caller_1_();
    local_8 = uint((base + 9u));
    uint _e80 = local_8;
    _group_0_binding_0_cs[_e80] = _e75;
    state = (int(lane) + 1);
    value = 0;
    old = 0;
    value = 1;
    int _e92 = state;
    old = _e92;
    int _e94 = value;
    int _e97 = state;
    state = (_e97 + (2 + _e94));
    int _e99 = old;
    local_9 = uint((base + 10u));
    uint _e105 = local_9;
    _group_0_binding_0_cs[_e105] = uint(_e99);
    value_1 = 0u;
    old_1 = 0;
    value_1 = 2u;
    int _e113 = state;
    old_1 = _e113;
    uint _e115 = value_1;
    int _e119 = state;
    state = (_e119 + (3 + int(_e115)));
    int _e121 = old_1;
    local_10 = uint((base + 11u));
    uint _e127 = local_10;
    _group_0_binding_0_cs[_e127] = uint(_e121);
    local_11 = false;
    if (false) {
        value_2 = 0;
        old_2 = 0;
        value_2 = 9;
        int _e137 = state;
        local_20 = _e137;
        int _e139 = local_20;
        old_2 = _e139;
        int _e141 = value_2;
        int _e144 = state;
        local_21 = _e144;
        int _e146 = local_21;
        state = (_e146 + (2 + _e141));
        int _e148 = old_2;
        local_12 = _e148;
        int _e150 = local_12;
        local_11 = (_e150 != 0);
    }
    local_13 = true;
    if (true) {
    } else {
        value_3 = 0;
        old_3 = 0;
        value_3 = 9;
        int _e161 = state;
        local_22 = _e161;
        int _e163 = local_22;
        old_3 = _e163;
        int _e165 = value_3;
        int _e168 = state;
        local_23 = _e168;
        int _e170 = local_23;
        state = (_e170 + (2 + _e165));
        int _e172 = old_3;
        local_14 = _e172;
        int _e174 = local_14;
        local_13 = (_e174 != 0);
    }
    value_4 = 0;
    old_4 = 0;
    value_4 = 0;
    int _e183 = state;
    old_4 = _e183;
    int _e185 = value_4;
    int _e188 = state;
    state = (_e188 + (2 + _e185));
    int _e190 = state;
    local_15 = uint((base + 12u));
    uint _e196 = local_15;
    _group_0_binding_0_cs[_e196] = uint(_e190);
    index = 0;
    int _e200 = index;
    index = (_e200 + 1);
    local_17 = uint(_e200);
    uint _e205 = local_17;
    int _e208 = _group_0_binding_1_cs[_e205];
    value_5 = 0;
    old_5 = 0;
    value_5 = _e208;
    int _e214 = state;
    old_5 = _e214;
    int _e216 = value_5;
    int _e219 = state;
    state = (_e219 + (2 + _e216));
    int _e221 = old_5;
    local_16 = uint((base + 13u));
    uint _e227 = local_16;
    _group_0_binding_0_cs[_e227] = uint(_e221);
    int _e229 = state;
    local_18 = uint((base + 14u));
    uint _e235 = local_18;
    _group_0_binding_0_cs[_e235] = uint(_e229);
    int _e237 = index;
    local_19 = uint((base + 15u));
    uint _e243 = local_19;
    _group_0_binding_0_cs[_e243] = uint(_e237);
}

