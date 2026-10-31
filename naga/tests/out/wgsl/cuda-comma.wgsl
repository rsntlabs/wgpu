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
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var choose: bool;
    var x: i32;
    var sequenced: i32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var target_: i32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var rhs: i32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var middle: i32;
    var selected: i32;
    var local_12: i32;
    var local_13: array<u32, 2>;
    var local_14: u32;
    var left: i32;
    var right: i32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var identity: i32;
    var local_17: array<u32, 2>;
    var local_18: u32;
    var position: u32;
    var local_19: array<u32, 2>;
    var local_20: u32;
    var effect: i32;
    var local_21: array<u32, 2>;
    var local_22: u32;
    var total: i32;
    var iteration: i32;
    var current: i32;
    var local_23: array<u32, 2>;
    var local_24: u32;
    var ticks: i32;
    var passes: i32;
    var local_25: array<u32, 2>;
    var local_26: u32;
    var argument: i32;
    var first: i32;
    var second: i32;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: i32;
    var local_30: array<u32, 2>;
    var local_31: u32;
    var local_32: u32;
    var local_33: i32;
    var local_34: array<u32, 2>;
    var local_35: u32;
    var local_36: u32;
    var local_37: array<u32, 2>;
    var local_38: u32;
    var local_39: u32;
    var local_40: array<u32, 2>;
    var local_41: u32;
    var local_42: u32;
    var local_43: array<u32, 2>;
    var local_44: u32;
    var local_45: u32;
    var local_46: array<u32, 2>;
    var local_47: u32;
    var local_48: u32;
    var local_49: array<u32, 2>;
    var local_50: u32;
    var local_51: u32;
    var local_52: array<u32, 2>;
    var local_53: u32;
    var local_54: u32;
    var local_55: array<u32, 2>;
    var local_56: u32;
    var local_57: u32;
    var local_58: array<u32, 2>;
    var local_59: u32;
    var local_60: u32;
    var local_61: array<u32, 2>;
    var local_62: u32;
    var local_63: u32;
    var local_64: array<u32, 2>;
    var local_65: u32;
    var local_66: u32;
    var local_67: array<u32, 2>;
    var local_68: u32;
    var local_69: u32;

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = array<u32, 2>();
    local_1[0] = 1u;
    local_1[1] = 0u;
    let _e18 = n_1.value;
    n = _e18;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e26 = i;
    let _e27 = n;
    if (_e26 < _e27) {
        let _e29 = i;
        base = (_e29 * 12u);
        let _e35 = local_1;
        local_2 = _e35;
        let _e36 = i;
        local_3 = u32(_e36);
        let _e40 = local_2;
        local_30 = _e40;
        let _e41 = local_3;
        let _e43 = local_30[1];
        local_30[1] = (_e43 + _e41);
        let _e47 = local_30[0];
        local_31 = u32(_e47);
        let _e51 = local_30[1];
        local_32 = u32(_e51);
        let _e55 = local_32;
        let _e57 = input[_e55];
        local_33 = _e57;
        let _e58 = local_33;
        local_29 = _e58;
        let _e60 = local_29;
        value = _e60;
        let _e62 = i;
        choose = ((_e62 % 2u) == 0u);
        let _e68 = value;
        x = _e68;
        let _e70 = x;
        x = (_e70 + 2i);
        let _e73 = x;
        x = (_e73 * 3i);
        let _e76 = x;
        sequenced = (_e76 - 1i);
        let _e80 = sequenced;
        let _e83 = local;
        local_4 = _e83;
        let _e84 = base;
        local_5 = u32(_e84);
        let _e88 = local_4;
        local_34 = _e88;
        let _e89 = local_5;
        let _e91 = local_34[1];
        local_34[1] = (_e91 + _e89);
        let _e95 = local_34[0];
        local_35 = u32(_e95);
        let _e99 = local_34[1];
        local_36 = u32(_e99);
        let _e102 = local_36;
        out[_e102] = _e80;
        let _e104 = x;
        let _e106 = local;
        local_6 = _e106;
        let _e107 = base;
        local_7 = u32((_e107 + 1u));
        let _e113 = local_6;
        local_37 = _e113;
        let _e114 = local_7;
        let _e116 = local_37[1];
        local_37[1] = (_e116 + _e114);
        let _e120 = local_37[0];
        local_38 = u32(_e120);
        let _e124 = local_37[1];
        local_39 = u32(_e124);
        let _e127 = local_39;
        out[_e127] = _e104;
        target_ = 0i;
        let _e131 = value;
        target_ = _e131;
        let _e132 = target_;
        target_ = (_e132 + 4i);
        let _e135 = target_;
        let _e137 = local;
        local_8 = _e137;
        let _e138 = base;
        local_9 = u32((_e138 + 2u));
        let _e144 = local_8;
        local_40 = _e144;
        let _e145 = local_9;
        let _e147 = local_40[1];
        local_40[1] = (_e147 + _e145);
        let _e151 = local_40[0];
        local_41 = u32(_e151);
        let _e155 = local_40[1];
        local_42 = u32(_e155);
        let _e158 = local_42;
        out[_e158] = _e135;
        let _e160 = value;
        target_ = (_e160 + 1i);
        let _e163 = target_;
        rhs = (_e163 + 3i);
        let _e167 = rhs;
        let _e170 = target_;
        let _e173 = local;
        local_10 = _e173;
        let _e174 = base;
        local_11 = u32((_e174 + 3u));
        let _e180 = local_10;
        local_43 = _e180;
        let _e181 = local_11;
        let _e183 = local_43[1];
        local_43[1] = (_e183 + _e181);
        let _e187 = local_43[0];
        local_44 = u32(_e187);
        let _e191 = local_43[1];
        local_45 = u32(_e191);
        let _e194 = local_45;
        out[_e194] = ((_e167 * 10i) + _e170);
        middle = 0i;
        let _e198 = choose;
        if _e198 {
            let _e199 = value;
            middle = (_e199 + 2i);
            let _e202 = middle;
            local_12 = (_e202 + 3i);
        } else {
            let _e206 = value;
            local_12 = (_e206 - 2i);
        }
        let _e211 = local_12;
        selected = _e211;
        let _e213 = selected;
        let _e216 = middle;
        let _e219 = local;
        local_13 = _e219;
        let _e220 = base;
        local_14 = u32((_e220 + 4u));
        let _e226 = local_13;
        local_46 = _e226;
        let _e227 = local_14;
        let _e229 = local_46[1];
        local_46[1] = (_e229 + _e227);
        let _e233 = local_46[0];
        local_47 = u32(_e233);
        let _e237 = local_46[1];
        local_48 = u32(_e237);
        let _e240 = local_48;
        out[_e240] = ((_e213 * 10i) + _e216);
        let _e242 = value;
        left = _e242;
        let _e244 = value;
        right = (_e244 + 10i);
        let _e248 = value;
        consume(_e248);
        let _e249 = choose;
        if _e249 {
            let _e250 = left;
            left = (_e250 + 3i);
        } else {
            let _e253 = right;
            right = (_e253 + 3i);
        }
        let _e256 = left;
        let _e259 = right;
        let _e262 = local;
        local_15 = _e262;
        let _e263 = base;
        local_16 = u32((_e263 + 5u));
        let _e269 = local_15;
        local_49 = _e269;
        let _e270 = local_16;
        let _e272 = local_49[1];
        local_49[1] = (_e272 + _e270);
        let _e276 = local_49[0];
        local_50 = u32(_e276);
        let _e280 = local_49[1];
        local_51 = u32(_e280);
        let _e283 = local_51;
        out[_e283] = ((_e256 * 100i) + _e259);
        let _e285 = value;
        identity = _e285;
        let _e287 = identity;
        identity = (_e287 + 1i);
        consume(_e287);
        let _e290 = identity;
        identity = (_e290 + 1i);
        let _e293 = identity;
        let _e295 = local;
        local_17 = _e295;
        let _e296 = base;
        local_18 = u32((_e296 + 6u));
        let _e302 = local_17;
        local_52 = _e302;
        let _e303 = local_18;
        let _e305 = local_52[1];
        local_52[1] = (_e305 + _e303);
        let _e309 = local_52[0];
        local_53 = u32(_e309);
        let _e313 = local_52[1];
        local_54 = u32(_e313);
        let _e316 = local_54;
        out[_e316] = _e293;
        let _e318 = base;
        position = (_e318 + 4u);
        let _e322 = position;
        position = (_e322 + 2u);
        let _e325 = value;
        let _e330 = position;
        position = (_e330 + u32(1i));
        let _e335 = local;
        local_19 = _e335;
        let _e336 = position;
        local_20 = u32(_e336);
        let _e340 = local_19;
        local_55 = _e340;
        let _e341 = local_20;
        let _e343 = local_55[1];
        local_55[1] = (_e343 + _e341);
        let _e347 = local_55[0];
        local_56 = u32(_e347);
        let _e351 = local_55[1];
        local_57 = u32(_e351);
        let _e354 = local_57;
        out[_e354] = ((_e325 * 2i) + 2i);
        let _e356 = value;
        effect = _e356;
        let _e358 = effect;
        effect = (_e358 + 1i);
        consume(_e358);
        let _e361 = effect;
        effect = (_e361 + 1i);
        consume(_e361);
        let _e364 = effect;
        effect = (_e364 + 1i);
        consume(_e364);
        let _e367 = effect;
        effect = (_e367 + 1i);
        consume(_e367);
        let _e370 = effect;
        let _e372 = local;
        local_21 = _e372;
        let _e373 = base;
        local_22 = u32((_e373 + 8u));
        let _e379 = local_21;
        local_58 = _e379;
        let _e380 = local_22;
        let _e382 = local_58[1];
        local_58[1] = (_e382 + _e380);
        let _e386 = local_58[0];
        local_59 = u32(_e386);
        let _e390 = local_58[1];
        local_60 = u32(_e390);
        let _e393 = local_60;
        out[_e393] = _e370;
        total = 0i;
        {
            iteration = 0i;
            let _e399 = value;
            current = _e399;
            loop {
                let _e401 = iteration;
                if (_e401 < 4i) {
                } else {
                    break;
                }
                let _e404 = iteration;
                if (_e404 != 1i) {
                    let _e407 = current;
                    let _e408 = total;
                    total = (_e408 + _e407);
                } else {
                    continue;
                }
                continuing {
                    let _e410 = iteration;
                    iteration = (_e410 + 1i);
                    let _e413 = current;
                    current = (_e413 + 2i);
                }
            }
        }
        let _e416 = total;
        let _e418 = local;
        local_23 = _e418;
        let _e419 = base;
        local_24 = u32((_e419 + 9u));
        let _e425 = local_23;
        local_61 = _e425;
        let _e426 = local_24;
        let _e428 = local_61[1];
        local_61[1] = (_e428 + _e426);
        let _e432 = local_61[0];
        local_62 = u32(_e432);
        let _e436 = local_61[1];
        local_63 = u32(_e436);
        let _e439 = local_63;
        out[_e439] = _e416;
        let _e441 = value;
        ticks = _e441;
        passes = 0i;
        {
            let _e445 = value;
            ticks = (_e445 + 1i);
            passes = 0i;
            loop {
                let _e449 = passes;
                passes = (_e449 + 1i);
                let _e452 = passes;
                if (_e452 < 4i) {
                } else {
                    break;
                }
                continuing {
                    let _e455 = ticks;
                    ticks = (_e455 + 2i);
                }
            }
        }
        let _e458 = ticks;
        let _e461 = passes;
        let _e464 = local;
        local_25 = _e464;
        let _e465 = base;
        local_26 = u32((_e465 + 10u));
        let _e471 = local_25;
        local_64 = _e471;
        let _e472 = local_26;
        let _e474 = local_64[1];
        local_64[1] = (_e474 + _e472);
        let _e478 = local_64[0];
        local_65 = u32(_e478);
        let _e482 = local_64[1];
        local_66 = u32(_e482);
        let _e485 = local_66;
        out[_e485] = ((_e458 * 10i) + _e461);
        let _e487 = value;
        argument = _e487;
        let _e489 = argument;
        argument = (_e489 + 1i);
        let _e492 = argument;
        let _e494 = pair_add(_e492, 2i);
        first = _e494;
        let _e496 = first;
        let _e498 = pair_add(_e496, 3i);
        second = _e498;
        let _e500 = second;
        let _e503 = argument;
        let _e506 = local;
        local_27 = _e506;
        let _e507 = base;
        local_28 = u32((_e507 + 11u));
        let _e513 = local_27;
        local_67 = _e513;
        let _e514 = local_28;
        let _e516 = local_67[1];
        local_67[1] = (_e516 + _e514);
        let _e520 = local_67[0];
        local_68 = u32(_e520);
        let _e524 = local_67[1];
        local_69 = u32(_e524);
        let _e527 = local_69;
        out[_e527] = ((_e500 * 10i) + _e503);
    }
}
