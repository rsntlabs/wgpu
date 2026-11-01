#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

shared uint helper_values[4];

layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };

shared uint fixed_values[4];


void initialize(uint index, uint value) {
    helper_values[index] = value;
    return;
}

void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        helper_values = uint[4](0u, 0u, 0u, 0u);
        fixed_values = uint[4](0u, 0u, 0u, 0u);
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint output_[2] = uint[2](0u, 0u);
    uint neighbor = 0u;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint pointer[2] = uint[2](0u, 0u);
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3[2] = uint[2](0u, 0u);
    uint local_4 = 0u;
    uint local_5[2] = uint[2](0u, 0u);
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11[2] = uint[2](0u, 0u);
    uint local_12 = 0u;
    uint local_13 = 0u;
    output_ = uint[2](0u, 0u);
    output_[0] = 0u;
    output_[1] = 0u;
    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 8u);
    initialize(lane, (((blockIdx.x * 10u) + lane) + 1u));
    fixed_values[lane] = (100u + lane);
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    {
        uint _e23 = (lane + 1u);
        neighbor = (_e23 - 4u * (_e23 / 4u));
        uint _e27 = neighbor;
        uint _e31 = helper_values[_e27];
        uint _e32 = fixed_values[lane];
        uint _e35[2] = output_;
        local = _e35;
        local_1 = uint((base + lane));
        uint _e40[2] = local;
        local_5 = _e40;
        uint _e42 = local_1;
        uint _e44 = local_5[1];
        local_5[1] = (_e44 + _e42);
        uint _e48 = local_5[0];
        local_6 = uint(_e48);
        uint _e52 = local_5[1];
        local_7 = uint(_e52);
        uint _e55 = local_7;
        _group_0_binding_0_cs[_e55] = (_e31 + _e32);
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    pointer = uint[2](0u, 0u);
    pointer[0] = 1u;
    pointer[1] = 0u;
    uint _e65[2] = pointer;
    local_2 = _e65;
    uint _e67[2] = local_2;
    local_8 = _e67;
    uint _e70 = local_8[1];
    local_8[1] = (_e70 + lane);
    uint _e74 = local_8[0];
    local_9 = uint(_e74);
    uint _e78 = local_8[1];
    local_10 = uint(_e78);
    uint _e81 = local_10;
    uint _e84 = helper_values[_e81];
    uint _e88 = local_10;
    helper_values[_e88] = (_e84 + uint(1));
    uint _e92 = helper_values[lane];
    uint _e93[2] = output_;
    local_3 = _e93;
    local_4 = uint(((base + 4u) + lane));
    uint _e100[2] = local_3;
    local_11 = _e100;
    uint _e102 = local_4;
    uint _e104 = local_11[1];
    local_11[1] = (_e104 + _e102);
    uint _e108 = local_11[0];
    local_12 = uint(_e108);
    uint _e112 = local_11[1];
    local_13 = uint(_e112);
    uint _e115 = local_13;
    _group_0_binding_0_cs[_e115] = _e92;
}

