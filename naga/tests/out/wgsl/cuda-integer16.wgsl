enable wgpu_int16;

struct Record_cuda_record_0_ {
    signed_value: i16,
    unsigned_value: u16,
    wide: u32,
    tail: i16,
    tag: u16,
}

struct type_6 {
    value: u16,
}

@group(0) @binding(0)
var<storage> input: array<Record_cuda_record_0_>;
@group(0) @binding(1)
var<storage, read_write> output: array<Record_cuda_record_0_>;
@group(0) @binding(2)
var<storage, read_write> observations: array<u32>;
@group(0) @binding(3)
var<uniform> count: type_6;

fn promoted(value: i32) -> i32 {
    return 31i;
}

fn exact(value_1: i16) -> i32 {
    return 41i;
}

fn exact_1(value_2: u16) -> i32 {
    return 43i;
}

fn identity_short(value_3: i16) -> i16 {
    return value_3;
}

fn identity_unsigned_u0020_short(value_4: u16) -> u16 {
    return value_4;
}

fn signed_type_u002d_1_() -> i32 {
    let _e1 = exact(i16(-1));
    return _e1;
}

fn unsigned_type_65535u() -> i32 {
    let _e1 = exact_1(u16(65535));
    return _e1;
}

@compute @workgroup_size(4, 1, 1)
fn integer16_(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var original: Record_cuda_record_0_;
    var result: Record_cuda_record_0_;
    var signed_value: i16;
    var unsigned_value: u16;
    var local: u32;
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
    var local_16: i16;
    var local_17: Record_cuda_record_0_;
    var local_18: Record_cuda_record_0_;

    let count_1 = count.value;
    let index = ((blockIdx.x * 4u) + threadIdx.x);
    if (index >= u32(count_1)) {
        return;
    }
    let _e14 = input[index];
    local_18 = _e14;
    let _e16 = local_18;
    local_17 = _e16;
    let _e18 = local_17;
    original = _e18;
    let _e20 = original;
    result = _e20;
    let _e24 = original.unsigned_value;
    let _e26 = original.unsigned_value;
    let promoted_sum = (i32(_e24) + i32(_e26));
    let _e30 = original.signed_value;
    let _e31 = identity_short(_e30);
    signed_value = _e31;
    let _e34 = original.unsigned_value;
    let _e35 = identity_unsigned_u0020_short(_e34);
    unsigned_value = _e35;
    let _e37 = signed_value;
    signed_value = i16((i32(_e37) + 3i));
    let _e45 = signed_value;
    signed_value = i16((i32(_e45) / i32(i16(-(1i)))));
    let _e52 = unsigned_value;
    unsigned_value = u16((i32(_e52) + i32(u16(1i))));
    let _e57 = unsigned_value;
    local = u32(1i);
    let _e62 = local;
    unsigned_value = u16((i32(_e57) << _e62));
    let _e65 = signed_value;
    result.signed_value = i16(f32(_e65));
    let _e69 = unsigned_value;
    result.unsigned_value = u16(f32(_e69));
    result.wide = u32(promoted_sum);
    let _e76 = original.tail;
    result.tail = i16(~(i32(_e76)));
    let _e82 = original.tag;
    result.tag = u16((i32(_e82) + 1i));
    let _e88 = result;
    output[index] = _e88;
    let base = (index * 16u);
    observations[base] = u32(promoted_sum);
    let _e97 = original.unsigned_value;
    let _e99 = promoted(i32(_e97));
    local_1 = u32((base + 1u));
    let _e105 = local_1;
    observations[_e105] = u32(_e99);
    let _e108 = original.signed_value;
    let _e109 = exact(_e108);
    local_2 = u32((base + 2u));
    let _e115 = local_2;
    observations[_e115] = u32(_e109);
    let _e118 = original.unsigned_value;
    let _e119 = exact_1(_e118);
    local_3 = u32((base + 3u));
    let _e125 = local_3;
    observations[_e125] = u32(_e119);
    let _e127 = signed_type_u002d_1_();
    local_4 = u32((base + 4u));
    let _e133 = local_4;
    observations[_e133] = u32(_e127);
    let _e135 = unsigned_type_65535u();
    local_5 = u32((base + 5u));
    let _e141 = local_5;
    observations[_e141] = u32(_e135);
    let _e144 = original.unsigned_value;
    local_6 = u32((base + 6u));
    let _e151 = local_6;
    observations[_e151] = u32(i32(_e144));
    let _e154 = original.unsigned_value;
    local_7 = u32((base + 7u));
    let _e162 = local_7;
    observations[_e162] = u32(-(i32(_e154)));
    let _e165 = original.unsigned_value;
    local_8 = u32((base + 8u));
    let _e173 = local_8;
    observations[_e173] = u32(~(i32(_e165)));
    local_9 = u32((base + 9u));
    let _e189 = local_9;
    observations[_e189] = u32((i32(i16(-(32768i))) / i32(i16(-(1i)))));
    let _e193 = original.signed_value;
    let _e195 = original.unsigned_value;
    local_10 = u32((base + 10u));
    let _e203 = local_10;
    observations[_e203] = u32((i32(_e193) < i32(_e195)));
    let _e206 = original.signed_value;
    local_11 = u32((base + 11u));
    let _e215 = local_11;
    observations[_e215] = u32((u32(_e206) < 1u));
    let _e218 = result.signed_value;
    local_12 = u32((base + 12u));
    let _e224 = local_12;
    observations[_e224] = u32(_e218);
    let _e227 = result.unsigned_value;
    local_13 = u32((base + 13u));
    let _e233 = local_13;
    observations[_e233] = u32(_e227);
    let _e236 = original.tail;
    local_14 = u32((base + 14u));
    let _e242 = local_14;
    observations[_e242] = u32(_e236);
    if ((index & 1u) != 0u) {
        let _e249 = original.signed_value;
        local_16 = _e249;
    } else {
        let _e252 = result.tail;
        local_16 = _e252;
    }
    let _e255 = local_16;
    let _e256 = exact(_e255);
    local_15 = u32((base + 15u));
    let _e262 = local_15;
    observations[_e262] = u32(_e256);
}
