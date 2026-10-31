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
    var local_31: u32;
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

    local = u32(0i);
    let _e3 = local;
    local_31 = u32(_e3);
    let _e6 = local_31;
    let seed_2 = out[_e6];
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
    let _e49 = values[0i];
    let _e50 = values[1i];
    let _e54 = values[2i];
    local_1 = u32(0i);
    let _e59 = local_1;
    local_32 = u32(_e59);
    let _e62 = local_32;
    out[_e62] = ((_e49 + _e50) + _e54);
    let _e66 = copied[0i];
    local_2 = u32(1i);
    let _e70 = local_2;
    local_33 = u32(_e70);
    let _e73 = local_33;
    out[_e73] = _e66;
    let _e79 = zeroes[0i];
    let _e80 = zeroes[1i];
    local_3 = u32(2i);
    let _e85 = local_3;
    local_34 = u32(_e85);
    let _e88 = local_34;
    out[_e88] = (_e79 + _e80);
    let _e92 = flags[0i];
    let _e96 = flags[1i];
    let _e101 = flags[2i];
    local_4 = u32(3i);
    let _e107 = local_4;
    local_35 = u32(_e107);
    let _e110 = local_35;
    out[_e110] = ((i32(_e92) + i32(_e96)) + i32(_e101));
    let _e116 = counts[0i];
    let _e117 = counts[1i];
    local_5 = u32(4i);
    let _e123 = local_5;
    local_36 = u32(_e123);
    let _e126 = local_36;
    out[_e126] = i32((_e116 + _e117));
    let _e132 = samples[0i];
    let _e133 = samples[1i];
    local_6 = u32(5i);
    let _e139 = local_6;
    local_37 = u32(_e139);
    let _e142 = local_37;
    out[_e142] = i32((_e132 + _e133));
    self_[0] = 1i;
    let _e150 = self_[0i];
    self_[1] = (_e150 + 1i);
    let _e156 = self_[1i];
    self_[2] = (_e156 + 1i);
    let _e161 = self_[0i];
    let _e166 = self_[1i];
    let _e172 = self_[2i];
    local_7 = u32(6i);
    let _e177 = local_7;
    local_38 = u32(_e177);
    let _e180 = local_38;
    out[_e180] = (((_e161 * 100i) + (_e166 * 10i)) + _e172);
    changed[0] = 1i;
    changed[0i] = 7i;
    changed[1] = 2i;
    let _e193 = changed[0i];
    changed[2] = _e193;
    let _e196 = changed[0i];
    local_8 = u32(7i);
    let _e200 = local_8;
    local_39 = u32(_e200);
    let _e203 = local_39;
    out[_e203] = _e196;
    let _e207 = changed[2i];
    local_9 = u32(8i);
    let _e211 = local_9;
    local_40 = u32(_e211);
    let _e214 = local_40;
    out[_e214] = _e207;
    points[0].x = 1i;
    let _e223 = points[0i].x;
    points[0].y = (_e223 + 1i);
    let _e230 = points[0i].y;
    points[0].z = (_e230 + 1i);
    let _e237 = points[0i];
    points[1] = _e237;
    let _e241 = points[1i].z;
    local_10 = u32(9i);
    let _e245 = local_10;
    local_41 = u32(_e245);
    let _e248 = local_41;
    out[_e248] = _e241;
    flat[0].x = 1i;
    flat[0].y = 2i;
    flat[1].x = 3i;
    flat[1].y = i32();
    let _e264 = flat[1i].y;
    local_11 = u32(10i);
    let _e268 = local_11;
    local_42 = u32(_e268);
    let _e271 = local_42;
    out[_e271] = _e264;
    let _e276 = flat[1i].x;
    local_12 = u32(11i);
    let _e280 = local_12;
    local_43 = u32(_e280);
    let _e283 = local_43;
    out[_e283] = _e276;
    original.x = 4i;
    original.y = 5i;
    original.z = 6i;
    let _e294 = original;
    copies[0] = _e294;
    let _e296 = original;
    copies[1] = _e296;
    copies[2].x = 7i;
    copies[2].y = 8i;
    copies[2].z = i32();
    original.x = 99i;
    let _e309 = copies[0i].x;
    local_13 = u32(12i);
    let _e313 = local_13;
    local_44 = u32(_e313);
    let _e316 = local_44;
    out[_e316] = _e309;
    let _e321 = copies[1i].y;
    local_14 = u32(13i);
    let _e325 = local_14;
    local_45 = u32(_e325);
    let _e328 = local_45;
    out[_e328] = _e321;
    let _e333 = copies[2i].z;
    local_15 = u32(14i);
    let _e337 = local_15;
    local_46 = u32(_e337);
    let _e340 = local_46;
    out[_e340] = _e333;
    Number[0] = 2i;
    Number[1] = 3i;
    let _e351 = Number[1i];
    next[0] = _e351;
    let _e355 = Number[0i];
    next[1] = _e355;
    let _e358 = next[0i];
    local_16 = u32(15i);
    let _e362 = local_16;
    local_47 = u32(_e362);
    let _e365 = local_47;
    out[_e365] = _e358;
    Count = 3i;
    scratch = array<i32, 3>();
    let _e373 = scratch[2i];
    local_17 = u32(16i);
    let _e377 = local_17;
    local_48 = u32(_e377);
    let _e380 = local_48;
    out[_e380] = _e373;
    pending[0] = 1f;
    pending[1] = f32(2i);
    let _e392 = pending[0i];
    let _e393 = pending[1i];
    local_18 = u32(17i);
    let _e399 = local_18;
    local_49 = u32(_e399);
    let _e402 = local_49;
    out[_e402] = i32((_e392 + _e393));
    pending_vectors[0].x = 1f;
    pending_vectors[0].y = f32(2i);
    pending_vectors[0].z = f32();
    pending_vectors[1].x = 3f;
    pending_vectors[1].y = f32();
    pending_vectors[1].z = f32();
    let _e426 = pending_vectors[0i].x;
    let _e427 = pending_vectors[0i].y;
    let _e432 = pending_vectors[1i].x;
    local_19 = u32(18i);
    let _e438 = local_19;
    local_50 = u32(_e438);
    let _e441 = local_50;
    out[_e441] = i32(((_e426 + _e427) + _e432));
    counter = seed_2;
    let _e446 = counter;
    counter = (_e446 + 1i);
    ordered[0] = _e446;
    let _e450 = counter;
    counter = (_e450 + 1i);
    ordered[1] = _e450;
    let _e454 = counter;
    ordered[2] = _e454;
    let _e457 = ordered[0i];
    let _e462 = ordered[1i];
    let _e468 = ordered[2i];
    local_20 = u32(19i);
    let _e473 = local_20;
    local_51 = u32(_e473);
    let _e476 = local_51;
    out[_e476] = (((_e457 * 100i) + (_e462 * 10i)) + _e468);
    let _e478 = counter;
    local_21 = u32(20i);
    let _e482 = local_21;
    local_52 = u32(_e482);
    let _e485 = local_52;
    out[_e485] = _e478;
    let _e489 = counter;
    counter = (_e489 + 1i);
    let _e493 = pair(_e489, 4i);
    called[0] = _e493;
    let _e495 = counter;
    called[1] = _e495;
    let _e500 = called[0i];
    let _e501 = called[1i];
    local_22 = u32(21i);
    let _e506 = local_22;
    local_53 = u32(_e506);
    let _e509 = local_53;
    out[_e509] = (_e500 + _e501);
    let _e511 = counter;
    local_23 = u32(22i);
    let _e515 = local_23;
    local_54 = u32(_e515);
    let _e518 = local_54;
    out[_e518] = _e511;
    zero_total = 0i;
    {
        iteration = 0i;
        loop {
            let _e524 = iteration;
            if (_e524 < 3i) {
            } else {
                break;
            }
            let _e529 = iteration;
            reset[0].x = _e529;
            reset[0].y = i32();
            reset[1] = vec2<i32>();
            let _e541 = reset[0i].y;
            let _e542 = reset[1i].x;
            let _e544 = zero_total;
            zero_total = (_e544 + (_e541 + _e542));
            reset[0i].y = 9i;
            reset[1i].x = 8i;
            continuing {
                let _e554 = iteration;
                iteration = (_e554 + 1i);
            }
        }
    }
    let _e557 = zero_total;
    local_24 = u32(23i);
    let _e561 = local_24;
    local_55 = u32(_e561);
    let _e564 = local_55;
    out[_e564] = _e557;
    total = 0i;
    {
        iteration_1 = 0i;
        loop {
            let _e570 = iteration_1;
            if (_e570 < 4i) {
            } else {
                break;
            }
            let _e573 = iteration_1;
            if (_e573 == 1i) {
                continue;
            }
            let _e576 = iteration_1;
            let _e577 = total;
            total = (_e577 + _e576);
            continuing {
                let _e579 = iteration_1;
                iteration_1 = (_e579 + 1i);
            }
        }
    }
    let _e582 = total;
    local_25 = u32(24i);
    let _e586 = local_25;
    local_56 = u32(_e586);
    let _e589 = local_56;
    out[_e589] = _e582;
    let _e592 = sum(4i);
    local_26 = u32(25i);
    let _e596 = local_26;
    local_57 = u32(_e596);
    let _e599 = local_57;
    out[_e599] = _e592;
    frozen[0] = 2i;
    frozen[1] = 3i;
    let _e610 = frozen[0i];
    let _e611 = frozen[1i];
    local_27 = u32(26i);
    let _e616 = local_27;
    local_58 = u32(_e616);
    let _e619 = local_58;
    out[_e619] = (_e610 + _e611);
    signed_zeroes[0] = -(0f);
    signed_zeroes[1] = 0f;
    let _e629 = signed_zeroes[0i];
    local_28 = u32(27i);
    let _e634 = local_28;
    local_59 = u32(_e634);
    let _e637 = local_59;
    out[_e637] = bitcast<i32>(_e629);
    let _e641 = signed_zeroes[1i];
    local_29 = u32(28i);
    let _e646 = local_29;
    local_60 = u32(_e646);
    let _e649 = local_60;
    out[_e649] = bitcast<i32>(_e641);
    let _e654 = triple(6i);
    from_calls[0] = _e654;
    let _e657 = triple(9i);
    from_calls[1] = _e657;
    let _e664 = from_calls[0i].x;
    let _e665 = from_calls[1i].z;
    local_30 = u32(29i);
    let _e670 = local_30;
    local_61 = u32(_e670);
    let _e673 = local_61;
    out[_e673] = (_e664 + _e665);
}
