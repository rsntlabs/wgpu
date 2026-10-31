// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

struct type_3 {
    int inner[3];
};
typedef int type_4[1];
typedef uint type_5[1];
struct type_6 {
    int inner[5];
};
struct float3_ {
    float x;
    float y;
    float z;
};
struct type_8 {
    float3_ inner[2];
};
struct type_9 {
    int inner[2];
};
constant int Base_1 = 2;
constant uint High = 2147483648u;
constant float Scale = 0.5;
constant int Second = 3;
constant int After = 4;

int accumulate(
    int runtime
) {
    int runtime_1 = {};
    int Size_1 = {};
    int local_74 = {};
    type_3 local_75 = {};
    int total = {};
    int i_1 = {};
    runtime_1 = runtime;
    Size_1 = 3;
    local_75 = type_3 {};
    total = 0;
    {
        i_1 = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e13 = i_1;
                i_1 = as_type<int>(as_type<uint>(_e13) + as_type<uint>(1));
            }
            loop_init = false;
            int _e10 = i_1;
            int _e11 = Size_1;
            if (_e10 < _e11) {
            } else {
                break;
            }
            int _e18 = runtime_1;
            int _e19 = i_1;
            int _e16 = i_1;
            local_75.inner[_e16] = as_type<int>(as_type<uint>(_e18) + as_type<uint>(_e19));
            int _e21 = i_1;
            int _e23 = local_75.inner[_e21];
            int _e24 = total;
            total = as_type<int>(as_type<uint>(_e24) + as_type<uint>(_e23));
        }
    }
    int _e26 = total;
    return _e26;
}
uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}


