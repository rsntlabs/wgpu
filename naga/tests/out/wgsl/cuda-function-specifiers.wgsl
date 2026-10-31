struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
@group(0) @binding(2)
var<uniform> n_1: type_5;

fn increment(value_1: i32) -> i32 {
    var value_2: i32;

    value_2 = value_1;
    let _e3 = value_2;
    value_2 = (_e3 + 2i);
    let _e5 = value_2;
    return _e5;
}

fn twice(value_3: i32) -> i32 {
    var value_4: i32;

    value_4 = value_3;
    let _e2 = value_4;
    let _e3 = increment(_e2);
    return (_e3 * 2i);
}

fn advance(value_5: i32) -> i32 {
    var value_6: i32;

    value_6 = value_5;
    let _e2 = value_6;
    let _e3 = twice(_e2);
    return (_e3 + 1i);
}

fn retreat(value_7: i32) -> i32 {
    var value_8: i32;

    value_8 = value_7;
    let _e3 = value_8;
    return (_e3 - 3i);
}

fn scaled(value_9: f32) -> f32 {
    var value_10: f32;

    value_10 = value_9;
    let _e3 = value_10;
    return ((_e3 * 1.5f) + 0.5f);
}

fn differs(value_11: i32, other: i32) -> bool {
    var value_12: i32;
    var other_1: i32;

    value_12 = value_11;
    other_1 = other;
    let _e4 = value_12;
    let _e5 = other_1;
    return (_e4 != _e5);
}

fn consume(stop: bool, value_13: i32) {
    var stop_1: bool;
    var value_14: i32;

    stop_1 = stop;
    value_14 = value_13;
    let _e4 = stop_1;
    if _e4 {
        return;
    }
    let _e5 = value_14;
    let _e6 = advance(_e5);
    value_14 = _e6;
    return;
}

fn forward(stop_2: bool, value_15: i32) {
    var stop_3: bool;
    var value_16: i32;

    stop_3 = stop_2;
    value_16 = value_15;
    let _e4 = stop_3;
    let _e5 = value_16;
    let _e6 = retreat(_e5);
    consume(_e4, _e6);
    return;
}

fn plus_one(value_17: u32) -> u32 {
    var value_18: u32;

    value_18 = value_17;
    let _e3 = value_18;
    return (_e3 + 1u);
}

