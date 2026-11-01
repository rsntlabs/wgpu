// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_1 {
    int inner[3];
};
struct type_2 {
    int inner[2];
};
typedef int type_3[1];
struct type_5 {
    uint inner[2];
};
struct type_7 {
    float inner[2];
};
struct type_9 {
    bool inner[3];
};
struct type_10 {
    bool inner[2];
};

int local_sum(
    int value
) {
    type_1 values = {};
    values = type_1 {};
    values.inner[0] = value;
    values.inner[1] = as_type<int>(as_type<uint>(value) + as_type<uint>(1));
    int _e13 = values.inner[0];
    int _e14 = values.inner[1];
    values.inner[2] = as_type<int>(as_type<uint>(_e13) + as_type<uint>(_e14));
    int _e20 = values.inner[2];
    return _e20;
}

int reset_sum(
    int count
) {
    int result = {};
    int i_1 = {};
    type_2 values_1 = {};
    result = 0;
    {
        i_1 = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e24 = i_1;
                i_1 = as_type<int>(as_type<uint>(_e24) + as_type<uint>(1));
            }
            loop_init = false;
            int _e5 = i_1;
            if (_e5 < count) {
            } else {
                break;
            }
            values_1 = type_2 {};
            int _e9 = i_1;
            values_1.inner[1] = _e9;
            int _e16 = values_1.inner[0];
            int _e17 = values_1.inner[1];
            int _e19 = result;
            result = as_type<int>(as_type<uint>(_e19) + as_type<uint>(as_type<int>(as_type<uint>(_e16) + as_type<uint>(_e17))));
            values_1.inner[0] = 99;
        }
    }
    int _e27 = result;
    return _e27;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int naga_mod(int lhs, int rhs) {
    int divisor = metal::select(rhs, 1, (lhs == (-2147483647 - 1) & rhs == -1) | (rhs == 0));
    return lhs - (lhs / divisor) * divisor;
}


