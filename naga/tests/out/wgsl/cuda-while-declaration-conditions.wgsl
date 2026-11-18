@group(0) @binding(0)
var<storage> input_4: array<i32>;
@group(0) @binding(1)
var<storage, read_write> output_1: array<u32>;

fn gen__naga_fabsf(input_bits: u32) -> u32 {
    let _e2 = (input_bits & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

@compute @workgroup_size(4, 1, 1)
fn while_conditions(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var input: array<u32, 2>;
    var output: array<u32, 2>;
    var cursor: i32;
    var total: i32;
    var entry: i32;
    var local: array<u32, 2>;
    var local_1: i32;
    var local_2: array<u32, 2>;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var inferred_cursor: i32;
    var inferred_total: i32;
    var local_5: array<u32, 2>;
    var local_6: i32;
    var entry_1: i32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var early_cursor: i32;
    var first: i32;
    var local_11: array<u32, 2>;
    var local_12: i32;
    var entry_2: i32;
    var local_13: array<u32, 2>;
    var local_14: u32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var repeat: i32;
    var fixed: i32;
    var local_17: array<u32, 2>;
    var local_18: u32;
    var entry_3: i32;
    var nested: i32;
    var local_19: array<u32, 2>;
    var local_20: u32;
    var entry_4: i32;
    var entry_5: i32;
    var local_21: array<u32, 2>;
    var local_22: u32;
    var local_23: array<u32, 2>;
    var local_24: u32;
    var false_count: i32;
    var stopped: i32;
    var local_25: array<u32, 2>;
    var local_26: u32;
    var fraction: f32;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: array<u32, 2>;
    var local_30: u32;
    var input_1: array<u32, 2>;
    var offset: u32;
    var local_31: array<u32, 2>;
    var local_32: u32;
    var local_33: i32;
    var local_34: i32;
    var local_35: i32;
    var input_2: array<u32, 2>;
    var offset_1: u32;
    var local_36: array<u32, 2>;
    var local_37: u32;
    var local_38: i32;
    var local_39: i32;
    var local_40: i32;
    var input_3: array<u32, 2>;
    var offset_2: u32;
    var local_41: array<u32, 2>;
    var local_42: u32;
    var local_43: i32;
    var local_44: i32;
    var local_45: i32;
    var local_46: i32;
    var local_47: array<u32, 2>;
    var local_48: u32;
    var local_49: u32;
    var local_50: i32;
    var local_51: array<u32, 2>;
    var local_52: u32;
    var local_53: u32;
    var local_54: array<u32, 2>;
    var local_55: u32;
    var local_56: u32;
    var local_57: array<u32, 2>;
    var local_58: u32;
    var local_59: u32;
    var local_60: i32;
    var local_61: array<u32, 2>;
    var local_62: u32;
    var local_63: u32;
    var local_64: array<u32, 2>;
    var local_65: u32;
    var local_66: u32;
    var local_67: array<u32, 2>;
    var local_68: u32;
    var local_69: u32;
    var local_70: i32;
    var local_71: array<u32, 2>;
    var local_72: u32;
    var local_73: u32;
    var local_74: array<u32, 2>;
    var local_75: u32;
    var local_76: u32;
    var local_77: array<u32, 2>;
    var local_78: u32;
    var local_79: u32;
    var local_80: array<u32, 2>;
    var local_81: u32;
    var local_82: u32;
    var local_83: i32;
    var local_84: array<u32, 2>;
    var local_85: u32;
    var local_86: u32;
    var local_87: array<u32, 2>;
    var local_88: u32;
    var local_89: u32;
    var local_90: array<u32, 2>;
    var local_91: u32;
    var local_92: u32;
    var local_93: array<u32, 2>;
    var local_94: u32;
    var local_95: u32;
    var local_96: array<u32, 2>;
    var local_97: u32;
    var local_98: u32;

    input = array<u32, 2>();
    input[0] = 2u;
    input[1] = 0u;
    output = array<u32, 2>();
    output[0] = 3u;
    output[1] = 0u;
    let lane = (threadIdx.x + (blockIdx.x * 4u));
    if (lane >= 4u) {
        return;
    }
    let offset_3 = (lane * 4u);
    let base = (4u + (lane * 12u));
    cursor = 0i;
    total = 0i;
    loop {
        let _e32 = input;
        local = _e32;
        offset = u32();
        local_32 = u32();
        local_33 = i32();
        let _e40 = local;
        input_1 = _e40;
        offset = offset_3;
        let _e44 = input_1;
        local_31 = _e44;
        let _e46 = cursor;
        local_34 = _e46;
        let _e48 = local_34;
        cursor = (_e48 + 1i);
        let _e52 = offset;
        local_32 = u32((_e52 + u32(_e48)));
        let _e56 = local_31;
        local_47 = _e56;
        let _e58 = local_32;
        let _e60 = local_47[1];
        local_47[1] = (_e60 + _e58);
        let _e64 = local_47[0];
        local_48 = u32(_e64);
        let _e68 = local_47[1];
        local_49 = u32(_e68);
        let _e71 = local_49;
        let _e74 = input_4[_e71];
        local_50 = _e74;
        let _e76 = local_50;
        local_35 = _e76;
        let _e78 = local_35;
        local_33 = _e78;
        let _e80 = local_33;
        local_1 = _e80;
        let _e82 = local_1;
        entry = _e82;
        let _e84 = entry;
        if (_e84 != 0i) {
        } else {
            break;
        }
        {
            let _e87 = entry;
            if (_e87 == 1i) {
                entry = 99i;
                continue;
            }
            let _e91 = entry;
            let _e92 = total;
            total = (_e92 + _e91);
        }
    }
    let _e94 = total;
    let _e97 = output;
    local_2 = _e97;
    let _e99 = local_2;
    local_51 = _e99;
    let _e102 = local_51[1];
    local_51[1] = (_e102 + base);
    let _e106 = local_51[0];
    local_52 = u32(_e106);
    let _e110 = local_51[1];
    local_53 = u32(_e110);
    let _e113 = local_53;
    output_1[_e113] = u32(_e94);
    let _e116 = cursor;
    let _e118 = output;
    local_3 = _e118;
    local_4 = u32((base + 1u));
    let _e124 = local_3;
    local_54 = _e124;
    let _e126 = local_4;
    let _e128 = local_54[1];
    local_54[1] = (_e128 + _e126);
    let _e132 = local_54[0];
    local_55 = u32(_e132);
    let _e136 = local_54[1];
    local_56 = u32(_e136);
    let _e139 = local_56;
    output_1[_e139] = u32(_e116);
    inferred_cursor = 0i;
    inferred_total = 0i;
    loop {
        let _e146 = input;
        local_5 = _e146;
        offset_1 = u32();
        local_37 = u32();
        local_38 = i32();
        let _e154 = local_5;
        input_2 = _e154;
        offset_1 = offset_3;
        let _e158 = input_2;
        local_36 = _e158;
        let _e160 = inferred_cursor;
        local_39 = _e160;
        let _e162 = local_39;
        inferred_cursor = (_e162 + 1i);
        let _e166 = offset_1;
        local_37 = u32((_e166 + u32(_e162)));
        let _e170 = local_36;
        local_57 = _e170;
        let _e172 = local_37;
        let _e174 = local_57[1];
        local_57[1] = (_e174 + _e172);
        let _e178 = local_57[0];
        local_58 = u32(_e178);
        let _e182 = local_57[1];
        local_59 = u32(_e182);
        let _e185 = local_59;
        let _e188 = input_4[_e185];
        local_60 = _e188;
        let _e190 = local_60;
        local_40 = _e190;
        let _e192 = local_40;
        local_38 = _e192;
        let _e194 = local_38;
        local_6 = _e194;
        let _e196 = local_6;
        entry_1 = _e196;
        let _e198 = entry_1;
        if (_e198 != 0i) {
        } else {
            break;
        }
        {
            let _e201 = entry_1;
            switch _e201 {
                case 1: {
                    entry_1 = 77i;
                    continue;
                }
                default: {
                    let _e203 = entry_1;
                    let _e204 = inferred_total;
                    inferred_total = (_e204 + _e203);
                    break;
                }
            }
        }
    }
    let _e206 = inferred_total;
    let _e208 = output;
    local_7 = _e208;
    local_8 = u32((base + 2u));
    let _e214 = local_7;
    local_61 = _e214;
    let _e216 = local_8;
    let _e218 = local_61[1];
    local_61[1] = (_e218 + _e216);
    let _e222 = local_61[0];
    local_62 = u32(_e222);
    let _e226 = local_61[1];
    local_63 = u32(_e226);
    let _e229 = local_63;
    output_1[_e229] = u32(_e206);
    let _e231 = inferred_cursor;
    let _e233 = output;
    local_9 = _e233;
    local_10 = u32((base + 3u));
    let _e239 = local_9;
    local_64 = _e239;
    let _e241 = local_10;
    let _e243 = local_64[1];
    local_64[1] = (_e243 + _e241);
    let _e247 = local_64[0];
    local_65 = u32(_e247);
    let _e251 = local_64[1];
    local_66 = u32(_e251);
    let _e254 = local_66;
    output_1[_e254] = u32(_e231);
    early_cursor = 0i;
    first = 0i;
    loop {
        let _e261 = input;
        local_11 = _e261;
        offset_2 = u32();
        local_42 = u32();
        local_43 = i32();
        let _e269 = local_11;
        input_3 = _e269;
        offset_2 = offset_3;
        let _e273 = input_3;
        local_41 = _e273;
        let _e275 = early_cursor;
        local_44 = _e275;
        let _e277 = local_44;
        early_cursor = (_e277 + 1i);
        let _e281 = offset_2;
        local_42 = u32((_e281 + u32(_e277)));
        let _e285 = local_41;
        local_67 = _e285;
        let _e287 = local_42;
        let _e289 = local_67[1];
        local_67[1] = (_e289 + _e287);
        let _e293 = local_67[0];
        local_68 = u32(_e293);
        let _e297 = local_67[1];
        local_69 = u32(_e297);
        let _e300 = local_69;
        let _e303 = input_4[_e300];
        local_70 = _e303;
        let _e305 = local_70;
        local_45 = _e305;
        let _e307 = local_45;
        local_43 = _e307;
        let _e309 = local_43;
        local_12 = _e309;
        let _e311 = local_12;
        entry_2 = _e311;
        let _e313 = entry_2;
        if (_e313 != 0i) {
        } else {
            break;
        }
        {
            let _e316 = entry_2;
            first = _e316;
            break;
        }
    }
    let _e317 = first;
    let _e319 = output;
    local_13 = _e319;
    local_14 = u32((base + 4u));
    let _e325 = local_13;
    local_71 = _e325;
    let _e327 = local_14;
    let _e329 = local_71[1];
    local_71[1] = (_e329 + _e327);
    let _e333 = local_71[0];
    local_72 = u32(_e333);
    let _e337 = local_71[1];
    local_73 = u32(_e337);
    let _e340 = local_73;
    output_1[_e340] = u32(_e317);
    let _e342 = early_cursor;
    let _e344 = output;
    local_15 = _e344;
    local_16 = u32((base + 5u));
    let _e350 = local_15;
    local_74 = _e350;
    let _e352 = local_16;
    let _e354 = local_74[1];
    local_74[1] = (_e354 + _e352);
    let _e358 = local_74[0];
    local_75 = u32(_e358);
    let _e362 = local_74[1];
    local_76 = u32(_e362);
    let _e365 = local_76;
    output_1[_e365] = u32(_e342);
    repeat = 0i;
    loop {
        fixed = 1i;
        let _e371 = fixed;
        if (_e371 != 0i) {
        } else {
            break;
        }
        {
            let _e374 = fixed;
            let _e375 = repeat;
            repeat = (_e375 + _e374);
            let _e377 = repeat;
            if (_e377 == 2i) {
                break;
            }
        }
    }
    let _e380 = repeat;
    let _e382 = output;
    local_17 = _e382;
    local_18 = u32((base + 6u));
    let _e388 = local_17;
    local_77 = _e388;
    let _e390 = local_18;
    let _e392 = local_77[1];
    local_77[1] = (_e392 + _e390);
    let _e396 = local_77[0];
    local_78 = u32(_e396);
    let _e400 = local_77[1];
    local_79 = u32(_e400);
    let _e403 = local_79;
    output_1[_e403] = u32(_e380);
    entry_3 = 50i;
    nested = 0i;
    loop {
        let _e410 = input;
        local_19 = _e410;
        local_20 = offset_3;
        let _e413 = local_19;
        local_80 = _e413;
        let _e415 = local_20;
        let _e417 = local_80[1];
        local_80[1] = (_e417 + _e415);
        let _e421 = local_80[0];
        local_81 = u32(_e421);
        let _e425 = local_80[1];
        local_82 = u32(_e425);
        let _e428 = local_82;
        let _e431 = input_4[_e428];
        local_83 = _e431;
        let _e433 = local_83;
        local_46 = _e433;
        let _e435 = local_46;
        entry_4 = _e435;
        let _e437 = entry_4;
        if (_e437 != 0i) {
        } else {
            break;
        }
        {
            {
                entry_5 = 9i;
                let _e442 = entry_5;
                let _e443 = nested;
                nested = (_e443 + _e442);
            }
            let _e445 = entry_4;
            let _e446 = nested;
            nested = (_e446 + _e445);
            break;
        }
    }
    let _e448 = nested;
    let _e450 = output;
    local_21 = _e450;
    local_22 = u32((base + 7u));
    let _e456 = local_21;
    local_84 = _e456;
    let _e458 = local_22;
    let _e460 = local_84[1];
    local_84[1] = (_e460 + _e458);
    let _e464 = local_84[0];
    local_85 = u32(_e464);
    let _e468 = local_84[1];
    local_86 = u32(_e468);
    let _e471 = local_86;
    output_1[_e471] = u32(_e448);
    let _e473 = entry_3;
    let _e475 = output;
    local_23 = _e475;
    local_24 = u32((base + 8u));
    let _e481 = local_23;
    local_87 = _e481;
    let _e483 = local_24;
    let _e485 = local_87[1];
    local_87[1] = (_e485 + _e483);
    let _e489 = local_87[0];
    local_88 = u32(_e489);
    let _e493 = local_87[1];
    local_89 = u32(_e493);
    let _e496 = local_89;
    output_1[_e496] = u32(_e473);
    false_count = 0i;
    loop {
        let _e500 = false_count;
        false_count = (_e500 + 1i);
        stopped = 0i;
        let _e505 = stopped;
        if (_e505 != 0i) {
        } else {
            break;
        }
        {
            let _e508 = total;
            total = (_e508 + 1i);
        }
    }
    let _e511 = false_count;
    let _e513 = output;
    local_25 = _e513;
    local_26 = u32((base + 9u));
    let _e519 = local_25;
    local_90 = _e519;
    let _e521 = local_26;
    let _e523 = local_90[1];
    local_90[1] = (_e523 + _e521);
    let _e527 = local_90[0];
    local_91 = u32(_e527);
    let _e531 = local_90[1];
    local_92 = u32(_e531);
    let _e534 = local_92;
    output_1[_e534] = u32(_e511);
    loop {
        fraction = 0.5f;
        let _e538 = fraction;
        let _e540 = gen__naga_fabsf(bitcast<u32>(_e538));
        if (_e540 != 0u) {
        } else {
            break;
        }
        {
            let _e543 = total;
            total = (_e543 + 1i);
            break;
        }
    }
    let _e546 = total;
    let _e548 = output;
    local_27 = _e548;
    local_28 = u32((base + 10u));
    let _e554 = local_27;
    local_93 = _e554;
    let _e556 = local_28;
    let _e558 = local_93[1];
    local_93[1] = (_e558 + _e556);
    let _e562 = local_93[0];
    local_94 = u32(_e562);
    let _e566 = local_93[1];
    local_95 = u32(_e566);
    let _e569 = local_95;
    output_1[_e569] = u32(_e546);
    let _e571 = cursor;
    let _e572 = inferred_cursor;
    let _e574 = early_cursor;
    let _e576 = false_count;
    let _e579 = output;
    local_29 = _e579;
    local_30 = u32((base + 11u));
    let _e585 = local_29;
    local_96 = _e585;
    let _e587 = local_30;
    let _e589 = local_96[1];
    local_96[1] = (_e589 + _e587);
    let _e593 = local_96[0];
    local_97 = u32(_e593);
    let _e597 = local_96[1];
    local_98 = u32(_e597);
    let _e600 = local_98;
    output_1[_e600] = u32((((_e571 + _e572) + _e574) + _e576));
}
