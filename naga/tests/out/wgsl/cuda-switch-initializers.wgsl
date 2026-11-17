@group(0) @binding(0)
var<storage> input: array<i32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

@compute @workgroup_size(4, 1, 1)
fn switch_initializers(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var state: i32;
    var local: u32;
    var bias: i32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var key: i32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var key_1: i32;
    var local_9: u32;
    var local_10: u32;
    var One: i32;
    var local_11: u32;
    var pass_: i32;
    var selected: i32;
    var local_12: u32;
    var counter: i32;
    var local_13: u32;
    var local_14: u32;
    var inner: i32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;

    let lane = threadIdx.x;
    let base = (4u + (lane * 16u));
    let seed = input[lane];
    state = (i32(lane) + 1i);
    switch seed {
        case 0: {
            let _e13 = state;
            state = (_e13 + 1i);
            break;
        }
        default: {
            let _e16 = state;
            state = (_e16 + 2i);
        }
    }
    let _e19 = state;
    output[base] = u32(_e19);
    let _e23 = state;
    state = (_e23 + 1i);
    switch seed {
        case 0: {
            let _e26 = state;
            state = (_e26 + 10i);
            break;
        }
        case 1: {
            let _e29 = state;
            state = (_e29 + 20i);
            let _e32 = state;
            state = (_e32 + 30i);
            break;
        }
        case 2: {
            let _e35 = state;
            state = (_e35 + 30i);
            break;
        }
        default: {
            let _e38 = state;
            state = (_e38 + 40i);
        }
    }
    let _e41 = state;
    local = u32((base + 1u));
    let _e47 = local;
    output[_e47] = u32(_e41);
    bias = 5i;
    switch seed {
        case 0: {
            let _e51 = bias;
            local_1 = u32((base + 2u));
            let _e57 = local_1;
            local_18 = _e57;
            let _e59 = local_18;
            output[_e59] = u32(_e51);
            break;
        }
        case 1: {
            let _e61 = bias;
            local_2 = u32((base + 2u));
            let _e68 = local_2;
            local_19 = _e68;
            let _e70 = local_19;
            output[_e70] = u32((_e61 + seed));
            break;
        }
        default: {
            let _e72 = bias;
            local_3 = u32((base + 2u));
            let _e79 = local_3;
            local_20 = _e79;
            let _e81 = local_20;
            output[_e81] = u32((_e72 + seed));
        }
    }
    let key_2 = (seed + 1i);
    switch key_2 {
        case 1: {
            let _e85 = state;
            state = (_e85 + 3i);
            break;
        }
        default: {
            let _e88 = state;
            state = (_e88 + 4i);
        }
    }
    let _e91 = state;
    local_4 = u32((base + 3u));
    let _e97 = local_4;
    output[_e97] = u32(_e91);
    let _e99 = state;
    switch _e99 {
        default: {
            let _e100 = state;
            state = (_e100 + 7i);
        }
    }
    let _e103 = state;
    local_5 = u32((base + 4u));
    let _e109 = local_5;
    output[_e109] = u32(_e103);
    key = 99i;
    switch seed {
        case 0: {
            local_6 = u32((base + 5u));
            let _e120 = local_6;
            local_21 = _e120;
            let _e122 = local_21;
            output[_e122] = u32((seed + 10i));
            break;
        }
        default: {
            local_7 = u32((base + 5u));
            let _e131 = local_7;
            local_22 = _e131;
            let _e133 = local_22;
            output[_e133] = u32((seed + 20i));
        }
    }
    let _e135 = key;
    local_8 = u32((base + 6u));
    let _e141 = local_8;
    output[_e141] = u32(_e135);
    switch seed {
        default: {
            {
                {
                    key_1 = 9i;
                    let _e145 = key_1;
                    let _e146 = state;
                    state = (_e146 + _e145);
                }
                local_9 = u32((base + 7u));
                let _e155 = local_9;
                local_23 = _e155;
                let _e157 = local_23;
                output[_e157] = u32((seed + 30i));
            }
        }
    }
    let _e159 = state;
    local_10 = u32((base + 8u));
    let _e165 = local_10;
    output[_e165] = u32(_e159);
    One = 1i;
    switch seed {
        case 1: {
            let _e169 = state;
            state = (_e169 + 1i);
            break;
        }
        default: {
            let _e172 = state;
            state = (_e172 + 2i);
        }
    }
    let _e175 = state;
    local_11 = u32((base + 9u));
    let _e181 = local_11;
    output[_e181] = u32(_e175);
    {
        pass_ = 0i;
        loop {
            let _e185 = pass_;
            if (_e185 < 4i) {
            } else {
                break;
            }
            let _e188 = pass_;
            selected = _e188;
            let _e190 = selected;
            switch _e190 {
                case 1: {
                    continue;
                }
                case 2: {
                    let _e191 = state;
                    state = (_e191 + 10i);
                    break;
                }
                default: {
                    let _e194 = state;
                    state = (_e194 + 1i);
                }
            }
            let _e197 = state;
            state = (_e197 + 2i);
            continuing {
                let _e200 = pass_;
                pass_ = (_e200 + 1i);
            }
        }
    }
    let _e203 = state;
    local_12 = u32((base + 10u));
    let _e209 = local_12;
    output[_e209] = u32(_e203);
    counter = 0i;
    let _e213 = counter;
    counter = (_e213 + 1i);
    let _e216 = state;
    state = (_e216 + 2i);
    switch seed {
        default: {
            let _e219 = state;
            state = (_e219 + 3i);
        }
    }
    let _e222 = counter;
    local_13 = u32((base + 11u));
    let _e228 = local_13;
    output[_e228] = u32(_e222);
    let _e230 = state;
    local_14 = u32((base + 12u));
    let _e236 = local_14;
    output[_e236] = u32(_e230);
    switch seed {
        case 0: {
            inner = (seed + 1i);
            let _e241 = inner;
            switch _e241 {
                default: {
                    let _e242 = inner;
                    let _e243 = state;
                    state = (_e243 + _e242);
                }
            }
            break;
        }
        default: {
            let _e245 = state;
            state = (_e245 + 4i);
        }
    }
    let _e248 = state;
    local_15 = u32((base + 13u));
    let _e254 = local_15;
    output[_e254] = u32(_e248);
    local_16 = u32((base + 14u));
    let _e261 = local_16;
    output[_e261] = u32(seed);
    let _e263 = counter;
    local_17 = u32((base + 15u));
    let _e269 = local_17;
    output[_e269] = u32(_e263);
}
