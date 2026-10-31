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
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    int left = {};
    int right = {};
    uint local_3 = {};
    uint local_4 = {};
    int source = {};
    float local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    int uninitialized = {};
    uint local_9 = {};
    int original = {};
    int replacement = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    int local_13 = {};
    float local_14 = {};
    int local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    int updated = {};
    uint local_19 = {};
    uint local_20 = {};
    int comma_left = {};
    int comma_right = {};
    int counter = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    bool enabled = {};
    uint local_24 = {};
    uint bits = {};
    uint local_25 = {};
    float floating = {};
    uint local_26 = {};
    Record_cuda_record_0_ record = {};
    uint local_27 = {};
    value = 1;
    value = 5;
    int _e3 = value;
    value = as_type<int>(as_type<uint>(_e3) + as_type<uint>(2));
    int _e6 = value;
    int _e7 = value;
    value = as_type<int>(as_type<uint>(_e7) + as_type<uint>(_e6));
    int _e9 = value;
    local = static_cast<uint>(0);
    uint _e14 = local;
    out[_e14] = static_cast<uint>(_e9);
    int _e17 = value;
    local_1 = static_cast<uint>(1);
    uint _e22 = local_1;
    out[_e22] = static_cast<uint>(_e17);
    int _e24 = value;
    local_2 = static_cast<uint>(2);
    uint _e29 = local_2;
    out[_e29] = static_cast<uint>(_e24);
    left = 1;
    right = 2;
    left = 5;
    int _e36 = right;
    right = as_type<int>(as_type<uint>(_e36) + as_type<uint>(2));
    int _e39 = right;
    int _e40 = left;
    left = as_type<int>(as_type<uint>(_e40) + as_type<uint>(_e39));
    int _e42 = left;
    local_3 = static_cast<uint>(3);
    uint _e47 = local_3;
    out[_e47] = static_cast<uint>(_e42);
    int _e49 = right;
    local_4 = static_cast<uint>(4);
    uint _e54 = local_4;
    out[_e54] = static_cast<uint>(_e49);
    source = 3;
    int _e58 = source;
    local_5 = static_cast<float>(_e58);
    source = 9;
    float _e62 = local_5;
    local_6 = static_cast<uint>(5);
    uint _e67 = local_6;
    out[_e67] = naga_f2u32(_e62);
    int _e69 = source;
    local_7 = static_cast<uint>(6);
    uint _e74 = local_7;
    out[_e74] = static_cast<uint>(_e69);
    int _e76 = source;
    local_8 = static_cast<uint>(7);
    uint _e81 = local_8;
    out[_e81] = static_cast<uint>(_e76);
    uninitialized = 7;
    local_9 = static_cast<uint>(8);
    int _e88 = uninitialized;
    uint _e90 = local_9;
    out[_e90] = static_cast<uint>(_e88);
    original = 2;
    replacement = 8;
    int _e96 = replacement;
    original = _e96;
    replacement = 10;
    int _e98 = original;
    local_10 = static_cast<uint>(9);
    uint _e103 = local_10;
    out[_e103] = static_cast<uint>(_e98);
    int _e105 = original;
    local_11 = static_cast<uint>(10);
    uint _e110 = local_11;
    out[_e110] = static_cast<uint>(_e105);
    int _e112 = replacement;
    local_12 = static_cast<uint>(11);
    uint _e117 = local_12;
    out[_e117] = static_cast<uint>(_e112);
    local_13 = int {};
    local_14 = 1.5;
    local_15 = naga_f2i32(3.75);
    int _e126 = local_13;
    local_16 = static_cast<uint>(12);
    uint _e131 = local_16;
    out[_e131] = static_cast<uint>(_e126);
    float _e133 = local_14;
    local_17 = static_cast<uint>(13);
    uint _e138 = local_17;
    out[_e138] = as_type<uint>(_e133);
    int _e140 = local_15;
    local_18 = static_cast<uint>(14);
    uint _e145 = local_18;
    out[_e145] = static_cast<uint>(_e140);
    updated = 1;
    int _e149 = updated;
    updated = as_type<int>(as_type<uint>(_e149) + as_type<uint>(1));
    int _e152 = updated;
    updated = as_type<int>(as_type<uint>(_e152) + as_type<uint>(3));
    int _e155 = updated;
    local_19 = static_cast<uint>(15);
    uint _e160 = local_19;
    out[_e160] = static_cast<uint>(_e155);
    updated = 9;
    int _e163 = updated;
    updated = as_type<int>(as_type<uint>(_e163) + as_type<uint>(2));
    int _e166 = updated;
    local_20 = static_cast<uint>(16);
    uint _e171 = local_20;
    out[_e171] = static_cast<uint>(_e166);
    comma_left = 3;
    comma_right = 4;
    counter = 0;
    int _e179 = counter;
    counter = as_type<int>(as_type<uint>(_e179) + as_type<uint>(1));
    int _e182 = comma_right;
    comma_right = as_type<int>(as_type<uint>(_e182) + as_type<uint>(5));
    int _e185 = comma_left;
    local_21 = static_cast<uint>(17);
    uint _e190 = local_21;
    out[_e190] = static_cast<uint>(_e185);
    int _e192 = comma_right;
    local_22 = static_cast<uint>(18);
    uint _e197 = local_22;
    out[_e197] = static_cast<uint>(_e192);
    int _e199 = counter;
    local_23 = static_cast<uint>(19);
    uint _e204 = local_23;
    out[_e204] = static_cast<uint>(_e199);
    enabled = false;
    enabled = true;
    bool _e209 = enabled;
    local_24 = static_cast<uint>(20);
    uint _e214 = local_24;
    out[_e214] = static_cast<uint>(_e209);
    bits = 4294901760u;
    uint _e218 = bits;
    bits = _e218 + 3u;
    uint _e221 = bits;
    local_25 = static_cast<uint>(21);
    uint _e225 = local_25;
    out[_e225] = _e221;
    floating = 2.0;
    float _e229 = floating;
    floating = _e229 * 0.5;
    float _e232 = floating;
    local_26 = static_cast<uint>(22);
    uint _e237 = local_26;
    out[_e237] = as_type<uint>(_e232);
    record.value = 10;
    record.samples.inner[0] = 2;
    record.samples.inner[1] = 3;
    int _e248 = record.value;
    int _e249 = adjust(_e248);
    record.value = _e249;
    int _e252 = record.value;
    local_27 = static_cast<uint>(23);
    uint _e257 = local_27;
    out[_e257] = static_cast<uint>(_e252);
}
