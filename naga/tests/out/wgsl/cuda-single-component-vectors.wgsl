enable wgpu_int16;

struct int1_ {
    x: i32,
}

struct float1_ {
    x: f32,
}

struct uint1_ {
    x: u32,
}

struct short1_ {
    x: i16,
}

struct ushort1_ {
    x: u16,
}

struct type_7 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<int1_>;
@group(0) @binding(1)
var<storage, read_write> output: array<int1_>;
@group(0) @binding(2)
var<storage, read_write> observations: array<u32>;
@group(0) @binding(3)
var<uniform> count: type_7;

fn kind(value: float1_) -> u32 {
    var value_1: float1_;

    value_1 = value;
    return 11u;
}

fn kind_1(value_2: int1_) -> u32 {
    var value_3: int1_;

    value_3 = value_2;
    return 13u;
}

fn kind_2(value_4: uint1_) -> u32 {
    var value_5: uint1_;

    value_5 = value_4;
    return 17u;
}

fn kind_3(value_6: short1_) -> u32 {
    var value_7: short1_;

    value_7 = value_6;
    return 19u;
}

fn kind_4(value_8: ushort1_) -> u32 {
    var value_9: ushort1_;

    value_9 = value_8;
    return 23u;
}

fn kind_5(value_10: f32) -> u32 {
    return 31u;
}

fn kind_6(value_11: i32) -> u32 {
    return 37u;
}

fn kind_7(value_12: u32) -> u32 {
    return 41u;
}

fn kind_8(value_13: i16) -> u32 {
    return 43u;
}

fn kind_9(value_14: u16) -> u32 {
    return 47u;
}

fn identity_int1_(value_15: int1_) -> int1_ {
    var value_16: int1_;

    value_16 = value_15;
    let _e2 = value_16;
    return _e2;
}

fn identity_uint1_(value_17: uint1_) -> uint1_ {
    var value_18: uint1_;

    value_18 = value_17;
    let _e2 = value_18;
    return _e2;
}

@compute @workgroup_size(4, 1, 1)
fn single_component_vectors(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var signed_value: int1_;
    var unsigned_value: uint1_;
    var floating: float1_;
    var signed_half: short1_;
    var unsigned_half: ushort1_;
    var changed: int1_;
    var local: int1_;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var result: int1_;
    var local_16: int1_;

    let count_1 = count.value;
    let index = ((blockIdx.x * 4u) + threadIdx.x);
    if (index >= count_1) {
        return;
    }
    let _e14 = input[index].x;
    let _e16 = identity_int1_(int1_(_e14));
    signed_value = _e16;
    let _e19 = signed_value.x;
    let _e22 = identity_uint1_(uint1_(u32(_e19)));
    unsigned_value = _e22;
    let _e25 = signed_value.x;
    floating = float1_((f32((_e25 & 7i)) + 0.5f));
    let _e34 = signed_value.x;
    signed_half = short1_(i16(_e34));
    let _e39 = signed_value.x;
    unsigned_half = ushort1_(u16(_e39));
    let _e44 = signed_half.x;
    signed_half.x = i16((i32(_e44) + 1i));
    let _e50 = unsigned_half.x;
    unsigned_half.x = u16((i32(_e50) + 1i));
    result = int1_();
    let _e57 = signed_value;
    local_16 = _e57;
    let _e59 = local_16;
    result = _e59;
    let _e62 = result.x;
    result.x = (_e62 ^ 324508639i);
    let _e65 = result;
    local = _e65;
    let _e67 = local;
    changed = _e67;
    let _e69 = changed;
    output[index] = _e69;
    let base = (index * 16u);
    let _e75 = signed_value.x;
    observations[base] = u32(_e75);
    let _e80 = changed.x;
    local_1 = u32((base + 1u));
    let _e86 = local_1;
    observations[_e86] = u32(_e80);
    let _e89 = unsigned_value.x;
    local_2 = u32((base + 2u));
    let _e94 = local_2;
    observations[_e94] = _e89;
    let _e97 = floating.x;
    local_3 = u32((base + 3u));
    let _e103 = local_3;
    observations[_e103] = bitcast<u32>(_e97);
    let _e106 = signed_half.x;
    local_4 = u32((base + 4u));
    let _e112 = local_4;
    observations[_e112] = u32(_e106);
    let _e115 = unsigned_half.x;
    local_5 = u32((base + 5u));
    let _e121 = local_5;
    observations[_e121] = u32(_e115);
    let _e123 = floating;
    let _e124 = kind(_e123);
    local_6 = u32((base + 6u));
    let _e129 = local_6;
    observations[_e129] = _e124;
    let _e131 = signed_value;
    let _e132 = kind_1(_e131);
    local_7 = u32((base + 7u));
    let _e137 = local_7;
    observations[_e137] = _e132;
    let _e139 = unsigned_value;
    let _e140 = kind_2(_e139);
    local_8 = u32((base + 8u));
    let _e145 = local_8;
    observations[_e145] = _e140;
    let _e147 = signed_half;
    let _e148 = kind_3(_e147);
    local_9 = u32((base + 9u));
    let _e153 = local_9;
    observations[_e153] = _e148;
    let _e155 = unsigned_half;
    let _e156 = kind_4(_e155);
    local_10 = u32((base + 10u));
    let _e161 = local_10;
    observations[_e161] = _e156;
    let _e164 = floating.x;
    let _e165 = kind_5(_e164);
    local_11 = u32((base + 11u));
    let _e170 = local_11;
    observations[_e170] = _e165;
    let _e173 = signed_value.x;
    let _e174 = kind_6(_e173);
    local_12 = u32((base + 12u));
    let _e179 = local_12;
    observations[_e179] = _e174;
    let _e182 = unsigned_value.x;
    let _e183 = kind_7(_e182);
    local_13 = u32((base + 13u));
    let _e188 = local_13;
    observations[_e188] = _e183;
    let _e191 = signed_half.x;
    let _e192 = kind_8(_e191);
    local_14 = u32((base + 14u));
    let _e197 = local_14;
    observations[_e197] = _e192;
    let _e200 = unsigned_half.x;
    let _e201 = kind_9(_e200);
    local_15 = u32((base + 15u));
    let _e206 = local_15;
    observations[_e206] = _e201;
}
