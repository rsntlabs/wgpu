struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

cbuffer enabled_1 : register(b0) { type_3 enabled_1; }
cbuffer frozen : register(b1) { type_3 frozen; }
RWByteAddressBuffer output : register(u2);

int flag_overload(bool value)
{
    int local_8 = (int)0;

    if (value) {
        local_8 = int(31);
    } else {
        local_8 = int(17);
    }
    int _e6 = local_8;
    return _e6;
}

int ZeroValueint() {
    return (int)0;
}

[numthreads(4, 1, 1)]
void boolean_parameters(uint3 threadIdx : SV_GroupThreadID)
{
    bool enabled = (bool)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    int local_7 = (int)0;

    uint _e3 = enabled_1.value;
    enabled = ((_e3 & 255u) != 0u);
    uint _e11 = frozen.value;
    bool frozen_1 = ((_e11 & 255u) != 0u);
    uint index = (4u + (threadIdx.x * 8u));
    bool original = enabled;
    bool _e22 = enabled;
    output.Store(index*4, asuint(uint(_e22)));
    bool _e26 = enabled;
    const int _e27 = flag_overload(_e26);
    local = uint((index + 1u));
    uint _e33 = local;
    output.Store(_e33*4, asuint(uint(_e27)));
    bool _e35 = enabled;
    enabled = !(_e35);
    bool _e37 = enabled;
    local_1 = uint((index + 2u));
    uint _e43 = local_1;
    output.Store(_e43*4, asuint(uint(_e37)));
    bool _e45 = enabled;
    const int _e46 = flag_overload(_e45);
    local_2 = uint((index + 3u));
    uint _e52 = local_2;
    output.Store(_e52*4, asuint(uint(_e46)));
    local_3 = uint((index + 4u));
    uint _e59 = local_3;
    output.Store(_e59*4, asuint(uint(frozen_1)));
    local_7 = ZeroValueint();
    if (frozen_1) {
        local_7 = int(7);
    } else {
        local_7 = int(9);
    }
    int _e68 = local_7;
    local_4 = uint((index + 5u));
    uint _e74 = local_4;
    output.Store(_e74*4, asuint(uint(_e68)));
    const int _e76 = flag_overload(original);
    local_5 = uint((index + 6u));
    uint _e82 = local_5;
    output.Store(_e82*4, asuint(uint(_e76)));
    bool _e84 = enabled;
    local_6 = uint((index + 7u));
    uint _e93 = local_6;
    output.Store(_e93*4, asuint(uint((int(_e84) != int(frozen_1)))));
}
