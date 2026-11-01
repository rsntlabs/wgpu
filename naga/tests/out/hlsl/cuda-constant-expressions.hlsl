struct float3_ {
    float x;
    float y;
    float z;
};

static const int Base_1 = int(2);
static const uint High = 2147483648u;
static const float Scale = 0.5;
static const int Second = int(3);
static const int After = int(4);

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer out_ : register(u1);

typedef int ret_ZeroValuearray3_int_[3];
ret_ZeroValuearray3_int_ ZeroValuearray3_int_() {
    return (int[3])0;
}

int accumulate(int runtime)
{
    int runtime_1 = (int)0;
    int Size_1 = (int)0;
    int local_12 = (int)0;
    int local_13[3] = (int[3])0;
    int total = (int)0;
    int i_1 = (int)0;

    runtime_1 = runtime;
    Size_1 = int(3);
    local_13 = ZeroValuearray3_int_();
    total = int(0);
    {
        i_1 = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e13 = i_1;
                i_1 = asint(asuint(_e13) + asuint(int(1)));
            }
            loop_init = false;
            int _e10 = i_1;
            int _e11 = Size_1;
            if ((_e10 < _e11)) {
            } else {
                break;
            }
            int _e18 = runtime_1;
            int _e19 = i_1;
            int _e16 = i_1;
            local_13[min(uint(_e16), 2u)] = asint(asuint(_e18) + asuint(_e19));
            int _e21 = i_1;
            int _e23 = local_13[min(uint(_e21), 2u)];
            int _e24 = total;
            total = asint(asuint(_e24) + asuint(_e23));
        }
    }
    int _e26 = total;
    return _e26;
}

typedef int ret_ZeroValuearray5_int_[5];
ret_ZeroValuearray5_int_ ZeroValuearray5_int_() {
    return (int[5])0;
}

typedef float3_ ret_ZeroValuearray2_float3__[2];
ret_ZeroValuearray2_float3__ ZeroValuearray2_float3__() {
    return (float3_[2])0;
}

