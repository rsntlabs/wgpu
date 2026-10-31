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

    local = u32(0i);
    let _e3 = local;
    local_29 = u32(_e3);
    let _e6 = local_29;
    let _e9 = out[_e6];
    seed = _e9;
    let _e11 = seed;
    signed_values[0i] = _e11;
    signed_values[1i] = -(2i);
    signed_values[2i] = 4i;
    let _e26 = signed_values[0i];
    let _e27 = signed_values[1i];
    let _e31 = signed_values[2i];
    local_1 = u32(0i);
    let _e36 = local_1;
    local_30 = u32(_e36);
    let _e39 = local_30;
    out[_e39] = ((_e26 + _e27) + _e31);
    words = array<u32, 2>();
    words[0i] = 4294967295u;
    words[1i] = 1u;
    let _e53 = words[0i];
    let _e54 = words[1i];
    local_2 = u32(1i);
    let _e62 = local_2;
    local_31 = u32(_e62);
    let _e65 = local_31;
    out[_e65] = i32(((_e53 + _e54) == 0u));
    samples = array<f32, 2>();
    samples[0i] = 1.5f;
    samples[1i] = 2.25f;
    let _e79 = samples[0i];
    let _e80 = samples[1i];
    local_3 = u32(2i);
    let _e88 = local_3;
    local_32 = u32(_e88);
    let _e91 = local_32;
    out[_e91] = i32(((_e79 + _e80) * 4f));
    flags = array<bool, 3>();
    let _e95 = seed;
    flags[0i] = (_e95 != 0i);
    flags[2i] = true;
    let _e105 = flags[0i];
    let _e111 = flags[1i];
    let _e118 = flags[2i];
    local_4 = u32(3i);
    let _e124 = local_4;
    local_33 = u32(_e124);
    let _e127 = local_33;
    out[_e127] = (((i32(_e105) * 100i) + (i32(_e111) * 10i)) + i32(_e118));
    zeros = array<i32, 2>();
    let _e135 = zeros[0i];
    let _e136 = zeros[1i];
    local_5 = u32(4i);
    let _e141 = local_5;
    local_34 = u32(_e141);
    let _e144 = local_34;
    out[_e144] = (_e135 + _e136);
    let _e146 = seed;
    let _e147 = local_sum(_e146);
    local_6 = u32(5i);
    let _e151 = local_6;
    local_35 = u32(_e151);
    let _e154 = local_35;
    out[_e154] = _e147;
    let _e157 = reset_sum(3i);
    local_7 = u32(6i);
    let _e161 = local_7;
    local_36 = u32(_e161);
    let _e164 = local_36;
    out[_e164] = _e157;
    zero_flags = array<bool, 2>();
    let _e170 = zero_flags[0i];
    local_9 = _e170;
    if _e170 {
    } else {
        let _e174 = zero_flags[1i];
        local_9 = _e174;
    }
    let _e175 = local_9;
    local_8 = u32(7i);
    let _e180 = local_8;
    local_37 = u32(_e180);
    let _e183 = local_37;
    out[_e183] = i32(_e175);
    bank = array<u32, 2>();
    bank[0i] = 3u;
    bank[1i] = 4u;
    {
        bank_1 = array<f32, 2>();
        bank_1[1i] = 6.5f;
        let _e202 = bank_1[0i];
        let _e203 = bank_1[1i];
        local_10 = u32(8i);
        let _e209 = local_10;
        local_38 = u32(_e209);
        let _e212 = local_38;
        out[_e212] = i32((_e202 + _e203));
    }
    let _e218 = bank[0i];
    let _e219 = bank[1i];
    local_11 = u32(9i);
    let _e225 = local_11;
    local_39 = u32(_e225);
    let _e228 = local_39;
    out[_e228] = i32((_e218 + _e219));
    {
        let _e230 = seed;
        signed_values_1[0i] = _e230;
        let _e234 = seed;
        signed_values_1[1i] = _e234;
        let _e241 = signed_values_1[0i];
        let _e242 = signed_values_1[1i];
        local_12 = u32(10i);
        let _e247 = local_12;
        local_40 = u32(_e247);
        let _e250 = local_40;
        out[_e250] = (_e241 + _e242);
    }
    let _e254 = signed_values[0i];
    local_13 = u32(11i);
    let _e258 = local_13;
    local_41 = u32(_e258);
    let _e261 = local_41;
    out[_e261] = _e254;
    mixed = array<i32, 2>();
    let _e265 = seed;
    seed = (_e265 + 1i);
    let next = seed;
    mixed[0i] = next;
    let _e271 = seed;
    seed = (_e271 + 1i);
    mixed[1i] = _e271;
    let _e278 = mixed[0i];
    let _e283 = mixed[1i];
    local_14 = u32(12i);
    let _e288 = local_14;
    local_42 = u32(_e288);
    let _e291 = local_42;
    out[_e291] = ((_e278 * 10i) + _e283);
    let _e293 = seed;
    local_15 = u32(13i);
    let _e297 = local_15;
    local_43 = u32(_e297);
    let _e300 = local_43;
    out[_e300] = _e293;
    reset_total = 0i;
    {
        i = 0i;
        loop {
            let _e306 = i;
            if (_e306 < 3i) {
            } else {
                break;
            }
            reset = array<i32, 2>();
            let _e311 = i;
            if (_e311 == 1i) {
                reset[0i] = 90i;
                continue;
            }
            let _e319 = reset[0i];
            let _e320 = i;
            let _e322 = reset_total;
            reset_total = (_e322 + (_e319 + _e320));
            reset[0i] = 99i;
            continuing {
                let _e327 = i;
                i = (_e327 + 1i);
            }
        }
    }
    let _e330 = reset_total;
    local_16 = u32(14i);
    let _e334 = local_16;
    local_44 = u32(_e334);
    let _e337 = local_44;
    out[_e337] = _e330;
    total = 0i;
    {
        scratch = array<i32, 2>();
        j = 0i;
        loop {
            let _e345 = j;
            if (_e345 < 3i) {
            } else {
                break;
            }
            let _e348 = j;
            let _e352 = scratch[(_e348 % 2i)];
            scratch[(_e348 % 2i)] = (_e352 + 1i);
            let _e355 = j;
            if (_e355 == 1i) {
                continue;
            }
            let _e360 = scratch[0i];
            let _e365 = scratch[1i];
            let _e367 = total;
            total = (_e367 + ((_e360 * 10i) + _e365));
            continuing {
                let _e369 = j;
                j = (_e369 + 1i);
            }
        }
    }
    let _e372 = total;
    local_17 = u32(15i);
    let _e376 = local_17;
    local_45 = u32(_e376);
    let _e379 = local_45;
    out[_e379] = _e372;
    zero_samples = array<f32, 2>();
    let _e387 = zero_samples[0i];
    let _e388 = zero_samples[1i];
    local_18 = u32(16i);
    let _e394 = local_18;
    local_46 = u32(_e394);
    let _e397 = local_46;
    out[_e397] = i32((_e387 + _e388));
    left = array<i32, 2>();
    right = array<i32, 2>();
    left[0i] = 5i;
    left[1i] = 7i;
    right[0i] = 11i;
    right[1i] = 13i;
    let _e419 = left[0i];
    let _e420 = right[0i];
    local_19 = u32(17i);
    let _e425 = local_19;
    local_47 = u32(_e425);
    let _e428 = local_47;
    out[_e428] = (_e419 + _e420);
    {
        temporary = array<i32, 2>();
        let _e432 = seed;
        temporary[0i] = _e432;
        {
            temporary_1 = array<i32, 2>();
            temporary_1[1i] = 3i;
            let _e444 = temporary_1[0i];
            let _e445 = temporary_1[1i];
            local_20 = u32(18i);
            let _e450 = local_20;
            local_48 = u32(_e450);
            let _e453 = local_48;
            out[_e453] = (_e444 + _e445);
        }
        let _e457 = temporary[0i];
        local_21 = u32(19i);
        let _e461 = local_21;
        local_49 = u32(_e461);
        let _e464 = local_49;
        out[_e464] = _e457;
    }
    let _e466 = seed;
    let choose = ((_e466 & 1i) == 0i);
    index = 0i;
    rhs = 20i;
    let _e475 = rhs;
    rhs = (_e475 + 1i);
    let _e478 = rhs;
    if choose {
        let _e479 = index;
        index = (_e479 + 1i);
        let _e483 = left[_e479];
        left[_e479] = (_e483 + _e478);
        let _e485 = left[_e479];
        local_23 = _e485;
    } else {
        let _e487 = index;
        index = (_e487 + 1i);
        let _e491 = right[_e487];
        right[_e487] = (_e491 + _e478);
        let _e493 = right[_e487];
        local_23 = _e493;
    }
    let _e496 = local_23;
    local_22 = u32(20i);
    let _e500 = local_22;
    local_50 = u32(_e500);
    let _e503 = local_50;
    out[_e503] = _e496;
    let _e505 = index;
    local_24 = u32(21i);
    let _e509 = local_24;
    local_51 = u32(_e509);
    let _e512 = local_51;
    out[_e512] = _e505;
    let _e516 = left[0i];
    let _e521 = right[0i];
    local_25 = u32(22i);
    let _e526 = local_25;
    local_52 = u32(_e526);
    let _e529 = local_52;
    out[_e529] = ((_e516 * 100i) + _e521);
    if choose {
        right[1i] = 9i;
        let _e534 = right[1i];
        right[1i] = (_e534 + 1i);
        local_27 = _e534;
    } else {
        left[1i] = 9i;
        let _e541 = left[1i];
        left[1i] = (_e541 + 1i);
        local_27 = _e541;
    }
    let _e546 = local_27;
    local_26 = u32(23i);
    let _e550 = local_26;
    local_53 = u32(_e550);
    let _e553 = local_53;
    out[_e553] = _e546;
    let _e557 = left[1i];
    let _e562 = right[1i];
    local_28 = u32(24i);
    let _e567 = local_28;
    local_54 = u32(_e567);
    let _e570 = local_54;
    out[_e570] = ((_e557 * 100i) + _e562);
}
