struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

struct int3_ {
    x: i32,
    y: i32,
    z: i32,
}

struct uint3_ {
    x: u32,
    y: u32,
    z: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn operator_u002b(left: vec2<f32>, right: vec2<f32>) -> vec2<f32> {
    var left_1: vec2<f32>;
    var right_1: vec2<f32>;

    left_1 = left;
    right_1 = right;
    let _e6 = left_1.x;
    let _e7 = right_1.x;
    let _e11 = left_1.y;
    let _e12 = right_1.y;
    return vec2<f32>((_e6 + _e7), (_e11 + _e12));
}

fn operator_u002b_1(left_2: vec2<f32>, right_2: f32) -> vec2<f32> {
    var left_3: vec2<f32>;

    left_3 = left_2;
    let _e4 = left_3.x;
    let _e7 = left_3.y;
    return vec2<f32>((_e4 + right_2), (_e7 + right_2));
}

fn operator_u002b_2(left_4: f32, right_3: vec2<f32>) -> vec2<f32> {
    var right_4: vec2<f32>;

    right_4 = right_3;
    let _e4 = right_4.x;
    let _e7 = right_4.y;
    return vec2<f32>((left_4 + _e4), (left_4 + _e7));
}

fn operator_u002b_3(left_5: float3_, right_5: float3_) -> float3_ {
    var left_6: float3_;
    var right_6: float3_;

    left_6 = left_5;
    right_6 = right_5;
    let _e6 = left_6.x;
    let _e7 = right_6.x;
    let _e11 = left_6.y;
    let _e12 = right_6.y;
    let _e16 = left_6.z;
    let _e17 = right_6.z;
    return float3_((_e6 + _e7), (_e11 + _e12), (_e16 + _e17));
}

fn operator_u002b_4(left_7: float3_, right_7: f32) -> float3_ {
    var left_8: float3_;

    left_8 = left_7;
    let _e4 = left_8.x;
    let _e7 = left_8.y;
    let _e10 = left_8.z;
    return float3_((_e4 + right_7), (_e7 + right_7), (_e10 + right_7));
}

fn operator_u002b_5(left_9: f32, right_8: float3_) -> float3_ {
    var right_9: float3_;

    right_9 = right_8;
    let _e4 = right_9.x;
    let _e7 = right_9.y;
    let _e10 = right_9.z;
    return float3_((left_9 + _e4), (left_9 + _e7), (left_9 + _e10));
}

fn operator_u002b_6(left_10: vec4<f32>, right_10: vec4<f32>) -> vec4<f32> {
    var left_11: vec4<f32>;
    var right_11: vec4<f32>;

    left_11 = left_10;
    right_11 = right_10;
    let _e6 = left_11.x;
    let _e7 = right_11.x;
    let _e11 = left_11.y;
    let _e12 = right_11.y;
    let _e16 = left_11.z;
    let _e17 = right_11.z;
    let _e21 = left_11.w;
    let _e22 = right_11.w;
    return vec4<f32>((_e6 + _e7), (_e11 + _e12), (_e16 + _e17), (_e21 + _e22));
}

fn operator_u002b_7(left_12: vec4<f32>, right_12: f32) -> vec4<f32> {
    var left_13: vec4<f32>;

    left_13 = left_12;
    let _e4 = left_13.x;
    let _e7 = left_13.y;
    let _e10 = left_13.z;
    let _e13 = left_13.w;
    return vec4<f32>((_e4 + right_12), (_e7 + right_12), (_e10 + right_12), (_e13 + right_12));
}

fn operator_u002b_8(left_14: f32, right_13: vec4<f32>) -> vec4<f32> {
    var right_14: vec4<f32>;

    right_14 = right_13;
    let _e4 = right_14.x;
    let _e7 = right_14.y;
    let _e10 = right_14.z;
    let _e13 = right_14.w;
    return vec4<f32>((left_14 + _e4), (left_14 + _e7), (left_14 + _e10), (left_14 + _e13));
}

fn operator_u002b_9(left_15: vec2<i32>, right_15: vec2<i32>) -> vec2<i32> {
    var left_16: vec2<i32>;
    var right_16: vec2<i32>;

    left_16 = left_15;
    right_16 = right_15;
    let _e6 = left_16.x;
    let _e7 = right_16.x;
    let _e11 = left_16.y;
    let _e12 = right_16.y;
    return vec2<i32>((_e6 + _e7), (_e11 + _e12));
}

fn operator_u002b_10(left_17: vec2<i32>, right_17: i32) -> vec2<i32> {
    var left_18: vec2<i32>;

    left_18 = left_17;
    let _e4 = left_18.x;
    let _e7 = left_18.y;
    return vec2<i32>((_e4 + right_17), (_e7 + right_17));
}

fn operator_u002b_11(left_19: i32, right_18: vec2<i32>) -> vec2<i32> {
    var right_19: vec2<i32>;

    right_19 = right_18;
    let _e4 = right_19.x;
    let _e7 = right_19.y;
    return vec2<i32>((left_19 + _e4), (left_19 + _e7));
}

fn operator_u002b_12(left_20: int3_, right_20: int3_) -> int3_ {
    var left_21: int3_;
    var right_21: int3_;

    left_21 = left_20;
    right_21 = right_20;
    let _e6 = left_21.x;
    let _e7 = right_21.x;
    let _e11 = left_21.y;
    let _e12 = right_21.y;
    let _e16 = left_21.z;
    let _e17 = right_21.z;
    return int3_((_e6 + _e7), (_e11 + _e12), (_e16 + _e17));
}

fn operator_u002b_13(left_22: int3_, right_22: i32) -> int3_ {
    var left_23: int3_;

    left_23 = left_22;
    let _e4 = left_23.x;
    let _e7 = left_23.y;
    let _e10 = left_23.z;
    return int3_((_e4 + right_22), (_e7 + right_22), (_e10 + right_22));
}

fn operator_u002b_14(left_24: i32, right_23: int3_) -> int3_ {
    var right_24: int3_;

    right_24 = right_23;
    let _e4 = right_24.x;
    let _e7 = right_24.y;
    let _e10 = right_24.z;
    return int3_((left_24 + _e4), (left_24 + _e7), (left_24 + _e10));
}

fn operator_u002b_15(left_25: vec4<i32>, right_25: vec4<i32>) -> vec4<i32> {
    var left_26: vec4<i32>;
    var right_26: vec4<i32>;

    left_26 = left_25;
    right_26 = right_25;
    let _e6 = left_26.x;
    let _e7 = right_26.x;
    let _e11 = left_26.y;
    let _e12 = right_26.y;
    let _e16 = left_26.z;
    let _e17 = right_26.z;
    let _e21 = left_26.w;
    let _e22 = right_26.w;
    return vec4<i32>((_e6 + _e7), (_e11 + _e12), (_e16 + _e17), (_e21 + _e22));
}

fn operator_u002b_16(left_27: vec4<i32>, right_27: i32) -> vec4<i32> {
    var left_28: vec4<i32>;

    left_28 = left_27;
    let _e4 = left_28.x;
    let _e7 = left_28.y;
    let _e10 = left_28.z;
    let _e13 = left_28.w;
    return vec4<i32>((_e4 + right_27), (_e7 + right_27), (_e10 + right_27), (_e13 + right_27));
}

fn operator_u002b_17(left_29: i32, right_28: vec4<i32>) -> vec4<i32> {
    var right_29: vec4<i32>;

    right_29 = right_28;
    let _e4 = right_29.x;
    let _e7 = right_29.y;
    let _e10 = right_29.z;
    let _e13 = right_29.w;
    return vec4<i32>((left_29 + _e4), (left_29 + _e7), (left_29 + _e10), (left_29 + _e13));
}

fn operator_u002b_18(left_30: vec2<u32>, right_30: vec2<u32>) -> vec2<u32> {
    var left_31: vec2<u32>;
    var right_31: vec2<u32>;

    left_31 = left_30;
    right_31 = right_30;
    let _e6 = left_31.x;
    let _e7 = right_31.x;
    let _e11 = left_31.y;
    let _e12 = right_31.y;
    return vec2<u32>((_e6 + _e7), (_e11 + _e12));
}

fn operator_u002b_19(left_32: vec2<u32>, right_32: u32) -> vec2<u32> {
    var left_33: vec2<u32>;

    left_33 = left_32;
    let _e4 = left_33.x;
    let _e7 = left_33.y;
    return vec2<u32>((_e4 + right_32), (_e7 + right_32));
}

fn operator_u002b_20(left_34: u32, right_33: vec2<u32>) -> vec2<u32> {
    var right_34: vec2<u32>;

    right_34 = right_33;
    let _e4 = right_34.x;
    let _e7 = right_34.y;
    return vec2<u32>((left_34 + _e4), (left_34 + _e7));
}

fn operator_u002b_21(left_35: uint3_, right_35: uint3_) -> uint3_ {
    var left_36: uint3_;
    var right_36: uint3_;

    left_36 = left_35;
    right_36 = right_35;
    let _e6 = left_36.x;
    let _e7 = right_36.x;
    let _e11 = left_36.y;
    let _e12 = right_36.y;
    let _e16 = left_36.z;
    let _e17 = right_36.z;
    return uint3_((_e6 + _e7), (_e11 + _e12), (_e16 + _e17));
}

fn operator_u002b_22(left_37: uint3_, right_37: u32) -> uint3_ {
    var left_38: uint3_;

    left_38 = left_37;
    let _e4 = left_38.x;
    let _e7 = left_38.y;
    let _e10 = left_38.z;
    return uint3_((_e4 + right_37), (_e7 + right_37), (_e10 + right_37));
}

fn operator_u002b_23(left_39: u32, right_38: uint3_) -> uint3_ {
    var right_39: uint3_;

    right_39 = right_38;
    let _e4 = right_39.x;
    let _e7 = right_39.y;
    let _e10 = right_39.z;
    return uint3_((left_39 + _e4), (left_39 + _e7), (left_39 + _e10));
}

fn operator_u002b_24(left_40: vec4<u32>, right_40: vec4<u32>) -> vec4<u32> {
    var left_41: vec4<u32>;
    var right_41: vec4<u32>;

    left_41 = left_40;
    right_41 = right_40;
    let _e6 = left_41.x;
    let _e7 = right_41.x;
    let _e11 = left_41.y;
    let _e12 = right_41.y;
    let _e16 = left_41.z;
    let _e17 = right_41.z;
    let _e21 = left_41.w;
    let _e22 = right_41.w;
    return vec4<u32>((_e6 + _e7), (_e11 + _e12), (_e16 + _e17), (_e21 + _e22));
}

fn operator_u002b_25(left_42: vec4<u32>, right_42: u32) -> vec4<u32> {
    var left_43: vec4<u32>;

    left_43 = left_42;
    let _e4 = left_43.x;
    let _e7 = left_43.y;
    let _e10 = left_43.z;
    let _e13 = left_43.w;
    return vec4<u32>((_e4 + right_42), (_e7 + right_42), (_e10 + right_42), (_e13 + right_42));
}

fn operator_u002b_26(left_44: u32, right_43: vec4<u32>) -> vec4<u32> {
    var right_44: vec4<u32>;

    right_44 = right_43;
    let _e4 = right_44.x;
    let _e7 = right_44.y;
    let _e10 = right_44.z;
    let _e13 = right_44.w;
    return vec4<u32>((left_44 + _e4), (left_44 + _e7), (left_44 + _e10), (left_44 + _e13));
}

@compute @workgroup_size(1, 1, 1)
fn additions() {
    var float_2_left: vec2<f32>;
    var float_2_right: vec2<f32>;
    var float_2_vectors: vec2<f32>;
    var float_2_vector_scalar: vec2<f32>;
    var float_2_scalar_vector: vec2<f32>;
    var float_3_left: float3_;
    var float_3_right: float3_;
    var float_3_vectors: float3_;
    var float_3_vector_scalar: float3_;
    var float_3_scalar_vector: float3_;
    var float_4_left: vec4<f32>;
    var float_4_right: vec4<f32>;
    var float_4_vectors: vec4<f32>;
    var float_4_vector_scalar: vec4<f32>;
    var float_4_scalar_vector: vec4<f32>;
    var int_2_left: vec2<i32>;
    var int_2_right: vec2<i32>;
    var int_2_vectors: vec2<i32>;
    var int_2_vector_scalar: vec2<i32>;
    var int_2_scalar_vector: vec2<i32>;
    var int_3_left: int3_;
    var int_3_right: int3_;
    var int_3_vectors: int3_;
    var int_3_vector_scalar: int3_;
    var int_3_scalar_vector: int3_;
    var int_4_left: vec4<i32>;
    var int_4_right: vec4<i32>;
    var int_4_vectors: vec4<i32>;
    var int_4_vector_scalar: vec4<i32>;
    var int_4_scalar_vector: vec4<i32>;
    var uint_2_left: vec2<u32>;
    var uint_2_right: vec2<u32>;
    var uint_2_vectors: vec2<u32>;
    var uint_2_vector_scalar: vec2<u32>;
    var uint_2_scalar_vector: vec2<u32>;
    var uint_3_left: uint3_;
    var uint_3_right: uint3_;
    var uint_3_vectors: uint3_;
    var uint_3_vector_scalar: uint3_;
    var uint_3_scalar_vector: uint3_;
    var uint_4_left: vec4<u32>;
    var uint_4_right: vec4<u32>;
    var uint_4_vectors: vec4<u32>;
    var uint_4_vector_scalar: vec4<u32>;
    var uint_4_scalar_vector: vec4<u32>;

    float_2_left = vec2<f32>(1.25f, -(2.5f));
    float_2_right = vec2<f32>(0.5f, 1.5f);
    let _e9 = float_2_left;
    let _e10 = float_2_right;
    let _e11 = operator_u002b(_e9, _e10);
    float_2_vectors = _e11;
    let _e13 = float_2_left;
    let _e15 = operator_u002b_1(_e13, 2f);
    float_2_vector_scalar = _e15;
    let _e17 = float_2_right;
    let _e19 = operator_u002b_2(2f, _e17);
    float_2_scalar_vector = _e19;
    let _e22 = float_2_vectors.x;
    out[u32(0i)] = bitcast<u32>(_e22);
    let _e29 = float_2_vectors.y;
    out[u32(1i)] = bitcast<u32>(_e29);
    let _e35 = float_2_vector_scalar.x;
    out[u32(2i)] = bitcast<u32>(_e35);
    let _e41 = float_2_vector_scalar.y;
    out[u32(3i)] = bitcast<u32>(_e41);
    let _e47 = float_2_scalar_vector.x;
    out[u32(4i)] = bitcast<u32>(_e47);
    let _e53 = float_2_scalar_vector.y;
    out[u32(5i)] = bitcast<u32>(_e53);
    float_3_left = float3_(1.25f, -(2.5f), 3.75f);
    float_3_right = float3_(0.5f, 1.5f, -(2f));
    let _e70 = float_3_left;
    let _e71 = float_3_right;
    let _e72 = operator_u002b_3(_e70, _e71);
    float_3_vectors = _e72;
    let _e74 = float_3_left;
    let _e76 = operator_u002b_4(_e74, 2f);
    float_3_vector_scalar = _e76;
    let _e78 = float_3_right;
    let _e80 = operator_u002b_5(2f, _e78);
    float_3_scalar_vector = _e80;
    let _e83 = float_3_vectors.x;
    out[u32(6i)] = bitcast<u32>(_e83);
    let _e89 = float_3_vectors.y;
    out[u32(7i)] = bitcast<u32>(_e89);
    let _e95 = float_3_vectors.z;
    out[u32(8i)] = bitcast<u32>(_e95);
    let _e101 = float_3_vector_scalar.x;
    out[u32(9i)] = bitcast<u32>(_e101);
    let _e107 = float_3_vector_scalar.y;
    out[u32(10i)] = bitcast<u32>(_e107);
    let _e113 = float_3_vector_scalar.z;
    out[u32(11i)] = bitcast<u32>(_e113);
    let _e119 = float_3_scalar_vector.x;
    out[u32(12i)] = bitcast<u32>(_e119);
    let _e125 = float_3_scalar_vector.y;
    out[u32(13i)] = bitcast<u32>(_e125);
    let _e131 = float_3_scalar_vector.z;
    out[u32(14i)] = bitcast<u32>(_e131);
    float_4_left = vec4<f32>(1.25f, -(2.5f), 3.75f, -(4f));
    float_4_right = vec4<f32>(0.5f, 1.5f, -(2f), 0.25f);
    let _e151 = float_4_left;
    let _e152 = float_4_right;
    let _e153 = operator_u002b_6(_e151, _e152);
    float_4_vectors = _e153;
    let _e155 = float_4_left;
    let _e157 = operator_u002b_7(_e155, 2f);
    float_4_vector_scalar = _e157;
    let _e159 = float_4_right;
    let _e161 = operator_u002b_8(2f, _e159);
    float_4_scalar_vector = _e161;
    let _e164 = float_4_vectors.x;
    out[u32(15i)] = bitcast<u32>(_e164);
    let _e170 = float_4_vectors.y;
    out[u32(16i)] = bitcast<u32>(_e170);
    let _e176 = float_4_vectors.z;
    out[u32(17i)] = bitcast<u32>(_e176);
    let _e182 = float_4_vectors.w;
    out[u32(18i)] = bitcast<u32>(_e182);
    let _e188 = float_4_vector_scalar.x;
    out[u32(19i)] = bitcast<u32>(_e188);
    let _e194 = float_4_vector_scalar.y;
    out[u32(20i)] = bitcast<u32>(_e194);
    let _e200 = float_4_vector_scalar.z;
    out[u32(21i)] = bitcast<u32>(_e200);
    let _e206 = float_4_vector_scalar.w;
    out[u32(22i)] = bitcast<u32>(_e206);
    let _e212 = float_4_scalar_vector.x;
    out[u32(23i)] = bitcast<u32>(_e212);
    let _e218 = float_4_scalar_vector.y;
    out[u32(24i)] = bitcast<u32>(_e218);
    let _e224 = float_4_scalar_vector.z;
    out[u32(25i)] = bitcast<u32>(_e224);
    let _e230 = float_4_scalar_vector.w;
    out[u32(26i)] = bitcast<u32>(_e230);
    int_2_left = vec2<i32>(1i, -(2i));
    int_2_right = vec2<i32>(5i, 6i);
    let _e244 = int_2_left;
    let _e245 = int_2_right;
    let _e246 = operator_u002b_9(_e244, _e245);
    int_2_vectors = _e246;
    let _e248 = int_2_left;
    let _e250 = operator_u002b_10(_e248, 3i);
    int_2_vector_scalar = _e250;
    let _e252 = int_2_right;
    let _e254 = operator_u002b_11(3i, _e252);
    int_2_scalar_vector = _e254;
    let _e257 = int_2_vectors.x;
    out[u32(27i)] = u32(_e257);
    let _e263 = int_2_vectors.y;
    out[u32(28i)] = u32(_e263);
    let _e269 = int_2_vector_scalar.x;
    out[u32(29i)] = u32(_e269);
    let _e275 = int_2_vector_scalar.y;
    out[u32(30i)] = u32(_e275);
    let _e281 = int_2_scalar_vector.x;
    out[u32(31i)] = u32(_e281);
    let _e287 = int_2_scalar_vector.y;
    out[u32(32i)] = u32(_e287);
    int_3_left = int3_(1i, -(2i), 3i);
    int_3_right = int3_(5i, 6i, -(7i));
    let _e304 = int_3_left;
    let _e305 = int_3_right;
    let _e306 = operator_u002b_12(_e304, _e305);
    int_3_vectors = _e306;
    let _e308 = int_3_left;
    let _e310 = operator_u002b_13(_e308, 3i);
    int_3_vector_scalar = _e310;
    let _e312 = int_3_right;
    let _e314 = operator_u002b_14(3i, _e312);
    int_3_scalar_vector = _e314;
    let _e317 = int_3_vectors.x;
    out[u32(33i)] = u32(_e317);
    let _e323 = int_3_vectors.y;
    out[u32(34i)] = u32(_e323);
    let _e329 = int_3_vectors.z;
    out[u32(35i)] = u32(_e329);
    let _e335 = int_3_vector_scalar.x;
    out[u32(36i)] = u32(_e335);
    let _e341 = int_3_vector_scalar.y;
    out[u32(37i)] = u32(_e341);
    let _e347 = int_3_vector_scalar.z;
    out[u32(38i)] = u32(_e347);
    let _e353 = int_3_scalar_vector.x;
    out[u32(39i)] = u32(_e353);
    let _e359 = int_3_scalar_vector.y;
    out[u32(40i)] = u32(_e359);
    let _e365 = int_3_scalar_vector.z;
    out[u32(41i)] = u32(_e365);
    int_4_left = vec4<i32>(1i, -(2i), 3i, -(4i));
    int_4_right = vec4<i32>(5i, 6i, -(7i), 8i);
    let _e385 = int_4_left;
    let _e386 = int_4_right;
    let _e387 = operator_u002b_15(_e385, _e386);
    int_4_vectors = _e387;
    let _e389 = int_4_left;
    let _e391 = operator_u002b_16(_e389, 3i);
    int_4_vector_scalar = _e391;
    let _e393 = int_4_right;
    let _e395 = operator_u002b_17(3i, _e393);
    int_4_scalar_vector = _e395;
    let _e398 = int_4_vectors.x;
    out[u32(42i)] = u32(_e398);
    let _e404 = int_4_vectors.y;
    out[u32(43i)] = u32(_e404);
    let _e410 = int_4_vectors.z;
    out[u32(44i)] = u32(_e410);
    let _e416 = int_4_vectors.w;
    out[u32(45i)] = u32(_e416);
    let _e422 = int_4_vector_scalar.x;
    out[u32(46i)] = u32(_e422);
    let _e428 = int_4_vector_scalar.y;
    out[u32(47i)] = u32(_e428);
    let _e434 = int_4_vector_scalar.z;
    out[u32(48i)] = u32(_e434);
    let _e440 = int_4_vector_scalar.w;
    out[u32(49i)] = u32(_e440);
    let _e446 = int_4_scalar_vector.x;
    out[u32(50i)] = u32(_e446);
    let _e452 = int_4_scalar_vector.y;
    out[u32(51i)] = u32(_e452);
    let _e458 = int_4_scalar_vector.z;
    out[u32(52i)] = u32(_e458);
    let _e464 = int_4_scalar_vector.w;
    out[u32(53i)] = u32(_e464);
    uint_2_left = vec2<u32>(4294967294u, 2147483649u);
    uint_2_right = vec2<u32>(5u, 2u);
    let _e477 = uint_2_left;
    let _e478 = uint_2_right;
    let _e479 = operator_u002b_18(_e477, _e478);
    uint_2_vectors = _e479;
    let _e481 = uint_2_left;
    let _e483 = operator_u002b_19(_e481, 4u);
    uint_2_vector_scalar = _e483;
    let _e485 = uint_2_right;
    let _e487 = operator_u002b_20(4u, _e485);
    uint_2_scalar_vector = _e487;
    let _e490 = uint_2_vectors.x;
    out[u32(54i)] = _e490;
    let _e495 = uint_2_vectors.y;
    out[u32(55i)] = _e495;
    let _e500 = uint_2_vector_scalar.x;
    out[u32(56i)] = _e500;
    let _e505 = uint_2_vector_scalar.y;
    out[u32(57i)] = _e505;
    let _e510 = uint_2_scalar_vector.x;
    out[u32(58i)] = _e510;
    let _e515 = uint_2_scalar_vector.y;
    out[u32(59i)] = _e515;
    uint_3_left = uint3_(4294967294u, 2147483649u, 3u);
    uint_3_right = uint3_(5u, 2u, 4294967293u);
    let _e529 = uint_3_left;
    let _e530 = uint_3_right;
    let _e531 = operator_u002b_21(_e529, _e530);
    uint_3_vectors = _e531;
    let _e533 = uint_3_left;
    let _e535 = operator_u002b_22(_e533, 4u);
    uint_3_vector_scalar = _e535;
    let _e537 = uint_3_right;
    let _e539 = operator_u002b_23(4u, _e537);
    uint_3_scalar_vector = _e539;
    let _e542 = uint_3_vectors.x;
    out[u32(60i)] = _e542;
    let _e547 = uint_3_vectors.y;
    out[u32(61i)] = _e547;
    let _e552 = uint_3_vectors.z;
    out[u32(62i)] = _e552;
    let _e557 = uint_3_vector_scalar.x;
    out[u32(63i)] = _e557;
    let _e562 = uint_3_vector_scalar.y;
    out[u32(64i)] = _e562;
    let _e567 = uint_3_vector_scalar.z;
    out[u32(65i)] = _e567;
    let _e572 = uint_3_scalar_vector.x;
    out[u32(66i)] = _e572;
    let _e577 = uint_3_scalar_vector.y;
    out[u32(67i)] = _e577;
    let _e582 = uint_3_scalar_vector.z;
    out[u32(68i)] = _e582;
    uint_4_left = vec4<u32>(4294967294u, 2147483649u, 3u, 4294967295u);
    uint_4_right = vec4<u32>(5u, 2u, 4294967293u, 1u);
    let _e598 = uint_4_left;
    let _e599 = uint_4_right;
    let _e600 = operator_u002b_24(_e598, _e599);
    uint_4_vectors = _e600;
    let _e602 = uint_4_left;
    let _e604 = operator_u002b_25(_e602, 4u);
    uint_4_vector_scalar = _e604;
    let _e606 = uint_4_right;
    let _e608 = operator_u002b_26(4u, _e606);
    uint_4_scalar_vector = _e608;
    let _e611 = uint_4_vectors.x;
    out[u32(69i)] = _e611;
    let _e616 = uint_4_vectors.y;
    out[u32(70i)] = _e616;
    let _e621 = uint_4_vectors.z;
    out[u32(71i)] = _e621;
    let _e626 = uint_4_vectors.w;
    out[u32(72i)] = _e626;
    let _e631 = uint_4_vector_scalar.x;
    out[u32(73i)] = _e631;
    let _e636 = uint_4_vector_scalar.y;
    out[u32(74i)] = _e636;
    let _e641 = uint_4_vector_scalar.z;
    out[u32(75i)] = _e641;
    let _e646 = uint_4_vector_scalar.w;
    out[u32(76i)] = _e646;
    let _e651 = uint_4_scalar_vector.x;
    out[u32(77i)] = _e651;
    let _e656 = uint_4_scalar_vector.y;
    out[u32(78i)] = _e656;
    let _e661 = uint_4_scalar_vector.z;
    out[u32(79i)] = _e661;
    let _e666 = uint_4_scalar_vector.w;
    out[u32(80i)] = _e666;
}
