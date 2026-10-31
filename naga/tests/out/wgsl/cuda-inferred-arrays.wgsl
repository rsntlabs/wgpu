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

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;

fn pair(first: i32, second: i32) -> i32 {
    return ((first * 10i) + second);
}

fn sum(seed: i32) -> i32 {
    var values_1: array<i32, 2>;

    values_1[0] = seed;
    values_1[1] = (seed + 1i);
    let _e10 = values_1[0i];
    let _e11 = values_1[1i];
    return (_e10 + _e11);
}

fn triple(seed_1: i32) -> int3_ {
    var value: int3_;

    value.x = seed_1;
    value.y = (seed_1 + 1i);
    value.z = (seed_1 + 2i);
    let _e9 = value;
    return _e9;
}

@compute @workgroup_size(1, 1, 1)
fn inferred_arrays() {
    var local: u32;
    var values: array<i32, 3>;
    var copied: array<i32, 2>;
    var zeroes: array<i32, 2>;
    var flags: array<bool, 3>;
    var counts: array<u32, 2>;
    var samples: array<f32, 2>;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var self_: array<i32, 3>;
    var local_7: u32;
    var changed: array<i32, 3>;
    var local_8: u32;
    var local_9: u32;
    var points: array<int3_, 2>;
    var local_10: u32;
    var flat: array<vec2<i32>, 2>;
    var local_11: u32;
    var local_12: u32;
    var original: int3_;
    var copies: array<int3_, 3>;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var Number: array<i32, 2>;
    var next: array<i32, 2>;
    var local_16: u32;
    var Count: i32;
    var scratch: array<i32, 3>;
    var local_17: u32;
    var pending: array<f32, 2>;
    var local_18: u32;
    var pending_vectors: array<float3_, 2>;
    var local_19: u32;
    var counter: i32;
    var ordered: array<i32, 3>;
    var local_20: u32;
    var local_21: u32;
    var called: array<i32, 2>;
    var local_22: u32;
    var local_23: u32;
    var zero_total: i32;
    var iteration: i32;
    var reset: array<vec2<i32>, 2>;
    var local_24: u32;
    var total: i32;
    var iteration_1: i32;
    var local_25: u32;
    var local_26: u32;
    var frozen: array<i32, 2>;
    var local_27: u32;
    var signed_zeroes: array<f32, 2>;
    var local_28: u32;
    var local_29: u32;
    var from_calls: array<int3_, 2>;
    var local_30: u32;
    var local_31: i32;
    var local_32: u32;
    var local_33: i32;
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

    local = u32(0i);
    let _e3 = local;
    local_32 = u32(_e3);
    let _e6 = local_32;
    let _e9 = out[_e6];
    local_33 = _e9;
    let _e11 = local_33;
    local_31 = _e11;
    let seed_2 = local_31;
    values[0] = seed_2;
    values[1] = (seed_2 + 1i);
    values[2] = (seed_2 + 2i);
    copied[0] = 4i;
    copied[1] = 5i;
    zeroes[0] = 0i;
    zeroes[1] = 0i;
    flags[0] = true;
    flags[1] = false;
    flags[2] = true;
    counts[0] = 3u;
    counts[1] = 5u;
    samples[0] = 1.5f;
    samples[1] = 2.5f;
    let _e53 = values[0i];
    let _e54 = values[1i];
    let _e58 = values[2i];
    local_1 = u32(0i);
    let _e63 = local_1;
    local_34 = u32(_e63);
    let _e66 = local_34;
    out[_e66] = ((_e53 + _e54) + _e58);
    let _e70 = copied[0i];
    local_2 = u32(1i);
    let _e74 = local_2;
    local_35 = u32(_e74);
    let _e77 = local_35;
    out[_e77] = _e70;
    let _e83 = zeroes[0i];
    let _e84 = zeroes[1i];
    local_3 = u32(2i);
    let _e89 = local_3;
    local_36 = u32(_e89);
    let _e92 = local_36;
    out[_e92] = (_e83 + _e84);
    let _e96 = flags[0i];
    let _e100 = flags[1i];
    let _e105 = flags[2i];
    local_4 = u32(3i);
    let _e111 = local_4;
    local_37 = u32(_e111);
    let _e114 = local_37;
    out[_e114] = ((i32(_e96) + i32(_e100)) + i32(_e105));
    let _e120 = counts[0i];
    let _e121 = counts[1i];
    local_5 = u32(4i);
    let _e127 = local_5;
    local_38 = u32(_e127);
    let _e130 = local_38;
    out[_e130] = i32((_e120 + _e121));
    let _e136 = samples[0i];
    let _e137 = samples[1i];
    local_6 = u32(5i);
    let _e143 = local_6;
    local_39 = u32(_e143);
    let _e146 = local_39;
    out[_e146] = i32((_e136 + _e137));
    self_[0] = 1i;
    let _e154 = self_[0i];
    self_[1] = (_e154 + 1i);
    let _e160 = self_[1i];
    self_[2] = (_e160 + 1i);
    let _e165 = self_[0i];
    let _e170 = self_[1i];
    let _e176 = self_[2i];
    local_7 = u32(6i);
    let _e181 = local_7;
    local_40 = u32(_e181);
    let _e184 = local_40;
    out[_e184] = (((_e165 * 100i) + (_e170 * 10i)) + _e176);
    changed[0] = 1i;
    changed[0i] = 7i;
    changed[1] = 2i;
    let _e197 = changed[0i];
    changed[2] = _e197;
    let _e200 = changed[0i];
    local_8 = u32(7i);
    let _e204 = local_8;
    local_41 = u32(_e204);
    let _e207 = local_41;
    out[_e207] = _e200;
    let _e211 = changed[2i];
    local_9 = u32(8i);
    let _e215 = local_9;
    local_42 = u32(_e215);
    let _e218 = local_42;
    out[_e218] = _e211;
    points[0].x = 1i;
    let _e227 = points[0i].x;
    points[0].y = (_e227 + 1i);
    let _e234 = points[0i].y;
    points[0].z = (_e234 + 1i);
    let _e241 = points[0i];
    points[1] = _e241;
    let _e245 = points[1i].z;
    local_10 = u32(9i);
    let _e249 = local_10;
    local_43 = u32(_e249);
    let _e252 = local_43;
    out[_e252] = _e245;
    flat[0].x = 1i;
    flat[0].y = 2i;
    flat[1].x = 3i;
    flat[1].y = i32();
    let _e268 = flat[1i].y;
    local_11 = u32(10i);
    let _e272 = local_11;
    local_44 = u32(_e272);
    let _e275 = local_44;
    out[_e275] = _e268;
    let _e280 = flat[1i].x;
    local_12 = u32(11i);
    let _e284 = local_12;
    local_45 = u32(_e284);
    let _e287 = local_45;
    out[_e287] = _e280;
    original.x = 4i;
    original.y = 5i;
    original.z = 6i;
    let _e298 = original;
    copies[0] = _e298;
    let _e300 = original;
    copies[1] = _e300;
    copies[2].x = 7i;
    copies[2].y = 8i;
    copies[2].z = i32();
    original.x = 99i;
    let _e313 = copies[0i].x;
    local_13 = u32(12i);
    let _e317 = local_13;
    local_46 = u32(_e317);
    let _e320 = local_46;
    out[_e320] = _e313;
    let _e325 = copies[1i].y;
    local_14 = u32(13i);
    let _e329 = local_14;
    local_47 = u32(_e329);
    let _e332 = local_47;
    out[_e332] = _e325;
    let _e337 = copies[2i].z;
    local_15 = u32(14i);
    let _e341 = local_15;
    local_48 = u32(_e341);
    let _e344 = local_48;
    out[_e344] = _e337;
    Number[0] = 2i;
    Number[1] = 3i;
    let _e355 = Number[1i];
    next[0] = _e355;
    let _e359 = Number[0i];
    next[1] = _e359;
    let _e362 = next[0i];
    local_16 = u32(15i);
    let _e366 = local_16;
    local_49 = u32(_e366);
    let _e369 = local_49;
    out[_e369] = _e362;
    Count = 3i;
    scratch = array<i32, 3>();
    let _e377 = scratch[2i];
    local_17 = u32(16i);
    let _e381 = local_17;
    local_50 = u32(_e381);
    let _e384 = local_50;
    out[_e384] = _e377;
    pending[0] = 1f;
    pending[1] = f32(2i);
    let _e396 = pending[0i];
    let _e397 = pending[1i];
    local_18 = u32(17i);
    let _e403 = local_18;
    local_51 = u32(_e403);
    let _e406 = local_51;
    out[_e406] = i32((_e396 + _e397));
    pending_vectors[0].x = 1f;
    pending_vectors[0].y = f32(2i);
    pending_vectors[0].z = f32();
    pending_vectors[1].x = 3f;
    pending_vectors[1].y = f32();
    pending_vectors[1].z = f32();
    let _e430 = pending_vectors[0i].x;
    let _e431 = pending_vectors[0i].y;
    let _e436 = pending_vectors[1i].x;
    local_19 = u32(18i);
    let _e442 = local_19;
    local_52 = u32(_e442);
    let _e445 = local_52;
    out[_e445] = i32(((_e430 + _e431) + _e436));
    counter = seed_2;
    let _e450 = counter;
    counter = (_e450 + 1i);
    ordered[0] = _e450;
    let _e454 = counter;
    counter = (_e454 + 1i);
    ordered[1] = _e454;
    let _e458 = counter;
    ordered[2] = _e458;
    let _e461 = ordered[0i];
    let _e466 = ordered[1i];
    let _e472 = ordered[2i];
    local_20 = u32(19i);
    let _e477 = local_20;
    local_53 = u32(_e477);
    let _e480 = local_53;
    out[_e480] = (((_e461 * 100i) + (_e466 * 10i)) + _e472);
    let _e482 = counter;
    local_21 = u32(20i);
    let _e486 = local_21;
    local_54 = u32(_e486);
    let _e489 = local_54;
    out[_e489] = _e482;
    let _e493 = counter;
    counter = (_e493 + 1i);
    let _e497 = pair(_e493, 4i);
    called[0] = _e497;
    let _e499 = counter;
    called[1] = _e499;
    let _e504 = called[0i];
    let _e505 = called[1i];
    local_22 = u32(21i);
    let _e510 = local_22;
    local_55 = u32(_e510);
    let _e513 = local_55;
    out[_e513] = (_e504 + _e505);
    let _e515 = counter;
    local_23 = u32(22i);
    let _e519 = local_23;
    local_56 = u32(_e519);
    let _e522 = local_56;
    out[_e522] = _e515;
    zero_total = 0i;
    {
        iteration = 0i;
        loop {
            let _e528 = iteration;
            if (_e528 < 3i) {
            } else {
                break;
            }
            let _e533 = iteration;
            reset[0].x = _e533;
            reset[0].y = i32();
            reset[1] = vec2<i32>();
            let _e545 = reset[0i].y;
            let _e546 = reset[1i].x;
            let _e548 = zero_total;
            zero_total = (_e548 + (_e545 + _e546));
            reset[0i].y = 9i;
            reset[1i].x = 8i;
            continuing {
                let _e558 = iteration;
                iteration = (_e558 + 1i);
            }
        }
    }
    let _e561 = zero_total;
    local_24 = u32(23i);
    let _e565 = local_24;
    local_57 = u32(_e565);
    let _e568 = local_57;
    out[_e568] = _e561;
    total = 0i;
    {
        iteration_1 = 0i;
        loop {
            let _e574 = iteration_1;
            if (_e574 < 4i) {
            } else {
                break;
            }
            let _e577 = iteration_1;
            if (_e577 == 1i) {
                continue;
            }
            let _e580 = iteration_1;
            let _e581 = total;
            total = (_e581 + _e580);
            continuing {
                let _e583 = iteration_1;
                iteration_1 = (_e583 + 1i);
            }
        }
    }
    let _e586 = total;
    local_25 = u32(24i);
    let _e590 = local_25;
    local_58 = u32(_e590);
    let _e593 = local_58;
    out[_e593] = _e586;
    let _e596 = sum(4i);
    local_26 = u32(25i);
    let _e600 = local_26;
    local_59 = u32(_e600);
    let _e603 = local_59;
    out[_e603] = _e596;
    frozen[0] = 2i;
    frozen[1] = 3i;
    let _e614 = frozen[0i];
    let _e615 = frozen[1i];
    local_27 = u32(26i);
    let _e620 = local_27;
    local_60 = u32(_e620);
    let _e623 = local_60;
    out[_e623] = (_e614 + _e615);
    signed_zeroes[0] = -(0f);
    signed_zeroes[1] = 0f;
    let _e633 = signed_zeroes[0i];
    local_28 = u32(27i);
    let _e638 = local_28;
    local_61 = u32(_e638);
    let _e641 = local_61;
    out[_e641] = bitcast<i32>(_e633);
    let _e645 = signed_zeroes[1i];
    local_29 = u32(28i);
    let _e650 = local_29;
    local_62 = u32(_e650);
    let _e653 = local_62;
    out[_e653] = bitcast<i32>(_e645);
    let _e658 = triple(6i);
    from_calls[0] = _e658;
    let _e661 = triple(9i);
    from_calls[1] = _e661;
    let _e668 = from_calls[0i].x;
    let _e669 = from_calls[1i].z;
    local_30 = u32(29i);
    let _e674 = local_30;
    local_63 = u32(_e674);
    let _e677 = local_63;
    out[_e677] = (_e668 + _e669);
}
