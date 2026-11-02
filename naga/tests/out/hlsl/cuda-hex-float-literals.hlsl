static const float HexScale = 0.75;

RWByteAddressBuffer output : register(u0);

float identity(float value_1)
{
    return value_1;
}

float ZeroValuefloat() {
    return (float)0;
}

[numthreads(1, 1, 1)]
void hex_float_literals()
{
    uint counter = (uint)0;
    float value = (float)0;

    counter = 0u;
    output.Store(uint(int(0))*4, asuint(asuint(0.0)));
    output.Store(uint(int(1))*4, asuint(asuint(-(0.0))));
    output.Store(uint(int(2))*4, asuint(asuint(1.0)));
    output.Store(uint(int(3))*4, asuint(asuint(2.0)));
    output.Store(uint(int(4))*4, asuint(asuint(1.0)));
    output.Store(uint(int(5))*4, asuint(asuint(0.5)));
    output.Store(uint(int(6))*4, asuint(asuint(3.0)));
    output.Store(uint(int(7))*4, asuint(asuint(-(5.0))));
    output.Store(uint(int(8))*4, asuint(asuint(1.1754944e-38)));
    output.Store(uint(int(9))*4, asuint(asuint(1e-45)));
    output.Store(uint(int(10))*4, asuint(asuint(1.1754942e-38)));
    output.Store(uint(int(11))*4, asuint(asuint(1.1754944e-38)));
    output.Store(uint(int(12))*4, asuint(asuint(0.0)));
    output.Store(uint(int(13))*4, asuint(asuint(-(0.0))));
    output.Store(uint(int(14))*4, asuint(asuint(1e-45)));
    output.Store(uint(int(15))*4, asuint(asuint(0.0)));
    output.Store(uint(int(16))*4, asuint(asuint(3e-45)));
    output.Store(uint(int(17))*4, asuint(asuint(3e-45)));
    output.Store(uint(int(18))*4, asuint(asuint(6e-45)));
    output.Store(uint(int(19))*4, asuint(asuint(1.0)));
    output.Store(uint(int(20))*4, asuint(asuint(1.0000002)));
    output.Store(uint(int(21))*4, asuint(asuint(1.0000001)));
    output.Store(uint(int(22))*4, asuint(asuint(1.0)));
    output.Store(uint(int(23))*4, asuint(asuint(3.4028235e38)));
    output.Store(uint(int(24))*4, asuint(asuint(-(3.4028235e38))));
    output.Store(uint(int(25))*4, asuint(asuint(3.4028233e38)));
    output.Store(uint(int(26))*4, asuint(asuint(3.4028235e38)));
    output.Store(uint(int(27))*4, asuint(asuint(1e-45)));
    output.Store(uint(int(28))*4, asuint(asuint(-(1e-45))));
    output.Store(uint(int(29))*4, asuint(asuint(0.0)));
    output.Store(uint(int(30))*4, asuint(asuint(72.8125)));
    output.Store(uint(int(31))*4, asuint(asuint(0.25)));
    output.Store(uint(int(32))*4, asuint(asuint(6.0)));
    output.Store(uint(int(33))*4, asuint(asuint(4.0)));
    output.Store(uint(int(34))*4, asuint(asuint(HexScale)));
    const float _e184 = identity(9.0);
    output.Store(uint(int(35))*4, asuint(asuint(_e184)));
    value = ZeroValuefloat();
    value = 3.0;
    uint _e193 = counter;
    counter = (_e193 + uint(int(1)));
    float _e197 = value;
    output.Store(uint(int(36))*4, asuint(asuint(_e197)));
    output.Store(uint(int(37))*4, asuint(asuint((0.25 + 0.5))));
    output.Store(uint(int(38))*4, asuint(asuint(0.0)));
    uint _e214 = counter;
    output.Store(uint(int(39))*4, asuint(_e214));
}
