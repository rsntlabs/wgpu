struct int3_ {
    x: i32,
    y: i32,
    z: i32,
}

struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

const Global: i32 = 2i;
const Scale: f32 = 0.5f;

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;

fn pair(first: i32, second: i32) -> i32 {
    return ((first * 10i) + second);
}

fn list_sum(seed: i32) -> i32 {
    var values_1: array<i32, 3>;
    var local_66: u32;

    values_1[0] = seed;
    values_1[1] = (seed + 1i);
    local_66 = 2u;
    loop {
        let _e8 = local_66;
        if (_e8 >= 3u) {
            break;
        }
        values_1[_e8] = i32();
        continuing {
            let _e13 = local_66;
            local_66 = (_e13 + 1u);
        }
    }
    let _e20 = values_1[0i];
    let _e21 = values_1[1i];
    let _e25 = values_1[2i];
    return ((_e20 + _e21) + _e25);
}

fn make_list(seed_1: i32) -> int3_ {
    var value: int3_;

    value.x = seed_1;
    value.y = (seed_1 + 1i);
    value.z = (seed_1 + 2i);
    let _e9 = value;
    return _e9;
}

@compute @workgroup_size(1, 1, 1)
fn list_initialization() {
    var local: u32;
    var zero: i32;
    var copy_zero: i32;
    var enabled: bool;
    var sample: f32;
    var Local: i32;
    var Safe: i32;
    var local_1: i32;
    var safe_values: array<i32, 3>;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var values: array<i32, 3>;
    var local_10: u32;
    var changed: array<i32, 3>;
    var local_11: u32;
    var local_12: u32;
    var point: int3_;
    var local_13: u32;
    var changed_point: int3_;
    var local_14: u32;
    var local_15: u32;
    var nested: array<int3_, 2>;
    var local_16: u32;
    var flat: array<vec2<i32>, 2>;
    var local_17: u32;
    var original: int3_;
    var copied: int3_;
    var copies: array<int3_, 2>;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var counter: i32;
    var ordered: array<i32, 3>;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var zero_total: i32;
    var iteration: i32;
    var reset: array<i32, 3>;
    var local_24: u32;
    var local_25: u32;
    var total: i32;
    var iteration_1: i32;
    var limit: i32;
    var local_26: u32;
    var Number: i32;
    var cached: array<i32, 2>;
    var local_27: u32;
    var frozen: array<i32, 3>;
    var local_28: u32;
    var local_29: u32;
    var floating: float3_;
    var local_30: u32;
    var local_31: u32;
    var from_call: int3_;
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
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;

    local = u32(0i);
    let _e3 = local;
    local_35 = u32(_e3);
    let _e6 = local_35;
    let seed_2 = out[_e6];
    zero = 0i;
    copy_zero = 0i;
    enabled = true;
    let count = u32(7i);
    sample = 1.5f;
    Local = 3i;
    Safe = 3i;
    safe_values[0] = 1i;
    local_2 = 1u;
    loop {
        let _e29 = local_2;
        if (_e29 >= 3u) {
            break;
        }
        safe_values[_e29] = i32();
        continuing {
            let _e34 = local_2;
            local_2 = (_e34 + 1u);
        }
    }
    let _e37 = zero;
    local_3 = u32(0i);
    let _e41 = local_3;
    local_36 = u32(_e41);
    let _e44 = local_36;
    out[_e44] = _e37;
    let _e46 = copy_zero;
    local_4 = u32(1i);
    let _e50 = local_4;
    local_37 = u32(_e50);
    let _e53 = local_37;
    out[_e53] = _e46;
    let _e55 = enabled;
    local_5 = u32(2i);
    let _e60 = local_5;
    local_38 = u32(_e60);
    let _e63 = local_38;
    out[_e63] = i32(_e55);
    local_6 = u32(3i);
    let _e69 = local_6;
    local_39 = u32(_e69);
    let _e72 = local_39;
    out[_e72] = i32(count);
    let _e74 = sample;
    local_7 = u32(4i);
    let _e81 = local_7;
    local_40 = u32(_e81);
    let _e84 = local_40;
    out[_e84] = i32((_e74 * 2f));
    let _e86 = Local;
    local_8 = u32(5i);
    let _e92 = local_8;
    local_41 = u32(_e92);
    let _e95 = local_41;
    out[_e95] = (Global + _e86);
    let _e99 = safe_values[2i];
    local_9 = u32(6i);
    let _e103 = local_9;
    local_42 = u32(_e103);
    let _e106 = local_42;
    out[_e106] = _e99;
    values[0] = 1i;
    let _e114 = values[0i];
    values[1] = (_e114 + 1i);
    let _e120 = values[1i];
    values[2] = (_e120 + 1i);
    let _e127 = values[0i];
    let _e128 = values[1i];
    let _e132 = values[2i];
    local_10 = u32(7i);
    let _e137 = local_10;
    local_43 = u32(_e137);
    let _e140 = local_43;
    out[_e140] = ((_e127 + _e128) + _e132);
    changed[0] = 1i;
    changed[0i] = 7i;
    changed[1] = 2i;
    let _e153 = changed[0i];
    changed[2] = _e153;
    let _e156 = changed[0i];
    local_11 = u32(8i);
    let _e160 = local_11;
    local_44 = u32(_e160);
    let _e163 = local_44;
    out[_e163] = _e156;
    let _e167 = changed[2i];
    local_12 = u32(9i);
    let _e171 = local_12;
    local_45 = u32(_e171);
    let _e174 = local_45;
    out[_e174] = _e167;
    point.x = 1i;
    let _e180 = point.x;
    point.y = (_e180 + 1i);
    let _e185 = point.y;
    point.z = (_e185 + 1i);
    let _e190 = point.z;
    local_13 = u32(10i);
    let _e194 = local_13;
    local_46 = u32(_e194);
    let _e197 = local_46;
    out[_e197] = _e190;
    changed_point.x = 1i;
    changed_point.x = 9i;
    changed_point.y = 2i;
    let _e207 = changed_point.x;
    changed_point.z = _e207;
    let _e210 = changed_point.x;
    local_14 = u32(11i);
    let _e214 = local_14;
    local_47 = u32(_e214);
    let _e217 = local_47;
    out[_e217] = _e210;
    let _e220 = changed_point.z;
    local_15 = u32(12i);
    let _e224 = local_15;
    local_48 = u32(_e224);
    let _e227 = local_48;
    out[_e227] = _e220;
    nested[0].x = 1i;
    nested[0].y = 2i;
    nested[0].z = i32();
    nested[1].x = 3i;
    nested[1].y = i32();
    nested[1].z = i32();
    let _e250 = nested[0i].z;
    let _e251 = nested[1i].x;
    local_16 = u32(13i);
    let _e256 = local_16;
    local_49 = u32(_e256);
    let _e259 = local_49;
    out[_e259] = (_e250 + _e251);
    flat[0].x = 1i;
    flat[0].y = 2i;
    flat[1].x = 3i;
    flat[1].y = i32();
    let _e278 = flat[0i].x;
    let _e279 = flat[0i].y;
    let _e284 = flat[1i].x;
    let _e289 = flat[1i].y;
    local_17 = u32(14i);
    let _e294 = local_17;
    local_50 = u32(_e294);
    let _e297 = local_50;
    out[_e297] = (((_e278 + _e279) + _e284) + _e289);
    original.x = 2i;
    original.y = 3i;
    original.z = 4i;
    let _e306 = original;
    copied = _e306;
    let _e310 = original;
    copies[0] = _e310;
    copies[1].x = 5i;
    copies[1].y = 6i;
    copies[1].z = i32();
    original.x = 99i;
    let _e321 = copied.x;
    local_18 = u32(15i);
    let _e325 = local_18;
    local_51 = u32(_e325);
    let _e328 = local_51;
    out[_e328] = _e321;
    let _e333 = copies[0i].x;
    local_19 = u32(16i);
    let _e337 = local_19;
    local_52 = u32(_e337);
    let _e340 = local_52;
    out[_e340] = _e333;
    let _e345 = copies[1i].z;
    local_20 = u32(17i);
    let _e349 = local_20;
    local_53 = u32(_e349);
    let _e352 = local_53;
    out[_e352] = _e345;
    counter = seed_2;
    let _e357 = counter;
    counter = (_e357 + 1i);
    ordered[0] = _e357;
    let _e361 = counter;
    counter = (_e361 + 1i);
    ordered[1] = _e361;
    let _e365 = counter;
    ordered[2] = _e365;
    let _e368 = ordered[0i];
    let _e373 = ordered[1i];
    let _e379 = ordered[2i];
    local_21 = u32(18i);
    let _e384 = local_21;
    local_54 = u32(_e384);
    let _e387 = local_54;
    out[_e387] = (((_e368 * 100i) + (_e373 * 10i)) + _e379);
    let _e389 = counter;
    local_22 = u32(19i);
    let _e393 = local_22;
    local_55 = u32(_e393);
    let _e396 = local_55;
    out[_e396] = _e389;
    let _e398 = counter;
    counter = (_e398 + 1i);
    let called = pair(_e398, 4i);
    local_23 = u32(20i);
    let _e406 = local_23;
    local_56 = u32(_e406);
    let _e409 = local_56;
    out[_e409] = called;
    zero_total = 0i;
    {
        iteration = 0i;
        loop {
            let _e415 = iteration;
            if (_e415 < 3i) {
            } else {
                break;
            }
            let _e420 = iteration;
            reset[0] = _e420;
            local_24 = 1u;
            loop {
                let _e423 = local_24;
                if (_e423 >= 3u) {
                    break;
                }
                reset[_e423] = i32();
                continuing {
                    let _e428 = local_24;
                    local_24 = (_e428 + 1u);
                }
            }
            let _e433 = reset[2i];
            let _e434 = zero_total;
            zero_total = (_e434 + _e433);
            reset[2i] = 9i;
            continuing {
                let _e439 = iteration;
                iteration = (_e439 + 1i);
            }
        }
    }
    let _e442 = zero_total;
    local_25 = u32(21i);
    let _e446 = local_25;
    local_57 = u32(_e446);
    let _e449 = local_57;
    out[_e449] = _e442;
    total = 0i;
    {
        iteration_1 = 0i;
        limit = 3i;
        loop {
            let _e457 = iteration_1;
            let _e458 = limit;
            if (_e457 < _e458) {
            } else {
                break;
            }
            let _e460 = iteration_1;
            let _e461 = total;
            total = (_e461 + _e460);
            continuing {
                let _e463 = iteration_1;
                iteration_1 = (_e463 + 1i);
            }
        }
    }
    let _e466 = total;
    local_26 = u32(22i);
    let _e470 = local_26;
    local_58 = u32(_e470);
    let _e473 = local_58;
    out[_e473] = _e466;
    Number = 4i;
    let _e479 = Number;
    cached[0] = _e479;
    let _e481 = Number;
    cached[1] = (_e481 + 1i);
    let _e486 = cached[1i];
    local_27 = u32(23i);
    let _e490 = local_27;
    local_59 = u32(_e490);
    let _e493 = local_59;
    out[_e493] = _e486;
    frozen[0] = 3i;
    local_28 = 1u;
    loop {
        let _e500 = local_28;
        if (_e500 >= 3u) {
            break;
        }
        frozen[_e500] = i32();
        continuing {
            let _e505 = local_28;
            local_28 = (_e505 + 1u);
        }
    }
    let _e512 = frozen[0i];
    let _e513 = frozen[1i];
    let _e517 = frozen[2i];
    local_29 = u32(24i);
    let _e522 = local_29;
    local_60 = u32(_e522);
    let _e525 = local_60;
    out[_e525] = ((_e512 + _e513) + _e517);
    floating.x = 1.5f;
    floating.y = -(0f);
    floating.z = f32();
    let _e536 = floating.y;
    local_30 = u32(25i);
    let _e541 = local_30;
    local_61 = u32(_e541);
    let _e544 = local_61;
    out[_e544] = bitcast<i32>(_e536);
    let _e547 = floating.z;
    local_31 = u32(26i);
    let _e552 = local_31;
    local_62 = u32(_e552);
    let _e555 = local_62;
    out[_e555] = bitcast<i32>(_e547);
    let _e558 = make_list(6i);
    from_call = _e558;
    let _e562 = from_call.x;
    let _e563 = from_call.z;
    local_32 = u32(27i);
    let _e568 = local_32;
    local_63 = u32(_e568);
    let _e571 = local_63;
    out[_e571] = (_e562 + _e563);
    local_33 = u32(28i);
    let _e580 = local_33;
    local_64 = u32(_e580);
    let _e583 = local_64;
    out[_e583] = i32((Scale * 10f));
    let _e587 = list_sum((seed_2 + 3i));
    local_34 = u32(29i);
    let _e591 = local_34;
    local_65 = u32(_e591);
    let _e594 = local_65;
    out[_e594] = _e587;
}
