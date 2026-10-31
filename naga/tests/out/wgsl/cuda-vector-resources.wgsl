struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

@group(0) @binding(0)
var<storage> input: array<float3_>;
@group(0) @binding(1)
var<storage, read_write> output: array<float3_>;

fn shift(value: float3_) -> float3_ {
    var value_1: float3_;

    value_1 = value;
    let _e4 = value_1.x;
    value_1.x = (_e4 + 1f);
    let _e9 = value_1.y;
    let _e10 = value_1.z;
    value_1.z = (_e9 + _e10);
    let _e12 = value_1;
    return _e12;
}

fn pair(value_2: float3_, digit: i32) -> f32 {
    var value_3: float3_;

    value_3 = value_2;
    let _e4 = value_3.x;
    return ((_e4 * 10f) + f32(digit));
}

@compute @workgroup_size(1, 1, 1)
fn vector_resources() {
    var i: i32;
    var copied: float3_;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var index: i32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var choose_first: bool;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: f32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: f32;
    var local_22: u32;
    var local_23: u32;
    var local_24: float3_;
    var pick_local: bool;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var snapshot: float3_;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: float3_;
    var local_37: float3_;
    var local_38: float3_;
    var local_39: f32;
    var local_40: f32;
    var local_41: f32;
    var local_42: f32;
    var local_43: float3_;
    var local_44: f32;
    var local_45: f32;
    var local_46: float3_;
    var local_47: float3_;
    var local_48: u32;
    var local_49: float3_;
    var local_50: u32;
    var local_51: u32;
    var local_52: float3_;
    var local_53: u32;
    var local_54: u32;
    var local_55: float3_;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: f32;
    var local_64: u32;
    var local_65: f32;
    var local_66: u32;
    var local_67: f32;
    var local_68: u32;
    var local_69: f32;
    var local_70: u32;
    var local_71: u32;
    var local_72: u32;
    var local_73: float3_;
    var local_74: u32;
    var local_75: u32;
    var local_76: f32;
    var local_77: u32;
    var local_78: u32;
    var local_79: f32;
    var local_80: u32;
    var local_81: float3_;
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
    var local_92: float3_;
    var local_93: u32;
    var local_94: u32;

    {
        i = 0i;
        loop {
            let _e2 = i;
            if (_e2 < 3i) {
            } else {
                break;
            }
            let _e5 = i;
            local = u32(_e5);
            let _e8 = local;
            local_48 = u32(_e8);
            let _e11 = local_48;
            let _e14 = input[_e11];
            local_49 = _e14;
            let _e16 = local_49;
            local_36 = _e16;
            let _e18 = local_36;
            copied = _e18;
            let _e20 = copied;
            let _e21 = shift(_e20);
            let _e22 = i;
            local_1 = u32(_e22);
            let _e25 = local_1;
            local_50 = u32(_e25);
            let _e28 = local_50;
            output[_e28] = _e21;
            continuing {
                let _e31 = i;
                i = (_e31 + 1i);
            }
        }
    }
    local_3 = u32(0i);
    let _e37 = local_3;
    local_51 = u32(_e37);
    let _e40 = local_51;
    let _e43 = input[_e40];
    local_52 = _e43;
    let _e45 = local_52;
    local_37 = _e45;
    let _e47 = local_37;
    local_2 = u32(3i);
    let _e51 = local_2;
    local_53 = u32(_e51);
    let _e54 = local_53;
    output[_e54] = _e47;
    local_5 = u32(1i);
    let _e60 = local_5;
    local_54 = u32(_e60);
    let _e63 = local_54;
    let _e65 = input[_e63];
    local_55 = _e65;
    let _e67 = local_55;
    local_38 = _e67;
    let _e69 = local_38;
    let _e70 = shift(_e69);
    local_4 = u32(3i);
    let _e75 = local_4;
    local_56 = u32(_e75);
    let _e78 = local_56;
    output[_e78].y = _e70.x;
    index = 0i;
    index = 1i;
    local_7 = u32(2i);
    let _e87 = local_7;
    local_57 = u32(_e87);
    let _e90 = local_57;
    let _e93 = input[_e90].x;
    let _e94 = index;
    index = (_e94 + 1i);
    local_6 = u32(_e94);
    let _e99 = local_6;
    local_58 = u32(_e99);
    let _e102 = local_58;
    output[_e102].x = _e93;
    let _e105 = index;
    local_9 = u32(0i);
    let _e109 = local_9;
    local_59 = u32(_e109);
    let _e112 = local_59;
    let _e115 = input[_e112].x;
    local_10 = u32(1i);
    let _e119 = local_10;
    local_60 = u32(_e119);
    let _e122 = local_60;
    let _e125 = input[_e122].x;
    local_8 = u32(4i);
    let _e131 = local_8;
    local_61 = u32(_e131);
    let _e134 = local_61;
    output[_e134] = float3_(f32(_e105), _e115, _e125);
    choose_first = true;
    let _e138 = choose_first;
    if _e138 {
        local_11 = u32(0i);
        let _e142 = local_11;
        local_62 = u32(_e142);
        let _e145 = local_62;
        let _e148 = output[_e145].y;
        local_63 = _e148;
        let _e150 = local_63;
        local_39 = _e150;
        let _e152 = local_39;
        let _e155 = local_62;
        output[_e155].y = (_e152 + 2f);
    } else {
        local_12 = u32(2i);
        let _e161 = local_12;
        local_64 = u32(_e161);
        let _e164 = local_64;
        let _e167 = output[_e164].y;
        local_65 = _e167;
        let _e169 = local_65;
        local_40 = _e169;
        let _e171 = local_40;
        let _e174 = local_64;
        output[_e174].y = (_e171 + 2f);
    }
    let _e177 = choose_first;
    if _e177 {
        local_14 = u32(0i);
        let _e181 = local_14;
        local_66 = u32(_e181);
        let _e184 = local_66;
        let _e187 = output[_e184].z;
        local_67 = _e187;
        let _e189 = local_67;
        local_41 = _e189;
        let _e191 = local_41;
        let _e195 = local_66;
        output[_e195].z = (_e191 + f32(1i));
        local_16 = _e191;
    } else {
        local_15 = u32(2i);
        let _e202 = local_15;
        local_68 = u32(_e202);
        let _e205 = local_68;
        let _e208 = output[_e205].z;
        local_69 = _e208;
        let _e210 = local_69;
        local_42 = _e210;
        let _e212 = local_42;
        let _e216 = local_68;
        output[_e216].z = (_e212 + f32(1i));
        local_16 = _e212;
    }
    let _e221 = local_16;
    local_13 = u32(4i);
    let _e225 = local_13;
    local_70 = u32(_e225);
    let _e228 = local_70;
    output[_e228].x = _e221;
    let _e231 = index;
    local_17 = u32(4i);
    let _e236 = local_17;
    local_71 = u32(_e236);
    let _e239 = local_71;
    output[_e239].z = f32(_e231);
    local_20 = u32(1i);
    let _e245 = local_20;
    local_72 = u32(_e245);
    let _e248 = local_72;
    let _e250 = input[_e248];
    local_73 = _e250;
    let _e252 = local_73;
    local_43 = _e252;
    let _e254 = local_43;
    let _e255 = choose_first;
    if _e255 {
        local_18 = u32(0i);
        let _e259 = local_18;
        local_74 = u32(_e259);
        let _e262 = local_74;
        output[_e262] = _e254;
        let _e264 = local_18;
        local_75 = u32(_e264);
        let _e267 = local_75;
        let _e270 = output[_e267].x;
        local_76 = _e270;
        let _e272 = local_76;
        local_44 = _e272;
        let _e274 = local_44;
        let _e278 = local_75;
        output[_e278].x = (_e274 + f32(1i));
        local_21 = _e274;
    } else {
        local_19 = u32(2i);
        let _e285 = local_19;
        local_77 = u32(_e285);
        let _e288 = local_77;
        output[_e288] = _e254;
        let _e290 = local_19;
        local_78 = u32(_e290);
        let _e293 = local_78;
        let _e296 = output[_e293].x;
        local_79 = _e296;
        let _e298 = local_79;
        local_45 = _e298;
        let _e300 = local_45;
        let _e304 = local_78;
        output[_e304].x = (_e300 + f32(1i));
        local_21 = _e300;
    }
    local_23 = u32(0i);
    let _e311 = local_23;
    local_80 = u32(_e311);
    let _e314 = local_80;
    let _e316 = output[_e314];
    local_81 = _e316;
    let _e318 = local_81;
    local_46 = _e318;
    let _e320 = local_46;
    local_22 = u32(5i);
    let _e324 = local_22;
    local_82 = u32(_e324);
    let _e327 = local_82;
    output[_e327] = _e320;
    local_24 = float3_(f32(20i), f32(30i), f32(40i));
    pick_local = false;
    pick_local = true;
    let _e340 = pick_local;
    if _e340 {
        local_24.z = 7f;
    } else {
        local_25 = u32(1i);
        let _e346 = local_25;
        local_83 = u32(_e346);
        let _e349 = local_83;
        output[_e349].z = 7f;
    }
    let _e353 = local_24;
    local_26 = u32(6i);
    let _e357 = local_26;
    local_84 = u32(_e357);
    let _e360 = local_84;
    output[_e360] = _e353;
    local_28 = u32(1i);
    let _e365 = local_28;
    local_85 = u32(_e365);
    let _e368 = local_85;
    let _e371 = output[_e368].z;
    local_27 = u32(6i);
    let _e375 = local_27;
    local_86 = u32(_e375);
    let _e378 = local_86;
    output[_e378].x = _e371;
    local_30 = u32(0i);
    let _e384 = local_30;
    local_87 = u32(_e384);
    let _e387 = local_87;
    let _e390 = output[_e387].x;
    local_31 = u32(1i);
    let _e394 = local_31;
    local_88 = u32(_e394);
    let _e397 = local_88;
    let _e400 = output[_e397].x;
    local_32 = u32(2i);
    let _e404 = local_32;
    local_89 = u32(_e404);
    let _e407 = local_89;
    let _e410 = output[_e407].x;
    local_29 = u32(7i);
    let _e415 = local_29;
    local_90 = u32(_e415);
    let _e418 = local_90;
    output[_e418] = float3_(_e390, _e400, _e410);
    local_33 = u32(0i);
    let _e423 = local_33;
    local_91 = u32(_e423);
    let _e426 = local_91;
    let _e428 = input[_e426];
    local_92 = _e428;
    let _e430 = local_92;
    local_47 = _e430;
    let _e432 = local_47;
    snapshot = _e432;
    let _e434 = snapshot;
    snapshot.x = 9f;
    let _e438 = pair(_e434, 4i);
    let _e440 = snapshot.x;
    local_35 = u32(2i);
    let _e444 = local_35;
    local_93 = u32(_e444);
    let _e447 = local_93;
    let _e450 = input[_e447].z;
    local_34 = u32(8i);
    let _e455 = local_34;
    local_94 = u32(_e455);
    let _e458 = local_94;
    output[_e458] = float3_(_e438, _e440, _e450);
}
