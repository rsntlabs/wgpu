struct type_5 {
    value: f32,
}

struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

struct type_7 {
    value: u32,
}

var<private> threadIdx_1: vec3<u32>;
var<private> blockIdx_1: vec3<u32>;
var<private> gridDim_1: vec3<u32>;
@group(0) @binding(0)
var<storage> input: array<i32>;
@group(0) @binding(1)
var<uniform> scale_1: type_5;
@group(0) @binding(2)
var<storage> points: array<float3_>;
@group(0) @binding(3)
var<uniform> limit_1: type_7;
@group(0) @binding(4)
var<storage, read_write> out: array<u32>;

fn thread_component(axis: u32) -> u32 {
    var axis_1: u32;

    axis_1 = axis;
    let _e3 = axis_1;
    if (_e3 == 0u) {
        let _e6 = threadIdx_1;
        return _e6.x;
    }
    let _e9 = axis_1;
    if (_e9 == 1u) {
        let _e12 = threadIdx_1;
        return _e12.y;
    }
    let _e15 = threadIdx_1;
    return _e15.z;
}

fn group_component(axis_2: u32) -> u32 {
    var axis_3: u32;

    axis_3 = axis_2;
    let _e3 = axis_3;
    if (_e3 == 0u) {
        let _e6 = blockIdx_1;
        return _e6.x;
    }
    let _e9 = axis_3;
    if (_e9 == 1u) {
        let _e12 = blockIdx_1;
        return _e12.y;
    }
    let _e15 = blockIdx_1;
    return _e15.z;
}

fn shape_component(axis_4: u32) -> u32 {
    var axis_5: u32;

    axis_5 = axis_4;
    let _e3 = axis_5;
    if (_e3 == 0u) {
        return 1u;
    }
    let _e7 = axis_5;
    if (_e7 == 1u) {
        return 1u;
    }
    return 1u;
}

fn grid_component(axis_6: u32) -> u32 {
    var axis_7: u32;

    axis_7 = axis_6;
    let _e3 = axis_7;
    if (_e3 == 0u) {
        let _e6 = gridDim_1;
        return _e6.x;
    }
    let _e9 = axis_7;
    if (_e9 == 1u) {
        let _e12 = gridDim_1;
        return _e12.y;
    }
    let _e15 = gridDim_1;
    return _e15.z;
}

fn component(axis_8: u32) -> u32 {
    var axis_9: u32;

    axis_9 = axis_8;
    let _e2 = axis_9;
    let _e3 = thread_component(_e2);
    return _e3;
}

fn component_1(offset: f32) -> f32 {
    var offset_1: f32;

    offset_1 = offset;
    let _e3 = blockIdx_1;
    let _e6 = offset_1;
    return (f32(_e3.x) + _e6);
}

fn global_x() -> u32 {
    let _e1 = group_component(0u);
    let _e3 = shape_component(0u);
    let _e6 = component(0u);
    return ((_e1 * _e3) + _e6);
}

fn kind(value: u32) -> u32 {
    var value_1: u32;

    value_1 = value;
    return 11u;
}

fn observe() {
    let _e1 = gridDim_1;
    if (_e1.z != 0u) {
        return;
    } else {
        return;
    }
}

