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
    float scale_1 = 0.0;
    int offset_1 = 0;
    value_2 = value_1;
    scale_1 = scale;
    offset_1 = offset;
    float _e6 = scale_1;
    float _e7 = value_2;
    value_2 = (_e7 * _e6);
    float _e9 = value_2;
    int _e10 = offset_1;
    return (_e9 + float(_e10));
}

bool nonnegative(int value_3) {
    int value_4 = 0;
    value_4 = value_3;
    int _e3 = value_4;
    return (_e3 >= 0);
}

uint sum_steps(uint count, bool include_even) {
    uint count_1 = 0u;
    bool include_even_1 = false;
    uint total = 0u;
    uint i_1 = 0u;
    bool local_41 = false;
    count_1 = count;
    include_even_1 = include_even;
    total = 0u;
    {
        i_1 = 0u;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e11 = i_1;
                i_1 = (_e11 + uint(1));
            }
            loop_init = false;
            uint _e8 = i_1;
            uint _e9 = count_1;
            if ((_e8 < _e9)) {
            } else {
                break;
            }
            bool _e15 = include_even_1;
            local_41 = _e15;
            if (_e15) {
            } else {
                uint _e18 = i_1;
                local_41 = ((_e18 - 2u * (_e18 / 2u)) != 0u);
            }
            bool _e22 = local_41;
            if (_e22) {
                uint _e23 = i_1;
                uint _e24 = total;
                total = (_e24 + _e23);
            }
        }
    }
    uint _e26 = total;
    return _e26;
}

int choose(int value_5) {
    int value_6 = 0;
    value_6 = value_5;
    int _e2 = value_6;
    bool _e3 = nonnegative(_e2);
    if (_e3) {
        int _e4 = value_6;
        float _e8 = affine(float(_e4), 2.0, 1);
        return int(_e8);
    }
    int _e10 = value_6;
    return -(_e10);
}

int pair(int a, int b) {
    int a_1 = 0;
    int b_1 = 0;
    a_1 = a;
    b_1 = b;
    int _e5 = a_1;
    int _e7 = b_1;
    return ((_e5 * 10) + _e7);
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    uint n = 0u;
    uint i = 0u;
    uint base = 0u;
    int value = 0;
    int argument = 0;
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
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    local = 0u;
    uint _e6 = _group_0_binding_1_cs.value;
    n = _e6;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e14 = i;
    uint _e15 = n;
    if ((_e14 < _e15)) {
        uint _e17 = i;
        base = (_e17 * 10u);
        uint _e21 = i;
        value = (int(_e21) - 35);
        argument = 3;
        int _e28 = value;
        int _e29 = choose(_e28);
        uint _e30 = local;
        local_1 = _e30;
        uint _e32 = local_1;
        local_2 = uint(_e32);
        uint _e35 = base;
        local_3 = uint(_e35);
        uint _e39 = local_2;
        uint _e40 = local_3;
        local_31 = uint((_e39 + _e40));
        uint _e44 = local_31;
        _group_0_binding_0_cs[_e44] = _e29;
        int _e46 = value;
        float _e50 = affine(float(_e46), 1.5, 2);
        uint _e51 = local;
        local_4 = _e51;
        uint _e53 = local_4;
        local_5 = uint(_e53);
        uint _e56 = base;
        local_6 = uint((_e56 + 1u));
        uint _e62 = local_5;
        uint _e63 = local_6;
        local_32 = uint((_e62 + _e63));
        uint _e67 = local_32;
        _group_0_binding_0_cs[_e67] = int(_e50);
        uint _e72 = sum_steps(uint(5), true);
        uint _e73 = local;
        local_7 = _e73;
        uint _e75 = local_7;
        local_8 = uint(_e75);
        uint _e78 = base;
        local_9 = uint((_e78 + 2u));
        uint _e84 = local_8;
        uint _e85 = local_9;
        local_33 = uint((_e84 + _e85));
        uint _e89 = local_33;
        _group_0_binding_0_cs[_e89] = int(_e72);
        uint _e95 = sum_steps(5u, (0 != 0));
        uint _e96 = local;
        local_10 = _e96;
        uint _e98 = local_10;
        local_11 = uint(_e98);
        uint _e101 = base;
        local_12 = uint((_e101 + 3u));
        uint _e107 = local_11;
        uint _e108 = local_12;
        local_34 = uint((_e107 + _e108));
        uint _e112 = local_34;
        _group_0_binding_0_cs[_e112] = int(_e95);
        int _e114 = value;
        float _e120 = affine(float(_e114), float(2u), int(true));
        uint _e121 = local;
        local_13 = _e121;
        uint _e123 = local_13;
        local_14 = uint(_e123);
        uint _e126 = base;
        local_15 = uint((_e126 + 4u));
        uint _e132 = local_14;
        uint _e133 = local_15;
        local_35 = uint((_e132 + _e133));
        uint _e137 = local_35;
        _group_0_binding_0_cs[_e137] = int(_e120);
        int _e139 = value;
        uint _e140 = local;
        local_16 = _e140;
        uint _e142 = local_16;
        local_17 = uint(_e142);
        uint _e145 = base;
        local_18 = uint((_e145 + 5u));
        uint _e150 = local_17;
        uint _e151 = local_18;
        local_36 = uint((_e150 + _e151));
        uint _e155 = local_36;
        _group_0_binding_0_cs[_e155] = _e139;
        int _e157 = value;
        int _e158 = choose(_e157);
        int _e159 = value;
        int _e162 = choose((_e159 + 1));
        uint _e164 = local;
        local_19 = _e164;
        uint _e166 = local_19;
        local_20 = uint(_e166);
        uint _e169 = base;
        local_21 = uint((_e169 + 6u));
        uint _e174 = local_20;
        uint _e175 = local_21;
        local_37 = uint((_e174 + _e175));
        uint _e179 = local_37;
        _group_0_binding_0_cs[_e179] = (_e158 + _e162);
        int _e181 = value;
        bool _e182 = nonnegative(_e181);
        uint _e183 = local;
        local_22 = _e183;
        uint _e185 = local_22;
        local_23 = uint(_e185);
        uint _e188 = base;
        local_24 = uint((_e188 + 7u));
        uint _e194 = local_23;
        uint _e195 = local_24;
        local_38 = uint((_e194 + _e195));
        uint _e199 = local_38;
        _group_0_binding_0_cs[_e199] = int(_e182);
        int _e201 = argument;
        int _e202 = argument;
        argument = (_e202 + 1);
        int _e205 = pair(_e201, _e202);
        uint _e206 = local;
        local_25 = _e206;
        uint _e208 = local_25;
        local_26 = uint(_e208);
        uint _e211 = base;
        local_27 = uint((_e211 + 8u));
        uint _e216 = local_26;
        uint _e217 = local_27;
        local_39 = uint((_e216 + _e217));
        uint _e221 = local_39;
        _group_0_binding_0_cs[_e221] = _e205;
        int _e223 = argument;
        uint _e224 = local;
        local_28 = _e224;
        uint _e226 = local_28;
        local_29 = uint(_e226);
        uint _e229 = base;
        local_30 = uint((_e229 + 9u));
        uint _e234 = local_29;
        uint _e235 = local_30;
        local_40 = uint((_e234 + _e235));
        uint _e239 = local_40;
        _group_0_binding_0_cs[_e239] = _e223;
    }
}

