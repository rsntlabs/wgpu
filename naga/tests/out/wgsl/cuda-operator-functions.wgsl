struct Record_cuda_record_0_ {
    value: i32,
    history: array<i32, 2>,
}

@group(0) @binding(0)
var<storage> input: array<vec2<i32>>;
@group(0) @binding(1)
var<storage, read_write> out: array<u32>;

fn operator_u002b(value: vec2<i32>) -> vec2<i32> {
    var value_1: vec2<i32>;

    value_1 = value;
    let _e3 = value_1.x;
    let _e5 = value_1.y;
    return vec2<i32>(_e3, _e5);
}

fn operator_u002d(value_2: vec2<i32>) -> vec2<i32> {
    var value_3: vec2<i32>;

    value_3 = value_2;
    let _e3 = value_3.x;
    let _e6 = value_3.y;
    return vec2<i32>(-(_e3), -(_e6));
}

fn operator_u007e(value_4: vec2<i32>) -> vec2<i32> {
    var value_5: vec2<i32>;

    value_5 = value_4;
    let _e3 = value_5.x;
    let _e6 = value_5.y;
    return vec2<i32>(~(_e3), ~(_e6));
}

fn operator_u0021_(value_6: vec2<i32>) -> bool {
    var value_7: vec2<i32>;
    var local_40: bool;

    value_7 = value_6;
    let _e4 = value_7.x;
    let _e5 = (_e4 == 0i);
    local_40 = _e5;
    if _e5 {
        let _e9 = value_7.y;
        local_40 = (_e9 == 0i);
    }
    let _e11 = local_40;
    return _e11;
}

fn operator_u002a(value_8: vec2<i32>) -> i32 {
    var value_9: vec2<i32>;

    value_9 = value_8;
    let _e4 = value_9.x;
    let _e7 = value_9.y;
    return ((_e4 * 10i) + _e7);
}

fn operator_u0026_(value_10: vec2<i32>) -> vec2<i32> {
    var value_11: vec2<i32>;

    value_11 = value_10;
    let _e3 = value_11.y;
    let _e5 = value_11.x;
    return vec2<i32>(_e3, _e5);
}

fn operator_u002b_1(left_1: vec2<i32>, right_1: vec2<i32>) -> vec2<i32> {
    var left_2: vec2<i32>;
    var right_2: vec2<i32>;

    left_2 = left_1;
    right_2 = right_1;
    let _e6 = left_2.x;
    let _e7 = right_2.x;
    let _e11 = left_2.y;
    let _e12 = right_2.y;
    return vec2<i32>((_e6 + _e7), (_e11 + _e12));
}

fn operator_u002d_1(left_3: vec2<i32>, right_3: vec2<i32>) -> vec2<i32> {
    var left_4: vec2<i32>;
    var right_4: vec2<i32>;

    left_4 = left_3;
    right_4 = right_3;
    let _e6 = left_4.x;
    let _e7 = right_4.x;
    let _e11 = left_4.y;
    let _e12 = right_4.y;
    return vec2<i32>((_e6 - _e7), (_e11 - _e12));
}

fn operator_u002a_1(left_5: vec2<i32>, right_5: vec2<i32>) -> vec2<i32> {
    var left_6: vec2<i32>;
    var right_6: vec2<i32>;

    left_6 = left_5;
    right_6 = right_5;
    let _e6 = left_6.x;
    let _e7 = right_6.x;
    let _e11 = left_6.y;
    let _e12 = right_6.y;
    return vec2<i32>((_e6 * _e7), (_e11 * _e12));
}

fn operator_u002f(left_7: vec2<i32>, right_7: vec2<i32>) -> vec2<i32> {
    var left_8: vec2<i32>;
    var right_8: vec2<i32>;

    left_8 = left_7;
    right_8 = right_7;
    let _e6 = left_8.x;
    let _e7 = right_8.x;
    let _e11 = left_8.y;
    let _e12 = right_8.y;
    return vec2<i32>((_e6 / _e7), (_e11 / _e12));
}

fn operator_u0025_(left_9: vec2<i32>, right_9: vec2<i32>) -> vec2<i32> {
    var left_10: vec2<i32>;
    var right_10: vec2<i32>;

    left_10 = left_9;
    right_10 = right_9;
    let _e6 = left_10.x;
    let _e7 = right_10.x;
    let _e11 = left_10.y;
    let _e12 = right_10.y;
    return vec2<i32>((_e6 % _e7), (_e11 % _e12));
}

