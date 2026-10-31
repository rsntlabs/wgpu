#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };


int count(uint value) {
    return int(uint(bitCount(value)));
}

int scan(int value_1) {
    return (findLSB(value_1) + 1);
}

int _clz(int first, int second) {
    return (first + second);
}

void main() {
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
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    int _e1 = int(true);
    local = uint(0);
    uint _e7 = local;
    _group_0_binding_0_cs[_e7] = uint((_e1 < 0 ? 0 : 31 - findMSB(_e1)));
    local_1 = uint(1);
    uint _e16 = local_1;
    _group_0_binding_0_cs[_e16] = uint((8 < 0 ? 0 : 31 - findMSB(8)));
    int _e19 = int(2147483648u);
    local_2 = uint(2);
    uint _e25 = local_2;
    _group_0_binding_0_cs[_e25] = uint((_e19 < 0 ? 0 : 31 - findMSB(_e19)));
    int _e28 = int(8.75);
    local_3 = uint(3);
    uint _e34 = local_3;
    _group_0_binding_0_cs[_e34] = uint((_e28 < 0 ? 0 : 31 - findMSB(_e28)));
    local_4 = uint(4);
    uint _e45 = local_4;
    _group_0_binding_0_cs[_e45] = uint((findLSB(int(true)) + 1));
    local_5 = uint(5);
    uint _e55 = local_5;
    _group_0_binding_0_cs[_e55] = uint((findLSB(8) + 1));
    local_6 = uint(6);
    uint _e66 = local_6;
    _group_0_binding_0_cs[_e66] = uint((findLSB(int(2147483648u)) + 1));
    local_7 = uint(7);
    uint _e77 = local_7;
    _group_0_binding_0_cs[_e77] = uint((findLSB(int(8.75)) + 1));
    local_8 = uint(8);
    uint _e87 = local_8;
    _group_0_binding_0_cs[_e87] = uint(int(uint(bitCount(uint(true)))));
    local_9 = uint(9);
    uint _e98 = local_9;
    _group_0_binding_0_cs[_e98] = uint(int(uint(bitCount(uint(-(1))))));
    local_10 = uint(10);
    uint _e107 = local_10;
    _group_0_binding_0_cs[_e107] = uint(int(uint(bitCount(2147483649u))));
    local_11 = uint(11);
    uint _e117 = local_11;
    _group_0_binding_0_cs[_e117] = uint(int(uint(bitCount(uint(3.75)))));
    local_12 = uint(12);
    uint _e125 = local_12;
    _group_0_binding_0_cs[_e125] = bitfieldReverse(uint(true));
    local_13 = uint(13);
    uint _e134 = local_13;
    _group_0_binding_0_cs[_e134] = bitfieldReverse(uint(-(1)));
    local_14 = uint(14);
    uint _e141 = local_14;
    _group_0_binding_0_cs[_e141] = bitfieldReverse(19088743u);
    local_15 = uint(15);
    uint _e149 = local_15;
    _group_0_binding_0_cs[_e149] = bitfieldReverse(uint(2.75));
    int _e152 = count(2147483649u);
    local_16 = uint(16);
    uint _e157 = local_16;
    _group_0_binding_0_cs[_e157] = uint(_e152);
    int _e161 = scan(int(2147483648u));
    local_17 = uint(17);
    uint _e166 = local_17;
    _group_0_binding_0_cs[_e166] = uint(_e161);
    local_18 = uint(18);
    uint _e174 = local_18;
    _group_0_binding_0_cs[_e174] = uint((0 < 0 ? 0 : 31 - findMSB(0)));
    local_19 = uint(19);
    uint _e184 = local_19;
    _group_0_binding_0_cs[_e184] = uint((findLSB(0) + 1));
    local_20 = uint(20);
    uint _e193 = local_20;
    _group_0_binding_0_cs[_e193] = uint(int(uint(bitCount(4294967295u))));
    local_21 = uint(21);
    uint _e200 = local_21;
    _group_0_binding_0_cs[_e200] = bitfieldReverse(0u);
    local_22 = uint(22);
    uint _e207 = local_22;
    _group_0_binding_0_cs[_e207] = bitfieldReverse(1u);
    local_23 = uint(23);
    uint _e214 = local_23;
    _group_0_binding_0_cs[_e214] = bitfieldReverse(2147483648u);
    int _e217 = -(2);
    local_24 = uint(24);
    uint _e223 = local_24;
    _group_0_binding_0_cs[_e223] = uint((_e217 < 0 ? 0 : 31 - findMSB(_e217)));
    local_25 = uint(25);
    uint _e234 = local_25;
    _group_0_binding_0_cs[_e234] = uint((findLSB(-(2)) + 1));
    local_26 = uint(26);
    uint _e243 = local_26;
    _group_0_binding_0_cs[_e243] = uint(int(uint(bitCount(2863311530u))));
    local_27 = uint(27);
    uint _e250 = local_27;
    _group_0_binding_0_cs[_e250] = bitfieldReverse(2863311530u);
    int _e254 = _clz(3, 4);
    local_28 = uint(28);
    uint _e259 = local_28;
    _group_0_binding_0_cs[_e259] = uint(_e254);
    local_29 = uint(29);
    uint _e272 = local_29;
    _group_0_binding_0_cs[_e272] = uint(((int(uint(bitCount(3u))) - 3) < 0));
}

