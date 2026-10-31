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
    int local_43 = (int)0;
    int local_44[3] = (int[3])0;
    int total = (int)0;
    int i_1 = (int)0;

    runtime_1 = runtime;
    Size_1 = int(3);
    local_44 = ZeroValuearray3_int_();
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
            local_44[min(uint(_e16), 2u)] = asint(asuint(_e18) + asuint(_e19));
            int _e21 = i_1;
            int _e23 = local_44[min(uint(_e21), 2u)];
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
    uint local = (uint)0;
    int Chosen = (int)0;
    int local_1 = (int)0;
    int Size = (int)0;
    int values[5] = (int[5])0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    int SignedHigh = (int)0;
    uint local_11 = (uint)0;
    int Negative = (int)0;
    uint local_12 = (uint)0;
    uint All = (uint)0;
    uint Wrapped = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint TruncatedZero = (uint)0;
    int Minimum = (int)0;
    uint Large = (uint)0;
    bool Ready = (bool)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    int Comma = (int)0;
    int Lazy = (int)0;
    int local_22 = (int)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    bool Skipped = (bool)0;
    bool local_26 = (bool)0;
    bool Yes = (bool)0;
    bool local_27 = (bool)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    int VectorCount = (int)0;
    float3_ vectors[2] = (float3_[2])0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    int Base[2] = (int[2])0;
    uint local_33 = (uint)0;
    int i = (int)0;
    int Count = (int)0;
    int scratch[3] = (int[3])0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    int Safe = (int)0;
    int local_38 = (int)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;

    local = uint(int(0));
    uint _e3 = local;
    int runtime_2 = asint(input.Load(_e3*4));
    Chosen = int(3);
    Size = int(4);
    values = ZeroValuearray5_int_();
    values[int(0)] = runtime_2;
    local_2 = uint(int(1));
    uint _e18 = local_2;
    int _e20 = asint(input.Load(_e18*4));
    int _e21 = Size;
    values[min(uint(_e21), 4u)] = _e20;
    local_3 = uint(int(0));
    uint _e28 = local_3;
    out_.Store(_e28*4, asuint(uint(Base_1)));
    local_4 = uint(int(1));
    uint _e34 = local_4;
    out_.Store(_e34*4, asuint(High));
    local_5 = uint(int(2));
    uint _e42 = local_5;
    out_.Store(_e42*4, asuint(asuint(Scale)));
    int _e44 = Chosen;
    local_6 = uint(int(3));
    uint _e49 = local_6;
    out_.Store(_e49*4, asuint(uint(_e44)));
    const int _e51 = accumulate(runtime_2);
    local_7 = uint(int(4));
    uint _e56 = local_7;
    out_.Store(_e56*4, asuint(uint(_e51)));
    int _e58 = Size;
    int _e60 = values[min(uint(_e58), 4u)];
    local_8 = uint(int(5));
    uint _e65 = local_8;
    out_.Store(_e65*4, asuint(uint(_e60)));
    int _e69 = values[int(1)];
    local_9 = uint(int(6));
    uint _e74 = local_9;
    out_.Store(_e74*4, asuint(uint(_e69)));
    local_10 = uint(int(7));
    uint _e83 = local_10;
    out_.Store(_e83*4, asuint(naga_f2u32((float(runtime_2) * Scale))));
    SignedHigh = int(-2147483647 - 1);
    Negative = int(-2);
    All = 4294967295u;
    Wrapped = 0u;
    int _e93 = SignedHigh;
    local_14 = uint(int(8));
    uint _e98 = local_14;
    out_.Store(_e98*4, asuint(uint(_e93)));
    int _e100 = Negative;
    local_15 = uint(int(9));
    uint _e105 = local_15;
    out_.Store(_e105*4, asuint(uint(_e100)));
    uint _e107 = All;
    local_16 = uint(int(10));
    uint _e111 = local_16;
    out_.Store(_e111*4, asuint(_e107));
    uint _e113 = Wrapped;
    local_17 = uint(int(11));
    uint _e117 = local_17;
    out_.Store(_e117*4, asuint(_e113));
    TruncatedZero = 0u;
    Minimum = int(-2147483647 - 1);
    Large = 4294967040u;
    Ready = true;
    uint _e127 = TruncatedZero;
    local_18 = uint(int(12));
    uint _e131 = local_18;
    out_.Store(_e131*4, asuint(_e127));
    int _e133 = Minimum;
    local_19 = uint(int(13));
    uint _e138 = local_19;
    out_.Store(_e138*4, asuint(uint(_e133)));
    uint _e140 = Large;
    local_20 = uint(int(14));
    uint _e144 = local_20;
    out_.Store(_e144*4, asuint(_e140));
    bool _e146 = Ready;
    local_21 = uint(int(15));
    uint _e151 = local_21;
    out_.Store(_e151*4, asuint(uint(_e146)));
    Comma = int(4);
    Lazy = int(6);
    int _e157 = Comma;
    local_23 = uint(int(16));
    uint _e162 = local_23;
    out_.Store(_e162*4, asuint(uint(_e157)));
    int _e164 = Lazy;
    local_24 = uint(int(17));
    uint _e169 = local_24;
    out_.Store(_e169*4, asuint(uint(_e164)));
    local_25 = uint(int(18));
    uint _e175 = local_25;
    out_.Store(_e175*4, asuint(uint(runtime_2)));
    Skipped = false;
    Yes = true;
    bool _e181 = Skipped;
    local_28 = uint(int(19));
    uint _e186 = local_28;
    out_.Store(_e186*4, asuint(uint(_e181)));
    bool _e188 = Yes;
    local_29 = uint(int(20));
    uint _e193 = local_29;
    out_.Store(_e193*4, asuint(uint(_e188)));
    local_30 = uint(int(21));
    uint _e199 = local_30;
    out_.Store(_e199*4, asuint(uint(runtime_2)));
    VectorCount = int(2);
    vectors = ZeroValuearray2_float3__();
    local_31 = uint(int(1));
    uint _e208 = local_31;
    int _e210 = asint(input.Load(_e208*4));
    vectors[int(1)].y = float(_e210);
    float _e218 = vectors[int(1)].y;
    local_32 = uint(int(22));
    uint _e223 = local_32;
    out_.Store(_e223*4, asuint(naga_f2u32(_e218)));
    {
        Base = ZeroValuearray2_int_();
        int _e229 = Base[int(1)];
        local_33 = uint(int(23));
        uint _e234 = local_33;
        local_41 = _e234;
        uint _e236 = local_41;
        out_.Store(_e236*4, asuint(uint(_e229)));
    }
    {
        i = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e264 = i;
                i = asint(asuint(_e264) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e240 = i;
            if ((_e240 < int(3))) {
            } else {
                break;
            }
            Count = int(3);
            scratch = ZeroValuearray3_int_();
            int _e249 = scratch[int(2)];
            int _e251 = i;
            local_34 = uint(asint(asuint(int(24)) + asuint(_e251)));
            uint _e256 = local_34;
            local_42 = _e256;
            uint _e258 = local_42;
            out_.Store(_e258*4, asuint(uint(_e249)));
            int _e260 = i;
            scratch[int(2)] = asint(asuint(runtime_2) + asuint(_e260));
        }
    }
    local_36 = uint(int(1));
    uint _e270 = local_36;
    int _e272 = asint(input.Load(_e270*4));
    const int _e273 = accumulate(_e272);
    local_35 = uint(int(27));
    uint _e278 = local_35;
    out_.Store(_e278*4, asuint(uint(_e273)));
    local_37 = uint(int(28));
    uint _e285 = local_37;
    out_.Store(_e285*4, asuint(uint(Second)));
    Safe = int(3);
    local_40 = uint(int(1));
    uint _e292 = local_40;
    int _e294 = asint(input.Load(_e292*4));
    int _e296 = Safe;
    local_39 = uint(int(29));
    uint _e304 = local_39;
    out_.Store(_e304*4, asuint(uint(asint(asuint(asint(asuint(asint(asuint(runtime_2) + asuint(_e294))) + asuint(_e296))) - asuint(int(3))))));
}