@compute @workgroup_size(64, 1, 1)
fn function_specifiers(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var choose: bool;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var effect: i32;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var local_20: array<u32, 2>;
    var local_21: u32;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var local_30: array<u32, 2>;
    var local_31: u32;
    var local_32: i32;
    var local_33: i32;
    var local_34: i32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var local_37: u32;
    var local_38: i32;
    var local_39: array<u32, 2>;
    var local_40: u32;
    var local_41: u32;
    var local_42: array<u32, 2>;
    var local_43: u32;
    var local_44: u32;
    var local_45: array<u32, 2>;
    var local_46: u32;
    var local_47: u32;
    var local_48: array<u32, 2>;
    var local_49: u32;
    var local_50: u32;
    var local_51: array<u32, 2>;
    var local_52: u32;
    var local_53: u32;
    var local_54: array<u32, 2>;
    var local_55: u32;
    var local_56: u32;
    var local_57: i32;
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
    var local_70: array<u32, 2>;
    var local_71: u32;
    var local_72: u32;
    var local_73: array<u32, 2>;
    var local_74: u32;
    var local_75: u32;
    var local_76: i32;
    var local_77: array<u32, 2>;
    var local_78: u32;
    var local_79: u32;
    var local_80: array<u32, 2>;
    var local_81: u32;
    var local_82: u32;

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
        local_35 = _e40;
        let _e41 = local_3;
        let _e43 = local_35[1];
        local_35[1] = (_e43 + _e41);
        let _e47 = local_35[0];
        local_36 = u32(_e47);
        let _e51 = local_35[1];
        local_37 = u32(_e51);
        let _e55 = local_37;
        let _e57 = input[_e55];
        local_38 = _e57;
        let _e58 = local_38;
        local_32 = _e58;
        let _e60 = local_32;
        value = _e60;
        let _e62 = i;
        choose = ((_e62 % 2u) == 0u);
        let _e68 = value;
        let _e69 = increment(_e68);
        let _e72 = local;
        local_4 = _e72;
        let _e73 = base;
        local_5 = u32(_e73);
        let _e77 = local_4;
        local_39 = _e77;
        let _e78 = local_5;
        let _e80 = local_39[1];
        local_39[1] = (_e80 + _e78);
        let _e84 = local_39[0];
        local_40 = u32(_e84);
        let _e88 = local_39[1];
        local_41 = u32(_e88);
        let _e91 = local_41;
        out[_e91] = _e69;
        let _e93 = value;
        let _e94 = twice(_e93);
        let _e96 = local;
        local_6 = _e96;
        let _e97 = base;
        local_7 = u32((_e97 + 1u));
        let _e103 = local_6;
        local_42 = _e103;
        let _e104 = local_7;
        let _e106 = local_42[1];
        local_42[1] = (_e106 + _e104);
        let _e110 = local_42[0];
        local_43 = u32(_e110);
        let _e114 = local_42[1];
        local_44 = u32(_e114);
        let _e117 = local_44;
        out[_e117] = _e94;
        let _e119 = value;
        let _e120 = advance(_e119);
        let _e122 = local;
        local_8 = _e122;
        let _e123 = base;
        local_9 = u32((_e123 + 2u));
        let _e129 = local_8;
        local_45 = _e129;
        let _e130 = local_9;
        let _e132 = local_45[1];
        local_45[1] = (_e132 + _e130);
        let _e136 = local_45[0];
        local_46 = u32(_e136);
        let _e140 = local_45[1];
        local_47 = u32(_e140);
        let _e143 = local_47;
        out[_e143] = _e120;
        let _e145 = value;
        let _e146 = retreat(_e145);
        let _e148 = local;
        local_10 = _e148;
        let _e149 = base;
        local_11 = u32((_e149 + 3u));
        let _e155 = local_10;
        local_48 = _e155;
        let _e156 = local_11;
        let _e158 = local_48[1];
        local_48[1] = (_e158 + _e156);
        let _e162 = local_48[0];
        local_49 = u32(_e162);
        let _e166 = local_48[1];
        local_50 = u32(_e166);
        let _e169 = local_50;
        out[_e169] = _e146;
        let _e171 = value;
        let _e173 = scaled(f32(_e171));
        let _e175 = local;
        local_12 = _e175;
        let _e176 = base;
        local_13 = u32((_e176 + 4u));
        let _e183 = local_12;
        local_51 = _e183;
        let _e184 = local_13;
        let _e186 = local_51[1];
        local_51[1] = (_e186 + _e184);
        let _e190 = local_51[0];
        local_52 = u32(_e190);
        let _e194 = local_51[1];
        local_53 = u32(_e194);
        let _e197 = local_53;
        out[_e197] = i32(_e173);
        let _e199 = value;
        let _e201 = local_1;
        local_16 = _e201;
        let _e202 = i;
        local_17 = u32(_e202);
        let _e206 = local_16;
        local_54 = _e206;
        let _e207 = local_17;
        let _e209 = local_54[1];
        local_54[1] = (_e209 + _e207);
        let _e213 = local_54[0];
        local_55 = u32(_e213);
        let _e217 = local_54[1];
        local_56 = u32(_e217);
        let _e221 = local_56;
        let _e223 = input[_e221];
        local_57 = _e223;
        let _e224 = local_57;
        local_33 = _e224;
        let _e226 = local_33;
        let _e227 = differs(_e199, _e226);
        let _e229 = local;
        local_14 = _e229;
        let _e230 = base;
        local_15 = u32((_e230 + 5u));
        let _e237 = local_14;
        local_58 = _e237;
        let _e238 = local_15;
        let _e240 = local_58[1];
        local_58[1] = (_e240 + _e238);
        let _e244 = local_58[0];
        local_59 = u32(_e244);
        let _e248 = local_58[1];
        local_60 = u32(_e248);
        let _e251 = local_60;
        out[_e251] = i32(_e227);
        let _e253 = value;
        effect = _e253;
        let _e255 = choose;
        let _e256 = effect;
        effect = (_e256 + 1i);
        consume(_e255, _e256);
        let _e259 = effect;
        let _e261 = local;
        local_18 = _e261;
        let _e262 = base;
        local_19 = u32((_e262 + 6u));
        let _e268 = local_18;
        local_61 = _e268;
        let _e269 = local_19;
        let _e271 = local_61[1];
        local_61[1] = (_e271 + _e269);
        let _e275 = local_61[0];
        local_62 = u32(_e275);
        let _e279 = local_61[1];
        local_63 = u32(_e279);
        let _e282 = local_63;
        out[_e282] = _e259;
        let _e284 = choose;
        let _e286 = effect;
        effect = (_e286 + 1i);
        forward(!(_e284), _e286);
        let _e289 = effect;
        let _e291 = local;
        local_20 = _e291;
        let _e292 = base;
        local_21 = u32((_e292 + 7u));
        let _e298 = local_20;
        local_64 = _e298;
        let _e299 = local_21;
        let _e301 = local_64[1];
        local_64[1] = (_e301 + _e299);
        let _e305 = local_64[0];
        local_65 = u32(_e305);
        let _e309 = local_64[1];
        local_66 = u32(_e309);
        let _e312 = local_66;
        out[_e312] = _e289;
        let _e314 = effect;
        let _e315 = advance(_e314);
        let _e317 = local;
        local_22 = _e317;
        let _e318 = base;
        local_23 = u32((_e318 + 8u));
        let _e324 = local_22;
        local_67 = _e324;
        let _e325 = local_23;
        let _e327 = local_67[1];
        local_67[1] = (_e327 + _e325);
        let _e331 = local_67[0];
        local_68 = u32(_e331);
        let _e335 = local_67[1];
        local_69 = u32(_e335);
        let _e338 = local_69;
        out[_e338] = _e315;
        let _e340 = effect;
        let _e344 = plus_one(u32((_e340 + 16i)));
        let _e346 = local;
        local_24 = _e346;
        let _e347 = base;
        local_25 = u32((_e347 + 9u));
        let _e354 = local_24;
        local_70 = _e354;
        let _e355 = local_25;
        let _e357 = local_70[1];
        local_70[1] = (_e357 + _e355);
        let _e361 = local_70[0];
        local_71 = u32(_e361);
        let _e365 = local_70[1];
        local_72 = u32(_e365);
        let _e368 = local_72;
        out[_e368] = i32(_e344);
        let _e370 = effect;
        let _e372 = local_1;
        local_28 = _e372;
        let _e373 = i;
        local_29 = u32(_e373);
        let _e377 = local_28;
        local_73 = _e377;
        let _e378 = local_29;
        let _e380 = local_73[1];
        local_73[1] = (_e380 + _e378);
        let _e384 = local_73[0];
        local_74 = u32(_e384);
        let _e388 = local_73[1];
        local_75 = u32(_e388);
        let _e392 = local_75;
        let _e394 = input[_e392];
        local_76 = _e394;
        let _e395 = local_76;
        local_34 = _e395;
        let _e397 = local_34;
        let _e398 = differs(_e370, _e397);
        let _e400 = local;
        local_26 = _e400;
        let _e401 = base;
        local_27 = u32((_e401 + 10u));
        let _e408 = local_26;
        local_77 = _e408;
        let _e409 = local_27;
        let _e411 = local_77[1];
        local_77[1] = (_e411 + _e409);
        let _e415 = local_77[0];
        local_78 = u32(_e415);
        let _e419 = local_77[1];
        local_79 = u32(_e419);
        let _e422 = local_79;
        out[_e422] = i32(_e398);
        let _e424 = effect;
        let _e426 = local;
        local_30 = _e426;
        let _e427 = base;
        local_31 = u32((_e427 + 11u));
        let _e433 = local_30;
        local_80 = _e433;
        let _e434 = local_31;
        let _e436 = local_80[1];
        local_80[1] = (_e436 + _e434);
        let _e440 = local_80[0];
        local_81 = u32(_e440);
        let _e444 = local_80[1];
        local_82 = u32(_e444);
        let _e447 = local_82;
        out[_e447] = _e424;
    }
}
