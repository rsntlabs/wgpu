@group(0) @binding(0)
var<storage, read_write> output_1: array<u32>;
@group(0) @binding(1)
var<storage> first_1: array<u32>;
@group(0) @binding(2)
var<storage> second_1: array<u32>;

@compute @workgroup_size(1, 1, 1)
fn nullable() {
    var output: array<u32, 2>;
    var first: array<u32, 2>;
    var second: array<u32, 2>;
    var local: array<u32, 2>;
    var local_1: u32;
    var selected: array<u32, 2>;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: array<u32, 2>;
    var saved: array<u32, 2>;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: array<u32, 2>;
    var local_10: bool;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: array<u32, 2>;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var local_16: array<u32, 2>;
    var local_17: bool;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: array<u32, 2>;
    var local_23: array<u32, 2>;
    var local_24: u32;
    var values: array<u32, 2>;
    var fallback: u32;
    var local_25: array<u32, 2>;
    var local_26: bool;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var values_1: array<u32, 2>;
    var fallback_1: u32;
    var local_32: array<u32, 2>;
    var local_33: bool;
    var local_34: array<u32, 2>;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var values_2: array<u32, 2>;
    var fallback_2: u32;
    var local_39: array<u32, 2>;
    var local_40: bool;
    var local_41: array<u32, 2>;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var local_46: array<u32, 2>;
    var local_47: u32;
    var local_48: u32;
    var local_49: array<u32, 2>;
    var local_50: array<u32, 2>;
    var local_51: array<u32, 2>;
    var local_52: array<u32, 2>;
    var local_53: array<u32, 2>;
    var local_54: u32;
    var local_55: u32;
    var local_56: array<u32, 2>;
    var local_57: array<u32, 2>;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: array<u32, 2>;
    var local_62: u32;
    var local_63: u32;
    var local_64: array<u32, 2>;
    var local_65: array<u32, 2>;
    var local_66: u32;
    var local_67: u32;
    var local_68: array<u32, 2>;
    var local_69: array<u32, 2>;
    var local_70: u32;
    var local_71: u32;
    var local_72: u32;
    var local_73: array<u32, 2>;
    var local_74: u32;
    var local_75: u32;
    var local_76: array<u32, 2>;
    var local_77: array<u32, 2>;
    var local_78: u32;
    var local_79: u32;
    var local_80: u32;
    var local_81: array<u32, 2>;
    var local_82: u32;
    var local_83: u32;

    output = array<u32, 2>();
    output[0] = 2u;
    output[1] = 0u;
    first = array<u32, 2>();
    first[0] = 3u;
    first[1] = 0u;
    second = array<u32, 2>();
    second[0] = 4u;
    second[1] = 0u;
    let _e19 = output;
    local = _e19;
    local_1 = u32(0i);
    let _e24 = local;
    local_46 = _e24;
    let _e26 = local_1;
    let _e28 = local_46[1];
    local_46[1] = (_e28 + _e26);
    let _e32 = local_46[0];
    local_47 = u32(_e32);
    let _e36 = local_46[1];
    local_48 = u32(_e36);
    let _e39 = local_48;
    let choice = output_1[_e39];
    selected = array<u32, 2>();
    selected[0] = 1u;
    if (choice == 1u) {
        let _e50 = first;
        local_2 = _e50;
        local_3 = u32(1i);
        let _e55 = local_2;
        local_49 = _e55;
        let _e57 = local_3;
        let _e59 = local_49[1];
        local_49[1] = (_e59 + _e57);
        let _e62 = local_49;
        selected = _e62;
    } else {
        if (choice == 2u) {
            let _e67 = second;
            local_4 = _e67;
            local_5 = u32(1i);
            let _e72 = local_4;
            local_50 = _e72;
            let _e74 = local_5;
            let _e76 = local_50[1];
            local_50[1] = (_e76 + _e74);
            let _e79 = local_50;
            selected = _e79;
        }
    }
    let _e82 = selected;
    local_6 = _e82;
    let _e84 = local_6;
    saved = _e84;
    local_51 = array<u32, 2>();
    local_51[0] = 1u;
    let _e90 = local_51;
    selected = _e90;
    let _e91 = selected;
    local_9 = _e91;
    let _e93 = local_9;
    local_52 = _e93;
    let _e96 = local_52[0];
    local_10 = (_e96 != 1u);
    let _e100 = local_10;
    let _e102 = output;
    local_7 = _e102;
    local_8 = u32(1i);
    let _e107 = local_7;
    local_53 = _e107;
    let _e109 = local_8;
    let _e111 = local_53[1];
    local_53[1] = (_e111 + _e109);
    let _e115 = local_53[0];
    local_54 = u32(_e115);
    let _e119 = local_53[1];
    local_55 = u32(_e119);
    let _e122 = local_55;
    output_1[_e122] = u32(_e100);
    let _e125 = saved;
    local_13 = _e125;
    fallback = u32();
    local_26 = bool();
    local_28 = u32();
    local_29 = u32();
    local_30 = u32();
    let _e137 = local_13;
    values = _e137;
    fallback = 17u;
    let _e142 = values;
    local_25 = _e142;
    let _e144 = local_25;
    local_56 = _e144;
    let _e147 = local_56[0];
    local_26 = (_e147 != 1u);
    let _e151 = local_26;
    if _e151 {
        let _e152 = values;
        local_27 = _e152;
        local_28 = u32(0i);
        let _e157 = local_27;
        local_57 = _e157;
        let _e159 = local_28;
        let _e161 = local_57[1];
        local_57[1] = (_e161 + _e159);
        let _e165 = local_57[0];
        local_58 = u32(_e165);
        let _e169 = local_57[1];
        local_59 = u32(_e169);
        local_60 = u32();
        let _e174 = local_58;
        switch _e174 {
            case 4u: {
                let _e175 = local_59;
                let _e178 = second_1[_e175];
                local_60 = _e178;
            }
            case 3u: {
                let _e179 = local_59;
                let _e182 = first_1[_e179];
                local_60 = _e182;
            }
            default: {
            }
        }
        let _e183 = local_60;
        local_31 = _e183;
        let _e185 = local_31;
        local_30 = _e185;
        let _e187 = local_30;
        local_29 = _e187;
    } else {
        let _e189 = fallback;
        local_29 = _e189;
    }
    let _e192 = local_29;
    let _e193 = output;
    local_11 = _e193;
    local_12 = u32(2i);
    let _e198 = local_11;
    local_61 = _e198;
    let _e200 = local_12;
    let _e202 = local_61[1];
    local_61[1] = (_e202 + _e200);
    let _e206 = local_61[0];
    local_62 = u32(_e206);
    let _e210 = local_61[1];
    local_63 = u32(_e210);
    let _e213 = local_63;
    output_1[_e213] = _e192;
    let _e215 = saved;
    local_16 = _e215;
    let _e217 = local_16;
    local_64 = _e217;
    let _e220 = local_64[0];
    local_17 = (_e220 == 1u);
    let _e224 = local_17;
    let _e226 = output;
    local_14 = _e226;
    local_15 = u32(3i);
    let _e231 = local_14;
    local_65 = _e231;
    let _e233 = local_15;
    let _e235 = local_65[1];
    local_65[1] = (_e235 + _e233);
    let _e239 = local_65[0];
    local_66 = u32(_e239);
    let _e243 = local_65[1];
    local_67 = u32(_e243);
    let _e246 = local_67;
    output_1[_e246] = u32(_e224);
    if (choice != 0u) {
        let _e251 = first;
        local_22 = _e251;
        local_21 = 0u;
        local_20 = 1u;
    } else {
        local_21 = 0u;
        local_20 = 0u;
    }
    fallback_1 = u32();
    local_33 = bool();
    local_35 = u32();
    local_36 = u32();
    local_37 = u32();
    let _e272 = local_20;
    if (_e272 != 0u) {
        let _e276 = local_22;
        values_1 = _e276;
    } else {
        values_1 = array<u32, 2>();
        values_1[0] = 1u;
    }
    let _e283 = local_21;
    let _e286 = values_1[1];
    values_1[1] = (_e286 + _e283);
    fallback_1 = 19u;
    let _e292 = values_1;
    local_32 = _e292;
    let _e294 = local_32;
    local_68 = _e294;
    let _e297 = local_68[0];
    local_33 = (_e297 != 1u);
    let _e301 = local_33;
    if _e301 {
        let _e302 = values_1;
        local_34 = _e302;
        local_35 = u32(0i);
        let _e307 = local_34;
        local_69 = _e307;
        let _e309 = local_35;
        let _e311 = local_69[1];
        local_69[1] = (_e311 + _e309);
        let _e315 = local_69[0];
        local_70 = u32(_e315);
        let _e319 = local_69[1];
        local_71 = u32(_e319);
        local_72 = u32();
        let _e324 = local_70;
        switch _e324 {
            case 3u: {
                let _e325 = local_71;
                let _e328 = first_1[_e325];
                local_72 = _e328;
            }
            default: {
            }
        }
        let _e329 = local_72;
        local_38 = _e329;
        let _e331 = local_38;
        local_37 = _e331;
        let _e333 = local_37;
        local_36 = _e333;
    } else {
        let _e335 = fallback_1;
        local_36 = _e335;
    }
    let _e338 = local_36;
    let _e339 = output;
    local_18 = _e339;
    local_19 = u32(4i);
    let _e344 = local_18;
    local_73 = _e344;
    let _e346 = local_19;
    let _e348 = local_73[1];
    local_73[1] = (_e348 + _e346);
    let _e352 = local_73[0];
    local_74 = u32(_e352);
    let _e356 = local_73[1];
    local_75 = u32(_e356);
    let _e359 = local_75;
    output_1[_e359] = _e338;
    fallback_2 = u32();
    local_40 = bool();
    local_42 = u32();
    local_43 = u32();
    local_44 = u32();
    values_2 = array<u32, 2>();
    values_2[0] = 1u;
    fallback_2 = 23u;
    let _e378 = values_2;
    local_39 = _e378;
    let _e380 = local_39;
    local_76 = _e380;
    let _e383 = local_76[0];
    local_40 = (_e383 != 1u);
    let _e387 = local_40;
    if _e387 {
        let _e388 = values_2;
        local_41 = _e388;
        local_42 = u32(0i);
        let _e393 = local_41;
        local_77 = _e393;
        let _e395 = local_42;
        let _e397 = local_77[1];
        local_77[1] = (_e397 + _e395);
        let _e401 = local_77[0];
        local_78 = u32(_e401);
        let _e405 = local_77[1];
        local_79 = u32(_e405);
        local_80 = u32();
        let _e410 = local_80;
        local_45 = _e410;
        let _e412 = local_45;
        local_44 = _e412;
        let _e414 = local_44;
        local_43 = _e414;
    } else {
        let _e416 = fallback_2;
        local_43 = _e416;
    }
    let _e419 = local_43;
    let _e420 = output;
    local_23 = _e420;
    local_24 = u32(5i);
    let _e425 = local_23;
    local_81 = _e425;
    let _e427 = local_24;
    let _e429 = local_81[1];
    local_81[1] = (_e429 + _e427);
    let _e433 = local_81[0];
    local_82 = u32(_e433);
    let _e437 = local_81[1];
    local_83 = u32(_e437);
    let _e440 = local_83;
    output_1[_e440] = _e419;
}
