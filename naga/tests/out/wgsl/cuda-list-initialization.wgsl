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
    var local_68: u32;

    values_1[0] = seed;
    values_1[1] = (seed + 1i);
    local_68 = 2u;
    loop {
        let _e8 = local_68;
        if (_e8 >= 3u) {
            break;
        }
        values_1[_e8] = i32();
        continuing {
            let _e13 = local_68;
            local_68 = (_e13 + 1u);
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
    var local_35: i32;
    var local_36: u32;
    var local_37: i32;
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
    var local_66: u32;
    var local_67: u32;

    local = u32(0i);
    let _e3 = local;
    local_36 = u32(_e3);
    let _e6 = local_36;
    let _e9 = out[_e6];
    local_37 = _e9;
    let _e11 = local_37;
    local_35 = _e11;
    let seed_2 = local_35;
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
        let _e33 = local_2;
        if (_e33 >= 3u) {
            break;
        }
        safe_values[_e33] = i32();
        continuing {
            let _e38 = local_2;
            local_2 = (_e38 + 1u);
        }
    }
    let _e41 = zero;
    local_3 = u32(0i);
    let _e45 = local_3;
    local_38 = u32(_e45);
    let _e48 = local_38;
    out[_e48] = _e41;
    let _e50 = copy_zero;
    local_4 = u32(1i);
    let _e54 = local_4;
    local_39 = u32(_e54);
    let _e57 = local_39;
    out[_e57] = _e50;
    let _e59 = enabled;
    local_5 = u32(2i);
    let _e64 = local_5;
    local_40 = u32(_e64);
    let _e67 = local_40;
    out[_e67] = i32(_e59);
    local_6 = u32(3i);
    let _e73 = local_6;
    local_41 = u32(_e73);
    let _e76 = local_41;
    out[_e76] = i32(count);
    let _e78 = sample;
    local_7 = u32(4i);
    let _e85 = local_7;
    local_42 = u32(_e85);
    let _e88 = local_42;
    out[_e88] = i32((_e78 * 2f));
    let _e90 = Local;
    local_8 = u32(5i);
    let _e96 = local_8;
    local_43 = u32(_e96);
    let _e99 = local_43;
    out[_e99] = (Global + _e90);
    let _e103 = safe_values[2i];
    local_9 = u32(6i);
    let _e107 = local_9;
    local_44 = u32(_e107);
    let _e110 = local_44;
    out[_e110] = _e103;
    values[0] = 1i;
    let _e118 = values[0i];
    values[1] = (_e118 + 1i);
    let _e124 = values[1i];
    values[2] = (_e124 + 1i);
    let _e131 = values[0i];
    let _e132 = values[1i];
    let _e136 = values[2i];
    local_10 = u32(7i);
    let _e141 = local_10;
    local_45 = u32(_e141);
    let _e144 = local_45;
    out[_e144] = ((_e131 + _e132) + _e136);
    changed[0] = 1i;
    changed[0i] = 7i;
    changed[1] = 2i;
    let _e157 = changed[0i];
    changed[2] = _e157;
    let _e160 = changed[0i];
    local_11 = u32(8i);
    let _e164 = local_11;
    local_46 = u32(_e164);
    let _e167 = local_46;
    out[_e167] = _e160;
    let _e171 = changed[2i];
    local_12 = u32(9i);
    let _e175 = local_12;
    local_47 = u32(_e175);
    let _e178 = local_47;
    out[_e178] = _e171;
    point.x = 1i;
    let _e184 = point.x;
    point.y = (_e184 + 1i);
    let _e189 = point.y;
    point.z = (_e189 + 1i);
    let _e194 = point.z;
    local_13 = u32(10i);
    let _e198 = local_13;
    local_48 = u32(_e198);
    let _e201 = local_48;
    out[_e201] = _e194;
    changed_point.x = 1i;
    changed_point.x = 9i;
    changed_point.y = 2i;
    let _e211 = changed_point.x;
    changed_point.z = _e211;
    let _e214 = changed_point.x;
    local_14 = u32(11i);
    let _e218 = local_14;
    local_49 = u32(_e218);
    let _e221 = local_49;
    out[_e221] = _e214;
    let _e224 = changed_point.z;
    local_15 = u32(12i);
    let _e228 = local_15;
    local_50 = u32(_e228);
    let _e231 = local_50;
    out[_e231] = _e224;
    nested[0].x = 1i;
    nested[0].y = 2i;
    nested[0].z = i32();
    nested[1].x = 3i;
    nested[1].y = i32();
    nested[1].z = i32();
    let _e254 = nested[0i].z;
    let _e255 = nested[1i].x;
    local_16 = u32(13i);
    let _e260 = local_16;
    local_51 = u32(_e260);
    let _e263 = local_51;
    out[_e263] = (_e254 + _e255);
    flat[0].x = 1i;
    flat[0].y = 2i;
    flat[1].x = 3i;
    flat[1].y = i32();
    let _e282 = flat[0i].x;
    let _e283 = flat[0i].y;
    let _e288 = flat[1i].x;
    let _e293 = flat[1i].y;
    local_17 = u32(14i);
    let _e298 = local_17;
    local_52 = u32(_e298);
    let _e301 = local_52;
    out[_e301] = (((_e282 + _e283) + _e288) + _e293);
    original.x = 2i;
    original.y = 3i;
    original.z = 4i;
    let _e310 = original;
    copied = _e310;
    let _e314 = original;
    copies[0] = _e314;
    copies[1].x = 5i;
    copies[1].y = 6i;
    copies[1].z = i32();
    original.x = 99i;
    let _e325 = copied.x;
    local_18 = u32(15i);
    let _e329 = local_18;
    local_53 = u32(_e329);
    let _e332 = local_53;
    out[_e332] = _e325;
    let _e337 = copies[0i].x;
    local_19 = u32(16i);
    let _e341 = local_19;
    local_54 = u32(_e341);
    let _e344 = local_54;
    out[_e344] = _e337;
    let _e349 = copies[1i].z;
    local_20 = u32(17i);
    let _e353 = local_20;
    local_55 = u32(_e353);
    let _e356 = local_55;
    out[_e356] = _e349;
    counter = seed_2;
    let _e361 = counter;
    counter = (_e361 + 1i);
    ordered[0] = _e361;
    let _e365 = counter;
    counter = (_e365 + 1i);
    ordered[1] = _e365;
    let _e369 = counter;
    ordered[2] = _e369;
    let _e372 = ordered[0i];
    let _e377 = ordered[1i];
    let _e383 = ordered[2i];
    local_21 = u32(18i);
    let _e388 = local_21;
    local_56 = u32(_e388);
    let _e391 = local_56;
    out[_e391] = (((_e372 * 100i) + (_e377 * 10i)) + _e383);
    let _e393 = counter;
    local_22 = u32(19i);
    let _e397 = local_22;
    local_57 = u32(_e397);
    let _e400 = local_57;
    out[_e400] = _e393;
    let _e402 = counter;
    counter = (_e402 + 1i);
    let called = pair(_e402, 4i);
    local_23 = u32(20i);
    let _e410 = local_23;
    local_58 = u32(_e410);
    let _e413 = local_58;
    out[_e413] = called;
    zero_total = 0i;
    {
        iteration = 0i;
        loop {
            let _e419 = iteration;
            if (_e419 < 3i) {
            } else {
                break;
            }
            let _e424 = iteration;
            reset[0] = _e424;
            local_24 = 1u;
            loop {
                let _e427 = local_24;
                if (_e427 >= 3u) {
                    break;
                }
                reset[_e427] = i32();
                continuing {
                    let _e432 = local_24;
                    local_24 = (_e432 + 1u);
                }
            }
            let _e437 = reset[2i];
            let _e438 = zero_total;
            zero_total = (_e438 + _e437);
            reset[2i] = 9i;
            continuing {
                let _e443 = iteration;
                iteration = (_e443 + 1i);
            }
        }
    }
    let _e446 = zero_total;
    local_25 = u32(21i);
    let _e450 = local_25;
    local_59 = u32(_e450);
    let _e453 = local_59;
    out[_e453] = _e446;
    total = 0i;
    {
        iteration_1 = 0i;
        limit = 3i;
        loop {
            let _e461 = iteration_1;
            let _e462 = limit;
            if (_e461 < _e462) {
            } else {
                break;
            }
            let _e464 = iteration_1;
            let _e465 = total;
            total = (_e465 + _e464);
            continuing {
                let _e467 = iteration_1;
                iteration_1 = (_e467 + 1i);
            }
        }
    }
    let _e470 = total;
    local_26 = u32(22i);
    let _e474 = local_26;
    local_60 = u32(_e474);
    let _e477 = local_60;
    out[_e477] = _e470;
    Number = 4i;
    let _e483 = Number;
    cached[0] = _e483;
    let _e485 = Number;
    cached[1] = (_e485 + 1i);
    let _e490 = cached[1i];
    local_27 = u32(23i);
    let _e494 = local_27;
    local_61 = u32(_e494);
    let _e497 = local_61;
    out[_e497] = _e490;
    frozen[0] = 3i;
    local_28 = 1u;
    loop {
        let _e504 = local_28;
        if (_e504 >= 3u) {
            break;
        }
        frozen[_e504] = i32();
        continuing {
            let _e509 = local_28;
            local_28 = (_e509 + 1u);
        }
    }
    let _e516 = frozen[0i];
    let _e517 = frozen[1i];
    let _e521 = frozen[2i];
    local_29 = u32(24i);
    let _e526 = local_29;
    local_62 = u32(_e526);
    let _e529 = local_62;
    out[_e529] = ((_e516 + _e517) + _e521);
    floating.x = 1.5f;
    floating.y = -(0f);
    floating.z = f32();
    let _e540 = floating.y;
    local_30 = u32(25i);
    let _e545 = local_30;
    local_63 = u32(_e545);
    let _e548 = local_63;
    out[_e548] = bitcast<i32>(_e540);
    let _e551 = floating.z;
    local_31 = u32(26i);
    let _e556 = local_31;
    local_64 = u32(_e556);
    let _e559 = local_64;
    out[_e559] = bitcast<i32>(_e551);
    let _e562 = make_list(6i);
    from_call = _e562;
    let _e566 = from_call.x;
    let _e567 = from_call.z;
    local_32 = u32(27i);
    let _e572 = local_32;
    local_65 = u32(_e572);
    let _e575 = local_65;
    out[_e575] = (_e566 + _e567);
    local_33 = u32(28i);
    let _e584 = local_33;
    local_66 = u32(_e584);
    let _e587 = local_66;
    out[_e587] = i32((Scale * 10f));
    let _e591 = list_sum((seed_2 + 3i));
    local_34 = u32(29i);
    let _e595 = local_34;
    local_67 = u32(_e595);
    let _e598 = local_67;
    out[_e598] = _e591;
}
