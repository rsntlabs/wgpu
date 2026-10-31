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
    bool local_50 = {};
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
            local_50 = _e15;
            if (_e15) {
            } else {
                uint _e18 = i_1;
                local_50 = naga_mod(_e18, 2u) != 0u;
            }
            bool _e22 = local_50;
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
, device type_4& out_1 [[user(fake0)]]
, constant type_5& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 out = {};
    uint n = {};
    uint i = {};
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
    uint _e11 = n_1.value;
    n = _e11;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e19 = i;
    uint _e20 = n;
    if (_e19 < _e20) {
        uint _e22 = i;
        base = _e22 * 10u;
        uint _e26 = i;
        value = as_type<int>(as_type<uint>(static_cast<int>(_e26)) - as_type<uint>(35));
        argument = 3;
        int _e33 = value;
        int _e34 = choose(_e33);
        type_7 _e37 = out;
        local = _e37;
        uint _e38 = base;
        local_1 = static_cast<uint>(_e38);
        type_7 _e42 = local;
        local_20 = _e42;
        uint _e43 = local_1;
        uint _e45 = local_20.inner[1];
        local_20.inner[1] = _e45 + _e43;
        uint _e49 = local_20.inner[0];
        local_21 = static_cast<uint>(_e49);
        uint _e53 = local_20.inner[1];
        local_22 = static_cast<uint>(_e53);
        uint _e56 = local_22;
        out_1[_e56] = _e34;
        int _e58 = value;
        float _e62 = affine(static_cast<float>(_e58), 1.5, 2);
        type_7 _e64 = out;
        local_2 = _e64;
        uint _e65 = base;
        local_3 = static_cast<uint>(_e65 + 1u);
        type_7 _e72 = local_2;
        local_23 = _e72;
        uint _e73 = local_3;
        uint _e75 = local_23.inner[1];
        local_23.inner[1] = _e75 + _e73;
        uint _e79 = local_23.inner[0];
        local_24 = static_cast<uint>(_e79);
        uint _e83 = local_23.inner[1];
        local_25 = static_cast<uint>(_e83);
        uint _e86 = local_25;
        out_1[_e86] = naga_f2i32(_e62);
        uint _e91 = sum_steps(static_cast<uint>(5), true);
        type_7 _e93 = out;
        local_4 = _e93;
        uint _e94 = base;
        local_5 = static_cast<uint>(_e94 + 2u);
        type_7 _e101 = local_4;
        local_26 = _e101;
        uint _e102 = local_5;
        uint _e104 = local_26.inner[1];
        local_26.inner[1] = _e104 + _e102;
        uint _e108 = local_26.inner[0];
        local_27 = static_cast<uint>(_e108);
        uint _e112 = local_26.inner[1];
        local_28 = static_cast<uint>(_e112);
        uint _e115 = local_28;
        out_1[_e115] = static_cast<int>(_e91);
        uint _e121 = sum_steps(5u, 0 != 0);
        type_7 _e123 = out;
        local_6 = _e123;
        uint _e124 = base;
        local_7 = static_cast<uint>(_e124 + 3u);
        type_7 _e131 = local_6;
        local_29 = _e131;
        uint _e132 = local_7;
        uint _e134 = local_29.inner[1];
        local_29.inner[1] = _e134 + _e132;
        uint _e138 = local_29.inner[0];
        local_30 = static_cast<uint>(_e138);
        uint _e142 = local_29.inner[1];
        local_31 = static_cast<uint>(_e142);
        uint _e145 = local_31;
        out_1[_e145] = static_cast<int>(_e121);
        int _e147 = value;
        float _e153 = affine(static_cast<float>(_e147), static_cast<float>(2u), static_cast<int>(true));
        type_7 _e155 = out;
        local_8 = _e155;
        uint _e156 = base;
        local_9 = static_cast<uint>(_e156 + 4u);
        type_7 _e163 = local_8;
        local_32 = _e163;
        uint _e164 = local_9;
        uint _e166 = local_32.inner[1];
        local_32.inner[1] = _e166 + _e164;
        uint _e170 = local_32.inner[0];
        local_33 = static_cast<uint>(_e170);
        uint _e174 = local_32.inner[1];
        local_34 = static_cast<uint>(_e174);
        uint _e177 = local_34;
        out_1[_e177] = naga_f2i32(_e153);
        int _e179 = value;
        type_7 _e181 = out;
        local_10 = _e181;
        uint _e182 = base;
        local_11 = static_cast<uint>(_e182 + 5u);
        type_7 _e188 = local_10;
        local_35 = _e188;
        uint _e189 = local_11;
        uint _e191 = local_35.inner[1];
        local_35.inner[1] = _e191 + _e189;
        uint _e195 = local_35.inner[0];
        local_36 = static_cast<uint>(_e195);
        uint _e199 = local_35.inner[1];
        local_37 = static_cast<uint>(_e199);
        uint _e202 = local_37;
        out_1[_e202] = _e179;
        int _e204 = value;
        int _e205 = choose(_e204);
        int _e206 = value;
        int _e209 = choose(as_type<int>(as_type<uint>(_e206) + as_type<uint>(1)));
        type_7 _e212 = out;
        local_12 = _e212;
        uint _e213 = base;
        local_13 = static_cast<uint>(_e213 + 6u);
        type_7 _e219 = local_12;
        local_38 = _e219;
        uint _e220 = local_13;
        uint _e222 = local_38.inner[1];
        local_38.inner[1] = _e222 + _e220;
        uint _e226 = local_38.inner[0];
        local_39 = static_cast<uint>(_e226);
        uint _e230 = local_38.inner[1];
        local_40 = static_cast<uint>(_e230);
        uint _e233 = local_40;
        out_1[_e233] = as_type<int>(as_type<uint>(_e205) + as_type<uint>(_e209));
        int _e235 = value;
        bool _e236 = nonnegative(_e235);
        type_7 _e238 = out;
        local_14 = _e238;
        uint _e239 = base;
        local_15 = static_cast<uint>(_e239 + 7u);
        type_7 _e246 = local_14;
        local_41 = _e246;
        uint _e247 = local_15;
        uint _e249 = local_41.inner[1];
        local_41.inner[1] = _e249 + _e247;
        uint _e253 = local_41.inner[0];
        local_42 = static_cast<uint>(_e253);
        uint _e257 = local_41.inner[1];
        local_43 = static_cast<uint>(_e257);
        uint _e260 = local_43;
        out_1[_e260] = static_cast<int>(_e236);
        int _e262 = argument;
        int _e263 = argument;
        argument = as_type<int>(as_type<uint>(_e263) + as_type<uint>(1));
        int _e266 = pair(_e262, _e263);
        type_7 _e268 = out;
        local_16 = _e268;
        uint _e269 = base;
        local_17 = static_cast<uint>(_e269 + 8u);
        type_7 _e275 = local_16;
        local_44 = _e275;
        uint _e276 = local_17;
        uint _e278 = local_44.inner[1];
        local_44.inner[1] = _e278 + _e276;
        uint _e282 = local_44.inner[0];
        local_45 = static_cast<uint>(_e282);
        uint _e286 = local_44.inner[1];
        local_46 = static_cast<uint>(_e286);
        uint _e289 = local_46;
        out_1[_e289] = _e266;
        int _e291 = argument;
        type_7 _e293 = out;
        local_18 = _e293;
        uint _e294 = base;
        local_19 = static_cast<uint>(_e294 + 9u);
        type_7 _e300 = local_18;
        local_47 = _e300;
        uint _e301 = local_19;
        uint _e303 = local_47.inner[1];
        local_47.inner[1] = _e303 + _e301;
        uint _e307 = local_47.inner[0];
        local_48 = static_cast<uint>(_e307);
        uint _e311 = local_47.inner[1];
        local_49 = static_cast<uint>(_e311);
        uint _e314 = local_49;
        out_1[_e314] = _e291;
    }
}
