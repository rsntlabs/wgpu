struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
@group(0) @binding(1)
var<storage> input_1: array<i32>;
@group(0) @binding(2)
var<uniform> n: type_5;

fn increment(value_1: i32) -> i32 {
    var value_2: i32;

    value_2 = value_1;
    let _e3 = value_2;
    value_2 = (_e3 + 2i);
    let _e5 = value_2;
    return _e5;
}

fn doubled(value_3: i32) -> i32 {
    let _e1 = increment(value_3);
    return (_e1 * 2i);
}

fn advance(value_4: u32) -> u32 {
    return (value_4 + 3u);
}

fn retreat(value_5: u32) -> u32 {
    return (value_5 - 1u);
}

fn scale(value_6: f32, bias: i32) -> f32 {
    return ((value_6 * 1.5f) + f32(bias));
}

fn same(left: i32, right: i32) -> bool {
    return (left == right);
}

fn consume(stop: bool, value_7: i32) {
    var value_8: i32;

    value_8 = value_7;
    if stop {
        return;
    }
    let _e3 = value_8;
    let _e4 = doubled(_e3);
    value_8 = _e4;
    return;
}

fn forward(stop_1: bool, value_9: i32) {
    let _e2 = increment(value_9);
    consume(stop_1, _e2);
    return;
}

