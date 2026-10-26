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
    var local: u32;
    var local_1: u32;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var chosen: i32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var weighted: f32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var negative: bool;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var magnitude: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var total: i32;
    var iteration: i32;
    var copied: i32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var descending: i32;
    var iteration_1: i32;
    var staged: i32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var remaining: i32;
    var partial: i32;
    var next: i32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var shadow: i32;
    var shadow_1: i32;
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
    var local_42: i32;
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

    local = 0u;
    local_1 = 0u;
    let _e8 = n_1.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e16 = i;
    let _e17 = n;
    if (_e16 < _e17) {
        let _e19 = i;
        base = (_e19 * 12u);
        let _e23 = local_1;
        local_2 = _e23;
        let _e25 = local_2;
        local_3 = u32(_e25);
        let _e28 = i;
        local_4 = u32(_e28);
        let _e32 = local_3;
        let _e33 = local_4;
        local_41 = u32((_e32 + _e33));
        let _e38 = local_41;
        let _e40 = input[_e38];
        local_42 = _e40;
        let _e41 = local_42;
        value = _e41;
        let _e43 = i;
        if ((_e43 % 2u) == 0u) {
            let _e48 = value;
            chosen = (_e48 + 7i);
        } else {
            let _e52 = value;
            chosen = (_e52 - 4i);
        }
        let _e57 = chosen;
        let _e58 = local;
        local_5 = _e58;
        let _e60 = local_5;
        local_6 = u32(_e60);
        let _e63 = base;
        local_7 = u32(_e63);
        let _e67 = local_6;
        let _e68 = local_7;
        local_43 = u32((_e67 + _e68));
        let _e72 = local_43;
        out[_e72] = _e57;
        let _e74 = value;
        let _e75 = i;
        let _e80 = select_value(_e74, ((_e75 % 3u) == 0u));
        let _e81 = local;
        local_8 = _e81;
        let _e83 = local_8;
        local_9 = u32(_e83);
        let _e86 = base;
        local_10 = u32((_e86 + 1u));
        let _e91 = local_9;
        let _e92 = local_10;
        local_44 = u32((_e91 + _e92));
        let _e96 = local_44;
        out[_e96] = _e80;
        let _e98 = value;
        weighted = ((f32(_e98) * 1.5f) + 2f);
        let _e105 = weighted;
        let _e107 = local;
        local_11 = _e107;
        let _e109 = local_11;
        local_12 = u32(_e109);
        let _e112 = base;
        local_13 = u32((_e112 + 2u));
        let _e117 = local_12;
        let _e118 = local_13;
        local_45 = u32((_e117 + _e118));
        let _e122 = local_45;
        out[_e122] = i32(_e105);
        let _e124 = value;
        negative = (_e124 < 0i);
        let _e128 = negative;
        let _e129 = local;
        local_14 = _e129;
        let _e131 = local_14;
        local_15 = u32(_e131);
        let _e134 = base;
        local_16 = u32((_e134 + 3u));
        let _e140 = local_15;
        let _e141 = local_16;
        local_46 = u32((_e140 + _e141));
        let _e145 = local_46;
        out[_e145] = i32(_e128);
        let _e147 = value;
        magnitude = u32((_e147 + 5i));
        let _e152 = magnitude;
        let _e155 = local;
        local_17 = _e155;
        let _e157 = local_17;
        local_18 = u32(_e157);
        let _e160 = base;
        local_19 = u32((_e160 + 4u));
        let _e166 = local_18;
        let _e167 = local_19;
        local_47 = u32((_e166 + _e167));
        let _e171 = local_47;
        out[_e171] = i32((_e152 * 3u));
        let _e173 = i;
        let _e176 = accumulate((_e173 % 5u));
        let _e177 = local;
        local_20 = _e177;
        let _e179 = local_20;
        local_21 = u32(_e179);
        let _e182 = base;
        local_22 = u32((_e182 + 5u));
        let _e188 = local_21;
        let _e189 = local_22;
        local_48 = u32((_e188 + _e189));
        let _e193 = local_48;
        out[_e193] = i32(_e176);
        total = 0i;
        {
            iteration = 0i;
            loop {
                let _e199 = iteration;
                if (_e199 < 3i) {
                } else {
                    break;
                }
                let _e202 = value;
                let _e203 = iteration;
                copied = (_e202 + _e203);
                let _e206 = copied;
                let _e207 = total;
                total = (_e207 + _e206);
                continuing {
                    let _e209 = iteration;
                    iteration = (_e209 + 1i);
                }
            }
        }
        let _e212 = total;
        let _e213 = local;
        local_23 = _e213;
        let _e215 = local_23;
        local_24 = u32(_e215);
        let _e218 = base;
        local_25 = u32((_e218 + 6u));
        let _e223 = local_24;
        let _e224 = local_25;
        local_49 = u32((_e223 + _e224));
        let _e228 = local_49;
        out[_e228] = _e212;
        descending = 0i;
        iteration_1 = 0i;
        {
            loop {
                let _e234 = iteration_1;
                if (_e234 < 3i) {
                } else {
                    break;
                }
                let _e237 = value;
                let _e238 = iteration_1;
                staged = (_e237 - _e238);
                let _e241 = staged;
                let _e242 = descending;
                descending = (_e242 + _e241);
                continuing {
                    let _e244 = iteration_1;
                    iteration_1 = (_e244 + 1i);
                }
            }
        }
        let _e247 = descending;
        let _e248 = local;
        local_26 = _e248;
        let _e250 = local_26;
        local_27 = u32(_e250);
        let _e253 = base;
        local_28 = u32((_e253 + 7u));
        let _e258 = local_27;
        let _e259 = local_28;
        local_50 = u32((_e258 + _e259));
        let _e263 = local_50;
        out[_e263] = _e247;
        remaining = 2i;
        let _e267 = value;
        partial = _e267;
        loop {
            let _e269 = remaining;
            if (_e269 > 0i) {
            } else {
                break;
            }
            {
                let _e272 = partial;
                let _e273 = remaining;
                next = (_e272 + _e273);
                let _e276 = next;
                partial = _e276;
                let _e277 = remaining;
                remaining = (_e277 - 1i);
            }
        }
        let _e280 = partial;
        let _e281 = local;
        local_29 = _e281;
        let _e283 = local_29;
        local_30 = u32(_e283);
        let _e286 = base;
        local_31 = u32((_e286 + 8u));
        let _e291 = local_30;
        let _e292 = local_31;
        local_51 = u32((_e291 + _e292));
        let _e296 = local_51;
        out[_e296] = _e280;
        let _e298 = value;
        shadow = _e298;
        {
            let _e300 = value;
            shadow_1 = (_e300 + 10i);
            let _e304 = shadow_1;
            let _e305 = local;
            local_32 = _e305;
            let _e307 = local_32;
            local_33 = u32(_e307);
            let _e310 = base;
            local_34 = u32((_e310 + 9u));
            let _e315 = local_33;
            let _e316 = local_34;
            local_52 = u32((_e315 + _e316));
            let _e320 = local_52;
            out[_e320] = _e304;
        }
        let _e322 = shadow;
        let _e323 = local;
        local_35 = _e323;
        let _e325 = local_35;
        local_36 = u32(_e325);
        let _e328 = base;
        local_37 = u32((_e328 + 10u));
        let _e333 = local_36;
        let _e334 = local_37;
        local_53 = u32((_e333 + _e334));
        let _e338 = local_53;
        out[_e338] = _e322;
        let _e340 = value;
        let _e342 = scaled(f32(_e340));
        let _e343 = local;
        local_38 = _e343;
        let _e345 = local_38;
        local_39 = u32(_e345);
        let _e348 = base;
        local_40 = u32((_e348 + 11u));
        let _e354 = local_39;
        let _e355 = local_40;
        local_54 = u32((_e354 + _e355));
        let _e359 = local_54;
        out[_e359] = i32(_e342);
    }
}
