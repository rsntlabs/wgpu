@group(0) @binding(0)
var<storage> input: array<i32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_fabsf(input_bits: u32) -> u32 {
    let _e2 = (input_bits & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

@compute @workgroup_size(4, 1, 1)
fn inferred_conditions(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var cursor: i32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var header: i32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var state: i32;
    var local_10: u32;
    var fixed: i32;
    var pass_: i32;
    var skip: bool;
    var stop: bool;
    var local_11: u32;
    var nested: i32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var fraction: f32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var mutable_copy: i32;
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
    var local_28: u32;
    var local_29: u32;

    let lane = (threadIdx.x + (blockIdx.x * 4u));
    if (lane >= 4u) {
        return;
    }
    let base = (4u + (lane * 13u));
    cursor = 0i;
    let _e15 = cursor;
    cursor = (_e15 + 1i);
    local = u32((lane + u32(_e15)));
    let _e22 = local;
    let selected = input[_e22];
    if (selected != 0i) {
        local_1 = base;
        let _e32 = local_1;
        local_20 = _e32;
        let _e34 = local_20;
        output[_e34] = u32((selected + 100i));
    } else {
        local_2 = base;
        let _e41 = local_2;
        local_21 = _e41;
        let _e43 = local_21;
        output[_e43] = u32((selected + 200i));
    }
    let _e46 = cursor;
    local_3 = u32((base + 1u));
    let _e52 = local_3;
    output[_e52] = u32(_e46);
    header = 50i;
    let header_1 = input[lane];
    if (header_1 != 0i) {
        local_4 = u32((base + 2u));
        let _e68 = local_4;
        local_22 = _e68;
        let _e70 = local_22;
        output[_e70] = u32((header_1 + 300i));
    } else {
        local_5 = u32((base + 2u));
        let _e79 = local_5;
        local_23 = _e79;
        let _e81 = local_23;
        output[_e81] = u32((header_1 + 400i));
    }
    let _e83 = header;
    local_6 = u32((base + 3u));
    let _e89 = local_6;
    output[_e89] = u32(_e83);
    local_7 = u32((lane + 4u));
    let _e95 = local_7;
    let seed = input[_e95];
    let ready = (seed > 0i);
    if ready {
        local_8 = u32((base + 4u));
        let _e107 = local_8;
        local_24 = _e107;
        let _e109 = local_24;
        output[_e109] = u32((seed + 500i));
    } else {
        local_9 = u32((base + 4u));
        let _e118 = local_9;
        local_25 = _e118;
        let _e120 = local_25;
        output[_e120] = u32((seed + 600i));
    }
    state = 0i;
    let _e124 = cursor;
    cursor = (_e124 + 1i);
    let mode = (lane % 3u);
    switch mode {
        case 0u: {
            let _e129 = state;
            state = (_e129 + 10i);
            break;
        }
        case 1u: {
            let _e132 = state;
            state = (_e132 + 20i);
            let _e135 = state;
            state = (_e135 + 30i);
            break;
        }
        default: {
            let _e138 = state;
            state = (_e138 + 30i);
            break;
        }
    }
    let _e141 = state;
    local_10 = u32((base + 5u));
    let _e147 = local_10;
    output[_e147] = u32(_e141);
    fixed = 2i;
    let _e151 = fixed;
    switch _e151 {
        case 2: {
            let _e152 = state;
            state = (_e152 + 7i);
            break;
        }
        default: {
        }
    }
    {
        pass_ = 0i;
        loop {
            let _e157 = pass_;
            if (_e157 < 4i) {
            } else {
                break;
            }
            let _e160 = pass_;
            skip = (_e160 == 1i);
            let _e164 = skip;
            if _e164 {
                continue;
            }
            let _e165 = pass_;
            stop = (_e165 == 3i);
            let _e169 = stop;
            if _e169 {
                break;
            }
            let _e170 = pass_;
            let _e173 = state;
            state = (_e173 + (_e170 + 1i));
            continuing {
                let _e175 = pass_;
                pass_ = (_e175 + 1i);
            }
        }
    }
    let _e178 = state;
    local_11 = u32((base + 6u));
    let _e184 = local_11;
    output[_e184] = u32(_e178);
    let nested_1 = input[lane];
    if (nested_1 != 0i) {
        {
            nested = 9i;
            let _e192 = nested;
            let _e193 = state;
            state = (_e193 + _e192);
        }
        local_12 = u32((base + 7u));
        let _e202 = local_12;
        local_26 = _e202;
        let _e204 = local_26;
        output[_e204] = u32((nested_1 + 700i));
    } else {
        local_13 = u32((base + 7u));
        let _e210 = local_13;
        local_27 = _e210;
        let _e212 = local_27;
        output[_e212] = 800u;
    }
    let _e215 = state;
    local_14 = u32((base + 8u));
    let _e221 = local_14;
    output[_e221] = u32(_e215);
    fraction = 0.5f;
    let _e225 = fraction;
    let _e227 = gen__naga_fabsf(bitcast<u32>(_e225));
    if (_e227 != 0u) {
        let _e230 = state;
        state = (_e230 + 1i);
    }
    let _e233 = state;
    local_15 = u32((base + 9u));
    let _e239 = local_15;
    output[_e239] = u32(_e233);
    let _e242 = input[lane];
    if (_e242 != 0i) {
        let _e245 = state;
        state = (_e245 + 1i);
    }
    let _e248 = state;
    local_16 = u32((base + 10u));
    let _e254 = local_16;
    output[_e254] = u32(_e248);
    let _e256 = cursor;
    local_17 = u32((base + 11u));
    let _e262 = local_17;
    output[_e262] = u32(_e256);
    let original = input[lane];
    mutable_copy = original;
    let _e267 = mutable_copy;
    if (_e267 != 0i) {
        let _e270 = mutable_copy;
        mutable_copy = (_e270 + 1i);
        let _e273 = mutable_copy;
        local_18 = u32((base + 12u));
        let _e281 = local_18;
        local_28 = _e281;
        let _e283 = local_28;
        output[_e283] = u32((_e273 + 900i));
    } else {
        mutable_copy = 3i;
        let _e286 = mutable_copy;
        local_19 = u32((base + 12u));
        let _e294 = local_19;
        local_29 = _e294;
        let _e296 = local_29;
        output[_e296] = u32((_e286 + 900i));
    }
}
