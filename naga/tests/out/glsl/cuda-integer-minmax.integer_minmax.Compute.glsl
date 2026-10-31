#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };


int min_(int first_1, int second_1, int third) {
    return (((first_1 + second_1) + third) + 100);
}

int bounded(int value_1) {
    return min(max(value_1, -(2)), 2);
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
    int first = 0;
    int second = 0;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    int value = 0;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    local = uint(0);
    uint _e3 = local;
    int seed = _group_0_binding_0_cs[_e3];
    local_1 = uint(0);
    uint _e13 = local_1;
    _group_0_binding_0_cs[_e13] = min(seed, -(7));
    local_2 = uint(1);
    uint _e21 = local_2;
    _group_0_binding_0_cs[_e21] = max(seed, -(7));
    local_3 = uint(2);
    uint _e30 = local_3;
    _group_0_binding_0_cs[_e30] = int(min(3u, 9u));
    local_4 = uint(3);
    uint _e39 = local_4;
    _group_0_binding_0_cs[_e39] = int(max(3u, 9u));
    local_5 = uint(4);
    uint _e52 = local_5;
    _group_0_binding_0_cs[_e52] = int((min(uint(-(1)), 2u) == 2u));
    local_6 = uint(5);
    uint _e65 = local_6;
    _group_0_binding_0_cs[_e65] = int((max(uint(-(1)), 2u) == 4294967295u));
    local_7 = uint(6);
    uint _e78 = local_7;
    _group_0_binding_0_cs[_e78] = int((min(2u, uint(-(1))) == 2u));
    local_8 = uint(7);
    uint _e91 = local_8;
    _group_0_binding_0_cs[_e91] = int((max(2u, uint(-(1))) == 4294967295u));
    local_9 = uint(8);
    uint _e101 = local_9;
    _group_0_binding_0_cs[_e101] = min(int(true), int(false));
    local_10 = uint(9);
    uint _e111 = local_10;
    _group_0_binding_0_cs[_e111] = max(int(false), int(true));
    local_11 = uint(10);
    uint _e121 = local_11;
    _group_0_binding_0_cs[_e121] = min(max(seed, -(5)), 2);
    local_12 = uint(11);
    uint _e134 = local_12;
    _group_0_binding_0_cs[_e134] = int((min(uint(-(2)), 4u) == 4u));
    int _e138 = min_(seed, 4, 5);
    local_13 = uint(12);
    uint _e142 = local_13;
    _group_0_binding_0_cs[_e142] = _e138;
    int _e144 = bounded(seed);
    local_14 = uint(13);
    uint _e148 = local_14;
    _group_0_binding_0_cs[_e148] = _e144;
    first = 3;
    second = 7;
    int _e154 = first;
    first = (_e154 + 1);
    int _e157 = second;
    second = (_e157 + 1);
    local_15 = uint(14);
    uint _e164 = local_15;
    _group_0_binding_0_cs[_e164] = max(_e154, _e157);
    int _e166 = first;
    local_16 = uint(15);
    uint _e170 = local_16;
    _group_0_binding_0_cs[_e170] = _e166;
    int _e172 = second;
    local_17 = uint(16);
    uint _e176 = local_17;
    _group_0_binding_0_cs[_e176] = _e172;
    value = seed;
    int _e179 = value;
    int _e180 = value;
    value = (_e180 + 1);
    local_18 = uint(17);
    uint _e187 = local_18;
    _group_0_binding_0_cs[_e187] = max(_e179, _e180);
    int _e189 = value;
    local_19 = uint(18);
    uint _e193 = local_19;
    _group_0_binding_0_cs[_e193] = _e189;
    local_20 = uint(19);
    uint _e210 = local_20;
    _group_0_binding_0_cs[_e210] = int((min((-(2147483647) - 1), 2147483647) == (-(2147483647) - 1)));
    local_21 = uint(20);
    uint _e221 = local_21;
    _group_0_binding_0_cs[_e221] = int((max(4294967295u, 0u) == 4294967295u));
    local_22 = uint(21);
    uint _e233 = local_22;
    _group_0_binding_0_cs[_e233] = int((min(uint(false), 3u) == 0u));
    local_23 = uint(22);
    uint _e245 = local_23;
    _group_0_binding_0_cs[_e245] = int((max(uint(true), 0u) == 1u));
    local_24 = uint(23);
    uint _e251 = local_24;
    _group_0_binding_0_cs[_e251] = min(seed, seed);
}

