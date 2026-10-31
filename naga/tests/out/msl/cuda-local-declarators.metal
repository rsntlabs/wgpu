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
struct type_7 {
    uint inner[2];
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
, device type_1& out_1 [[user(fake0)]]
, device type_1 const& input_1 [[user(fake0)]]
, constant type_3& n_1 [[user(fake0)]]
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
    int first = {};
    int second = {};
    int third = {};
    type_7 local_2 = {};
    uint local_3 = {};
    type_7 local_4 = {};
    uint local_5 = {};
    int omitted = {};
    int initialized = {};
    int final = {};
    type_7 local_6 = {};
    uint local_7 = {};
    int fixed = {};
    int fixed_next = {};
    type_7 local_8 = {};
    uint local_9 = {};
    int alias_first = {};
    int alias_next = {};
    type_7 local_10 = {};
    uint local_11 = {};
    bool positive = {};
    bool same = {};
    bool local_12 = {};
    type_7 local_13 = {};
    uint local_14 = {};
    type_7 local_15 = {};
    uint local_16 = {};
    float low = {};
    float high = {};
    type_7 local_17 = {};
    uint local_18 = {};
    uint start = {};
    uint finish = {};
    type_7 local_19 = {};
    uint local_20 = {};
    type_7 local_21 = {};
    uint local_22 = {};
    int outside = {};
    int outside_1 = {};
    int derived = {};
    type_7 local_23 = {};
    uint local_24 = {};
    int total = {};
    int iteration = {};
    int seed = {};
    int term = {};
    int copied = {};
    type_7 local_25 = {};
    uint local_26 = {};
    int from_call = {};
    int from_prior = {};
    type_7 local_27 = {};
    uint local_28 = {};
    int local_29 = {};
    int local_30 = {};
    type_7 local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    int local_34 = {};
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
    type_7 local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    int local_53 = {};
    type_7 local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    type_7 local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    type_7 local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    type_7 local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    type_7 local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    type_7 local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    type_7 local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
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
        local_31 = _e40;
        uint _e41 = local_1;
        uint _e43 = local_31.inner[1];
        local_31.inner[1] = _e43 + _e41;
        uint _e47 = local_31.inner[0];
        local_32 = static_cast<uint>(_e47);
        uint _e51 = local_31.inner[1];
        local_33 = static_cast<uint>(_e51);
        uint _e55 = local_33;
        int _e57 = input_1[_e55];
        local_34 = _e57;
        int _e58 = local_34;
        local_29 = _e58;
        int _e60 = local_29;
        value = _e60;
        int _e62 = value;
        value = as_type<int>(as_type<uint>(_e62) + as_type<uint>(1));
        first = _e62;
        int _e66 = value;
        value = as_type<int>(as_type<uint>(_e66) + as_type<uint>(1));
        second = _e66;
        int _e70 = value;
        third = _e70;
        int _e72 = first;
        int _e75 = second;
        int _e79 = third;
        type_7 _e83 = out;
        local_2 = _e83;
        uint _e84 = base;
        local_3 = static_cast<uint>(_e84);
        type_7 _e88 = local_2;
        local_35 = _e88;
        uint _e89 = local_3;
        uint _e91 = local_35.inner[1];
        local_35.inner[1] = _e91 + _e89;
        uint _e95 = local_35.inner[0];
        local_36 = static_cast<uint>(_e95);
        uint _e99 = local_35.inner[1];
        local_37 = static_cast<uint>(_e99);
        uint _e102 = local_37;
        out_1[_e102] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e72) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e75) * as_type<uint>(10))))) + as_type<uint>(_e79));
        int _e104 = value;
        type_7 _e106 = out;
        local_4 = _e106;
        uint _e107 = base;
        local_5 = static_cast<uint>(_e107 + 1u);
        type_7 _e113 = local_4;
        local_38 = _e113;
        uint _e114 = local_5;
        uint _e116 = local_38.inner[1];
        local_38.inner[1] = _e116 + _e114;
        uint _e120 = local_38.inner[0];
        local_39 = static_cast<uint>(_e120);
        uint _e124 = local_38.inner[1];
        local_40 = static_cast<uint>(_e124);
        uint _e127 = local_40;
        out_1[_e127] = _e104;
        int _e129 = value;
        initialized = as_type<int>(as_type<uint>(_e129) + as_type<uint>(3));
        int _e133 = initialized;
        omitted = as_type<int>(as_type<uint>(_e133) + as_type<uint>(2));
        int _e137 = omitted;
        int _e138 = initialized;
        final = as_type<int>(as_type<uint>(_e137) + as_type<uint>(_e138));
        int _e141 = final;
        type_7 _e143 = out;
        local_6 = _e143;
        uint _e144 = base;
        local_7 = static_cast<uint>(_e144 + 2u);
        type_7 _e150 = local_6;
        local_41 = _e150;
        uint _e151 = local_7;
        uint _e153 = local_41.inner[1];
        local_41.inner[1] = _e153 + _e151;
        uint _e157 = local_41.inner[0];
        local_42 = static_cast<uint>(_e157);
        uint _e161 = local_41.inner[1];
        local_43 = static_cast<uint>(_e161);
        uint _e164 = local_43;
        out_1[_e164] = _e141;
        int _e166 = value;
        fixed = as_type<int>(as_type<uint>(_e166) + as_type<uint>(1));
        int _e170 = fixed;
        fixed_next = as_type<int>(as_type<uint>(_e170) + as_type<uint>(2));
        int _e174 = fixed_next;
        type_7 _e176 = out;
        local_8 = _e176;
        uint _e177 = base;
        local_9 = static_cast<uint>(_e177 + 3u);
        type_7 _e183 = local_8;
        local_44 = _e183;
        uint _e184 = local_9;
        uint _e186 = local_44.inner[1];
        local_44.inner[1] = _e186 + _e184;
        uint _e190 = local_44.inner[0];
        local_45 = static_cast<uint>(_e190);
        uint _e194 = local_44.inner[1];
        local_46 = static_cast<uint>(_e194);
        uint _e197 = local_46;
        out_1[_e197] = _e174;
        int _e199 = value;
        alias_first = as_type<int>(as_type<uint>(_e199) + as_type<uint>(4));
        int _e203 = alias_first;
        alias_next = as_type<int>(as_type<uint>(_e203) + as_type<uint>(1));
        int _e207 = alias_next;
        type_7 _e209 = out;
        local_10 = _e209;
        uint _e210 = base;
        local_11 = static_cast<uint>(_e210 + 4u);
        type_7 _e216 = local_10;
        local_47 = _e216;
        uint _e217 = local_11;
        uint _e219 = local_47.inner[1];
        local_47.inner[1] = _e219 + _e217;
        uint _e223 = local_47.inner[0];
        local_48 = static_cast<uint>(_e223);
        uint _e227 = local_47.inner[1];
        local_49 = static_cast<uint>(_e227);
        uint _e230 = local_49;
        out_1[_e230] = _e207;
        int _e232 = value;
        positive = _e232 > 0;
        bool _e236 = positive;
        local_12 = _e236;
        if (_e236) {
            type_7 _e239 = input;
            local_13 = _e239;
            uint _e240 = i;
            local_14 = static_cast<uint>(_e240);
            type_7 _e244 = local_13;
            local_50 = _e244;
            uint _e245 = local_14;
            uint _e247 = local_50.inner[1];
            local_50.inner[1] = _e247 + _e245;
            uint _e251 = local_50.inner[0];
            local_51 = static_cast<uint>(_e251);
            uint _e255 = local_50.inner[1];
            local_52 = static_cast<uint>(_e255);
            uint _e259 = local_52;
            int _e261 = input_1[_e259];
            local_53 = _e261;
            int _e262 = local_53;
            local_30 = _e262;
            int _e264 = local_30;
            int _e267 = value;
            local_12 = _e267 == as_type<int>(as_type<uint>(_e264) + as_type<uint>(2));
        }
        bool _e269 = local_12;
        same = _e269;
        bool _e271 = same;
        type_7 _e273 = out;
        local_15 = _e273;
        uint _e274 = base;
        local_16 = static_cast<uint>(_e274 + 5u);
        type_7 _e281 = local_15;
        local_54 = _e281;
        uint _e282 = local_16;
        uint _e284 = local_54.inner[1];
        local_54.inner[1] = _e284 + _e282;
        uint _e288 = local_54.inner[0];
        local_55 = static_cast<uint>(_e288);
        uint _e292 = local_54.inner[1];
        local_56 = static_cast<uint>(_e292);
        uint _e295 = local_56;
        out_1[_e295] = static_cast<int>(_e271);
        int _e297 = value;
        low = static_cast<float>(_e297) * 0.5;
        float _e302 = low;
        high = _e302 + 1.5;
        float _e306 = high;
        type_7 _e311 = out;
        local_17 = _e311;
        uint _e312 = base;
        local_18 = static_cast<uint>(_e312 + 6u);
        type_7 _e318 = local_17;
        local_57 = _e318;
        uint _e319 = local_18;
        uint _e321 = local_57.inner[1];
        local_57.inner[1] = _e321 + _e319;
        uint _e325 = local_57.inner[0];
        local_58 = static_cast<uint>(_e325);
        uint _e329 = local_57.inner[1];
        local_59 = static_cast<uint>(_e329);
        uint _e332 = local_59;
        out_1[_e332] = naga_f2i32(_e306 * 2.0);
        uint _e334 = i;
        start = naga_mod(_e334, 5u);
        uint _e338 = start;
        finish = _e338 + 3u;
        uint _e342 = finish;
        type_7 _e344 = out;
        local_19 = _e344;
        uint _e345 = base;
        local_20 = static_cast<uint>(_e345 + 7u);
        type_7 _e352 = local_19;
        local_60 = _e352;
        uint _e353 = local_20;
        uint _e355 = local_60.inner[1];
        local_60.inner[1] = _e355 + _e353;
        uint _e359 = local_60.inner[0];
        local_61 = static_cast<uint>(_e359);
        uint _e363 = local_60.inner[1];
        local_62 = static_cast<uint>(_e363);
        uint _e366 = local_62;
        out_1[_e366] = static_cast<int>(_e342);
        int _e368 = value;
        int _e369 = cached_type(_e368);
        type_7 _e371 = out;
        local_21 = _e371;
        uint _e372 = base;
        local_22 = static_cast<uint>(_e372 + 8u);
        type_7 _e378 = local_21;
        local_63 = _e378;
        uint _e379 = local_22;
        uint _e381 = local_63.inner[1];
        local_63.inner[1] = _e381 + _e379;
        uint _e385 = local_63.inner[0];
        local_64 = static_cast<uint>(_e385);
        uint _e389 = local_63.inner[1];
        local_65 = static_cast<uint>(_e389);
        uint _e392 = local_65;
        out_1[_e392] = _e369;
        int _e394 = value;
        outside = _e394;
        {
            int _e396 = value;
            outside_1 = as_type<int>(as_type<uint>(_e396) + as_type<uint>(5));
            int _e400 = outside_1;
            derived = as_type<int>(as_type<uint>(_e400) + as_type<uint>(2));
            int _e404 = derived;
            type_7 _e406 = out;
            local_23 = _e406;
            uint _e407 = base;
            local_24 = static_cast<uint>(_e407 + 9u);
            type_7 _e413 = local_23;
            local_66 = _e413;
            uint _e414 = local_24;
            uint _e416 = local_66.inner[1];
            local_66.inner[1] = _e416 + _e414;
            uint _e420 = local_66.inner[0];
            local_67 = static_cast<uint>(_e420);
            uint _e424 = local_66.inner[1];
            local_68 = static_cast<uint>(_e424);
            uint _e427 = local_68;
            out_1[_e427] = _e404;
        }
        total = 0;
        {
            iteration = 0;
            int _e433 = value;
            seed = _e433;
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e450 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e450) + as_type<uint>(1));
                }
                loop_init = false;
                int _e435 = iteration;
                if (_e435 < 4) {
                } else {
                    break;
                }
                int _e438 = iteration;
                if (_e438 == 1) {
                    continue;
                }
                int _e441 = seed;
                int _e442 = iteration;
                term = as_type<int>(as_type<uint>(_e441) + as_type<uint>(_e442));
                int _e445 = term;
                copied = _e445;
                int _e447 = copied;
                int _e448 = total;
                total = as_type<int>(as_type<uint>(_e448) + as_type<uint>(_e447));
            }
        }
        int _e453 = total;
        type_7 _e455 = out;
        local_25 = _e455;
        uint _e456 = base;
        local_26 = static_cast<uint>(_e456 + 10u);
        type_7 _e462 = local_25;
        local_69 = _e462;
        uint _e463 = local_26;
        uint _e465 = local_69.inner[1];
        local_69.inner[1] = _e465 + _e463;
        uint _e469 = local_69.inner[0];
        local_70 = static_cast<uint>(_e469);
        uint _e473 = local_69.inner[1];
        local_71 = static_cast<uint>(_e473);
        uint _e476 = local_71;
        out_1[_e476] = _e453;
        int _e478 = value;
        int _e480 = pair_add(_e478, 2);
        from_call = _e480;
        int _e482 = from_call;
        int _e484 = pair_add(_e482, 3);
        from_prior = _e484;
        int _e486 = from_prior;
        int _e487 = outside;
        type_7 _e490 = out;
        local_27 = _e490;
        uint _e491 = base;
        local_28 = static_cast<uint>(_e491 + 11u);
        type_7 _e497 = local_27;
        local_72 = _e497;
        uint _e498 = local_28;
        uint _e500 = local_72.inner[1];
        local_72.inner[1] = _e500 + _e498;
        uint _e504 = local_72.inner[0];
        local_73 = static_cast<uint>(_e504);
        uint _e508 = local_72.inner[1];
        local_74 = static_cast<uint>(_e508);
        uint _e511 = local_74;
        out_1[_e511] = as_type<int>(as_type<uint>(_e486) + as_type<uint>(_e487));
    }
}
