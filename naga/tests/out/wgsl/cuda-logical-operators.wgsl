struct Sample_cuda_record_0_ {
    value: i32,
    payload: array<i32, 2>,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn operator_u0026_u0026_(left_1: Sample_cuda_record_0_, right_1: Sample_cuda_record_0_) -> Sample_cuda_record_0_ {
    var left_2: Sample_cuda_record_0_;
    var right_2: Sample_cuda_record_0_;

    left_2 = left_1;
    right_2 = right_1;
    let _e7 = left_2.value;
    let _e10 = right_2.value;
    left_2.value = ((_e7 * 10i) + _e10);
    let _e18 = right_2.payload[0i];
    let _e19 = left_2.payload[1i];
    left_2.payload[1i] = (_e19 + _e18);
    let _e21 = left_2;
    return _e21;
}

fn operator_u007c_u007c(left_3: Sample_cuda_record_0_, right_3: Sample_cuda_record_0_) -> Sample_cuda_record_0_ {
    var left_4: Sample_cuda_record_0_;
    var right_4: Sample_cuda_record_0_;

    left_4 = left_3;
    right_4 = right_3;
    let _e7 = left_4.value;
    let _e10 = right_4.value;
    left_4.value = ((_e7 * 100i) + _e10);
    let _e18 = right_4.payload[1i];
    let _e19 = left_4.payload[0i];
    left_4.payload[0i] = (_e19 + _e18);
    let _e21 = left_4;
    return _e21;
}

fn operator_u0026_u0026_1(left_5: Sample_cuda_record_0_, right_5: i32) -> i32 {
    var left_6: Sample_cuda_record_0_;

    left_6 = left_5;
    let _e4 = left_6.value;
    return ((_e4 * 10i) + right_5);
}

fn operator_u007c_u007c_1(left_7: i32, right_6: Sample_cuda_record_0_) -> i32 {
    var right_7: Sample_cuda_record_0_;

    right_7 = right_6;
    let _e6 = right_7.value;
    return ((left_7 * 100i) + _e6);
}

fn operator_u0026_u0026_2(left_8: vec2<i32>, right_8: vec2<i32>) -> vec2<i32> {
    var left_9: vec2<i32>;
    var right_9: vec2<i32>;

    left_9 = left_8;
    right_9 = right_8;
    let _e6 = left_9.x;
    let _e9 = right_9.x;
    let _e13 = left_9.y;
    let _e16 = right_9.y;
    return vec2<i32>(((_e6 * 10i) + _e9), ((_e13 * 10i) + _e16));
}

fn operator_u007c_u007c_2(left_10: vec2<i32>, right_10: vec2<i32>) -> vec2<i32> {
    var left_11: vec2<i32>;
    var right_11: vec2<i32>;

    left_11 = left_10;
    right_11 = right_10;
    let _e6 = left_11.x;
    let _e9 = right_11.x;
    let _e13 = left_11.y;
    let _e16 = right_11.y;
    return vec2<i32>(((_e6 * 100i) + _e9), ((_e13 * 100i) + _e16));
}

@compute @workgroup_size(2, 1, 1)
fn logical_operators(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var left: Sample_cuda_record_0_;
    var right: Sample_cuda_record_0_;
    var both: Sample_cuda_record_0_;
    var either: Sample_cuda_record_0_;
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
    var first: vec2<i32>;
    var second: vec2<i32>;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: Sample_cuda_record_0_;
    var local_17: u32;
    var local_18: Sample_cuda_record_0_;
    var counter: i32;
    var evaluated: Sample_cuda_record_0_;
    var local_19: Sample_cuda_record_0_;
    var local_20: Sample_cuda_record_0_;
    var local_21: Sample_cuda_record_0_;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: bool;
    var local_26: u32;
    var local_27: bool;
    var local_28: u32;
    var local_29: bool;
    var local_30: u32;
    var local_31: bool;
    var local_32: u32;

    let base = (threadIdx.x * 24u);
    left.value = 2i;
    left.payload[0] = 3i;
    left.payload[1] = 4i;
    right.value = 5i;
    right.payload[0] = 6i;
    right.payload[1] = 7i;
    let _e20 = left;
    let _e21 = right;
    let _e22 = operator_u0026_u0026_(_e20, _e21);
    both = _e22;
    let _e24 = left;
    let _e25 = right;
    let _e26 = operator_u007c_u007c(_e24, _e25);
    either = _e26;
    let _e29 = both.value;
    local = u32((base + 0u));
    let _e35 = local;
    out[_e35] = u32(_e29);
    let _e41 = both.payload[1i];
    local_1 = u32((base + 1u));
    let _e47 = local_1;
    out[_e47] = u32(_e41);
    let _e50 = either.value;
    local_2 = u32((base + 2u));
    let _e56 = local_2;
    out[_e56] = u32(_e50);
    let _e61 = either.payload[0i];
    local_3 = u32((base + 3u));
    let _e67 = local_3;
    out[_e67] = u32(_e61);
    let _e70 = left.value;
    local_4 = u32((base + 4u));
    let _e76 = local_4;
    out[_e76] = u32(_e70);
    let _e81 = left.payload[1i];
    local_5 = u32((base + 5u));
    let _e87 = local_5;
    out[_e87] = u32(_e81);
    let _e89 = left;
    let _e91 = operator_u0026_u0026_1(_e89, 9i);
    local_6 = u32((base + 6u));
    let _e97 = local_6;
    out[_e97] = u32(_e91);
    let _e99 = right;
    let _e101 = operator_u007c_u007c_1(0i, _e99);
    local_7 = u32((base + 7u));
    let _e107 = local_7;
    out[_e107] = u32(_e101);
    let _e109 = left;
    let _e110 = right;
    let _e111 = operator_u0026_u0026_(_e109, _e110);
    local_8 = u32((base + 8u));
    let _e118 = local_8;
    out[_e118] = u32(_e111.value);
    let _e120 = left;
    let _e121 = right;
    let _e122 = operator_u007c_u007c(_e120, _e121);
    local_9 = u32((base + 9u));
    let _e131 = local_9;
    out[_e131] = u32(_e122.payload[0i]);
    first = vec2<i32>(2i, 3i);
    second = vec2<i32>(4i, 5i);
    let _e141 = first;
    let _e142 = second;
    let _e143 = operator_u0026_u0026_2(_e141, _e142);
    local_10 = u32((base + 10u));
    let _e150 = local_10;
    out[_e150] = u32(_e143.x);
    let _e152 = first;
    let _e153 = second;
    let _e154 = operator_u007c_u007c_2(_e152, _e153);
    local_11 = u32((base + 11u));
    let _e161 = local_11;
    out[_e161] = u32(_e154.y);
    let _e163 = first;
    let _e164 = second;
    let _e165 = operator_u0026_u0026_2(_e163, _e164);
    let _e166 = first;
    let _e167 = operator_u0026_u0026_2(_e165, _e166);
    local_12 = u32((base + 12u));
    let _e174 = local_12;
    out[_e174] = u32(_e167.x);
    let _e176 = first;
    let _e177 = second;
    let _e178 = first;
    let _e179 = operator_u0026_u0026_2(_e177, _e178);
    let _e180 = operator_u007c_u007c_2(_e176, _e179);
    local_13 = u32((base + 13u));
    let _e187 = local_13;
    out[_e187] = u32(_e180.y);
    let _e189 = first;
    let _e190 = second;
    let _e191 = operator_u007c_u007c_2(_e189, _e190);
    let _e192 = first;
    let _e193 = operator_u0026_u0026_2(_e191, _e192);
    local_14 = u32((base + 14u));
    let _e200 = local_14;
    out[_e200] = u32(_e193.x);
    if true {
        let _e203 = left;
        local_16 = _e203;
    } else {
        let _e205 = right;
        local_16 = _e205;
    }
    let _e208 = local_16;
    let _e210 = operator_u0026_u0026_1(_e208, 1i);
    local_15 = u32((base + 15u));
    let _e216 = local_15;
    out[_e216] = u32(_e210);
    if true {
        let _e219 = left;
        let _e220 = right;
        let _e221 = operator_u0026_u0026_(_e219, _e220);
        local_18 = _e221;
    } else {
        let _e223 = right;
        let _e224 = left;
        let _e225 = operator_u007c_u007c(_e223, _e224);
        local_18 = _e225;
    }
    let _e228 = local_18;
    local_17 = u32((base + 16u));
    let _e235 = local_17;
    out[_e235] = u32(_e228.value);
    counter = 0i;
    if false {
        let _e240 = counter;
        counter = (_e240 + 1i);
        local_19.value = _e240;
        local_19.payload[0] = 1i;
        local_19.payload[1] = 2i;
        let _e250 = local_19;
        let _e251 = right;
        let _e252 = operator_u0026_u0026_(_e250, _e251);
        local_21 = _e252;
    } else {
        let _e254 = left;
        let _e255 = counter;
        counter = (_e255 + 1i);
        local_20.value = _e255;
        local_20.payload[0] = 1i;
        local_20.payload[1] = 2i;
        let _e265 = local_20;
        let _e266 = operator_u007c_u007c(_e254, _e265);
        local_21 = _e266;
    }
    let _e269 = local_21;
    evaluated = _e269;
    let _e272 = evaluated.value;
    local_22 = u32((base + 17u));
    let _e278 = local_22;
    out[_e278] = u32(_e272);
    let _e280 = counter;
    local_23 = u32((base + 18u));
    let _e286 = local_23;
    out[_e286] = u32(_e280);
    local_25 = false;
    if false {
        let _e290 = left;
        let _e291 = right;
        let _e292 = operator_u0026_u0026_(_e290, _e291);
        local_25 = (_e292.value != 0i);
    }
    let _e296 = local_25;
    local_24 = u32((base + 19u));
    let _e302 = local_24;
    out[_e302] = u32(_e296);
    local_27 = true;
    if true {
    } else {
        let _e306 = left;
        let _e307 = right;
        let _e308 = operator_u007c_u007c(_e306, _e307);
        local_27 = (_e308.value != 0i);
    }
    let _e312 = local_27;
    local_26 = u32((base + 20u));
    let _e318 = local_26;
    out[_e318] = u32(_e312);
    let _e322 = (2i != 0i);
    local_29 = _e322;
    if _e322 {
        local_29 = (3i != 0i);
    }
    let _e327 = local_29;
    local_28 = u32((base + 21u));
    let _e333 = local_28;
    out[_e333] = u32(_e327);
    let _e337 = (0i != 0i);
    local_31 = _e337;
    if _e337 {
    } else {
        local_31 = (4i != 0i);
    }
    let _e342 = local_31;
    local_30 = u32((base + 22u));
    let _e348 = local_30;
    out[_e348] = u32(_e342);
    local_32 = u32((base + 23u));
    let _e355 = local_32;
    out[_e355] = threadIdx.x;
}
