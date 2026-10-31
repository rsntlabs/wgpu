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
    local = static_cast<uint>(0);
    uint _e3 = local;
    int _e6 = out[_e3];
    seed = _e6;
    int _e8 = seed;
    signed_values.inner[0] = _e8;
    signed_values.inner[1] = naga_neg(2);
    signed_values.inner[2] = 4;
    int _e23 = signed_values.inner[0];
    int _e24 = signed_values.inner[1];
    int _e28 = signed_values.inner[2];
    local_1 = static_cast<uint>(0);
    uint _e33 = local_1;
    out[_e33] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e23) + as_type<uint>(_e24))) + as_type<uint>(_e28));
    words = type_5 {};
    words.inner[0] = 4294967295u;
    words.inner[1] = 1u;
    uint _e47 = words.inner[0];
    uint _e48 = words.inner[1];
    local_2 = static_cast<uint>(1);
    uint _e56 = local_2;
    out[_e56] = static_cast<int>((_e47 + _e48) == 0u);
    samples = type_7 {};
    samples.inner[0] = 1.5;
    samples.inner[1] = 2.25;
    float _e70 = samples.inner[0];
    float _e71 = samples.inner[1];
    local_3 = static_cast<uint>(2);
    uint _e79 = local_3;
    out[_e79] = naga_f2i32((_e70 + _e71) * 4.0);
    flags = type_9 {};
    int _e83 = seed;
    flags.inner[0] = _e83 != 0;
    flags.inner[2] = true;
    bool _e93 = flags.inner[0];
    bool _e99 = flags.inner[1];
    bool _e106 = flags.inner[2];
    local_4 = static_cast<uint>(3);
    uint _e112 = local_4;
    out[_e112] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e93)) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(_e99)) * as_type<uint>(10))))) + as_type<uint>(static_cast<int>(_e106)));
    zeros = type_2 {};
    int _e120 = zeros.inner[0];
    int _e121 = zeros.inner[1];
    local_5 = static_cast<uint>(4);
    uint _e126 = local_5;
    out[_e126] = as_type<int>(as_type<uint>(_e120) + as_type<uint>(_e121));
    int _e128 = seed;
    int _e129 = local_sum(_e128);
    local_6 = static_cast<uint>(5);
    uint _e133 = local_6;
    out[_e133] = _e129;
    int _e136 = reset_sum(3);
    local_7 = static_cast<uint>(6);
    uint _e140 = local_7;
    out[_e140] = _e136;
    zero_flags = type_10 {};
    bool _e146 = zero_flags.inner[0];
    local_9 = _e146;
    if (_e146) {
    } else {
        bool _e150 = zero_flags.inner[1];
        local_9 = _e150;
    }
    bool _e151 = local_9;
    local_8 = static_cast<uint>(7);
    uint _e156 = local_8;
    out[_e156] = static_cast<int>(_e151);
    bank = type_5 {};
    bank.inner[0] = 3u;
    bank.inner[1] = 4u;
    {
        bank_1 = type_7 {};
        bank_1.inner[1] = 6.5;
        float _e175 = bank_1.inner[0];
        float _e176 = bank_1.inner[1];
        local_10 = static_cast<uint>(8);
        uint _e182 = local_10;
        local_29 = _e182;
        uint _e184 = local_29;
        out[_e184] = naga_f2i32(_e175 + _e176);
    }
    uint _e190 = bank.inner[0];
    uint _e191 = bank.inner[1];
    local_11 = static_cast<uint>(9);
    uint _e197 = local_11;
    out[_e197] = static_cast<int>(_e190 + _e191);
    {
        int _e199 = seed;
        signed_values_1.inner[0] = _e199;
        int _e203 = seed;
        signed_values_1.inner[1] = _e203;
        int _e210 = signed_values_1.inner[0];
        int _e211 = signed_values_1.inner[1];
        local_12 = static_cast<uint>(10);
        uint _e216 = local_12;
        local_30 = _e216;
        uint _e218 = local_30;
        out[_e218] = as_type<int>(as_type<uint>(_e210) + as_type<uint>(_e211));
    }
    int _e222 = signed_values.inner[0];
    local_13 = static_cast<uint>(11);
    uint _e226 = local_13;
    out[_e226] = _e222;
    mixed = type_2 {};
    int _e230 = seed;
    seed = as_type<int>(as_type<uint>(_e230) + as_type<uint>(1));
    int next = seed;
    mixed.inner[0] = next;
    int _e236 = seed;
    seed = as_type<int>(as_type<uint>(_e236) + as_type<uint>(1));
    mixed.inner[1] = _e236;
    int _e243 = mixed.inner[0];
    int _e248 = mixed.inner[1];
    local_14 = static_cast<uint>(12);
    uint _e253 = local_14;
    out[_e253] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e243) * as_type<uint>(10))) + as_type<uint>(_e248));
    int _e255 = seed;
    local_15 = static_cast<uint>(13);
    uint _e259 = local_15;
    out[_e259] = _e255;
    reset_total = 0;
    {
        i = 0;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e286 = i;
                i = as_type<int>(as_type<uint>(_e286) + as_type<uint>(1));
            }
            loop_init_1 = false;
            int _e265 = i;
            if (_e265 < 3) {
            } else {
                break;
            }
            reset = type_2 {};
            int _e270 = i;
            if (_e270 == 1) {
                reset.inner[0] = 90;
                continue;
            }
            int _e278 = reset.inner[0];
            int _e279 = i;
            int _e281 = reset_total;
            reset_total = as_type<int>(as_type<uint>(_e281) + as_type<uint>(as_type<int>(as_type<uint>(_e278) + as_type<uint>(_e279))));
            reset.inner[0] = 99;
        }
    }
    int _e289 = reset_total;
    local_16 = static_cast<uint>(14);
    uint _e293 = local_16;
    out[_e293] = _e289;
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
                int _e325 = j;
                j = as_type<int>(as_type<uint>(_e325) + as_type<uint>(1));
            }
            loop_init_2 = false;
            int _e301 = j;
            if (_e301 < 3) {
            } else {
                break;
            }
            int _e304 = j;
            int _e308 = scratch.inner[naga_mod(_e304, 2)];
            scratch.inner[naga_mod(_e304, 2)] = as_type<int>(as_type<uint>(_e308) + as_type<uint>(1));
            int _e311 = j;
            if (_e311 == 1) {
                continue;
            }
            int _e316 = scratch.inner[0];
            int _e321 = scratch.inner[1];
            int _e323 = total;
            total = as_type<int>(as_type<uint>(_e323) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e316) * as_type<uint>(10))) + as_type<uint>(_e321))));
        }
    }
    int _e328 = total;
    local_17 = static_cast<uint>(15);
    uint _e332 = local_17;
    out[_e332] = _e328;
    zero_samples = type_7 {};
    float _e340 = zero_samples.inner[0];
    float _e341 = zero_samples.inner[1];
    local_18 = static_cast<uint>(16);
    uint _e347 = local_18;
    out[_e347] = naga_f2i32(_e340 + _e341);
    left = type_2 {};
    right = type_2 {};
    left.inner[0] = 5;
    left.inner[1] = 7;
    right.inner[0] = 11;
    right.inner[1] = 13;
    int _e369 = left.inner[0];
    int _e370 = right.inner[0];
    local_19 = static_cast<uint>(17);
    uint _e375 = local_19;
    out[_e375] = as_type<int>(as_type<uint>(_e369) + as_type<uint>(_e370));
    {
        temporary = type_2 {};
        int _e379 = seed;
        temporary.inner[0] = _e379;
        {
            temporary_1 = type_2 {};
            temporary_1.inner[1] = 3;
            int _e391 = temporary_1.inner[0];
            int _e392 = temporary_1.inner[1];
            local_20 = static_cast<uint>(18);
            uint _e397 = local_20;
            local_31 = _e397;
            uint _e399 = local_31;
            out[_e399] = as_type<int>(as_type<uint>(_e391) + as_type<uint>(_e392));
        }
        int _e403 = temporary.inner[0];
        local_21 = static_cast<uint>(19);
        uint _e407 = local_21;
        local_32 = _e407;
        uint _e409 = local_32;
        out[_e409] = _e403;
    }
    int _e411 = seed;
    bool choose = (_e411 & 1) == 0;
    index = 0;
    rhs = 20;
    int _e420 = rhs;
    rhs = as_type<int>(as_type<uint>(_e420) + as_type<uint>(1));
    int _e423 = rhs;
    if (choose) {
        int _e424 = index;
        index = as_type<int>(as_type<uint>(_e424) + as_type<uint>(1));
        int _e428 = left.inner[_e424];
        left.inner[_e424] = as_type<int>(as_type<uint>(_e428) + as_type<uint>(_e423));
        int _e430 = left.inner[_e424];
        local_23 = _e430;
    } else {
        int _e432 = index;
        index = as_type<int>(as_type<uint>(_e432) + as_type<uint>(1));
        int _e436 = right.inner[_e432];
        right.inner[_e432] = as_type<int>(as_type<uint>(_e436) + as_type<uint>(_e423));
        int _e438 = right.inner[_e432];
        local_23 = _e438;
    }
    int _e441 = local_23;
    local_22 = static_cast<uint>(20);
    uint _e445 = local_22;
    out[_e445] = _e441;
    int _e447 = index;
    local_24 = static_cast<uint>(21);
    uint _e451 = local_24;
    out[_e451] = _e447;
    int _e455 = left.inner[0];
    int _e460 = right.inner[0];
    local_25 = static_cast<uint>(22);
    uint _e465 = local_25;
    out[_e465] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e455) * as_type<uint>(100))) + as_type<uint>(_e460));
    if (choose) {
        right.inner[1] = 9;
        int _e470 = right.inner[1];
        right.inner[1] = as_type<int>(as_type<uint>(_e470) + as_type<uint>(1));
        local_27 = _e470;
    } else {
        left.inner[1] = 9;
        int _e477 = left.inner[1];
        left.inner[1] = as_type<int>(as_type<uint>(_e477) + as_type<uint>(1));
        local_27 = _e477;
    }
    int _e482 = local_27;
    local_26 = static_cast<uint>(23);
    uint _e486 = local_26;
    out[_e486] = _e482;
    int _e490 = left.inner[1];
    int _e495 = right.inner[1];
    local_28 = static_cast<uint>(24);
    uint _e500 = local_28;
    out[_e500] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e490) * as_type<uint>(100))) + as_type<uint>(_e495));
}
