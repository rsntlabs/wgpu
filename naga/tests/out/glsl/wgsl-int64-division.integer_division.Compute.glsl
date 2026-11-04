#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_ARB_gpu_shader_int64 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct Values {
    int64_t signed_scalar;
    uint64_t unsigned_scalar;
    i64vec2 signed_pair;
    u64vec2 unsigned_pair;
    i64vec3 signed_triple;
    u64vec3 unsigned_triple;
    i64vec4 signed_quad;
    u64vec4 unsigned_quad;
};
layout(std430) readonly buffer type_8_block_0Compute { Values _group_0_binding_0_cs[]; };

layout(std430) buffer type_8_block_1Compute { Values _group_0_binding_1_cs[]; };

layout(std430) buffer type_8_block_2Compute { Values _group_0_binding_2_cs[]; };


int64_t naga_div64(int64_t dividend, int64_t divisor) {
    int64_t safe_divisor = ((divisor == 0l) || ((dividend == (-9223372036854775807l - 1l)) && (divisor == -1l))) ? 1l : divisor;
    return dividend / safe_divisor;
}

uint64_t naga_div64(uint64_t dividend, uint64_t divisor) {
    uint64_t safe_divisor = (divisor == 0ul) ? 1ul : divisor;
    return dividend / safe_divisor;
}

i64vec2 naga_div64(i64vec2 dividend, i64vec2 divisor) {
    return i64vec2(naga_div64(dividend.x, divisor.x), naga_div64(dividend.y, divisor.y));
}

u64vec2 naga_div64(u64vec2 dividend, u64vec2 divisor) {
    return u64vec2(naga_div64(dividend.x, divisor.x), naga_div64(dividend.y, divisor.y));
}

i64vec3 naga_div64(i64vec3 dividend, i64vec3 divisor) {
    return i64vec3(naga_div64(dividend.x, divisor.x), naga_div64(dividend.y, divisor.y), naga_div64(dividend.z, divisor.z));
}

u64vec3 naga_div64(u64vec3 dividend, u64vec3 divisor) {
    return u64vec3(naga_div64(dividend.x, divisor.x), naga_div64(dividend.y, divisor.y), naga_div64(dividend.z, divisor.z));
}

i64vec4 naga_div64(i64vec4 dividend, i64vec4 divisor) {
    return i64vec4(naga_div64(dividend.x, divisor.x), naga_div64(dividend.y, divisor.y), naga_div64(dividend.z, divisor.z), naga_div64(dividend.w, divisor.w));
}

u64vec4 naga_div64(u64vec4 dividend, u64vec4 divisor) {
    return u64vec4(naga_div64(dividend.x, divisor.x), naga_div64(dividend.y, divisor.y), naga_div64(dividend.z, divisor.z), naga_div64(dividend.w, divisor.w));
}

int64_t naga_mod64(int64_t dividend, int64_t divisor) {
    int64_t safe_divisor = ((divisor == 0l) || ((dividend == (-9223372036854775807l - 1l)) && (divisor == -1l))) ? 1l : divisor;
    return dividend - (dividend / safe_divisor) * safe_divisor;
}

uint64_t naga_mod64(uint64_t dividend, uint64_t divisor) {
    uint64_t safe_divisor = (divisor == 0ul) ? 1ul : divisor;
    return dividend % safe_divisor;
}

i64vec2 naga_mod64(i64vec2 dividend, i64vec2 divisor) {
    return i64vec2(naga_mod64(dividend.x, divisor.x), naga_mod64(dividend.y, divisor.y));
}

u64vec2 naga_mod64(u64vec2 dividend, u64vec2 divisor) {
    return u64vec2(naga_mod64(dividend.x, divisor.x), naga_mod64(dividend.y, divisor.y));
}

i64vec3 naga_mod64(i64vec3 dividend, i64vec3 divisor) {
    return i64vec3(naga_mod64(dividend.x, divisor.x), naga_mod64(dividend.y, divisor.y), naga_mod64(dividend.z, divisor.z));
}

u64vec3 naga_mod64(u64vec3 dividend, u64vec3 divisor) {
    return u64vec3(naga_mod64(dividend.x, divisor.x), naga_mod64(dividend.y, divisor.y), naga_mod64(dividend.z, divisor.z));
}

i64vec4 naga_mod64(i64vec4 dividend, i64vec4 divisor) {
    return i64vec4(naga_mod64(dividend.x, divisor.x), naga_mod64(dividend.y, divisor.y), naga_mod64(dividend.z, divisor.z), naga_mod64(dividend.w, divisor.w));
}

u64vec4 naga_mod64(u64vec4 dividend, u64vec4 divisor) {
    return u64vec4(naga_mod64(dividend.x, divisor.x), naga_mod64(dividend.y, divisor.y), naga_mod64(dividend.z, divisor.z), naga_mod64(dividend.w, divisor.w));
}

void main() {
    Values dividend = _group_0_binding_0_cs[0];
    Values divisor = _group_0_binding_0_cs[1];
    _group_0_binding_1_cs[0] = Values(naga_div64(dividend.signed_scalar, divisor.signed_scalar), naga_div64(dividend.unsigned_scalar, divisor.unsigned_scalar), naga_div64(dividend.signed_pair, divisor.signed_pair), naga_div64(dividend.unsigned_pair, divisor.unsigned_pair), naga_div64(dividend.signed_triple, divisor.signed_triple), naga_div64(dividend.unsigned_triple, divisor.unsigned_triple), naga_div64(dividend.signed_quad, divisor.signed_quad), naga_div64(dividend.unsigned_quad, divisor.unsigned_quad));
    int64_t _e35 = dividend.signed_scalar;
    int64_t _e36 = divisor.signed_scalar;
    uint64_t _e38 = dividend.unsigned_scalar;
    uint64_t _e39 = divisor.unsigned_scalar;
    i64vec2 _e41 = dividend.signed_pair;
    i64vec2 _e42 = divisor.signed_pair;
    u64vec2 _e44 = dividend.unsigned_pair;
    u64vec2 _e45 = divisor.unsigned_pair;
    i64vec3 _e47 = dividend.signed_triple;
    i64vec3 _e48 = divisor.signed_triple;
    u64vec3 _e50 = dividend.unsigned_triple;
    u64vec3 _e51 = divisor.unsigned_triple;
    i64vec4 _e53 = dividend.signed_quad;
    i64vec4 _e54 = divisor.signed_quad;
    u64vec4 _e56 = dividend.unsigned_quad;
    u64vec4 _e57 = divisor.unsigned_quad;
    _group_0_binding_2_cs[0] = Values(naga_mod64(_e35, _e36), naga_mod64(_e38, _e39), naga_mod64(_e41, _e42), naga_mod64(_e44, _e45), naga_mod64(_e47, _e48), naga_mod64(_e50, _e51), naga_mod64(_e53, _e54), naga_mod64(_e56, _e57));
    return;
}

