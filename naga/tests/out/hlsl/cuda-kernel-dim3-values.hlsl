struct dim3_ {
    uint x;
    uint y;
    uint z;
};

struct uint3_ {
    uint x;
    uint y;
    uint z;
};

struct type_2 {
    dim3_ value;
    int _end_pad_0;
};

RWByteAddressBuffer output : register(u0);
cbuffer shape_1 : register(b1) { type_2 shape_1; }
cbuffer fixed_1 : register(b2) { type_2 fixed_1; }

uint kind(dim3_ param)
{
    return 11u;
}

uint kind_1(uint3_ param_1)
{
    return 22u;
}

uint3_ Constructuint3_(uint arg0, uint arg1, uint arg2) {
    uint3_ ret = (uint3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

dim3_ Constructdim3_(uint arg0, uint arg1, uint arg2) {
    dim3_ ret = (dim3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

uint ZeroValueuint() {
    return (uint)0;
}

[numthreads(4, 1, 1)]
void dim3_values(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    dim3_ shape = (dim3_)0;
    dim3_ fixed = (dim3_)0;
    dim3_ original = (dim3_)0;
    uint3_ packed = (uint3_)0;
    dim3_ restored = (dim3_)0;
    dim3_ local = (dim3_)0;
    dim3_ partial = (dim3_)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint lane = (uint)0;

    dim3_ _e4 = shape_1.value;
    shape = _e4;
    dim3_ _e8 = fixed_1.value;
    fixed = _e8;
    uint lane_1 = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane_1 >= 4u)) {
        return;
    }
    uint base = (4u + (lane_1 * 14u));
    dim3_ _e21 = shape;
    original = _e21;
    dim3_ _e23 = original;
    packed = Constructuint3_(_e23.x, _e23.y, _e23.z);
    uint3_ _e29 = packed;
    restored = Constructdim3_(_e29.x, _e29.y, _e29.z);
    lane = ZeroValueuint();
    lane = lane_1;
    uint _e38 = lane;
    uint _e40 = shape.x;
    shape.x = (_e40 + _e38);
    uint _e44 = shape.y;
    shape.y = (_e44 + 2u);
    uint _e49 = shape.x;
    uint _e51 = shape.y;
    shape = Constructdim3_(_e49, _e51, 1u);
    local = Constructdim3_(1u, 1u, 1u);
    partial = Constructdim3_(2u, 1u, 1u);
    uint _e65 = original.x;
    output.Store(base*4, asuint(_e65));
    uint _e69 = original.y;
    local_1 = uint((base + 1u));
    uint _e74 = local_1;
    output.Store(_e74*4, asuint(_e69));
    uint _e77 = original.z;
    local_2 = uint((base + 2u));
    uint _e82 = local_2;
    output.Store(_e82*4, asuint(_e77));
    uint _e85 = shape.x;
    local_3 = uint((base + 3u));
    uint _e90 = local_3;
    output.Store(_e90*4, asuint(_e85));
    uint _e93 = shape.y;
    local_4 = uint((base + 4u));
    uint _e98 = local_4;
    output.Store(_e98*4, asuint(_e93));
    uint _e101 = shape.z;
    local_5 = uint((base + 5u));
    uint _e106 = local_5;
    output.Store(_e106*4, asuint(_e101));
    uint _e110 = local.x;
    uint _e111 = local.y;
    uint _e114 = local.z;
    local_6 = uint((base + 6u));
    uint _e120 = local_6;
    output.Store(_e120*4, asuint(((_e110 + _e111) + _e114)));
    uint _e123 = fixed.x;
    local_7 = uint((base + 7u));
    uint _e128 = local_7;
    output.Store(_e128*4, asuint(_e123));
    uint _e131 = fixed.y;
    local_8 = uint((base + 8u));
    uint _e136 = local_8;
    output.Store(_e136*4, asuint(_e131));
    uint _e139 = fixed.z;
    local_9 = uint((base + 9u));
    uint _e144 = local_9;
    output.Store(_e144*4, asuint(_e139));
    dim3_ _e146 = shape;
    const uint _e147 = kind(_e146);
    uint3_ _e148 = packed;
    const uint _e149 = kind_1(_e148);
    local_10 = uint((base + 10u));
    uint _e155 = local_10;
    output.Store(_e155*4, asuint((_e147 + _e149)));
    uint _e159 = restored.x;
    uint _e160 = restored.y;
    uint _e163 = restored.z;
    local_11 = uint((base + 11u));
    uint _e169 = local_11;
    output.Store(_e169*4, asuint(((_e159 ^ _e160) ^ _e163)));
    local_12 = uint((base + 12u));
    uint _e175 = local_12;
    output.Store(_e175*4, asuint(4u));
    uint _e180 = partial.y;
    uint _e181 = partial.z;
    local_13 = uint((base + 13u));
    uint _e187 = local_13;
    output.Store(_e187*4, asuint((_e180 + _e181)));
}
