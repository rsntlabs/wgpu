struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
@group(0) @binding(2)
var<uniform> n: type_3;

fn consume(value_1: i32) {
    if (value_1 < 0i) {
        return;
    } else {
        return;
    }
}

fn pair_add(left_1: i32, right_1: i32) -> i32 {
    return (left_1 + right_1);
}

@compute @workgroup_size(64, 1, 1)
fn comma(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var base: u32;
    var value: i32;
    var local: u32;
    var choose: bool;
    var x: i32;
    var sequenced: i32;
    var local_1: u32;
    var local_2: u32;
    var target_: i32;
    var local_3: u32;
    var rhs: i32;
    var local_4: u32;
    var middle: i32;
    var selected: i32;
    var local_5: i32;
    var local_6: u32;
    var left: i32;
    var right: i32;
    var local_7: u32;
    var identity: i32;
    var local_8: u32;
    var position: u32;
    var local_9: u32;
    var effect: i32;
    var local_10: u32;
    var total: i32;
    var iteration: i32;
    var current: i32;
    var local_11: u32;
    var ticks: i32;
    var passes: i32;
    var local_12: u32;
    var argument: i32;
    var first: i32;
    var second: i32;
    var local_13: u32;
    var local_14: i32;
    var local_15: u32;
    var local_16: i32;
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

    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 12u);
        local = u32(i);
        let _e16 = local;
        local_15 = u32(_e16);
        let _e19 = local_15;
        let _e22 = input[_e19];
        local_16 = _e22;
        let _e24 = local_16;
        local_14 = _e24;
        let _e26 = local_14;
        value = _e26;
        choose = ((i % 2u) == 0u);
        let _e33 = value;
        x = _e33;
        let _e35 = x;
        x = (_e35 + 2i);
        let _e38 = x;
        x = (_e38 * 3i);
        let _e41 = x;
        sequenced = (_e41 - 1i);
        let _e45 = sequenced;
        let _e46 = base;
        local_1 = u32(_e46);
        let _e49 = local_1;
        local_17 = u32(_e49);
        let _e52 = local_17;
        out[_e52] = _e45;
        let _e55 = x;
        let _e56 = base;
        local_2 = u32((_e56 + 1u));
        let _e61 = local_2;
        local_18 = u32(_e61);
        let _e64 = local_18;
        out[_e64] = _e55;
        target_ = 0i;
        let _e68 = value;
        target_ = _e68;
        let _e69 = target_;
        target_ = (_e69 + 4i);
        let _e72 = target_;
        let _e73 = base;
        local_3 = u32((_e73 + 2u));
        let _e78 = local_3;
        local_19 = u32(_e78);
        let _e81 = local_19;
        out[_e81] = _e72;
        let _e83 = value;
        target_ = (_e83 + 1i);
        let _e86 = target_;
        rhs = (_e86 + 3i);
        let _e90 = rhs;
        let _e93 = target_;
        let _e95 = base;
        local_4 = u32((_e95 + 3u));
        let _e100 = local_4;
        local_20 = u32(_e100);
        let _e103 = local_20;
        out[_e103] = ((_e90 * 10i) + _e93);
        middle = 0i;
        let _e107 = choose;
        if _e107 {
            let _e108 = value;
            middle = (_e108 + 2i);
            let _e111 = middle;
            local_5 = (_e111 + 3i);
        } else {
            let _e115 = value;
            local_5 = (_e115 - 2i);
        }
        let _e120 = local_5;
        selected = _e120;
        let _e122 = selected;
        let _e125 = middle;
        let _e127 = base;
        local_6 = u32((_e127 + 4u));
        let _e132 = local_6;
        local_21 = u32(_e132);
        let _e135 = local_21;
        out[_e135] = ((_e122 * 10i) + _e125);
        let _e137 = value;
        left = _e137;
        let _e139 = value;
        right = (_e139 + 10i);
        let _e143 = value;
        consume(_e143);
        let _e144 = choose;
        if _e144 {
            let _e145 = left;
            left = (_e145 + 3i);
        } else {
            let _e148 = right;
            right = (_e148 + 3i);
        }
        let _e151 = left;
        let _e154 = right;
        let _e156 = base;
        local_7 = u32((_e156 + 5u));
        let _e161 = local_7;
        local_22 = u32(_e161);
        let _e164 = local_22;
        out[_e164] = ((_e151 * 100i) + _e154);
        let _e166 = value;
        identity = _e166;
        let _e168 = identity;
        identity = (_e168 + 1i);
        consume(_e168);
        let _e171 = identity;
        identity = (_e171 + 1i);
        let _e174 = identity;
        let _e175 = base;
        local_8 = u32((_e175 + 6u));
        let _e180 = local_8;
        local_23 = u32(_e180);
        let _e183 = local_23;
        out[_e183] = _e174;
        let _e185 = base;
        position = (_e185 + 4u);
        let _e189 = position;
        position = (_e189 + 2u);
        let _e192 = value;
        let _e197 = position;
        position = (_e197 + u32(1i));
        let _e201 = position;
        local_9 = u32(_e201);
        let _e204 = local_9;
        local_24 = u32(_e204);
        let _e207 = local_24;
        out[_e207] = ((_e192 * 2i) + 2i);
        let _e209 = value;
        effect = _e209;
        let _e211 = effect;
        effect = (_e211 + 1i);
        consume(_e211);
        let _e214 = effect;
        effect = (_e214 + 1i);
        consume(_e214);
        let _e217 = effect;
        effect = (_e217 + 1i);
        consume(_e217);
        let _e220 = effect;
        effect = (_e220 + 1i);
        consume(_e220);
        let _e223 = effect;
        let _e224 = base;
        local_10 = u32((_e224 + 8u));
        let _e229 = local_10;
        local_25 = u32(_e229);
        let _e232 = local_25;
        out[_e232] = _e223;
        total = 0i;
        {
            iteration = 0i;
            let _e238 = value;
            current = _e238;
            loop {
                let _e240 = iteration;
                if (_e240 < 4i) {
                } else {
                    break;
                }
                let _e243 = iteration;
                if (_e243 != 1i) {
                    let _e246 = current;
                    let _e247 = total;
                    total = (_e247 + _e246);
                } else {
                    continue;
                }
                continuing {
                    let _e249 = iteration;
                    iteration = (_e249 + 1i);
                    let _e252 = current;
                    current = (_e252 + 2i);
                }
            }
        }
        let _e255 = total;
        let _e256 = base;
        local_11 = u32((_e256 + 9u));
        let _e261 = local_11;
        local_26 = u32(_e261);
        let _e264 = local_26;
        out[_e264] = _e255;
        let _e266 = value;
        ticks = _e266;
        passes = 0i;
        {
            let _e270 = value;
            ticks = (_e270 + 1i);
            passes = 0i;
            loop {
                let _e274 = passes;
                passes = (_e274 + 1i);
                let _e277 = passes;
                if (_e277 < 4i) {
                } else {
                    break;
                }
                continuing {
                    let _e280 = ticks;
                    ticks = (_e280 + 2i);
                }
            }
        }
        let _e283 = ticks;
        let _e286 = passes;
        let _e288 = base;
        local_12 = u32((_e288 + 10u));
        let _e293 = local_12;
        local_27 = u32(_e293);
        let _e296 = local_27;
        out[_e296] = ((_e283 * 10i) + _e286);
        let _e298 = value;
        argument = _e298;
        let _e300 = argument;
        argument = (_e300 + 1i);
        let _e303 = argument;
        let _e305 = pair_add(_e303, 2i);
        first = _e305;
        let _e307 = first;
        let _e309 = pair_add(_e307, 3i);
        second = _e309;
        let _e311 = second;
        let _e314 = argument;
        let _e316 = base;
        local_13 = u32((_e316 + 11u));
        let _e321 = local_13;
        local_28 = u32(_e321);
        let _e324 = local_28;
        out[_e324] = ((_e311 * 10i) + _e314);
    }
}
