#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_3_block_0Compute { int _group_0_binding_0_cs[]; };


int local_sum(int value) {
    int values[3] = int[3](0, 0, 0);
    values = int[3](0, 0, 0);
    values[0] = value;
    values[1] = (value + 1);
    int _e13 = values[0];
    int _e14 = values[1];
    values[2] = (_e13 + _e14);
    int _e20 = values[2];
    return _e20;
}

int reset_sum(int count) {
    int result = 0;
    int i_1 = 0;
    int values_1[2] = int[2](0, 0);
    result = 0;
    {
        i_1 = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e24 = i_1;
                i_1 = (_e24 + 1);
            }
            loop_init = false;
            int _e5 = i_1;
            if ((_e5 < count)) {
            } else {
                break;
            }
            values_1 = int[2](0, 0);
            int _e9 = i_1;
            values_1[1] = _e9;
            int _e16 = values_1[0];
            int _e17 = values_1[1];
            int _e19 = result;
            result = (_e19 + (_e16 + _e17));
            values_1[0] = 99;
        }
    }
    int _e27 = result;
    return _e27;
}

void main() {
    int seed = 0;
    uint local = 0u;
    int signed_values[3] = int[3](0, 0, 0);
    uint local_1 = 0u;
    uint words[2] = uint[2](0u, 0u);
    uint local_2 = 0u;
    float samples[2] = float[2](0.0, 0.0);
    uint local_3 = 0u;
    bool flags[3] = bool[3](false, false, false);
    uint local_4 = 0u;
    int zeros[2] = int[2](0, 0);
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    bool zero_flags[2] = bool[2](false, false);
    uint local_8 = 0u;
    bool local_9 = false;
    uint bank[2] = uint[2](0u, 0u);
    float bank_1[2] = float[2](0.0, 0.0);
    uint local_10 = 0u;
    uint local_11 = 0u;
    int signed_values_1[2] = int[2](0, 0);
    uint local_12 = 0u;
    uint local_13 = 0u;
    int mixed[2] = int[2](0, 0);
    uint local_14 = 0u;
    uint local_15 = 0u;
    int reset_total = 0;
    int i = 0;
    int reset[2] = int[2](0, 0);
    uint local_16 = 0u;
    int total = 0;
    int scratch[2] = int[2](0, 0);
    int j = 0;
    uint local_17 = 0u;
    float zero_samples[2] = float[2](0.0, 0.0);
    uint local_18 = 0u;
    int left[2] = int[2](0, 0);
    int right[2] = int[2](0, 0);
    uint local_19 = 0u;
    int temporary[2] = int[2](0, 0);
    int temporary_1[2] = int[2](0, 0);
    uint local_20 = 0u;
    uint local_21 = 0u;
    int index = 0;
    int rhs = 0;
    uint local_22 = 0u;
    int local_23 = 0;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    int local_27 = 0;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54 = 0u;
    local = uint(0);
    uint _e3 = local;
    local_29 = uint(_e3);
    uint _e6 = local_29;
    int _e9 = _group_0_binding_0_cs[_e6];
    seed = _e9;
    int _e11 = seed;
    signed_values[0] = _e11;
    signed_values[1] = -(2);
    signed_values[2] = 4;
    int _e26 = signed_values[0];
    int _e27 = signed_values[1];
    int _e31 = signed_values[2];
    local_1 = uint(0);
    uint _e36 = local_1;
    local_30 = uint(_e36);
    uint _e39 = local_30;
    _group_0_binding_0_cs[_e39] = ((_e26 + _e27) + _e31);
    words = uint[2](0u, 0u);
    words[0] = 4294967295u;
    words[1] = 1u;
    uint _e53 = words[0];
    uint _e54 = words[1];
    local_2 = uint(1);
    uint _e62 = local_2;
    local_31 = uint(_e62);
    uint _e65 = local_31;
    _group_0_binding_0_cs[_e65] = int(((_e53 + _e54) == 0u));
    samples = float[2](0.0, 0.0);
    samples[0] = 1.5;
    samples[1] = 2.25;
    float _e79 = samples[0];
    float _e80 = samples[1];
    local_3 = uint(2);
    uint _e88 = local_3;
    local_32 = uint(_e88);
    uint _e91 = local_32;
    _group_0_binding_0_cs[_e91] = int(((_e79 + _e80) * 4.0));
    flags = bool[3](false, false, false);
    int _e95 = seed;
    flags[0] = (_e95 != 0);
    flags[2] = true;
    bool _e105 = flags[0];
    bool _e111 = flags[1];
    bool _e118 = flags[2];
    local_4 = uint(3);
    uint _e124 = local_4;
    local_33 = uint(_e124);
    uint _e127 = local_33;
    _group_0_binding_0_cs[_e127] = (((int(_e105) * 100) + (int(_e111) * 10)) + int(_e118));
    zeros = int[2](0, 0);
    int _e135 = zeros[0];
    int _e136 = zeros[1];
    local_5 = uint(4);
    uint _e141 = local_5;
    local_34 = uint(_e141);
    uint _e144 = local_34;
    _group_0_binding_0_cs[_e144] = (_e135 + _e136);
    int _e146 = seed;
    int _e147 = local_sum(_e146);
    local_6 = uint(5);
    uint _e151 = local_6;
    local_35 = uint(_e151);
    uint _e154 = local_35;
    _group_0_binding_0_cs[_e154] = _e147;
    int _e157 = reset_sum(3);
    local_7 = uint(6);
    uint _e161 = local_7;
    local_36 = uint(_e161);
    uint _e164 = local_36;
    _group_0_binding_0_cs[_e164] = _e157;
    zero_flags = bool[2](false, false);
    bool _e170 = zero_flags[0];
    local_9 = _e170;
    if (_e170) {
    } else {
        bool _e174 = zero_flags[1];
        local_9 = _e174;
    }
    bool _e175 = local_9;
    local_8 = uint(7);
    uint _e180 = local_8;
    local_37 = uint(_e180);
    uint _e183 = local_37;
    _group_0_binding_0_cs[_e183] = int(_e175);
    bank = uint[2](0u, 0u);
    bank[0] = 3u;
    bank[1] = 4u;
    {
        bank_1 = float[2](0.0, 0.0);
        bank_1[1] = 6.5;
        float _e202 = bank_1[0];
        float _e203 = bank_1[1];
        local_10 = uint(8);
        uint _e209 = local_10;
        local_38 = uint(_e209);
        uint _e212 = local_38;
        _group_0_binding_0_cs[_e212] = int((_e202 + _e203));
    }
    uint _e218 = bank[0];
    uint _e219 = bank[1];
    local_11 = uint(9);
    uint _e225 = local_11;
    local_39 = uint(_e225);
    uint _e228 = local_39;
    _group_0_binding_0_cs[_e228] = int((_e218 + _e219));
    {
        int _e230 = seed;
        signed_values_1[0] = _e230;
        int _e234 = seed;
        signed_values_1[1] = _e234;
        int _e241 = signed_values_1[0];
        int _e242 = signed_values_1[1];
        local_12 = uint(10);
        uint _e247 = local_12;
        local_40 = uint(_e247);
        uint _e250 = local_40;
        _group_0_binding_0_cs[_e250] = (_e241 + _e242);
    }
    int _e254 = signed_values[0];
    local_13 = uint(11);
    uint _e258 = local_13;
    local_41 = uint(_e258);
    uint _e261 = local_41;
    _group_0_binding_0_cs[_e261] = _e254;
    mixed = int[2](0, 0);
    int _e265 = seed;
    seed = (_e265 + 1);
    int next = seed;
    mixed[0] = next;
    int _e271 = seed;
    seed = (_e271 + 1);
    mixed[1] = _e271;
    int _e278 = mixed[0];
    int _e283 = mixed[1];
    local_14 = uint(12);
    uint _e288 = local_14;
    local_42 = uint(_e288);
    uint _e291 = local_42;
    _group_0_binding_0_cs[_e291] = ((_e278 * 10) + _e283);
    int _e293 = seed;
    local_15 = uint(13);
    uint _e297 = local_15;
    local_43 = uint(_e297);
    uint _e300 = local_43;
    _group_0_binding_0_cs[_e300] = _e293;
    reset_total = 0;
    {
        i = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e327 = i;
                i = (_e327 + 1);
            }
            loop_init_1 = false;
            int _e306 = i;
            if ((_e306 < 3)) {
            } else {
                break;
            }
            reset = int[2](0, 0);
            int _e311 = i;
            if ((_e311 == 1)) {
                reset[0] = 90;
                continue;
            }
            int _e319 = reset[0];
            int _e320 = i;
            int _e322 = reset_total;
            reset_total = (_e322 + (_e319 + _e320));
            reset[0] = 99;
        }
    }
    int _e330 = reset_total;
    local_16 = uint(14);
    uint _e334 = local_16;
    local_44 = uint(_e334);
    uint _e337 = local_44;
    _group_0_binding_0_cs[_e337] = _e330;
    total = 0;
    {
        scratch = int[2](0, 0);
        j = 0;
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                int _e369 = j;
                j = (_e369 + 1);
            }
            loop_init_2 = false;
            int _e345 = j;
            if ((_e345 < 3)) {
            } else {
                break;
            }
            int _e348 = j;
            int _e352 = scratch[(_e348 - 2 * (_e348 / 2))];
            scratch[(_e348 - 2 * (_e348 / 2))] = (_e352 + 1);
            int _e355 = j;
            if ((_e355 == 1)) {
                continue;
            }
            int _e360 = scratch[0];
            int _e365 = scratch[1];
            int _e367 = total;
            total = (_e367 + ((_e360 * 10) + _e365));
        }
    }
    int _e372 = total;
    local_17 = uint(15);
    uint _e376 = local_17;
    local_45 = uint(_e376);
    uint _e379 = local_45;
    _group_0_binding_0_cs[_e379] = _e372;
    zero_samples = float[2](0.0, 0.0);
    float _e387 = zero_samples[0];
    float _e388 = zero_samples[1];
    local_18 = uint(16);
    uint _e394 = local_18;
    local_46 = uint(_e394);
    uint _e397 = local_46;
    _group_0_binding_0_cs[_e397] = int((_e387 + _e388));
    left = int[2](0, 0);
    right = int[2](0, 0);
    left[0] = 5;
    left[1] = 7;
    right[0] = 11;
    right[1] = 13;
    int _e419 = left[0];
    int _e420 = right[0];
    local_19 = uint(17);
    uint _e425 = local_19;
    local_47 = uint(_e425);
    uint _e428 = local_47;
    _group_0_binding_0_cs[_e428] = (_e419 + _e420);
    {
        temporary = int[2](0, 0);
        int _e432 = seed;
        temporary[0] = _e432;
        {
            temporary_1 = int[2](0, 0);
            temporary_1[1] = 3;
            int _e444 = temporary_1[0];
            int _e445 = temporary_1[1];
            local_20 = uint(18);
            uint _e450 = local_20;
            local_48 = uint(_e450);
            uint _e453 = local_48;
            _group_0_binding_0_cs[_e453] = (_e444 + _e445);
        }
        int _e457 = temporary[0];
        local_21 = uint(19);
        uint _e461 = local_21;
        local_49 = uint(_e461);
        uint _e464 = local_49;
        _group_0_binding_0_cs[_e464] = _e457;
    }
    int _e466 = seed;
    bool choose = ((_e466 & 1) == 0);
    index = 0;
    rhs = 20;
    int _e475 = rhs;
    rhs = (_e475 + 1);
    int _e478 = rhs;
    if (choose) {
        int _e479 = index;
        index = (_e479 + 1);
        int _e483 = left[_e479];
        left[_e479] = (_e483 + _e478);
        int _e485 = left[_e479];
        local_23 = _e485;
    } else {
        int _e487 = index;
        index = (_e487 + 1);
        int _e491 = right[_e487];
        right[_e487] = (_e491 + _e478);
        int _e493 = right[_e487];
        local_23 = _e493;
    }
    int _e496 = local_23;
    local_22 = uint(20);
    uint _e500 = local_22;
    local_50 = uint(_e500);
    uint _e503 = local_50;
    _group_0_binding_0_cs[_e503] = _e496;
    int _e505 = index;
    local_24 = uint(21);
    uint _e509 = local_24;
    local_51 = uint(_e509);
    uint _e512 = local_51;
    _group_0_binding_0_cs[_e512] = _e505;
    int _e516 = left[0];
    int _e521 = right[0];
    local_25 = uint(22);
    uint _e526 = local_25;
    local_52 = uint(_e526);
    uint _e529 = local_52;
    _group_0_binding_0_cs[_e529] = ((_e516 * 100) + _e521);
    if (choose) {
        right[1] = 9;
        int _e534 = right[1];
        right[1] = (_e534 + 1);
        local_27 = _e534;
    } else {
        left[1] = 9;
        int _e541 = left[1];
        left[1] = (_e541 + 1);
        local_27 = _e541;
    }
    int _e546 = local_27;
    local_26 = uint(23);
    uint _e550 = local_26;
    local_53 = uint(_e550);
    uint _e553 = local_53;
    _group_0_binding_0_cs[_e553] = _e546;
    int _e557 = left[1];
    int _e562 = right[1];
    local_28 = uint(24);
    uint _e567 = local_28;
    local_54 = uint(_e567);
    uint _e570 = local_54;
    _group_0_binding_0_cs[_e570] = ((_e557 * 100) + _e562);
}

