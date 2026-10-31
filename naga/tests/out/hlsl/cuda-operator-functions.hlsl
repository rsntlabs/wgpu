struct Record_cuda_record_0_ {
    int value;
    int history[2];
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer out_ : register(u1);

int2 operator_u002b(int2 value)
{
    int2 value_1 = (int2)0;

    value_1 = value;
    int _e3 = value_1.x;
    int _e5 = value_1.y;
    return int2(_e3, _e5);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

int2 operator_u002d(int2 value_2)
{
    int2 value_3 = (int2)0;

    value_3 = value_2;
    int _e3 = value_3.x;
    int _e6 = value_3.y;
    return int2(naga_neg(_e3), naga_neg(_e6));
}

int2 operator_u007e(int2 value_4)
{
    int2 value_5 = (int2)0;

    value_5 = value_4;
    int _e3 = value_5.x;
    int _e6 = value_5.y;
    return int2(~(_e3), ~(_e6));
}

bool operator_u0021_(int2 value_6)
{
    int2 value_7 = (int2)0;
    bool local_40 = (bool)0;

    value_7 = value_6;
    int _e4 = value_7.x;
    bool _e5 = (_e4 == int(0));
    local_40 = _e5;
    if (_e5) {
        int _e9 = value_7.y;
        local_40 = (_e9 == int(0));
    }
    bool _e11 = local_40;
    return _e11;
}

int operator_u002a(int2 value_8)
{
    int2 value_9 = (int2)0;

    value_9 = value_8;
    int _e4 = value_9.x;
    int _e7 = value_9.y;
    return asint(asuint(asint(asuint(_e4) * asuint(int(10)))) + asuint(_e7));
}

int2 operator_u0026_(int2 value_10)
{
    int2 value_11 = (int2)0;

    value_11 = value_10;
    int _e3 = value_11.y;
    int _e5 = value_11.x;
    return int2(_e3, _e5);
}

int2 operator_u002b_1(int2 left_1, int2 right_1)
{
    int2 left_2 = (int2)0;
    int2 right_2 = (int2)0;

    left_2 = left_1;
    right_2 = right_1;
    int _e6 = left_2.x;
    int _e7 = right_2.x;
    int _e11 = left_2.y;
    int _e12 = right_2.y;
    return int2(asint(asuint(_e6) + asuint(_e7)), asint(asuint(_e11) + asuint(_e12)));
}

int2 operator_u002d_1(int2 left_3, int2 right_3)
{
    int2 left_4 = (int2)0;
    int2 right_4 = (int2)0;

    left_4 = left_3;
    right_4 = right_3;
    int _e6 = left_4.x;
    int _e7 = right_4.x;
    int _e11 = left_4.y;
    int _e12 = right_4.y;
    return int2(asint(asuint(_e6) - asuint(_e7)), asint(asuint(_e11) - asuint(_e12)));
}

int2 operator_u002a_1(int2 left_5, int2 right_5)
{
    int2 left_6 = (int2)0;
    int2 right_6 = (int2)0;

    left_6 = left_5;
    right_6 = right_5;
    int _e6 = left_6.x;
    int _e7 = right_6.x;
    int _e11 = left_6.y;
    int _e12 = right_6.y;
    return int2(asint(asuint(_e6) * asuint(_e7)), asint(asuint(_e11) * asuint(_e12)));
}

int naga_div(int lhs, int rhs) {
    return lhs / (((lhs == int(-2147483647 - 1) & rhs == -1) | (rhs == 0)) ? 1 : rhs);
}

int2 operator_u002f(int2 left_7, int2 right_7)
{
    int2 left_8 = (int2)0;
    int2 right_8 = (int2)0;

    left_8 = left_7;
    right_8 = right_7;
    int _e6 = left_8.x;
    int _e7 = right_8.x;
    int _e11 = left_8.y;
    int _e12 = right_8.y;
    return int2(naga_div(_e6, _e7), naga_div(_e11, _e12));
}

int naga_mod(int lhs, int rhs) {
    int divisor = ((lhs == int(-2147483647 - 1) & rhs == -1) | (rhs == 0)) ? 1 : rhs;
    return lhs - (lhs / divisor) * divisor;
}

int2 operator_u0025_(int2 left_9, int2 right_9)
{
    int2 left_10 = (int2)0;
    int2 right_10 = (int2)0;

    left_10 = left_9;
    right_10 = right_9;
    int _e6 = left_10.x;
    int _e7 = right_10.x;
    int _e11 = left_10.y;
    int _e12 = right_10.y;
    return int2(naga_mod(_e6, _e7), naga_mod(_e11, _e12));
}

int2 operator_u0026_1(int2 left_11, int2 right_11)
{
    int2 left_12 = (int2)0;
    int2 right_12 = (int2)0;

    left_12 = left_11;
    right_12 = right_11;
    int _e6 = left_12.x;
    int _e7 = right_12.x;
    int _e11 = left_12.y;
    int _e12 = right_12.y;
    return int2((_e6 & _e7), (_e11 & _e12));
}

int2 operator_u007c(int2 left_13, int2 right_13)
{
    int2 left_14 = (int2)0;
    int2 right_14 = (int2)0;

    left_14 = left_13;
    right_14 = right_13;
    int _e6 = left_14.x;
    int _e7 = right_14.x;
    int _e11 = left_14.y;
    int _e12 = right_14.y;
    return int2((_e6 | _e7), (_e11 | _e12));
}

int2 operator_u005e(int2 left_15, int2 right_15)
{
    int2 left_16 = (int2)0;
    int2 right_16 = (int2)0;

    left_16 = left_15;
    right_16 = right_15;
    int _e6 = left_16.x;
    int _e7 = right_16.x;
    int _e11 = left_16.y;
    int _e12 = right_16.y;
    return int2((_e6 ^ _e7), (_e11 ^ _e12));
}

int2 operator_(int2 left_17, int2 right_17)
{
    int2 left_18 = (int2)0;
    int2 right_18 = (int2)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;

    left_18 = left_17;
    right_18 = right_17;
    int _e5 = left_18.x;
    int _e7 = right_18.x;
    local_41 = uint(_e7);
    uint _e10 = local_41;
    int _e13 = left_18.y;
    int _e15 = right_18.y;
    local_42 = uint(_e15);
    uint _e18 = local_42;
    return int2((_e5 << _e10), (_e13 << _e18));
}

int2 operator_1(int2 left_19, int2 right_19)
{
    int2 left_20 = (int2)0;
    int2 right_20 = (int2)0;

    left_20 = left_19;
    right_20 = right_19;
    int _e5 = left_20.x;
    int _e7 = right_20.x;
    int _e11 = left_20.y;
    int _e13 = right_20.y;
    return int2((_e5 >> uint(_e7)), (_e11 >> uint(_e13)));
}

Record_cuda_record_0_ operator_u002a_2(Record_cuda_record_0_ value_12)
{
    Record_cuda_record_0_ value_13 = (Record_cuda_record_0_)0;

    value_13 = value_12;
    int _e3 = value_13.value;
    value_13.value = asint(asuint(_e3) + asuint(int(1)));
    Record_cuda_record_0_ _e6 = value_13;
    const Record_cuda_record_0_ record_cuda_record_0_ = _e6;
    return record_cuda_record_0_;
}

int operator_u0026_2(Record_cuda_record_0_ value_14)
{
    Record_cuda_record_0_ value_15 = (Record_cuda_record_0_)0;

    value_15 = value_14;
    int _e3 = value_15.value;
    return _e3;
}

Record_cuda_record_0_ operator_u002d_2(Record_cuda_record_0_ value_16)
{
    Record_cuda_record_0_ value_17 = (Record_cuda_record_0_)0;

    value_17 = value_16;
    int _e4 = value_17.value;
    value_17.value = naga_neg(_e4);
    Record_cuda_record_0_ _e6 = value_17;
    const Record_cuda_record_0_ record_cuda_record_0_1 = _e6;
    return record_cuda_record_0_1;
}

Record_cuda_record_0_ operator_u002a_3(Record_cuda_record_0_ value_18, int factor)
{
    Record_cuda_record_0_ value_19 = (Record_cuda_record_0_)0;

    value_19 = value_18;
    int _e4 = value_19.value;
    value_19.value = asint(asuint(_e4) * asuint(factor));
    int _e9 = value_19.history[int(1)];
    value_19.history[int(1)] = asint(asuint(_e9) + asuint(factor));
    Record_cuda_record_0_ _e11 = value_19;
    const Record_cuda_record_0_ record_cuda_record_0_2 = _e11;
    return record_cuda_record_0_2;
}

[numthreads(2, 1, 1)]
void operator_functions(uint3 threadIdx : SV_GroupThreadID)
{
    int2 left = (int2)0;
    uint local = (uint)0;
    int2 right = (int2)0;
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
    Record_cuda_record_0_ original = (Record_cuda_record_0_)0;
    Record_cuda_record_0_ scaled = (Record_cuda_record_0_)0;
    uint local_27 = (uint)0;
    Record_cuda_record_0_ local_28 = (Record_cuda_record_0_)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    int2 local_38 = (int2)0;
    int2 local_39 = (int2)0;

    uint base = (threadIdx.x * 36u);
    local = uint(threadIdx.x);
    uint _e7 = local;
    int2 _e10 = asint(input.Load2(_e7*8));
    local_39 = _e10;
    int2 _e12 = local_39;
    local_38 = _e12;
    int2 _e14 = local_38;
    left = _e14;
    right = int2(int(3), int(2));
    int2 _e20 = left;
    const int2 _e21 = operator_u002b(_e20);
    local_1 = uint((base + 0u));
    uint _e28 = local_1;
    out_.Store(_e28*4, asuint(uint(_e21.x)));
    int2 _e31 = left;
    const int2 _e32 = operator_u002d(_e31);
    local_2 = uint((base + 1u));
    uint _e39 = local_2;
    out_.Store(_e39*4, asuint(uint(_e32.y)));
    int2 _e41 = left;
    const int2 _e42 = operator_u007e(_e41);
    local_3 = uint((base + 2u));
    uint _e49 = local_3;
    out_.Store(_e49*4, asuint(uint(_e42.x)));
    int2 _e51 = left;
    const bool _e52 = operator_u0021_(_e51);
    local_4 = uint((base + 3u));
    uint _e58 = local_4;
    out_.Store(_e58*4, asuint(uint(_e52)));
    int2 _e60 = left;
    const int _e61 = operator_u002a(_e60);
    local_5 = uint((base + 4u));
    uint _e67 = local_5;
    out_.Store(_e67*4, asuint(uint(_e61)));
    int2 _e69 = left;
    const int2 _e70 = operator_u0026_(_e69);
    local_6 = uint((base + 5u));
    uint _e77 = local_6;
    out_.Store(_e77*4, asuint(uint(_e70.x)));
    int2 _e79 = left;
    int2 _e80 = right;
    const int2 _e81 = operator_u002b_1(_e79, _e80);
    local_7 = uint((base + 6u));
    uint _e88 = local_7;
    out_.Store(_e88*4, asuint(uint(_e81.x)));
    int2 _e90 = left;
    int2 _e91 = right;
    const int2 _e92 = operator_u002d_1(_e90, _e91);
    local_8 = uint((base + 7u));
    uint _e99 = local_8;
    out_.Store(_e99*4, asuint(uint(_e92.y)));
    int2 _e101 = left;
    int2 _e102 = right;
    const int2 _e103 = operator_u002a_1(_e101, _e102);
    local_9 = uint((base + 8u));
    uint _e110 = local_9;
    out_.Store(_e110*4, asuint(uint(_e103.x)));
    int2 _e112 = left;
    int2 _e113 = right;
    const int2 _e114 = operator_u002f(_e112, _e113);
    local_10 = uint((base + 9u));
    uint _e121 = local_10;
    out_.Store(_e121*4, asuint(uint(_e114.y)));
    int2 _e123 = left;
    int2 _e124 = right;
    const int2 _e125 = operator_u0025_(_e123, _e124);
    local_11 = uint((base + 10u));
    uint _e132 = local_11;
    out_.Store(_e132*4, asuint(uint(_e125.y)));
    int2 _e134 = left;
    int2 _e135 = right;
    const int2 _e136 = operator_u0026_1(_e134, _e135);
    local_12 = uint((base + 11u));
    uint _e143 = local_12;
    out_.Store(_e143*4, asuint(uint(_e136.x)));
    int2 _e145 = left;
    int2 _e146 = right;
    const int2 _e147 = operator_u007c(_e145, _e146);
    local_13 = uint((base + 12u));
    uint _e154 = local_13;
    out_.Store(_e154*4, asuint(uint(_e147.y)));
    int2 _e156 = left;
    int2 _e157 = right;
    const int2 _e158 = operator_u005e(_e156, _e157);
    local_14 = uint((base + 13u));
    uint _e165 = local_14;
    out_.Store(_e165*4, asuint(uint(_e158.x)));
    int2 _e167 = left;
    int2 _e168 = right;
    const int2 _e169 = operator_(_e167, _e168);
    local_15 = uint((base + 14u));
    uint _e176 = local_15;
    out_.Store(_e176*4, asuint(uint(_e169.x)));
    int2 _e178 = left;
    int2 _e179 = right;
    const int2 _e180 = operator_1(_e178, _e179);
    local_16 = uint((base + 15u));
    uint _e187 = local_16;
    out_.Store(_e187*4, asuint(uint(_e180.y)));
    int2 _e189 = left;
    const int2 _e190 = operator_u002b(_e189);
    local_17 = uint((base + 16u));
    uint _e197 = local_17;
    out_.Store(_e197*4, asuint(uint(_e190.y)));
    int2 _e199 = left;
    int2 _e200 = right;
    const int2 _e201 = operator_u002d_1(_e199, _e200);
    local_18 = uint((base + 17u));
    uint _e208 = local_18;
    out_.Store(_e208*4, asuint(uint(_e201.x)));
    int2 _e210 = left;
    const int _e211 = operator_u002a(_e210);
    local_19 = uint((base + 18u));
    uint _e217 = local_19;
    out_.Store(_e217*4, asuint(uint(_e211)));
    int2 _e219 = left;
    int2 _e220 = right;
    const int2 _e221 = operator_u0026_1(_e219, _e220);
    local_20 = uint((base + 19u));
    uint _e228 = local_20;
    out_.Store(_e228*4, asuint(uint(_e221.y)));
    int2 _e230 = left;
    const int2 _e231 = operator_u0026_(_e230);
    const int _e232 = operator_u002a(_e231);
    local_21 = uint((base + 20u));
    uint _e238 = local_21;
    out_.Store(_e238*4, asuint(uint(_e232)));
    int2 _e240 = left;
    const int2 _e241 = operator_u0026_(_e240);
    const int2 _e242 = operator_u0026_(_e241);
    local_22 = uint((base + 21u));
    uint _e249 = local_22;
    out_.Store(_e249*4, asuint(uint(_e242.x)));
    int2 _e251 = left;
    int2 _e252 = right;
    int2 _e253 = right;
    const int2 _e254 = operator_u002a_1(_e252, _e253);
    const int2 _e255 = operator_u002b_1(_e251, _e254);
    local_23 = uint((base + 22u));
    uint _e262 = local_23;
    out_.Store(_e262*4, asuint(uint(_e255.x)));
    int2 _e264 = left;
    int2 _e265 = right;
    const int2 _e269 = operator_u002b_1(_e265, int2(int(1), int(1)));
    const int2 _e270 = operator_(_e264, _e269);
    local_24 = uint((base + 23u));
    uint _e277 = local_24;
    out_.Store(_e277*4, asuint(uint(_e270.x)));
    int2 _e279 = left;
    int2 _e280 = right;
    const int2 _e284 = operator_u0026_1(_e280, int2(int(1), int(1)));
    const int2 _e285 = operator_u007c(_e279, _e284);
    local_25 = uint((base + 24u));
    uint _e292 = local_25;
    out_.Store(_e292*4, asuint(uint(_e285.y)));
    int2 _e294 = left;
    int2 _e295 = right;
    const int2 _e296 = operator_u002d_1(_e294, _e295);
    int2 _e297 = right;
    const int2 _e298 = operator_u002d_1(_e296, _e297);
    local_26 = uint((base + 25u));
    uint _e305 = local_26;
    out_.Store(_e305*4, asuint(uint(_e298.x)));
    original.value = int(9);
    original.history[0] = int(1);
    original.history[1] = int(2);
    Record_cuda_record_0_ _e315 = original;
    const Record_cuda_record_0_ _e317 = operator_u002a_3(_e315, int(3));
    scaled = _e317;
    local_28.value = int(9);
    local_28.history[0] = int(1);
    local_28.history[1] = int(2);
    Record_cuda_record_0_ _e327 = local_28;
    const int _e328 = operator_u0026_2(_e327);
    local_27 = uint((base + 26u));
    uint _e334 = local_27;
    out_.Store(_e334*4, asuint(uint(_e328)));
    Record_cuda_record_0_ _e336 = original;
    const Record_cuda_record_0_ _e337 = operator_u002a_2(_e336);
    const int _e338 = operator_u0026_2(_e337);
    local_29 = uint((base + 27u));
    uint _e344 = local_29;
    out_.Store(_e344*4, asuint(uint(_e338)));
    int _e347 = scaled.value;
    local_30 = uint((base + 28u));
    uint _e353 = local_30;
    out_.Store(_e353*4, asuint(uint(_e347)));
    int _e358 = scaled.history[int(1)];
    local_31 = uint((base + 29u));
    uint _e364 = local_31;
    out_.Store(_e364*4, asuint(uint(_e358)));
    int _e367 = original.value;
    local_32 = uint((base + 30u));
    uint _e373 = local_32;
    out_.Store(_e373*4, asuint(uint(_e367)));
    int _e378 = original.history[int(1)];
    local_33 = uint((base + 31u));
    uint _e384 = local_33;
    out_.Store(_e384*4, asuint(uint(_e378)));
    Record_cuda_record_0_ _e386 = original;
    const Record_cuda_record_0_ _e387 = operator_u002d_2(_e386);
    local_34 = uint((base + 32u));
    uint _e394 = local_34;
    out_.Store(_e394*4, asuint(uint(_e387.value)));
    Record_cuda_record_0_ _e396 = original;
    const Record_cuda_record_0_ _e398 = operator_u002a_3(_e396, int(2));
    local_35 = uint((base + 33u));
    uint _e405 = local_35;
    out_.Store(_e405*4, asuint(uint(_e398.value)));
    Record_cuda_record_0_ _e407 = original;
    const Record_cuda_record_0_ _e408 = operator_u002a_2(_e407);
    const int _e409 = operator_u0026_2(_e408);
    local_36 = uint((base + 34u));
    uint _e415 = local_36;
    out_.Store(_e415*4, asuint(uint(_e409)));
    const bool _e420 = operator_u0021_(int2(int(0), int(0)));
    local_37 = uint((base + 35u));
    uint _e426 = local_37;
    out_.Store(_e426*4, asuint(uint(_e420)));
}
