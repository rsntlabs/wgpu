struct Packet_cuda_record_0_ {
    uint tag;
    int samples[2];
    int _pad2_0;
    int2 pair;
};

struct uint3_ {
    uint x;
    uint y;
    uint z;
};

RWByteAddressBuffer output : register(u0);

int ZeroValueint() {
    return (int)0;
}

Packet_cuda_record_0_ ZeroValuePacket_cuda_record_0_() {
    return (Packet_cuda_record_0_)0;
}

[numthreads(1, 1, 1)]
void direct_aggregate_copy()
{
    uint counter = (uint)0;
    Packet_cuda_record_0_ original = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ copied = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ following = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ frozen = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ called = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ local = (Packet_cuda_record_0_)0;
    Packet_cuda_record_0_ called_copy = (Packet_cuda_record_0_)0;
    int2 point_ = (int2)0;
    int2 point_copy = (int2)0;
    int2 changed = (int2)0;
    int2 frozen_point = (int2)0;
    int2 from_call = (int2)0;
    int2 local_1 = (int2)0;
    uint3_ triple = (uint3_)0;
    uint3_ triple_copy = (uint3_)0;
    int seed = (int)0;
    Packet_cuda_record_0_ result = (Packet_cuda_record_0_)0;
    int seed_1 = (int)0;

    counter = 0u;
    original.tag = 3u;
    original.samples[0] = int(5);
    original.samples[1] = int(7);
    original.pair.x = int(11);
    original.pair.y = int(13);
    Packet_cuda_record_0_ _e15 = original;
    copied = _e15;
    original.samples[int(0)] = int(17);
    Packet_cuda_record_0_ _e21 = original;
    following = _e21;
    Packet_cuda_record_0_ _e23 = copied;
    frozen = _e23;
    original.pair.x = int(19);
    original.samples[int(1)] = int(23);
    original.tag = 29u;
    int _e37 = copied.samples[int(1)];
    copied.samples[int(1)] = asint(asuint(_e37) + asuint(int(1)));
    seed = ZeroValueint();
    result = ZeroValuePacket_cuda_record_0_();
    seed = int(31);
    uint _e46 = counter;
    counter = (_e46 + uint(int(1)));
    uint _e50 = counter;
    result.tag = _e50;
    int _e54 = seed;
    result.samples[0] = _e54;
    int _e57 = seed;
    result.samples[1] = asint(asuint(_e57) + asuint(int(1)));
    int _e61 = seed;
    result.pair.x = asint(asuint(_e61) + asuint(int(2)));
    int _e66 = seed;
    result.pair.y = asint(asuint(_e66) + asuint(int(3)));
    Packet_cuda_record_0_ _e69 = result;
    local = _e69;
    Packet_cuda_record_0_ _e71 = local;
    called = _e71;
    Packet_cuda_record_0_ _e73 = called;
    called_copy = _e73;
    called.samples[int(0)] = int(41);
    point_.x = int(43);
    point_.y = int(47);
    int2 _e84 = point_;
    point_copy = _e84;
    point_.x = int(53);
    int2 _e88 = point_;
    changed = _e88;
    int2 _e90 = point_copy;
    frozen_point = _e90;
    point_copy.y = int(59);
    seed_1 = ZeroValueint();
    seed_1 = int(61);
    uint _e98 = counter;
    counter = (_e98 + uint(int(1)));
    int _e102 = seed_1;
    int _e103 = seed_1;
    local_1 = int2(_e102, asint(asuint(_e103) + asuint(int(1))));
    int2 _e108 = local_1;
    from_call = _e108;
    triple.x = 67u;
    triple.y = 71u;
    triple.z = 73u;
    uint3_ _e117 = triple;
    triple_copy = _e117;
    triple.y = 79u;
    uint _e122 = copied.tag;
    output.Store(uint(int(0))*4, asuint(_e122));
    int _e130 = copied.samples[int(0)];
    output.Store(uint(int(1))*4, asuint(uint(_e130)));
    int _e138 = copied.samples[int(1)];
    output.Store(uint(int(2))*4, asuint(uint(_e138)));
    int _e146 = frozen.samples[int(1)];
    output.Store(uint(int(3))*4, asuint(uint(_e146)));
    int _e153 = copied.pair.x;
    output.Store(uint(int(4))*4, asuint(uint(_e153)));
    int _e160 = frozen.pair.y;
    output.Store(uint(int(5))*4, asuint(uint(_e160)));
    int _e168 = following.samples[int(0)];
    output.Store(uint(int(6))*4, asuint(uint(_e168)));
    int _e175 = following.pair.x;
    output.Store(uint(int(7))*4, asuint(uint(_e175)));
    int _e183 = original.samples[int(1)];
    output.Store(uint(int(8))*4, asuint(uint(_e183)));
    int _e190 = original.pair.x;
    output.Store(uint(int(9))*4, asuint(uint(_e190)));
    uint _e196 = called.tag;
    output.Store(uint(int(10))*4, asuint(_e196));
    int _e203 = called_copy.samples[int(0)];
    output.Store(uint(int(11))*4, asuint(uint(_e203)));
    int _e211 = called.samples[int(0)];
    output.Store(uint(int(12))*4, asuint(uint(_e211)));
    int _e218 = called_copy.pair.y;
    output.Store(uint(int(13))*4, asuint(uint(_e218)));
    int _e224 = point_copy.x;
    output.Store(uint(int(14))*4, asuint(uint(_e224)));
    int _e230 = point_copy.y;
    output.Store(uint(int(15))*4, asuint(uint(_e230)));
    int _e236 = changed.x;
    output.Store(uint(int(16))*4, asuint(uint(_e236)));
    int _e242 = frozen_point.y;
    output.Store(uint(int(17))*4, asuint(uint(_e242)));
    int _e248 = from_call.x;
    output.Store(uint(int(18))*4, asuint(uint(_e248)));
    int _e254 = from_call.y;
    output.Store(uint(int(19))*4, asuint(uint(_e254)));
    uint _e259 = counter;
    output.Store(uint(int(20))*4, asuint(_e259));
    uint _e264 = triple_copy.x;
    output.Store(uint(int(21))*4, asuint(_e264));
    uint _e269 = triple_copy.y;
    output.Store(uint(int(22))*4, asuint(_e269));
    uint _e274 = triple.y;
    output.Store(uint(int(23))*4, asuint(_e274));
}
