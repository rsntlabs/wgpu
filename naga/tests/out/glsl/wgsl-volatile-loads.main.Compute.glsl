#version 430 core
#extension GL_ARB_compute_shader : require
#extension GL_ARB_shader_storage_buffer_object : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) volatile buffer Data_block_0Compute {
    uint values[];
} _group_0_binding_0_cs;

layout(std430) buffer Data_block_1Compute {
    uint values[];
} _group_0_binding_1_cs;

layout(std430) buffer Data_block_2Compute {
    uint values[];
} _group_0_binding_2_cs;


void main() {
    uint lane = gl_LocalInvocationIndex;
    uint iteration = 0u;
    uint phony = _group_0_binding_0_cs.values[0];
    _group_0_binding_0_cs.values[0] = 7u;
    uint phony_1 = _group_0_binding_0_cs.values[0];
    uint _e19 = _group_0_binding_0_cs.values[1];
    uint _e23 = _group_0_binding_0_cs.values[1];
    _group_0_binding_2_cs.values[0] = (_e19 + _e23);
    uint shared_read = _group_0_binding_0_cs.values[2];
    _group_0_binding_2_cs.values[1] = (shared_read + shared_read);
    uint _e36 = _group_0_binding_0_cs.values[2];
    uint _e40 = _group_0_binding_0_cs.values[3];
    uint phony_2 = (_e36 + _e40);
    if ((lane == 0u)) {
        uint phony_3 = _group_0_binding_0_cs.values[3];
    }
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e59 = iteration;
            iteration = (_e59 + 1u);
        }
        loop_init = false;
        uint _e50 = iteration;
        if ((_e50 < 2u)) {
        } else {
            break;
        }
        {
            uint _e55 = iteration;
            uint phony_4 = _group_0_binding_0_cs.values[_e55];
        }
    }
    uint phony_5 = _group_0_binding_1_cs.values[0];
    uint _e70 = _group_0_binding_0_cs.values[0];
    uint phony_6 = _group_0_binding_1_cs.values[(_e70 & 3u)];
    return;
}

