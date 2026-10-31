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
        local = static_cast<uint>(i_1);
        uint _e16 = local;
        local_14 = static_cast<uint>(_e16);
        uint _e19 = local_14;
        int _e22 = input[_e19];
        local_15 = _e22;
        int _e24 = local_15;
        local_13 = _e24;
        int _e26 = local_13;
        value = _e26;
        if (naga_mod(i_1, 2u) == 0u) {
            int _e32 = value;
            chosen = as_type<int>(as_type<uint>(_e32) + as_type<uint>(7));
        } else {
            int _e36 = value;
            chosen = as_type<int>(as_type<uint>(_e36) - as_type<uint>(4));
        }
        int _e41 = chosen;
        uint _e42 = base;
        local_1 = static_cast<uint>(_e42);
        uint _e45 = local_1;
        local_16 = static_cast<uint>(_e45);
        uint _e48 = local_16;
        out[_e48] = _e41;
        int _e51 = value;
        int _e56 = select_value(_e51, naga_mod(i_1, 3u) == 0u);
        uint _e57 = base;
        local_2 = static_cast<uint>(_e57 + 1u);
        uint _e62 = local_2;
        local_17 = static_cast<uint>(_e62);
        uint _e65 = local_17;
        out[_e65] = _e56;
        int _e67 = value;
        weighted = (static_cast<float>(_e67) * 1.5) + 2.0;
        float _e74 = weighted;
        uint _e76 = base;
        local_3 = static_cast<uint>(_e76 + 2u);
        uint _e81 = local_3;
        local_18 = static_cast<uint>(_e81);
        uint _e84 = local_18;
        out[_e84] = naga_f2i32(_e74);
        int _e86 = value;
        negative = _e86 < 0;
        bool _e90 = negative;
        uint _e91 = base;
        local_4 = static_cast<uint>(_e91 + 3u);
        uint _e97 = local_4;
        local_19 = static_cast<uint>(_e97);
        uint _e100 = local_19;
        out[_e100] = static_cast<int>(_e90);
        int _e102 = value;
        magnitude = static_cast<uint>(as_type<int>(as_type<uint>(_e102) + as_type<uint>(5)));
        uint _e107 = magnitude;
        uint _e110 = base;
        local_5 = static_cast<uint>(_e110 + 4u);
        uint _e116 = local_5;
        local_20 = static_cast<uint>(_e116);
        uint _e119 = local_20;
        out[_e119] = static_cast<int>(_e107 * 3u);
        uint _e123 = accumulate(naga_mod(i_1, 5u));
        uint _e124 = base;
        local_6 = static_cast<uint>(_e124 + 5u);
        uint _e130 = local_6;
        local_21 = static_cast<uint>(_e130);
        uint _e133 = local_21;
        out[_e133] = static_cast<int>(_e123);
        total = 0;
        {
            iteration = 0;
            uint2 loop_bound_1 = uint2(4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (metal::all(loop_bound_1 == uint2(0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e149 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e149) + as_type<uint>(1));
                }
                loop_init_1 = false;
                int _e139 = iteration;
                if (_e139 < 3) {
                } else {
                    break;
                }
                int _e142 = value;
                int _e143 = iteration;
                copied = as_type<int>(as_type<uint>(_e142) + as_type<uint>(_e143));
                int _e146 = copied;
                int _e147 = total;
                total = as_type<int>(as_type<uint>(_e147) + as_type<uint>(_e146));
            }
        }
        int _e152 = total;
        uint _e153 = base;
        local_7 = static_cast<uint>(_e153 + 6u);
        uint _e158 = local_7;
        local_22 = static_cast<uint>(_e158);
        uint _e161 = local_22;
        out[_e161] = _e152;
        descending = 0;
        iteration_1 = 0;
        {
            uint2 loop_bound_2 = uint2(4294967295u);
            bool loop_init_2 = true;
            while(true) {
                if (metal::all(loop_bound_2 == uint2(0u))) { break; }
                loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
                if (!loop_init_2) {
                    int _e177 = iteration_1;
                    iteration_1 = as_type<int>(as_type<uint>(_e177) + as_type<uint>(1));
                }
                loop_init_2 = false;
                int _e167 = iteration_1;
                if (_e167 < 3) {
                } else {
                    break;
                }
                int _e170 = value;
                int _e171 = iteration_1;
                staged = as_type<int>(as_type<uint>(_e170) - as_type<uint>(_e171));
                int _e174 = staged;
                int _e175 = descending;
                descending = as_type<int>(as_type<uint>(_e175) + as_type<uint>(_e174));
            }
        }
        int _e180 = descending;
        uint _e181 = base;
        local_8 = static_cast<uint>(_e181 + 7u);
        uint _e186 = local_8;
        local_23 = static_cast<uint>(_e186);
        uint _e189 = local_23;
        out[_e189] = _e180;
        remaining = 2;
        int _e193 = value;
        partial = _e193;
        uint2 loop_bound_3 = uint2(4294967295u);
        while(true) {
            if (metal::all(loop_bound_3 == uint2(0u))) { break; }
            loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
            int _e195 = remaining;
            if (_e195 > 0) {
            } else {
                break;
            }
            {
                int _e198 = partial;
                int _e199 = remaining;
                next = as_type<int>(as_type<uint>(_e198) + as_type<uint>(_e199));
                int _e202 = next;
                partial = _e202;
                int _e203 = remaining;
                remaining = as_type<int>(as_type<uint>(_e203) - as_type<uint>(1));
            }
        }
        int _e206 = partial;
        uint _e207 = base;
        local_9 = static_cast<uint>(_e207 + 8u);
        uint _e212 = local_9;
        local_24 = static_cast<uint>(_e212);
        uint _e215 = local_24;
        out[_e215] = _e206;
        int _e217 = value;
        shadow = _e217;
        {
            int _e219 = value;
            shadow_1 = as_type<int>(as_type<uint>(_e219) + as_type<uint>(10));
            int _e223 = shadow_1;
            uint _e224 = base;
            local_10 = static_cast<uint>(_e224 + 9u);
            uint _e229 = local_10;
            local_25 = static_cast<uint>(_e229);
            uint _e232 = local_25;
            out[_e232] = _e223;
        }
        int _e234 = shadow;
        uint _e235 = base;
        local_11 = static_cast<uint>(_e235 + 10u);
        uint _e240 = local_11;
        local_26 = static_cast<uint>(_e240);
        uint _e243 = local_26;
        out[_e243] = _e234;
        int _e245 = value;
        float _e247 = scaled(static_cast<float>(_e245));
        uint _e248 = base;
        local_12 = static_cast<uint>(_e248 + 11u);
        uint _e254 = local_12;
        local_27 = static_cast<uint>(_e254);
        uint _e257 = local_27;
        out[_e257] = naga_f2i32(_e247);
    }
}
