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
    float scale_1 = {};
    int offset_1 = {};
    value_2 = value_1;
    scale_1 = scale;
    offset_1 = offset;
    float _e6 = scale_1;
    float _e7 = value_2;
    value_2 = _e7 * _e6;
    float _e9 = value_2;
    int _e10 = offset_1;
    return _e9 + static_cast<float>(_e10);
}

bool nonnegative(
    int value_3
) {
    int value_4 = {};
    value_4 = value_3;
    int _e3 = value_4;
    return _e3 >= 0;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

uint sum_steps(
    uint count,
    bool include_even
) {
    uint count_1 = {};
    bool include_even_1 = {};
    uint total = {};
    uint i_1 = {};
    bool local_41 = {};
    count_1 = count;
    include_even_1 = include_even;
    total = 0u;
    {
        i_1 = 0u;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e11 = i_1;
                i_1 = _e11 + static_cast<uint>(1);
            }
            loop_init = false;
            uint _e8 = i_1;
            uint _e9 = count_1;
            if (_e8 < _e9) {
            } else {
                break;
            }
            bool _e15 = include_even_1;
            local_41 = _e15;
            if (_e15) {
            } else {
                uint _e18 = i_1;
                local_41 = naga_mod(_e18, 2u) != 0u;
            }
            bool _e22 = local_41;
            if (_e22) {
                uint _e23 = i_1;
                uint _e24 = total;
                total = _e24 + _e23;
            }
        }
    }
    uint _e26 = total;
    return _e26;
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

int choose(
    int value_5
) {
    int value_6 = {};
    value_6 = value_5;
    int _e2 = value_6;
    bool _e3 = nonnegative(_e2);
    if (_e3) {
        int _e4 = value_6;
        float _e8 = affine(static_cast<float>(_e4), 2.0, 1);
        return naga_f2i32(_e8);
    }
    int _e10 = value_6;
    return naga_neg(_e10);
}

int pair(
    int a,
    int b
) {
    int a_1 = {};
    int b_1 = {};
    a_1 = a;
    b_1 = b;
    int _e5 = a_1;
    int _e7 = b_1;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e5) * as_type<uint>(10))) + as_type<uint>(_e7));
}

