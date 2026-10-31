#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    uint value;
};
layout(std430) buffer type_4_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std140) uniform type_5_block_1Compute { type_5 _group_0_binding_1_cs; };


float affine(float value_1, float scale, int offset) {
    float value_2 = 0.0;
    value_2 = value_1;
    float _e4 = value_2;
    value_2 = (_e4 * scale);
    float _e6 = value_2;
    return (_e6 + float(offset));
}

bool nonnegative(int value_3) {
    return (value_3 >= 0);
}

uint sum_steps(uint count, bool include_even) {
    uint total = 0u;
    uint i = 0u;
    bool local_20 = false;
    total = 0u;
    {
        i = 0u;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e18 = i;
                i = (_e18 + uint(1));
            }
            loop_init = false;
            uint _e6 = i;
            if ((_e6 < count)) {
            } else {
                break;
            }
            local_20 = include_even;
            if (include_even) {
            } else {
                uint _e9 = i;
                local_20 = ((_e9 - 2u * (_e9 / 2u)) != 0u);
            }
            bool _e14 = local_20;
            if (_e14) {
                uint _e15 = i;
                uint _e16 = total;
                total = (_e16 + _e15);
            }
        }
    }
    uint _e22 = total;
    return _e22;
}

int choose(int value_4) {
    bool _e1 = nonnegative(value_4);
    if (_e1) {
        float _e5 = affine(float(value_4), 2.0, 1);
        return int(_e5);
    }
    return -(value_4);
}

int pair(int a, int b) {
    return ((a * 10) + b);
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint base = 0u;
    int value = 0;
    int argument = 0;
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
    uint n_1 = _group_0_binding_1_cs.value;
    uint i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i_1 < n_1)) {
        base = (i_1 * 10u);
        value = (int(i_1) - 35);
        argument = 3;
        int _e20 = value;
        int _e21 = choose(_e20);
        uint _e22 = base;
        local = uint(_e22);
        uint _e25 = local;
        local_10 = uint(_e25);
        uint _e28 = local_10;
        _group_0_binding_0_cs[_e28] = _e21;
        int _e31 = value;
        float _e35 = affine(float(_e31), 1.5, 2);
        uint _e36 = base;
        local_1 = uint((_e36 + 1u));
        uint _e42 = local_1;
        local_11 = uint(_e42);
        uint _e45 = local_11;
        _group_0_binding_0_cs[_e45] = int(_e35);
        uint _e50 = sum_steps(uint(5), true);
        uint _e51 = base;
        local_2 = uint((_e51 + 2u));
        uint _e57 = local_2;
        local_12 = uint(_e57);
        uint _e60 = local_12;
        _group_0_binding_0_cs[_e60] = int(_e50);
        uint _e66 = sum_steps(5u, (0 != 0));
        uint _e67 = base;
        local_3 = uint((_e67 + 3u));
        uint _e73 = local_3;
        local_13 = uint(_e73);
        uint _e76 = local_13;
        _group_0_binding_0_cs[_e76] = int(_e66);
        int _e78 = value;
        float _e84 = affine(float(_e78), float(2u), int(true));
        uint _e85 = base;
        local_4 = uint((_e85 + 4u));
        uint _e91 = local_4;
        local_14 = uint(_e91);
        uint _e94 = local_14;
        _group_0_binding_0_cs[_e94] = int(_e84);
        int _e96 = value;
        uint _e97 = base;
        local_5 = uint((_e97 + 5u));
        uint _e102 = local_5;
        local_15 = uint(_e102);
        uint _e105 = local_15;
        _group_0_binding_0_cs[_e105] = _e96;
        int _e107 = value;
        int _e108 = choose(_e107);
        int _e109 = value;
        int _e112 = choose((_e109 + 1));
        uint _e114 = base;
        local_6 = uint((_e114 + 6u));
        uint _e119 = local_6;
        local_16 = uint(_e119);
        uint _e122 = local_16;
        _group_0_binding_0_cs[_e122] = (_e108 + _e112);
        int _e124 = value;
        bool _e125 = nonnegative(_e124);
        uint _e126 = base;
        local_7 = uint((_e126 + 7u));
        uint _e132 = local_7;
        local_17 = uint(_e132);
        uint _e135 = local_17;
        _group_0_binding_0_cs[_e135] = int(_e125);
        int _e137 = argument;
        int _e138 = argument;
        argument = (_e138 + 1);
        int _e141 = pair(_e137, _e138);
        uint _e142 = base;
        local_8 = uint((_e142 + 8u));
        uint _e147 = local_8;
        local_18 = uint(_e147);
        uint _e150 = local_18;
        _group_0_binding_0_cs[_e150] = _e141;
        int _e152 = argument;
        uint _e153 = base;
        local_9 = uint((_e153 + 9u));
        uint _e158 = local_9;
        local_19 = uint(_e158);
        uint _e161 = local_19;
        _group_0_binding_0_cs[_e161] = _e152;
    }
}

