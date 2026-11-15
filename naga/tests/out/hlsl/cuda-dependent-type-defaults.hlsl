struct R_cuda_record_0_ {
    int x;
    int y;
};

struct float3_ {
    float x;
    float y;
    float z;
};

struct int1_ {
    int x;
};

struct dim3_ {
    uint x;
    uint y;
    uint z;
};

RWByteAddressBuffer output_1 : register(u0);
ByteAddressBuffer input_9 : register(t1);

int kind(int value)
{
    return int(1);
}

int kind_1(uint value_1)
{
    return int(2);
}

uint chain_unsigned_unsigned_const_u0020_unsigned()
{
    uint value_2 = (uint)0;

    value_2 = 7u;
    uint _e2 = value_2;
    return _e2;
}

int selected_int_int(int input_2)
{
    const int _e1 = kind(input_2);
    return _e1;
}

int selected_unsigned_unsigned(uint input_3)
{
    const int _e1 = kind_1(input_3);
    return _e1;
}

int cv_value_int_const_u0020_int()
{
    int value_3 = (int)0;
    int local_123 = (int)0;

    value_3 = int(7);
    local_123 = int(4);
    int _e3 = local_123;
    return _e3;
}

int cv_value_int_int()
{
    int value_4 = (int)0;
    int local_124 = (int)0;

    value_4 = int(7);
    local_124 = int(3);
    int _e3 = local_124;
    return _e3;
}