typedef int ret_ZeroValuearray2_int_[2];
ret_ZeroValuearray2_int_ ZeroValuearray2_int_() {
    return (int[2])0;
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

[numthreads(1, 1, 1)]
void constant_expressions()
{
    int Chosen = (int)0;
    int local = (int)0;
    int Size = (int)0;
    int values[5] = (int[5])0;
    int SignedHigh = (int)0;
    uint local_1 = (uint)0;
    int Negative = (int)0;
    uint local_2 = (uint)0;
    uint All = (uint)0;
    uint Wrapped = (uint)0;
    uint local_3 = (uint)0;
    uint TruncatedZero = (uint)0;
    int Minimum = (int)0;
    uint Large = (uint)0;
    bool Ready = (bool)0;
    int Comma = (int)0;
    int Lazy = (int)0;
    int local_4 = (int)0;
    bool Skipped = (bool)0;
    bool local_5 = (bool)0;
    bool Yes = (bool)0;
    bool local_6 = (bool)0;
    int VectorCount = (int)0;
    float3_ vectors[2] = (float3_[2])0;
    int Base[2] = (int[2])0;
    uint local_7 = (uint)0;
    int i = (int)0;
    int Count = (int)0;
    int scratch[3] = (int[3])0;
    uint local_8 = (uint)0;
    int Safe = (int)0;
    int local_9 = (int)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;

    int runtime_2 = asint(input.Load(uint(int(0))*4));
    Chosen = int(3);
    Size = int(4);
    values = ZeroValuearray5_int_();
    values[int(0)] = runtime_2;
    int _e16 = asint(input.Load(uint(int(1))*4));
    int _e17 = Size;
    values[min(uint(_e17), 4u)] = _e16;
    out_.Store(uint(int(0))*4, asuint(uint(Base_1)));
    out_.Store(uint(int(1))*4, asuint(High));
    out_.Store(uint(int(2))*4, asuint(asuint(Scale)));
    int _e34 = Chosen;
    out_.Store(uint(int(3))*4, asuint(uint(_e34)));
    const int _e39 = accumulate(runtime_2);
    out_.Store(uint(int(4))*4, asuint(uint(_e39)));
    int _e44 = Size;
    int _e46 = values[min(uint(_e44), 4u)];
    out_.Store(uint(int(5))*4, asuint(uint(_e46)));
    int _e53 = values[int(1)];
    out_.Store(uint(int(6))*4, asuint(uint(_e53)));
    out_.Store(uint(int(7))*4, asuint(naga_f2u32((float(runtime_2) * Scale))));
    SignedHigh = int(-2147483647 - 1);
    Negative = int(-2);
    All = 4294967295u;
    Wrapped = 0u;
    int _e73 = SignedHigh;
    out_.Store(uint(int(8))*4, asuint(uint(_e73)));
    int _e78 = Negative;
    out_.Store(uint(int(9))*4, asuint(uint(_e78)));
    uint _e83 = All;
    out_.Store(uint(int(10))*4, asuint(_e83));
    uint _e87 = Wrapped;
    out_.Store(uint(int(11))*4, asuint(_e87));
    TruncatedZero = 0u;
    Minimum = int(-2147483647 - 1);
    Large = 4294967040u;
    Ready = true;
    uint _e99 = TruncatedZero;
    out_.Store(uint(int(12))*4, asuint(_e99));
    int _e103 = Minimum;
    out_.Store(uint(int(13))*4, asuint(uint(_e103)));
    uint _e108 = Large;
    out_.Store(uint(int(14))*4, asuint(_e108));
    bool _e112 = Ready;
    out_.Store(uint(int(15))*4, asuint(uint(_e112)));
    Comma = int(4);
    Lazy = int(6);
    int _e121 = Comma;
    out_.Store(uint(int(16))*4, asuint(uint(_e121)));
    int _e126 = Lazy;
    out_.Store(uint(int(17))*4, asuint(uint(_e126)));
    out_.Store(uint(int(18))*4, asuint(uint(runtime_2)));
    Skipped = false;
    Yes = true;
    bool _e139 = Skipped;
    out_.Store(uint(int(19))*4, asuint(uint(_e139)));
    bool _e144 = Yes;
    out_.Store(uint(int(20))*4, asuint(uint(_e144)));
    out_.Store(uint(int(21))*4, asuint(uint(runtime_2)));
    VectorCount = int(2);
    vectors = ZeroValuearray2_float3__();
    int _e160 = asint(input.Load(uint(int(1))*4));
    vectors[int(1)].y = float(_e160);
    float _e168 = vectors[int(1)].y;
    out_.Store(uint(int(22))*4, asuint(naga_f2u32(_e168)));
    {
        Base = ZeroValuearray2_int_();
        int _e177 = Base[int(1)];
        local_7 = uint(int(23));
        uint _e182 = local_7;
        local_10 = _e182;
        uint _e184 = local_10;
        out_.Store(_e184*4, asuint(uint(_e177)));
    }
    {
        i = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e212 = i;
                i = asint(asuint(_e212) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e188 = i;
            if ((_e188 < int(3))) {
            } else {
                break;
            }
            Count = int(3);
            scratch = ZeroValuearray3_int_();
            int _e197 = scratch[int(2)];
            int _e199 = i;
            local_8 = uint(asint(asuint(int(24)) + asuint(_e199)));
            uint _e204 = local_8;
            local_11 = _e204;
            uint _e206 = local_11;
            out_.Store(_e206*4, asuint(uint(_e197)));
            int _e208 = i;
            scratch[int(2)] = asint(asuint(runtime_2) + asuint(_e208));
        }
    }
    int _e218 = asint(input.Load(uint(int(1))*4));
    const int _e219 = accumulate(_e218);
    out_.Store(uint(int(27))*4, asuint(uint(_e219)));
    out_.Store(uint(int(28))*4, asuint(uint(Second)));
    Safe = int(3);
    int _e234 = asint(input.Load(uint(int(1))*4));
    int _e236 = Safe;
    out_.Store(uint(int(29))*4, asuint(uint(asint(asuint(asint(asuint(asint(asuint(runtime_2) + asuint(_e234))) + asuint(_e236))) - asuint(int(3))))));
}