struct device_functionsInput {
};
kernel void device_functions(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4& out [[user(fake0)]]
, constant type_5& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint n = {};
    uint i = {};
    uint base = {};
    int value = {};
    int argument = {};
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
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    local = 0u;
    uint _e6 = n_1.value;
    n = _e6;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e14 = i;
    uint _e15 = n;
    if (_e14 < _e15) {
        uint _e17 = i;
        base = _e17 * 10u;
        uint _e21 = i;
        value = as_type<int>(as_type<uint>(static_cast<int>(_e21)) - as_type<uint>(35));
        argument = 3;
        int _e28 = value;
        int _e29 = choose(_e28);
        uint _e30 = local;
        local_1 = _e30;
        uint _e32 = local_1;
        local_2 = static_cast<uint>(_e32);
        uint _e35 = base;
        local_3 = static_cast<uint>(_e35);
        uint _e39 = local_2;
        uint _e40 = local_3;
        local_31 = static_cast<uint>(_e39 + _e40);
        uint _e44 = local_31;
        out[_e44] = _e29;
        int _e46 = value;
        float _e50 = affine(static_cast<float>(_e46), 1.5, 2);
        uint _e51 = local;
        local_4 = _e51;
        uint _e53 = local_4;
        local_5 = static_cast<uint>(_e53);
        uint _e56 = base;
        local_6 = static_cast<uint>(_e56 + 1u);
        uint _e62 = local_5;
        uint _e63 = local_6;
        local_32 = static_cast<uint>(_e62 + _e63);
        uint _e67 = local_32;
        out[_e67] = naga_f2i32(_e50);
        uint _e72 = sum_steps(static_cast<uint>(5), true);
        uint _e73 = local;
        local_7 = _e73;
        uint _e75 = local_7;
        local_8 = static_cast<uint>(_e75);
        uint _e78 = base;
        local_9 = static_cast<uint>(_e78 + 2u);
        uint _e84 = local_8;
        uint _e85 = local_9;
        local_33 = static_cast<uint>(_e84 + _e85);
        uint _e89 = local_33;
        out[_e89] = static_cast<int>(_e72);
        uint _e95 = sum_steps(5u, 0 != 0);
        uint _e96 = local;
        local_10 = _e96;
        uint _e98 = local_10;
        local_11 = static_cast<uint>(_e98);
        uint _e101 = base;
        local_12 = static_cast<uint>(_e101 + 3u);
        uint _e107 = local_11;
        uint _e108 = local_12;
        local_34 = static_cast<uint>(_e107 + _e108);
        uint _e112 = local_34;
        out[_e112] = static_cast<int>(_e95);
        int _e114 = value;
        float _e120 = affine(static_cast<float>(_e114), static_cast<float>(2u), static_cast<int>(true));
        uint _e121 = local;
        local_13 = _e121;
        uint _e123 = local_13;
        local_14 = static_cast<uint>(_e123);
        uint _e126 = base;
        local_15 = static_cast<uint>(_e126 + 4u);
        uint _e132 = local_14;
        uint _e133 = local_15;
        local_35 = static_cast<uint>(_e132 + _e133);
        uint _e137 = local_35;
        out[_e137] = naga_f2i32(_e120);
        int _e139 = value;
        uint _e140 = local;
        local_16 = _e140;
        uint _e142 = local_16;
        local_17 = static_cast<uint>(_e142);
        uint _e145 = base;
        local_18 = static_cast<uint>(_e145 + 5u);
        uint _e150 = local_17;
        uint _e151 = local_18;
        local_36 = static_cast<uint>(_e150 + _e151);
        uint _e155 = local_36;
        out[_e155] = _e139;
        int _e157 = value;
        int _e158 = choose(_e157);
        int _e159 = value;
        int _e162 = choose(as_type<int>(as_type<uint>(_e159) + as_type<uint>(1)));
        uint _e164 = local;
        local_19 = _e164;
        uint _e166 = local_19;
        local_20 = static_cast<uint>(_e166);
        uint _e169 = base;
        local_21 = static_cast<uint>(_e169 + 6u);
        uint _e174 = local_20;
        uint _e175 = local_21;
        local_37 = static_cast<uint>(_e174 + _e175);
        uint _e179 = local_37;
        out[_e179] = as_type<int>(as_type<uint>(_e158) + as_type<uint>(_e162));
        int _e181 = value;
        bool _e182 = nonnegative(_e181);
        uint _e183 = local;
        local_22 = _e183;
        uint _e185 = local_22;
        local_23 = static_cast<uint>(_e185);
        uint _e188 = base;
        local_24 = static_cast<uint>(_e188 + 7u);
        uint _e194 = local_23;
        uint _e195 = local_24;
        local_38 = static_cast<uint>(_e194 + _e195);
        uint _e199 = local_38;
        out[_e199] = static_cast<int>(_e182);
        int _e201 = argument;
        int _e202 = argument;
        argument = as_type<int>(as_type<uint>(_e202) + as_type<uint>(1));
        int _e205 = pair(_e201, _e202);
        uint _e206 = local;
        local_25 = _e206;
        uint _e208 = local_25;
        local_26 = static_cast<uint>(_e208);
        uint _e211 = base;
        local_27 = static_cast<uint>(_e211 + 8u);
        uint _e216 = local_26;
        uint _e217 = local_27;
        local_39 = static_cast<uint>(_e216 + _e217);
        uint _e221 = local_39;
        out[_e221] = _e205;
        int _e223 = argument;
        uint _e224 = local;
        local_28 = _e224;
        uint _e226 = local_28;
        local_29 = static_cast<uint>(_e226);
        uint _e229 = base;
        local_30 = static_cast<uint>(_e229 + 9u);
        uint _e234 = local_29;
        uint _e235 = local_30;
        local_40 = static_cast<uint>(_e234 + _e235);
        uint _e239 = local_40;
        out[_e239] = _e223;
    }
}