kernel void constant_expressions(
  device type_4 const& input [[user(fake0)]]
, device type_5& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    int Chosen = {};
    int local_1 = {};
    int Size = {};
    type_6 values = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    int SignedHigh = {};
    uint local_11 = {};
    int Negative = {};
    uint local_12 = {};
    uint All = {};
    uint Wrapped = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint TruncatedZero = {};
    int Minimum = {};
    uint Large = {};
    bool Ready = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    int Comma = {};
    int Lazy = {};
    int local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    bool Skipped = {};
    bool local_26 = {};
    bool Yes = {};
    bool local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    int VectorCount = {};
    type_8 vectors = {};
    uint local_31 = {};
    uint local_32 = {};
    type_9 Base = {};
    uint local_33 = {};
    int i = {};
    int Count = {};
    type_3 scratch = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    int Safe = {};
    int local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_41 = static_cast<uint>(_e3);
    uint _e6 = local_41;
    int runtime_2 = input[_e6];
    Chosen = 3;
    Size = 4;
    values = type_6 {};
    values.inner[0] = runtime_2;
    local_2 = static_cast<uint>(1);
    uint _e21 = local_2;
    local_42 = static_cast<uint>(_e21);
    uint _e24 = local_42;
    int _e26 = input[_e24];
    int _e27 = Size;
    values.inner[_e27] = _e26;
    local_3 = static_cast<uint>(0);
    uint _e34 = local_3;
    local_43 = static_cast<uint>(_e34);
    uint _e37 = local_43;
    out[_e37] = static_cast<uint>(Base_1);
    local_4 = static_cast<uint>(1);
    uint _e43 = local_4;
    local_44 = static_cast<uint>(_e43);
    uint _e46 = local_44;
    out[_e46] = High;
    local_5 = static_cast<uint>(2);
    uint _e54 = local_5;
    local_45 = static_cast<uint>(_e54);
    uint _e57 = local_45;
    out[_e57] = as_type<uint>(Scale);
    int _e59 = Chosen;
    local_6 = static_cast<uint>(3);
    uint _e64 = local_6;
    local_46 = static_cast<uint>(_e64);
    uint _e67 = local_46;
    out[_e67] = static_cast<uint>(_e59);
    int _e69 = accumulate(runtime_2);
    local_7 = static_cast<uint>(4);
    uint _e74 = local_7;
    local_47 = static_cast<uint>(_e74);
    uint _e77 = local_47;
    out[_e77] = static_cast<uint>(_e69);
    int _e79 = Size;
    int _e81 = values.inner[_e79];
    local_8 = static_cast<uint>(5);
    uint _e86 = local_8;
    local_48 = static_cast<uint>(_e86);
    uint _e89 = local_48;
    out[_e89] = static_cast<uint>(_e81);
    int _e93 = values.inner[1];
    local_9 = static_cast<uint>(6);
    uint _e98 = local_9;
    local_49 = static_cast<uint>(_e98);
    uint _e101 = local_49;
    out[_e101] = static_cast<uint>(_e93);
    local_10 = static_cast<uint>(7);
    uint _e110 = local_10;
    local_50 = static_cast<uint>(_e110);
    uint _e113 = local_50;
    out[_e113] = naga_f2u32(static_cast<float>(runtime_2) * Scale);
    SignedHigh = (-2147483647 - 1);
    Negative = -2;
    All = 4294967295u;
    Wrapped = 0u;
    int _e123 = SignedHigh;
    local_14 = static_cast<uint>(8);
    uint _e128 = local_14;
    local_51 = static_cast<uint>(_e128);
    uint _e131 = local_51;
    out[_e131] = static_cast<uint>(_e123);
    int _e133 = Negative;
    local_15 = static_cast<uint>(9);
    uint _e138 = local_15;
    local_52 = static_cast<uint>(_e138);
    uint _e141 = local_52;
    out[_e141] = static_cast<uint>(_e133);
    uint _e143 = All;
    local_16 = static_cast<uint>(10);
    uint _e147 = local_16;
    local_53 = static_cast<uint>(_e147);
    uint _e150 = local_53;
    out[_e150] = _e143;
    uint _e152 = Wrapped;
    local_17 = static_cast<uint>(11);
    uint _e156 = local_17;
    local_54 = static_cast<uint>(_e156);
    uint _e159 = local_54;
    out[_e159] = _e152;
    TruncatedZero = 0u;
    Minimum = (-2147483647 - 1);
    Large = 4294967040u;
    Ready = true;
    uint _e169 = TruncatedZero;
    local_18 = static_cast<uint>(12);
    uint _e173 = local_18;
    local_55 = static_cast<uint>(_e173);
    uint _e176 = local_55;
    out[_e176] = _e169;
    int _e178 = Minimum;
    local_19 = static_cast<uint>(13);
    uint _e183 = local_19;
    local_56 = static_cast<uint>(_e183);
    uint _e186 = local_56;
    out[_e186] = static_cast<uint>(_e178);
    uint _e188 = Large;
    local_20 = static_cast<uint>(14);
    uint _e192 = local_20;
    local_57 = static_cast<uint>(_e192);
    uint _e195 = local_57;
    out[_e195] = _e188;
    bool _e197 = Ready;
    local_21 = static_cast<uint>(15);
    uint _e202 = local_21;
    local_58 = static_cast<uint>(_e202);
    uint _e205 = local_58;
    out[_e205] = static_cast<uint>(_e197);
    Comma = 4;
    Lazy = 6;
    int _e211 = Comma;
    local_23 = static_cast<uint>(16);
    uint _e216 = local_23;
    local_59 = static_cast<uint>(_e216);
    uint _e219 = local_59;
    out[_e219] = static_cast<uint>(_e211);
    int _e221 = Lazy;
    local_24 = static_cast<uint>(17);
    uint _e226 = local_24;
    local_60 = static_cast<uint>(_e226);
    uint _e229 = local_60;
    out[_e229] = static_cast<uint>(_e221);
    local_25 = static_cast<uint>(18);
    uint _e235 = local_25;
    local_61 = static_cast<uint>(_e235);
    uint _e238 = local_61;
    out[_e238] = static_cast<uint>(runtime_2);
    Skipped = false;
    Yes = true;
    bool _e244 = Skipped;
    local_28 = static_cast<uint>(19);
    uint _e249 = local_28;
    local_62 = static_cast<uint>(_e249);
    uint _e252 = local_62;
    out[_e252] = static_cast<uint>(_e244);
    bool _e254 = Yes;
    local_29 = static_cast<uint>(20);
    uint _e259 = local_29;
    local_63 = static_cast<uint>(_e259);
    uint _e262 = local_63;
    out[_e262] = static_cast<uint>(_e254);
    local_30 = static_cast<uint>(21);
    uint _e268 = local_30;
    local_64 = static_cast<uint>(_e268);
    uint _e271 = local_64;
    out[_e271] = static_cast<uint>(runtime_2);
    VectorCount = 2;
    vectors = type_8 {};
    local_31 = static_cast<uint>(1);
    uint _e280 = local_31;
    local_65 = static_cast<uint>(_e280);
    uint _e283 = local_65;
    int _e285 = input[_e283];
    vectors.inner[1].y = static_cast<float>(_e285);
    float _e293 = vectors.inner[1].y;
    local_32 = static_cast<uint>(22);
    uint _e298 = local_32;
    local_66 = static_cast<uint>(_e298);
    uint _e301 = local_66;
    out[_e301] = naga_f2u32(_e293);
    {
        Base = type_9 {};
        int _e307 = Base.inner[1];
        local_33 = static_cast<uint>(23);
        uint _e312 = local_33;
        local_67 = static_cast<uint>(_e312);
        uint _e315 = local_67;
        out[_e315] = static_cast<uint>(_e307);
    }
    {
        i = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e344 = i;
                i = as_type<int>(as_type<uint>(_e344) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e319 = i;
            if (_e319 < 3) {
            } else {
                break;
            }
            Count = 3;
            scratch = type_3 {};
            int _e328 = scratch.inner[2];
            int _e330 = i;
            local_34 = static_cast<uint>(as_type<int>(as_type<uint>(24) + as_type<uint>(_e330)));
            uint _e335 = local_34;
            local_68 = static_cast<uint>(_e335);
            uint _e338 = local_68;
            out[_e338] = static_cast<uint>(_e328);
            int _e340 = i;
            scratch.inner[2] = as_type<int>(as_type<uint>(runtime_2) + as_type<uint>(_e340));
        }
    }
    local_36 = static_cast<uint>(1);
    uint _e350 = local_36;
    local_69 = static_cast<uint>(_e350);
    uint _e353 = local_69;
    int _e355 = input[_e353];
    int _e356 = accumulate(_e355);
    local_35 = static_cast<uint>(27);
    uint _e361 = local_35;
    local_70 = static_cast<uint>(_e361);
    uint _e364 = local_70;
    out[_e364] = static_cast<uint>(_e356);
    local_37 = static_cast<uint>(28);
    uint _e371 = local_37;
    local_71 = static_cast<uint>(_e371);
    uint _e374 = local_71;
    out[_e374] = static_cast<uint>(Second);
    Safe = 3;
    local_40 = static_cast<uint>(1);
    uint _e381 = local_40;
    local_72 = static_cast<uint>(_e381);
    uint _e384 = local_72;
    int _e386 = input[_e384];
    int _e388 = Safe;
    local_39 = static_cast<uint>(29);
    uint _e396 = local_39;
    local_73 = static_cast<uint>(_e396);
    uint _e399 = local_73;
    out[_e399] = static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(runtime_2) + as_type<uint>(_e386))) + as_type<uint>(_e388))) - as_type<uint>(3)));
}
