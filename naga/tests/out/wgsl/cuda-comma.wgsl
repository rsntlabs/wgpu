struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
@group(0) @binding(2)
var<uniform> n_1: type_3;

fn consume(value_1: i32) {
    var value_2: i32;

    value_2 = value_1;
    let _e3 = value_2;
    if (_e3 < 0i) {
        return;
    } else {
        return;
    }
}

fn pair_add(left_1: i32, right_1: i32) -> i32 {
    var left_2: i32;
    var right_2: i32;

    left_2 = left_1;
    right_2 = right_1;
    let _e4 = left_2;
    let _e5 = right_2;
    return (_e4 + _e5);
}

@compute @workgroup_size(64, 1, 1)
fn comma(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var choose: bool;
    var x: i32;
    var sequenced: i32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var target_: i32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var rhs: i32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var middle: i32;
    var selected: i32;
    var local_17: i32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var left: i32;
    var right: i32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var identity: i32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var position: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var effect: i32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var total: i32;
    var iteration: i32;
    var current: i32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var ticks: i32;
    var passes: i32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var argument: i32;
    var first: i32;
    var second: i32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var local_43: i32;
    var local_44: u32;
    var local_45: u32;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;

    local = 0u;
    local_1 = 0u;
    let _e8 = n_1.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e16 = i;
    let _e17 = n;
    if (_e16 < _e17) {
        let _e19 = i;
        base = (_e19 * 12u);
        let _e23 = local_1;
        local_2 = _e23;
        let _e25 = local_2;
        local_3 = u32(_e25);
        let _e28 = i;
        local_4 = u32(_e28);
        let _e32 = local_3;
        let _e33 = local_4;
        local_42 = u32((_e32 + _e33));
        let _e38 = local_42;
        let _e40 = input[_e38];
        local_43 = _e40;
        let _e41 = local_43;
        value = _e41;
        let _e43 = i;
        choose = ((_e43 % 2u) == 0u);
        let _e49 = value;
        x = _e49;
        let _e51 = x;
        x = (_e51 + 2i);
        let _e54 = x;
        x = (_e54 * 3i);
        let _e57 = x;
        sequenced = (_e57 - 1i);
        let _e61 = sequenced;
        let _e62 = local;
        local_5 = _e62;
        let _e64 = local_5;
        local_6 = u32(_e64);
        let _e67 = base;
        local_7 = u32(_e67);
        let _e71 = local_6;
        let _e72 = local_7;
        local_44 = u32((_e71 + _e72));
        let _e76 = local_44;
        out[_e76] = _e61;
        let _e78 = x;
        let _e79 = local;
        local_8 = _e79;
        let _e81 = local_8;
        local_9 = u32(_e81);
        let _e84 = base;
        local_10 = u32((_e84 + 1u));
        let _e89 = local_9;
        let _e90 = local_10;
        local_45 = u32((_e89 + _e90));
        let _e94 = local_45;
        out[_e94] = _e78;
        target_ = 0i;
        let _e98 = value;
        target_ = _e98;
        let _e99 = target_;
        target_ = (_e99 + 4i);
        let _e102 = target_;
        let _e103 = local;
        local_11 = _e103;
        let _e105 = local_11;
        local_12 = u32(_e105);
        let _e108 = base;
        local_13 = u32((_e108 + 2u));
        let _e113 = local_12;
        let _e114 = local_13;
        local_46 = u32((_e113 + _e114));
        let _e118 = local_46;
        out[_e118] = _e102;
        let _e120 = value;
        target_ = (_e120 + 1i);
        let _e123 = target_;
        rhs = (_e123 + 3i);
        let _e127 = rhs;
        let _e130 = target_;
        let _e132 = local;
        local_14 = _e132;
        let _e134 = local_14;
        local_15 = u32(_e134);
        let _e137 = base;
        local_16 = u32((_e137 + 3u));
        let _e142 = local_15;
        let _e143 = local_16;
        local_47 = u32((_e142 + _e143));
        let _e147 = local_47;
        out[_e147] = ((_e127 * 10i) + _e130);
        middle = 0i;
        let _e151 = choose;
        if _e151 {
            let _e152 = value;
            middle = (_e152 + 2i);
            let _e155 = middle;
            local_17 = (_e155 + 3i);
        } else {
            let _e159 = value;
            local_17 = (_e159 - 2i);
        }
        let _e164 = local_17;
        selected = _e164;
        let _e166 = selected;
        let _e169 = middle;
        let _e171 = local;
        local_18 = _e171;
        let _e173 = local_18;
        local_19 = u32(_e173);
        let _e176 = base;
        local_20 = u32((_e176 + 4u));
        let _e181 = local_19;
        let _e182 = local_20;
        local_48 = u32((_e181 + _e182));
        let _e186 = local_48;
        out[_e186] = ((_e166 * 10i) + _e169);
        let _e188 = value;
        left = _e188;
        let _e190 = value;
        right = (_e190 + 10i);
        let _e194 = value;
        consume(_e194);
        let _e195 = choose;
        if _e195 {
            let _e196 = left;
            left = (_e196 + 3i);
        } else {
            let _e199 = right;
            right = (_e199 + 3i);
        }
        let _e202 = left;
        let _e205 = right;
        let _e207 = local;
        local_21 = _e207;
        let _e209 = local_21;
        local_22 = u32(_e209);
        let _e212 = base;
        local_23 = u32((_e212 + 5u));
        let _e217 = local_22;
        let _e218 = local_23;
        local_49 = u32((_e217 + _e218));
        let _e222 = local_49;
        out[_e222] = ((_e202 * 100i) + _e205);
        let _e224 = value;
        identity = _e224;
        let _e226 = identity;
        identity = (_e226 + 1i);
        consume(_e226);
        let _e229 = identity;
        identity = (_e229 + 1i);
        let _e232 = identity;
        let _e233 = local;
        local_24 = _e233;
        let _e235 = local_24;
        local_25 = u32(_e235);
        let _e238 = base;
        local_26 = u32((_e238 + 6u));
        let _e243 = local_25;
        let _e244 = local_26;
        local_50 = u32((_e243 + _e244));
        let _e248 = local_50;
        out[_e248] = _e232;
        let _e250 = base;
        position = (_e250 + 4u);
        let _e254 = position;
        position = (_e254 + 2u);
        let _e257 = value;
        let _e262 = position;
        position = (_e262 + u32(1i));
        let _e266 = local;
        local_27 = _e266;
        let _e268 = local_27;
        local_28 = u32(_e268);
        let _e271 = position;
        local_29 = u32(_e271);
        let _e274 = local_28;
        let _e275 = local_29;
        local_51 = u32((_e274 + _e275));
        let _e279 = local_51;
        out[_e279] = ((_e257 * 2i) + 2i);
        let _e281 = value;
        effect = _e281;
        let _e283 = effect;
        effect = (_e283 + 1i);
        consume(_e283);
        let _e286 = effect;
        effect = (_e286 + 1i);
        consume(_e286);
        let _e289 = effect;
        effect = (_e289 + 1i);
        consume(_e289);
        let _e292 = effect;
        effect = (_e292 + 1i);
        consume(_e292);
        let _e295 = effect;
        let _e296 = local;
        local_30 = _e296;
        let _e298 = local_30;
        local_31 = u32(_e298);
        let _e301 = base;
        local_32 = u32((_e301 + 8u));
        let _e306 = local_31;
        let _e307 = local_32;
        local_52 = u32((_e306 + _e307));
        let _e311 = local_52;
        out[_e311] = _e295;
        total = 0i;
        {
            iteration = 0i;
            let _e317 = value;
            current = _e317;
            loop {
                let _e319 = iteration;
                if (_e319 < 4i) {
                } else {
                    break;
                }
                let _e322 = iteration;
                if (_e322 != 1i) {
                    let _e325 = current;
                    let _e326 = total;
                    total = (_e326 + _e325);
                } else {
                    continue;
                }
                continuing {
                    let _e328 = iteration;
                    iteration = (_e328 + 1i);
                    let _e331 = current;
                    current = (_e331 + 2i);
                }
            }
        }
        let _e334 = total;
        let _e335 = local;
        local_33 = _e335;
        let _e337 = local_33;
        local_34 = u32(_e337);
        let _e340 = base;
        local_35 = u32((_e340 + 9u));
        let _e345 = local_34;
        let _e346 = local_35;
        local_53 = u32((_e345 + _e346));
        let _e350 = local_53;
        out[_e350] = _e334;
        let _e352 = value;
        ticks = _e352;
        passes = 0i;
        {
            let _e356 = value;
            ticks = (_e356 + 1i);
            passes = 0i;
            loop {
                let _e360 = passes;
                passes = (_e360 + 1i);
                let _e363 = passes;
                if (_e363 < 4i) {
                } else {
                    break;
                }
                continuing {
                    let _e366 = ticks;
                    ticks = (_e366 + 2i);
                }
            }
        }
        let _e369 = ticks;
        let _e372 = passes;
        let _e374 = local;
        local_36 = _e374;
        let _e376 = local_36;
        local_37 = u32(_e376);
        let _e379 = base;
        local_38 = u32((_e379 + 10u));
        let _e384 = local_37;
        let _e385 = local_38;
        local_54 = u32((_e384 + _e385));
        let _e389 = local_54;
        out[_e389] = ((_e369 * 10i) + _e372);
        let _e391 = value;
        argument = _e391;
        let _e393 = argument;
        argument = (_e393 + 1i);
        let _e396 = argument;
        let _e398 = pair_add(_e396, 2i);
        first = _e398;
        let _e400 = first;
        let _e402 = pair_add(_e400, 3i);
        second = _e402;
        let _e404 = second;
        let _e407 = argument;
        let _e409 = local;
        local_39 = _e409;
        let _e411 = local_39;
        local_40 = u32(_e411);
        let _e414 = base;
        local_41 = u32((_e414 + 11u));
        let _e419 = local_40;
        let _e420 = local_41;
        local_55 = u32((_e419 + _e420));
        let _e424 = local_55;
        out[_e424] = ((_e404 * 10i) + _e407);
    }
}
