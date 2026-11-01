struct dim3_ {
    x: u32,
    y: u32,
    z: u32,
}

struct uint3_ {
    x: u32,
    y: u32,
    z: u32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

fn encode(value: dim3_) -> u32 {
    var value_1: dim3_;

    value_1 = value;
    let _e5 = value_1.y;
    let _e7 = value_1.x;
    let _e11 = value_1.z;
    return ((_e7 + (10u * _e5)) + (100u * _e11));
}

fn grow(value_2: dim3_) -> dim3_ {
    var value_3: dim3_;

    value_3 = value_2;
    let _e3 = value_3.y;
    value_3.y = (_e3 + u32(1i));
    let _e7 = value_3;
    return _e7;
}

fn kind(value_4: dim3_) -> u32 {
    var value_5: dim3_;

    value_5 = value_4;
    return 11u;
}

fn kind_1(value_6: uint3_) -> u32 {
    var value_7: uint3_;

    value_7 = value_6;
    return 22u;
}

@compute @workgroup_size(1, 1, 1)
fn dimensions() {
    var default_shape: dim3_;
    var fixed: dim3_;
    var first: dim3_;
    var second: dim3_;
    var third: dim3_;
    var zero: dim3_;
    var copied: dim3_;
    var packed: uint3_;
    var rebuilt: dim3_;
    var automatic: dim3_;
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
    var grown: dim3_;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var scalar_copy: dim3_;
    var local_15: u32;
    var converted: dim3_;
    var local_16: u32;
    var direct: uint3_;
    var expression: uint3_;
    var braced: dim3_;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var raw: uint3_;
    var local_20: dim3_;
    var local_21: u32;
    var local_22: u32;
    var source: dim3_;
    var local_23: uint3_;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var object: dim3_;
    var local_28: u32;

    default_shape = dim3_(1u, 1u, 1u);
    fixed = dim3_(1u, 1u, 1u);
    first = dim3_(2u, 1u, 1u);
    second = dim3_(3u, 4u, 1u);
    third = dim3_(5u, 6u, 7u);
    zero = dim3_(0u, 0u, 0u);
    let _e30 = third;
    copied = _e30;
    let _e33 = copied.x;
    copied.x = (_e33 + u32(1i));
    let _e37 = copied;
    packed = uint3_(_e37.x, _e37.y, _e37.z);
    let _e43 = packed;
    rebuilt = dim3_(_e43.x, _e43.y, _e43.z);
    let _e49 = fixed;
    automatic = _e49;
    automatic.z = 9u;
    let _e54 = default_shape.x;
    local = u32(0i);
    let _e58 = local;
    output[_e58] = _e54;
    let _e62 = default_shape.y;
    local_1 = u32(1i);
    let _e66 = local_1;
    output[_e66] = _e62;
    let _e69 = default_shape.z;
    local_2 = u32(2i);
    let _e73 = local_2;
    output[_e73] = _e69;
    let _e75 = fixed;
    let _e76 = encode(_e75);
    local_3 = u32(3i);
    let _e80 = local_3;
    output[_e80] = _e76;
    let _e82 = first;
    let _e83 = encode(_e82);
    local_4 = u32(4i);
    let _e87 = local_4;
    output[_e87] = _e83;
    let _e89 = second;
    let _e90 = encode(_e89);
    local_5 = u32(5i);
    let _e94 = local_5;
    output[_e94] = _e90;
    let _e96 = third;
    let _e97 = encode(_e96);
    local_6 = u32(6i);
    let _e101 = local_6;
    output[_e101] = _e97;
    let _e103 = copied;
    let _e104 = encode(_e103);
    local_7 = u32(7i);
    let _e108 = local_7;
    output[_e108] = _e104;
    let _e110 = rebuilt;
    let _e111 = encode(_e110);
    local_8 = u32(8i);
    let _e115 = local_8;
    output[_e115] = _e111;
    let _e117 = automatic;
    let _e118 = encode(_e117);
    local_9 = u32(9i);
    let _e122 = local_9;
    output[_e122] = _e118;
    let _e126 = zero.x;
    let _e127 = zero.y;
    let _e130 = zero.z;
    local_10 = u32(10i);
    let _e135 = local_10;
    output[_e135] = ((_e126 + _e127) + _e130);
    let _e137 = third;
    let _e138 = grow(_e137);
    grown = _e138;
    let _e141 = grown.y;
    local_11 = u32(11i);
    let _e145 = local_11;
    output[_e145] = _e141;
    let _e148 = third.y;
    local_12 = u32(12i);
    let _e152 = local_12;
    output[_e152] = _e148;
    let _e154 = rebuilt;
    let _e155 = kind(_e154);
    local_13 = u32(13i);
    let _e159 = local_13;
    output[_e159] = _e155;
    let _e161 = packed;
    let _e162 = kind_1(_e161);
    local_14 = u32(14i);
    let _e166 = local_14;
    output[_e166] = _e162;
    scalar_copy = dim3_(8u, 1u, 1u);
    let _e173 = scalar_copy;
    let _e174 = encode(_e173);
    local_15 = u32(15i);
    let _e178 = local_15;
    output[_e178] = _e174;
    converted = dim3_(u32(1.75f), u32(2i), u32(true));
    let _e188 = converted;
    let _e189 = encode(_e188);
    local_16 = u32(16i);
    let _e193 = local_16;
    output[_e193] = _e189;
    let _e195 = copied;
    direct = uint3_(_e195.x, _e195.y, _e195.z);
    let _e201 = copied;
    expression = uint3_(_e201.x, _e201.y, _e201.z);
    let _e207 = packed;
    braced = dim3_(_e207.x, _e207.y, _e207.z);
    let _e214 = direct.x;
    local_17 = u32(17i);
    let _e218 = local_17;
    output[_e218] = _e214;
    let _e221 = expression.z;
    local_18 = u32(18i);
    let _e225 = local_18;
    output[_e225] = _e221;
    let _e227 = braced;
    let _e228 = encode(_e227);
    local_19 = u32(19i);
    let _e232 = local_19;
    output[_e232] = _e228;
    raw.x = 2u;
    raw.y = 3u;
    raw.z = 4u;
    let _e241 = raw;
    local_20 = dim3_(_e241.x, _e241.y, _e241.z);
    let _e248 = raw.x;
    raw.x = (_e248 + u32(1i));
    let _e253 = local_20.x;
    local_21 = u32(20i);
    let _e257 = local_21;
    output[_e257] = _e253;
    let _e260 = raw.x;
    local_22 = u32(21i);
    let _e264 = local_22;
    output[_e264] = _e260;
    source = dim3_(5u, 6u, 7u);
    let _e271 = source;
    local_23 = uint3_(_e271.x, _e271.y, _e271.z);
    let _e278 = source.y;
    source.y = (_e278 + u32(1i));
    let _e283 = local_23.y;
    local_24 = u32(22i);
    let _e287 = local_24;
    output[_e287] = _e283;
    let _e290 = source.y;
    local_25 = u32(23i);
    let _e294 = local_25;
    output[_e294] = _e290;
    let _e297 = source.z;
    source.z = (_e297 + u32(1i));
    let _e302 = source.z;
    local_26 = u32(24i);
    let _e306 = local_26;
    output[_e306] = _e302;
    let _e309 = source.z;
    local_27 = u32(25i);
    let _e313 = local_27;
    output[_e313] = _e309;
    object = dim3_(1u, 1u, 1u);
    let _e320 = object;
    let _e321 = encode(_e320);
    local_28 = u32(26i);
    let _e325 = local_28;
    output[_e325] = _e321;
}
