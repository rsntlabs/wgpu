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
    var local_35: u32;

    values_1[0] = seed;
    values_1[1] = (seed + 1i);
    local_35 = 2u;
    loop {
        let _e8 = local_35;
        if (_e8 >= 3u) {
            break;
        }
        values_1[_e8] = i32();
        continuing {
            let _e13 = local_35;
            local_35 = (_e13 + 1u);
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

    local = u32(0i);
    let _e3 = local;
    let seed_2 = out[_e3];
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
        let _e26 = local_2;
        if (_e26 >= 3u) {
            break;
        }
        safe_values[_e26] = i32();
        continuing {
            let _e31 = local_2;
            local_2 = (_e31 + 1u);
        }
    }
    let _e34 = zero;
    local_3 = u32(0i);
    let _e38 = local_3;
    out[_e38] = _e34;
    let _e40 = copy_zero;
    local_4 = u32(1i);
    let _e44 = local_4;
    out[_e44] = _e40;
    let _e46 = enabled;
    local_5 = u32(2i);
    let _e51 = local_5;
    out[_e51] = i32(_e46);
    local_6 = u32(3i);
    let _e57 = local_6;
    out[_e57] = i32(count);
    let _e59 = sample;
    local_7 = u32(4i);
    let _e66 = local_7;
    out[_e66] = i32((_e59 * 2f));
    let _e68 = Local;
    local_8 = u32(5i);
    let _e74 = local_8;
    out[_e74] = (Global + _e68);
    let _e78 = safe_values[2i];
    local_9 = u32(6i);
    let _e82 = local_9;
    out[_e82] = _e78;
    values[0] = 1i;
    let _e90 = values[0i];
    values[1] = (_e90 + 1i);
    let _e96 = values[1i];
    values[2] = (_e96 + 1i);
    let _e103 = values[0i];
    let _e104 = values[1i];
    let _e108 = values[2i];
    local_10 = u32(7i);
    let _e113 = local_10;
    out[_e113] = ((_e103 + _e104) + _e108);
    changed[0] = 1i;
    changed[0i] = 7i;
    changed[1] = 2i;
    let _e126 = changed[0i];
    changed[2] = _e126;
    let _e129 = changed[0i];
    local_11 = u32(8i);
    let _e133 = local_11;
    out[_e133] = _e129;
    let _e137 = changed[2i];
    local_12 = u32(9i);
    let _e141 = local_12;
    out[_e141] = _e137;
    point.x = 1i;
    let _e147 = point.x;
    point.y = (_e147 + 1i);
    let _e152 = point.y;
    point.z = (_e152 + 1i);
    let _e157 = point.z;
    local_13 = u32(10i);
    let _e161 = local_13;
    out[_e161] = _e157;
    changed_point.x = 1i;
    changed_point.x = 9i;
    changed_point.y = 2i;
    let _e171 = changed_point.x;
    changed_point.z = _e171;
    let _e174 = changed_point.x;
    local_14 = u32(11i);
    let _e178 = local_14;
    out[_e178] = _e174;
    let _e181 = changed_point.z;
    local_15 = u32(12i);
    let _e185 = local_15;
    out[_e185] = _e181;
    nested[0].x = 1i;
    nested[0].y = 2i;
    nested[0].z = i32();
    nested[1].x = 3i;
    nested[1].y = i32();
    nested[1].z = i32();
    let _e208 = nested[0i].z;
    let _e209 = nested[1i].x;
    local_16 = u32(13i);
    let _e214 = local_16;
    out[_e214] = (_e208 + _e209);
    flat[0].x = 1i;
    flat[0].y = 2i;
    flat[1].x = 3i;
    flat[1].y = i32();
    let _e233 = flat[0i].x;
    let _e234 = flat[0i].y;
    let _e239 = flat[1i].x;
    let _e244 = flat[1i].y;
    local_17 = u32(14i);
    let _e249 = local_17;
    out[_e249] = (((_e233 + _e234) + _e239) + _e244);
    original.x = 2i;
    original.y = 3i;
    original.z = 4i;
    let _e258 = original;
    copied = _e258;
    let _e262 = original;
    copies[0] = _e262;
    copies[1].x = 5i;
    copies[1].y = 6i;
    copies[1].z = i32();
    original.x = 99i;
    let _e273 = copied.x;
    local_18 = u32(15i);
    let _e277 = local_18;
    out[_e277] = _e273;
    let _e282 = copies[0i].x;
    local_19 = u32(16i);
    let _e286 = local_19;
    out[_e286] = _e282;
    let _e291 = copies[1i].z;
    local_20 = u32(17i);
    let _e295 = local_20;
    out[_e295] = _e291;
    counter = seed_2;
    let _e300 = counter;
    counter = (_e300 + 1i);
    ordered[0] = _e300;
    let _e304 = counter;
    counter = (_e304 + 1i);
    ordered[1] = _e304;
    let _e308 = counter;
    ordered[2] = _e308;
    let _e311 = ordered[0i];
    let _e316 = ordered[1i];
    let _e322 = ordered[2i];
    local_21 = u32(18i);
    let _e327 = local_21;
    out[_e327] = (((_e311 * 100i) + (_e316 * 10i)) + _e322);
    let _e329 = counter;
    local_22 = u32(19i);
    let _e333 = local_22;
    out[_e333] = _e329;
    let _e335 = counter;
    counter = (_e335 + 1i);
    let called = pair(_e335, 4i);
    local_23 = u32(20i);
    let _e343 = local_23;
    out[_e343] = called;
    zero_total = 0i;
    {
        iteration = 0i;
        loop {
            let _e349 = iteration;
            if (_e349 < 3i) {
            } else {
                break;
            }
            let _e354 = iteration;
            reset[0] = _e354;
            local_24 = 1u;
            loop {
                let _e357 = local_24;
                if (_e357 >= 3u) {
                    break;
                }
                reset[_e357] = i32();
                continuing {
                    let _e362 = local_24;
                    local_24 = (_e362 + 1u);
                }
            }
            let _e367 = reset[2i];
            let _e368 = zero_total;
            zero_total = (_e368 + _e367);
            reset[2i] = 9i;
            continuing {
                let _e373 = iteration;
                iteration = (_e373 + 1i);
            }
        }
    }
    let _e376 = zero_total;
    local_25 = u32(21i);
    let _e380 = local_25;
    out[_e380] = _e376;
    total = 0i;
    {
        iteration_1 = 0i;
        limit = 3i;
        loop {
            let _e388 = iteration_1;
            let _e389 = limit;
            if (_e388 < _e389) {
            } else {
                break;
            }
            let _e391 = iteration_1;
            let _e392 = total;
            total = (_e392 + _e391);
            continuing {
                let _e394 = iteration_1;
                iteration_1 = (_e394 + 1i);
            }
        }
    }
    let _e397 = total;
    local_26 = u32(22i);
    let _e401 = local_26;
    out[_e401] = _e397;
    Number = 4i;
    let _e407 = Number;
    cached[0] = _e407;
    let _e409 = Number;
    cached[1] = (_e409 + 1i);
    let _e414 = cached[1i];
    local_27 = u32(23i);
    let _e418 = local_27;
    out[_e418] = _e414;
    frozen[0] = 3i;
    local_28 = 1u;
    loop {
        let _e425 = local_28;
        if (_e425 >= 3u) {
            break;
        }
        frozen[_e425] = i32();
        continuing {
            let _e430 = local_28;
            local_28 = (_e430 + 1u);
        }
    }
    let _e437 = frozen[0i];
    let _e438 = frozen[1i];
    let _e442 = frozen[2i];
    local_29 = u32(24i);
    let _e447 = local_29;
    out[_e447] = ((_e437 + _e438) + _e442);
    floating.x = 1.5f;
    floating.y = -(0f);
    floating.z = f32();
    let _e458 = floating.y;
    local_30 = u32(25i);
    let _e463 = local_30;
    out[_e463] = bitcast<i32>(_e458);
    let _e466 = floating.z;
    local_31 = u32(26i);
    let _e471 = local_31;
    out[_e471] = bitcast<i32>(_e466);
    let _e474 = make_list(6i);
    from_call = _e474;
    let _e478 = from_call.x;
    let _e479 = from_call.z;
    local_32 = u32(27i);
    let _e484 = local_32;
    out[_e484] = (_e478 + _e479);
    local_33 = u32(28i);
    let _e493 = local_33;
    out[_e493] = i32((Scale * 10f));
    let _e497 = list_sum((seed_2 + 3i));
    local_34 = u32(29i);
    let _e501 = local_34;
    out[_e501] = _e497;
}