@compute @workgroup_size(64, 1, 1)
fn inline_functions(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var out: array<u32, 2>;
    var input: array<u32, 2>;
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
    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 12u);
        let _e27 = input;
        local = _e27;
        local_1 = u32(i);
        let _e31 = local;
        local_33 = _e31;
        let _e33 = local_1;
        let _e35 = local_33[1];
        local_33[1] = (_e35 + _e33);
        let _e39 = local_33[0];
        local_34 = u32(_e39);
        let _e43 = local_33[1];
        local_35 = u32(_e43);
        let _e46 = local_35;
        let _e49 = input_1[_e46];
        local_36 = _e49;
        let _e51 = local_36;
        local_30 = _e51;
        let _e53 = local_30;
        value = _e53;
        let _e55 = value;
        let _e56 = increment(_e55);
        let _e58 = out;
        local_2 = _e58;
        let _e60 = base;
        local_3 = u32(_e60);
        let _e63 = local_2;
        local_37 = _e63;
        let _e65 = local_3;
        let _e67 = local_37[1];
        local_37[1] = (_e67 + _e65);
        let _e71 = local_37[0];
        local_38 = u32(_e71);
        let _e75 = local_37[1];
        local_39 = u32(_e75);
        let _e78 = local_39;
        out_1[_e78] = _e56;
        let _e81 = value;
        let _e82 = out;
        local_4 = _e82;
        let _e84 = base;
        local_5 = u32((_e84 + 1u));
        let _e89 = local_4;
        local_40 = _e89;
        let _e91 = local_5;
        let _e93 = local_40[1];
        local_40[1] = (_e93 + _e91);
        let _e97 = local_40[0];
        local_41 = u32(_e97);
        let _e101 = local_40[1];
        local_42 = u32(_e101);
        let _e104 = local_42;
        out_1[_e104] = _e81;
        let _e106 = value;
        let _e107 = doubled(_e106);
        let _e108 = out;
        local_6 = _e108;
        let _e110 = base;
        local_7 = u32((_e110 + 2u));
        let _e115 = local_6;
        local_43 = _e115;
        let _e117 = local_7;
        let _e119 = local_43[1];
        local_43[1] = (_e119 + _e117);
        let _e123 = local_43[0];
        local_44 = u32(_e123);
        let _e127 = local_43[1];
        local_45 = u32(_e127);
        let _e130 = local_45;
        out_1[_e130] = _e107;
        let _e132 = value;
        let _e134 = advance(u32(_e132));
        let _e135 = out;
        local_8 = _e135;
        let _e137 = base;
        local_9 = u32((_e137 + 3u));
        let _e143 = local_8;
        local_46 = _e143;
        let _e145 = local_9;
        let _e147 = local_46[1];
        local_46[1] = (_e147 + _e145);
        let _e151 = local_46[0];
        local_47 = u32(_e151);
        let _e155 = local_46[1];
        local_48 = u32(_e155);
        let _e158 = local_48;
        out_1[_e158] = i32(_e134);
        let _e160 = value;
        let _e162 = retreat(u32(_e160));
        let _e163 = out;
        local_10 = _e163;
        let _e165 = base;
        local_11 = u32((_e165 + 4u));
        let _e171 = local_10;
        local_49 = _e171;
        let _e173 = local_11;
        let _e175 = local_49[1];
        local_49[1] = (_e175 + _e173);
        let _e179 = local_49[0];
        local_50 = u32(_e179);
        let _e183 = local_49[1];
        local_51 = u32(_e183);
        let _e186 = local_51;
        out_1[_e186] = i32(_e162);
        let _e188 = value;
        let _e191 = scale(f32(_e188), 2i);
        let _e192 = out;
        local_12 = _e192;
        let _e194 = base;
        local_13 = u32((_e194 + 5u));
        let _e200 = local_12;
        local_52 = _e200;
        let _e202 = local_13;
        let _e204 = local_52[1];
        local_52[1] = (_e204 + _e202);
        let _e208 = local_52[0];
        local_53 = u32(_e208);
        let _e212 = local_52[1];
        local_54 = u32(_e212);
        let _e215 = local_54;
        out_1[_e215] = i32(_e191);
        let _e217 = value;
        let _e218 = input;
        local_16 = _e218;
        local_17 = u32(i);
        let _e222 = local_16;
        local_55 = _e222;
        let _e224 = local_17;
        let _e226 = local_55[1];
        local_55[1] = (_e226 + _e224);
        let _e230 = local_55[0];
        local_56 = u32(_e230);
        let _e234 = local_55[1];
        local_57 = u32(_e234);
        let _e237 = local_57;
        let _e239 = input_1[_e237];
        local_58 = _e239;
        let _e241 = local_58;
        local_31 = _e241;
        let _e243 = local_31;
        let _e244 = same(_e217, _e243);
        let _e245 = out;
        local_14 = _e245;
        let _e247 = base;
        local_15 = u32((_e247 + 6u));
        let _e253 = local_14;
        local_59 = _e253;
        let _e255 = local_15;
        let _e257 = local_59[1];
        local_59[1] = (_e257 + _e255);
        let _e261 = local_59[0];
        local_60 = u32(_e261);
        let _e265 = local_59[1];
        local_61 = u32(_e265);
        let _e268 = local_61;
        out_1[_e268] = i32(_e244);
        let _e274 = value;
        value = (_e274 + 1i);
        consume(((i % 2u) == 0u), _e274);
        let _e277 = value;
        let _e278 = out;
        local_18 = _e278;
        let _e280 = base;
        local_19 = u32((_e280 + 7u));
        let _e285 = local_18;
        local_62 = _e285;
        let _e287 = local_19;
        let _e289 = local_62[1];
        local_62[1] = (_e289 + _e287);
        let _e293 = local_62[0];
        local_63 = u32(_e293);
        let _e297 = local_62[1];
        local_64 = u32(_e297);
        let _e300 = local_64;
        out_1[_e300] = _e277;
        let _e306 = value;
        value = (_e306 + 1i);
        forward(((i % 2u) != 0u), _e306);
        let _e309 = value;
        let _e310 = out;
        local_20 = _e310;
        let _e312 = base;
        local_21 = u32((_e312 + 8u));
        let _e317 = local_20;
        local_65 = _e317;
        let _e319 = local_21;
        let _e321 = local_65[1];
        local_65[1] = (_e321 + _e319);
        let _e325 = local_65[0];
        local_66 = u32(_e325);
        let _e329 = local_65[1];
        local_67 = u32(_e329);
        let _e332 = local_67;
        out_1[_e332] = _e309;
        let _e334 = value;
        let _e335 = input;
        local_24 = _e335;
        local_25 = u32(i);
        let _e339 = local_24;
        local_68 = _e339;
        let _e341 = local_25;
        let _e343 = local_68[1];
        local_68[1] = (_e343 + _e341);
        let _e347 = local_68[0];
        local_69 = u32(_e347);
        let _e351 = local_68[1];
        local_70 = u32(_e351);
        let _e354 = local_70;
        let _e356 = input_1[_e354];
        local_71 = _e356;
        let _e358 = local_71;
        local_32 = _e358;
        let _e360 = local_32;
        let _e361 = same(_e334, _e360);
        let _e362 = out;
        local_22 = _e362;
        let _e364 = base;
        local_23 = u32((_e364 + 9u));
        let _e370 = local_22;
        local_72 = _e370;
        let _e372 = local_23;
        let _e374 = local_72[1];
        local_72[1] = (_e374 + _e372);
        let _e378 = local_72[0];
        local_73 = u32(_e378);
        let _e382 = local_72[1];
        local_74 = u32(_e382);
        let _e385 = local_74;
        out_1[_e385] = i32(_e361);
        let _e387 = value;
        let _e388 = increment(_e387);
        let _e389 = increment(_e388);
        let _e390 = out;
        local_26 = _e390;
        let _e392 = base;
        local_27 = u32((_e392 + 10u));
        let _e397 = local_26;
        local_75 = _e397;
        let _e399 = local_27;
        let _e401 = local_75[1];
        local_75[1] = (_e401 + _e399);
        let _e405 = local_75[0];
        local_76 = u32(_e405);
        let _e409 = local_75[1];
        local_77 = u32(_e409);
        let _e412 = local_77;
        out_1[_e412] = _e389;
        let _e414 = value;
        let _e415 = out;
        local_28 = _e415;
        let _e417 = base;
        local_29 = u32((_e417 + 11u));
        let _e422 = local_28;
        local_78 = _e422;
        let _e424 = local_29;
        let _e426 = local_78[1];
        local_78[1] = (_e426 + _e424);
        let _e430 = local_78[0];
        local_79 = u32(_e430);
        let _e434 = local_78[1];
        local_80 = u32(_e434);
        let _e437 = local_80;
        out_1[_e437] = _e414;
    }
}
