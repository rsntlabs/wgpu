struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_1 : register(u0);
ByteAddressBuffer input_a_1 : register(t1);
ByteAddressBuffer input_b_1 : register(t2);
cbuffer n_1 : register(b3) { type_3 n_1; }
groupshared int shared_values[64];

int shifted(int value_1)
{
    int value_2 = (int)0;

    value_2 = value_1;
    int _e3 = value_2;
    return asint(asuint(_e3) + asuint(int(10)));
}

void discard_(int value_3)
{
    int value_4 = (int)0;

    value_4 = value_3;
    int _e3 = value_4;
    value_4 = asint(asuint(_e3) + asuint(int(1)));
    return;
}

int pair(int x, int y)
{
    int x_1 = (int)0;
    int y_1 = (int)0;

    x_1 = x;
    y_1 = y;
    int _e5 = x_1;
    int _e7 = y_1;
    return asint(asuint(asint(asuint(_e5) * asuint(int(10)))) + asuint(_e7));
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(64, 1, 1)]
void conditionals(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        shared_values = (int[64])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint out_[2] = (uint[2])0;
    uint input_a[2] = (uint[2])0;
    uint input_b[2] = (uint[2])0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint base = (uint)0;
    bool choose_a = (bool)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    int local_6 = (int)0;
    int a = (int)0;
    int b = (int)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    int local_9 = (int)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    int index_a = (int)0;
    int index_b = (int)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    int local_26 = (int)0;
    uint local_27[2] = (uint[2])0;
    uint local_28 = (uint)0;
    int local_29 = (int)0;
    uint local_30[2] = (uint[2])0;
    uint local_31 = (uint)0;
    int c = (int)0;
    uint local_32[2] = (uint[2])0;
    uint local_33 = (uint)0;
    int local_34 = (int)0;
    uint local_35[2] = (uint[2])0;
    uint local_36 = (uint)0;
    int condition = (int)0;
    uint local_37[2] = (uint[2])0;
    uint local_38 = (uint)0;
    uint local_39[2] = (uint[2])0;
    uint local_40 = (uint)0;
    uint lane = (uint)0;
    int local_value = (int)0;
    uint local_41[2] = (uint[2])0;
    uint local_42 = (uint)0;
    uint local_43[2] = (uint[2])0;
    uint local_44 = (uint)0;
    uint local_45[2] = (uint[2])0;
    uint local_46 = (uint)0;
    uint local_47[2] = (uint[2])0;
    uint local_48 = (uint)0;
    float local_49 = (float)0;
    uint local_50[2] = (uint[2])0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53[2] = (uint[2])0;
    uint local_54 = (uint)0;
    bool local_55 = (bool)0;
    uint local_56[2] = (uint[2])0;
    uint local_57 = (uint)0;
    int local_58 = (int)0;
    uint local_59[2] = (uint[2])0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    int shift_value = (int)0;
    uint local_62[2] = (uint[2])0;
    uint local_63 = (uint)0;
    int local_64 = (int)0;
    uint local_65 = (uint)0;
    int value = (int)0;
    int other = (int)0;
    uint local_66[2] = (uint[2])0;
    uint local_67 = (uint)0;
    int local_68 = (int)0;
    int count = (int)0;
    int left = (int)0;
    int right = (int)0;
    uint local_69[2] = (uint[2])0;
    uint local_70 = (uint)0;
    int local_71 = (int)0;
    int local_72 = (int)0;
    uint local_73[2] = (uint[2])0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    int local_76 = (int)0;
    uint local_77[2] = (uint[2])0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    int local_80 = (int)0;
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
    uint local_141[2] = (uint[2])0;
    uint local_142 = (uint)0;
    uint local_143 = (uint)0;
    uint local_144[2] = (uint[2])0;
    uint local_145 = (uint)0;
    uint local_146 = (uint)0;
    uint local_147[2] = (uint[2])0;
    uint local_148 = (uint)0;
    uint local_149 = (uint)0;
    uint local_150[2] = (uint[2])0;
    uint local_151 = (uint)0;
    uint local_152 = (uint)0;
    uint local_153[2] = (uint[2])0;
    uint local_154 = (uint)0;
    uint local_155 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    input_a = ZeroValuearray2_uint_();
    input_a[0] = 1u;
    input_a[1] = 0u;
    input_b = ZeroValuearray2_uint_();
    input_b[0] = 2u;
    input_b[1] = 0u;
    uint _e25 = n_1.value;
    n = _e25;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e33 = i;
    uint _e34 = n;
    if ((_e33 < _e34)) {
        uint _e36 = i;
        base = (_e36 * 25u);
        uint _e40 = i;
        choose_a = (naga_mod(_e40, 2u) == 0u);
        bool _e46 = choose_a;
        if (_e46) {
            uint _e49[2] = input_a;
            local_2 = _e49;
            uint _e50 = i;
            local_3 = uint(_e50);
            uint _e54[2] = local_2;
            local_73 = _e54;
            uint _e55 = local_3;
            uint _e57 = local_73[1];
            local_73[1] = (_e57 + _e55);
            uint _e61 = local_73[0];
            local_74 = uint(_e61);
            uint _e65 = local_73[1];
            local_75 = uint(_e65);
            uint _e69 = local_75;
            int _e71 = asint(input_a_1.Load(_e69*4));
            local_76 = _e71;
            int _e72 = local_76;
            local_71 = _e72;
            int _e74 = local_71;
            local_6 = _e74;
        } else {
            uint _e78[2] = input_b;
            local_4 = _e78;
            uint _e79 = i;
            local_5 = uint(_e79);
            uint _e83[2] = local_4;
            local_77 = _e83;
            uint _e84 = local_5;
            uint _e86 = local_77[1];
            local_77[1] = (_e86 + _e84);
            uint _e90 = local_77[0];
            local_78 = uint(_e90);
            uint _e94 = local_77[1];
            local_79 = uint(_e94);
            uint _e98 = local_79;
            int _e100 = asint(input_b_1.Load(_e98*4));
            local_80 = _e100;
            int _e101 = local_80;
            local_72 = _e101;
            int _e103 = local_72;
            local_6 = _e103;
        }
        int _e106 = local_6;
        uint _e109[2] = out_;
        local = _e109;
        uint _e110 = base;
        local_1 = uint(_e110);
        uint _e114[2] = local;
        local_81 = _e114;
        uint _e115 = local_1;
        uint _e117 = local_81[1];
        local_81[1] = (_e117 + _e115);
        uint _e121 = local_81[0];
        local_82 = uint(_e121);
        uint _e125 = local_81[1];
        local_83 = uint(_e125);
        uint _e128 = local_83;
        out_1.Store(_e128*4, asuint(_e106));
        a = int(3);
        b = int(5);
        bool _e134 = choose_a;
        if (_e134) {
            int _e135 = a;
            a = asint(asuint(_e135) + asuint(int(1)));
            const int _e138 = shifted(_e135);
            local_9 = _e138;
        } else {
            int _e140 = b;
            b = asint(asuint(_e140) + asuint(int(1)));
            const int _e143 = shifted(_e140);
            local_9 = _e143;
        }
        int _e146 = local_9;
        uint _e148[2] = out_;
        local_7 = _e148;
        uint _e149 = base;
        local_8 = uint((_e149 + 1u));
        uint _e155[2] = local_7;
        local_84 = _e155;
        uint _e156 = local_8;
        uint _e158 = local_84[1];
        local_84[1] = (_e158 + _e156);
        uint _e162 = local_84[0];
        local_85 = uint(_e162);
        uint _e166 = local_84[1];
        local_86 = uint(_e166);
        uint _e169 = local_86;
        out_1.Store(_e169*4, asuint(_e146));
        int _e171 = a;
        int _e174 = b;
        uint _e177[2] = out_;
        local_10 = _e177;
        uint _e178 = base;
        local_11 = uint((_e178 + 2u));
        uint _e184[2] = local_10;
        local_87 = _e184;
        uint _e185 = local_11;
        uint _e187 = local_87[1];
        local_87[1] = (_e187 + _e185);
        uint _e191 = local_87[0];
        local_88 = uint(_e191);
        uint _e195 = local_87[1];
        local_89 = uint(_e195);
        uint _e198 = local_89;
        out_1.Store(_e198*4, asuint(asint(asuint(asint(asuint(_e171) * asuint(int(10)))) + asuint(_e174))));
        bool _e200 = choose_a;
        if (_e200) {
            int _e201 = a;
            a = asint(asuint(_e201) + asuint(int(1)));
            discard_(_e201);
        } else {
            int _e204 = b;
            b = asint(asuint(_e204) + asuint(int(1)));
            discard_(_e204);
        }
        int _e207 = a;
        int _e210 = b;
        uint _e213[2] = out_;
        local_12 = _e213;
        uint _e214 = base;
        local_13 = uint((_e214 + 3u));
        uint _e220[2] = local_12;
        local_90 = _e220;
        uint _e221 = local_13;
        uint _e223 = local_90[1];
        local_90[1] = (_e223 + _e221);
        uint _e227 = local_90[0];
        local_91 = uint(_e227);
        uint _e231 = local_90[1];
        local_92 = uint(_e231);
        uint _e234 = local_92;
        out_1.Store(_e234*4, asuint(asint(asuint(asint(asuint(_e207) * asuint(int(10)))) + asuint(_e210))));
        index_a = int(0);
        index_b = int(0);
        bool _e240 = choose_a;
        if (_e240) {
            uint _e243[2] = input_a;
            local_14 = _e243;
            int _e244 = index_a;
            index_a = asint(asuint(_e244) + asuint(int(1)));
            local_15 = uint(_e244);
        } else {
            uint _e251[2] = input_b;
            local_16 = _e251;
            int _e252 = index_b;
            index_b = asint(asuint(_e252) + asuint(int(1)));
            local_17 = uint(_e252);
        }
        int _e257 = index_a;
        int _e260 = index_b;
        uint _e263[2] = out_;
        local_18 = _e263;
        uint _e264 = base;
        local_19 = uint((_e264 + 4u));
        uint _e270[2] = local_18;
        local_93 = _e270;
        uint _e271 = local_19;
        uint _e273 = local_93[1];
        local_93[1] = (_e273 + _e271);
        uint _e277 = local_93[0];
        local_94 = uint(_e277);
        uint _e281 = local_93[1];
        local_95 = uint(_e281);
        uint _e284 = local_95;
        out_1.Store(_e284*4, asuint(asint(asuint(asint(asuint(_e257) * asuint(int(10)))) + asuint(_e260))));
        a = int(3);
        b = int(5);
        bool _e288 = choose_a;
        if (_e288) {
            a = int(7);
        } else {
            b = int(7);
        }
        int _e291 = a;
        int _e294 = b;
        uint _e297[2] = out_;
        local_20 = _e297;
        uint _e298 = base;
        local_21 = uint((_e298 + 5u));
        uint _e304[2] = local_20;
        local_96 = _e304;
        uint _e305 = local_21;
        uint _e307 = local_96[1];
        local_96[1] = (_e307 + _e305);
        uint _e311 = local_96[0];
        local_97 = uint(_e311);
        uint _e315 = local_96[1];
        local_98 = uint(_e315);
        uint _e318 = local_98;
        out_1.Store(_e318*4, asuint(asint(asuint(asint(asuint(_e291) * asuint(int(10)))) + asuint(_e294))));
        bool _e320 = choose_a;
        if (_e320) {
            int _e321 = a;
            a = asint(asuint(_e321) + asuint(int(2)));
        } else {
            int _e324 = b;
            b = asint(asuint(_e324) + asuint(int(2)));
        }
        int _e327 = a;
        int _e330 = b;
        uint _e333[2] = out_;
        local_22 = _e333;
        uint _e334 = base;
        local_23 = uint((_e334 + 6u));
        uint _e340[2] = local_22;
        local_99 = _e340;
        uint _e341 = local_23;
        uint _e343 = local_99[1];
        local_99[1] = (_e343 + _e341);
        uint _e347 = local_99[0];
        local_100 = uint(_e347);
        uint _e351 = local_99[1];
        local_101 = uint(_e351);
        uint _e354 = local_101;
        out_1.Store(_e354*4, asuint(asint(asuint(asint(asuint(_e327) * asuint(int(10)))) + asuint(_e330))));
        bool _e356 = choose_a;
        if (_e356) {
            int _e357 = a;
            a = asint(asuint(_e357) + asuint(int(1)));
            int _e360 = a;
            local_26 = _e360;
        } else {
            int _e362 = b;
            b = asint(asuint(_e362) + asuint(int(1)));
            int _e365 = b;
            local_26 = _e365;
        }
        int _e368 = local_26;
        uint _e370[2] = out_;
        local_24 = _e370;
        uint _e371 = base;
        local_25 = uint((_e371 + 7u));
        uint _e377[2] = local_24;
        local_102 = _e377;
        uint _e378 = local_25;
        uint _e380 = local_102[1];
        local_102[1] = (_e380 + _e378);
        uint _e384 = local_102[0];
        local_103 = uint(_e384);
        uint _e388 = local_102[1];
        local_104 = uint(_e388);
        uint _e391 = local_104;
        out_1.Store(_e391*4, asuint(_e368));
        bool _e393 = choose_a;
        if (_e393) {
            int _e394 = a;
            a = asint(asuint(_e394) + asuint(int(1)));
            local_29 = _e394;
        } else {
            int _e398 = b;
            b = asint(asuint(_e398) + asuint(int(1)));
            local_29 = _e398;
        }
        int _e403 = local_29;
        uint _e405[2] = out_;
        local_27 = _e405;
        uint _e406 = base;
        local_28 = uint((_e406 + 8u));
        uint _e412[2] = local_27;
        local_105 = _e412;
        uint _e413 = local_28;
        uint _e415 = local_105[1];
        local_105[1] = (_e415 + _e413);
        uint _e419 = local_105[0];
        local_106 = uint(_e419);
        uint _e423 = local_105[1];
        local_107 = uint(_e423);
        uint _e426 = local_107;
        out_1.Store(_e426*4, asuint(_e403));
        int _e428 = a;
        int _e431 = b;
        uint _e434[2] = out_;
        local_30 = _e434;
        uint _e435 = base;
        local_31 = uint((_e435 + 9u));
        uint _e441[2] = local_30;
        local_108 = _e441;
        uint _e442 = local_31;
        uint _e444 = local_108[1];
        local_108[1] = (_e444 + _e442);
        uint _e448 = local_108[0];
        local_109 = uint(_e448);
        uint _e452 = local_108[1];
        local_110 = uint(_e452);
        uint _e455 = local_110;
        out_1.Store(_e455*4, asuint(asint(asuint(asint(asuint(_e428) * asuint(int(100)))) + asuint(_e431))));
        bool _e457 = choose_a;
        c = int(_e457);
        b = int(7);
        int _e461 = c;
        if ((_e461 != int(0))) {
            c = int(0);
            int _e465 = c;
            c = asint(asuint(_e465) + asuint(int(1)));
            local_34 = _e465;
        } else {
            b = int(0);
            int _e470 = b;
            b = asint(asuint(_e470) + asuint(int(1)));
            local_34 = _e470;
        }
        int _e475 = local_34;
        uint _e477[2] = out_;
        local_32 = _e477;
        uint _e478 = base;
        local_33 = uint((_e478 + 10u));
        uint _e484[2] = local_32;
        local_111 = _e484;
        uint _e485 = local_33;
        uint _e487 = local_111[1];
        local_111[1] = (_e487 + _e485);
        uint _e491 = local_111[0];
        local_112 = uint(_e491);
        uint _e495 = local_111[1];
        local_113 = uint(_e495);
        uint _e498 = local_113;
        out_1.Store(_e498*4, asuint(_e475));
        int _e500 = c;
        int _e503 = b;
        uint _e506[2] = out_;
        local_35 = _e506;
        uint _e507 = base;
        local_36 = uint((_e507 + 11u));
        uint _e513[2] = local_35;
        local_114 = _e513;
        uint _e514 = local_36;
        uint _e516 = local_114[1];
        local_114[1] = (_e516 + _e514);
        uint _e520 = local_114[0];
        local_115 = uint(_e520);
        uint _e524 = local_114[1];
        local_116 = uint(_e524);
        uint _e527 = local_116;
        out_1.Store(_e527*4, asuint(asint(asuint(asint(asuint(_e500) * asuint(int(10)))) + asuint(_e503))));
        condition = int(0);
        a = int(2);
        b = int(4);
        condition = int(1);
        int _e534 = condition;
        int _e535 = condition;
        if ((_e535 != int(0))) {
            a = _e534;
        } else {
            b = _e534;
        }
        int _e538 = a;
        int _e541 = b;
        uint _e544[2] = out_;
        local_37 = _e544;
        uint _e545 = base;
        local_38 = uint((_e545 + 12u));
        uint _e551[2] = local_37;
        local_117 = _e551;
        uint _e552 = local_38;
        uint _e554 = local_117[1];
        local_117[1] = (_e554 + _e552);
        uint _e558 = local_117[0];
        local_118 = uint(_e558);
        uint _e562 = local_117[1];
        local_119 = uint(_e562);
        uint _e565 = local_119;
        out_1.Store(_e565*4, asuint(asint(asuint(asint(asuint(_e538) * asuint(int(10)))) + asuint(_e541))));
        a = int(2);
        b = int(4);
        c = int(6);
        bool _e570 = choose_a;
        if (_e570) {
            uint _e571 = i;
            if ((naga_mod(_e571, 4u) == 0u)) {
                int _e576 = a;
                a = asint(asuint(_e576) + asuint(int(3)));
            } else {
                int _e579 = b;
                b = asint(asuint(_e579) + asuint(int(3)));
            }
        } else {
            int _e582 = c;
            c = asint(asuint(_e582) + asuint(int(3)));
        }
        int _e585 = a;
        int _e588 = b;
        int _e592 = c;
        uint _e595[2] = out_;
        local_39 = _e595;
        uint _e596 = base;
        local_40 = uint((_e596 + 13u));
        uint _e602[2] = local_39;
        local_120 = _e602;
        uint _e603 = local_40;
        uint _e605 = local_120[1];
        local_120[1] = (_e605 + _e603);
        uint _e609 = local_120[0];
        local_121 = uint(_e609);
        uint _e613 = local_120[1];
        local_122 = uint(_e613);
        uint _e616 = local_122;
        out_1.Store(_e616*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e585) * asuint(int(100)))) + asuint(asint(asuint(_e588) * asuint(int(10)))))) + asuint(_e592))));
        lane = threadIdx.x;
        uint _e620 = lane;
        shared_values[min(uint(_e620), 63u)] = int(20);
        local_value = int(10);
        bool _e626 = choose_a;
        if (_e626) {
            int _e627 = local_value;
            local_value = asint(asuint(_e627) + asuint(int(5)));
        } else {
            uint _e630 = lane;
            int _e632 = shared_values[min(uint(_e630), 63u)];
            shared_values[min(uint(_e630), 63u)] = asint(asuint(_e632) + asuint(int(5)));
        }
        int _e635 = local_value;
        uint _e638 = lane;
        int _e640 = shared_values[min(uint(_e638), 63u)];
        uint _e643[2] = out_;
        local_41 = _e643;
        uint _e644 = base;
        local_42 = uint((_e644 + 14u));
        uint _e650[2] = local_41;
        local_123 = _e650;
        uint _e651 = local_42;
        uint _e653 = local_123[1];
        local_123[1] = (_e653 + _e651);
        uint _e657 = local_123[0];
        local_124 = uint(_e657);
        uint _e661 = local_123[1];
        local_125 = uint(_e661);
        uint _e664 = local_125;
        out_1.Store(_e664*4, asuint(asint(asuint(asint(asuint(_e635) * asuint(int(100)))) + asuint(_e640))));
        bool _e666 = choose_a;
        if (_e666) {
            uint _e667 = lane;
            shared_values[min(uint(_e667), 63u)] = int(30);
        } else {
            uint _e671[2] = out_;
            local_43 = _e671;
            uint _e672 = base;
            local_44 = uint((_e672 + 15u));
            uint _e678[2] = local_43;
            local_126 = _e678;
            uint _e679 = local_44;
            uint _e681 = local_126[1];
            local_126[1] = (_e681 + _e679);
            uint _e685 = local_126[0];
            local_127 = uint(_e685);
            uint _e689 = local_126[1];
            local_128 = uint(_e689);
            uint _e693 = local_128;
            out_1.Store(_e693*4, asuint(int(30)));
        }
        uint _e695 = lane;
        int _e697 = shared_values[min(uint(_e695), 63u)];
        uint _e699[2] = out_;
        local_45 = _e699;
        uint _e700 = base;
        local_46 = uint((_e700 + 16u));
        uint _e706[2] = local_45;
        local_129 = _e706;
        uint _e707 = local_46;
        uint _e709 = local_129[1];
        local_129[1] = (_e709 + _e707);
        uint _e713 = local_129[0];
        local_130 = uint(_e713);
        uint _e717 = local_129[1];
        local_131 = uint(_e717);
        uint _e720 = local_131;
        out_1.Store(_e720*4, asuint(_e697));
        bool _e722 = choose_a;
        if (_e722) {
            local_49 = 1.5;
        } else {
            local_49 = float(int(3));
        }
        float _e729 = local_49;
        uint _e731[2] = out_;
        local_47 = _e731;
        uint _e732 = base;
        local_48 = uint((_e732 + 17u));
        uint _e739[2] = local_47;
        local_132 = _e739;
        uint _e740 = local_48;
        uint _e742 = local_132[1];
        local_132[1] = (_e742 + _e740);
        uint _e746 = local_132[0];
        local_133 = uint(_e746);
        uint _e750 = local_132[1];
        local_134 = uint(_e750);
        uint _e753 = local_134;
        out_1.Store(_e753*4, asuint(naga_f2i32(_e729)));
        bool _e755 = choose_a;
        if (_e755) {
            local_52 = uint(naga_neg(int(1)));
        } else {
            local_52 = 2u;
        }
        uint _e763 = local_52;
        uint _e765[2] = out_;
        local_50 = _e765;
        uint _e766 = base;
        local_51 = uint((_e766 + 18u));
        uint _e773[2] = local_50;
        local_135 = _e773;
        uint _e774 = local_51;
        uint _e776 = local_135[1];
        local_135[1] = (_e776 + _e774);
        uint _e780 = local_135[0];
        local_136 = uint(_e780);
        uint _e784 = local_135[1];
        local_137 = uint(_e784);
        uint _e787 = local_137;
        out_1.Store(_e787*4, asuint(int(_e763)));
        bool _e789 = choose_a;
        if (_e789) {
            local_55 = true;
        } else {
            local_55 = false;
        }
        bool _e795 = local_55;
        uint _e797[2] = out_;
        local_53 = _e797;
        uint _e798 = base;
        local_54 = uint((_e798 + 19u));
        uint _e805[2] = local_53;
        local_138 = _e805;
        uint _e806 = local_54;
        uint _e808 = local_138[1];
        local_138[1] = (_e808 + _e806);
        uint _e812 = local_138[0];
        local_139 = uint(_e812);
        uint _e816 = local_138[1];
        local_140 = uint(_e816);
        uint _e819 = local_140;
        out_1.Store(_e819*4, asuint(int(_e795)));
        bool _e821 = choose_a;
        if (_e821) {
            local_58 = int(true);
        } else {
            local_58 = int(2);
        }
        int _e828 = local_58;
        uint _e830[2] = out_;
        local_56 = _e830;
        uint _e831 = base;
        local_57 = uint((_e831 + 20u));
        uint _e837[2] = local_56;
        local_141 = _e837;
        uint _e838 = local_57;
        uint _e840 = local_141[1];
        local_141[1] = (_e840 + _e838);
        uint _e844 = local_141[0];
        local_142 = uint(_e844);
        uint _e848 = local_141[1];
        local_143 = uint(_e848);
        uint _e851 = local_143;
        out_1.Store(_e851*4, asuint(_e828));
        bool _e853 = choose_a;
        if (_e853) {
            local_61 = 4u;
        } else {
            local_61 = 8u;
        }
        uint _e859 = local_61;
        uint _e861[2] = out_;
        local_59 = _e861;
        uint _e862 = base;
        local_60 = uint((_e862 + 21u));
        uint _e869[2] = local_59;
        local_144 = _e869;
        uint _e870 = local_60;
        uint _e872 = local_144[1];
        local_144[1] = (_e872 + _e870);
        uint _e876 = local_144[0];
        local_145 = uint(_e876);
        uint _e880 = local_144[1];
        local_146 = uint(_e880);
        uint _e883 = local_146;
        out_1.Store(_e883*4, asuint(int(_e859)));
        a = int(3);
        shift_value = int(2);
        bool _e888 = choose_a;
        if (_e888) {
            int _e889 = shift_value;
            local_64 = _e889;
        } else {
            int _e891 = a;
            local_64 = _e891;
        }
        int _e894 = local_64;
        shift_value = int(1);
        int _e896 = shift_value;
        local_65 = uint(_e896);
        uint _e899 = local_65;
        uint _e902[2] = out_;
        local_62 = _e902;
        uint _e903 = base;
        local_63 = uint((_e903 + 22u));
        uint _e909[2] = local_62;
        local_147 = _e909;
        uint _e910 = local_63;
        uint _e912 = local_147[1];
        local_147[1] = (_e912 + _e910);
        uint _e916 = local_147[0];
        local_148 = uint(_e916);
        uint _e920 = local_147[1];
        local_149 = uint(_e920);
        uint _e923 = local_149;
        out_1.Store(_e923*4, asuint((_e894 << _e899)));
        value = int(3);
        other = int(7);
        bool _e929 = choose_a;
        if (_e929) {
            int _e930 = value;
            local_68 = _e930;
        } else {
            int _e932 = other;
            local_68 = _e932;
        }
        int _e935 = local_68;
        int _e936 = value;
        value = asint(asuint(_e936) + asuint(int(1)));
        const int _e939 = pair(_e935, _e936);
        uint _e941[2] = out_;
        local_66 = _e941;
        uint _e942 = base;
        local_67 = uint((_e942 + 23u));
        uint _e948[2] = local_66;
        local_150 = _e948;
        uint _e949 = local_67;
        uint _e951 = local_150[1];
        local_150[1] = (_e951 + _e949);
        uint _e955 = local_150[0];
        local_151 = uint(_e955);
        uint _e959 = local_150[1];
        local_152 = uint(_e959);
        uint _e962 = local_152;
        out_1.Store(_e962*4, asuint(_e939));
        count = int(0);
        left = int(0);
        right = int(0);
        {
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    bool _e979 = choose_a;
                    if (_e979) {
                        int _e980 = left;
                        left = asint(asuint(_e980) + asuint(int(1)));
                    } else {
                        int _e983 = right;
                        right = asint(asuint(_e983) + asuint(int(1)));
                    }
                }
                loop_init = false;
                int _e970 = count;
                if ((_e970 < int(3))) {
                } else {
                    break;
                }
                int _e973 = count;
                count = asint(asuint(_e973) + asuint(int(1)));
                int _e976 = count;
                if ((_e976 == int(2))) {
                    continue;
                }
            }
        }
        int _e986 = left;
        int _e989 = right;
        int _e993 = count;
        uint _e996[2] = out_;
        local_69 = _e996;
        uint _e997 = base;
        local_70 = uint((_e997 + 24u));
        uint _e1003[2] = local_69;
        local_153 = _e1003;
        uint _e1004 = local_70;
        uint _e1006 = local_153[1];
        local_153[1] = (_e1006 + _e1004);
        uint _e1010 = local_153[0];
        local_154 = uint(_e1010);
        uint _e1014 = local_153[1];
        local_155 = uint(_e1014);
        uint _e1017 = local_155;
        out_1.Store(_e1017*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e986) * asuint(int(100)))) + asuint(asint(asuint(_e989) * asuint(int(10)))))) + asuint(_e993))));
    }
}
