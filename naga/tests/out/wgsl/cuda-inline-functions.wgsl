struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
@group(0) @binding(1)
var<storage> input_1: array<i32>;
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

fn doubled(value_3: i32) -> i32 {
    var value_4: i32;

    value_4 = value_3;
    let _e2 = value_4;
    let _e3 = increment(_e2);
    return (_e3 * 2i);
}

fn advance(value_5: u32) -> u32 {
    var value_6: u32;

    value_6 = value_5;
    let _e3 = value_6;
    return (_e3 + 3u);
}

fn retreat(value_7: u32) -> u32 {
    var value_8: u32;

    value_8 = value_7;
    let _e3 = value_8;
    return (_e3 - 1u);
}

fn scale(value_9: f32, bias: i32) -> f32 {
    var value_10: f32;
    var bias_1: i32;

    value_10 = value_9;
    bias_1 = bias;
    let _e5 = value_10;
    let _e7 = bias_1;
    return ((_e5 * 1.5f) + f32(_e7));
}

fn same(left: i32, right: i32) -> bool {
    var left_1: i32;
    var right_1: i32;

    left_1 = left;
    right_1 = right;
    let _e4 = left_1;
    let _e5 = right_1;
    return (_e4 == _e5);
}

fn consume(stop: bool, value_11: i32) {
    var stop_1: bool;
    var value_12: i32;

    stop_1 = stop;
    value_12 = value_11;
    let _e4 = stop_1;
    if _e4 {
        return;
    }
    let _e5 = value_12;
    let _e6 = doubled(_e5);
    value_12 = _e6;
    return;
}

fn forward(stop_2: bool, value_13: i32) {
    var stop_3: bool;
    var value_14: i32;

    stop_3 = stop_2;
    value_14 = value_13;
    let _e4 = stop_3;
    let _e5 = value_14;
    let _e6 = increment(_e5);
    consume(_e4, _e6);
    return;
}

