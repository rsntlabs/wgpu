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
    local = uint(0);
    uint _e3 = local;
    int _e6 = _group_0_binding_0_cs[_e3];
    seed = _e6;
    int _e8 = seed;
    signed_values[0] = _e8;
    signed_values[1] = -(2);
    signed_values[2] = 4;
    int _e23 = signed_values[0];
    int _e24 = signed_values[1];
    int _e28 = signed_values[2];
    local_1 = uint(0);
    uint _e33 = local_1;
    _group_0_binding_0_cs[_e33] = ((_e23 + _e24) + _e28);
    words = uint[2](0u, 0u);
    words[0] = 4294967295u;
    words[1] = 1u;
    uint _e47 = words[0];
    uint _e48 = words[1];
    local_2 = uint(1);
    uint _e56 = local_2;
    _group_0_binding_0_cs[_e56] = int(((_e47 + _e48) == 0u));
    samples = float[2](0.0, 0.0);
    samples[0] = 1.5;
    samples[1] = 2.25;
    float _e70 = samples[0];
    float _e71 = samples[1];
    local_3 = uint(2);
    uint _e79 = local_3;
    _group_0_binding_0_cs[_e79] = int(((_e70 + _e71) * 4.0));
    flags = bool[3](false, false, false);
    int _e83 = seed;
    flags[0] = (_e83 != 0);
    flags[2] = true;
    bool _e93 = flags[0];
    bool _e99 = flags[1];
    bool _e106 = flags[2];
    local_4 = uint(3);
    uint _e112 = local_4;
    _group_0_binding_0_cs[_e112] = (((int(_e93) * 100) + (int(_e99) * 10)) + int(_e106));
    zeros = int[2](0, 0);
    int _e120 = zeros[0];
    int _e121 = zeros[1];
    local_5 = uint(4);
    uint _e126 = local_5;
    _group_0_binding_0_cs[_e126] = (_e120 + _e121);
    int _e128 = seed;
    int _e129 = local_sum(_e128);
    local_6 = uint(5);
    uint _e133 = local_6;
    _group_0_binding_0_cs[_e133] = _e129;
    int _e136 = reset_sum(3);
    local_7 = uint(6);
    uint _e140 = local_7;
    _group_0_binding_0_cs[_e140] = _e136;
    zero_flags = bool[2](false, false);
    bool _e146 = zero_flags[0];
    local_9 = _e146;
    if (_e146) {
    } else {
        bool _e150 = zero_flags[1];
        local_9 = _e150;
    }
    bool _e151 = local_9;
    local_8 = uint(7);
    uint _e156 = local_8;
    _group_0_binding_0_cs[_e156] = int(_e151);
    bank = uint[2](0u, 0u);
    bank[0] = 3u;
    bank[1] = 4u;
    {
        bank_1 = float[2](0.0, 0.0);
        bank_1[1] = 6.5;
        float _e175 = bank_1[0];
        float _e176 = bank_1[1];
        local_10 = uint(8);
        uint _e182 = local_10;
        local_29 = _e182;
        uint _e184 = local_29;
        _group_0_binding_0_cs[_e184] = int((_e175 + _e176));
    }
    uint _e190 = bank[0];
    uint _e191 = bank[1];
    local_11 = uint(9);
    uint _e197 = local_11;
    _group_0_binding_0_cs[_e197] = int((_e190 + _e191));
    {
        int _e199 = seed;
        signed_values_1[0] = _e199;
        int _e203 = seed;
        signed_values_1[1] = _e203;
        int _e210 = signed_values_1[0];
        int _e211 = signed_values_1[1];
        local_12 = uint(10);
        uint _e216 = local_12;
        local_30 = _e216;
        uint _e218 = local_30;
        _group_0_binding_0_cs[_e218] = (_e210 + _e211);
    }
    int _e222 = signed_values[0];
    local_13 = uint(11);
    uint _e226 = local_13;
    _group_0_binding_0_cs[_e226] = _e222;
    mixed = int[2](0, 0);
    int _e230 = seed;
    seed = (_e230 + 1);
    int next = seed;
    mixed[0] = next;
    int _e236 = seed;
    seed = (_e236 + 1);
    mixed[1] = _e236;
    int _e243 = mixed[0];
    int _e248 = mixed[1];
    local_14 = uint(12);
    uint _e253 = local_14;
    _group_0_binding_0_cs[_e253] = ((_e243 * 10) + _e248);
    int _e255 = seed;
    local_15 = uint(13);
    uint _e259 = local_15;
    _group_0_binding_0_cs[_e259] = _e255;
    reset_total = 0;
    {
        i = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e286 = i;
                i = (_e286 + 1);
            }
            loop_init_1 = false;
            int _e265 = i;
            if ((_e265 < 3)) {
            } else {
                break;
            }
            reset = int[2](0, 0);
            int _e270 = i;
            if ((_e270 == 1)) {
                reset[0] = 90;
                continue;
            }
            int _e278 = reset[0];
            int _e279 = i;
            int _e281 = reset_total;
            reset_total = (_e281 + (_e278 + _e279));
            reset[0] = 99;
        }
    }
    int _e289 = reset_total;
    local_16 = uint(14);
    uint _e293 = local_16;
    _group_0_binding_0_cs[_e293] = _e289;
    total = 0;
    {
        scratch = int[2](0, 0);
        j = 0;
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                int _e325 = j;
                j = (_e325 + 1);
            }
            loop_init_2 = false;
            int _e301 = j;
            if ((_e301 < 3)) {
            } else {
                break;
            }
            int _e304 = j;
            int _e308 = scratch[(_e304 - 2 * (_e304 / 2))];
            scratch[(_e304 - 2 * (_e304 / 2))] = (_e308 + 1);
            int _e311 = j;
            if ((_e311 == 1)) {
                continue;
            }
            int _e316 = scratch[0];
            int _e321 = scratch[1];
            int _e323 = total;
            total = (_e323 + ((_e316 * 10) + _e321));
        }
    }
    int _e328 = total;
    local_17 = uint(15);
    uint _e332 = local_17;
    _group_0_binding_0_cs[_e332] = _e328;
    zero_samples = float[2](0.0, 0.0);
    float _e340 = zero_samples[0];
    float _e341 = zero_samples[1];
    local_18 = uint(16);
    uint _e347 = local_18;
    _group_0_binding_0_cs[_e347] = int((_e340 + _e341));
    left = int[2](0, 0);
    right = int[2](0, 0);
    left[0] = 5;
    left[1] = 7;
    right[0] = 11;
    right[1] = 13;
    int _e369 = left[0];
    int _e370 = right[0];
    local_19 = uint(17);
    uint _e375 = local_19;
    _group_0_binding_0_cs[_e375] = (_e369 + _e370);
    {
        temporary = int[2](0, 0);
        int _e379 = seed;
        temporary[0] = _e379;
        {
            temporary_1 = int[2](0, 0);
            temporary_1[1] = 3;
            int _e391 = temporary_1[0];
            int _e392 = temporary_1[1];
            local_20 = uint(18);
            uint _e397 = local_20;
            local_31 = _e397;
            uint _e399 = local_31;
            _group_0_binding_0_cs[_e399] = (_e391 + _e392);
        }
        int _e403 = temporary[0];
        local_21 = uint(19);
        uint _e407 = local_21;
        local_32 = _e407;
        uint _e409 = local_32;
        _group_0_binding_0_cs[_e409] = _e403;
    }
    int _e411 = seed;
    bool choose = ((_e411 & 1) == 0);
    index = 0;
    rhs = 20;
    int _e420 = rhs;
    rhs = (_e420 + 1);
    int _e423 = rhs;
    if (choose) {
        int _e424 = index;
        index = (_e424 + 1);
        int _e428 = left[_e424];
        left[_e424] = (_e428 + _e423);
        int _e430 = left[_e424];
        local_23 = _e430;
    } else {
        int _e432 = index;
        index = (_e432 + 1);
        int _e436 = right[_e432];
        right[_e432] = (_e436 + _e423);
        int _e438 = right[_e432];
        local_23 = _e438;
    }
    int _e441 = local_23;
    local_22 = uint(20);
    uint _e445 = local_22;
    _group_0_binding_0_cs[_e445] = _e441;
    int _e447 = index;
    local_24 = uint(21);
    uint _e451 = local_24;
    _group_0_binding_0_cs[_e451] = _e447;
    int _e455 = left[0];
    int _e460 = right[0];
    local_25 = uint(22);
    uint _e465 = local_25;
    _group_0_binding_0_cs[_e465] = ((_e455 * 100) + _e460);
    if (choose) {
        right[1] = 9;
        int _e470 = right[1];
        right[1] = (_e470 + 1);
        local_27 = _e470;
    } else {
        left[1] = 9;
        int _e477 = left[1];
        left[1] = (_e477 + 1);
        local_27 = _e477;
    }
    int _e482 = local_27;
    local_26 = uint(23);
    uint _e486 = local_26;
    _group_0_binding_0_cs[_e486] = _e482;
    int _e490 = left[1];
    int _e495 = right[1];
    local_28 = uint(24);
    uint _e500 = local_28;
    _group_0_binding_0_cs[_e500] = ((_e490 * 100) + _e495);
}

