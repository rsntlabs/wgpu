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
    int local_36 = (int)0;
    float local_37 = (float)0;
    float local_38 = (float)0;
    float local_39 = (float)0;
    int local_40 = (int)0;
    float local_41 = (float)0;
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
    int local_62 = (int)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    float local_66 = (float)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    float local_69 = (float)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    float local_72 = (float)0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    int local_78 = (int)0;
    uint local_79 = (uint)0;
    float local_80 = (float)0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    uint local_83 = (uint)0;

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
    local_42 = uint(_e19);
    uint _e22 = local_42;
    out_.Store(_e22*4, asuint(_e15));
    const uint _e26 = thread_component(1u);
    local_1 = uint(int(1));
    uint _e30 = local_1;
    local_43 = uint(_e30);
    uint _e33 = local_43;
    out_.Store(_e33*4, asuint(_e26));
    const uint _e36 = thread_component(2u);
    local_2 = uint(int(2));
    uint _e40 = local_2;
    local_44 = uint(_e40);
    uint _e43 = local_44;
    out_.Store(_e43*4, asuint(_e36));
    const uint _e46 = group_component(0u);
    local_3 = uint(int(3));
    uint _e50 = local_3;
    local_45 = uint(_e50);
    uint _e53 = local_45;
    out_.Store(_e53*4, asuint(_e46));
    const uint _e56 = group_component(1u);
    local_4 = uint(int(4));
    uint _e60 = local_4;
    local_46 = uint(_e60);
    uint _e63 = local_46;
    out_.Store(_e63*4, asuint(_e56));
    const uint _e66 = group_component(2u);
    local_5 = uint(int(5));
    uint _e70 = local_5;
    local_47 = uint(_e70);
    uint _e73 = local_47;
    out_.Store(_e73*4, asuint(_e66));
    const uint _e76 = shape_component(0u);
    local_6 = uint(int(6));
    uint _e80 = local_6;
    local_48 = uint(_e80);
    uint _e83 = local_48;
    out_.Store(_e83*4, asuint(_e76));
    const uint _e86 = shape_component(1u);
    local_7 = uint(int(7));
    uint _e90 = local_7;
    local_49 = uint(_e90);
    uint _e93 = local_49;
    out_.Store(_e93*4, asuint(_e86));
    const uint _e96 = shape_component(2u);
    local_8 = uint(int(8));
    uint _e100 = local_8;
    local_50 = uint(_e100);
    uint _e103 = local_50;
    out_.Store(_e103*4, asuint(_e96));
    const uint _e106 = grid_component(0u);
    local_9 = uint(int(9));
    uint _e110 = local_9;
    local_51 = uint(_e110);
    uint _e113 = local_51;
    out_.Store(_e113*4, asuint(_e106));
    const uint _e116 = grid_component(1u);
    local_10 = uint(int(10));
    uint _e120 = local_10;
    local_52 = uint(_e120);
    uint _e123 = local_52;
    out_.Store(_e123*4, asuint(_e116));
    const uint _e126 = grid_component(2u);
    local_11 = uint(int(11));
    uint _e130 = local_11;
    local_53 = uint(_e130);
    uint _e133 = local_53;
    out_.Store(_e133*4, asuint(_e126));
    const uint _e135 = global_x();
    local_12 = uint(int(12));
    uint _e139 = local_12;
    local_54 = uint(_e139);
    uint _e142 = local_54;
    out_.Store(_e142*4, asuint(_e135));
    const uint _e145 = component(0u);
    local_13 = uint(int(13));
    uint _e149 = local_13;
    local_55 = uint(_e149);
    uint _e152 = local_55;
    out_.Store(_e152*4, asuint(_e145));
    const float _e155 = component_1(2.5);
    local_14 = uint(int(14));
    uint _e160 = local_14;
    local_56 = uint(_e160);
    uint _e163 = local_56;
    out_.Store(_e163*4, asuint(asuint(_e155)));
    local_15 = uint(int(15));
    uint _e169 = local_15;
    local_57 = uint(_e169);
    uint _e172 = local_57;
    out_.Store(_e172*4, asuint(threadIdx.x));
    local_16 = uint(int(16));
    uint _e178 = local_16;
    local_58 = uint(_e178);
    uint _e181 = local_58;
    out_.Store(_e181*4, asuint(blockIdx.y));
    local_17 = uint(int(17));
    uint _e187 = local_17;
    local_59 = uint(_e187);
    uint _e190 = local_59;
    out_.Store(_e190*4, asuint(uint3(_NagaConstants.first_vertex, _NagaConstants.first_instance, _NagaConstants.other).z));
    local_18 = uint(int(18));
    uint _e195 = local_18;
    local_60 = uint(_e195);
    uint _e198 = local_60;
    out_.Store(_e198*4, asuint(1u));
    local_20 = uint(int(0));
    uint _e204 = local_20;
    local_61 = uint(_e204);
    uint _e207 = local_61;
    int _e210 = asint(input.Load(_e207*4));
    local_62 = _e210;
    int _e212 = local_62;
    local_36 = _e212;
    int _e214 = local_36;
    local_19 = uint(int(19));
    uint _e219 = local_19;
    local_63 = uint(_e219);
    uint _e222 = local_63;
    out_.Store(_e222*4, asuint(uint(_e214)));
    local_21 = uint(int(20));
    uint _e228 = local_21;
    local_64 = uint(_e228);
    uint _e231 = local_64;
    out_.Store(_e231*4, asuint(asuint(scale_1)));
    local_23 = uint(int(0));
    uint _e236 = local_23;
    local_65 = uint(_e236);
    uint _e239 = local_65;
    float _e243 = asfloat(points.Load(0+_e239*12));
    local_66 = _e243;
    float _e245 = local_66;
    local_37 = _e245;
    float _e247 = local_37;
    local_22 = uint(int(21));
    uint _e252 = local_22;
    local_67 = uint(_e252);
    uint _e255 = local_67;
    out_.Store(_e255*4, asuint(asuint(_e247)));
    local_25 = uint(int(0));
    uint _e260 = local_25;
    local_68 = uint(_e260);
    uint _e263 = local_68;
    float _e266 = asfloat(points.Load(4+_e263*12));
    local_69 = _e266;
    float _e268 = local_69;
    local_38 = _e268;
    float _e270 = local_38;
    local_24 = uint(int(22));
    uint _e275 = local_24;
    local_70 = uint(_e275);
    uint _e278 = local_70;
    out_.Store(_e278*4, asuint(asuint(_e270)));
    local_27 = uint(int(0));
    uint _e283 = local_27;
    local_71 = uint(_e283);
    uint _e286 = local_71;
    float _e289 = asfloat(points.Load(8+_e286*12));
    local_72 = _e289;
    float _e291 = local_72;
    local_39 = _e291;
    float _e293 = local_39;
    local_26 = uint(int(23));
    uint _e298 = local_26;
    local_73 = uint(_e298);
    uint _e301 = local_73;
    out_.Store(_e301*4, asuint(asuint(_e293)));
    local_28 = uint(int(24));
    uint _e306 = local_28;
    local_74 = uint(_e306);
    uint _e309 = local_74;
    out_.Store(_e309*4, asuint(limit_1));
    const uint _e312 = thread_component(0u);
    const uint _e314 = group_component(1u);
    const uint _e317 = shape_component(2u);
    const uint _e320 = grid_component(0u);
    local_29 = uint(int(25));
    uint _e325 = local_29;
    local_75 = uint(_e325);
    uint _e328 = local_75;
    out_.Store(_e328*4, asuint((((_e312 + _e314) + _e317) + _e320)));
    const uint _e330 = global_x();
    const uint _e331 = global_x();
    local_30 = uint(int(26));
    uint _e336 = local_30;
    local_76 = uint(_e336);
    uint _e339 = local_76;
    out_.Store(_e339*4, asuint((_e330 + _e331)));
    local_32 = uint(int(0));
    uint _e344 = local_32;
    local_77 = uint(_e344);
    uint _e347 = local_77;
    int _e349 = asint(input.Load(_e347*4));
    local_78 = _e349;
    int _e351 = local_78;
    local_40 = _e351;
    int _e353 = local_40;
    local_33 = uint(int(0));
    uint _e359 = local_33;
    local_79 = uint(_e359);
    uint _e362 = local_79;
    float _e365 = asfloat(points.Load(0+_e362*12));
    local_80 = _e365;
    float _e367 = local_80;
    local_41 = _e367;
    float _e369 = local_41;
    local_31 = uint(int(27));
    uint _e375 = local_31;
    local_81 = uint(_e375);
    uint _e378 = local_81;
    out_.Store(_e378*4, asuint(asuint(((float(_e353) * scale_1) + _e369))));
    const uint _e381 = kind(threadIdx.x);
    local_34 = uint(int(28));
    uint _e385 = local_34;
    local_82 = uint(_e385);
    uint _e388 = local_82;
    out_.Store(_e388*4, asuint(_e381));
    const uint _e391 = grid_component(2u);
    local_35 = uint(int(29));
    uint _e395 = local_35;
    local_83 = uint(_e395);
    uint _e398 = local_83;
    out_.Store(_e398*4, asuint(_e391));
}
