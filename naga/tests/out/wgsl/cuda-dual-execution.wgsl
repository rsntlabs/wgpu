struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
@group(0) @binding(2)
var<uniform> n_1: type_5;

fn step_(value_1: i32) -> i32 {
    var value_2: i32;

    value_2 = value_1;
    let _e3 = value_2;
    value_2 = (_e3 + 3i);
    let _e5 = value_2;
    return _e5;
}

fn doubled(value_3: i32) -> i32 {
    var value_4: i32;

    value_4 = value_3;
    let _e2 = value_4;
    let _e3 = step_(_e2);
    return (_e3 * 2i);
}

fn advance(value_5: u32) -> u32 {
    var value_6: u32;

    value_6 = value_5;
    let _e3 = value_6;
    return (_e3 + 5u);
}

fn retreat(value_7: u32) -> u32 {
    var value_8: u32;

    value_8 = value_7;
    let _e3 = value_8;
    return (_e3 - 2u);
}

fn scale(value_9: f32, bias: i32) -> f32 {
    var value_10: f32;
    var bias_1: i32;

    value_10 = value_9;
    bias_1 = bias;
    let _e5 = value_10;
    let _e7 = bias_1;
    return ((_e5 * 2f) + f32(_e7));
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
    let _e6 = step_(_e5);
    consume(_e4, _e6);
    return;
}

fn device_only(value_15: i32) -> i32 {
    var value_16: i32;

    value_16 = value_15;
    let _e2 = value_16;
    let _e3 = step_(_e2);
    return (_e3 + 1i);
}

@compute @workgroup_size(64, 1, 1)
fn dual_execution(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var n: u32;
    var i: u32;
    var base: u32;
    var value: i32;
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
    var local_48: i32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;
    var local_56: i32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: i32;
    var local_62: u32;
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
        let _e43 = value;
        let _e44 = step_(_e43);
        let _e45 = local;
        local_5 = _e45;
        let _e47 = local_5;
        local_6 = u32(_e47);
        let _e50 = base;
        local_7 = u32(_e50);
        let _e54 = local_6;
        let _e55 = local_7;
        local_49 = u32((_e54 + _e55));
        let _e59 = local_49;
        out[_e59] = _e44;
        let _e61 = value;
        let _e62 = local;
        local_8 = _e62;
        let _e64 = local_8;
        local_9 = u32(_e64);
        let _e67 = base;
        local_10 = u32((_e67 + 1u));
        let _e72 = local_9;
        let _e73 = local_10;
        local_50 = u32((_e72 + _e73));
        let _e77 = local_50;
        out[_e77] = _e61;
        let _e79 = value;
        let _e80 = doubled(_e79);
        let _e81 = local;
        local_11 = _e81;
        let _e83 = local_11;
        local_12 = u32(_e83);
        let _e86 = base;
        local_13 = u32((_e86 + 2u));
        let _e91 = local_12;
        let _e92 = local_13;
        local_51 = u32((_e91 + _e92));
        let _e96 = local_51;
        out[_e96] = _e80;
        let _e98 = value;
        let _e100 = advance(u32(_e98));
        let _e101 = local;
        local_14 = _e101;
        let _e103 = local_14;
        local_15 = u32(_e103);
        let _e106 = base;
        local_16 = u32((_e106 + 3u));
        let _e112 = local_15;
        let _e113 = local_16;
        local_52 = u32((_e112 + _e113));
        let _e117 = local_52;
        out[_e117] = i32(_e100);
        let _e119 = value;
        let _e121 = retreat(u32(_e119));
        let _e122 = local;
        local_17 = _e122;
        let _e124 = local_17;
        local_18 = u32(_e124);
        let _e127 = base;
        local_19 = u32((_e127 + 4u));
        let _e133 = local_18;
        let _e134 = local_19;
        local_53 = u32((_e133 + _e134));
        let _e138 = local_53;
        out[_e138] = i32(_e121);
        let _e140 = value;
        let _e143 = scale(f32(_e140), 4i);
        let _e144 = local;
        local_20 = _e144;
        let _e146 = local_20;
        local_21 = u32(_e146);
        let _e149 = base;
        local_22 = u32((_e149 + 5u));
        let _e155 = local_21;
        let _e156 = local_22;
        local_54 = u32((_e155 + _e156));
        let _e160 = local_54;
        out[_e160] = i32(_e143);
        let _e162 = value;
        let _e163 = local_1;
        local_26 = _e163;
        let _e165 = local_26;
        local_27 = u32(_e165);
        let _e168 = i;
        local_28 = u32(_e168);
        let _e171 = local_27;
        let _e172 = local_28;
        local_55 = u32((_e171 + _e172));
        let _e177 = local_55;
        let _e179 = input[_e177];
        local_56 = _e179;
        let _e180 = local_56;
        let _e181 = same(_e162, _e180);
        let _e182 = local;
        local_23 = _e182;
        let _e184 = local_23;
        local_24 = u32(_e184);
        let _e187 = base;
        local_25 = u32((_e187 + 6u));
        let _e193 = local_24;
        let _e194 = local_25;
        local_57 = u32((_e193 + _e194));
        let _e198 = local_57;
        out[_e198] = i32(_e181);
        let _e200 = i;
        let _e205 = value;
        value = (_e205 + 1i);
        consume(((_e200 % 2u) == 0u), _e205);
        let _e208 = value;
        let _e209 = local;
        local_29 = _e209;
        let _e211 = local_29;
        local_30 = u32(_e211);
        let _e214 = base;
        local_31 = u32((_e214 + 7u));
        let _e219 = local_30;
        let _e220 = local_31;
        local_58 = u32((_e219 + _e220));
        let _e224 = local_58;
        out[_e224] = _e208;
        let _e226 = i;
        let _e231 = value;
        value = (_e231 + 1i);
        forward(((_e226 % 2u) != 0u), _e231);
        let _e234 = value;
        let _e235 = local;
        local_32 = _e235;
        let _e237 = local_32;
        local_33 = u32(_e237);
        let _e240 = base;
        local_34 = u32((_e240 + 8u));
        let _e245 = local_33;
        let _e246 = local_34;
        local_59 = u32((_e245 + _e246));
        let _e250 = local_59;
        out[_e250] = _e234;
        let _e252 = value;
        let _e253 = local_1;
        local_38 = _e253;
        let _e255 = local_38;
        local_39 = u32(_e255);
        let _e258 = i;
        local_40 = u32(_e258);
        let _e261 = local_39;
        let _e262 = local_40;
        local_60 = u32((_e261 + _e262));
        let _e267 = local_60;
        let _e269 = input[_e267];
        local_61 = _e269;
        let _e270 = local_61;
        let _e271 = same(_e252, _e270);
        let _e272 = local;
        local_35 = _e272;
        let _e274 = local_35;
        local_36 = u32(_e274);
        let _e277 = base;
        local_37 = u32((_e277 + 9u));
        let _e283 = local_36;
        let _e284 = local_37;
        local_62 = u32((_e283 + _e284));
        let _e288 = local_62;
        out[_e288] = i32(_e271);
        let _e290 = value;
        let _e291 = step_(_e290);
        let _e292 = device_only(_e291);
        let _e293 = local;
        local_41 = _e293;
        let _e295 = local_41;
        local_42 = u32(_e295);
        let _e298 = base;
        local_43 = u32((_e298 + 10u));
        let _e303 = local_42;
        let _e304 = local_43;
        local_63 = u32((_e303 + _e304));
        let _e308 = local_63;
        out[_e308] = _e292;
        let _e310 = value;
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
