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
    var grown: dim3_;
    var scalar_copy: dim3_;
    var converted: dim3_;
    var direct: uint3_;
    var expression: uint3_;
    var braced: dim3_;
    var raw: uint3_;
    var local: dim3_;
    var source: dim3_;
    var local_1: uint3_;
    var object: dim3_;

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
    output[u32(0i)] = _e54;
    let _e60 = default_shape.y;
    output[u32(1i)] = _e60;
    let _e65 = default_shape.z;
    output[u32(2i)] = _e65;
    let _e69 = fixed;
    let _e70 = encode(_e69);
    output[u32(3i)] = _e70;
    let _e74 = first;
    let _e75 = encode(_e74);
    output[u32(4i)] = _e75;
    let _e79 = second;
    let _e80 = encode(_e79);
    output[u32(5i)] = _e80;
    let _e84 = third;
    let _e85 = encode(_e84);
    output[u32(6i)] = _e85;
    let _e89 = copied;
    let _e90 = encode(_e89);
    output[u32(7i)] = _e90;
    let _e94 = rebuilt;
    let _e95 = encode(_e94);
    output[u32(8i)] = _e95;
    let _e99 = automatic;
    let _e100 = encode(_e99);
    output[u32(9i)] = _e100;
    let _e106 = zero.x;
    let _e107 = zero.y;
    let _e110 = zero.z;
    output[u32(10i)] = ((_e106 + _e107) + _e110);
    let _e115 = third;
    let _e116 = grow(_e115);
    grown = _e116;
    let _e119 = grown.y;
    output[u32(11i)] = _e119;
    let _e124 = third.y;
    output[u32(12i)] = _e124;
    let _e128 = rebuilt;
    let _e129 = kind(_e128);
    output[u32(13i)] = _e129;
    let _e133 = packed;
    let _e134 = kind_1(_e133);
    output[u32(14i)] = _e134;
    scalar_copy = dim3_(8u, 1u, 1u);
    let _e143 = scalar_copy;
    let _e144 = encode(_e143);
    output[u32(15i)] = _e144;
    converted = dim3_(u32(1.75f), u32(2i), u32(true));
    let _e156 = converted;
    let _e157 = encode(_e156);
    output[u32(16i)] = _e157;
    let _e161 = copied;
    direct = uint3_(_e161.x, _e161.y, _e161.z);
    let _e167 = copied;
    expression = uint3_(_e167.x, _e167.y, _e167.z);
    let _e173 = packed;
    braced = dim3_(_e173.x, _e173.y, _e173.z);
    let _e180 = direct.x;
    output[u32(17i)] = _e180;
    let _e185 = expression.z;
    output[u32(18i)] = _e185;
    let _e189 = braced;
    let _e190 = encode(_e189);
    output[u32(19i)] = _e190;
    raw.x = 2u;
    raw.y = 3u;
    raw.z = 4u;
    let _e201 = raw;
    local = dim3_(_e201.x, _e201.y, _e201.z);
    let _e208 = raw.x;
    raw.x = (_e208 + u32(1i));
    let _e213 = local.x;
    output[u32(20i)] = _e213;
    let _e218 = raw.x;
    output[u32(21i)] = _e218;
    source = dim3_(5u, 6u, 7u);
    let _e227 = source;
    local_1 = uint3_(_e227.x, _e227.y, _e227.z);
    let _e234 = source.y;
    source.y = (_e234 + u32(1i));
    let _e239 = local_1.y;
    output[u32(22i)] = _e239;
    let _e244 = source.y;
    output[u32(23i)] = _e244;
    let _e249 = source.z;
    source.z = (_e249 + u32(1i));
    let _e254 = source.z;
    output[u32(24i)] = _e254;
    let _e259 = source.z;
    output[u32(25i)] = _e259;
    object = dim3_(1u, 1u, 1u);
    let _e268 = object;
    let _e269 = encode(_e268);
    output[u32(26i)] = _e269;
}
