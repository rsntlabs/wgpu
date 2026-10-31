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
var<uniform> scale: type_5;
@group(0) @binding(2)
var<storage> points: array<float3_>;
@group(0) @binding(3)
var<uniform> limit: type_7;
@group(0) @binding(4)
var<storage, read_write> out: array<u32>;

fn thread_component(axis: u32) -> u32 {
    if (axis == 0u) {
        let _e4 = threadIdx_1;
        return _e4.x;
    }
    if (axis == 1u) {
        let _e9 = threadIdx_1;
        return _e9.y;
    }
    let _e12 = threadIdx_1;
    return _e12.z;
}

fn group_component(axis_1: u32) -> u32 {
    if (axis_1 == 0u) {
        let _e4 = blockIdx_1;
        return _e4.x;
    }
    if (axis_1 == 1u) {
        let _e9 = blockIdx_1;
        return _e9.y;
    }
    let _e12 = blockIdx_1;
    return _e12.z;
}

fn shape_component(axis_2: u32) -> u32 {
    if (axis_2 == 0u) {
        return 1u;
    }
    if (axis_2 == 1u) {
        return 1u;
    }
    return 1u;
}

fn grid_component(axis_3: u32) -> u32 {
    if (axis_3 == 0u) {
        let _e4 = gridDim_1;
        return _e4.x;
    }
    if (axis_3 == 1u) {
        let _e9 = gridDim_1;
        return _e9.y;
    }
    let _e12 = gridDim_1;
    return _e12.z;
}

fn component(axis_4: u32) -> u32 {
    let _e1 = thread_component(axis_4);
    return _e1;
}

fn component_1(offset: f32) -> f32 {
    let _e2 = blockIdx_1;
    return (f32(_e2.x) + offset);
}

fn global_x() -> u32 {
    let _e1 = group_component(0u);
    let _e3 = shape_component(0u);
    let _e6 = component(0u);
    return ((_e1 * _e3) + _e6);
}

