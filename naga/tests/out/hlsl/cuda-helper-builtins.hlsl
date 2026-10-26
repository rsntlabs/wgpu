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
cbuffer scale_1 : register(b1) { type_5 scale_1; }
ByteAddressBuffer points : register(t2);
cbuffer limit_1 : register(b3) { type_7 limit_1; }
RWByteAddressBuffer out_ : register(u4);

uint thread_component(uint axis)
{
    uint axis_1 = (uint)0;

    axis_1 = axis;
    uint _e3 = axis_1;
    if ((_e3 == 0u)) {
        uint3 _e6 = threadIdx_1;
        return _e6.x;
    }
    uint _e9 = axis_1;
    if ((_e9 == 1u)) {
        uint3 _e12 = threadIdx_1;
        return _e12.y;
    }
    uint3 _e15 = threadIdx_1;
    return _e15.z;
}

uint group_component(uint axis_2)
{
    uint axis_3 = (uint)0;

    axis_3 = axis_2;
    uint _e3 = axis_3;
    if ((_e3 == 0u)) {
        uint3 _e6 = blockIdx_1;
        return _e6.x;
    }
    uint _e9 = axis_3;
    if ((_e9 == 1u)) {
        uint3 _e12 = blockIdx_1;
        return _e12.y;
    }
    uint3 _e15 = blockIdx_1;
    return _e15.z;
}

uint shape_component(uint axis_4)
{
    uint axis_5 = (uint)0;

    axis_5 = axis_4;
    uint _e3 = axis_5;
    if ((_e3 == 0u)) {
        return 1u;
    }
    uint _e7 = axis_5;
    if ((_e7 == 1u)) {
        return 1u;
    }
    return 1u;
}

uint grid_component(uint axis_6)
{
    uint axis_7 = (uint)0;

    axis_7 = axis_6;
    uint _e3 = axis_7;
    if ((_e3 == 0u)) {
        uint3 _e6 = gridDim_1;
        return _e6.x;
    }
    uint _e9 = axis_7;
    if ((_e9 == 1u)) {
        uint3 _e12 = gridDim_1;
        return _e12.y;
    }
    uint3 _e15 = gridDim_1;
    return _e15.z;
}

uint component(uint axis_8)
{
    uint axis_9 = (uint)0;

    axis_9 = axis_8;
    uint _e2 = axis_9;
    const uint _e3 = thread_component(_e2);
    return _e3;
}

