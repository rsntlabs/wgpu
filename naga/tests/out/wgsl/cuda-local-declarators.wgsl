struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
@group(0) @binding(2)
var<uniform> n: type_3;

fn cached_type(value_1: i32) -> i32 {
    let next = (value_1 + 1i);
    let result = (next * 2i);
    return result;
}

fn pair_add(left: i32, right: i32) -> i32 {
    return (left + right);
}

@compute @workgroup_size(64, 1, 1)
fn local_declarators(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var base: u32;
    var value: i32;
    var local: u32;
    var first: i32;
    var second: i32;
    var third: i32;
    var local_1: u32;
    var local_2: u32;
    var omitted: i32;
    var initialized: i32;
    var final_: i32;
    var local_3: u32;
    var fixed: i32;
    var fixed_next: i32;
    var local_4: u32;
    var alias_first: i32;
    var alias_next: i32;
    var local_5: u32;
    var positive: bool;
    var same: bool;
    var local_6: bool;
    var local_7: u32;
    var local_8: u32;
    var low: f32;
    var high: f32;
    var local_9: u32;
    var start: u32;
    var finish: u32;
    var local_10: u32;
    var local_11: u32;
    var outside: i32;
    var outside_1: i32;
    var derived: i32;
    var local_12: u32;
    var total: i32;
    var iteration: i32;
    var seed: i32;
    var term: i32;
    var copied: i32;
    var local_13: u32;
    var from_call: i32;
    var from_prior: i32;
    var local_14: u32;
    var local_15: i32;
    var local_16: i32;
    var local_17: u32;
    var local_18: i32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: i32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;

    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 12u);
        local = i;
        let _e15 = local;
        local_17 = _e15;
        let _e17 = local_17;
        let _e20 = input[_e17];
        local_18 = _e20;
        let _e22 = local_18;
        local_15 = _e22;
        let _e24 = local_15;
        value = _e24;
        let _e26 = value;
        value = (_e26 + 1i);
        first = _e26;
        let _e30 = value;
        value = (_e30 + 1i);
        second = _e30;
        let _e34 = value;
        third = _e34;
        let _e36 = first;
        let _e39 = second;
        let _e43 = third;
        let _e45 = base;
        local_1 = _e45;
        let _e47 = local_1;
        local_19 = _e47;
        let _e49 = local_19;
        out[_e49] = (((_e36 * 100i) + (_e39 * 10i)) + _e43);
        let _e52 = value;
        let _e53 = base;
        local_2 = u32((_e53 + 1u));
        let _e58 = local_2;
        local_20 = _e58;
        let _e60 = local_20;
        out[_e60] = _e52;
        let _e62 = value;
        initialized = (_e62 + 3i);
        let _e66 = initialized;
        omitted = (_e66 + 2i);
        let _e70 = omitted;
        let _e71 = initialized;
        final_ = (_e70 + _e71);
        let _e74 = final_;
        let _e75 = base;
        local_3 = u32((_e75 + 2u));
        let _e80 = local_3;
        local_21 = _e80;
        let _e82 = local_21;
        out[_e82] = _e74;
        let _e84 = value;
        fixed = (_e84 + 1i);
        let _e88 = fixed;
        fixed_next = (_e88 + 2i);
        let _e92 = fixed_next;
        let _e93 = base;
        local_4 = u32((_e93 + 3u));
        let _e98 = local_4;
        local_22 = _e98;
        let _e100 = local_22;
        out[_e100] = _e92;
        let _e102 = value;
        alias_first = (_e102 + 4i);
        let _e106 = alias_first;
        alias_next = (_e106 + 1i);
        let _e110 = alias_next;
        let _e111 = base;
        local_5 = u32((_e111 + 4u));
        let _e116 = local_5;
        local_23 = _e116;
        let _e118 = local_23;
        out[_e118] = _e110;
        let _e120 = value;
        positive = (_e120 > 0i);
        let _e124 = positive;
        local_6 = _e124;
        if _e124 {
            local_7 = i;
            let _e127 = local_7;
            local_24 = _e127;
            let _e129 = local_24;
            let _e131 = input[_e129];
            local_25 = _e131;
            let _e133 = local_25;
            local_16 = _e133;
            let _e135 = local_16;
            let _e138 = value;
            local_6 = (_e138 == (_e135 + 2i));
        }
        let _e140 = local_6;
        same = _e140;
        let _e142 = same;
        let _e143 = base;
        local_8 = u32((_e143 + 5u));
        let _e149 = local_8;
        local_26 = _e149;
        let _e151 = local_26;
        out[_e151] = i32(_e142);
        let _e153 = value;
        low = (f32(_e153) * 0.5f);
        let _e158 = low;
        high = (_e158 + 1.5f);
        let _e162 = high;
        let _e166 = base;
        local_9 = u32((_e166 + 6u));
        let _e171 = local_9;
        local_27 = _e171;
        let _e173 = local_27;
        out[_e173] = i32((_e162 * 2f));
        start = (i % 5u);
        let _e178 = start;
        finish = (_e178 + 3u);
        let _e182 = finish;
        let _e183 = base;
        local_10 = u32((_e183 + 7u));
        let _e189 = local_10;
        local_28 = _e189;
        let _e191 = local_28;
        out[_e191] = i32(_e182);
        let _e193 = value;
        let _e194 = cached_type(_e193);
        let _e195 = base;
        local_11 = u32((_e195 + 8u));
        let _e200 = local_11;
        local_29 = _e200;
        let _e202 = local_29;
        out[_e202] = _e194;
        let _e204 = value;
        outside = _e204;
        {
            let _e206 = value;
            outside_1 = (_e206 + 5i);
            let _e210 = outside_1;
            derived = (_e210 + 2i);
            let _e214 = derived;
            let _e215 = base;
            local_12 = u32((_e215 + 9u));
            let _e220 = local_12;
            local_30 = _e220;
            let _e222 = local_30;
            out[_e222] = _e214;
        }
        total = 0i;
        {
            iteration = 0i;
            let _e228 = value;
            seed = _e228;
            loop {
                let _e230 = iteration;
                if (_e230 < 4i) {
                } else {
                    break;
                }
                let _e233 = iteration;
                if (_e233 == 1i) {
                    continue;
                }
                let _e236 = seed;
                let _e237 = iteration;
                term = (_e236 + _e237);
                let _e240 = term;
                copied = _e240;
                let _e242 = copied;
                let _e243 = total;
                total = (_e243 + _e242);
                continuing {
                    let _e245 = iteration;
                    iteration = (_e245 + 1i);
                }
            }
        }
        let _e248 = total;
        let _e249 = base;
        local_13 = u32((_e249 + 10u));
        let _e254 = local_13;
        local_31 = _e254;
        let _e256 = local_31;
        out[_e256] = _e248;
        let _e258 = value;
        let _e260 = pair_add(_e258, 2i);
        from_call = _e260;
        let _e262 = from_call;
        let _e264 = pair_add(_e262, 3i);
        from_prior = _e264;
        let _e266 = from_prior;
        let _e267 = outside;
        let _e269 = base;
        local_14 = u32((_e269 + 11u));
        let _e274 = local_14;
        local_32 = _e274;
        let _e276 = local_32;
        out[_e276] = (_e266 + _e267);
    }
}
