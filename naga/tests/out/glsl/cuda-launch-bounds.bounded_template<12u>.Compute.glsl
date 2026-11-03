#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 2, local_size_y = 3, local_size_z = 2) in;

struct type_3 {
    uint value;
};
uvec3 threadIdx_2 = uvec3(0u);

uvec3 blockIdx_2 = uvec3(0u);

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_2_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_2Compute { type_3 _group_0_binding_2_cs; };


uint shifted_7u(uint value) {
    return ((value * 3u) + 7u);
}

void main() {
    uvec3 threadIdx_1 = gl_LocalInvocationID;
    uvec3 blockIdx_1 = gl_WorkGroupID;
    uint output_2[2] = uint[2](0u, 0u);
    uint input_2[2] = uint[2](0u, 0u);
    uint local_30[2] = uint[2](0u, 0u);
    uint local_31[2] = uint[2](0u, 0u);
    uint output_3[2] = uint[2](0u, 0u);
    uint input_3[2] = uint[2](0u, 0u);
    uint count_1 = 0u;
    uint block_size_1 = 0u;
    uint local_index_1 = 0u;
    uint index_1 = 0u;
    uint offset_1 = 0u;
    uint local_32[2] = uint[2](0u, 0u);
    uint local_33 = 0u;
    uint local_34[2] = uint[2](0u, 0u);
    uint local_35 = 0u;
    uint local_36[2] = uint[2](0u, 0u);
    uint local_37 = 0u;
    uint local_38[2] = uint[2](0u, 0u);
    uint local_39 = 0u;
    uint local_40[2] = uint[2](0u, 0u);
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44[2] = uint[2](0u, 0u);
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48[2] = uint[2](0u, 0u);
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51[2] = uint[2](0u, 0u);
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54[2] = uint[2](0u, 0u);
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57[2] = uint[2](0u, 0u);
    uint local_58 = 0u;
    uint local_59 = 0u;
    output_2 = uint[2](0u, 0u);
    output_2[0] = 2u;
    output_2[1] = 0u;
    input_2 = uint[2](0u, 0u);
    input_2[0] = 3u;
    input_2[1] = 0u;
    uint count_4 = _group_0_binding_2_cs.value;
    threadIdx_2 = threadIdx_1;
    blockIdx_2 = blockIdx_1;
    uint _e20[2] = output_2;
    local_30 = _e20;
    uint _e23[2] = input_2;
    local_31 = _e23;
    count_1 = 0u;
    block_size_1 = 0u;
    local_index_1 = 0u;
    index_1 = 0u;
    offset_1 = 0u;
    local_33 = 0u;
    local_35 = 0u;
    local_37 = 0u;
    local_39 = 0u;
    local_41 = 0u;
    local_42 = 0u;
    uint _e47[2] = local_30;
    output_3 = _e47;
    uint _e49[2] = local_31;
    input_3 = _e49;
    count_1 = count_4;
    block_size_1 = ((2u * 3u) * 2u);
    uvec3 _e59 = threadIdx_2;
    uvec3 _e62 = threadIdx_2;
    uvec3 _e65 = threadIdx_2;
    local_index_1 = (_e59.x + (2u * (_e62.y + (3u * _e65.z))));
    uvec3 _e75 = blockIdx_2;
    uint _e77 = block_size_1;
    uint _e79 = local_index_1;
    index_1 = ((_e75.x * _e77) + _e79);
    uint _e82 = index_1;
    uint _e83 = count_1;
    if ((_e82 < _e83)) {
        uint _e85 = index_1;
        offset_1 = (_e85 * 4u);
        uint _e90[2] = input_3;
        local_34 = _e90;
        uint _e92 = index_1;
        local_35 = _e92;
        uint _e94[2] = local_34;
        local_44 = _e94;
        uint _e96 = local_35;
        uint _e98 = local_44[1];
        local_44[1] = (_e98 + _e96);
        uint _e102 = local_44[0];
        local_45 = uint(_e102);
        uint _e106 = local_44[1];
        local_46 = uint(_e106);
        uint _e109 = local_46;
        uint _e112 = _group_0_binding_1_cs[_e109];
        local_47 = _e112;
        uint _e114 = local_47;
        local_43 = _e114;
        uint _e116 = local_43;
        local_42 = _e116;
        uint _e118 = local_42;
        uint _e119 = shifted_7u(_e118);
        uint _e121[2] = output_3;
        local_32 = _e121;
        uint _e123 = offset_1;
        local_33 = _e123;
        uint _e125[2] = local_32;
        local_48 = _e125;
        uint _e127 = local_33;
        uint _e129 = local_48[1];
        local_48[1] = (_e129 + _e127);
        uint _e133 = local_48[0];
        local_49 = uint(_e133);
        uint _e137 = local_48[1];
        local_50 = uint(_e137);
        uint _e140 = local_50;
        _group_0_binding_0_cs[_e140] = _e119;
        uint _e143 = block_size_1;
        uint _e144[2] = output_3;
        local_36 = _e144;
        uint _e146 = offset_1;
        local_37 = uint((_e146 + 1u));
        uint _e151[2] = local_36;
        local_51 = _e151;
        uint _e153 = local_37;
        uint _e155 = local_51[1];
        local_51[1] = (_e155 + _e153);
        uint _e159 = local_51[0];
        local_52 = uint(_e159);
        uint _e163 = local_51[1];
        local_53 = uint(_e163);
        uint _e166 = local_53;
        _group_0_binding_0_cs[_e166] = _e143;
        uint _e168 = local_index_1;
        uint _e169[2] = output_3;
        local_38 = _e169;
        uint _e171 = offset_1;
        local_39 = uint((_e171 + 2u));
        uint _e176[2] = local_38;
        local_54 = _e176;
        uint _e178 = local_39;
        uint _e180 = local_54[1];
        local_54[1] = (_e180 + _e178);
        uint _e184 = local_54[0];
        local_55 = uint(_e184);
        uint _e188 = local_54[1];
        local_56 = uint(_e188);
        uint _e191 = local_56;
        _group_0_binding_0_cs[_e191] = _e168;
        uvec3 _e194 = blockIdx_2;
        uint _e196[2] = output_3;
        local_40 = _e196;
        uint _e198 = offset_1;
        local_41 = uint((_e198 + 3u));
        uint _e203[2] = local_40;
        local_57 = _e203;
        uint _e205 = local_41;
        uint _e207 = local_57[1];
        local_57[1] = (_e207 + _e205);
        uint _e211 = local_57[0];
        local_58 = uint(_e211);
        uint _e215 = local_57[1];
        local_59 = uint(_e215);
        uint _e218 = local_59;
        _group_0_binding_0_cs[_e218] = _e194.x;
    }
}