float component_1(float offset)
{
    float offset_1 = (float)0;

    offset_1 = offset;
    uint3 _e3 = blockIdx_1;
    float _e6 = offset_1;
    return (float(_e3.x) + _e6);
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
    uint value_1 = (uint)0;

    value_1 = value;
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
    float scale = (float)0;
    uint local_1 = (uint)0;
    uint limit = (uint)0;
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
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    uint local_83 = (uint)0;
    uint local_84 = (uint)0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;
    uint local_90 = (uint)0;
    uint local_91 = (uint)0;
    uint local_92 = (uint)0;
    uint local_93 = (uint)0;
    uint local_94 = (uint)0;
    uint local_95 = (uint)0;
    uint local_96 = (uint)0;
    uint local_97 = (uint)0;
    uint local_98 = (uint)0;
    uint local_99 = (uint)0;
    uint local_100 = (uint)0;
    uint local_101 = (uint)0;
    uint local_102 = (uint)0;
    uint local_103 = (uint)0;
    uint local_104 = (uint)0;
    uint local_105 = (uint)0;
    uint local_106 = (uint)0;
    uint local_107 = (uint)0;
    uint local_108 = (uint)0;
    uint local_109 = (uint)0;
    uint local_110 = (uint)0;
    uint local_111 = (uint)0;
    uint local_112 = (uint)0;
    uint local_113 = (uint)0;
    uint local_114 = (uint)0;
    uint local_115 = (uint)0;
    uint local_116 = (uint)0;
    uint local_117 = (uint)0;
    uint local_118 = (uint)0;
    uint local_119 = (uint)0;
    uint local_120 = (uint)0;
    uint local_121 = (uint)0;
    uint local_122 = (uint)0;
    uint local_123 = (uint)0;
    uint local_124 = (uint)0;
    uint local_125 = (uint)0;
    uint local_126 = (uint)0;
    uint local_127 = (uint)0;
    uint local_128 = (uint)0;
    uint local_129 = (uint)0;
    uint local_130 = (uint)0;
    int local_131 = (int)0;
    uint local_132 = (uint)0;
    uint local_133 = (uint)0;
    uint local_134 = (uint)0;
    float local_135 = (float)0;
    uint local_136 = (uint)0;
    uint local_137 = (uint)0;
    float local_138 = (float)0;
    uint local_139 = (uint)0;
    uint local_140 = (uint)0;
    float local_141 = (float)0;
    uint local_142 = (uint)0;
    uint local_143 = (uint)0;
    uint local_144 = (uint)0;
    uint local_145 = (uint)0;
    uint local_146 = (uint)0;
    int local_147 = (int)0;
    uint local_148 = (uint)0;
    float local_149 = (float)0;
    uint local_150 = (uint)0;
    uint local_151 = (uint)0;
    uint local_152 = (uint)0;

    local = 0u;
    float _e7 = scale_1.value;
    scale = _e7;
    local_1 = 0u;
    uint _e13 = limit_1.value;
    limit = _e13;
    local_2 = 0u;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    gridDim_1 = uint3(_NagaConstants.first_vertex, _NagaConstants.first_instance, _NagaConstants.other);
    const uint _e20 = global_x();
    uint _e21 = limit;
    if ((_e20 >= _e21)) {
        return;
    }
    observe();
    const uint _e24 = thread_component(0u);
    uint _e25 = local_2;
    local_3 = _e25;
    uint _e27 = local_3;
    local_4 = uint(_e27);
    local_5 = uint(int(0));
    uint _e34 = local_4;
    uint _e35 = local_5;
    local_111 = uint((_e34 + _e35));
    uint _e39 = local_111;
    out_.Store(_e39*4, asuint(_e24));
    const uint _e42 = thread_component(1u);
    uint _e43 = local_2;
    local_6 = _e43;
    uint _e45 = local_6;
    local_7 = uint(_e45);
    local_8 = uint(int(1));
    uint _e51 = local_7;
    uint _e52 = local_8;
    local_112 = uint((_e51 + _e52));
    uint _e56 = local_112;
    out_.Store(_e56*4, asuint(_e42));
    const uint _e59 = thread_component(2u);
    uint _e60 = local_2;
    local_9 = _e60;
    uint _e62 = local_9;
    local_10 = uint(_e62);
    local_11 = uint(int(2));
    uint _e68 = local_10;
    uint _e69 = local_11;
    local_113 = uint((_e68 + _e69));
    uint _e73 = local_113;
    out_.Store(_e73*4, asuint(_e59));
    const uint _e76 = group_component(0u);
    uint _e77 = local_2;
    local_12 = _e77;
    uint _e79 = local_12;
    local_13 = uint(_e79);
    local_14 = uint(int(3));
    uint _e85 = local_13;
    uint _e86 = local_14;
    local_114 = uint((_e85 + _e86));
    uint _e90 = local_114;
    out_.Store(_e90*4, asuint(_e76));
    const uint _e93 = group_component(1u);
    uint _e94 = local_2;
    local_15 = _e94;
    uint _e96 = local_15;
    local_16 = uint(_e96);
    local_17 = uint(int(4));
    uint _e102 = local_16;
    uint _e103 = local_17;
    local_115 = uint((_e102 + _e103));
    uint _e107 = local_115;
    out_.Store(_e107*4, asuint(_e93));
    const uint _e110 = group_component(2u);
    uint _e111 = local_2;
    local_18 = _e111;
    uint _e113 = local_18;
    local_19 = uint(_e113);
    local_20 = uint(int(5));
    uint _e119 = local_19;
    uint _e120 = local_20;
    local_116 = uint((_e119 + _e120));
    uint _e124 = local_116;
    out_.Store(_e124*4, asuint(_e110));
    const uint _e127 = shape_component(0u);
    uint _e128 = local_2;
    local_21 = _e128;
    uint _e130 = local_21;
    local_22 = uint(_e130);
    local_23 = uint(int(6));
    uint _e136 = local_22;
    uint _e137 = local_23;
    local_117 = uint((_e136 + _e137));
    uint _e141 = local_117;
    out_.Store(_e141*4, asuint(_e127));
    const uint _e144 = shape_component(1u);
    uint _e145 = local_2;
    local_24 = _e145;
    uint _e147 = local_24;
    local_25 = uint(_e147);
    local_26 = uint(int(7));
    uint _e153 = local_25;
    uint _e154 = local_26;
    local_118 = uint((_e153 + _e154));
    uint _e158 = local_118;
    out_.Store(_e158*4, asuint(_e144));
    const uint _e161 = shape_component(2u);
    uint _e162 = local_2;
    local_27 = _e162;
    uint _e164 = local_27;
    local_28 = uint(_e164);
    local_29 = uint(int(8));
    uint _e170 = local_28;
    uint _e171 = local_29;
    local_119 = uint((_e170 + _e171));
    uint _e175 = local_119;
    out_.Store(_e175*4, asuint(_e161));
    const uint _e178 = grid_component(0u);
    uint _e179 = local_2;
    local_30 = _e179;
    uint _e181 = local_30;
    local_31 = uint(_e181);
    local_32 = uint(int(9));
    uint _e187 = local_31;
    uint _e188 = local_32;
    local_120 = uint((_e187 + _e188));
    uint _e192 = local_120;
    out_.Store(_e192*4, asuint(_e178));
    const uint _e195 = grid_component(1u);
    uint _e196 = local_2;
    local_33 = _e196;
    uint _e198 = local_33;
    local_34 = uint(_e198);
    local_35 = uint(int(10));
    uint _e204 = local_34;
    uint _e205 = local_35;
    local_121 = uint((_e204 + _e205));
    uint _e209 = local_121;
    out_.Store(_e209*4, asuint(_e195));
    const uint _e212 = grid_component(2u);
    uint _e213 = local_2;
    local_36 = _e213;
    uint _e215 = local_36;
    local_37 = uint(_e215);
    local_38 = uint(int(11));
    uint _e221 = local_37;
    uint _e222 = local_38;
    local_122 = uint((_e221 + _e222));
    uint _e226 = local_122;
    out_.Store(_e226*4, asuint(_e212));
    const uint _e228 = global_x();
    uint _e229 = local_2;
    local_39 = _e229;
    uint _e231 = local_39;
    local_40 = uint(_e231);
    local_41 = uint(int(12));
    uint _e237 = local_40;
    uint _e238 = local_41;
    local_123 = uint((_e237 + _e238));
    uint _e242 = local_123;
    out_.Store(_e242*4, asuint(_e228));
    const uint _e245 = component(0u);
    uint _e246 = local_2;
    local_42 = _e246;
    uint _e248 = local_42;
    local_43 = uint(_e248);
    local_44 = uint(int(13));
    uint _e254 = local_43;
    uint _e255 = local_44;
    local_124 = uint((_e254 + _e255));
    uint _e259 = local_124;
    out_.Store(_e259*4, asuint(_e245));
    const float _e262 = component_1(2.5);
    uint _e264 = local_2;
    local_45 = _e264;
    uint _e266 = local_45;
    local_46 = uint(_e266);
    local_47 = uint(int(14));
    uint _e272 = local_46;
    uint _e273 = local_47;
    local_125 = uint((_e272 + _e273));
    uint _e277 = local_125;
    out_.Store(_e277*4, asuint(asuint(_e262)));
    uint _e280 = local_2;
    local_48 = _e280;
    uint _e282 = local_48;
    local_49 = uint(_e282);
    local_50 = uint(int(15));
    uint _e288 = local_49;
    uint _e289 = local_50;
    local_126 = uint((_e288 + _e289));
    uint _e293 = local_126;
    out_.Store(_e293*4, asuint(threadIdx.x));
    uint _e296 = local_2;
    local_51 = _e296;
    uint _e298 = local_51;
    local_52 = uint(_e298);
    local_53 = uint(int(16));
    uint _e304 = local_52;
    uint _e305 = local_53;
    local_127 = uint((_e304 + _e305));
    uint _e309 = local_127;
    out_.Store(_e309*4, asuint(blockIdx.y));
    uint _e312 = local_2;
    local_54 = _e312;
    uint _e314 = local_54;
    local_55 = uint(_e314);
    local_56 = uint(int(17));
    uint _e320 = local_55;
    uint _e321 = local_56;
    local_128 = uint((_e320 + _e321));
    uint _e325 = local_128;
    out_.Store(_e325*4, asuint(uint3(_NagaConstants.first_vertex, _NagaConstants.first_instance, _NagaConstants.other).z));
    uint _e327 = local_2;
    local_57 = _e327;
    uint _e329 = local_57;
    local_58 = uint(_e329);
    local_59 = uint(int(18));
    uint _e335 = local_58;
    uint _e336 = local_59;
    local_129 = uint((_e335 + _e336));
    uint _e341 = local_129;
    out_.Store(_e341*4, asuint(1u));
    uint _e343 = local;
    local_63 = _e343;
    uint _e345 = local_63;
    local_64 = uint(_e345);
    local_65 = uint(int(0));
    uint _e352 = local_64;
    uint _e353 = local_65;
    local_130 = uint((_e352 + _e353));
    uint _e358 = local_130;
    int _e360 = asint(input.Load(_e358*4));
    local_131 = _e360;
    int _e361 = local_131;
    uint _e363 = local_2;
    local_60 = _e363;
    uint _e365 = local_60;
    local_61 = uint(_e365);
    local_62 = uint(int(19));
    uint _e371 = local_61;
    uint _e372 = local_62;
    local_132 = uint((_e371 + _e372));
    uint _e376 = local_132;
    out_.Store(_e376*4, asuint(uint(_e361)));
    float _e378 = scale;
    uint _e380 = local_2;
    local_66 = _e380;
    uint _e382 = local_66;
    local_67 = uint(_e382);
    local_68 = uint(int(20));
    uint _e388 = local_67;
    uint _e389 = local_68;
    local_133 = uint((_e388 + _e389));
    uint _e393 = local_133;
    out_.Store(_e393*4, asuint(asuint(_e378)));
    uint _e395 = local_1;
    local_72 = _e395;
    uint _e397 = local_72;
    local_73 = uint(_e397);
    local_74 = uint(int(0));
    uint _e404 = local_73;
    uint _e405 = local_74;
    local_134 = uint((_e404 + _e405));
    uint _e410 = local_134;
    float _e413 = asfloat(points.Load(0+_e410*12));
    local_135 = _e413;
    float _e414 = local_135;
    uint _e416 = local_2;
    local_69 = _e416;
    uint _e418 = local_69;
    local_70 = uint(_e418);
    local_71 = uint(int(21));
    uint _e424 = local_70;
    uint _e425 = local_71;
    local_136 = uint((_e424 + _e425));
    uint _e429 = local_136;
    out_.Store(_e429*4, asuint(asuint(_e414)));
    uint _e431 = local_1;
    local_78 = _e431;
    uint _e433 = local_78;
    local_79 = uint(_e433);
    local_80 = uint(int(0));
    uint _e439 = local_79;
    uint _e440 = local_80;
    local_137 = uint((_e439 + _e440));
    uint _e445 = local_137;
    float _e448 = asfloat(points.Load(4+_e445*12));
    local_138 = _e448;
    float _e449 = local_138;
    uint _e451 = local_2;
    local_75 = _e451;
    uint _e453 = local_75;
    local_76 = uint(_e453);
    local_77 = uint(int(22));
    uint _e459 = local_76;
    uint _e460 = local_77;
    local_139 = uint((_e459 + _e460));
    uint _e464 = local_139;
    out_.Store(_e464*4, asuint(asuint(_e449)));
    uint _e466 = local_1;
    local_84 = _e466;
    uint _e468 = local_84;
    local_85 = uint(_e468);
    local_86 = uint(int(0));
    uint _e474 = local_85;
    uint _e475 = local_86;
    local_140 = uint((_e474 + _e475));
    uint _e480 = local_140;
    float _e483 = asfloat(points.Load(8+_e480*12));
    local_141 = _e483;
    float _e484 = local_141;
    uint _e486 = local_2;
    local_81 = _e486;
    uint _e488 = local_81;
    local_82 = uint(_e488);
    local_83 = uint(int(23));
    uint _e494 = local_82;
    uint _e495 = local_83;
    local_142 = uint((_e494 + _e495));
    uint _e499 = local_142;
    out_.Store(_e499*4, asuint(asuint(_e484)));
    uint _e501 = limit;
    uint _e502 = local_2;
    local_87 = _e502;
    uint _e504 = local_87;
    local_88 = uint(_e504);
    local_89 = uint(int(24));
    uint _e510 = local_88;
    uint _e511 = local_89;
    local_143 = uint((_e510 + _e511));
    uint _e515 = local_143;
    out_.Store(_e515*4, asuint(_e501));
    const uint _e518 = thread_component(0u);
    const uint _e520 = group_component(1u);
    const uint _e523 = shape_component(2u);
    const uint _e526 = grid_component(0u);
    uint _e528 = local_2;
    local_90 = _e528;
    uint _e530 = local_90;
    local_91 = uint(_e530);
    local_92 = uint(int(25));
    uint _e536 = local_91;
    uint _e537 = local_92;
    local_144 = uint((_e536 + _e537));
    uint _e541 = local_144;
    out_.Store(_e541*4, asuint((((_e518 + _e520) + _e523) + _e526)));
    const uint _e543 = global_x();
    const uint _e544 = global_x();
    uint _e546 = local_2;
    local_93 = _e546;
    uint _e548 = local_93;
    local_94 = uint(_e548);
    local_95 = uint(int(26));
    uint _e554 = local_94;
    uint _e555 = local_95;
    local_145 = uint((_e554 + _e555));
    uint _e559 = local_145;
    out_.Store(_e559*4, asuint((_e543 + _e544)));
    uint _e561 = local;
    local_99 = _e561;
    uint _e563 = local_99;
    local_100 = uint(_e563);
    local_101 = uint(int(0));
    uint _e569 = local_100;
    uint _e570 = local_101;
    local_146 = uint((_e569 + _e570));
    uint _e575 = local_146;
    int _e577 = asint(input.Load(_e575*4));
    local_147 = _e577;
    int _e578 = local_147;
    float _e580 = scale;
    uint _e582 = local_1;
    local_102 = _e582;
    uint _e584 = local_102;
    local_103 = uint(_e584);
    local_104 = uint(int(0));
    uint _e590 = local_103;
    uint _e591 = local_104;
    local_148 = uint((_e590 + _e591));
    uint _e596 = local_148;
    float _e599 = asfloat(points.Load(0+_e596*12));
    local_149 = _e599;
    float _e600 = local_149;
    uint _e603 = local_2;
    local_96 = _e603;
    uint _e605 = local_96;
    local_97 = uint(_e605);
    local_98 = uint(int(27));
    uint _e611 = local_97;
    uint _e612 = local_98;
    local_150 = uint((_e611 + _e612));
    uint _e616 = local_150;
    out_.Store(_e616*4, asuint(asuint(((float(_e578) * _e580) + _e600))));
    const uint _e619 = kind(threadIdx.x);
    uint _e620 = local_2;
    local_105 = _e620;
    uint _e622 = local_105;
    local_106 = uint(_e622);
    local_107 = uint(int(28));
    uint _e628 = local_106;
    uint _e629 = local_107;
    local_151 = uint((_e628 + _e629));
    uint _e633 = local_151;
    out_.Store(_e633*4, asuint(_e619));
    const uint _e636 = grid_component(2u);
    uint _e637 = local_2;
    local_108 = _e637;
    uint _e639 = local_108;
    local_109 = uint(_e639);
    local_110 = uint(int(29));
    uint _e645 = local_109;
    uint _e646 = local_110;
    local_152 = uint((_e645 + _e646));
    uint _e650 = local_152;
    out_.Store(_e650*4, asuint(_e636));
}
