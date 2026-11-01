struct Record_cuda_record_0_ {
    int value;
    int samples[2];
};

RWByteAddressBuffer out_ : register(u0);

int adjust(int value_1)
{
    int value_2 = (int)0;

    value_2 = value_1;
    int _e2 = value_2;
    value_2 = asint(asuint(_e2) + asuint(int(2)));
    int _e5 = value_2;
    return _e5;
}

int ZeroValueint() {
    return (int)0;
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(1, 1, 1)]
void reference_bindings()
{
    int value = (int)0;
    int left = (int)0;
    int right = (int)0;
    int source = (int)0;
    float local = (float)0;
    int uninitialized = (int)0;
    int original = (int)0;
    int replacement = (int)0;
    int local_1 = (int)0;
    float local_2 = (float)0;
    int local_3 = (int)0;
    int updated = (int)0;
    int comma_left = (int)0;
    int comma_right = (int)0;
    int counter = (int)0;
    bool enabled = (bool)0;
    uint bits = (uint)0;
    float floating = (float)0;
    Record_cuda_record_0_ record = (Record_cuda_record_0_)0;

    value = int(1);
    value = int(5);
    int _e3 = value;
    value = asint(asuint(_e3) + asuint(int(2)));
    int _e6 = value;
    int _e7 = value;
    value = asint(asuint(_e7) + asuint(_e6));
    int _e9 = value;
    out_.Store(uint(int(0))*4, asuint(uint(_e9)));
    int _e15 = value;
    out_.Store(uint(int(1))*4, asuint(uint(_e15)));
    int _e20 = value;
    out_.Store(uint(int(2))*4, asuint(uint(_e20)));
    left = int(1);
    right = int(2);
    left = int(5);
    int _e30 = right;
    right = asint(asuint(_e30) + asuint(int(2)));
    int _e33 = right;
    int _e34 = left;
    left = asint(asuint(_e34) + asuint(_e33));
    int _e36 = left;
    out_.Store(uint(int(3))*4, asuint(uint(_e36)));
    int _e41 = right;
    out_.Store(uint(int(4))*4, asuint(uint(_e41)));
    source = int(3);
    int _e48 = source;
    local = float(_e48);
    source = int(9);
    float _e52 = local;
    out_.Store(uint(int(5))*4, asuint(naga_f2u32(_e52)));
    int _e57 = source;
    out_.Store(uint(int(6))*4, asuint(uint(_e57)));
    int _e62 = source;
    out_.Store(uint(int(7))*4, asuint(uint(_e62)));
    uninitialized = int(7);
    int _e71 = uninitialized;
    out_.Store(uint(int(8))*4, asuint(uint(_e71)));
    original = int(2);
    replacement = int(8);
    int _e78 = replacement;
    original = _e78;
    replacement = int(10);
    int _e80 = original;
    out_.Store(uint(int(9))*4, asuint(uint(_e80)));
    int _e85 = original;
    out_.Store(uint(int(10))*4, asuint(uint(_e85)));
    int _e90 = replacement;
    out_.Store(uint(int(11))*4, asuint(uint(_e90)));
    local_1 = ZeroValueint();
    local_2 = 1.5;
    local_3 = naga_f2i32(3.75);
    int _e102 = local_1;
    out_.Store(uint(int(12))*4, asuint(uint(_e102)));
    float _e107 = local_2;
    out_.Store(uint(int(13))*4, asuint(asuint(_e107)));
    int _e112 = local_3;
    out_.Store(uint(int(14))*4, asuint(uint(_e112)));
    updated = int(1);
    int _e119 = updated;
    updated = asint(asuint(_e119) + asuint(int(1)));
    int _e122 = updated;
    updated = asint(asuint(_e122) + asuint(int(3)));
    int _e125 = updated;
    out_.Store(uint(int(15))*4, asuint(uint(_e125)));
    updated = int(9);
    int _e131 = updated;
    updated = asint(asuint(_e131) + asuint(int(2)));
    int _e134 = updated;
    out_.Store(uint(int(16))*4, asuint(uint(_e134)));
    comma_left = int(3);
    comma_right = int(4);
    counter = int(0);
    int _e145 = counter;
    counter = asint(asuint(_e145) + asuint(int(1)));
    int _e148 = comma_right;
    comma_right = asint(asuint(_e148) + asuint(int(5)));
    int _e151 = comma_left;
    out_.Store(uint(int(17))*4, asuint(uint(_e151)));
    int _e156 = comma_right;
    out_.Store(uint(int(18))*4, asuint(uint(_e156)));
    int _e161 = counter;
    out_.Store(uint(int(19))*4, asuint(uint(_e161)));
    enabled = false;
    enabled = true;
    bool _e169 = enabled;
    out_.Store(uint(int(20))*4, asuint(uint(_e169)));
    bits = 4294901760u;
    uint _e176 = bits;
    bits = (_e176 + 3u);
    uint _e179 = bits;
    out_.Store(uint(int(21))*4, asuint(_e179));
    floating = 2.0;
    float _e185 = floating;
    floating = (_e185 * 0.5);
    float _e188 = floating;
    out_.Store(uint(int(22))*4, asuint(asuint(_e188)));
    record.value = int(10);
    record.samples[0] = int(2);
    record.samples[1] = int(3);
    int _e202 = record.value;
    const int _e203 = adjust(_e202);
    record.value = _e203;
    int _e206 = record.value;
    out_.Store(uint(int(23))*4, asuint(uint(_e206)));
}
