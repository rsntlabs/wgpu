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
    uint local = {};
    type_1 signed_values = {};
    uint local_1 = {};
    type_5 words = {};
    uint local_2 = {};
    type_7 samples = {};
    uint local_3 = {};
    type_9 flags = {};
    uint local_4 = {};
    type_2 zeros = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    type_10 zero_flags = {};
    uint local_8 = {};
    bool local_9 = {};
    type_5 bank = {};
    type_7 bank_1 = {};
    uint local_10 = {};
    uint local_11 = {};
    type_2 signed_values_1 = {};
    uint local_12 = {};
    uint local_13 = {};
    type_2 mixed = {};
    uint local_14 = {};
    uint local_15 = {};
    int reset_total = {};
    int i = {};
    type_2 reset = {};
    uint local_16 = {};
    int total = {};
    type_2 scratch = {};
    int j = {};
    uint local_17 = {};
    type_7 zero_samples = {};
    uint local_18 = {};
    type_2 left = {};
    type_2 right = {};
    uint local_19 = {};
    type_2 temporary = {};
    type_2 temporary_1 = {};
    uint local_20 = {};
    uint local_21 = {};
    int index = {};
    int rhs = {};
    uint local_22 = {};
    int local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    int local_27 = {};
    uint local_28 = {};
    int local_29 = {};
    uint local_30 = {};
    int local_31 = {};
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
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_30 = static_cast<uint>(_e3);
    uint _e6 = local_30;
    int _e9 = out[_e6];
    local_31 = _e9;
    int _e11 = local_31;
    local_29 = _e11;
    int _e13 = local_29;
    seed = _e13;
    int _e15 = seed;
    signed_values.inner[0] = _e15;
    signed_values.inner[1] = naga_neg(2);
    signed_values.inner[2] = 4;
    int _e30 = signed_values.inner[0];
    int _e31 = signed_values.inner[1];
    int _e35 = signed_values.inner[2];
    local_1 = static_cast<uint>(0);
    uint _e40 = local_1;
    local_32 = static_cast<uint>(_e40);
    uint _e43 = local_32;
    out[_e43] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e30) + as_type<uint>(_e31))) + as_type<uint>(_e35));
    words = type_5 {};
    words.inner[0] = 4294967295u;
    words.inner[1] = 1u;
    uint _e57 = words.inner[0];
    uint _e58 = words.inner[1];
    local_2 = static_cast<uint>(1);
    uint _e66 = local_2;
    local_33 = static_cast<uint>(_e66);
    uint _e69 = local_33;
    out[_e69] = static_cast<int>((_e57 + _e58) == 0u);
    samples = type_7 {};
    samples.inner[0] = 1.5;
    samples.inner[1] = 2.25;
    float _e83 = samples.inner[0];
    float _e84 = samples.inner[1];
    local_3 = static_cast<uint>(2);
    uint _e92 = local_3;
    local_34 = static_cast<uint>(_e92);
    uint _e95 = local_34;
    out[_e95] = naga_f2i32((_e83 + _e84) * 4.0);
    flags = type_9 {};
    int _e99 = seed;
    flags.inner[0] = _e99 != 0;
    flags.inner[2] = true;
    bool _e109 = flags.inner[0];
    bool _e115 = flags.inner[1];
    bool _e122 = flags.inner[2];
    local_4 = static_cast<uint>(3);
    uint _e128 = local_4;
    local_35 = static_cast<uint>(_e128);
    uint _e131 = local_35;
    out[_e131] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e109)) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e115)) * as_type<uint>(10))))) + as_type<uint>(static_cast<int>(_e122)));
    zeros = type_2 {};
    int _e139 = zeros.inner[0];
    int _e140 = zeros.inner[1];
    local_5 = static_cast<uint>(4);
    uint _e145 = local_5;
    local_36 = static_cast<uint>(_e145);
    uint _e148 = local_36;
    out[_e148] = as_type<int>(as_type<uint>(_e139) + as_type<uint>(_e140));
    int _e150 = seed;
    int _e151 = local_sum(_e150);
    local_6 = static_cast<uint>(5);
    uint _e155 = local_6;
    local_37 = static_cast<uint>(_e155);
    uint _e158 = local_37;
    out[_e158] = _e151;
    int _e161 = reset_sum(3);
    local_7 = static_cast<uint>(6);
    uint _e165 = local_7;
    local_38 = static_cast<uint>(_e165);
    uint _e168 = local_38;
    out[_e168] = _e161;
    zero_flags = type_10 {};
    bool _e174 = zero_flags.inner[0];
    local_9 = _e174;
    if (_e174) {
    } else {
        bool _e178 = zero_flags.inner[1];
        local_9 = _e178;
    }
    bool _e179 = local_9;
    local_8 = static_cast<uint>(7);
    uint _e184 = local_8;
    local_39 = static_cast<uint>(_e184);
    uint _e187 = local_39;
    out[_e187] = static_cast<int>(_e179);
    bank = type_5 {};
    bank.inner[0] = 3u;
    bank.inner[1] = 4u;
    {
        bank_1 = type_7 {};
        bank_1.inner[1] = 6.5;
        float _e206 = bank_1.inner[0];
        float _e207 = bank_1.inner[1];
        local_10 = static_cast<uint>(8);
        uint _e213 = local_10;
        local_40 = static_cast<uint>(_e213);
        uint _e216 = local_40;
        out[_e216] = naga_f2i32(_e206 + _e207);
    }
    uint _e222 = bank.inner[0];
    uint _e223 = bank.inner[1];
    local_11 = static_cast<uint>(9);
    uint _e229 = local_11;
    local_41 = static_cast<uint>(_e229);
    uint _e232 = local_41;
    out[_e232] = static_cast<int>(_e222 + _e223);
    {
        int _e234 = seed;
        signed_values_1.inner[0] = _e234;
        int _e238 = seed;
        signed_values_1.inner[1] = _e238;
        int _e245 = signed_values_1.inner[0];
        int _e246 = signed_values_1.inner[1];
        local_12 = static_cast<uint>(10);
        uint _e251 = local_12;
        local_42 = static_cast<uint>(_e251);
        uint _e254 = local_42;
        out[_e254] = as_type<int>(as_type<uint>(_e245) + as_type<uint>(_e246));
    }
    int _e258 = signed_values.inner[0];
    local_13 = static_cast<uint>(11);
    uint _e262 = local_13;
    local_43 = static_cast<uint>(_e262);
    uint _e265 = local_43;
    out[_e265] = _e258;
    mixed = type_2 {};
    int _e269 = seed;
    seed = as_type<int>(as_type<uint>(_e269) + as_type<uint>(1));
    int next = seed;
    mixed.inner[0] = next;
    int _e275 = seed;
    seed = as_type<int>(as_type<uint>(_e275) + as_type<uint>(1));
    mixed.inner[1] = _e275;
    int _e282 = mixed.inner[0];
    int _e287 = mixed.inner[1];
    local_14 = static_cast<uint>(12);
    uint _e292 = local_14;
    local_44 = static_cast<uint>(_e292);
    uint _e295 = local_44;
    out[_e295] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e282) * as_type<uint>(10))) + as_type<uint>(_e287));
    int _e297 = seed;
    local_15 = static_cast<uint>(13);
    uint _e301 = local_15;
    local_45 = static_cast<uint>(_e301);
    uint _e304 = local_45;
    out[_e304] = _e297;
    reset_total = 0;
    {
        i = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e331 = i;
                i = as_type<int>(as_type<uint>(_e331) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e310 = i;
            if (_e310 < 3) {
            } else {
                break;
            }
            reset = type_2 {};
            int _e315 = i;
            if (_e315 == 1) {
                reset.inner[0] = 90;
                continue;
            }
            int _e323 = reset.inner[0];
            int _e324 = i;
            int _e326 = reset_total;
            reset_total = as_type<int>(as_type<uint>(_e326) + as_type<uint>(as_type<int>(as_type<uint>(_e323) + as_type<uint>(_e324))));
            reset.inner[0] = 99;
        }
    }
    int _e334 = reset_total;
    local_16 = static_cast<uint>(14);
    uint _e338 = local_16;
    local_46 = static_cast<uint>(_e338);
    uint _e341 = local_46;
    out[_e341] = _e334;
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
                int _e373 = j;
                j = as_type<int>(as_type<uint>(_e373) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e349 = j;
            if (_e349 < 3) {
            } else {
                break;
            }
            int _e352 = j;
            int _e356 = scratch.inner[naga_mod(_e352, 2)];
            scratch.inner[naga_mod(_e352, 2)] = as_type<int>(as_type<uint>(_e356) + as_type<uint>(1));
            int _e359 = j;
            if (_e359 == 1) {
                continue;
            }
            int _e364 = scratch.inner[0];
            int _e369 = scratch.inner[1];
            int _e371 = total;
            total = as_type<int>(as_type<uint>(_e371) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e364) * as_type<uint>(10))) + as_type<uint>(_e369))));
        }
    }
    int _e376 = total;
    local_17 = static_cast<uint>(15);
    uint _e380 = local_17;
    local_47 = static_cast<uint>(_e380);
    uint _e383 = local_47;
    out[_e383] = _e376;
    zero_samples = type_7 {};
    float _e391 = zero_samples.inner[0];
    float _e392 = zero_samples.inner[1];
    local_18 = static_cast<uint>(16);
    uint _e398 = local_18;
    local_48 = static_cast<uint>(_e398);
    uint _e401 = local_48;
    out[_e401] = naga_f2i32(_e391 + _e392);
    left = type_2 {};
    right = type_2 {};
    left.inner[0] = 5;
    left.inner[1] = 7;
    right.inner[0] = 11;
    right.inner[1] = 13;
    int _e423 = left.inner[0];
    int _e424 = right.inner[0];
    local_19 = static_cast<uint>(17);
    uint _e429 = local_19;
    local_49 = static_cast<uint>(_e429);
    uint _e432 = local_49;
    out[_e432] = as_type<int>(as_type<uint>(_e423) + as_type<uint>(_e424));
    {
        temporary = type_2 {};
        int _e436 = seed;
        temporary.inner[0] = _e436;
        {
            temporary_1 = type_2 {};
            temporary_1.inner[1] = 3;
            int _e448 = temporary_1.inner[0];
            int _e449 = temporary_1.inner[1];
            local_20 = static_cast<uint>(18);
            uint _e454 = local_20;
            local_50 = static_cast<uint>(_e454);
            uint _e457 = local_50;
            out[_e457] = as_type<int>(as_type<uint>(_e448) + as_type<uint>(_e449));
        }
        int _e461 = temporary.inner[0];
        local_21 = static_cast<uint>(19);
        uint _e465 = local_21;
        local_51 = static_cast<uint>(_e465);
        uint _e468 = local_51;
        out[_e468] = _e461;
    }
    int _e470 = seed;
    bool choose = (_e470 & 1) == 0;
    index = 0;
    rhs = 20;
    int _e479 = rhs;
    rhs = as_type<int>(as_type<uint>(_e479) + as_type<uint>(1));
    int _e482 = rhs;
    if (choose) {
        int _e483 = index;
        index = as_type<int>(as_type<uint>(_e483) + as_type<uint>(1));
        int _e487 = left.inner[_e483];
        left.inner[_e483] = as_type<int>(as_type<uint>(_e487) + as_type<uint>(_e482));
        int _e489 = left.inner[_e483];
        local_23 = _e489;
    } else {
        int _e491 = index;
        index = as_type<int>(as_type<uint>(_e491) + as_type<uint>(1));
        int _e495 = right.inner[_e491];
        right.inner[_e491] = as_type<int>(as_type<uint>(_e495) + as_type<uint>(_e482));
        int _e497 = right.inner[_e491];
        local_23 = _e497;
    }
    int _e500 = local_23;
    local_22 = static_cast<uint>(20);
    uint _e504 = local_22;
    local_52 = static_cast<uint>(_e504);
    uint _e507 = local_52;
    out[_e507] = _e500;
    int _e509 = index;
    local_24 = static_cast<uint>(21);
    uint _e513 = local_24;
    local_53 = static_cast<uint>(_e513);
    uint _e516 = local_53;
    out[_e516] = _e509;
    int _e520 = left.inner[0];
    int _e525 = right.inner[0];
    local_25 = static_cast<uint>(22);
    uint _e530 = local_25;
    local_54 = static_cast<uint>(_e530);
    uint _e533 = local_54;
    out[_e533] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e520) * as_type<uint>(100))) + as_type<uint>(_e525));
    if (choose) {
        right.inner[1] = 9;
        int _e538 = right.inner[1];
        right.inner[1] = as_type<int>(as_type<uint>(_e538) + as_type<uint>(1));
        local_27 = _e538;
    } else {
        left.inner[1] = 9;
        int _e545 = left.inner[1];
        left.inner[1] = as_type<int>(as_type<uint>(_e545) + as_type<uint>(1));
        local_27 = _e545;
    }
    int _e550 = local_27;
    local_26 = static_cast<uint>(23);
    uint _e554 = local_26;
    local_55 = static_cast<uint>(_e554);
    uint _e557 = local_55;
    out[_e557] = _e550;
    int _e561 = left.inner[1];
    int _e566 = right.inner[1];
    local_28 = static_cast<uint>(24);
    uint _e571 = local_28;
    local_56 = static_cast<uint>(_e571);
    uint _e574 = local_56;
    out[_e574] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e561) * as_type<uint>(100))) + as_type<uint>(_e566));
}
