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
    uint local_29 = {};
    uint local_30 = {};
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
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_29 = static_cast<uint>(_e3);
    uint _e6 = local_29;
    int _e9 = out[_e6];
    seed = _e9;
    int _e11 = seed;
    signed_values.inner[0] = _e11;
    signed_values.inner[1] = naga_neg(2);
    signed_values.inner[2] = 4;
    int _e26 = signed_values.inner[0];
    int _e27 = signed_values.inner[1];
    int _e31 = signed_values.inner[2];
    local_1 = static_cast<uint>(0);
    uint _e36 = local_1;
    local_30 = static_cast<uint>(_e36);
    uint _e39 = local_30;
    out[_e39] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e26) + as_type<uint>(_e27))) + as_type<uint>(_e31));
    words = type_5 {};
    words.inner[0] = 4294967295u;
    words.inner[1] = 1u;
    uint _e53 = words.inner[0];
    uint _e54 = words.inner[1];
    local_2 = static_cast<uint>(1);
    uint _e62 = local_2;
    local_31 = static_cast<uint>(_e62);
    uint _e65 = local_31;
    out[_e65] = static_cast<int>((_e53 + _e54) == 0u);
    samples = type_7 {};
    samples.inner[0] = 1.5;
    samples.inner[1] = 2.25;
    float _e79 = samples.inner[0];
    float _e80 = samples.inner[1];
    local_3 = static_cast<uint>(2);
    uint _e88 = local_3;
    local_32 = static_cast<uint>(_e88);
    uint _e91 = local_32;
    out[_e91] = naga_f2i32((_e79 + _e80) * 4.0);
    flags = type_9 {};
    int _e95 = seed;
    flags.inner[0] = _e95 != 0;
    flags.inner[2] = true;
    bool _e105 = flags.inner[0];
    bool _e111 = flags.inner[1];
    bool _e118 = flags.inner[2];
    local_4 = static_cast<uint>(3);
    uint _e124 = local_4;
    local_33 = static_cast<uint>(_e124);
    uint _e127 = local_33;
    out[_e127] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e105)) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e111)) * as_type<uint>(10))))) + as_type<uint>(static_cast<int>(_e118)));
    zeros = type_2 {};
    int _e135 = zeros.inner[0];
    int _e136 = zeros.inner[1];
    local_5 = static_cast<uint>(4);
    uint _e141 = local_5;
    local_34 = static_cast<uint>(_e141);
    uint _e144 = local_34;
    out[_e144] = as_type<int>(as_type<uint>(_e135) + as_type<uint>(_e136));
    int _e146 = seed;
    int _e147 = local_sum(_e146);
    local_6 = static_cast<uint>(5);
    uint _e151 = local_6;
    local_35 = static_cast<uint>(_e151);
    uint _e154 = local_35;
    out[_e154] = _e147;
    int _e157 = reset_sum(3);
    local_7 = static_cast<uint>(6);
    uint _e161 = local_7;
    local_36 = static_cast<uint>(_e161);
    uint _e164 = local_36;
    out[_e164] = _e157;
    zero_flags = type_10 {};
    bool _e170 = zero_flags.inner[0];
    local_9 = _e170;
    if (_e170) {
    } else {
        bool _e174 = zero_flags.inner[1];
        local_9 = _e174;
    }
    bool _e175 = local_9;
    local_8 = static_cast<uint>(7);
    uint _e180 = local_8;
    local_37 = static_cast<uint>(_e180);
    uint _e183 = local_37;
    out[_e183] = static_cast<int>(_e175);
    bank = type_5 {};
    bank.inner[0] = 3u;
    bank.inner[1] = 4u;
    {
        bank_1 = type_7 {};
        bank_1.inner[1] = 6.5;
        float _e202 = bank_1.inner[0];
        float _e203 = bank_1.inner[1];
        local_10 = static_cast<uint>(8);
        uint _e209 = local_10;
        local_38 = static_cast<uint>(_e209);
        uint _e212 = local_38;
        out[_e212] = naga_f2i32(_e202 + _e203);
    }
    uint _e218 = bank.inner[0];
    uint _e219 = bank.inner[1];
    local_11 = static_cast<uint>(9);
    uint _e225 = local_11;
    local_39 = static_cast<uint>(_e225);
    uint _e228 = local_39;
    out[_e228] = static_cast<int>(_e218 + _e219);
    {
        int _e230 = seed;
        signed_values_1.inner[0] = _e230;
        int _e234 = seed;
        signed_values_1.inner[1] = _e234;
        int _e241 = signed_values_1.inner[0];
        int _e242 = signed_values_1.inner[1];
        local_12 = static_cast<uint>(10);
        uint _e247 = local_12;
        local_40 = static_cast<uint>(_e247);
        uint _e250 = local_40;
        out[_e250] = as_type<int>(as_type<uint>(_e241) + as_type<uint>(_e242));
    }
    int _e254 = signed_values.inner[0];
    local_13 = static_cast<uint>(11);
    uint _e258 = local_13;
    local_41 = static_cast<uint>(_e258);
    uint _e261 = local_41;
    out[_e261] = _e254;
    mixed = type_2 {};
    int _e265 = seed;
    seed = as_type<int>(as_type<uint>(_e265) + as_type<uint>(1));
    int next = seed;
    mixed.inner[0] = next;
    int _e271 = seed;
    seed = as_type<int>(as_type<uint>(_e271) + as_type<uint>(1));
    mixed.inner[1] = _e271;
    int _e278 = mixed.inner[0];
    int _e283 = mixed.inner[1];
    local_14 = static_cast<uint>(12);
    uint _e288 = local_14;
    local_42 = static_cast<uint>(_e288);
    uint _e291 = local_42;
    out[_e291] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e278) * as_type<uint>(10))) + as_type<uint>(_e283));
    int _e293 = seed;
    local_15 = static_cast<uint>(13);
    uint _e297 = local_15;
    local_43 = static_cast<uint>(_e297);
    uint _e300 = local_43;
    out[_e300] = _e293;
    reset_total = 0;
    {
        i = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e327 = i;
                i = as_type<int>(as_type<uint>(_e327) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e306 = i;
            if (_e306 < 3) {
            } else {
                break;
            }
            reset = type_2 {};
            int _e311 = i;
            if (_e311 == 1) {
                reset.inner[0] = 90;
                continue;
            }
            int _e319 = reset.inner[0];
            int _e320 = i;
            int _e322 = reset_total;
            reset_total = as_type<int>(as_type<uint>(_e322) + as_type<uint>(as_type<int>(as_type<uint>(_e319) + as_type<uint>(_e320))));
            reset.inner[0] = 99;
        }
    }
    int _e330 = reset_total;
    local_16 = static_cast<uint>(14);
    uint _e334 = local_16;
    local_44 = static_cast<uint>(_e334);
    uint _e337 = local_44;
    out[_e337] = _e330;
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
                int _e369 = j;
                j = as_type<int>(as_type<uint>(_e369) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e345 = j;
            if (_e345 < 3) {
            } else {
                break;
            }
            int _e348 = j;
            int _e352 = scratch.inner[naga_mod(_e348, 2)];
            scratch.inner[naga_mod(_e348, 2)] = as_type<int>(as_type<uint>(_e352) + as_type<uint>(1));
            int _e355 = j;
            if (_e355 == 1) {
                continue;
            }
            int _e360 = scratch.inner[0];
            int _e365 = scratch.inner[1];
            int _e367 = total;
            total = as_type<int>(as_type<uint>(_e367) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e360) * as_type<uint>(10))) + as_type<uint>(_e365))));
        }
    }
    int _e372 = total;
    local_17 = static_cast<uint>(15);
    uint _e376 = local_17;
    local_45 = static_cast<uint>(_e376);
    uint _e379 = local_45;
    out[_e379] = _e372;
    zero_samples = type_7 {};
    float _e387 = zero_samples.inner[0];
    float _e388 = zero_samples.inner[1];
    local_18 = static_cast<uint>(16);
    uint _e394 = local_18;
    local_46 = static_cast<uint>(_e394);
    uint _e397 = local_46;
    out[_e397] = naga_f2i32(_e387 + _e388);
    left = type_2 {};
    right = type_2 {};
    left.inner[0] = 5;
    left.inner[1] = 7;
    right.inner[0] = 11;
    right.inner[1] = 13;
    int _e419 = left.inner[0];
    int _e420 = right.inner[0];
    local_19 = static_cast<uint>(17);
    uint _e425 = local_19;
    local_47 = static_cast<uint>(_e425);
    uint _e428 = local_47;
    out[_e428] = as_type<int>(as_type<uint>(_e419) + as_type<uint>(_e420));
    {
        temporary = type_2 {};
        int _e432 = seed;
        temporary.inner[0] = _e432;
        {
            temporary_1 = type_2 {};
            temporary_1.inner[1] = 3;
            int _e444 = temporary_1.inner[0];
            int _e445 = temporary_1.inner[1];
            local_20 = static_cast<uint>(18);
            uint _e450 = local_20;
            local_48 = static_cast<uint>(_e450);
            uint _e453 = local_48;
            out[_e453] = as_type<int>(as_type<uint>(_e444) + as_type<uint>(_e445));
        }
        int _e457 = temporary.inner[0];
        local_21 = static_cast<uint>(19);
        uint _e461 = local_21;
        local_49 = static_cast<uint>(_e461);
        uint _e464 = local_49;
        out[_e464] = _e457;
    }
    int _e466 = seed;
    bool choose = (_e466 & 1) == 0;
    index = 0;
    rhs = 20;
    int _e475 = rhs;
    rhs = as_type<int>(as_type<uint>(_e475) + as_type<uint>(1));
    int _e478 = rhs;
    if (choose) {
        int _e479 = index;
        index = as_type<int>(as_type<uint>(_e479) + as_type<uint>(1));
        int _e483 = left.inner[_e479];
        left.inner[_e479] = as_type<int>(as_type<uint>(_e483) + as_type<uint>(_e478));
        int _e485 = left.inner[_e479];
        local_23 = _e485;
    } else {
        int _e487 = index;
        index = as_type<int>(as_type<uint>(_e487) + as_type<uint>(1));
        int _e491 = right.inner[_e487];
        right.inner[_e487] = as_type<int>(as_type<uint>(_e491) + as_type<uint>(_e478));
        int _e493 = right.inner[_e487];
        local_23 = _e493;
    }
    int _e496 = local_23;
    local_22 = static_cast<uint>(20);
    uint _e500 = local_22;
    local_50 = static_cast<uint>(_e500);
    uint _e503 = local_50;
    out[_e503] = _e496;
    int _e505 = index;
    local_24 = static_cast<uint>(21);
    uint _e509 = local_24;
    local_51 = static_cast<uint>(_e509);
    uint _e512 = local_51;
    out[_e512] = _e505;
    int _e516 = left.inner[0];
    int _e521 = right.inner[0];
    local_25 = static_cast<uint>(22);
    uint _e526 = local_25;
    local_52 = static_cast<uint>(_e526);
    uint _e529 = local_52;
    out[_e529] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e516) * as_type<uint>(100))) + as_type<uint>(_e521));
    if (choose) {
        right.inner[1] = 9;
        int _e534 = right.inner[1];
        right.inner[1] = as_type<int>(as_type<uint>(_e534) + as_type<uint>(1));
        local_27 = _e534;
    } else {
        left.inner[1] = 9;
        int _e541 = left.inner[1];
        left.inner[1] = as_type<int>(as_type<uint>(_e541) + as_type<uint>(1));
        local_27 = _e541;
    }
    int _e546 = local_27;
    local_26 = static_cast<uint>(23);
    uint _e550 = local_26;
    local_53 = static_cast<uint>(_e550);
    uint _e553 = local_53;
    out[_e553] = _e546;
    int _e557 = left.inner[1];
    int _e562 = right.inner[1];
    local_28 = static_cast<uint>(24);
    uint _e567 = local_28;
    local_54 = static_cast<uint>(_e567);
    uint _e570 = local_54;
    out[_e570] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e557) * as_type<uint>(100))) + as_type<uint>(_e562));
}
