#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

const bool Safe = true;

layout(std430) buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };


int choose_noexcept(int value_1) {
    return (10 + value_1);
}

int choose_noexcept_1(uint value_2) {
    return (20 + int(value_2));
}

uint combined_noexcept(uint a, uint b) {
    return ((((a & 65535u) + (b & 65535u)) & 65535u) | (((((a >> 16u) & 65535u) + ((b >> 16u) & 65535u)) & 65535u) << 16u));
}

int skipped_noexcept() {
    bool local_37 = false;
    return 7;
}

int converted_noexcept() {
    return 9;
}

int false_noexcept() {
    return 13;
}

int reverse_noexcept() {
    return 14;
}

int default_noexcept(int value_3) {
    return (value_3 + 4);
}

int float_bool_noexcept() {
    return 15;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int value = 0;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    bool local_8 = false;
    int local_9 = 0;
    bool local_10 = false;
    int local_11 = 0;
    int local_12 = 0;
    int local_13 = 0;
    int local_14 = 0;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    int local_18 = 0;
    uint local_19 = 0u;
    int local_20 = 0;
    uint local_21 = 0u;
    int local_22 = 0;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    int amount = 0;
    int old = 0;
    int amount_1 = 0;
    int old_1 = 0;
    uint scale = 0u;
    uint scale_1 = 0u;
    int amount_2 = 0;
    int old_2 = 0;
    int local_29 = 0;
    int local_30 = 0;
    int amount_3 = 0;
    int old_3 = 0;
    int local_31 = 0;
    int local_32 = 0;
    int amount_4 = 0;
    int old_4 = 0;
    int local_33 = 0;
    int local_34 = 0;
    int amount_5 = 0;
    int old_5 = 0;
    int local_35 = 0;
    int local_36 = 0;
    int amount_6 = 0;
    int old_6 = 0;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 18u));
    value = (int(lane) + 1);
    amount = 0;
    old = 0;
    amount = 2;
    int _e16 = value;
    old = _e16;
    int _e18 = amount;
    int _e19 = value;
    value = (_e19 + _e18);
    int _e21 = old;
    _group_0_binding_0_cs[base] = uint(_e21);
    amount_1 = 0;
    old_1 = 0;
    amount_1 = 5;
    int _e31 = value;
    old_1 = _e31;
    int _e33 = amount_1;
    int _e34 = value;
    value = (_e34 + _e33);
    int _e36 = old_1;
    local = uint((base + 1u));
    uint _e42 = local;
    _group_0_binding_0_cs[_e42] = uint(_e36);
    int _e44 = value;
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    _group_0_binding_0_cs[_e50] = uint(_e44);
    int _e53 = choose_noexcept(1);
    local_2 = uint((base + 3u));
    uint _e59 = local_2;
    _group_0_binding_0_cs[_e59] = uint(_e53);
    int _e62 = choose_noexcept_1(1u);
    local_3 = uint((base + 4u));
    uint _e68 = local_3;
    _group_0_binding_0_cs[_e68] = uint(_e62);
    scale = 0u;
    scale = 3u;
    int _e74 = value;
    value = (_e74 + 1);
    uint _e78 = scale;
    local_5 = (uint(_e74) * _e78);
    uint _e81 = local_5;
    scale_1 = 0u;
    scale_1 = 5u;
    int _e86 = value;
    value = (_e86 + 1);
    uint _e90 = scale_1;
    local_6 = (uint(_e86) * _e90);
    uint _e93 = local_6;
    uint _e94 = combined_noexcept(_e81, _e93);
    local_4 = uint((base + 5u));
    uint _e99 = local_4;
    _group_0_binding_0_cs[_e99] = _e94;
    int _e101 = value;
    local_7 = uint((base + 6u));
    uint _e107 = local_7;
    _group_0_binding_0_cs[_e107] = uint(_e101);
    local_8 = false;
    if (false) {
        amount_2 = 0;
        old_2 = 0;
        amount_2 = 2;
        int _e117 = value;
        local_29 = _e117;
        int _e119 = local_29;
        old_2 = _e119;
        int _e121 = amount_2;
        int _e122 = value;
        local_30 = _e122;
        int _e124 = local_30;
        value = (_e124 + _e121);
        int _e126 = old_2;
        local_9 = _e126;
        int _e128 = local_9;
        local_8 = (_e128 != 0);
    }
    local_10 = true;
    if (true) {
    } else {
        amount_3 = 0;
        old_3 = 0;
        amount_3 = 2;
        int _e139 = value;
        local_31 = _e139;
        int _e141 = local_31;
        old_3 = _e141;
        int _e143 = amount_3;
        int _e144 = value;
        local_32 = _e144;
        int _e146 = local_32;
        value = (_e146 + _e143);
        int _e148 = old_3;
        local_11 = _e148;
        int _e150 = local_11;
        local_10 = (_e150 != 0);
    }
    if (((lane & 1u) == 0u)) {
        amount_4 = 0;
        old_4 = 0;
        amount_4 = 2;
        int _e163 = value;
        local_33 = _e163;
        int _e165 = local_33;
        old_4 = _e165;
        int _e167 = amount_4;
        int _e168 = value;
        local_34 = _e168;
        int _e170 = local_34;
        value = (_e170 + _e167);
        int _e172 = old_4;
        local_12 = _e172;
        int _e174 = local_12;
        local_14 = _e174;
    } else {
        amount_5 = 0;
        old_5 = 0;
        amount_5 = 3;
        int _e182 = value;
        local_35 = _e182;
        int _e184 = local_35;
        old_5 = _e184;
        int _e186 = amount_5;
        int _e187 = value;
        local_36 = _e187;
        int _e189 = local_36;
        value = (_e189 + _e186);
        int _e191 = old_5;
        local_13 = _e191;
        int _e193 = local_13;
        local_14 = _e193;
    }
    int _e195 = value;
    local_15 = uint((base + 7u));
    uint _e201 = local_15;
    _group_0_binding_0_cs[_e201] = uint(_e195);
    amount_6 = 0;
    old_6 = 0;
    amount_6 = 2;
    int _e209 = value;
    old_6 = _e209;
    int _e211 = amount_6;
    int _e212 = value;
    value = (_e212 + _e211);
    int _e214 = value;
    local_16 = uint((base + 8u));
    uint _e220 = local_16;
    _group_0_binding_0_cs[_e220] = uint(_e214);
    int _e222 = value;
    local_18 = (_e222 + 1);
    int _e226 = local_18;
    local_17 = uint((base + 9u));
    uint _e232 = local_17;
    _group_0_binding_0_cs[_e232] = uint(_e226);
    int _e234 = value;
    local_20 = (_e234 + 2);
    int _e238 = local_20;
    local_19 = uint((base + 10u));
    uint _e244 = local_19;
    _group_0_binding_0_cs[_e244] = uint(_e238);
    int _e246 = value;
    local_22 = (_e246 + 3);
    int _e250 = local_22;
    local_21 = uint((base + 11u));
    uint _e256 = local_21;
    _group_0_binding_0_cs[_e256] = uint(_e250);
    int _e258 = skipped_noexcept();
    local_23 = uint((base + 12u));
    uint _e264 = local_23;
    _group_0_binding_0_cs[_e264] = uint(_e258);
    int _e266 = converted_noexcept();
    local_24 = uint((base + 13u));
    uint _e272 = local_24;
    _group_0_binding_0_cs[_e272] = uint(_e266);
    int _e274 = false_noexcept();
    local_25 = uint((base + 14u));
    uint _e280 = local_25;
    _group_0_binding_0_cs[_e280] = uint(_e274);
    int _e282 = reverse_noexcept();
    local_26 = uint((base + 15u));
    uint _e288 = local_26;
    _group_0_binding_0_cs[_e288] = uint(_e282);
    int _e291 = default_noexcept(3);
    local_27 = uint((base + 16u));
    uint _e297 = local_27;
    _group_0_binding_0_cs[_e297] = uint(_e291);
    int _e299 = float_bool_noexcept();
    local_28 = uint((base + 17u));
    uint _e305 = local_28;
    _group_0_binding_0_cs[_e305] = uint(_e299);
}

