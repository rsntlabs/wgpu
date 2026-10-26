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
    var local: u32;
    var local_1: u32;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var choose: bool;
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
    var effect: i32;
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
    var local_48: i32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: u32;
    var local_55: i32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: i32;
    var local_63: u32;
    var local_64: u32;

    local = 0u;
    local_1 = 0u;
    let _e8 = n_1.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e16 = i;
    let _e17 = n;
    if (_e16 < _e17) {
        let _e19 = i;
        base = (_e19 * 12u);
        let _e23 = local_1;
        local_2 = _e23;
        let _e25 = local_2;
        local_3 = u32(_e25);
        let _e28 = i;
        local_4 = u32(_e28);
        let _e32 = local_3;
        let _e33 = local_4;
        local_47 = u32((_e32 + _e33));
        let _e38 = local_47;
        let _e40 = input[_e38];
        local_48 = _e40;
        let _e41 = local_48;
        value = _e41;
        let _e43 = i;
        choose = ((_e43 % 2u) == 0u);
        let _e49 = value;
        let _e50 = increment(_e49);
        let _e51 = local;
        local_5 = _e51;
        let _e53 = local_5;
        local_6 = u32(_e53);
        let _e56 = base;
        local_7 = u32(_e56);
        let _e60 = local_6;
        let _e61 = local_7;
        local_49 = u32((_e60 + _e61));
        let _e65 = local_49;
        out[_e65] = _e50;
        let _e67 = value;
        let _e68 = twice(_e67);
        let _e69 = local;
        local_8 = _e69;
        let _e71 = local_8;
        local_9 = u32(_e71);
        let _e74 = base;
        local_10 = u32((_e74 + 1u));
        let _e79 = local_9;
        let _e80 = local_10;
        local_50 = u32((_e79 + _e80));
        let _e84 = local_50;
        out[_e84] = _e68;
        let _e86 = value;
        let _e87 = advance(_e86);
        let _e88 = local;
        local_11 = _e88;
        let _e90 = local_11;
        local_12 = u32(_e90);
        let _e93 = base;
        local_13 = u32((_e93 + 2u));
        let _e98 = local_12;
        let _e99 = local_13;
        local_51 = u32((_e98 + _e99));
        let _e103 = local_51;
        out[_e103] = _e87;
        let _e105 = value;
        let _e106 = retreat(_e105);
        let _e107 = local;
        local_14 = _e107;
        let _e109 = local_14;
        local_15 = u32(_e109);
        let _e112 = base;
        local_16 = u32((_e112 + 3u));
        let _e117 = local_15;
        let _e118 = local_16;
        local_52 = u32((_e117 + _e118));
        let _e122 = local_52;
        out[_e122] = _e106;
        let _e124 = value;
        let _e126 = scaled(f32(_e124));
        let _e127 = local;
        local_17 = _e127;
        let _e129 = local_17;
        local_18 = u32(_e129);
        let _e132 = base;
        local_19 = u32((_e132 + 4u));
        let _e138 = local_18;
        let _e139 = local_19;
        local_53 = u32((_e138 + _e139));
        let _e143 = local_53;
        out[_e143] = i32(_e126);
        let _e145 = value;
        let _e146 = local_1;
        local_23 = _e146;
        let _e148 = local_23;
        local_24 = u32(_e148);
        let _e151 = i;
        local_25 = u32(_e151);
        let _e154 = local_24;
        let _e155 = local_25;
        local_54 = u32((_e154 + _e155));
        let _e160 = local_54;
        let _e162 = input[_e160];
        local_55 = _e162;
        let _e163 = local_55;
        let _e164 = differs(_e145, _e163);
        let _e165 = local;
        local_20 = _e165;
        let _e167 = local_20;
        local_21 = u32(_e167);
        let _e170 = base;
        local_22 = u32((_e170 + 5u));
        let _e176 = local_21;
        let _e177 = local_22;
        local_56 = u32((_e176 + _e177));
        let _e181 = local_56;
        out[_e181] = i32(_e164);
        let _e183 = value;
        effect = _e183;
        let _e185 = choose;
        let _e186 = effect;
        effect = (_e186 + 1i);
        consume(_e185, _e186);
        let _e189 = effect;
        let _e190 = local;
        local_26 = _e190;
        let _e192 = local_26;
        local_27 = u32(_e192);
        let _e195 = base;
        local_28 = u32((_e195 + 6u));
        let _e200 = local_27;
        let _e201 = local_28;
        local_57 = u32((_e200 + _e201));
        let _e205 = local_57;
        out[_e205] = _e189;
        let _e207 = choose;
        let _e209 = effect;
        effect = (_e209 + 1i);
        forward(!(_e207), _e209);
        let _e212 = effect;
        let _e213 = local;
        local_29 = _e213;
        let _e215 = local_29;
        local_30 = u32(_e215);
        let _e218 = base;
        local_31 = u32((_e218 + 7u));
        let _e223 = local_30;
        let _e224 = local_31;
        local_58 = u32((_e223 + _e224));
        let _e228 = local_58;
        out[_e228] = _e212;
        let _e230 = effect;
        let _e231 = advance(_e230);
        let _e232 = local;
        local_32 = _e232;
        let _e234 = local_32;
        local_33 = u32(_e234);
        let _e237 = base;
        local_34 = u32((_e237 + 8u));
        let _e242 = local_33;
        let _e243 = local_34;
        local_59 = u32((_e242 + _e243));
        let _e247 = local_59;
        out[_e247] = _e231;
        let _e249 = effect;
        let _e253 = plus_one(u32((_e249 + 16i)));
        let _e254 = local;
        local_35 = _e254;
        let _e256 = local_35;
        local_36 = u32(_e256);
        let _e259 = base;
        local_37 = u32((_e259 + 9u));
        let _e265 = local_36;
        let _e266 = local_37;
        local_60 = u32((_e265 + _e266));
        let _e270 = local_60;
        out[_e270] = i32(_e253);
        let _e272 = effect;
        let _e273 = local_1;
        local_41 = _e273;
        let _e275 = local_41;
        local_42 = u32(_e275);
        let _e278 = i;
        local_43 = u32(_e278);
        let _e281 = local_42;
        let _e282 = local_43;
        local_61 = u32((_e281 + _e282));
        let _e287 = local_61;
        let _e289 = input[_e287];
        local_62 = _e289;
        let _e290 = local_62;
        let _e291 = differs(_e272, _e290);
        let _e292 = local;
        local_38 = _e292;
        let _e294 = local_38;
        local_39 = u32(_e294);
        let _e297 = base;
        local_40 = u32((_e297 + 10u));
        let _e303 = local_39;
        let _e304 = local_40;
        local_63 = u32((_e303 + _e304));
        let _e308 = local_63;
        out[_e308] = i32(_e291);
        let _e310 = effect;
        let _e311 = local;
        local_44 = _e311;
        let _e313 = local_44;
        local_45 = u32(_e313);
        let _e316 = base;
        local_46 = u32((_e316 + 11u));
        let _e321 = local_45;
        let _e322 = local_46;
        local_64 = u32((_e321 + _e322));
        let _e326 = local_64;
        out[_e326] = _e310;
    }
}
