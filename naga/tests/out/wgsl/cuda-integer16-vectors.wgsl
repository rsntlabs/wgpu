enable wgpu_int16;

struct short3_ {
    x: i16,
    y: i16,
    z: i16,
}

struct type_6 {
    value: u16,
}

struct ushort3_ {
    x: u16,
    y: u16,
    z: u16,
}

@group(0) @binding(0)
var<storage> input: array<short3_>;
@group(0) @binding(1)
var<storage, read_write> output: array<short3_>;
@group(0) @binding(2)
var<storage, read_write> observations: array<u32>;
@group(0) @binding(3)
var<uniform> count: type_6;

fn promoted(value: i32) -> u32 {
    return 31u;
}

fn field_kind(value_1: u16) -> u32 {
    return 43u;
}

fn identity_short3_(value_2: short3_) -> short3_ {
    var value_3: short3_;

    value_3 = value_2;
    let _e2 = value_3;
    return _e2;
}

fn identity_ushort4_(value_4: vec4<u16>) -> vec4<u16> {
    var value_5: vec4<u16>;

    value_5 = value_4;
    let _e2 = value_5;
    return _e2;
}

@compute @workgroup_size(4, 1, 1)
fn integer16_vectors(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var signed_triple: short3_;
    var signed_pair: vec2<i16>;
    var signed_quad: vec4<i16>;
    var copied_quad: vec4<i16>;
    var unsigned_pair: vec2<u16>;
    var unsigned_triple: ushort3_;
    var unsigned_quad: vec4<u16>;
    var local: short3_;
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
    var local_16: short3_;
    var result: short3_;
    var local_17: short3_;
    var local_18: short3_;

    let count_1 = count.value;
    let index = ((blockIdx.x * 4u) + threadIdx.x);
    if (index >= u32(count_1)) {
        return;
    }
    let _e14 = input[index];
    local_18 = _e14;
    let _e16 = local_18;
    local_16 = _e16;
    let _e18 = local_16;
    let _e19 = identity_short3_(_e18);
    signed_triple = _e19;
    let _e22 = signed_triple.x;
    let _e24 = signed_triple.y;
    signed_pair = vec2<i16>(_e22, _e24);
    let _e28 = signed_triple.x;
    let _e30 = signed_triple.y;
    let _e32 = signed_triple.z;
    signed_quad = vec4<i16>(_e28, _e30, _e32, i16(7i));
    let _e37 = signed_quad;
    copied_quad = _e37;
    let _e40 = signed_triple.x;
    let _e42 = copied_quad.w;
    copied_quad.w = i16((i32(_e42) + i32(_e40)));
    let _e48 = signed_triple.x;
    let _e50 = signed_triple.y;
    unsigned_pair = vec2<u16>(u16(_e48), u16(_e50));
    let _e56 = unsigned_pair.x;
    unsigned_pair.x = u16((i32(_e56) + 1i));
    let _e62 = unsigned_pair.y;
    unsigned_pair.y = u16((i32(_e62) + 1i));
    let _e68 = signed_triple.x;
    let _e70 = signed_triple.y;
    let _e72 = signed_triple.z;
    unsigned_triple = ushort3_(u16(_e68), u16(_e70), u16(_e72));
    let _e79 = signed_triple.z;
    let _e81 = signed_triple.y;
    let _e83 = signed_triple.x;
    let _e90 = identity_ushort4_(vec4<u16>(u16(_e79), u16(_e81), u16(_e83), u16(65535u)));
    unsigned_quad = _e90;
    let _e93 = unsigned_quad.w;
    unsigned_quad.w = u16((i32(_e93) + 2i));
    result = short3_();
    let _e100 = signed_triple;
    local_17 = _e100;
    let _e102 = local_17;
    result = _e102;
    let _e105 = result.x;
    result.x = i16((i32(_e105) + 3i));
    let _e111 = result.y;
    result.y = i16(-(i32(_e111)));
    let _e117 = result.z;
    result.z = i16((i32(_e117) ^ 4951i));
    let _e122 = result;
    local = _e122;
    let _e124 = local;
    output[index] = _e124;
    let base = (index * 16u);
    let _e130 = signed_pair.x;
    observations[base] = u32(_e130);
    let _e135 = signed_pair.y;
    local_1 = u32((base + 1u));
    let _e141 = local_1;
    observations[_e141] = u32(_e135);
    let _e144 = copied_quad.x;
    local_2 = u32((base + 2u));
    let _e150 = local_2;
    observations[_e150] = u32(_e144);
    let _e153 = copied_quad.y;
    local_3 = u32((base + 3u));
    let _e159 = local_3;
    observations[_e159] = u32(_e153);
    let _e162 = copied_quad.z;
    local_4 = u32((base + 4u));
    let _e168 = local_4;
    observations[_e168] = u32(_e162);
    let _e171 = copied_quad.w;
    local_5 = u32((base + 5u));
    let _e177 = local_5;
    observations[_e177] = u32(_e171);
    let _e180 = unsigned_pair.x;
    local_6 = u32((base + 6u));
    let _e186 = local_6;
    observations[_e186] = u32(_e180);
    let _e189 = unsigned_pair.y;
    local_7 = u32((base + 7u));
    let _e195 = local_7;
    observations[_e195] = u32(_e189);
    let _e199 = unsigned_triple.y;
    let _e203 = unsigned_triple.x;
    local_8 = u32((base + 8u));
    let _e211 = local_8;
    observations[_e211] = u32((i32(_e203) + (3i * i32(_e199))));
    let _e214 = unsigned_triple.z;
    local_9 = u32((base + 9u));
    let _e220 = local_9;
    observations[_e220] = u32(_e214);
    let _e223 = unsigned_quad.x;
    local_10 = u32((base + 10u));
    let _e229 = local_10;
    observations[_e229] = u32(_e223);
    let _e232 = unsigned_quad.y;
    local_11 = u32((base + 11u));
    let _e238 = local_11;
    observations[_e238] = u32(_e232);
    let _e241 = unsigned_quad.z;
    local_12 = u32((base + 12u));
    let _e247 = local_12;
    observations[_e247] = u32(_e241);
    let _e250 = unsigned_quad.w;
    local_13 = u32((base + 13u));
    let _e256 = local_13;
    observations[_e256] = u32(_e250);
    let _e259 = unsigned_triple.x;
    let _e261 = promoted(i32(_e259));
    local_14 = u32((base + 14u));
    let _e266 = local_14;
    observations[_e266] = _e261;
    let _e269 = unsigned_triple.z;
    let _e270 = field_kind(_e269);
    local_15 = u32((base + 15u));
    let _e275 = local_15;
    observations[_e275] = _e270;
}
