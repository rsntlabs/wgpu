struct type_6 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<vec2<u32>>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_6;

fn kind(value_2: f32) -> u32 {
    return 1u;
}

fn gen__naga_remainderf(dividend_bits: u32, divisor_bits: u32) -> u32 {
    var dividend_significand: u32;
    var dividend_exponent: i32;
    var divisor_significand: u32;
    var divisor_exponent: i32;
    var remainder: u32;
    var remaining_bits: u32;

    let _e8 = (dividend_bits & 2147483647u);
    let _e9 = (divisor_bits & 2147483647u);
    let _e10 = (dividend_bits & 2147483648u);
    if ((_e8 >= 2139095040u) || ((_e9 > 2139095040u) || (_e9 == 0u))) {
        return 2143289344u;
    }
    if ((_e8 == 0u) || (_e9 == 2139095040u)) {
        return dividend_bits;
    }
    if (_e8 == _e9) {
        return _e10;
    }
    let _e24 = (_e8 & 8388607u);
    let _e25 = (_e8 >> 23u);
    dividend_significand = (_e24 | 8388608u);
    dividend_exponent = (i32(_e25) - 127i);
    if (_e25 == 0u) {
        let _e35 = (countLeadingZeros(_e24) - 8u);
        dividend_significand = (_e24 << _e35);
        dividend_exponent = (-126i - i32(_e35));
    }
    let _e40 = dividend_significand;
    let _e41 = dividend_exponent;
    let _e46 = (_e9 & 8388607u);
    let _e47 = (_e9 >> 23u);
    divisor_significand = (_e46 | 8388608u);
    divisor_exponent = (i32(_e47) - 127i);
    if (_e47 == 0u) {
        let _e57 = (countLeadingZeros(_e46) - 8u);
        divisor_significand = (_e46 << _e57);
        divisor_exponent = (-126i - i32(_e57));
    }
    let _e62 = divisor_significand;
    let _e63 = divisor_exponent;
    remainder = _e40;
    let _e66 = (_e41 - _e63);
    if (_e66 < -1i) {
        return dividend_bits;
    }
    let _e70 = (_e66 == -1i);
    let _e72 = select(_e62, (_e62 << 1u), _e70);
    remaining_bits = u32(select(_e66, 0i, _e70));
    loop {
        let _e76 = remaining_bits;
        if (_e76 == 0u) {
            break;
        }
        let _e78 = remainder;
        remainder = (select(_e78, (_e78 - _e72), (_e78 >= _e72)) << 1u);
        remaining_bits = (_e76 - 1u);
    }
    let _e84 = remainder;
    let _e85 = (_e84 >= _e72);
    let _e87 = select(_e84, (_e84 - _e72), _e85);
    let _e88 = (_e87 + _e87);
    let _e92 = ((_e88 > _e72) || ((_e88 == _e72) && _e85));
    let _e96 = select(_e87, (_e72 - _e87), _e92);
    let _e97 = select(_e10, (_e10 ^ 2147483648u), _e92);
    if (_e96 == 0u) {
        return _e97;
    }
    let _e101 = (countLeadingZeros(_e96) - 8u);
    let _e102 = (_e96 << _e101);
    let _e104 = (select(_e63, _e41, _e70) - i32(_e101));
    return (_e97 | select((_e102 >> (u32((-126i - _e104)) & 31u)), ((u32((_e104 + 127i)) << 23u) | (_e102 & 8388607u)), (_e104 >= -126i)));
}

@compute @workgroup_size(4, 1, 1)
fn nearest_remainders(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var value: f32;
    var value_1: f32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 4u));
    let _e18 = input[index].x;
    let x = bitcast<f32>(_e18);
    let _e22 = input[index].y;
    let y = bitcast<f32>(_e22);
    counter = 0u;
    let _e28 = gen__naga_remainderf(bitcast<u32>(x), bitcast<u32>(y));
    output[base] = bitcast<u32>(bitcast<f32>(_e28));
    value = f32();
    value = x;
    let _e36 = counter;
    counter = (_e36 + u32(1i));
    let _e40 = value;
    value_1 = f32();
    value_1 = y;
    let _e44 = counter;
    counter = (_e44 + u32(1i));
    let _e48 = value_1;
    let _e51 = gen__naga_remainderf(bitcast<u32>(_e40), bitcast<u32>(_e48));
    local = u32((base + 1u));
    let _e58 = local;
    output[_e58] = bitcast<u32>(bitcast<f32>(_e51));
    let _e60 = counter;
    local_1 = u32((base + 2u));
    let _e65 = local_1;
    output[_e65] = _e60;
    let _e69 = gen__naga_remainderf(bitcast<u32>(x), bitcast<u32>(y));
    let _e71 = kind(bitcast<f32>(_e69));
    local_2 = u32((base + 3u));
    let _e76 = local_2;
    output[_e76] = _e71;
}
