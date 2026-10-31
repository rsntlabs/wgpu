struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
cbuffer n : register(b1) { type_5 n; }

float affine(float value_1, float scale, int offset)
{
    float value_2 = (float)0;

    value_2 = value_1;
    float _e4 = value_2;
    value_2 = (_e4 * scale);
    float _e6 = value_2;
    return (_e6 + float(offset));
}

bool nonnegative(int value_3)
{
    return (value_3 >= int(0));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

uint sum_steps(uint count, bool include_even)
{
    uint total = (uint)0;
    uint i = (uint)0;
    bool local_50 = (bool)0;

    total = 0u;
    {
        i = 0u;
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e18 = i;
                i = (_e18 + uint(int(1)));
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
                local_50 = (naga_mod(_e9, 2u) != 0u);
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

int naga_neg(int val) {
    return asint(-asuint(val));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int choose(int value_4)
{
    const bool _e1 = nonnegative(value_4);
    if (_e1) {
        const float _e5 = affine(float(value_4), 2.0, int(1));
        return naga_f2i32(_e5);
    }
    return naga_neg(value_4);
}

int pair(int a, int b)
{
    return asint(asuint(asint(asuint(a) * asuint(int(10)))) + asuint(b));
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(64, 1, 1)]
void device_functions(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint out_[2] = (uint[2])0;
    uint base = (uint)0;
    int value = (int)0;
    int argument = (int)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23[2] = (uint[2])0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29[2] = (uint[2])0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32[2] = (uint[2])0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35[2] = (uint[2])0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38[2] = (uint[2])0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41[2] = (uint[2])0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44[2] = (uint[2])0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47[2] = (uint[2])0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    uint n_1 = n.value;
    uint i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i_1 < n_1)) {
        base = (i_1 * 10u);
        value = asint(asuint(int(i_1)) - asuint(int(35)));
        argument = int(3);
        int _e26 = value;
        const int _e27 = choose(_e26);
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
        out_1.Store(_e49*4, asuint(_e27));
        int _e52 = value;
        const float _e56 = affine(float(_e52), 1.5, int(2));
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
        out_1.Store(_e80*4, asuint(naga_f2i32(_e56)));
        const uint _e85 = sum_steps(uint(int(5)), true);
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
        out_1.Store(_e109*4, asuint(int(_e85)));
        const uint _e115 = sum_steps(5u, (int(0) != int(0)));
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
        out_1.Store(_e139*4, asuint(int(_e115)));
        int _e141 = value;
        const float _e147 = affine(float(_e141), float(2u), int(true));
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
        out_1.Store(_e171*4, asuint(naga_f2i32(_e147)));
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
        out_1.Store(_e196*4, asuint(_e173));
        int _e198 = value;
        const int _e199 = choose(_e198);
        int _e200 = value;
        const int _e203 = choose(asint(asuint(_e200) + asuint(int(1))));
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
        out_1.Store(_e227*4, asuint(asint(asuint(_e199) + asuint(_e203))));
        int _e229 = value;
        const bool _e230 = nonnegative(_e229);
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
        out_1.Store(_e254*4, asuint(int(_e230)));
        int _e256 = argument;
        int _e257 = argument;
        argument = asint(asuint(_e257) + asuint(int(1)));
        const int _e260 = pair(_e256, _e257);
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
        out_1.Store(_e283*4, asuint(_e260));
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
        out_1.Store(_e308*4, asuint(_e285));
    }
}