@compute @workgroup_size(64, 1, 1)
fn inline_functions(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var out: array<u32, 2>;
    var input: array<u32, 2>;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
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
    var local_30: i32;
    var local_31: i32;
    var local_32: i32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var local_35: u32;
    var local_36: i32;
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
    var local_58: i32;
    var local_59: array<u32, 2>;
    var local_60: u32;
    var local_61: u32;
    var local_62: array<u32, 2>;
    var local_63: u32;
    var local_64: u32;
    var local_65: array<u32, 2>;
    var local_66: u32;
    var local_67: u32;
    var local_68: array<u32, 2>;
    var local_69: u32;
    var local_70: u32;
    var local_71: i32;
    var local_72: array<u32, 2>;
    var local_73: u32;
    var local_74: u32;
    var local_75: array<u32, 2>;
    var local_76: u32;
    var local_77: u32;
    var local_78: array<u32, 2>;
    var local_79: u32;
    var local_80: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    input = array<u32, 2>();
    input[0] = 1u;
    input[1] = 0u;
    let _e18 = n_1.value;
    n = _e18;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e26 = i;
    let _e27 = n;
    if (_e26 < _e27) {
        let _e29 = i;
        base = (_e29 * 12u);
        let _e35 = input;
        local = _e35;
        let _e36 = i;
        local_1 = u32(_e36);
        let _e40 = local;
        local_33 = _e40;
        let _e41 = local_1;
        let _e43 = local_33[1];
        local_33[1] = (_e43 + _e41);
        let _e47 = local_33[0];
        local_34 = u32(_e47);
        let _e51 = local_33[1];
        local_35 = u32(_e51);
        let _e55 = local_35;
        let _e57 = input_1[_e55];
        local_36 = _e57;
        let _e58 = local_36;
        local_30 = _e58;
        let _e60 = local_30;
        value = _e60;
        let _e62 = value;
        let _e63 = increment(_e62);
        let _e66 = out;
        local_2 = _e66;
        let _e67 = base;
        local_3 = u32(_e67);
        let _e71 = local_2;
        local_37 = _e71;
        let _e72 = local_3;
        let _e74 = local_37[1];
        local_37[1] = (_e74 + _e72);
        let _e78 = local_37[0];
        local_38 = u32(_e78);
        let _e82 = local_37[1];
        local_39 = u32(_e82);
        let _e85 = local_39;
        out_1[_e85] = _e63;
        let _e87 = value;
        let _e89 = out;
        local_4 = _e89;
        let _e90 = base;
        local_5 = u32((_e90 + 1u));
        let _e96 = local_4;
        local_40 = _e96;
        let _e97 = local_5;
        let _e99 = local_40[1];
        local_40[1] = (_e99 + _e97);
        let _e103 = local_40[0];
        local_41 = u32(_e103);
        let _e107 = local_40[1];
        local_42 = u32(_e107);
        let _e110 = local_42;
        out_1[_e110] = _e87;
        let _e112 = value;
        let _e113 = doubled(_e112);
        let _e115 = out;
        local_6 = _e115;
        let _e116 = base;
        local_7 = u32((_e116 + 2u));
        let _e122 = local_6;
        local_43 = _e122;
        let _e123 = local_7;
        let _e125 = local_43[1];
        local_43[1] = (_e125 + _e123);
        let _e129 = local_43[0];
        local_44 = u32(_e129);
        let _e133 = local_43[1];
        local_45 = u32(_e133);
        let _e136 = local_45;
        out_1[_e136] = _e113;
        let _e138 = value;
        let _e140 = advance(u32(_e138));
        let _e142 = out;
        local_8 = _e142;
        let _e143 = base;
        local_9 = u32((_e143 + 3u));
        let _e150 = local_8;
        local_46 = _e150;
        let _e151 = local_9;
        let _e153 = local_46[1];
        local_46[1] = (_e153 + _e151);
        let _e157 = local_46[0];
        local_47 = u32(_e157);
        let _e161 = local_46[1];
        local_48 = u32(_e161);
        let _e164 = local_48;
        out_1[_e164] = i32(_e140);
        let _e166 = value;
        let _e168 = retreat(u32(_e166));
        let _e170 = out;
        local_10 = _e170;
        let _e171 = base;
        local_11 = u32((_e171 + 4u));
        let _e178 = local_10;
        local_49 = _e178;
        let _e179 = local_11;
        let _e181 = local_49[1];
        local_49[1] = (_e181 + _e179);
        let _e185 = local_49[0];
        local_50 = u32(_e185);
        let _e189 = local_49[1];
        local_51 = u32(_e189);
        let _e192 = local_51;
        out_1[_e192] = i32(_e168);
        let _e194 = value;
        let _e197 = scale(f32(_e194), 2i);
        let _e199 = out;
        local_12 = _e199;
        let _e200 = base;
        local_13 = u32((_e200 + 5u));
        let _e207 = local_12;
        local_52 = _e207;
        let _e208 = local_13;
        let _e210 = local_52[1];
        local_52[1] = (_e210 + _e208);
        let _e214 = local_52[0];
        local_53 = u32(_e214);
        let _e218 = local_52[1];
        local_54 = u32(_e218);
        let _e221 = local_54;
        out_1[_e221] = i32(_e197);
        let _e223 = value;
        let _e225 = input;
        local_16 = _e225;
        let _e226 = i;
        local_17 = u32(_e226);
        let _e230 = local_16;
        local_55 = _e230;
        let _e231 = local_17;
        let _e233 = local_55[1];
        local_55[1] = (_e233 + _e231);
        let _e237 = local_55[0];
        local_56 = u32(_e237);
        let _e241 = local_55[1];
        local_57 = u32(_e241);
        let _e245 = local_57;
        let _e247 = input_1[_e245];
        local_58 = _e247;
        let _e248 = local_58;
        local_31 = _e248;
        let _e250 = local_31;
        let _e251 = same(_e223, _e250);
        let _e253 = out;
        local_14 = _e253;
        let _e254 = base;
        local_15 = u32((_e254 + 6u));
        let _e261 = local_14;
        local_59 = _e261;
        let _e262 = local_15;
        let _e264 = local_59[1];
        local_59[1] = (_e264 + _e262);
        let _e268 = local_59[0];
        local_60 = u32(_e268);
        let _e272 = local_59[1];
        local_61 = u32(_e272);
        let _e275 = local_61;
        out_1[_e275] = i32(_e251);
        let _e277 = i;
        let _e282 = value;
        value = (_e282 + 1i);
        consume(((_e277 % 2u) == 0u), _e282);
        let _e285 = value;
        let _e287 = out;
        local_18 = _e287;
        let _e288 = base;
        local_19 = u32((_e288 + 7u));
        let _e294 = local_18;
        local_62 = _e294;
        let _e295 = local_19;
        let _e297 = local_62[1];
        local_62[1] = (_e297 + _e295);
        let _e301 = local_62[0];
        local_63 = u32(_e301);
        let _e305 = local_62[1];
        local_64 = u32(_e305);
        let _e308 = local_64;
        out_1[_e308] = _e285;
        let _e310 = i;
        let _e315 = value;
        value = (_e315 + 1i);
        forward(((_e310 % 2u) != 0u), _e315);
        let _e318 = value;
        let _e320 = out;
        local_20 = _e320;
        let _e321 = base;
        local_21 = u32((_e321 + 8u));
        let _e327 = local_20;
        local_65 = _e327;
        let _e328 = local_21;
        let _e330 = local_65[1];
        local_65[1] = (_e330 + _e328);
        let _e334 = local_65[0];
        local_66 = u32(_e334);
        let _e338 = local_65[1];
        local_67 = u32(_e338);
        let _e341 = local_67;
        out_1[_e341] = _e318;
        let _e343 = value;
        let _e345 = input;
        local_24 = _e345;
        let _e346 = i;
        local_25 = u32(_e346);
        let _e350 = local_24;
        local_68 = _e350;
        let _e351 = local_25;
        let _e353 = local_68[1];
        local_68[1] = (_e353 + _e351);
        let _e357 = local_68[0];
        local_69 = u32(_e357);
        let _e361 = local_68[1];
        local_70 = u32(_e361);
        let _e365 = local_70;
        let _e367 = input_1[_e365];
        local_71 = _e367;
        let _e368 = local_71;
        local_32 = _e368;
        let _e370 = local_32;
        let _e371 = same(_e343, _e370);
        let _e373 = out;
        local_22 = _e373;
        let _e374 = base;
        local_23 = u32((_e374 + 9u));
        let _e381 = local_22;
        local_72 = _e381;
        let _e382 = local_23;
        let _e384 = local_72[1];
        local_72[1] = (_e384 + _e382);
        let _e388 = local_72[0];
        local_73 = u32(_e388);
        let _e392 = local_72[1];
        local_74 = u32(_e392);
        let _e395 = local_74;
        out_1[_e395] = i32(_e371);
        let _e397 = value;
        let _e398 = increment(_e397);
        let _e399 = increment(_e398);
        let _e401 = out;
        local_26 = _e401;
        let _e402 = base;
        local_27 = u32((_e402 + 10u));
        let _e408 = local_26;
        local_75 = _e408;
        let _e409 = local_27;
        let _e411 = local_75[1];
        local_75[1] = (_e411 + _e409);
        let _e415 = local_75[0];
        local_76 = u32(_e415);
        let _e419 = local_75[1];
        local_77 = u32(_e419);
        let _e422 = local_77;
        out_1[_e422] = _e399;
        let _e424 = value;
        let _e426 = out;
        local_28 = _e426;
        let _e427 = base;
        local_29 = u32((_e427 + 11u));
        let _e433 = local_28;
        local_78 = _e433;
        let _e434 = local_29;
        let _e436 = local_78[1];
        local_78[1] = (_e436 + _e434);
        let _e440 = local_78[0];
        local_79 = u32(_e440);
        let _e444 = local_78[1];
        local_80 = u32(_e444);
        let _e447 = local_80;
        out_1[_e447] = _e424;
    }
}
