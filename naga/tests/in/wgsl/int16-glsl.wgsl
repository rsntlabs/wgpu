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
var<storage, read> input_records: array<IntegerRecord>;
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
    let positive = value & i16(32767);
    return ((positive + i16(3)) * i16(2) - i16(1)) / i16(3) % i16(17);
}

fn unsigned_arithmetic(value: u16) -> u16 {
    let shifted = (value << 1u) | (value >> 1u);
    return (~shifted ^ u16(255)) + u16(1);
}

fn transformed(record: IntegerRecord) -> IntegerRecord {
    var result = record;
    result.signed_value = signed_arithmetic(record.signed_value);
    result.unsigned_value = unsigned_arithmetic(record.unsigned_value);
    result.signed_pair = record.signed_pair + vec2<i16>(i16(-1), i16(32767));
    result.unsigned_triple = record.unsigned_triple ^ vec3<u16>(u16(0), u16(32768), u16(65535));
    result.tail = min(record.tail, i16(32767));
    result.signed_array[0] = i16(-32768);
    result.signed_array[3] = i16(32767);
    result.unsigned_array[0] = u16(0);
    result.unsigned_array[3] = u16(65535);
    return result;
}

@compute @workgroup_size(4)
fn integer_storage(@builtin(local_invocation_index) lane: u32) {
    let record = transformed(input_records[lane]);
    shared_signed[lane] = record.signed_value;
    shared_unsigned[lane] = vec2<u16>(record.unsigned_value, u16(lane));
    workgroupBarrier();
    let neighbor = (lane + 1u) % 4u;
    output_records[lane] = record;
    signed_values[lane + 1u] = shared_signed[neighbor] + private_signed;
    unsigned_values[lane + 1u] = shared_unsigned[neighbor].x & private_unsigned;
    private_signed = i16(i32(record.tail));
    private_unsigned = u16(u32(record.unsigned_array[1]));
}
