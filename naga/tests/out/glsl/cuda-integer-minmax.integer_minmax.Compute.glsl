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
    int first = 0;
    int second = 0;
    int value = 0;
    int seed = _group_0_binding_0_cs[uint(0)];
    _group_0_binding_0_cs[uint(0)] = min(seed, -(7));
    _group_0_binding_0_cs[uint(1)] = max(seed, -(7));
    _group_0_binding_0_cs[uint(2)] = int(min(3u, 9u));
    _group_0_binding_0_cs[uint(3)] = int(max(3u, 9u));
    _group_0_binding_0_cs[uint(4)] = int((min(uint(-(1)), 2u) == 2u));
    _group_0_binding_0_cs[uint(5)] = int((max(uint(-(1)), 2u) == 4294967295u));
    _group_0_binding_0_cs[uint(6)] = int((min(2u, uint(-(1))) == 2u));
    _group_0_binding_0_cs[uint(7)] = int((max(2u, uint(-(1))) == 4294967295u));
    _group_0_binding_0_cs[uint(8)] = min(int(true), int(false));
    _group_0_binding_0_cs[uint(9)] = max(int(false), int(true));
    _group_0_binding_0_cs[uint(10)] = min(max(seed, -(5)), 2);
    _group_0_binding_0_cs[uint(11)] = int((min(uint(-(2)), 4u) == 4u));
    int _e112 = min_(seed, 4, 5);
    _group_0_binding_0_cs[uint(12)] = _e112;
    int _e116 = bounded(seed);
    _group_0_binding_0_cs[uint(13)] = _e116;
    first = 3;
    second = 7;
    int _e124 = first;
    first = (_e124 + 1);
    int _e127 = second;
    second = (_e127 + 1);
    _group_0_binding_0_cs[uint(14)] = max(_e124, _e127);
    int _e134 = first;
    _group_0_binding_0_cs[uint(15)] = _e134;
    int _e138 = second;
    _group_0_binding_0_cs[uint(16)] = _e138;
    value = seed;
    int _e143 = value;
    int _e144 = value;
    value = (_e144 + 1);
    _group_0_binding_0_cs[uint(17)] = max(_e143, _e144);
    int _e151 = value;
    _group_0_binding_0_cs[uint(18)] = _e151;
    _group_0_binding_0_cs[uint(19)] = int((min((-(2147483647) - 1), 2147483647) == (-(2147483647) - 1)));
    _group_0_binding_0_cs[uint(20)] = int((max(4294967295u, 0u) == 4294967295u));
    _group_0_binding_0_cs[uint(21)] = int((min(uint(false), 3u) == 0u));
    _group_0_binding_0_cs[uint(22)] = int((max(uint(true), 0u) == 1u));
    _group_0_binding_0_cs[uint(23)] = min(seed, seed);
}

