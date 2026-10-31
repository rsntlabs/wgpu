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
, device type_4& out_1 [[user(fake0)]]
, device type_4 const& input_1 [[user(fake0)]]
, constant type_5& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 out = {};
    type_7 input = {};
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
    uint n_1 = n.value;
    uint i_1 = (blockIdx.x * 64u) + threadIdx.x;
    if (i_1 < n_1) {
        base = i_1 * 12u;
        type_7 _e27 = input;
        local = _e27;
        local_1 = static_cast<uint>(i_1);
        type_7 _e31 = local;
        local_27 = _e31;
        uint _e33 = local_1;
        uint _e35 = local_27.inner[1];
        local_27.inner[1] = _e35 + _e33;
        uint _e39 = local_27.inner[0];
        local_28 = static_cast<uint>(_e39);
        uint _e43 = local_27.inner[1];
        local_29 = static_cast<uint>(_e43);
        uint _e46 = local_29;
        int _e49 = input_1[_e46];
        local_30 = _e49;
        int _e51 = local_30;
        local_26 = _e51;
        int _e53 = local_26;
        value = _e53;
        if (naga_mod(i_1, 2u) == 0u) {
            int _e59 = value;
            chosen = as_type<int>(as_type<uint>(_e59) + as_type<uint>(7));
        } else {
            int _e63 = value;
            chosen = as_type<int>(as_type<uint>(_e63) - as_type<uint>(4));
        }
        int _e68 = chosen;
        type_7 _e70 = out;
        local_2 = _e70;
        uint _e72 = base;
        local_3 = static_cast<uint>(_e72);
        type_7 _e75 = local_2;
        local_31 = _e75;
        uint _e77 = local_3;
        uint _e79 = local_31.inner[1];
        local_31.inner[1] = _e79 + _e77;
        uint _e83 = local_31.inner[0];
        local_32 = static_cast<uint>(_e83);
        uint _e87 = local_31.inner[1];
        local_33 = static_cast<uint>(_e87);
        uint _e90 = local_33;
        out_1[_e90] = _e68;
        int _e93 = value;
        int _e98 = select_value(_e93, naga_mod(i_1, 3u) == 0u);
        type_7 _e99 = out;
        local_4 = _e99;
        uint _e101 = base;
        local_5 = static_cast<uint>(_e101 + 1u);
        type_7 _e106 = local_4;
        local_34 = _e106;
        uint _e108 = local_5;
        uint _e110 = local_34.inner[1];
        local_34.inner[1] = _e110 + _e108;
        uint _e114 = local_34.inner[0];
        local_35 = static_cast<uint>(_e114);
        uint _e118 = local_34.inner[1];
        local_36 = static_cast<uint>(_e118);
        uint _e121 = local_36;
        out_1[_e121] = _e98;
        int _e123 = value;
        weighted = (static_cast<float>(_e123) * 1.5) + 2.0;
        float _e130 = weighted;
        type_7 _e132 = out;
        local_6 = _e132;
        uint _e134 = base;
        local_7 = static_cast<uint>(_e134 + 2u);
        type_7 _e139 = local_6;
        local_37 = _e139;
        uint _e141 = local_7;
        uint _e143 = local_37.inner[1];
        local_37.inner[1] = _e143 + _e141;
        uint _e147 = local_37.inner[0];
        local_38 = static_cast<uint>(_e147);
        uint _e151 = local_37.inner[1];
        local_39 = static_cast<uint>(_e151);
        uint _e154 = local_39;
        out_1[_e154] = naga_f2i32(_e130);
        int _e156 = value;
        negative = _e156 < 0;
        bool _e160 = negative;
        type_7 _e161 = out;
        local_8 = _e161;
        uint _e163 = base;
        local_9 = static_cast<uint>(_e163 + 3u);
        type_7 _e169 = local_8;
        local_40 = _e169;
        uint _e171 = local_9;
        uint _e173 = local_40.inner[1];
        local_40.inner[1] = _e173 + _e171;
        uint _e177 = local_40.inner[0];
        local_41 = static_cast<uint>(_e177);
        uint _e181 = local_40.inner[1];
        local_42 = static_cast<uint>(_e181);
        uint _e184 = local_42;
        out_1[_e184] = static_cast<int>(_e160);
        int _e186 = value;
        magnitude = static_cast<uint>(as_type<int>(as_type<uint>(_e186) + as_type<uint>(5)));
        uint _e191 = magnitude;
        type_7 _e194 = out;
        local_10 = _e194;
        uint _e196 = base;
        local_11 = static_cast<uint>(_e196 + 4u);
        type_7 _e202 = local_10;
        local_43 = _e202;
        uint _e204 = local_11;
        uint _e206 = local_43.inner[1];
        local_43.inner[1] = _e206 + _e204;
        uint _e210 = local_43.inner[0];
        local_44 = static_cast<uint>(_e210);
        uint _e214 = local_43.inner[1];
        local_45 = static_cast<uint>(_e214);
        uint _e217 = local_45;
        out_1[_e217] = static_cast<int>(_e191 * 3u);
        uint _e221 = accumulate(naga_mod(i_1, 5u));
        type_7 _e222 = out;
        local_12 = _e222;
        uint _e224 = base;
        local_13 = static_cast<uint>(_e224 + 5u);
        type_7 _e230 = local_12;
        local_46 = _e230;
        uint _e232 = local_13;
        uint _e234 = local_46.inner[1];
        local_46.inner[1] = _e234 + _e232;
        uint _e238 = local_46.inner[0];
        local_47 = static_cast<uint>(_e238);
        uint _e242 = local_46.inner[1];
        local_48 = static_cast<uint>(_e242);
        uint _e245 = local_48;
        out_1[_e245] = static_cast<int>(_e221);
        total = 0;
        {
            iteration = 0;
            uint2 loop_bound_1 = uint2(4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (metal::all(loop_bound_1 == uint2(0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e261 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e261) + as_type<uint>(1));
                }
                loop_init_1 = false;
                int _e251 = iteration;
                if (_e251 < 3) {
                } else {
                    break;
                }
                int _e254 = value;
                int _e255 = iteration;
                copied = as_type<int>(as_type<uint>(_e254) + as_type<uint>(_e255));
                int _e258 = copied;
                int _e259 = total;
                total = as_type<int>(as_type<uint>(_e259) + as_type<uint>(_e258));
            }
        }
        int _e264 = total;
        type_7 _e265 = out;
        local_14 = _e265;
        uint _e267 = base;
        local_15 = static_cast<uint>(_e267 + 6u);
        type_7 _e272 = local_14;
        local_49 = _e272;
        uint _e274 = local_15;
        uint _e276 = local_49.inner[1];
        local_49.inner[1] = _e276 + _e274;
        uint _e280 = local_49.inner[0];
        local_50 = static_cast<uint>(_e280);
        uint _e284 = local_49.inner[1];
        local_51 = static_cast<uint>(_e284);
        uint _e287 = local_51;
        out_1[_e287] = _e264;
        descending = 0;
        iteration_1 = 0;
        {
            uint2 loop_bound_2 = uint2(4294967295u);
            bool loop_init_2 = true;
            while(true) {
                if (metal::all(loop_bound_2 == uint2(0u))) { break; }
                loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
                if (!loop_init_2) {
                    int _e303 = iteration_1;
                    iteration_1 = as_type<int>(as_type<uint>(_e303) + as_type<uint>(1));
                }
                loop_init_2 = false;
                int _e293 = iteration_1;
                if (_e293 < 3) {
                } else {
                    break;
                }
                int _e296 = value;
                int _e297 = iteration_1;
                staged = as_type<int>(as_type<uint>(_e296) - as_type<uint>(_e297));
                int _e300 = staged;
                int _e301 = descending;
                descending = as_type<int>(as_type<uint>(_e301) + as_type<uint>(_e300));
            }
        }
        int _e306 = descending;
        type_7 _e307 = out;
        local_16 = _e307;
        uint _e309 = base;
        local_17 = static_cast<uint>(_e309 + 7u);
        type_7 _e314 = local_16;
        local_52 = _e314;
        uint _e316 = local_17;
        uint _e318 = local_52.inner[1];
        local_52.inner[1] = _e318 + _e316;
        uint _e322 = local_52.inner[0];
        local_53 = static_cast<uint>(_e322);
        uint _e326 = local_52.inner[1];
        local_54 = static_cast<uint>(_e326);
        uint _e329 = local_54;
        out_1[_e329] = _e306;
        remaining = 2;
        int _e333 = value;
        partial = _e333;
        uint2 loop_bound_3 = uint2(4294967295u);
        while(true) {
            if (metal::all(loop_bound_3 == uint2(0u))) { break; }
            loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
            int _e335 = remaining;
            if (_e335 > 0) {
            } else {
                break;
            }
            {
                int _e338 = partial;
                int _e339 = remaining;
                next = as_type<int>(as_type<uint>(_e338) + as_type<uint>(_e339));
                int _e342 = next;
                partial = _e342;
                int _e343 = remaining;
                remaining = as_type<int>(as_type<uint>(_e343) - as_type<uint>(1));
            }
        }
        int _e346 = partial;
        type_7 _e347 = out;
        local_18 = _e347;
        uint _e349 = base;
        local_19 = static_cast<uint>(_e349 + 8u);
        type_7 _e354 = local_18;
        local_55 = _e354;
        uint _e356 = local_19;
        uint _e358 = local_55.inner[1];
        local_55.inner[1] = _e358 + _e356;
        uint _e362 = local_55.inner[0];
        local_56 = static_cast<uint>(_e362);
        uint _e366 = local_55.inner[1];
        local_57 = static_cast<uint>(_e366);
        uint _e369 = local_57;
        out_1[_e369] = _e346;
        int _e371 = value;
        shadow = _e371;
        {
            int _e373 = value;
            shadow_1 = as_type<int>(as_type<uint>(_e373) + as_type<uint>(10));
            int _e377 = shadow_1;
            type_7 _e378 = out;
            local_20 = _e378;
            uint _e380 = base;
            local_21 = static_cast<uint>(_e380 + 9u);
            type_7 _e385 = local_20;
            local_58 = _e385;
            uint _e387 = local_21;
            uint _e389 = local_58.inner[1];
            local_58.inner[1] = _e389 + _e387;
            uint _e393 = local_58.inner[0];
            local_59 = static_cast<uint>(_e393);
            uint _e397 = local_58.inner[1];
            local_60 = static_cast<uint>(_e397);
            uint _e400 = local_60;
            out_1[_e400] = _e377;
        }
        int _e402 = shadow;
        type_7 _e403 = out;
        local_22 = _e403;
        uint _e405 = base;
        local_23 = static_cast<uint>(_e405 + 10u);
        type_7 _e410 = local_22;
        local_61 = _e410;
        uint _e412 = local_23;
        uint _e414 = local_61.inner[1];
        local_61.inner[1] = _e414 + _e412;
        uint _e418 = local_61.inner[0];
        local_62 = static_cast<uint>(_e418);
        uint _e422 = local_61.inner[1];
        local_63 = static_cast<uint>(_e422);
        uint _e425 = local_63;
        out_1[_e425] = _e402;
        int _e427 = value;
        float _e429 = scaled(static_cast<float>(_e427));
        type_7 _e430 = out;
        local_24 = _e430;
        uint _e432 = base;
        local_25 = static_cast<uint>(_e432 + 11u);
        type_7 _e438 = local_24;
        local_64 = _e438;
        uint _e440 = local_25;
        uint _e442 = local_64.inner[1];
        local_64.inner[1] = _e442 + _e440;
        uint _e446 = local_64.inner[0];
        local_65 = static_cast<uint>(_e446);
        uint _e450 = local_64.inner[1];
        local_66 = static_cast<uint>(_e450);
        uint _e453 = local_66;
        out_1[_e453] = naga_f2i32(_e429);
    }
}
