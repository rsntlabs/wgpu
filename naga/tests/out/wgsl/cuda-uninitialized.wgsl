struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
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
    var base: u32;
    var value: i32;
    var local: u32;
    var chosen: i32;
    var local_1: u32;
    var local_2: u32;
    var weighted: f32;
    var local_3: u32;
    var negative: bool;
    var local_4: u32;
    var magnitude: u32;
    var local_5: u32;
    var local_6: u32;
    var total: i32;
    var iteration: i32;
    var copied: i32;
    var local_7: u32;
    var descending: i32;
    var iteration_1: i32;
    var staged: i32;
    var local_8: u32;
    var remaining: i32;
    var partial: i32;
    var next: i32;
    var local_9: u32;
    var shadow: i32;
    var shadow_1: i32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: i32;
    var local_14: u32;
    var local_15: i32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;

    let n_1 = n.value;
    let i_1 = ((blockIdx.x * 64u) + threadIdx.x);
    if (i_1 < n_1) {
        base = (i_1 * 12u);
        local = i_1;
        let _e15 = local;
        local_14 = _e15;
        let _e17 = local_14;
        let _e20 = input[_e17];
        local_15 = _e20;
        let _e22 = local_15;
        local_13 = _e22;
        let _e24 = local_13;
        value = _e24;
        if ((i_1 % 2u) == 0u) {
            let _e30 = value;
            chosen = (_e30 + 7i);
        } else {
            let _e34 = value;
            chosen = (_e34 - 4i);
        }
        let _e39 = chosen;
        let _e40 = base;
        local_1 = _e40;
        let _e42 = local_1;
        local_16 = _e42;
        let _e44 = local_16;
        out[_e44] = _e39;
        let _e47 = value;
        let _e52 = select_value(_e47, ((i_1 % 3u) == 0u));
        let _e53 = base;
        local_2 = u32((_e53 + 1u));
        let _e58 = local_2;
        local_17 = _e58;
        let _e60 = local_17;
        out[_e60] = _e52;
        let _e62 = value;
        weighted = ((f32(_e62) * 1.5f) + 2f);
        let _e69 = weighted;
        let _e71 = base;
        local_3 = u32((_e71 + 2u));
        let _e76 = local_3;
        local_18 = _e76;
        let _e78 = local_18;
        out[_e78] = i32(_e69);
        let _e80 = value;
        negative = (_e80 < 0i);
        let _e84 = negative;
        let _e85 = base;
        local_4 = u32((_e85 + 3u));
        let _e91 = local_4;
        local_19 = _e91;
        let _e93 = local_19;
        out[_e93] = i32(_e84);
        let _e95 = value;
        magnitude = u32((_e95 + 5i));
        let _e100 = magnitude;
        let _e103 = base;
        local_5 = u32((_e103 + 4u));
        let _e109 = local_5;
        local_20 = _e109;
        let _e111 = local_20;
        out[_e111] = i32((_e100 * 3u));
        let _e115 = accumulate((i_1 % 5u));
        let _e116 = base;
        local_6 = u32((_e116 + 5u));
        let _e122 = local_6;
        local_21 = _e122;
        let _e124 = local_21;
        out[_e124] = i32(_e115);
        total = 0i;
        {
            iteration = 0i;
            loop {
                let _e130 = iteration;
                if (_e130 < 3i) {
                } else {
                    break;
                }
                let _e133 = value;
                let _e134 = iteration;
                copied = (_e133 + _e134);
                let _e137 = copied;
                let _e138 = total;
                total = (_e138 + _e137);
                continuing {
                    let _e140 = iteration;
                    iteration = (_e140 + 1i);
                }
            }
        }
        let _e143 = total;
        let _e144 = base;
        local_7 = u32((_e144 + 6u));
        let _e149 = local_7;
        local_22 = _e149;
        let _e151 = local_22;
        out[_e151] = _e143;
        descending = 0i;
        iteration_1 = 0i;
        {
            loop {
                let _e157 = iteration_1;
                if (_e157 < 3i) {
                } else {
                    break;
                }
                let _e160 = value;
                let _e161 = iteration_1;
                staged = (_e160 - _e161);
                let _e164 = staged;
                let _e165 = descending;
                descending = (_e165 + _e164);
                continuing {
                    let _e167 = iteration_1;
                    iteration_1 = (_e167 + 1i);
                }
            }
        }
        let _e170 = descending;
        let _e171 = base;
        local_8 = u32((_e171 + 7u));
        let _e176 = local_8;
        local_23 = _e176;
        let _e178 = local_23;
        out[_e178] = _e170;
        remaining = 2i;
        let _e182 = value;
        partial = _e182;
        loop {
            let _e184 = remaining;
            if (_e184 > 0i) {
            } else {
                break;
            }
            {
                let _e187 = partial;
                let _e188 = remaining;
                next = (_e187 + _e188);
                let _e191 = next;
                partial = _e191;
                let _e192 = remaining;
                remaining = (_e192 - 1i);
            }
        }
        let _e195 = partial;
        let _e196 = base;
        local_9 = u32((_e196 + 8u));
        let _e201 = local_9;
        local_24 = _e201;
        let _e203 = local_24;
        out[_e203] = _e195;
        let _e205 = value;
        shadow = _e205;
        {
            let _e207 = value;
            shadow_1 = (_e207 + 10i);
            let _e211 = shadow_1;
            let _e212 = base;
            local_10 = u32((_e212 + 9u));
            let _e217 = local_10;
            local_25 = _e217;
            let _e219 = local_25;
            out[_e219] = _e211;
        }
        let _e221 = shadow;
        let _e222 = base;
        local_11 = u32((_e222 + 10u));
        let _e227 = local_11;
        local_26 = _e227;
        let _e229 = local_26;
        out[_e229] = _e221;
        let _e231 = value;
        let _e233 = scaled(f32(_e231));
        let _e234 = base;
        local_12 = u32((_e234 + 11u));
        let _e240 = local_12;
        local_27 = _e240;
        let _e242 = local_27;
        out[_e242] = i32(_e233);
    }
}
