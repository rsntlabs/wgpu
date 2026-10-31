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
    bool local_51 = {};
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
            local_51 = _e15;
            if (_e15) {
            } else {
                uint _e18 = i_1;
                local_51 = naga_mod(_e18, 2u) != 0u;
            }
            bool _e22 = local_51;
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
    type_7 local = {};
    uint n = {};
    uint i = {};
    uint base = {};
    int value = {};
    int argument = {};
    type_7 local_1 = {};
    uint local_2 = {};
    type_7 local_3 = {};
    uint local_4 = {};
    type_7 local_5 = {};
    uint local_6 = {};
    type_7 local_7 = {};
    uint local_8 = {};
    type_7 local_9 = {};
    uint local_10 = {};
    type_7 local_11 = {};
    uint local_12 = {};
    type_7 local_13 = {};
    uint local_14 = {};
    type_7 local_15 = {};
    uint local_16 = {};
    type_7 local_17 = {};
    uint local_18 = {};
    type_7 local_19 = {};
    uint local_20 = {};
    type_7 local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    type_7 local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    type_7 local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    type_7 local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    type_7 local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    type_7 local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    type_7 local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    type_7 local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    type_7 local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    type_7 local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    local = type_7 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
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
        type_7 _e37 = local;
        local_1 = _e37;
        uint _e38 = base;
        local_2 = static_cast<uint>(_e38);
        type_7 _e42 = local_1;
        local_21 = _e42;
        uint _e43 = local_2;
        uint _e45 = local_21.inner[1];
        local_21.inner[1] = _e45 + _e43;
        uint _e49 = local_21.inner[0];
        local_22 = static_cast<uint>(_e49);
        uint _e53 = local_21.inner[1];
        local_23 = static_cast<uint>(_e53);
        uint _e56 = local_23;
        out[_e56] = _e34;
        int _e58 = value;
        float _e62 = affine(static_cast<float>(_e58), 1.5, 2);
        type_7 _e64 = local;
        local_3 = _e64;
        uint _e65 = base;
        local_4 = static_cast<uint>(_e65 + 1u);
        type_7 _e72 = local_3;
        local_24 = _e72;
        uint _e73 = local_4;
        uint _e75 = local_24.inner[1];
        local_24.inner[1] = _e75 + _e73;
        uint _e79 = local_24.inner[0];
        local_25 = static_cast<uint>(_e79);
        uint _e83 = local_24.inner[1];
        local_26 = static_cast<uint>(_e83);
        uint _e86 = local_26;
        out[_e86] = naga_f2i32(_e62);
        uint _e91 = sum_steps(static_cast<uint>(5), true);
        type_7 _e93 = local;
        local_5 = _e93;
        uint _e94 = base;
        local_6 = static_cast<uint>(_e94 + 2u);
        type_7 _e101 = local_5;
        local_27 = _e101;
        uint _e102 = local_6;
        uint _e104 = local_27.inner[1];
        local_27.inner[1] = _e104 + _e102;
        uint _e108 = local_27.inner[0];
        local_28 = static_cast<uint>(_e108);
        uint _e112 = local_27.inner[1];
        local_29 = static_cast<uint>(_e112);
        uint _e115 = local_29;
        out[_e115] = static_cast<int>(_e91);
        uint _e121 = sum_steps(5u, 0 != 0);
        type_7 _e123 = local;
        local_7 = _e123;
        uint _e124 = base;
        local_8 = static_cast<uint>(_e124 + 3u);
        type_7 _e131 = local_7;
        local_30 = _e131;
        uint _e132 = local_8;
        uint _e134 = local_30.inner[1];
        local_30.inner[1] = _e134 + _e132;
        uint _e138 = local_30.inner[0];
        local_31 = static_cast<uint>(_e138);
        uint _e142 = local_30.inner[1];
        local_32 = static_cast<uint>(_e142);
        uint _e145 = local_32;
        out[_e145] = static_cast<int>(_e121);
        int _e147 = value;
        float _e153 = affine(static_cast<float>(_e147), static_cast<float>(2u), static_cast<int>(true));
        type_7 _e155 = local;
        local_9 = _e155;
        uint _e156 = base;
        local_10 = static_cast<uint>(_e156 + 4u);
        type_7 _e163 = local_9;
        local_33 = _e163;
        uint _e164 = local_10;
        uint _e166 = local_33.inner[1];
        local_33.inner[1] = _e166 + _e164;
        uint _e170 = local_33.inner[0];
        local_34 = static_cast<uint>(_e170);
        uint _e174 = local_33.inner[1];
        local_35 = static_cast<uint>(_e174);
        uint _e177 = local_35;
        out[_e177] = naga_f2i32(_e153);
        int _e179 = value;
        type_7 _e181 = local;
        local_11 = _e181;
        uint _e182 = base;
        local_12 = static_cast<uint>(_e182 + 5u);
        type_7 _e188 = local_11;
        local_36 = _e188;
        uint _e189 = local_12;
        uint _e191 = local_36.inner[1];
        local_36.inner[1] = _e191 + _e189;
        uint _e195 = local_36.inner[0];
        local_37 = static_cast<uint>(_e195);
        uint _e199 = local_36.inner[1];
        local_38 = static_cast<uint>(_e199);
        uint _e202 = local_38;
        out[_e202] = _e179;
        int _e204 = value;
        int _e205 = choose(_e204);
        int _e206 = value;
        int _e209 = choose(as_type<int>(as_type<uint>(_e206) + as_type<uint>(1)));
        type_7 _e212 = local;
        local_13 = _e212;
        uint _e213 = base;
        local_14 = static_cast<uint>(_e213 + 6u);
        type_7 _e219 = local_13;
        local_39 = _e219;
        uint _e220 = local_14;
        uint _e222 = local_39.inner[1];
        local_39.inner[1] = _e222 + _e220;
        uint _e226 = local_39.inner[0];
        local_40 = static_cast<uint>(_e226);
        uint _e230 = local_39.inner[1];
        local_41 = static_cast<uint>(_e230);
        uint _e233 = local_41;
        out[_e233] = as_type<int>(as_type<uint>(_e205) + as_type<uint>(_e209));
        int _e235 = value;
        bool _e236 = nonnegative(_e235);
        type_7 _e238 = local;
        local_15 = _e238;
        uint _e239 = base;
        local_16 = static_cast<uint>(_e239 + 7u);
        type_7 _e246 = local_15;
        local_42 = _e246;
        uint _e247 = local_16;
        uint _e249 = local_42.inner[1];
        local_42.inner[1] = _e249 + _e247;
        uint _e253 = local_42.inner[0];
        local_43 = static_cast<uint>(_e253);
        uint _e257 = local_42.inner[1];
        local_44 = static_cast<uint>(_e257);
        uint _e260 = local_44;
        out[_e260] = static_cast<int>(_e236);
        int _e262 = argument;
        int _e263 = argument;
        argument = as_type<int>(as_type<uint>(_e263) + as_type<uint>(1));
        int _e266 = pair(_e262, _e263);
        type_7 _e268 = local;
        local_17 = _e268;
        uint _e269 = base;
        local_18 = static_cast<uint>(_e269 + 8u);
        type_7 _e275 = local_17;
        local_45 = _e275;
        uint _e276 = local_18;
        uint _e278 = local_45.inner[1];
        local_45.inner[1] = _e278 + _e276;
        uint _e282 = local_45.inner[0];
        local_46 = static_cast<uint>(_e282);
        uint _e286 = local_45.inner[1];
        local_47 = static_cast<uint>(_e286);
        uint _e289 = local_47;
        out[_e289] = _e266;
        int _e291 = argument;
        type_7 _e293 = local;
        local_19 = _e293;
        uint _e294 = base;
        local_20 = static_cast<uint>(_e294 + 9u);
        type_7 _e300 = local_19;
        local_48 = _e300;
        uint _e301 = local_20;
        uint _e303 = local_48.inner[1];
        local_48.inner[1] = _e303 + _e301;
        uint _e307 = local_48.inner[0];
        local_49 = static_cast<uint>(_e307);
        uint _e311 = local_48.inner[1];
        local_50 = static_cast<uint>(_e311);
        uint _e314 = local_50;
        out[_e314] = _e291;
    }
}
