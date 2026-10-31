struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
@group(0) @binding(2)
var<uniform> n_1: type_5;

fn select_value(value_1: i32, choose_first: bool) -> i32 {
    var value_2: i32;
    var choose_first_1: bool;
    var result: i32;

    value_2 = value_1;
    choose_first_1 = choose_first;
    let _e5 = choose_first_1;
    if _e5 {
        let _e7 = value_2;
        result = (_e7 + 3i);
    } else {
        let _e10 = value_2;
        result = (_e10 - 2i);
    }
    let _e12 = result;
    return _e12;
}

fn scaled(value_3: f32) -> f32 {
    var value_4: f32;
    var result_1: f32;

    value_4 = value_3;
    let _e4 = value_4;
    result_1 = ((_e4 * 2f) + 4f);
    let _e8 = result_1;
    return _e8;
}

fn accumulate(limit: u32) -> u32 {
    var limit_1: u32;
    var sum: u32;
    var i_1: u32;
    var term: u32;

    limit_1 = limit;
    sum = 0u;
    {
        i_1 = 0u;
        loop {
            let _e6 = i_1;
            let _e7 = limit_1;
            if (_e6 < _e7) {
            } else {
                break;
            }
            let _e15 = i_1;
            if ((_e15 % 2u) == 0u) {
                let _e20 = i_1;
                term = (_e20 + 1u);
            } else {
                let _e23 = i_1;
                term = (_e23 * 2u);
            }
            let _e25 = term;
            let _e26 = sum;
            sum = (_e26 + _e25);
            continuing {
                let _e9 = i_1;
                i_1 = (_e9 + u32(1i));
            }
        }
    }
    let _e28 = sum;
    return _e28;
}

