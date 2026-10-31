struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
@group(0) @binding(1)
var<storage> input_1: array<i32>;
@group(0) @binding(2)
var<uniform> n: type_5;

fn select_value(value_1: i32, choose_first: bool) -> i32 {
    var result: i32;

    if choose_first {
        result = (value_1 + 3i);
    } else {
        result = (value_1 - 2i);
    }
    let _e9 = result;
    return _e9;
}

fn scaled(value_2: f32) -> f32 {
    let result_1 = ((value_2 * 2f) + 4f);
    return result_1;
}

fn accumulate(limit: u32) -> u32 {
    var sum: u32;
    var i: u32;
    var term: u32;

    sum = 0u;
    {
        i = 0u;
        loop {
            let _e5 = i;
            if (_e5 < limit) {
            } else {
                break;
            }
            let _e7 = i;
            if ((_e7 % 2u) == 0u) {
                let _e12 = i;
                term = (_e12 + 1u);
            } else {
                let _e16 = i;
                term = (_e16 * 2u);
            }
            let _e21 = term;
            let _e22 = sum;
            sum = (_e22 + _e21);
            continuing {
                let _e24 = i;
                i = (_e24 + u32(1i));
            }
        }
    }
    let _e28 = sum;
    return _e28;
}

@compute @workgroup_size(64, 1, 1)
fn uninitialized(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var out: array<u32, 2>;
    var input: array<u32, 2>;
    var base: u32;
    var value: i32;
    var local: array<u32, 2>;
    var local_1: u32;
    var chosen: i32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var weighted: f32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var negative: bool;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var magnitude: u32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var total: i32;
    var iteration: i32;
    var copied: i32;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var descending: i32;
    var iteration_1: i32;
    var staged: i32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var remaining: i32;
    var partial: i32;
    var next: i32;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var shadow: i32;
    var shadow_1: i32;
    var local_20: array<u32, 2>;
    var local_21: u32;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: i32;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: u32;
    var local_30: i32;
    var local_31: array<u32, 2>;
    var local_32: u32;
    var local_33: u32;
    var local_34: array<u32, 2>;
    var local_35: u32;
    var local_36: u32;
    var local_37: array<u32, 2>;
    var local_38: u32;
    var local_39: u32;
    var local_40: array<u32, 2>;
    var local_41: u32;
    var local_42: u32;
    var local_43: array<u32, 2>;
    var local_44: u32;
    var local_45: u32;
    var local_46: array<u32, 2>;
    var local_47: u32;
    var local_48: u32;
    var local_49: array<u32, 2>;
    var local_50: u32;
    var local_51: u32;
    var local_52: array<u32, 2>;
    var local_53: u32;
    var local_54: u32;
    var local_55: array<u32, 2>;
    var local_56: u32;
    var local_57: u32;
    var local_58: array<u32, 2>;
    var local_59: u32;
    var local_60: u32;
    var local_61: array<u32, 2>;
    var local_62: u32;
    var local_63: u32;
    var local_64: array<u32, 2>;
    var local_65: u32;
    var local_66: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    input = array<u32, 2>();
    input[0] = 1u;
    input[1] = 0u;
    let n_1 = n.value;
    let i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if (i_1 < n_1) {
        base = (i_1 * 12u);
        let _e27 = input;
        local = _e27;
        local_1 = u32(i_1);
        let _e31 = local;
        local_27 = _e31;
        let _e33 = local_1;
        let _e35 = local_27[1];
        local_27[1] = (_e35 + _e33);
        let _e39 = local_27[0];
        local_28 = u32(_e39);
        let _e43 = local_27[1];
        local_29 = u32(_e43);
        let _e46 = local_29;
        let _e49 = input_1[_e46];
        local_30 = _e49;
        let _e51 = local_30;
        local_26 = _e51;
        let _e53 = local_26;
        value = _e53;
        if ((i_1 % 2u) == 0u) {
            let _e59 = value;
            chosen = (_e59 + 7i);
        } else {
            let _e63 = value;
            chosen = (_e63 - 4i);
        }
        let _e68 = chosen;
        let _e70 = out;
        local_2 = _e70;
        let _e72 = base;
        local_3 = u32(_e72);
        let _e75 = local_2;
        local_31 = _e75;
        let _e77 = local_3;
        let _e79 = local_31[1];
        local_31[1] = (_e79 + _e77);
        let _e83 = local_31[0];
        local_32 = u32(_e83);
        let _e87 = local_31[1];
        local_33 = u32(_e87);
        let _e90 = local_33;
        out_1[_e90] = _e68;
        let _e93 = value;
        let _e98 = select_value(_e93, ((i_1 % 3u) == 0u));
        let _e99 = out;
        local_4 = _e99;
        let _e101 = base;
        local_5 = u32((_e101 + 1u));
        let _e106 = local_4;
        local_34 = _e106;
        let _e108 = local_5;
        let _e110 = local_34[1];
        local_34[1] = (_e110 + _e108);
        let _e114 = local_34[0];
        local_35 = u32(_e114);
        let _e118 = local_34[1];
        local_36 = u32(_e118);
        let _e121 = local_36;
        out_1[_e121] = _e98;
        let _e123 = value;
        weighted = ((f32(_e123) * 1.5f) + 2f);
        let _e130 = weighted;
        let _e132 = out;
        local_6 = _e132;
        let _e134 = base;
        local_7 = u32((_e134 + 2u));
        let _e139 = local_6;
        local_37 = _e139;
        let _e141 = local_7;
        let _e143 = local_37[1];
        local_37[1] = (_e143 + _e141);
        let _e147 = local_37[0];
        local_38 = u32(_e147);
        let _e151 = local_37[1];
        local_39 = u32(_e151);
        let _e154 = local_39;
        out_1[_e154] = i32(_e130);
        let _e156 = value;
        negative = (_e156 < 0i);
        let _e160 = negative;
        let _e161 = out;
        local_8 = _e161;
        let _e163 = base;
        local_9 = u32((_e163 + 3u));
        let _e169 = local_8;
        local_40 = _e169;
        let _e171 = local_9;
        let _e173 = local_40[1];
        local_40[1] = (_e173 + _e171);
        let _e177 = local_40[0];
        local_41 = u32(_e177);
        let _e181 = local_40[1];
        local_42 = u32(_e181);
        let _e184 = local_42;
        out_1[_e184] = i32(_e160);
        let _e186 = value;
        magnitude = u32((_e186 + 5i));
        let _e191 = magnitude;
        let _e194 = out;
        local_10 = _e194;
        let _e196 = base;
        local_11 = u32((_e196 + 4u));
        let _e202 = local_10;
        local_43 = _e202;
        let _e204 = local_11;
        let _e206 = local_43[1];
        local_43[1] = (_e206 + _e204);
        let _e210 = local_43[0];
        local_44 = u32(_e210);
        let _e214 = local_43[1];
        local_45 = u32(_e214);
        let _e217 = local_45;
        out_1[_e217] = i32((_e191 * 3u));
        let _e221 = accumulate((i_1 % 5u));
        let _e222 = out;
        local_12 = _e222;
        let _e224 = base;
        local_13 = u32((_e224 + 5u));
        let _e230 = local_12;
        local_46 = _e230;
        let _e232 = local_13;
        let _e234 = local_46[1];
        local_46[1] = (_e234 + _e232);
        let _e238 = local_46[0];
        local_47 = u32(_e238);
        let _e242 = local_46[1];
        local_48 = u32(_e242);
        let _e245 = local_48;
        out_1[_e245] = i32(_e221);
        total = 0i;
        {
            iteration = 0i;
            loop {
                let _e251 = iteration;
                if (_e251 < 3i) {
                } else {
                    break;
                }
                let _e254 = value;
                let _e255 = iteration;
                copied = (_e254 + _e255);
                let _e258 = copied;
                let _e259 = total;
                total = (_e259 + _e258);
                continuing {
                    let _e261 = iteration;
                    iteration = (_e261 + 1i);
                }
            }
        }
        let _e264 = total;
        let _e265 = out;
        local_14 = _e265;
        let _e267 = base;
        local_15 = u32((_e267 + 6u));
        let _e272 = local_14;
        local_49 = _e272;
        let _e274 = local_15;
        let _e276 = local_49[1];
        local_49[1] = (_e276 + _e274);
        let _e280 = local_49[0];
        local_50 = u32(_e280);
        let _e284 = local_49[1];
        local_51 = u32(_e284);
        let _e287 = local_51;
        out_1[_e287] = _e264;
        descending = 0i;
        iteration_1 = 0i;
        {
            loop {
                let _e293 = iteration_1;
                if (_e293 < 3i) {
                } else {
                    break;
                }
                let _e296 = value;
                let _e297 = iteration_1;
                staged = (_e296 - _e297);
                let _e300 = staged;
                let _e301 = descending;
                descending = (_e301 + _e300);
                continuing {
                    let _e303 = iteration_1;
                    iteration_1 = (_e303 + 1i);
                }
            }
        }
        let _e306 = descending;
        let _e307 = out;
        local_16 = _e307;
        let _e309 = base;
        local_17 = u32((_e309 + 7u));
        let _e314 = local_16;
        local_52 = _e314;
        let _e316 = local_17;
        let _e318 = local_52[1];
        local_52[1] = (_e318 + _e316);
        let _e322 = local_52[0];
        local_53 = u32(_e322);
        let _e326 = local_52[1];
        local_54 = u32(_e326);
        let _e329 = local_54;
        out_1[_e329] = _e306;
        remaining = 2i;
        let _e333 = value;
        partial = _e333;
        loop {
            let _e335 = remaining;
            if (_e335 > 0i) {
            } else {
                break;
            }
            {
                let _e338 = partial;
                let _e339 = remaining;
                next = (_e338 + _e339);
                let _e342 = next;
                partial = _e342;
                let _e343 = remaining;
                remaining = (_e343 - 1i);
            }
        }
        let _e346 = partial;
        let _e347 = out;
        local_18 = _e347;
        let _e349 = base;
        local_19 = u32((_e349 + 8u));
        let _e354 = local_18;
        local_55 = _e354;
        let _e356 = local_19;
        let _e358 = local_55[1];
        local_55[1] = (_e358 + _e356);
        let _e362 = local_55[0];
        local_56 = u32(_e362);
        let _e366 = local_55[1];
        local_57 = u32(_e366);
        let _e369 = local_57;
        out_1[_e369] = _e346;
        let _e371 = value;
        shadow = _e371;
        {
            let _e373 = value;
            shadow_1 = (_e373 + 10i);
            let _e377 = shadow_1;
            let _e378 = out;
            local_20 = _e378;
            let _e380 = base;
            local_21 = u32((_e380 + 9u));
            let _e385 = local_20;
            local_58 = _e385;
            let _e387 = local_21;
            let _e389 = local_58[1];
            local_58[1] = (_e389 + _e387);
            let _e393 = local_58[0];
            local_59 = u32(_e393);
            let _e397 = local_58[1];
            local_60 = u32(_e397);
            let _e400 = local_60;
            out_1[_e400] = _e377;
        }
        let _e402 = shadow;
        let _e403 = out;
        local_22 = _e403;
        let _e405 = base;
        local_23 = u32((_e405 + 10u));
        let _e410 = local_22;
        local_61 = _e410;
        let _e412 = local_23;
        let _e414 = local_61[1];
        local_61[1] = (_e414 + _e412);
        let _e418 = local_61[0];
        local_62 = u32(_e418);
        let _e422 = local_61[1];
        local_63 = u32(_e422);
        let _e425 = local_63;
        out_1[_e425] = _e402;
        let _e427 = value;
        let _e429 = scaled(f32(_e427));
        let _e430 = out;
        local_24 = _e430;
        let _e432 = base;
        local_25 = u32((_e432 + 11u));
        let _e438 = local_24;
        local_64 = _e438;
        let _e440 = local_25;
        let _e442 = local_64[1];
        local_64[1] = (_e442 + _e440);
        let _e446 = local_64[0];
        local_65 = u32(_e446);
        let _e450 = local_64[1];
        local_66 = u32(_e450);
        let _e453 = local_66;
        out_1[_e453] = i32(_e429);
    }
}
