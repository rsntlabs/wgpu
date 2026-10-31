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
    int local_43 = {};
    type_3 local_44 = {};
    int total = {};
    int i_1 = {};
    runtime_1 = runtime;
    Size_1 = 3;
    local_44 = type_3 {};
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
            local_44.inner[_e16] = as_type<int>(as_type<uint>(_e18) + as_type<uint>(_e19));
            int _e21 = i_1;
            int _e23 = local_44.inner[_e21];
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
    local = static_cast<uint>(0);
    uint _e3 = local;
    int runtime_2 = input[_e3];
    Chosen = 3;
    Size = 4;
    values = type_6 {};
    values.inner[0] = runtime_2;
    local_2 = static_cast<uint>(1);
    uint _e18 = local_2;
    int _e20 = input[_e18];
    int _e21 = Size;
    values.inner[_e21] = _e20;
    local_3 = static_cast<uint>(0);
    uint _e28 = local_3;
    out[_e28] = static_cast<uint>(Base_1);
    local_4 = static_cast<uint>(1);
    uint _e34 = local_4;
    out[_e34] = High;
    local_5 = static_cast<uint>(2);
    uint _e42 = local_5;
    out[_e42] = as_type<uint>(Scale);
    int _e44 = Chosen;
    local_6 = static_cast<uint>(3);
    uint _e49 = local_6;
    out[_e49] = static_cast<uint>(_e44);
    int _e51 = accumulate(runtime_2);
    local_7 = static_cast<uint>(4);
    uint _e56 = local_7;
    out[_e56] = static_cast<uint>(_e51);
    int _e58 = Size;
    int _e60 = values.inner[_e58];
    local_8 = static_cast<uint>(5);
    uint _e65 = local_8;
    out[_e65] = static_cast<uint>(_e60);
    int _e69 = values.inner[1];
    local_9 = static_cast<uint>(6);
    uint _e74 = local_9;
    out[_e74] = static_cast<uint>(_e69);
    local_10 = static_cast<uint>(7);
    uint _e83 = local_10;
    out[_e83] = naga_f2u32(static_cast<float>(runtime_2) * Scale);
    SignedHigh = (-2147483647 - 1);
    Negative = -2;
    All = 4294967295u;
    Wrapped = 0u;
    int _e93 = SignedHigh;
    local_14 = static_cast<uint>(8);
    uint _e98 = local_14;
    out[_e98] = static_cast<uint>(_e93);
    int _e100 = Negative;
    local_15 = static_cast<uint>(9);
    uint _e105 = local_15;
    out[_e105] = static_cast<uint>(_e100);
    uint _e107 = All;
    local_16 = static_cast<uint>(10);
    uint _e111 = local_16;
    out[_e111] = _e107;
    uint _e113 = Wrapped;
    local_17 = static_cast<uint>(11);
    uint _e117 = local_17;
    out[_e117] = _e113;
    TruncatedZero = 0u;
    Minimum = (-2147483647 - 1);
    Large = 4294967040u;
    Ready = true;
    uint _e127 = TruncatedZero;
    local_18 = static_cast<uint>(12);
    uint _e131 = local_18;
    out[_e131] = _e127;
    int _e133 = Minimum;
    local_19 = static_cast<uint>(13);
    uint _e138 = local_19;
    out[_e138] = static_cast<uint>(_e133);
    uint _e140 = Large;
    local_20 = static_cast<uint>(14);
    uint _e144 = local_20;
    out[_e144] = _e140;
    bool _e146 = Ready;
    local_21 = static_cast<uint>(15);
    uint _e151 = local_21;
    out[_e151] = static_cast<uint>(_e146);
    Comma = 4;
    Lazy = 6;
    int _e157 = Comma;
    local_23 = static_cast<uint>(16);
    uint _e162 = local_23;
    out[_e162] = static_cast<uint>(_e157);
    int _e164 = Lazy;
    local_24 = static_cast<uint>(17);
    uint _e169 = local_24;
    out[_e169] = static_cast<uint>(_e164);
    local_25 = static_cast<uint>(18);
    uint _e175 = local_25;
    out[_e175] = static_cast<uint>(runtime_2);
    Skipped = false;
    Yes = true;
    bool _e181 = Skipped;
    local_28 = static_cast<uint>(19);
    uint _e186 = local_28;
    out[_e186] = static_cast<uint>(_e181);
    bool _e188 = Yes;
    local_29 = static_cast<uint>(20);
    uint _e193 = local_29;
    out[_e193] = static_cast<uint>(_e188);
    local_30 = static_cast<uint>(21);
    uint _e199 = local_30;
    out[_e199] = static_cast<uint>(runtime_2);
    VectorCount = 2;
    vectors = type_8 {};
    local_31 = static_cast<uint>(1);
    uint _e208 = local_31;
    int _e210 = input[_e208];
    vectors.inner[1].y = static_cast<float>(_e210);
    float _e218 = vectors.inner[1].y;
    local_32 = static_cast<uint>(22);
    uint _e223 = local_32;
    out[_e223] = naga_f2u32(_e218);
    {
        Base = type_9 {};
        int _e229 = Base.inner[1];
        local_33 = static_cast<uint>(23);
        uint _e234 = local_33;
        local_41 = _e234;
        uint _e236 = local_41;
        out[_e236] = static_cast<uint>(_e229);
    }
    {
        i = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e264 = i;
                i = as_type<int>(as_type<uint>(_e264) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e240 = i;
            if (_e240 < 3) {
            } else {
                break;
            }
            Count = 3;
            scratch = type_3 {};
            int _e249 = scratch.inner[2];
            int _e251 = i;
            local_34 = static_cast<uint>(as_type<int>(as_type<uint>(24) + as_type<uint>(_e251)));
            uint _e256 = local_34;
            local_42 = _e256;
            uint _e258 = local_42;
            out[_e258] = static_cast<uint>(_e249);
            int _e260 = i;
            scratch.inner[2] = as_type<int>(as_type<uint>(runtime_2) + as_type<uint>(_e260));
        }
    }
    local_36 = static_cast<uint>(1);
    uint _e270 = local_36;
    int _e272 = input[_e270];
    int _e273 = accumulate(_e272);
    local_35 = static_cast<uint>(27);
    uint _e278 = local_35;
    out[_e278] = static_cast<uint>(_e273);
    local_37 = static_cast<uint>(28);
    uint _e285 = local_37;
    out[_e285] = static_cast<uint>(Second);
    Safe = 3;
    local_40 = static_cast<uint>(1);
    uint _e292 = local_40;
    int _e294 = input[_e292];
    int _e296 = Safe;
    local_39 = static_cast<uint>(29);
    uint _e304 = local_39;
    out[_e304] = static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(runtime_2) + as_type<uint>(_e294))) + as_type<uint>(_e296))) - as_type<uint>(3)));
}
