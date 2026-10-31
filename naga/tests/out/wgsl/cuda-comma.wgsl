struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
@group(0) @binding(1)
var<storage> input_1: array<i32>;
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
    var out: array<u32, 2>;
    var input: array<u32, 2>;
    var base: u32;
    var value: i32;
    var local: array<u32, 2>;
    var local_1: u32;
    var choose: bool;
    var x: i32;
    var sequenced: i32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var target_: i32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var rhs: i32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var middle: i32;
    var selected: i32;
    var local_10: i32;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var left: i32;
    var right: i32;
    var local_13: array<u32, 2>;
    var local_14: u32;
    var identity: i32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var position: u32;
    var local_17: array<u32, 2>;
    var local_18: u32;
    var effect: i32;
    var local_19: array<u32, 2>;
    var local_20: u32;
    var total: i32;
    var iteration: i32;
    var current: i32;
    var local_21: array<u32, 2>;
    var local_22: u32;
    var ticks: i32;
    var passes: i32;
    var local_23: array<u32, 2>;
    var local_24: u32;
    var argument: i32;
    var first: i32;
    var second: i32;
    var local_25: array<u32, 2>;
    var local_26: u32;
    var local_27: i32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var local_30: u32;
    var local_31: i32;
    var local_32: array<u32, 2>;
    var local_33: u32;
    var local_34: u32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var local_37: u32;
    var local_38: array<u32, 2>;
    var local_39: u32;
    var local_40: u32;
    var local_41: array<u32, 2>;
    var local_42: u32;
    var local_43: u32;
    var local_44: array<u32, 2>;
    var local_45: u32;
    var local_46: u32;
    var local_47: array<u32, 2>;
    var local_48: u32;
    var local_49: u32;
    var local_50: array<u32, 2>;
    var local_51: u32;
    var local_52: u32;
    var local_53: array<u32, 2>;
    var local_54: u32;
    var local_55: u32;
    var local_56: array<u32, 2>;
    var local_57: u32;
    var local_58: u32;
    var local_59: array<u32, 2>;
    var local_60: u32;
    var local_61: u32;
    var local_62: array<u32, 2>;
    var local_63: u32;
    var local_64: u32;
    var local_65: array<u32, 2>;
    var local_66: u32;
    var local_67: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    input = array<u32, 2>();
    input[0] = 1u;
    input[1] = 0u;
    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 12u);
        let _e27 = input;
        local = _e27;
        local_1 = u32(i);
        let _e31 = local;
        local_28 = _e31;
        let _e33 = local_1;
        let _e35 = local_28[1];
        local_28[1] = (_e35 + _e33);
        let _e39 = local_28[0];
        local_29 = u32(_e39);
        let _e43 = local_28[1];
        local_30 = u32(_e43);
        let _e46 = local_30;
        let _e49 = input_1[_e46];
        local_31 = _e49;
        let _e51 = local_31;
        local_27 = _e51;
        let _e53 = local_27;
        value = _e53;
        choose = ((i % 2u) == 0u);
        let _e60 = value;
        x = _e60;
        let _e62 = x;
        x = (_e62 + 2i);
        let _e65 = x;
        x = (_e65 * 3i);
        let _e68 = x;
        sequenced = (_e68 - 1i);
        let _e72 = sequenced;
        let _e74 = out;
        local_2 = _e74;
        let _e76 = base;
        local_3 = u32(_e76);
        let _e79 = local_2;
        local_32 = _e79;
        let _e81 = local_3;
        let _e83 = local_32[1];
        local_32[1] = (_e83 + _e81);
        let _e87 = local_32[0];
        local_33 = u32(_e87);
        let _e91 = local_32[1];
        local_34 = u32(_e91);
        let _e94 = local_34;
        out_1[_e94] = _e72;
        let _e97 = x;
        let _e98 = out;
        local_4 = _e98;
        let _e100 = base;
        local_5 = u32((_e100 + 1u));
        let _e105 = local_4;
        local_35 = _e105;
        let _e107 = local_5;
        let _e109 = local_35[1];
        local_35[1] = (_e109 + _e107);
        let _e113 = local_35[0];
        local_36 = u32(_e113);
        let _e117 = local_35[1];
        local_37 = u32(_e117);
        let _e120 = local_37;
        out_1[_e120] = _e97;
        target_ = 0i;
        let _e124 = value;
        target_ = _e124;
        let _e125 = target_;
        target_ = (_e125 + 4i);
        let _e128 = target_;
        let _e129 = out;
        local_6 = _e129;
        let _e131 = base;
        local_7 = u32((_e131 + 2u));
        let _e136 = local_6;
        local_38 = _e136;
        let _e138 = local_7;
        let _e140 = local_38[1];
        local_38[1] = (_e140 + _e138);
        let _e144 = local_38[0];
        local_39 = u32(_e144);
        let _e148 = local_38[1];
        local_40 = u32(_e148);
        let _e151 = local_40;
        out_1[_e151] = _e128;
        let _e153 = value;
        target_ = (_e153 + 1i);
        let _e156 = target_;
        rhs = (_e156 + 3i);
        let _e160 = rhs;
        let _e163 = target_;
        let _e165 = out;
        local_8 = _e165;
        let _e167 = base;
        local_9 = u32((_e167 + 3u));
        let _e172 = local_8;
        local_41 = _e172;
        let _e174 = local_9;
        let _e176 = local_41[1];
        local_41[1] = (_e176 + _e174);
        let _e180 = local_41[0];
        local_42 = u32(_e180);
        let _e184 = local_41[1];
        local_43 = u32(_e184);
        let _e187 = local_43;
        out_1[_e187] = ((_e160 * 10i) + _e163);
        middle = 0i;
        let _e191 = choose;
        if _e191 {
            let _e192 = value;
            middle = (_e192 + 2i);
            let _e195 = middle;
            local_10 = (_e195 + 3i);
        } else {
            let _e199 = value;
            local_10 = (_e199 - 2i);
        }
        let _e204 = local_10;
        selected = _e204;
        let _e206 = selected;
        let _e209 = middle;
        let _e211 = out;
        local_11 = _e211;
        let _e213 = base;
        local_12 = u32((_e213 + 4u));
        let _e218 = local_11;
        local_44 = _e218;
        let _e220 = local_12;
        let _e222 = local_44[1];
        local_44[1] = (_e222 + _e220);
        let _e226 = local_44[0];
        local_45 = u32(_e226);
        let _e230 = local_44[1];
        local_46 = u32(_e230);
        let _e233 = local_46;
        out_1[_e233] = ((_e206 * 10i) + _e209);
        let _e235 = value;
        left = _e235;
        let _e237 = value;
        right = (_e237 + 10i);
        let _e241 = value;
        consume(_e241);
        let _e242 = choose;
        if _e242 {
            let _e243 = left;
            left = (_e243 + 3i);
        } else {
            let _e246 = right;
            right = (_e246 + 3i);
        }
        let _e249 = left;
        let _e252 = right;
        let _e254 = out;
        local_13 = _e254;
        let _e256 = base;
        local_14 = u32((_e256 + 5u));
        let _e261 = local_13;
        local_47 = _e261;
        let _e263 = local_14;
        let _e265 = local_47[1];
        local_47[1] = (_e265 + _e263);
        let _e269 = local_47[0];
        local_48 = u32(_e269);
        let _e273 = local_47[1];
        local_49 = u32(_e273);
        let _e276 = local_49;
        out_1[_e276] = ((_e249 * 100i) + _e252);
        let _e278 = value;
        identity = _e278;
        let _e280 = identity;
        identity = (_e280 + 1i);
        consume(_e280);
        let _e283 = identity;
        identity = (_e283 + 1i);
        let _e286 = identity;
        let _e287 = out;
        local_15 = _e287;
        let _e289 = base;
        local_16 = u32((_e289 + 6u));
        let _e294 = local_15;
        local_50 = _e294;
        let _e296 = local_16;
        let _e298 = local_50[1];
        local_50[1] = (_e298 + _e296);
        let _e302 = local_50[0];
        local_51 = u32(_e302);
        let _e306 = local_50[1];
        local_52 = u32(_e306);
        let _e309 = local_52;
        out_1[_e309] = _e286;
        let _e311 = base;
        position = (_e311 + 4u);
        let _e315 = position;
        position = (_e315 + 2u);
        let _e318 = value;
        let _e323 = position;
        position = (_e323 + u32(1i));
        let _e327 = out;
        local_17 = _e327;
        let _e329 = position;
        local_18 = u32(_e329);
        let _e332 = local_17;
        local_53 = _e332;
        let _e334 = local_18;
        let _e336 = local_53[1];
        local_53[1] = (_e336 + _e334);
        let _e340 = local_53[0];
        local_54 = u32(_e340);
        let _e344 = local_53[1];
        local_55 = u32(_e344);
        let _e347 = local_55;
        out_1[_e347] = ((_e318 * 2i) + 2i);
        let _e349 = value;
        effect = _e349;
        let _e351 = effect;
        effect = (_e351 + 1i);
        consume(_e351);
        let _e354 = effect;
        effect = (_e354 + 1i);
        consume(_e354);
        let _e357 = effect;
        effect = (_e357 + 1i);
        consume(_e357);
        let _e360 = effect;
        effect = (_e360 + 1i);
        consume(_e360);
        let _e363 = effect;
        let _e364 = out;
        local_19 = _e364;
        let _e366 = base;
        local_20 = u32((_e366 + 8u));
        let _e371 = local_19;
        local_56 = _e371;
        let _e373 = local_20;
        let _e375 = local_56[1];
        local_56[1] = (_e375 + _e373);
        let _e379 = local_56[0];
        local_57 = u32(_e379);
        let _e383 = local_56[1];
        local_58 = u32(_e383);
        let _e386 = local_58;
        out_1[_e386] = _e363;
        total = 0i;
        {
            iteration = 0i;
            let _e392 = value;
            current = _e392;
            loop {
                let _e394 = iteration;
                if (_e394 < 4i) {
                } else {
                    break;
                }
                let _e397 = iteration;
                if (_e397 != 1i) {
                    let _e400 = current;
                    let _e401 = total;
                    total = (_e401 + _e400);
                } else {
                    continue;
                }
                continuing {
                    let _e403 = iteration;
                    iteration = (_e403 + 1i);
                    let _e406 = current;
                    current = (_e406 + 2i);
                }
            }
        }
        let _e409 = total;
        let _e410 = out;
        local_21 = _e410;
        let _e412 = base;
        local_22 = u32((_e412 + 9u));
        let _e417 = local_21;
        local_59 = _e417;
        let _e419 = local_22;
        let _e421 = local_59[1];
        local_59[1] = (_e421 + _e419);
        let _e425 = local_59[0];
        local_60 = u32(_e425);
        let _e429 = local_59[1];
        local_61 = u32(_e429);
        let _e432 = local_61;
        out_1[_e432] = _e409;
        let _e434 = value;
        ticks = _e434;
        passes = 0i;
        {
            let _e438 = value;
            ticks = (_e438 + 1i);
            passes = 0i;
            loop {
                let _e442 = passes;
                passes = (_e442 + 1i);
                let _e445 = passes;
                if (_e445 < 4i) {
                } else {
                    break;
                }
                continuing {
                    let _e448 = ticks;
                    ticks = (_e448 + 2i);
                }
            }
        }
        let _e451 = ticks;
        let _e454 = passes;
        let _e456 = out;
        local_23 = _e456;
        let _e458 = base;
        local_24 = u32((_e458 + 10u));
        let _e463 = local_23;
        local_62 = _e463;
        let _e465 = local_24;
        let _e467 = local_62[1];
        local_62[1] = (_e467 + _e465);
        let _e471 = local_62[0];
        local_63 = u32(_e471);
        let _e475 = local_62[1];
        local_64 = u32(_e475);
        let _e478 = local_64;
        out_1[_e478] = ((_e451 * 10i) + _e454);
        let _e480 = value;
        argument = _e480;
        let _e482 = argument;
        argument = (_e482 + 1i);
        let _e485 = argument;
        let _e487 = pair_add(_e485, 2i);
        first = _e487;
        let _e489 = first;
        let _e491 = pair_add(_e489, 3i);
        second = _e491;
        let _e493 = second;
        let _e496 = argument;
        let _e498 = out;
        local_25 = _e498;
        let _e500 = base;
        local_26 = u32((_e500 + 11u));
        let _e505 = local_25;
        local_65 = _e505;
        let _e507 = local_26;
        let _e509 = local_65[1];
        local_65[1] = (_e509 + _e507);
        let _e513 = local_65[0];
        local_66 = u32(_e513);
        let _e517 = local_65[1];
        local_67 = u32(_e517);
        let _e520 = local_67;
        out_1[_e520] = ((_e493 * 10i) + _e496);
    }
}
