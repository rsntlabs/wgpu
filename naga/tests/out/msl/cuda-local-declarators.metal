// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_1[1];
struct type_3 {
    uint value;
    char _pad1[12];
};

int cached_type(
    int value_1
) {
    int next = as_type<int>(as_type<uint>(value_1) + as_type<uint>(1));
    int result = as_type<int>(as_type<uint>(next) * as_type<uint>(2));
    return result;
}

int pair_add(
    int left,
    int right
) {
    return as_type<int>(as_type<uint>(left) + as_type<uint>(right));
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct local_declaratorsInput {
};
kernel void local_declarators(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, device type_1 const& input [[user(fake0)]]
, constant type_3& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint base = {};
    int value = {};
    uint local = {};
    int first = {};
    int second = {};
    int third = {};
    uint local_1 = {};
    uint local_2 = {};
    int omitted = {};
    int initialized = {};
    int final = {};
    uint local_3 = {};
    int fixed = {};
    int fixed_next = {};
    uint local_4 = {};
    int alias_first = {};
    int alias_next = {};
    uint local_5 = {};
    bool positive = {};
    bool same = {};
    bool local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    float low = {};
    float high = {};
    uint local_9 = {};
    uint start = {};
    uint finish = {};
    uint local_10 = {};
    uint local_11 = {};
    int outside = {};
    int outside_1 = {};
    int derived = {};
    uint local_12 = {};
    int total = {};
    int iteration = {};
    int seed = {};
    int term = {};
    int copied = {};
    uint local_13 = {};
    int from_call = {};
    int from_prior = {};
    uint local_14 = {};
    int local_15 = {};
    int local_16 = {};
    uint local_17 = {};
    int local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    int local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 12u;
        local = static_cast<uint>(i);
        uint _e16 = local;
        local_17 = static_cast<uint>(_e16);
        uint _e19 = local_17;
        int _e22 = input[_e19];
        local_18 = _e22;
        int _e24 = local_18;
        local_15 = _e24;
        int _e26 = local_15;
        value = _e26;
        int _e28 = value;
        value = as_type<int>(as_type<uint>(_e28) + as_type<uint>(1));
        first = _e28;
        int _e32 = value;
        value = as_type<int>(as_type<uint>(_e32) + as_type<uint>(1));
        second = _e32;
        int _e36 = value;
        third = _e36;
        int _e38 = first;
        int _e41 = second;
        int _e45 = third;
        uint _e47 = base;
        local_1 = static_cast<uint>(_e47);
        uint _e50 = local_1;
        local_19 = static_cast<uint>(_e50);
        uint _e53 = local_19;
        out[_e53] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e38) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e41) * as_type<uint>(10))))) + as_type<uint>(_e45));
        int _e56 = value;
        uint _e57 = base;
        local_2 = static_cast<uint>(_e57 + 1u);
        uint _e62 = local_2;
        local_20 = static_cast<uint>(_e62);
        uint _e65 = local_20;
        out[_e65] = _e56;
        int _e67 = value;
        initialized = as_type<int>(as_type<uint>(_e67) + as_type<uint>(3));
        int _e71 = initialized;
        omitted = as_type<int>(as_type<uint>(_e71) + as_type<uint>(2));
        int _e75 = omitted;
        int _e76 = initialized;
        final = as_type<int>(as_type<uint>(_e75) + as_type<uint>(_e76));
        int _e79 = final;
        uint _e80 = base;
        local_3 = static_cast<uint>(_e80 + 2u);
        uint _e85 = local_3;
        local_21 = static_cast<uint>(_e85);
        uint _e88 = local_21;
        out[_e88] = _e79;
        int _e90 = value;
        fixed = as_type<int>(as_type<uint>(_e90) + as_type<uint>(1));
        int _e94 = fixed;
        fixed_next = as_type<int>(as_type<uint>(_e94) + as_type<uint>(2));
        int _e98 = fixed_next;
        uint _e99 = base;
        local_4 = static_cast<uint>(_e99 + 3u);
        uint _e104 = local_4;
        local_22 = static_cast<uint>(_e104);
        uint _e107 = local_22;
        out[_e107] = _e98;
        int _e109 = value;
        alias_first = as_type<int>(as_type<uint>(_e109) + as_type<uint>(4));
        int _e113 = alias_first;
        alias_next = as_type<int>(as_type<uint>(_e113) + as_type<uint>(1));
        int _e117 = alias_next;
        uint _e118 = base;
        local_5 = static_cast<uint>(_e118 + 4u);
        uint _e123 = local_5;
        local_23 = static_cast<uint>(_e123);
        uint _e126 = local_23;
        out[_e126] = _e117;
        int _e128 = value;
        positive = _e128 > 0;
        bool _e132 = positive;
        local_6 = _e132;
        if (_e132) {
            local_7 = static_cast<uint>(i);
            uint _e136 = local_7;
            local_24 = static_cast<uint>(_e136);
            uint _e139 = local_24;
            int _e141 = input[_e139];
            local_25 = _e141;
            int _e143 = local_25;
            local_16 = _e143;
            int _e145 = local_16;
            int _e148 = value;
            local_6 = _e148 == as_type<int>(as_type<uint>(_e145) + as_type<uint>(2));
        }
        bool _e150 = local_6;
        same = _e150;
        bool _e152 = same;
        uint _e153 = base;
        local_8 = static_cast<uint>(_e153 + 5u);
        uint _e159 = local_8;
        local_26 = static_cast<uint>(_e159);
        uint _e162 = local_26;
        out[_e162] = static_cast<int>(_e152);
        int _e164 = value;
        low = static_cast<float>(_e164) * 0.5;
        float _e169 = low;
        high = _e169 + 1.5;
        float _e173 = high;
        uint _e177 = base;
        local_9 = static_cast<uint>(_e177 + 6u);
        uint _e182 = local_9;
        local_27 = static_cast<uint>(_e182);
        uint _e185 = local_27;
        out[_e185] = naga_f2i32(_e173 * 2.0);
        start = naga_mod(i, 5u);
        uint _e190 = start;
        finish = _e190 + 3u;
        uint _e194 = finish;
        uint _e195 = base;
        local_10 = static_cast<uint>(_e195 + 7u);
        uint _e201 = local_10;
        local_28 = static_cast<uint>(_e201);
        uint _e204 = local_28;
        out[_e204] = static_cast<int>(_e194);
        int _e206 = value;
        int _e207 = cached_type(_e206);
        uint _e208 = base;
        local_11 = static_cast<uint>(_e208 + 8u);
        uint _e213 = local_11;
        local_29 = static_cast<uint>(_e213);
        uint _e216 = local_29;
        out[_e216] = _e207;
        int _e218 = value;
        outside = _e218;
        {
            int _e220 = value;
            outside_1 = as_type<int>(as_type<uint>(_e220) + as_type<uint>(5));
            int _e224 = outside_1;
            derived = as_type<int>(as_type<uint>(_e224) + as_type<uint>(2));
            int _e228 = derived;
            uint _e229 = base;
            local_12 = static_cast<uint>(_e229 + 9u);
            uint _e234 = local_12;
            local_30 = static_cast<uint>(_e234);
            uint _e237 = local_30;
            out[_e237] = _e228;
        }
        total = 0;
        {
            iteration = 0;
            int _e243 = value;
            seed = _e243;
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e260 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e260) + as_type<uint>(1));
                }
                loop_init = false;
                int _e245 = iteration;
                if (_e245 < 4) {
                } else {
                    break;
                }
                int _e248 = iteration;
                if (_e248 == 1) {
                    continue;
                }
                int _e251 = seed;
                int _e252 = iteration;
                term = as_type<int>(as_type<uint>(_e251) + as_type<uint>(_e252));
                int _e255 = term;
                copied = _e255;
                int _e257 = copied;
                int _e258 = total;
                total = as_type<int>(as_type<uint>(_e258) + as_type<uint>(_e257));
            }
        }
        int _e263 = total;
        uint _e264 = base;
        local_13 = static_cast<uint>(_e264 + 10u);
        uint _e269 = local_13;
        local_31 = static_cast<uint>(_e269);
        uint _e272 = local_31;
        out[_e272] = _e263;
        int _e274 = value;
        int _e276 = pair_add(_e274, 2);
        from_call = _e276;
        int _e278 = from_call;
        int _e280 = pair_add(_e278, 3);
        from_prior = _e280;
        int _e282 = from_prior;
        int _e283 = outside;
        uint _e285 = base;
        local_14 = static_cast<uint>(_e285 + 11u);
        uint _e290 = local_14;
        local_32 = static_cast<uint>(_e290);
        uint _e293 = local_32;
        out[_e293] = as_type<int>(as_type<uint>(_e282) + as_type<uint>(_e283));
    }
}
