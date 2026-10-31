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
        local = _e22;
        uint _e24 = local;
        local_10 = _e24;
        uint _e26 = local_10;
        _group_0_binding_0_cs[_e26] = _e21;
        int _e29 = value;
        float _e33 = affine(float(_e29), 1.5, 2);
        uint _e34 = base;
        local_1 = uint((_e34 + 1u));
        uint _e40 = local_1;
        local_11 = _e40;
        uint _e42 = local_11;
        _group_0_binding_0_cs[_e42] = int(_e33);
        uint _e47 = sum_steps(uint(5), true);
        uint _e48 = base;
        local_2 = uint((_e48 + 2u));
        uint _e54 = local_2;
        local_12 = _e54;
        uint _e56 = local_12;
        _group_0_binding_0_cs[_e56] = int(_e47);
        uint _e62 = sum_steps(5u, (0 != 0));
        uint _e63 = base;
        local_3 = uint((_e63 + 3u));
        uint _e69 = local_3;
        local_13 = _e69;
        uint _e71 = local_13;
        _group_0_binding_0_cs[_e71] = int(_e62);
        int _e73 = value;
        float _e79 = affine(float(_e73), float(2u), int(true));
        uint _e80 = base;
        local_4 = uint((_e80 + 4u));
        uint _e86 = local_4;
        local_14 = _e86;
        uint _e88 = local_14;
        _group_0_binding_0_cs[_e88] = int(_e79);
        int _e90 = value;
        uint _e91 = base;
        local_5 = uint((_e91 + 5u));
        uint _e96 = local_5;
        local_15 = _e96;
        uint _e98 = local_15;
        _group_0_binding_0_cs[_e98] = _e90;
        int _e100 = value;
        int _e101 = choose(_e100);
        int _e102 = value;
        int _e105 = choose((_e102 + 1));
        uint _e107 = base;
        local_6 = uint((_e107 + 6u));
        uint _e112 = local_6;
        local_16 = _e112;
        uint _e114 = local_16;
        _group_0_binding_0_cs[_e114] = (_e101 + _e105);
        int _e116 = value;
        bool _e117 = nonnegative(_e116);
        uint _e118 = base;
        local_7 = uint((_e118 + 7u));
        uint _e124 = local_7;
        local_17 = _e124;
        uint _e126 = local_17;
        _group_0_binding_0_cs[_e126] = int(_e117);
        int _e128 = argument;
        int _e129 = argument;
        argument = (_e129 + 1);
        int _e132 = pair(_e128, _e129);
        uint _e133 = base;
        local_8 = uint((_e133 + 8u));
        uint _e138 = local_8;
        local_18 = _e138;
        uint _e140 = local_18;
        _group_0_binding_0_cs[_e140] = _e132;
        int _e142 = argument;
        uint _e143 = base;
        local_9 = uint((_e143 + 9u));
        uint _e148 = local_9;
        local_19 = _e148;
        uint _e150 = local_19;
        _group_0_binding_0_cs[_e150] = _e142;
    }
}

