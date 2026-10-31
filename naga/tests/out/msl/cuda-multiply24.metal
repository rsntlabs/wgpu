// language: metal1.2
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_4[1];
struct type_5 {
    int inner[2];
};

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int signed_conversion(
    float first_1,
    float second_1
) {
    return as_type<int>(as_type<uint>(metal::extract_bits(naga_f2i32(first_1), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(naga_f2i32(second_1), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
}

uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}

uint unsigned_conversion(
    float first_2,
    float second_2
) {
    return metal::extract_bits(naga_f2u32(first_2), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(naga_f2u32(second_2), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
}

int _mul24_(
    bool first_3,
    bool second_3
) {
    int local_66 = {};
    int local_67 = {};
    if (first_3) {
        if (second_3) {
            local_66 = 71;
        } else {
            local_66 = 73;
        }
        int _e7 = local_66;
        local_67 = _e7;
    } else {
        local_67 = 79;
    }
    int _e12 = local_67;
    return _e12;
}

int _mul24_1(
    float first_4,
    float second_4
) {
    return naga_f2i32((first_4 * 10.0) + second_4);
}

uint _umul24_(
    int first_5,
    int second_5
) {
    return static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(first_5) + as_type<uint>(second_5))) + as_type<uint>(100)));
}

int signed_pair(
    int first_6,
    int second_6
) {
    return as_type<int>(as_type<uint>(metal::extract_bits(first_6, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(second_6, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void multiply24_(
  device type_4& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    int first = {};
    uint second = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    int local_25 = {};
    type_5 values = {};
    uint local_26 = {};
    int Count = {};
    int local_27 = {};
    type_5 scratch = {};
    uint local_28 = {};
    int counter = {};
    uint local_29 = {};
    uint local_30 = {};
    int total = {};
    int index = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
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
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    local = static_cast<uint>(0);
    uint _e15 = local;
    local_34 = static_cast<uint>(_e15);
    uint _e18 = local_34;
    out[_e18] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(8388608, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(1, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    local_1 = static_cast<uint>(1);
    uint _e30 = local_1;
    local_35 = static_cast<uint>(_e30);
    uint _e33 = local_35;
    out[_e33] = metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    local_2 = static_cast<uint>(2);
    uint _e49 = local_2;
    local_36 = static_cast<uint>(_e49);
    uint _e52 = local_36;
    out[_e52] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(8388607, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(8388607, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    local_3 = static_cast<uint>(3);
    uint _e64 = local_3;
    local_37 = static_cast<uint>(_e64);
    uint _e67 = local_37;
    out[_e67] = metal::extract_bits(16777216u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(13u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    int _e72 = signed_conversion(3.75, -(2.75));
    local_4 = static_cast<uint>(4);
    uint _e77 = local_4;
    local_38 = static_cast<uint>(_e77);
    uint _e80 = local_38;
    out[_e80] = static_cast<uint>(_e72);
    int _e85 = signed_conversion(-(3.75), 2.75);
    local_5 = static_cast<uint>(5);
    uint _e90 = local_5;
    local_39 = static_cast<uint>(_e90);
    uint _e93 = local_39;
    out[_e93] = static_cast<uint>(_e85);
    uint _e97 = unsigned_conversion(3.75, 2.75);
    local_6 = static_cast<uint>(6);
    uint _e101 = local_6;
    local_40 = static_cast<uint>(_e101);
    uint _e104 = local_40;
    out[_e104] = _e97;
    uint _e108 = unsigned_conversion(16777215.0, 1.0);
    local_7 = static_cast<uint>(7);
    uint _e112 = local_7;
    local_41 = static_cast<uint>(_e112);
    uint _e115 = local_41;
    out[_e115] = _e108;
    int _e119 = _mul24_(true, true);
    local_8 = static_cast<uint>(8);
    uint _e124 = local_8;
    local_42 = static_cast<uint>(_e124);
    uint _e127 = local_42;
    out[_e127] = static_cast<uint>(_e119);
    int _e131 = _mul24_(false, true);
    local_9 = static_cast<uint>(9);
    uint _e136 = local_9;
    local_43 = static_cast<uint>(_e136);
    uint _e139 = local_43;
    out[_e139] = static_cast<uint>(_e131);
    local_10 = static_cast<uint>(10);
    uint _e156 = local_10;
    local_44 = static_cast<uint>(_e156);
    uint _e159 = local_44;
    out[_e159] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(static_cast<int>(true), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    local_11 = static_cast<uint>(11);
    uint _e176 = local_11;
    local_45 = static_cast<uint>(_e176);
    uint _e179 = local_45;
    out[_e179] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(static_cast<int>(true), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e183 = _mul24_1(3.75, 2.0);
    local_12 = static_cast<uint>(12);
    uint _e188 = local_12;
    local_46 = static_cast<uint>(_e188);
    uint _e191 = local_46;
    out[_e191] = static_cast<uint>(_e183);
    uint _e195 = _umul24_(3, 4);
    local_13 = static_cast<uint>(13);
    uint _e199 = local_13;
    local_47 = static_cast<uint>(_e199);
    uint _e202 = local_47;
    out[_e202] = _e195;
    local_14 = static_cast<uint>(14);
    uint _e214 = local_14;
    local_48 = static_cast<uint>(_e214);
    uint _e217 = local_48;
    out[_e217] = metal::extract_bits(3u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(4u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    uint _e223 = _umul24_(static_cast<int>(true), static_cast<int>(true));
    local_15 = static_cast<uint>(15);
    uint _e227 = local_15;
    local_49 = static_cast<uint>(_e227);
    uint _e230 = local_49;
    out[_e230] = _e223;
    local_16 = static_cast<uint>(16);
    uint _e243 = local_16;
    local_50 = static_cast<uint>(_e243);
    uint _e246 = local_50;
    out[_e246] = metal::extract_bits(3u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(static_cast<uint>(4), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    int _e251 = signed_pair(naga_neg(7), 3);
    local_17 = static_cast<uint>(17);
    uint _e256 = local_17;
    local_51 = static_cast<uint>(_e256);
    uint _e259 = local_51;
    out[_e259] = static_cast<uint>(_e251);
    local_18 = static_cast<uint>(18);
    uint _e284 = local_18;
    local_52 = static_cast<uint>(_e284);
    uint _e287 = local_52;
    out[_e287] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(4, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(5, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    local_19 = static_cast<uint>(19);
    uint _e305 = local_19;
    local_53 = static_cast<uint>(_e305);
    uint _e308 = local_53;
    out[_e308] = metal::extract_bits(metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(2u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(2u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    first = -3;
    second = 5u;
    int _e314 = first;
    uint _e315 = second;
    local_20 = static_cast<uint>(20);
    uint _e329 = local_20;
    local_54 = static_cast<uint>(_e329);
    uint _e332 = local_54;
    out[_e332] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(_e314, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(static_cast<int>(_e315), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e334 = first;
    uint _e336 = second;
    local_21 = static_cast<uint>(21);
    uint _e345 = local_21;
    local_55 = static_cast<uint>(_e345);
    uint _e348 = local_55;
    out[_e348] = metal::extract_bits(static_cast<uint>(_e334), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(_e336, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    local_22 = static_cast<uint>(22);
    uint _e364 = local_22;
    local_56 = static_cast<uint>(_e364);
    uint _e367 = local_56;
    out[_e367] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(25165824, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(16777217, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    local_23 = static_cast<uint>(23);
    uint _e379 = local_23;
    local_57 = static_cast<uint>(_e379);
    uint _e382 = local_57;
    out[_e382] = metal::extract_bits(4286578688u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(4278190081u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    if (true) {
        local_25 = as_type<int>(as_type<uint>(metal::extract_bits(naga_neg(3), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(7, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    } else {
        local_25 = as_type<int>(as_type<uint>(metal::extract_bits(0, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(0, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    }
    int _e409 = local_25;
    local_24 = static_cast<uint>(24);
    uint _e414 = local_24;
    local_58 = static_cast<uint>(_e414);
    uint _e417 = local_58;
    out[_e417] = static_cast<uint>(_e409);
    values.inner[0] = as_type<int>(as_type<uint>(metal::extract_bits(2, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    values.inner[1] = as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(4, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    int _e446 = values.inner[0];
    int _e447 = values.inner[1];
    local_26 = static_cast<uint>(25);
    uint _e453 = local_26;
    local_59 = static_cast<uint>(_e453);
    uint _e456 = local_59;
    out[_e456] = static_cast<uint>(as_type<int>(as_type<uint>(_e446) + as_type<uint>(_e447)));
    Count = 2;
    scratch = type_5 {};
    int _e464 = Count;
    int _e465 = scratch.inner[0];
    local_28 = static_cast<uint>(26);
    uint _e471 = local_28;
    local_60 = static_cast<uint>(_e471);
    uint _e474 = local_60;
    out[_e474] = static_cast<uint>(as_type<int>(as_type<uint>(_e464) + as_type<uint>(_e465)));
    counter = 2;
    int _e478 = counter;
    counter = as_type<int>(as_type<uint>(_e478) + as_type<uint>(1));
    int _e481 = counter;
    counter = as_type<int>(as_type<uint>(_e481) + as_type<uint>(1));
    local_29 = static_cast<uint>(27);
    uint _e496 = local_29;
    local_61 = static_cast<uint>(_e496);
    uint _e499 = local_61;
    out[_e499] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(_e478, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(_e481, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e501 = counter;
    local_30 = static_cast<uint>(28);
    uint _e506 = local_30;
    local_62 = static_cast<uint>(_e506);
    uint _e509 = local_62;
    out[_e509] = static_cast<uint>(_e501);
    total = 0;
    {
        index = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e532 = index;
                index = as_type<int>(as_type<uint>(_e532) + as_type<uint>(1));
            }
            loop_init = false;
            int _e515 = index;
            if (_e515 < 3) {
            } else {
                break;
            }
            int _e518 = index;
            int _e530 = total;
            total = as_type<int>(as_type<uint>(_e530) + as_type<uint>(as_type<int>(as_type<uint>(metal::extract_bits(as_type<int>(as_type<uint>(_e518) + as_type<uint>(1)), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(2, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))))));
        }
    }
    int _e535 = total;
    local_31 = static_cast<uint>(29);
    uint _e540 = local_31;
    local_63 = static_cast<uint>(_e540);
    uint _e543 = local_63;
    out[_e543] = static_cast<uint>(_e535);
    {
        local_32 = static_cast<uint>(30);
        uint _e551 = local_32;
        local_64 = static_cast<uint>(_e551);
        uint _e554 = local_64;
        out[_e554] = static_cast<uint>(naga_f2i32(9.75));
    }
    local_33 = static_cast<uint>(31);
    uint _e570 = local_33;
    local_65 = static_cast<uint>(_e570);
    uint _e573 = local_65;
    out[_e573] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(16777215, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
}
