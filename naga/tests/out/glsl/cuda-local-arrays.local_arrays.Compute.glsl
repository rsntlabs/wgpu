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
    int signed_values[3] = int[3](0, 0, 0);
    uint words[2] = uint[2](0u, 0u);
    float samples[2] = float[2](0.0, 0.0);
    bool flags[3] = bool[3](false, false, false);
    int zeros[2] = int[2](0, 0);
    bool zero_flags[2] = bool[2](false, false);
    bool local = false;
    uint bank[2] = uint[2](0u, 0u);
    float bank_1[2] = float[2](0.0, 0.0);
    uint local_1 = 0u;
    int signed_values_1[2] = int[2](0, 0);
    uint local_2 = 0u;
    int mixed[2] = int[2](0, 0);
    int reset_total = 0;
    int i = 0;
    int reset[2] = int[2](0, 0);
    int total = 0;
    int scratch[2] = int[2](0, 0);
    int j = 0;
    float zero_samples[2] = float[2](0.0, 0.0);
    int left[2] = int[2](0, 0);
    int right[2] = int[2](0, 0);
    int temporary[2] = int[2](0, 0);
    int temporary_1[2] = int[2](0, 0);
    uint local_3 = 0u;
    uint local_4 = 0u;
    int index = 0;
    int rhs = 0;
    int local_5 = 0;
    int local_6 = 0;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    int _e4 = _group_0_binding_0_cs[uint(0)];
    seed = _e4;
    int _e6 = seed;
    signed_values[0] = _e6;
    signed_values[1] = -(2);
    signed_values[2] = 4;
    int _e21 = signed_values[0];
    int _e22 = signed_values[1];
    int _e26 = signed_values[2];
    _group_0_binding_0_cs[uint(0)] = ((_e21 + _e22) + _e26);
    words = uint[2](0u, 0u);
    words[0] = 4294967295u;
    words[1] = 1u;
    uint _e43 = words[0];
    uint _e44 = words[1];
    _group_0_binding_0_cs[uint(1)] = int(((_e43 + _e44) == 0u));
    samples = float[2](0.0, 0.0);
    samples[0] = 1.5;
    samples[1] = 2.25;
    float _e64 = samples[0];
    float _e65 = samples[1];
    _group_0_binding_0_cs[uint(2)] = int(((_e64 + _e65) * 4.0));
    flags = bool[3](false, false, false);
    int _e75 = seed;
    flags[0] = (_e75 != 0);
    flags[2] = true;
    bool _e85 = flags[0];
    bool _e91 = flags[1];
    bool _e98 = flags[2];
    _group_0_binding_0_cs[uint(3)] = (((int(_e85) * 100) + (int(_e91) * 10)) + int(_e98));
    zeros = int[2](0, 0);
    int _e110 = zeros[0];
    int _e111 = zeros[1];
    _group_0_binding_0_cs[uint(4)] = (_e110 + _e111);
    int _e116 = seed;
    int _e117 = local_sum(_e116);
    _group_0_binding_0_cs[uint(5)] = _e117;
    int _e122 = reset_sum(3);
    _group_0_binding_0_cs[uint(6)] = _e122;
    zero_flags = bool[2](false, false);
    bool _e130 = zero_flags[0];
    local = _e130;
    if (_e130) {
    } else {
        bool _e134 = zero_flags[1];
        local = _e134;
    }
    bool _e135 = local;
    _group_0_binding_0_cs[uint(7)] = int(_e135);
    bank = uint[2](0u, 0u);
    bank[0] = 3u;
    bank[1] = 4u;
    {
        bank_1 = float[2](0.0, 0.0);
        bank_1[1] = 6.5;
        float _e157 = bank_1[0];
        float _e158 = bank_1[1];
        local_1 = uint(8);
        uint _e164 = local_1;
        local_7 = _e164;
        uint _e166 = local_7;
        _group_0_binding_0_cs[_e166] = int((_e157 + _e158));
    }
    uint _e172 = bank[0];
    uint _e173 = bank[1];
    _group_0_binding_0_cs[uint(9)] = int((_e172 + _e173));
    {
        int _e179 = seed;
        signed_values_1[0] = _e179;
        int _e183 = seed;
        signed_values_1[1] = _e183;
        int _e190 = signed_values_1[0];
        int _e191 = signed_values_1[1];
        local_2 = uint(10);
        uint _e196 = local_2;
        local_8 = _e196;
        uint _e198 = local_8;
        _group_0_binding_0_cs[_e198] = (_e190 + _e191);
    }
    int _e202 = signed_values[0];
    _group_0_binding_0_cs[uint(11)] = _e202;
    mixed = int[2](0, 0);
    int _e208 = seed;
    seed = (_e208 + 1);
    int next = seed;
    mixed[0] = next;
    int _e214 = seed;
    seed = (_e214 + 1);
    mixed[1] = _e214;
    int _e221 = mixed[0];
    int _e226 = mixed[1];
    _group_0_binding_0_cs[uint(12)] = ((_e221 * 10) + _e226);
    int _e231 = seed;
    _group_0_binding_0_cs[uint(13)] = _e231;
    reset_total = 0;
    {
        i = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e260 = i;
                i = (_e260 + 1);
            }
            loop_init_1 = false;
            int _e239 = i;
            if ((_e239 < 3)) {
            } else {
                break;
            }
            reset = int[2](0, 0);
            int _e244 = i;
            if ((_e244 == 1)) {
                reset[0] = 90;
                continue;
            }
            int _e252 = reset[0];
            int _e253 = i;
            int _e255 = reset_total;
            reset_total = (_e255 + (_e252 + _e253));
            reset[0] = 99;
        }
    }
    int _e263 = reset_total;
    _group_0_binding_0_cs[uint(14)] = _e263;
    total = 0;
    {
        scratch = int[2](0, 0);
        j = 0;
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                int _e297 = j;
                j = (_e297 + 1);
            }
            loop_init_2 = false;
            int _e273 = j;
            if ((_e273 < 3)) {
            } else {
                break;
            }
            int _e276 = j;
            int _e280 = scratch[(_e276 - 2 * (_e276 / 2))];
            scratch[(_e276 - 2 * (_e276 / 2))] = (_e280 + 1);
            int _e283 = j;
            if ((_e283 == 1)) {
                continue;
            }
            int _e288 = scratch[0];
            int _e293 = scratch[1];
            int _e295 = total;
            total = (_e295 + ((_e288 * 10) + _e293));
        }
    }
    int _e300 = total;
    _group_0_binding_0_cs[uint(15)] = _e300;
    zero_samples = float[2](0.0, 0.0);
    float _e310 = zero_samples[0];
    float _e311 = zero_samples[1];
    _group_0_binding_0_cs[uint(16)] = int((_e310 + _e311));
    left = int[2](0, 0);
    right = int[2](0, 0);
    left[0] = 5;
    left[1] = 7;
    right[0] = 11;
    right[1] = 13;
    int _e337 = left[0];
    int _e338 = right[0];
    _group_0_binding_0_cs[uint(17)] = (_e337 + _e338);
    {
        temporary = int[2](0, 0);
        int _e345 = seed;
        temporary[0] = _e345;
        {
            temporary_1 = int[2](0, 0);
            temporary_1[1] = 3;
            int _e357 = temporary_1[0];
            int _e358 = temporary_1[1];
            local_3 = uint(18);
            uint _e363 = local_3;
            local_9 = _e363;
            uint _e365 = local_9;
            _group_0_binding_0_cs[_e365] = (_e357 + _e358);
        }
        int _e369 = temporary[0];
        local_4 = uint(19);
        uint _e373 = local_4;
        local_10 = _e373;
        uint _e375 = local_10;
        _group_0_binding_0_cs[_e375] = _e369;
    }
    int _e377 = seed;
    bool choose = ((_e377 & 1) == 0);
    index = 0;
    rhs = 20;
    int _e386 = rhs;
    rhs = (_e386 + 1);
    int _e389 = rhs;
    if (choose) {
        int _e390 = index;
        index = (_e390 + 1);
        int _e394 = left[_e390];
        left[_e390] = (_e394 + _e389);
        int _e396 = left[_e390];
        local_5 = _e396;
    } else {
        int _e398 = index;
        index = (_e398 + 1);
        int _e402 = right[_e398];
        right[_e398] = (_e402 + _e389);
        int _e404 = right[_e398];
        local_5 = _e404;
    }
    int _e407 = local_5;
    _group_0_binding_0_cs[uint(20)] = _e407;
    int _e411 = index;
    _group_0_binding_0_cs[uint(21)] = _e411;
    int _e417 = left[0];
    int _e422 = right[0];
    _group_0_binding_0_cs[uint(22)] = ((_e417 * 100) + _e422);
    if (choose) {
        right[1] = 9;
        int _e430 = right[1];
        right[1] = (_e430 + 1);
        local_6 = _e430;
    } else {
        left[1] = 9;
        int _e437 = left[1];
        left[1] = (_e437 + 1);
        local_6 = _e437;
    }
    int _e442 = local_6;
    _group_0_binding_0_cs[uint(23)] = _e442;
    int _e448 = left[1];
    int _e453 = right[1];
    _group_0_binding_0_cs[uint(24)] = ((_e448 * 100) + _e453);
}

