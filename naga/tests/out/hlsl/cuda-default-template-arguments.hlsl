struct Record_cuda_record_0_ {
    int x;
    int y;
};

struct float3_ {
    float x;
    float y;
    float z;
};

struct dim3_ {
    uint x;
    uint y;
    uint z;
};

RWByteAddressBuffer output_1 : register(u0);
ByteAddressBuffer input_2 : register(t1);

int kind(int value_2)
{
    return int(1);
}

int kind_1(uint value_3)
{
    return int(2);
}

int selected(int value_4)
{
    return asint(asuint(int(10)) + asuint(value_4));
}

uint default_value_unsigned()
{
    return uint(int(7));
}

uint self_named_unsigned()
{
    return uint(int(9));
}

int deduced_kind_int(int value_5)
{
    const int _e1 = kind(value_5);
    return _e1;
}

int deduced_kind_unsigned(uint value_6)
{
    const int _e1 = kind_1(value_6);
    return _e1;
}

uint converted_unsigned_int(int value_7)
{
    return uint(value_7);
}

int converted_int_unsigned(uint value_8)
{
    return int(value_8);
}

int selected_unsigned(uint value_9)
{
    return asint(asuint(int(20)) + asuint(int(value_9)));
}

int selected_int(int value_10)
{
    return asint(asuint(int(20)) + asuint(value_10));
}

int frozen_cv_const_u0020_int()
{
    int value_11 = (int)0;
    int local_141 = (int)0;

    value_11 = int(7);
    local_141 = int(4);
    int _e3 = local_141;
    return _e3;
}

