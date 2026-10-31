RWByteAddressBuffer out_ : register(u0);

int count(uint value)
{
    return int(countbits(value));
}

int scan(int value_1)
{
    return asint(asuint(asint(firstbitlow(value_1))) + asuint(int(1)));
}

int _clz(int first, int second)
{
    return asint(asuint(first) + asuint(second));
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

[numthreads(1, 1, 1)]
void integer_intrinsics()
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
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
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;

    int _e1 = int(true);
    local = uint(int(0));
    uint _e8 = local;
    local_30 = uint(_e8);
    uint _e11 = local_30;
    out_.Store(_e11*4, asuint(uint((_e1 < 0 ? 0 : 31 - asint(firstbithigh(_e1))))));
    local_1 = uint(int(1));
    uint _e19 = local_1;
    local_31 = uint(_e19);
    uint _e22 = local_31;
    out_.Store(_e22*4, asuint(uint((int(8) < 0 ? 0 : 31 - asint(firstbithigh(int(8)))))));
    int _e25 = int(2147483648u);
    local_2 = uint(int(2));
    uint _e31 = local_2;
    local_32 = uint(_e31);
    uint _e34 = local_32;
    out_.Store(_e34*4, asuint(uint((_e25 < 0 ? 0 : 31 - asint(firstbithigh(_e25))))));
    int _e37 = naga_f2i32(8.75);
    local_3 = uint(int(3));
    uint _e43 = local_3;
    local_33 = uint(_e43);
    uint _e46 = local_33;
    out_.Store(_e46*4, asuint(uint((_e37 < 0 ? 0 : 31 - asint(firstbithigh(_e37))))));
    local_4 = uint(int(4));
    uint _e57 = local_4;
    local_34 = uint(_e57);
    uint _e60 = local_34;
    out_.Store(_e60*4, asuint(uint(asint(asuint(asint(firstbitlow(int(true)))) + asuint(int(1))))));
    local_5 = uint(int(5));
    uint _e70 = local_5;
    local_35 = uint(_e70);
    uint _e73 = local_35;
    out_.Store(_e73*4, asuint(uint(asint(asuint(asint(firstbitlow(int(8)))) + asuint(int(1))))));
    local_6 = uint(int(6));
    uint _e84 = local_6;
    local_36 = uint(_e84);
    uint _e87 = local_36;
    out_.Store(_e87*4, asuint(uint(asint(asuint(asint(firstbitlow(int(2147483648u)))) + asuint(int(1))))));
    local_7 = uint(int(7));
    uint _e98 = local_7;
    local_37 = uint(_e98);
    uint _e101 = local_37;
    out_.Store(_e101*4, asuint(uint(asint(asuint(asint(firstbitlow(naga_f2i32(8.75)))) + asuint(int(1))))));
    local_8 = uint(int(8));
    uint _e111 = local_8;
    local_38 = uint(_e111);
    uint _e114 = local_38;
    out_.Store(_e114*4, asuint(uint(int(countbits(uint(true))))));
    local_9 = uint(int(9));
    uint _e125 = local_9;
    local_39 = uint(_e125);
    uint _e128 = local_39;
    out_.Store(_e128*4, asuint(uint(int(countbits(uint(naga_neg(int(1))))))));
    local_10 = uint(int(10));
    uint _e137 = local_10;
    local_40 = uint(_e137);
    uint _e140 = local_40;
    out_.Store(_e140*4, asuint(uint(int(countbits(2147483649u)))));
    local_11 = uint(int(11));
    uint _e150 = local_11;
    local_41 = uint(_e150);
    uint _e153 = local_41;
    out_.Store(_e153*4, asuint(uint(int(countbits(naga_f2u32(3.75))))));
    local_12 = uint(int(12));
    uint _e161 = local_12;
    local_42 = uint(_e161);
    uint _e164 = local_42;
    out_.Store(_e164*4, asuint(reversebits(uint(true))));
    local_13 = uint(int(13));
    uint _e173 = local_13;
    local_43 = uint(_e173);
    uint _e176 = local_43;
    out_.Store(_e176*4, asuint(reversebits(uint(naga_neg(int(1))))));
    local_14 = uint(int(14));
    uint _e183 = local_14;
    local_44 = uint(_e183);
    uint _e186 = local_44;
    out_.Store(_e186*4, asuint(reversebits(19088743u)));
    local_15 = uint(int(15));
    uint _e194 = local_15;
    local_45 = uint(_e194);
    uint _e197 = local_45;
    out_.Store(_e197*4, asuint(reversebits(naga_f2u32(2.75))));
    const int _e200 = count(2147483649u);
    local_16 = uint(int(16));
    uint _e205 = local_16;
    local_46 = uint(_e205);
    uint _e208 = local_46;
    out_.Store(_e208*4, asuint(uint(_e200)));
    const int _e212 = scan(int(2147483648u));
    local_17 = uint(int(17));
    uint _e217 = local_17;
    local_47 = uint(_e217);
    uint _e220 = local_47;
    out_.Store(_e220*4, asuint(uint(_e212)));
    local_18 = uint(int(18));
    uint _e228 = local_18;
    local_48 = uint(_e228);
    uint _e231 = local_48;
    out_.Store(_e231*4, asuint(uint((int(0) < 0 ? 0 : 31 - asint(firstbithigh(int(0)))))));
    local_19 = uint(int(19));
    uint _e241 = local_19;
    local_49 = uint(_e241);
    uint _e244 = local_49;
    out_.Store(_e244*4, asuint(uint(asint(asuint(asint(firstbitlow(int(0)))) + asuint(int(1))))));
    local_20 = uint(int(20));
    uint _e253 = local_20;
    local_50 = uint(_e253);
    uint _e256 = local_50;
    out_.Store(_e256*4, asuint(uint(int(countbits(4294967295u)))));
    local_21 = uint(int(21));
    uint _e263 = local_21;
    local_51 = uint(_e263);
    uint _e266 = local_51;
    out_.Store(_e266*4, asuint(reversebits(0u)));
    local_22 = uint(int(22));
    uint _e273 = local_22;
    local_52 = uint(_e273);
    uint _e276 = local_52;
    out_.Store(_e276*4, asuint(reversebits(1u)));
    local_23 = uint(int(23));
    uint _e283 = local_23;
    local_53 = uint(_e283);
    uint _e286 = local_53;
    out_.Store(_e286*4, asuint(reversebits(2147483648u)));
    int _e289 = naga_neg(int(2));
    local_24 = uint(int(24));
    uint _e295 = local_24;
    local_54 = uint(_e295);
    uint _e298 = local_54;
    out_.Store(_e298*4, asuint(uint((_e289 < 0 ? 0 : 31 - asint(firstbithigh(_e289))))));
    local_25 = uint(int(25));
    uint _e309 = local_25;
    local_55 = uint(_e309);
    uint _e312 = local_55;
    out_.Store(_e312*4, asuint(uint(asint(asuint(asint(firstbitlow(naga_neg(int(2))))) + asuint(int(1))))));
    local_26 = uint(int(26));
    uint _e321 = local_26;
    local_56 = uint(_e321);
    uint _e324 = local_56;
    out_.Store(_e324*4, asuint(uint(int(countbits(2863311530u)))));
    local_27 = uint(int(27));
    uint _e331 = local_27;
    local_57 = uint(_e331);
    uint _e334 = local_57;
    out_.Store(_e334*4, asuint(reversebits(2863311530u)));
    const int _e338 = _clz(int(3), int(4));
    local_28 = uint(int(28));
    uint _e343 = local_28;
    local_58 = uint(_e343);
    uint _e346 = local_58;
    out_.Store(_e346*4, asuint(uint(_e338)));
    local_29 = uint(int(29));
    uint _e359 = local_29;
    local_59 = uint(_e359);
    uint _e362 = local_59;
    out_.Store(_e362*4, asuint(uint((asint(asuint(int(countbits(3u))) - asuint(int(3))) < int(0)))));
}
