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
        local = i;
        let _e15 = local;
        local_15 = _e15;
        let _e17 = local_15;
        let _e20 = input[_e17];
        local_16 = _e20;
        let _e22 = local_16;
        local_14 = _e22;
        let _e24 = local_14;
        value = _e24;
        choose = ((i % 2u) == 0u);
        let _e31 = value;
        x = _e31;
        let _e33 = x;
        x = (_e33 + 2i);
        let _e36 = x;
        x = (_e36 * 3i);
        let _e39 = x;
        sequenced = (_e39 - 1i);
        let _e43 = sequenced;
        let _e44 = base;
        local_1 = _e44;
        let _e46 = local_1;
        local_17 = _e46;
        let _e48 = local_17;
        out[_e48] = _e43;
        let _e51 = x;
        let _e52 = base;
        local_2 = u32((_e52 + 1u));
        let _e57 = local_2;
        local_18 = _e57;
        let _e59 = local_18;
        out[_e59] = _e51;
        target_ = 0i;
        let _e63 = value;
        target_ = _e63;
        let _e64 = target_;
        target_ = (_e64 + 4i);
        let _e67 = target_;
        let _e68 = base;
        local_3 = u32((_e68 + 2u));
        let _e73 = local_3;
        local_19 = _e73;
        let _e75 = local_19;
        out[_e75] = _e67;
        let _e77 = value;
        target_ = (_e77 + 1i);
        let _e80 = target_;
        rhs = (_e80 + 3i);
        let _e84 = rhs;
        let _e87 = target_;
        let _e89 = base;
        local_4 = u32((_e89 + 3u));
        let _e94 = local_4;
        local_20 = _e94;
        let _e96 = local_20;
        out[_e96] = ((_e84 * 10i) + _e87);
        middle = 0i;
        let _e100 = choose;
        if _e100 {
            let _e101 = value;
            middle = (_e101 + 2i);
            let _e104 = middle;
            local_5 = (_e104 + 3i);
        } else {
            let _e108 = value;
            local_5 = (_e108 - 2i);
        }
        let _e113 = local_5;
        selected = _e113;
        let _e115 = selected;
        let _e118 = middle;
        let _e120 = base;
        local_6 = u32((_e120 + 4u));
        let _e125 = local_6;
        local_21 = _e125;
        let _e127 = local_21;
        out[_e127] = ((_e115 * 10i) + _e118);
        let _e129 = value;
        left = _e129;
        let _e131 = value;
        right = (_e131 + 10i);
        let _e135 = value;
        consume(_e135);
        let _e136 = choose;
        if _e136 {
            let _e137 = left;
            left = (_e137 + 3i);
        } else {
            let _e140 = right;
            right = (_e140 + 3i);
        }
        let _e143 = left;
        let _e146 = right;
        let _e148 = base;
        local_7 = u32((_e148 + 5u));
        let _e153 = local_7;
        local_22 = _e153;
        let _e155 = local_22;
        out[_e155] = ((_e143 * 100i) + _e146);
        let _e157 = value;
        identity = _e157;
        let _e159 = identity;
        identity = (_e159 + 1i);
        consume(_e159);
        let _e162 = identity;
        identity = (_e162 + 1i);
        let _e165 = identity;
        let _e166 = base;
        local_8 = u32((_e166 + 6u));
        let _e171 = local_8;
        local_23 = _e171;
        let _e173 = local_23;
        out[_e173] = _e165;
        let _e175 = base;
        position = (_e175 + 4u);
        let _e179 = position;
        position = (_e179 + 2u);
        let _e182 = value;
        let _e187 = position;
        position = (_e187 + u32(1i));
        let _e191 = position;
        local_9 = _e191;
        let _e193 = local_9;
        local_24 = _e193;
        let _e195 = local_24;
        out[_e195] = ((_e182 * 2i) + 2i);
        let _e197 = value;
        effect = _e197;
        let _e199 = effect;
        effect = (_e199 + 1i);
        consume(_e199);
        let _e202 = effect;
        effect = (_e202 + 1i);
        consume(_e202);
        let _e205 = effect;
        effect = (_e205 + 1i);
        consume(_e205);
        let _e208 = effect;
        effect = (_e208 + 1i);
        consume(_e208);
        let _e211 = effect;
        let _e212 = base;
        local_10 = u32((_e212 + 8u));
        let _e217 = local_10;
        local_25 = _e217;
        let _e219 = local_25;
        out[_e219] = _e211;
        total = 0i;
        {
            iteration = 0i;
            let _e225 = value;
            current = _e225;
            loop {
                let _e227 = iteration;
                if (_e227 < 4i) {
                } else {
                    break;
                }
                let _e230 = iteration;
                if (_e230 != 1i) {
                    let _e233 = current;
                    let _e234 = total;
                    total = (_e234 + _e233);
                } else {
                    continue;
                }
                continuing {
                    let _e236 = iteration;
                    iteration = (_e236 + 1i);
                    let _e239 = current;
                    current = (_e239 + 2i);
                }
            }
        }
        let _e242 = total;
        let _e243 = base;
        local_11 = u32((_e243 + 9u));
        let _e248 = local_11;
        local_26 = _e248;
        let _e250 = local_26;
        out[_e250] = _e242;
        let _e252 = value;
        ticks = _e252;
        passes = 0i;
        {
            let _e256 = value;
            ticks = (_e256 + 1i);
            passes = 0i;
            loop {
                let _e260 = passes;
                passes = (_e260 + 1i);
                let _e263 = passes;
                if (_e263 < 4i) {
                } else {
                    break;
                }
                continuing {
                    let _e266 = ticks;
                    ticks = (_e266 + 2i);
                }
            }
        }
        let _e269 = ticks;
        let _e272 = passes;
        let _e274 = base;
        local_12 = u32((_e274 + 10u));
        let _e279 = local_12;
        local_27 = _e279;
        let _e281 = local_27;
        out[_e281] = ((_e269 * 10i) + _e272);
        let _e283 = value;
        argument = _e283;
        let _e285 = argument;
        argument = (_e285 + 1i);
        let _e288 = argument;
        let _e290 = pair_add(_e288, 2i);
        first = _e290;
        let _e292 = first;
        let _e294 = pair_add(_e292, 3i);
        second = _e294;
        let _e296 = second;
        let _e299 = argument;
        let _e301 = base;
        local_13 = u32((_e301 + 11u));
        let _e306 = local_13;
        local_28 = _e306;
        let _e308 = local_28;
        out[_e308] = ((_e296 * 10i) + _e299);
    }
}
