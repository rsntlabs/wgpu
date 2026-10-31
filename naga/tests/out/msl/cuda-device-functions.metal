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
        local = _e22;
        uint _e24 = local;
        local_10 = _e24;
        uint _e26 = local_10;
        out[_e26] = _e21;
        int _e29 = value;
        float _e33 = affine(static_cast<float>(_e29), 1.5, 2);
        uint _e34 = base;
        local_1 = static_cast<uint>(_e34 + 1u);
        uint _e40 = local_1;
        local_11 = _e40;
        uint _e42 = local_11;
        out[_e42] = naga_f2i32(_e33);
        uint _e47 = sum_steps(static_cast<uint>(5), true);
        uint _e48 = base;
        local_2 = static_cast<uint>(_e48 + 2u);
        uint _e54 = local_2;
        local_12 = _e54;
        uint _e56 = local_12;
        out[_e56] = static_cast<int>(_e47);
        uint _e62 = sum_steps(5u, 0 != 0);
        uint _e63 = base;
        local_3 = static_cast<uint>(_e63 + 3u);
        uint _e69 = local_3;
        local_13 = _e69;
        uint _e71 = local_13;
        out[_e71] = static_cast<int>(_e62);
        int _e73 = value;
        float _e79 = affine(static_cast<float>(_e73), static_cast<float>(2u), static_cast<int>(true));
        uint _e80 = base;
        local_4 = static_cast<uint>(_e80 + 4u);
        uint _e86 = local_4;
        local_14 = _e86;
        uint _e88 = local_14;
        out[_e88] = naga_f2i32(_e79);
        int _e90 = value;
        uint _e91 = base;
        local_5 = static_cast<uint>(_e91 + 5u);
        uint _e96 = local_5;
        local_15 = _e96;
        uint _e98 = local_15;
        out[_e98] = _e90;
        int _e100 = value;
        int _e101 = choose(_e100);
        int _e102 = value;
        int _e105 = choose(as_type<int>(as_type<uint>(_e102) + as_type<uint>(1)));
        uint _e107 = base;
        local_6 = static_cast<uint>(_e107 + 6u);
        uint _e112 = local_6;
        local_16 = _e112;
        uint _e114 = local_16;
        out[_e114] = as_type<int>(as_type<uint>(_e101) + as_type<uint>(_e105));
        int _e116 = value;
        bool _e117 = nonnegative(_e116);
        uint _e118 = base;
        local_7 = static_cast<uint>(_e118 + 7u);
        uint _e124 = local_7;
        local_17 = _e124;
        uint _e126 = local_17;
        out[_e126] = static_cast<int>(_e117);
        int _e128 = argument;
        int _e129 = argument;
        argument = as_type<int>(as_type<uint>(_e129) + as_type<uint>(1));
        int _e132 = pair(_e128, _e129);
        uint _e133 = base;
        local_8 = static_cast<uint>(_e133 + 8u);
        uint _e138 = local_8;
        local_18 = _e138;
        uint _e140 = local_18;
        out[_e140] = _e132;
        int _e142 = argument;
        uint _e143 = base;
        local_9 = static_cast<uint>(_e143 + 9u);
        uint _e148 = local_9;
        local_19 = _e148;
        uint _e150 = local_19;
        out[_e150] = _e142;
    }
}
