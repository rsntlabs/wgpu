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
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var float_3_left: float3_;
    var float_3_right: float3_;
    var float_3_vectors: float3_;
    var float_3_vector_scalar: float3_;
    var float_3_scalar_vector: float3_;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var float_4_left: vec4<f32>;
    var float_4_right: vec4<f32>;
    var float_4_vectors: vec4<f32>;
    var float_4_vector_scalar: vec4<f32>;
    var float_4_scalar_vector: vec4<f32>;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var int_2_left: vec2<i32>;
    var int_2_right: vec2<i32>;
    var int_2_vectors: vec2<i32>;
    var int_2_vector_scalar: vec2<i32>;
    var int_2_scalar_vector: vec2<i32>;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var int_3_left: int3_;
    var int_3_right: int3_;
    var int_3_vectors: int3_;
    var int_3_vector_scalar: int3_;
    var int_3_scalar_vector: int3_;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var int_4_left: vec4<i32>;
    var int_4_right: vec4<i32>;
    var int_4_vectors: vec4<i32>;
    var int_4_vector_scalar: vec4<i32>;
    var int_4_scalar_vector: vec4<i32>;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var uint_2_left: vec2<u32>;
    var uint_2_right: vec2<u32>;
    var uint_2_vectors: vec2<u32>;
    var uint_2_vector_scalar: vec2<u32>;
    var uint_2_scalar_vector: vec2<u32>;
    var local_54: u32;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var uint_3_left: uint3_;
    var uint_3_right: uint3_;
    var uint_3_vectors: uint3_;
    var uint_3_vector_scalar: uint3_;
    var uint_3_scalar_vector: uint3_;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;
    var local_66: u32;
    var local_67: u32;
    var local_68: u32;
    var uint_4_left: vec4<u32>;
    var uint_4_right: vec4<u32>;
    var uint_4_vectors: vec4<u32>;
    var uint_4_vector_scalar: vec4<u32>;
    var uint_4_scalar_vector: vec4<u32>;
    var local_69: u32;
    var local_70: u32;
    var local_71: u32;
    var local_72: u32;
    var local_73: u32;
    var local_74: u32;
    var local_75: u32;
    var local_76: u32;
    var local_77: u32;
    var local_78: u32;
    var local_79: u32;
    var local_80: u32;

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
    local = u32(0i);
    let _e27 = local;
    out[_e27] = bitcast<u32>(_e22);
    let _e31 = float_2_vectors.y;
    local_1 = u32(1i);
    let _e36 = local_1;
    out[_e36] = bitcast<u32>(_e31);
    let _e39 = float_2_vector_scalar.x;
    local_2 = u32(2i);
    let _e44 = local_2;
    out[_e44] = bitcast<u32>(_e39);
    let _e47 = float_2_vector_scalar.y;
    local_3 = u32(3i);
    let _e52 = local_3;
    out[_e52] = bitcast<u32>(_e47);
    let _e55 = float_2_scalar_vector.x;
    local_4 = u32(4i);
    let _e60 = local_4;
    out[_e60] = bitcast<u32>(_e55);
    let _e63 = float_2_scalar_vector.y;
    local_5 = u32(5i);
    let _e68 = local_5;
    out[_e68] = bitcast<u32>(_e63);
    float_3_left = float3_(1.25f, -(2.5f), 3.75f);
    float_3_right = float3_(0.5f, 1.5f, -(2f));
    let _e82 = float_3_left;
    let _e83 = float_3_right;
    let _e84 = operator_u002b_3(_e82, _e83);
    float_3_vectors = _e84;
    let _e86 = float_3_left;
    let _e88 = operator_u002b_4(_e86, 2f);
    float_3_vector_scalar = _e88;
    let _e90 = float_3_right;
    let _e92 = operator_u002b_5(2f, _e90);
    float_3_scalar_vector = _e92;
    let _e95 = float_3_vectors.x;
    local_6 = u32(6i);
    let _e100 = local_6;
    out[_e100] = bitcast<u32>(_e95);
    let _e103 = float_3_vectors.y;
    local_7 = u32(7i);
    let _e108 = local_7;
    out[_e108] = bitcast<u32>(_e103);
    let _e111 = float_3_vectors.z;
    local_8 = u32(8i);
    let _e116 = local_8;
    out[_e116] = bitcast<u32>(_e111);
    let _e119 = float_3_vector_scalar.x;
    local_9 = u32(9i);
    let _e124 = local_9;
    out[_e124] = bitcast<u32>(_e119);
    let _e127 = float_3_vector_scalar.y;
    local_10 = u32(10i);
    let _e132 = local_10;
    out[_e132] = bitcast<u32>(_e127);
    let _e135 = float_3_vector_scalar.z;
    local_11 = u32(11i);
    let _e140 = local_11;
    out[_e140] = bitcast<u32>(_e135);
    let _e143 = float_3_scalar_vector.x;
    local_12 = u32(12i);
    let _e148 = local_12;
    out[_e148] = bitcast<u32>(_e143);
    let _e151 = float_3_scalar_vector.y;
    local_13 = u32(13i);
    let _e156 = local_13;
    out[_e156] = bitcast<u32>(_e151);
    let _e159 = float_3_scalar_vector.z;
    local_14 = u32(14i);
    let _e164 = local_14;
    out[_e164] = bitcast<u32>(_e159);
    float_4_left = vec4<f32>(1.25f, -(2.5f), 3.75f, -(4f));
    float_4_right = vec4<f32>(0.5f, 1.5f, -(2f), 0.25f);
    let _e181 = float_4_left;
    let _e182 = float_4_right;
    let _e183 = operator_u002b_6(_e181, _e182);
    float_4_vectors = _e183;
    let _e185 = float_4_left;
    let _e187 = operator_u002b_7(_e185, 2f);
    float_4_vector_scalar = _e187;
    let _e189 = float_4_right;
    let _e191 = operator_u002b_8(2f, _e189);
    float_4_scalar_vector = _e191;
    let _e194 = float_4_vectors.x;
    local_15 = u32(15i);
    let _e199 = local_15;
    out[_e199] = bitcast<u32>(_e194);
    let _e202 = float_4_vectors.y;
    local_16 = u32(16i);
    let _e207 = local_16;
    out[_e207] = bitcast<u32>(_e202);
    let _e210 = float_4_vectors.z;
    local_17 = u32(17i);
    let _e215 = local_17;
    out[_e215] = bitcast<u32>(_e210);
    let _e218 = float_4_vectors.w;
    local_18 = u32(18i);
    let _e223 = local_18;
    out[_e223] = bitcast<u32>(_e218);
    let _e226 = float_4_vector_scalar.x;
    local_19 = u32(19i);
    let _e231 = local_19;
    out[_e231] = bitcast<u32>(_e226);
    let _e234 = float_4_vector_scalar.y;
    local_20 = u32(20i);
    let _e239 = local_20;
    out[_e239] = bitcast<u32>(_e234);
    let _e242 = float_4_vector_scalar.z;
    local_21 = u32(21i);
    let _e247 = local_21;
    out[_e247] = bitcast<u32>(_e242);
    let _e250 = float_4_vector_scalar.w;
    local_22 = u32(22i);
    let _e255 = local_22;
    out[_e255] = bitcast<u32>(_e250);
    let _e258 = float_4_scalar_vector.x;
    local_23 = u32(23i);
    let _e263 = local_23;
    out[_e263] = bitcast<u32>(_e258);
    let _e266 = float_4_scalar_vector.y;
    local_24 = u32(24i);
    let _e271 = local_24;
    out[_e271] = bitcast<u32>(_e266);
    let _e274 = float_4_scalar_vector.z;
    local_25 = u32(25i);
    let _e279 = local_25;
    out[_e279] = bitcast<u32>(_e274);
    let _e282 = float_4_scalar_vector.w;
    local_26 = u32(26i);
    let _e287 = local_26;
    out[_e287] = bitcast<u32>(_e282);
    int_2_left = vec2<i32>(1i, -(2i));
    int_2_right = vec2<i32>(5i, 6i);
    let _e298 = int_2_left;
    let _e299 = int_2_right;
    let _e300 = operator_u002b_9(_e298, _e299);
    int_2_vectors = _e300;
    let _e302 = int_2_left;
    let _e304 = operator_u002b_10(_e302, 3i);
    int_2_vector_scalar = _e304;
    let _e306 = int_2_right;
    let _e308 = operator_u002b_11(3i, _e306);
    int_2_scalar_vector = _e308;
    let _e311 = int_2_vectors.x;
    local_27 = u32(27i);
    let _e316 = local_27;
    out[_e316] = u32(_e311);
    let _e319 = int_2_vectors.y;
    local_28 = u32(28i);
    let _e324 = local_28;
    out[_e324] = u32(_e319);
    let _e327 = int_2_vector_scalar.x;
    local_29 = u32(29i);
    let _e332 = local_29;
    out[_e332] = u32(_e327);
    let _e335 = int_2_vector_scalar.y;
    local_30 = u32(30i);
    let _e340 = local_30;
    out[_e340] = u32(_e335);
    let _e343 = int_2_scalar_vector.x;
    local_31 = u32(31i);
    let _e348 = local_31;
    out[_e348] = u32(_e343);
    let _e351 = int_2_scalar_vector.y;
    local_32 = u32(32i);
    let _e356 = local_32;
    out[_e356] = u32(_e351);
    int_3_left = int3_(1i, -(2i), 3i);
    int_3_right = int3_(5i, 6i, -(7i));
    let _e370 = int_3_left;
    let _e371 = int_3_right;
    let _e372 = operator_u002b_12(_e370, _e371);
    int_3_vectors = _e372;
    let _e374 = int_3_left;
    let _e376 = operator_u002b_13(_e374, 3i);
    int_3_vector_scalar = _e376;
    let _e378 = int_3_right;
    let _e380 = operator_u002b_14(3i, _e378);
    int_3_scalar_vector = _e380;
    let _e383 = int_3_vectors.x;
    local_33 = u32(33i);
    let _e388 = local_33;
    out[_e388] = u32(_e383);
    let _e391 = int_3_vectors.y;
    local_34 = u32(34i);
    let _e396 = local_34;
    out[_e396] = u32(_e391);
    let _e399 = int_3_vectors.z;
    local_35 = u32(35i);
    let _e404 = local_35;
    out[_e404] = u32(_e399);
    let _e407 = int_3_vector_scalar.x;
    local_36 = u32(36i);
    let _e412 = local_36;
    out[_e412] = u32(_e407);
    let _e415 = int_3_vector_scalar.y;
    local_37 = u32(37i);
    let _e420 = local_37;
    out[_e420] = u32(_e415);
    let _e423 = int_3_vector_scalar.z;
    local_38 = u32(38i);
    let _e428 = local_38;
    out[_e428] = u32(_e423);
    let _e431 = int_3_scalar_vector.x;
    local_39 = u32(39i);
    let _e436 = local_39;
    out[_e436] = u32(_e431);
    let _e439 = int_3_scalar_vector.y;
    local_40 = u32(40i);
    let _e444 = local_40;
    out[_e444] = u32(_e439);
    let _e447 = int_3_scalar_vector.z;
    local_41 = u32(41i);
    let _e452 = local_41;
    out[_e452] = u32(_e447);
    int_4_left = vec4<i32>(1i, -(2i), 3i, -(4i));
    int_4_right = vec4<i32>(5i, 6i, -(7i), 8i);
    let _e469 = int_4_left;
    let _e470 = int_4_right;
    let _e471 = operator_u002b_15(_e469, _e470);
    int_4_vectors = _e471;
    let _e473 = int_4_left;
    let _e475 = operator_u002b_16(_e473, 3i);
    int_4_vector_scalar = _e475;
    let _e477 = int_4_right;
    let _e479 = operator_u002b_17(3i, _e477);
    int_4_scalar_vector = _e479;
    let _e482 = int_4_vectors.x;
    local_42 = u32(42i);
    let _e487 = local_42;
    out[_e487] = u32(_e482);
    let _e490 = int_4_vectors.y;
    local_43 = u32(43i);
    let _e495 = local_43;
    out[_e495] = u32(_e490);
    let _e498 = int_4_vectors.z;
    local_44 = u32(44i);
    let _e503 = local_44;
    out[_e503] = u32(_e498);
    let _e506 = int_4_vectors.w;
    local_45 = u32(45i);
    let _e511 = local_45;
    out[_e511] = u32(_e506);
    let _e514 = int_4_vector_scalar.x;
    local_46 = u32(46i);
    let _e519 = local_46;
    out[_e519] = u32(_e514);
    let _e522 = int_4_vector_scalar.y;
    local_47 = u32(47i);
    let _e527 = local_47;
    out[_e527] = u32(_e522);
    let _e530 = int_4_vector_scalar.z;
    local_48 = u32(48i);
    let _e535 = local_48;
    out[_e535] = u32(_e530);
    let _e538 = int_4_vector_scalar.w;
    local_49 = u32(49i);
    let _e543 = local_49;
    out[_e543] = u32(_e538);
    let _e546 = int_4_scalar_vector.x;
    local_50 = u32(50i);
    let _e551 = local_50;
    out[_e551] = u32(_e546);
    let _e554 = int_4_scalar_vector.y;
    local_51 = u32(51i);
    let _e559 = local_51;
    out[_e559] = u32(_e554);
    let _e562 = int_4_scalar_vector.z;
    local_52 = u32(52i);
    let _e567 = local_52;
    out[_e567] = u32(_e562);
    let _e570 = int_4_scalar_vector.w;
    local_53 = u32(53i);
    let _e575 = local_53;
    out[_e575] = u32(_e570);
    uint_2_left = vec2<u32>(4294967294u, 2147483649u);
    uint_2_right = vec2<u32>(5u, 2u);
    let _e585 = uint_2_left;
    let _e586 = uint_2_right;
    let _e587 = operator_u002b_18(_e585, _e586);
    uint_2_vectors = _e587;
    let _e589 = uint_2_left;
    let _e591 = operator_u002b_19(_e589, 4u);
    uint_2_vector_scalar = _e591;
    let _e593 = uint_2_right;
    let _e595 = operator_u002b_20(4u, _e593);
    uint_2_scalar_vector = _e595;
    let _e598 = uint_2_vectors.x;
    local_54 = u32(54i);
    let _e602 = local_54;
    out[_e602] = _e598;
    let _e605 = uint_2_vectors.y;
    local_55 = u32(55i);
    let _e609 = local_55;
    out[_e609] = _e605;
    let _e612 = uint_2_vector_scalar.x;
    local_56 = u32(56i);
    let _e616 = local_56;
    out[_e616] = _e612;
    let _e619 = uint_2_vector_scalar.y;
    local_57 = u32(57i);
    let _e623 = local_57;
    out[_e623] = _e619;
    let _e626 = uint_2_scalar_vector.x;
    local_58 = u32(58i);
    let _e630 = local_58;
    out[_e630] = _e626;
    let _e633 = uint_2_scalar_vector.y;
    local_59 = u32(59i);
    let _e637 = local_59;
    out[_e637] = _e633;
    uint_3_left = uint3_(4294967294u, 2147483649u, 3u);
    uint_3_right = uint3_(5u, 2u, 4294967293u);
    let _e649 = uint_3_left;
    let _e650 = uint_3_right;
    let _e651 = operator_u002b_21(_e649, _e650);
    uint_3_vectors = _e651;
    let _e653 = uint_3_left;
    let _e655 = operator_u002b_22(_e653, 4u);
    uint_3_vector_scalar = _e655;
    let _e657 = uint_3_right;
    let _e659 = operator_u002b_23(4u, _e657);
    uint_3_scalar_vector = _e659;
    let _e662 = uint_3_vectors.x;
    local_60 = u32(60i);
    let _e666 = local_60;
    out[_e666] = _e662;
    let _e669 = uint_3_vectors.y;
    local_61 = u32(61i);
    let _e673 = local_61;
    out[_e673] = _e669;
    let _e676 = uint_3_vectors.z;
    local_62 = u32(62i);
    let _e680 = local_62;
    out[_e680] = _e676;
    let _e683 = uint_3_vector_scalar.x;
    local_63 = u32(63i);
    let _e687 = local_63;
    out[_e687] = _e683;
    let _e690 = uint_3_vector_scalar.y;
    local_64 = u32(64i);
    let _e694 = local_64;
    out[_e694] = _e690;
    let _e697 = uint_3_vector_scalar.z;
    local_65 = u32(65i);
    let _e701 = local_65;
    out[_e701] = _e697;
    let _e704 = uint_3_scalar_vector.x;
    local_66 = u32(66i);
    let _e708 = local_66;
    out[_e708] = _e704;
    let _e711 = uint_3_scalar_vector.y;
    local_67 = u32(67i);
    let _e715 = local_67;
    out[_e715] = _e711;
    let _e718 = uint_3_scalar_vector.z;
    local_68 = u32(68i);
    let _e722 = local_68;
    out[_e722] = _e718;
    uint_4_left = vec4<u32>(4294967294u, 2147483649u, 3u, 4294967295u);
    uint_4_right = vec4<u32>(5u, 2u, 4294967293u, 1u);
    let _e736 = uint_4_left;
    let _e737 = uint_4_right;
    let _e738 = operator_u002b_24(_e736, _e737);
    uint_4_vectors = _e738;
    let _e740 = uint_4_left;
    let _e742 = operator_u002b_25(_e740, 4u);
    uint_4_vector_scalar = _e742;
    let _e744 = uint_4_right;
    let _e746 = operator_u002b_26(4u, _e744);
    uint_4_scalar_vector = _e746;
    let _e749 = uint_4_vectors.x;
    local_69 = u32(69i);
    let _e753 = local_69;
    out[_e753] = _e749;
    let _e756 = uint_4_vectors.y;
    local_70 = u32(70i);
    let _e760 = local_70;
    out[_e760] = _e756;
    let _e763 = uint_4_vectors.z;
    local_71 = u32(71i);
    let _e767 = local_71;
    out[_e767] = _e763;
    let _e770 = uint_4_vectors.w;
    local_72 = u32(72i);
    let _e774 = local_72;
    out[_e774] = _e770;
    let _e777 = uint_4_vector_scalar.x;
    local_73 = u32(73i);
    let _e781 = local_73;
    out[_e781] = _e777;
    let _e784 = uint_4_vector_scalar.y;
    local_74 = u32(74i);
    let _e788 = local_74;
    out[_e788] = _e784;
    let _e791 = uint_4_vector_scalar.z;
    local_75 = u32(75i);
    let _e795 = local_75;
    out[_e795] = _e791;
    let _e798 = uint_4_vector_scalar.w;
    local_76 = u32(76i);
    let _e802 = local_76;
    out[_e802] = _e798;
    let _e805 = uint_4_scalar_vector.x;
    local_77 = u32(77i);
    let _e809 = local_77;
    out[_e809] = _e805;
    let _e812 = uint_4_scalar_vector.y;
    local_78 = u32(78i);
    let _e816 = local_78;
    out[_e816] = _e812;
    let _e819 = uint_4_scalar_vector.z;
    local_79 = u32(79i);
    let _e823 = local_79;
    out[_e823] = _e819;
    let _e826 = uint_4_scalar_vector.w;
    local_80 = u32(80i);
    let _e830 = local_80;
    out[_e830] = _e826;
}
