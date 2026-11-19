struct type_4 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer count : register(b2) { type_4 count; }

int forward(int value)
{
    return value;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(4, 1, 1)]
void convert_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint counter = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    int local_4 = (int)0;
    int local_5 = (int)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    int local_11 = (int)0;
    uint local_12 = (uint)0;
    int local_13 = (int)0;

    uint count_1 = count.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 8u));
    int value_1 = asint(input.Load(index*4));
    counter = 0u;
    uint _e20 = asuint(value_1);
    uint _e22 = (_e20 >> 31u);
    uint _e28 = ((_e20 ^ ((_e22 != 0u) ? 4294967295u : 0u)) + _e22);
    uint _e32 = (31u - (31u - firstbithigh((_e28 | 1u))));
    uint _e34 = min(_e32, 23u);
    output.Store(base*4, asuint(asuint(asfloat(((_e28 != 0u) ? ((_e22 << 31u) | (((_e32 + 127u) << 23u) | (((_e28 << (23u - _e34)) >> (_e32 - _e34)) & 8388607u))) : 0u)))));
    const int _e53 = forward(value_1);
    uint _e54 = asuint(_e53);
    uint _e56 = (_e54 >> 31u);
    uint _e62 = ((_e54 ^ ((_e56 != 0u) ? 4294967295u : 0u)) + _e56);
    uint _e66 = (31u - (31u - firstbithigh((_e62 | 1u))));
    uint _e68 = min(_e66, 23u);
    local = uint((base + 1u));
    uint _e89 = local;
    output.Store(_e89*4, asuint(asuint(asfloat(((_e62 != 0u) ? ((_e56 << 31u) | (((_e66 + 127u) << 23u) | (((_e62 << (23u - _e68)) >> (_e66 - _e68)) & 8388607u))) : 0u)))));
    uint _e91 = counter;
    counter = (_e91 + uint(int(1)));
    uint _e95 = asuint(value_1);
    uint _e97 = (_e95 >> 31u);
    uint _e103 = ((_e95 ^ ((_e97 != 0u) ? 4294967295u : 0u)) + _e97);
    uint _e107 = (31u - (31u - firstbithigh((_e103 | 1u))));
    uint _e109 = min(_e107, 23u);
    local_1 = uint((base + 2u));
    uint _e130 = local_1;
    output.Store(_e130*4, asuint(asuint(asfloat(((_e103 != 0u) ? ((_e97 << 31u) | (((_e107 + 127u) << 23u) | (((_e103 << (23u - _e109)) >> (_e107 - _e109)) & 8388607u))) : 0u)))));
    uint _e132 = counter;
    local_2 = uint((base + 3u));
    uint _e137 = local_2;
    output.Store(_e137*4, asuint(_e132));
    if (((index & 1u) != 0u)) {
        uint _e143 = counter;
        local_10 = _e143;
        uint _e145 = local_10;
        counter = (_e145 + uint(int(1)));
        local_11 = value_1;
        int _e150 = local_11;
        local_4 = _e150;
        int _e152 = local_4;
        uint _e153 = asuint(_e152);
        uint _e155 = (_e153 >> 31u);
        uint _e161 = ((_e153 ^ ((_e155 != 0u) ? 4294967295u : 0u)) + _e155);
        uint _e165 = (31u - (31u - firstbithigh((_e161 | 1u))));
        uint _e167 = min(_e165, 23u);
        local_6 = asuint(asfloat(((_e161 != 0u) ? ((_e155 << 31u) | (((_e165 + 127u) << 23u) | (((_e161 << (23u - _e167)) >> (_e165 - _e167)) & 8388607u))) : 0u)));
    } else {
        uint _e185 = counter;
        local_12 = _e185;
        uint _e187 = local_12;
        counter = (_e187 + uint(int(1)));
        local_13 = value_1;
        int _e192 = local_13;
        local_5 = _e192;
        int _e194 = local_5;
        uint _e195 = asuint(_e194);
        uint _e197 = (_e195 >> 31u);
        uint _e203 = ((_e195 ^ ((_e197 != 0u) ? 4294967295u : 0u)) + _e197);
        uint _e207 = (31u - (31u - firstbithigh((_e203 | 1u))));
        uint _e209 = min(_e207, 23u);
        local_6 = asuint(asfloat(((_e203 != 0u) ? ((_e197 << 31u) | (((_e207 + 127u) << 23u) | (((_e203 << (23u - _e209)) >> (_e207 - _e209)) & 8388607u))) : 0u)));
    }
    uint _e228 = local_6;
    local_3 = uint((base + 4u));
    uint _e233 = local_3;
    output.Store(_e233*4, asuint(_e228));
    uint _e235 = counter;
    local_7 = uint((base + 5u));
    uint _e240 = local_7;
    output.Store(_e240*4, asuint(_e235));
    uint _e244 = asuint(int(4294967295u));
    uint _e246 = (_e244 >> 31u);
    uint _e252 = ((_e244 ^ ((_e246 != 0u) ? 4294967295u : 0u)) + _e246);
    uint _e256 = (31u - (31u - firstbithigh((_e252 | 1u))));
    uint _e258 = min(_e256, 23u);
    local_8 = uint((base + 6u));
    uint _e279 = local_8;
    output.Store(_e279*4, asuint(asuint(asfloat(((_e252 != 0u) ? ((_e246 << 31u) | (((_e256 + 127u) << 23u) | (((_e252 << (23u - _e258)) >> (_e256 - _e258)) & 8388607u))) : 0u)))));
    uint _e284 = asuint(naga_f2i32(-(3.5)));
    uint _e286 = (_e284 >> 31u);
    uint _e292 = ((_e284 ^ ((_e286 != 0u) ? 4294967295u : 0u)) + _e286);
    uint _e296 = (31u - (31u - firstbithigh((_e292 | 1u))));
    uint _e298 = min(_e296, 23u);
    local_9 = uint((base + 7u));
    uint _e319 = local_9;
    output.Store(_e319*4, asuint(asuint(asfloat(((_e292 != 0u) ? ((_e286 << 31u) | (((_e296 + 127u) << 23u) | (((_e292 << (23u - _e298)) >> (_e296 - _e298)) & 8388607u))) : 0u)))));
}
