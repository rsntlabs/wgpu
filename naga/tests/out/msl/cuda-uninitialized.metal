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
struct type_7 {
    uint inner[2];
};

int select_value(
    int value_1,
    bool choose_first
) {
    int value_2 = {};
    bool choose_first_1 = {};
    int result = {};
    value_2 = value_1;
    choose_first_1 = choose_first;
    bool _e5 = choose_first_1;
    if (_e5) {
        int _e7 = value_2;
        result = as_type<int>(as_type<uint>(_e7) + as_type<uint>(3));
    } else {
        int _e10 = value_2;
        result = as_type<int>(as_type<uint>(_e10) - as_type<uint>(2));
    }
    int _e12 = result;
    return _e12;
}

float scaled(
    float value_3
) {
    float value_4 = {};
    float result_1 = {};
    value_4 = value_3;
    float _e4 = value_4;
    result_1 = (_e4 * 2.0) + 4.0;
    float _e8 = result_1;
    return _e8;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

uint accumulate(
    uint limit
) {
    uint limit_1 = {};
    uint sum = {};
    uint i_1 = {};
    uint term = {};
    limit_1 = limit;
    sum = 0u;
    {
        i_1 = 0u;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e9 = i_1;
                i_1 = _e9 + static_cast<uint>(1);
            }
            loop_init = false;
            uint _e6 = i_1;
            uint _e7 = limit_1;
            if (_e6 < _e7) {
            } else {
                break;
            }
            uint _e15 = i_1;
            if (naga_mod(_e15, 2u) == 0u) {
                uint _e20 = i_1;
                term = _e20 + 1u;
            } else {
                uint _e23 = i_1;
                term = _e23 * 2u;
            }
            uint _e25 = term;
            uint _e26 = sum;
            sum = _e26 + _e25;
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
, device type_4& out_1 [[user(fake0)]]
, device type_4 const& input_1 [[user(fake0)]]
, constant type_5& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 out = {};
    type_7 input = {};
    uint n = {};
    uint i = {};
    uint base = {};
    int value = {};
    type_7 local = {};
    uint local_1 = {};
    int chosen = {};
    type_7 local_2 = {};
    uint local_3 = {};
    type_7 local_4 = {};
    uint local_5 = {};
    float weighted = {};
    type_7 local_6 = {};
    uint local_7 = {};
    bool negative = {};
    type_7 local_8 = {};
    uint local_9 = {};
    uint magnitude = {};
    type_7 local_10 = {};
    uint local_11 = {};
    type_7 local_12 = {};
    uint local_13 = {};
    int total = {};
    int iteration = {};
    int copied = {};
    type_7 local_14 = {};
    uint local_15 = {};
    int descending = {};
    int iteration_1 = {};
    int staged = {};
    type_7 local_16 = {};
    uint local_17 = {};
    int remaining = {};
    int partial = {};
    int next = {};
    type_7 local_18 = {};
    uint local_19 = {};
    int shadow = {};
    int shadow_1 = {};
    type_7 local_20 = {};
    uint local_21 = {};
    type_7 local_22 = {};
    uint local_23 = {};
    type_7 local_24 = {};
    uint local_25 = {};
    int local_26 = {};
    type_7 local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    int local_30 = {};
    type_7 local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    type_7 local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    type_7 local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    type_7 local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    type_7 local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    type_7 local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    type_7 local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    type_7 local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    type_7 local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    type_7 local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    type_7 local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    type_7 local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    out = type_7 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    input = type_7 {};
    input.inner[0] = 1u;
    input.inner[1] = 0u;
    uint _e18 = n_1.value;
    n = _e18;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e26 = i;
    uint _e27 = n;
    if (_e26 < _e27) {
        uint _e29 = i;
        base = _e29 * 12u;
        type_7 _e35 = input;
        local = _e35;
        uint _e36 = i;
        local_1 = static_cast<uint>(_e36);
        type_7 _e40 = local;
        local_27 = _e40;
        uint _e41 = local_1;
        uint _e43 = local_27.inner[1];
        local_27.inner[1] = _e43 + _e41;
        uint _e47 = local_27.inner[0];
        local_28 = static_cast<uint>(_e47);
        uint _e51 = local_27.inner[1];
        local_29 = static_cast<uint>(_e51);
        uint _e55 = local_29;
        int _e57 = input_1[_e55];
        local_30 = _e57;
        int _e58 = local_30;
        local_26 = _e58;
        int _e60 = local_26;
        value = _e60;
        uint _e62 = i;
        if (naga_mod(_e62, 2u) == 0u) {
            int _e67 = value;
            chosen = as_type<int>(as_type<uint>(_e67) + as_type<uint>(7));
        } else {
            int _e71 = value;
            chosen = as_type<int>(as_type<uint>(_e71) - as_type<uint>(4));
        }
        int _e76 = chosen;
        type_7 _e79 = out;
        local_2 = _e79;
        uint _e80 = base;
        local_3 = static_cast<uint>(_e80);
        type_7 _e84 = local_2;
        local_31 = _e84;
        uint _e85 = local_3;
        uint _e87 = local_31.inner[1];
        local_31.inner[1] = _e87 + _e85;
        uint _e91 = local_31.inner[0];
        local_32 = static_cast<uint>(_e91);
        uint _e95 = local_31.inner[1];
        local_33 = static_cast<uint>(_e95);
        uint _e98 = local_33;
        out_1[_e98] = _e76;
        int _e100 = value;
        uint _e101 = i;
        int _e106 = select_value(_e100, naga_mod(_e101, 3u) == 0u);
        type_7 _e108 = out;
        local_4 = _e108;
        uint _e109 = base;
        local_5 = static_cast<uint>(_e109 + 1u);
        type_7 _e115 = local_4;
        local_34 = _e115;
        uint _e116 = local_5;
        uint _e118 = local_34.inner[1];
        local_34.inner[1] = _e118 + _e116;
        uint _e122 = local_34.inner[0];
        local_35 = static_cast<uint>(_e122);
        uint _e126 = local_34.inner[1];
        local_36 = static_cast<uint>(_e126);
        uint _e129 = local_36;
        out_1[_e129] = _e106;
        int _e131 = value;
        weighted = (static_cast<float>(_e131) * 1.5) + 2.0;
        float _e138 = weighted;
        type_7 _e141 = out;
        local_6 = _e141;
        uint _e142 = base;
        local_7 = static_cast<uint>(_e142 + 2u);
        type_7 _e148 = local_6;
        local_37 = _e148;
        uint _e149 = local_7;
        uint _e151 = local_37.inner[1];
        local_37.inner[1] = _e151 + _e149;
        uint _e155 = local_37.inner[0];
        local_38 = static_cast<uint>(_e155);
        uint _e159 = local_37.inner[1];
        local_39 = static_cast<uint>(_e159);
        uint _e162 = local_39;
        out_1[_e162] = naga_f2i32(_e138);
        int _e164 = value;
        negative = _e164 < 0;
        bool _e168 = negative;
        type_7 _e170 = out;
        local_8 = _e170;
        uint _e171 = base;
        local_9 = static_cast<uint>(_e171 + 3u);
        type_7 _e178 = local_8;
        local_40 = _e178;
        uint _e179 = local_9;
        uint _e181 = local_40.inner[1];
        local_40.inner[1] = _e181 + _e179;
        uint _e185 = local_40.inner[0];
        local_41 = static_cast<uint>(_e185);
        uint _e189 = local_40.inner[1];
        local_42 = static_cast<uint>(_e189);
        uint _e192 = local_42;
        out_1[_e192] = static_cast<int>(_e168);
        int _e194 = value;
        magnitude = static_cast<uint>(as_type<int>(as_type<uint>(_e194) + as_type<uint>(5)));
        uint _e199 = magnitude;
        type_7 _e203 = out;
        local_10 = _e203;
        uint _e204 = base;
        local_11 = static_cast<uint>(_e204 + 4u);
        type_7 _e211 = local_10;
        local_43 = _e211;
        uint _e212 = local_11;
        uint _e214 = local_43.inner[1];
        local_43.inner[1] = _e214 + _e212;
        uint _e218 = local_43.inner[0];
        local_44 = static_cast<uint>(_e218);
        uint _e222 = local_43.inner[1];
        local_45 = static_cast<uint>(_e222);
        uint _e225 = local_45;
        out_1[_e225] = static_cast<int>(_e199 * 3u);
        uint _e227 = i;
        uint _e230 = accumulate(naga_mod(_e227, 5u));
        type_7 _e232 = out;
        local_12 = _e232;
        uint _e233 = base;
        local_13 = static_cast<uint>(_e233 + 5u);
        type_7 _e240 = local_12;
        local_46 = _e240;
        uint _e241 = local_13;
        uint _e243 = local_46.inner[1];
        local_46.inner[1] = _e243 + _e241;
        uint _e247 = local_46.inner[0];
        local_47 = static_cast<uint>(_e247);
        uint _e251 = local_46.inner[1];
        local_48 = static_cast<uint>(_e251);
        uint _e254 = local_48;
        out_1[_e254] = static_cast<int>(_e230);
        total = 0;
        {
            iteration = 0;
            uint2 loop_bound_1 = uint2(4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (metal::all(loop_bound_1 == uint2(0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e270 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e270) + as_type<uint>(1));
                }
                loop_init_1 = false;
                int _e260 = iteration;
                if (_e260 < 3) {
                } else {
                    break;
                }
                int _e263 = value;
                int _e264 = iteration;
                copied = as_type<int>(as_type<uint>(_e263) + as_type<uint>(_e264));
                int _e267 = copied;
                int _e268 = total;
                total = as_type<int>(as_type<uint>(_e268) + as_type<uint>(_e267));
            }
        }
        int _e273 = total;
        type_7 _e275 = out;
        local_14 = _e275;
        uint _e276 = base;
        local_15 = static_cast<uint>(_e276 + 6u);
        type_7 _e282 = local_14;
        local_49 = _e282;
        uint _e283 = local_15;
        uint _e285 = local_49.inner[1];
        local_49.inner[1] = _e285 + _e283;
        uint _e289 = local_49.inner[0];
        local_50 = static_cast<uint>(_e289);
        uint _e293 = local_49.inner[1];
        local_51 = static_cast<uint>(_e293);
        uint _e296 = local_51;
        out_1[_e296] = _e273;
        descending = 0;
        iteration_1 = 0;
        {
            uint2 loop_bound_2 = uint2(4294967295u);
            bool loop_init_2 = true;
            while(true) {
                if (metal::all(loop_bound_2 == uint2(0u))) { break; }
                loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
                if (!loop_init_2) {
                    int _e312 = iteration_1;
                    iteration_1 = as_type<int>(as_type<uint>(_e312) + as_type<uint>(1));
                }
                loop_init_2 = false;
                int _e302 = iteration_1;
                if (_e302 < 3) {
                } else {
                    break;
                }
                int _e305 = value;
                int _e306 = iteration_1;
                staged = as_type<int>(as_type<uint>(_e305) - as_type<uint>(_e306));
                int _e309 = staged;
                int _e310 = descending;
                descending = as_type<int>(as_type<uint>(_e310) + as_type<uint>(_e309));
            }
        }
        int _e315 = descending;
        type_7 _e317 = out;
        local_16 = _e317;
        uint _e318 = base;
        local_17 = static_cast<uint>(_e318 + 7u);
        type_7 _e324 = local_16;
        local_52 = _e324;
        uint _e325 = local_17;
        uint _e327 = local_52.inner[1];
        local_52.inner[1] = _e327 + _e325;
        uint _e331 = local_52.inner[0];
        local_53 = static_cast<uint>(_e331);
        uint _e335 = local_52.inner[1];
        local_54 = static_cast<uint>(_e335);
        uint _e338 = local_54;
        out_1[_e338] = _e315;
        remaining = 2;
        int _e342 = value;
        partial = _e342;
        uint2 loop_bound_3 = uint2(4294967295u);
        while(true) {
            if (metal::all(loop_bound_3 == uint2(0u))) { break; }
            loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
            int _e344 = remaining;
            if (_e344 > 0) {
            } else {
                break;
            }
            {
                int _e347 = partial;
                int _e348 = remaining;
                next = as_type<int>(as_type<uint>(_e347) + as_type<uint>(_e348));
                int _e351 = next;
                partial = _e351;
                int _e352 = remaining;
                remaining = as_type<int>(as_type<uint>(_e352) - as_type<uint>(1));
            }
        }
        int _e355 = partial;
        type_7 _e357 = out;
        local_18 = _e357;
        uint _e358 = base;
        local_19 = static_cast<uint>(_e358 + 8u);
        type_7 _e364 = local_18;
        local_55 = _e364;
        uint _e365 = local_19;
        uint _e367 = local_55.inner[1];
        local_55.inner[1] = _e367 + _e365;
        uint _e371 = local_55.inner[0];
        local_56 = static_cast<uint>(_e371);
        uint _e375 = local_55.inner[1];
        local_57 = static_cast<uint>(_e375);
        uint _e378 = local_57;
        out_1[_e378] = _e355;
        int _e380 = value;
        shadow = _e380;
        {
            int _e382 = value;
            shadow_1 = as_type<int>(as_type<uint>(_e382) + as_type<uint>(10));
            int _e386 = shadow_1;
            type_7 _e388 = out;
            local_20 = _e388;
            uint _e389 = base;
            local_21 = static_cast<uint>(_e389 + 9u);
            type_7 _e395 = local_20;
            local_58 = _e395;
            uint _e396 = local_21;
            uint _e398 = local_58.inner[1];
            local_58.inner[1] = _e398 + _e396;
            uint _e402 = local_58.inner[0];
            local_59 = static_cast<uint>(_e402);
            uint _e406 = local_58.inner[1];
            local_60 = static_cast<uint>(_e406);
            uint _e409 = local_60;
            out_1[_e409] = _e386;
        }
        int _e411 = shadow;
        type_7 _e413 = out;
        local_22 = _e413;
        uint _e414 = base;
        local_23 = static_cast<uint>(_e414 + 10u);
        type_7 _e420 = local_22;
        local_61 = _e420;
        uint _e421 = local_23;
        uint _e423 = local_61.inner[1];
        local_61.inner[1] = _e423 + _e421;
        uint _e427 = local_61.inner[0];
        local_62 = static_cast<uint>(_e427);
        uint _e431 = local_61.inner[1];
        local_63 = static_cast<uint>(_e431);
        uint _e434 = local_63;
        out_1[_e434] = _e411;
        int _e436 = value;
        float _e438 = scaled(static_cast<float>(_e436));
        type_7 _e440 = out;
        local_24 = _e440;
        uint _e441 = base;
        local_25 = static_cast<uint>(_e441 + 11u);
        type_7 _e448 = local_24;
        local_64 = _e448;
        uint _e449 = local_25;
        uint _e451 = local_64.inner[1];
        local_64.inner[1] = _e451 + _e449;
        uint _e455 = local_64.inner[0];
        local_65 = static_cast<uint>(_e455);
        uint _e459 = local_64.inner[1];
        local_66 = static_cast<uint>(_e459);
        uint _e462 = local_66;
        out_1[_e462] = naga_f2i32(_e438);
    }
}
