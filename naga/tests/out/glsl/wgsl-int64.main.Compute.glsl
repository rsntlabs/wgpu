#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
#extension GL_ARB_gpu_shader_int64 : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct UniformCompatible {
    uint val_u32_;
    int val_i32_;
    float val_f32_;
    uint64_t val_u64_;
    u64vec2 val_u64_2_;
    u64vec3 val_u64_3_;
    u64vec4 val_u64_4_;
    int64_t val_i64_;
    i64vec2 val_i64_2_;
    i64vec3 val_i64_3_;
    i64vec4 val_i64_4_;
    uint64_t final_value;
};
struct StorageCompatible {
    uint64_t val_u64_array_2_[2];
    int64_t val_i64_array_2_[2];
};
const uint64_t constant_variable = 20ul;

int64_t private_variable = 1l;

layout(std140) uniform UniformCompatible_block_0Compute { UniformCompatible _group_0_binding_0_cs; };

layout(std430) readonly buffer UniformCompatible_block_1Compute { UniformCompatible _group_0_binding_1_cs; };

layout(std430) readonly buffer StorageCompatible_block_2Compute { StorageCompatible _group_0_binding_2_cs; };

layout(std430) buffer UniformCompatible_block_3Compute { UniformCompatible _group_0_binding_3_cs; };

layout(std430) buffer StorageCompatible_block_4Compute { StorageCompatible _group_0_binding_4_cs; };


int64_t int64_function(int64_t x) {
    int64_t val = 20l;
    int64_t phony = private_variable;
    int64_t _e5 = val;
    val = (_e5 + 9222370033850770834l);
    int64_t _e8 = val;
    int64_t _e9 = val;
    val = (_e8 + (_e9 + 5l));
    int64_t _e13 = val;
    uint _e16 = _group_0_binding_0_cs.val_u32_;
    int64_t _e17 = val;
    val = (_e13 + int64_t((_e16 + uint(_e17))));
    int64_t _e22 = val;
    int _e25 = _group_0_binding_0_cs.val_i32_;
    int64_t _e26 = val;
    val = (_e22 + int64_t((_e25 + int(_e26))));
    int64_t _e31 = val;
    float _e34 = _group_0_binding_0_cs.val_f32_;
    int64_t _e35 = val;
    val = (_e31 + int64_t(clamp((_e34 + float(_e35)), -9.223372e18, 9.2233715e18)));
    int64_t _e40 = val;
    int64_t _e43 = _group_0_binding_0_cs.val_i64_;
    val = (_e40 + i64vec3(_e43).z);
    int64_t _e47 = val;
    uint64_t _e50 = _group_0_binding_0_cs.val_u64_;
    val = (_e47 + int64_t(_e50));
    int64_t _e53 = val;
    u64vec2 _e56 = _group_0_binding_0_cs.val_u64_2_;
    val = (_e53 + i64vec2(_e56).y);
    int64_t _e60 = val;
    u64vec3 _e63 = _group_0_binding_0_cs.val_u64_3_;
    val = (_e60 + i64vec3(_e63).z);
    int64_t _e67 = val;
    u64vec4 _e70 = _group_0_binding_0_cs.val_u64_4_;
    val = (_e67 + i64vec4(_e70).w);
    int64_t _e74 = val;
    val = (_e74 + (-9223372036854775807l - 1l));
    int64_t _e81 = _group_0_binding_0_cs.val_i64_;
    int64_t _e84 = _group_0_binding_1_cs.val_i64_;
    _group_0_binding_3_cs.val_i64_ = (_e81 + _e84);
    i64vec2 _e90 = _group_0_binding_0_cs.val_i64_2_;
    i64vec2 _e93 = _group_0_binding_1_cs.val_i64_2_;
    _group_0_binding_3_cs.val_i64_2_ = (_e90 + _e93);
    i64vec3 _e99 = _group_0_binding_0_cs.val_i64_3_;
    i64vec3 _e102 = _group_0_binding_1_cs.val_i64_3_;
    _group_0_binding_3_cs.val_i64_3_ = (_e99 + _e102);
    i64vec4 _e108 = _group_0_binding_0_cs.val_i64_4_;
    i64vec4 _e111 = _group_0_binding_1_cs.val_i64_4_;
    _group_0_binding_3_cs.val_i64_4_ = (_e108 + _e111);
    int64_t _e117[2] = _group_0_binding_2_cs.val_i64_array_2_;
    _group_0_binding_4_cs.val_i64_array_2_ = _e117;
    int64_t _e118 = val;
    int64_t _e119 = val;
    val = (_e118 + abs(_e119));
    int64_t _e122 = val;
    int64_t _e123 = val;
    int64_t _e124 = val;
    int64_t _e125 = val;
    val = (_e122 + min(max(_e123, _e124), _e125));
    int64_t _e128 = val;
    int64_t _e129 = val;
    i64vec2 _e130 = i64vec2(_e129);
    int64_t _e131 = val;
    i64vec2 _e132 = i64vec2(_e131);
    val = (_e128 + ( + _e130.x * _e132.x + _e130.y * _e132.y));
    int64_t _e135 = val;
    int64_t _e136 = val;
    int64_t _e137 = val;
    val = (_e135 + max(_e136, _e137));
    int64_t _e140 = val;
    int64_t _e141 = val;
    int64_t _e142 = val;
    val = (_e140 + min(_e141, _e142));
    int64_t _e145 = val;
    int64_t _e146 = val;
    val = (_e145 + sign(_e146));
    int64_t _e149 = val;
    return _e149;
}

