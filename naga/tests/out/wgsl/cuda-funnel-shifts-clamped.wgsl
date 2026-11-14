@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<storage> input: array<u32>;

@compute @workgroup_size(4, 1, 1)
fn funnel_shifts_clamped(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var row: u32;
    var at: u32;
    var lo: u32;
    var local: u32;
    var hi: u32;
    var local_1: u32;
    var shift: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var value: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: bool;
    var local_9: bool;
    var local_10: u32;
    var index: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
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
    let count = input[u32(0i)];
    {
        row = lane;
        loop {
            let _e8 = row;
            if (_e8 < count) {
            } else {
                break;
            }
            let _e10 = row;
            at = (1u + (_e10 * 3u));
            let _e16 = at;
            local = _e16;
            let _e18 = local;
            local_16 = _e18;
            let _e20 = local_16;
            let _e22 = input[_e20];
            local_17 = _e22;
            let _e24 = local_17;
            local_13 = _e24;
            let _e26 = local_13;
            lo = _e26;
            let _e28 = at;
            local_1 = u32((_e28 + 1u));
            let _e33 = local_1;
            local_18 = _e33;
            let _e35 = local_18;
            let _e37 = input[_e35];
            local_19 = _e37;
            let _e39 = local_19;
            local_14 = _e39;
            let _e41 = local_14;
            hi = _e41;
            let _e43 = at;
            local_2 = u32((_e43 + 2u));
            let _e48 = local_2;
            local_20 = _e48;
            let _e50 = local_20;
            let _e52 = input[_e50];
            local_21 = _e52;
            let _e54 = local_21;
            local_15 = _e54;
            let _e56 = local_15;
            shift = _e56;
            let _e58 = lo;
            let _e59 = hi;
            let _e60 = shift;
            let _e62 = (_e60 & 31u);
            let _e74 = row;
            local_3 = u32((4u + (_e74 * 2u)));
            let _e81 = local_3;
            local_22 = _e81;
            let _e83 = local_22;
            output[_e83] = select(select(_e59, ((_e59 << _e62) | (_e58 >> ((32u - _e62) & 31u))), (_e62 != 0u)), _e58, (_e60 >= 32u));
            let _e86 = lo;
            let _e87 = hi;
            let _e88 = shift;
            let _e90 = (_e88 & 31u);
            let _e102 = row;
            local_4 = u32((5u + (_e102 * 2u)));
            let _e109 = local_4;
            local_23 = _e109;
            let _e111 = local_23;
            output[_e111] = select(select(_e86, ((_e86 >> _e90) | (_e87 << ((32u - _e90) & 31u))), (_e90 != 0u)), _e87, (_e88 >= 32u));
            continuing {
                let _e113 = row;
                row = (_e113 + 4u);
            }
        }
    }
    let base = ((4u + (count * 2u)) + (lane * 6u));
    value = 1u;
    let _e125 = value;
    value = (_e125 + u32(1i));
    let _e129 = value;
    value = (_e129 + u32(1i));
    let _e133 = value;
    value = (_e133 + u32(1i));
    let _e138 = (_e133 & 31u);
    output[base] = select(select(_e129, ((_e129 << _e138) | (_e125 >> ((32u - _e138) & 31u))), (_e138 != 0u)), _e125, (_e133 >= 32u));
    let _e152 = value;
    value = (_e152 + u32(1i));
    let _e156 = value;
    value = (_e156 + u32(1i));
    let _e160 = value;
    value = (_e160 + u32(1i));
    let _e165 = (_e160 & 31u);
    local_5 = u32((base + 1u));
    let _e181 = local_5;
    output[_e181] = select(select(_e152, ((_e152 >> _e165) | (_e156 << ((32u - _e165) & 31u))), (_e165 != 0u)), _e156, (_e160 >= 32u));
    if ((lane & 1u) == 0u) {
        let _e187 = value;
        value = (_e187 + u32(1i));
        let _e191 = value;
        value = (_e191 + u32(1i));
        let _e195 = value;
        value = (_e195 + u32(1i));
        let _e200 = (_e195 & 31u);
        local_6 = select(select(_e191, ((_e191 << _e200) | (_e187 >> ((32u - _e200) & 31u))), (_e200 != 0u)), _e187, (_e195 >= 32u));
    } else {
        local_6 = 0u;
    }
    let _e215 = value;
    local_7 = u32((base + 2u));
    let _e220 = local_7;
    output[_e220] = _e215;
    local_8 = false;
    if false {
        let _e224 = value;
        value = (_e224 + u32(1i));
        let _e228 = value;
        value = (_e228 + u32(1i));
        let _e232 = value;
        value = (_e232 + u32(1i));
        let _e237 = (_e232 & 31u);
        local_8 = (select(select(_e224, ((_e224 >> _e237) | (_e228 << ((32u - _e237) & 31u))), (_e237 != 0u)), _e228, (_e232 >= 32u)) != 0u);
    }
    local_9 = true;
    if true {
    } else {
        let _e253 = value;
        value = (_e253 + u32(1i));
        let _e257 = value;
        value = (_e257 + u32(1i));
        let _e261 = value;
        value = (_e261 + u32(1i));
        let _e266 = (_e261 & 31u);
        local_9 = (select(select(_e257, ((_e257 << _e266) | (_e253 >> ((32u - _e266) & 31u))), (_e266 != 0u)), _e253, (_e261 >= 32u)) != 0u);
    }
    let _e280 = value;
    value = (_e280 + u32(1i));
    let _e284 = value;
    value = (_e284 + u32(1i));
    let _e288 = value;
    value = (_e288 + u32(1i));
    let _e292 = value;
    local_10 = u32((base + 3u));
    let _e297 = local_10;
    output[_e297] = _e292;
    index = 1u;
    let _e301 = index;
    index = (_e301 + u32(1i));
    let _e306 = input[_e301];
    let _e307 = index;
    index = (_e307 + u32(1i));
    let _e312 = input[_e307];
    let _e313 = index;
    index = (_e313 + u32(1i));
    let _e318 = input[_e313];
    let _e320 = (_e318 & 31u);
    local_11 = u32((base + 4u));
    let _e336 = local_11;
    output[_e336] = select(select(_e312, ((_e312 << _e320) | (_e306 >> ((32u - _e320) & 31u))), (_e320 != 0u)), _e306, (_e318 >= 32u));
    let _e338 = index;
    local_12 = u32((base + 5u));
    let _e343 = local_12;
    output[_e343] = _e338;
}
