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
    int local_12 = {};
    type_3 local_13 = {};
    int total = {};
    int i_1 = {};
    runtime_1 = runtime;
    Size_1 = 3;
    local_13 = type_3 {};
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
            local_13.inner[_e16] = as_type<int>(as_type<uint>(_e18) + as_type<uint>(_e19));
            int _e21 = i_1;
            int _e23 = local_13.inner[_e21];
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
    int Chosen = {};
    int local = {};
    int Size = {};
    type_6 values = {};
    int SignedHigh = {};
    uint local_1 = {};
    int Negative = {};
    uint local_2 = {};
    uint All = {};
    uint Wrapped = {};
    uint local_3 = {};
    uint TruncatedZero = {};
    int Minimum = {};
    uint Large = {};
    bool Ready = {};
    int Comma = {};
    int Lazy = {};
    int local_4 = {};
    bool Skipped = {};
    bool local_5 = {};
    bool Yes = {};
    bool local_6 = {};
    int VectorCount = {};
    type_8 vectors = {};
    type_9 Base = {};
    uint local_7 = {};
    int i = {};
    int Count = {};
    type_3 scratch = {};
    uint local_8 = {};
    int Safe = {};
    int local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    int runtime_2 = input[static_cast<uint>(0)];
    Chosen = 3;
    Size = 4;
    values = type_6 {};
    values.inner[0] = runtime_2;
    int _e16 = input[static_cast<uint>(1)];
    int _e17 = Size;
    values.inner[_e17] = _e16;
    out[static_cast<uint>(0)] = static_cast<uint>(Base_1);
    out[static_cast<uint>(1)] = High;
    out[static_cast<uint>(2)] = as_type<uint>(Scale);
    int _e34 = Chosen;
    out[static_cast<uint>(3)] = static_cast<uint>(_e34);
    int _e39 = accumulate(runtime_2);
    out[static_cast<uint>(4)] = static_cast<uint>(_e39);
    int _e44 = Size;
    int _e46 = values.inner[_e44];
    out[static_cast<uint>(5)] = static_cast<uint>(_e46);
    int _e53 = values.inner[1];
    out[static_cast<uint>(6)] = static_cast<uint>(_e53);
    out[static_cast<uint>(7)] = naga_f2u32(static_cast<float>(runtime_2) * Scale);
    SignedHigh = (-2147483647 - 1);
    Negative = -2;
    All = 4294967295u;
    Wrapped = 0u;
    int _e73 = SignedHigh;
    out[static_cast<uint>(8)] = static_cast<uint>(_e73);
    int _e78 = Negative;
    out[static_cast<uint>(9)] = static_cast<uint>(_e78);
    uint _e83 = All;
    out[static_cast<uint>(10)] = _e83;
    uint _e87 = Wrapped;
    out[static_cast<uint>(11)] = _e87;
    TruncatedZero = 0u;
    Minimum = (-2147483647 - 1);
    Large = 4294967040u;
    Ready = true;
    uint _e99 = TruncatedZero;
    out[static_cast<uint>(12)] = _e99;
    int _e103 = Minimum;
    out[static_cast<uint>(13)] = static_cast<uint>(_e103);
    uint _e108 = Large;
    out[static_cast<uint>(14)] = _e108;
    bool _e112 = Ready;
    out[static_cast<uint>(15)] = static_cast<uint>(_e112);
    Comma = 4;
    Lazy = 6;
    int _e121 = Comma;
    out[static_cast<uint>(16)] = static_cast<uint>(_e121);
    int _e126 = Lazy;
    out[static_cast<uint>(17)] = static_cast<uint>(_e126);
    out[static_cast<uint>(18)] = static_cast<uint>(runtime_2);
    Skipped = false;
    Yes = true;
    bool _e139 = Skipped;
    out[static_cast<uint>(19)] = static_cast<uint>(_e139);
    bool _e144 = Yes;
    out[static_cast<uint>(20)] = static_cast<uint>(_e144);
    out[static_cast<uint>(21)] = static_cast<uint>(runtime_2);
    VectorCount = 2;
    vectors = type_8 {};
    int _e160 = input[static_cast<uint>(1)];
    vectors.inner[1].y = static_cast<float>(_e160);
    float _e168 = vectors.inner[1].y;
    out[static_cast<uint>(22)] = naga_f2u32(_e168);
    {
        Base = type_9 {};
        int _e177 = Base.inner[1];
        local_7 = static_cast<uint>(23);
        uint _e182 = local_7;
        local_10 = _e182;
        uint _e184 = local_10;
        out[_e184] = static_cast<uint>(_e177);
    }
    {
        i = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e212 = i;
                i = as_type<int>(as_type<uint>(_e212) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e188 = i;
            if (_e188 < 3) {
            } else {
                break;
            }
            Count = 3;
            scratch = type_3 {};
            int _e197 = scratch.inner[2];
            int _e199 = i;
            local_8 = static_cast<uint>(as_type<int>(as_type<uint>(24) + as_type<uint>(_e199)));
            uint _e204 = local_8;
            local_11 = _e204;
            uint _e206 = local_11;
            out[_e206] = static_cast<uint>(_e197);
            int _e208 = i;
            scratch.inner[2] = as_type<int>(as_type<uint>(runtime_2) + as_type<uint>(_e208));
        }
    }
    int _e218 = input[static_cast<uint>(1)];
    int _e219 = accumulate(_e218);
    out[static_cast<uint>(27)] = static_cast<uint>(_e219);
    out[static_cast<uint>(28)] = static_cast<uint>(Second);
    Safe = 3;
    int _e234 = input[static_cast<uint>(1)];
    int _e236 = Safe;
    out[static_cast<uint>(29)] = static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(runtime_2) + as_type<uint>(_e234))) + as_type<uint>(_e236))) - as_type<uint>(3)));
}
