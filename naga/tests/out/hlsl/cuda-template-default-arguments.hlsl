static const int Frozen_1 = int(3);

RWByteAddressBuffer output_1 : register(u0);
ByteAddressBuffer input_3 : register(t1);

int choose_template_default(bool value_3, int bias_1)
{
    return asint(asuint(asint(asuint(int(400)) + asuint(int(value_3)))) + asuint(bias_1));
}

int tied_template_default(int value_4, int bias_2)
{
    return asint(asuint(asint(asuint(int(400)) + asuint(value_4))) + asuint(bias_2));
}

int inner_template_default(int value_5, int extra)
{
    return asint(asuint(value_5) + asuint(extra));
}

int add_template_default_int(int renamed, int other)
{
    return asint(asuint(renamed) + asuint(other));
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int converted_template_default_int(int value_6, int bias_3, bool enabled, float scale)
{
    return asint(asuint(asint(asuint(asint(asuint(value_6) + asuint(bias_3))) + asuint(int(enabled)))) + asuint(naga_f2i32(scale)));
}

uint wrapped_template_default_int(uint value_7)
{
    return value_7;
}

int choose_template_default_int(int value_8, int bias_4)
{
    return asint(asuint(asint(asuint(int(300)) + asuint(value_8))) + asuint(bias_4));
}

int choose_template_default_bool(bool value_9, int bias_5)
{
    return asint(asuint(asint(asuint(int(300)) + asuint(int(value_9)))) + asuint(bias_5));
}

int tied_template_default_unsigned(uint value_10, int bias_6)
{
    return asint(asuint(asint(asuint(int(500)) + asuint(int(value_10)))) + asuint(bias_6));
}

int erased_template_default_5_(int result)
{
    return asint(asuint(result) + asuint(int(5)));
}

int add_template_default_unsigned(uint renamed_1, int other_1)
{
    return asint(asuint(int(renamed_1)) + asuint(other_1));
}

int conditional_template_default_int(int value_11, int count)
{
    return asint(asuint(value_11) + asuint(count));
}

int casted_template_default_int(int value_12, int count_1)
{
    return asint(asuint(value_12) + asuint(count_1));
}

int explicit_value_template_default_3_(int bias_7)
{
    const int _e2 = inner_template_default(bias_7, int(2));
    return asint(asuint(_e2) + asuint(int(3)));
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
void template_default_arguments(uint3 threadIdx : SV_GroupThreadID)
{
    uint output[2] = (uint[2])0;
    uint input[2] = (uint[2])0;
    int value = (int)0;
    int Frozen = (int)0;
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
    int local_16 = (int)0;
    uint local_17[2] = (uint[2])0;
    uint local_18 = (uint)0;
    uint local_19[2] = (uint[2])0;
    int local_20 = (int)0;
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
    uint local_32[2] = (uint[2])0;
    uint local_33 = (uint)0;
    int index = (int)0;
    uint local_34[2] = (uint[2])0;
    uint local_35 = (uint)0;
    uint local_36[2] = (uint[2])0;
    uint local_37 = (uint)0;
    bool local_38 = (bool)0;
    int local_39 = (int)0;
    bool local_40 = (bool)0;
    int local_41 = (int)0;
    int local_42 = (int)0;
    int local_43 = (int)0;
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
    uint local_55[2] = (uint[2])0;
    uint local_56 = (uint)0;
    uint local_57[2] = (uint[2])0;
    uint local_58 = (uint)0;
    uint value_1[2] = (uint[2])0;
    uint local_59[2] = (uint[2])0;
    int local_60 = (int)0;
    uint value_2[2] = (uint[2])0;
    int bias = (int)0;
    uint local_61[2] = (uint[2])0;
    int local_62 = (int)0;
    int step_ = (int)0;
    int old = (int)0;
    int step_1 = (int)0;
    int old_1 = (int)0;
    uint input_1[2] = (uint[2])0;
    int index_1 = (int)0;
    uint local_63[2] = (uint[2])0;
    uint local_64 = (uint)0;
    int local_65 = (int)0;
    uint input_2[2] = (uint[2])0;
    int index_2 = (int)0;
    uint local_66[2] = (uint[2])0;
    uint local_67 = (uint)0;
    int local_68 = (int)0;
    int step_2 = (int)0;
    int old_2 = (int)0;
    int local_69 = (int)0;
    int local_70 = (int)0;
    int step_3 = (int)0;
    int old_3 = (int)0;
    int local_71 = (int)0;
    int local_72 = (int)0;
    int step_4 = (int)0;
    int old_4 = (int)0;
    int local_73 = (int)0;
    int local_74 = (int)0;
    int step_5 = (int)0;
    int old_5 = (int)0;
    int local_75 = (int)0;
    int local_76 = (int)0;
    int step_6 = (int)0;
    int old_6 = (int)0;
    uint local_77[2] = (uint[2])0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    uint local_80[2] = (uint[2])0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    uint local_83[2] = (uint[2])0;
    uint local_84 = (uint)0;
    uint local_85 = (uint)0;
    uint local_86[2] = (uint[2])0;
    uint local_87 = (uint)0;
    uint local_88 = (uint)0;
    uint local_89[2] = (uint[2])0;
    uint local_90 = (uint)0;
    uint local_91 = (uint)0;
    uint local_92[2] = (uint[2])0;
    uint local_93 = (uint)0;
    uint local_94 = (uint)0;
    uint local_95[2] = (uint[2])0;
    uint local_96 = (uint)0;
    uint local_97 = (uint)0;
    uint local_98[2] = (uint[2])0;
    uint local_99 = (uint)0;
    uint local_100 = (uint)0;
    uint local_101[2] = (uint[2])0;
    uint local_102 = (uint)0;
    uint local_103 = (uint)0;
    uint local_104[2] = (uint[2])0;
    uint local_105 = (uint)0;
    uint local_106 = (uint)0;
    uint local_107[2] = (uint[2])0;
    uint local_108 = (uint)0;
    uint local_109 = (uint)0;
    uint local_110[2] = (uint[2])0;
    uint local_111 = (uint)0;
    uint local_112 = (uint)0;
    uint local_113[2] = (uint[2])0;
    uint local_114 = (uint)0;
    uint local_115 = (uint)0;
    uint local_116[2] = (uint[2])0;
    uint local_117 = (uint)0;
    uint local_118 = (uint)0;
    uint local_119[2] = (uint[2])0;
    uint local_120 = (uint)0;
    uint local_121 = (uint)0;
    uint local_122[2] = (uint[2])0;
    uint local_123 = (uint)0;
    uint local_124 = (uint)0;
    uint local_125[2] = (uint[2])0;
    uint local_126 = (uint)0;
    uint local_127 = (uint)0;
    uint local_128[2] = (uint[2])0;
    uint local_129 = (uint)0;
    uint local_130 = (uint)0;
    uint local_131[2] = (uint[2])0;
    uint local_132 = (uint)0;
    uint local_133 = (uint)0;
    uint local_134[2] = (uint[2])0;
    uint local_135 = (uint)0;
    uint local_136 = (uint)0;
    uint local_137[2] = (uint[2])0;
    uint local_138 = (uint)0;
    uint local_139 = (uint)0;
    uint local_140[2] = (uint[2])0;
    uint local_141 = (uint)0;
    uint local_142 = (uint)0;
    uint local_143[2] = (uint[2])0;
    uint local_144 = (uint)0;
    uint local_145 = (uint)0;
    uint local_146[2] = (uint[2])0;
    uint local_147 = (uint)0;
    uint local_148 = (uint)0;
    uint local_149[2] = (uint[2])0;
    uint local_150 = (uint)0;
    uint local_151 = (uint)0;
    uint local_152[2] = (uint[2])0;
    uint local_153 = (uint)0;
    uint local_154 = (uint)0;
    uint local_155[2] = (uint[2])0;
    uint local_156 = (uint)0;
    uint local_157 = (uint)0;

    output = ZeroValuearray2_uint_();
    output[0] = 2u;
    output[1] = 0u;
    input = ZeroValuearray2_uint_();
    input[0] = 3u;
    input[1] = 0u;
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 23u));
    value = asint(asuint(int(lane)) + asuint(int(1)));
    Frozen = int(99);
    int _e24 = value;
    const int _e26 = add_template_default_int(_e24, int(3));
    uint _e29[2] = output;
    local = _e29;
    uint _e31[2] = local;
    local_77 = _e31;
    uint _e34 = local_77[1];
    local_77[1] = (_e34 + base);
    uint _e38 = local_77[0];
    local_78 = uint(_e38);
    uint _e42 = local_77[1];
    local_79 = uint(_e42);
    uint _e45 = local_79;
    output_1.Store(_e45*4, asuint(uint(_e26)));
    int _e48 = value;
    const int _e50 = add_template_default_int(_e48, int(9));
    uint _e52[2] = output;
    local_1 = _e52;
    local_2 = uint((base + 1u));
    uint _e58[2] = local_1;
    local_80 = _e58;
    uint _e60 = local_2;
    uint _e62 = local_80[1];
    local_80[1] = (_e62 + _e60);
    uint _e66 = local_80[0];
    local_81 = uint(_e66);
    uint _e70 = local_80[1];
    local_82 = uint(_e70);
    uint _e73 = local_82;
    output_1.Store(_e73*4, asuint(uint(_e50)));
    int _e75 = value;
    const int _e79 = converted_template_default_int(_e75, int(3), true, 2.0);
    uint _e81[2] = output;
    local_3 = _e81;
    local_4 = uint((base + 2u));
    uint _e87[2] = local_3;
    local_83 = _e87;
    uint _e89 = local_4;
    uint _e91 = local_83[1];
    local_83[1] = (_e91 + _e89);
    uint _e95 = local_83[0];
    local_84 = uint(_e95);
    uint _e99 = local_83[1];
    local_85 = uint(_e99);
    uint _e102 = local_85;
    output_1.Store(_e102*4, asuint(uint(_e79)));
    const uint _e105 = wrapped_template_default_int(4294967295u);
    uint _e106[2] = output;
    local_5 = _e106;
    local_6 = uint((base + 3u));
    uint _e112[2] = local_5;
    local_86 = _e112;
    uint _e114 = local_6;
    uint _e116 = local_86[1];
    local_86[1] = (_e116 + _e114);
    uint _e120 = local_86[0];
    local_87 = uint(_e120);
    uint _e124 = local_86[1];
    local_88 = uint(_e124);
    uint _e127 = local_88;
    output_1.Store(_e127*4, asuint(_e105));
    const int _e131 = choose_template_default(true, int(4));
    uint _e133[2] = output;
    local_7 = _e133;
    local_8 = uint((base + 4u));
    uint _e139[2] = local_7;
    local_89 = _e139;
    uint _e141 = local_8;
    uint _e143 = local_89[1];
    local_89[1] = (_e143 + _e141);
    uint _e147 = local_89[0];
    local_90 = uint(_e147);
    uint _e151 = local_89[1];
    local_91 = uint(_e151);
    uint _e154 = local_91;
    output_1.Store(_e154*4, asuint(uint(_e131)));
    const int _e158 = choose_template_default_int(int(1), int(3));
    uint _e160[2] = output;
    local_9 = _e160;
    local_10 = uint((base + 5u));
    uint _e166[2] = local_9;
    local_92 = _e166;
    uint _e168 = local_10;
    uint _e170 = local_92[1];
    local_92[1] = (_e170 + _e168);
    uint _e174 = local_92[0];
    local_93 = uint(_e174);
    uint _e178 = local_92[1];
    local_94 = uint(_e178);
    uint _e181 = local_94;
    output_1.Store(_e181*4, asuint(uint(_e158)));
    const int _e185 = choose_template_default_bool(true, int(3));
    uint _e187[2] = output;
    local_11 = _e187;
    local_12 = uint((base + 6u));
    uint _e193[2] = local_11;
    local_95 = _e193;
    uint _e195 = local_12;
    uint _e197 = local_95[1];
    local_95[1] = (_e197 + _e195);
    uint _e201 = local_95[0];
    local_96 = uint(_e201);
    uint _e205 = local_95[1];
    local_97 = uint(_e205);
    uint _e208 = local_97;
    output_1.Store(_e208*4, asuint(uint(_e185)));
    uint _e211[2] = input;
    local_15 = _e211;
    local_60 = ZeroValueint();
    uint _e215[2] = local_15;
    value_1 = _e215;
    uint _e218[2] = value_1;
    local_59 = _e218;
    uint _e220[2] = local_59;
    local_98 = _e220;
    uint _e223 = local_98[0];
    local_99 = uint(_e223);
    uint _e227 = local_98[1];
    local_100 = uint(_e227);
    uint _e230 = local_100;
    int _e233 = asint(input_3.Load(_e230*4));
    local_60 = _e233;
    int _e235 = local_60;
    local_16 = asint(asuint(int(200)) + asuint(_e235));
    int _e239 = local_16;
    uint _e241[2] = output;
    local_13 = _e241;
    local_14 = uint((base + 7u));
    uint _e247[2] = local_13;
    local_101 = _e247;
    uint _e249 = local_14;
    uint _e251 = local_101[1];
    local_101[1] = (_e251 + _e249);
    uint _e255 = local_101[0];
    local_102 = uint(_e255);
    uint _e259 = local_101[1];
    local_103 = uint(_e259);
    uint _e262 = local_103;
    output_1.Store(_e262*4, asuint(uint(_e239)));
    uint _e264[2] = input;
    local_19 = _e264;
    bias = ZeroValueint();
    local_62 = ZeroValueint();
    uint _e270[2] = local_19;
    value_2 = _e270;
    bias = int(4);
    uint _e275[2] = value_2;
    local_61 = _e275;
    uint _e277[2] = local_61;
    local_104 = _e277;
    uint _e280 = local_104[0];
    local_105 = uint(_e280);
    uint _e284 = local_104[1];
    local_106 = uint(_e284);
    uint _e287 = local_106;
    int _e289 = asint(input_3.Load(_e287*4));
    local_62 = _e289;
    int _e291 = local_62;
    int _e294 = bias;
    local_20 = asint(asuint(asint(asuint(int(200)) + asuint(_e291))) + asuint(_e294));
    int _e297 = local_20;
    uint _e299[2] = output;
    local_17 = _e299;
    local_18 = uint((base + 8u));
    uint _e305[2] = local_17;
    local_107 = _e305;
    uint _e307 = local_18;
    uint _e309 = local_107[1];
    local_107[1] = (_e309 + _e307);
    uint _e313 = local_107[0];
    local_108 = uint(_e313);
    uint _e317 = local_107[1];
    local_109 = uint(_e317);
    uint _e320 = local_109;
    output_1.Store(_e320*4, asuint(uint(_e297)));
    const int _e324 = tied_template_default(int(1), int(2));
    uint _e326[2] = output;
    local_21 = _e326;
    local_22 = uint((base + 9u));
    uint _e332[2] = local_21;
    local_110 = _e332;
    uint _e334 = local_22;
    uint _e336 = local_110[1];
    local_110[1] = (_e336 + _e334);
    uint _e340 = local_110[0];
    local_111 = uint(_e340);
    uint _e344 = local_110[1];
    local_112 = uint(_e344);
    uint _e347 = local_112;
    output_1.Store(_e347*4, asuint(uint(_e324)));
    const int _e351 = tied_template_default_unsigned(1u, int(3));
    uint _e353[2] = output;
    local_23 = _e353;
    local_24 = uint((base + 10u));
    uint _e359[2] = local_23;
    local_113 = _e359;
    uint _e361 = local_24;
    uint _e363 = local_113[1];
    local_113[1] = (_e363 + _e361);
    uint _e367 = local_113[0];
    local_114 = uint(_e367);
    uint _e371 = local_113[1];
    local_115 = uint(_e371);
    uint _e374 = local_115;
    output_1.Store(_e374*4, asuint(uint(_e351)));
    step_ = ZeroValueint();
    old = ZeroValueint();
    step_ = int(2);
    int _e382 = value;
    old = _e382;
    int _e384 = step_;
    int _e385 = value;
    value = asint(asuint(_e385) + asuint(_e384));
    int _e387 = old;
    uint _e389[2] = output;
    local_25 = _e389;
    local_26 = uint((base + 11u));
    uint _e395[2] = local_25;
    local_116 = _e395;
    uint _e397 = local_26;
    uint _e399 = local_116[1];
    local_116[1] = (_e399 + _e397);
    uint _e403 = local_116[0];
    local_117 = uint(_e403);
    uint _e407 = local_116[1];
    local_118 = uint(_e407);
    uint _e410 = local_118;
    output_1.Store(_e410*4, asuint(uint(_e387)));
    step_1 = ZeroValueint();
    old_1 = ZeroValueint();
    step_1 = int(5);
    int _e418 = value;
    old_1 = _e418;
    int _e420 = step_1;
    int _e421 = value;
    value = asint(asuint(_e421) + asuint(_e420));
    int _e423 = old_1;
    uint _e425[2] = output;
    local_27 = _e425;
    local_28 = uint((base + 12u));
    uint _e431[2] = local_27;
    local_119 = _e431;
    uint _e433 = local_28;
    uint _e435 = local_119[1];
    local_119[1] = (_e435 + _e433);
    uint _e439 = local_119[0];
    local_120 = uint(_e439);
    uint _e443 = local_119[1];
    local_121 = uint(_e443);
    uint _e446 = local_121;
    output_1.Store(_e446*4, asuint(uint(_e423)));
    uint _e448[2] = input;
    local_31 = _e448;
    index_1 = ZeroValueint();
    local_64 = ZeroValueuint();
    local_65 = ZeroValueint();
    uint _e456[2] = local_31;
    input_1 = _e456;
    index_1 = int(1);
    uint _e461[2] = input_1;
    local_63 = _e461;
    int _e463 = index_1;
    local_64 = uint(_e463);
    uint _e466[2] = local_63;
    local_122 = _e466;
    uint _e468 = local_64;
    uint _e470 = local_122[1];
    local_122[1] = (_e470 + _e468);
    uint _e474 = local_122[0];
    local_123 = uint(_e474);
    uint _e478 = local_122[1];
    local_124 = uint(_e478);
    uint _e481 = local_124;
    int _e483 = asint(input_3.Load(_e481*4));
    local_65 = _e483;
    int _e485 = local_65;
    uint _e487[2] = output;
    local_29 = _e487;
    local_30 = uint((base + 13u));
    uint _e493[2] = local_29;
    local_125 = _e493;
    uint _e495 = local_30;
    uint _e497 = local_125[1];
    local_125[1] = (_e497 + _e495);
    uint _e501 = local_125[0];
    local_126 = uint(_e501);
    uint _e505 = local_125[1];
    local_127 = uint(_e505);
    uint _e508 = local_127;
    output_1.Store(_e508*4, asuint(uint(_e485)));
    const int _e511 = erased_template_default_5_(int(7));
    uint _e513[2] = output;
    local_32 = _e513;
    local_33 = uint((base + 14u));
    uint _e519[2] = local_32;
    local_128 = _e519;
    uint _e521 = local_33;
    uint _e523 = local_128[1];
    local_128[1] = (_e523 + _e521);
    uint _e527 = local_128[0];
    local_129 = uint(_e527);
    uint _e531 = local_128[1];
    local_130 = uint(_e531);
    uint _e534 = local_130;
    output_1.Store(_e534*4, asuint(uint(_e511)));
    index = int(0);
    uint _e538[2] = input;
    local_36 = _e538;
    int _e540 = index;
    index = asint(asuint(_e540) + asuint(int(1)));
    local_37 = uint(_e540);
    index_2 = ZeroValueint();
    local_67 = ZeroValueuint();
    local_68 = ZeroValueint();
    uint _e551[2] = local_36;
    input_2 = _e551;
    uint _e553 = local_37;
    uint _e555 = input_2[1];
    input_2[1] = (_e555 + _e553);
    index_2 = int(1);
    uint _e561[2] = input_2;
    local_66 = _e561;
    int _e563 = index_2;
    local_67 = uint(_e563);
    uint _e566[2] = local_66;
    local_131 = _e566;
    uint _e568 = local_67;
    uint _e570 = local_131[1];
    local_131[1] = (_e570 + _e568);
    uint _e574 = local_131[0];
    local_132 = uint(_e574);
    uint _e578 = local_131[1];
    local_133 = uint(_e578);
    uint _e581 = local_133;
    int _e583 = asint(input_3.Load(_e581*4));
    local_68 = _e583;
    int _e585 = local_68;
    uint _e587[2] = output;
    local_34 = _e587;
    local_35 = uint((base + 15u));
    uint _e593[2] = local_34;
    local_134 = _e593;
    uint _e595 = local_35;
    uint _e597 = local_134[1];
    local_134[1] = (_e597 + _e595);
    uint _e601 = local_134[0];
    local_135 = uint(_e601);
    uint _e605 = local_134[1];
    local_136 = uint(_e605);
    uint _e608 = local_136;
    output_1.Store(_e608*4, asuint(uint(_e585)));
    local_38 = false;
    if (false) {
        step_2 = ZeroValueint();
        old_2 = ZeroValueint();
        step_2 = int(2);
        int _e618 = value;
        local_69 = _e618;
        int _e620 = local_69;
        old_2 = _e620;
        int _e622 = step_2;
        int _e623 = value;
        local_70 = _e623;
        int _e625 = local_70;
        value = asint(asuint(_e625) + asuint(_e622));
        int _e627 = old_2;
        local_39 = _e627;
        int _e629 = local_39;
        local_38 = (_e629 != int(0));
    }
    local_40 = true;
    if (true) {
    } else {
        step_3 = ZeroValueint();
        old_3 = ZeroValueint();
        step_3 = int(2);
        int _e640 = value;
        local_71 = _e640;
        int _e642 = local_71;
        old_3 = _e642;
        int _e644 = step_3;
        int _e645 = value;
        local_72 = _e645;
        int _e647 = local_72;
        value = asint(asuint(_e647) + asuint(_e644));
        int _e649 = old_3;
        local_41 = _e649;
        int _e651 = local_41;
        local_40 = (_e651 != int(0));
    }
    if (((lane & 1u) == 0u)) {
        step_4 = ZeroValueint();
        old_4 = ZeroValueint();
        step_4 = int(2);
        int _e664 = value;
        local_73 = _e664;
        int _e666 = local_73;
        old_4 = _e666;
        int _e668 = step_4;
        int _e669 = value;
        local_74 = _e669;
        int _e671 = local_74;
        value = asint(asuint(_e671) + asuint(_e668));
        int _e673 = old_4;
        local_42 = _e673;
        int _e675 = local_42;
        local_44 = _e675;
    } else {
        step_5 = ZeroValueint();
        old_5 = ZeroValueint();
        step_5 = int(3);
        int _e683 = value;
        local_75 = _e683;
        int _e685 = local_75;
        old_5 = _e685;
        int _e687 = step_5;
        int _e688 = value;
        local_76 = _e688;
        int _e690 = local_76;
        value = asint(asuint(_e690) + asuint(_e687));
        int _e692 = old_5;
        local_43 = _e692;
        int _e694 = local_43;
        local_44 = _e694;
    }
    step_6 = ZeroValueint();
    old_6 = ZeroValueint();
    step_6 = int(2);
    int _e702 = value;
    old_6 = _e702;
    int _e704 = step_6;
    int _e705 = value;
    value = asint(asuint(_e705) + asuint(_e704));
    int _e707 = value;
    uint _e709[2] = output;
    local_45 = _e709;
    local_46 = uint((base + 16u));
    uint _e715[2] = local_45;
    local_137 = _e715;
    uint _e717 = local_46;
    uint _e719 = local_137[1];
    local_137[1] = (_e719 + _e717);
    uint _e723 = local_137[0];
    local_138 = uint(_e723);
    uint _e727 = local_137[1];
    local_139 = uint(_e727);
    uint _e730 = local_139;
    output_1.Store(_e730*4, asuint(uint(_e707)));
    int _e732 = index;
    uint _e734[2] = output;
    local_47 = _e734;
    local_48 = uint((base + 17u));
    uint _e740[2] = local_47;
    local_140 = _e740;
    uint _e742 = local_48;
    uint _e744 = local_140[1];
    local_140[1] = (_e744 + _e742);
    uint _e748 = local_140[0];
    local_141 = uint(_e748);
    uint _e752 = local_140[1];
    local_142 = uint(_e752);
    uint _e755 = local_142;
    output_1.Store(_e755*4, asuint(uint(_e732)));
    const int _e759 = add_template_default_int(int(0), int(3));
    uint _e761[2] = output;
    local_49 = _e761;
    local_50 = uint((base + 18u));
    uint _e767[2] = local_49;
    local_143 = _e767;
    uint _e769 = local_50;
    uint _e771 = local_143[1];
    local_143[1] = (_e771 + _e769);
    uint _e775 = local_143[0];
    local_144 = uint(_e775);
    uint _e779 = local_143[1];
    local_145 = uint(_e779);
    uint _e782 = local_145;
    output_1.Store(_e782*4, asuint(uint(_e759)));
    const int _e786 = add_template_default_unsigned(2u, int(3));
    uint _e788[2] = output;
    local_51 = _e788;
    local_52 = uint((base + 19u));
    uint _e794[2] = local_51;
    local_146 = _e794;
    uint _e796 = local_52;
    uint _e798 = local_146[1];
    local_146[1] = (_e798 + _e796);
    uint _e802 = local_146[0];
    local_147 = uint(_e802);
    uint _e806 = local_146[1];
    local_148 = uint(_e806);
    uint _e809 = local_148;
    output_1.Store(_e809*4, asuint(uint(_e786)));
    const int _e813 = conditional_template_default_int(int(1), int(2));
    uint _e815[2] = output;
    local_53 = _e815;
    local_54 = uint((base + 20u));
    uint _e821[2] = local_53;
    local_149 = _e821;
    uint _e823 = local_54;
    uint _e825 = local_149[1];
    local_149[1] = (_e825 + _e823);
    uint _e829 = local_149[0];
    local_150 = uint(_e829);
    uint _e833 = local_149[1];
    local_151 = uint(_e833);
    uint _e836 = local_151;
    output_1.Store(_e836*4, asuint(uint(_e813)));
    const int _e840 = casted_template_default_int(int(1), int(3));
    uint _e842[2] = output;
    local_55 = _e842;
    local_56 = uint((base + 21u));
    uint _e848[2] = local_55;
    local_152 = _e848;
    uint _e850 = local_56;
    uint _e852 = local_152[1];
    local_152[1] = (_e852 + _e850);
    uint _e856 = local_152[0];
    local_153 = uint(_e856);
    uint _e860 = local_152[1];
    local_154 = uint(_e860);
    uint _e863 = local_154;
    output_1.Store(_e863*4, asuint(uint(_e840)));
    const int _e866 = explicit_value_template_default_3_(int(7));
    uint _e868[2] = output;
    local_57 = _e868;
    local_58 = uint((base + 22u));
    uint _e874[2] = local_57;
    local_155 = _e874;
    uint _e876 = local_58;
    uint _e878 = local_155[1];
    local_155[1] = (_e878 + _e876);
    uint _e882 = local_155[0];
    local_156 = uint(_e882);
    uint _e886 = local_155[1];
    local_157 = uint(_e886);
    uint _e889 = local_157;
    output_1.Store(_e889*4, asuint(uint(_e866)));
}
