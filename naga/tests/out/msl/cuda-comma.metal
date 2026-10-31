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
    type_6 local = {};
    type_6 local_1 = {};
    uint n = {};
    uint i = {};
    uint base = {};
    int value = {};
    type_6 local_2 = {};
    uint local_3 = {};
    bool choose = {};
    int x = {};
    int sequenced = {};
    type_6 local_4 = {};
    uint local_5 = {};
    type_6 local_6 = {};
    uint local_7 = {};
    int target = {};
    type_6 local_8 = {};
    uint local_9 = {};
    int rhs = {};
    type_6 local_10 = {};
    uint local_11 = {};
    int middle = {};
    int selected = {};
    int local_12 = {};
    type_6 local_13 = {};
    uint local_14 = {};
    int left = {};
    int right = {};
    type_6 local_15 = {};
    uint local_16 = {};
    int identity = {};
    type_6 local_17 = {};
    uint local_18 = {};
    uint position = {};
    type_6 local_19 = {};
    uint local_20 = {};
    int effect = {};
    type_6 local_21 = {};
    uint local_22 = {};
    int total = {};
    int iteration = {};
    int current = {};
    type_6 local_23 = {};
    uint local_24 = {};
    int ticks = {};
    int passes = {};
    type_6 local_25 = {};
    uint local_26 = {};
    int argument = {};
    int first = {};
    int second = {};
    type_6 local_27 = {};
    uint local_28 = {};
    int local_29 = {};
    type_6 local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    int local_33 = {};
    type_6 local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    type_6 local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    type_6 local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    type_6 local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    type_6 local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    type_6 local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    type_6 local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    type_6 local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    type_6 local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    type_6 local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    type_6 local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    type_6 local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    local = type_6 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    local_1 = type_6 {};
    local_1.inner[0] = 1u;
    local_1.inner[1] = 0u;
    uint _e18 = n_1.value;
    n = _e18;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e26 = i;
    uint _e27 = n;
    if (_e26 < _e27) {
        uint _e29 = i;
        base = _e29 * 12u;
        type_6 _e35 = local_1;
        local_2 = _e35;
        uint _e36 = i;
        local_3 = static_cast<uint>(_e36);
        type_6 _e40 = local_2;
        local_30 = _e40;
        uint _e41 = local_3;
        uint _e43 = local_30.inner[1];
        local_30.inner[1] = _e43 + _e41;
        uint _e47 = local_30.inner[0];
        local_31 = static_cast<uint>(_e47);
        uint _e51 = local_30.inner[1];
        local_32 = static_cast<uint>(_e51);
        uint _e55 = local_32;
        int _e57 = input[_e55];
        local_33 = _e57;
        int _e58 = local_33;
        local_29 = _e58;
        int _e60 = local_29;
        value = _e60;
        uint _e62 = i;
        choose = naga_mod(_e62, 2u) == 0u;
        int _e68 = value;
        x = _e68;
        int _e70 = x;
        x = as_type<int>(as_type<uint>(_e70) + as_type<uint>(2));
        int _e73 = x;
        x = as_type<int>(as_type<uint>(_e73) * as_type<uint>(3));
        int _e76 = x;
        sequenced = as_type<int>(as_type<uint>(_e76) - as_type<uint>(1));
        int _e80 = sequenced;
        type_6 _e83 = local;
        local_4 = _e83;
        uint _e84 = base;
        local_5 = static_cast<uint>(_e84);
        type_6 _e88 = local_4;
        local_34 = _e88;
        uint _e89 = local_5;
        uint _e91 = local_34.inner[1];
        local_34.inner[1] = _e91 + _e89;
        uint _e95 = local_34.inner[0];
        local_35 = static_cast<uint>(_e95);
        uint _e99 = local_34.inner[1];
        local_36 = static_cast<uint>(_e99);
        uint _e102 = local_36;
        out[_e102] = _e80;
        int _e104 = x;
        type_6 _e106 = local;
        local_6 = _e106;
        uint _e107 = base;
        local_7 = static_cast<uint>(_e107 + 1u);
        type_6 _e113 = local_6;
        local_37 = _e113;
        uint _e114 = local_7;
        uint _e116 = local_37.inner[1];
        local_37.inner[1] = _e116 + _e114;
        uint _e120 = local_37.inner[0];
        local_38 = static_cast<uint>(_e120);
        uint _e124 = local_37.inner[1];
        local_39 = static_cast<uint>(_e124);
        uint _e127 = local_39;
        out[_e127] = _e104;
        target = 0;
        int _e131 = value;
        target = _e131;
        int _e132 = target;
        target = as_type<int>(as_type<uint>(_e132) + as_type<uint>(4));
        int _e135 = target;
        type_6 _e137 = local;
        local_8 = _e137;
        uint _e138 = base;
        local_9 = static_cast<uint>(_e138 + 2u);
        type_6 _e144 = local_8;
        local_40 = _e144;
        uint _e145 = local_9;
        uint _e147 = local_40.inner[1];
        local_40.inner[1] = _e147 + _e145;
        uint _e151 = local_40.inner[0];
        local_41 = static_cast<uint>(_e151);
        uint _e155 = local_40.inner[1];
        local_42 = static_cast<uint>(_e155);
        uint _e158 = local_42;
        out[_e158] = _e135;
        int _e160 = value;
        target = as_type<int>(as_type<uint>(_e160) + as_type<uint>(1));
        int _e163 = target;
        rhs = as_type<int>(as_type<uint>(_e163) + as_type<uint>(3));
        int _e167 = rhs;
        int _e170 = target;
        type_6 _e173 = local;
        local_10 = _e173;
        uint _e174 = base;
        local_11 = static_cast<uint>(_e174 + 3u);
        type_6 _e180 = local_10;
        local_43 = _e180;
        uint _e181 = local_11;
        uint _e183 = local_43.inner[1];
        local_43.inner[1] = _e183 + _e181;
        uint _e187 = local_43.inner[0];
        local_44 = static_cast<uint>(_e187);
        uint _e191 = local_43.inner[1];
        local_45 = static_cast<uint>(_e191);
        uint _e194 = local_45;
        out[_e194] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e167) * as_type<uint>(10))) + as_type<uint>(_e170));
        middle = 0;
        bool _e198 = choose;
        if (_e198) {
            int _e199 = value;
            middle = as_type<int>(as_type<uint>(_e199) + as_type<uint>(2));
            int _e202 = middle;
            local_12 = as_type<int>(as_type<uint>(_e202) + as_type<uint>(3));
        } else {
            int _e206 = value;
            local_12 = as_type<int>(as_type<uint>(_e206) - as_type<uint>(2));
        }
        int _e211 = local_12;
        selected = _e211;
        int _e213 = selected;
        int _e216 = middle;
        type_6 _e219 = local;
        local_13 = _e219;
        uint _e220 = base;
        local_14 = static_cast<uint>(_e220 + 4u);
        type_6 _e226 = local_13;
        local_46 = _e226;
        uint _e227 = local_14;
        uint _e229 = local_46.inner[1];
        local_46.inner[1] = _e229 + _e227;
        uint _e233 = local_46.inner[0];
        local_47 = static_cast<uint>(_e233);
        uint _e237 = local_46.inner[1];
        local_48 = static_cast<uint>(_e237);
        uint _e240 = local_48;
        out[_e240] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e213) * as_type<uint>(10))) + as_type<uint>(_e216));
        int _e242 = value;
        left = _e242;
        int _e244 = value;
        right = as_type<int>(as_type<uint>(_e244) + as_type<uint>(10));
        int _e248 = value;
        consume(_e248);
        bool _e249 = choose;
        if (_e249) {
            int _e250 = left;
            left = as_type<int>(as_type<uint>(_e250) + as_type<uint>(3));
        } else {
            int _e253 = right;
            right = as_type<int>(as_type<uint>(_e253) + as_type<uint>(3));
        }
        int _e256 = left;
        int _e259 = right;
        type_6 _e262 = local;
        local_15 = _e262;
        uint _e263 = base;
        local_16 = static_cast<uint>(_e263 + 5u);
        type_6 _e269 = local_15;
        local_49 = _e269;
        uint _e270 = local_16;
        uint _e272 = local_49.inner[1];
        local_49.inner[1] = _e272 + _e270;
        uint _e276 = local_49.inner[0];
        local_50 = static_cast<uint>(_e276);
        uint _e280 = local_49.inner[1];
        local_51 = static_cast<uint>(_e280);
        uint _e283 = local_51;
        out[_e283] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e256) * as_type<uint>(100))) + as_type<uint>(_e259));
        int _e285 = value;
        identity = _e285;
        int _e287 = identity;
        identity = as_type<int>(as_type<uint>(_e287) + as_type<uint>(1));
        consume(_e287);
        int _e290 = identity;
        identity = as_type<int>(as_type<uint>(_e290) + as_type<uint>(1));
        int _e293 = identity;
        type_6 _e295 = local;
        local_17 = _e295;
        uint _e296 = base;
        local_18 = static_cast<uint>(_e296 + 6u);
        type_6 _e302 = local_17;
        local_52 = _e302;
        uint _e303 = local_18;
        uint _e305 = local_52.inner[1];
        local_52.inner[1] = _e305 + _e303;
        uint _e309 = local_52.inner[0];
        local_53 = static_cast<uint>(_e309);
        uint _e313 = local_52.inner[1];
        local_54 = static_cast<uint>(_e313);
        uint _e316 = local_54;
        out[_e316] = _e293;
        uint _e318 = base;
        position = _e318 + 4u;
        uint _e322 = position;
        position = _e322 + 2u;
        int _e325 = value;
        uint _e330 = position;
        position = _e330 + static_cast<uint>(1);
        type_6 _e335 = local;
        local_19 = _e335;
        uint _e336 = position;
        local_20 = static_cast<uint>(_e336);
        type_6 _e340 = local_19;
        local_55 = _e340;
        uint _e341 = local_20;
        uint _e343 = local_55.inner[1];
        local_55.inner[1] = _e343 + _e341;
        uint _e347 = local_55.inner[0];
        local_56 = static_cast<uint>(_e347);
        uint _e351 = local_55.inner[1];
        local_57 = static_cast<uint>(_e351);
        uint _e354 = local_57;
        out[_e354] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e325) * as_type<uint>(2))) + as_type<uint>(2));
        int _e356 = value;
        effect = _e356;
        int _e358 = effect;
        effect = as_type<int>(as_type<uint>(_e358) + as_type<uint>(1));
        consume(_e358);
        int _e361 = effect;
        effect = as_type<int>(as_type<uint>(_e361) + as_type<uint>(1));
        consume(_e361);
        int _e364 = effect;
        effect = as_type<int>(as_type<uint>(_e364) + as_type<uint>(1));
        consume(_e364);
        int _e367 = effect;
        effect = as_type<int>(as_type<uint>(_e367) + as_type<uint>(1));
        consume(_e367);
        int _e370 = effect;
        type_6 _e372 = local;
        local_21 = _e372;
        uint _e373 = base;
        local_22 = static_cast<uint>(_e373 + 8u);
        type_6 _e379 = local_21;
        local_58 = _e379;
        uint _e380 = local_22;
        uint _e382 = local_58.inner[1];
        local_58.inner[1] = _e382 + _e380;
        uint _e386 = local_58.inner[0];
        local_59 = static_cast<uint>(_e386);
        uint _e390 = local_58.inner[1];
        local_60 = static_cast<uint>(_e390);
        uint _e393 = local_60;
        out[_e393] = _e370;
        total = 0;
        {
            iteration = 0;
            int _e399 = value;
            current = _e399;
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e410 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e410) + as_type<uint>(1));
                    int _e413 = current;
                    current = as_type<int>(as_type<uint>(_e413) + as_type<uint>(2));
                }
                loop_init = false;
                int _e401 = iteration;
                if (_e401 < 4) {
                } else {
                    break;
                }
                int _e404 = iteration;
                if (_e404 != 1) {
                    int _e407 = current;
                    int _e408 = total;
                    total = as_type<int>(as_type<uint>(_e408) + as_type<uint>(_e407));
                } else {
                    continue;
                }
            }
        }
        int _e416 = total;
        type_6 _e418 = local;
        local_23 = _e418;
        uint _e419 = base;
        local_24 = static_cast<uint>(_e419 + 9u);
        type_6 _e425 = local_23;
        local_61 = _e425;
        uint _e426 = local_24;
        uint _e428 = local_61.inner[1];
        local_61.inner[1] = _e428 + _e426;
        uint _e432 = local_61.inner[0];
        local_62 = static_cast<uint>(_e432);
        uint _e436 = local_61.inner[1];
        local_63 = static_cast<uint>(_e436);
        uint _e439 = local_63;
        out[_e439] = _e416;
        int _e441 = value;
        ticks = _e441;
        passes = 0;
        {
            int _e445 = value;
            ticks = as_type<int>(as_type<uint>(_e445) + as_type<uint>(1));
            passes = 0;
            uint2 loop_bound_1 = uint2(4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (metal::all(loop_bound_1 == uint2(0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e455 = ticks;
                    ticks = as_type<int>(as_type<uint>(_e455) + as_type<uint>(2));
                }
                loop_init_1 = false;
                int _e449 = passes;
                passes = as_type<int>(as_type<uint>(_e449) + as_type<uint>(1));
                int _e452 = passes;
                if (_e452 < 4) {
                } else {
                    break;
                }
            }
        }
        int _e458 = ticks;
        int _e461 = passes;
        type_6 _e464 = local;
        local_25 = _e464;
        uint _e465 = base;
        local_26 = static_cast<uint>(_e465 + 10u);
        type_6 _e471 = local_25;
        local_64 = _e471;
        uint _e472 = local_26;
        uint _e474 = local_64.inner[1];
        local_64.inner[1] = _e474 + _e472;
        uint _e478 = local_64.inner[0];
        local_65 = static_cast<uint>(_e478);
        uint _e482 = local_64.inner[1];
        local_66 = static_cast<uint>(_e482);
        uint _e485 = local_66;
        out[_e485] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e458) * as_type<uint>(10))) + as_type<uint>(_e461));
        int _e487 = value;
        argument = _e487;
        int _e489 = argument;
        argument = as_type<int>(as_type<uint>(_e489) + as_type<uint>(1));
        int _e492 = argument;
        int _e494 = pair_add(_e492, 2);
        first = _e494;
        int _e496 = first;
        int _e498 = pair_add(_e496, 3);
        second = _e498;
        int _e500 = second;
        int _e503 = argument;
        type_6 _e506 = local;
        local_27 = _e506;
        uint _e507 = base;
        local_28 = static_cast<uint>(_e507 + 11u);
        type_6 _e513 = local_27;
        local_67 = _e513;
        uint _e514 = local_28;
        uint _e516 = local_67.inner[1];
        local_67.inner[1] = _e516 + _e514;
        uint _e520 = local_67.inner[0];
        local_68 = static_cast<uint>(_e520);
        uint _e524 = local_67.inner[1];
        local_69 = static_cast<uint>(_e524);
        uint _e527 = local_69;
        out[_e527] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e500) * as_type<uint>(10))) + as_type<uint>(_e503));
    }
}
