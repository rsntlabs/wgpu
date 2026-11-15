#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

const int N_1 = 4;

uvec3 threadIdx_1 = uvec3(0u);

layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_5_block_1Compute { int _group_0_binding_1_cs[]; };


int choose(int value) {
    return (value + 10);
}

int self_named_4_() {
    return 4;
}

int inherited_5_() {
    return 5;
}

int value_7_() {
    return 7;
}

int add_3_int(int value_1) {
    return (value_1 + 3);
}

uint add_7_unsigned(uint value_2) {
    return (value_2 + uint(7));
}

uint mixed_unsigned_5_() {
    return uint(5);
}

int mixed_int_8_() {
    return 8;
}

uint flags_true_4u() {
    return (uint(true) + 4u);
}

int cast_value_3_() {
    return 3;
}

int comma_value_2_() {
    return 2;
}

int shifted_4_() {
    return 4;
}

int choose_20_unsigned(uint value_3) {
    return (int(value_3) + 20);
}

int choose_20_int(int value_4) {
    return (value_4 + 20);
}

int skipped_thread_true() {
    return int(true);
}

int skipped_grid_false() {
    return int(false);
}

int skipped_call_true() {
    return int(true);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int N = 0;
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
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    int state = 0;
    uint local_15 = 0u;
    uint local_16 = 0u;
    bool local_17 = false;
    int local_18 = 0;
    bool local_19 = false;
    int local_20 = 0;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    int index = 0;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    int old = 0;
    int old_1 = 0;
    int old_2 = 0;
    int local_28 = 0;
    int local_29 = 0;
    int old_3 = 0;
    int local_30 = 0;
    int local_31 = 0;
    int old_4 = 0;
    threadIdx_1 = threadIdx;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 24u));
    N = 99;
    int _e9 = self_named_4_();
    _group_0_binding_0_cs[base] = uint(_e9);
    int _e13 = inherited_5_();
    local = uint((base + 1u));
    uint _e19 = local;
    _group_0_binding_0_cs[_e19] = uint(_e13);
    int _e21 = value_7_();
    local_1 = uint((base + 2u));
    uint _e27 = local_1;
    _group_0_binding_0_cs[_e27] = uint(_e21);
    int _e29 = value_7_();
    local_2 = uint((base + 3u));
    uint _e35 = local_2;
    _group_0_binding_0_cs[_e35] = uint(_e29);
    int _e37 = value_7_();
    local_3 = uint((base + 4u));
    uint _e43 = local_3;
    _group_0_binding_0_cs[_e43] = uint(_e37);
    int _e46 = add_3_int(2);
    local_4 = uint((base + 5u));
    uint _e52 = local_4;
    _group_0_binding_0_cs[_e52] = uint(_e46);
    uint _e55 = add_7_unsigned(3u);
    local_5 = uint((base + 6u));
    uint _e60 = local_5;
    _group_0_binding_0_cs[_e60] = _e55;
    uint _e62 = mixed_unsigned_5_();
    local_6 = uint((base + 7u));
    uint _e67 = local_6;
    _group_0_binding_0_cs[_e67] = _e62;
    int _e69 = mixed_int_8_();
    local_7 = uint((base + 8u));
    uint _e75 = local_7;
    _group_0_binding_0_cs[_e75] = uint(_e69);
    uint _e77 = flags_true_4u();
    local_8 = uint((base + 9u));
    uint _e82 = local_8;
    _group_0_binding_0_cs[_e82] = _e77;
    int _e84 = cast_value_3_();
    local_9 = uint((base + 10u));
    uint _e90 = local_9;
    _group_0_binding_0_cs[_e90] = uint(_e84);
    int _e92 = comma_value_2_();
    local_10 = uint((base + 11u));
    uint _e98 = local_10;
    _group_0_binding_0_cs[_e98] = uint(_e92);
    int _e100 = shifted_4_();
    local_11 = uint((base + 12u));
    uint _e106 = local_11;
    _group_0_binding_0_cs[_e106] = uint(_e100);
    int _e109 = choose(1);
    local_12 = uint((base + 13u));
    uint _e115 = local_12;
    _group_0_binding_0_cs[_e115] = uint(_e109);
    int _e118 = choose_20_unsigned(1u);
    local_13 = uint((base + 14u));
    uint _e124 = local_13;
    _group_0_binding_0_cs[_e124] = uint(_e118);
    int _e127 = choose_20_int(1);
    local_14 = uint((base + 15u));
    uint _e133 = local_14;
    _group_0_binding_0_cs[_e133] = uint(_e127);
    state = (int(lane) + 1);
    old = 0;
    int _e141 = state;
    old = _e141;
    int _e143 = state;
    state = (_e143 + 2);
    int _e146 = old;
    local_15 = uint((base + 16u));
    uint _e152 = local_15;
    _group_0_binding_0_cs[_e152] = uint(_e146);
    old_1 = 0;
    int _e156 = state;
    old_1 = _e156;
    int _e158 = state;
    state = (_e158 + 3);
    int _e161 = old_1;
    local_16 = uint((base + 17u));
    uint _e167 = local_16;
    _group_0_binding_0_cs[_e167] = uint(_e161);
    local_17 = false;
    if (false) {
        old_2 = 0;
        int _e173 = state;
        local_28 = _e173;
        int _e175 = local_28;
        old_2 = _e175;
        int _e177 = state;
        local_29 = _e177;
        int _e179 = local_29;
        state = (_e179 + 2);
        int _e182 = old_2;
        local_18 = _e182;
        int _e184 = local_18;
        local_17 = (_e184 != 0);
    }
    local_19 = true;
    if (true) {
    } else {
        old_3 = 0;
        int _e191 = state;
        local_30 = _e191;
        int _e193 = local_30;
        old_3 = _e193;
        int _e195 = state;
        local_31 = _e195;
        int _e197 = local_31;
        state = (_e197 + 2);
        int _e200 = old_3;
        local_20 = _e200;
        int _e202 = local_20;
        local_19 = (_e202 != 0);
    }
    old_4 = 0;
    int _e207 = state;
    old_4 = _e207;
    int _e209 = state;
    state = (_e209 + 2);
    int _e212 = state;
    local_21 = uint((base + 18u));
    uint _e218 = local_21;
    _group_0_binding_0_cs[_e218] = uint(_e212);
    int _e220 = skipped_thread_true();
    local_22 = uint((base + 19u));
    uint _e226 = local_22;
    _group_0_binding_0_cs[_e226] = uint(_e220);
    int _e228 = skipped_grid_false();
    local_23 = uint((base + 20u));
    uint _e234 = local_23;
    _group_0_binding_0_cs[_e234] = uint(_e228);
    int _e236 = skipped_call_true();
    local_24 = uint((base + 21u));
    uint _e242 = local_24;
    _group_0_binding_0_cs[_e242] = uint(_e236);
    index = 0;
    int _e246 = index;
    index = (_e246 + 1);
    local_26 = uint(_e246);
    uint _e251 = local_26;
    int _e254 = _group_0_binding_1_cs[_e251];
    int _e255 = add_3_int(_e254);
    local_25 = uint((base + 22u));
    uint _e261 = local_25;
    _group_0_binding_0_cs[_e261] = uint(_e255);
    int _e263 = index;
    local_27 = uint((base + 23u));
    uint _e269 = local_27;
    _group_0_binding_0_cs[_e269] = uint(_e263);
}

