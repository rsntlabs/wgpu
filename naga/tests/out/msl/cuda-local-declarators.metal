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
        local = i;
        uint _e15 = local;
        local_17 = _e15;
        uint _e17 = local_17;
        int _e20 = input[_e17];
        local_18 = _e20;
        int _e22 = local_18;
        local_15 = _e22;
        int _e24 = local_15;
        value = _e24;
        int _e26 = value;
        value = as_type<int>(as_type<uint>(_e26) + as_type<uint>(1));
        first = _e26;
        int _e30 = value;
        value = as_type<int>(as_type<uint>(_e30) + as_type<uint>(1));
        second = _e30;
        int _e34 = value;
        third = _e34;
        int _e36 = first;
        int _e39 = second;
        int _e43 = third;
        uint _e45 = base;
        local_1 = _e45;
        uint _e47 = local_1;
        local_19 = _e47;
        uint _e49 = local_19;
        out[_e49] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e36) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e39) * as_type<uint>(10))))) + as_type<uint>(_e43));
        int _e52 = value;
        uint _e53 = base;
        local_2 = static_cast<uint>(_e53 + 1u);
        uint _e58 = local_2;
        local_20 = _e58;
        uint _e60 = local_20;
        out[_e60] = _e52;
        int _e62 = value;
        initialized = as_type<int>(as_type<uint>(_e62) + as_type<uint>(3));
        int _e66 = initialized;
        omitted = as_type<int>(as_type<uint>(_e66) + as_type<uint>(2));
        int _e70 = omitted;
        int _e71 = initialized;
        final = as_type<int>(as_type<uint>(_e70) + as_type<uint>(_e71));
        int _e74 = final;
        uint _e75 = base;
        local_3 = static_cast<uint>(_e75 + 2u);
        uint _e80 = local_3;
        local_21 = _e80;
        uint _e82 = local_21;
        out[_e82] = _e74;
        int _e84 = value;
        fixed = as_type<int>(as_type<uint>(_e84) + as_type<uint>(1));
        int _e88 = fixed;
        fixed_next = as_type<int>(as_type<uint>(_e88) + as_type<uint>(2));
        int _e92 = fixed_next;
        uint _e93 = base;
        local_4 = static_cast<uint>(_e93 + 3u);
        uint _e98 = local_4;
        local_22 = _e98;
        uint _e100 = local_22;
        out[_e100] = _e92;
        int _e102 = value;
        alias_first = as_type<int>(as_type<uint>(_e102) + as_type<uint>(4));
        int _e106 = alias_first;
        alias_next = as_type<int>(as_type<uint>(_e106) + as_type<uint>(1));
        int _e110 = alias_next;
        uint _e111 = base;
        local_5 = static_cast<uint>(_e111 + 4u);
        uint _e116 = local_5;
        local_23 = _e116;
        uint _e118 = local_23;
        out[_e118] = _e110;
        int _e120 = value;
        positive = _e120 > 0;
        bool _e124 = positive;
        local_6 = _e124;
        if (_e124) {
            local_7 = i;
            uint _e127 = local_7;
            local_24 = _e127;
            uint _e129 = local_24;
            int _e131 = input[_e129];
            local_25 = _e131;
            int _e133 = local_25;
            local_16 = _e133;
            int _e135 = local_16;
            int _e138 = value;
            local_6 = _e138 == as_type<int>(as_type<uint>(_e135) + as_type<uint>(2));
        }
        bool _e140 = local_6;
        same = _e140;
        bool _e142 = same;
        uint _e143 = base;
        local_8 = static_cast<uint>(_e143 + 5u);
        uint _e149 = local_8;
        local_26 = _e149;
        uint _e151 = local_26;
        out[_e151] = static_cast<int>(_e142);
        int _e153 = value;
        low = static_cast<float>(_e153) * 0.5;
        float _e158 = low;
        high = _e158 + 1.5;
        float _e162 = high;
        uint _e166 = base;
        local_9 = static_cast<uint>(_e166 + 6u);
        uint _e171 = local_9;
        local_27 = _e171;
        uint _e173 = local_27;
        out[_e173] = naga_f2i32(_e162 * 2.0);
        start = naga_mod(i, 5u);
        uint _e178 = start;
        finish = _e178 + 3u;
        uint _e182 = finish;
        uint _e183 = base;
        local_10 = static_cast<uint>(_e183 + 7u);
        uint _e189 = local_10;
        local_28 = _e189;
        uint _e191 = local_28;
        out[_e191] = static_cast<int>(_e182);
        int _e193 = value;
        int _e194 = cached_type(_e193);
        uint _e195 = base;
        local_11 = static_cast<uint>(_e195 + 8u);
        uint _e200 = local_11;
        local_29 = _e200;
        uint _e202 = local_29;
        out[_e202] = _e194;
        int _e204 = value;
        outside = _e204;
        {
            int _e206 = value;
            outside_1 = as_type<int>(as_type<uint>(_e206) + as_type<uint>(5));
            int _e210 = outside_1;
            derived = as_type<int>(as_type<uint>(_e210) + as_type<uint>(2));
            int _e214 = derived;
            uint _e215 = base;
            local_12 = static_cast<uint>(_e215 + 9u);
            uint _e220 = local_12;
            local_30 = _e220;
            uint _e222 = local_30;
            out[_e222] = _e214;
        }
        total = 0;
        {
            iteration = 0;
            int _e228 = value;
            seed = _e228;
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e245 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e245) + as_type<uint>(1));
                }
                loop_init = false;
                int _e230 = iteration;
                if (_e230 < 4) {
                } else {
                    break;
                }
                int _e233 = iteration;
                if (_e233 == 1) {
                    continue;
                }
                int _e236 = seed;
                int _e237 = iteration;
                term = as_type<int>(as_type<uint>(_e236) + as_type<uint>(_e237));
                int _e240 = term;
                copied = _e240;
                int _e242 = copied;
                int _e243 = total;
                total = as_type<int>(as_type<uint>(_e243) + as_type<uint>(_e242));
            }
        }
        int _e248 = total;
        uint _e249 = base;
        local_13 = static_cast<uint>(_e249 + 10u);
        uint _e254 = local_13;
        local_31 = _e254;
        uint _e256 = local_31;
        out[_e256] = _e248;
        int _e258 = value;
        int _e260 = pair_add(_e258, 2);
        from_call = _e260;
        int _e262 = from_call;
        int _e264 = pair_add(_e262, 3);
        from_prior = _e264;
        int _e266 = from_prior;
        int _e267 = outside;
        uint _e269 = base;
        local_14 = static_cast<uint>(_e269 + 11u);
        uint _e274 = local_14;
        local_32 = _e274;
        uint _e276 = local_32;
        out[_e276] = as_type<int>(as_type<uint>(_e266) + as_type<uint>(_e267));
    }
}
