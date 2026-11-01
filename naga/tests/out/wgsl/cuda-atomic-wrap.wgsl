@group(0) @binding(0)
var<storage, read_write> output: array<atomic<u32>>;

@compute @workgroup_size(1, 1, 1)
fn kernel() {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
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
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var index: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;
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
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;
    var local_66: u32;
    var local_67: u32;
    var local_68: u32;
    var local_69: u32;
    var local_70: u32;
    var local_71: u32;
    var local_72: u32;
    var local_73: u32;
    var local_74: u32;
    var local_75: u32;
    var local_76: u32;
    var local_77: u32;
    var local_78: u32;
    var local_79: u32;
    var local_80: u32;
    var local_81: u32;
    var local_82: u32;
    var local_83: u32;
    var local_84: u32;
    var local_85: u32;
    var local_86: u32;
    var local_87: u32;
    var local_88: u32;
    var local_89: u32;
    var local_90: u32;
    var local_91: u32;
    var local_92: u32;
    var local_93: u32;
    var local_94: u32;
    var local_95: u32;
    var local_96: u32;
    var local_97: u32;

    local = 0u;
    let _e2 = local;
    let _e4 = u32(0u);
    let _e8 = atomicAdd((&output[_e4]), 0u);
    local_1 = _e8;
    loop {
        let _e10 = local_1;
        loop {
            let _e16 = atomicCompareExchangeWeak((&output[_e4]), _e10, select((_e10 + 1u), 0u, (_e10 >= _e2)));
            local_74 = _e16.old_value;
            if (_e16.exchanged || (_e16.old_value != _e10)) {
                break;
            }
        }
        let _e23 = local_74;
        local_47 = _e23;
        let _e25 = local_47;
        local_1 = _e25;
        if (_e25 == _e10) {
            break;
        }
    }
    let _e27 = local_1;
    atomicStore((&output[u32(16i)]), _e27);
    let _e32 = u32(1i);
    local_2 = u32(1.75f);
    let _e36 = local_2;
    let _e39 = atomicAdd((&output[_e32]), 0u);
    local_3 = _e39;
    loop {
        let _e41 = local_3;
        loop {
            let _e47 = atomicCompareExchangeWeak((&output[_e32]), _e41, select((_e41 + 1u), 0u, (_e41 >= _e36)));
            local_75 = _e47.old_value;
            if (_e47.exchanged || (_e47.old_value != _e41)) {
                break;
            }
        }
        let _e54 = local_75;
        local_48 = _e54;
        let _e56 = local_48;
        local_3 = _e56;
        if (_e56 == _e41) {
            break;
        }
    }
    let _e58 = local_3;
    atomicStore((&output[u32(17i)]), _e58);
    let _e63 = u32(2i);
    local_4 = 1u;
    let _e66 = local_4;
    let _e69 = atomicAdd((&output[_e63]), 0u);
    local_5 = _e69;
    loop {
        let _e71 = local_5;
        loop {
            let _e77 = atomicCompareExchangeWeak((&output[_e63]), _e71, select((_e71 + 1u), 0u, (_e71 >= _e66)));
            local_76 = _e77.old_value;
            if (_e77.exchanged || (_e77.old_value != _e71)) {
                break;
            }
        }
        let _e84 = local_76;
        local_49 = _e84;
        let _e86 = local_49;
        local_5 = _e86;
        if (_e86 == _e71) {
            break;
        }
    }
    let _e88 = local_5;
    atomicStore((&output[u32(18i)]), _e88);
    let _e93 = u32(3i);
    local_6 = 1u;
    let _e96 = local_6;
    let _e99 = atomicAdd((&output[_e93]), 0u);
    local_7 = _e99;
    loop {
        let _e101 = local_7;
        loop {
            let _e107 = atomicCompareExchangeWeak((&output[_e93]), _e101, select((_e101 + 1u), 0u, (_e101 >= _e96)));
            local_77 = _e107.old_value;
            if (_e107.exchanged || (_e107.old_value != _e101)) {
                break;
            }
        }
        let _e114 = local_77;
        local_50 = _e114;
        let _e116 = local_50;
        local_7 = _e116;
        if (_e116 == _e101) {
            break;
        }
    }
    let _e118 = local_7;
    atomicStore((&output[u32(19i)]), _e118);
    let _e123 = u32(4i);
    local_8 = u32(-(1i));
    let _e128 = local_8;
    let _e131 = atomicAdd((&output[_e123]), 0u);
    local_9 = _e131;
    loop {
        let _e133 = local_9;
        loop {
            let _e139 = atomicCompareExchangeWeak((&output[_e123]), _e133, select((_e133 + 1u), 0u, (_e133 >= _e128)));
            local_78 = _e139.old_value;
            if (_e139.exchanged || (_e139.old_value != _e133)) {
                break;
            }
        }
        let _e146 = local_78;
        local_51 = _e146;
        let _e148 = local_51;
        local_9 = _e148;
        if (_e148 == _e133) {
            break;
        }
    }
    let _e150 = local_9;
    atomicStore((&output[u32(20i)]), _e150);
    let _e155 = u32(5i);
    local_10 = 4294967295u;
    let _e158 = local_10;
    let _e161 = atomicAdd((&output[_e155]), 0u);
    local_11 = _e161;
    loop {
        let _e163 = local_11;
        loop {
            let _e169 = atomicCompareExchangeWeak((&output[_e155]), _e163, select((_e163 + 1u), 0u, (_e163 >= _e158)));
            local_79 = _e169.old_value;
            if (_e169.exchanged || (_e169.old_value != _e163)) {
                break;
            }
        }
        let _e176 = local_79;
        local_52 = _e176;
        let _e178 = local_52;
        local_11 = _e178;
        if (_e178 == _e163) {
            break;
        }
    }
    let _e180 = local_11;
    atomicStore((&output[u32(21i)]), _e180);
    let _e185 = u32(6i);
    local_12 = 2147483648u;
    let _e188 = local_12;
    let _e191 = atomicAdd((&output[_e185]), 0u);
    local_13 = _e191;
    loop {
        let _e193 = local_13;
        loop {
            let _e199 = atomicCompareExchangeWeak((&output[_e185]), _e193, select((_e193 + 1u), 0u, (_e193 >= _e188)));
            local_80 = _e199.old_value;
            if (_e199.exchanged || (_e199.old_value != _e193)) {
                break;
            }
        }
        let _e206 = local_80;
        local_53 = _e206;
        let _e208 = local_53;
        local_13 = _e208;
        if (_e208 == _e193) {
            break;
        }
    }
    let _e210 = local_13;
    atomicStore((&output[u32(22i)]), _e210);
    let _e215 = u32(7i);
    local_14 = 2147483648u;
    let _e218 = local_14;
    let _e221 = atomicAdd((&output[_e215]), 0u);
    local_15 = _e221;
    loop {
        let _e223 = local_15;
        loop {
            let _e229 = atomicCompareExchangeWeak((&output[_e215]), _e223, select((_e223 + 1u), 0u, (_e223 >= _e218)));
            local_81 = _e229.old_value;
            if (_e229.exchanged || (_e229.old_value != _e223)) {
                break;
            }
        }
        let _e236 = local_81;
        local_54 = _e236;
        let _e238 = local_54;
        local_15 = _e238;
        if (_e238 == _e223) {
            break;
        }
    }
    let _e240 = local_15;
    atomicStore((&output[u32(23i)]), _e240);
    let _e245 = u32(8i);
    local_16 = 0u;
    let _e248 = local_16;
    let _e251 = atomicAdd((&output[_e245]), 0u);
    local_17 = _e251;
    loop {
        let _e253 = local_17;
        loop {
            let _e261 = atomicCompareExchangeWeak((&output[_e245]), _e253, select((_e253 - 1u), _e248, ((_e253 == 0u) || (_e253 > _e248))));
            local_82 = _e261.old_value;
            if (_e261.exchanged || (_e261.old_value != _e253)) {
                break;
            }
        }
        let _e268 = local_82;
        local_55 = _e268;
        let _e270 = local_55;
        local_17 = _e270;
        if (_e270 == _e253) {
            break;
        }
    }
    let _e272 = local_17;
    atomicStore((&output[u32(24i)]), _e272);
    let _e277 = u32(9i);
    local_18 = u32(1.75f);
    let _e281 = local_18;
    let _e284 = atomicAdd((&output[_e277]), 0u);
    local_19 = _e284;
    loop {
        let _e286 = local_19;
        loop {
            let _e294 = atomicCompareExchangeWeak((&output[_e277]), _e286, select((_e286 - 1u), _e281, ((_e286 == 0u) || (_e286 > _e281))));
            local_83 = _e294.old_value;
            if (_e294.exchanged || (_e294.old_value != _e286)) {
                break;
            }
        }
        let _e301 = local_83;
        local_56 = _e301;
        let _e303 = local_56;
        local_19 = _e303;
        if (_e303 == _e286) {
            break;
        }
    }
    let _e305 = local_19;
    atomicStore((&output[u32(25i)]), _e305);
    let _e310 = u32(10i);
    local_20 = 1u;
    let _e313 = local_20;
    let _e316 = atomicAdd((&output[_e310]), 0u);
    local_21 = _e316;
    loop {
        let _e318 = local_21;
        loop {
            let _e326 = atomicCompareExchangeWeak((&output[_e310]), _e318, select((_e318 - 1u), _e313, ((_e318 == 0u) || (_e318 > _e313))));
            local_84 = _e326.old_value;
            if (_e326.exchanged || (_e326.old_value != _e318)) {
                break;
            }
        }
        let _e333 = local_84;
        local_57 = _e333;
        let _e335 = local_57;
        local_21 = _e335;
        if (_e335 == _e318) {
            break;
        }
    }
    let _e337 = local_21;
    atomicStore((&output[u32(26i)]), _e337);
    let _e342 = u32(11i);
    local_22 = 1u;
    let _e345 = local_22;
    let _e348 = atomicAdd((&output[_e342]), 0u);
    local_23 = _e348;
    loop {
        let _e350 = local_23;
        loop {
            let _e358 = atomicCompareExchangeWeak((&output[_e342]), _e350, select((_e350 - 1u), _e345, ((_e350 == 0u) || (_e350 > _e345))));
            local_85 = _e358.old_value;
            if (_e358.exchanged || (_e358.old_value != _e350)) {
                break;
            }
        }
        let _e365 = local_85;
        local_58 = _e365;
        let _e367 = local_58;
        local_23 = _e367;
        if (_e367 == _e350) {
            break;
        }
    }
    let _e369 = local_23;
    atomicStore((&output[u32(27i)]), _e369);
    let _e374 = u32(12i);
    local_24 = u32(-(1i));
    let _e379 = local_24;
    let _e382 = atomicAdd((&output[_e374]), 0u);
    local_25 = _e382;
    loop {
        let _e384 = local_25;
        loop {
            let _e392 = atomicCompareExchangeWeak((&output[_e374]), _e384, select((_e384 - 1u), _e379, ((_e384 == 0u) || (_e384 > _e379))));
            local_86 = _e392.old_value;
            if (_e392.exchanged || (_e392.old_value != _e384)) {
                break;
            }
        }
        let _e399 = local_86;
        local_59 = _e399;
        let _e401 = local_59;
        local_25 = _e401;
        if (_e401 == _e384) {
            break;
        }
    }
    let _e403 = local_25;
    atomicStore((&output[u32(28i)]), _e403);
    let _e408 = u32(13i);
    local_26 = 4294967295u;
    let _e411 = local_26;
    let _e414 = atomicAdd((&output[_e408]), 0u);
    local_27 = _e414;
    loop {
        let _e416 = local_27;
        loop {
            let _e424 = atomicCompareExchangeWeak((&output[_e408]), _e416, select((_e416 - 1u), _e411, ((_e416 == 0u) || (_e416 > _e411))));
            local_87 = _e424.old_value;
            if (_e424.exchanged || (_e424.old_value != _e416)) {
                break;
            }
        }
        let _e431 = local_87;
        local_60 = _e431;
        let _e433 = local_60;
        local_27 = _e433;
        if (_e433 == _e416) {
            break;
        }
    }
    let _e435 = local_27;
    atomicStore((&output[u32(29i)]), _e435);
    let _e440 = u32(14i);
    local_28 = 1u;
    let _e443 = local_28;
    let _e446 = atomicAdd((&output[_e440]), 0u);
    local_29 = _e446;
    loop {
        let _e448 = local_29;
        loop {
            let _e456 = atomicCompareExchangeWeak((&output[_e440]), _e448, select((_e448 - 1u), _e443, ((_e448 == 0u) || (_e448 > _e443))));
            local_88 = _e456.old_value;
            if (_e456.exchanged || (_e456.old_value != _e448)) {
                break;
            }
        }
        let _e463 = local_88;
        local_61 = _e463;
        let _e465 = local_61;
        local_29 = _e465;
        if (_e465 == _e448) {
            break;
        }
    }
    let _e467 = local_29;
    atomicStore((&output[u32(30i)]), _e467);
    let _e472 = u32(15i);
    local_30 = 2147483648u;
    let _e475 = local_30;
    let _e478 = atomicAdd((&output[_e472]), 0u);
    local_31 = _e478;
    loop {
        let _e480 = local_31;
        loop {
            let _e488 = atomicCompareExchangeWeak((&output[_e472]), _e480, select((_e480 - 1u), _e475, ((_e480 == 0u) || (_e480 > _e475))));
            local_89 = _e488.old_value;
            if (_e488.exchanged || (_e488.old_value != _e480)) {
                break;
            }
        }
        let _e495 = local_89;
        local_62 = _e495;
        let _e497 = local_62;
        local_31 = _e497;
        if (_e497 == _e480) {
            break;
        }
    }
    let _e499 = local_31;
    atomicStore((&output[u32(31i)]), _e499);
    {
        index = u32(0i);
        loop {
            let _e506 = index;
            if (_e506 < 16u) {
            } else {
                break;
            }
            let _e509 = index;
            local_33 = _e509;
            let _e511 = local_33;
            local_63 = _e511;
            let _e513 = local_63;
            let _e515 = atomicLoad((&output[_e513]));
            local_64 = _e515;
            let _e517 = local_64;
            local_46 = _e517;
            let _e519 = local_46;
            let _e520 = index;
            local_32 = u32((32u + _e520));
            let _e525 = local_32;
            local_65 = _e525;
            let _e527 = local_65;
            atomicStore((&output[_e527]), _e519);
            continuing {
                let _e529 = index;
                index = (_e529 + u32(1i));
            }
        }
    }
    local_34 = 1u;
    let _e535 = local_34;
    let _e537 = u32(0u);
    let _e540 = atomicAdd((&output[_e537]), 0u);
    local_35 = _e540;
    loop {
        let _e542 = local_35;
        loop {
            let _e548 = atomicCompareExchangeWeak((&output[_e537]), _e542, select((_e542 + 1u), 0u, (_e542 >= _e535)));
            local_90 = _e548.old_value;
            if (_e548.exchanged || (_e548.old_value != _e542)) {
                break;
            }
        }
        let _e555 = local_90;
        local_66 = _e555;
        let _e557 = local_66;
        local_35 = _e557;
        if (_e557 == _e542) {
            break;
        }
    }
    let _e560 = u32(8i);
    local_36 = 1u;
    let _e563 = local_36;
    let _e566 = atomicAdd((&output[_e560]), 0u);
    local_37 = _e566;
    loop {
        let _e568 = local_37;
        loop {
            let _e576 = atomicCompareExchangeWeak((&output[_e560]), _e568, select((_e568 - 1u), _e563, ((_e568 == 0u) || (_e568 > _e563))));
            local_91 = _e576.old_value;
            if (_e576.exchanged || (_e576.old_value != _e568)) {
                break;
            }
        }
        let _e583 = local_91;
        local_67 = _e583;
        let _e585 = local_67;
        local_37 = _e585;
        if (_e585 == _e568) {
            break;
        }
    }
    let _e590 = atomicLoad((&output[u32(0i)]));
    atomicStore((&output[u32(48i)]), _e590);
    let _e597 = atomicLoad((&output[u32(8i)]));
    atomicStore((&output[u32(49i)]), _e597);
    atomicStore((&output[u32(50i)]), 2u);
    let _e606 = u32(50i);
    let _e608 = u32(50i);
    let _e610 = atomicLoad((&output[_e608]));
    atomicStore((&output[_e608]), (_e610 + u32(1i)));
    let _e617 = atomicAdd((&output[_e606]), 0u);
    local_38 = _e617;
    loop {
        let _e619 = local_38;
        loop {
            let _e625 = atomicCompareExchangeWeak((&output[_e606]), _e619, select((_e619 + 1u), 0u, (_e619 >= _e610)));
            local_92 = _e625.old_value;
            if (_e625.exchanged || (_e625.old_value != _e619)) {
                break;
            }
        }
        let _e632 = local_92;
        local_68 = _e632;
        let _e634 = local_68;
        local_38 = _e634;
        if (_e634 == _e619) {
            break;
        }
    }
    let _e636 = local_38;
    atomicStore((&output[u32(51i)]), _e636);
    let _e643 = atomicLoad((&output[u32(50i)]));
    atomicStore((&output[u32(52i)]), _e643);
    let _e648 = u32(50i);
    let _e650 = u32(50i);
    let _e652 = atomicLoad((&output[_e650]));
    atomicStore((&output[_e650]), (_e652 + u32(1i)));
    let _e659 = atomicAdd((&output[_e648]), 0u);
    local_39 = _e659;
    loop {
        let _e661 = local_39;
        loop {
            let _e669 = atomicCompareExchangeWeak((&output[_e648]), _e661, select((_e661 - 1u), _e652, ((_e661 == 0u) || (_e661 > _e652))));
            local_93 = _e669.old_value;
            if (_e669.exchanged || (_e669.old_value != _e661)) {
                break;
            }
        }
        let _e676 = local_93;
        local_69 = _e676;
        let _e678 = local_69;
        local_39 = _e678;
        if (_e678 == _e661) {
            break;
        }
    }
    let _e680 = local_39;
    atomicStore((&output[u32(53i)]), _e680);
    let _e687 = atomicLoad((&output[u32(50i)]));
    atomicStore((&output[u32(54i)]), _e687);
    atomicStore((&output[u32(50i)]), 2u);
    let _e696 = u32(50i);
    let _e698 = u32(50i);
    local_40 = 3u;
    let _e701 = local_40;
    let _e704 = atomicAdd((&output[_e698]), 0u);
    local_41 = _e704;
    loop {
        let _e706 = local_41;
        loop {
            let _e712 = atomicCompareExchangeWeak((&output[_e698]), _e706, select((_e706 + 1u), 0u, (_e706 >= _e701)));
            local_94 = _e712.old_value;
            if (_e712.exchanged || (_e712.old_value != _e706)) {
                break;
            }
        }
        let _e719 = local_94;
        local_70 = _e719;
        let _e721 = local_70;
        local_41 = _e721;
        if (_e721 == _e706) {
            break;
        }
    }
    let _e723 = local_41;
    let _e726 = atomicAdd((&output[_e696]), 0u);
    local_42 = _e726;
    loop {
        let _e728 = local_42;
        loop {
            let _e736 = atomicCompareExchangeWeak((&output[_e696]), _e728, select((_e728 - 1u), _e723, ((_e728 == 0u) || (_e728 > _e723))));
            local_95 = _e736.old_value;
            if (_e736.exchanged || (_e736.old_value != _e728)) {
                break;
            }
        }
        let _e743 = local_95;
        local_71 = _e743;
        let _e745 = local_71;
        local_42 = _e745;
        if (_e745 == _e728) {
            break;
        }
    }
    let _e747 = local_42;
    atomicStore((&output[u32(55i)]), _e747);
    let _e754 = atomicLoad((&output[u32(50i)]));
    atomicStore((&output[u32(56i)]), _e754);
    let _e759 = u32(50i);
    let _e761 = u32(50i);
    local_43 = 3u;
    let _e764 = local_43;
    let _e767 = atomicAdd((&output[_e761]), 0u);
    local_44 = _e767;
    loop {
        let _e769 = local_44;
        loop {
            let _e777 = atomicCompareExchangeWeak((&output[_e761]), _e769, select((_e769 - 1u), _e764, ((_e769 == 0u) || (_e769 > _e764))));
            local_96 = _e777.old_value;
            if (_e777.exchanged || (_e777.old_value != _e769)) {
                break;
            }
        }
        let _e784 = local_96;
        local_72 = _e784;
        let _e786 = local_72;
        local_44 = _e786;
        if (_e786 == _e769) {
            break;
        }
    }
    let _e788 = local_44;
    let _e791 = atomicAdd((&output[_e759]), 0u);
    local_45 = _e791;
    loop {
        let _e793 = local_45;
        loop {
            let _e799 = atomicCompareExchangeWeak((&output[_e759]), _e793, select((_e793 + 1u), 0u, (_e793 >= _e788)));
            local_97 = _e799.old_value;
            if (_e799.exchanged || (_e799.old_value != _e793)) {
                break;
            }
        }
        let _e806 = local_97;
        local_73 = _e806;
        let _e808 = local_73;
        local_45 = _e808;
        if (_e808 == _e793) {
            break;
        }
    }
    let _e810 = local_45;
    atomicStore((&output[u32(57i)]), _e810);
    let _e817 = atomicLoad((&output[u32(50i)]));
    atomicStore((&output[u32(58i)]), _e817);
}
