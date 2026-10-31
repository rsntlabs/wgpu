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
        local = u32(i);
        let _e16 = local;
        local_17 = u32(_e16);
        let _e19 = local_17;
        let _e22 = input[_e19];
        local_18 = _e22;
        let _e24 = local_18;
        local_15 = _e24;
        let _e26 = local_15;
        value = _e26;
        let _e28 = value;
        value = (_e28 + 1i);
        first = _e28;
        let _e32 = value;
        value = (_e32 + 1i);
        second = _e32;
        let _e36 = value;
        third = _e36;
        let _e38 = first;
        let _e41 = second;
        let _e45 = third;
        let _e47 = base;
        local_1 = u32(_e47);
        let _e50 = local_1;
        local_19 = u32(_e50);
        let _e53 = local_19;
        out[_e53] = (((_e38 * 100i) + (_e41 * 10i)) + _e45);
        let _e56 = value;
        let _e57 = base;
        local_2 = u32((_e57 + 1u));
        let _e62 = local_2;
        local_20 = u32(_e62);
        let _e65 = local_20;
        out[_e65] = _e56;
        let _e67 = value;
        initialized = (_e67 + 3i);
        let _e71 = initialized;
        omitted = (_e71 + 2i);
        let _e75 = omitted;
        let _e76 = initialized;
        final_ = (_e75 + _e76);
        let _e79 = final_;
        let _e80 = base;
        local_3 = u32((_e80 + 2u));
        let _e85 = local_3;
        local_21 = u32(_e85);
        let _e88 = local_21;
        out[_e88] = _e79;
        let _e90 = value;
        fixed = (_e90 + 1i);
        let _e94 = fixed;
        fixed_next = (_e94 + 2i);
        let _e98 = fixed_next;
        let _e99 = base;
        local_4 = u32((_e99 + 3u));
        let _e104 = local_4;
        local_22 = u32(_e104);
        let _e107 = local_22;
        out[_e107] = _e98;
        let _e109 = value;
        alias_first = (_e109 + 4i);
        let _e113 = alias_first;
        alias_next = (_e113 + 1i);
        let _e117 = alias_next;
        let _e118 = base;
        local_5 = u32((_e118 + 4u));
        let _e123 = local_5;
        local_23 = u32(_e123);
        let _e126 = local_23;
        out[_e126] = _e117;
        let _e128 = value;
        positive = (_e128 > 0i);
        let _e132 = positive;
        local_6 = _e132;
        if _e132 {
            local_7 = u32(i);
            let _e136 = local_7;
            local_24 = u32(_e136);
            let _e139 = local_24;
            let _e141 = input[_e139];
            local_25 = _e141;
            let _e143 = local_25;
            local_16 = _e143;
            let _e145 = local_16;
            let _e148 = value;
            local_6 = (_e148 == (_e145 + 2i));
        }
        let _e150 = local_6;
        same = _e150;
        let _e152 = same;
        let _e153 = base;
        local_8 = u32((_e153 + 5u));
        let _e159 = local_8;
        local_26 = u32(_e159);
        let _e162 = local_26;
        out[_e162] = i32(_e152);
        let _e164 = value;
        low = (f32(_e164) * 0.5f);
        let _e169 = low;
        high = (_e169 + 1.5f);
        let _e173 = high;
        let _e177 = base;
        local_9 = u32((_e177 + 6u));
        let _e182 = local_9;
        local_27 = u32(_e182);
        let _e185 = local_27;
        out[_e185] = i32((_e173 * 2f));
        start = (i % 5u);
        let _e190 = start;
        finish = (_e190 + 3u);
        let _e194 = finish;
        let _e195 = base;
        local_10 = u32((_e195 + 7u));
        let _e201 = local_10;
        local_28 = u32(_e201);
        let _e204 = local_28;
        out[_e204] = i32(_e194);
        let _e206 = value;
        let _e207 = cached_type(_e206);
        let _e208 = base;
        local_11 = u32((_e208 + 8u));
        let _e213 = local_11;
        local_29 = u32(_e213);
        let _e216 = local_29;
        out[_e216] = _e207;
        let _e218 = value;
        outside = _e218;
        {
            let _e220 = value;
            outside_1 = (_e220 + 5i);
            let _e224 = outside_1;
            derived = (_e224 + 2i);
            let _e228 = derived;
            let _e229 = base;
            local_12 = u32((_e229 + 9u));
            let _e234 = local_12;
            local_30 = u32(_e234);
            let _e237 = local_30;
            out[_e237] = _e228;
        }
        total = 0i;
        {
            iteration = 0i;
            let _e243 = value;
            seed = _e243;
            loop {
                let _e245 = iteration;
                if (_e245 < 4i) {
                } else {
                    break;
                }
                let _e248 = iteration;
                if (_e248 == 1i) {
                    continue;
                }
                let _e251 = seed;
                let _e252 = iteration;
                term = (_e251 + _e252);
                let _e255 = term;
                copied = _e255;
                let _e257 = copied;
                let _e258 = total;
                total = (_e258 + _e257);
                continuing {
                    let _e260 = iteration;
                    iteration = (_e260 + 1i);
                }
            }
        }
        let _e263 = total;
        let _e264 = base;
        local_13 = u32((_e264 + 10u));
        let _e269 = local_13;
        local_31 = u32(_e269);
        let _e272 = local_31;
        out[_e272] = _e263;
        let _e274 = value;
        let _e276 = pair_add(_e274, 2i);
        from_call = _e276;
        let _e278 = from_call;
        let _e280 = pair_add(_e278, 3i);
        from_prior = _e280;
        let _e282 = from_prior;
        let _e283 = outside;
        let _e285 = base;
        local_14 = u32((_e285 + 11u));
        let _e290 = local_14;
        local_32 = u32(_e290);
        let _e293 = local_32;
        out[_e293] = (_e282 + _e283);
    }
}
