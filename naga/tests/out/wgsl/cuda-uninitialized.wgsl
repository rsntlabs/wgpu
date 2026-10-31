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
        local = u32(i_1);
        let _e16 = local;
        local_14 = u32(_e16);
        let _e19 = local_14;
        let _e22 = input[_e19];
        local_15 = _e22;
        let _e24 = local_15;
        local_13 = _e24;
        let _e26 = local_13;
        value = _e26;
        if ((i_1 % 2u) == 0u) {
            let _e32 = value;
            chosen = (_e32 + 7i);
        } else {
            let _e36 = value;
            chosen = (_e36 - 4i);
        }
        let _e41 = chosen;
        let _e42 = base;
        local_1 = u32(_e42);
        let _e45 = local_1;
        local_16 = u32(_e45);
        let _e48 = local_16;
        out[_e48] = _e41;
        let _e51 = value;
        let _e56 = select_value(_e51, ((i_1 % 3u) == 0u));
        let _e57 = base;
        local_2 = u32((_e57 + 1u));
        let _e62 = local_2;
        local_17 = u32(_e62);
        let _e65 = local_17;
        out[_e65] = _e56;
        let _e67 = value;
        weighted = ((f32(_e67) * 1.5f) + 2f);
        let _e74 = weighted;
        let _e76 = base;
        local_3 = u32((_e76 + 2u));
        let _e81 = local_3;
        local_18 = u32(_e81);
        let _e84 = local_18;
        out[_e84] = i32(_e74);
        let _e86 = value;
        negative = (_e86 < 0i);
        let _e90 = negative;
        let _e91 = base;
        local_4 = u32((_e91 + 3u));
        let _e97 = local_4;
        local_19 = u32(_e97);
        let _e100 = local_19;
        out[_e100] = i32(_e90);
        let _e102 = value;
        magnitude = u32((_e102 + 5i));
        let _e107 = magnitude;
        let _e110 = base;
        local_5 = u32((_e110 + 4u));
        let _e116 = local_5;
        local_20 = u32(_e116);
        let _e119 = local_20;
        out[_e119] = i32((_e107 * 3u));
        let _e123 = accumulate((i_1 % 5u));
        let _e124 = base;
        local_6 = u32((_e124 + 5u));
        let _e130 = local_6;
        local_21 = u32(_e130);
        let _e133 = local_21;
        out[_e133] = i32(_e123);
        total = 0i;
        {
            iteration = 0i;
            loop {
                let _e139 = iteration;
                if (_e139 < 3i) {
                } else {
                    break;
                }
                let _e142 = value;
                let _e143 = iteration;
                copied = (_e142 + _e143);
                let _e146 = copied;
                let _e147 = total;
                total = (_e147 + _e146);
                continuing {
                    let _e149 = iteration;
                    iteration = (_e149 + 1i);
                }
            }
        }
        let _e152 = total;
        let _e153 = base;
        local_7 = u32((_e153 + 6u));
        let _e158 = local_7;
        local_22 = u32(_e158);
        let _e161 = local_22;
        out[_e161] = _e152;
        descending = 0i;
        iteration_1 = 0i;
        {
            loop {
                let _e167 = iteration_1;
                if (_e167 < 3i) {
                } else {
                    break;
                }
                let _e170 = value;
                let _e171 = iteration_1;
                staged = (_e170 - _e171);
                let _e174 = staged;
                let _e175 = descending;
                descending = (_e175 + _e174);
                continuing {
                    let _e177 = iteration_1;
                    iteration_1 = (_e177 + 1i);
                }
            }
        }
        let _e180 = descending;
        let _e181 = base;
        local_8 = u32((_e181 + 7u));
        let _e186 = local_8;
        local_23 = u32(_e186);
        let _e189 = local_23;
        out[_e189] = _e180;
        remaining = 2i;
        let _e193 = value;
        partial = _e193;
        loop {
            let _e195 = remaining;
            if (_e195 > 0i) {
            } else {
                break;
            }
            {
                let _e198 = partial;
                let _e199 = remaining;
                next = (_e198 + _e199);
                let _e202 = next;
                partial = _e202;
                let _e203 = remaining;
                remaining = (_e203 - 1i);
            }
        }
        let _e206 = partial;
        let _e207 = base;
        local_9 = u32((_e207 + 8u));
        let _e212 = local_9;
        local_24 = u32(_e212);
        let _e215 = local_24;
        out[_e215] = _e206;
        let _e217 = value;
        shadow = _e217;
        {
            let _e219 = value;
            shadow_1 = (_e219 + 10i);
            let _e223 = shadow_1;
            let _e224 = base;
            local_10 = u32((_e224 + 9u));
            let _e229 = local_10;
            local_25 = u32(_e229);
            let _e232 = local_25;
            out[_e232] = _e223;
        }
        let _e234 = shadow;
        let _e235 = base;
        local_11 = u32((_e235 + 10u));
        let _e240 = local_11;
        local_26 = u32(_e240);
        let _e243 = local_26;
        out[_e243] = _e234;
        let _e245 = value;
        let _e247 = scaled(f32(_e245));
        let _e248 = base;
        local_12 = u32((_e248 + 11u));
        let _e254 = local_12;
        local_27 = u32(_e254);
        let _e257 = local_27;
        out[_e257] = i32(_e247);
    }
}
