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

    local = u32(0i);
    let _e3 = local;
    let seed_2 = out[_e3];
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
    let _e46 = values[0i];
    let _e47 = values[1i];
    let _e51 = values[2i];
    local_1 = u32(0i);
    let _e56 = local_1;
    out[_e56] = ((_e46 + _e47) + _e51);
    let _e60 = copied[0i];
    local_2 = u32(1i);
    let _e64 = local_2;
    out[_e64] = _e60;
    let _e70 = zeroes[0i];
    let _e71 = zeroes[1i];
    local_3 = u32(2i);
    let _e76 = local_3;
    out[_e76] = (_e70 + _e71);
    let _e80 = flags[0i];
    let _e84 = flags[1i];
    let _e89 = flags[2i];
    local_4 = u32(3i);
    let _e95 = local_4;
    out[_e95] = ((i32(_e80) + i32(_e84)) + i32(_e89));
    let _e101 = counts[0i];
    let _e102 = counts[1i];
    local_5 = u32(4i);
    let _e108 = local_5;
    out[_e108] = i32((_e101 + _e102));
    let _e114 = samples[0i];
    let _e115 = samples[1i];
    local_6 = u32(5i);
    let _e121 = local_6;
    out[_e121] = i32((_e114 + _e115));
    self_[0] = 1i;
    let _e129 = self_[0i];
    self_[1] = (_e129 + 1i);
    let _e135 = self_[1i];
    self_[2] = (_e135 + 1i);
    let _e140 = self_[0i];
    let _e145 = self_[1i];
    let _e151 = self_[2i];
    local_7 = u32(6i);
    let _e156 = local_7;
    out[_e156] = (((_e140 * 100i) + (_e145 * 10i)) + _e151);
    changed[0] = 1i;
    changed[0i] = 7i;
    changed[1] = 2i;
    let _e169 = changed[0i];
    changed[2] = _e169;
    let _e172 = changed[0i];
    local_8 = u32(7i);
    let _e176 = local_8;
    out[_e176] = _e172;
    let _e180 = changed[2i];
    local_9 = u32(8i);
    let _e184 = local_9;
    out[_e184] = _e180;
    points[0].x = 1i;
    let _e193 = points[0i].x;
    points[0].y = (_e193 + 1i);
    let _e200 = points[0i].y;
    points[0].z = (_e200 + 1i);
    let _e207 = points[0i];
    points[1] = _e207;
    let _e211 = points[1i].z;
    local_10 = u32(9i);
    let _e215 = local_10;
    out[_e215] = _e211;
    flat[0].x = 1i;
    flat[0].y = 2i;
    flat[1].x = 3i;
    flat[1].y = i32();
    let _e231 = flat[1i].y;
    local_11 = u32(10i);
    let _e235 = local_11;
    out[_e235] = _e231;
    let _e240 = flat[1i].x;
    local_12 = u32(11i);
    let _e244 = local_12;
    out[_e244] = _e240;
    original.x = 4i;
    original.y = 5i;
    original.z = 6i;
    let _e255 = original;
    copies[0] = _e255;
    let _e257 = original;
    copies[1] = _e257;
    copies[2].x = 7i;
    copies[2].y = 8i;
    copies[2].z = i32();
    original.x = 99i;
    let _e270 = copies[0i].x;
    local_13 = u32(12i);
    let _e274 = local_13;
    out[_e274] = _e270;
    let _e279 = copies[1i].y;
    local_14 = u32(13i);
    let _e283 = local_14;
    out[_e283] = _e279;
    let _e288 = copies[2i].z;
    local_15 = u32(14i);
    let _e292 = local_15;
    out[_e292] = _e288;
    Number[0] = 2i;
    Number[1] = 3i;
    let _e303 = Number[1i];
    next[0] = _e303;
    let _e307 = Number[0i];
    next[1] = _e307;
    let _e310 = next[0i];
    local_16 = u32(15i);
    let _e314 = local_16;
    out[_e314] = _e310;
    Count = 3i;
    scratch = array<i32, 3>();
    let _e322 = scratch[2i];
    local_17 = u32(16i);
    let _e326 = local_17;
    out[_e326] = _e322;
    pending[0] = 1f;
    pending[1] = f32(2i);
    let _e338 = pending[0i];
    let _e339 = pending[1i];
    local_18 = u32(17i);
    let _e345 = local_18;
    out[_e345] = i32((_e338 + _e339));
    pending_vectors[0].x = 1f;
    pending_vectors[0].y = f32(2i);
    pending_vectors[0].z = f32();
    pending_vectors[1].x = 3f;
    pending_vectors[1].y = f32();
    pending_vectors[1].z = f32();
    let _e369 = pending_vectors[0i].x;
    let _e370 = pending_vectors[0i].y;
    let _e375 = pending_vectors[1i].x;
    local_19 = u32(18i);
    let _e381 = local_19;
    out[_e381] = i32(((_e369 + _e370) + _e375));
    counter = seed_2;
    let _e386 = counter;
    counter = (_e386 + 1i);
    ordered[0] = _e386;
    let _e390 = counter;
    counter = (_e390 + 1i);
    ordered[1] = _e390;
    let _e394 = counter;
    ordered[2] = _e394;
    let _e397 = ordered[0i];
    let _e402 = ordered[1i];
    let _e408 = ordered[2i];
    local_20 = u32(19i);
    let _e413 = local_20;
    out[_e413] = (((_e397 * 100i) + (_e402 * 10i)) + _e408);
    let _e415 = counter;
    local_21 = u32(20i);
    let _e419 = local_21;
    out[_e419] = _e415;
    let _e423 = counter;
    counter = (_e423 + 1i);
    let _e427 = pair(_e423, 4i);
    called[0] = _e427;
    let _e429 = counter;
    called[1] = _e429;
    let _e434 = called[0i];
    let _e435 = called[1i];
    local_22 = u32(21i);
    let _e440 = local_22;
    out[_e440] = (_e434 + _e435);
    let _e442 = counter;
    local_23 = u32(22i);
    let _e446 = local_23;
    out[_e446] = _e442;
    zero_total = 0i;
    {
        iteration = 0i;
        loop {
            let _e452 = iteration;
            if (_e452 < 3i) {
            } else {
                break;
            }
            let _e457 = iteration;
            reset[0].x = _e457;
            reset[0].y = i32();
            reset[1] = vec2<i32>();
            let _e469 = reset[0i].y;
            let _e470 = reset[1i].x;
            let _e472 = zero_total;
            zero_total = (_e472 + (_e469 + _e470));
            reset[0i].y = 9i;
            reset[1i].x = 8i;
            continuing {
                let _e482 = iteration;
                iteration = (_e482 + 1i);
            }
        }
    }
    let _e485 = zero_total;
    local_24 = u32(23i);
    let _e489 = local_24;
    out[_e489] = _e485;
    total = 0i;
    {
        iteration_1 = 0i;
        loop {
            let _e495 = iteration_1;
            if (_e495 < 4i) {
            } else {
                break;
            }
            let _e498 = iteration_1;
            if (_e498 == 1i) {
                continue;
            }
            let _e501 = iteration_1;
            let _e502 = total;
            total = (_e502 + _e501);
            continuing {
                let _e504 = iteration_1;
                iteration_1 = (_e504 + 1i);
            }
        }
    }
    let _e507 = total;
    local_25 = u32(24i);
    let _e511 = local_25;
    out[_e511] = _e507;
    let _e514 = sum(4i);
    local_26 = u32(25i);
    let _e518 = local_26;
    out[_e518] = _e514;
    frozen[0] = 2i;
    frozen[1] = 3i;
    let _e529 = frozen[0i];
    let _e530 = frozen[1i];
    local_27 = u32(26i);
    let _e535 = local_27;
    out[_e535] = (_e529 + _e530);
    signed_zeroes[0] = -(0f);
    signed_zeroes[1] = 0f;
    let _e545 = signed_zeroes[0i];
    local_28 = u32(27i);
    let _e550 = local_28;
    out[_e550] = bitcast<i32>(_e545);
    let _e554 = signed_zeroes[1i];
    local_29 = u32(28i);
    let _e559 = local_29;
    out[_e559] = bitcast<i32>(_e554);
    let _e564 = triple(6i);
    from_calls[0] = _e564;
    let _e567 = triple(9i);
    from_calls[1] = _e567;
    let _e574 = from_calls[0i].x;
    let _e575 = from_calls[1i].z;
    local_30 = u32(29i);
    let _e580 = local_30;
    out[_e580] = (_e574 + _e575);
}