@compute @workgroup_size(1, 1, 1)
fn coordinates(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(num_workgroups) gridDim: vec3<u32>) {
    var local: u32;
    var scale: f32;
    var local_1: u32;
    var limit: u32;
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
    var local_98: u32;
    var local_99: u32;
    var local_100: u32;
    var local_101: u32;
    var local_102: u32;
    var local_103: u32;
    var local_104: u32;
    var local_105: u32;
    var local_106: u32;
    var local_107: u32;
    var local_108: u32;
    var local_109: u32;
    var local_110: u32;
    var local_111: u32;
    var local_112: u32;
    var local_113: u32;
    var local_114: u32;
    var local_115: u32;
    var local_116: u32;
    var local_117: u32;
    var local_118: u32;
    var local_119: u32;
    var local_120: u32;
    var local_121: u32;
    var local_122: u32;
    var local_123: u32;
    var local_124: u32;
    var local_125: u32;
    var local_126: u32;
    var local_127: u32;
    var local_128: u32;
    var local_129: u32;
    var local_130: u32;
    var local_131: i32;
    var local_132: u32;
    var local_133: u32;
    var local_134: u32;
    var local_135: f32;
    var local_136: u32;
    var local_137: u32;
    var local_138: f32;
    var local_139: u32;
    var local_140: u32;
    var local_141: f32;
    var local_142: u32;
    var local_143: u32;
    var local_144: u32;
    var local_145: u32;
    var local_146: u32;
    var local_147: i32;
    var local_148: u32;
    var local_149: f32;
    var local_150: u32;
    var local_151: u32;
    var local_152: u32;

    local = 0u;
    let _e7 = scale_1.value;
    scale = _e7;
    local_1 = 0u;
    let _e13 = limit_1.value;
    limit = _e13;
    local_2 = 0u;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    gridDim_1 = gridDim;
    let _e20 = global_x();
    let _e21 = limit;
    if (_e20 >= _e21) {
        return;
    }
    observe();
    let _e24 = thread_component(0u);
    let _e25 = local_2;
    local_3 = _e25;
    let _e27 = local_3;
    local_4 = u32(_e27);
    local_5 = u32(0i);
    let _e34 = local_4;
    let _e35 = local_5;
    local_111 = u32((_e34 + _e35));
    let _e39 = local_111;
    out[_e39] = _e24;
    let _e42 = thread_component(1u);
    let _e43 = local_2;
    local_6 = _e43;
    let _e45 = local_6;
    local_7 = u32(_e45);
    local_8 = u32(1i);
    let _e51 = local_7;
    let _e52 = local_8;
    local_112 = u32((_e51 + _e52));
    let _e56 = local_112;
    out[_e56] = _e42;
    let _e59 = thread_component(2u);
    let _e60 = local_2;
    local_9 = _e60;
    let _e62 = local_9;
    local_10 = u32(_e62);
    local_11 = u32(2i);
    let _e68 = local_10;
    let _e69 = local_11;
    local_113 = u32((_e68 + _e69));
    let _e73 = local_113;
    out[_e73] = _e59;
    let _e76 = group_component(0u);
    let _e77 = local_2;
    local_12 = _e77;
    let _e79 = local_12;
    local_13 = u32(_e79);
    local_14 = u32(3i);
    let _e85 = local_13;
    let _e86 = local_14;
    local_114 = u32((_e85 + _e86));
    let _e90 = local_114;
    out[_e90] = _e76;
    let _e93 = group_component(1u);
    let _e94 = local_2;
    local_15 = _e94;
    let _e96 = local_15;
    local_16 = u32(_e96);
    local_17 = u32(4i);
    let _e102 = local_16;
    let _e103 = local_17;
    local_115 = u32((_e102 + _e103));
    let _e107 = local_115;
    out[_e107] = _e93;
    let _e110 = group_component(2u);
    let _e111 = local_2;
    local_18 = _e111;
    let _e113 = local_18;
    local_19 = u32(_e113);
    local_20 = u32(5i);
    let _e119 = local_19;
    let _e120 = local_20;
    local_116 = u32((_e119 + _e120));
    let _e124 = local_116;
    out[_e124] = _e110;
    let _e127 = shape_component(0u);
    let _e128 = local_2;
    local_21 = _e128;
    let _e130 = local_21;
    local_22 = u32(_e130);
    local_23 = u32(6i);
    let _e136 = local_22;
    let _e137 = local_23;
    local_117 = u32((_e136 + _e137));
    let _e141 = local_117;
    out[_e141] = _e127;
    let _e144 = shape_component(1u);
    let _e145 = local_2;
    local_24 = _e145;
    let _e147 = local_24;
    local_25 = u32(_e147);
    local_26 = u32(7i);
    let _e153 = local_25;
    let _e154 = local_26;
    local_118 = u32((_e153 + _e154));
    let _e158 = local_118;
    out[_e158] = _e144;
    let _e161 = shape_component(2u);
    let _e162 = local_2;
    local_27 = _e162;
    let _e164 = local_27;
    local_28 = u32(_e164);
    local_29 = u32(8i);
    let _e170 = local_28;
    let _e171 = local_29;
    local_119 = u32((_e170 + _e171));
    let _e175 = local_119;
    out[_e175] = _e161;
    let _e178 = grid_component(0u);
    let _e179 = local_2;
    local_30 = _e179;
    let _e181 = local_30;
    local_31 = u32(_e181);
    local_32 = u32(9i);
    let _e187 = local_31;
    let _e188 = local_32;
    local_120 = u32((_e187 + _e188));
    let _e192 = local_120;
    out[_e192] = _e178;
    let _e195 = grid_component(1u);
    let _e196 = local_2;
    local_33 = _e196;
    let _e198 = local_33;
    local_34 = u32(_e198);
    local_35 = u32(10i);
    let _e204 = local_34;
    let _e205 = local_35;
    local_121 = u32((_e204 + _e205));
    let _e209 = local_121;
    out[_e209] = _e195;
    let _e212 = grid_component(2u);
    let _e213 = local_2;
    local_36 = _e213;
    let _e215 = local_36;
    local_37 = u32(_e215);
    local_38 = u32(11i);
    let _e221 = local_37;
    let _e222 = local_38;
    local_122 = u32((_e221 + _e222));
    let _e226 = local_122;
    out[_e226] = _e212;
    let _e228 = global_x();
    let _e229 = local_2;
    local_39 = _e229;
    let _e231 = local_39;
    local_40 = u32(_e231);
    local_41 = u32(12i);
    let _e237 = local_40;
    let _e238 = local_41;
    local_123 = u32((_e237 + _e238));
    let _e242 = local_123;
    out[_e242] = _e228;
    let _e245 = component(0u);
    let _e246 = local_2;
    local_42 = _e246;
    let _e248 = local_42;
    local_43 = u32(_e248);
    local_44 = u32(13i);
    let _e254 = local_43;
    let _e255 = local_44;
    local_124 = u32((_e254 + _e255));
    let _e259 = local_124;
    out[_e259] = _e245;
    let _e262 = component_1(2.5f);
    let _e264 = local_2;
    local_45 = _e264;
    let _e266 = local_45;
    local_46 = u32(_e266);
    local_47 = u32(14i);
    let _e272 = local_46;
    let _e273 = local_47;
    local_125 = u32((_e272 + _e273));
    let _e277 = local_125;
    out[_e277] = bitcast<u32>(_e262);
    let _e280 = local_2;
    local_48 = _e280;
    let _e282 = local_48;
    local_49 = u32(_e282);
    local_50 = u32(15i);
    let _e288 = local_49;
    let _e289 = local_50;
    local_126 = u32((_e288 + _e289));
    let _e293 = local_126;
    out[_e293] = threadIdx.x;
    let _e296 = local_2;
    local_51 = _e296;
    let _e298 = local_51;
    local_52 = u32(_e298);
    local_53 = u32(16i);
    let _e304 = local_52;
    let _e305 = local_53;
    local_127 = u32((_e304 + _e305));
    let _e309 = local_127;
    out[_e309] = blockIdx.y;
    let _e312 = local_2;
    local_54 = _e312;
    let _e314 = local_54;
    local_55 = u32(_e314);
    local_56 = u32(17i);
    let _e320 = local_55;
    let _e321 = local_56;
    local_128 = u32((_e320 + _e321));
    let _e325 = local_128;
    out[_e325] = gridDim.z;
    let _e327 = local_2;
    local_57 = _e327;
    let _e329 = local_57;
    local_58 = u32(_e329);
    local_59 = u32(18i);
    let _e335 = local_58;
    let _e336 = local_59;
    local_129 = u32((_e335 + _e336));
    let _e341 = local_129;
    out[_e341] = 1u;
    let _e343 = local;
    local_63 = _e343;
    let _e345 = local_63;
    local_64 = u32(_e345);
    local_65 = u32(0i);
    let _e352 = local_64;
    let _e353 = local_65;
    local_130 = u32((_e352 + _e353));
    let _e358 = local_130;
    let _e360 = input[_e358];
    local_131 = _e360;
    let _e361 = local_131;
    let _e363 = local_2;
    local_60 = _e363;
    let _e365 = local_60;
    local_61 = u32(_e365);
    local_62 = u32(19i);
    let _e371 = local_61;
    let _e372 = local_62;
    local_132 = u32((_e371 + _e372));
    let _e376 = local_132;
    out[_e376] = u32(_e361);
    let _e378 = scale;
    let _e380 = local_2;
    local_66 = _e380;
    let _e382 = local_66;
    local_67 = u32(_e382);
    local_68 = u32(20i);
    let _e388 = local_67;
    let _e389 = local_68;
    local_133 = u32((_e388 + _e389));
    let _e393 = local_133;
    out[_e393] = bitcast<u32>(_e378);
    let _e395 = local_1;
    local_72 = _e395;
    let _e397 = local_72;
    local_73 = u32(_e397);
    local_74 = u32(0i);
    let _e404 = local_73;
    let _e405 = local_74;
    local_134 = u32((_e404 + _e405));
    let _e410 = local_134;
    let _e413 = points[_e410].x;
    local_135 = _e413;
    let _e414 = local_135;
    let _e416 = local_2;
    local_69 = _e416;
    let _e418 = local_69;
    local_70 = u32(_e418);
    local_71 = u32(21i);
    let _e424 = local_70;
    let _e425 = local_71;
    local_136 = u32((_e424 + _e425));
    let _e429 = local_136;
    out[_e429] = bitcast<u32>(_e414);
    let _e431 = local_1;
    local_78 = _e431;
    let _e433 = local_78;
    local_79 = u32(_e433);
    local_80 = u32(0i);
    let _e439 = local_79;
    let _e440 = local_80;
    local_137 = u32((_e439 + _e440));
    let _e445 = local_137;
    let _e448 = points[_e445].y;
    local_138 = _e448;
    let _e449 = local_138;
    let _e451 = local_2;
    local_75 = _e451;
    let _e453 = local_75;
    local_76 = u32(_e453);
    local_77 = u32(22i);
    let _e459 = local_76;
    let _e460 = local_77;
    local_139 = u32((_e459 + _e460));
    let _e464 = local_139;
    out[_e464] = bitcast<u32>(_e449);
    let _e466 = local_1;
    local_84 = _e466;
    let _e468 = local_84;
    local_85 = u32(_e468);
    local_86 = u32(0i);
    let _e474 = local_85;
    let _e475 = local_86;
    local_140 = u32((_e474 + _e475));
    let _e480 = local_140;
    let _e483 = points[_e480].z;
    local_141 = _e483;
    let _e484 = local_141;
    let _e486 = local_2;
    local_81 = _e486;
    let _e488 = local_81;
    local_82 = u32(_e488);
    local_83 = u32(23i);
    let _e494 = local_82;
    let _e495 = local_83;
    local_142 = u32((_e494 + _e495));
    let _e499 = local_142;
    out[_e499] = bitcast<u32>(_e484);
    let _e501 = limit;
    let _e502 = local_2;
    local_87 = _e502;
    let _e504 = local_87;
    local_88 = u32(_e504);
    local_89 = u32(24i);
    let _e510 = local_88;
    let _e511 = local_89;
    local_143 = u32((_e510 + _e511));
    let _e515 = local_143;
    out[_e515] = _e501;
    let _e518 = thread_component(0u);
    let _e520 = group_component(1u);
    let _e523 = shape_component(2u);
    let _e526 = grid_component(0u);
    let _e528 = local_2;
    local_90 = _e528;
    let _e530 = local_90;
    local_91 = u32(_e530);
    local_92 = u32(25i);
    let _e536 = local_91;
    let _e537 = local_92;
    local_144 = u32((_e536 + _e537));
    let _e541 = local_144;
    out[_e541] = (((_e518 + _e520) + _e523) + _e526);
    let _e543 = global_x();
    let _e544 = global_x();
    let _e546 = local_2;
    local_93 = _e546;
    let _e548 = local_93;
    local_94 = u32(_e548);
    local_95 = u32(26i);
    let _e554 = local_94;
    let _e555 = local_95;
    local_145 = u32((_e554 + _e555));
    let _e559 = local_145;
    out[_e559] = (_e543 + _e544);
    let _e561 = local;
    local_99 = _e561;
    let _e563 = local_99;
    local_100 = u32(_e563);
    local_101 = u32(0i);
    let _e569 = local_100;
    let _e570 = local_101;
    local_146 = u32((_e569 + _e570));
    let _e575 = local_146;
    let _e577 = input[_e575];
    local_147 = _e577;
    let _e578 = local_147;
    let _e580 = scale;
    let _e582 = local_1;
    local_102 = _e582;
    let _e584 = local_102;
    local_103 = u32(_e584);
    local_104 = u32(0i);
    let _e590 = local_103;
    let _e591 = local_104;
    local_148 = u32((_e590 + _e591));
    let _e596 = local_148;
    let _e599 = points[_e596].x;
    local_149 = _e599;
    let _e600 = local_149;
    let _e603 = local_2;
    local_96 = _e603;
    let _e605 = local_96;
    local_97 = u32(_e605);
    local_98 = u32(27i);
    let _e611 = local_97;
    let _e612 = local_98;
    local_150 = u32((_e611 + _e612));
    let _e616 = local_150;
    out[_e616] = bitcast<u32>(((f32(_e578) * _e580) + _e600));
    let _e619 = kind(threadIdx.x);
    let _e620 = local_2;
    local_105 = _e620;
    let _e622 = local_105;
    local_106 = u32(_e622);
    local_107 = u32(28i);
    let _e628 = local_106;
    let _e629 = local_107;
    local_151 = u32((_e628 + _e629));
    let _e633 = local_151;
    out[_e633] = _e619;
    let _e636 = grid_component(2u);
    let _e637 = local_2;
    local_108 = _e637;
    let _e639 = local_108;
    local_109 = u32(_e639);
    local_110 = u32(29i);
    let _e645 = local_109;
    let _e646 = local_110;
    local_152 = u32((_e645 + _e646));
    let _e650 = local_152;
    out[_e650] = _e636;
}
