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
    int local_74 = (int)0;
    int local_75[3] = (int[3])0;
    int total = (int)0;
    int i_1 = (int)0;

    runtime_1 = runtime;
    Size_1 = int(3);
    local_75 = ZeroValuearray3_int_();
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
            local_75[min(uint(_e16), 2u)] = asint(asuint(_e18) + asuint(_e19));
            int _e21 = i_1;
            int _e23 = local_75[min(uint(_e21), 2u)];
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
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;

    local = uint(int(0));
    uint _e3 = local;
    local_41 = uint(_e3);
    uint _e6 = local_41;
    int runtime_2 = asint(input.Load(_e6*4));
    Chosen = int(3);
    Size = int(4);
    values = ZeroValuearray5_int_();
    values[int(0)] = runtime_2;
    local_2 = uint(int(1));
    uint _e21 = local_2;
    local_42 = uint(_e21);
    uint _e24 = local_42;
    int _e26 = asint(input.Load(_e24*4));
    int _e27 = Size;
    values[min(uint(_e27), 4u)] = _e26;
    local_3 = uint(int(0));
    uint _e34 = local_3;
    local_43 = uint(_e34);
    uint _e37 = local_43;
    out_.Store(_e37*4, asuint(uint(Base_1)));
    local_4 = uint(int(1));
    uint _e43 = local_4;
    local_44 = uint(_e43);
    uint _e46 = local_44;
    out_.Store(_e46*4, asuint(High));
    local_5 = uint(int(2));
    uint _e54 = local_5;
    local_45 = uint(_e54);
    uint _e57 = local_45;
    out_.Store(_e57*4, asuint(asuint(Scale)));
    int _e59 = Chosen;
    local_6 = uint(int(3));
    uint _e64 = local_6;
    local_46 = uint(_e64);
    uint _e67 = local_46;
    out_.Store(_e67*4, asuint(uint(_e59)));
    const int _e69 = accumulate(runtime_2);
    local_7 = uint(int(4));
    uint _e74 = local_7;
    local_47 = uint(_e74);
    uint _e77 = local_47;
    out_.Store(_e77*4, asuint(uint(_e69)));
    int _e79 = Size;
    int _e81 = values[min(uint(_e79), 4u)];
    local_8 = uint(int(5));
    uint _e86 = local_8;
    local_48 = uint(_e86);
    uint _e89 = local_48;
    out_.Store(_e89*4, asuint(uint(_e81)));
    int _e93 = values[int(1)];
    local_9 = uint(int(6));
    uint _e98 = local_9;
    local_49 = uint(_e98);
    uint _e101 = local_49;
    out_.Store(_e101*4, asuint(uint(_e93)));
    local_10 = uint(int(7));
    uint _e110 = local_10;
    local_50 = uint(_e110);
    uint _e113 = local_50;
    out_.Store(_e113*4, asuint(naga_f2u32((float(runtime_2) * Scale))));
    SignedHigh = int(-2147483647 - 1);
    Negative = int(-2);
    All = 4294967295u;
    Wrapped = 0u;
    int _e123 = SignedHigh;
    local_14 = uint(int(8));
    uint _e128 = local_14;
    local_51 = uint(_e128);
    uint _e131 = local_51;
    out_.Store(_e131*4, asuint(uint(_e123)));
    int _e133 = Negative;
    local_15 = uint(int(9));
    uint _e138 = local_15;
    local_52 = uint(_e138);
    uint _e141 = local_52;
    out_.Store(_e141*4, asuint(uint(_e133)));
    uint _e143 = All;
    local_16 = uint(int(10));
    uint _e147 = local_16;
    local_53 = uint(_e147);
    uint _e150 = local_53;
    out_.Store(_e150*4, asuint(_e143));
    uint _e152 = Wrapped;
    local_17 = uint(int(11));
    uint _e156 = local_17;
    local_54 = uint(_e156);
    uint _e159 = local_54;
    out_.Store(_e159*4, asuint(_e152));
    TruncatedZero = 0u;
    Minimum = int(-2147483647 - 1);
    Large = 4294967040u;
    Ready = true;
    uint _e169 = TruncatedZero;
    local_18 = uint(int(12));
    uint _e173 = local_18;
    local_55 = uint(_e173);
    uint _e176 = local_55;
    out_.Store(_e176*4, asuint(_e169));
    int _e178 = Minimum;
    local_19 = uint(int(13));
    uint _e183 = local_19;
    local_56 = uint(_e183);
    uint _e186 = local_56;
    out_.Store(_e186*4, asuint(uint(_e178)));
    uint _e188 = Large;
    local_20 = uint(int(14));
    uint _e192 = local_20;
    local_57 = uint(_e192);
    uint _e195 = local_57;
    out_.Store(_e195*4, asuint(_e188));
    bool _e197 = Ready;
    local_21 = uint(int(15));
    uint _e202 = local_21;
    local_58 = uint(_e202);
    uint _e205 = local_58;
    out_.Store(_e205*4, asuint(uint(_e197)));
    Comma = int(4);
    Lazy = int(6);
    int _e211 = Comma;
    local_23 = uint(int(16));
    uint _e216 = local_23;
    local_59 = uint(_e216);
    uint _e219 = local_59;
    out_.Store(_e219*4, asuint(uint(_e211)));
    int _e221 = Lazy;
    local_24 = uint(int(17));
    uint _e226 = local_24;
    local_60 = uint(_e226);
    uint _e229 = local_60;
    out_.Store(_e229*4, asuint(uint(_e221)));
    local_25 = uint(int(18));
    uint _e235 = local_25;
    local_61 = uint(_e235);
    uint _e238 = local_61;
    out_.Store(_e238*4, asuint(uint(runtime_2)));
    Skipped = false;
    Yes = true;
    bool _e244 = Skipped;
    local_28 = uint(int(19));
    uint _e249 = local_28;
    local_62 = uint(_e249);
    uint _e252 = local_62;
    out_.Store(_e252*4, asuint(uint(_e244)));
    bool _e254 = Yes;
    local_29 = uint(int(20));
    uint _e259 = local_29;
    local_63 = uint(_e259);
    uint _e262 = local_63;
    out_.Store(_e262*4, asuint(uint(_e254)));
    local_30 = uint(int(21));
    uint _e268 = local_30;
    local_64 = uint(_e268);
    uint _e271 = local_64;
    out_.Store(_e271*4, asuint(uint(runtime_2)));
    VectorCount = int(2);
    vectors = ZeroValuearray2_float3__();
    local_31 = uint(int(1));
    uint _e280 = local_31;
    local_65 = uint(_e280);
    uint _e283 = local_65;
    int _e285 = asint(input.Load(_e283*4));
    vectors[int(1)].y = float(_e285);
    float _e293 = vectors[int(1)].y;
    local_32 = uint(int(22));
    uint _e298 = local_32;
    local_66 = uint(_e298);
    uint _e301 = local_66;
    out_.Store(_e301*4, asuint(naga_f2u32(_e293)));
    {
        Base = ZeroValuearray2_int_();
        int _e307 = Base[int(1)];
        local_33 = uint(int(23));
        uint _e312 = local_33;
        local_67 = uint(_e312);
        uint _e315 = local_67;
        out_.Store(_e315*4, asuint(uint(_e307)));
    }
    {
        i = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e344 = i;
                i = asint(asuint(_e344) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e319 = i;
            if ((_e319 < int(3))) {
            } else {
                break;
            }
            Count = int(3);
            scratch = ZeroValuearray3_int_();
            int _e328 = scratch[int(2)];
            int _e330 = i;
            local_34 = uint(asint(asuint(int(24)) + asuint(_e330)));
            uint _e335 = local_34;
            local_68 = uint(_e335);
            uint _e338 = local_68;
            out_.Store(_e338*4, asuint(uint(_e328)));
            int _e340 = i;
            scratch[int(2)] = asint(asuint(runtime_2) + asuint(_e340));
        }
    }
    local_36 = uint(int(1));
    uint _e350 = local_36;
    local_69 = uint(_e350);
    uint _e353 = local_69;
    int _e355 = asint(input.Load(_e353*4));
    const int _e356 = accumulate(_e355);
    local_35 = uint(int(27));
    uint _e361 = local_35;
    local_70 = uint(_e361);
    uint _e364 = local_70;
    out_.Store(_e364*4, asuint(uint(_e356)));
    local_37 = uint(int(28));
    uint _e371 = local_37;
    local_71 = uint(_e371);
    uint _e374 = local_71;
    out_.Store(_e374*4, asuint(uint(Second)));
    Safe = int(3);
    local_40 = uint(int(1));
    uint _e381 = local_40;
    local_72 = uint(_e381);
    uint _e384 = local_72;
    int _e386 = asint(input.Load(_e384*4));
    int _e388 = Safe;
    local_39 = uint(int(29));
    uint _e396 = local_39;
    local_73 = uint(_e396);
    uint _e399 = local_73;
    out_.Store(_e399*4, asuint(uint(asint(asuint(asint(asuint(asint(asuint(runtime_2) + asuint(_e386))) + asuint(_e388))) - asuint(int(3))))));
}
