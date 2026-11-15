@group(0) @binding(0)
var<storage> input: array<i32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

@compute @workgroup_size(4, 1, 1)
fn if_initializers(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var state: i32;
    var local_1: u32;
    var index: i32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var header: i32;
    var local_8: u32;
    var header_1: i32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var header_2: i32;
    var local_12: u32;
    var local_13: u32;
    var pass_: i32;
    var selected: i32;
    var selected_1: i32;
    var local_14: u32;
    var local_15: u32;
    var read_: i32;
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
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;

    let lane = threadIdx.x;
    let base = (4u + (lane * 16u));
    let seed = input[lane];
    local = u32((lane + 4u));
    let _e13 = local;
    let other = input[_e13];
    state = (i32(lane) + 1i);
    if (seed > 0i) {
        let _e22 = state;
        state = (_e22 + 10i);
    } else {
        let _e25 = state;
        state = (_e25 + 20i);
    }
    let _e28 = state;
    output[base] = u32(_e28);
    let _e32 = state;
    state = (_e32 + 1i);
    if false {
        let _e36 = state;
        state = (_e36 + 99i);
    } else {
        let _e39 = state;
        local_1 = u32((base + 1u));
        let _e45 = local_1;
        local_21 = _e45;
        let _e47 = local_21;
        output[_e47] = u32(_e39);
    }
    index = 0i;
    let _e51 = index;
    index = (_e51 + 1i);
    let _e54 = state;
    state = (_e54 + 2i);
    if (seed < other) {
        let _e58 = state;
        state = (_e58 + 3i);
    } else {
        let _e61 = state;
        state = (_e61 + 5i);
    }
    let _e64 = index;
    local_2 = u32((base + 2u));
    let _e70 = local_2;
    output[_e70] = u32(_e64);
    let _e72 = state;
    local_3 = u32((base + 3u));
    let _e78 = local_3;
    output[_e78] = u32(_e72);
    if (seed < other) {
        local_4 = u32((base + 4u));
        let _e88 = local_4;
        local_22 = _e88;
        let _e90 = local_22;
        output[_e90] = u32((seed + 100i));
    } else {
        local_5 = u32((base + 4u));
        let _e99 = local_5;
        local_23 = _e99;
        let _e101 = local_23;
        output[_e101] = u32((other + 200i));
    }
    if true {
        local_6 = u32((base + 5u));
        let _e111 = local_6;
        local_24 = _e111;
        let _e113 = local_24;
        output[_e113] = u32((seed + 300i));
    }
    let _e115 = state;
    if (_e115 > 0i) {
        let _e118 = state;
        state = (_e118 + 7i);
    }
    let _e121 = state;
    local_7 = u32((base + 6u));
    let _e127 = local_7;
    output[_e127] = u32(_e121);
    header = 50i;
    if (seed > 0i) {
        local_8 = u32((base + 7u));
        let _e140 = local_8;
        local_25 = _e140;
        let _e142 = local_25;
        output[_e142] = u32((seed + 400i));
    } else {
        header_1 = other;
        let _e145 = header_1;
        if (_e145 > 0i) {
            let _e148 = header_1;
            local_9 = u32((base + 7u));
            let _e156 = local_9;
            local_26 = _e156;
            let _e158 = local_26;
            output[_e158] = u32((_e148 + 500i));
        } else {
            let _e160 = header_1;
            local_10 = u32((base + 7u));
            let _e168 = local_10;
            local_27 = _e168;
            let _e170 = local_27;
            output[_e170] = u32((_e160 + 600i));
        }
    }
    let _e172 = header;
    local_11 = u32((base + 8u));
    let _e178 = local_11;
    output[_e178] = u32(_e172);
    if true {
        {
            header_2 = 9i;
            let _e183 = header_2;
            let _e184 = state;
            state = (_e184 + _e183);
        }
        local_12 = u32((base + 9u));
        let _e193 = local_12;
        local_28 = _e193;
        let _e195 = local_28;
        output[_e195] = u32((seed + 20i));
    }
    let _e197 = state;
    local_13 = u32((base + 10u));
    let _e203 = local_13;
    output[_e203] = u32(_e197);
    {
        pass_ = 0i;
        loop {
            let _e207 = pass_;
            if (_e207 < 4i) {
            } else {
                break;
            }
            let _e210 = pass_;
            selected = _e210;
            let _e212 = selected;
            if (_e212 == 1i) {
                continue;
            }
            let _e215 = pass_;
            selected_1 = _e215;
            let _e217 = selected_1;
            if (_e217 == 3i) {
                break;
            }
            let _e220 = pass_;
            let _e223 = state;
            state = (_e223 + (_e220 + 1i));
            continuing {
                let _e225 = pass_;
                pass_ = (_e225 + 1i);
            }
        }
    }
    let _e228 = state;
    local_14 = u32((base + 11u));
    let _e234 = local_14;
    output[_e234] = u32(_e228);
    let _e236 = state;
    state = (_e236 + 1i);
    if true {
        let _e240 = state;
        local_15 = u32((base + 12u));
        let _e246 = local_15;
        local_29 = _e246;
        let _e248 = local_29;
        output[_e248] = u32(_e240);
    }
    read_ = 0i;
    let _e252 = read_;
    read_ = (_e252 + 1i);
    local_16 = u32((lane + u32(_e252)));
    let _e259 = local_16;
    let saved = input[_e259];
    if (saved > 0i) {
        let _e264 = read_;
        local_17 = u32((base + 13u));
        let _e272 = local_17;
        local_30 = _e272;
        let _e274 = local_30;
        output[_e274] = u32((_e264 + 100i));
    } else {
        let _e276 = read_;
        local_18 = u32((base + 13u));
        let _e284 = local_18;
        local_31 = _e284;
        let _e286 = local_31;
        output[_e286] = u32((_e276 + 200i));
    }
    let _e288 = state;
    local_19 = u32((base + 14u));
    let _e294 = local_19;
    output[_e294] = u32(_e288);
    let _e296 = index;
    local_20 = u32((base + 15u));
    let _e302 = local_20;
    output[_e302] = u32(_e296);
}
