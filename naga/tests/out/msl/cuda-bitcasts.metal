// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_3[1];

float from_bits(
    uint value_1
) {
    return as_type<float>(value_1);
}

int _float_as_int(
    int first,
    int second
) {
    return as_type<int>(as_type<uint>(first) + as_type<uint>(second));
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}


kernel void bitcasts(
  device type_3& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    int local = {};
    int local_1 = {};
    int local_2 = {};
    int local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    float value = {};
    int signed_bits = {};
    uint unsigned_bits = {};
    int local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    out[static_cast<uint>(0)] = static_cast<uint>(as_type<int>(static_cast<float>(true)));
    out[static_cast<uint>(1)] = static_cast<uint>(as_type<int>(static_cast<float>(3)));
    out[static_cast<uint>(2)] = static_cast<uint>(as_type<int>(static_cast<float>(5u)));
    out[static_cast<uint>(3)] = static_cast<uint>(as_type<int>(2.75));
    out[static_cast<uint>(4)] = as_type<uint>(static_cast<float>(true));
    out[static_cast<uint>(5)] = as_type<uint>(static_cast<float>(3));
    out[static_cast<uint>(6)] = as_type<uint>(static_cast<float>(5u));
    out[static_cast<uint>(7)] = as_type<uint>(2.75);
    local = static_cast<int>(true);
    int _e54 = local;
    out[static_cast<uint>(8)] = as_type<uint>(as_type<float>(_e54));
    local_1 = 3;
    int _e62 = local_1;
    out[static_cast<uint>(9)] = as_type<uint>(as_type<float>(_e62));
    local_2 = static_cast<int>(5u);
    int _e71 = local_2;
    out[static_cast<uint>(10)] = as_type<uint>(as_type<float>(_e71));
    local_3 = naga_f2i32(2.75);
    int _e80 = local_3;
    out[static_cast<uint>(11)] = as_type<uint>(as_type<float>(_e80));
    local_4 = static_cast<uint>(true);
    uint _e89 = local_4;
    out[static_cast<uint>(12)] = as_type<uint>(as_type<float>(_e89));
    local_5 = static_cast<uint>(3);
    uint _e98 = local_5;
    out[static_cast<uint>(13)] = as_type<uint>(as_type<float>(_e98));
    local_6 = 5u;
    uint _e106 = local_6;
    out[static_cast<uint>(14)] = as_type<uint>(as_type<float>(_e106));
    local_7 = naga_f2u32(2.75);
    uint _e115 = local_7;
    out[static_cast<uint>(15)] = as_type<uint>(as_type<float>(_e115));
    value = 1.5;
    float _e123 = value;
    value = _e123 + static_cast<float>(1);
    out[static_cast<uint>(16)] = static_cast<uint>(as_type<int>(_e123));
    float _e132 = value;
    out[static_cast<uint>(17)] = as_type<uint>(_e132);
    float _e137 = value;
    value = _e137 + static_cast<float>(1);
    out[static_cast<uint>(18)] = as_type<uint>(_e137);
    float _e145 = value;
    out[static_cast<uint>(19)] = as_type<uint>(_e145);
    signed_bits = 1065353216;
    int _e152 = signed_bits;
    signed_bits = as_type<int>(as_type<uint>(_e152) + as_type<uint>(1));
    out[static_cast<uint>(20)] = as_type<uint>(as_type<float>(_e152));
    int _e160 = signed_bits;
    out[static_cast<uint>(21)] = static_cast<uint>(_e160);
    unsigned_bits = 1073741824u;
    uint _e167 = unsigned_bits;
    unsigned_bits = _e167 + static_cast<uint>(1);
    out[static_cast<uint>(22)] = as_type<uint>(as_type<float>(_e167));
    uint _e176 = unsigned_bits;
    out[static_cast<uint>(23)] = _e176;
    int _e182 = _float_as_int(3, 4);
    out[static_cast<uint>(24)] = static_cast<uint>(_e182);
    float _e188 = from_bits(3212836864u);
    out[static_cast<uint>(25)] = as_type<uint>(_e188);
    local_8 = 2139095040;
    int _e195 = local_8;
    out[static_cast<uint>(26)] = as_type<uint>(as_type<float>(_e195));
    local_9 = 2143363909u;
    uint _e203 = local_9;
    out[static_cast<uint>(27)] = as_type<uint>(as_type<float>(_e203));
    local_10 = naga_f2u32(1065353200.0);
    uint _e212 = local_10;
    out[static_cast<uint>(28)] = as_type<uint>(as_type<float>(_e212));
    out[static_cast<uint>(29)] = static_cast<uint>(as_type<int>(static_cast<float>(1u)));
}
