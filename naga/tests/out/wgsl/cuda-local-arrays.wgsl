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
    var local: u32;
    var signed_values: array<i32, 3>;
    var local_1: u32;
    var words: array<u32, 2>;
    var local_2: u32;
    var samples: array<f32, 2>;
    var local_3: u32;
    var flags: array<bool, 3>;
    var local_4: u32;
    var zeros: array<i32, 2>;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var zero_flags: array<bool, 2>;
    var local_8: u32;
    var local_9: bool;
    var bank: array<u32, 2>;
    var bank_1: array<f32, 2>;
    var local_10: u32;
    var local_11: u32;
    var signed_values_1: array<i32, 2>;
    var local_12: u32;
    var local_13: u32;
    var mixed: array<i32, 2>;
    var local_14: u32;
    var local_15: u32;
    var reset_total: i32;
    var i: i32;
    var reset: array<i32, 2>;
    var local_16: u32;
    var total: i32;
    var scratch: array<i32, 2>;
    var j: i32;
    var local_17: u32;
    var zero_samples: array<f32, 2>;
    var local_18: u32;
    var left: array<i32, 2>;
    var right: array<i32, 2>;
    var local_19: u32;
    var temporary: array<i32, 2>;
    var temporary_1: array<i32, 2>;
    var local_20: u32;
    var local_21: u32;
    var index: i32;
    var rhs: i32;
    var local_22: u32;
    var local_23: i32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: i32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;

    local = u32(0i);
    let _e3 = local;
    let _e6 = out[_e3];
    seed = _e6;
    let _e8 = seed;
    signed_values[0i] = _e8;
    signed_values[1i] = -(2i);
    signed_values[2i] = 4i;
    let _e23 = signed_values[0i];
    let _e24 = signed_values[1i];
    let _e28 = signed_values[2i];
    local_1 = u32(0i);
    let _e33 = local_1;
    out[_e33] = ((_e23 + _e24) + _e28);
    words = array<u32, 2>();
    words[0i] = 4294967295u;
    words[1i] = 1u;
    let _e47 = words[0i];
    let _e48 = words[1i];
    local_2 = u32(1i);
    let _e56 = local_2;
    out[_e56] = i32(((_e47 + _e48) == 0u));
    samples = array<f32, 2>();
    samples[0i] = 1.5f;
    samples[1i] = 2.25f;
    let _e70 = samples[0i];
    let _e71 = samples[1i];
    local_3 = u32(2i);
    let _e79 = local_3;
    out[_e79] = i32(((_e70 + _e71) * 4f));
    flags = array<bool, 3>();
    let _e83 = seed;
    flags[0i] = (_e83 != 0i);
    flags[2i] = true;
    let _e93 = flags[0i];
    let _e99 = flags[1i];
    let _e106 = flags[2i];
    local_4 = u32(3i);
    let _e112 = local_4;
    out[_e112] = (((i32(_e93) * 100i) + (i32(_e99) * 10i)) + i32(_e106));
    zeros = array<i32, 2>();
    let _e120 = zeros[0i];
    let _e121 = zeros[1i];
    local_5 = u32(4i);
    let _e126 = local_5;
    out[_e126] = (_e120 + _e121);
    let _e128 = seed;
    let _e129 = local_sum(_e128);
    local_6 = u32(5i);
    let _e133 = local_6;
    out[_e133] = _e129;
    let _e136 = reset_sum(3i);
    local_7 = u32(6i);
    let _e140 = local_7;
    out[_e140] = _e136;
    zero_flags = array<bool, 2>();
    let _e146 = zero_flags[0i];
    local_9 = _e146;
    if _e146 {
    } else {
        let _e150 = zero_flags[1i];
        local_9 = _e150;
    }
    let _e151 = local_9;
    local_8 = u32(7i);
    let _e156 = local_8;
    out[_e156] = i32(_e151);
    bank = array<u32, 2>();
    bank[0i] = 3u;
    bank[1i] = 4u;
    {
        bank_1 = array<f32, 2>();
        bank_1[1i] = 6.5f;
        let _e175 = bank_1[0i];
        let _e176 = bank_1[1i];
        local_10 = u32(8i);
        let _e182 = local_10;
        local_29 = _e182;
        let _e184 = local_29;
        out[_e184] = i32((_e175 + _e176));
    }
    let _e190 = bank[0i];
    let _e191 = bank[1i];
    local_11 = u32(9i);
    let _e197 = local_11;
    out[_e197] = i32((_e190 + _e191));
    {
        let _e199 = seed;
        signed_values_1[0i] = _e199;
        let _e203 = seed;
        signed_values_1[1i] = _e203;
        let _e210 = signed_values_1[0i];
        let _e211 = signed_values_1[1i];
        local_12 = u32(10i);
        let _e216 = local_12;
        local_30 = _e216;
        let _e218 = local_30;
        out[_e218] = (_e210 + _e211);
    }
    let _e222 = signed_values[0i];
    local_13 = u32(11i);
    let _e226 = local_13;
    out[_e226] = _e222;
    mixed = array<i32, 2>();
    let _e230 = seed;
    seed = (_e230 + 1i);
    let next = seed;
    mixed[0i] = next;
    let _e236 = seed;
    seed = (_e236 + 1i);
    mixed[1i] = _e236;
    let _e243 = mixed[0i];
    let _e248 = mixed[1i];
    local_14 = u32(12i);
    let _e253 = local_14;
    out[_e253] = ((_e243 * 10i) + _e248);
    let _e255 = seed;
    local_15 = u32(13i);
    let _e259 = local_15;
    out[_e259] = _e255;
    reset_total = 0i;
    {
        i = 0i;
        loop {
            let _e265 = i;
            if (_e265 < 3i) {
            } else {
                break;
            }
            reset = array<i32, 2>();
            let _e270 = i;
            if (_e270 == 1i) {
                reset[0i] = 90i;
                continue;
            }
            let _e278 = reset[0i];
            let _e279 = i;
            let _e281 = reset_total;
            reset_total = (_e281 + (_e278 + _e279));
            reset[0i] = 99i;
            continuing {
                let _e286 = i;
                i = (_e286 + 1i);
            }
        }
    }
    let _e289 = reset_total;
    local_16 = u32(14i);
    let _e293 = local_16;
    out[_e293] = _e289;
    total = 0i;
    {
        scratch = array<i32, 2>();
        j = 0i;
        loop {
            let _e301 = j;
            if (_e301 < 3i) {
            } else {
                break;
            }
            let _e304 = j;
            let _e308 = scratch[(_e304 % 2i)];
            scratch[(_e304 % 2i)] = (_e308 + 1i);
            let _e311 = j;
            if (_e311 == 1i) {
                continue;
            }
            let _e316 = scratch[0i];
            let _e321 = scratch[1i];
            let _e323 = total;
            total = (_e323 + ((_e316 * 10i) + _e321));
            continuing {
                let _e325 = j;
                j = (_e325 + 1i);
            }
        }
    }
    let _e328 = total;
    local_17 = u32(15i);
    let _e332 = local_17;
    out[_e332] = _e328;
    zero_samples = array<f32, 2>();
    let _e340 = zero_samples[0i];
    let _e341 = zero_samples[1i];
    local_18 = u32(16i);
    let _e347 = local_18;
    out[_e347] = i32((_e340 + _e341));
    left = array<i32, 2>();
    right = array<i32, 2>();
    left[0i] = 5i;
    left[1i] = 7i;
    right[0i] = 11i;
    right[1i] = 13i;
    let _e369 = left[0i];
    let _e370 = right[0i];
    local_19 = u32(17i);
    let _e375 = local_19;
    out[_e375] = (_e369 + _e370);
    {
        temporary = array<i32, 2>();
        let _e379 = seed;
        temporary[0i] = _e379;
        {
            temporary_1 = array<i32, 2>();
            temporary_1[1i] = 3i;
            let _e391 = temporary_1[0i];
            let _e392 = temporary_1[1i];
            local_20 = u32(18i);
            let _e397 = local_20;
            local_31 = _e397;
            let _e399 = local_31;
            out[_e399] = (_e391 + _e392);
        }
        let _e403 = temporary[0i];
        local_21 = u32(19i);
        let _e407 = local_21;
        local_32 = _e407;
        let _e409 = local_32;
        out[_e409] = _e403;
    }
    let _e411 = seed;
    let choose = ((_e411 & 1i) == 0i);
    index = 0i;
    rhs = 20i;
    let _e420 = rhs;
    rhs = (_e420 + 1i);
    let _e423 = rhs;
    if choose {
        let _e424 = index;
        index = (_e424 + 1i);
        let _e428 = left[_e424];
        left[_e424] = (_e428 + _e423);
        let _e430 = left[_e424];
        local_23 = _e430;
    } else {
        let _e432 = index;
        index = (_e432 + 1i);
        let _e436 = right[_e432];
        right[_e432] = (_e436 + _e423);
        let _e438 = right[_e432];
        local_23 = _e438;
    }
    let _e441 = local_23;
    local_22 = u32(20i);
    let _e445 = local_22;
    out[_e445] = _e441;
    let _e447 = index;
    local_24 = u32(21i);
    let _e451 = local_24;
    out[_e451] = _e447;
    let _e455 = left[0i];
    let _e460 = right[0i];
    local_25 = u32(22i);
    let _e465 = local_25;
    out[_e465] = ((_e455 * 100i) + _e460);
    if choose {
        right[1i] = 9i;
        let _e470 = right[1i];
        right[1i] = (_e470 + 1i);
        local_27 = _e470;
    } else {
        left[1i] = 9i;
        let _e477 = left[1i];
        left[1i] = (_e477 + 1i);
        local_27 = _e477;
    }
    let _e482 = local_27;
    local_26 = u32(23i);
    let _e486 = local_26;
    out[_e486] = _e482;
    let _e490 = left[1i];
    let _e495 = right[1i];
    local_28 = u32(24i);
    let _e500 = local_28;
    out[_e500] = ((_e490 * 100i) + _e495);
}