fn operator_u0026_1(left_11: vec2<i32>, right_11: vec2<i32>) -> vec2<i32> {
    var left_12: vec2<i32>;
    var right_12: vec2<i32>;

    left_12 = left_11;
    right_12 = right_11;
    let _e6 = left_12.x;
    let _e7 = right_12.x;
    let _e11 = left_12.y;
    let _e12 = right_12.y;
    return vec2<i32>((_e6 & _e7), (_e11 & _e12));
}

fn operator_u007c(left_13: vec2<i32>, right_13: vec2<i32>) -> vec2<i32> {
    var left_14: vec2<i32>;
    var right_14: vec2<i32>;

    left_14 = left_13;
    right_14 = right_13;
    let _e6 = left_14.x;
    let _e7 = right_14.x;
    let _e11 = left_14.y;
    let _e12 = right_14.y;
    return vec2<i32>((_e6 | _e7), (_e11 | _e12));
}

fn operator_u005e(left_15: vec2<i32>, right_15: vec2<i32>) -> vec2<i32> {
    var left_16: vec2<i32>;
    var right_16: vec2<i32>;

    left_16 = left_15;
    right_16 = right_15;
    let _e6 = left_16.x;
    let _e7 = right_16.x;
    let _e11 = left_16.y;
    let _e12 = right_16.y;
    return vec2<i32>((_e6 ^ _e7), (_e11 ^ _e12));
}

fn operator_(left_17: vec2<i32>, right_17: vec2<i32>) -> vec2<i32> {
    var left_18: vec2<i32>;
    var right_18: vec2<i32>;
    var local_41: u32;
    var local_42: u32;

    left_18 = left_17;
    right_18 = right_17;
    let _e5 = left_18.x;
    let _e7 = right_18.x;
    local_41 = u32(_e7);
    let _e10 = local_41;
    let _e13 = left_18.y;
    let _e15 = right_18.y;
    local_42 = u32(_e15);
    let _e18 = local_42;
    return vec2<i32>((_e5 << _e10), (_e13 << _e18));
}

fn operator_1(left_19: vec2<i32>, right_19: vec2<i32>) -> vec2<i32> {
    var left_20: vec2<i32>;
    var right_20: vec2<i32>;

    left_20 = left_19;
    right_20 = right_19;
    let _e5 = left_20.x;
    let _e7 = right_20.x;
    let _e11 = left_20.y;
    let _e13 = right_20.y;
    return vec2<i32>((_e5 >> u32(_e7)), (_e11 >> u32(_e13)));
}

fn operator_u002a_2(value_12: Record_cuda_record_0_) -> Record_cuda_record_0_ {
    var value_13: Record_cuda_record_0_;

    value_13 = value_12;
    let _e3 = value_13.value;
    value_13.value = (_e3 + 1i);
    let _e6 = value_13;
    return _e6;
}

fn operator_u0026_2(value_14: Record_cuda_record_0_) -> i32 {
    var value_15: Record_cuda_record_0_;

    value_15 = value_14;
    let _e3 = value_15.value;
    return _e3;
}

fn operator_u002d_2(value_16: Record_cuda_record_0_) -> Record_cuda_record_0_ {
    var value_17: Record_cuda_record_0_;

    value_17 = value_16;
    let _e4 = value_17.value;
    value_17.value = -(_e4);
    let _e6 = value_17;
    return _e6;
}

fn operator_u002a_3(value_18: Record_cuda_record_0_, factor: i32) -> Record_cuda_record_0_ {
    var value_19: Record_cuda_record_0_;

    value_19 = value_18;
    let _e4 = value_19.value;
    value_19.value = (_e4 * factor);
    let _e9 = value_19.history[1i];
    value_19.history[1i] = (_e9 + factor);
    let _e11 = value_19;
    return _e11;
}

