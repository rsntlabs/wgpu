// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef int type_4[1];
struct type_5 {
    uint value;
    char _pad1[12];
};

float affine(
    float value_1,
    float scale,
    int offset
) {
    float value_2 = {};
    value_2 = value_1;
    float _e4 = value_2;
    value_2 = _e4 * scale;
    float _e6 = value_2;
    return _e6 + static_cast<float>(offset);
}

bool nonnegative(
    int value_3
) {
    return value_3 >= 0;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

uint sum_steps(
    uint count,
    bool include_even
) {
    uint total = {};
    uint i = {};
    bool local_20 = {};
    total = 0u;
    {
        i = 0u;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e18 = i;
                i = _e18 + static_cast<uint>(1);
            }
            loop_init = false;
            uint _e6 = i;
            if (_e6 < count) {
            } else {
                break;
            }
            local_20 = include_even;
            if (include_even) {
            } else {
                uint _e9 = i;
                local_20 = naga_mod(_e9, 2u) != 0u;
            }
            bool _e14 = local_20;
            if (_e14) {
                uint _e15 = i;
                uint _e16 = total;
                total = _e16 + _e15;
            }
        }
    }
    uint _e22 = total;
    return _e22;
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

int choose(
    int value_4
) {
    bool _e1 = nonnegative(value_4);
    if (_e1) {
        float _e5 = affine(static_cast<float>(value_4), 2.0, 1);
        return naga_f2i32(_e5);
    }
    return naga_neg(value_4);
}

int pair(
    int a,
    int b
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(a) * as_type<uint>(10))) + as_type<uint>(b));
}

struct device_functionsInput {
};
kernel void device_functions(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4& out [[user(fake0)]]
, constant type_5& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint base = {};
    int value = {};
    int argument = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint n_1 = n.value;
    uint i_1 = (blockIdx.x * 64u) + threadIdx.x;
    if (i_1 < n_1) {
        base = i_1 * 10u;
        value = as_type<int>(as_type<uint>(static_cast<int>(i_1)) - as_type<uint>(35));
        argument = 3;
        int _e20 = value;
        int _e21 = choose(_e20);
        uint _e22 = base;
        local = static_cast<uint>(_e22);
        uint _e25 = local;
        local_10 = static_cast<uint>(_e25);
        uint _e28 = local_10;
        out[_e28] = _e21;
        int _e31 = value;
        float _e35 = affine(static_cast<float>(_e31), 1.5, 2);
        uint _e36 = base;
        local_1 = static_cast<uint>(_e36 + 1u);
        uint _e42 = local_1;
        local_11 = static_cast<uint>(_e42);
        uint _e45 = local_11;
        out[_e45] = naga_f2i32(_e35);
        uint _e50 = sum_steps(static_cast<uint>(5), true);
        uint _e51 = base;
        local_2 = static_cast<uint>(_e51 + 2u);
        uint _e57 = local_2;
        local_12 = static_cast<uint>(_e57);
        uint _e60 = local_12;
        out[_e60] = static_cast<int>(_e50);
        uint _e66 = sum_steps(5u, 0 != 0);
        uint _e67 = base;
        local_3 = static_cast<uint>(_e67 + 3u);
        uint _e73 = local_3;
        local_13 = static_cast<uint>(_e73);
        uint _e76 = local_13;
        out[_e76] = static_cast<int>(_e66);
        int _e78 = value;
        float _e84 = affine(static_cast<float>(_e78), static_cast<float>(2u), static_cast<int>(true));
        uint _e85 = base;
        local_4 = static_cast<uint>(_e85 + 4u);
        uint _e91 = local_4;
        local_14 = static_cast<uint>(_e91);
        uint _e94 = local_14;
        out[_e94] = naga_f2i32(_e84);
        int _e96 = value;
        uint _e97 = base;
        local_5 = static_cast<uint>(_e97 + 5u);
        uint _e102 = local_5;
        local_15 = static_cast<uint>(_e102);
        uint _e105 = local_15;
        out[_e105] = _e96;
        int _e107 = value;
        int _e108 = choose(_e107);
        int _e109 = value;
        int _e112 = choose(as_type<int>(as_type<uint>(_e109) + as_type<uint>(1)));
        uint _e114 = base;
        local_6 = static_cast<uint>(_e114 + 6u);
        uint _e119 = local_6;
        local_16 = static_cast<uint>(_e119);
        uint _e122 = local_16;
        out[_e122] = as_type<int>(as_type<uint>(_e108) + as_type<uint>(_e112));
        int _e124 = value;
        bool _e125 = nonnegative(_e124);
        uint _e126 = base;
        local_7 = static_cast<uint>(_e126 + 7u);
        uint _e132 = local_7;
        local_17 = static_cast<uint>(_e132);
        uint _e135 = local_17;
        out[_e135] = static_cast<int>(_e125);
        int _e137 = argument;
        int _e138 = argument;
        argument = as_type<int>(as_type<uint>(_e138) + as_type<uint>(1));
        int _e141 = pair(_e137, _e138);
        uint _e142 = base;
        local_8 = static_cast<uint>(_e142 + 8u);
        uint _e147 = local_8;
        local_18 = static_cast<uint>(_e147);
        uint _e150 = local_18;
        out[_e150] = _e141;
        int _e152 = argument;
        uint _e153 = base;
        local_9 = static_cast<uint>(_e153 + 9u);
        uint _e158 = local_9;
        local_19 = static_cast<uint>(_e158);
        uint _e161 = local_19;
        out[_e161] = _e152;
    }
}
