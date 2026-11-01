// language: metal1.2
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_1 {
    int inner[2];
};
struct Record_cuda_record_0_ {
    int value;
    type_1 samples;
};
typedef uint type_3[1];

int adjust(
    int value_1
) {
    int value_2 = {};
    value_2 = value_1;
    int _e2 = value_2;
    value_2 = as_type<int>(as_type<uint>(_e2) + as_type<uint>(2));
    int _e5 = value_2;
    return _e5;
}
uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


kernel void reference_bindings(
  device type_3& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    int value = {};
    int left = {};
    int right = {};
    int source = {};
    float local = {};
    int uninitialized = {};
    int original = {};
    int replacement = {};
    int local_1 = {};
    float local_2 = {};
    int local_3 = {};
    int updated = {};
    int comma_left = {};
    int comma_right = {};
    int counter = {};
    bool enabled = {};
    uint bits = {};
    float floating = {};
    Record_cuda_record_0_ record = {};
    value = 1;
    value = 5;
    int _e3 = value;
    value = as_type<int>(as_type<uint>(_e3) + as_type<uint>(2));
    int _e6 = value;
    int _e7 = value;
    value = as_type<int>(as_type<uint>(_e7) + as_type<uint>(_e6));
    int _e9 = value;
    out[static_cast<uint>(0)] = static_cast<uint>(_e9);
    int _e15 = value;
    out[static_cast<uint>(1)] = static_cast<uint>(_e15);
    int _e20 = value;
    out[static_cast<uint>(2)] = static_cast<uint>(_e20);
    left = 1;
    right = 2;
    left = 5;
    int _e30 = right;
    right = as_type<int>(as_type<uint>(_e30) + as_type<uint>(2));
    int _e33 = right;
    int _e34 = left;
    left = as_type<int>(as_type<uint>(_e34) + as_type<uint>(_e33));
    int _e36 = left;
    out[static_cast<uint>(3)] = static_cast<uint>(_e36);
    int _e41 = right;
    out[static_cast<uint>(4)] = static_cast<uint>(_e41);
    source = 3;
    int _e48 = source;
    local = static_cast<float>(_e48);
    source = 9;
    float _e52 = local;
    out[static_cast<uint>(5)] = naga_f2u32(_e52);
    int _e57 = source;
    out[static_cast<uint>(6)] = static_cast<uint>(_e57);
    int _e62 = source;
    out[static_cast<uint>(7)] = static_cast<uint>(_e62);
    uninitialized = 7;
    int _e71 = uninitialized;
    out[static_cast<uint>(8)] = static_cast<uint>(_e71);
    original = 2;
    replacement = 8;
    int _e78 = replacement;
    original = _e78;
    replacement = 10;
    int _e80 = original;
    out[static_cast<uint>(9)] = static_cast<uint>(_e80);
    int _e85 = original;
    out[static_cast<uint>(10)] = static_cast<uint>(_e85);
    int _e90 = replacement;
    out[static_cast<uint>(11)] = static_cast<uint>(_e90);
    local_1 = int {};
    local_2 = 1.5;
    local_3 = naga_f2i32(3.75);
    int _e102 = local_1;
    out[static_cast<uint>(12)] = static_cast<uint>(_e102);
    float _e107 = local_2;
    out[static_cast<uint>(13)] = as_type<uint>(_e107);
    int _e112 = local_3;
    out[static_cast<uint>(14)] = static_cast<uint>(_e112);
    updated = 1;
    int _e119 = updated;
    updated = as_type<int>(as_type<uint>(_e119) + as_type<uint>(1));
    int _e122 = updated;
    updated = as_type<int>(as_type<uint>(_e122) + as_type<uint>(3));
    int _e125 = updated;
    out[static_cast<uint>(15)] = static_cast<uint>(_e125);
    updated = 9;
    int _e131 = updated;
    updated = as_type<int>(as_type<uint>(_e131) + as_type<uint>(2));
    int _e134 = updated;
    out[static_cast<uint>(16)] = static_cast<uint>(_e134);
    comma_left = 3;
    comma_right = 4;
    counter = 0;
    int _e145 = counter;
    counter = as_type<int>(as_type<uint>(_e145) + as_type<uint>(1));
    int _e148 = comma_right;
    comma_right = as_type<int>(as_type<uint>(_e148) + as_type<uint>(5));
    int _e151 = comma_left;
    out[static_cast<uint>(17)] = static_cast<uint>(_e151);
    int _e156 = comma_right;
    out[static_cast<uint>(18)] = static_cast<uint>(_e156);
    int _e161 = counter;
    out[static_cast<uint>(19)] = static_cast<uint>(_e161);
    enabled = false;
    enabled = true;
    bool _e169 = enabled;
    out[static_cast<uint>(20)] = static_cast<uint>(_e169);
    bits = 4294901760u;
    uint _e176 = bits;
    bits = _e176 + 3u;
    uint _e179 = bits;
    out[static_cast<uint>(21)] = _e179;
    floating = 2.0;
    float _e185 = floating;
    floating = _e185 * 0.5;
    float _e188 = floating;
    out[static_cast<uint>(22)] = as_type<uint>(_e188);
    record.value = 10;
    record.samples.inner[0] = 2;
    record.samples.inner[1] = 3;
    int _e202 = record.value;
    int _e203 = adjust(_e202);
    record.value = _e203;
    int _e206 = record.value;
    out[static_cast<uint>(23)] = static_cast<uint>(_e206);
}
