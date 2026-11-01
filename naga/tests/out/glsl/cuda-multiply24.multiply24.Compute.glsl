#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };


int signed_conversion(float first_1, float second_1) {
    return int((uint(bitfieldExtract(int(first_1), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(int(second_1), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
}

uint unsigned_conversion(float first_2, float second_2) {
    return (bitfieldExtract(uint(first_2), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(uint(second_2), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
}

int _mul24_(bool first_3, bool second_3) {
    int local_4 = 0;
    int local_5 = 0;
    if (first_3) {
        if (second_3) {
            local_4 = 71;
        } else {
            local_4 = 73;
        }
        int _e7 = local_4;
        local_5 = _e7;
    } else {
        local_5 = 79;
    }
    int _e12 = local_5;
    return _e12;
}

int _mul24_1(float first_4, float second_4) {
    return int(((first_4 * 10.0) + second_4));
}

uint _umul24_(int first_5, int second_5) {
    return uint(((first_5 + second_5) + 100));
}

int signed_pair(int first_6, int second_6) {
    return int((uint(bitfieldExtract(first_6, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(second_6, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
}

void main() {
    int first = 0;
    uint second = 0u;
    int local = 0;
    int values[2] = int[2](0, 0);
    int Count = 0;
    int local_1 = 0;
    int scratch[2] = int[2](0, 0);
    int counter = 0;
    int total = 0;
    int index = 0;
    uint local_2 = 0u;
    uint local_3 = 0u;
    _group_0_binding_0_cs[uint(0)] = uint(int((uint(bitfieldExtract(8388608, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(1, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    _group_0_binding_0_cs[uint(1)] = (bitfieldExtract(16777215u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(16777215u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    _group_0_binding_0_cs[uint(2)] = uint(int((uint(bitfieldExtract(8388607, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(8388607, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    _group_0_binding_0_cs[uint(3)] = (bitfieldExtract(16777216u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(13u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    int _e52 = signed_conversion(3.75, -(2.75));
    _group_0_binding_0_cs[uint(4)] = uint(_e52);
    int _e60 = signed_conversion(-(3.75), 2.75);
    _group_0_binding_0_cs[uint(5)] = uint(_e60);
    uint _e67 = unsigned_conversion(3.75, 2.75);
    _group_0_binding_0_cs[uint(6)] = _e67;
    uint _e73 = unsigned_conversion(16777215.0, 1.0);
    _group_0_binding_0_cs[uint(7)] = _e73;
    int _e79 = _mul24_(true, true);
    _group_0_binding_0_cs[uint(8)] = uint(_e79);
    int _e86 = _mul24_(false, true);
    _group_0_binding_0_cs[uint(9)] = uint(_e86);
    _group_0_binding_0_cs[uint(10)] = uint(int((uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(int(true), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    _group_0_binding_0_cs[uint(11)] = uint(int((uint(bitfieldExtract(int(true), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    int _e123 = _mul24_1(3.75, 2.0);
    _group_0_binding_0_cs[uint(12)] = uint(_e123);
    uint _e130 = _umul24_(3, 4);
    _group_0_binding_0_cs[uint(13)] = _e130;
    _group_0_binding_0_cs[uint(14)] = (bitfieldExtract(3u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(4u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    uint _e148 = _umul24_(int(true), int(true));
    _group_0_binding_0_cs[uint(15)] = _e148;
    _group_0_binding_0_cs[uint(16)] = (bitfieldExtract(3u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(uint(4), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    int _e166 = signed_pair(-(7), 3);
    _group_0_binding_0_cs[uint(17)] = uint(_e166);
    _group_0_binding_0_cs[uint(18)] = uint(int((uint(bitfieldExtract(int((uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(4, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(5, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    _group_0_binding_0_cs[uint(19)] = (bitfieldExtract((bitfieldExtract(16777215u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(2u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(2u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    first = -3;
    second = 5u;
    int _e214 = first;
    uint _e215 = second;
    _group_0_binding_0_cs[uint(20)] = uint(int((uint(bitfieldExtract(_e214, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(int(_e215), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    int _e229 = first;
    uint _e231 = second;
    _group_0_binding_0_cs[uint(21)] = (bitfieldExtract(uint(_e229), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(_e231, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    _group_0_binding_0_cs[uint(22)] = uint(int((uint(bitfieldExtract(25165824, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(16777217, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    _group_0_binding_0_cs[uint(23)] = (bitfieldExtract(4286578688u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))) * bitfieldExtract(4278190081u, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))));
    if (true) {
        local = int((uint(bitfieldExtract(-(3), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(7, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    } else {
        local = int((uint(bitfieldExtract(0, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(0, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    }
    int _e289 = local;
    _group_0_binding_0_cs[uint(24)] = uint(_e289);
    values[0] = int((uint(bitfieldExtract(2, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    values[1] = int((uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(4, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u)))))));
    int _e321 = values[0];
    int _e322 = values[1];
    _group_0_binding_0_cs[uint(25)] = uint((_e321 + _e322));
    Count = 2;
    scratch = int[2](0, 0);
    int _e334 = Count;
    int _e335 = scratch[0];
    _group_0_binding_0_cs[uint(26)] = uint((_e334 + _e335));
    counter = 2;
    int _e343 = counter;
    counter = (_e343 + 1);
    int _e346 = counter;
    counter = (_e346 + 1);
    _group_0_binding_0_cs[uint(27)] = uint(int((uint(bitfieldExtract(_e343, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(_e346, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
    int _e361 = counter;
    _group_0_binding_0_cs[uint(28)] = uint(_e361);
    total = 0;
    {
        index = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e387 = index;
                index = (_e387 + 1);
            }
            loop_init = false;
            int _e370 = index;
            if ((_e370 < 3)) {
            } else {
                break;
            }
            int _e373 = index;
            int _e385 = total;
            total = (_e385 + int((uint(bitfieldExtract((_e373 + 1), int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(2, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
        }
    }
    int _e390 = total;
    _group_0_binding_0_cs[uint(29)] = uint(_e390);
    {
        local_2 = uint(30);
        uint _e401 = local_2;
        local_3 = _e401;
        uint _e403 = local_3;
        _group_0_binding_0_cs[_e403] = uint(int(9.75));
    }
    _group_0_binding_0_cs[uint(31)] = uint(int((uint(bitfieldExtract(16777215, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))) * uint(bitfieldExtract(3, int(min(0u, 32u)), int(min(24u, 32u - min(0u, 32u))))))));
}

