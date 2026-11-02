#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_2_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std430) readonly buffer type_2_block_2Compute { uint _group_0_binding_2_cs[]; };


void main() {
    uint output_[2] = uint[2](0u, 0u);
    uint first[2] = uint[2](0u, 0u);
    uint second[2] = uint[2](0u, 0u);
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint selected[2] = uint[2](0u, 0u);
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    uint local_6[2] = uint[2](0u, 0u);
    uint saved[2] = uint[2](0u, 0u);
    uint local_7[2] = uint[2](0u, 0u);
    uint local_8 = 0u;
    uint local_9[2] = uint[2](0u, 0u);
    bool local_10 = false;
    uint local_11[2] = uint[2](0u, 0u);
    uint local_12 = 0u;
    uint local_13[2] = uint[2](0u, 0u);
    uint local_14[2] = uint[2](0u, 0u);
    uint local_15 = 0u;
    uint local_16[2] = uint[2](0u, 0u);
    bool local_17 = false;
    uint local_18[2] = uint[2](0u, 0u);
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22[2] = uint[2](0u, 0u);
    uint local_23[2] = uint[2](0u, 0u);
    uint local_24 = 0u;
    uint values[2] = uint[2](0u, 0u);
    uint fallback = 0u;
    uint local_25[2] = uint[2](0u, 0u);
    bool local_26 = false;
    uint local_27[2] = uint[2](0u, 0u);
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint values_1[2] = uint[2](0u, 0u);
    uint fallback_1 = 0u;
    uint local_32[2] = uint[2](0u, 0u);
    bool local_33 = false;
    uint local_34[2] = uint[2](0u, 0u);
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint values_2[2] = uint[2](0u, 0u);
    uint fallback_2 = 0u;
    uint local_39[2] = uint[2](0u, 0u);
    bool local_40 = false;
    uint local_41[2] = uint[2](0u, 0u);
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46[2] = uint[2](0u, 0u);
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49[2] = uint[2](0u, 0u);
    uint local_50[2] = uint[2](0u, 0u);
    uint local_51[2] = uint[2](0u, 0u);
    uint local_52[2] = uint[2](0u, 0u);
    uint local_53[2] = uint[2](0u, 0u);
    uint local_54 = 0u;
    uint local_55 = 0u;
    uint local_56[2] = uint[2](0u, 0u);
    uint local_57[2] = uint[2](0u, 0u);
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61[2] = uint[2](0u, 0u);
    uint local_62 = 0u;
    uint local_63 = 0u;
    uint local_64[2] = uint[2](0u, 0u);
    uint local_65[2] = uint[2](0u, 0u);
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68[2] = uint[2](0u, 0u);
    uint local_69[2] = uint[2](0u, 0u);
    uint local_70 = 0u;
    uint local_71 = 0u;
    uint local_72 = 0u;
    uint local_73[2] = uint[2](0u, 0u);
    uint local_74 = 0u;
    uint local_75 = 0u;
    uint local_76[2] = uint[2](0u, 0u);
    uint local_77[2] = uint[2](0u, 0u);
    uint local_78 = 0u;
    uint local_79 = 0u;
    uint local_80 = 0u;
    uint local_81[2] = uint[2](0u, 0u);
    uint local_82 = 0u;
    uint local_83 = 0u;
    output_ = uint[2](0u, 0u);
    output_[0] = 2u;
    output_[1] = 0u;
    first = uint[2](0u, 0u);
    first[0] = 3u;
    first[1] = 0u;
    second = uint[2](0u, 0u);
    second[0] = 4u;
    second[1] = 0u;
    uint _e19[2] = output_;
    local = _e19;
    local_1 = uint(0);
    uint _e24[2] = local;
    local_46 = _e24;
    uint _e26 = local_1;
    uint _e28 = local_46[1];
    local_46[1] = (_e28 + _e26);
    uint _e32 = local_46[0];
    local_47 = uint(_e32);
    uint _e36 = local_46[1];
    local_48 = uint(_e36);
    uint _e39 = local_48;
    uint choice = _group_0_binding_0_cs[_e39];
    selected = uint[2](0u, 0u);
    selected[0] = 1u;
    if ((choice == 1u)) {
        uint _e50[2] = first;
        local_2 = _e50;
        local_3 = uint(1);
        uint _e55[2] = local_2;
        local_49 = _e55;
        uint _e57 = local_3;
        uint _e59 = local_49[1];
        local_49[1] = (_e59 + _e57);
        uint _e62[2] = local_49;
        selected = _e62;
    } else {
        if ((choice == 2u)) {
            uint _e67[2] = second;
            local_4 = _e67;
            local_5 = uint(1);
            uint _e72[2] = local_4;
            local_50 = _e72;
            uint _e74 = local_5;
            uint _e76 = local_50[1];
            local_50[1] = (_e76 + _e74);
            uint _e79[2] = local_50;
            selected = _e79;
        }
    }
    uint _e82[2] = selected;
    local_6 = _e82;
    uint _e84[2] = local_6;
    saved = _e84;
    local_51 = uint[2](0u, 0u);
    local_51[0] = 1u;
    uint _e90[2] = local_51;
    selected = _e90;
    uint _e91[2] = selected;
    local_9 = _e91;
    uint _e93[2] = local_9;
    local_52 = _e93;
    uint _e96 = local_52[0];
    local_10 = (_e96 != 1u);
    bool _e100 = local_10;
    uint _e102[2] = output_;
    local_7 = _e102;
    local_8 = uint(1);
    uint _e107[2] = local_7;
    local_53 = _e107;
    uint _e109 = local_8;
    uint _e111 = local_53[1];
    local_53[1] = (_e111 + _e109);
    uint _e115 = local_53[0];
    local_54 = uint(_e115);
    uint _e119 = local_53[1];
    local_55 = uint(_e119);
    uint _e122 = local_55;
    _group_0_binding_0_cs[_e122] = uint(_e100);
    uint _e125[2] = saved;
    local_13 = _e125;
    fallback = 0u;
    local_26 = false;
    local_28 = 0u;
    local_29 = 0u;
    local_30 = 0u;
    uint _e137[2] = local_13;
    values = _e137;
    fallback = 17u;
    uint _e142[2] = values;
    local_25 = _e142;
    uint _e144[2] = local_25;
    local_56 = _e144;
    uint _e147 = local_56[0];
    local_26 = (_e147 != 1u);
    bool _e151 = local_26;
    if (_e151) {
        uint _e152[2] = values;
        local_27 = _e152;
        local_28 = uint(0);
        uint _e157[2] = local_27;
        local_57 = _e157;
        uint _e159 = local_28;
        uint _e161 = local_57[1];
        local_57[1] = (_e161 + _e159);
        uint _e165 = local_57[0];
        local_58 = uint(_e165);
        uint _e169 = local_57[1];
        local_59 = uint(_e169);
        local_60 = 0u;
        uint _e174 = local_58;
        switch(_e174) {
            case 4u: {
                uint _e175 = local_59;
                uint _e178 = _group_0_binding_2_cs[_e175];
                local_60 = _e178;
                break;
            }
            case 3u: {
                uint _e179 = local_59;
                uint _e182 = _group_0_binding_1_cs[_e179];
                local_60 = _e182;
                break;
            }
            default: {
                break;
            }
        }
        uint _e183 = local_60;
        local_31 = _e183;
        uint _e185 = local_31;
        local_30 = _e185;
        uint _e187 = local_30;
        local_29 = _e187;
    } else {
        uint _e189 = fallback;
        local_29 = _e189;
    }
    uint _e192 = local_29;
    uint _e193[2] = output_;
    local_11 = _e193;
    local_12 = uint(2);
    uint _e198[2] = local_11;
    local_61 = _e198;
    uint _e200 = local_12;
    uint _e202 = local_61[1];
    local_61[1] = (_e202 + _e200);
    uint _e206 = local_61[0];
    local_62 = uint(_e206);
    uint _e210 = local_61[1];
    local_63 = uint(_e210);
    uint _e213 = local_63;
    _group_0_binding_0_cs[_e213] = _e192;
    uint _e215[2] = saved;
    local_16 = _e215;
    uint _e217[2] = local_16;
    local_64 = _e217;
    uint _e220 = local_64[0];
    local_17 = (_e220 == 1u);
    bool _e224 = local_17;
    uint _e226[2] = output_;
    local_14 = _e226;
    local_15 = uint(3);
    uint _e231[2] = local_14;
    local_65 = _e231;
    uint _e233 = local_15;
    uint _e235 = local_65[1];
    local_65[1] = (_e235 + _e233);
    uint _e239 = local_65[0];
    local_66 = uint(_e239);
    uint _e243 = local_65[1];
    local_67 = uint(_e243);
    uint _e246 = local_67;
    _group_0_binding_0_cs[_e246] = uint(_e224);
    if ((choice != 0u)) {
        uint _e251[2] = first;
        local_22 = _e251;
        local_21 = 0u;
        local_20 = 1u;
    } else {
        local_21 = 0u;
        local_20 = 0u;
    }
    fallback_1 = 0u;
    local_33 = false;
    local_35 = 0u;
    local_36 = 0u;
    local_37 = 0u;
    uint _e272 = local_20;
    if ((_e272 != 0u)) {
        uint _e276[2] = local_22;
        values_1 = _e276;
    } else {
        values_1 = uint[2](0u, 0u);
        values_1[0] = 1u;
    }
    uint _e283 = local_21;
    uint _e286 = values_1[1];
    values_1[1] = (_e286 + _e283);
    fallback_1 = 19u;
    uint _e292[2] = values_1;
    local_32 = _e292;
    uint _e294[2] = local_32;
    local_68 = _e294;
    uint _e297 = local_68[0];
    local_33 = (_e297 != 1u);
    bool _e301 = local_33;
    if (_e301) {
        uint _e302[2] = values_1;
        local_34 = _e302;
        local_35 = uint(0);
        uint _e307[2] = local_34;
        local_69 = _e307;
        uint _e309 = local_35;
        uint _e311 = local_69[1];
        local_69[1] = (_e311 + _e309);
        uint _e315 = local_69[0];
        local_70 = uint(_e315);
        uint _e319 = local_69[1];
        local_71 = uint(_e319);
        local_72 = 0u;
        uint _e324 = local_70;
        switch(_e324) {
            case 3u: {
                uint _e325 = local_71;
                uint _e328 = _group_0_binding_1_cs[_e325];
                local_72 = _e328;
                break;
            }
            default: {
                break;
            }
        }
        uint _e329 = local_72;
        local_38 = _e329;
        uint _e331 = local_38;
        local_37 = _e331;
        uint _e333 = local_37;
        local_36 = _e333;
    } else {
        uint _e335 = fallback_1;
        local_36 = _e335;
    }
    uint _e338 = local_36;
    uint _e339[2] = output_;
    local_18 = _e339;
    local_19 = uint(4);
    uint _e344[2] = local_18;
    local_73 = _e344;
    uint _e346 = local_19;
    uint _e348 = local_73[1];
    local_73[1] = (_e348 + _e346);
    uint _e352 = local_73[0];
    local_74 = uint(_e352);
    uint _e356 = local_73[1];
    local_75 = uint(_e356);
    uint _e359 = local_75;
    _group_0_binding_0_cs[_e359] = _e338;
    fallback_2 = 0u;
    local_40 = false;
    local_42 = 0u;
    local_43 = 0u;
    local_44 = 0u;
    values_2 = uint[2](0u, 0u);
    values_2[0] = 1u;
    fallback_2 = 23u;
    uint _e378[2] = values_2;
    local_39 = _e378;
    uint _e380[2] = local_39;
    local_76 = _e380;
    uint _e383 = local_76[0];
    local_40 = (_e383 != 1u);
    bool _e387 = local_40;
    if (_e387) {
        uint _e388[2] = values_2;
        local_41 = _e388;
        local_42 = uint(0);
        uint _e393[2] = local_41;
        local_77 = _e393;
        uint _e395 = local_42;
        uint _e397 = local_77[1];
        local_77[1] = (_e397 + _e395);
        uint _e401 = local_77[0];
        local_78 = uint(_e401);
        uint _e405 = local_77[1];
        local_79 = uint(_e405);
        local_80 = 0u;
        uint _e410 = local_80;
        local_45 = _e410;
        uint _e412 = local_45;
        local_44 = _e412;
        uint _e414 = local_44;
        local_43 = _e414;
    } else {
        uint _e416 = fallback_2;
        local_43 = _e416;
    }
    uint _e419 = local_43;
    uint _e420[2] = output_;
    local_23 = _e420;
    local_24 = uint(5);
    uint _e425[2] = local_23;
    local_81 = _e425;
    uint _e427 = local_24;
    uint _e429 = local_81[1];
    local_81[1] = (_e429 + _e427);
    uint _e433 = local_81[0];
    local_82 = uint(_e433);
    uint _e437 = local_81[1];
    local_83 = uint(_e437);
    uint _e440 = local_83;
    _group_0_binding_0_cs[_e440] = _e419;
}

