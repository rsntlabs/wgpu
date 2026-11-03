enable wgpu_int16;

struct IntegerRecord {
    signed_value: i16,
    unsigned_value: u16,
    signed_pair: vec2<i16>,
    unsigned_triple: vec3<u16>,
    tail: i16,
    signed_array: array<i16, 4>,
    unsigned_array: array<u16, 4>,
}

@group(0) @binding(0)
var<storage> input_records: array<IntegerRecord>;
@group(0) @binding(1)
var<storage, read_write> output_records: array<IntegerRecord>;
@group(0) @binding(2)
var<storage, read_write> signed_values: array<i16>;
@group(0) @binding(3)
var<storage, read_write> unsigned_values: array<u16>;
var<private> private_signed: i16 = i16(-32768);
var<private> private_unsigned: u16 = u16(65535);
var<workgroup> shared_signed: array<i16, 4>;
var<workgroup> shared_unsigned: array<vec2<u16>, 4>;

fn signed_arithmetic(value: i16) -> i16 {
    let positive = (value & i16(32767));
    return (((((positive + i16(3)) * i16(2)) - i16(1)) / i16(3)) % i16(17));
}

fn unsigned_arithmetic(value_1: u16) -> u16 {
    let shifted = ((value_1 << 1u) | (value_1 >> 1u));
    return ((~(shifted) ^ u16(255)) + u16(1));
}

fn transformed(record: IntegerRecord) -> IntegerRecord {
    var result: IntegerRecord;

    result = record;
    let _e4 = signed_arithmetic(record.signed_value);
    result.signed_value = _e4;
    let _e7 = unsigned_arithmetic(record.unsigned_value);
    result.unsigned_value = _e7;
    result.signed_pair = (record.signed_pair + vec2<i16>(i16(-1), i16(32767)));
    result.unsigned_triple = (record.unsigned_triple ^ vec3<u16>(u16(0), u16(32768), u16(65535)));
    result.tail = min(record.tail, i16(32767));
    result.signed_array[0] = i16(-32768);
    result.signed_array[3] = i16(32767);
    result.unsigned_array[0] = u16(0);
    result.unsigned_array[3] = u16(65535);
    let _e37 = result;
    return _e37;
}

@compute @workgroup_size(4, 1, 1)
fn integer_storage(@builtin(local_invocation_index) lane: u32) {
    let _e3 = input_records[lane];
    let record_1 = transformed(_e3);
    shared_signed[lane] = record_1.signed_value;
    shared_unsigned[lane] = vec2<u16>(record_1.unsigned_value, u16(lane));
    workgroupBarrier();
    let neighbor = ((lane + 1u) % 4u);
    output_records[lane] = record_1;
    let _e25 = shared_signed[neighbor];
    let _e27 = private_signed;
    signed_values[(lane + 1u)] = (_e25 + _e27);
    let _e36 = shared_unsigned[neighbor].x;
    let _e38 = private_unsigned;
    unsigned_values[(lane + 1u)] = (_e36 & _e38);
    private_signed = i16(i32(record_1.tail));
    private_unsigned = u16(u32(record_1.unsigned_array[1]));
    return;
}