uint merged_unsigned_unsigned(uint input_4)
{
    return input_4;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int vector3_float3_float3_(float3_ input_5)
{
    float3_ input_6 = (float3_)0;
    float3_ value_5 = (float3_)0;

    input_6 = input_5;
    float3_ _e3 = input_6;
    value_5 = _e3;
    float _e5 = value_5.z;
    return naga_f2i32(_e5);
}

int vector1_int1_int1_(int1_ input_7)
{
    int1_ input_8 = (int1_)0;
    int1_ value_6 = (int1_)0;

    input_8 = input_7;
    int1_ _e3 = input_8;
    value_6 = _e3;
    int _e5 = value_6.x;
    return _e5;
}

int record_value_R_R()
{
    R_cuda_record_0_ value_7 = (R_cuda_record_0_)0;

    value_7.x = int(4);
    value_7.y = int(5);
    int _e7 = value_7.x;
    int _e8 = value_7.y;
    return asint(asuint(_e7) + asuint(_e8));
}

dim3_ Constructdim3_(uint arg0, uint arg1, uint arg2) {
    dim3_ ret = (dim3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

uint shape_dim3_dim3_()
{
    dim3_ value_8 = (dim3_)0;

    value_8 = Constructdim3_(1u, 1u, 1u);
    uint _e7 = value_8.x;
    uint _e8 = value_8.y;
    uint _e11 = value_8.z;
    return ((_e7 + _e8) + _e11);
}

void null_value_decltype_u0028_nullptr_u0029_decltype_u0028_nullptr_u0029_()
{
    return;
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

int ZeroValueint() {
    return (int)0;
}

uint ZeroValueuint() {
    return (uint)0;
}

[numthreads(4, 1, 1)]
void dependent_type_defaults(uint3 threadIdx : SV_GroupThreadID)
{
    uint output[2] = (uint[2])0;
    uint input[2] = (uint[2])0;
    uint local[2] = (uint[2])0;
    uint local_1[2] = (uint[2])0;
    uint local_2 = (uint)0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13[2] = (uint[2])0;
    uint local_14 = (uint)0;
    float3_ vector_ = (float3_)0;
    int1_ one = (int1_)0;
    uint local_15[2] = (uint[2])0;
    uint local_16 = (uint)0;
    uint local_17[2] = (uint[2])0;
    uint local_18 = (uint)0;
    uint local_19[2] = (uint[2])0;
    uint local_20 = (uint)0;
    uint local_21[2] = (uint[2])0;
    uint local_22 = (uint)0;
    uint local_23[2] = (uint[2])0;
    uint local_24 = (uint)0;
    int local_25 = (int)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    uint local_28[2] = (uint[2])0;
    uint local_29 = (uint)0;
    int state = (int)0;
    uint local_30[2] = (uint[2])0;
    uint local_31 = (uint)0;
    uint local_32[2] = (uint[2])0;
    uint local_33 = (uint)0;
    bool local_34 = (bool)0;
    int local_35 = (int)0;
    bool local_36 = (bool)0;
    int local_37 = (int)0;
    int index = (int)0;
    uint local_38[2] = (uint[2])0;
    uint local_39 = (uint)0;
    uint local_40[2] = (uint[2])0;
    uint local_41 = (uint)0;
    uint local_42[2] = (uint[2])0;
    uint local_43 = (uint)0;
    uint local_44[2] = (uint[2])0;
    uint local_45 = (uint)0;
    uint input_1[2] = (uint[2])0;
    uint local_46[2] = (uint[2])0;
    uint pointer[2] = (uint[2])0;
    uint local_47[2] = (uint[2])0;
    uint local_48[2] = (uint[2])0;
    int local_49 = (int)0;
    int amount = (int)0;
    int copy = (int)0;
    int old = (int)0;
    uint amount_1 = (uint)0;
    uint copy_1 = (uint)0;
    int old_1 = (int)0;
    int amount_2 = (int)0;
    int copy_2 = (int)0;
    int old_2 = (int)0;
    int local_50 = (int)0;
    int local_51 = (int)0;
    int amount_3 = (int)0;
    int copy_3 = (int)0;
    int old_3 = (int)0;
    int local_52 = (int)0;
    int local_53 = (int)0;
    int amount_4 = (int)0;
    int copy_4 = (int)0;
    int old_4 = (int)0;
    uint local_54[2] = (uint[2])0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57[2] = (uint[2])0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60[2] = (uint[2])0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63[2] = (uint[2])0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66[2] = (uint[2])0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint local_69[2] = (uint[2])0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72[2] = (uint[2])0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75[2] = (uint[2])0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78[2] = (uint[2])0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81[2] = (uint[2])0;
    uint local_82 = (uint)0;
    uint local_83 = (uint)0;
    uint local_84[2] = (uint[2])0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87[2] = (uint[2])0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;
    uint local_90[2] = (uint[2])0;
    uint local_91 = (uint)0;
    uint local_92 = (uint)0;
    uint local_93[2] = (uint[2])0;
    uint local_94 = (uint)0;
    uint local_95 = (uint)0;
    uint local_96[2] = (uint[2])0;
    uint local_97 = (uint)0;
    uint local_98 = (uint)0;
    uint local_99[2] = (uint[2])0;
    uint local_100 = (uint)0;
    uint local_101 = (uint)0;
    uint local_102[2] = (uint[2])0;
    uint local_103 = (uint)0;
    uint local_104 = (uint)0;
    uint local_105[2] = (uint[2])0;
    uint local_106 = (uint)0;
    uint local_107 = (uint)0;
    uint local_108[2] = (uint[2])0;
    uint local_109 = (uint)0;
    uint local_110 = (uint)0;
    uint local_111[2] = (uint[2])0;
    uint local_112 = (uint)0;
    uint local_113 = (uint)0;
    uint local_114[2] = (uint[2])0;
    uint local_115 = (uint)0;
    uint local_116 = (uint)0;
    uint local_117[2] = (uint[2])0;
    uint local_118 = (uint)0;
    uint local_119 = (uint)0;
    uint local_120[2] = (uint[2])0;
    uint local_121 = (uint)0;
    uint local_122 = (uint)0;

    output = ZeroValuearray2_uint_();
    output[0] = 2u;
    output[1] = 0u;
    input = ZeroValuearray2_uint_();
    input[0] = 3u;
    input[1] = 0u;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 20u));
    const uint _e18 = chain_unsigned_unsigned_const_u0020_unsigned();
    uint _e20[2] = output;
    local = _e20;
    uint _e22[2] = local;
    local_54 = _e22;
    uint _e25 = local_54[1];
    local_54[1] = (_e25 + base);
    uint _e29 = local_54[0];
    local_55 = uint(_e29);
    uint _e33 = local_54[1];
    local_56 = uint(_e33);
    uint _e36 = local_56;
    output_1.Store(_e36*4, asuint(_e18));
    const uint _e39 = chain_unsigned_unsigned_const_u0020_unsigned();
    uint _e40[2] = output;
    local_1 = _e40;
    local_2 = uint((base + 1u));
    uint _e46[2] = local_1;
    local_57 = _e46;
    uint _e48 = local_2;
    uint _e50 = local_57[1];
    local_57[1] = (_e50 + _e48);
    uint _e54 = local_57[0];
    local_58 = uint(_e54);
    uint _e58 = local_57[1];
    local_59 = uint(_e58);
    uint _e61 = local_59;
    output_1.Store(_e61*4, asuint(_e39));
    const uint _e63 = chain_unsigned_unsigned_const_u0020_unsigned();
    uint _e64[2] = output;
    local_3 = _e64;
    local_4 = uint((base + 2u));
    uint _e70[2] = local_3;
    local_60 = _e70;
    uint _e72 = local_4;
    uint _e74 = local_60[1];
    local_60[1] = (_e74 + _e72);
    uint _e78 = local_60[0];
    local_61 = uint(_e78);
    uint _e82 = local_60[1];
    local_62 = uint(_e82);
    uint _e85 = local_62;
    output_1.Store(_e85*4, asuint(_e63));
    const int _e88 = selected_int_int(int(1));
    uint _e90[2] = output;
    local_5 = _e90;
    local_6 = uint((base + 3u));
    uint _e96[2] = local_5;
    local_63 = _e96;
    uint _e98 = local_6;
    uint _e100 = local_63[1];
    local_63[1] = (_e100 + _e98);
    uint _e104 = local_63[0];
    local_64 = uint(_e104);
    uint _e108 = local_63[1];
    local_65 = uint(_e108);
    uint _e111 = local_65;
    output_1.Store(_e111*4, asuint(uint(_e88)));
    const int _e114 = selected_unsigned_unsigned(1u);
    uint _e116[2] = output;
    local_7 = _e116;
    local_8 = uint((base + 4u));
    uint _e122[2] = local_7;
    local_66 = _e122;
    uint _e124 = local_8;
    uint _e126 = local_66[1];
    local_66[1] = (_e126 + _e124);
    uint _e130 = local_66[0];
    local_67 = uint(_e130);
    uint _e134 = local_66[1];
    local_68 = uint(_e134);
    uint _e137 = local_68;
    output_1.Store(_e137*4, asuint(uint(_e114)));
    const int _e139 = cv_value_int_const_u0020_int();
    uint _e141[2] = output;
    local_9 = _e141;
    local_10 = uint((base + 5u));
    uint _e147[2] = local_9;
    local_69 = _e147;
    uint _e149 = local_10;
    uint _e151 = local_69[1];
    local_69[1] = (_e151 + _e149);
    uint _e155 = local_69[0];
    local_70 = uint(_e155);
    uint _e159 = local_69[1];
    local_71 = uint(_e159);
    uint _e162 = local_71;
    output_1.Store(_e162*4, asuint(uint(_e139)));
    const int _e164 = cv_value_int_int();
    uint _e166[2] = output;
    local_11 = _e166;
    local_12 = uint((base + 6u));
    uint _e172[2] = local_11;
    local_72 = _e172;
    uint _e174 = local_12;
    uint _e176 = local_72[1];
    local_72[1] = (_e176 + _e174);
    uint _e180 = local_72[0];
    local_73 = uint(_e180);
    uint _e184 = local_72[1];
    local_74 = uint(_e184);
    uint _e187 = local_74;
    output_1.Store(_e187*4, asuint(uint(_e164)));
    const uint _e190 = merged_unsigned_unsigned(8u);
    uint _e191[2] = output;
    local_13 = _e191;
    local_14 = uint((base + 7u));
    uint _e197[2] = local_13;
    local_75 = _e197;
    uint _e199 = local_14;
    uint _e201 = local_75[1];
    local_75[1] = (_e201 + _e199);
    uint _e205 = local_75[0];
    local_76 = uint(_e205);
    uint _e209 = local_75[1];
    local_77 = uint(_e209);
    uint _e212 = local_77;
    output_1.Store(_e212*4, asuint(_e190));
    vector_.x = float(int(1));
    vector_.y = float(int(2));
    vector_.z = float(int(3));
    one.x = int(7);
    float3_ _e227 = vector_;
    const int _e228 = vector3_float3_float3_(_e227);
    uint _e230[2] = output;
    local_15 = _e230;
    local_16 = uint((base + 8u));
    uint _e236[2] = local_15;
    local_78 = _e236;
    uint _e238 = local_16;
    uint _e240 = local_78[1];
    local_78[1] = (_e240 + _e238);
    uint _e244 = local_78[0];
    local_79 = uint(_e244);
    uint _e248 = local_78[1];
    local_80 = uint(_e248);
    uint _e251 = local_80;
    output_1.Store(_e251*4, asuint(uint(_e228)));
    int1_ _e253 = one;
    const int _e254 = vector1_int1_int1_(_e253);
    uint _e256[2] = output;
    local_17 = _e256;
    local_18 = uint((base + 9u));
    uint _e262[2] = local_17;
    local_81 = _e262;
    uint _e264 = local_18;
    uint _e266 = local_81[1];
    local_81[1] = (_e266 + _e264);
    uint _e270 = local_81[0];
    local_82 = uint(_e270);
    uint _e274 = local_81[1];
    local_83 = uint(_e274);
    uint _e277 = local_83;
    output_1.Store(_e277*4, asuint(uint(_e254)));
    const int _e279 = record_value_R_R();
    uint _e281[2] = output;
    local_19 = _e281;
    local_20 = uint((base + 10u));
    uint _e287[2] = local_19;
    local_84 = _e287;
    uint _e289 = local_20;
    uint _e291 = local_84[1];
    local_84[1] = (_e291 + _e289);
    uint _e295 = local_84[0];
    local_85 = uint(_e295);
    uint _e299 = local_84[1];
    local_86 = uint(_e299);
    uint _e302 = local_86;
    output_1.Store(_e302*4, asuint(uint(_e279)));
    const uint _e304 = shape_dim3_dim3_();
    uint _e305[2] = output;
    local_21 = _e305;
    local_22 = uint((base + 11u));
    uint _e311[2] = local_21;
    local_87 = _e311;
    uint _e313 = local_22;
    uint _e315 = local_87[1];
    local_87[1] = (_e315 + _e313);
    uint _e319 = local_87[0];
    local_88 = uint(_e319);
    uint _e323 = local_87[1];
    local_89 = uint(_e323);
    uint _e326 = local_89;
    output_1.Store(_e326*4, asuint(_e304));
    null_value_decltype_u0028_nullptr_u0029_decltype_u0028_nullptr_u0029_();
    uint _e330[2] = output;
    local_23 = _e330;
    local_24 = uint((base + 12u));
    uint _e336[2] = local_23;
    local_90 = _e336;
    uint _e338 = local_24;
    uint _e340 = local_90[1];
    local_90[1] = (_e340 + _e338);
    uint _e344 = local_90[0];
    local_91 = uint(_e344);
    uint _e348 = local_90[1];
    local_92 = uint(_e348);
    uint _e351 = local_92;
    output_1.Store(_e351*4, asuint(uint(true)));
    local_25 = int(0);
    local_49 = ZeroValueint();
    input_1 = ZeroValuearray2_uint_();
    input_1[0] = 4u;
    input_1[1] = 0u;
    uint _e364[2] = input_1;
    local_46 = _e364;
    uint _e366[2] = local_46;
    pointer = _e366;
    uint _e369[2] = pointer;
    local_47 = _e369;
    uint _e371[2] = local_47;
    local_93 = _e371;
    uint _e374 = local_93[0];
    local_94 = uint(_e374);
    uint _e378 = local_93[1];
    local_95 = uint(_e378);
    local_25 = int(9);
    uint _e382[2] = pointer;
    local_48 = _e382;
    uint _e384[2] = local_48;
    local_96 = _e384;
    uint _e387 = local_96[0];
    local_97 = uint(_e387);
    uint _e391 = local_96[1];
    local_98 = uint(_e391);
    int _e394 = local_25;
    local_49 = _e394;
    int _e396 = local_49;
    uint _e398[2] = output;
    local_26 = _e398;
    local_27 = uint((base + 13u));
    uint _e404[2] = local_26;
    local_99 = _e404;
    uint _e406 = local_27;
    uint _e408 = local_99[1];
    local_99[1] = (_e408 + _e406);
    uint _e412 = local_99[0];
    local_100 = uint(_e412);
    uint _e416 = local_99[1];
    local_101 = uint(_e416);
    uint _e419 = local_101;
    output_1.Store(_e419*4, asuint(uint(_e396)));
    int _e421 = local_25;
    uint _e423[2] = output;
    local_28 = _e423;
    local_29 = uint((base + 14u));
    uint _e429[2] = local_28;
    local_102 = _e429;
    uint _e431 = local_29;
    uint _e433 = local_102[1];
    local_102[1] = (_e433 + _e431);
    uint _e437 = local_102[0];
    local_103 = uint(_e437);
    uint _e441 = local_102[1];
    local_104 = uint(_e441);
    uint _e444 = local_104;
    output_1.Store(_e444*4, asuint(uint(_e421)));
    state = asint(asuint(int(lane)) + asuint(int(1)));
    amount = ZeroValueint();
    copy = ZeroValueint();
    old = ZeroValueint();
    amount = int(2);
    int _e458 = amount;
    copy = _e458;
    int _e460 = state;
    old = _e460;
    int _e462 = copy;
    int _e463 = state;
    state = asint(asuint(_e463) + asuint(_e462));
    int _e465 = old;
    uint _e467[2] = output;
    local_30 = _e467;
    local_31 = uint((base + 15u));
    uint _e473[2] = local_30;
    local_105 = _e473;
    uint _e475 = local_31;
    uint _e477 = local_105[1];
    local_105[1] = (_e477 + _e475);
    uint _e481 = local_105[0];
    local_106 = uint(_e481);
    uint _e485 = local_105[1];
    local_107 = uint(_e485);
    uint _e488 = local_107;
    output_1.Store(_e488*4, asuint(uint(_e465)));
    amount_1 = ZeroValueuint();
    copy_1 = ZeroValueuint();
    old_1 = ZeroValueint();
    amount_1 = 3u;
    uint _e498 = amount_1;
    copy_1 = _e498;
    int _e500 = state;
    old_1 = _e500;
    uint _e502 = copy_1;
    int _e504 = state;
    state = asint(asuint(_e504) + asuint(int(_e502)));
    int _e506 = old_1;
    uint _e508[2] = output;
    local_32 = _e508;
    local_33 = uint((base + 16u));
    uint _e514[2] = local_32;
    local_108 = _e514;
    uint _e516 = local_33;
    uint _e518 = local_108[1];
    local_108[1] = (_e518 + _e516);
    uint _e522 = local_108[0];
    local_109 = uint(_e522);
    uint _e526 = local_108[1];
    local_110 = uint(_e526);
    uint _e529 = local_110;
    output_1.Store(_e529*4, asuint(uint(_e506)));
    local_34 = false;
    if (false) {
        amount_2 = ZeroValueint();
        copy_2 = ZeroValueint();
        old_2 = ZeroValueint();
        amount_2 = int(99);
        int _e541 = amount_2;
        copy_2 = _e541;
        int _e543 = state;
        local_50 = _e543;
        int _e545 = local_50;
        old_2 = _e545;
        int _e547 = copy_2;
        int _e548 = state;
        local_51 = _e548;
        int _e550 = local_51;
        state = asint(asuint(_e550) + asuint(_e547));
        int _e552 = old_2;
        local_35 = _e552;
        int _e554 = local_35;
        local_34 = (_e554 != int(0));
    }
    local_36 = true;
    if (true) {
    } else {
        amount_3 = ZeroValueint();
        copy_3 = ZeroValueint();
        old_3 = ZeroValueint();
        amount_3 = int(99);
        int _e567 = amount_3;
        copy_3 = _e567;
        int _e569 = state;
        local_52 = _e569;
        int _e571 = local_52;
        old_3 = _e571;
        int _e573 = copy_3;
        int _e574 = state;
        local_53 = _e574;
        int _e576 = local_53;
        state = asint(asuint(_e576) + asuint(_e573));
        int _e578 = old_3;
        local_37 = _e578;
        int _e580 = local_37;
        local_36 = (_e580 != int(0));
    }
    index = int(0);
    uint _e586[2] = input;
    local_38 = _e586;
    int _e588 = index;
    index = asint(asuint(_e588) + asuint(int(1)));
    local_39 = uint(_e588);
    uint _e593[2] = local_38;
    local_111 = _e593;
    uint _e595 = local_39;
    uint _e597 = local_111[1];
    local_111[1] = (_e597 + _e595);
    uint _e601 = local_111[0];
    local_112 = uint(_e601);
    uint _e605 = local_111[1];
    local_113 = uint(_e605);
    uint _e608 = local_113;
    int _e611 = asint(input_9.Load(_e608*4));
    amount_4 = ZeroValueint();
    copy_4 = ZeroValueint();
    old_4 = ZeroValueint();
    amount_4 = _e611;
    int _e619 = amount_4;
    copy_4 = _e619;
    int _e621 = state;
    old_4 = _e621;
    int _e623 = copy_4;
    int _e624 = state;
    state = asint(asuint(_e624) + asuint(_e623));
    int _e626 = state;
    uint _e628[2] = output;
    local_40 = _e628;
    local_41 = uint((base + 17u));
    uint _e634[2] = local_40;
    local_114 = _e634;
    uint _e636 = local_41;
    uint _e638 = local_114[1];
    local_114[1] = (_e638 + _e636);
    uint _e642 = local_114[0];
    local_115 = uint(_e642);
    uint _e646 = local_114[1];
    local_116 = uint(_e646);
    uint _e649 = local_116;
    output_1.Store(_e649*4, asuint(uint(_e626)));
    int _e651 = index;
    uint _e653[2] = output;
    local_42 = _e653;
    local_43 = uint((base + 18u));
    uint _e659[2] = local_42;
    local_117 = _e659;
    uint _e661 = local_43;
    uint _e663 = local_117[1];
    local_117[1] = (_e663 + _e661);
    uint _e667 = local_117[0];
    local_118 = uint(_e667);
    uint _e671 = local_117[1];
    local_119 = uint(_e671);
    uint _e674 = local_119;
    output_1.Store(_e674*4, asuint(uint(_e651)));
    const uint _e677 = merged_unsigned_unsigned(1u);
    const int _e678 = kind_1(_e677);
    uint _e680[2] = output;
    local_44 = _e680;
    local_45 = uint((base + 19u));
    uint _e686[2] = local_44;
    local_120 = _e686;
    uint _e688 = local_45;
    uint _e690 = local_120[1];
    local_120[1] = (_e690 + _e688);
    uint _e694 = local_120[0];
    local_121 = uint(_e694);
    uint _e698 = local_120[1];
    local_122 = uint(_e698);
    uint _e701 = local_122;
    output_1.Store(_e701*4, asuint(uint(_e678)));
}
