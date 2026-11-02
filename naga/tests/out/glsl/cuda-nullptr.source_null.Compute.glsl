#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };

shared uint values[4];


void synchronize() {
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    return;
}

uint selected() {
    return 7u;
}

uint selected_1(int value) {
    return 13u;
}

void copied_decltype_u0028_nullptr_u0029_() {
    return;
}

void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        values = uint[4](0u, 0u, 0u, 0u);
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uint output_[2] = uint[2](0u, 0u);
    uint counter = 0u;
    uint pointer[2] = uint[2](0u, 0u);
    uint local[2] = uint[2](0u, 0u);
    uint local_1[2] = uint[2](0u, 0u);
    uint local_2 = 0u;
    uint local_3[2] = uint[2](0u, 0u);
    uint local_4 = 0u;
    uint local_5[2] = uint[2](0u, 0u);
    uint local_6 = 0u;
    uint local_7[2] = uint[2](0u, 0u);
    bool local_8 = false;
    uint local_9[2] = uint[2](0u, 0u);
    uint local_10 = 0u;
    uint local_11[2] = uint[2](0u, 0u);
    uint local_12 = 0u;
    uint local_13[2] = uint[2](0u, 0u);
    uint local_14 = 0u;
    uint local_15[2] = uint[2](0u, 0u);
    uint local_16 = 0u;
    uint local_17[2] = uint[2](0u, 0u);
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20[2] = uint[2](0u, 0u);
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23[2] = uint[2](0u, 0u);
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26[2] = uint[2](0u, 0u);
    uint local_27[2] = uint[2](0u, 0u);
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30[2] = uint[2](0u, 0u);
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33[2] = uint[2](0u, 0u);
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36[2] = uint[2](0u, 0u);
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39[2] = uint[2](0u, 0u);
    uint local_40 = 0u;
    uint local_41 = 0u;
    output_ = uint[2](0u, 0u);
    output_[0] = 2u;
    output_[1] = 0u;
    uint lane = threadIdx.x;
    counter = 0u;
    copied_decltype_u0028_nullptr_u0029_();
    uint _e10 = counter;
    counter = (_e10 + uint(1));
    pointer = uint[2](0u, 0u);
    pointer[0] = 1u;
    values[lane] = (lane + 3u);
    synchronize();
    uint base = (lane * 8u);
    uint _e27 = values[(3u - lane)];
    uint _e29[2] = output_;
    local = _e29;
    uint _e31[2] = local;
    local_17 = _e31;
    uint _e34 = local_17[1];
    local_17[1] = (_e34 + base);
    uint _e38 = local_17[0];
    local_18 = uint(_e38);
    uint _e42 = local_17[1];
    local_19 = uint(_e42);
    uint _e45 = local_19;
    _group_0_binding_0_cs[_e45] = _e27;
    uint _e48 = selected();
    uint _e49[2] = output_;
    local_1 = _e49;
    local_2 = uint((base + 1u));
    uint _e55[2] = local_1;
    local_20 = _e55;
    uint _e57 = local_2;
    uint _e59 = local_20[1];
    local_20[1] = (_e59 + _e57);
    uint _e63 = local_20[0];
    local_21 = uint(_e63);
    uint _e67 = local_20[1];
    local_22 = uint(_e67);
    uint _e70 = local_22;
    _group_0_binding_0_cs[_e70] = _e48;
    uint _e73 = selected_1(0);
    uint _e74[2] = output_;
    local_3 = _e74;
    local_4 = uint((base + 2u));
    uint _e80[2] = local_3;
    local_23 = _e80;
    uint _e82 = local_4;
    uint _e84 = local_23[1];
    local_23[1] = (_e84 + _e82);
    uint _e88 = local_23[0];
    local_24 = uint(_e88);
    uint _e92 = local_23[1];
    local_25 = uint(_e92);
    uint _e95 = local_25;
    _group_0_binding_0_cs[_e95] = _e73;
    uint _e98[2] = pointer;
    local_7 = _e98;
    uint _e100[2] = local_7;
    local_26 = _e100;
    uint _e103 = local_26[0];
    local_8 = (_e103 == 1u);
    bool _e107 = local_8;
    uint _e109[2] = output_;
    local_5 = _e109;
    local_6 = uint((base + 3u));
    uint _e115[2] = local_5;
    local_27 = _e115;
    uint _e117 = local_6;
    uint _e119 = local_27[1];
    local_27[1] = (_e119 + _e117);
    uint _e123 = local_27[0];
    local_28 = uint(_e123);
    uint _e127 = local_27[1];
    local_29 = uint(_e127);
    uint _e130 = local_29;
    _group_0_binding_0_cs[_e130] = uint(_e107);
    uint _e132 = counter;
    uint _e133[2] = output_;
    local_9 = _e133;
    local_10 = uint((base + 4u));
    uint _e139[2] = local_9;
    local_30 = _e139;
    uint _e141 = local_10;
    uint _e143 = local_30[1];
    local_30[1] = (_e143 + _e141);
    uint _e147 = local_30[0];
    local_31 = uint(_e147);
    uint _e151 = local_30[1];
    local_32 = uint(_e151);
    uint _e154 = local_32;
    _group_0_binding_0_cs[_e154] = _e132;
    copied_decltype_u0028_nullptr_u0029_();
    uint _e156 = selected();
    uint _e157[2] = output_;
    local_11 = _e157;
    local_12 = uint((base + 5u));
    uint _e163[2] = local_11;
    local_33 = _e163;
    uint _e165 = local_12;
    uint _e167 = local_33[1];
    local_33[1] = (_e167 + _e165);
    uint _e171 = local_33[0];
    local_34 = uint(_e171);
    uint _e175 = local_33[1];
    local_35 = uint(_e175);
    uint _e178 = local_35;
    _group_0_binding_0_cs[_e178] = _e156;
    uint _e180 = selected();
    uint _e181[2] = output_;
    local_13 = _e181;
    local_14 = uint((base + 6u));
    uint _e187[2] = local_13;
    local_36 = _e187;
    uint _e189 = local_14;
    uint _e191 = local_36[1];
    local_36[1] = (_e191 + _e189);
    uint _e195 = local_36[0];
    local_37 = uint(_e195);
    uint _e199 = local_36[1];
    local_38 = uint(_e199);
    uint _e202 = local_38;
    _group_0_binding_0_cs[_e202] = _e180;
    uint _e206[2] = output_;
    local_15 = _e206;
    local_16 = uint((base + 7u));
    uint _e212[2] = local_15;
    local_39 = _e212;
    uint _e214 = local_16;
    uint _e216 = local_39[1];
    local_39[1] = (_e216 + _e214);
    uint _e220 = local_39[0];
    local_40 = uint(_e220);
    uint _e224 = local_39[1];
    local_41 = uint(_e224);
    uint _e227 = local_41;
    _group_0_binding_0_cs[_e227] = uint(false);
}

