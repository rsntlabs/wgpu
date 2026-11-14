RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);

int naga_neg(int val) {
    return asint(-asuint(val));
}

uint ZeroValueuint() {
    return (uint)0;
}

[numthreads(4, 1, 1)]
void half_add(uint3 threadIdx : SV_GroupThreadID)
{
    uint row = (uint)0;
    uint a = (uint)0;
    uint local = (uint)0;
    uint b = (uint)0;
    uint local_1 = (uint)0;
    uint base = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint value = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    bool local_19 = (bool)0;
    bool local_20 = (bool)0;
    uint local_21 = (uint)0;
    uint index = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint scale = (uint)0;
    uint scale_1 = (uint)0;
    uint scale_2 = (uint)0;
    uint scale_3 = (uint)0;
    uint scale_4 = (uint)0;
    uint scale_5 = (uint)0;
    uint scale_6 = (uint)0;
    uint scale_7 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;

    uint lane = threadIdx.x;
    uint count = asuint(input.Load(uint(int(0))*4));
    {
        row = lane;
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e118 = row;
                row = (_e118 + 4u);
            }
            loop_init = false;
            uint _e8 = row;
            if ((_e8 < count)) {
            } else {
                break;
            }
            uint _e10 = row;
            local = uint((1u + (_e10 * 2u)));
            uint _e17 = local;
            local_28 = _e17;
            uint _e19 = local_28;
            uint _e21 = asuint(input.Load(_e19*4));
            local_29 = _e21;
            uint _e23 = local_29;
            local_26 = _e23;
            uint _e25 = local_26;
            a = _e25;
            uint _e27 = row;
            local_1 = uint((2u + (_e27 * 2u)));
            uint _e34 = local_1;
            local_30 = _e34;
            uint _e36 = local_30;
            uint _e38 = asuint(input.Load(_e36*4));
            local_31 = _e38;
            uint _e40 = local_31;
            local_27 = _e40;
            uint _e42 = local_27;
            b = _e42;
            uint _e44 = row;
            base = (4u + (_e44 * 4u));
            uint _e50 = a;
            int _e51 = int(_e50);
            uint _e52 = b;
            int _e53 = int(_e52);
            uint _e60 = base;
            local_2 = _e60;
            uint _e62 = local_2;
            local_32 = _e62;
            uint _e64 = local_32;
            output.Store(_e64*4, asuint(uint(asint(asuint((_e51 & _e53)) + asuint(((_e51 ^ _e53) >> 1u))))));
            uint _e67 = a;
            int _e68 = int(_e67);
            uint _e69 = b;
            int _e70 = int(_e69);
            uint _e77 = base;
            local_3 = uint((_e77 + 1u));
            uint _e82 = local_3;
            local_33 = _e82;
            uint _e84 = local_33;
            output.Store(_e84*4, asuint(uint(asint(asuint((_e68 | _e70)) - asuint(((_e68 ^ _e70) >> 1u))))));
            uint _e86 = a;
            uint _e87 = b;
            uint _e93 = base;
            local_4 = uint((_e93 + 2u));
            uint _e98 = local_4;
            local_34 = _e98;
            uint _e100 = local_34;
            output.Store(_e100*4, asuint(((_e86 & _e87) + ((_e86 ^ _e87) >> 1u))));
            uint _e102 = a;
            uint _e103 = b;
            uint _e109 = base;
            local_5 = uint((_e109 + 3u));
            uint _e114 = local_5;
            local_35 = _e114;
            uint _e116 = local_35;
            output.Store(_e116*4, asuint(((_e102 | _e103) - ((_e102 ^ _e103) >> 1u))));
        }
    }
    uint base_1 = ((4u + (count * 4u)) + (lane * 10u));
    value = 1u;
    scale = ZeroValueuint();
    scale = 3u;
    uint _e134 = value;
    value = (_e134 + uint(int(1)));
    uint _e138 = scale;
    local_6 = (_e134 * _e138);
    uint _e141 = local_6;
    int _e142 = int(_e141);
    scale_1 = ZeroValueuint();
    scale_1 = 5u;
    uint _e147 = value;
    value = (_e147 + uint(int(1)));
    uint _e151 = scale_1;
    local_7 = (_e147 * _e151);
    uint _e154 = local_7;
    int _e155 = int(_e154);
    output.Store(base_1*4, asuint(uint(asint(asuint((_e142 & _e155)) + asuint(((_e142 ^ _e155) >> 1u))))));
    scale_2 = ZeroValueuint();
    scale_2 = 3u;
    uint _e168 = value;
    value = (_e168 + uint(int(1)));
    uint _e172 = scale_2;
    local_9 = (_e168 * _e172);
    uint _e175 = local_9;
    int _e176 = int(_e175);
    scale_3 = ZeroValueuint();
    scale_3 = 5u;
    uint _e181 = value;
    value = (_e181 + uint(int(1)));
    uint _e185 = scale_3;
    local_10 = (_e181 * _e185);
    uint _e188 = local_10;
    int _e189 = int(_e188);
    local_8 = uint((base_1 + 1u));
    uint _e200 = local_8;
    output.Store(_e200*4, asuint(uint(asint(asuint((_e176 | _e189)) - asuint(((_e176 ^ _e189) >> 1u))))));
    scale_4 = ZeroValueuint();
    scale_4 = 3u;
    uint _e206 = value;
    value = (_e206 + uint(int(1)));
    uint _e210 = scale_4;
    local_12 = (_e206 * _e210);
    uint _e213 = local_12;
    scale_5 = ZeroValueuint();
    scale_5 = 5u;
    uint _e218 = value;
    value = (_e218 + uint(int(1)));
    uint _e222 = scale_5;
    local_13 = (_e218 * _e222);
    uint _e225 = local_13;
    local_11 = uint((base_1 + 2u));
    uint _e235 = local_11;
    output.Store(_e235*4, asuint(((_e213 & _e225) + ((_e213 ^ _e225) >> 1u))));
    scale_6 = ZeroValueuint();
    scale_6 = 3u;
    uint _e241 = value;
    value = (_e241 + uint(int(1)));
    uint _e245 = scale_6;
    local_15 = (_e241 * _e245);
    uint _e248 = local_15;
    scale_7 = ZeroValueuint();
    scale_7 = 5u;
    uint _e253 = value;
    value = (_e253 + uint(int(1)));
    uint _e257 = scale_7;
    local_16 = (_e253 * _e257);
    uint _e260 = local_16;
    local_14 = uint((base_1 + 3u));
    uint _e270 = local_14;
    output.Store(_e270*4, asuint(((_e248 | _e260) - ((_e248 ^ _e260) >> 1u))));
    if (((lane & 1u) == 0u)) {
        uint _e276 = value;
        value = (_e276 + uint(int(1)));
        uint _e280 = value;
        value = (_e280 + uint(int(1)));
        local_17 = ((_e276 & _e280) + ((_e276 ^ _e280) >> 1u));
    } else {
        local_17 = 0u;
    }
    uint _e292 = value;
    local_18 = uint((base_1 + 4u));
    uint _e297 = local_18;
    output.Store(_e297*4, asuint(_e292));
    local_19 = false;
    if (false) {
        uint _e301 = value;
        value = (_e301 + uint(int(1)));
        int _e305 = int(_e301);
        uint _e306 = value;
        value = (_e306 + uint(int(1)));
        int _e310 = int(_e306);
        local_19 = (asint(asuint((_e305 & _e310)) + asuint(((_e305 ^ _e310) >> 1u))) != int(0));
    }
    local_20 = true;
    if (true) {
    } else {
        uint _e320 = value;
        value = (_e320 + uint(int(1)));
        uint _e324 = value;
        value = (_e324 + uint(int(1)));
        local_20 = (((_e320 | _e324) - ((_e320 ^ _e324) >> 1u)) != 0u);
    }
    uint _e335 = value;
    value = (_e335 + uint(int(1)));
    uint _e339 = value;
    value = (_e339 + uint(int(1)));
    uint _e343 = value;
    local_21 = uint((base_1 + 5u));
    uint _e348 = local_21;
    output.Store(_e348*4, asuint(_e343));
    index = 1u;
    uint _e352 = index;
    index = (_e352 + uint(int(1)));
    uint _e357 = asuint(input.Load(_e352*4));
    uint _e358 = index;
    index = (_e358 + uint(int(1)));
    uint _e363 = asuint(input.Load(_e358*4));
    local_22 = uint((base_1 + 6u));
    uint _e373 = local_22;
    output.Store(_e373*4, asuint(((_e357 & _e363) + ((_e357 ^ _e363) >> 1u))));
    uint _e375 = index;
    local_23 = uint((base_1 + 7u));
    uint _e380 = local_23;
    output.Store(_e380*4, asuint(_e375));
    int _e383 = naga_neg(int(1));
    local_24 = uint((base_1 + 8u));
    uint _e395 = local_24;
    output.Store(_e395*4, asuint(uint(asint(asuint((_e383 & int(0))) + asuint(((_e383 ^ int(0)) >> 1u))))));
    int _e398 = naga_neg(int(1));
    local_25 = uint((base_1 + 9u));
    uint _e410 = local_25;
    output.Store(_e410*4, asuint(uint(asint(asuint((_e398 | int(0))) - asuint(((_e398 ^ int(0)) >> 1u))))));
}
