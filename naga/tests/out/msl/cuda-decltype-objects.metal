// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct float3_ {
    float x;
    float y;
    float z;
};
struct DecltypeRecord_cuda_record_0_ {
    int tag;
    float3_ vector;
};
struct float1_ {
    float x;
};
typedef uint type_3[1];
struct type_7 {
    DecltypeRecord_cuda_record_0_ inner[2];
};
struct dim3_ {
    uint x;
    uint y;
    uint z;
};
struct type_8 {
    float1_ inner[2];
};
struct type_9 {
    float3_ inner[2];
};
constant uint GlobalWord = 7u;

uint global_decltype_value(
) {
    return GlobalWord;
}

void old_nullptr_value(
) {
    return;
}

int vector_decltype_kind(
    float1_ value
) {
    float1_ value_1 = {};
    value_1 = value;
    return 2;
}

int copied_decltype_value_int(
    int value_2
) {
    return value_2;
}

int copied_decltype_value_unsigned(
    uint value_3
) {
    return static_cast<int>(value_3);
}
uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}


struct decltype_objectsInput {
};
kernel void decltype_objects(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_3& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
) {
    int source = {};
    int counter = {};
    uint local = {};
    int mutable_value = {};
    int frozen_value = {};
    int Constant = {};
    int mutable_copy = {};
    int frozen_copy = {};
    int constant_copy = {};
    uint local_1 = {};
    int local_2 = {};
    uint local_3 = {};
    int local_4 = {};
    uint local_5 = {};
    int local_6 = {};
    uint local_7 = {};
    float1_ one = {};
    float1_ one_copy = {};
    metal::float2 two = {};
    metal::float2 two_copy = {};
    float3_ three = {};
    float3_ three_copy = {};
    metal::float4 four = {};
    metal::float4 four_copy = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    DecltypeRecord_cuda_record_0_ record = {};
    DecltypeRecord_cuda_record_0_ record_copy = {};
    type_7 records = {};
    uint local_13 = {};
    uint local_14 = {};
    dim3_ shape = {};
    dim3_ default_shape = {};
    dim3_ explicit_shape = {};
    dim3_ braced_shape = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    int Hidden = {};
    int outer_copy = {};
    uint local_20 = {};
    float Hidden_1 = {};
    float inner_copy = {};
    uint local_21 = {};
    int after_copy = {};
    uint local_22 = {};
    uint local_23 = {};
    type_8 singles = {};
    type_9 triples = {};
    uint local_24 = {};
    uint local_25 = {};
    DecltypeRecord_cuda_record_0_ expression = {};
    uint local_26 = {};
    uint local_27 = {};
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 25u);
    source = 1;
    counter = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    int first = counter;
    counter = as_type<int>(as_type<uint>(first) + as_type<uint>(1));
    int second = counter;
    counter = as_type<int>(as_type<uint>(second) + as_type<uint>(1));
    int third = counter;
    counter = as_type<int>(as_type<uint>(third) + as_type<uint>(1));
    int fourth = counter;
    counter = as_type<int>(as_type<uint>(fourth) + as_type<uint>(1));
    int fifth = counter;
    counter = as_type<int>(as_type<uint>(fifth) + as_type<uint>(1));
    int sixth = counter;
    counter = as_type<int>(as_type<uint>(sixth) + as_type<uint>(1));
    int seventh = counter;
    counter = as_type<int>(as_type<uint>(seventh) + as_type<uint>(1));
    output[base] = static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(first) + as_type<uint>(second))) + as_type<uint>(third))) + as_type<uint>(fourth))) + as_type<uint>(fifth))) + as_type<uint>(sixth))) + as_type<uint>(seventh)));
    int _e42 = counter;
    local = static_cast<uint>(base + 1u);
    uint _e48 = local;
    output[_e48] = static_cast<uint>(_e42);
    mutable_value = 1;
    frozen_value = 2;
    Constant = 3;
    mutable_copy = 4;
    frozen_copy = 5;
    constant_copy = 6;
    local_2 = 1;
    int _e64 = local_2;
    local_1 = static_cast<uint>(base + 2u);
    uint _e70 = local_1;
    output[_e70] = static_cast<uint>(_e64);
    local_4 = 2;
    int _e74 = local_4;
    local_3 = static_cast<uint>(base + 3u);
    uint _e80 = local_3;
    output[_e80] = static_cast<uint>(_e74);
    local_6 = 2;
    int _e84 = local_6;
    local_5 = static_cast<uint>(base + 4u);
    uint _e90 = local_5;
    output[_e90] = static_cast<uint>(_e84);
    uint _e92 = global_decltype_value();
    local_7 = static_cast<uint>(base + 5u);
    uint _e97 = local_7;
    output[_e97] = _e92;
    one = float1_ {2.0};
    one_copy.x = 3.0;
    two = metal::float2(1.0, 2.0);
    two_copy.x = 3.0;
    two_copy.y = 4.0;
    three = float3_ {1.0, 2.0, 3.0};
    three_copy.x = 4.0;
    three_copy.y = 5.0;
    three_copy.z = 6.0;
    four = metal::float4(1.0, 2.0, 3.0, 4.0);
    four_copy.x = 5.0;
    four_copy.y = 6.0;
    four_copy.z = 7.0;
    four_copy.w = 8.0;
    float _e142 = one_copy.x;
    local_8 = static_cast<uint>(base + 6u);
    uint _e148 = local_8;
    output[_e148] = naga_f2u32(_e142);
    float1_ _e150 = one_copy;
    int _e151 = vector_decltype_kind(_e150);
    local_9 = static_cast<uint>(base + 7u);
    uint _e157 = local_9;
    output[_e157] = static_cast<uint>(_e151);
    float _e160 = two_copy.y;
    local_10 = static_cast<uint>(base + 8u);
    uint _e166 = local_10;
    output[_e166] = naga_f2u32(_e160);
    float _e169 = three_copy.z;
    local_11 = static_cast<uint>(base + 9u);
    uint _e175 = local_11;
    output[_e175] = naga_f2u32(_e169);
    float _e178 = four_copy.w;
    local_12 = static_cast<uint>(base + 10u);
    uint _e184 = local_12;
    output[_e184] = naga_f2u32(_e178);
    record.tag = 1;
    record.vector.x = 2.0;
    record.vector.y = 3.0;
    record.vector.z = 4.0;
    record_copy.tag = 9;
    record_copy.vector.x = 5.0;
    record_copy.vector.y = 6.0;
    record_copy.vector.z = 7.0;
    records.inner[0].tag = 2;
    records.inner[0].vector.x = 3.0;
    records.inner[0].vector.y = 4.0;
    records.inner[0].vector.z = 5.0;
    records.inner[1].tag = 6;
    records.inner[1].vector.x = 7.0;
    records.inner[1].vector.y = 8.0;
    records.inner[1].vector.z = 9.0;
    int _e228 = record_copy.tag;
    float _e232 = record_copy.vector.y;
    local_13 = static_cast<uint>(base + 11u);
    uint _e239 = local_13;
    output[_e239] = static_cast<uint>(_e228) + naga_f2u32(_e232);
    float _e245 = records.inner[1].vector.z;
    local_14 = static_cast<uint>(base + 12u);
    uint _e251 = local_14;
    output[_e251] = naga_f2u32(_e245);
    shape = dim3_ {1u, 1u, 1u};
    default_shape = dim3_ {1u, 1u, 1u};
    explicit_shape = dim3_ {2u, 3u, 1u};
    braced_shape = dim3_ {4u, 5u, 1u};
    uint _e275 = default_shape.y;
    uint _e278 = default_shape.x;
    uint _e281 = default_shape.z;
    local_15 = static_cast<uint>(base + 13u);
    uint _e289 = local_15;
    output[_e289] = (_e278 + (10u * _e275)) + (100u * _e281);
    uint _e293 = explicit_shape.y;
    uint _e296 = explicit_shape.x;
    uint _e299 = explicit_shape.z;
    local_16 = static_cast<uint>(base + 14u);
    uint _e307 = local_16;
    output[_e307] = (_e296 + (10u * _e293)) + (100u * _e299);
    uint _e311 = braced_shape.y;
    uint _e314 = braced_shape.x;
    uint _e317 = braced_shape.z;
    local_17 = static_cast<uint>(base + 15u);
    uint _e325 = local_17;
    output[_e325] = (_e314 + (10u * _e311)) + (100u * _e317);
    int _e328 = copied_decltype_value_int(7);
    local_18 = static_cast<uint>(base + 16u);
    uint _e334 = local_18;
    output[_e334] = static_cast<uint>(_e328);
    int _e337 = copied_decltype_value_unsigned(9u);
    local_19 = static_cast<uint>(base + 17u);
    uint _e343 = local_19;
    output[_e343] = static_cast<uint>(_e337);
    Hidden = 3;
    outer_copy = 4;
    int _e349 = outer_copy;
    local_20 = static_cast<uint>(base + 18u);
    uint _e355 = local_20;
    output[_e355] = static_cast<uint>(_e349);
    {
        Hidden_1 = 2.0;
        inner_copy = 3.0;
        float _e361 = inner_copy;
        local_21 = static_cast<uint>(base + 19u);
        uint _e367 = local_21;
        local_27 = _e367;
        uint _e369 = local_27;
        output[_e369] = naga_f2u32(_e361);
    }
    after_copy = 5;
    int _e373 = after_copy;
    local_22 = static_cast<uint>(base + 20u);
    uint _e379 = local_22;
    output[_e379] = static_cast<uint>(_e373);
    old_nullptr_value();
    local_23 = static_cast<uint>(base + 21u);
    uint _e387 = local_23;
    output[_e387] = static_cast<uint>(true);
    singles.inner[0].x = 2.0;
    singles.inner[1].x = 5.0;
    triples.inner[0].x = 1.0;
    triples.inner[0].y = 2.0;
    triples.inner[0].z = 3.0;
    triples.inner[1].x = 4.0;
    triples.inner[1].y = 5.0;
    triples.inner[1].z = 6.0;
    float _e414 = singles.inner[1].x;
    local_24 = static_cast<uint>(base + 22u);
    uint _e420 = local_24;
    output[_e420] = naga_f2u32(_e414);
    float _e425 = triples.inner[1].z;
    local_25 = static_cast<uint>(base + 23u);
    uint _e431 = local_25;
    output[_e431] = naga_f2u32(_e425);
    expression.tag = 10;
    expression.vector.x = 11.0;
    expression.vector.y = 12.0;
    expression.vector.z = 13.0;
    int _e444 = expression.tag;
    float _e448 = expression.vector.z;
    local_26 = static_cast<uint>(base + 24u);
    uint _e455 = local_26;
    output[_e455] = static_cast<uint>(_e444) + naga_f2u32(_e448);
}
