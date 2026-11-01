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
    var values: array<i32, 3>;
    var copied: array<i32, 2>;
    var zeroes: array<i32, 2>;
    var flags: array<bool, 3>;
    var counts: array<u32, 2>;
    var samples: array<f32, 2>;
    var self_: array<i32, 3>;
    var changed: array<i32, 3>;
    var points: array<int3_, 2>;
    var flat: array<vec2<i32>, 2>;
    var original: int3_;
    var copies: array<int3_, 3>;
    var Number: array<i32, 2>;
    var next: array<i32, 2>;
    var Count: i32;
    var scratch: array<i32, 3>;
    var pending: array<f32, 2>;
    var pending_vectors: array<float3_, 2>;
    var counter: i32;
    var ordered: array<i32, 3>;
    var called: array<i32, 2>;
    var zero_total: i32;
    var iteration: i32;
    var reset: array<vec2<i32>, 2>;
    var total: i32;
    var iteration_1: i32;
    var frozen: array<i32, 2>;
    var signed_zeroes: array<f32, 2>;
    var from_calls: array<int3_, 2>;

    let seed_2 = out[u32(0i)];
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
    let _e44 = values[0i];
    let _e45 = values[1i];
    let _e49 = values[2i];
    out[u32(0i)] = ((_e44 + _e45) + _e49);
    let _e56 = copied[0i];
    out[u32(1i)] = _e56;
    let _e64 = zeroes[0i];
    let _e65 = zeroes[1i];
    out[u32(2i)] = (_e64 + _e65);
    let _e72 = flags[0i];
    let _e76 = flags[1i];
    let _e81 = flags[2i];
    out[u32(3i)] = ((i32(_e72) + i32(_e76)) + i32(_e81));
    let _e91 = counts[0i];
    let _e92 = counts[1i];
    out[u32(4i)] = i32((_e91 + _e92));
    let _e102 = samples[0i];
    let _e103 = samples[1i];
    out[u32(5i)] = i32((_e102 + _e103));
    self_[0] = 1i;
    let _e115 = self_[0i];
    self_[1] = (_e115 + 1i);
    let _e121 = self_[1i];
    self_[2] = (_e121 + 1i);
    let _e126 = self_[0i];
    let _e131 = self_[1i];
    let _e137 = self_[2i];
    out[u32(6i)] = (((_e126 * 100i) + (_e131 * 10i)) + _e137);
    changed[0] = 1i;
    changed[0i] = 7i;
    changed[1] = 2i;
    let _e153 = changed[0i];
    changed[2] = _e153;
    let _e156 = changed[0i];
    out[u32(7i)] = _e156;
    let _e162 = changed[2i];
    out[u32(8i)] = _e162;
    points[0].x = 1i;
    let _e173 = points[0i].x;
    points[0].y = (_e173 + 1i);
    let _e180 = points[0i].y;
    points[0].z = (_e180 + 1i);
    let _e187 = points[0i];
    points[1] = _e187;
    let _e191 = points[1i].z;
    out[u32(9i)] = _e191;
    flat[0].x = 1i;
    flat[0].y = 2i;
    flat[1].x = 3i;
    flat[1].y = i32();
    let _e209 = flat[1i].y;
    out[u32(10i)] = _e209;
    let _e216 = flat[1i].x;
    out[u32(11i)] = _e216;
    original.x = 4i;
    original.y = 5i;
    original.z = 6i;
    let _e229 = original;
    copies[0] = _e229;
    let _e231 = original;
    copies[1] = _e231;
    copies[2].x = 7i;
    copies[2].y = 8i;
    copies[2].z = i32();
    original.x = 99i;
    let _e244 = copies[0i].x;
    out[u32(12i)] = _e244;
    let _e251 = copies[1i].y;
    out[u32(13i)] = _e251;
    let _e258 = copies[2i].z;
    out[u32(14i)] = _e258;
    Number[0] = 2i;
    Number[1] = 3i;
    let _e271 = Number[1i];
    next[0] = _e271;
    let _e275 = Number[0i];
    next[1] = _e275;
    let _e278 = next[0i];
    out[u32(15i)] = _e278;
    Count = 3i;
    scratch = array<i32, 3>();
    let _e288 = scratch[2i];
    out[u32(16i)] = _e288;
    pending[0] = 1f;
    pending[1] = f32(2i);
    let _e302 = pending[0i];
    let _e303 = pending[1i];
    out[u32(17i)] = i32((_e302 + _e303));
    pending_vectors[0].x = 1f;
    pending_vectors[0].y = f32(2i);
    pending_vectors[0].z = f32();
    pending_vectors[1].x = 3f;
    pending_vectors[1].y = f32();
    pending_vectors[1].z = f32();
    let _e331 = pending_vectors[0i].x;
    let _e332 = pending_vectors[0i].y;
    let _e337 = pending_vectors[1i].x;
    out[u32(18i)] = i32(((_e331 + _e332) + _e337));
    counter = seed_2;
    let _e346 = counter;
    counter = (_e346 + 1i);
    ordered[0] = _e346;
    let _e350 = counter;
    counter = (_e350 + 1i);
    ordered[1] = _e350;
    let _e354 = counter;
    ordered[2] = _e354;
    let _e357 = ordered[0i];
    let _e362 = ordered[1i];
    let _e368 = ordered[2i];
    out[u32(19i)] = (((_e357 * 100i) + (_e362 * 10i)) + _e368);
    let _e373 = counter;
    out[u32(20i)] = _e373;
    let _e379 = counter;
    counter = (_e379 + 1i);
    let _e383 = pair(_e379, 4i);
    called[0] = _e383;
    let _e385 = counter;
    called[1] = _e385;
    let _e390 = called[0i];
    let _e391 = called[1i];
    out[u32(21i)] = (_e390 + _e391);
    let _e396 = counter;
    out[u32(22i)] = _e396;
    zero_total = 0i;
    {
        iteration = 0i;
        loop {
            let _e404 = iteration;
            if (_e404 < 3i) {
            } else {
                break;
            }
            let _e409 = iteration;
            reset[0].x = _e409;
            reset[0].y = i32();
            reset[1] = vec2<i32>();
            let _e421 = reset[0i].y;
            let _e422 = reset[1i].x;
            let _e424 = zero_total;
            zero_total = (_e424 + (_e421 + _e422));
            reset[0i].y = 9i;
            reset[1i].x = 8i;
            continuing {
                let _e434 = iteration;
                iteration = (_e434 + 1i);
            }
        }
    }
    let _e437 = zero_total;
    out[u32(23i)] = _e437;
    total = 0i;
    {
        iteration_1 = 0i;
        loop {
            let _e445 = iteration_1;
            if (_e445 < 4i) {
            } else {
                break;
            }
            let _e448 = iteration_1;
            if (_e448 == 1i) {
                continue;
            }
            let _e451 = iteration_1;
            let _e452 = total;
            total = (_e452 + _e451);
            continuing {
                let _e454 = iteration_1;
                iteration_1 = (_e454 + 1i);
            }
        }
    }
    let _e457 = total;
    out[u32(24i)] = _e457;
    let _e462 = sum(4i);
    out[u32(25i)] = _e462;
    frozen[0] = 2i;
    frozen[1] = 3i;
    let _e475 = frozen[0i];
    let _e476 = frozen[1i];
    out[u32(26i)] = (_e475 + _e476);
    signed_zeroes[0] = -(0f);
    signed_zeroes[1] = 0f;
    let _e489 = signed_zeroes[0i];
    out[u32(27i)] = bitcast<i32>(_e489);
    let _e496 = signed_zeroes[1i];
    out[u32(28i)] = bitcast<i32>(_e496);
    let _e504 = triple(6i);
    from_calls[0] = _e504;
    let _e507 = triple(9i);
    from_calls[1] = _e507;
    let _e514 = from_calls[0i].x;
    let _e515 = from_calls[1i].z;
    out[u32(29i)] = (_e514 + _e515);
}
