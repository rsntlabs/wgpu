struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

struct DecltypeRecord_cuda_record_0_ {
    tag: i32,
    vector: float3_,
}

struct float1_ {
    x: f32,
}

struct dim3_ {
    x: u32,
    y: u32,
    z: u32,
}

const GlobalWord: u32 = 7u;

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

fn global_decltype_value() -> u32 {
    return GlobalWord;
}

fn old_nullptr_value() {
    return;
}

fn vector_decltype_kind(value: float1_) -> i32 {
    var value_1: float1_;

    value_1 = value;
    return 2i;
}

fn copied_decltype_value_int(value_2: i32) -> i32 {
    return value_2;
}

fn copied_decltype_value_unsigned(value_3: u32) -> i32 {
    return i32(value_3);
}

@compute @workgroup_size(4, 1, 1)
fn decltype_objects(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var source: i32;
    var counter: i32;
    var local: u32;
    var mutable_value: i32;
    var frozen_value: i32;
    var Constant: i32;
    var mutable_copy: i32;
    var frozen_copy: i32;
    var constant_copy: i32;
    var local_1: u32;
    var local_2: i32;
    var local_3: u32;
    var local_4: i32;
    var local_5: u32;
    var local_6: i32;
    var local_7: u32;
    var one: float1_;
    var one_copy: float1_;
    var two: vec2<f32>;
    var two_copy: vec2<f32>;
    var three: float3_;
    var three_copy: float3_;
    var four: vec4<f32>;
    var four_copy: vec4<f32>;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var record: DecltypeRecord_cuda_record_0_;
    var record_copy: DecltypeRecord_cuda_record_0_;
    var records: array<DecltypeRecord_cuda_record_0_, 2>;
    var local_13: u32;
    var local_14: u32;
    var shape: dim3_;
    var default_shape: dim3_;
    var explicit_shape: dim3_;
    var braced_shape: dim3_;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var Hidden: i32;
    var outer_copy: i32;
    var local_20: u32;
    var Hidden_1: f32;
    var inner_copy: f32;
    var local_21: u32;
    var after_copy: i32;
    var local_22: u32;
    var local_23: u32;
    var singles: array<float1_, 2>;
    var triples: array<float3_, 2>;
    var local_24: u32;
    var local_25: u32;
    var expression: DecltypeRecord_cuda_record_0_;
    var local_26: u32;
    var local_27: u32;

    let lane = threadIdx.x;
    let base = (4u + (lane * 25u));
    source = 1i;
    counter = (i32(lane) + 1i);
    let first = counter;
    counter = (first + 1i);
    let second = counter;
    counter = (second + 1i);
    let third = counter;
    counter = (third + 1i);
    let fourth = counter;
    counter = (fourth + 1i);
    let fifth = counter;
    counter = (fifth + 1i);
    let sixth = counter;
    counter = (sixth + 1i);
    let seventh = counter;
    counter = (seventh + 1i);
    output[base] = u32(((((((first + second) + third) + fourth) + fifth) + sixth) + seventh));
    let _e42 = counter;
    local = u32((base + 1u));
    let _e48 = local;
    output[_e48] = u32(_e42);
    mutable_value = 1i;
    frozen_value = 2i;
    Constant = 3i;
    mutable_copy = 4i;
    frozen_copy = 5i;
    constant_copy = 6i;
    local_2 = 1i;
    let _e64 = local_2;
    local_1 = u32((base + 2u));
    let _e70 = local_1;
    output[_e70] = u32(_e64);
    local_4 = 2i;
    let _e74 = local_4;
    local_3 = u32((base + 3u));
    let _e80 = local_3;
    output[_e80] = u32(_e74);
    local_6 = 2i;
    let _e84 = local_6;
    local_5 = u32((base + 4u));
    let _e90 = local_5;
    output[_e90] = u32(_e84);
    let _e92 = global_decltype_value();
    local_7 = u32((base + 5u));
    let _e97 = local_7;
    output[_e97] = _e92;
    one = float1_(2f);
    one_copy.x = 3f;
    two = vec2<f32>(1f, 2f);
    two_copy.x = 3f;
    two_copy.y = 4f;
    three = float3_(1f, 2f, 3f);
    three_copy.x = 4f;
    three_copy.y = 5f;
    three_copy.z = 6f;
    four = vec4<f32>(1f, 2f, 3f, 4f);
    four_copy.x = 5f;
    four_copy.y = 6f;
    four_copy.z = 7f;
    four_copy.w = 8f;
    let _e142 = one_copy.x;
    local_8 = u32((base + 6u));
    let _e148 = local_8;
    output[_e148] = u32(_e142);
    let _e150 = one_copy;
    let _e151 = vector_decltype_kind(_e150);
    local_9 = u32((base + 7u));
    let _e157 = local_9;
    output[_e157] = u32(_e151);
    let _e160 = two_copy.y;
    local_10 = u32((base + 8u));
    let _e166 = local_10;
    output[_e166] = u32(_e160);
    let _e169 = three_copy.z;
    local_11 = u32((base + 9u));
    let _e175 = local_11;
    output[_e175] = u32(_e169);
    let _e178 = four_copy.w;
    local_12 = u32((base + 10u));
    let _e184 = local_12;
    output[_e184] = u32(_e178);
    record.tag = 1i;
    record.vector.x = 2f;
    record.vector.y = 3f;
    record.vector.z = 4f;
    record_copy.tag = 9i;
    record_copy.vector.x = 5f;
    record_copy.vector.y = 6f;
    record_copy.vector.z = 7f;
    records[0].tag = 2i;
    records[0].vector.x = 3f;
    records[0].vector.y = 4f;
    records[0].vector.z = 5f;
    records[1].tag = 6i;
    records[1].vector.x = 7f;
    records[1].vector.y = 8f;
    records[1].vector.z = 9f;
    let _e228 = record_copy.tag;
    let _e232 = record_copy.vector.y;
    local_13 = u32((base + 11u));
    let _e239 = local_13;
    output[_e239] = (u32(_e228) + u32(_e232));
    let _e245 = records[1i].vector.z;
    local_14 = u32((base + 12u));
    let _e251 = local_14;
    output[_e251] = u32(_e245);
    shape = dim3_(1u, 1u, 1u);
    default_shape = dim3_(1u, 1u, 1u);
    explicit_shape = dim3_(2u, 3u, 1u);
    braced_shape = dim3_(4u, 5u, 1u);
    let _e275 = default_shape.y;
    let _e278 = default_shape.x;
    let _e281 = default_shape.z;
    local_15 = u32((base + 13u));
    let _e289 = local_15;
    output[_e289] = ((_e278 + (10u * _e275)) + (100u * _e281));
    let _e293 = explicit_shape.y;
    let _e296 = explicit_shape.x;
    let _e299 = explicit_shape.z;
    local_16 = u32((base + 14u));
    let _e307 = local_16;
    output[_e307] = ((_e296 + (10u * _e293)) + (100u * _e299));
    let _e311 = braced_shape.y;
    let _e314 = braced_shape.x;
    let _e317 = braced_shape.z;
    local_17 = u32((base + 15u));
    let _e325 = local_17;
    output[_e325] = ((_e314 + (10u * _e311)) + (100u * _e317));
    let _e328 = copied_decltype_value_int(7i);
    local_18 = u32((base + 16u));
    let _e334 = local_18;
    output[_e334] = u32(_e328);
    let _e337 = copied_decltype_value_unsigned(9u);
    local_19 = u32((base + 17u));
    let _e343 = local_19;
    output[_e343] = u32(_e337);
    Hidden = 3i;
    outer_copy = 4i;
    let _e349 = outer_copy;
    local_20 = u32((base + 18u));
    let _e355 = local_20;
    output[_e355] = u32(_e349);
    {
        Hidden_1 = 2f;
        inner_copy = 3f;
        let _e361 = inner_copy;
        local_21 = u32((base + 19u));
        let _e367 = local_21;
        local_27 = _e367;
        let _e369 = local_27;
        output[_e369] = u32(_e361);
    }
    after_copy = 5i;
    let _e373 = after_copy;
    local_22 = u32((base + 20u));
    let _e379 = local_22;
    output[_e379] = u32(_e373);
    old_nullptr_value();
    local_23 = u32((base + 21u));
    let _e387 = local_23;
    output[_e387] = u32(true);
    singles[0].x = 2f;
    singles[1].x = 5f;
    triples[0].x = 1f;
    triples[0].y = 2f;
    triples[0].z = 3f;
    triples[1].x = 4f;
    triples[1].y = 5f;
    triples[1].z = 6f;
    let _e414 = singles[1i].x;
    local_24 = u32((base + 22u));
    let _e420 = local_24;
    output[_e420] = u32(_e414);
    let _e425 = triples[1i].z;
    local_25 = u32((base + 23u));
    let _e431 = local_25;
    output[_e431] = u32(_e425);
    expression.tag = 10i;
    expression.vector.x = 11f;
    expression.vector.y = 12f;
    expression.vector.z = 13f;
    let _e444 = expression.tag;
    let _e448 = expression.vector.z;
    local_26 = u32((base + 24u));
    let _e455 = local_26;
    output[_e455] = (u32(_e444) + u32(_e448));
}
