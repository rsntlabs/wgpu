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
    bool local_50 = false;
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
            local_50 = _e15;
            if (_e15) {
            } else {
                uint _e18 = i_1;
                local_50 = ((_e18 - 2u * (_e18 / 2u)) != 0u);
            }
            bool _e22 = local_50;
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
    uint out_[2] = uint[2](0u, 0u);
    uint n = 0u;
    uint i = 0u;
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
    uint _e11 = _group_0_binding_1_cs.value;
    n = _e11;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e19 = i;
    uint _e20 = n;
    if ((_e19 < _e20)) {
        uint _e22 = i;
        base = (_e22 * 10u);
        uint _e26 = i;
        value = (int(_e26) - 35);
        argument = 3;
        int _e33 = value;
        int _e34 = choose(_e33);
        uint _e37[2] = out_;
        local = _e37;
        uint _e38 = base;
        local_1 = uint(_e38);
        uint _e42[2] = local;
        local_20 = _e42;
        uint _e43 = local_1;
        uint _e45 = local_20[1];
        local_20[1] = (_e45 + _e43);
        uint _e49 = local_20[0];
        local_21 = uint(_e49);
        uint _e53 = local_20[1];
        local_22 = uint(_e53);
        uint _e56 = local_22;
        _group_0_binding_0_cs[_e56] = _e34;
        int _e58 = value;
        float _e62 = affine(float(_e58), 1.5, 2);
        uint _e64[2] = out_;
        local_2 = _e64;
        uint _e65 = base;
        local_3 = uint((_e65 + 1u));
        uint _e72[2] = local_2;
        local_23 = _e72;
        uint _e73 = local_3;
        uint _e75 = local_23[1];
        local_23[1] = (_e75 + _e73);
        uint _e79 = local_23[0];
        local_24 = uint(_e79);
        uint _e83 = local_23[1];
        local_25 = uint(_e83);
        uint _e86 = local_25;
        _group_0_binding_0_cs[_e86] = int(_e62);
        uint _e91 = sum_steps(uint(5), true);
        uint _e93[2] = out_;
        local_4 = _e93;
        uint _e94 = base;
        local_5 = uint((_e94 + 2u));
        uint _e101[2] = local_4;
        local_26 = _e101;
        uint _e102 = local_5;
        uint _e104 = local_26[1];
        local_26[1] = (_e104 + _e102);
        uint _e108 = local_26[0];
        local_27 = uint(_e108);
        uint _e112 = local_26[1];
        local_28 = uint(_e112);
        uint _e115 = local_28;
        _group_0_binding_0_cs[_e115] = int(_e91);
        uint _e121 = sum_steps(5u, (0 != 0));
        uint _e123[2] = out_;
        local_6 = _e123;
        uint _e124 = base;
        local_7 = uint((_e124 + 3u));
        uint _e131[2] = local_6;
        local_29 = _e131;
        uint _e132 = local_7;
        uint _e134 = local_29[1];
        local_29[1] = (_e134 + _e132);
        uint _e138 = local_29[0];
        local_30 = uint(_e138);
        uint _e142 = local_29[1];
        local_31 = uint(_e142);
        uint _e145 = local_31;
        _group_0_binding_0_cs[_e145] = int(_e121);
        int _e147 = value;
        float _e153 = affine(float(_e147), float(2u), int(true));
        uint _e155[2] = out_;
        local_8 = _e155;
        uint _e156 = base;
        local_9 = uint((_e156 + 4u));
        uint _e163[2] = local_8;
        local_32 = _e163;
        uint _e164 = local_9;
        uint _e166 = local_32[1];
        local_32[1] = (_e166 + _e164);
        uint _e170 = local_32[0];
        local_33 = uint(_e170);
        uint _e174 = local_32[1];
        local_34 = uint(_e174);
        uint _e177 = local_34;
        _group_0_binding_0_cs[_e177] = int(_e153);
        int _e179 = value;
        uint _e181[2] = out_;
        local_10 = _e181;
        uint _e182 = base;
        local_11 = uint((_e182 + 5u));
        uint _e188[2] = local_10;
        local_35 = _e188;
        uint _e189 = local_11;
        uint _e191 = local_35[1];
        local_35[1] = (_e191 + _e189);
        uint _e195 = local_35[0];
        local_36 = uint(_e195);
        uint _e199 = local_35[1];
        local_37 = uint(_e199);
        uint _e202 = local_37;
        _group_0_binding_0_cs[_e202] = _e179;
        int _e204 = value;
        int _e205 = choose(_e204);
        int _e206 = value;
        int _e209 = choose((_e206 + 1));
        uint _e212[2] = out_;
        local_12 = _e212;
        uint _e213 = base;
        local_13 = uint((_e213 + 6u));
        uint _e219[2] = local_12;
        local_38 = _e219;
        uint _e220 = local_13;
        uint _e222 = local_38[1];
        local_38[1] = (_e222 + _e220);
        uint _e226 = local_38[0];
        local_39 = uint(_e226);
        uint _e230 = local_38[1];
        local_40 = uint(_e230);
        uint _e233 = local_40;
        _group_0_binding_0_cs[_e233] = (_e205 + _e209);
        int _e235 = value;
        bool _e236 = nonnegative(_e235);
        uint _e238[2] = out_;
        local_14 = _e238;
        uint _e239 = base;
        local_15 = uint((_e239 + 7u));
        uint _e246[2] = local_14;
        local_41 = _e246;
        uint _e247 = local_15;
        uint _e249 = local_41[1];
        local_41[1] = (_e249 + _e247);
        uint _e253 = local_41[0];
        local_42 = uint(_e253);
        uint _e257 = local_41[1];
        local_43 = uint(_e257);
        uint _e260 = local_43;
        _group_0_binding_0_cs[_e260] = int(_e236);
        int _e262 = argument;
        int _e263 = argument;
        argument = (_e263 + 1);
        int _e266 = pair(_e262, _e263);
        uint _e268[2] = out_;
        local_16 = _e268;
        uint _e269 = base;
        local_17 = uint((_e269 + 8u));
        uint _e275[2] = local_16;
        local_44 = _e275;
        uint _e276 = local_17;
        uint _e278 = local_44[1];
        local_44[1] = (_e278 + _e276);
        uint _e282 = local_44[0];
        local_45 = uint(_e282);
        uint _e286 = local_44[1];
        local_46 = uint(_e286);
        uint _e289 = local_46;
        _group_0_binding_0_cs[_e289] = _e266;
        int _e291 = argument;
        uint _e293[2] = out_;
        local_18 = _e293;
        uint _e294 = base;
        local_19 = uint((_e294 + 9u));
        uint _e300[2] = local_18;
        local_47 = _e300;
        uint _e301 = local_19;
        uint _e303 = local_47[1];
        local_47[1] = (_e303 + _e301);
        uint _e307 = local_47[0];
        local_48 = uint(_e307);
        uint _e311 = local_47[1];
        local_49 = uint(_e311);
        uint _e314 = local_49;
        _group_0_binding_0_cs[_e314] = _e291;
    }
}

