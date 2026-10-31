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
struct type_6 {
    uint inner[2];
};

void consume(
    int value_1
) {
    if (value_1 < 0) {
        return;
    } else {
        return;
    }
}

int pair_add(
    int left_1,
    int right_1
) {
    return as_type<int>(as_type<uint>(left_1) + as_type<uint>(right_1));
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct commaInput {
};
kernel void comma(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out_1 [[user(fake0)]]
, device type_1 const& input_1 [[user(fake0)]]
, constant type_3& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_6 out = {};
    type_6 input = {};
    uint base = {};
    int value = {};
    type_6 local = {};
    uint local_1 = {};
    bool choose = {};
    int x = {};
    int sequenced = {};
    type_6 local_2 = {};
    uint local_3 = {};
    type_6 local_4 = {};
    uint local_5 = {};
    int target = {};
    type_6 local_6 = {};
    uint local_7 = {};
    int rhs = {};
    type_6 local_8 = {};
    uint local_9 = {};
    int middle = {};
    int selected = {};
    int local_10 = {};
    type_6 local_11 = {};
    uint local_12 = {};
    int left = {};
    int right = {};
    type_6 local_13 = {};
    uint local_14 = {};
    int identity = {};
    type_6 local_15 = {};
    uint local_16 = {};
    uint position = {};
    type_6 local_17 = {};
    uint local_18 = {};
    int effect = {};
    type_6 local_19 = {};
    uint local_20 = {};
    int total = {};
    int iteration = {};
    int current = {};
    type_6 local_21 = {};
    uint local_22 = {};
    int ticks = {};
    int passes = {};
    type_6 local_23 = {};
    uint local_24 = {};
    int argument = {};
    int first = {};
    int second = {};
    type_6 local_25 = {};
    uint local_26 = {};
    int local_27 = {};
    type_6 local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    int local_31 = {};
    type_6 local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    type_6 local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    type_6 local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    type_6 local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    type_6 local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    type_6 local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    type_6 local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    type_6 local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    type_6 local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    type_6 local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    type_6 local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    type_6 local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    out = type_6 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    input = type_6 {};
    input.inner[0] = 1u;
    input.inner[1] = 0u;
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 12u;
        type_6 _e27 = input;
        local = _e27;
        local_1 = static_cast<uint>(i);
        type_6 _e31 = local;
        local_28 = _e31;
        uint _e33 = local_1;
        uint _e35 = local_28.inner[1];
        local_28.inner[1] = _e35 + _e33;
        uint _e39 = local_28.inner[0];
        local_29 = static_cast<uint>(_e39);
        uint _e43 = local_28.inner[1];
        local_30 = static_cast<uint>(_e43);
        uint _e46 = local_30;
        int _e49 = input_1[_e46];
        local_31 = _e49;
        int _e51 = local_31;
        local_27 = _e51;
        int _e53 = local_27;
        value = _e53;
        choose = naga_mod(i, 2u) == 0u;
        int _e60 = value;
        x = _e60;
        int _e62 = x;
        x = as_type<int>(as_type<uint>(_e62) + as_type<uint>(2));
        int _e65 = x;
        x = as_type<int>(as_type<uint>(_e65) * as_type<uint>(3));
        int _e68 = x;
        sequenced = as_type<int>(as_type<uint>(_e68) - as_type<uint>(1));
        int _e72 = sequenced;
        type_6 _e74 = out;
        local_2 = _e74;
        uint _e76 = base;
        local_3 = static_cast<uint>(_e76);
        type_6 _e79 = local_2;
        local_32 = _e79;
        uint _e81 = local_3;
        uint _e83 = local_32.inner[1];
        local_32.inner[1] = _e83 + _e81;
        uint _e87 = local_32.inner[0];
        local_33 = static_cast<uint>(_e87);
        uint _e91 = local_32.inner[1];
        local_34 = static_cast<uint>(_e91);
        uint _e94 = local_34;
        out_1[_e94] = _e72;
        int _e97 = x;
        type_6 _e98 = out;
        local_4 = _e98;
        uint _e100 = base;
        local_5 = static_cast<uint>(_e100 + 1u);
        type_6 _e105 = local_4;
        local_35 = _e105;
        uint _e107 = local_5;
        uint _e109 = local_35.inner[1];
        local_35.inner[1] = _e109 + _e107;
        uint _e113 = local_35.inner[0];
        local_36 = static_cast<uint>(_e113);
        uint _e117 = local_35.inner[1];
        local_37 = static_cast<uint>(_e117);
        uint _e120 = local_37;
        out_1[_e120] = _e97;
        target = 0;
        int _e124 = value;
        target = _e124;
        int _e125 = target;
        target = as_type<int>(as_type<uint>(_e125) + as_type<uint>(4));
        int _e128 = target;
        type_6 _e129 = out;
        local_6 = _e129;
        uint _e131 = base;
        local_7 = static_cast<uint>(_e131 + 2u);
        type_6 _e136 = local_6;
        local_38 = _e136;
        uint _e138 = local_7;
        uint _e140 = local_38.inner[1];
        local_38.inner[1] = _e140 + _e138;
        uint _e144 = local_38.inner[0];
        local_39 = static_cast<uint>(_e144);
        uint _e148 = local_38.inner[1];
        local_40 = static_cast<uint>(_e148);
        uint _e151 = local_40;
        out_1[_e151] = _e128;
        int _e153 = value;
        target = as_type<int>(as_type<uint>(_e153) + as_type<uint>(1));
        int _e156 = target;
        rhs = as_type<int>(as_type<uint>(_e156) + as_type<uint>(3));
        int _e160 = rhs;
        int _e163 = target;
        type_6 _e165 = out;
        local_8 = _e165;
        uint _e167 = base;
        local_9 = static_cast<uint>(_e167 + 3u);
        type_6 _e172 = local_8;
        local_41 = _e172;
        uint _e174 = local_9;
        uint _e176 = local_41.inner[1];
        local_41.inner[1] = _e176 + _e174;
        uint _e180 = local_41.inner[0];
        local_42 = static_cast<uint>(_e180);
        uint _e184 = local_41.inner[1];
        local_43 = static_cast<uint>(_e184);
        uint _e187 = local_43;
        out_1[_e187] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e160) * as_type<uint>(10))) + as_type<uint>(_e163));
        middle = 0;
        bool _e191 = choose;
        if (_e191) {
            int _e192 = value;
            middle = as_type<int>(as_type<uint>(_e192) + as_type<uint>(2));
            int _e195 = middle;
            local_10 = as_type<int>(as_type<uint>(_e195) + as_type<uint>(3));
        } else {
            int _e199 = value;
            local_10 = as_type<int>(as_type<uint>(_e199) - as_type<uint>(2));
        }
        int _e204 = local_10;
        selected = _e204;
        int _e206 = selected;
        int _e209 = middle;
        type_6 _e211 = out;
        local_11 = _e211;
        uint _e213 = base;
        local_12 = static_cast<uint>(_e213 + 4u);
        type_6 _e218 = local_11;
        local_44 = _e218;
        uint _e220 = local_12;
        uint _e222 = local_44.inner[1];
        local_44.inner[1] = _e222 + _e220;
        uint _e226 = local_44.inner[0];
        local_45 = static_cast<uint>(_e226);
        uint _e230 = local_44.inner[1];
        local_46 = static_cast<uint>(_e230);
        uint _e233 = local_46;
        out_1[_e233] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e206) * as_type<uint>(10))) + as_type<uint>(_e209));
        int _e235 = value;
        left = _e235;
        int _e237 = value;
        right = as_type<int>(as_type<uint>(_e237) + as_type<uint>(10));
        int _e241 = value;
        consume(_e241);
        bool _e242 = choose;
        if (_e242) {
            int _e243 = left;
            left = as_type<int>(as_type<uint>(_e243) + as_type<uint>(3));
        } else {
            int _e246 = right;
            right = as_type<int>(as_type<uint>(_e246) + as_type<uint>(3));
        }
        int _e249 = left;
        int _e252 = right;
        type_6 _e254 = out;
        local_13 = _e254;
        uint _e256 = base;
        local_14 = static_cast<uint>(_e256 + 5u);
        type_6 _e261 = local_13;
        local_47 = _e261;
        uint _e263 = local_14;
        uint _e265 = local_47.inner[1];
        local_47.inner[1] = _e265 + _e263;
        uint _e269 = local_47.inner[0];
        local_48 = static_cast<uint>(_e269);
        uint _e273 = local_47.inner[1];
        local_49 = static_cast<uint>(_e273);
        uint _e276 = local_49;
        out_1[_e276] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e249) * as_type<uint>(100))) + as_type<uint>(_e252));
        int _e278 = value;
        identity = _e278;
        int _e280 = identity;
        identity = as_type<int>(as_type<uint>(_e280) + as_type<uint>(1));
        consume(_e280);
        int _e283 = identity;
        identity = as_type<int>(as_type<uint>(_e283) + as_type<uint>(1));
        int _e286 = identity;
        type_6 _e287 = out;
        local_15 = _e287;
        uint _e289 = base;
        local_16 = static_cast<uint>(_e289 + 6u);
        type_6 _e294 = local_15;
        local_50 = _e294;
        uint _e296 = local_16;
        uint _e298 = local_50.inner[1];
        local_50.inner[1] = _e298 + _e296;
        uint _e302 = local_50.inner[0];
        local_51 = static_cast<uint>(_e302);
        uint _e306 = local_50.inner[1];
        local_52 = static_cast<uint>(_e306);
        uint _e309 = local_52;
        out_1[_e309] = _e286;
        uint _e311 = base;
        position = _e311 + 4u;
        uint _e315 = position;
        position = _e315 + 2u;
        int _e318 = value;
        uint _e323 = position;
        position = _e323 + static_cast<uint>(1);
        type_6 _e327 = out;
        local_17 = _e327;
        uint _e329 = position;
        local_18 = static_cast<uint>(_e329);
        type_6 _e332 = local_17;
        local_53 = _e332;
        uint _e334 = local_18;
        uint _e336 = local_53.inner[1];
        local_53.inner[1] = _e336 + _e334;
        uint _e340 = local_53.inner[0];
        local_54 = static_cast<uint>(_e340);
        uint _e344 = local_53.inner[1];
        local_55 = static_cast<uint>(_e344);
        uint _e347 = local_55;
        out_1[_e347] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e318) * as_type<uint>(2))) + as_type<uint>(2));
        int _e349 = value;
        effect = _e349;
        int _e351 = effect;
        effect = as_type<int>(as_type<uint>(_e351) + as_type<uint>(1));
        consume(_e351);
        int _e354 = effect;
        effect = as_type<int>(as_type<uint>(_e354) + as_type<uint>(1));
        consume(_e354);
        int _e357 = effect;
        effect = as_type<int>(as_type<uint>(_e357) + as_type<uint>(1));
        consume(_e357);
        int _e360 = effect;
        effect = as_type<int>(as_type<uint>(_e360) + as_type<uint>(1));
        consume(_e360);
        int _e363 = effect;
        type_6 _e364 = out;
        local_19 = _e364;
        uint _e366 = base;
        local_20 = static_cast<uint>(_e366 + 8u);
        type_6 _e371 = local_19;
        local_56 = _e371;
        uint _e373 = local_20;
        uint _e375 = local_56.inner[1];
        local_56.inner[1] = _e375 + _e373;
        uint _e379 = local_56.inner[0];
        local_57 = static_cast<uint>(_e379);
        uint _e383 = local_56.inner[1];
        local_58 = static_cast<uint>(_e383);
        uint _e386 = local_58;
        out_1[_e386] = _e363;
        total = 0;
        {
            iteration = 0;
            int _e392 = value;
            current = _e392;
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e403 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e403) + as_type<uint>(1));
                    int _e406 = current;
                    current = as_type<int>(as_type<uint>(_e406) + as_type<uint>(2));
                }
                loop_init = false;
                int _e394 = iteration;
                if (_e394 < 4) {
                } else {
                    break;
                }
                int _e397 = iteration;
                if (_e397 != 1) {
                    int _e400 = current;
                    int _e401 = total;
                    total = as_type<int>(as_type<uint>(_e401) + as_type<uint>(_e400));
                } else {
                    continue;
                }
            }
        }
        int _e409 = total;
        type_6 _e410 = out;
        local_21 = _e410;
        uint _e412 = base;
        local_22 = static_cast<uint>(_e412 + 9u);
        type_6 _e417 = local_21;
        local_59 = _e417;
        uint _e419 = local_22;
        uint _e421 = local_59.inner[1];
        local_59.inner[1] = _e421 + _e419;
        uint _e425 = local_59.inner[0];
        local_60 = static_cast<uint>(_e425);
        uint _e429 = local_59.inner[1];
        local_61 = static_cast<uint>(_e429);
        uint _e432 = local_61;
        out_1[_e432] = _e409;
        int _e434 = value;
        ticks = _e434;
        passes = 0;
        {
            int _e438 = value;
            ticks = as_type<int>(as_type<uint>(_e438) + as_type<uint>(1));
            passes = 0;
            uint2 loop_bound_1 = uint2(4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (metal::all(loop_bound_1 == uint2(0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e448 = ticks;
                    ticks = as_type<int>(as_type<uint>(_e448) + as_type<uint>(2));
                }
                loop_init_1 = false;
                int _e442 = passes;
                passes = as_type<int>(as_type<uint>(_e442) + as_type<uint>(1));
                int _e445 = passes;
                if (_e445 < 4) {
                } else {
                    break;
                }
            }
        }
        int _e451 = ticks;
        int _e454 = passes;
        type_6 _e456 = out;
        local_23 = _e456;
        uint _e458 = base;
        local_24 = static_cast<uint>(_e458 + 10u);
        type_6 _e463 = local_23;
        local_62 = _e463;
        uint _e465 = local_24;
        uint _e467 = local_62.inner[1];
        local_62.inner[1] = _e467 + _e465;
        uint _e471 = local_62.inner[0];
        local_63 = static_cast<uint>(_e471);
        uint _e475 = local_62.inner[1];
        local_64 = static_cast<uint>(_e475);
        uint _e478 = local_64;
        out_1[_e478] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e451) * as_type<uint>(10))) + as_type<uint>(_e454));
        int _e480 = value;
        argument = _e480;
        int _e482 = argument;
        argument = as_type<int>(as_type<uint>(_e482) + as_type<uint>(1));
        int _e485 = argument;
        int _e487 = pair_add(_e485, 2);
        first = _e487;
        int _e489 = first;
        int _e491 = pair_add(_e489, 3);
        second = _e491;
        int _e493 = second;
        int _e496 = argument;
        type_6 _e498 = out;
        local_25 = _e498;
        uint _e500 = base;
        local_26 = static_cast<uint>(_e500 + 11u);
        type_6 _e505 = local_25;
        local_65 = _e505;
        uint _e507 = local_26;
        uint _e509 = local_65.inner[1];
        local_65.inner[1] = _e509 + _e507;
        uint _e513 = local_65.inner[0];
        local_66 = static_cast<uint>(_e513);
        uint _e517 = local_65.inner[1];
        local_67 = static_cast<uint>(_e517);
        uint _e520 = local_67;
        out_1[_e520] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e493) * as_type<uint>(10))) + as_type<uint>(_e496));
    }
}
