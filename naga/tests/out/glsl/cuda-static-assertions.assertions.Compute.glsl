#version 450 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

const uint Count = 4u;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };


uint verified_unsigned_4u(uint value) {
    return value;
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint VectorBytes = 0u;
    uint local = 0u;
    VectorBytes = 12u;
    uint _e6 = verified_unsigned_4u((threadIdx.x + 7u));
    local = uint(threadIdx.x);
    uint _e10 = local;
    _group_0_binding_0_cs[_e10] = _e6;
}

