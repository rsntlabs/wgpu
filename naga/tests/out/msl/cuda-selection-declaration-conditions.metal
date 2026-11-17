// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_1[1];
typedef uint type_3[1];

uint _naga_fabsf(
    uint input_bits
) {
    uint _e2 = input_bits & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct selection_conditionsInput {
};
kernel void selection_conditions(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_1 const& input [[buffer(0)]]
, device type_3& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    int cursor = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    int header = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    int state = {};
    uint local_10 = {};
    int fixed = {};
    int pass = {};
    int skip = {};
    bool stop = {};
    uint local_11 = {};
    int nested = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    float fraction = {};
    uint local_15 = {};
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
    uint lane = threadIdx.x + (blockIdx.x * 4u);
    if (lane >= 4u) {
        return;
    }
    uint base = 4u + (lane * 12u);
    cursor = 0;
    int _e15 = cursor;
    cursor = as_type<int>(as_type<uint>(_e15) + as_type<uint>(1));
    local = static_cast<uint>(lane + static_cast<uint>(_e15));
    uint _e22 = local;
    int selected = input[_e22];
    if (selected != 0) {
        local_1 = base;
        uint _e32 = local_1;
        local_18 = _e32;
        uint _e34 = local_18;
        output[_e34] = static_cast<uint>(as_type<int>(as_type<uint>(selected) + as_type<uint>(100)));
    } else {
        local_2 = base;
        uint _e41 = local_2;
        local_19 = _e41;
        uint _e43 = local_19;
        output[_e43] = static_cast<uint>(as_type<int>(as_type<uint>(selected) + as_type<uint>(200)));
    }
    int _e46 = cursor;
    local_3 = static_cast<uint>(base + 1u);
    uint _e52 = local_3;
    output[_e52] = static_cast<uint>(_e46);
    header = 50;
    int header_1 = input[lane];
    if (header_1 != 0) {
        local_4 = static_cast<uint>(base + 2u);
        uint _e68 = local_4;
        local_20 = _e68;
        uint _e70 = local_20;
        output[_e70] = static_cast<uint>(as_type<int>(as_type<uint>(header_1) + as_type<uint>(300)));
    } else {
        local_5 = static_cast<uint>(base + 2u);
        uint _e79 = local_5;
        local_21 = _e79;
        uint _e81 = local_21;
        output[_e81] = static_cast<uint>(as_type<int>(as_type<uint>(header_1) + as_type<uint>(400)));
    }
    int _e83 = header;
    local_6 = static_cast<uint>(base + 3u);
    uint _e89 = local_6;
    output[_e89] = static_cast<uint>(_e83);
    local_7 = static_cast<uint>(lane + 4u);
    uint _e95 = local_7;
    int seed = input[_e95];
    bool ready = seed > 0;
    if (ready) {
        local_8 = static_cast<uint>(base + 4u);
        uint _e107 = local_8;
        local_22 = _e107;
        uint _e109 = local_22;
        output[_e109] = static_cast<uint>(as_type<int>(as_type<uint>(seed) + as_type<uint>(500)));
    } else {
        local_9 = static_cast<uint>(base + 4u);
        uint _e118 = local_9;
        local_23 = _e118;
        uint _e120 = local_23;
        output[_e120] = static_cast<uint>(as_type<int>(as_type<uint>(seed) + as_type<uint>(600)));
    }
    state = 0;
    int _e124 = cursor;
    cursor = as_type<int>(as_type<uint>(_e124) + as_type<uint>(1));
    uint mode = naga_mod(lane, 3u);
    switch(mode) {
        case 0u: {
            int _e129 = state;
            state = as_type<int>(as_type<uint>(_e129) + as_type<uint>(10));
            break;
        }
        case 1u: {
            int _e132 = state;
            state = as_type<int>(as_type<uint>(_e132) + as_type<uint>(20));
            int _e135 = state;
            state = as_type<int>(as_type<uint>(_e135) + as_type<uint>(30));
            break;
        }
        default: {
            int _e138 = state;
            state = as_type<int>(as_type<uint>(_e138) + as_type<uint>(30));
            break;
        }
    }
    int _e141 = state;
    local_10 = static_cast<uint>(base + 5u);
    uint _e147 = local_10;
    output[_e147] = static_cast<uint>(_e141);
    fixed = 2;
    int _e151 = fixed;
    switch(_e151) {
        case 2: {
            int _e152 = state;
            state = as_type<int>(as_type<uint>(_e152) + as_type<uint>(7));
            break;
        }
        default: {
            break;
        }
    }
    {
        pass = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e178 = pass;
                pass = as_type<int>(as_type<uint>(_e178) + as_type<uint>(1));
            }
            loop_init = false;
            int _e157 = pass;
            if (_e157 < 4) {
            } else {
                break;
            }
            int _e160 = pass;
            skip = static_cast<int>(_e160 == 1);
            int _e165 = skip;
            if (_e165 != 0) {
                continue;
            }
            int _e168 = pass;
            stop = _e168 == 3;
            bool _e172 = stop;
            if (_e172) {
                break;
            }
            int _e173 = pass;
            int _e176 = state;
            state = as_type<int>(as_type<uint>(_e176) + as_type<uint>(as_type<int>(as_type<uint>(_e173) + as_type<uint>(1))));
        }
    }
    int _e181 = state;
    local_11 = static_cast<uint>(base + 6u);
    uint _e187 = local_11;
    output[_e187] = static_cast<uint>(_e181);
    int nested_1 = input[lane];
    if (nested_1 != 0) {
        {
            nested = 9;
            int _e195 = nested;
            int _e196 = state;
            state = as_type<int>(as_type<uint>(_e196) + as_type<uint>(_e195));
        }
        local_12 = static_cast<uint>(base + 7u);
        uint _e205 = local_12;
        local_24 = _e205;
        uint _e207 = local_24;
        output[_e207] = static_cast<uint>(as_type<int>(as_type<uint>(nested_1) + as_type<uint>(700)));
    } else {
        local_13 = static_cast<uint>(base + 7u);
        uint _e213 = local_13;
        local_25 = _e213;
        uint _e215 = local_25;
        output[_e215] = 800u;
    }
    int _e218 = state;
    local_14 = static_cast<uint>(base + 8u);
    uint _e224 = local_14;
    output[_e224] = static_cast<uint>(_e218);
    fraction = 0.5;
    float _e228 = fraction;
    uint _e230 = _naga_fabsf(as_type<uint>(_e228));
    if (_e230 != 0u) {
        int _e233 = state;
        state = as_type<int>(as_type<uint>(_e233) + as_type<uint>(1));
    }
    int _e236 = state;
    local_15 = static_cast<uint>(base + 9u);
    uint _e242 = local_15;
    output[_e242] = static_cast<uint>(_e236);
    int _e245 = input[lane];
    if (_e245 != 0) {
        int _e248 = state;
        state = as_type<int>(as_type<uint>(_e248) + as_type<uint>(1));
    }
    int _e251 = state;
    local_16 = static_cast<uint>(base + 10u);
    uint _e257 = local_16;
    output[_e257] = static_cast<uint>(_e251);
    int _e259 = cursor;
    local_17 = static_cast<uint>(base + 11u);
    uint _e265 = local_17;
    output[_e265] = static_cast<uint>(_e259);
}
