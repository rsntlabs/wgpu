struct type_6 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input_1 : register(t0);
RWByteAddressBuffer output_1 : register(u1);
cbuffer count : register(b2) { type_6 count; }

int naga_neg(int val) {
    return asint(-asuint(val));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

typedef uint ret_ZeroValuearray3_uint_[3];
ret_ZeroValuearray3_uint_ ZeroValuearray3_uint_() {
    return (uint[3])0;
}

uint ZeroValueuint() {
    return (uint)0;
}

int ZeroValueint() {
    return (int)0;
}

[numthreads(4, 1, 1)]
void incomplete_array_pointers(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint input[3] = (uint[3])0;
    uint output[3] = (uint[3])0;
    uint local[3] = (uint[3])0;
    int small[3] = (int[3])0;
    int large[5] = (int[5])0;
    uint view[3] = (uint[3])0;
    uint local_1[3] = (uint[3])0;
    uint local_2[3] = (uint[3])0;
    uint snapshot[3] = (uint[3])0;
    uint local_3[3] = (uint[3])0;
    uint large_view[3] = (uint[3])0;
    uint local_4[3] = (uint[3])0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7[3] = (uint[3])0;
    uint selected[3] = (uint[3])0;
    uint local_8[3] = (uint[3])0;
    uint nullable[3] = (uint[3])0;
    uint local_9[3] = (uint[3])0;
    int optional = (int)0;
    uint local_10[3] = (uint[3])0;
    bool local_11 = (bool)0;
    uint local_12[3] = (uint[3])0;
    int local_13 = (int)0;
    uint local_14[3] = (uint[3])0;
    uint roundtrip[3] = (uint[3])0;
    int pairs[2][2] = (int[2][2])0;
    uint local_15 = (uint)0;
    uint row[3] = (uint[3])0;
    uint local_16[3] = (uint[3])0;
    uint row_view[3] = (uint[3])0;
    uint local_17[3] = (uint[3])0;
    uint local_18[3] = (uint[3])0;
    uint local_19[3] = (uint[3])0;
    uint elements[3] = (uint[3])0;
    uint local_20[3] = (uint[3])0;
    uint phase = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23[3] = (uint[3])0;
    uint local_24[3] = (uint[3])0;
    uint local_25[3] = (uint[3])0;
    uint local_26 = (uint)0;
    uint local_27[3] = (uint[3])0;
    uint local_28 = (uint)0;
    uint local_29[3] = (uint[3])0;
    uint local_30[3] = (uint[3])0;
    uint local_31 = (uint)0;
    uint local_32[3] = (uint[3])0;
    uint local_33[3] = (uint[3])0;
    uint local_34 = (uint)0;
    uint local_35[3] = (uint[3])0;
    uint local_36[3] = (uint[3])0;
    uint local_37 = (uint)0;
    uint local_38[3] = (uint[3])0;
    uint local_39 = (uint)0;
    uint local_40[3] = (uint[3])0;
    uint local_41[3] = (uint[3])0;
    uint local_42 = (uint)0;
    uint local_43[3] = (uint[3])0;
    bool local_44 = (bool)0;
    uint local_45[3] = (uint[3])0;
    uint local_46 = (uint)0;
    uint local_47[3] = (uint[3])0;
    uint local_48 = (uint)0;
    uint local_49[3] = (uint[3])0;
    uint local_50 = (uint)0;
    uint local_51[3] = (uint[3])0;
    uint local_52[3] = (uint[3])0;
    uint local_53 = (uint)0;
    uint local_54[3] = (uint[3])0;
    uint view_1[3] = (uint[3])0;
    uint index = (uint)0;
    uint local_55[3] = (uint[3])0;
    uint local_56 = (uint)0;
    int local_57 = (int)0;
    uint view_2[3] = (uint[3])0;
    uint index_1 = (uint)0;
    uint local_58[3] = (uint[3])0;
    uint local_59 = (uint)0;
    int local_60 = (int)0;
    uint local_61 = (uint)0;
    uint view_3[3] = (uint[3])0;
    uint index_2 = (uint)0;
    uint local_62[3] = (uint[3])0;
    uint local_63 = (uint)0;
    int local_64 = (int)0;
    int local_65 = (int)0;
    uint view_4[3] = (uint[3])0;
    uint index_3 = (uint)0;
    uint local_66[3] = (uint[3])0;
    uint local_67 = (uint)0;
    int local_68 = (int)0;
    uint view_5[3] = (uint[3])0;
    uint index_4 = (uint)0;
    uint local_69[3] = (uint[3])0;
    uint local_70 = (uint)0;
    int local_71 = (int)0;
    uint local_72 = (uint)0;
    uint view_6[3] = (uint[3])0;
    uint index_5 = (uint)0;
    uint local_73[3] = (uint[3])0;
    uint local_74 = (uint)0;
    int local_75 = (int)0;
    uint view_7[3] = (uint[3])0;
    uint index_6 = (uint)0;
    uint local_76[3] = (uint[3])0;
    uint local_77 = (uint)0;
    int local_78 = (int)0;
    uint view_8[3] = (uint[3])0;
    uint index_7 = (uint)0;
    uint local_79[3] = (uint[3])0;
    uint local_80 = (uint)0;
    int local_81 = (int)0;
    uint view_9[3] = (uint[3])0;
    uint index_8 = (uint)0;
    uint local_82[3] = (uint[3])0;
    uint local_83 = (uint)0;
    int local_84 = (int)0;
    uint view_10[3] = (uint[3])0;
    uint index_9 = (uint)0;
    uint local_85[3] = (uint[3])0;
    uint local_86 = (uint)0;
    int local_87 = (int)0;
    uint local_88[3] = (uint[3])0;
    uint local_89 = (uint)0;
    uint local_90 = (uint)0;
    uint local_91 = (uint)0;
    uint local_92[3] = (uint[3])0;
    uint local_93 = (uint)0;
    uint local_94 = (uint)0;
    uint local_95 = (uint)0;
    int local_96 = (int)0;
    uint local_97[3] = (uint[3])0;
    uint local_98[3] = (uint[3])0;
    uint local_99 = (uint)0;
    uint local_100 = (uint)0;
    uint local_101 = (uint)0;
    int local_102 = (int)0;
    uint local_103 = (uint)0;
    uint local_104[3] = (uint[3])0;
    uint local_105 = (uint)0;
    uint local_106 = (uint)0;
    uint local_107 = (uint)0;
    int local_108 = (int)0;
    uint local_109[3] = (uint[3])0;
    uint local_110[3] = (uint[3])0;
    uint local_111[3] = (uint[3])0;
    uint local_112 = (uint)0;
    uint local_113 = (uint)0;
    uint local_114 = (uint)0;
    int local_115 = (int)0;
    uint local_116[3] = (uint[3])0;
    uint local_117 = (uint)0;
    uint local_118 = (uint)0;
    uint local_119 = (uint)0;
    uint local_120[3] = (uint[3])0;
    uint local_121 = (uint)0;
    uint local_122 = (uint)0;
    uint local_123 = (uint)0;
    uint local_124[3] = (uint[3])0;
    uint local_125 = (uint)0;
    uint local_126 = (uint)0;
    uint local_127 = (uint)0;
    uint local_128[3] = (uint[3])0;
    uint local_129 = (uint)0;
    uint local_130 = (uint)0;
    uint local_131 = (uint)0;
    uint local_132 = (uint)0;
    uint local_133[3] = (uint[3])0;
    uint local_134[3] = (uint[3])0;
    uint local_135 = (uint)0;
    uint local_136 = (uint)0;
    uint local_137 = (uint)0;
    uint local_138[3] = (uint[3])0;
    uint local_139 = (uint)0;
    uint local_140 = (uint)0;
    uint local_141 = (uint)0;
    uint local_142[3] = (uint[3])0;
    uint local_143 = (uint)0;
    uint local_144 = (uint)0;
    uint local_145 = (uint)0;
    int local_146 = (int)0;
    uint local_147[3] = (uint[3])0;
    uint local_148 = (uint)0;
    uint local_149 = (uint)0;
    uint local_150 = (uint)0;
    uint local_151[3] = (uint[3])0;
    uint local_152 = (uint)0;
    uint local_153 = (uint)0;
    uint local_154 = (uint)0;
    int local_155 = (int)0;
    uint local_156[3] = (uint[3])0;
    uint local_157 = (uint)0;
    uint local_158 = (uint)0;
    uint local_159 = (uint)0;
    uint local_160[3] = (uint[3])0;
    uint local_161 = (uint)0;
    uint local_162 = (uint)0;
    uint local_163 = (uint)0;
    int local_164 = (int)0;
    uint local_165[3] = (uint[3])0;
    uint local_166 = (uint)0;
    uint local_167 = (uint)0;
    uint local_168 = (uint)0;
    uint local_169[3] = (uint[3])0;
    uint local_170 = (uint)0;
    uint local_171 = (uint)0;
    uint local_172 = (uint)0;
    uint local_173[3] = (uint[3])0;
    uint local_174 = (uint)0;
    uint local_175 = (uint)0;
    uint local_176 = (uint)0;
    int local_177 = (int)0;
    uint local_178[3] = (uint[3])0;
    uint local_179 = (uint)0;
    uint local_180 = (uint)0;
    uint local_181 = (uint)0;
    uint local_182[3] = (uint[3])0;
    uint local_183[3] = (uint[3])0;
    uint local_184 = (uint)0;
    uint local_185 = (uint)0;
    uint local_186 = (uint)0;
    uint local_187[3] = (uint[3])0;
    uint local_188 = (uint)0;
    uint local_189 = (uint)0;
    uint local_190 = (uint)0;
    uint local_191[3] = (uint[3])0;
    uint local_192 = (uint)0;
    uint local_193 = (uint)0;
    uint local_194 = (uint)0;
    uint local_195[3] = (uint[3])0;
    uint local_196 = (uint)0;
    uint local_197 = (uint)0;
    uint local_198 = (uint)0;
    uint local_199[3] = (uint[3])0;
    uint local_200 = (uint)0;
    uint local_201 = (uint)0;
    uint local_202 = (uint)0;
    uint local_203[3] = (uint[3])0;
    uint local_204 = (uint)0;
    uint local_205 = (uint)0;
    uint local_206 = (uint)0;
    int local_207 = (int)0;
    uint local_208[3] = (uint[3])0;
    uint local_209 = (uint)0;
    uint local_210 = (uint)0;
    uint local_211 = (uint)0;

    input = ZeroValuearray3_uint_();
    input[0] = 2u;
    input[1] = 0u;
    output = ZeroValuearray3_uint_();
    output[0] = 3u;
    output[1] = 0u;
    uint count_1 = count.value;
    uint index_10 = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index_10 >= count_1)) {
        return;
    }
    uint _e24[3] = input;
    local = _e24;
    uint _e26[3] = local;
    local_88 = _e26;
    uint _e29 = local_88[0];
    local_89 = uint(_e29);
    uint _e33 = local_88[1];
    local_90 = uint(_e33);
    uint _e37 = local_88[2];
    local_91 = uint(_e37);
    int _e42 = asint(input_1.Load(index_10*4));
    int value = (_e42 & int(255));
    small[0] = value;
    small[1] = asint(asuint(value) + asuint(int(1)));
    small[2] = asint(asuint(value) + asuint(int(2)));
    large[0] = asint(asuint(value) + asuint(int(3)));
    large[1] = asint(asuint(value) + asuint(int(4)));
    large[2] = asint(asuint(value) + asuint(int(5)));
    large[3] = asint(asuint(value) + asuint(int(6)));
    large[4] = asint(asuint(value) + asuint(int(7)));
    view = ZeroValuearray3_uint_();
    view[0] = 4u;
    view[1] = 0u;
    uint _e76[3] = view;
    local_1 = _e76;
    index = ZeroValueuint();
    local_56 = ZeroValueuint();
    local_57 = ZeroValueint();
    uint _e86[3] = local_1;
    view_1 = _e86;
    index = uint(int(1));
    uint _e90[3] = view_1;
    local_55 = _e90;
    uint _e92 = index;
    local_56 = _e92;
    uint _e94[3] = local_55;
    local_92 = _e94;
    uint _e97 = local_92[0];
    local_93 = uint(_e97);
    uint _e101 = local_92[1];
    local_94 = uint(_e101);
    uint _e105 = local_92[2];
    local_95 = uint(_e105);
    uint _e108 = local_93;
    switch(_e108) {
        case 4u: {
            uint _e109 = local_56;
            int _e111 = small[min(uint(_e109), 2u)];
            local_96 = _e111;
            break;
        }
        default: {
            uint _e113 = local_56;
            int _e115 = large[min(uint(_e113), 4u)];
            local_96 = _e115;
            break;
        }
    }
    int _e118 = local_96;
    local_57 = _e118;
    int before = local_57;
    uint _e121[3] = view;
    local_2 = _e121;
    uint _e123[3] = local_2;
    snapshot = _e123;
    local_97 = ZeroValuearray3_uint_();
    local_97[0] = 5u;
    local_97[1] = 0u;
    uint _e131[3] = local_97;
    view = _e131;
    uint _e132[3] = view;
    local_3 = _e132;
    uint _e134[3] = local_3;
    large_view = _e134;
    uint _e136[3] = view;
    local_4 = _e136;
    index_1 = ZeroValueuint();
    local_59 = ZeroValueuint();
    local_60 = ZeroValueint();
    uint _e146[3] = local_4;
    view_2 = _e146;
    index_1 = uint(int(3));
    uint _e150[3] = view_2;
    local_58 = _e150;
    uint _e152 = index_1;
    local_59 = _e152;
    uint _e154[3] = local_58;
    local_98 = _e154;
    uint _e157 = local_98[0];
    local_99 = uint(_e157);
    uint _e161 = local_98[1];
    local_100 = uint(_e161);
    uint _e165 = local_98[2];
    local_101 = uint(_e165);
    uint _e168 = local_99;
    switch(_e168) {
        case 4u: {
            uint _e169 = local_59;
            int _e171 = small[min(uint(_e169), 2u)];
            local_102 = _e171;
            break;
        }
        default: {
            uint _e173 = local_59;
            int _e175 = large[min(uint(_e173), 4u)];
            local_102 = _e175;
            break;
        }
    }
    int _e178 = local_102;
    local_60 = _e178;
    int after = local_60;
    if (((index_10 & 1u) == 0u)) {
        local_6 = 6u;
        local_5 = 1u;
    } else {
        local_6 = 5u;
        local_5 = 0u;
    }
    uint _e194 = local_6;
    switch(_e194) {
        case 5u: {
            local_61 = 5u;
            break;
        }
        default: {
            local_61 = 11u;
            break;
        }
    }
    uint _e200 = local_61;
    switch(_e200) {
        case 5u: {
            local_103 = 5u;
            break;
        }
        default: {
            local_103 = 13u;
            break;
        }
    }
    uint _e206 = local_103;
    switch(_e206) {
        case 5u: {
            uint _e207[3] = view;
            local_7 = _e207;
            break;
        }
        default: {
            uint _e210[3] = snapshot;
            local_7 = _e210;
            break;
        }
    }
    uint _e213[3] = local_7;
    selected = _e213;
    uint _e216[3] = selected;
    local_8 = _e216;
    uint _e219 = uint(int(1));
    uint _e220[3] = local_8;
    local_104 = _e220;
    uint _e223 = local_104[0];
    local_105 = uint(_e223);
    uint _e227 = local_104[1];
    local_106 = uint(_e227);
    uint _e231 = local_104[2];
    local_107 = uint(_e231);
    uint _e234 = local_105;
    switch(_e234) {
        case 4u: {
            int _e236 = small[min(uint(_e219), 2u)];
            local_108 = _e236;
            break;
        }
        default: {
            int _e239 = large[min(uint(_e219), 4u)];
            local_108 = _e239;
            break;
        }
    }
    int _e242 = local_108;
    int _e244 = asint(asuint(_e242) + asuint(int(7)));
    uint _e245 = local_105;
    switch(_e245) {
        case 4u: {
            small[min(uint(_e219), 2u)] = _e244;
            break;
        }
        default: {
            large[min(uint(_e219), 4u)] = _e244;
            break;
        }
    }
    nullable = ZeroValuearray3_uint_();
    nullable[0] = 1u;
    if ((naga_mod(index_10, 3u) != 0u)) {
        uint _e256[3] = selected;
        local_9 = _e256;
        uint _e258[3] = local_9;
        local_109 = _e258;
        uint _e260[3] = local_109;
        nullable = _e260;
    }
    optional = naga_neg(int(1));
    uint _e266[3] = nullable;
    local_10 = _e266;
    uint _e268[3] = local_10;
    local_110 = _e268;
    uint _e271 = local_110[0];
    local_11 = (_e271 != 1u);
    bool _e275 = local_11;
    if (_e275) {
        uint _e276[3] = nullable;
        local_12 = _e276;
        index_2 = ZeroValueuint();
        local_63 = ZeroValueuint();
        local_64 = ZeroValueint();
        uint _e286[3] = local_12;
        view_3 = _e286;
        index_2 = uint(int(0));
        uint _e290[3] = view_3;
        local_62 = _e290;
        uint _e292 = index_2;
        local_63 = _e292;
        uint _e294[3] = local_62;
        local_111 = _e294;
        uint _e297 = local_111[0];
        local_112 = uint(_e297);
        uint _e301 = local_111[1];
        local_113 = uint(_e301);
        uint _e305 = local_111[2];
        local_114 = uint(_e305);
        local_115 = ZeroValueint();
        uint _e310 = local_112;
        switch(_e310) {
            case 4u: {
                uint _e311 = local_63;
                int _e313 = small[min(uint(_e311), 2u)];
                local_115 = _e313;
                break;
            }
            case 5u: {
                uint _e314 = local_63;
                int _e316 = large[min(uint(_e314), 4u)];
                local_115 = _e316;
                break;
            }
            default: {
                break;
            }
        }
        int _e317 = local_115;
        local_65 = _e317;
        int _e319 = local_65;
        local_64 = _e319;
        int _e321 = local_64;
        local_13 = _e321;
        int _e323 = local_13;
        optional = _e323;
    }
    uint _e324[3] = selected;
    local_14 = _e324;
    uint _e326[3] = local_14;
    roundtrip = _e326;
    pairs[0][0] = asint(asuint(value) + asuint(int(8)));
    pairs[0][1] = asint(asuint(value) + asuint(int(9)));
    pairs[1][0] = asint(asuint(value) + asuint(int(10)));
    pairs[1][1] = asint(asuint(value) + asuint(int(11)));
    local_15 = uint(int(1));
    row = ZeroValuearray3_uint_();
    row[0] = 6u;
    row[1] = 0u;
    uint _e352 = local_15;
    uint _e354 = row[1];
    row[1] = (_e354 + _e352);
    uint _e358[3] = row;
    local_16 = _e358;
    uint _e360[3] = local_16;
    row_view = _e360;
    uint _e363[3] = row_view;
    local_17 = _e363;
    index_3 = ZeroValueuint();
    local_67 = ZeroValueuint();
    local_68 = ZeroValueint();
    uint _e373[3] = local_17;
    view_4 = _e373;
    index_3 = uint(int(0));
    uint _e377[3] = view_4;
    local_66 = _e377;
    uint _e379 = index_3;
    local_67 = _e379;
    uint _e381[3] = local_66;
    local_116 = _e381;
    uint _e384 = local_116[0];
    local_117 = uint(_e384);
    uint _e388 = local_116[1];
    local_118 = uint(_e388);
    uint _e392 = local_116[2];
    local_119 = uint(_e392);
    uint _e395 = local_118;
    uint _e397 = local_67;
    int _e399 = pairs[min(uint(_e395), 1u)][min(uint(_e397), 1u)];
    local_68 = _e399;
    int row_first = local_68;
    uint _e402[3] = row_view;
    local_18 = _e402;
    index_4 = ZeroValueuint();
    local_70 = ZeroValueuint();
    local_71 = ZeroValueint();
    uint _e412[3] = local_18;
    view_5 = _e412;
    index_4 = uint(int(1));
    uint _e416[3] = view_5;
    local_69 = _e416;
    uint _e418 = index_4;
    local_70 = _e418;
    uint _e420[3] = local_69;
    local_120 = _e420;
    uint _e423 = local_120[0];
    local_121 = uint(_e423);
    uint _e427 = local_120[1];
    local_122 = uint(_e427);
    uint _e431 = local_120[2];
    local_123 = uint(_e431);
    uint _e434 = local_122;
    uint _e436 = local_70;
    int _e438 = pairs[min(uint(_e434), 1u)][min(uint(_e436), 1u)];
    local_71 = _e438;
    int row_second = local_71;
    uint _e441[3] = row_view;
    local_19 = _e441;
    uint _e443[3] = local_19;
    local_124 = _e443;
    uint _e446 = local_124[0];
    local_125 = uint(_e446);
    uint _e450 = local_124[1];
    local_126 = uint(_e450);
    uint _e454 = local_124[2];
    local_127 = uint(_e454);
    elements = ZeroValuearray3_uint_();
    elements[0] = 7u;
    elements[1] = 0u;
    uint _e463 = local_126;
    elements[2] = _e463;
    uint _e467 = elements[1];
    elements[1] = (_e467 + 1u);
    uint _e471[3] = elements;
    local_20 = _e471;
    uint _e473[3] = local_20;
    local_128 = _e473;
    uint _e476 = local_128[0];
    local_129 = uint(_e476);
    uint _e480 = local_128[1];
    local_130 = uint(_e480);
    uint _e484 = local_128[2];
    local_131 = uint(_e484);
    uint _e487 = local_131;
    uint _e489 = local_130;
    int _e491 = pairs[min(uint(_e487), 1u)][min(uint(_e489), 1u)];
    uint _e494 = local_131;
    uint _e496 = local_130;
    pairs[min(uint(_e494), 1u)][min(uint(_e496), 1u)] = asint(asuint(_e491) + asuint(int(1)));
    {
        phase = uint(int(0));
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e541 = phase;
                phase = (_e541 + uint(int(1)));
            }
            loop_init = false;
            uint _e501 = phase;
            if ((_e501 < 3u)) {
            } else {
                break;
            }
            uint _e504 = phase;
            if (((_e504 & 1u) == 0u)) {
                local_22 = 6u;
                local_21 = 1u;
            } else {
                local_22 = 8u;
                local_21 = 0u;
            }
            uint _e518 = local_22;
            bool should_continue = false;
            switch(_e518) {
                case 6u: {
                    local_72 = 11u;
                    break;
                }
                default: {
                    local_72 = 27u;
                    break;
                }
            }
            uint _e524 = local_72;
            bool should_continue_1 = false;
            switch(_e524) {
                case 11u: {
                    local_132 = 13u;
                    break;
                }
                default: {
                    local_132 = 32u;
                    break;
                }
            }
            uint _e530 = local_132;
            bool should_continue_2 = false;
            switch(_e530) {
                case 13u: {
                    uint _e532[3] = snapshot;
                    local_23 = _e532;
                    break;
                }
                default: {
                    uint _e535[3] = large_view;
                    local_23 = _e535;
                    break;
                }
            }
            uint _e538[3] = local_23;
            local_133 = _e538;
            uint _e540[3] = local_133;
            view = _e540;
        }
    }
    uint base = ((index_10 + 1u) * 12u);
    uint _e550[3] = output;
    local_24 = _e550;
    uint _e552[3] = local_24;
    local_134 = _e552;
    uint _e555 = local_134[0];
    local_135 = uint(_e555);
    uint _e559 = local_134[1];
    local_136 = uint(_e559);
    uint _e563 = local_134[2];
    local_137 = uint(_e563);
    output_1.Store(base*4, asuint(before));
    uint _e568[3] = output;
    local_25 = _e568;
    local_26 = uint((base + 1u));
    uint _e574[3] = local_25;
    local_138 = _e574;
    uint _e577 = local_138[0];
    local_139 = uint(_e577);
    uint _e581 = local_138[1];
    local_140 = uint(_e581);
    uint _e585 = local_138[2];
    local_141 = uint(_e585);
    uint _e588 = local_26;
    output_1.Store(_e588*4, asuint(after));
    uint _e591[3] = snapshot;
    local_29 = _e591;
    index_5 = ZeroValueuint();
    local_74 = ZeroValueuint();
    local_75 = ZeroValueint();
    uint _e601[3] = local_29;
    view_6 = _e601;
    index_5 = uint(int(1));
    uint _e605[3] = view_6;
    local_73 = _e605;
    uint _e607 = index_5;
    local_74 = _e607;
    uint _e609[3] = local_73;
    local_142 = _e609;
    uint _e612 = local_142[0];
    local_143 = uint(_e612);
    uint _e616 = local_142[1];
    local_144 = uint(_e616);
    uint _e620 = local_142[2];
    local_145 = uint(_e620);
    uint _e623 = local_143;
    switch(_e623) {
        case 4u: {
            uint _e624 = local_74;
            int _e626 = small[min(uint(_e624), 2u)];
            local_146 = _e626;
            break;
        }
        default: {
            uint _e628 = local_74;
            int _e630 = large[min(uint(_e628), 4u)];
            local_146 = _e630;
            break;
        }
    }
    int _e633 = local_146;
    local_75 = _e633;
    int _e635 = local_75;
    uint _e636[3] = output;
    local_27 = _e636;
    local_28 = uint((base + 2u));
    uint _e642[3] = local_27;
    local_147 = _e642;
    uint _e645 = local_147[0];
    local_148 = uint(_e645);
    uint _e649 = local_147[1];
    local_149 = uint(_e649);
    uint _e653 = local_147[2];
    local_150 = uint(_e653);
    uint _e656 = local_28;
    output_1.Store(_e656*4, asuint(_e635));
    uint _e659[3] = large_view;
    local_32 = _e659;
    index_6 = ZeroValueuint();
    local_77 = ZeroValueuint();
    local_78 = ZeroValueint();
    uint _e669[3] = local_32;
    view_7 = _e669;
    index_6 = uint(int(1));
    uint _e673[3] = view_7;
    local_76 = _e673;
    uint _e675 = index_6;
    local_77 = _e675;
    uint _e677[3] = local_76;
    local_151 = _e677;
    uint _e680 = local_151[0];
    local_152 = uint(_e680);
    uint _e684 = local_151[1];
    local_153 = uint(_e684);
    uint _e688 = local_151[2];
    local_154 = uint(_e688);
    uint _e691 = local_152;
    switch(_e691) {
        case 4u: {
            uint _e692 = local_77;
            int _e694 = small[min(uint(_e692), 2u)];
            local_155 = _e694;
            break;
        }
        default: {
            uint _e696 = local_77;
            int _e698 = large[min(uint(_e696), 4u)];
            local_155 = _e698;
            break;
        }
    }
    int _e701 = local_155;
    local_78 = _e701;
    int _e703 = local_78;
    uint _e704[3] = output;
    local_30 = _e704;
    local_31 = uint((base + 3u));
    uint _e710[3] = local_30;
    local_156 = _e710;
    uint _e713 = local_156[0];
    local_157 = uint(_e713);
    uint _e717 = local_156[1];
    local_158 = uint(_e717);
    uint _e721 = local_156[2];
    local_159 = uint(_e721);
    uint _e724 = local_31;
    output_1.Store(_e724*4, asuint(_e703));
    uint _e726[3] = selected;
    local_35 = _e726;
    index_7 = ZeroValueuint();
    local_80 = ZeroValueuint();
    local_81 = ZeroValueint();
    uint _e736[3] = local_35;
    view_8 = _e736;
    index_7 = uint(int(1));
    uint _e740[3] = view_8;
    local_79 = _e740;
    uint _e742 = index_7;
    local_80 = _e742;
    uint _e744[3] = local_79;
    local_160 = _e744;
    uint _e747 = local_160[0];
    local_161 = uint(_e747);
    uint _e751 = local_160[1];
    local_162 = uint(_e751);
    uint _e755 = local_160[2];
    local_163 = uint(_e755);
    uint _e758 = local_161;
    switch(_e758) {
        case 4u: {
            uint _e759 = local_80;
            int _e761 = small[min(uint(_e759), 2u)];
            local_164 = _e761;
            break;
        }
        default: {
            uint _e763 = local_80;
            int _e765 = large[min(uint(_e763), 4u)];
            local_164 = _e765;
            break;
        }
    }
    int _e768 = local_164;
    local_81 = _e768;
    int _e770 = local_81;
    uint _e771[3] = output;
    local_33 = _e771;
    local_34 = uint((base + 4u));
    uint _e777[3] = local_33;
    local_165 = _e777;
    uint _e780 = local_165[0];
    local_166 = uint(_e780);
    uint _e784 = local_165[1];
    local_167 = uint(_e784);
    uint _e788 = local_165[2];
    local_168 = uint(_e788);
    uint _e791 = local_34;
    output_1.Store(_e791*4, asuint(_e770));
    int _e793 = optional;
    uint _e794[3] = output;
    local_36 = _e794;
    local_37 = uint((base + 5u));
    uint _e800[3] = local_36;
    local_169 = _e800;
    uint _e803 = local_169[0];
    local_170 = uint(_e803);
    uint _e807 = local_169[1];
    local_171 = uint(_e807);
    uint _e811 = local_169[2];
    local_172 = uint(_e811);
    uint _e814 = local_37;
    output_1.Store(_e814*4, asuint(_e793));
    uint _e817[3] = roundtrip;
    local_40 = _e817;
    index_8 = ZeroValueuint();
    local_83 = ZeroValueuint();
    local_84 = ZeroValueint();
    uint _e827[3] = local_40;
    view_9 = _e827;
    index_8 = uint(int(0));
    uint _e831[3] = view_9;
    local_82 = _e831;
    uint _e833 = index_8;
    local_83 = _e833;
    uint _e835[3] = local_82;
    local_173 = _e835;
    uint _e838 = local_173[0];
    local_174 = uint(_e838);
    uint _e842 = local_173[1];
    local_175 = uint(_e842);
    uint _e846 = local_173[2];
    local_176 = uint(_e846);
    uint _e849 = local_174;
    switch(_e849) {
        case 4u: {
            uint _e850 = local_83;
            int _e852 = small[min(uint(_e850), 2u)];
            local_177 = _e852;
            break;
        }
        default: {
            uint _e854 = local_83;
            int _e856 = large[min(uint(_e854), 4u)];
            local_177 = _e856;
            break;
        }
    }
    int _e859 = local_177;
    local_84 = _e859;
    int _e861 = local_84;
    uint _e862[3] = output;
    local_38 = _e862;
    local_39 = uint((base + 6u));
    uint _e868[3] = local_38;
    local_178 = _e868;
    uint _e871 = local_178[0];
    local_179 = uint(_e871);
    uint _e875 = local_178[1];
    local_180 = uint(_e875);
    uint _e879 = local_178[2];
    local_181 = uint(_e879);
    uint _e882 = local_39;
    output_1.Store(_e882*4, asuint(_e861));
    uint _e884[3] = nullable;
    local_43 = _e884;
    uint _e886[3] = local_43;
    local_182 = _e886;
    uint _e889 = local_182[0];
    local_44 = (_e889 != 1u);
    bool _e893 = local_44;
    uint _e894[3] = output;
    local_41 = _e894;
    local_42 = uint((base + 7u));
    uint _e901[3] = local_41;
    local_183 = _e901;
    uint _e904 = local_183[0];
    local_184 = uint(_e904);
    uint _e908 = local_183[1];
    local_185 = uint(_e908);
    uint _e912 = local_183[2];
    local_186 = uint(_e912);
    uint _e915 = local_42;
    output_1.Store(_e915*4, asuint(int(_e893)));
    uint _e917[3] = output;
    local_45 = _e917;
    local_46 = uint((base + 8u));
    uint _e923[3] = local_45;
    local_187 = _e923;
    uint _e926 = local_187[0];
    local_188 = uint(_e926);
    uint _e930 = local_187[1];
    local_189 = uint(_e930);
    uint _e934 = local_187[2];
    local_190 = uint(_e934);
    uint _e937 = local_46;
    output_1.Store(_e937*4, asuint(row_first));
    uint _e939[3] = output;
    local_47 = _e939;
    local_48 = uint((base + 9u));
    uint _e945[3] = local_47;
    local_191 = _e945;
    uint _e948 = local_191[0];
    local_192 = uint(_e948);
    uint _e952 = local_191[1];
    local_193 = uint(_e952);
    uint _e956 = local_191[2];
    local_194 = uint(_e956);
    uint _e959 = local_48;
    output_1.Store(_e959*4, asuint(row_second));
    uint _e961[3] = elements;
    local_51 = _e961;
    uint _e963[3] = local_51;
    local_195 = _e963;
    uint _e966 = local_195[0];
    local_196 = uint(_e966);
    uint _e970 = local_195[1];
    local_197 = uint(_e970);
    uint _e974 = local_195[2];
    local_198 = uint(_e974);
    uint _e977 = local_198;
    uint _e979 = local_197;
    int _e981 = pairs[min(uint(_e977), 1u)][min(uint(_e979), 1u)];
    uint _e982[3] = output;
    local_49 = _e982;
    local_50 = uint((base + 10u));
    uint _e988[3] = local_49;
    local_199 = _e988;
    uint _e991 = local_199[0];
    local_200 = uint(_e991);
    uint _e995 = local_199[1];
    local_201 = uint(_e995);
    uint _e999 = local_199[2];
    local_202 = uint(_e999);
    uint _e1002 = local_50;
    output_1.Store(_e1002*4, asuint(_e981));
    uint _e1004[3] = view;
    local_54 = _e1004;
    index_9 = ZeroValueuint();
    local_86 = ZeroValueuint();
    local_87 = ZeroValueint();
    uint _e1014[3] = local_54;
    view_10 = _e1014;
    index_9 = uint(int(1));
    uint _e1018[3] = view_10;
    local_85 = _e1018;
    uint _e1020 = index_9;
    local_86 = _e1020;
    uint _e1022[3] = local_85;
    local_203 = _e1022;
    uint _e1025 = local_203[0];
    local_204 = uint(_e1025);
    uint _e1029 = local_203[1];
    local_205 = uint(_e1029);
    uint _e1033 = local_203[2];
    local_206 = uint(_e1033);
    uint _e1036 = local_204;
    switch(_e1036) {
        case 4u: {
            uint _e1037 = local_86;
            int _e1039 = small[min(uint(_e1037), 2u)];
            local_207 = _e1039;
            break;
        }
        default: {
            uint _e1041 = local_86;
            int _e1043 = large[min(uint(_e1041), 4u)];
            local_207 = _e1043;
            break;
        }
    }
    int _e1046 = local_207;
    local_87 = _e1046;
    int _e1048 = local_87;
    uint _e1049[3] = output;
    local_52 = _e1049;
    local_53 = uint((base + 11u));
    uint _e1055[3] = local_52;
    local_208 = _e1055;
    uint _e1058 = local_208[0];
    local_209 = uint(_e1058);
    uint _e1062 = local_208[1];
    local_210 = uint(_e1062);
    uint _e1066 = local_208[2];
    local_211 = uint(_e1066);
    uint _e1069 = local_53;
    output_1.Store(_e1069*4, asuint(_e1048));
}
