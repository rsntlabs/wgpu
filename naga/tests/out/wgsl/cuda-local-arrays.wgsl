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
    var local_29: i32;
    var local_30: u32;
    var local_31: i32;
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

    local = u32(0i);
    let _e3 = local;
    local_30 = u32(_e3);
    let _e6 = local_30;
    let _e9 = out[_e6];
    local_31 = _e9;
    let _e11 = local_31;
    local_29 = _e11;
    let _e13 = local_29;
    seed = _e13;
    let _e15 = seed;
    signed_values[0i] = _e15;
    signed_values[1i] = -(2i);
    signed_values[2i] = 4i;
    let _e30 = signed_values[0i];
    let _e31 = signed_values[1i];
    let _e35 = signed_values[2i];
    local_1 = u32(0i);
    let _e40 = local_1;
    local_32 = u32(_e40);
    let _e43 = local_32;
    out[_e43] = ((_e30 + _e31) + _e35);
    words = array<u32, 2>();
    words[0i] = 4294967295u;
    words[1i] = 1u;
    let _e57 = words[0i];
    let _e58 = words[1i];
    local_2 = u32(1i);
    let _e66 = local_2;
    local_33 = u32(_e66);
    let _e69 = local_33;
    out[_e69] = i32(((_e57 + _e58) == 0u));
    samples = array<f32, 2>();
    samples[0i] = 1.5f;
    samples[1i] = 2.25f;
    let _e83 = samples[0i];
    let _e84 = samples[1i];
    local_3 = u32(2i);
    let _e92 = local_3;
    local_34 = u32(_e92);
    let _e95 = local_34;
    out[_e95] = i32(((_e83 + _e84) * 4f));
    flags = array<bool, 3>();
    let _e99 = seed;
    flags[0i] = (_e99 != 0i);
    flags[2i] = true;
    let _e109 = flags[0i];
    let _e115 = flags[1i];
    let _e122 = flags[2i];
    local_4 = u32(3i);
    let _e128 = local_4;
    local_35 = u32(_e128);
    let _e131 = local_35;
    out[_e131] = (((i32(_e109) * 100i) + (i32(_e115) * 10i)) + i32(_e122));
    zeros = array<i32, 2>();
    let _e139 = zeros[0i];
    let _e140 = zeros[1i];
    local_5 = u32(4i);
    let _e145 = local_5;
    local_36 = u32(_e145);
    let _e148 = local_36;
    out[_e148] = (_e139 + _e140);
    let _e150 = seed;
    let _e151 = local_sum(_e150);
    local_6 = u32(5i);
    let _e155 = local_6;
    local_37 = u32(_e155);
    let _e158 = local_37;
    out[_e158] = _e151;
    let _e161 = reset_sum(3i);
    local_7 = u32(6i);
    let _e165 = local_7;
    local_38 = u32(_e165);
    let _e168 = local_38;
    out[_e168] = _e161;
    zero_flags = array<bool, 2>();
    let _e174 = zero_flags[0i];
    local_9 = _e174;
    if _e174 {
    } else {
        let _e178 = zero_flags[1i];
        local_9 = _e178;
    }
    let _e179 = local_9;
    local_8 = u32(7i);
    let _e184 = local_8;
    local_39 = u32(_e184);
    let _e187 = local_39;
    out[_e187] = i32(_e179);
    bank = array<u32, 2>();
    bank[0i] = 3u;
    bank[1i] = 4u;
    {
        bank_1 = array<f32, 2>();
        bank_1[1i] = 6.5f;
        let _e206 = bank_1[0i];
        let _e207 = bank_1[1i];
        local_10 = u32(8i);
        let _e213 = local_10;
        local_40 = u32(_e213);
        let _e216 = local_40;
        out[_e216] = i32((_e206 + _e207));
    }
    let _e222 = bank[0i];
    let _e223 = bank[1i];
    local_11 = u32(9i);
    let _e229 = local_11;
    local_41 = u32(_e229);
    let _e232 = local_41;
    out[_e232] = i32((_e222 + _e223));
    {
        let _e234 = seed;
        signed_values_1[0i] = _e234;
        let _e238 = seed;
        signed_values_1[1i] = _e238;
        let _e245 = signed_values_1[0i];
        let _e246 = signed_values_1[1i];
        local_12 = u32(10i);
        let _e251 = local_12;
        local_42 = u32(_e251);
        let _e254 = local_42;
        out[_e254] = (_e245 + _e246);
    }
    let _e258 = signed_values[0i];
    local_13 = u32(11i);
    let _e262 = local_13;
    local_43 = u32(_e262);
    let _e265 = local_43;
    out[_e265] = _e258;
    mixed = array<i32, 2>();
    let _e269 = seed;
    seed = (_e269 + 1i);
    let next = seed;
    mixed[0i] = next;
    let _e275 = seed;
    seed = (_e275 + 1i);
    mixed[1i] = _e275;
    let _e282 = mixed[0i];
    let _e287 = mixed[1i];
    local_14 = u32(12i);
    let _e292 = local_14;
    local_44 = u32(_e292);
    let _e295 = local_44;
    out[_e295] = ((_e282 * 10i) + _e287);
    let _e297 = seed;
    local_15 = u32(13i);
    let _e301 = local_15;
    local_45 = u32(_e301);
    let _e304 = local_45;
    out[_e304] = _e297;
    reset_total = 0i;
    {
        i = 0i;
        loop {
            let _e310 = i;
            if (_e310 < 3i) {
            } else {
                break;
            }
            reset = array<i32, 2>();
            let _e315 = i;
            if (_e315 == 1i) {
                reset[0i] = 90i;
                continue;
            }
            let _e323 = reset[0i];
            let _e324 = i;
            let _e326 = reset_total;
            reset_total = (_e326 + (_e323 + _e324));
            reset[0i] = 99i;
            continuing {
                let _e331 = i;
                i = (_e331 + 1i);
            }
        }
    }
    let _e334 = reset_total;
    local_16 = u32(14i);
    let _e338 = local_16;
    local_46 = u32(_e338);
    let _e341 = local_46;
    out[_e341] = _e334;
    total = 0i;
    {
        scratch = array<i32, 2>();
        j = 0i;
        loop {
            let _e349 = j;
            if (_e349 < 3i) {
            } else {
                break;
            }
            let _e352 = j;
            let _e356 = scratch[(_e352 % 2i)];
            scratch[(_e352 % 2i)] = (_e356 + 1i);
            let _e359 = j;
            if (_e359 == 1i) {
                continue;
            }
            let _e364 = scratch[0i];
            let _e369 = scratch[1i];
            let _e371 = total;
            total = (_e371 + ((_e364 * 10i) + _e369));
            continuing {
                let _e373 = j;
                j = (_e373 + 1i);
            }
        }
    }
    let _e376 = total;
    local_17 = u32(15i);
    let _e380 = local_17;
    local_47 = u32(_e380);
    let _e383 = local_47;
    out[_e383] = _e376;
    zero_samples = array<f32, 2>();
    let _e391 = zero_samples[0i];
    let _e392 = zero_samples[1i];
    local_18 = u32(16i);
    let _e398 = local_18;
    local_48 = u32(_e398);
    let _e401 = local_48;
    out[_e401] = i32((_e391 + _e392));
    left = array<i32, 2>();
    right = array<i32, 2>();
    left[0i] = 5i;
    left[1i] = 7i;
    right[0i] = 11i;
    right[1i] = 13i;
    let _e423 = left[0i];
    let _e424 = right[0i];
    local_19 = u32(17i);
    let _e429 = local_19;
    local_49 = u32(_e429);
    let _e432 = local_49;
    out[_e432] = (_e423 + _e424);
    {
        temporary = array<i32, 2>();
        let _e436 = seed;
        temporary[0i] = _e436;
        {
            temporary_1 = array<i32, 2>();
            temporary_1[1i] = 3i;
            let _e448 = temporary_1[0i];
            let _e449 = temporary_1[1i];
            local_20 = u32(18i);
            let _e454 = local_20;
            local_50 = u32(_e454);
            let _e457 = local_50;
            out[_e457] = (_e448 + _e449);
        }
        let _e461 = temporary[0i];
        local_21 = u32(19i);
        let _e465 = local_21;
        local_51 = u32(_e465);
        let _e468 = local_51;
        out[_e468] = _e461;
    }
    let _e470 = seed;
    let choose = ((_e470 & 1i) == 0i);
    index = 0i;
    rhs = 20i;
    let _e479 = rhs;
    rhs = (_e479 + 1i);
    let _e482 = rhs;
    if choose {
        let _e483 = index;
        index = (_e483 + 1i);
        let _e487 = left[_e483];
        left[_e483] = (_e487 + _e482);
        let _e489 = left[_e483];
        local_23 = _e489;
    } else {
        let _e491 = index;
        index = (_e491 + 1i);
        let _e495 = right[_e491];
        right[_e491] = (_e495 + _e482);
        let _e497 = right[_e491];
        local_23 = _e497;
    }
    let _e500 = local_23;
    local_22 = u32(20i);
    let _e504 = local_22;
    local_52 = u32(_e504);
    let _e507 = local_52;
    out[_e507] = _e500;
    let _e509 = index;
    local_24 = u32(21i);
    let _e513 = local_24;
    local_53 = u32(_e513);
    let _e516 = local_53;
    out[_e516] = _e509;
    let _e520 = left[0i];
    let _e525 = right[0i];
    local_25 = u32(22i);
    let _e530 = local_25;
    local_54 = u32(_e530);
    let _e533 = local_54;
    out[_e533] = ((_e520 * 100i) + _e525);
    if choose {
        right[1i] = 9i;
        let _e538 = right[1i];
        right[1i] = (_e538 + 1i);
        local_27 = _e538;
    } else {
        left[1i] = 9i;
        let _e545 = left[1i];
        left[1i] = (_e545 + 1i);
        local_27 = _e545;
    }
    let _e550 = local_27;
    local_26 = u32(23i);
    let _e554 = local_26;
    local_55 = u32(_e554);
    let _e557 = local_55;
    out[_e557] = _e550;
    let _e561 = left[1i];
    let _e566 = right[1i];
    local_28 = u32(24i);
    let _e571 = local_28;
    local_56 = u32(_e571);
    let _e574 = local_56;
    out[_e574] = ((_e561 * 100i) + _e566);
}