@compute @workgroup_size(2, 1, 1)
fn operator_functions(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var left: vec2<i32>;
    var local: u32;
    var right: vec2<i32>;
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
    var original: Record_cuda_record_0_;
    var scaled: Record_cuda_record_0_;
    var local_27: u32;
    var local_28: Record_cuda_record_0_;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: vec2<i32>;
    var local_39: vec2<i32>;

    let base = (threadIdx.x * 36u);
    local = u32(threadIdx.x);
    let _e7 = local;
    let _e10 = input[_e7];
    local_39 = _e10;
    let _e12 = local_39;
    local_38 = _e12;
    let _e14 = local_38;
    left = _e14;
    right = vec2<i32>(3i, 2i);
    let _e20 = left;
    let _e21 = operator_u002b(_e20);
    local_1 = u32((base + 0u));
    let _e28 = local_1;
    out[_e28] = u32(_e21.x);
    let _e31 = left;
    let _e32 = operator_u002d(_e31);
    local_2 = u32((base + 1u));
    let _e39 = local_2;
    out[_e39] = u32(_e32.y);
    let _e41 = left;
    let _e42 = operator_u007e(_e41);
    local_3 = u32((base + 2u));
    let _e49 = local_3;
    out[_e49] = u32(_e42.x);
    let _e51 = left;
    let _e52 = operator_u0021_(_e51);
    local_4 = u32((base + 3u));
    let _e58 = local_4;
    out[_e58] = u32(_e52);
    let _e60 = left;
    let _e61 = operator_u002a(_e60);
    local_5 = u32((base + 4u));
    let _e67 = local_5;
    out[_e67] = u32(_e61);
    let _e69 = left;
    let _e70 = operator_u0026_(_e69);
    local_6 = u32((base + 5u));
    let _e77 = local_6;
    out[_e77] = u32(_e70.x);
    let _e79 = left;
    let _e80 = right;
    let _e81 = operator_u002b_1(_e79, _e80);
    local_7 = u32((base + 6u));
    let _e88 = local_7;
    out[_e88] = u32(_e81.x);
    let _e90 = left;
    let _e91 = right;
    let _e92 = operator_u002d_1(_e90, _e91);
    local_8 = u32((base + 7u));
    let _e99 = local_8;
    out[_e99] = u32(_e92.y);
    let _e101 = left;
    let _e102 = right;
    let _e103 = operator_u002a_1(_e101, _e102);
    local_9 = u32((base + 8u));
    let _e110 = local_9;
    out[_e110] = u32(_e103.x);
    let _e112 = left;
    let _e113 = right;
    let _e114 = operator_u002f(_e112, _e113);
    local_10 = u32((base + 9u));
    let _e121 = local_10;
    out[_e121] = u32(_e114.y);
    let _e123 = left;
    let _e124 = right;
    let _e125 = operator_u0025_(_e123, _e124);
    local_11 = u32((base + 10u));
    let _e132 = local_11;
    out[_e132] = u32(_e125.y);
    let _e134 = left;
    let _e135 = right;
    let _e136 = operator_u0026_1(_e134, _e135);
    local_12 = u32((base + 11u));
    let _e143 = local_12;
    out[_e143] = u32(_e136.x);
    let _e145 = left;
    let _e146 = right;
    let _e147 = operator_u007c(_e145, _e146);
    local_13 = u32((base + 12u));
    let _e154 = local_13;
    out[_e154] = u32(_e147.y);
    let _e156 = left;
    let _e157 = right;
    let _e158 = operator_u005e(_e156, _e157);
    local_14 = u32((base + 13u));
    let _e165 = local_14;
    out[_e165] = u32(_e158.x);
    let _e167 = left;
    let _e168 = right;
    let _e169 = operator_(_e167, _e168);
    local_15 = u32((base + 14u));
    let _e176 = local_15;
    out[_e176] = u32(_e169.x);
    let _e178 = left;
    let _e179 = right;
    let _e180 = operator_1(_e178, _e179);
    local_16 = u32((base + 15u));
    let _e187 = local_16;
    out[_e187] = u32(_e180.y);
    let _e189 = left;
    let _e190 = operator_u002b(_e189);
    local_17 = u32((base + 16u));
    let _e197 = local_17;
    out[_e197] = u32(_e190.y);
    let _e199 = left;
    let _e200 = right;
    let _e201 = operator_u002d_1(_e199, _e200);
    local_18 = u32((base + 17u));
    let _e208 = local_18;
    out[_e208] = u32(_e201.x);
    let _e210 = left;
    let _e211 = operator_u002a(_e210);
    local_19 = u32((base + 18u));
    let _e217 = local_19;
    out[_e217] = u32(_e211);
    let _e219 = left;
    let _e220 = right;
    let _e221 = operator_u0026_1(_e219, _e220);
    local_20 = u32((base + 19u));
    let _e228 = local_20;
    out[_e228] = u32(_e221.y);
    let _e230 = left;
    let _e231 = operator_u0026_(_e230);
    let _e232 = operator_u002a(_e231);
    local_21 = u32((base + 20u));
    let _e238 = local_21;
    out[_e238] = u32(_e232);
    let _e240 = left;
    let _e241 = operator_u0026_(_e240);
    let _e242 = operator_u0026_(_e241);
    local_22 = u32((base + 21u));
    let _e249 = local_22;
    out[_e249] = u32(_e242.x);
    let _e251 = left;
    let _e252 = right;
    let _e253 = right;
    let _e254 = operator_u002a_1(_e252, _e253);
    let _e255 = operator_u002b_1(_e251, _e254);
    local_23 = u32((base + 22u));
    let _e262 = local_23;
    out[_e262] = u32(_e255.x);
    let _e264 = left;
    let _e265 = right;
    let _e269 = operator_u002b_1(_e265, vec2<i32>(1i, 1i));
    let _e270 = operator_(_e264, _e269);
    local_24 = u32((base + 23u));
    let _e277 = local_24;
    out[_e277] = u32(_e270.x);
    let _e279 = left;
    let _e280 = right;
    let _e284 = operator_u0026_1(_e280, vec2<i32>(1i, 1i));
    let _e285 = operator_u007c(_e279, _e284);
    local_25 = u32((base + 24u));
    let _e292 = local_25;
    out[_e292] = u32(_e285.y);
    let _e294 = left;
    let _e295 = right;
    let _e296 = operator_u002d_1(_e294, _e295);
    let _e297 = right;
    let _e298 = operator_u002d_1(_e296, _e297);
    local_26 = u32((base + 25u));
    let _e305 = local_26;
    out[_e305] = u32(_e298.x);
    original.value = 9i;
    original.history[0] = 1i;
    original.history[1] = 2i;
    let _e315 = original;
    let _e317 = operator_u002a_3(_e315, 3i);
    scaled = _e317;
    local_28.value = 9i;
    local_28.history[0] = 1i;
    local_28.history[1] = 2i;
    let _e327 = local_28;
    let _e328 = operator_u0026_2(_e327);
    local_27 = u32((base + 26u));
    let _e334 = local_27;
    out[_e334] = u32(_e328);
    let _e336 = original;
    let _e337 = operator_u002a_2(_e336);
    let _e338 = operator_u0026_2(_e337);
    local_29 = u32((base + 27u));
    let _e344 = local_29;
    out[_e344] = u32(_e338);
    let _e347 = scaled.value;
    local_30 = u32((base + 28u));
    let _e353 = local_30;
    out[_e353] = u32(_e347);
    let _e358 = scaled.history[1i];
    local_31 = u32((base + 29u));
    let _e364 = local_31;
    out[_e364] = u32(_e358);
    let _e367 = original.value;
    local_32 = u32((base + 30u));
    let _e373 = local_32;
    out[_e373] = u32(_e367);
    let _e378 = original.history[1i];
    local_33 = u32((base + 31u));
    let _e384 = local_33;
    out[_e384] = u32(_e378);
    let _e386 = original;
    let _e387 = operator_u002d_2(_e386);
    local_34 = u32((base + 32u));
    let _e394 = local_34;
    out[_e394] = u32(_e387.value);
    let _e396 = original;
    let _e398 = operator_u002a_3(_e396, 2i);
    local_35 = u32((base + 33u));
    let _e405 = local_35;
    out[_e405] = u32(_e398.value);
    let _e407 = original;
    let _e408 = operator_u002a_2(_e407);
    let _e409 = operator_u0026_2(_e408);
    local_36 = u32((base + 34u));
    let _e415 = local_36;
    out[_e415] = u32(_e409);
    let _e420 = operator_u0021_(vec2<i32>(0i, 0i));
    local_37 = u32((base + 35u));
    let _e426 = local_37;
    out[_e426] = u32(_e420);
}
