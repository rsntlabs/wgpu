struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input_a: array<i32>;
@group(0) @binding(2)
var<storage> input_b: array<i32>;
@group(0) @binding(3)
var<uniform> n: type_3;
var<workgroup> shared_values: array<i32, 64>;

fn shifted(value_1: i32) -> i32 {
    return (value_1 + 10i);
}

fn discard_(value_2: i32) {
    var value_3: i32;

    value_3 = value_2;
    let _e3 = value_3;
    value_3 = (_e3 + 1i);
    return;
}

fn pair(x: i32, y: i32) -> i32 {
    return ((x * 10i) + y);
}

@compute @workgroup_size(64, 1, 1)
fn conditionals(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var base: u32;
    var choose_a: bool;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: i32;
    var a: i32;
    var b: i32;
    var local_4: u32;
    var local_5: i32;
    var local_6: u32;
    var local_7: u32;
    var index_a: i32;
    var index_b: i32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: i32;
    var local_15: u32;
    var local_16: i32;
    var local_17: u32;
    var c: i32;
    var local_18: u32;
    var local_19: i32;
    var local_20: u32;
    var condition: i32;
    var local_21: u32;
    var local_22: u32;
    var lane: u32;
    var local_value: i32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: f32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: bool;
    var local_32: u32;
    var local_33: i32;
    var local_34: u32;
    var local_35: u32;
    var shift_value: i32;
    var local_36: u32;
    var local_37: i32;
    var local_38: u32;
    var value: i32;
    var other: i32;
    var local_39: u32;
    var local_40: i32;
    var count: i32;
    var left: i32;
    var right: i32;
    var local_41: u32;
    var local_42: i32;
    var local_43: i32;
    var local_44: u32;
    var local_45: i32;
    var local_46: u32;
    var local_47: i32;
    var local_48: u32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;
    var local_66: u32;
    var local_67: u32;
    var local_68: u32;
    var local_69: u32;
    var local_70: u32;
    var local_71: u32;
    var local_72: u32;

    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 25u);
        choose_a = ((i % 2u) == 0u);
        let _e19 = choose_a;
        if _e19 {
            local_1 = i;
            let _e21 = local_1;
            local_44 = _e21;
            let _e23 = local_44;
            let _e26 = input_a[_e23];
            local_45 = _e26;
            let _e28 = local_45;
            local_42 = _e28;
            let _e30 = local_42;
            local_3 = _e30;
        } else {
            local_2 = i;
            let _e33 = local_2;
            local_46 = _e33;
            let _e35 = local_46;
            let _e38 = input_b[_e35];
            local_47 = _e38;
            let _e40 = local_47;
            local_43 = _e40;
            let _e42 = local_43;
            local_3 = _e42;
        }
        let _e45 = local_3;
        let _e46 = base;
        local = _e46;
        let _e48 = local;
        local_48 = _e48;
        let _e50 = local_48;
        out[_e50] = _e45;
        a = 3i;
        b = 5i;
        let _e57 = choose_a;
        if _e57 {
            let _e58 = a;
            a = (_e58 + 1i);
            let _e61 = shifted(_e58);
            local_5 = _e61;
        } else {
            let _e63 = b;
            b = (_e63 + 1i);
            let _e66 = shifted(_e63);
            local_5 = _e66;
        }
        let _e69 = local_5;
        let _e70 = base;
        local_4 = u32((_e70 + 1u));
        let _e75 = local_4;
        local_49 = _e75;
        let _e77 = local_49;
        out[_e77] = _e69;
        let _e79 = a;
        let _e82 = b;
        let _e84 = base;
        local_6 = u32((_e84 + 2u));
        let _e89 = local_6;
        local_50 = _e89;
        let _e91 = local_50;
        out[_e91] = ((_e79 * 10i) + _e82);
        let _e93 = choose_a;
        if _e93 {
            let _e94 = a;
            a = (_e94 + 1i);
            discard_(_e94);
        } else {
            let _e97 = b;
            b = (_e97 + 1i);
            discard_(_e97);
        }
        let _e100 = a;
        let _e103 = b;
        let _e105 = base;
        local_7 = u32((_e105 + 3u));
        let _e110 = local_7;
        local_51 = _e110;
        let _e112 = local_51;
        out[_e112] = ((_e100 * 10i) + _e103);
        index_a = 0i;
        index_b = 0i;
        let _e118 = choose_a;
        if _e118 {
            let _e119 = index_a;
            index_a = (_e119 + 1i);
            local_8 = u32(_e119);
        } else {
            let _e124 = index_b;
            index_b = (_e124 + 1i);
            local_9 = u32(_e124);
        }
        let _e129 = index_a;
        let _e132 = index_b;
        let _e134 = base;
        local_10 = u32((_e134 + 4u));
        let _e139 = local_10;
        local_52 = _e139;
        let _e141 = local_52;
        out[_e141] = ((_e129 * 10i) + _e132);
        a = 3i;
        b = 5i;
        let _e145 = choose_a;
        if _e145 {
            a = 7i;
        } else {
            b = 7i;
        }
        let _e148 = a;
        let _e151 = b;
        let _e153 = base;
        local_11 = u32((_e153 + 5u));
        let _e158 = local_11;
        local_53 = _e158;
        let _e160 = local_53;
        out[_e160] = ((_e148 * 10i) + _e151);
        let _e162 = choose_a;
        if _e162 {
            let _e163 = a;
            a = (_e163 + 2i);
        } else {
            let _e166 = b;
            b = (_e166 + 2i);
        }
        let _e169 = a;
        let _e172 = b;
        let _e174 = base;
        local_12 = u32((_e174 + 6u));
        let _e179 = local_12;
        local_54 = _e179;
        let _e181 = local_54;
        out[_e181] = ((_e169 * 10i) + _e172);
        let _e183 = choose_a;
        if _e183 {
            let _e184 = a;
            a = (_e184 + 1i);
            let _e187 = a;
            local_14 = _e187;
        } else {
            let _e189 = b;
            b = (_e189 + 1i);
            let _e192 = b;
            local_14 = _e192;
        }
        let _e195 = local_14;
        let _e196 = base;
        local_13 = u32((_e196 + 7u));
        let _e201 = local_13;
        local_55 = _e201;
        let _e203 = local_55;
        out[_e203] = _e195;
        let _e205 = choose_a;
        if _e205 {
            let _e206 = a;
            a = (_e206 + 1i);
            local_16 = _e206;
        } else {
            let _e210 = b;
            b = (_e210 + 1i);
            local_16 = _e210;
        }
        let _e215 = local_16;
        let _e216 = base;
        local_15 = u32((_e216 + 8u));
        let _e221 = local_15;
        local_56 = _e221;
        let _e223 = local_56;
        out[_e223] = _e215;
        let _e225 = a;
        let _e228 = b;
        let _e230 = base;
        local_17 = u32((_e230 + 9u));
        let _e235 = local_17;
        local_57 = _e235;
        let _e237 = local_57;
        out[_e237] = ((_e225 * 100i) + _e228);
        let _e239 = choose_a;
        c = i32(_e239);
        b = 7i;
        let _e243 = c;
        if (_e243 != 0i) {
            c = 0i;
            let _e247 = c;
            c = (_e247 + 1i);
            local_19 = _e247;
        } else {
            b = 0i;
            let _e252 = b;
            b = (_e252 + 1i);
            local_19 = _e252;
        }
        let _e257 = local_19;
        let _e258 = base;
        local_18 = u32((_e258 + 10u));
        let _e263 = local_18;
        local_58 = _e263;
        let _e265 = local_58;
        out[_e265] = _e257;
        let _e267 = c;
        let _e270 = b;
        let _e272 = base;
        local_20 = u32((_e272 + 11u));
        let _e277 = local_20;
        local_59 = _e277;
        let _e279 = local_59;
        out[_e279] = ((_e267 * 10i) + _e270);
        condition = 0i;
        a = 2i;
        b = 4i;
        condition = 1i;
        let _e286 = condition;
        let _e287 = condition;
        if (_e287 != 0i) {
            a = _e286;
        } else {
            b = _e286;
        }
        let _e290 = a;
        let _e293 = b;
        let _e295 = base;
        local_21 = u32((_e295 + 12u));
        let _e300 = local_21;
        local_60 = _e300;
        let _e302 = local_60;
        out[_e302] = ((_e290 * 10i) + _e293);
        a = 2i;
        b = 4i;
        c = 6i;
        let _e307 = choose_a;
        if _e307 {
            if ((i % 4u) == 0u) {
                let _e312 = a;
                a = (_e312 + 3i);
            } else {
                let _e315 = b;
                b = (_e315 + 3i);
            }
        } else {
            let _e318 = c;
            c = (_e318 + 3i);
        }
        let _e321 = a;
        let _e324 = b;
        let _e328 = c;
        let _e330 = base;
        local_22 = u32((_e330 + 13u));
        let _e335 = local_22;
        local_61 = _e335;
        let _e337 = local_61;
        out[_e337] = (((_e321 * 100i) + (_e324 * 10i)) + _e328);
        lane = threadIdx.x;
        let _e341 = lane;
        shared_values[_e341] = 20i;
        local_value = 10i;
        let _e347 = choose_a;
        if _e347 {
            let _e348 = local_value;
            local_value = (_e348 + 5i);
        } else {
            let _e351 = lane;
            let _e353 = shared_values[_e351];
            shared_values[_e351] = (_e353 + 5i);
        }
        let _e356 = local_value;
        let _e359 = lane;
        let _e361 = shared_values[_e359];
        let _e363 = base;
        local_23 = u32((_e363 + 14u));
        let _e368 = local_23;
        local_62 = _e368;
        let _e370 = local_62;
        out[_e370] = ((_e356 * 100i) + _e361);
        let _e372 = choose_a;
        if _e372 {
            let _e373 = lane;
            shared_values[_e373] = 30i;
        } else {
            let _e376 = base;
            local_24 = u32((_e376 + 15u));
            let _e381 = local_24;
            local_63 = _e381;
            let _e383 = local_63;
            out[_e383] = 30i;
        }
        let _e386 = lane;
        let _e388 = shared_values[_e386];
        let _e389 = base;
        local_25 = u32((_e389 + 16u));
        let _e394 = local_25;
        local_64 = _e394;
        let _e396 = local_64;
        out[_e396] = _e388;
        let _e398 = choose_a;
        if _e398 {
            local_27 = 1.5f;
        } else {
            local_27 = f32(3i);
        }
        let _e405 = local_27;
        let _e406 = base;
        local_26 = u32((_e406 + 17u));
        let _e412 = local_26;
        local_65 = _e412;
        let _e414 = local_65;
        out[_e414] = i32(_e405);
        let _e416 = choose_a;
        if _e416 {
            local_29 = u32(-(1i));
        } else {
            local_29 = 2u;
        }
        let _e424 = local_29;
        let _e425 = base;
        local_28 = u32((_e425 + 18u));
        let _e431 = local_28;
        local_66 = _e431;
        let _e433 = local_66;
        out[_e433] = i32(_e424);
        let _e435 = choose_a;
        if _e435 {
            local_31 = true;
        } else {
            local_31 = false;
        }
        let _e441 = local_31;
        let _e442 = base;
        local_30 = u32((_e442 + 19u));
        let _e448 = local_30;
        local_67 = _e448;
        let _e450 = local_67;
        out[_e450] = i32(_e441);
        let _e452 = choose_a;
        if _e452 {
            local_33 = i32(true);
        } else {
            local_33 = 2i;
        }
        let _e459 = local_33;
        let _e460 = base;
        local_32 = u32((_e460 + 20u));
        let _e465 = local_32;
        local_68 = _e465;
        let _e467 = local_68;
        out[_e467] = _e459;
        let _e469 = choose_a;
        if _e469 {
            local_35 = 4u;
        } else {
            local_35 = 8u;
        }
        let _e475 = local_35;
        let _e476 = base;
        local_34 = u32((_e476 + 21u));
        let _e482 = local_34;
        local_69 = _e482;
        let _e484 = local_69;
        out[_e484] = i32(_e475);
        a = 3i;
        shift_value = 2i;
        let _e489 = choose_a;
        if _e489 {
            let _e490 = shift_value;
            local_37 = _e490;
        } else {
            let _e492 = a;
            local_37 = _e492;
        }
        let _e495 = local_37;
        shift_value = 1i;
        let _e497 = shift_value;
        local_38 = u32(_e497);
        let _e500 = local_38;
        let _e502 = base;
        local_36 = u32((_e502 + 22u));
        let _e507 = local_36;
        local_70 = _e507;
        let _e509 = local_70;
        out[_e509] = (_e495 << _e500);
        value = 3i;
        other = 7i;
        let _e515 = choose_a;
        if _e515 {
            let _e516 = value;
            local_40 = _e516;
        } else {
            let _e518 = other;
            local_40 = _e518;
        }
        let _e521 = local_40;
        let _e522 = value;
        value = (_e522 + 1i);
        let _e525 = pair(_e521, _e522);
        let _e526 = base;
        local_39 = u32((_e526 + 23u));
        let _e531 = local_39;
        local_71 = _e531;
        let _e533 = local_71;
        out[_e533] = _e525;
        count = 0i;
        left = 0i;
        right = 0i;
        {
            loop {
                let _e541 = count;
                if (_e541 < 3i) {
                } else {
                    break;
                }
                let _e544 = count;
                count = (_e544 + 1i);
                let _e547 = count;
                if (_e547 == 2i) {
                    continue;
                }
                continuing {
                    let _e550 = choose_a;
                    if _e550 {
                        let _e551 = left;
                        left = (_e551 + 1i);
                    } else {
                        let _e554 = right;
                        right = (_e554 + 1i);
                    }
                }
            }
        }
        let _e557 = left;
        let _e560 = right;
        let _e564 = count;
        let _e566 = base;
        local_41 = u32((_e566 + 24u));
        let _e571 = local_41;
        local_72 = _e571;
        let _e573 = local_72;
        out[_e573] = (((_e557 * 100i) + (_e560 * 10i)) + _e564);
    }
}
