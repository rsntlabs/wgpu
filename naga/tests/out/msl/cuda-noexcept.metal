// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_3[1];
constant bool Safe = true;

int choose_noexcept(
    int value_1
) {
    return as_type<int>(as_type<uint>(10) + as_type<uint>(value_1));
}

int choose_noexcept_1(
    uint value_2
) {
    return as_type<int>(as_type<uint>(20) + as_type<uint>(static_cast<int>(value_2)));
}

uint combined_noexcept(
    uint a,
    uint b
) {
    return (((a & 65535u) + (b & 65535u)) & 65535u) | (((((a >> 16u) & 65535u) + ((b >> 16u) & 65535u)) & 65535u) << 16u);
}

int skipped_noexcept(
) {
    bool local_37 = {};
    return 7;
}

int converted_noexcept(
) {
    return 9;
}

int false_noexcept(
) {
    return 13;
}

int reverse_noexcept(
) {
    return 14;
}

int default_noexcept(
    int value_3
) {
    return as_type<int>(as_type<uint>(value_3) + as_type<uint>(4));
}

int float_bool_noexcept(
) {
    return 15;
}

struct noexcept_helpersInput {
};
kernel void noexcept_helpers(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_3& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
) {
    int value = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    bool local_8 = {};
    int local_9 = {};
    bool local_10 = {};
    int local_11 = {};
    int local_12 = {};
    int local_13 = {};
    int local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    int local_18 = {};
    uint local_19 = {};
    int local_20 = {};
    uint local_21 = {};
    int local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    int amount = {};
    int old = {};
    int amount_1 = {};
    int old_1 = {};
    uint scale = {};
    uint scale_1 = {};
    int amount_2 = {};
    int old_2 = {};
    int local_29 = {};
    int local_30 = {};
    int amount_3 = {};
    int old_3 = {};
    int local_31 = {};
    int local_32 = {};
    int amount_4 = {};
    int old_4 = {};
    int local_33 = {};
    int local_34 = {};
    int amount_5 = {};
    int old_5 = {};
    int local_35 = {};
    int local_36 = {};
    int amount_6 = {};
    int old_6 = {};
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 18u);
    value = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    amount = int {};
    old = int {};
    amount = 2;
    int _e16 = value;
    old = _e16;
    int _e18 = amount;
    int _e19 = value;
    value = as_type<int>(as_type<uint>(_e19) + as_type<uint>(_e18));
    int _e21 = old;
    output[base] = static_cast<uint>(_e21);
    amount_1 = int {};
    old_1 = int {};
    amount_1 = 5;
    int _e31 = value;
    old_1 = _e31;
    int _e33 = amount_1;
    int _e34 = value;
    value = as_type<int>(as_type<uint>(_e34) + as_type<uint>(_e33));
    int _e36 = old_1;
    local = static_cast<uint>(base + 1u);
    uint _e42 = local;
    output[_e42] = static_cast<uint>(_e36);
    int _e44 = value;
    local_1 = static_cast<uint>(base + 2u);
    uint _e50 = local_1;
    output[_e50] = static_cast<uint>(_e44);
    int _e53 = choose_noexcept(1);
    local_2 = static_cast<uint>(base + 3u);
    uint _e59 = local_2;
    output[_e59] = static_cast<uint>(_e53);
    int _e62 = choose_noexcept_1(1u);
    local_3 = static_cast<uint>(base + 4u);
    uint _e68 = local_3;
    output[_e68] = static_cast<uint>(_e62);
    scale = uint {};
    scale = 3u;
    int _e74 = value;
    value = as_type<int>(as_type<uint>(_e74) + as_type<uint>(1));
    uint _e78 = scale;
    local_5 = static_cast<uint>(_e74) * _e78;
    uint _e81 = local_5;
    scale_1 = uint {};
    scale_1 = 5u;
    int _e86 = value;
    value = as_type<int>(as_type<uint>(_e86) + as_type<uint>(1));
    uint _e90 = scale_1;
    local_6 = static_cast<uint>(_e86) * _e90;
    uint _e93 = local_6;
    uint _e94 = combined_noexcept(_e81, _e93);
    local_4 = static_cast<uint>(base + 5u);
    uint _e99 = local_4;
    output[_e99] = _e94;
    int _e101 = value;
    local_7 = static_cast<uint>(base + 6u);
    uint _e107 = local_7;
    output[_e107] = static_cast<uint>(_e101);
    local_8 = false;
    if (false) {
        amount_2 = int {};
        old_2 = int {};
        amount_2 = 2;
        int _e117 = value;
        local_29 = _e117;
        int _e119 = local_29;
        old_2 = _e119;
        int _e121 = amount_2;
        int _e122 = value;
        local_30 = _e122;
        int _e124 = local_30;
        value = as_type<int>(as_type<uint>(_e124) + as_type<uint>(_e121));
        int _e126 = old_2;
        local_9 = _e126;
        int _e128 = local_9;
        local_8 = _e128 != 0;
    }
    local_10 = true;
    if (true) {
    } else {
        amount_3 = int {};
        old_3 = int {};
        amount_3 = 2;
        int _e139 = value;
        local_31 = _e139;
        int _e141 = local_31;
        old_3 = _e141;
        int _e143 = amount_3;
        int _e144 = value;
        local_32 = _e144;
        int _e146 = local_32;
        value = as_type<int>(as_type<uint>(_e146) + as_type<uint>(_e143));
        int _e148 = old_3;
        local_11 = _e148;
        int _e150 = local_11;
        local_10 = _e150 != 0;
    }
    if ((lane & 1u) == 0u) {
        amount_4 = int {};
        old_4 = int {};
        amount_4 = 2;
        int _e163 = value;
        local_33 = _e163;
        int _e165 = local_33;
        old_4 = _e165;
        int _e167 = amount_4;
        int _e168 = value;
        local_34 = _e168;
        int _e170 = local_34;
        value = as_type<int>(as_type<uint>(_e170) + as_type<uint>(_e167));
        int _e172 = old_4;
        local_12 = _e172;
        int _e174 = local_12;
        local_14 = _e174;
    } else {
        amount_5 = int {};
        old_5 = int {};
        amount_5 = 3;
        int _e182 = value;
        local_35 = _e182;
        int _e184 = local_35;
        old_5 = _e184;
        int _e186 = amount_5;
        int _e187 = value;
        local_36 = _e187;
        int _e189 = local_36;
        value = as_type<int>(as_type<uint>(_e189) + as_type<uint>(_e186));
        int _e191 = old_5;
        local_13 = _e191;
        int _e193 = local_13;
        local_14 = _e193;
    }
    int _e195 = value;
    local_15 = static_cast<uint>(base + 7u);
    uint _e201 = local_15;
    output[_e201] = static_cast<uint>(_e195);
    amount_6 = int {};
    old_6 = int {};
    amount_6 = 2;
    int _e209 = value;
    old_6 = _e209;
    int _e211 = amount_6;
    int _e212 = value;
    value = as_type<int>(as_type<uint>(_e212) + as_type<uint>(_e211));
    int _e214 = value;
    local_16 = static_cast<uint>(base + 8u);
    uint _e220 = local_16;
    output[_e220] = static_cast<uint>(_e214);
    int _e222 = value;
    local_18 = as_type<int>(as_type<uint>(_e222) + as_type<uint>(1));
    int _e226 = local_18;
    local_17 = static_cast<uint>(base + 9u);
    uint _e232 = local_17;
    output[_e232] = static_cast<uint>(_e226);
    int _e234 = value;
    local_20 = as_type<int>(as_type<uint>(_e234) + as_type<uint>(2));
    int _e238 = local_20;
    local_19 = static_cast<uint>(base + 10u);
    uint _e244 = local_19;
    output[_e244] = static_cast<uint>(_e238);
    int _e246 = value;
    local_22 = as_type<int>(as_type<uint>(_e246) + as_type<uint>(3));
    int _e250 = local_22;
    local_21 = static_cast<uint>(base + 11u);
    uint _e256 = local_21;
    output[_e256] = static_cast<uint>(_e250);
    int _e258 = skipped_noexcept();
    local_23 = static_cast<uint>(base + 12u);
    uint _e264 = local_23;
    output[_e264] = static_cast<uint>(_e258);
    int _e266 = converted_noexcept();
    local_24 = static_cast<uint>(base + 13u);
    uint _e272 = local_24;
    output[_e272] = static_cast<uint>(_e266);
    int _e274 = false_noexcept();
    local_25 = static_cast<uint>(base + 14u);
    uint _e280 = local_25;
    output[_e280] = static_cast<uint>(_e274);
    int _e282 = reverse_noexcept();
    local_26 = static_cast<uint>(base + 15u);
    uint _e288 = local_26;
    output[_e288] = static_cast<uint>(_e282);
    int _e291 = default_noexcept(3);
    local_27 = static_cast<uint>(base + 16u);
    uint _e297 = local_27;
    output[_e297] = static_cast<uint>(_e291);
    int _e299 = float_bool_noexcept();
    local_28 = static_cast<uint>(base + 17u);
    uint _e305 = local_28;
    output[_e305] = static_cast<uint>(_e299);
}
