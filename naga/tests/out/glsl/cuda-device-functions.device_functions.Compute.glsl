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
    bool local_50 = false;
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
            local_50 = include_even;
            if (include_even) {
            } else {
                uint _e9 = i;
                local_50 = ((_e9 - 2u * (_e9 / 2u)) != 0u);
            }
            bool _e14 = local_50;
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
    uint out_[2] = uint[2](0u, 0u);
    uint base = 0u;
    int value = 0;
    int argument = 0;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    uint local_14[2] = uint[2](0u, 0u);
    uint local_15 = 0u;
    uint local_16[2] = uint[2](0u, 0u);
    uint local_17 = 0u;
    uint local_18[2] = uint[2](0u, 0u);
    uint local_19 = 0u;
    uint local_20[2] = uint[2](0u, 0u);
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23[2] = uint[2](0u, 0u);
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26[2] = uint[2](0u, 0u);
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29[2] = uint[2](0u, 0u);
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32[2] = uint[2](0u, 0u);
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35[2] = uint[2](0u, 0u);
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38[2] = uint[2](0u, 0u);
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41[2] = uint[2](0u, 0u);
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44[2] = uint[2](0u, 0u);
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47[2] = uint[2](0u, 0u);
    uint local_48 = 0u;
    uint local_49 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    uint n_1 = _group_0_binding_1_cs.value;
    uint i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i_1 < n_1)) {
        base = (i_1 * 10u);
        value = (int(i_1) - 35);
        argument = 3;
        int _e26 = value;
        int _e27 = choose(_e26);
        uint _e29[2] = out_;
        local = _e29;
        uint _e31 = base;
        local_1 = uint(_e31);
        uint _e34[2] = local;
        local_20 = _e34;
        uint _e36 = local_1;
        uint _e38 = local_20[1];
        local_20[1] = (_e38 + _e36);
        uint _e42 = local_20[0];
        local_21 = uint(_e42);
        uint _e46 = local_20[1];
        local_22 = uint(_e46);
        uint _e49 = local_22;
        _group_0_binding_0_cs[_e49] = _e27;
        int _e52 = value;
        float _e56 = affine(float(_e52), 1.5, 2);
        uint _e57[2] = out_;
        local_2 = _e57;
        uint _e59 = base;
        local_3 = uint((_e59 + 1u));
        uint _e65[2] = local_2;
        local_23 = _e65;
        uint _e67 = local_3;
        uint _e69 = local_23[1];
        local_23[1] = (_e69 + _e67);
        uint _e73 = local_23[0];
        local_24 = uint(_e73);
        uint _e77 = local_23[1];
        local_25 = uint(_e77);
        uint _e80 = local_25;
        _group_0_binding_0_cs[_e80] = int(_e56);
        uint _e85 = sum_steps(uint(5), true);
        uint _e86[2] = out_;
        local_4 = _e86;
        uint _e88 = base;
        local_5 = uint((_e88 + 2u));
        uint _e94[2] = local_4;
        local_26 = _e94;
        uint _e96 = local_5;
        uint _e98 = local_26[1];
        local_26[1] = (_e98 + _e96);
        uint _e102 = local_26[0];
        local_27 = uint(_e102);
        uint _e106 = local_26[1];
        local_28 = uint(_e106);
        uint _e109 = local_28;
        _group_0_binding_0_cs[_e109] = int(_e85);
        uint _e115 = sum_steps(5u, (0 != 0));
        uint _e116[2] = out_;
        local_6 = _e116;
        uint _e118 = base;
        local_7 = uint((_e118 + 3u));
        uint _e124[2] = local_6;
        local_29 = _e124;
        uint _e126 = local_7;
        uint _e128 = local_29[1];
        local_29[1] = (_e128 + _e126);
        uint _e132 = local_29[0];
        local_30 = uint(_e132);
        uint _e136 = local_29[1];
        local_31 = uint(_e136);
        uint _e139 = local_31;
        _group_0_binding_0_cs[_e139] = int(_e115);
        int _e141 = value;
        float _e147 = affine(float(_e141), float(2u), int(true));
        uint _e148[2] = out_;
        local_8 = _e148;
        uint _e150 = base;
        local_9 = uint((_e150 + 4u));
        uint _e156[2] = local_8;
        local_32 = _e156;
        uint _e158 = local_9;
        uint _e160 = local_32[1];
        local_32[1] = (_e160 + _e158);
        uint _e164 = local_32[0];
        local_33 = uint(_e164);
        uint _e168 = local_32[1];
        local_34 = uint(_e168);
        uint _e171 = local_34;
        _group_0_binding_0_cs[_e171] = int(_e147);
        int _e173 = value;
        uint _e174[2] = out_;
        local_10 = _e174;
        uint _e176 = base;
        local_11 = uint((_e176 + 5u));
        uint _e181[2] = local_10;
        local_35 = _e181;
        uint _e183 = local_11;
        uint _e185 = local_35[1];
        local_35[1] = (_e185 + _e183);
        uint _e189 = local_35[0];
        local_36 = uint(_e189);
        uint _e193 = local_35[1];
        local_37 = uint(_e193);
        uint _e196 = local_37;
        _group_0_binding_0_cs[_e196] = _e173;
        int _e198 = value;
        int _e199 = choose(_e198);
        int _e200 = value;
        int _e203 = choose((_e200 + 1));
        uint _e205[2] = out_;
        local_12 = _e205;
        uint _e207 = base;
        local_13 = uint((_e207 + 6u));
        uint _e212[2] = local_12;
        local_38 = _e212;
        uint _e214 = local_13;
        uint _e216 = local_38[1];
        local_38[1] = (_e216 + _e214);
        uint _e220 = local_38[0];
        local_39 = uint(_e220);
        uint _e224 = local_38[1];
        local_40 = uint(_e224);
        uint _e227 = local_40;
        _group_0_binding_0_cs[_e227] = (_e199 + _e203);
        int _e229 = value;
        bool _e230 = nonnegative(_e229);
        uint _e231[2] = out_;
        local_14 = _e231;
        uint _e233 = base;
        local_15 = uint((_e233 + 7u));
        uint _e239[2] = local_14;
        local_41 = _e239;
        uint _e241 = local_15;
        uint _e243 = local_41[1];
        local_41[1] = (_e243 + _e241);
        uint _e247 = local_41[0];
        local_42 = uint(_e247);
        uint _e251 = local_41[1];
        local_43 = uint(_e251);
        uint _e254 = local_43;
        _group_0_binding_0_cs[_e254] = int(_e230);
        int _e256 = argument;
        int _e257 = argument;
        argument = (_e257 + 1);
        int _e260 = pair(_e256, _e257);
        uint _e261[2] = out_;
        local_16 = _e261;
        uint _e263 = base;
        local_17 = uint((_e263 + 8u));
        uint _e268[2] = local_16;
        local_44 = _e268;
        uint _e270 = local_17;
        uint _e272 = local_44[1];
        local_44[1] = (_e272 + _e270);
        uint _e276 = local_44[0];
        local_45 = uint(_e276);
        uint _e280 = local_44[1];
        local_46 = uint(_e280);
        uint _e283 = local_46;
        _group_0_binding_0_cs[_e283] = _e260;
        int _e285 = argument;
        uint _e286[2] = out_;
        local_18 = _e286;
        uint _e288 = base;
        local_19 = uint((_e288 + 9u));
        uint _e293[2] = local_18;
        local_47 = _e293;
        uint _e295 = local_19;
        uint _e297 = local_47[1];
        local_47[1] = (_e297 + _e295);
        uint _e301 = local_47[0];
        local_48 = uint(_e301);
        uint _e305 = local_47[1];
        local_49 = uint(_e305);
        uint _e308 = local_49;
        _group_0_binding_0_cs[_e308] = _e285;
    }
}

