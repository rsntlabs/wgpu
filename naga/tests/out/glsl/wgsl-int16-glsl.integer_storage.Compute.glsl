#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct IntegerRecord {
    int16_t signed_value;
    uint16_t unsigned_value;
    i16vec2 signed_pair;
    u16vec3 unsigned_triple;
    int16_t tail;
    int16_t signed_array[4];
    uint16_t unsigned_array[4];
};
layout(std430) readonly buffer type_6_block_0Compute { IntegerRecord _group_0_binding_0_cs[]; };

layout(std430) buffer type_6_block_1Compute { IntegerRecord _group_0_binding_1_cs[]; };

layout(std430) buffer type_7_block_2Compute { int16_t _group_0_binding_2_cs[]; };

layout(std430) buffer type_8_block_3Compute { uint16_t _group_0_binding_3_cs[]; };

int16_t private_signed = int16_t(-32768);

uint16_t private_unsigned = uint16_t(65535);

shared int16_t shared_signed[4];

shared u16vec2 shared_unsigned[4];


int16_t signed_arithmetic(int16_t value) {
    int16_t positive = (value & int16_t(32767));
    int16_t _e10 = ((((positive + int16_t(3)) * int16_t(2)) - int16_t(1)) / int16_t(3));
    return (_e10 - int16_t(17) * (_e10 / int16_t(17)));
}

uint16_t unsigned_arithmetic(uint16_t value_1) {
    uint16_t shifted = ((value_1 << 1u) | (value_1 >> 1u));
    return ((~(shifted) ^ uint16_t(255)) + uint16_t(1));
}

IntegerRecord transformed(IntegerRecord record) {
    IntegerRecord result = IntegerRecord(int16_t(0), uint16_t(0), i16vec2(0), u16vec3(0u), int16_t(0), int16_t[4](int16_t(0), int16_t(0), int16_t(0), int16_t(0)), uint16_t[4](uint16_t(0), uint16_t(0), uint16_t(0), uint16_t(0)));
    result = record;
    int16_t _e4 = signed_arithmetic(record.signed_value);
    result.signed_value = _e4;
    uint16_t _e7 = unsigned_arithmetic(record.unsigned_value);
    result.unsigned_value = _e7;
    result.signed_pair = (record.signed_pair + i16vec2(int16_t(-1), int16_t(32767)));
    result.unsigned_triple = (record.unsigned_triple ^ u16vec3(uint16_t(0), uint16_t(32768), uint16_t(65535)));
    result.tail = min(record.tail, int16_t(32767));
    result.signed_array[0] = int16_t(-32768);
    result.signed_array[3] = int16_t(32767);
    result.unsigned_array[0] = uint16_t(0);
    result.unsigned_array[3] = uint16_t(65535);
    IntegerRecord _e37 = result;
    return _e37;
}

void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        shared_signed = int16_t[4](int16_t(0), int16_t(0), int16_t(0), int16_t(0));
        shared_unsigned = u16vec2[4](u16vec2(0u), u16vec2(0u), u16vec2(0u), u16vec2(0u));
    }
    memoryBarrierShared();
    barrier();
    uint lane = gl_LocalInvocationIndex;
    IntegerRecord _e3 = _group_0_binding_0_cs[lane];
    IntegerRecord _e4 = transformed(_e3);
    shared_signed[lane] = _e4.signed_value;
    shared_unsigned[lane] = u16vec2(_e4.unsigned_value, uint16_t(lane));
    memoryBarrierShared();
    barrier();
    uint _e14 = (lane + 1u);
    uint neighbor = (_e14 - 4u * (_e14 / 4u));
    _group_0_binding_1_cs[lane] = _e4;
    int16_t _e25 = shared_signed[neighbor];
    int16_t _e27 = private_signed;
    _group_0_binding_2_cs[(lane + 1u)] = (_e25 + _e27);
    uint16_t _e36 = shared_unsigned[neighbor].x;
    uint16_t _e38 = private_unsigned;
    _group_0_binding_3_cs[(lane + 1u)] = (_e36 & _e38);
    private_signed = int16_t(int(_e4.tail));
    private_unsigned = uint16_t(uint(_e4.unsigned_array[1]));
    return;
}

