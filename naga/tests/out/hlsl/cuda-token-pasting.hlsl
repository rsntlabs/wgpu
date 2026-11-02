RWByteAddressBuffer out_ : register(u0);

uint adjust(uint value_3)
{
    return (value_3 + 3u);
}

uint ZeroValueuint() {
    return (uint)0;
}

[numthreads(1, 1, 1)]
void token_pasting()
{
    uint typed_value = (uint)0;
    uint local_value = (uint)0;
    uint SOURCE_NAME_tail = (uint)0;
    uint expanded_tail = (uint)0;
    uint local = (uint)0;
    uint updated = (uint)0;
    uint value = (uint)0;
    uint counter = (uint)0;
    uint value_1 = (uint)0;
    uint value_2 = (uint)0;

    typed_value = 7u;
    local_value = 11u;
    SOURCE_NAME_tail = 13u;
    expanded_tail = 17u;
    uint _e8 = typed_value;
    out_.Store(uint(int(0))*4, asuint(_e8));
    uint _e13 = local_value;
    out_.Store(uint(int(1))*4, asuint(_e13));
    uint _e17 = SOURCE_NAME_tail;
    out_.Store(uint(int(2))*4, asuint(_e17));
    uint _e21 = expanded_tail;
    out_.Store(uint(int(3))*4, asuint(_e21));
    out_.Store(uint(int(4))*4, asuint(23u));
    out_.Store(uint(int(5))*4, asuint(42u));
    out_.Store(uint(int(6))*4, asuint(asuint(1.5)));
    out_.Store(uint(int(7))*4, asuint(asuint(4.0)));
    if ((3u <= 4u)) {
        local = 1u;
    } else {
        local = 0u;
    }
    uint _e51 = local;
    out_.Store(uint(int(8))*4, asuint(_e51));
    out_.Store(uint(int(9))*4, asuint((32u >> 2u)));
    updated = 9u;
    uint _e63 = updated;
    updated = (_e63 + 5u);
    uint _e66 = updated;
    out_.Store(uint(int(10))*4, asuint(_e66));
    out_.Store(uint(int(11))*4, asuint(uint(int(63))));
    out_.Store(uint(int(12))*4, asuint(29u));
    const uint _e80 = adjust(5u);
    out_.Store(uint(int(13))*4, asuint(_e80));
    out_.Store(uint(int(14))*4, asuint(19u));
    out_.Store(uint(int(15))*4, asuint(21u));
    out_.Store(uint(int(16))*4, asuint((4u + 5u)));
    out_.Store(uint(int(17))*4, asuint(23u));
    value = 10u;
    uint _e104 = value;
    out_.Store(uint(int(18))*4, asuint(((3u + _e104) + 2u)));
    out_.Store(uint(int(19))*4, asuint((2u + 3u)));
    counter = 0u;
    uint _e120 = counter;
    counter = (_e120 + uint(int(1)));
    value_1 = ZeroValueuint();
    value_1 = 7u;
    uint _e128 = counter;
    counter = (_e128 + 1u);
    uint _e131 = value_1;
    out_.Store(uint(int(20))*4, asuint(_e131));
    uint _e135 = counter;
    out_.Store(uint(int(21))*4, asuint(_e135));
    uint _e139 = counter;
    counter = (_e139 + uint(int(1)));
    value_2 = ZeroValueuint();
    value_2 = 9u;
    uint _e147 = counter;
    counter = (_e147 + 1u);
    uint _e150 = value_2;
    out_.Store(uint(int(22))*4, asuint(_e150));
    uint _e154 = counter;
    out_.Store(uint(int(23))*4, asuint(_e154));
}