@compute @workgroup_size(64, 1, 1)
fn uninitialized(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var chosen: i32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var weighted: f32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var negative: bool;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var magnitude: u32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var total: i32;
    var iteration: i32;
    var copied: i32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var descending: i32;
    var iteration_1: i32;
    var staged: i32;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var remaining: i32;
    var partial: i32;
    var next: i32;
    var local_20: array<u32, 2>;
    var local_21: u32;
    var shadow: i32;
    var shadow_1: i32;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var local_28: i32;
    var local_29: array<u32, 2>;
    var local_30: u32;
    var local_31: u32;
    var local_32: i32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var local_35: u32;
    var local_36: array<u32, 2>;
    var local_37: u32;
    var local_38: u32;
    var local_39: array<u32, 2>;
    var local_40: u32;
    var local_41: u32;
    var local_42: array<u32, 2>;
    var local_43: u32;
    var local_44: u32;
    var local_45: array<u32, 2>;
    var local_46: u32;
    var local_47: u32;
    var local_48: array<u32, 2>;
    var local_49: u32;
    var local_50: u32;
    var local_51: array<u32, 2>;
    var local_52: u32;
    var local_53: u32;
    var local_54: array<u32, 2>;
    var local_55: u32;
    var local_56: u32;
    var local_57: array<u32, 2>;
    var local_58: u32;
    var local_59: u32;
    var local_60: array<u32, 2>;
    var local_61: u32;
    var local_62: u32;
    var local_63: array<u32, 2>;
    var local_64: u32;
    var local_65: u32;
    var local_66: array<u32, 2>;
    var local_67: u32;
    var local_68: u32;

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = array<u32, 2>();
    local_1[0] = 1u;
    local_1[1] = 0u;
    let _e18 = n_1.value;
    n = _e18;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e26 = i;
    let _e27 = n;
    if (_e26 < _e27) {
        let _e29 = i;
        base = (_e29 * 12u);
        let _e35 = local_1;
        local_2 = _e35;
        let _e36 = i;
        local_3 = u32(_e36);
        let _e40 = local_2;
        local_29 = _e40;
        let _e41 = local_3;
        let _e43 = local_29[1];
        local_29[1] = (_e43 + _e41);
        let _e47 = local_29[0];
        local_30 = u32(_e47);
        let _e51 = local_29[1];
        local_31 = u32(_e51);
        let _e55 = local_31;
        let _e57 = input[_e55];
        local_32 = _e57;
        let _e58 = local_32;
        local_28 = _e58;
        let _e60 = local_28;
        value = _e60;
        let _e62 = i;
        if ((_e62 % 2u) == 0u) {
            let _e67 = value;
            chosen = (_e67 + 7i);
        } else {
            let _e71 = value;
            chosen = (_e71 - 4i);
        }
        let _e76 = chosen;
        let _e79 = local;
        local_4 = _e79;
        let _e80 = base;
        local_5 = u32(_e80);
        let _e84 = local_4;
        local_33 = _e84;
        let _e85 = local_5;
        let _e87 = local_33[1];
        local_33[1] = (_e87 + _e85);
        let _e91 = local_33[0];
        local_34 = u32(_e91);
        let _e95 = local_33[1];
        local_35 = u32(_e95);
        let _e98 = local_35;
        out[_e98] = _e76;
        let _e100 = value;
        let _e101 = i;
        let _e106 = select_value(_e100, ((_e101 % 3u) == 0u));
        let _e108 = local;
        local_6 = _e108;
        let _e109 = base;
        local_7 = u32((_e109 + 1u));
        let _e115 = local_6;
        local_36 = _e115;
        let _e116 = local_7;
        let _e118 = local_36[1];
        local_36[1] = (_e118 + _e116);
        let _e122 = local_36[0];
        local_37 = u32(_e122);
        let _e126 = local_36[1];
        local_38 = u32(_e126);
        let _e129 = local_38;
        out[_e129] = _e106;
        let _e131 = value;
        weighted = ((f32(_e131) * 1.5f) + 2f);
        let _e138 = weighted;
        let _e141 = local;
        local_8 = _e141;
        let _e142 = base;
        local_9 = u32((_e142 + 2u));
        let _e148 = local_8;
        local_39 = _e148;
        let _e149 = local_9;
        let _e151 = local_39[1];
        local_39[1] = (_e151 + _e149);
        let _e155 = local_39[0];
        local_40 = u32(_e155);
        let _e159 = local_39[1];
        local_41 = u32(_e159);
        let _e162 = local_41;
        out[_e162] = i32(_e138);
        let _e164 = value;
        negative = (_e164 < 0i);
        let _e168 = negative;
        let _e170 = local;
        local_10 = _e170;
        let _e171 = base;
        local_11 = u32((_e171 + 3u));
        let _e178 = local_10;
        local_42 = _e178;
        let _e179 = local_11;
        let _e181 = local_42[1];
        local_42[1] = (_e181 + _e179);
        let _e185 = local_42[0];
        local_43 = u32(_e185);
        let _e189 = local_42[1];
        local_44 = u32(_e189);
        let _e192 = local_44;
        out[_e192] = i32(_e168);
        let _e194 = value;
        magnitude = u32((_e194 + 5i));
        let _e199 = magnitude;
        let _e203 = local;
        local_12 = _e203;
        let _e204 = base;
        local_13 = u32((_e204 + 4u));
        let _e211 = local_12;
        local_45 = _e211;
        let _e212 = local_13;
        let _e214 = local_45[1];
        local_45[1] = (_e214 + _e212);
        let _e218 = local_45[0];
        local_46 = u32(_e218);
        let _e222 = local_45[1];
        local_47 = u32(_e222);
        let _e225 = local_47;
        out[_e225] = i32((_e199 * 3u));
        let _e227 = i;
        let _e230 = accumulate((_e227 % 5u));
        let _e232 = local;
        local_14 = _e232;
        let _e233 = base;
        local_15 = u32((_e233 + 5u));
        let _e240 = local_14;
        local_48 = _e240;
        let _e241 = local_15;
        let _e243 = local_48[1];
        local_48[1] = (_e243 + _e241);
        let _e247 = local_48[0];
        local_49 = u32(_e247);
        let _e251 = local_48[1];
        local_50 = u32(_e251);
        let _e254 = local_50;
        out[_e254] = i32(_e230);
        total = 0i;
        {
            iteration = 0i;
            loop {
                let _e260 = iteration;
                if (_e260 < 3i) {
                } else {
                    break;
                }
                let _e263 = value;
                let _e264 = iteration;
                copied = (_e263 + _e264);
                let _e267 = copied;
                let _e268 = total;
                total = (_e268 + _e267);
                continuing {
                    let _e270 = iteration;
                    iteration = (_e270 + 1i);
                }
            }
        }
        let _e273 = total;
        let _e275 = local;
        local_16 = _e275;
        let _e276 = base;
        local_17 = u32((_e276 + 6u));
        let _e282 = local_16;
        local_51 = _e282;
        let _e283 = local_17;
        let _e285 = local_51[1];
        local_51[1] = (_e285 + _e283);
        let _e289 = local_51[0];
        local_52 = u32(_e289);
        let _e293 = local_51[1];
        local_53 = u32(_e293);
        let _e296 = local_53;
        out[_e296] = _e273;
        descending = 0i;
        iteration_1 = 0i;
        {
            loop {
                let _e302 = iteration_1;
                if (_e302 < 3i) {
                } else {
                    break;
                }
                let _e305 = value;
                let _e306 = iteration_1;
                staged = (_e305 - _e306);
                let _e309 = staged;
                let _e310 = descending;
                descending = (_e310 + _e309);
                continuing {
                    let _e312 = iteration_1;
                    iteration_1 = (_e312 + 1i);
                }
            }
        }
        let _e315 = descending;
        let _e317 = local;
        local_18 = _e317;
        let _e318 = base;
        local_19 = u32((_e318 + 7u));
        let _e324 = local_18;
        local_54 = _e324;
        let _e325 = local_19;
        let _e327 = local_54[1];
        local_54[1] = (_e327 + _e325);
        let _e331 = local_54[0];
        local_55 = u32(_e331);
        let _e335 = local_54[1];
        local_56 = u32(_e335);
        let _e338 = local_56;
        out[_e338] = _e315;
        remaining = 2i;
        let _e342 = value;
        partial = _e342;
        loop {
            let _e344 = remaining;
            if (_e344 > 0i) {
            } else {
                break;
            }
            {
                let _e347 = partial;
                let _e348 = remaining;
                next = (_e347 + _e348);
                let _e351 = next;
                partial = _e351;
                let _e352 = remaining;
                remaining = (_e352 - 1i);
            }
        }
        let _e355 = partial;
        let _e357 = local;
        local_20 = _e357;
        let _e358 = base;
        local_21 = u32((_e358 + 8u));
        let _e364 = local_20;
        local_57 = _e364;
        let _e365 = local_21;
        let _e367 = local_57[1];
        local_57[1] = (_e367 + _e365);
        let _e371 = local_57[0];
        local_58 = u32(_e371);
        let _e375 = local_57[1];
        local_59 = u32(_e375);
        let _e378 = local_59;
        out[_e378] = _e355;
        let _e380 = value;
        shadow = _e380;
        {
            let _e382 = value;
            shadow_1 = (_e382 + 10i);
            let _e386 = shadow_1;
            let _e388 = local;
            local_22 = _e388;
            let _e389 = base;
            local_23 = u32((_e389 + 9u));
            let _e395 = local_22;
            local_60 = _e395;
            let _e396 = local_23;
            let _e398 = local_60[1];
            local_60[1] = (_e398 + _e396);
            let _e402 = local_60[0];
            local_61 = u32(_e402);
            let _e406 = local_60[1];
            local_62 = u32(_e406);
            let _e409 = local_62;
            out[_e409] = _e386;
        }
        let _e411 = shadow;
        let _e413 = local;
        local_24 = _e413;
        let _e414 = base;
        local_25 = u32((_e414 + 10u));
        let _e420 = local_24;
        local_63 = _e420;
        let _e421 = local_25;
        let _e423 = local_63[1];
        local_63[1] = (_e423 + _e421);
        let _e427 = local_63[0];
        local_64 = u32(_e427);
        let _e431 = local_63[1];
        local_65 = u32(_e431);
        let _e434 = local_65;
        out[_e434] = _e411;
        let _e436 = value;
        let _e438 = scaled(f32(_e436));
        let _e440 = local;
        local_26 = _e440;
        let _e441 = base;
        local_27 = u32((_e441 + 11u));
        let _e448 = local_26;
        local_66 = _e448;
        let _e449 = local_27;
        let _e451 = local_66[1];
        local_66[1] = (_e451 + _e449);
        let _e455 = local_66[0];
        local_67 = u32(_e455);
        let _e459 = local_66[1];
        local_68 = u32(_e459);
        let _e462 = local_68;
        out[_e462] = i32(_e438);
    }
}
