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
    int local_84 = {};
    type_3 local_85 = {};
    int total = {};
    int i_1 = {};
    runtime_1 = runtime;
    Size_1 = 3;
    local_85 = type_3 {};
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
            local_85.inner[_e16] = as_type<int>(as_type<uint>(_e18) + as_type<uint>(_e19));
            int _e21 = i_1;
            int _e23 = local_85.inner[_e21];
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
    int local_41 = {};
    int local_42 = {};
    int local_43 = {};
    int local_44 = {};
    int local_45 = {};
    uint local_46 = {};
    int local_47 = {};
    uint local_48 = {};
    int local_49 = {};
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
    int local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    int local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    uint local_81 = {};
    int local_82 = {};
    uint local_83 = {};
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_46 = static_cast<uint>(_e3);
    uint _e6 = local_46;
    int _e9 = input[_e6];
    local_47 = _e9;
    int _e11 = local_47;
    local_41 = _e11;
    int runtime_2 = local_41;
    Chosen = 3;
    Size = 4;
    values = type_6 {};
    values.inner[0] = runtime_2;
    local_2 = static_cast<uint>(1);
    uint _e25 = local_2;
    local_48 = static_cast<uint>(_e25);
    uint _e28 = local_48;
    int _e30 = input[_e28];
    local_49 = _e30;
    int _e32 = local_49;
    local_42 = _e32;
    int _e34 = local_42;
    int _e35 = Size;
    values.inner[_e35] = _e34;
    local_3 = static_cast<uint>(0);
    uint _e42 = local_3;
    local_50 = static_cast<uint>(_e42);
    uint _e45 = local_50;
    out[_e45] = static_cast<uint>(Base_1);
    local_4 = static_cast<uint>(1);
    uint _e51 = local_4;
    local_51 = static_cast<uint>(_e51);
    uint _e54 = local_51;
    out[_e54] = High;
    local_5 = static_cast<uint>(2);
    uint _e62 = local_5;
    local_52 = static_cast<uint>(_e62);
    uint _e65 = local_52;
    out[_e65] = as_type<uint>(Scale);
    int _e67 = Chosen;
    local_6 = static_cast<uint>(3);
    uint _e72 = local_6;
    local_53 = static_cast<uint>(_e72);
    uint _e75 = local_53;
    out[_e75] = static_cast<uint>(_e67);
    int _e77 = accumulate(runtime_2);
    local_7 = static_cast<uint>(4);
    uint _e82 = local_7;
    local_54 = static_cast<uint>(_e82);
    uint _e85 = local_54;
    out[_e85] = static_cast<uint>(_e77);
    int _e87 = Size;
    int _e89 = values.inner[_e87];
    local_8 = static_cast<uint>(5);
    uint _e94 = local_8;
    local_55 = static_cast<uint>(_e94);
    uint _e97 = local_55;
    out[_e97] = static_cast<uint>(_e89);
    int _e101 = values.inner[1];
    local_9 = static_cast<uint>(6);
    uint _e106 = local_9;
    local_56 = static_cast<uint>(_e106);
    uint _e109 = local_56;
    out[_e109] = static_cast<uint>(_e101);
    local_10 = static_cast<uint>(7);
    uint _e118 = local_10;
    local_57 = static_cast<uint>(_e118);
    uint _e121 = local_57;
    out[_e121] = naga_f2u32(static_cast<float>(runtime_2) * Scale);
    SignedHigh = (-2147483647 - 1);
    Negative = -2;
    All = 4294967295u;
    Wrapped = 0u;
    int _e131 = SignedHigh;
    local_14 = static_cast<uint>(8);
    uint _e136 = local_14;
    local_58 = static_cast<uint>(_e136);
    uint _e139 = local_58;
    out[_e139] = static_cast<uint>(_e131);
    int _e141 = Negative;
    local_15 = static_cast<uint>(9);
    uint _e146 = local_15;
    local_59 = static_cast<uint>(_e146);
    uint _e149 = local_59;
    out[_e149] = static_cast<uint>(_e141);
    uint _e151 = All;
    local_16 = static_cast<uint>(10);
    uint _e155 = local_16;
    local_60 = static_cast<uint>(_e155);
    uint _e158 = local_60;
    out[_e158] = _e151;
    uint _e160 = Wrapped;
    local_17 = static_cast<uint>(11);
    uint _e164 = local_17;
    local_61 = static_cast<uint>(_e164);
    uint _e167 = local_61;
    out[_e167] = _e160;
    TruncatedZero = 0u;
    Minimum = (-2147483647 - 1);
    Large = 4294967040u;
    Ready = true;
    uint _e177 = TruncatedZero;
    local_18 = static_cast<uint>(12);
    uint _e181 = local_18;
    local_62 = static_cast<uint>(_e181);
    uint _e184 = local_62;
    out[_e184] = _e177;
    int _e186 = Minimum;
    local_19 = static_cast<uint>(13);
    uint _e191 = local_19;
    local_63 = static_cast<uint>(_e191);
    uint _e194 = local_63;
    out[_e194] = static_cast<uint>(_e186);
    uint _e196 = Large;
    local_20 = static_cast<uint>(14);
    uint _e200 = local_20;
    local_64 = static_cast<uint>(_e200);
    uint _e203 = local_64;
    out[_e203] = _e196;
    bool _e205 = Ready;
    local_21 = static_cast<uint>(15);
    uint _e210 = local_21;
    local_65 = static_cast<uint>(_e210);
    uint _e213 = local_65;
    out[_e213] = static_cast<uint>(_e205);
    Comma = 4;
    Lazy = 6;
    int _e219 = Comma;
    local_23 = static_cast<uint>(16);
    uint _e224 = local_23;
    local_66 = static_cast<uint>(_e224);
    uint _e227 = local_66;
    out[_e227] = static_cast<uint>(_e219);
    int _e229 = Lazy;
    local_24 = static_cast<uint>(17);
    uint _e234 = local_24;
    local_67 = static_cast<uint>(_e234);
    uint _e237 = local_67;
    out[_e237] = static_cast<uint>(_e229);
    local_25 = static_cast<uint>(18);
    uint _e243 = local_25;
    local_68 = static_cast<uint>(_e243);
    uint _e246 = local_68;
    out[_e246] = static_cast<uint>(runtime_2);
    Skipped = false;
    Yes = true;
    bool _e252 = Skipped;
    local_28 = static_cast<uint>(19);
    uint _e257 = local_28;
    local_69 = static_cast<uint>(_e257);
    uint _e260 = local_69;
    out[_e260] = static_cast<uint>(_e252);
    bool _e262 = Yes;
    local_29 = static_cast<uint>(20);
    uint _e267 = local_29;
    local_70 = static_cast<uint>(_e267);
    uint _e270 = local_70;
    out[_e270] = static_cast<uint>(_e262);
    local_30 = static_cast<uint>(21);
    uint _e276 = local_30;
    local_71 = static_cast<uint>(_e276);
    uint _e279 = local_71;
    out[_e279] = static_cast<uint>(runtime_2);
    VectorCount = 2;
    vectors = type_8 {};
    local_31 = static_cast<uint>(1);
    uint _e288 = local_31;
    local_72 = static_cast<uint>(_e288);
    uint _e291 = local_72;
    int _e293 = input[_e291];
    local_73 = _e293;
    int _e295 = local_73;
    local_43 = _e295;
    int _e297 = local_43;
    vectors.inner[1].y = static_cast<float>(_e297);
    float _e305 = vectors.inner[1].y;
    local_32 = static_cast<uint>(22);
    uint _e310 = local_32;
    local_74 = static_cast<uint>(_e310);
    uint _e313 = local_74;
    out[_e313] = naga_f2u32(_e305);
    {
        Base = type_9 {};
        int _e319 = Base.inner[1];
        local_33 = static_cast<uint>(23);
        uint _e324 = local_33;
        local_75 = static_cast<uint>(_e324);
        uint _e327 = local_75;
        out[_e327] = static_cast<uint>(_e319);
    }
    {
        i = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e356 = i;
                i = as_type<int>(as_type<uint>(_e356) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e331 = i;
            if (_e331 < 3) {
            } else {
                break;
            }
            Count = 3;
            scratch = type_3 {};
            int _e340 = scratch.inner[2];
            int _e342 = i;
            local_34 = static_cast<uint>(as_type<int>(as_type<uint>(24) + as_type<uint>(_e342)));
            uint _e347 = local_34;
            local_76 = static_cast<uint>(_e347);
            uint _e350 = local_76;
            out[_e350] = static_cast<uint>(_e340);
            int _e352 = i;
            scratch.inner[2] = as_type<int>(as_type<uint>(runtime_2) + as_type<uint>(_e352));
        }
    }
    local_36 = static_cast<uint>(1);
    uint _e362 = local_36;
    local_77 = static_cast<uint>(_e362);
    uint _e365 = local_77;
    int _e367 = input[_e365];
    local_78 = _e367;
    int _e369 = local_78;
    local_44 = _e369;
    int _e371 = local_44;
    int _e372 = accumulate(_e371);
    local_35 = static_cast<uint>(27);
    uint _e377 = local_35;
    local_79 = static_cast<uint>(_e377);
    uint _e380 = local_79;
    out[_e380] = static_cast<uint>(_e372);
    local_37 = static_cast<uint>(28);
    uint _e387 = local_37;
    local_80 = static_cast<uint>(_e387);
    uint _e390 = local_80;
    out[_e390] = static_cast<uint>(Second);
    Safe = 3;
    local_40 = static_cast<uint>(1);
    uint _e397 = local_40;
    local_81 = static_cast<uint>(_e397);
    uint _e400 = local_81;
    int _e402 = input[_e400];
    local_82 = _e402;
    int _e404 = local_82;
    local_45 = _e404;
    int _e406 = local_45;
    int _e408 = Safe;
    local_39 = static_cast<uint>(29);
    uint _e416 = local_39;
    local_83 = static_cast<uint>(_e416);
    uint _e419 = local_83;
    out[_e419] = static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(runtime_2) + as_type<uint>(_e406))) + as_type<uint>(_e408))) - as_type<uint>(3)));
}
