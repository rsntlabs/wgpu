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
    int local_84 = (int)0;
    int local_85[3] = (int[3])0;
    int total = (int)0;
    int i_1 = (int)0;

    runtime_1 = runtime;
    Size_1 = int(3);
    local_85 = ZeroValuearray3_int_();
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
            local_85[min(uint(_e16), 2u)] = asint(asuint(_e18) + asuint(_e19));
            int _e21 = i_1;
            int _e23 = local_85[min(uint(_e21), 2u)];
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
    int local_41 = (int)0;
    int local_42 = (int)0;
    int local_43 = (int)0;
    int local_44 = (int)0;
    int local_45 = (int)0;
    uint local_46 = (uint)0;
    int local_47 = (int)0;
    uint local_48 = (uint)0;
    int local_49 = (int)0;
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
    int local_73 = (int)0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    int local_78 = (int)0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81 = (uint)0;
    int local_82 = (int)0;
    uint local_83 = (uint)0;

    local = uint(int(0));
    uint _e3 = local;
    local_46 = uint(_e3);
    uint _e6 = local_46;
    int _e9 = asint(input.Load(_e6*4));
    local_47 = _e9;
    int _e11 = local_47;
    local_41 = _e11;
    int runtime_2 = local_41;
    Chosen = int(3);
    Size = int(4);
    values = ZeroValuearray5_int_();
    values[int(0)] = runtime_2;
    local_2 = uint(int(1));
    uint _e25 = local_2;
    local_48 = uint(_e25);
    uint _e28 = local_48;
    int _e30 = asint(input.Load(_e28*4));
    local_49 = _e30;
    int _e32 = local_49;
    local_42 = _e32;
    int _e34 = local_42;
    int _e35 = Size;
    values[min(uint(_e35), 4u)] = _e34;
    local_3 = uint(int(0));
    uint _e42 = local_3;
    local_50 = uint(_e42);
    uint _e45 = local_50;
    out_.Store(_e45*4, asuint(uint(Base_1)));
    local_4 = uint(int(1));
    uint _e51 = local_4;
    local_51 = uint(_e51);
    uint _e54 = local_51;
    out_.Store(_e54*4, asuint(High));
    local_5 = uint(int(2));
    uint _e62 = local_5;
    local_52 = uint(_e62);
    uint _e65 = local_52;
    out_.Store(_e65*4, asuint(asuint(Scale)));
    int _e67 = Chosen;
    local_6 = uint(int(3));
    uint _e72 = local_6;
    local_53 = uint(_e72);
    uint _e75 = local_53;
    out_.Store(_e75*4, asuint(uint(_e67)));
    const int _e77 = accumulate(runtime_2);
    local_7 = uint(int(4));
    uint _e82 = local_7;
    local_54 = uint(_e82);
    uint _e85 = local_54;
    out_.Store(_e85*4, asuint(uint(_e77)));
    int _e87 = Size;
    int _e89 = values[min(uint(_e87), 4u)];
    local_8 = uint(int(5));
    uint _e94 = local_8;
    local_55 = uint(_e94);
    uint _e97 = local_55;
    out_.Store(_e97*4, asuint(uint(_e89)));
    int _e101 = values[int(1)];
    local_9 = uint(int(6));
    uint _e106 = local_9;
    local_56 = uint(_e106);
    uint _e109 = local_56;
    out_.Store(_e109*4, asuint(uint(_e101)));
    local_10 = uint(int(7));
    uint _e118 = local_10;
    local_57 = uint(_e118);
    uint _e121 = local_57;
    out_.Store(_e121*4, asuint(naga_f2u32((float(runtime_2) * Scale))));
    SignedHigh = int(-2147483647 - 1);
    Negative = int(-2);
    All = 4294967295u;
    Wrapped = 0u;
    int _e131 = SignedHigh;
    local_14 = uint(int(8));
    uint _e136 = local_14;
    local_58 = uint(_e136);
    uint _e139 = local_58;
    out_.Store(_e139*4, asuint(uint(_e131)));
    int _e141 = Negative;
    local_15 = uint(int(9));
    uint _e146 = local_15;
    local_59 = uint(_e146);
    uint _e149 = local_59;
    out_.Store(_e149*4, asuint(uint(_e141)));
    uint _e151 = All;
    local_16 = uint(int(10));
    uint _e155 = local_16;
    local_60 = uint(_e155);
    uint _e158 = local_60;
    out_.Store(_e158*4, asuint(_e151));
    uint _e160 = Wrapped;
    local_17 = uint(int(11));
    uint _e164 = local_17;
    local_61 = uint(_e164);
    uint _e167 = local_61;
    out_.Store(_e167*4, asuint(_e160));
    TruncatedZero = 0u;
    Minimum = int(-2147483647 - 1);
    Large = 4294967040u;
    Ready = true;
    uint _e177 = TruncatedZero;
    local_18 = uint(int(12));
    uint _e181 = local_18;
    local_62 = uint(_e181);
    uint _e184 = local_62;
    out_.Store(_e184*4, asuint(_e177));
    int _e186 = Minimum;
    local_19 = uint(int(13));
    uint _e191 = local_19;
    local_63 = uint(_e191);
    uint _e194 = local_63;
    out_.Store(_e194*4, asuint(uint(_e186)));
    uint _e196 = Large;
    local_20 = uint(int(14));
    uint _e200 = local_20;
    local_64 = uint(_e200);
    uint _e203 = local_64;
    out_.Store(_e203*4, asuint(_e196));
    bool _e205 = Ready;
    local_21 = uint(int(15));
    uint _e210 = local_21;
    local_65 = uint(_e210);
    uint _e213 = local_65;
    out_.Store(_e213*4, asuint(uint(_e205)));
    Comma = int(4);
    Lazy = int(6);
    int _e219 = Comma;
    local_23 = uint(int(16));
    uint _e224 = local_23;
    local_66 = uint(_e224);
    uint _e227 = local_66;
    out_.Store(_e227*4, asuint(uint(_e219)));
    int _e229 = Lazy;
    local_24 = uint(int(17));
    uint _e234 = local_24;
    local_67 = uint(_e234);
    uint _e237 = local_67;
    out_.Store(_e237*4, asuint(uint(_e229)));
    local_25 = uint(int(18));
    uint _e243 = local_25;
    local_68 = uint(_e243);
    uint _e246 = local_68;
    out_.Store(_e246*4, asuint(uint(runtime_2)));
    Skipped = false;
    Yes = true;
    bool _e252 = Skipped;
    local_28 = uint(int(19));
    uint _e257 = local_28;
    local_69 = uint(_e257);
    uint _e260 = local_69;
    out_.Store(_e260*4, asuint(uint(_e252)));
    bool _e262 = Yes;
    local_29 = uint(int(20));
    uint _e267 = local_29;
    local_70 = uint(_e267);
    uint _e270 = local_70;
    out_.Store(_e270*4, asuint(uint(_e262)));
    local_30 = uint(int(21));
    uint _e276 = local_30;
    local_71 = uint(_e276);
    uint _e279 = local_71;
    out_.Store(_e279*4, asuint(uint(runtime_2)));
    VectorCount = int(2);
    vectors = ZeroValuearray2_float3__();
    local_31 = uint(int(1));
    uint _e288 = local_31;
    local_72 = uint(_e288);
    uint _e291 = local_72;
    int _e293 = asint(input.Load(_e291*4));
    local_73 = _e293;
    int _e295 = local_73;
    local_43 = _e295;
    int _e297 = local_43;
    vectors[int(1)].y = float(_e297);
    float _e305 = vectors[int(1)].y;
    local_32 = uint(int(22));
    uint _e310 = local_32;
    local_74 = uint(_e310);
    uint _e313 = local_74;
    out_.Store(_e313*4, asuint(naga_f2u32(_e305)));
    {
        Base = ZeroValuearray2_int_();
        int _e319 = Base[int(1)];
        local_33 = uint(int(23));
        uint _e324 = local_33;
        local_75 = uint(_e324);
        uint _e327 = local_75;
        out_.Store(_e327*4, asuint(uint(_e319)));
    }
    {
        i = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e356 = i;
                i = asint(asuint(_e356) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e331 = i;
            if ((_e331 < int(3))) {
            } else {
                break;
            }
            Count = int(3);
            scratch = ZeroValuearray3_int_();
            int _e340 = scratch[int(2)];
            int _e342 = i;
            local_34 = uint(asint(asuint(int(24)) + asuint(_e342)));
            uint _e347 = local_34;
            local_76 = uint(_e347);
            uint _e350 = local_76;
            out_.Store(_e350*4, asuint(uint(_e340)));
            int _e352 = i;
            scratch[int(2)] = asint(asuint(runtime_2) + asuint(_e352));
        }
    }
    local_36 = uint(int(1));
    uint _e362 = local_36;
    local_77 = uint(_e362);
    uint _e365 = local_77;
    int _e367 = asint(input.Load(_e365*4));
    local_78 = _e367;
    int _e369 = local_78;
    local_44 = _e369;
    int _e371 = local_44;
    const int _e372 = accumulate(_e371);
    local_35 = uint(int(27));
    uint _e377 = local_35;
    local_79 = uint(_e377);
    uint _e380 = local_79;
    out_.Store(_e380*4, asuint(uint(_e372)));
    local_37 = uint(int(28));
    uint _e387 = local_37;
    local_80 = uint(_e387);
    uint _e390 = local_80;
    out_.Store(_e390*4, asuint(uint(Second)));
    Safe = int(3);
    local_40 = uint(int(1));
    uint _e397 = local_40;
    local_81 = uint(_e397);
    uint _e400 = local_81;
    int _e402 = asint(input.Load(_e400*4));
    local_82 = _e402;
    int _e404 = local_82;
    local_45 = _e404;
    int _e406 = local_45;
    int _e408 = Safe;
    local_39 = uint(int(29));
    uint _e416 = local_39;
    local_83 = uint(_e416);
    uint _e419 = local_83;
    out_.Store(_e419*4, asuint(uint(asint(asuint(asint(asuint(asint(asuint(runtime_2) + asuint(_e406))) + asuint(_e408))) - asuint(int(3))))));
}