kernel void local_arrays(
  device type_3& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    int seed = {};
    type_1 signed_values = {};
    type_5 words = {};
    type_7 samples = {};
    type_9 flags = {};
    type_2 zeros = {};
    type_10 zero_flags = {};
    bool local = {};
    type_5 bank = {};
    type_7 bank_1 = {};
    uint local_1 = {};
    type_2 signed_values_1 = {};
    uint local_2 = {};
    type_2 mixed = {};
    int reset_total = {};
    int i = {};
    type_2 reset = {};
    int total = {};
    type_2 scratch = {};
    int j = {};
    type_7 zero_samples = {};
    type_2 left = {};
    type_2 right = {};
    type_2 temporary = {};
    type_2 temporary_1 = {};
    uint local_3 = {};
    uint local_4 = {};
    int index = {};
    int rhs = {};
    int local_5 = {};
    int local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    int _e4 = out[static_cast<uint>(0)];
    seed = _e4;
    int _e6 = seed;
    signed_values.inner[0] = _e6;
    signed_values.inner[1] = naga_neg(2);
    signed_values.inner[2] = 4;
    int _e21 = signed_values.inner[0];
    int _e22 = signed_values.inner[1];
    int _e26 = signed_values.inner[2];
    out[static_cast<uint>(0)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e21) + as_type<uint>(_e22))) + as_type<uint>(_e26));
    words = type_5 {};
    words.inner[0] = 4294967295u;
    words.inner[1] = 1u;
    uint _e43 = words.inner[0];
    uint _e44 = words.inner[1];
    out[static_cast<uint>(1)] = static_cast<int>((_e43 + _e44) == 0u);
    samples = type_7 {};
    samples.inner[0] = 1.5;
    samples.inner[1] = 2.25;
    float _e64 = samples.inner[0];
    float _e65 = samples.inner[1];
    out[static_cast<uint>(2)] = naga_f2i32((_e64 + _e65) * 4.0);
    flags = type_9 {};
    int _e75 = seed;
    flags.inner[0] = _e75 != 0;
    flags.inner[2] = true;
    bool _e85 = flags.inner[0];
    bool _e91 = flags.inner[1];
    bool _e98 = flags.inner[2];
    out[static_cast<uint>(3)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e85)) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e91)) * as_type<uint>(10))))) + as_type<uint>(static_cast<int>(_e98)));
    zeros = type_2 {};
    int _e110 = zeros.inner[0];
    int _e111 = zeros.inner[1];
    out[static_cast<uint>(4)] = as_type<int>(as_type<uint>(_e110) + as_type<uint>(_e111));
    int _e116 = seed;
    int _e117 = local_sum(_e116);
    out[static_cast<uint>(5)] = _e117;
    int _e122 = reset_sum(3);
    out[static_cast<uint>(6)] = _e122;
    zero_flags = type_10 {};
    bool _e130 = zero_flags.inner[0];
    local = _e130;
    if (_e130) {
    } else {
        bool _e134 = zero_flags.inner[1];
        local = _e134;
    }
    bool _e135 = local;
    out[static_cast<uint>(7)] = static_cast<int>(_e135);
    bank = type_5 {};
    bank.inner[0] = 3u;
    bank.inner[1] = 4u;
    {
        bank_1 = type_7 {};
        bank_1.inner[1] = 6.5;
        float _e157 = bank_1.inner[0];
        float _e158 = bank_1.inner[1];
        local_1 = static_cast<uint>(8);
        uint _e164 = local_1;
        local_7 = _e164;
        uint _e166 = local_7;
        out[_e166] = naga_f2i32(_e157 + _e158);
    }
    uint _e172 = bank.inner[0];
    uint _e173 = bank.inner[1];
    out[static_cast<uint>(9)] = static_cast<int>(_e172 + _e173);
    {
        int _e179 = seed;
        signed_values_1.inner[0] = _e179;
        int _e183 = seed;
        signed_values_1.inner[1] = _e183;
        int _e190 = signed_values_1.inner[0];
        int _e191 = signed_values_1.inner[1];
        local_2 = static_cast<uint>(10);
        uint _e196 = local_2;
        local_8 = _e196;
        uint _e198 = local_8;
        out[_e198] = as_type<int>(as_type<uint>(_e190) + as_type<uint>(_e191));
    }
    int _e202 = signed_values.inner[0];
    out[static_cast<uint>(11)] = _e202;
    mixed = type_2 {};
    int _e208 = seed;
    seed = as_type<int>(as_type<uint>(_e208) + as_type<uint>(1));
    int next = seed;
    mixed.inner[0] = next;
    int _e214 = seed;
    seed = as_type<int>(as_type<uint>(_e214) + as_type<uint>(1));
    mixed.inner[1] = _e214;
    int _e221 = mixed.inner[0];
    int _e226 = mixed.inner[1];
    out[static_cast<uint>(12)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e221) * as_type<uint>(10))) + as_type<uint>(_e226));
    int _e231 = seed;
    out[static_cast<uint>(13)] = _e231;
    reset_total = 0;
    {
        i = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e260 = i;
                i = as_type<int>(as_type<uint>(_e260) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e239 = i;
            if (_e239 < 3) {
            } else {
                break;
            }
            reset = type_2 {};
            int _e244 = i;
            if (_e244 == 1) {
                reset.inner[0] = 90;
                continue;
            }
            int _e252 = reset.inner[0];
            int _e253 = i;
            int _e255 = reset_total;
            reset_total = as_type<int>(as_type<uint>(_e255) + as_type<uint>(as_type<int>(as_type<uint>(_e252) + as_type<uint>(_e253))));
            reset.inner[0] = 99;
        }
    }
    int _e263 = reset_total;
    out[static_cast<uint>(14)] = _e263;
    total = 0;
    {
        scratch = type_2 {};
        j = 0;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e297 = j;
                j = as_type<int>(as_type<uint>(_e297) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e273 = j;
            if (_e273 < 3) {
            } else {
                break;
            }
            int _e276 = j;
            int _e280 = scratch.inner[naga_mod(_e276, 2)];
            scratch.inner[naga_mod(_e276, 2)] = as_type<int>(as_type<uint>(_e280) + as_type<uint>(1));
            int _e283 = j;
            if (_e283 == 1) {
                continue;
            }
            int _e288 = scratch.inner[0];
            int _e293 = scratch.inner[1];
            int _e295 = total;
            total = as_type<int>(as_type<uint>(_e295) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e288) * as_type<uint>(10))) + as_type<uint>(_e293))));
        }
    }
    int _e300 = total;
    out[static_cast<uint>(15)] = _e300;
    zero_samples = type_7 {};
    float _e310 = zero_samples.inner[0];
    float _e311 = zero_samples.inner[1];
    out[static_cast<uint>(16)] = naga_f2i32(_e310 + _e311);
    left = type_2 {};
    right = type_2 {};
    left.inner[0] = 5;
    left.inner[1] = 7;
    right.inner[0] = 11;
    right.inner[1] = 13;
    int _e337 = left.inner[0];
    int _e338 = right.inner[0];
    out[static_cast<uint>(17)] = as_type<int>(as_type<uint>(_e337) + as_type<uint>(_e338));
    {
        temporary = type_2 {};
        int _e345 = seed;
        temporary.inner[0] = _e345;
        {
            temporary_1 = type_2 {};
            temporary_1.inner[1] = 3;
            int _e357 = temporary_1.inner[0];
            int _e358 = temporary_1.inner[1];
            local_3 = static_cast<uint>(18);
            uint _e363 = local_3;
            local_9 = _e363;
            uint _e365 = local_9;
            out[_e365] = as_type<int>(as_type<uint>(_e357) + as_type<uint>(_e358));
        }
        int _e369 = temporary.inner[0];
        local_4 = static_cast<uint>(19);
        uint _e373 = local_4;
        local_10 = _e373;
        uint _e375 = local_10;
        out[_e375] = _e369;
    }
    int _e377 = seed;
    bool choose = (_e377 & 1) == 0;
    index = 0;
    rhs = 20;
    int _e386 = rhs;
    rhs = as_type<int>(as_type<uint>(_e386) + as_type<uint>(1));
    int _e389 = rhs;
    if (choose) {
        int _e390 = index;
        index = as_type<int>(as_type<uint>(_e390) + as_type<uint>(1));
        int _e394 = left.inner[_e390];
        left.inner[_e390] = as_type<int>(as_type<uint>(_e394) + as_type<uint>(_e389));
        int _e396 = left.inner[_e390];
        local_5 = _e396;
    } else {
        int _e398 = index;
        index = as_type<int>(as_type<uint>(_e398) + as_type<uint>(1));
        int _e402 = right.inner[_e398];
        right.inner[_e398] = as_type<int>(as_type<uint>(_e402) + as_type<uint>(_e389));
        int _e404 = right.inner[_e398];
        local_5 = _e404;
    }
    int _e407 = local_5;
    out[static_cast<uint>(20)] = _e407;
    int _e411 = index;
    out[static_cast<uint>(21)] = _e411;
    int _e417 = left.inner[0];
    int _e422 = right.inner[0];
    out[static_cast<uint>(22)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e417) * as_type<uint>(100))) + as_type<uint>(_e422));
    if (choose) {
        right.inner[1] = 9;
        int _e430 = right.inner[1];
        right.inner[1] = as_type<int>(as_type<uint>(_e430) + as_type<uint>(1));
        local_6 = _e430;
    } else {
        left.inner[1] = 9;
        int _e437 = left.inner[1];
        left.inner[1] = as_type<int>(as_type<uint>(_e437) + as_type<uint>(1));
        local_6 = _e437;
    }
    int _e442 = local_6;
    out[static_cast<uint>(23)] = _e442;
    int _e448 = left.inner[1];
    int _e453 = right.inner[1];
    out[static_cast<uint>(24)] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e448) * as_type<uint>(100))) + as_type<uint>(_e453));
}
