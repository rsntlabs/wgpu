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
            local_1 = u32(i);
            let _e22 = local_1;
            local_44 = u32(_e22);
            let _e25 = local_44;
            let _e28 = input_a[_e25];
            local_45 = _e28;
            let _e30 = local_45;
            local_42 = _e30;
            let _e32 = local_42;
            local_3 = _e32;
        } else {
            local_2 = u32(i);
            let _e36 = local_2;
            local_46 = u32(_e36);
            let _e39 = local_46;
            let _e42 = input_b[_e39];
            local_47 = _e42;
            let _e44 = local_47;
            local_43 = _e44;
            let _e46 = local_43;
            local_3 = _e46;
        }
        let _e49 = local_3;
        let _e50 = base;
        local = u32(_e50);
        let _e53 = local;
        local_48 = u32(_e53);
        let _e56 = local_48;
        out[_e56] = _e49;
        a = 3i;
        b = 5i;
        let _e63 = choose_a;
        if _e63 {
            let _e64 = a;
            a = (_e64 + 1i);
            let _e67 = shifted(_e64);
            local_5 = _e67;
        } else {
            let _e69 = b;
            b = (_e69 + 1i);
            let _e72 = shifted(_e69);
            local_5 = _e72;
        }
        let _e75 = local_5;
        let _e76 = base;
        local_4 = u32((_e76 + 1u));
        let _e81 = local_4;
        local_49 = u32(_e81);
        let _e84 = local_49;
        out[_e84] = _e75;
        let _e86 = a;
        let _e89 = b;
        let _e91 = base;
        local_6 = u32((_e91 + 2u));
        let _e96 = local_6;
        local_50 = u32(_e96);
        let _e99 = local_50;
        out[_e99] = ((_e86 * 10i) + _e89);
        let _e101 = choose_a;
        if _e101 {
            let _e102 = a;
            a = (_e102 + 1i);
            discard_(_e102);
        } else {
            let _e105 = b;
            b = (_e105 + 1i);
            discard_(_e105);
        }
        let _e108 = a;
        let _e111 = b;
        let _e113 = base;
        local_7 = u32((_e113 + 3u));
        let _e118 = local_7;
        local_51 = u32(_e118);
        let _e121 = local_51;
        out[_e121] = ((_e108 * 10i) + _e111);
        index_a = 0i;
        index_b = 0i;
        let _e127 = choose_a;
        if _e127 {
            let _e128 = index_a;
            index_a = (_e128 + 1i);
            local_8 = u32(_e128);
        } else {
            let _e133 = index_b;
            index_b = (_e133 + 1i);
            local_9 = u32(_e133);
        }
        let _e138 = index_a;
        let _e141 = index_b;
        let _e143 = base;
        local_10 = u32((_e143 + 4u));
        let _e148 = local_10;
        local_52 = u32(_e148);
        let _e151 = local_52;
        out[_e151] = ((_e138 * 10i) + _e141);
        a = 3i;
        b = 5i;
        let _e155 = choose_a;
        if _e155 {
            a = 7i;
        } else {
            b = 7i;
        }
        let _e158 = a;
        let _e161 = b;
        let _e163 = base;
        local_11 = u32((_e163 + 5u));
        let _e168 = local_11;
        local_53 = u32(_e168);
        let _e171 = local_53;
        out[_e171] = ((_e158 * 10i) + _e161);
        let _e173 = choose_a;
        if _e173 {
            let _e174 = a;
            a = (_e174 + 2i);
        } else {
            let _e177 = b;
            b = (_e177 + 2i);
        }
        let _e180 = a;
        let _e183 = b;
        let _e185 = base;
        local_12 = u32((_e185 + 6u));
        let _e190 = local_12;
        local_54 = u32(_e190);
        let _e193 = local_54;
        out[_e193] = ((_e180 * 10i) + _e183);
        let _e195 = choose_a;
        if _e195 {
            let _e196 = a;
            a = (_e196 + 1i);
            let _e199 = a;
            local_14 = _e199;
        } else {
            let _e201 = b;
            b = (_e201 + 1i);
            let _e204 = b;
            local_14 = _e204;
        }
        let _e207 = local_14;
        let _e208 = base;
        local_13 = u32((_e208 + 7u));
        let _e213 = local_13;
        local_55 = u32(_e213);
        let _e216 = local_55;
        out[_e216] = _e207;
        let _e218 = choose_a;
        if _e218 {
            let _e219 = a;
            a = (_e219 + 1i);
            local_16 = _e219;
        } else {
            let _e223 = b;
            b = (_e223 + 1i);
            local_16 = _e223;
        }
        let _e228 = local_16;
        let _e229 = base;
        local_15 = u32((_e229 + 8u));
        let _e234 = local_15;
        local_56 = u32(_e234);
        let _e237 = local_56;
        out[_e237] = _e228;
        let _e239 = a;
        let _e242 = b;
        let _e244 = base;
        local_17 = u32((_e244 + 9u));
        let _e249 = local_17;
        local_57 = u32(_e249);
        let _e252 = local_57;
        out[_e252] = ((_e239 * 100i) + _e242);
        let _e254 = choose_a;
        c = i32(_e254);
        b = 7i;
        let _e258 = c;
        if (_e258 != 0i) {
            c = 0i;
            let _e262 = c;
            c = (_e262 + 1i);
            local_19 = _e262;
        } else {
            b = 0i;
            let _e267 = b;
            b = (_e267 + 1i);
            local_19 = _e267;
        }
        let _e272 = local_19;
        let _e273 = base;
        local_18 = u32((_e273 + 10u));
        let _e278 = local_18;
        local_58 = u32(_e278);
        let _e281 = local_58;
        out[_e281] = _e272;
        let _e283 = c;
        let _e286 = b;
        let _e288 = base;
        local_20 = u32((_e288 + 11u));
        let _e293 = local_20;
        local_59 = u32(_e293);
        let _e296 = local_59;
        out[_e296] = ((_e283 * 10i) + _e286);
        condition = 0i;
        a = 2i;
        b = 4i;
        condition = 1i;
        let _e303 = condition;
        let _e304 = condition;
        if (_e304 != 0i) {
            a = _e303;
        } else {
            b = _e303;
        }
        let _e307 = a;
        let _e310 = b;
        let _e312 = base;
        local_21 = u32((_e312 + 12u));
        let _e317 = local_21;
        local_60 = u32(_e317);
        let _e320 = local_60;
        out[_e320] = ((_e307 * 10i) + _e310);
        a = 2i;
        b = 4i;
        c = 6i;
        let _e325 = choose_a;
        if _e325 {
            if ((i % 4u) == 0u) {
                let _e330 = a;
                a = (_e330 + 3i);
            } else {
                let _e333 = b;
                b = (_e333 + 3i);
            }
        } else {
            let _e336 = c;
            c = (_e336 + 3i);
        }
        let _e339 = a;
        let _e342 = b;
        let _e346 = c;
        let _e348 = base;
        local_22 = u32((_e348 + 13u));
        let _e353 = local_22;
        local_61 = u32(_e353);
        let _e356 = local_61;
        out[_e356] = (((_e339 * 100i) + (_e342 * 10i)) + _e346);
        lane = threadIdx.x;
        let _e360 = lane;
        shared_values[_e360] = 20i;
        local_value = 10i;
        let _e366 = choose_a;
        if _e366 {
            let _e367 = local_value;
            local_value = (_e367 + 5i);
        } else {
            let _e370 = lane;
            let _e372 = shared_values[_e370];
            shared_values[_e370] = (_e372 + 5i);
        }
        let _e375 = local_value;
        let _e378 = lane;
        let _e380 = shared_values[_e378];
        let _e382 = base;
        local_23 = u32((_e382 + 14u));
        let _e387 = local_23;
        local_62 = u32(_e387);
        let _e390 = local_62;
        out[_e390] = ((_e375 * 100i) + _e380);
        let _e392 = choose_a;
        if _e392 {
            let _e393 = lane;
            shared_values[_e393] = 30i;
        } else {
            let _e396 = base;
            local_24 = u32((_e396 + 15u));
            let _e401 = local_24;
            local_63 = u32(_e401);
            let _e404 = local_63;
            out[_e404] = 30i;
        }
        let _e407 = lane;
        let _e409 = shared_values[_e407];
        let _e410 = base;
        local_25 = u32((_e410 + 16u));
        let _e415 = local_25;
        local_64 = u32(_e415);
        let _e418 = local_64;
        out[_e418] = _e409;
        let _e420 = choose_a;
        if _e420 {
            local_27 = 1.5f;
        } else {
            local_27 = f32(3i);
        }
        let _e427 = local_27;
        let _e428 = base;
        local_26 = u32((_e428 + 17u));
        let _e434 = local_26;
        local_65 = u32(_e434);
        let _e437 = local_65;
        out[_e437] = i32(_e427);
        let _e439 = choose_a;
        if _e439 {
            local_29 = u32(-(1i));
        } else {
            local_29 = 2u;
        }
        let _e447 = local_29;
        let _e448 = base;
        local_28 = u32((_e448 + 18u));
        let _e454 = local_28;
        local_66 = u32(_e454);
        let _e457 = local_66;
        out[_e457] = i32(_e447);
        let _e459 = choose_a;
        if _e459 {
            local_31 = true;
        } else {
            local_31 = false;
        }
        let _e465 = local_31;
        let _e466 = base;
        local_30 = u32((_e466 + 19u));
        let _e472 = local_30;
        local_67 = u32(_e472);
        let _e475 = local_67;
        out[_e475] = i32(_e465);
        let _e477 = choose_a;
        if _e477 {
            local_33 = i32(true);
        } else {
            local_33 = 2i;
        }
        let _e484 = local_33;
        let _e485 = base;
        local_32 = u32((_e485 + 20u));
        let _e490 = local_32;
        local_68 = u32(_e490);
        let _e493 = local_68;
        out[_e493] = _e484;
        let _e495 = choose_a;
        if _e495 {
            local_35 = 4u;
        } else {
            local_35 = 8u;
        }
        let _e501 = local_35;
        let _e502 = base;
        local_34 = u32((_e502 + 21u));
        let _e508 = local_34;
        local_69 = u32(_e508);
        let _e511 = local_69;
        out[_e511] = i32(_e501);
        a = 3i;
        shift_value = 2i;
        let _e516 = choose_a;
        if _e516 {
            let _e517 = shift_value;
            local_37 = _e517;
        } else {
            let _e519 = a;
            local_37 = _e519;
        }
        let _e522 = local_37;
        shift_value = 1i;
        let _e524 = shift_value;
        local_38 = u32(_e524);
        let _e527 = local_38;
        let _e529 = base;
        local_36 = u32((_e529 + 22u));
        let _e534 = local_36;
        local_70 = u32(_e534);
        let _e537 = local_70;
        out[_e537] = (_e522 << _e527);
        value = 3i;
        other = 7i;
        let _e543 = choose_a;
        if _e543 {
            let _e544 = value;
            local_40 = _e544;
        } else {
            let _e546 = other;
            local_40 = _e546;
        }
        let _e549 = local_40;
        let _e550 = value;
        value = (_e550 + 1i);
        let _e553 = pair(_e549, _e550);
        let _e554 = base;
        local_39 = u32((_e554 + 23u));
        let _e559 = local_39;
        local_71 = u32(_e559);
        let _e562 = local_71;
        out[_e562] = _e553;
        count = 0i;
        left = 0i;
        right = 0i;
        {
            loop {
                let _e570 = count;
                if (_e570 < 3i) {
                } else {
                    break;
                }
                let _e573 = count;
                count = (_e573 + 1i);
                let _e576 = count;
                if (_e576 == 2i) {
                    continue;
                }
                continuing {
                    let _e579 = choose_a;
                    if _e579 {
                        let _e580 = left;
                        left = (_e580 + 1i);
                    } else {
                        let _e583 = right;
                        right = (_e583 + 1i);
                    }
                }
            }
        }
        let _e586 = left;
        let _e589 = right;
        let _e593 = count;
        let _e595 = base;
        local_41 = u32((_e595 + 24u));
        let _e600 = local_41;
        local_72 = u32(_e600);
        let _e603 = local_72;
        out[_e603] = (((_e586 * 100i) + (_e589 * 10i)) + _e593);
    }
}