fn kind(value: u32) -> u32 {
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
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: i32;
    var local_37: f32;
    var local_38: f32;
    var local_39: f32;
    var local_40: i32;
    var local_41: f32;
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
    var local_62: i32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;
    var local_66: f32;
    var local_67: u32;
    var local_68: u32;
    var local_69: f32;
    var local_70: u32;
    var local_71: u32;
    var local_72: f32;
    var local_73: u32;
    var local_74: u32;
    var local_75: u32;
    var local_76: u32;
    var local_77: u32;
    var local_78: i32;
    var local_79: u32;
    var local_80: f32;
    var local_81: u32;
    var local_82: u32;
    var local_83: u32;

    let scale_1 = scale.value;
    let limit_1 = limit.value;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    gridDim_1 = gridDim;
    let _e12 = global_x();
    if (_e12 >= limit_1) {
        return;
    }
    observe();
    let _e15 = thread_component(0u);
    local = u32(0i);
    let _e19 = local;
    local_42 = u32(_e19);
    let _e22 = local_42;
    out[_e22] = _e15;
    let _e26 = thread_component(1u);
    local_1 = u32(1i);
    let _e30 = local_1;
    local_43 = u32(_e30);
    let _e33 = local_43;
    out[_e33] = _e26;
    let _e36 = thread_component(2u);
    local_2 = u32(2i);
    let _e40 = local_2;
    local_44 = u32(_e40);
    let _e43 = local_44;
    out[_e43] = _e36;
    let _e46 = group_component(0u);
    local_3 = u32(3i);
    let _e50 = local_3;
    local_45 = u32(_e50);
    let _e53 = local_45;
    out[_e53] = _e46;
    let _e56 = group_component(1u);
    local_4 = u32(4i);
    let _e60 = local_4;
    local_46 = u32(_e60);
    let _e63 = local_46;
    out[_e63] = _e56;
    let _e66 = group_component(2u);
    local_5 = u32(5i);
    let _e70 = local_5;
    local_47 = u32(_e70);
    let _e73 = local_47;
    out[_e73] = _e66;
    let _e76 = shape_component(0u);
    local_6 = u32(6i);
    let _e80 = local_6;
    local_48 = u32(_e80);
    let _e83 = local_48;
    out[_e83] = _e76;
    let _e86 = shape_component(1u);
    local_7 = u32(7i);
    let _e90 = local_7;
    local_49 = u32(_e90);
    let _e93 = local_49;
    out[_e93] = _e86;
    let _e96 = shape_component(2u);
    local_8 = u32(8i);
    let _e100 = local_8;
    local_50 = u32(_e100);
    let _e103 = local_50;
    out[_e103] = _e96;
    let _e106 = grid_component(0u);
    local_9 = u32(9i);
    let _e110 = local_9;
    local_51 = u32(_e110);
    let _e113 = local_51;
    out[_e113] = _e106;
    let _e116 = grid_component(1u);
    local_10 = u32(10i);
    let _e120 = local_10;
    local_52 = u32(_e120);
    let _e123 = local_52;
    out[_e123] = _e116;
    let _e126 = grid_component(2u);
    local_11 = u32(11i);
    let _e130 = local_11;
    local_53 = u32(_e130);
    let _e133 = local_53;
    out[_e133] = _e126;
    let _e135 = global_x();
    local_12 = u32(12i);
    let _e139 = local_12;
    local_54 = u32(_e139);
    let _e142 = local_54;
    out[_e142] = _e135;
    let _e145 = component(0u);
    local_13 = u32(13i);
    let _e149 = local_13;
    local_55 = u32(_e149);
    let _e152 = local_55;
    out[_e152] = _e145;
    let _e155 = component_1(2.5f);
    local_14 = u32(14i);
    let _e160 = local_14;
    local_56 = u32(_e160);
    let _e163 = local_56;
    out[_e163] = bitcast<u32>(_e155);
    local_15 = u32(15i);
    let _e169 = local_15;
    local_57 = u32(_e169);
    let _e172 = local_57;
    out[_e172] = threadIdx.x;
    local_16 = u32(16i);
    let _e178 = local_16;
    local_58 = u32(_e178);
    let _e181 = local_58;
    out[_e181] = blockIdx.y;
    local_17 = u32(17i);
    let _e187 = local_17;
    local_59 = u32(_e187);
    let _e190 = local_59;
    out[_e190] = gridDim.z;
    local_18 = u32(18i);
    let _e195 = local_18;
    local_60 = u32(_e195);
    let _e198 = local_60;
    out[_e198] = 1u;
    local_20 = u32(0i);
    let _e204 = local_20;
    local_61 = u32(_e204);
    let _e207 = local_61;
    let _e210 = input[_e207];
    local_62 = _e210;
    let _e212 = local_62;
    local_36 = _e212;
    let _e214 = local_36;
    local_19 = u32(19i);
    let _e219 = local_19;
    local_63 = u32(_e219);
    let _e222 = local_63;
    out[_e222] = u32(_e214);
    local_21 = u32(20i);
    let _e228 = local_21;
    local_64 = u32(_e228);
    let _e231 = local_64;
    out[_e231] = bitcast<u32>(scale_1);
    local_23 = u32(0i);
    let _e236 = local_23;
    local_65 = u32(_e236);
    let _e239 = local_65;
    let _e243 = points[_e239].x;
    local_66 = _e243;
    let _e245 = local_66;
    local_37 = _e245;
    let _e247 = local_37;
    local_22 = u32(21i);
    let _e252 = local_22;
    local_67 = u32(_e252);
    let _e255 = local_67;
    out[_e255] = bitcast<u32>(_e247);
    local_25 = u32(0i);
    let _e260 = local_25;
    local_68 = u32(_e260);
    let _e263 = local_68;
    let _e266 = points[_e263].y;
    local_69 = _e266;
    let _e268 = local_69;
    local_38 = _e268;
    let _e270 = local_38;
    local_24 = u32(22i);
    let _e275 = local_24;
    local_70 = u32(_e275);
    let _e278 = local_70;
    out[_e278] = bitcast<u32>(_e270);
    local_27 = u32(0i);
    let _e283 = local_27;
    local_71 = u32(_e283);
    let _e286 = local_71;
    let _e289 = points[_e286].z;
    local_72 = _e289;
    let _e291 = local_72;
    local_39 = _e291;
    let _e293 = local_39;
    local_26 = u32(23i);
    let _e298 = local_26;
    local_73 = u32(_e298);
    let _e301 = local_73;
    out[_e301] = bitcast<u32>(_e293);
    local_28 = u32(24i);
    let _e306 = local_28;
    local_74 = u32(_e306);
    let _e309 = local_74;
    out[_e309] = limit_1;
    let _e312 = thread_component(0u);
    let _e314 = group_component(1u);
    let _e317 = shape_component(2u);
    let _e320 = grid_component(0u);
    local_29 = u32(25i);
    let _e325 = local_29;
    local_75 = u32(_e325);
    let _e328 = local_75;
    out[_e328] = (((_e312 + _e314) + _e317) + _e320);
    let _e330 = global_x();
    let _e331 = global_x();
    local_30 = u32(26i);
    let _e336 = local_30;
    local_76 = u32(_e336);
    let _e339 = local_76;
    out[_e339] = (_e330 + _e331);
    local_32 = u32(0i);
    let _e344 = local_32;
    local_77 = u32(_e344);
    let _e347 = local_77;
    let _e349 = input[_e347];
    local_78 = _e349;
    let _e351 = local_78;
    local_40 = _e351;
    let _e353 = local_40;
    local_33 = u32(0i);
    let _e359 = local_33;
    local_79 = u32(_e359);
    let _e362 = local_79;
    let _e365 = points[_e362].x;
    local_80 = _e365;
    let _e367 = local_80;
    local_41 = _e367;
    let _e369 = local_41;
    local_31 = u32(27i);
    let _e375 = local_31;
    local_81 = u32(_e375);
    let _e378 = local_81;
    out[_e378] = bitcast<u32>(((f32(_e353) * scale_1) + _e369));
    let _e381 = kind(threadIdx.x);
    local_34 = u32(28i);
    let _e385 = local_34;
    local_82 = u32(_e385);
    let _e388 = local_82;
    out[_e388] = _e381;
    let _e391 = grid_component(2u);
    local_35 = u32(29i);
    let _e395 = local_35;
    local_83 = u32(_e395);
    let _e398 = local_83;
    out[_e398] = _e391;
}
