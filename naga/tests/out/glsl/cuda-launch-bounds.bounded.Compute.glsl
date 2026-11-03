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
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint output_[2] = uint[2](0u, 0u);
    uint input_[2] = uint[2](0u, 0u);
    uint local[2] = uint[2](0u, 0u);
    uint local_1[2] = uint[2](0u, 0u);
    uint output_1[2] = uint[2](0u, 0u);
    uint input_1[2] = uint[2](0u, 0u);
    uint count = 0u;
    uint block_size = 0u;
    uint local_index = 0u;
    uint index = 0u;
    uint offset = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14[2] = uint[2](0u, 0u);
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18[2] = uint[2](0u, 0u);
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21[2] = uint[2](0u, 0u);
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24[2] = uint[2](0u, 0u);
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27[2] = uint[2](0u, 0u);
    uint local_28 = 0u;
    uint local_29 = 0u;
    output_ = uint[2](0u, 0u);
    output_[0] = 2u;
    output_[1] = 0u;
    input_ = uint[2](0u, 0u);
    input_[0] = 3u;
    input_[1] = 0u;
    uint count_4 = _group_0_binding_2_cs.value;
    threadIdx_2 = threadIdx;
    blockIdx_2 = blockIdx;
    uint _e20[2] = output_;
    local = _e20;
    uint _e23[2] = input_;
    local_1 = _e23;
    count = 0u;
    block_size = 0u;
    local_index = 0u;
    index = 0u;
    offset = 0u;
    local_3 = 0u;
    local_5 = 0u;
    local_7 = 0u;
    local_9 = 0u;
    local_11 = 0u;
    local_12 = 0u;
    uint _e47[2] = local;
    output_1 = _e47;
    uint _e49[2] = local_1;
    input_1 = _e49;
    count = count_4;
    block_size = ((2u * 3u) * 2u);
    uvec3 _e59 = threadIdx_2;
    uvec3 _e62 = threadIdx_2;
    uvec3 _e65 = threadIdx_2;
    local_index = (_e59.x + (2u * (_e62.y + (3u * _e65.z))));
    uvec3 _e75 = blockIdx_2;
    uint _e77 = block_size;
    uint _e79 = local_index;
    index = ((_e75.x * _e77) + _e79);
    uint _e82 = index;
    uint _e83 = count;
    if ((_e82 < _e83)) {
        uint _e85 = index;
        offset = (_e85 * 4u);
        uint _e90[2] = input_1;
        local_4 = _e90;
        uint _e92 = index;
        local_5 = _e92;
        uint _e94[2] = local_4;
        local_14 = _e94;
        uint _e96 = local_5;
        uint _e98 = local_14[1];
        local_14[1] = (_e98 + _e96);
        uint _e102 = local_14[0];
        local_15 = uint(_e102);
        uint _e106 = local_14[1];
        local_16 = uint(_e106);
        uint _e109 = local_16;
        uint _e112 = _group_0_binding_1_cs[_e109];
        local_17 = _e112;
        uint _e114 = local_17;
        local_13 = _e114;
        uint _e116 = local_13;
        local_12 = _e116;
        uint _e118 = local_12;
        uint _e119 = shifted_7u(_e118);
        uint _e121[2] = output_1;
        local_2 = _e121;
        uint _e123 = offset;
        local_3 = _e123;
        uint _e125[2] = local_2;
        local_18 = _e125;
        uint _e127 = local_3;
        uint _e129 = local_18[1];
        local_18[1] = (_e129 + _e127);
        uint _e133 = local_18[0];
        local_19 = uint(_e133);
        uint _e137 = local_18[1];
        local_20 = uint(_e137);
        uint _e140 = local_20;
        _group_0_binding_0_cs[_e140] = _e119;
        uint _e143 = block_size;
        uint _e144[2] = output_1;
        local_6 = _e144;
        uint _e146 = offset;
        local_7 = uint((_e146 + 1u));
        uint _e151[2] = local_6;
        local_21 = _e151;
        uint _e153 = local_7;
        uint _e155 = local_21[1];
        local_21[1] = (_e155 + _e153);
        uint _e159 = local_21[0];
        local_22 = uint(_e159);
        uint _e163 = local_21[1];
        local_23 = uint(_e163);
        uint _e166 = local_23;
        _group_0_binding_0_cs[_e166] = _e143;
        uint _e168 = local_index;
        uint _e169[2] = output_1;
        local_8 = _e169;
        uint _e171 = offset;
        local_9 = uint((_e171 + 2u));
        uint _e176[2] = local_8;
        local_24 = _e176;
        uint _e178 = local_9;
        uint _e180 = local_24[1];
        local_24[1] = (_e180 + _e178);
        uint _e184 = local_24[0];
        local_25 = uint(_e184);
        uint _e188 = local_24[1];
        local_26 = uint(_e188);
        uint _e191 = local_26;
        _group_0_binding_0_cs[_e191] = _e168;
        uvec3 _e194 = blockIdx_2;
        uint _e196[2] = output_1;
        local_10 = _e196;
        uint _e198 = offset;
        local_11 = uint((_e198 + 3u));
        uint _e203[2] = local_10;
        local_27 = _e203;
        uint _e205 = local_11;
        uint _e207 = local_27[1];
        local_27[1] = (_e207 + _e205);
        uint _e211 = local_27[0];
        local_28 = uint(_e211);
        uint _e215 = local_27[1];
        local_29 = uint(_e215);
        uint _e218 = local_29;
        _group_0_binding_0_cs[_e218] = _e194.x;
    }
}

