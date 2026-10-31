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
    int local_29 = 0;
    uint local_30 = 0u;
    int local_31 = 0;
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
    uint local_55 = 0u;
    uint local_56 = 0u;
    local = uint(0);
    uint _e3 = local;
    local_30 = uint(_e3);
    uint _e6 = local_30;
    int _e9 = _group_0_binding_0_cs[_e6];
    local_31 = _e9;
    int _e11 = local_31;
    local_29 = _e11;
    int _e13 = local_29;
    seed = _e13;
    int _e15 = seed;
    signed_values[0] = _e15;
    signed_values[1] = -(2);
    signed_values[2] = 4;
    int _e30 = signed_values[0];
    int _e31 = signed_values[1];
    int _e35 = signed_values[2];
    local_1 = uint(0);
    uint _e40 = local_1;
    local_32 = uint(_e40);
    uint _e43 = local_32;
    _group_0_binding_0_cs[_e43] = ((_e30 + _e31) + _e35);
    words = uint[2](0u, 0u);
    words[0] = 4294967295u;
    words[1] = 1u;
    uint _e57 = words[0];
    uint _e58 = words[1];
    local_2 = uint(1);
    uint _e66 = local_2;
    local_33 = uint(_e66);
    uint _e69 = local_33;
    _group_0_binding_0_cs[_e69] = int(((_e57 + _e58) == 0u));
    samples = float[2](0.0, 0.0);
    samples[0] = 1.5;
    samples[1] = 2.25;
    float _e83 = samples[0];
    float _e84 = samples[1];
    local_3 = uint(2);
    uint _e92 = local_3;
    local_34 = uint(_e92);
    uint _e95 = local_34;
    _group_0_binding_0_cs[_e95] = int(((_e83 + _e84) * 4.0));
    flags = bool[3](false, false, false);
    int _e99 = seed;
    flags[0] = (_e99 != 0);
    flags[2] = true;
    bool _e109 = flags[0];
    bool _e115 = flags[1];
    bool _e122 = flags[2];
    local_4 = uint(3);
    uint _e128 = local_4;
    local_35 = uint(_e128);
    uint _e131 = local_35;
    _group_0_binding_0_cs[_e131] = (((int(_e109) * 100) + (int(_e115) * 10)) + int(_e122));
    zeros = int[2](0, 0);
    int _e139 = zeros[0];
    int _e140 = zeros[1];
    local_5 = uint(4);
    uint _e145 = local_5;
    local_36 = uint(_e145);
    uint _e148 = local_36;
    _group_0_binding_0_cs[_e148] = (_e139 + _e140);
    int _e150 = seed;
    int _e151 = local_sum(_e150);
    local_6 = uint(5);
    uint _e155 = local_6;
    local_37 = uint(_e155);
    uint _e158 = local_37;
    _group_0_binding_0_cs[_e158] = _e151;
    int _e161 = reset_sum(3);
    local_7 = uint(6);
    uint _e165 = local_7;
    local_38 = uint(_e165);
    uint _e168 = local_38;
    _group_0_binding_0_cs[_e168] = _e161;
    zero_flags = bool[2](false, false);
    bool _e174 = zero_flags[0];
    local_9 = _e174;
    if (_e174) {
    } else {
        bool _e178 = zero_flags[1];
        local_9 = _e178;
    }
    bool _e179 = local_9;
    local_8 = uint(7);
    uint _e184 = local_8;
    local_39 = uint(_e184);
    uint _e187 = local_39;
    _group_0_binding_0_cs[_e187] = int(_e179);
    bank = uint[2](0u, 0u);
    bank[0] = 3u;
    bank[1] = 4u;
    {
        bank_1 = float[2](0.0, 0.0);
        bank_1[1] = 6.5;
        float _e206 = bank_1[0];
        float _e207 = bank_1[1];
        local_10 = uint(8);
        uint _e213 = local_10;
        local_40 = uint(_e213);
        uint _e216 = local_40;
        _group_0_binding_0_cs[_e216] = int((_e206 + _e207));
    }
    uint _e222 = bank[0];
    uint _e223 = bank[1];
    local_11 = uint(9);
    uint _e229 = local_11;
    local_41 = uint(_e229);
    uint _e232 = local_41;
    _group_0_binding_0_cs[_e232] = int((_e222 + _e223));
    {
        int _e234 = seed;
        signed_values_1[0] = _e234;
        int _e238 = seed;
        signed_values_1[1] = _e238;
        int _e245 = signed_values_1[0];
        int _e246 = signed_values_1[1];
        local_12 = uint(10);
        uint _e251 = local_12;
        local_42 = uint(_e251);
        uint _e254 = local_42;
        _group_0_binding_0_cs[_e254] = (_e245 + _e246);
    }
    int _e258 = signed_values[0];
    local_13 = uint(11);
    uint _e262 = local_13;
    local_43 = uint(_e262);
    uint _e265 = local_43;
    _group_0_binding_0_cs[_e265] = _e258;
    mixed = int[2](0, 0);
    int _e269 = seed;
    seed = (_e269 + 1);
    int next = seed;
    mixed[0] = next;
    int _e275 = seed;
    seed = (_e275 + 1);
    mixed[1] = _e275;
    int _e282 = mixed[0];
    int _e287 = mixed[1];
    local_14 = uint(12);
    uint _e292 = local_14;
    local_44 = uint(_e292);
    uint _e295 = local_44;
    _group_0_binding_0_cs[_e295] = ((_e282 * 10) + _e287);
    int _e297 = seed;
    local_15 = uint(13);
    uint _e301 = local_15;
    local_45 = uint(_e301);
    uint _e304 = local_45;
    _group_0_binding_0_cs[_e304] = _e297;
    reset_total = 0;
    {
        i = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e331 = i;
                i = (_e331 + 1);
            }
            loop_init_1 = false;
            int _e310 = i;
            if ((_e310 < 3)) {
            } else {
                break;
            }
            reset = int[2](0, 0);
            int _e315 = i;
            if ((_e315 == 1)) {
                reset[0] = 90;
                continue;
            }
            int _e323 = reset[0];
            int _e324 = i;
            int _e326 = reset_total;
            reset_total = (_e326 + (_e323 + _e324));
            reset[0] = 99;
        }
    }
    int _e334 = reset_total;
    local_16 = uint(14);
    uint _e338 = local_16;
    local_46 = uint(_e338);
    uint _e341 = local_46;
    _group_0_binding_0_cs[_e341] = _e334;
    total = 0;
    {
        scratch = int[2](0, 0);
        j = 0;
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                int _e373 = j;
                j = (_e373 + 1);
            }
            loop_init_2 = false;
            int _e349 = j;
            if ((_e349 < 3)) {
            } else {
                break;
            }
            int _e352 = j;
            int _e356 = scratch[(_e352 - 2 * (_e352 / 2))];
            scratch[(_e352 - 2 * (_e352 / 2))] = (_e356 + 1);
            int _e359 = j;
            if ((_e359 == 1)) {
                continue;
            }
            int _e364 = scratch[0];
            int _e369 = scratch[1];
            int _e371 = total;
            total = (_e371 + ((_e364 * 10) + _e369));
        }
    }
    int _e376 = total;
    local_17 = uint(15);
    uint _e380 = local_17;
    local_47 = uint(_e380);
    uint _e383 = local_47;
    _group_0_binding_0_cs[_e383] = _e376;
    zero_samples = float[2](0.0, 0.0);
    float _e391 = zero_samples[0];
    float _e392 = zero_samples[1];
    local_18 = uint(16);
    uint _e398 = local_18;
    local_48 = uint(_e398);
    uint _e401 = local_48;
    _group_0_binding_0_cs[_e401] = int((_e391 + _e392));
    left = int[2](0, 0);
    right = int[2](0, 0);
    left[0] = 5;
    left[1] = 7;
    right[0] = 11;
    right[1] = 13;
    int _e423 = left[0];
    int _e424 = right[0];
    local_19 = uint(17);
    uint _e429 = local_19;
    local_49 = uint(_e429);
    uint _e432 = local_49;
    _group_0_binding_0_cs[_e432] = (_e423 + _e424);
    {
        temporary = int[2](0, 0);
        int _e436 = seed;
        temporary[0] = _e436;
        {
            temporary_1 = int[2](0, 0);
            temporary_1[1] = 3;
            int _e448 = temporary_1[0];
            int _e449 = temporary_1[1];
            local_20 = uint(18);
            uint _e454 = local_20;
            local_50 = uint(_e454);
            uint _e457 = local_50;
            _group_0_binding_0_cs[_e457] = (_e448 + _e449);
        }
        int _e461 = temporary[0];
        local_21 = uint(19);
        uint _e465 = local_21;
        local_51 = uint(_e465);
        uint _e468 = local_51;
        _group_0_binding_0_cs[_e468] = _e461;
    }
    int _e470 = seed;
    bool choose = ((_e470 & 1) == 0);
    index = 0;
    rhs = 20;
    int _e479 = rhs;
    rhs = (_e479 + 1);
    int _e482 = rhs;
    if (choose) {
        int _e483 = index;
        index = (_e483 + 1);
        int _e487 = left[_e483];
        left[_e483] = (_e487 + _e482);
        int _e489 = left[_e483];
        local_23 = _e489;
    } else {
        int _e491 = index;
        index = (_e491 + 1);
        int _e495 = right[_e491];
        right[_e491] = (_e495 + _e482);
        int _e497 = right[_e491];
        local_23 = _e497;
    }
    int _e500 = local_23;
    local_22 = uint(20);
    uint _e504 = local_22;
    local_52 = uint(_e504);
    uint _e507 = local_52;
    _group_0_binding_0_cs[_e507] = _e500;
    int _e509 = index;
    local_24 = uint(21);
    uint _e513 = local_24;
    local_53 = uint(_e513);
    uint _e516 = local_53;
    _group_0_binding_0_cs[_e516] = _e509;
    int _e520 = left[0];
    int _e525 = right[0];
    local_25 = uint(22);
    uint _e530 = local_25;
    local_54 = uint(_e530);
    uint _e533 = local_54;
    _group_0_binding_0_cs[_e533] = ((_e520 * 100) + _e525);
    if (choose) {
        right[1] = 9;
        int _e538 = right[1];
        right[1] = (_e538 + 1);
        local_27 = _e538;
    } else {
        left[1] = 9;
        int _e545 = left[1];
        left[1] = (_e545 + 1);
        local_27 = _e545;
    }
    int _e550 = local_27;
    local_26 = uint(23);
    uint _e554 = local_26;
    local_55 = uint(_e554);
    uint _e557 = local_55;
    _group_0_binding_0_cs[_e557] = _e550;
    int _e561 = left[1];
    int _e566 = right[1];
    local_28 = uint(24);
    uint _e571 = local_28;
    local_56 = uint(_e571);
    uint _e574 = local_56;
    _group_0_binding_0_cs[_e574] = ((_e561 * 100) + _e566);
}

