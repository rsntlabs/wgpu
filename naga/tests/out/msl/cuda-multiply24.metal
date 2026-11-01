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
    int local_4 = {};
    int local_5 = {};
    if (first_3) {
        if (second_3) {
            local_4 = 71;
        } else {
            local_4 = 73;
        }
        int _e7 = local_4;
        local_5 = _e7;
    } else {
        local_5 = 79;
    }
    int _e12 = local_5;
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
    int first = {};
    uint second = {};
    int local = {};
    type_5 values = {};
    int Count = {};
    int local_1 = {};
    type_5 scratch = {};
    int counter = {};
    int total = {};
    int index = {};
    uint local_2 = {};
    uint local_3 = {};
    out[static_cast<uint>(0)] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(8388608, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(1, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    out[static_cast<uint>(1)] = metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    out[static_cast<uint>(2)] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(8388607, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(8388607, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    out[static_cast<uint>(3)] = metal::extract_bits(16777216u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(13u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    int _e52 = signed_conversion(3.75, -(2.75));
    out[static_cast<uint>(4)] = static_cast<uint>(_e52);
    int _e60 = signed_conversion(-(3.75), 2.75);
    out[static_cast<uint>(5)] = static_cast<uint>(_e60);
    uint _e67 = unsigned_conversion(3.75, 2.75);
    out[static_cast<uint>(6)] = _e67;
    uint _e73 = unsigned_conversion(16777215.0, 1.0);
    out[static_cast<uint>(7)] = _e73;
    int _e79 = _mul24_(true, true);
    out[static_cast<uint>(8)] = static_cast<uint>(_e79);
    int _e86 = _mul24_(false, true);
    out[static_cast<uint>(9)] = static_cast<uint>(_e86);
    out[static_cast<uint>(10)] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(static_cast<int>(true), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    out[static_cast<uint>(11)] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(static_cast<int>(true), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e123 = _mul24_1(3.75, 2.0);
    out[static_cast<uint>(12)] = static_cast<uint>(_e123);
    uint _e130 = _umul24_(3, 4);
    out[static_cast<uint>(13)] = _e130;
    out[static_cast<uint>(14)] = metal::extract_bits(3u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(4u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    uint _e148 = _umul24_(static_cast<int>(true), static_cast<int>(true));
    out[static_cast<uint>(15)] = _e148;
    out[static_cast<uint>(16)] = metal::extract_bits(3u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(static_cast<uint>(4), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    int _e166 = signed_pair(naga_neg(7), 3);
    out[static_cast<uint>(17)] = static_cast<uint>(_e166);
    out[static_cast<uint>(18)] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(4, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(5, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    out[static_cast<uint>(19)] = metal::extract_bits(metal::extract_bits(16777215u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(2u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(2u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    first = -3;
    second = 5u;
    int _e214 = first;
    uint _e215 = second;
    out[static_cast<uint>(20)] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(_e214, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(static_cast<int>(_e215), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e229 = first;
    uint _e231 = second;
    out[static_cast<uint>(21)] = metal::extract_bits(static_cast<uint>(_e229), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(_e231, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    out[static_cast<uint>(22)] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(25165824, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(16777217, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    out[static_cast<uint>(23)] = metal::extract_bits(4286578688u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))) * metal::extract_bits(4278190081u, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)));
    if (true) {
        local = as_type<int>(as_type<uint>(metal::extract_bits(naga_neg(3), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(7, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    } else {
        local = as_type<int>(as_type<uint>(metal::extract_bits(0, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(0, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    }
    int _e289 = local;
    out[static_cast<uint>(24)] = static_cast<uint>(_e289);
    values.inner[0] = as_type<int>(as_type<uint>(metal::extract_bits(2, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    values.inner[1] = as_type<int>(as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(4, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))));
    int _e321 = values.inner[0];
    int _e322 = values.inner[1];
    out[static_cast<uint>(25)] = static_cast<uint>(as_type<int>(as_type<uint>(_e321) + as_type<uint>(_e322)));
    Count = 2;
    scratch = type_5 {};
    int _e334 = Count;
    int _e335 = scratch.inner[0];
    out[static_cast<uint>(26)] = static_cast<uint>(as_type<int>(as_type<uint>(_e334) + as_type<uint>(_e335)));
    counter = 2;
    int _e343 = counter;
    counter = as_type<int>(as_type<uint>(_e343) + as_type<uint>(1));
    int _e346 = counter;
    counter = as_type<int>(as_type<uint>(_e346) + as_type<uint>(1));
    out[static_cast<uint>(27)] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(_e343, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(_e346, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
    int _e361 = counter;
    out[static_cast<uint>(28)] = static_cast<uint>(_e361);
    total = 0;
    {
        index = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e387 = index;
                index = as_type<int>(as_type<uint>(_e387) + as_type<uint>(1));
            }
            loop_init = false;
            int _e370 = index;
            if (_e370 < 3) {
            } else {
                break;
            }
            int _e373 = index;
            int _e385 = total;
            total = as_type<int>(as_type<uint>(_e385) + as_type<uint>(as_type<int>(as_type<uint>(metal::extract_bits(as_type<int>(as_type<uint>(_e373) + as_type<uint>(1)), metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(2, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))))));
        }
    }
    int _e390 = total;
    out[static_cast<uint>(29)] = static_cast<uint>(_e390);
    {
        local_2 = static_cast<uint>(30);
        uint _e401 = local_2;
        local_3 = _e401;
        uint _e403 = local_3;
        out[_e403] = static_cast<uint>(naga_f2i32(9.75));
    }
    out[static_cast<uint>(31)] = static_cast<uint>(as_type<int>(as_type<uint>(metal::extract_bits(16777215, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u)))) * as_type<uint>(metal::extract_bits(3, metal::min(0u, 32u), metal::min(24u, 32u - metal::min(0u, 32u))))));
}
