#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

shared uint values[64];

shared int signed_value;

shared float float_value;


void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        values = uint[64](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        signed_value = 0;
        float_value = 0.0;
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint out_[2] = uint[2](0u, 0u);
    uint lane = 0u;
    uint base = 0u;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9[2] = uint[2](0u, 0u);
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    uint local_14 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    lane = threadIdx.x;
    base = (blockIdx.x * 128u);
    uint _e18 = lane;
    uint _e22 = lane;
    values[_e22] = (((blockIdx.x * 1000u) + _e18) + 10u);
    uint _e25 = lane;
    uint _e27 = values[_e25];
    uint _e30[2] = out_;
    local = _e30;
    uint _e31 = base;
    uint _e32 = lane;
    local_1 = uint((_e31 + _e32));
    uint _e37[2] = local;
    local_6 = _e37;
    uint _e38 = local_1;
    uint _e40 = local_6[1];
    local_6[1] = (_e40 + _e38);
    uint _e44 = local_6[0];
    local_7 = uint(_e44);
    uint _e48 = local_6[1];
    local_8 = uint(_e48);
    uint _e51 = local_8;
    _group_0_binding_0_cs[_e51] = _e27;
    uint _e53 = lane;
    if ((_e53 == 0u)) {
        signed_value = -(7);
        float_value = 3.5;
        int _e61 = signed_value;
        uint _e65[2] = out_;
        local_2 = _e65;
        uint _e66 = base;
        local_3 = uint((_e66 + 64u));
        uint _e73[2] = local_2;
        local_9 = _e73;
        uint _e74 = local_3;
        uint _e76 = local_9[1];
        local_9[1] = (_e76 + _e74);
        uint _e80 = local_9[0];
        local_10 = uint(_e80);
        uint _e84 = local_9[1];
        local_11 = uint(_e84);
        uint _e87 = local_11;
        _group_0_binding_0_cs[_e87] = uint((_e61 + 10));
        float _e89 = float_value;
        uint _e93[2] = out_;
        local_4 = _e93;
        uint _e94 = base;
        local_5 = uint((_e94 + 65u));
        uint _e101[2] = local_4;
        local_12 = _e101;
        uint _e102 = local_5;
        uint _e104 = local_12[1];
        local_12[1] = (_e104 + _e102);
        uint _e108 = local_12[0];
        local_13 = uint(_e108);
        uint _e112 = local_12[1];
        local_14 = uint(_e112);
        uint _e115 = local_14;
        _group_0_binding_0_cs[_e115] = uint((_e89 * 2.0));
    }
}