uint64_t uint64_function(uint64_t x_1) {
    uint64_t val_1 = 20ul;
    uint64_t _e3 = val_1;
    val_1 = (_e3 + 31ul);
    uint64_t _e6 = val_1;
    uint64_t _e7 = val_1;
    val_1 = (_e6 + (_e7 + 5ul));
    uint64_t _e11 = val_1;
    uint _e14 = _group_0_binding_0_cs.val_u32_;
    uint64_t _e15 = val_1;
    val_1 = (_e11 + uint64_t((_e14 + uint(_e15))));
    uint64_t _e20 = val_1;
    int _e23 = _group_0_binding_0_cs.val_i32_;
    uint64_t _e24 = val_1;
    val_1 = (_e20 + uint64_t((_e23 + int(_e24))));
    uint64_t _e29 = val_1;
    float _e32 = _group_0_binding_0_cs.val_f32_;
    uint64_t _e33 = val_1;
    val_1 = (_e29 + uint64_t(clamp((_e32 + float(_e33)), 0.0, 1.8446743e19)));
    uint64_t _e38 = val_1;
    uint64_t _e41 = _group_0_binding_0_cs.val_u64_;
    val_1 = (_e38 + u64vec3(_e41).z);
    uint64_t _e45 = val_1;
    int64_t _e48 = _group_0_binding_0_cs.val_i64_;
    val_1 = (_e45 + uint64_t(_e48));
    uint64_t _e51 = val_1;
    i64vec2 _e54 = _group_0_binding_0_cs.val_i64_2_;
    val_1 = (_e51 + u64vec2(_e54).y);
    uint64_t _e58 = val_1;
    i64vec3 _e61 = _group_0_binding_0_cs.val_i64_3_;
    val_1 = (_e58 + u64vec3(_e61).z);
    uint64_t _e65 = val_1;
    i64vec4 _e68 = _group_0_binding_0_cs.val_i64_4_;
    val_1 = (_e65 + u64vec4(_e68).w);
    uint64_t _e76 = _group_0_binding_0_cs.val_u64_;
    uint64_t _e79 = _group_0_binding_1_cs.val_u64_;
    _group_0_binding_3_cs.val_u64_ = (_e76 + _e79);
    u64vec2 _e85 = _group_0_binding_0_cs.val_u64_2_;
    u64vec2 _e88 = _group_0_binding_1_cs.val_u64_2_;
    _group_0_binding_3_cs.val_u64_2_ = (_e85 + _e88);
    u64vec3 _e94 = _group_0_binding_0_cs.val_u64_3_;
    u64vec3 _e97 = _group_0_binding_1_cs.val_u64_3_;
    _group_0_binding_3_cs.val_u64_3_ = (_e94 + _e97);
    u64vec4 _e103 = _group_0_binding_0_cs.val_u64_4_;
    u64vec4 _e106 = _group_0_binding_1_cs.val_u64_4_;
    _group_0_binding_3_cs.val_u64_4_ = (_e103 + _e106);
    uint64_t _e112[2] = _group_0_binding_2_cs.val_u64_array_2_;
    _group_0_binding_4_cs.val_u64_array_2_ = _e112;
    uint64_t _e113 = val_1;
    uint64_t _e114 = val_1;
    val_1 = (_e113 + _e114);
    uint64_t _e117 = val_1;
    uint64_t _e118 = val_1;
    uint64_t _e119 = val_1;
    uint64_t _e120 = val_1;
    val_1 = (_e117 + min(max(_e118, _e119), _e120));
    uint64_t _e123 = val_1;
    uint64_t _e124 = val_1;
    u64vec2 _e125 = u64vec2(_e124);
    uint64_t _e126 = val_1;
    u64vec2 _e127 = u64vec2(_e126);
    val_1 = (_e123 + ( + _e125.x * _e127.x + _e125.y * _e127.y));
    uint64_t _e130 = val_1;
    uint64_t _e131 = val_1;
    uint64_t _e132 = val_1;
    val_1 = (_e130 + max(_e131, _e132));
    uint64_t _e135 = val_1;
    uint64_t _e136 = val_1;
    uint64_t _e137 = val_1;
    val_1 = (_e135 + min(_e136, _e137));
    uint64_t _e140 = val_1;
    return _e140;
}

void main() {
    uint64_t _e3 = uint64_function(67ul);
    int64_t _e5 = int64_function(60l);
    _group_0_binding_3_cs.final_value = (_e3 + uint64_t(_e5));
    return;
}

