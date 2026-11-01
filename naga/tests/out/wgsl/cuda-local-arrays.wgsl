@group(0) @binding(0)
var<storage, read_write> out: array<i32>;

fn local_sum(value: i32) -> i32 {
    var values: array<i32, 3>;

    values = array<i32, 3>();
    values[0i] = value;
    values[1i] = (value + 1i);
    let _e13 = values[0i];
    let _e14 = values[1i];
    values[2i] = (_e13 + _e14);
    let _e20 = values[2i];
    return _e20;
}

fn reset_sum(count: i32) -> i32 {
    var result: i32;
    var i_1: i32;
    var values_1: array<i32, 2>;

    result = 0i;
    {
        i_1 = 0i;
        loop {
            let _e5 = i_1;
            if (_e5 < count) {
            } else {
                break;
            }
            values_1 = array<i32, 2>();
            let _e9 = i_1;
            values_1[1i] = _e9;
            let _e16 = values_1[0i];
            let _e17 = values_1[1i];
            let _e19 = result;
            result = (_e19 + (_e16 + _e17));
            values_1[0i] = 99i;
            continuing {
                let _e24 = i_1;
                i_1 = (_e24 + 1i);
            }
        }
    }
    let _e27 = result;
    return _e27;
}

@compute @workgroup_size(1, 1, 1)
fn local_arrays() {
    var seed: i32;
    var signed_values: array<i32, 3>;
    var words: array<u32, 2>;
    var samples: array<f32, 2>;
    var flags: array<bool, 3>;
    var zeros: array<i32, 2>;
    var zero_flags: array<bool, 2>;
    var local: bool;
    var bank: array<u32, 2>;
    var bank_1: array<f32, 2>;
    var local_1: u32;
    var signed_values_1: array<i32, 2>;
    var local_2: u32;
    var mixed: array<i32, 2>;
    var reset_total: i32;
    var i: i32;
    var reset: array<i32, 2>;
    var total: i32;
    var scratch: array<i32, 2>;
    var j: i32;
    var zero_samples: array<f32, 2>;
    var left: array<i32, 2>;
    var right: array<i32, 2>;
    var temporary: array<i32, 2>;
    var temporary_1: array<i32, 2>;
    var local_3: u32;
    var local_4: u32;
    var index: i32;
    var rhs: i32;
    var local_5: i32;
    var local_6: i32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;

    let _e4 = out[u32(0i)];
    seed = _e4;
    let _e6 = seed;
    signed_values[0i] = _e6;
    signed_values[1i] = -(2i);
    signed_values[2i] = 4i;
    let _e21 = signed_values[0i];
    let _e22 = signed_values[1i];
    let _e26 = signed_values[2i];
    out[u32(0i)] = ((_e21 + _e22) + _e26);
    words = array<u32, 2>();
    words[0i] = 4294967295u;
    words[1i] = 1u;
    let _e43 = words[0i];
    let _e44 = words[1i];
    out[u32(1i)] = i32(((_e43 + _e44) == 0u));
    samples = array<f32, 2>();
    samples[0i] = 1.5f;
    samples[1i] = 2.25f;
    let _e64 = samples[0i];
    let _e65 = samples[1i];
    out[u32(2i)] = i32(((_e64 + _e65) * 4f));
    flags = array<bool, 3>();
    let _e75 = seed;
    flags[0i] = (_e75 != 0i);
    flags[2i] = true;
    let _e85 = flags[0i];
    let _e91 = flags[1i];
    let _e98 = flags[2i];
    out[u32(3i)] = (((i32(_e85) * 100i) + (i32(_e91) * 10i)) + i32(_e98));
    zeros = array<i32, 2>();
    let _e110 = zeros[0i];
    let _e111 = zeros[1i];
    out[u32(4i)] = (_e110 + _e111);
    let _e116 = seed;
    let _e117 = local_sum(_e116);
    out[u32(5i)] = _e117;
    let _e122 = reset_sum(3i);
    out[u32(6i)] = _e122;
    zero_flags = array<bool, 2>();
    let _e130 = zero_flags[0i];
    local = _e130;
    if _e130 {
    } else {
        let _e134 = zero_flags[1i];
        local = _e134;
    }
    let _e135 = local;
    out[u32(7i)] = i32(_e135);
    bank = array<u32, 2>();
    bank[0i] = 3u;
    bank[1i] = 4u;
    {
        bank_1 = array<f32, 2>();
        bank_1[1i] = 6.5f;
        let _e157 = bank_1[0i];
        let _e158 = bank_1[1i];
        local_1 = u32(8i);
        let _e164 = local_1;
        local_7 = _e164;
        let _e166 = local_7;
        out[_e166] = i32((_e157 + _e158));
    }
    let _e172 = bank[0i];
    let _e173 = bank[1i];
    out[u32(9i)] = i32((_e172 + _e173));
    {
        let _e179 = seed;
        signed_values_1[0i] = _e179;
        let _e183 = seed;
        signed_values_1[1i] = _e183;
        let _e190 = signed_values_1[0i];
        let _e191 = signed_values_1[1i];
        local_2 = u32(10i);
        let _e196 = local_2;
        local_8 = _e196;
        let _e198 = local_8;
        out[_e198] = (_e190 + _e191);
    }
    let _e202 = signed_values[0i];
    out[u32(11i)] = _e202;
    mixed = array<i32, 2>();
    let _e208 = seed;
    seed = (_e208 + 1i);
    let next = seed;
    mixed[0i] = next;
    let _e214 = seed;
    seed = (_e214 + 1i);
    mixed[1i] = _e214;
    let _e221 = mixed[0i];
    let _e226 = mixed[1i];
    out[u32(12i)] = ((_e221 * 10i) + _e226);
    let _e231 = seed;
    out[u32(13i)] = _e231;
    reset_total = 0i;
    {
        i = 0i;
        loop {
            let _e239 = i;
            if (_e239 < 3i) {
            } else {
                break;
            }
            reset = array<i32, 2>();
            let _e244 = i;
            if (_e244 == 1i) {
                reset[0i] = 90i;
                continue;
            }
            let _e252 = reset[0i];
            let _e253 = i;
            let _e255 = reset_total;
            reset_total = (_e255 + (_e252 + _e253));
            reset[0i] = 99i;
            continuing {
                let _e260 = i;
                i = (_e260 + 1i);
            }
        }
    }
    let _e263 = reset_total;
    out[u32(14i)] = _e263;
    total = 0i;
    {
        scratch = array<i32, 2>();
        j = 0i;
        loop {
            let _e273 = j;
            if (_e273 < 3i) {
            } else {
                break;
            }
            let _e276 = j;
            let _e280 = scratch[(_e276 % 2i)];
            scratch[(_e276 % 2i)] = (_e280 + 1i);
            let _e283 = j;
            if (_e283 == 1i) {
                continue;
            }
            let _e288 = scratch[0i];
            let _e293 = scratch[1i];
            let _e295 = total;
            total = (_e295 + ((_e288 * 10i) + _e293));
            continuing {
                let _e297 = j;
                j = (_e297 + 1i);
            }
        }
    }
    let _e300 = total;
    out[u32(15i)] = _e300;
    zero_samples = array<f32, 2>();
    let _e310 = zero_samples[0i];
    let _e311 = zero_samples[1i];
    out[u32(16i)] = i32((_e310 + _e311));
    left = array<i32, 2>();
    right = array<i32, 2>();
    left[0i] = 5i;
    left[1i] = 7i;
    right[0i] = 11i;
    right[1i] = 13i;
    let _e337 = left[0i];
    let _e338 = right[0i];
    out[u32(17i)] = (_e337 + _e338);
    {
        temporary = array<i32, 2>();
        let _e345 = seed;
        temporary[0i] = _e345;
        {
            temporary_1 = array<i32, 2>();
            temporary_1[1i] = 3i;
            let _e357 = temporary_1[0i];
            let _e358 = temporary_1[1i];
            local_3 = u32(18i);
            let _e363 = local_3;
            local_9 = _e363;
            let _e365 = local_9;
            out[_e365] = (_e357 + _e358);
        }
        let _e369 = temporary[0i];
        local_4 = u32(19i);
        let _e373 = local_4;
        local_10 = _e373;
        let _e375 = local_10;
        out[_e375] = _e369;
    }
    let _e377 = seed;
    let choose = ((_e377 & 1i) == 0i);
    index = 0i;
    rhs = 20i;
    let _e386 = rhs;
    rhs = (_e386 + 1i);
    let _e389 = rhs;
    if choose {
        let _e390 = index;
        index = (_e390 + 1i);
        let _e394 = left[_e390];
        left[_e390] = (_e394 + _e389);
        let _e396 = left[_e390];
        local_5 = _e396;
    } else {
        let _e398 = index;
        index = (_e398 + 1i);
        let _e402 = right[_e398];
        right[_e398] = (_e402 + _e389);
        let _e404 = right[_e398];
        local_5 = _e404;
    }
    let _e407 = local_5;
    out[u32(20i)] = _e407;
    let _e411 = index;
    out[u32(21i)] = _e411;
    let _e417 = left[0i];
    let _e422 = right[0i];
    out[u32(22i)] = ((_e417 * 100i) + _e422);
    if choose {
        right[1i] = 9i;
        let _e430 = right[1i];
        right[1i] = (_e430 + 1i);
        local_6 = _e430;
    } else {
        left[1i] = 9i;
        let _e437 = left[1i];
        left[1i] = (_e437 + 1i);
        local_6 = _e437;
    }
    let _e442 = local_6;
    out[u32(23i)] = _e442;
    let _e448 = left[1i];
    let _e453 = right[1i];
    out[u32(24i)] = ((_e448 * 100i) + _e453);
}
