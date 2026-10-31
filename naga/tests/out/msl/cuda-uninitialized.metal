// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_4[1];
struct type_5 {
    uint value;
    char _pad1[12];
};

int select_value(
    int value_1,
    bool choose_first
) {
    int result = {};
    if (choose_first) {
        result = as_type<int>(as_type<uint>(value_1) + as_type<uint>(3));
    } else {
        result = as_type<int>(as_type<uint>(value_1) - as_type<uint>(2));
    }
    int _e9 = result;
    return _e9;
}

float scaled(
    float value_2
) {
    float result_1 = (value_2 * 2.0) + 4.0;
    return result_1;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

uint accumulate(
    uint limit
) {
    uint sum = {};
    uint i = {};
    uint term = {};
    sum = 0u;
    {
        i = 0u;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e24 = i;
                i = _e24 + static_cast<uint>(1);
            }
            loop_init = false;
            uint _e5 = i;
            if (_e5 < limit) {
            } else {
                break;
            }
            uint _e7 = i;
            if (naga_mod(_e7, 2u) == 0u) {
                uint _e12 = i;
                term = _e12 + 1u;
            } else {
                uint _e16 = i;
                term = _e16 * 2u;
            }
            uint _e21 = term;
            uint _e22 = sum;
            sum = _e22 + _e21;
        }
    }
    uint _e28 = sum;
    return _e28;
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


