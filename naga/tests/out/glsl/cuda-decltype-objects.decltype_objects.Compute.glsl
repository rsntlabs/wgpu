#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

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
struct dim3_ {
    uint x;
    uint y;
    uint z;
};
const uint GlobalWord = 7u;

layout(std430) buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };


uint global_decltype_value() {
    return GlobalWord;
}

void old_nullptr_value() {
    return;
}

int vector_decltype_kind(float1_ value) {
    float1_ value_1 = float1_(0.0);
    value_1 = value;
    return 2;
}

int copied_decltype_value_int(int value_2) {
    return value_2;
}

int copied_decltype_value_unsigned(uint value_3) {
    return int(value_3);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    int source = 0;
    int counter = 0;
    uint local = 0u;
    int mutable_value = 0;
    int frozen_value = 0;
    int Constant = 0;
    int mutable_copy = 0;
    int frozen_copy = 0;
    int constant_copy = 0;
    uint local_1 = 0u;
    int local_2 = 0;
    uint local_3 = 0u;
    int local_4 = 0;
    uint local_5 = 0u;
    int local_6 = 0;
    uint local_7 = 0u;
    float1_ one = float1_(0.0);
    float1_ one_copy = float1_(0.0);
    vec2 two = vec2(0.0);
    vec2 two_copy = vec2(0.0);
    float3_ three = float3_(0.0, 0.0, 0.0);
    float3_ three_copy = float3_(0.0, 0.0, 0.0);
    vec4 four = vec4(0.0);
    vec4 four_copy = vec4(0.0);
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    DecltypeRecord_cuda_record_0_ record = DecltypeRecord_cuda_record_0_(0, float3_(0.0, 0.0, 0.0));
    DecltypeRecord_cuda_record_0_ record_copy = DecltypeRecord_cuda_record_0_(0, float3_(0.0, 0.0, 0.0));
    DecltypeRecord_cuda_record_0_ records[2] = DecltypeRecord_cuda_record_0_[2](DecltypeRecord_cuda_record_0_(0, float3_(0.0, 0.0, 0.0)), DecltypeRecord_cuda_record_0_(0, float3_(0.0, 0.0, 0.0)));
    uint local_13 = 0u;
    uint local_14 = 0u;
    dim3_ shape = dim3_(0u, 0u, 0u);
    dim3_ default_shape = dim3_(0u, 0u, 0u);
    dim3_ explicit_shape = dim3_(0u, 0u, 0u);
    dim3_ braced_shape = dim3_(0u, 0u, 0u);
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    int Hidden = 0;
    int outer_copy = 0;
    uint local_20 = 0u;
    float Hidden_1 = 0.0;
    float inner_copy = 0.0;
    uint local_21 = 0u;
    int after_copy = 0;
    uint local_22 = 0u;
    uint local_23 = 0u;
    float1_ singles[2] = float1_[2](float1_(0.0), float1_(0.0));
    float3_ triples[2] = float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
    uint local_24 = 0u;
    uint local_25 = 0u;
    DecltypeRecord_cuda_record_0_ expression = DecltypeRecord_cuda_record_0_(0, float3_(0.0, 0.0, 0.0));
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 25u));
    source = 1;
    counter = (int(lane) + 1);
    int first = counter;
    counter = (first + 1);
    int second = counter;
    counter = (second + 1);
    int third = counter;
    counter = (third + 1);
    int fourth = counter;
    counter = (fourth + 1);
    int fifth = counter;
    counter = (fifth + 1);
    int sixth = counter;
    counter = (sixth + 1);
    int seventh = counter;
    counter = (seventh + 1);
    _group_0_binding_0_cs[base] = uint(((((((first + second) + third) + fourth) + fifth) + sixth) + seventh));
    int _e42 = counter;
    local = uint((base + 1u));
    uint _e48 = local;
    _group_0_binding_0_cs[_e48] = uint(_e42);
    mutable_value = 1;
    frozen_value = 2;
    Constant = 3;
    mutable_copy = 4;
    frozen_copy = 5;
    constant_copy = 6;
    local_2 = 1;
    int _e64 = local_2;
    local_1 = uint((base + 2u));
    uint _e70 = local_1;
    _group_0_binding_0_cs[_e70] = uint(_e64);
    local_4 = 2;
    int _e74 = local_4;
    local_3 = uint((base + 3u));
    uint _e80 = local_3;
    _group_0_binding_0_cs[_e80] = uint(_e74);
    local_6 = 2;
    int _e84 = local_6;
    local_5 = uint((base + 4u));
    uint _e90 = local_5;
    _group_0_binding_0_cs[_e90] = uint(_e84);
    uint _e92 = global_decltype_value();
    local_7 = uint((base + 5u));
    uint _e97 = local_7;
    _group_0_binding_0_cs[_e97] = _e92;
    one = float1_(2.0);
    one_copy.x = 3.0;
    two = vec2(1.0, 2.0);
    two_copy.x = 3.0;
    two_copy.y = 4.0;
    three = float3_(1.0, 2.0, 3.0);
    three_copy.x = 4.0;
    three_copy.y = 5.0;
    three_copy.z = 6.0;
    four = vec4(1.0, 2.0, 3.0, 4.0);
    four_copy.x = 5.0;
    four_copy.y = 6.0;
    four_copy.z = 7.0;
    four_copy.w = 8.0;
    float _e142 = one_copy.x;
    local_8 = uint((base + 6u));
    uint _e148 = local_8;
    _group_0_binding_0_cs[_e148] = uint(_e142);
    float1_ _e150 = one_copy;
    int _e151 = vector_decltype_kind(_e150);
    local_9 = uint((base + 7u));
    uint _e157 = local_9;
    _group_0_binding_0_cs[_e157] = uint(_e151);
    float _e160 = two_copy.y;
    local_10 = uint((base + 8u));
    uint _e166 = local_10;
    _group_0_binding_0_cs[_e166] = uint(_e160);
    float _e169 = three_copy.z;
    local_11 = uint((base + 9u));
    uint _e175 = local_11;
    _group_0_binding_0_cs[_e175] = uint(_e169);
    float _e178 = four_copy.w;
    local_12 = uint((base + 10u));
    uint _e184 = local_12;
    _group_0_binding_0_cs[_e184] = uint(_e178);
    record.tag = 1;
    record.vector.x = 2.0;
    record.vector.y = 3.0;
    record.vector.z = 4.0;
    record_copy.tag = 9;
    record_copy.vector.x = 5.0;
    record_copy.vector.y = 6.0;
    record_copy.vector.z = 7.0;
    records[0].tag = 2;
    records[0].vector.x = 3.0;
    records[0].vector.y = 4.0;
    records[0].vector.z = 5.0;
    records[1].tag = 6;
    records[1].vector.x = 7.0;
    records[1].vector.y = 8.0;
    records[1].vector.z = 9.0;
    int _e228 = record_copy.tag;
    float _e232 = record_copy.vector.y;
    local_13 = uint((base + 11u));
    uint _e239 = local_13;
    _group_0_binding_0_cs[_e239] = (uint(_e228) + uint(_e232));
    float _e245 = records[1].vector.z;
    local_14 = uint((base + 12u));
    uint _e251 = local_14;
    _group_0_binding_0_cs[_e251] = uint(_e245);
    shape = dim3_(1u, 1u, 1u);
    default_shape = dim3_(1u, 1u, 1u);
    explicit_shape = dim3_(2u, 3u, 1u);
    braced_shape = dim3_(4u, 5u, 1u);
    uint _e275 = default_shape.y;
    uint _e278 = default_shape.x;
    uint _e281 = default_shape.z;
    local_15 = uint((base + 13u));
    uint _e289 = local_15;
    _group_0_binding_0_cs[_e289] = ((_e278 + (10u * _e275)) + (100u * _e281));
    uint _e293 = explicit_shape.y;
    uint _e296 = explicit_shape.x;
    uint _e299 = explicit_shape.z;
    local_16 = uint((base + 14u));
    uint _e307 = local_16;
    _group_0_binding_0_cs[_e307] = ((_e296 + (10u * _e293)) + (100u * _e299));
    uint _e311 = braced_shape.y;
    uint _e314 = braced_shape.x;
    uint _e317 = braced_shape.z;
    local_17 = uint((base + 15u));
    uint _e325 = local_17;
    _group_0_binding_0_cs[_e325] = ((_e314 + (10u * _e311)) + (100u * _e317));
    int _e328 = copied_decltype_value_int(7);
    local_18 = uint((base + 16u));
    uint _e334 = local_18;
    _group_0_binding_0_cs[_e334] = uint(_e328);
    int _e337 = copied_decltype_value_unsigned(9u);
    local_19 = uint((base + 17u));
    uint _e343 = local_19;
    _group_0_binding_0_cs[_e343] = uint(_e337);
    Hidden = 3;
    outer_copy = 4;
    int _e349 = outer_copy;
    local_20 = uint((base + 18u));
    uint _e355 = local_20;
    _group_0_binding_0_cs[_e355] = uint(_e349);
    {
        Hidden_1 = 2.0;
        inner_copy = 3.0;
        float _e361 = inner_copy;
        local_21 = uint((base + 19u));
        uint _e367 = local_21;
        local_27 = _e367;
        uint _e369 = local_27;
        _group_0_binding_0_cs[_e369] = uint(_e361);
    }
    after_copy = 5;
    int _e373 = after_copy;
    local_22 = uint((base + 20u));
    uint _e379 = local_22;
    _group_0_binding_0_cs[_e379] = uint(_e373);
    old_nullptr_value();
    local_23 = uint((base + 21u));
    uint _e387 = local_23;
    _group_0_binding_0_cs[_e387] = uint(true);
    singles[0].x = 2.0;
    singles[1].x = 5.0;
    triples[0].x = 1.0;
    triples[0].y = 2.0;
    triples[0].z = 3.0;
    triples[1].x = 4.0;
    triples[1].y = 5.0;
    triples[1].z = 6.0;
    float _e414 = singles[1].x;
    local_24 = uint((base + 22u));
    uint _e420 = local_24;
    _group_0_binding_0_cs[_e420] = uint(_e414);
    float _e425 = triples[1].z;
    local_25 = uint((base + 23u));
    uint _e431 = local_25;
    _group_0_binding_0_cs[_e431] = uint(_e425);
    expression.tag = 10;
    expression.vector.x = 11.0;
    expression.vector.y = 12.0;
    expression.vector.z = 13.0;
    int _e444 = expression.tag;
    float _e448 = expression.vector.z;
    local_26 = uint((base + 24u));
    uint _e455 = local_26;
    _group_0_binding_0_cs[_e455] = (uint(_e444) + uint(_e448));
}

