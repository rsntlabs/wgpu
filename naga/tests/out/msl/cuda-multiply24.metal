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
    int local_35 = {};
    int local_36 = {};
    if (first_3) {
        if (second_3) {
            local_35 = 71;
        } else {
            local_35 = 73;
        }
        int _e7 = local_35;
        local_36 = _e7;
    } else {
        local_36 = 79;
    }
    int _e12 = local_36;
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
    local = static_cast<uint>(0);
    uint _e14 = local;
    out[_e14] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(8388608, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(1, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    local_1 = static_cast<uint>(1);
    uint _e27 = local_1;
    out[_e27] = metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    local_2 = static_cast<uint>(2);
    uint _e43 = local_2;
    out[_e43] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(8388607, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(8388607, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    local_3 = static_cast<uint>(3);
    uint _e55 = local_3;
    out[_e55] = metal::extract_bits(16777216u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(13u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    int _e60 = signed_conversion(3.75, -(2.75));
    local_4 = static_cast<uint>(4);
    uint _e65 = local_4;
    out[_e65] = static_cast<uint>(_e60);
    int _e70 = signed_conversion(-(3.75), 2.75);
    local_5 = static_cast<uint>(5);
    uint _e75 = local_5;
    out[_e75] = static_cast<uint>(_e70);
    uint _e79 = unsigned_conversion(3.75, 2.75);
    local_6 = static_cast<uint>(6);
    uint _e83 = local_6;
    out[_e83] = _e79;
    uint _e87 = unsigned_conversion(16777215.0, 1.0);
    local_7 = static_cast<uint>(7);
    uint _e91 = local_7;
    out[_e91] = _e87;
    int _e95 = _mul24_(true, true);
    local_8 = static_cast<uint>(8);
    uint _e100 = local_8;
    out[_e100] = static_cast<uint>(_e95);
    int _e104 = _mul24_(false, true);
    local_9 = static_cast<uint>(9);
    uint _e109 = local_9;
    out[_e109] = static_cast<uint>(_e104);
    local_10 = static_cast<uint>(10);
    uint _e126 = local_10;
    out[_e126] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(static_cast<int>(true), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    local_11 = static_cast<uint>(11);
    uint _e143 = local_11;
    out[_e143] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(static_cast<int>(true), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e147 = _mul24_1(3.75, 2.0);
    local_12 = static_cast<uint>(12);
    uint _e152 = local_12;
    out[_e152] = static_cast<uint>(_e147);
    uint _e156 = _umul24_(3, 4);
    local_13 = static_cast<uint>(13);
    uint _e160 = local_13;
    out[_e160] = _e156;
    local_14 = static_cast<uint>(14);
    uint _e172 = local_14;
    out[_e172] = metal::extract_bits(3u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(4u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    uint _e178 = _umul24_(static_cast<int>(true), static_cast<int>(true));
    local_15 = static_cast<uint>(15);
    uint _e182 = local_15;
    out[_e182] = _e178;
    local_16 = static_cast<uint>(16);
    uint _e195 = local_16;
    out[_e195] = metal::extract_bits(3u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(static_cast<uint>(4), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    int _e200 = signed_pair(naga_neg(7), 3);
    local_17 = static_cast<uint>(17);
    uint _e205 = local_17;
    out[_e205] = static_cast<uint>(_e200);
    local_18 = static_cast<uint>(18);
    uint _e230 = local_18;
    out[_e230] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(4, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(5, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    local_19 = static_cast<uint>(19);
    uint _e248 = local_19;
    out[_e248] = metal::extract_bits(metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(2u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(2u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    first = -3;
    second = 5u;
    int _e254 = first;
    uint _e255 = second;
    local_20 = static_cast<uint>(20);
    uint _e269 = local_20;
    out[_e269] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(_e254, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(static_cast<int>(_e255), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e271 = first;
    uint _e273 = second;
    local_21 = static_cast<uint>(21);
    uint _e282 = local_21;
    out[_e282] = metal::extract_bits(static_cast<uint>(_e271), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(_e273, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    local_22 = static_cast<uint>(22);
    uint _e298 = local_22;
    out[_e298] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(25165824, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(16777217, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    local_23 = static_cast<uint>(23);
    uint _e310 = local_23;
    out[_e310] = metal::extract_bits(4286578688u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(4278190081u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    if (true) {
        local_25 = as_type<int>(as_type<uint>(metal::extract_bits(naga_neg(3), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(7, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    } else {
        local_25 = as_type<int>(as_type<uint>(metal::extract_bits(0, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(0, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    }
    int _e337 = local_25;
    local_24 = static_cast<uint>(24);
    uint _e342 = local_24;
    out[_e342] = static_cast<uint>(_e337);
    values.inner[0] = as_type<int>(as_type<uint>(metal::extract_bits(2, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    values.inner[1] = as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(4, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    int _e371 = values.inner[0];
    int _e372 = values.inner[1];
    local_26 = static_cast<uint>(25);
    uint _e378 = local_26;
    out[_e378] = static_cast<uint>(as_type<int>(as_type<uint>(_e371) + as_type<uint>(_e372)));
    Count = 2;
    scratch = type_5 {};
    int _e386 = Count;
    int _e387 = scratch.inner[0];
    local_28 = static_cast<uint>(26);
    uint _e393 = local_28;
    out[_e393] = static_cast<uint>(as_type<int>(as_type<uint>(_e386) + as_type<uint>(_e387)));
    counter = 2;
    int _e397 = counter;
    counter = as_type<int>(as_type<uint>(_e397) + as_type<uint>(1));
    int _e400 = counter;
    counter = as_type<int>(as_type<uint>(_e400) + as_type<uint>(1));
    local_29 = static_cast<uint>(27);
    uint _e415 = local_29;
    out[_e415] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(_e397, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(_e400, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e417 = counter;
    local_30 = static_cast<uint>(28);
    uint _e422 = local_30;
    out[_e422] = static_cast<uint>(_e417);
    total = 0;
    {
        index = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e445 = index;
                index = as_type<int>(as_type<uint>(_e445) + as_type<uint>(1));
            }
            loop_init = false;
            int _e428 = index;
            if (_e428 < 3) {
            } else {
                break;
            }
            int _e431 = index;
            int _e443 = total;
            total = as_type<int>(as_type<uint>(_e443) + as_type<uint>(as_type<int>(as_type<uint>(metal::extract_bits(as_type<int>(as_type<uint>(_e431) + as_type<uint>(1)), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(2, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))))));
        }
    }
    int _e448 = total;
    local_31 = static_cast<uint>(29);
    uint _e453 = local_31;
    out[_e453] = static_cast<uint>(_e448);
    {
        local_32 = static_cast<uint>(30);
        uint _e461 = local_32;
        local_34 = _e461;
        uint _e463 = local_34;
        out[_e463] = static_cast<uint>(naga_f2i32(9.75));
    }
    local_33 = static_cast<uint>(31);
    uint _e479 = local_33;
    out[_e479] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(16777215, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
}