struct uninitializedInput {
};
kernel void uninitialized(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4& out [[user(fake0)]]
, device type_4 const& input [[user(fake0)]]
, constant type_5& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint base = {};
    int value = {};
    uint local = {};
    int chosen = {};
    uint local_1 = {};
    uint local_2 = {};
    float weighted = {};
    uint local_3 = {};
    bool negative = {};
    uint local_4 = {};
    uint magnitude = {};
    uint local_5 = {};
    uint local_6 = {};
    int total = {};
    int iteration = {};
    int copied = {};
    uint local_7 = {};
    int descending = {};
    int iteration_1 = {};
    int staged = {};
    uint local_8 = {};
    int remaining = {};
    int partial = {};
    int next = {};
    uint local_9 = {};
    int shadow = {};
    int shadow_1 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    int local_13 = {};
    uint local_14 = {};
    int local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint n_1 = n.value;
    uint i_1 = (blockIdx.x * 64u) + threadIdx.x;
    if (i_1 < n_1) {
        base = i_1 * 12u;
        local = i_1;
        uint _e15 = local;
        local_14 = _e15;
        uint _e17 = local_14;
        int _e20 = input[_e17];
        local_15 = _e20;
        int _e22 = local_15;
        local_13 = _e22;
        int _e24 = local_13;
        value = _e24;
        if (naga_mod(i_1, 2u) == 0u) {
            int _e30 = value;
            chosen = as_type<int>(as_type<uint>(_e30) + as_type<uint>(7));
        } else {
            int _e34 = value;
            chosen = as_type<int>(as_type<uint>(_e34) - as_type<uint>(4));
        }
        int _e39 = chosen;
        uint _e40 = base;
        local_1 = _e40;
        uint _e42 = local_1;
        local_16 = _e42;
        uint _e44 = local_16;
        out[_e44] = _e39;
        int _e47 = value;
        int _e52 = select_value(_e47, naga_mod(i_1, 3u) == 0u);
        uint _e53 = base;
        local_2 = static_cast<uint>(_e53 + 1u);
        uint _e58 = local_2;
        local_17 = _e58;
        uint _e60 = local_17;
        out[_e60] = _e52;
        int _e62 = value;
        weighted = (static_cast<float>(_e62) * 1.5) + 2.0;
        float _e69 = weighted;
        uint _e71 = base;
        local_3 = static_cast<uint>(_e71 + 2u);
        uint _e76 = local_3;
        local_18 = _e76;
        uint _e78 = local_18;
        out[_e78] = naga_f2i32(_e69);
        int _e80 = value;
        negative = _e80 < 0;
        bool _e84 = negative;
        uint _e85 = base;
        local_4 = static_cast<uint>(_e85 + 3u);
        uint _e91 = local_4;
        local_19 = _e91;
        uint _e93 = local_19;
        out[_e93] = static_cast<int>(_e84);
        int _e95 = value;
        magnitude = static_cast<uint>(as_type<int>(as_type<uint>(_e95) + as_type<uint>(5)));
        uint _e100 = magnitude;
        uint _e103 = base;
        local_5 = static_cast<uint>(_e103 + 4u);
        uint _e109 = local_5;
        local_20 = _e109;
        uint _e111 = local_20;
        out[_e111] = static_cast<int>(_e100 * 3u);
        uint _e115 = accumulate(naga_mod(i_1, 5u));
        uint _e116 = base;
        local_6 = static_cast<uint>(_e116 + 5u);
        uint _e122 = local_6;
        local_21 = _e122;
        uint _e124 = local_21;
        out[_e124] = static_cast<int>(_e115);
        total = 0;
        {
            iteration = 0;
            uint2 loop_bound_1 = uint2(4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (metal::all(loop_bound_1 == uint2(0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e140 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e140) + as_type<uint>(1));
                }
                loop_init_1 = false;
                int _e130 = iteration;
                if (_e130 < 3) {
                } else {
                    break;
                }
                int _e133 = value;
                int _e134 = iteration;
                copied = as_type<int>(as_type<uint>(_e133) + as_type<uint>(_e134));
                int _e137 = copied;
                int _e138 = total;
                total = as_type<int>(as_type<uint>(_e138) + as_type<uint>(_e137));
            }
        }
        int _e143 = total;
        uint _e144 = base;
        local_7 = static_cast<uint>(_e144 + 6u);
        uint _e149 = local_7;
        local_22 = _e149;
        uint _e151 = local_22;
        out[_e151] = _e143;
        descending = 0;
        iteration_1 = 0;
        {
            uint2 loop_bound_2 = uint2(4294967295u);
            bool loop_init_2 = true;
            while(true) {
                if (metal::all(loop_bound_2 == uint2(0u))) { break; }
                loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
                if (!loop_init_2) {
                    int _e167 = iteration_1;
                    iteration_1 = as_type<int>(as_type<uint>(_e167) + as_type<uint>(1));
                }
                loop_init_2 = false;
                int _e157 = iteration_1;
                if (_e157 < 3) {
                } else {
                    break;
                }
                int _e160 = value;
                int _e161 = iteration_1;
                staged = as_type<int>(as_type<uint>(_e160) - as_type<uint>(_e161));
                int _e164 = staged;
                int _e165 = descending;
                descending = as_type<int>(as_type<uint>(_e165) + as_type<uint>(_e164));
            }
        }
        int _e170 = descending;
        uint _e171 = base;
        local_8 = static_cast<uint>(_e171 + 7u);
        uint _e176 = local_8;
        local_23 = _e176;
        uint _e178 = local_23;
        out[_e178] = _e170;
        remaining = 2;
        int _e182 = value;
        partial = _e182;
        uint2 loop_bound_3 = uint2(4294967295u);
        while(true) {
            if (metal::all(loop_bound_3 == uint2(0u))) { break; }
            loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
            int _e184 = remaining;
            if (_e184 > 0) {
            } else {
                break;
            }
            {
                int _e187 = partial;
                int _e188 = remaining;
                next = as_type<int>(as_type<uint>(_e187) + as_type<uint>(_e188));
                int _e191 = next;
                partial = _e191;
                int _e192 = remaining;
                remaining = as_type<int>(as_type<uint>(_e192) - as_type<uint>(1));
            }
        }
        int _e195 = partial;
        uint _e196 = base;
        local_9 = static_cast<uint>(_e196 + 8u);
        uint _e201 = local_9;
        local_24 = _e201;
        uint _e203 = local_24;
        out[_e203] = _e195;
        int _e205 = value;
        shadow = _e205;
        {
            int _e207 = value;
            shadow_1 = as_type<int>(as_type<uint>(_e207) + as_type<uint>(10));
            int _e211 = shadow_1;
            uint _e212 = base;
            local_10 = static_cast<uint>(_e212 + 9u);
            uint _e217 = local_10;
            local_25 = _e217;
            uint _e219 = local_25;
            out[_e219] = _e211;
        }
        int _e221 = shadow;
        uint _e222 = base;
        local_11 = static_cast<uint>(_e222 + 10u);
        uint _e227 = local_11;
        local_26 = _e227;
        uint _e229 = local_26;
        out[_e229] = _e221;
        int _e231 = value;
        float _e233 = scaled(static_cast<float>(_e231));
        uint _e234 = base;
        local_12 = static_cast<uint>(_e234 + 11u);
        uint _e240 = local_12;
        local_27 = _e240;
        uint _e242 = local_27;
        out[_e242] = naga_f2i32(_e233);
    }
}
