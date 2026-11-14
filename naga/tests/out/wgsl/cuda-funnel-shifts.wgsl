@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<storage> input: array<u32>;

@compute @workgroup_size(4, 1, 1)
fn funnel_shifts(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
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
            let _e72 = row;
            local_3 = u32((4u + (_e72 * 2u)));
            let _e79 = local_3;
            local_22 = _e79;
            let _e81 = local_22;
            output[_e81] = select(_e59, ((_e59 << _e62) | (_e58 >> ((32u - _e62) & 31u))), (_e62 != 0u));
            let _e84 = lo;
            let _e85 = hi;
            let _e86 = shift;
            let _e88 = (_e86 & 31u);
            let _e98 = row;
            local_4 = u32((5u + (_e98 * 2u)));
            let _e105 = local_4;
            local_23 = _e105;
            let _e107 = local_23;
            output[_e107] = select(_e84, ((_e84 >> _e88) | (_e85 << ((32u - _e88) & 31u))), (_e88 != 0u));
            continuing {
                let _e109 = row;
                row = (_e109 + 4u);
            }
        }
    }
    let base = ((4u + (count * 2u)) + (lane * 6u));
    value = 1u;
    let _e121 = value;
    value = (_e121 + u32(1i));
    let _e125 = value;
    value = (_e125 + u32(1i));
    let _e129 = value;
    value = (_e129 + u32(1i));
    let _e134 = (_e129 & 31u);
    output[base] = select(_e125, ((_e125 << _e134) | (_e121 >> ((32u - _e134) & 31u))), (_e134 != 0u));
    let _e146 = value;
    value = (_e146 + u32(1i));
    let _e150 = value;
    value = (_e150 + u32(1i));
    let _e154 = value;
    value = (_e154 + u32(1i));
    let _e159 = (_e154 & 31u);
    local_5 = u32((base + 1u));
    let _e173 = local_5;
    output[_e173] = select(_e146, ((_e146 >> _e159) | (_e150 << ((32u - _e159) & 31u))), (_e159 != 0u));
    if ((lane & 1u) == 0u) {
        let _e179 = value;
        value = (_e179 + u32(1i));
        let _e183 = value;
        value = (_e183 + u32(1i));
        let _e187 = value;
        value = (_e187 + u32(1i));
        let _e192 = (_e187 & 31u);
        local_6 = select(_e183, ((_e183 << _e192) | (_e179 >> ((32u - _e192) & 31u))), (_e192 != 0u));
    } else {
        local_6 = 0u;
    }
    let _e205 = value;
    local_7 = u32((base + 2u));
    let _e210 = local_7;
    output[_e210] = _e205;
    local_8 = false;
    if false {
        let _e214 = value;
        value = (_e214 + u32(1i));
        let _e218 = value;
        value = (_e218 + u32(1i));
        let _e222 = value;
        value = (_e222 + u32(1i));
        let _e227 = (_e222 & 31u);
        local_8 = (select(_e214, ((_e214 >> _e227) | (_e218 << ((32u - _e227) & 31u))), (_e227 != 0u)) != 0u);
    }
    local_9 = true;
    if true {
    } else {
        let _e241 = value;
        value = (_e241 + u32(1i));
        let _e245 = value;
        value = (_e245 + u32(1i));
        let _e249 = value;
        value = (_e249 + u32(1i));
        let _e254 = (_e249 & 31u);
        local_9 = (select(_e245, ((_e245 << _e254) | (_e241 >> ((32u - _e254) & 31u))), (_e254 != 0u)) != 0u);
    }
    let _e266 = value;
    value = (_e266 + u32(1i));
    let _e270 = value;
    value = (_e270 + u32(1i));
    let _e274 = value;
    value = (_e274 + u32(1i));
    let _e278 = value;
    local_10 = u32((base + 3u));
    let _e283 = local_10;
    output[_e283] = _e278;
    index = 1u;
    let _e287 = index;
    index = (_e287 + u32(1i));
    let _e292 = input[_e287];
    let _e293 = index;
    index = (_e293 + u32(1i));
    let _e298 = input[_e293];
    let _e299 = index;
    index = (_e299 + u32(1i));
    let _e304 = input[_e299];
    let _e306 = (_e304 & 31u);
    local_11 = u32((base + 4u));
    let _e320 = local_11;
    output[_e320] = select(_e298, ((_e298 << _e306) | (_e292 >> ((32u - _e306) & 31u))), (_e306 != 0u));
    let _e322 = index;
    local_12 = u32((base + 5u));
    let _e327 = local_12;
    output[_e327] = _e322;
}
