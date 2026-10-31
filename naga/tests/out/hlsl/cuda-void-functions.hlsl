struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
cbuffer n_1 : register(b1) { type_5 n_1; }

int next_value(int value_1)
{
    int value_2 = (int)0;

    value_2 = value_1;
    int _e3 = value_2;
    return asint(asuint(_e3) + asuint(int(1)));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

void consume(bool stop, int value_3, uint count, float scale)
{
    bool stop_1 = (bool)0;
    int value_4 = (int)0;
    uint count_1 = (uint)0;
    float scale_1 = (float)0;

    stop_1 = stop;
    value_4 = value_3;
    count_1 = count;
    scale_1 = scale;
    uint _e8 = count_1;
    int _e9 = value_4;
    value_4 = int((uint(_e9) + _e8));
    bool _e13 = stop_1;
    if (_e13) {
        return;
    }
    float _e14 = scale_1;
    int _e15 = value_4;
    value_4 = naga_f2i32((float(_e15) * _e14));
    return;
}

void forward(bool stop_2, int value_5)
{
    bool stop_3 = (bool)0;
    int value_6 = (int)0;

    stop_3 = stop_2;
    value_6 = value_5;
    bool _e4 = stop_3;
    int _e5 = value_6;
    const int _e6 = next_value(_e5);
    consume(_e4, _e6, 2u, 0.5);
    return;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(64, 1, 1)]
void void_functions(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint local[2] = (uint[2])0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint base = (uint)0;
    int value = (int)0;
    uint local_1[2] = (uint[2])0;
    uint local_2 = (uint)0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    int iterations = (int)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13[2] = (uint[2])0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19[2] = (uint[2])0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25[2] = (uint[2])0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28[2] = (uint[2])0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;

    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
    uint _e11 = n_1.value;
    n = _e11;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e19 = i;
    uint _e20 = n;
    if ((_e19 < _e20)) {
        uint _e22 = i;
        base = (_e22 * 6u);
        value = int(2);
        int _e28 = value;
        value = asint(asuint(_e28) + asuint(int(1)));
        consume(false, _e28, 1u, 1.5);
        int _e34 = value;
        uint _e37[2] = local;
        local_1 = _e37;
        uint _e38 = base;
        local_2 = uint(_e38);
        uint _e42[2] = local_1;
        local_13 = _e42;
        uint _e43 = local_2;
        uint _e45 = local_13[1];
        local_13[1] = (_e45 + _e43);
        uint _e49 = local_13[0];
        local_14 = uint(_e49);
        uint _e53 = local_13[1];
        local_15 = uint(_e53);
        uint _e56 = local_15;
        out_.Store(_e56*4, asuint(_e34));
        int _e58 = value;
        value = asint(asuint(_e58) + asuint(int(1)));
        const int _e61 = next_value(_e58);
        consume(true, _e61, 2u, 0.5);
        int _e65 = value;
        uint _e67[2] = local;
        local_3 = _e67;
        uint _e68 = base;
        local_4 = uint((_e68 + 1u));
        uint _e74[2] = local_3;
        local_16 = _e74;
        uint _e75 = local_4;
        uint _e77 = local_16[1];
        local_16[1] = (_e77 + _e75);
        uint _e81 = local_16[0];
        local_17 = uint(_e81);
        uint _e85 = local_16[1];
        local_18 = uint(_e85);
        uint _e88 = local_18;
        out_.Store(_e88*4, asuint(_e65));
        uint _e90 = i;
        int _e95 = value;
        value = asint(asuint(_e95) + asuint(int(1)));
        forward((naga_mod(_e90, 2u) == 0u), _e95);
        int _e98 = value;
        uint _e100[2] = local;
        local_5 = _e100;
        uint _e101 = base;
        local_6 = uint((_e101 + 2u));
        uint _e107[2] = local_5;
        local_19 = _e107;
        uint _e108 = local_6;
        uint _e110 = local_19[1];
        local_19[1] = (_e110 + _e108);
        uint _e114 = local_19[0];
        local_20 = uint(_e114);
        uint _e118 = local_19[1];
        local_21 = uint(_e118);
        uint _e121 = local_21;
        out_.Store(_e121*4, asuint(_e98));
        iterations = int(0);
        {
            int _e125 = value;
            value = asint(asuint(_e125) + asuint(int(1)));
            consume((int(0) != int(0)), _e125, uint(int(0)), float(1u));
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e144 = value;
                    value = asint(asuint(_e144) + asuint(int(1)));
                    int _e147 = value;
                    consume(false, _e147, 0u, 1.0);
                }
                loop_init = false;
                int _e135 = iterations;
                if ((_e135 < int(3))) {
                } else {
                    break;
                }
                int _e138 = iterations;
                iterations = asint(asuint(_e138) + asuint(int(1)));
                int _e141 = iterations;
                if ((_e141 == int(1))) {
                    continue;
                }
            }
        }
        int _e151 = value;
        uint _e153[2] = local;
        local_7 = _e153;
        uint _e154 = base;
        local_8 = uint((_e154 + 3u));
        uint _e160[2] = local_7;
        local_22 = _e160;
        uint _e161 = local_8;
        uint _e163 = local_22[1];
        local_22[1] = (_e163 + _e161);
        uint _e167 = local_22[0];
        local_23 = uint(_e167);
        uint _e171 = local_22[1];
        local_24 = uint(_e171);
        uint _e174 = local_24;
        out_.Store(_e174*4, asuint(_e151));
        int _e176 = iterations;
        uint _e178[2] = local;
        local_9 = _e178;
        uint _e179 = base;
        local_10 = uint((_e179 + 4u));
        uint _e185[2] = local_9;
        local_25 = _e185;
        uint _e186 = local_10;
        uint _e188 = local_25[1];
        local_25[1] = (_e188 + _e186);
        uint _e192 = local_25[0];
        local_26 = uint(_e192);
        uint _e196 = local_25[1];
        local_27 = uint(_e196);
        uint _e199 = local_27;
        out_.Store(_e199*4, asuint(_e176));
        int _e201 = value;
        const int _e202 = next_value(_e201);
        uint _e204[2] = local;
        local_11 = _e204;
        uint _e205 = base;
        local_12 = uint((_e205 + 5u));
        uint _e211[2] = local_11;
        local_28 = _e211;
        uint _e212 = local_12;
        uint _e214 = local_28[1];
        local_28[1] = (_e214 + _e212);
        uint _e218 = local_28[0];
        local_29 = uint(_e218);
        uint _e222 = local_28[1];
        local_30 = uint(_e222);
        uint _e225 = local_30;
        out_.Store(_e225*4, asuint(_e202));
    }
}