int frozen_cv_int()
{
    int value_12 = (int)0;
    int local_142 = (int)0;

    value_12 = int(7);
    local_142 = int(3);
    int _e3 = local_142;
    return _e3;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int vector_value_float3_()
{
    float3_ value_13 = (float3_)0;

    value_13.x = 1.0;
    value_13.y = 2.0;
    value_13.z = 3.0;
    float _e8 = value_13.z;
    return naga_f2i32(_e8);
}

int record_value_Record()
{
    Record_cuda_record_0_ value_14 = (Record_cuda_record_0_)0;

    value_14.x = int(4);
    value_14.y = int(5);
    int _e7 = value_14.x;
    int _e8 = value_14.y;
    return asint(asuint(_e7) + asuint(_e8));
}

dim3_ Constructdim3_(uint arg0, uint arg1, uint arg2) {
    dim3_ ret = (dim3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

uint shape_value_dim3_()
{
    dim3_ value_15 = (dim3_)0;

    value_15 = Constructdim3_(1u, 1u, 1u);
    uint _e8 = value_15.y;
    uint _e10 = value_15.x;
    uint _e14 = value_15.z;
    return ((_e10 + (10u * _e8)) + (100u * _e14));
}

void null_value_decltype_u0028_nullptr_u0029_()
{
    return;
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

uint ZeroValueuint() {
    return (uint)0;
}

int ZeroValueint() {
    return (int)0;
}

[numthreads(4, 1, 1)]
void default_template_arguments(uint3 threadIdx : SV_GroupThreadID)
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
    uint local_25[2] = (uint[2])0;
    uint local_26 = (uint)0;
    uint local_27[2] = (uint[2])0;
    uint local_28 = (uint)0;
    uint local_29[2] = (uint[2])0;
    uint local_30 = (uint)0;
    uint local_31[2] = (uint[2])0;
    uint local_32 = (uint)0;
    uint local_33[2] = (uint[2])0;
    uint local_34 = (uint)0;
    uint local_35[2] = (uint[2])0;
    uint local_36 = (uint)0;
    int value = (int)0;
    uint local_37[2] = (uint[2])0;
    uint local_38 = (uint)0;
    uint local_39[2] = (uint[2])0;
    uint local_40 = (uint)0;
    bool local_41 = (bool)0;
    int local_42 = (int)0;
    bool local_43 = (bool)0;
    int local_44 = (int)0;
    uint local_45[2] = (uint[2])0;
    uint local_46 = (uint)0;
    uint local_47[2] = (uint[2])0;
    uint local_48 = (uint)0;
    uint local_49[2] = (uint[2])0;
    uint local_50 = (uint)0;
    uint local_51[2] = (uint[2])0;
    uint local_52 = (uint)0;
    uint local_53[2] = (uint[2])0;
    uint local_54 = (uint)0;
    uint input_1[2] = (uint[2])0;
    uint local_55[2] = (uint[2])0;
    uint value_1[2] = (uint[2])0;
    uint local_56[2] = (uint[2])0;
    uint local_57 = (uint)0;
    int local_58 = (int)0;
    int amount = (int)0;
    int old = (int)0;
    int amount_1 = (int)0;
    int old_1 = (int)0;
    int amount_2 = (int)0;
    int old_2 = (int)0;
    int local_59 = (int)0;
    int local_60 = (int)0;
    int amount_3 = (int)0;
    int old_3 = (int)0;
    int local_61 = (int)0;
    int local_62 = (int)0;
    int amount_4 = (int)0;
    int old_4 = (int)0;
    int amount_5 = (int)0;
    int old_5 = (int)0;
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
    uint local_123[2] = (uint[2])0;
    uint local_124 = (uint)0;
    uint local_125 = (uint)0;
    uint local_126[2] = (uint[2])0;
    uint local_127 = (uint)0;
    uint local_128 = (uint)0;
    uint local_129[2] = (uint[2])0;
    uint local_130 = (uint)0;
    uint local_131 = (uint)0;
    uint local_132[2] = (uint[2])0;
    uint local_133 = (uint)0;
    uint local_134 = (uint)0;
    uint local_135[2] = (uint[2])0;
    uint local_136 = (uint)0;
    uint local_137 = (uint)0;
    uint local_138[2] = (uint[2])0;
    uint local_139 = (uint)0;
    uint local_140 = (uint)0;

    output = ZeroValuearray2_uint_();
    output[0] = 2u;
    output[1] = 0u;
    input = ZeroValuearray2_uint_();
    input[0] = 3u;
    input[1] = 0u;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 24u));
    const uint _e18 = default_value_unsigned();
    uint _e20[2] = output;
    local = _e20;
    uint _e22[2] = local;
    local_63 = _e22;
    uint _e25 = local_63[1];
    local_63[1] = (_e25 + base);
    uint _e29 = local_63[0];
    local_64 = uint(_e29);
    uint _e33 = local_63[1];
    local_65 = uint(_e33);
    uint _e36 = local_65;
    output_1.Store(_e36*4, asuint(_e18));
    const uint _e39 = default_value_unsigned();
    uint _e40[2] = output;
    local_1 = _e40;
    local_2 = uint((base + 1u));
    uint _e46[2] = local_1;
    local_66 = _e46;
    uint _e48 = local_2;
    uint _e50 = local_66[1];
    local_66[1] = (_e50 + _e48);
    uint _e54 = local_66[0];
    local_67 = uint(_e54);
    uint _e58 = local_66[1];
    local_68 = uint(_e58);
    uint _e61 = local_68;
    output_1.Store(_e61*4, asuint(_e39));
    const uint _e63 = default_value_unsigned();
    uint _e64[2] = output;
    local_3 = _e64;
    local_4 = uint((base + 2u));
    uint _e70[2] = local_3;
    local_69 = _e70;
    uint _e72 = local_4;
    uint _e74 = local_69[1];
    local_69[1] = (_e74 + _e72);
    uint _e78 = local_69[0];
    local_70 = uint(_e78);
    uint _e82 = local_69[1];
    local_71 = uint(_e82);
    uint _e85 = local_71;
    output_1.Store(_e85*4, asuint(_e63));
    const uint _e87 = self_named_unsigned();
    uint _e88[2] = output;
    local_5 = _e88;
    local_6 = uint((base + 3u));
    uint _e94[2] = local_5;
    local_72 = _e94;
    uint _e96 = local_6;
    uint _e98 = local_72[1];
    local_72[1] = (_e98 + _e96);
    uint _e102 = local_72[0];
    local_73 = uint(_e102);
    uint _e106 = local_72[1];
    local_74 = uint(_e106);
    uint _e109 = local_74;
    output_1.Store(_e109*4, asuint(_e87));
    const int _e112 = deduced_kind_int(int(1));
    uint _e114[2] = output;
    local_7 = _e114;
    local_8 = uint((base + 4u));
    uint _e120[2] = local_7;
    local_75 = _e120;
    uint _e122 = local_8;
    uint _e124 = local_75[1];
    local_75[1] = (_e124 + _e122);
    uint _e128 = local_75[0];
    local_76 = uint(_e128);
    uint _e132 = local_75[1];
    local_77 = uint(_e132);
    uint _e135 = local_77;
    output_1.Store(_e135*4, asuint(uint(_e112)));
    const int _e138 = deduced_kind_unsigned(1u);
    uint _e140[2] = output;
    local_9 = _e140;
    local_10 = uint((base + 5u));
    uint _e146[2] = local_9;
    local_78 = _e146;
    uint _e148 = local_10;
    uint _e150 = local_78[1];
    local_78[1] = (_e150 + _e148);
    uint _e154 = local_78[0];
    local_79 = uint(_e154);
    uint _e158 = local_78[1];
    local_80 = uint(_e158);
    uint _e161 = local_80;
    output_1.Store(_e161*4, asuint(uint(_e138)));
    const uint _e164 = converted_unsigned_int(int(3));
    const int _e165 = kind_1(_e164);
    uint _e167[2] = output;
    local_11 = _e167;
    local_12 = uint((base + 6u));
    uint _e173[2] = local_11;
    local_81 = _e173;
    uint _e175 = local_12;
    uint _e177 = local_81[1];
    local_81[1] = (_e177 + _e175);
    uint _e181 = local_81[0];
    local_82 = uint(_e181);
    uint _e185 = local_81[1];
    local_83 = uint(_e185);
    uint _e188 = local_83;
    output_1.Store(_e188*4, asuint(uint(_e165)));
    const int _e191 = converted_int_unsigned(3u);
    const int _e192 = kind(_e191);
    uint _e194[2] = output;
    local_13 = _e194;
    local_14 = uint((base + 7u));
    uint _e200[2] = local_13;
    local_84 = _e200;
    uint _e202 = local_14;
    uint _e204 = local_84[1];
    local_84[1] = (_e204 + _e202);
    uint _e208 = local_84[0];
    local_85 = uint(_e208);
    uint _e212 = local_84[1];
    local_86 = uint(_e212);
    uint _e215 = local_86;
    output_1.Store(_e215*4, asuint(uint(_e192)));
    const int _e218 = selected(int(1));
    uint _e220[2] = output;
    local_15 = _e220;
    local_16 = uint((base + 8u));
    uint _e226[2] = local_15;
    local_87 = _e226;
    uint _e228 = local_16;
    uint _e230 = local_87[1];
    local_87[1] = (_e230 + _e228);
    uint _e234 = local_87[0];
    local_88 = uint(_e234);
    uint _e238 = local_87[1];
    local_89 = uint(_e238);
    uint _e241 = local_89;
    output_1.Store(_e241*4, asuint(uint(_e218)));
    const int _e244 = selected_unsigned(1u);
    uint _e246[2] = output;
    local_17 = _e246;
    local_18 = uint((base + 9u));
    uint _e252[2] = local_17;
    local_90 = _e252;
    uint _e254 = local_18;
    uint _e256 = local_90[1];
    local_90[1] = (_e256 + _e254);
    uint _e260 = local_90[0];
    local_91 = uint(_e260);
    uint _e264 = local_90[1];
    local_92 = uint(_e264);
    uint _e267 = local_92;
    output_1.Store(_e267*4, asuint(uint(_e244)));
    const int _e270 = selected_int(int(1));
    uint _e272[2] = output;
    local_19 = _e272;
    local_20 = uint((base + 10u));
    uint _e278[2] = local_19;
    local_93 = _e278;
    uint _e280 = local_20;
    uint _e282 = local_93[1];
    local_93[1] = (_e282 + _e280);
    uint _e286 = local_93[0];
    local_94 = uint(_e286);
    uint _e290 = local_93[1];
    local_95 = uint(_e290);
    uint _e293 = local_95;
    output_1.Store(_e293*4, asuint(uint(_e270)));
    const int _e295 = frozen_cv_const_u0020_int();
    uint _e297[2] = output;
    local_21 = _e297;
    local_22 = uint((base + 11u));
    uint _e303[2] = local_21;
    local_96 = _e303;
    uint _e305 = local_22;
    uint _e307 = local_96[1];
    local_96[1] = (_e307 + _e305);
    uint _e311 = local_96[0];
    local_97 = uint(_e311);
    uint _e315 = local_96[1];
    local_98 = uint(_e315);
    uint _e318 = local_98;
    output_1.Store(_e318*4, asuint(uint(_e295)));
    const int _e320 = frozen_cv_int();
    uint _e322[2] = output;
    local_23 = _e322;
    local_24 = uint((base + 12u));
    uint _e328[2] = local_23;
    local_99 = _e328;
    uint _e330 = local_24;
    uint _e332 = local_99[1];
    local_99[1] = (_e332 + _e330);
    uint _e336 = local_99[0];
    local_100 = uint(_e336);
    uint _e340 = local_99[1];
    local_101 = uint(_e340);
    uint _e343 = local_101;
    output_1.Store(_e343*4, asuint(uint(_e320)));
    const int _e345 = vector_value_float3_();
    uint _e347[2] = output;
    local_25 = _e347;
    local_26 = uint((base + 13u));
    uint _e353[2] = local_25;
    local_102 = _e353;
    uint _e355 = local_26;
    uint _e357 = local_102[1];
    local_102[1] = (_e357 + _e355);
    uint _e361 = local_102[0];
    local_103 = uint(_e361);
    uint _e365 = local_102[1];
    local_104 = uint(_e365);
    uint _e368 = local_104;
    output_1.Store(_e368*4, asuint(uint(_e345)));
    const int _e370 = record_value_Record();
    uint _e372[2] = output;
    local_27 = _e372;
    local_28 = uint((base + 14u));
    uint _e378[2] = local_27;
    local_105 = _e378;
    uint _e380 = local_28;
    uint _e382 = local_105[1];
    local_105[1] = (_e382 + _e380);
    uint _e386 = local_105[0];
    local_106 = uint(_e386);
    uint _e390 = local_105[1];
    local_107 = uint(_e390);
    uint _e393 = local_107;
    output_1.Store(_e393*4, asuint(uint(_e370)));
    const uint _e395 = shape_value_dim3_();
    uint _e396[2] = output;
    local_29 = _e396;
    local_30 = uint((base + 15u));
    uint _e402[2] = local_29;
    local_108 = _e402;
    uint _e404 = local_30;
    uint _e406 = local_108[1];
    local_108[1] = (_e406 + _e404);
    uint _e410 = local_108[0];
    local_109 = uint(_e410);
    uint _e414 = local_108[1];
    local_110 = uint(_e414);
    uint _e417 = local_110;
    output_1.Store(_e417*4, asuint(_e395));
    null_value_decltype_u0028_nullptr_u0029_();
    uint _e421[2] = output;
    local_31 = _e421;
    local_32 = uint((base + 16u));
    uint _e427[2] = local_31;
    local_111 = _e427;
    uint _e429 = local_32;
    uint _e431 = local_111[1];
    local_111[1] = (_e431 + _e429);
    uint _e435 = local_111[0];
    local_112 = uint(_e435);
    uint _e439 = local_111[1];
    local_113 = uint(_e439);
    uint _e442 = local_113;
    output_1.Store(_e442*4, asuint(uint(true)));
    uint _e445[2] = input;
    local_35 = _e445;
    local_36 = uint(int(1));
    local_57 = ZeroValueuint();
    local_58 = ZeroValueint();
    uint _e454[2] = local_35;
    input_1 = _e454;
    uint _e456 = local_36;
    uint _e458 = input_1[1];
    input_1[1] = (_e458 + _e456);
    uint _e462[2] = input_1;
    local_55 = _e462;
    uint _e464[2] = local_55;
    value_1 = _e464;
    uint _e467[2] = value_1;
    local_56 = _e467;
    local_57 = uint(int(0));
    uint _e472[2] = local_56;
    local_114 = _e472;
    uint _e474 = local_57;
    uint _e476 = local_114[1];
    local_114[1] = (_e476 + _e474);
    uint _e480 = local_114[0];
    local_115 = uint(_e480);
    uint _e484 = local_114[1];
    local_116 = uint(_e484);
    uint _e487 = local_116;
    int _e490 = asint(input_2.Load(_e487*4));
    local_58 = _e490;
    int _e492 = local_58;
    uint _e494[2] = output;
    local_33 = _e494;
    local_34 = uint((base + 17u));
    uint _e500[2] = local_33;
    local_117 = _e500;
    uint _e502 = local_34;
    uint _e504 = local_117[1];
    local_117[1] = (_e504 + _e502);
    uint _e508 = local_117[0];
    local_118 = uint(_e508);
    uint _e512 = local_117[1];
    local_119 = uint(_e512);
    uint _e515 = local_119;
    output_1.Store(_e515*4, asuint(uint(_e492)));
    value = asint(asuint(int(lane)) + asuint(int(1)));
    amount = ZeroValueint();
    old = ZeroValueint();
    amount = int(2);
    int _e527 = value;
    old = _e527;
    int _e529 = amount;
    int _e530 = value;
    value = asint(asuint(_e530) + asuint(_e529));
    int _e532 = old;
    uint _e534[2] = output;
    local_37 = _e534;
    local_38 = uint((base + 18u));
    uint _e540[2] = local_37;
    local_120 = _e540;
    uint _e542 = local_38;
    uint _e544 = local_120[1];
    local_120[1] = (_e544 + _e542);
    uint _e548 = local_120[0];
    local_121 = uint(_e548);
    uint _e552 = local_120[1];
    local_122 = uint(_e552);
    uint _e555 = local_122;
    output_1.Store(_e555*4, asuint(uint(_e532)));
    amount_1 = ZeroValueint();
    old_1 = ZeroValueint();
    amount_1 = int(3);
    int _e563 = value;
    old_1 = _e563;
    int _e565 = amount_1;
    int _e566 = value;
    value = asint(asuint(_e566) + asuint(_e565));
    int _e568 = old_1;
    uint _e570[2] = output;
    local_39 = _e570;
    local_40 = uint((base + 19u));
    uint _e576[2] = local_39;
    local_123 = _e576;
    uint _e578 = local_40;
    uint _e580 = local_123[1];
    local_123[1] = (_e580 + _e578);
    uint _e584 = local_123[0];
    local_124 = uint(_e584);
    uint _e588 = local_123[1];
    local_125 = uint(_e588);
    uint _e591 = local_125;
    output_1.Store(_e591*4, asuint(uint(_e568)));
    local_41 = false;
    if (false) {
        amount_2 = ZeroValueint();
        old_2 = ZeroValueint();
        amount_2 = int(2);
        int _e601 = value;
        local_59 = _e601;
        int _e603 = local_59;
        old_2 = _e603;
        int _e605 = amount_2;
        int _e606 = value;
        local_60 = _e606;
        int _e608 = local_60;
        value = asint(asuint(_e608) + asuint(_e605));
        int _e610 = old_2;
        local_42 = _e610;
        int _e612 = local_42;
        local_41 = (_e612 != int(0));
    }
    local_43 = true;
    if (true) {
    } else {
        amount_3 = ZeroValueint();
        old_3 = ZeroValueint();
        amount_3 = int(2);
        int _e623 = value;
        local_61 = _e623;
        int _e625 = local_61;
        old_3 = _e625;
        int _e627 = amount_3;
        int _e628 = value;
        local_62 = _e628;
        int _e630 = local_62;
        value = asint(asuint(_e630) + asuint(_e627));
        int _e632 = old_3;
        local_44 = _e632;
        int _e634 = local_44;
        local_43 = (_e634 != int(0));
    }
    amount_4 = ZeroValueint();
    old_4 = ZeroValueint();
    amount_4 = int(2);
    int _e643 = value;
    old_4 = _e643;
    int _e645 = amount_4;
    int _e646 = value;
    value = asint(asuint(_e646) + asuint(_e645));
    int _e648 = value;
    uint _e650[2] = output;
    local_45 = _e650;
    local_46 = uint((base + 20u));
    uint _e656[2] = local_45;
    local_126 = _e656;
    uint _e658 = local_46;
    uint _e660 = local_126[1];
    local_126[1] = (_e660 + _e658);
    uint _e664 = local_126[0];
    local_127 = uint(_e664);
    uint _e668 = local_126[1];
    local_128 = uint(_e668);
    uint _e671 = local_128;
    output_1.Store(_e671*4, asuint(uint(_e648)));
    const uint _e673 = default_value_unsigned();
    const int _e674 = kind_1(_e673);
    uint _e676[2] = output;
    local_47 = _e676;
    local_48 = uint((base + 21u));
    uint _e682[2] = local_47;
    local_129 = _e682;
    uint _e684 = local_48;
    uint _e686 = local_129[1];
    local_129[1] = (_e686 + _e684);
    uint _e690 = local_129[0];
    local_130 = uint(_e690);
    uint _e694 = local_129[1];
    local_131 = uint(_e694);
    uint _e697 = local_131;
    output_1.Store(_e697*4, asuint(uint(_e674)));
    uint _e699[2] = input;
    local_51 = _e699;
    local_52 = uint(int(0));
    uint _e704[2] = local_51;
    local_132 = _e704;
    uint _e706 = local_52;
    uint _e708 = local_132[1];
    local_132[1] = (_e708 + _e706);
    uint _e712 = local_132[0];
    local_133 = uint(_e712);
    uint _e716 = local_132[1];
    local_134 = uint(_e716);
    uint _e719 = local_134;
    int _e721 = asint(input_2.Load(_e719*4));
    amount_5 = ZeroValueint();
    old_5 = ZeroValueint();
    amount_5 = _e721;
    int _e727 = value;
    old_5 = _e727;
    int _e729 = amount_5;
    int _e730 = value;
    value = asint(asuint(_e730) + asuint(_e729));
    int _e732 = old_5;
    uint _e734[2] = output;
    local_49 = _e734;
    local_50 = uint((base + 22u));
    uint _e740[2] = local_49;
    local_135 = _e740;
    uint _e742 = local_50;
    uint _e744 = local_135[1];
    local_135[1] = (_e744 + _e742);
    uint _e748 = local_135[0];
    local_136 = uint(_e748);
    uint _e752 = local_135[1];
    local_137 = uint(_e752);
    uint _e755 = local_137;
    output_1.Store(_e755*4, asuint(uint(_e732)));
    int _e757 = value;
    uint _e759[2] = output;
    local_53 = _e759;
    local_54 = uint((base + 23u));
    uint _e765[2] = local_53;
    local_138 = _e765;
    uint _e767 = local_54;
    uint _e769 = local_138[1];
    local_138[1] = (_e769 + _e767);
    uint _e773 = local_138[0];
    local_139 = uint(_e773);
    uint _e777 = local_138[1];
    local_140 = uint(_e777);
    uint _e780 = local_140;
    output_1.Store(_e780*4, asuint(uint(_e757)));
}
