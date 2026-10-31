struct NagaConstants {
    int first_vertex;
    int first_instance;
    uint other;
};
ConstantBuffer<NagaConstants> _NagaConstants: register(b0, space1);

struct type_5 {
    float value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

struct float3_ {
    float x;
    float y;
    float z;
};

struct type_7 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

static uint3 threadIdx_1 = (uint3)0;
static uint3 blockIdx_1 = (uint3)0;
static uint3 gridDim_1 = (uint3)0;
ByteAddressBuffer input : register(t0);
cbuffer scale : register(b1) { type_5 scale; }
ByteAddressBuffer points : register(t2);
cbuffer limit : register(b3) { type_7 limit; }
RWByteAddressBuffer out_ : register(u4);

uint thread_component(uint axis)
{
    if ((axis == 0u)) {
        uint3 _e4 = threadIdx_1;
        return _e4.x;
    }
    if ((axis == 1u)) {
        uint3 _e9 = threadIdx_1;
        return _e9.y;
    }
    uint3 _e12 = threadIdx_1;
    return _e12.z;
}

uint group_component(uint axis_1)
{
    if ((axis_1 == 0u)) {
        uint3 _e4 = blockIdx_1;
        return _e4.x;
    }
    if ((axis_1 == 1u)) {
        uint3 _e9 = blockIdx_1;
        return _e9.y;
    }
    uint3 _e12 = blockIdx_1;
    return _e12.z;
}

uint shape_component(uint axis_2)
{
    if ((axis_2 == 0u)) {
        return 1u;
    }
    if ((axis_2 == 1u)) {
        return 1u;
    }
    return 1u;
}

uint grid_component(uint axis_3)
{
    if ((axis_3 == 0u)) {
        uint3 _e4 = gridDim_1;
        return _e4.x;
    }
    if ((axis_3 == 1u)) {
        uint3 _e9 = gridDim_1;
        return _e9.y;
    }
    uint3 _e12 = gridDim_1;
    return _e12.z;
}

uint component(uint axis_4)
{
    const uint _e1 = thread_component(axis_4);
    return _e1;
}

float component_1(float offset)
{
    uint3 _e2 = blockIdx_1;
    return (float(_e2.x) + offset);
}

uint global_x()
{
    const uint _e1 = group_component(0u);
    const uint _e3 = shape_component(0u);
    const uint _e6 = component(0u);
    return ((_e1 * _e3) + _e6);
}

uint kind(uint value)
{
    return 11u;
}

void observe()
{
    uint3 _e1 = gridDim_1;
    if ((_e1.z != 0u)) {
        return;
    } else {
        return;
    }
}

[numthreads(1, 1, 1)]
void coordinates(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint3 gridDim : SV_GroupID)
{
    uint local = (uint)0;
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
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;

    float scale_1 = scale.value;
    uint limit_1 = limit.value;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    gridDim_1 = uint3(_NagaConstants.first_vertex, _NagaConstants.first_instance, _NagaConstants.other);
    const uint _e12 = global_x();
    if ((_e12 >= limit_1)) {
        return;
    }
    observe();
    const uint _e15 = thread_component(0u);
    local = uint(int(0));
    uint _e19 = local;
    local_36 = uint(_e19);
    uint _e22 = local_36;
    out_.Store(_e22*4, asuint(_e15));
    const uint _e26 = thread_component(1u);
    local_1 = uint(int(1));
    uint _e30 = local_1;
    local_37 = uint(_e30);
    uint _e33 = local_37;
    out_.Store(_e33*4, asuint(_e26));
    const uint _e36 = thread_component(2u);
    local_2 = uint(int(2));
    uint _e40 = local_2;
    local_38 = uint(_e40);
    uint _e43 = local_38;
    out_.Store(_e43*4, asuint(_e36));
    const uint _e46 = group_component(0u);
    local_3 = uint(int(3));
    uint _e50 = local_3;
    local_39 = uint(_e50);
    uint _e53 = local_39;
    out_.Store(_e53*4, asuint(_e46));
    const uint _e56 = group_component(1u);
    local_4 = uint(int(4));
    uint _e60 = local_4;
    local_40 = uint(_e60);
    uint _e63 = local_40;
    out_.Store(_e63*4, asuint(_e56));
    const uint _e66 = group_component(2u);
    local_5 = uint(int(5));
    uint _e70 = local_5;
    local_41 = uint(_e70);
    uint _e73 = local_41;
    out_.Store(_e73*4, asuint(_e66));
    const uint _e76 = shape_component(0u);
    local_6 = uint(int(6));
    uint _e80 = local_6;
    local_42 = uint(_e80);
    uint _e83 = local_42;
    out_.Store(_e83*4, asuint(_e76));
    const uint _e86 = shape_component(1u);
    local_7 = uint(int(7));
    uint _e90 = local_7;
    local_43 = uint(_e90);
    uint _e93 = local_43;
    out_.Store(_e93*4, asuint(_e86));
    const uint _e96 = shape_component(2u);
    local_8 = uint(int(8));
    uint _e100 = local_8;
    local_44 = uint(_e100);
    uint _e103 = local_44;
    out_.Store(_e103*4, asuint(_e96));
    const uint _e106 = grid_component(0u);
    local_9 = uint(int(9));
    uint _e110 = local_9;
    local_45 = uint(_e110);
    uint _e113 = local_45;
    out_.Store(_e113*4, asuint(_e106));
    const uint _e116 = grid_component(1u);
    local_10 = uint(int(10));
    uint _e120 = local_10;
    local_46 = uint(_e120);
    uint _e123 = local_46;
    out_.Store(_e123*4, asuint(_e116));
    const uint _e126 = grid_component(2u);
    local_11 = uint(int(11));
    uint _e130 = local_11;
    local_47 = uint(_e130);
    uint _e133 = local_47;
    out_.Store(_e133*4, asuint(_e126));
    const uint _e135 = global_x();
    local_12 = uint(int(12));
    uint _e139 = local_12;
    local_48 = uint(_e139);
    uint _e142 = local_48;
    out_.Store(_e142*4, asuint(_e135));
    const uint _e145 = component(0u);
    local_13 = uint(int(13));
    uint _e149 = local_13;
    local_49 = uint(_e149);
    uint _e152 = local_49;
    out_.Store(_e152*4, asuint(_e145));
    const float _e155 = component_1(2.5);
    local_14 = uint(int(14));
    uint _e160 = local_14;
    local_50 = uint(_e160);
    uint _e163 = local_50;
    out_.Store(_e163*4, asuint(asuint(_e155)));
    local_15 = uint(int(15));
    uint _e169 = local_15;
    local_51 = uint(_e169);
    uint _e172 = local_51;
    out_.Store(_e172*4, asuint(threadIdx.x));
    local_16 = uint(int(16));
    uint _e178 = local_16;
    local_52 = uint(_e178);
    uint _e181 = local_52;
    out_.Store(_e181*4, asuint(blockIdx.y));
    local_17 = uint(int(17));
    uint _e187 = local_17;
    local_53 = uint(_e187);
    uint _e190 = local_53;
    out_.Store(_e190*4, asuint(uint3(_NagaConstants.first_vertex, _NagaConstants.first_instance, _NagaConstants.other).z));
    local_18 = uint(int(18));
    uint _e195 = local_18;
    local_54 = uint(_e195);
    uint _e198 = local_54;
    out_.Store(_e198*4, asuint(1u));
    local_20 = uint(int(0));
    uint _e204 = local_20;
    local_55 = uint(_e204);
    uint _e207 = local_55;
    int _e210 = asint(input.Load(_e207*4));
    local_19 = uint(int(19));
    uint _e215 = local_19;
    local_56 = uint(_e215);
    uint _e218 = local_56;
    out_.Store(_e218*4, asuint(uint(_e210)));
    local_21 = uint(int(20));
    uint _e224 = local_21;
    local_57 = uint(_e224);
    uint _e227 = local_57;
    out_.Store(_e227*4, asuint(asuint(scale_1)));
    local_23 = uint(int(0));
    uint _e232 = local_23;
    local_58 = uint(_e232);
    uint _e235 = local_58;
    float _e239 = asfloat(points.Load(0+_e235*12));
    local_22 = uint(int(21));
    uint _e244 = local_22;
    local_59 = uint(_e244);
    uint _e247 = local_59;
    out_.Store(_e247*4, asuint(asuint(_e239)));
    local_25 = uint(int(0));
    uint _e252 = local_25;
    local_60 = uint(_e252);
    uint _e255 = local_60;
    float _e258 = asfloat(points.Load(4+_e255*12));
    local_24 = uint(int(22));
    uint _e263 = local_24;
    local_61 = uint(_e263);
    uint _e266 = local_61;
    out_.Store(_e266*4, asuint(asuint(_e258)));
    local_27 = uint(int(0));
    uint _e271 = local_27;
    local_62 = uint(_e271);
    uint _e274 = local_62;
    float _e277 = asfloat(points.Load(8+_e274*12));
    local_26 = uint(int(23));
    uint _e282 = local_26;
    local_63 = uint(_e282);
    uint _e285 = local_63;
    out_.Store(_e285*4, asuint(asuint(_e277)));
    local_28 = uint(int(24));
    uint _e290 = local_28;
    local_64 = uint(_e290);
    uint _e293 = local_64;
    out_.Store(_e293*4, asuint(limit_1));
    const uint _e296 = thread_component(0u);
    const uint _e298 = group_component(1u);
    const uint _e301 = shape_component(2u);
    const uint _e304 = grid_component(0u);
    local_29 = uint(int(25));
    uint _e309 = local_29;
    local_65 = uint(_e309);
    uint _e312 = local_65;
    out_.Store(_e312*4, asuint((((_e296 + _e298) + _e301) + _e304)));
    const uint _e314 = global_x();
    const uint _e315 = global_x();
    local_30 = uint(int(26));
    uint _e320 = local_30;
    local_66 = uint(_e320);
    uint _e323 = local_66;
    out_.Store(_e323*4, asuint((_e314 + _e315)));
    local_32 = uint(int(0));
    uint _e328 = local_32;
    local_67 = uint(_e328);
    uint _e331 = local_67;
    int _e333 = asint(input.Load(_e331*4));
    local_33 = uint(int(0));
    uint _e339 = local_33;
    local_68 = uint(_e339);
    uint _e342 = local_68;
    float _e345 = asfloat(points.Load(0+_e342*12));
    local_31 = uint(int(27));
    uint _e351 = local_31;
    local_69 = uint(_e351);
    uint _e354 = local_69;
    out_.Store(_e354*4, asuint(asuint(((float(_e333) * scale_1) + _e345))));
    const uint _e357 = kind(threadIdx.x);
    local_34 = uint(int(28));
    uint _e361 = local_34;
    local_70 = uint(_e361);
    uint _e364 = local_70;
    out_.Store(_e364*4, asuint(_e357));
    const uint _e367 = grid_component(2u);
    local_35 = uint(int(29));
    uint _e371 = local_35;
    local_71 = uint(_e371);
    uint _e374 = local_71;
    out_.Store(_e374*4, asuint(_e367));
}
