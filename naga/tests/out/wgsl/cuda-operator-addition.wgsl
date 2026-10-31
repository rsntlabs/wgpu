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
    var local_81: u32;
    var local_82: u32;
    var local_83: u32;
    var local_84: u32;
    var local_85: u32;
    var local_86: u32;
    var local_87: u32;
    var local_88: u32;
    var local_89: u32;
    var local_90: u32;
    var local_91: u32;
    var local_92: u32;
    var local_93: u32;
    var local_94: u32;
    var local_95: u32;
    var local_96: u32;
    var local_97: u32;
    var local_98: u32;
    var local_99: u32;
    var local_100: u32;
    var local_101: u32;
    var local_102: u32;
    var local_103: u32;
    var local_104: u32;
    var local_105: u32;
    var local_106: u32;
    var local_107: u32;
    var local_108: u32;
    var local_109: u32;
    var local_110: u32;
    var local_111: u32;
    var local_112: u32;
    var local_113: u32;
    var local_114: u32;
    var local_115: u32;
    var local_116: u32;
    var local_117: u32;
    var local_118: u32;
    var local_119: u32;
    var local_120: u32;
    var local_121: u32;
    var local_122: u32;
    var local_123: u32;
    var local_124: u32;
    var local_125: u32;
    var local_126: u32;
    var local_127: u32;
    var local_128: u32;
    var local_129: u32;
    var local_130: u32;
    var local_131: u32;
    var local_132: u32;
    var local_133: u32;
    var local_134: u32;
    var local_135: u32;
    var local_136: u32;
    var local_137: u32;
    var local_138: u32;
    var local_139: u32;
    var local_140: u32;
    var local_141: u32;
    var local_142: u32;
    var local_143: u32;
    var local_144: u32;
    var local_145: u32;
    var local_146: u32;
    var local_147: u32;
    var local_148: u32;
    var local_149: u32;
    var local_150: u32;
    var local_151: u32;
    var local_152: u32;
    var local_153: u32;
    var local_154: u32;
    var local_155: u32;
    var local_156: u32;
    var local_157: u32;
    var local_158: u32;
    var local_159: u32;
    var local_160: u32;
    var local_161: u32;

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
    let _e28 = local;
    local_81 = u32(_e28);
    let _e31 = local_81;
    out[_e31] = bitcast<u32>(_e22);
    let _e34 = float_2_vectors.y;
    local_1 = u32(1i);
    let _e39 = local_1;
    local_82 = u32(_e39);
    let _e42 = local_82;
    out[_e42] = bitcast<u32>(_e34);
    let _e45 = float_2_vector_scalar.x;
    local_2 = u32(2i);
    let _e50 = local_2;
    local_83 = u32(_e50);
    let _e53 = local_83;
    out[_e53] = bitcast<u32>(_e45);
    let _e56 = float_2_vector_scalar.y;
    local_3 = u32(3i);
    let _e61 = local_3;
    local_84 = u32(_e61);
    let _e64 = local_84;
    out[_e64] = bitcast<u32>(_e56);
    let _e67 = float_2_scalar_vector.x;
    local_4 = u32(4i);
    let _e72 = local_4;
    local_85 = u32(_e72);
    let _e75 = local_85;
    out[_e75] = bitcast<u32>(_e67);
    let _e78 = float_2_scalar_vector.y;
    local_5 = u32(5i);
    let _e83 = local_5;
    local_86 = u32(_e83);
    let _e86 = local_86;
    out[_e86] = bitcast<u32>(_e78);
    float_3_left = float3_(1.25f, -(2.5f), 3.75f);
    float_3_right = float3_(0.5f, 1.5f, -(2f));
    let _e100 = float_3_left;
    let _e101 = float_3_right;
    let _e102 = operator_u002b_3(_e100, _e101);
    float_3_vectors = _e102;
    let _e104 = float_3_left;
    let _e106 = operator_u002b_4(_e104, 2f);
    float_3_vector_scalar = _e106;
    let _e108 = float_3_right;
    let _e110 = operator_u002b_5(2f, _e108);
    float_3_scalar_vector = _e110;
    let _e113 = float_3_vectors.x;
    local_6 = u32(6i);
    let _e118 = local_6;
    local_87 = u32(_e118);
    let _e121 = local_87;
    out[_e121] = bitcast<u32>(_e113);
    let _e124 = float_3_vectors.y;
    local_7 = u32(7i);
    let _e129 = local_7;
    local_88 = u32(_e129);
    let _e132 = local_88;
    out[_e132] = bitcast<u32>(_e124);
    let _e135 = float_3_vectors.z;
    local_8 = u32(8i);
    let _e140 = local_8;
    local_89 = u32(_e140);
    let _e143 = local_89;
    out[_e143] = bitcast<u32>(_e135);
    let _e146 = float_3_vector_scalar.x;
    local_9 = u32(9i);
    let _e151 = local_9;
    local_90 = u32(_e151);
    let _e154 = local_90;
    out[_e154] = bitcast<u32>(_e146);
    let _e157 = float_3_vector_scalar.y;
    local_10 = u32(10i);
    let _e162 = local_10;
    local_91 = u32(_e162);
    let _e165 = local_91;
    out[_e165] = bitcast<u32>(_e157);
    let _e168 = float_3_vector_scalar.z;
    local_11 = u32(11i);
    let _e173 = local_11;
    local_92 = u32(_e173);
    let _e176 = local_92;
    out[_e176] = bitcast<u32>(_e168);
    let _e179 = float_3_scalar_vector.x;
    local_12 = u32(12i);
    let _e184 = local_12;
    local_93 = u32(_e184);
    let _e187 = local_93;
    out[_e187] = bitcast<u32>(_e179);
    let _e190 = float_3_scalar_vector.y;
    local_13 = u32(13i);
    let _e195 = local_13;
    local_94 = u32(_e195);
    let _e198 = local_94;
    out[_e198] = bitcast<u32>(_e190);
    let _e201 = float_3_scalar_vector.z;
    local_14 = u32(14i);
    let _e206 = local_14;
    local_95 = u32(_e206);
    let _e209 = local_95;
    out[_e209] = bitcast<u32>(_e201);
    float_4_left = vec4<f32>(1.25f, -(2.5f), 3.75f, -(4f));
    float_4_right = vec4<f32>(0.5f, 1.5f, -(2f), 0.25f);
    let _e226 = float_4_left;
    let _e227 = float_4_right;
    let _e228 = operator_u002b_6(_e226, _e227);
    float_4_vectors = _e228;
    let _e230 = float_4_left;
    let _e232 = operator_u002b_7(_e230, 2f);
    float_4_vector_scalar = _e232;
    let _e234 = float_4_right;
    let _e236 = operator_u002b_8(2f, _e234);
    float_4_scalar_vector = _e236;
    let _e239 = float_4_vectors.x;
    local_15 = u32(15i);
    let _e244 = local_15;
    local_96 = u32(_e244);
    let _e247 = local_96;
    out[_e247] = bitcast<u32>(_e239);
    let _e250 = float_4_vectors.y;
    local_16 = u32(16i);
    let _e255 = local_16;
    local_97 = u32(_e255);
    let _e258 = local_97;
    out[_e258] = bitcast<u32>(_e250);
    let _e261 = float_4_vectors.z;
    local_17 = u32(17i);
    let _e266 = local_17;
    local_98 = u32(_e266);
    let _e269 = local_98;
    out[_e269] = bitcast<u32>(_e261);
    let _e272 = float_4_vectors.w;
    local_18 = u32(18i);
    let _e277 = local_18;
    local_99 = u32(_e277);
    let _e280 = local_99;
    out[_e280] = bitcast<u32>(_e272);
    let _e283 = float_4_vector_scalar.x;
    local_19 = u32(19i);
    let _e288 = local_19;
    local_100 = u32(_e288);
    let _e291 = local_100;
    out[_e291] = bitcast<u32>(_e283);
    let _e294 = float_4_vector_scalar.y;
    local_20 = u32(20i);
    let _e299 = local_20;
    local_101 = u32(_e299);
    let _e302 = local_101;
    out[_e302] = bitcast<u32>(_e294);
    let _e305 = float_4_vector_scalar.z;
    local_21 = u32(21i);
    let _e310 = local_21;
    local_102 = u32(_e310);
    let _e313 = local_102;
    out[_e313] = bitcast<u32>(_e305);
    let _e316 = float_4_vector_scalar.w;
    local_22 = u32(22i);
    let _e321 = local_22;
    local_103 = u32(_e321);
    let _e324 = local_103;
    out[_e324] = bitcast<u32>(_e316);
    let _e327 = float_4_scalar_vector.x;
    local_23 = u32(23i);
    let _e332 = local_23;
    local_104 = u32(_e332);
    let _e335 = local_104;
    out[_e335] = bitcast<u32>(_e327);
    let _e338 = float_4_scalar_vector.y;
    local_24 = u32(24i);
    let _e343 = local_24;
    local_105 = u32(_e343);
    let _e346 = local_105;
    out[_e346] = bitcast<u32>(_e338);
    let _e349 = float_4_scalar_vector.z;
    local_25 = u32(25i);
    let _e354 = local_25;
    local_106 = u32(_e354);
    let _e357 = local_106;
    out[_e357] = bitcast<u32>(_e349);
    let _e360 = float_4_scalar_vector.w;
    local_26 = u32(26i);
    let _e365 = local_26;
    local_107 = u32(_e365);
    let _e368 = local_107;
    out[_e368] = bitcast<u32>(_e360);
    int_2_left = vec2<i32>(1i, -(2i));
    int_2_right = vec2<i32>(5i, 6i);
    let _e379 = int_2_left;
    let _e380 = int_2_right;
    let _e381 = operator_u002b_9(_e379, _e380);
    int_2_vectors = _e381;
    let _e383 = int_2_left;
    let _e385 = operator_u002b_10(_e383, 3i);
    int_2_vector_scalar = _e385;
    let _e387 = int_2_right;
    let _e389 = operator_u002b_11(3i, _e387);
    int_2_scalar_vector = _e389;
    let _e392 = int_2_vectors.x;
    local_27 = u32(27i);
    let _e397 = local_27;
    local_108 = u32(_e397);
    let _e400 = local_108;
    out[_e400] = u32(_e392);
    let _e403 = int_2_vectors.y;
    local_28 = u32(28i);
    let _e408 = local_28;
    local_109 = u32(_e408);
    let _e411 = local_109;
    out[_e411] = u32(_e403);
    let _e414 = int_2_vector_scalar.x;
    local_29 = u32(29i);
    let _e419 = local_29;
    local_110 = u32(_e419);
    let _e422 = local_110;
    out[_e422] = u32(_e414);
    let _e425 = int_2_vector_scalar.y;
    local_30 = u32(30i);
    let _e430 = local_30;
    local_111 = u32(_e430);
    let _e433 = local_111;
    out[_e433] = u32(_e425);
    let _e436 = int_2_scalar_vector.x;
    local_31 = u32(31i);
    let _e441 = local_31;
    local_112 = u32(_e441);
    let _e444 = local_112;
    out[_e444] = u32(_e436);
    let _e447 = int_2_scalar_vector.y;
    local_32 = u32(32i);
    let _e452 = local_32;
    local_113 = u32(_e452);
    let _e455 = local_113;
    out[_e455] = u32(_e447);
    int_3_left = int3_(1i, -(2i), 3i);
    int_3_right = int3_(5i, 6i, -(7i));
    let _e469 = int_3_left;
    let _e470 = int_3_right;
    let _e471 = operator_u002b_12(_e469, _e470);
    int_3_vectors = _e471;
    let _e473 = int_3_left;
    let _e475 = operator_u002b_13(_e473, 3i);
    int_3_vector_scalar = _e475;
    let _e477 = int_3_right;
    let _e479 = operator_u002b_14(3i, _e477);
    int_3_scalar_vector = _e479;
    let _e482 = int_3_vectors.x;
    local_33 = u32(33i);
    let _e487 = local_33;
    local_114 = u32(_e487);
    let _e490 = local_114;
    out[_e490] = u32(_e482);
    let _e493 = int_3_vectors.y;
    local_34 = u32(34i);
    let _e498 = local_34;
    local_115 = u32(_e498);
    let _e501 = local_115;
    out[_e501] = u32(_e493);
    let _e504 = int_3_vectors.z;
    local_35 = u32(35i);
    let _e509 = local_35;
    local_116 = u32(_e509);
    let _e512 = local_116;
    out[_e512] = u32(_e504);
    let _e515 = int_3_vector_scalar.x;
    local_36 = u32(36i);
    let _e520 = local_36;
    local_117 = u32(_e520);
    let _e523 = local_117;
    out[_e523] = u32(_e515);
    let _e526 = int_3_vector_scalar.y;
    local_37 = u32(37i);
    let _e531 = local_37;
    local_118 = u32(_e531);
    let _e534 = local_118;
    out[_e534] = u32(_e526);
    let _e537 = int_3_vector_scalar.z;
    local_38 = u32(38i);
    let _e542 = local_38;
    local_119 = u32(_e542);
    let _e545 = local_119;
    out[_e545] = u32(_e537);
    let _e548 = int_3_scalar_vector.x;
    local_39 = u32(39i);
    let _e553 = local_39;
    local_120 = u32(_e553);
    let _e556 = local_120;
    out[_e556] = u32(_e548);
    let _e559 = int_3_scalar_vector.y;
    local_40 = u32(40i);
    let _e564 = local_40;
    local_121 = u32(_e564);
    let _e567 = local_121;
    out[_e567] = u32(_e559);
    let _e570 = int_3_scalar_vector.z;
    local_41 = u32(41i);
    let _e575 = local_41;
    local_122 = u32(_e575);
    let _e578 = local_122;
    out[_e578] = u32(_e570);
    int_4_left = vec4<i32>(1i, -(2i), 3i, -(4i));
    int_4_right = vec4<i32>(5i, 6i, -(7i), 8i);
    let _e595 = int_4_left;
    let _e596 = int_4_right;
    let _e597 = operator_u002b_15(_e595, _e596);
    int_4_vectors = _e597;
    let _e599 = int_4_left;
    let _e601 = operator_u002b_16(_e599, 3i);
    int_4_vector_scalar = _e601;
    let _e603 = int_4_right;
    let _e605 = operator_u002b_17(3i, _e603);
    int_4_scalar_vector = _e605;
    let _e608 = int_4_vectors.x;
    local_42 = u32(42i);
    let _e613 = local_42;
    local_123 = u32(_e613);
    let _e616 = local_123;
    out[_e616] = u32(_e608);
    let _e619 = int_4_vectors.y;
    local_43 = u32(43i);
    let _e624 = local_43;
    local_124 = u32(_e624);
    let _e627 = local_124;
    out[_e627] = u32(_e619);
    let _e630 = int_4_vectors.z;
    local_44 = u32(44i);
    let _e635 = local_44;
    local_125 = u32(_e635);
    let _e638 = local_125;
    out[_e638] = u32(_e630);
    let _e641 = int_4_vectors.w;
    local_45 = u32(45i);
    let _e646 = local_45;
    local_126 = u32(_e646);
    let _e649 = local_126;
    out[_e649] = u32(_e641);
    let _e652 = int_4_vector_scalar.x;
    local_46 = u32(46i);
    let _e657 = local_46;
    local_127 = u32(_e657);
    let _e660 = local_127;
    out[_e660] = u32(_e652);
    let _e663 = int_4_vector_scalar.y;
    local_47 = u32(47i);
    let _e668 = local_47;
    local_128 = u32(_e668);
    let _e671 = local_128;
    out[_e671] = u32(_e663);
    let _e674 = int_4_vector_scalar.z;
    local_48 = u32(48i);
    let _e679 = local_48;
    local_129 = u32(_e679);
    let _e682 = local_129;
    out[_e682] = u32(_e674);
    let _e685 = int_4_vector_scalar.w;
    local_49 = u32(49i);
    let _e690 = local_49;
    local_130 = u32(_e690);
    let _e693 = local_130;
    out[_e693] = u32(_e685);
    let _e696 = int_4_scalar_vector.x;
    local_50 = u32(50i);
    let _e701 = local_50;
    local_131 = u32(_e701);
    let _e704 = local_131;
    out[_e704] = u32(_e696);
    let _e707 = int_4_scalar_vector.y;
    local_51 = u32(51i);
    let _e712 = local_51;
    local_132 = u32(_e712);
    let _e715 = local_132;
    out[_e715] = u32(_e707);
    let _e718 = int_4_scalar_vector.z;
    local_52 = u32(52i);
    let _e723 = local_52;
    local_133 = u32(_e723);
    let _e726 = local_133;
    out[_e726] = u32(_e718);
    let _e729 = int_4_scalar_vector.w;
    local_53 = u32(53i);
    let _e734 = local_53;
    local_134 = u32(_e734);
    let _e737 = local_134;
    out[_e737] = u32(_e729);
    uint_2_left = vec2<u32>(4294967294u, 2147483649u);
    uint_2_right = vec2<u32>(5u, 2u);
    let _e747 = uint_2_left;
    let _e748 = uint_2_right;
    let _e749 = operator_u002b_18(_e747, _e748);
    uint_2_vectors = _e749;
    let _e751 = uint_2_left;
    let _e753 = operator_u002b_19(_e751, 4u);
    uint_2_vector_scalar = _e753;
    let _e755 = uint_2_right;
    let _e757 = operator_u002b_20(4u, _e755);
    uint_2_scalar_vector = _e757;
    let _e760 = uint_2_vectors.x;
    local_54 = u32(54i);
    let _e764 = local_54;
    local_135 = u32(_e764);
    let _e767 = local_135;
    out[_e767] = _e760;
    let _e770 = uint_2_vectors.y;
    local_55 = u32(55i);
    let _e774 = local_55;
    local_136 = u32(_e774);
    let _e777 = local_136;
    out[_e777] = _e770;
    let _e780 = uint_2_vector_scalar.x;
    local_56 = u32(56i);
    let _e784 = local_56;
    local_137 = u32(_e784);
    let _e787 = local_137;
    out[_e787] = _e780;
    let _e790 = uint_2_vector_scalar.y;
    local_57 = u32(57i);
    let _e794 = local_57;
    local_138 = u32(_e794);
    let _e797 = local_138;
    out[_e797] = _e790;
    let _e800 = uint_2_scalar_vector.x;
    local_58 = u32(58i);
    let _e804 = local_58;
    local_139 = u32(_e804);
    let _e807 = local_139;
    out[_e807] = _e800;
    let _e810 = uint_2_scalar_vector.y;
    local_59 = u32(59i);
    let _e814 = local_59;
    local_140 = u32(_e814);
    let _e817 = local_140;
    out[_e817] = _e810;
    uint_3_left = uint3_(4294967294u, 2147483649u, 3u);
    uint_3_right = uint3_(5u, 2u, 4294967293u);
    let _e829 = uint_3_left;
    let _e830 = uint_3_right;
    let _e831 = operator_u002b_21(_e829, _e830);
    uint_3_vectors = _e831;
    let _e833 = uint_3_left;
    let _e835 = operator_u002b_22(_e833, 4u);
    uint_3_vector_scalar = _e835;
    let _e837 = uint_3_right;
    let _e839 = operator_u002b_23(4u, _e837);
    uint_3_scalar_vector = _e839;
    let _e842 = uint_3_vectors.x;
    local_60 = u32(60i);
    let _e846 = local_60;
    local_141 = u32(_e846);
    let _e849 = local_141;
    out[_e849] = _e842;
    let _e852 = uint_3_vectors.y;
    local_61 = u32(61i);
    let _e856 = local_61;
    local_142 = u32(_e856);
    let _e859 = local_142;
    out[_e859] = _e852;
    let _e862 = uint_3_vectors.z;
    local_62 = u32(62i);
    let _e866 = local_62;
    local_143 = u32(_e866);
    let _e869 = local_143;
    out[_e869] = _e862;
    let _e872 = uint_3_vector_scalar.x;
    local_63 = u32(63i);
    let _e876 = local_63;
    local_144 = u32(_e876);
    let _e879 = local_144;
    out[_e879] = _e872;
    let _e882 = uint_3_vector_scalar.y;
    local_64 = u32(64i);
    let _e886 = local_64;
    local_145 = u32(_e886);
    let _e889 = local_145;
    out[_e889] = _e882;
    let _e892 = uint_3_vector_scalar.z;
    local_65 = u32(65i);
    let _e896 = local_65;
    local_146 = u32(_e896);
    let _e899 = local_146;
    out[_e899] = _e892;
    let _e902 = uint_3_scalar_vector.x;
    local_66 = u32(66i);
    let _e906 = local_66;
    local_147 = u32(_e906);
    let _e909 = local_147;
    out[_e909] = _e902;
    let _e912 = uint_3_scalar_vector.y;
    local_67 = u32(67i);
    let _e916 = local_67;
    local_148 = u32(_e916);
    let _e919 = local_148;
    out[_e919] = _e912;
    let _e922 = uint_3_scalar_vector.z;
    local_68 = u32(68i);
    let _e926 = local_68;
    local_149 = u32(_e926);
    let _e929 = local_149;
    out[_e929] = _e922;
    uint_4_left = vec4<u32>(4294967294u, 2147483649u, 3u, 4294967295u);
    uint_4_right = vec4<u32>(5u, 2u, 4294967293u, 1u);
    let _e943 = uint_4_left;
    let _e944 = uint_4_right;
    let _e945 = operator_u002b_24(_e943, _e944);
    uint_4_vectors = _e945;
    let _e947 = uint_4_left;
    let _e949 = operator_u002b_25(_e947, 4u);
    uint_4_vector_scalar = _e949;
    let _e951 = uint_4_right;
    let _e953 = operator_u002b_26(4u, _e951);
    uint_4_scalar_vector = _e953;
    let _e956 = uint_4_vectors.x;
    local_69 = u32(69i);
    let _e960 = local_69;
    local_150 = u32(_e960);
    let _e963 = local_150;
    out[_e963] = _e956;
    let _e966 = uint_4_vectors.y;
    local_70 = u32(70i);
    let _e970 = local_70;
    local_151 = u32(_e970);
    let _e973 = local_151;
    out[_e973] = _e966;
    let _e976 = uint_4_vectors.z;
    local_71 = u32(71i);
    let _e980 = local_71;
    local_152 = u32(_e980);
    let _e983 = local_152;
    out[_e983] = _e976;
    let _e986 = uint_4_vectors.w;
    local_72 = u32(72i);
    let _e990 = local_72;
    local_153 = u32(_e990);
    let _e993 = local_153;
    out[_e993] = _e986;
    let _e996 = uint_4_vector_scalar.x;
    local_73 = u32(73i);
    let _e1000 = local_73;
    local_154 = u32(_e1000);
    let _e1003 = local_154;
    out[_e1003] = _e996;
    let _e1006 = uint_4_vector_scalar.y;
    local_74 = u32(74i);
    let _e1010 = local_74;
    local_155 = u32(_e1010);
    let _e1013 = local_155;
    out[_e1013] = _e1006;
    let _e1016 = uint_4_vector_scalar.z;
    local_75 = u32(75i);
    let _e1020 = local_75;
    local_156 = u32(_e1020);
    let _e1023 = local_156;
    out[_e1023] = _e1016;
    let _e1026 = uint_4_vector_scalar.w;
    local_76 = u32(76i);
    let _e1030 = local_76;
    local_157 = u32(_e1030);
    let _e1033 = local_157;
    out[_e1033] = _e1026;
    let _e1036 = uint_4_scalar_vector.x;
    local_77 = u32(77i);
    let _e1040 = local_77;
    local_158 = u32(_e1040);
    let _e1043 = local_158;
    out[_e1043] = _e1036;
    let _e1046 = uint_4_scalar_vector.y;
    local_78 = u32(78i);
    let _e1050 = local_78;
    local_159 = u32(_e1050);
    let _e1053 = local_159;
    out[_e1053] = _e1046;
    let _e1056 = uint_4_scalar_vector.z;
    local_79 = u32(79i);
    let _e1060 = local_79;
    local_160 = u32(_e1060);
    let _e1063 = local_160;
    out[_e1063] = _e1056;
    let _e1066 = uint_4_scalar_vector.w;
    local_80 = u32(80i);
    let _e1070 = local_80;
    local_161 = u32(_e1070);
    let _e1073 = local_161;
    out[_e1073] = _e1066;
}
