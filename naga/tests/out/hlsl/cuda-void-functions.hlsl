struct type_5 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
cbuffer n : register(b1) { type_5 n; }

int next_value(int value_1)
{
    return asint(asuint(value_1) + asuint(int(1)));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

void consume(bool stop, int value_2, uint count, float scale)
{
    int value_3 = (int)0;

    value_3 = value_2;
    int _e5 = value_3;
    value_3 = int((uint(_e5) + count));
    if (stop) {
        return;
    }
    int _e9 = value_3;
    value_3 = naga_f2i32((float(_e9) * scale));
    return;
}

void forward(bool stop_1, int value_4)
{
    const int _e2 = next_value(value_4);
    consume(stop_1, _e2, 2u, 0.5);
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
    uint out_[2] = (uint[2])0;
    uint base = (uint)0;
    int value = (int)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    int iterations = (int)0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15[2] = (uint[2])0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21[2] = (uint[2])0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27[2] = (uint[2])0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 6u);
        value = int(2);
        int _e22 = value;
        value = asint(asuint(_e22) + asuint(int(1)));
        consume(false, _e22, 1u, 1.5);
        int _e28 = value;
        uint _e30[2] = out_;
        local = _e30;
        uint _e32 = base;
        local_1 = uint(_e32);
        uint _e35[2] = local;
        local_12 = _e35;
        uint _e37 = local_1;
        uint _e39 = local_12[1];
        local_12[1] = (_e39 + _e37);
        uint _e43 = local_12[0];
        local_13 = uint(_e43);
        uint _e47 = local_12[1];
        local_14 = uint(_e47);
        uint _e50 = local_14;
        out_1.Store(_e50*4, asuint(_e28));
        int _e53 = value;
        value = asint(asuint(_e53) + asuint(int(1)));
        const int _e56 = next_value(_e53);
        consume(true, _e56, 2u, 0.5);
        int _e60 = value;
        uint _e61[2] = out_;
        local_2 = _e61;
        uint _e63 = base;
        local_3 = uint((_e63 + 1u));
        uint _e68[2] = local_2;
        local_15 = _e68;
        uint _e70 = local_3;
        uint _e72 = local_15[1];
        local_15[1] = (_e72 + _e70);
        uint _e76 = local_15[0];
        local_16 = uint(_e76);
        uint _e80 = local_15[1];
        local_17 = uint(_e80);
        uint _e83 = local_17;
        out_1.Store(_e83*4, asuint(_e60));
        int _e89 = value;
        value = asint(asuint(_e89) + asuint(int(1)));
        forward((naga_mod(i, 2u) == 0u), _e89);
        int _e92 = value;
        uint _e93[2] = out_;
        local_4 = _e93;
        uint _e95 = base;
        local_5 = uint((_e95 + 2u));
        uint _e100[2] = local_4;
        local_18 = _e100;
        uint _e102 = local_5;
        uint _e104 = local_18[1];
        local_18[1] = (_e104 + _e102);
        uint _e108 = local_18[0];
        local_19 = uint(_e108);
        uint _e112 = local_18[1];
        local_20 = uint(_e112);
        uint _e115 = local_20;
        out_1.Store(_e115*4, asuint(_e92));
        iterations = int(0);
        {
            int _e119 = value;
            value = asint(asuint(_e119) + asuint(int(1)));
            consume((int(0) != int(0)), _e119, uint(int(0)), float(1u));
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e138 = value;
                    value = asint(asuint(_e138) + asuint(int(1)));
                    int _e141 = value;
                    consume(false, _e141, 0u, 1.0);
                }
                loop_init = false;
                int _e129 = iterations;
                if ((_e129 < int(3))) {
                } else {
                    break;
                }
                int _e132 = iterations;
                iterations = asint(asuint(_e132) + asuint(int(1)));
                int _e135 = iterations;
                if ((_e135 == int(1))) {
                    continue;
                }
            }
        }
        int _e145 = value;
        uint _e146[2] = out_;
        local_6 = _e146;
        uint _e148 = base;
        local_7 = uint((_e148 + 3u));
        uint _e153[2] = local_6;
        local_21 = _e153;
        uint _e155 = local_7;
        uint _e157 = local_21[1];
        local_21[1] = (_e157 + _e155);
        uint _e161 = local_21[0];
        local_22 = uint(_e161);
        uint _e165 = local_21[1];
        local_23 = uint(_e165);
        uint _e168 = local_23;
        out_1.Store(_e168*4, asuint(_e145));
        int _e170 = iterations;
        uint _e171[2] = out_;
        local_8 = _e171;
        uint _e173 = base;
        local_9 = uint((_e173 + 4u));
        uint _e178[2] = local_8;
        local_24 = _e178;
        uint _e180 = local_9;
        uint _e182 = local_24[1];
        local_24[1] = (_e182 + _e180);
        uint _e186 = local_24[0];
        local_25 = uint(_e186);
        uint _e190 = local_24[1];
        local_26 = uint(_e190);
        uint _e193 = local_26;
        out_1.Store(_e193*4, asuint(_e170));
        int _e195 = value;
        const int _e196 = next_value(_e195);
        uint _e197[2] = out_;
        local_10 = _e197;
        uint _e199 = base;
        local_11 = uint((_e199 + 5u));
        uint _e204[2] = local_10;
        local_27 = _e204;
        uint _e206 = local_11;
        uint _e208 = local_27[1];
        local_27[1] = (_e208 + _e206);
        uint _e212 = local_27[0];
        local_28 = uint(_e212);
        uint _e216 = local_27[1];
        local_29 = uint(_e216);
        uint _e219 = local_29;
        out_1.Store(_e219*4, asuint(_e196));
    }
}
