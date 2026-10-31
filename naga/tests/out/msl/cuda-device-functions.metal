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
struct type_7 {
    uint inner[2];
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
    bool local_50 = {};
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
            local_50 = include_even;
            if (include_even) {
            } else {
                uint _e9 = i;
                local_50 = naga_mod(_e9, 2u) != 0u;
            }
            bool _e14 = local_50;
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
, device type_4& out_1 [[user(fake0)]]
, constant type_5& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 out = {};
    uint base = {};
    int value = {};
    int argument = {};
    type_7 local = {};
    uint local_1 = {};
    type_7 local_2 = {};
    uint local_3 = {};
    type_7 local_4 = {};
    uint local_5 = {};
    type_7 local_6 = {};
    uint local_7 = {};
    type_7 local_8 = {};
    uint local_9 = {};
    type_7 local_10 = {};
    uint local_11 = {};
    type_7 local_12 = {};
    uint local_13 = {};
    type_7 local_14 = {};
    uint local_15 = {};
    type_7 local_16 = {};
    uint local_17 = {};
    type_7 local_18 = {};
    uint local_19 = {};
    type_7 local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    type_7 local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    type_7 local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    type_7 local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    type_7 local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    type_7 local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    type_7 local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    type_7 local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    type_7 local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    type_7 local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    out = type_7 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    uint n_1 = n.value;
    uint i_1 = (blockIdx.x * 64u) + threadIdx.x;
    if (i_1 < n_1) {
        base = i_1 * 10u;
        value = as_type<int>(as_type<uint>(static_cast<int>(i_1)) - as_type<uint>(35));
        argument = 3;
        int _e26 = value;
        int _e27 = choose(_e26);
        type_7 _e29 = out;
        local = _e29;
        uint _e31 = base;
        local_1 = static_cast<uint>(_e31);
        type_7 _e34 = local;
        local_20 = _e34;
        uint _e36 = local_1;
        uint _e38 = local_20.inner[1];
        local_20.inner[1] = _e38 + _e36;
        uint _e42 = local_20.inner[0];
        local_21 = static_cast<uint>(_e42);
        uint _e46 = local_20.inner[1];
        local_22 = static_cast<uint>(_e46);
        uint _e49 = local_22;
        out_1[_e49] = _e27;
        int _e52 = value;
        float _e56 = affine(static_cast<float>(_e52), 1.5, 2);
        type_7 _e57 = out;
        local_2 = _e57;
        uint _e59 = base;
        local_3 = static_cast<uint>(_e59 + 1u);
        type_7 _e65 = local_2;
        local_23 = _e65;
        uint _e67 = local_3;
        uint _e69 = local_23.inner[1];
        local_23.inner[1] = _e69 + _e67;
        uint _e73 = local_23.inner[0];
        local_24 = static_cast<uint>(_e73);
        uint _e77 = local_23.inner[1];
        local_25 = static_cast<uint>(_e77);
        uint _e80 = local_25;
        out_1[_e80] = naga_f2i32(_e56);
        uint _e85 = sum_steps(static_cast<uint>(5), true);
        type_7 _e86 = out;
        local_4 = _e86;
        uint _e88 = base;
        local_5 = static_cast<uint>(_e88 + 2u);
        type_7 _e94 = local_4;
        local_26 = _e94;
        uint _e96 = local_5;
        uint _e98 = local_26.inner[1];
        local_26.inner[1] = _e98 + _e96;
        uint _e102 = local_26.inner[0];
        local_27 = static_cast<uint>(_e102);
        uint _e106 = local_26.inner[1];
        local_28 = static_cast<uint>(_e106);
        uint _e109 = local_28;
        out_1[_e109] = static_cast<int>(_e85);
        uint _e115 = sum_steps(5u, 0 != 0);
        type_7 _e116 = out;
        local_6 = _e116;
        uint _e118 = base;
        local_7 = static_cast<uint>(_e118 + 3u);
        type_7 _e124 = local_6;
        local_29 = _e124;
        uint _e126 = local_7;
        uint _e128 = local_29.inner[1];
        local_29.inner[1] = _e128 + _e126;
        uint _e132 = local_29.inner[0];
        local_30 = static_cast<uint>(_e132);
        uint _e136 = local_29.inner[1];
        local_31 = static_cast<uint>(_e136);
        uint _e139 = local_31;
        out_1[_e139] = static_cast<int>(_e115);
        int _e141 = value;
        float _e147 = affine(static_cast<float>(_e141), static_cast<float>(2u), static_cast<int>(true));
        type_7 _e148 = out;
        local_8 = _e148;
        uint _e150 = base;
        local_9 = static_cast<uint>(_e150 + 4u);
        type_7 _e156 = local_8;
        local_32 = _e156;
        uint _e158 = local_9;
        uint _e160 = local_32.inner[1];
        local_32.inner[1] = _e160 + _e158;
        uint _e164 = local_32.inner[0];
        local_33 = static_cast<uint>(_e164);
        uint _e168 = local_32.inner[1];
        local_34 = static_cast<uint>(_e168);
        uint _e171 = local_34;
        out_1[_e171] = naga_f2i32(_e147);
        int _e173 = value;
        type_7 _e174 = out;
        local_10 = _e174;
        uint _e176 = base;
        local_11 = static_cast<uint>(_e176 + 5u);
        type_7 _e181 = local_10;
        local_35 = _e181;
        uint _e183 = local_11;
        uint _e185 = local_35.inner[1];
        local_35.inner[1] = _e185 + _e183;
        uint _e189 = local_35.inner[0];
        local_36 = static_cast<uint>(_e189);
        uint _e193 = local_35.inner[1];
        local_37 = static_cast<uint>(_e193);
        uint _e196 = local_37;
        out_1[_e196] = _e173;
        int _e198 = value;
        int _e199 = choose(_e198);
        int _e200 = value;
        int _e203 = choose(as_type<int>(as_type<uint>(_e200) + as_type<uint>(1)));
        type_7 _e205 = out;
        local_12 = _e205;
        uint _e207 = base;
        local_13 = static_cast<uint>(_e207 + 6u);
        type_7 _e212 = local_12;
        local_38 = _e212;
        uint _e214 = local_13;
        uint _e216 = local_38.inner[1];
        local_38.inner[1] = _e216 + _e214;
        uint _e220 = local_38.inner[0];
        local_39 = static_cast<uint>(_e220);
        uint _e224 = local_38.inner[1];
        local_40 = static_cast<uint>(_e224);
        uint _e227 = local_40;
        out_1[_e227] = as_type<int>(as_type<uint>(_e199) + as_type<uint>(_e203));
        int _e229 = value;
        bool _e230 = nonnegative(_e229);
        type_7 _e231 = out;
        local_14 = _e231;
        uint _e233 = base;
        local_15 = static_cast<uint>(_e233 + 7u);
        type_7 _e239 = local_14;
        local_41 = _e239;
        uint _e241 = local_15;
        uint _e243 = local_41.inner[1];
        local_41.inner[1] = _e243 + _e241;
        uint _e247 = local_41.inner[0];
        local_42 = static_cast<uint>(_e247);
        uint _e251 = local_41.inner[1];
        local_43 = static_cast<uint>(_e251);
        uint _e254 = local_43;
        out_1[_e254] = static_cast<int>(_e230);
        int _e256 = argument;
        int _e257 = argument;
        argument = as_type<int>(as_type<uint>(_e257) + as_type<uint>(1));
        int _e260 = pair(_e256, _e257);
        type_7 _e261 = out;
        local_16 = _e261;
        uint _e263 = base;
        local_17 = static_cast<uint>(_e263 + 8u);
        type_7 _e268 = local_16;
        local_44 = _e268;
        uint _e270 = local_17;
        uint _e272 = local_44.inner[1];
        local_44.inner[1] = _e272 + _e270;
        uint _e276 = local_44.inner[0];
        local_45 = static_cast<uint>(_e276);
        uint _e280 = local_44.inner[1];
        local_46 = static_cast<uint>(_e280);
        uint _e283 = local_46;
        out_1[_e283] = _e260;
        int _e285 = argument;
        type_7 _e286 = out;
        local_18 = _e286;
        uint _e288 = base;
        local_19 = static_cast<uint>(_e288 + 9u);
        type_7 _e293 = local_18;
        local_47 = _e293;
        uint _e295 = local_19;
        uint _e297 = local_47.inner[1];
        local_47.inner[1] = _e297 + _e295;
        uint _e301 = local_47.inner[0];
        local_48 = static_cast<uint>(_e301);
        uint _e305 = local_47.inner[1];
        local_49 = static_cast<uint>(_e305);
        uint _e308 = local_49;
        out_1[_e308] = _e285;
    }
}
