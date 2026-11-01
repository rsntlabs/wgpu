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
    int _e1 = int(true);
    _group_0_binding_0_cs[uint(0)] = uint((_e1 < 0 ? 0 : 31 - findMSB(_e1)));
    _group_0_binding_0_cs[uint(1)] = uint((8 < 0 ? 0 : 31 - findMSB(8)));
    int _e15 = int(2147483648u);
    _group_0_binding_0_cs[uint(2)] = uint((_e15 < 0 ? 0 : 31 - findMSB(_e15)));
    int _e22 = int(8.75);
    _group_0_binding_0_cs[uint(3)] = uint((_e22 < 0 ? 0 : 31 - findMSB(_e22)));
    _group_0_binding_0_cs[uint(4)] = uint((findLSB(int(true)) + 1));
    _group_0_binding_0_cs[uint(5)] = uint((findLSB(8) + 1));
    _group_0_binding_0_cs[uint(6)] = uint((findLSB(int(2147483648u)) + 1));
    _group_0_binding_0_cs[uint(7)] = uint((findLSB(int(8.75)) + 1));
    _group_0_binding_0_cs[uint(8)] = uint(int(uint(bitCount(uint(true)))));
    _group_0_binding_0_cs[uint(9)] = uint(int(uint(bitCount(uint(-(1))))));
    _group_0_binding_0_cs[uint(10)] = uint(int(uint(bitCount(2147483649u))));
    _group_0_binding_0_cs[uint(11)] = uint(int(uint(bitCount(uint(3.75)))));
    _group_0_binding_0_cs[uint(12)] = bitfieldReverse(uint(true));
    _group_0_binding_0_cs[uint(13)] = bitfieldReverse(uint(-(1)));
    _group_0_binding_0_cs[uint(14)] = bitfieldReverse(19088743u);
    _group_0_binding_0_cs[uint(15)] = bitfieldReverse(uint(2.75));
    int _e120 = count(2147483649u);
    _group_0_binding_0_cs[uint(16)] = uint(_e120);
    int _e127 = scan(int(2147483648u));
    _group_0_binding_0_cs[uint(17)] = uint(_e127);
    _group_0_binding_0_cs[uint(18)] = uint((0 < 0 ? 0 : 31 - findMSB(0)));
    _group_0_binding_0_cs[uint(19)] = uint((findLSB(0) + 1));
    _group_0_binding_0_cs[uint(20)] = uint(int(uint(bitCount(4294967295u))));
    _group_0_binding_0_cs[uint(21)] = bitfieldReverse(0u);
    _group_0_binding_0_cs[uint(22)] = bitfieldReverse(1u);
    _group_0_binding_0_cs[uint(23)] = bitfieldReverse(2147483648u);
    int _e169 = -(2);
    _group_0_binding_0_cs[uint(24)] = uint((_e169 < 0 ? 0 : 31 - findMSB(_e169)));
    _group_0_binding_0_cs[uint(25)] = uint((findLSB(-(2)) + 1));
    _group_0_binding_0_cs[uint(26)] = uint(int(uint(bitCount(2863311530u))));
    _group_0_binding_0_cs[uint(27)] = bitfieldReverse(2863311530u);
    int _e198 = _clz(3, 4);
    _group_0_binding_0_cs[uint(28)] = uint(_e198);
    _group_0_binding_0_cs[uint(29)] = uint(((int(uint(bitCount(3u))) - 3) < 0));
}

