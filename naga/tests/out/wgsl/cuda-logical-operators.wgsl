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
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
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
    var local_54: u32;
    var local_55: u32;
    var local_56: u32;

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
    local_33 = u32(_e35);
    let _e38 = local_33;
    out[_e38] = u32(_e29);
    let _e44 = both.payload[1i];
    local_1 = u32((base + 1u));
    let _e50 = local_1;
    local_34 = u32(_e50);
    let _e53 = local_34;
    out[_e53] = u32(_e44);
    let _e56 = either.value;
    local_2 = u32((base + 2u));
    let _e62 = local_2;
    local_35 = u32(_e62);
    let _e65 = local_35;
    out[_e65] = u32(_e56);
    let _e70 = either.payload[0i];
    local_3 = u32((base + 3u));
    let _e76 = local_3;
    local_36 = u32(_e76);
    let _e79 = local_36;
    out[_e79] = u32(_e70);
    let _e82 = left.value;
    local_4 = u32((base + 4u));
    let _e88 = local_4;
    local_37 = u32(_e88);
    let _e91 = local_37;
    out[_e91] = u32(_e82);
    let _e96 = left.payload[1i];
    local_5 = u32((base + 5u));
    let _e102 = local_5;
    local_38 = u32(_e102);
    let _e105 = local_38;
    out[_e105] = u32(_e96);
    let _e107 = left;
    let _e109 = operator_u0026_u0026_1(_e107, 9i);
    local_6 = u32((base + 6u));
    let _e115 = local_6;
    local_39 = u32(_e115);
    let _e118 = local_39;
    out[_e118] = u32(_e109);
    let _e120 = right;
    let _e122 = operator_u007c_u007c_1(0i, _e120);
    local_7 = u32((base + 7u));
    let _e128 = local_7;
    local_40 = u32(_e128);
    let _e131 = local_40;
    out[_e131] = u32(_e122);
    let _e133 = left;
    let _e134 = right;
    let _e135 = operator_u0026_u0026_(_e133, _e134);
    local_8 = u32((base + 8u));
    let _e142 = local_8;
    local_41 = u32(_e142);
    let _e145 = local_41;
    out[_e145] = u32(_e135.value);
    let _e147 = left;
    let _e148 = right;
    let _e149 = operator_u007c_u007c(_e147, _e148);
    local_9 = u32((base + 9u));
    let _e158 = local_9;
    local_42 = u32(_e158);
    let _e161 = local_42;
    out[_e161] = u32(_e149.payload[0i]);
    first = vec2<i32>(2i, 3i);
    second = vec2<i32>(4i, 5i);
    let _e171 = first;
    let _e172 = second;
    let _e173 = operator_u0026_u0026_2(_e171, _e172);
    local_10 = u32((base + 10u));
    let _e180 = local_10;
    local_43 = u32(_e180);
    let _e183 = local_43;
    out[_e183] = u32(_e173.x);
    let _e185 = first;
    let _e186 = second;
    let _e187 = operator_u007c_u007c_2(_e185, _e186);
    local_11 = u32((base + 11u));
    let _e194 = local_11;
    local_44 = u32(_e194);
    let _e197 = local_44;
    out[_e197] = u32(_e187.y);
    let _e199 = first;
    let _e200 = second;
    let _e201 = operator_u0026_u0026_2(_e199, _e200);
    let _e202 = first;
    let _e203 = operator_u0026_u0026_2(_e201, _e202);
    local_12 = u32((base + 12u));
    let _e210 = local_12;
    local_45 = u32(_e210);
    let _e213 = local_45;
    out[_e213] = u32(_e203.x);
    let _e215 = first;
    let _e216 = second;
    let _e217 = first;
    let _e218 = operator_u0026_u0026_2(_e216, _e217);
    let _e219 = operator_u007c_u007c_2(_e215, _e218);
    local_13 = u32((base + 13u));
    let _e226 = local_13;
    local_46 = u32(_e226);
    let _e229 = local_46;
    out[_e229] = u32(_e219.y);
    let _e231 = first;
    let _e232 = second;
    let _e233 = operator_u007c_u007c_2(_e231, _e232);
    let _e234 = first;
    let _e235 = operator_u0026_u0026_2(_e233, _e234);
    local_14 = u32((base + 14u));
    let _e242 = local_14;
    local_47 = u32(_e242);
    let _e245 = local_47;
    out[_e245] = u32(_e235.x);
    if true {
        let _e248 = left;
        local_16 = _e248;
    } else {
        let _e250 = right;
        local_16 = _e250;
    }
    let _e253 = local_16;
    let _e255 = operator_u0026_u0026_1(_e253, 1i);
    local_15 = u32((base + 15u));
    let _e261 = local_15;
    local_48 = u32(_e261);
    let _e264 = local_48;
    out[_e264] = u32(_e255);
    if true {
        let _e267 = left;
        let _e268 = right;
        let _e269 = operator_u0026_u0026_(_e267, _e268);
        local_18 = _e269;
    } else {
        let _e271 = right;
        let _e272 = left;
        let _e273 = operator_u007c_u007c(_e271, _e272);
        local_18 = _e273;
    }
    let _e276 = local_18;
    local_17 = u32((base + 16u));
    let _e283 = local_17;
    local_49 = u32(_e283);
    let _e286 = local_49;
    out[_e286] = u32(_e276.value);
    counter = 0i;
    if false {
        let _e291 = counter;
        counter = (_e291 + 1i);
        local_19.value = _e291;
        local_19.payload[0] = 1i;
        local_19.payload[1] = 2i;
        let _e301 = local_19;
        let _e302 = right;
        let _e303 = operator_u0026_u0026_(_e301, _e302);
        local_21 = _e303;
    } else {
        let _e305 = left;
        let _e306 = counter;
        counter = (_e306 + 1i);
        local_20.value = _e306;
        local_20.payload[0] = 1i;
        local_20.payload[1] = 2i;
        let _e316 = local_20;
        let _e317 = operator_u007c_u007c(_e305, _e316);
        local_21 = _e317;
    }
    let _e320 = local_21;
    evaluated = _e320;
    let _e323 = evaluated.value;
    local_22 = u32((base + 17u));
    let _e329 = local_22;
    local_50 = u32(_e329);
    let _e332 = local_50;
    out[_e332] = u32(_e323);
    let _e334 = counter;
    local_23 = u32((base + 18u));
    let _e340 = local_23;
    local_51 = u32(_e340);
    let _e343 = local_51;
    out[_e343] = u32(_e334);
    local_25 = false;
    if false {
        let _e347 = left;
        let _e348 = right;
        let _e349 = operator_u0026_u0026_(_e347, _e348);
        local_25 = (_e349.value != 0i);
    }
    let _e353 = local_25;
    local_24 = u32((base + 19u));
    let _e359 = local_24;
    local_52 = u32(_e359);
    let _e362 = local_52;
    out[_e362] = u32(_e353);
    local_27 = true;
    if true {
    } else {
        let _e366 = left;
        let _e367 = right;
        let _e368 = operator_u007c_u007c(_e366, _e367);
        local_27 = (_e368.value != 0i);
    }
    let _e372 = local_27;
    local_26 = u32((base + 20u));
    let _e378 = local_26;
    local_53 = u32(_e378);
    let _e381 = local_53;
    out[_e381] = u32(_e372);
    let _e385 = (2i != 0i);
    local_29 = _e385;
    if _e385 {
        local_29 = (3i != 0i);
    }
    let _e390 = local_29;
    local_28 = u32((base + 21u));
    let _e396 = local_28;
    local_54 = u32(_e396);
    let _e399 = local_54;
    out[_e399] = u32(_e390);
    let _e403 = (0i != 0i);
    local_31 = _e403;
    if _e403 {
    } else {
        local_31 = (4i != 0i);
    }
    let _e408 = local_31;
    local_30 = u32((base + 22u));
    let _e414 = local_30;
    local_55 = u32(_e414);
    let _e417 = local_55;
    out[_e417] = u32(_e408);
    local_32 = u32((base + 23u));
    let _e424 = local_32;
    local_56 = u32(_e424);
    let _e427 = local_56;
    out[_e427] = threadIdx.x;
}
