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
    var local_4: u32;

    values_1[0] = seed;
    values_1[1] = (seed + 1i);
    local_4 = 2u;
    loop {
        let _e8 = local_4;
        if (_e8 >= 3u) {
            break;
        }
        values_1[_e8] = i32();
        continuing {
            let _e13 = local_4;
            local_4 = (_e13 + 1u);
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
    var zero: i32;
    var copy_zero: i32;
    var enabled: bool;
    var sample: f32;
    var Local: i32;
    var Safe: i32;
    var local: i32;
    var safe_values: array<i32, 3>;
    var local_1: u32;
    var values: array<i32, 3>;
    var changed: array<i32, 3>;
    var point: int3_;
    var changed_point: int3_;
    var nested: array<int3_, 2>;
    var flat: array<vec2<i32>, 2>;
    var original: int3_;
    var copied: int3_;
    var copies: array<int3_, 2>;
    var counter: i32;
    var ordered: array<i32, 3>;
    var zero_total: i32;
    var iteration: i32;
    var reset: array<i32, 3>;
    var local_2: u32;
    var total: i32;
    var iteration_1: i32;
    var limit: i32;
    var Number: i32;
    var cached: array<i32, 2>;
    var frozen: array<i32, 3>;
    var local_3: u32;
    var floating: float3_;
    var from_call: int3_;

    let seed_2 = out[u32(0i)];
    zero = 0i;
    copy_zero = 0i;
    enabled = true;
    let count = u32(7i);
    sample = 1.5f;
    Local = 3i;
    Safe = 3i;
    safe_values[0] = 1i;
    local_1 = 1u;
    loop {
        let _e24 = local_1;
        if (_e24 >= 3u) {
            break;
        }
        safe_values[_e24] = i32();
        continuing {
            let _e29 = local_1;
            local_1 = (_e29 + 1u);
        }
    }
    let _e32 = zero;
    out[u32(0i)] = _e32;
    let _e36 = copy_zero;
    out[u32(1i)] = _e36;
    let _e40 = enabled;
    out[u32(2i)] = i32(_e40);
    out[u32(3i)] = i32(count);
    let _e49 = sample;
    out[u32(4i)] = i32((_e49 * 2f));
    let _e56 = Local;
    out[u32(5i)] = (Global + _e56);
    let _e64 = safe_values[2i];
    out[u32(6i)] = _e64;
    values[0] = 1i;
    let _e74 = values[0i];
    values[1] = (_e74 + 1i);
    let _e80 = values[1i];
    values[2] = (_e80 + 1i);
    let _e87 = values[0i];
    let _e88 = values[1i];
    let _e92 = values[2i];
    out[u32(7i)] = ((_e87 + _e88) + _e92);
    changed[0] = 1i;
    changed[0i] = 7i;
    changed[1] = 2i;
    let _e108 = changed[0i];
    changed[2] = _e108;
    let _e111 = changed[0i];
    out[u32(8i)] = _e111;
    let _e117 = changed[2i];
    out[u32(9i)] = _e117;
    point.x = 1i;
    let _e125 = point.x;
    point.y = (_e125 + 1i);
    let _e130 = point.y;
    point.z = (_e130 + 1i);
    let _e135 = point.z;
    out[u32(10i)] = _e135;
    changed_point.x = 1i;
    changed_point.x = 9i;
    changed_point.y = 2i;
    let _e147 = changed_point.x;
    changed_point.z = _e147;
    let _e150 = changed_point.x;
    out[u32(11i)] = _e150;
    let _e155 = changed_point.z;
    out[u32(12i)] = _e155;
    nested[0].x = 1i;
    nested[0].y = 2i;
    nested[0].z = i32();
    nested[1].x = 3i;
    nested[1].y = i32();
    nested[1].z = i32();
    let _e180 = nested[0i].z;
    let _e181 = nested[1i].x;
    out[u32(13i)] = (_e180 + _e181);
    flat[0].x = 1i;
    flat[0].y = 2i;
    flat[1].x = 3i;
    flat[1].y = i32();
    let _e203 = flat[0i].x;
    let _e204 = flat[0i].y;
    let _e209 = flat[1i].x;
    let _e214 = flat[1i].y;
    out[u32(14i)] = (((_e203 + _e204) + _e209) + _e214);
    original.x = 2i;
    original.y = 3i;
    original.z = 4i;
    let _e226 = original;
    copied = _e226;
    let _e230 = original;
    copies[0] = _e230;
    copies[1].x = 5i;
    copies[1].y = 6i;
    copies[1].z = i32();
    original.x = 99i;
    let _e241 = copied.x;
    out[u32(15i)] = _e241;
    let _e248 = copies[0i].x;
    out[u32(16i)] = _e248;
    let _e255 = copies[1i].z;
    out[u32(17i)] = _e255;
    counter = seed_2;
    let _e262 = counter;
    counter = (_e262 + 1i);
    ordered[0] = _e262;
    let _e266 = counter;
    counter = (_e266 + 1i);
    ordered[1] = _e266;
    let _e270 = counter;
    ordered[2] = _e270;
    let _e273 = ordered[0i];
    let _e278 = ordered[1i];
    let _e284 = ordered[2i];
    out[u32(18i)] = (((_e273 * 100i) + (_e278 * 10i)) + _e284);
    let _e289 = counter;
    out[u32(19i)] = _e289;
    let _e293 = counter;
    counter = (_e293 + 1i);
    let called = pair(_e293, 4i);
    out[u32(20i)] = called;
    zero_total = 0i;
    {
        iteration = 0i;
        loop {
            let _e305 = iteration;
            if (_e305 < 3i) {
            } else {
                break;
            }
            let _e310 = iteration;
            reset[0] = _e310;
            local_2 = 1u;
            loop {
                let _e313 = local_2;
                if (_e313 >= 3u) {
                    break;
                }
                reset[_e313] = i32();
                continuing {
                    let _e318 = local_2;
                    local_2 = (_e318 + 1u);
                }
            }
            let _e323 = reset[2i];
            let _e324 = zero_total;
            zero_total = (_e324 + _e323);
            reset[2i] = 9i;
            continuing {
                let _e329 = iteration;
                iteration = (_e329 + 1i);
            }
        }
    }
    let _e332 = zero_total;
    out[u32(21i)] = _e332;
    total = 0i;
    {
        iteration_1 = 0i;
        limit = 3i;
        loop {
            let _e342 = iteration_1;
            let _e343 = limit;
            if (_e342 < _e343) {
            } else {
                break;
            }
            let _e345 = iteration_1;
            let _e346 = total;
            total = (_e346 + _e345);
            continuing {
                let _e348 = iteration_1;
                iteration_1 = (_e348 + 1i);
            }
        }
    }
    let _e351 = total;
    out[u32(22i)] = _e351;
    Number = 4i;
    let _e359 = Number;
    cached[0] = _e359;
    let _e361 = Number;
    cached[1] = (_e361 + 1i);
    let _e366 = cached[1i];
    out[u32(23i)] = _e366;
    frozen[0] = 3i;
    local_3 = 1u;
    loop {
        let _e375 = local_3;
        if (_e375 >= 3u) {
            break;
        }
        frozen[_e375] = i32();
        continuing {
            let _e380 = local_3;
            local_3 = (_e380 + 1u);
        }
    }
    let _e387 = frozen[0i];
    let _e388 = frozen[1i];
    let _e392 = frozen[2i];
    out[u32(24i)] = ((_e387 + _e388) + _e392);
    floating.x = 1.5f;
    floating.y = -(0f);
    floating.z = f32();
    let _e406 = floating.y;
    out[u32(25i)] = bitcast<i32>(_e406);
    let _e412 = floating.z;
    out[u32(26i)] = bitcast<i32>(_e412);
    let _e418 = make_list(6i);
    from_call = _e418;
    let _e422 = from_call.x;
    let _e423 = from_call.z;
    out[u32(27i)] = (_e422 + _e423);
    out[u32(28i)] = i32((Scale * 10f));
    let _e437 = list_sum((seed_2 + 3i));
    out[u32(29i)] = _e437;
}
