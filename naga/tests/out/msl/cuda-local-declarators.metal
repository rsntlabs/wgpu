// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_1[1];
struct type_3 {
    uint value;
    char _pad1[12];
};

int cached_type(
    int value_1
) {
    int value_2 = {};
    int Number = {};
    int next = {};
    int result = {};
    value_2 = value_1;
    int _e3 = value_2;
    Number = _e3;
    int _e6 = Number;
    next = as_type<int>(as_type<uint>(_e6) + as_type<uint>(1));
    int _e10 = next;
    result = as_type<int>(as_type<uint>(_e10) * as_type<uint>(2));
    int _e12 = result;
    return _e12;
}

int pair_add(
    int left,
    int right
) {
    int left_1 = {};
    int right_1 = {};
    left_1 = left;
    right_1 = right;
    int _e4 = left_1;
    int _e5 = right_1;
    return as_type<int>(as_type<uint>(_e4) + as_type<uint>(_e5));
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct local_declaratorsInput {
};
kernel void local_declarators(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, device type_1 const& input [[user(fake0)]]
, constant type_3& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    uint n = {};
    uint i = {};
    uint base = {};
    int value = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    int first = {};
    int second = {};
    int third = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    int omitted = {};
    int initialized = {};
    int final = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    int fixed = {};
    int fixed_next = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    int alias_first = {};
    int alias_next = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    bool positive = {};
    bool same = {};
    bool local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    float low = {};
    float high = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint start = {};
    uint finish = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    int outside = {};
    int outside_1 = {};
    int derived = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    int total = {};
    int iteration = {};
    int seed = {};
    int term = {};
    int copied = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    int from_call = {};
    int from_prior = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    int local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    int local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    local = 0u;
    local_1 = 0u;
    uint _e8 = n_1.value;
    n = _e8;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e16 = i;
    uint _e17 = n;
    if (_e16 < _e17) {
        uint _e19 = i;
        base = _e19 * 12u;
        uint _e23 = local_1;
        local_2 = _e23;
        uint _e25 = local_2;
        local_3 = static_cast<uint>(_e25);
        uint _e28 = i;
        local_4 = static_cast<uint>(_e28);
        uint _e32 = local_3;
        uint _e33 = local_4;
        local_45 = static_cast<uint>(_e32 + _e33);
        uint _e38 = local_45;
        int _e40 = input[_e38];
        local_46 = _e40;
        int _e41 = local_46;
        value = _e41;
        int _e43 = value;
        value = as_type<int>(as_type<uint>(_e43) + as_type<uint>(1));
        first = _e43;
        int _e47 = value;
        value = as_type<int>(as_type<uint>(_e47) + as_type<uint>(1));
        second = _e47;
        int _e51 = value;
        third = _e51;
        int _e53 = first;
        int _e56 = second;
        int _e60 = third;
        uint _e62 = local;
        local_5 = _e62;
        uint _e64 = local_5;
        local_6 = static_cast<uint>(_e64);
        uint _e67 = base;
        local_7 = static_cast<uint>(_e67);
        uint _e71 = local_6;
        uint _e72 = local_7;
        local_47 = static_cast<uint>(_e71 + _e72);
        uint _e76 = local_47;
        out[_e76] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e53) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e56) * as_type<uint>(10))))) + as_type<uint>(_e60));
        int _e78 = value;
        uint _e79 = local;
        local_8 = _e79;
        uint _e81 = local_8;
        local_9 = static_cast<uint>(_e81);
        uint _e84 = base;
        local_10 = static_cast<uint>(_e84 + 1u);
        uint _e89 = local_9;
        uint _e90 = local_10;
        local_48 = static_cast<uint>(_e89 + _e90);
        uint _e94 = local_48;
        out[_e94] = _e78;
        int _e96 = value;
        initialized = as_type<int>(as_type<uint>(_e96) + as_type<uint>(3));
        int _e100 = initialized;
        omitted = as_type<int>(as_type<uint>(_e100) + as_type<uint>(2));
        int _e104 = omitted;
        int _e105 = initialized;
        final = as_type<int>(as_type<uint>(_e104) + as_type<uint>(_e105));
        int _e108 = final;
        uint _e109 = local;
        local_11 = _e109;
        uint _e111 = local_11;
        local_12 = static_cast<uint>(_e111);
        uint _e114 = base;
        local_13 = static_cast<uint>(_e114 + 2u);
        uint _e119 = local_12;
        uint _e120 = local_13;
        local_49 = static_cast<uint>(_e119 + _e120);
        uint _e124 = local_49;
        out[_e124] = _e108;
        int _e126 = value;
        fixed = as_type<int>(as_type<uint>(_e126) + as_type<uint>(1));
        int _e130 = fixed;
        fixed_next = as_type<int>(as_type<uint>(_e130) + as_type<uint>(2));
        int _e134 = fixed_next;
        uint _e135 = local;
        local_14 = _e135;
        uint _e137 = local_14;
        local_15 = static_cast<uint>(_e137);
        uint _e140 = base;
        local_16 = static_cast<uint>(_e140 + 3u);
        uint _e145 = local_15;
        uint _e146 = local_16;
        local_50 = static_cast<uint>(_e145 + _e146);
        uint _e150 = local_50;
        out[_e150] = _e134;
        int _e152 = value;
        alias_first = as_type<int>(as_type<uint>(_e152) + as_type<uint>(4));
        int _e156 = alias_first;
        alias_next = as_type<int>(as_type<uint>(_e156) + as_type<uint>(1));
        int _e160 = alias_next;
        uint _e161 = local;
        local_17 = _e161;
        uint _e163 = local_17;
        local_18 = static_cast<uint>(_e163);
        uint _e166 = base;
        local_19 = static_cast<uint>(_e166 + 4u);
        uint _e171 = local_18;
        uint _e172 = local_19;
        local_51 = static_cast<uint>(_e171 + _e172);
        uint _e176 = local_51;
        out[_e176] = _e160;
        int _e178 = value;
        positive = _e178 > 0;
        bool _e182 = positive;
        local_20 = _e182;
        if (_e182) {
            uint _e184 = local_1;
            local_21 = _e184;
            uint _e186 = local_21;
            local_22 = static_cast<uint>(_e186);
            uint _e189 = i;
            local_23 = static_cast<uint>(_e189);
            uint _e192 = local_22;
            uint _e193 = local_23;
            local_52 = static_cast<uint>(_e192 + _e193);
            uint _e198 = local_52;
            int _e200 = input[_e198];
            local_53 = _e200;
            int _e201 = local_53;
            int _e204 = value;
            local_20 = _e204 == as_type<int>(as_type<uint>(_e201) + as_type<uint>(2));
        }
        bool _e206 = local_20;
        same = _e206;
        bool _e208 = same;
        uint _e209 = local;
        local_24 = _e209;
        uint _e211 = local_24;
        local_25 = static_cast<uint>(_e211);
        uint _e214 = base;
        local_26 = static_cast<uint>(_e214 + 5u);
        uint _e220 = local_25;
        uint _e221 = local_26;
        local_54 = static_cast<uint>(_e220 + _e221);
        uint _e225 = local_54;
        out[_e225] = static_cast<int>(_e208);
        int _e227 = value;
        low = static_cast<float>(_e227) * 0.5;
        float _e232 = low;
        high = _e232 + 1.5;
        float _e236 = high;
        uint _e240 = local;
        local_27 = _e240;
        uint _e242 = local_27;
        local_28 = static_cast<uint>(_e242);
        uint _e245 = base;
        local_29 = static_cast<uint>(_e245 + 6u);
        uint _e250 = local_28;
        uint _e251 = local_29;
        local_55 = static_cast<uint>(_e250 + _e251);
        uint _e255 = local_55;
        out[_e255] = naga_f2i32(_e236 * 2.0);
        uint _e257 = i;
        start = naga_mod(_e257, 5u);
        uint _e261 = start;
        finish = _e261 + 3u;
        uint _e265 = finish;
        uint _e266 = local;
        local_30 = _e266;
        uint _e268 = local_30;
        local_31 = static_cast<uint>(_e268);
        uint _e271 = base;
        local_32 = static_cast<uint>(_e271 + 7u);
        uint _e277 = local_31;
        uint _e278 = local_32;
        local_56 = static_cast<uint>(_e277 + _e278);
        uint _e282 = local_56;
        out[_e282] = static_cast<int>(_e265);
        int _e284 = value;
        int _e285 = cached_type(_e284);
        uint _e286 = local;
        local_33 = _e286;
        uint _e288 = local_33;
        local_34 = static_cast<uint>(_e288);
        uint _e291 = base;
        local_35 = static_cast<uint>(_e291 + 8u);
        uint _e296 = local_34;
        uint _e297 = local_35;
        local_57 = static_cast<uint>(_e296 + _e297);
        uint _e301 = local_57;
        out[_e301] = _e285;
        int _e303 = value;
        outside = _e303;
        {
            int _e305 = value;
            outside_1 = as_type<int>(as_type<uint>(_e305) + as_type<uint>(5));
            int _e309 = outside_1;
            derived = as_type<int>(as_type<uint>(_e309) + as_type<uint>(2));
            int _e313 = derived;
            uint _e314 = local;
            local_36 = _e314;
            uint _e316 = local_36;
            local_37 = static_cast<uint>(_e316);
            uint _e319 = base;
            local_38 = static_cast<uint>(_e319 + 9u);
            uint _e324 = local_37;
            uint _e325 = local_38;
            local_58 = static_cast<uint>(_e324 + _e325);
            uint _e329 = local_58;
            out[_e329] = _e313;
        }
        total = 0;
        {
            iteration = 0;
            int _e335 = value;
            seed = _e335;
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e352 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e352) + as_type<uint>(1));
                }
                loop_init = false;
                int _e337 = iteration;
                if (_e337 < 4) {
                } else {
                    break;
                }
                int _e340 = iteration;
                if (_e340 == 1) {
                    continue;
                }
                int _e343 = seed;
                int _e344 = iteration;
                term = as_type<int>(as_type<uint>(_e343) + as_type<uint>(_e344));
                int _e347 = term;
                copied = _e347;
                int _e349 = copied;
                int _e350 = total;
                total = as_type<int>(as_type<uint>(_e350) + as_type<uint>(_e349));
            }
        }
        int _e355 = total;
        uint _e356 = local;
        local_39 = _e356;
        uint _e358 = local_39;
        local_40 = static_cast<uint>(_e358);
        uint _e361 = base;
        local_41 = static_cast<uint>(_e361 + 10u);
        uint _e366 = local_40;
        uint _e367 = local_41;
        local_59 = static_cast<uint>(_e366 + _e367);
        uint _e371 = local_59;
        out[_e371] = _e355;
        int _e373 = value;
        int _e375 = pair_add(_e373, 2);
        from_call = _e375;
        int _e377 = from_call;
        int _e379 = pair_add(_e377, 3);
        from_prior = _e379;
        int _e381 = from_prior;
        int _e382 = outside;
        uint _e384 = local;
        local_42 = _e384;
        uint _e386 = local_42;
        local_43 = static_cast<uint>(_e386);
        uint _e389 = base;
        local_44 = static_cast<uint>(_e389 + 11u);
        uint _e394 = local_43;
        uint _e395 = local_44;
        local_60 = static_cast<uint>(_e394 + _e395);
        uint _e399 = local_60;
        out[_e399] = as_type<int>(as_type<uint>(_e381) + as_type<uint>(_e382));
    }
}
