// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_2 {
    int inner[2];
};
struct Packet_cuda_record_0_ {
    uint tag;
    type_2 samples;
    char _pad2[4];
    metal::int2 pair;
};
typedef uint type_4[1];
struct uint3_ {
    uint x;
    uint y;
    uint z;
};

kernel void direct_aggregate_copy(
  device type_4& output [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint counter = {};
    Packet_cuda_record_0_ original = {};
    Packet_cuda_record_0_ copied = {};
    Packet_cuda_record_0_ following = {};
    Packet_cuda_record_0_ frozen = {};
    Packet_cuda_record_0_ called = {};
    Packet_cuda_record_0_ local = {};
    Packet_cuda_record_0_ called_copy = {};
    metal::int2 point = {};
    metal::int2 point_copy = {};
    metal::int2 changed = {};
    metal::int2 frozen_point = {};
    metal::int2 from_call = {};
    metal::int2 local_1 = {};
    uint3_ triple = {};
    uint3_ triple_copy = {};
    int seed = {};
    Packet_cuda_record_0_ result = {};
    int seed_1 = {};
    counter = 0u;
    original.tag = 3u;
    original.samples.inner[0] = 5;
    original.samples.inner[1] = 7;
    original.pair.x = 11;
    original.pair.y = 13;
    Packet_cuda_record_0_ _e15 = original;
    copied = _e15;
    original.samples.inner[0] = 17;
    Packet_cuda_record_0_ _e21 = original;
    following = _e21;
    Packet_cuda_record_0_ _e23 = copied;
    frozen = _e23;
    original.pair.x = 19;
    original.samples.inner[1] = 23;
    original.tag = 29u;
    int _e37 = copied.samples.inner[1];
    copied.samples.inner[1] = as_type<int>(as_type<uint>(_e37) + as_type<uint>(1));
    seed = int {};
    result = Packet_cuda_record_0_ {};
    seed = 31;
    uint _e46 = counter;
    counter = _e46 + static_cast<uint>(1);
    uint _e50 = counter;
    result.tag = _e50;
    int _e54 = seed;
    result.samples.inner[0] = _e54;
    int _e57 = seed;
    result.samples.inner[1] = as_type<int>(as_type<uint>(_e57) + as_type<uint>(1));
    int _e61 = seed;
    result.pair.x = as_type<int>(as_type<uint>(_e61) + as_type<uint>(2));
    int _e66 = seed;
    result.pair.y = as_type<int>(as_type<uint>(_e66) + as_type<uint>(3));
    Packet_cuda_record_0_ _e69 = result;
    local = _e69;
    Packet_cuda_record_0_ _e71 = local;
    called = _e71;
    Packet_cuda_record_0_ _e73 = called;
    called_copy = _e73;
    called.samples.inner[0] = 41;
    point.x = 43;
    point.y = 47;
    metal::int2 _e84 = point;
    point_copy = _e84;
    point.x = 53;
    metal::int2 _e88 = point;
    changed = _e88;
    metal::int2 _e90 = point_copy;
    frozen_point = _e90;
    point_copy.y = 59;
    seed_1 = int {};
    seed_1 = 61;
    uint _e98 = counter;
    counter = _e98 + static_cast<uint>(1);
    int _e102 = seed_1;
    int _e103 = seed_1;
    local_1 = metal::int2(_e102, as_type<int>(as_type<uint>(_e103) + as_type<uint>(1)));
    metal::int2 _e108 = local_1;
    from_call = _e108;
    triple.x = 67u;
    triple.y = 71u;
    triple.z = 73u;
    uint3_ _e117 = triple;
    triple_copy = _e117;
    triple.y = 79u;
    uint _e122 = copied.tag;
    output[static_cast<uint>(0)] = _e122;
    int _e130 = copied.samples.inner[0];
    output[static_cast<uint>(1)] = static_cast<uint>(_e130);
    int _e138 = copied.samples.inner[1];
    output[static_cast<uint>(2)] = static_cast<uint>(_e138);
    int _e146 = frozen.samples.inner[1];
    output[static_cast<uint>(3)] = static_cast<uint>(_e146);
    int _e153 = copied.pair.x;
    output[static_cast<uint>(4)] = static_cast<uint>(_e153);
    int _e160 = frozen.pair.y;
    output[static_cast<uint>(5)] = static_cast<uint>(_e160);
    int _e168 = following.samples.inner[0];
    output[static_cast<uint>(6)] = static_cast<uint>(_e168);
    int _e175 = following.pair.x;
    output[static_cast<uint>(7)] = static_cast<uint>(_e175);
    int _e183 = original.samples.inner[1];
    output[static_cast<uint>(8)] = static_cast<uint>(_e183);
    int _e190 = original.pair.x;
    output[static_cast<uint>(9)] = static_cast<uint>(_e190);
    uint _e196 = called.tag;
    output[static_cast<uint>(10)] = _e196;
    int _e203 = called_copy.samples.inner[0];
    output[static_cast<uint>(11)] = static_cast<uint>(_e203);
    int _e211 = called.samples.inner[0];
    output[static_cast<uint>(12)] = static_cast<uint>(_e211);
    int _e218 = called_copy.pair.y;
    output[static_cast<uint>(13)] = static_cast<uint>(_e218);
    int _e224 = point_copy.x;
    output[static_cast<uint>(14)] = static_cast<uint>(_e224);
    int _e230 = point_copy.y;
    output[static_cast<uint>(15)] = static_cast<uint>(_e230);
    int _e236 = changed.x;
    output[static_cast<uint>(16)] = static_cast<uint>(_e236);
    int _e242 = frozen_point.y;
    output[static_cast<uint>(17)] = static_cast<uint>(_e242);
    int _e248 = from_call.x;
    output[static_cast<uint>(18)] = static_cast<uint>(_e248);
    int _e254 = from_call.y;
    output[static_cast<uint>(19)] = static_cast<uint>(_e254);
    uint _e259 = counter;
    output[static_cast<uint>(20)] = _e259;
    uint _e264 = triple_copy.x;
    output[static_cast<uint>(21)] = _e264;
    uint _e269 = triple_copy.y;
    output[static_cast<uint>(22)] = _e269;
    uint _e274 = triple.y;
    output[static_cast<uint>(23)] = _e274;
}
