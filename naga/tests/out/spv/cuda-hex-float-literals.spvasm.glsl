#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _8_7
{
    uint _m0[];
} _7;

float _12(float _11)
{
    return _11;
}

void main()
{
    uint _83 = 0u;
    float _86 = 0.0;
    _83 = 0u;
    _7._m0[uint(0)] = floatBitsToUint(0.0);
    float _94 = -0.0;
    _7._m0[uint(1)] = floatBitsToUint(_94);
    _7._m0[uint(2)] = floatBitsToUint(1.0);
    _7._m0[uint(3)] = floatBitsToUint(2.0);
    _7._m0[uint(4)] = floatBitsToUint(1.0);
    _7._m0[uint(5)] = floatBitsToUint(0.5);
    _7._m0[uint(6)] = floatBitsToUint(3.0);
    float _113 = -5.0;
    _7._m0[uint(7)] = floatBitsToUint(_113);
    _7._m0[uint(8)] = floatBitsToUint(1.1754943508222875079687365372222e-38);
    _7._m0[uint(9)] = floatBitsToUint(1.4012984643248170709237295832899e-45);
    _7._m0[uint(10)] = floatBitsToUint(1.1754942106924410754870294448493e-38);
    _7._m0[uint(11)] = floatBitsToUint(1.1754943508222875079687365372222e-38);
    _7._m0[uint(12)] = floatBitsToUint(0.0);
    float _132 = -0.0;
    _7._m0[uint(13)] = floatBitsToUint(_132);
    _7._m0[uint(14)] = floatBitsToUint(1.4012984643248170709237295832899e-45);
    _7._m0[uint(15)] = floatBitsToUint(0.0);
    _7._m0[uint(16)] = floatBitsToUint(2.8025969286496341418474591665798e-45);
    _7._m0[uint(17)] = floatBitsToUint(2.8025969286496341418474591665798e-45);
    _7._m0[uint(18)] = floatBitsToUint(5.6051938572992682836949183331597e-45);
    _7._m0[uint(19)] = floatBitsToUint(1.0);
    _7._m0[uint(20)] = floatBitsToUint(1.0000002384185791015625);
    _7._m0[uint(21)] = floatBitsToUint(1.00000011920928955078125);
    _7._m0[uint(22)] = floatBitsToUint(1.0);
    _7._m0[uint(23)] = floatBitsToUint(3.4028234663852885981170418348452e+38);
    float _166 = -3.4028234663852885981170418348452e+38;
    _7._m0[uint(24)] = floatBitsToUint(_166);
    _7._m0[uint(25)] = floatBitsToUint(3.4028232635611925616003375953727e+38);
    _7._m0[uint(26)] = floatBitsToUint(3.4028234663852885981170418348452e+38);
    _7._m0[uint(27)] = floatBitsToUint(1.4012984643248170709237295832899e-45);
    float _179 = -1.4012984643248170709237295832899e-45;
    _7._m0[uint(28)] = floatBitsToUint(_179);
    _7._m0[uint(29)] = floatBitsToUint(0.0);
    _7._m0[uint(30)] = floatBitsToUint(72.8125);
    _7._m0[uint(31)] = floatBitsToUint(0.25);
    _7._m0[uint(32)] = floatBitsToUint(6.0);
    _7._m0[uint(33)] = floatBitsToUint(4.0);
    _7._m0[uint(34)] = floatBitsToUint(0.75);
    _7._m0[uint(35)] = floatBitsToUint(_12(9.0));
    _86 = 0.0;
    _86 = 3.0;
    _83++;
    _7._m0[uint(36)] = floatBitsToUint(_86);
    float _212 = 0.25 + 0.5;
    _7._m0[uint(37)] = floatBitsToUint(_212);
    _7._m0[uint(38)] = floatBitsToUint(0.0);
    _7._m0[uint(39)] = _83;
}

