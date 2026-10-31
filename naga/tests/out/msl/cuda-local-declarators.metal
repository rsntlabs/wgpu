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
    int next = as_type<int>(as_type<uint>(value_1) + as_type<uint>(1));
    int result = as_type<int>(as_type<uint>(next) * as_type<uint>(2));
    return result;
}

int pair_add(
    int left,
    int right
) {
    return as_type<int>(as_type<uint>(left) + as_type<uint>(right));
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
, constant type_3& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 out = {};
    type_7 input = {};
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
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 12u;
        type_7 _e27 = input;
        local = _e27;
        local_1 = static_cast<uint>(i);
        type_7 _e31 = local;
        local_31 = _e31;
        uint _e33 = local_1;
        uint _e35 = local_31.inner[1];
        local_31.inner[1] = _e35 + _e33;
        uint _e39 = local_31.inner[0];
        local_32 = static_cast<uint>(_e39);
        uint _e43 = local_31.inner[1];
        local_33 = static_cast<uint>(_e43);
        uint _e46 = local_33;
        int _e49 = input_1[_e46];
        local_34 = _e49;
        int _e51 = local_34;
        local_29 = _e51;
        int _e53 = local_29;
        value = _e53;
        int _e55 = value;
        value = as_type<int>(as_type<uint>(_e55) + as_type<uint>(1));
        first = _e55;
        int _e59 = value;
        value = as_type<int>(as_type<uint>(_e59) + as_type<uint>(1));
        second = _e59;
        int _e63 = value;
        third = _e63;
        int _e65 = first;
        int _e68 = second;
        int _e72 = third;
        type_7 _e75 = out;
        local_2 = _e75;
        uint _e77 = base;
        local_3 = static_cast<uint>(_e77);
        type_7 _e80 = local_2;
        local_35 = _e80;
        uint _e82 = local_3;
        uint _e84 = local_35.inner[1];
        local_35.inner[1] = _e84 + _e82;
        uint _e88 = local_35.inner[0];
        local_36 = static_cast<uint>(_e88);
        uint _e92 = local_35.inner[1];
        local_37 = static_cast<uint>(_e92);
        uint _e95 = local_37;
        out_1[_e95] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e65) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e68) * as_type<uint>(10))))) + as_type<uint>(_e72));
        int _e98 = value;
        type_7 _e99 = out;
        local_4 = _e99;
        uint _e101 = base;
        local_5 = static_cast<uint>(_e101 + 1u);
        type_7 _e106 = local_4;
        local_38 = _e106;
        uint _e108 = local_5;
        uint _e110 = local_38.inner[1];
        local_38.inner[1] = _e110 + _e108;
        uint _e114 = local_38.inner[0];
        local_39 = static_cast<uint>(_e114);
        uint _e118 = local_38.inner[1];
        local_40 = static_cast<uint>(_e118);
        uint _e121 = local_40;
        out_1[_e121] = _e98;
        int _e123 = value;
        initialized = as_type<int>(as_type<uint>(_e123) + as_type<uint>(3));
        int _e127 = initialized;
        omitted = as_type<int>(as_type<uint>(_e127) + as_type<uint>(2));
        int _e131 = omitted;
        int _e132 = initialized;
        final = as_type<int>(as_type<uint>(_e131) + as_type<uint>(_e132));
        int _e135 = final;
        type_7 _e136 = out;
        local_6 = _e136;
        uint _e138 = base;
        local_7 = static_cast<uint>(_e138 + 2u);
        type_7 _e143 = local_6;
        local_41 = _e143;
        uint _e145 = local_7;
        uint _e147 = local_41.inner[1];
        local_41.inner[1] = _e147 + _e145;
        uint _e151 = local_41.inner[0];
        local_42 = static_cast<uint>(_e151);
        uint _e155 = local_41.inner[1];
        local_43 = static_cast<uint>(_e155);
        uint _e158 = local_43;
        out_1[_e158] = _e135;
        int _e160 = value;
        fixed = as_type<int>(as_type<uint>(_e160) + as_type<uint>(1));
        int _e164 = fixed;
        fixed_next = as_type<int>(as_type<uint>(_e164) + as_type<uint>(2));
        int _e168 = fixed_next;
        type_7 _e169 = out;
        local_8 = _e169;
        uint _e171 = base;
        local_9 = static_cast<uint>(_e171 + 3u);
        type_7 _e176 = local_8;
        local_44 = _e176;
        uint _e178 = local_9;
        uint _e180 = local_44.inner[1];
        local_44.inner[1] = _e180 + _e178;
        uint _e184 = local_44.inner[0];
        local_45 = static_cast<uint>(_e184);
        uint _e188 = local_44.inner[1];
        local_46 = static_cast<uint>(_e188);
        uint _e191 = local_46;
        out_1[_e191] = _e168;
        int _e193 = value;
        alias_first = as_type<int>(as_type<uint>(_e193) + as_type<uint>(4));
        int _e197 = alias_first;
        alias_next = as_type<int>(as_type<uint>(_e197) + as_type<uint>(1));
        int _e201 = alias_next;
        type_7 _e202 = out;
        local_10 = _e202;
        uint _e204 = base;
        local_11 = static_cast<uint>(_e204 + 4u);
        type_7 _e209 = local_10;
        local_47 = _e209;
        uint _e211 = local_11;
        uint _e213 = local_47.inner[1];
        local_47.inner[1] = _e213 + _e211;
        uint _e217 = local_47.inner[0];
        local_48 = static_cast<uint>(_e217);
        uint _e221 = local_47.inner[1];
        local_49 = static_cast<uint>(_e221);
        uint _e224 = local_49;
        out_1[_e224] = _e201;
        int _e226 = value;
        positive = _e226 > 0;
        bool _e230 = positive;
        local_12 = _e230;
        if (_e230) {
            type_7 _e232 = input;
            local_13 = _e232;
            local_14 = static_cast<uint>(i);
            type_7 _e236 = local_13;
            local_50 = _e236;
            uint _e238 = local_14;
            uint _e240 = local_50.inner[1];
            local_50.inner[1] = _e240 + _e238;
            uint _e244 = local_50.inner[0];
            local_51 = static_cast<uint>(_e244);
            uint _e248 = local_50.inner[1];
            local_52 = static_cast<uint>(_e248);
            uint _e251 = local_52;
            int _e253 = input_1[_e251];
            local_53 = _e253;
            int _e255 = local_53;
            local_30 = _e255;
            int _e257 = local_30;
            int _e260 = value;
            local_12 = _e260 == as_type<int>(as_type<uint>(_e257) + as_type<uint>(2));
        }
        bool _e262 = local_12;
        same = _e262;
        bool _e264 = same;
        type_7 _e265 = out;
        local_15 = _e265;
        uint _e267 = base;
        local_16 = static_cast<uint>(_e267 + 5u);
        type_7 _e273 = local_15;
        local_54 = _e273;
        uint _e275 = local_16;
        uint _e277 = local_54.inner[1];
        local_54.inner[1] = _e277 + _e275;
        uint _e281 = local_54.inner[0];
        local_55 = static_cast<uint>(_e281);
        uint _e285 = local_54.inner[1];
        local_56 = static_cast<uint>(_e285);
        uint _e288 = local_56;
        out_1[_e288] = static_cast<int>(_e264);
        int _e290 = value;
        low = static_cast<float>(_e290) * 0.5;
        float _e295 = low;
        high = _e295 + 1.5;
        float _e299 = high;
        type_7 _e303 = out;
        local_17 = _e303;
        uint _e305 = base;
        local_18 = static_cast<uint>(_e305 + 6u);
        type_7 _e310 = local_17;
        local_57 = _e310;
        uint _e312 = local_18;
        uint _e314 = local_57.inner[1];
        local_57.inner[1] = _e314 + _e312;
        uint _e318 = local_57.inner[0];
        local_58 = static_cast<uint>(_e318);
        uint _e322 = local_57.inner[1];
        local_59 = static_cast<uint>(_e322);
        uint _e325 = local_59;
        out_1[_e325] = naga_f2i32(_e299 * 2.0);
        start = naga_mod(i, 5u);
        uint _e330 = start;
        finish = _e330 + 3u;
        uint _e334 = finish;
        type_7 _e335 = out;
        local_19 = _e335;
        uint _e337 = base;
        local_20 = static_cast<uint>(_e337 + 7u);
        type_7 _e343 = local_19;
        local_60 = _e343;
        uint _e345 = local_20;
        uint _e347 = local_60.inner[1];
        local_60.inner[1] = _e347 + _e345;
        uint _e351 = local_60.inner[0];
        local_61 = static_cast<uint>(_e351);
        uint _e355 = local_60.inner[1];
        local_62 = static_cast<uint>(_e355);
        uint _e358 = local_62;
        out_1[_e358] = static_cast<int>(_e334);
        int _e360 = value;
        int _e361 = cached_type(_e360);
        type_7 _e362 = out;
        local_21 = _e362;
        uint _e364 = base;
        local_22 = static_cast<uint>(_e364 + 8u);
        type_7 _e369 = local_21;
        local_63 = _e369;
        uint _e371 = local_22;
        uint _e373 = local_63.inner[1];
        local_63.inner[1] = _e373 + _e371;
        uint _e377 = local_63.inner[0];
        local_64 = static_cast<uint>(_e377);
        uint _e381 = local_63.inner[1];
        local_65 = static_cast<uint>(_e381);
        uint _e384 = local_65;
        out_1[_e384] = _e361;
        int _e386 = value;
        outside = _e386;
        {
            int _e388 = value;
            outside_1 = as_type<int>(as_type<uint>(_e388) + as_type<uint>(5));
            int _e392 = outside_1;
            derived = as_type<int>(as_type<uint>(_e392) + as_type<uint>(2));
            int _e396 = derived;
            type_7 _e397 = out;
            local_23 = _e397;
            uint _e399 = base;
            local_24 = static_cast<uint>(_e399 + 9u);
            type_7 _e404 = local_23;
            local_66 = _e404;
            uint _e406 = local_24;
            uint _e408 = local_66.inner[1];
            local_66.inner[1] = _e408 + _e406;
            uint _e412 = local_66.inner[0];
            local_67 = static_cast<uint>(_e412);
            uint _e416 = local_66.inner[1];
            local_68 = static_cast<uint>(_e416);
            uint _e419 = local_68;
            out_1[_e419] = _e396;
        }
        total = 0;
        {
            iteration = 0;
            int _e425 = value;
            seed = _e425;
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e442 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e442) + as_type<uint>(1));
                }
                loop_init = false;
                int _e427 = iteration;
                if (_e427 < 4) {
                } else {
                    break;
                }
                int _e430 = iteration;
                if (_e430 == 1) {
                    continue;
                }
                int _e433 = seed;
                int _e434 = iteration;
                term = as_type<int>(as_type<uint>(_e433) + as_type<uint>(_e434));
                int _e437 = term;
                copied = _e437;
                int _e439 = copied;
                int _e440 = total;
                total = as_type<int>(as_type<uint>(_e440) + as_type<uint>(_e439));
            }
        }
        int _e445 = total;
        type_7 _e446 = out;
        local_25 = _e446;
        uint _e448 = base;
        local_26 = static_cast<uint>(_e448 + 10u);
        type_7 _e453 = local_25;
        local_69 = _e453;
        uint _e455 = local_26;
        uint _e457 = local_69.inner[1];
        local_69.inner[1] = _e457 + _e455;
        uint _e461 = local_69.inner[0];
        local_70 = static_cast<uint>(_e461);
        uint _e465 = local_69.inner[1];
        local_71 = static_cast<uint>(_e465);
        uint _e468 = local_71;
        out_1[_e468] = _e445;
        int _e470 = value;
        int _e472 = pair_add(_e470, 2);
        from_call = _e472;
        int _e474 = from_call;
        int _e476 = pair_add(_e474, 3);
        from_prior = _e476;
        int _e478 = from_prior;
        int _e479 = outside;
        type_7 _e481 = out;
        local_27 = _e481;
        uint _e483 = base;
        local_28 = static_cast<uint>(_e483 + 11u);
        type_7 _e488 = local_27;
        local_72 = _e488;
        uint _e490 = local_28;
        uint _e492 = local_72.inner[1];
        local_72.inner[1] = _e492 + _e490;
        uint _e496 = local_72.inner[0];
        local_73 = static_cast<uint>(_e496);
        uint _e500 = local_72.inner[1];
        local_74 = static_cast<uint>(_e500);
        uint _e503 = local_74;
        out_1[_e503] = as_type<int>(as_type<uint>(_e478) + as_type<uint>(_e479));
    }
}
