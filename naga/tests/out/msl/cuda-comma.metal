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

void consume(
    int value_1
) {
    int value_2 = {};
    value_2 = value_1;
    int _e3 = value_2;
    if (_e3 < 0) {
        return;
    } else {
        return;
    }
}

int pair_add(
    int left_1,
    int right_1
) {
    int left_2 = {};
    int right_2 = {};
    left_2 = left_1;
    right_2 = right_1;
    int _e4 = left_2;
    int _e5 = right_2;
    return as_type<int>(as_type<uint>(_e4) + as_type<uint>(_e5));
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct commaInput {
};
kernel void comma(
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
    bool choose = {};
    int x = {};
    int sequenced = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    int target = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    int rhs = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    int middle = {};
    int selected = {};
    int local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    int left = {};
    int right = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    int identity = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint position = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    int effect = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    int total = {};
    int iteration = {};
    int current = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    int ticks = {};
    int passes = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    int argument = {};
    int first = {};
    int second = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    int local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
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
        local_42 = static_cast<uint>(_e32 + _e33);
        uint _e38 = local_42;
        int _e40 = input[_e38];
        local_43 = _e40;
        int _e41 = local_43;
        value = _e41;
        uint _e43 = i;
        choose = naga_mod(_e43, 2u) == 0u;
        int _e49 = value;
        x = _e49;
        int _e51 = x;
        x = as_type<int>(as_type<uint>(_e51) + as_type<uint>(2));
        int _e54 = x;
        x = as_type<int>(as_type<uint>(_e54) * as_type<uint>(3));
        int _e57 = x;
        sequenced = as_type<int>(as_type<uint>(_e57) - as_type<uint>(1));
        int _e61 = sequenced;
        uint _e62 = local;
        local_5 = _e62;
        uint _e64 = local_5;
        local_6 = static_cast<uint>(_e64);
        uint _e67 = base;
        local_7 = static_cast<uint>(_e67);
        uint _e71 = local_6;
        uint _e72 = local_7;
        local_44 = static_cast<uint>(_e71 + _e72);
        uint _e76 = local_44;
        out[_e76] = _e61;
        int _e78 = x;
        uint _e79 = local;
        local_8 = _e79;
        uint _e81 = local_8;
        local_9 = static_cast<uint>(_e81);
        uint _e84 = base;
        local_10 = static_cast<uint>(_e84 + 1u);
        uint _e89 = local_9;
        uint _e90 = local_10;
        local_45 = static_cast<uint>(_e89 + _e90);
        uint _e94 = local_45;
        out[_e94] = _e78;
        target = 0;
        int _e98 = value;
        target = _e98;
        int _e99 = target;
        target = as_type<int>(as_type<uint>(_e99) + as_type<uint>(4));
        int _e102 = target;
        uint _e103 = local;
        local_11 = _e103;
        uint _e105 = local_11;
        local_12 = static_cast<uint>(_e105);
        uint _e108 = base;
        local_13 = static_cast<uint>(_e108 + 2u);
        uint _e113 = local_12;
        uint _e114 = local_13;
        local_46 = static_cast<uint>(_e113 + _e114);
        uint _e118 = local_46;
        out[_e118] = _e102;
        int _e120 = value;
        target = as_type<int>(as_type<uint>(_e120) + as_type<uint>(1));
        int _e123 = target;
        rhs = as_type<int>(as_type<uint>(_e123) + as_type<uint>(3));
        int _e127 = rhs;
        int _e130 = target;
        uint _e132 = local;
        local_14 = _e132;
        uint _e134 = local_14;
        local_15 = static_cast<uint>(_e134);
        uint _e137 = base;
        local_16 = static_cast<uint>(_e137 + 3u);
        uint _e142 = local_15;
        uint _e143 = local_16;
        local_47 = static_cast<uint>(_e142 + _e143);
        uint _e147 = local_47;
        out[_e147] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e127) * as_type<uint>(10))) + as_type<uint>(_e130));
        middle = 0;
        bool _e151 = choose;
        if (_e151) {
            int _e152 = value;
            middle = as_type<int>(as_type<uint>(_e152) + as_type<uint>(2));
            int _e155 = middle;
            local_17 = as_type<int>(as_type<uint>(_e155) + as_type<uint>(3));
        } else {
            int _e159 = value;
            local_17 = as_type<int>(as_type<uint>(_e159) - as_type<uint>(2));
        }
        int _e164 = local_17;
        selected = _e164;
        int _e166 = selected;
        int _e169 = middle;
        uint _e171 = local;
        local_18 = _e171;
        uint _e173 = local_18;
        local_19 = static_cast<uint>(_e173);
        uint _e176 = base;
        local_20 = static_cast<uint>(_e176 + 4u);
        uint _e181 = local_19;
        uint _e182 = local_20;
        local_48 = static_cast<uint>(_e181 + _e182);
        uint _e186 = local_48;
        out[_e186] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e166) * as_type<uint>(10))) + as_type<uint>(_e169));
        int _e188 = value;
        left = _e188;
        int _e190 = value;
        right = as_type<int>(as_type<uint>(_e190) + as_type<uint>(10));
        int _e194 = value;
        consume(_e194);
        bool _e195 = choose;
        if (_e195) {
            int _e196 = left;
            left = as_type<int>(as_type<uint>(_e196) + as_type<uint>(3));
        } else {
            int _e199 = right;
            right = as_type<int>(as_type<uint>(_e199) + as_type<uint>(3));
        }
        int _e202 = left;
        int _e205 = right;
        uint _e207 = local;
        local_21 = _e207;
        uint _e209 = local_21;
        local_22 = static_cast<uint>(_e209);
        uint _e212 = base;
        local_23 = static_cast<uint>(_e212 + 5u);
        uint _e217 = local_22;
        uint _e218 = local_23;
        local_49 = static_cast<uint>(_e217 + _e218);
        uint _e222 = local_49;
        out[_e222] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e202) * as_type<uint>(100))) + as_type<uint>(_e205));
        int _e224 = value;
        identity = _e224;
        int _e226 = identity;
        identity = as_type<int>(as_type<uint>(_e226) + as_type<uint>(1));
        consume(_e226);
        int _e229 = identity;
        identity = as_type<int>(as_type<uint>(_e229) + as_type<uint>(1));
        int _e232 = identity;
        uint _e233 = local;
        local_24 = _e233;
        uint _e235 = local_24;
        local_25 = static_cast<uint>(_e235);
        uint _e238 = base;
        local_26 = static_cast<uint>(_e238 + 6u);
        uint _e243 = local_25;
        uint _e244 = local_26;
        local_50 = static_cast<uint>(_e243 + _e244);
        uint _e248 = local_50;
        out[_e248] = _e232;
        uint _e250 = base;
        position = _e250 + 4u;
        uint _e254 = position;
        position = _e254 + 2u;
        int _e257 = value;
        uint _e262 = position;
        position = _e262 + static_cast<uint>(1);
        uint _e266 = local;
        local_27 = _e266;
        uint _e268 = local_27;
        local_28 = static_cast<uint>(_e268);
        uint _e271 = position;
        local_29 = static_cast<uint>(_e271);
        uint _e274 = local_28;
        uint _e275 = local_29;
        local_51 = static_cast<uint>(_e274 + _e275);
        uint _e279 = local_51;
        out[_e279] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e257) * as_type<uint>(2))) + as_type<uint>(2));
        int _e281 = value;
        effect = _e281;
        int _e283 = effect;
        effect = as_type<int>(as_type<uint>(_e283) + as_type<uint>(1));
        consume(_e283);
        int _e286 = effect;
        effect = as_type<int>(as_type<uint>(_e286) + as_type<uint>(1));
        consume(_e286);
        int _e289 = effect;
        effect = as_type<int>(as_type<uint>(_e289) + as_type<uint>(1));
        consume(_e289);
        int _e292 = effect;
        effect = as_type<int>(as_type<uint>(_e292) + as_type<uint>(1));
        consume(_e292);
        int _e295 = effect;
        uint _e296 = local;
        local_30 = _e296;
        uint _e298 = local_30;
        local_31 = static_cast<uint>(_e298);
        uint _e301 = base;
        local_32 = static_cast<uint>(_e301 + 8u);
        uint _e306 = local_31;
        uint _e307 = local_32;
        local_52 = static_cast<uint>(_e306 + _e307);
        uint _e311 = local_52;
        out[_e311] = _e295;
        total = 0;
        {
            iteration = 0;
            int _e317 = value;
            current = _e317;
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e328 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e328) + as_type<uint>(1));
                    int _e331 = current;
                    current = as_type<int>(as_type<uint>(_e331) + as_type<uint>(2));
                }
                loop_init = false;
                int _e319 = iteration;
                if (_e319 < 4) {
                } else {
                    break;
                }
                int _e322 = iteration;
                if (_e322 != 1) {
                    int _e325 = current;
                    int _e326 = total;
                    total = as_type<int>(as_type<uint>(_e326) + as_type<uint>(_e325));
                } else {
                    continue;
                }
            }
        }
        int _e334 = total;
        uint _e335 = local;
        local_33 = _e335;
        uint _e337 = local_33;
        local_34 = static_cast<uint>(_e337);
        uint _e340 = base;
        local_35 = static_cast<uint>(_e340 + 9u);
        uint _e345 = local_34;
        uint _e346 = local_35;
        local_53 = static_cast<uint>(_e345 + _e346);
        uint _e350 = local_53;
        out[_e350] = _e334;
        int _e352 = value;
        ticks = _e352;
        passes = 0;
        {
            int _e356 = value;
            ticks = as_type<int>(as_type<uint>(_e356) + as_type<uint>(1));
            passes = 0;
            uint2 loop_bound_1 = uint2(4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (metal::all(loop_bound_1 == uint2(0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e366 = ticks;
                    ticks = as_type<int>(as_type<uint>(_e366) + as_type<uint>(2));
                }
                loop_init_1 = false;
                int _e360 = passes;
                passes = as_type<int>(as_type<uint>(_e360) + as_type<uint>(1));
                int _e363 = passes;
                if (_e363 < 4) {
                } else {
                    break;
                }
            }
        }
        int _e369 = ticks;
        int _e372 = passes;
        uint _e374 = local;
        local_36 = _e374;
        uint _e376 = local_36;
        local_37 = static_cast<uint>(_e376);
        uint _e379 = base;
        local_38 = static_cast<uint>(_e379 + 10u);
        uint _e384 = local_37;
        uint _e385 = local_38;
        local_54 = static_cast<uint>(_e384 + _e385);
        uint _e389 = local_54;
        out[_e389] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e369) * as_type<uint>(10))) + as_type<uint>(_e372));
        int _e391 = value;
        argument = _e391;
        int _e393 = argument;
        argument = as_type<int>(as_type<uint>(_e393) + as_type<uint>(1));
        int _e396 = argument;
        int _e398 = pair_add(_e396, 2);
        first = _e398;
        int _e400 = first;
        int _e402 = pair_add(_e400, 3);
        second = _e402;
        int _e404 = second;
        int _e407 = argument;
        uint _e409 = local;
        local_39 = _e409;
        uint _e411 = local_39;
        local_40 = static_cast<uint>(_e411);
        uint _e414 = base;
        local_41 = static_cast<uint>(_e414 + 11u);
        uint _e419 = local_40;
        uint _e420 = local_41;
        local_55 = static_cast<uint>(_e419 + _e420);
        uint _e424 = local_55;
        out[_e424] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e404) * as_type<uint>(10))) + as_type<uint>(_e407));
    }
}
