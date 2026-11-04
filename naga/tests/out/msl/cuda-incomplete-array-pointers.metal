// language: metal2.4
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_1[1];
struct type_2 {
    int inner[3];
};
struct type_3 {
    int inner[5];
};
struct type_4 {
    int inner[2];
};
struct type_6 {
    uint value;
    char _pad1[12];
};
struct type_9 {
    type_4 inner[2];
};
struct type_10 {
    uint inner[3];
};
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


struct incomplete_array_pointersInput {
};
[[max_total_threads_per_threadgroup(4)]] kernel void incomplete_array_pointers(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& input_1 [[buffer(0)]]
, device type_1& output_1 [[buffer(1)]]
, constant type_6& count [[buffer(2)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(3)]]
) {
    type_10 input = {};
    type_10 output = {};
    type_10 local = {};
    type_2 small = {};
    type_3 large = {};
    type_10 view = {};
    type_10 local_1 = {};
    type_10 local_2 = {};
    type_10 snapshot = {};
    type_10 local_3 = {};
    type_10 large_view = {};
    type_10 local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    type_10 local_7 = {};
    type_10 selected = {};
    type_10 local_8 = {};
    type_10 nullable = {};
    type_10 local_9 = {};
    int optional = {};
    type_10 local_10 = {};
    bool local_11 = {};
    type_10 local_12 = {};
    int local_13 = {};
    type_10 local_14 = {};
    type_10 roundtrip = {};
    type_9 pairs = {};
    uint local_15 = {};
    type_10 row = {};
    type_10 local_16 = {};
    type_10 row_view = {};
    type_10 local_17 = {};
    type_10 local_18 = {};
    type_10 local_19 = {};
    type_10 elements = {};
    type_10 local_20 = {};
    uint phase = {};
    uint local_21 = {};
    uint local_22 = {};
    type_10 local_23 = {};
    type_10 local_24 = {};
    type_10 local_25 = {};
    uint local_26 = {};
    type_10 local_27 = {};
    uint local_28 = {};
    type_10 local_29 = {};
    type_10 local_30 = {};
    uint local_31 = {};
    type_10 local_32 = {};
    type_10 local_33 = {};
    uint local_34 = {};
    type_10 local_35 = {};
    type_10 local_36 = {};
    uint local_37 = {};
    type_10 local_38 = {};
    uint local_39 = {};
    type_10 local_40 = {};
    type_10 local_41 = {};
    uint local_42 = {};
    type_10 local_43 = {};
    bool local_44 = {};
    type_10 local_45 = {};
    uint local_46 = {};
    type_10 local_47 = {};
    uint local_48 = {};
    type_10 local_49 = {};
    uint local_50 = {};
    type_10 local_51 = {};
    type_10 local_52 = {};
    uint local_53 = {};
    type_10 local_54 = {};
    type_10 view_1 = {};
    uint index = {};
    type_10 local_55 = {};
    uint local_56 = {};
    int local_57 = {};
    type_10 view_2 = {};
    uint index_1 = {};
    type_10 local_58 = {};
    uint local_59 = {};
    int local_60 = {};
    uint local_61 = {};
    type_10 view_3 = {};
    uint index_2 = {};
    type_10 local_62 = {};
    uint local_63 = {};
    int local_64 = {};
    int local_65 = {};
    type_10 view_4 = {};
    uint index_3 = {};
    type_10 local_66 = {};
    uint local_67 = {};
    int local_68 = {};
    type_10 view_5 = {};
    uint index_4 = {};
    type_10 local_69 = {};
    uint local_70 = {};
    int local_71 = {};
    uint local_72 = {};
    type_10 view_6 = {};
    uint index_5 = {};
    type_10 local_73 = {};
    uint local_74 = {};
    int local_75 = {};
    type_10 view_7 = {};
    uint index_6 = {};
    type_10 local_76 = {};
    uint local_77 = {};
    int local_78 = {};
    type_10 view_8 = {};
    uint index_7 = {};
    type_10 local_79 = {};
    uint local_80 = {};
    int local_81 = {};
    type_10 view_9 = {};
    uint index_8 = {};
    type_10 local_82 = {};
    uint local_83 = {};
    int local_84 = {};
    type_10 view_10 = {};
    uint index_9 = {};
    type_10 local_85 = {};
    uint local_86 = {};
    int local_87 = {};
    type_10 local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    uint local_91 = {};
    type_10 local_92 = {};
    uint local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    int local_96 = {};
    type_10 local_97 = {};
    type_10 local_98 = {};
    uint local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    int local_102 = {};
    uint local_103 = {};
    type_10 local_104 = {};
    uint local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    int local_108 = {};
    type_10 local_109 = {};
    type_10 local_110 = {};
    type_10 local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    uint local_114 = {};
    int local_115 = {};
    type_10 local_116 = {};
    uint local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    type_10 local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    uint local_123 = {};
    type_10 local_124 = {};
    uint local_125 = {};
    uint local_126 = {};
    uint local_127 = {};
    type_10 local_128 = {};
    uint local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    uint local_132 = {};
    type_10 local_133 = {};
    type_10 local_134 = {};
    uint local_135 = {};
    uint local_136 = {};
    uint local_137 = {};
    type_10 local_138 = {};
    uint local_139 = {};
    uint local_140 = {};
    uint local_141 = {};
    type_10 local_142 = {};
    uint local_143 = {};
    uint local_144 = {};
    uint local_145 = {};
    int local_146 = {};
    type_10 local_147 = {};
    uint local_148 = {};
    uint local_149 = {};
    uint local_150 = {};
    type_10 local_151 = {};
    uint local_152 = {};
    uint local_153 = {};
    uint local_154 = {};
    int local_155 = {};
    type_10 local_156 = {};
    uint local_157 = {};
    uint local_158 = {};
    uint local_159 = {};
    type_10 local_160 = {};
    uint local_161 = {};
    uint local_162 = {};
    uint local_163 = {};
    int local_164 = {};
    type_10 local_165 = {};
    uint local_166 = {};
    uint local_167 = {};
    uint local_168 = {};
    type_10 local_169 = {};
    uint local_170 = {};
    uint local_171 = {};
    uint local_172 = {};
    type_10 local_173 = {};
    uint local_174 = {};
    uint local_175 = {};
    uint local_176 = {};
    int local_177 = {};
    type_10 local_178 = {};
    uint local_179 = {};
    uint local_180 = {};
    uint local_181 = {};
    type_10 local_182 = {};
    type_10 local_183 = {};
    uint local_184 = {};
    uint local_185 = {};
    uint local_186 = {};
    type_10 local_187 = {};
    uint local_188 = {};
    uint local_189 = {};
    uint local_190 = {};
    type_10 local_191 = {};
    uint local_192 = {};
    uint local_193 = {};
    uint local_194 = {};
    type_10 local_195 = {};
    uint local_196 = {};
    uint local_197 = {};
    uint local_198 = {};
    type_10 local_199 = {};
    uint local_200 = {};
    uint local_201 = {};
    uint local_202 = {};
    type_10 local_203 = {};
    uint local_204 = {};
    uint local_205 = {};
    uint local_206 = {};
    int local_207 = {};
    type_10 local_208 = {};
    uint local_209 = {};
    uint local_210 = {};
    uint local_211 = {};
    input = type_10 {};
    input.inner[0] = 2u;
    input.inner[1] = 0u;
    output = type_10 {};
    output.inner[0] = 3u;
    output.inner[1] = 0u;
    uint count_1 = count.value;
    uint index_10 = (blockIdx.x * 4u) + threadIdx.x;
    if (index_10 >= count_1) {
        return;
    }
    type_10 _e24 = input;
    local = _e24;
    type_10 _e26 = local;
    local_88 = _e26;
    uint _e29 = local_88.inner[0];
    local_89 = static_cast<uint>(_e29);
    uint _e33 = local_88.inner[1];
    local_90 = static_cast<uint>(_e33);
    uint _e37 = local_88.inner[2];
    local_91 = static_cast<uint>(_e37);
    int _e42 = input_1[index_10];
    int value = _e42 & 255;
    small.inner[0] = value;
    small.inner[1] = as_type<int>(as_type<uint>(value) + as_type<uint>(1));
    small.inner[2] = as_type<int>(as_type<uint>(value) + as_type<uint>(2));
    large.inner[0] = as_type<int>(as_type<uint>(value) + as_type<uint>(3));
    large.inner[1] = as_type<int>(as_type<uint>(value) + as_type<uint>(4));
    large.inner[2] = as_type<int>(as_type<uint>(value) + as_type<uint>(5));
    large.inner[3] = as_type<int>(as_type<uint>(value) + as_type<uint>(6));
    large.inner[4] = as_type<int>(as_type<uint>(value) + as_type<uint>(7));
    view = type_10 {};
    view.inner[0] = 4u;
    view.inner[1] = 0u;
    type_10 _e76 = view;
    local_1 = _e76;
    index = uint {};
    local_56 = uint {};
    local_57 = int {};
    type_10 _e86 = local_1;
    view_1 = _e86;
    index = static_cast<uint>(1);
    type_10 _e90 = view_1;
    local_55 = _e90;
    uint _e92 = index;
    local_56 = _e92;
    type_10 _e94 = local_55;
    local_92 = _e94;
    uint _e97 = local_92.inner[0];
    local_93 = static_cast<uint>(_e97);
    uint _e101 = local_92.inner[1];
    local_94 = static_cast<uint>(_e101);
    uint _e105 = local_92.inner[2];
    local_95 = static_cast<uint>(_e105);
    uint _e108 = local_93;
    switch(_e108) {
        case 4u: {
            uint _e109 = local_56;
            int _e111 = small.inner[_e109];
            local_96 = _e111;
            break;
        }
        default: {
            uint _e113 = local_56;
            int _e115 = large.inner[_e113];
            local_96 = _e115;
            break;
        }
    }
    int _e118 = local_96;
    local_57 = _e118;
    int before = local_57;
    type_10 _e121 = view;
    local_2 = _e121;
    type_10 _e123 = local_2;
    snapshot = _e123;
    local_97 = type_10 {};
    local_97.inner[0] = 5u;
    local_97.inner[1] = 0u;
    type_10 _e131 = local_97;
    view = _e131;
    type_10 _e132 = view;
    local_3 = _e132;
    type_10 _e134 = local_3;
    large_view = _e134;
    type_10 _e136 = view;
    local_4 = _e136;
    index_1 = uint {};
    local_59 = uint {};
    local_60 = int {};
    type_10 _e146 = local_4;
    view_2 = _e146;
    index_1 = static_cast<uint>(3);
    type_10 _e150 = view_2;
    local_58 = _e150;
    uint _e152 = index_1;
    local_59 = _e152;
    type_10 _e154 = local_58;
    local_98 = _e154;
    uint _e157 = local_98.inner[0];
    local_99 = static_cast<uint>(_e157);
    uint _e161 = local_98.inner[1];
    local_100 = static_cast<uint>(_e161);
    uint _e165 = local_98.inner[2];
    local_101 = static_cast<uint>(_e165);
    uint _e168 = local_99;
    switch(_e168) {
        case 4u: {
            uint _e169 = local_59;
            int _e171 = small.inner[_e169];
            local_102 = _e171;
            break;
        }
        default: {
            uint _e173 = local_59;
            int _e175 = large.inner[_e173];
            local_102 = _e175;
            break;
        }
    }
    int _e178 = local_102;
    local_60 = _e178;
    int after = local_60;
    if ((index_10 & 1u) == 0u) {
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
            type_10 _e207 = view;
            local_7 = _e207;
            break;
        }
        default: {
            type_10 _e210 = snapshot;
            local_7 = _e210;
            break;
        }
    }
    type_10 _e213 = local_7;
    selected = _e213;
    type_10 _e216 = selected;
    local_8 = _e216;
    uint _e219 = static_cast<uint>(1);
    type_10 _e220 = local_8;
    local_104 = _e220;
    uint _e223 = local_104.inner[0];
    local_105 = static_cast<uint>(_e223);
    uint _e227 = local_104.inner[1];
    local_106 = static_cast<uint>(_e227);
    uint _e231 = local_104.inner[2];
    local_107 = static_cast<uint>(_e231);
    uint _e234 = local_105;
    switch(_e234) {
        case 4u: {
            int _e236 = small.inner[_e219];
            local_108 = _e236;
            break;
        }
        default: {
            int _e239 = large.inner[_e219];
            local_108 = _e239;
            break;
        }
    }
    int _e242 = local_108;
    int _e244 = as_type<int>(as_type<uint>(_e242) + as_type<uint>(7));
    uint _e245 = local_105;
    switch(_e245) {
        case 4u: {
            small.inner[_e219] = _e244;
            break;
        }
        default: {
            large.inner[_e219] = _e244;
            break;
        }
    }
    nullable = type_10 {};
    nullable.inner[0] = 1u;
    if (naga_mod(index_10, 3u) != 0u) {
        type_10 _e256 = selected;
        local_9 = _e256;
        type_10 _e258 = local_9;
        local_109 = _e258;
        type_10 _e260 = local_109;
        nullable = _e260;
    }
    optional = naga_neg(1);
    type_10 _e266 = nullable;
    local_10 = _e266;
    type_10 _e268 = local_10;
    local_110 = _e268;
    uint _e271 = local_110.inner[0];
    local_11 = _e271 != 1u;
    bool _e275 = local_11;
    if (_e275) {
        type_10 _e276 = nullable;
        local_12 = _e276;
        index_2 = uint {};
        local_63 = uint {};
        local_64 = int {};
        type_10 _e286 = local_12;
        view_3 = _e286;
        index_2 = static_cast<uint>(0);
        type_10 _e290 = view_3;
        local_62 = _e290;
        uint _e292 = index_2;
        local_63 = _e292;
        type_10 _e294 = local_62;
        local_111 = _e294;
        uint _e297 = local_111.inner[0];
        local_112 = static_cast<uint>(_e297);
        uint _e301 = local_111.inner[1];
        local_113 = static_cast<uint>(_e301);
        uint _e305 = local_111.inner[2];
        local_114 = static_cast<uint>(_e305);
        local_115 = int {};
        uint _e310 = local_112;
        switch(_e310) {
            case 4u: {
                uint _e311 = local_63;
                int _e313 = small.inner[_e311];
                local_115 = _e313;
                break;
            }
            case 5u: {
                uint _e314 = local_63;
                int _e316 = large.inner[_e314];
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
    type_10 _e324 = selected;
    local_14 = _e324;
    type_10 _e326 = local_14;
    roundtrip = _e326;
    pairs.inner[0].inner[0] = as_type<int>(as_type<uint>(value) + as_type<uint>(8));
    pairs.inner[0].inner[1] = as_type<int>(as_type<uint>(value) + as_type<uint>(9));
    pairs.inner[1].inner[0] = as_type<int>(as_type<uint>(value) + as_type<uint>(10));
    pairs.inner[1].inner[1] = as_type<int>(as_type<uint>(value) + as_type<uint>(11));
    local_15 = static_cast<uint>(1);
    row = type_10 {};
    row.inner[0] = 6u;
    row.inner[1] = 0u;
    uint _e352 = local_15;
    uint _e354 = row.inner[1];
    row.inner[1] = _e354 + _e352;
    type_10 _e358 = row;
    local_16 = _e358;
    type_10 _e360 = local_16;
    row_view = _e360;
    type_10 _e363 = row_view;
    local_17 = _e363;
    index_3 = uint {};
    local_67 = uint {};
    local_68 = int {};
    type_10 _e373 = local_17;
    view_4 = _e373;
    index_3 = static_cast<uint>(0);
    type_10 _e377 = view_4;
    local_66 = _e377;
    uint _e379 = index_3;
    local_67 = _e379;
    type_10 _e381 = local_66;
    local_116 = _e381;
    uint _e384 = local_116.inner[0];
    local_117 = static_cast<uint>(_e384);
    uint _e388 = local_116.inner[1];
    local_118 = static_cast<uint>(_e388);
    uint _e392 = local_116.inner[2];
    local_119 = static_cast<uint>(_e392);
    uint _e395 = local_118;
    uint _e397 = local_67;
    int _e399 = pairs.inner[_e395].inner[_e397];
    local_68 = _e399;
    int row_first = local_68;
    type_10 _e402 = row_view;
    local_18 = _e402;
    index_4 = uint {};
    local_70 = uint {};
    local_71 = int {};
    type_10 _e412 = local_18;
    view_5 = _e412;
    index_4 = static_cast<uint>(1);
    type_10 _e416 = view_5;
    local_69 = _e416;
    uint _e418 = index_4;
    local_70 = _e418;
    type_10 _e420 = local_69;
    local_120 = _e420;
    uint _e423 = local_120.inner[0];
    local_121 = static_cast<uint>(_e423);
    uint _e427 = local_120.inner[1];
    local_122 = static_cast<uint>(_e427);
    uint _e431 = local_120.inner[2];
    local_123 = static_cast<uint>(_e431);
    uint _e434 = local_122;
    uint _e436 = local_70;
    int _e438 = pairs.inner[_e434].inner[_e436];
    local_71 = _e438;
    int row_second = local_71;
    type_10 _e441 = row_view;
    local_19 = _e441;
    type_10 _e443 = local_19;
    local_124 = _e443;
    uint _e446 = local_124.inner[0];
    local_125 = static_cast<uint>(_e446);
    uint _e450 = local_124.inner[1];
    local_126 = static_cast<uint>(_e450);
    uint _e454 = local_124.inner[2];
    local_127 = static_cast<uint>(_e454);
    elements = type_10 {};
    elements.inner[0] = 7u;
    elements.inner[1] = 0u;
    uint _e463 = local_126;
    elements.inner[2] = _e463;
    uint _e467 = elements.inner[1];
    elements.inner[1] = _e467 + 1u;
    type_10 _e471 = elements;
    local_20 = _e471;
    type_10 _e473 = local_20;
    local_128 = _e473;
    uint _e476 = local_128.inner[0];
    local_129 = static_cast<uint>(_e476);
    uint _e480 = local_128.inner[1];
    local_130 = static_cast<uint>(_e480);
    uint _e484 = local_128.inner[2];
    local_131 = static_cast<uint>(_e484);
    uint _e487 = local_131;
    uint _e489 = local_130;
    int _e491 = pairs.inner[_e487].inner[_e489];
    uint _e494 = local_131;
    uint _e496 = local_130;
    pairs.inner[_e494].inner[_e496] = as_type<int>(as_type<uint>(_e491) + as_type<uint>(1));
    {
        phase = static_cast<uint>(0);
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e541 = phase;
                phase = _e541 + static_cast<uint>(1);
            }
            loop_init = false;
            uint _e501 = phase;
            if (_e501 < 3u) {
            } else {
                break;
            }
            uint _e504 = phase;
            if ((_e504 & 1u) == 0u) {
                local_22 = 6u;
                local_21 = 1u;
            } else {
                local_22 = 8u;
                local_21 = 0u;
            }
            uint _e518 = local_22;
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
            switch(_e530) {
                case 13u: {
                    type_10 _e532 = snapshot;
                    local_23 = _e532;
                    break;
                }
                default: {
                    type_10 _e535 = large_view;
                    local_23 = _e535;
                    break;
                }
            }
            type_10 _e538 = local_23;
            local_133 = _e538;
            type_10 _e540 = local_133;
            view = _e540;
        }
    }
    uint base = (index_10 + 1u) * 12u;
    type_10 _e550 = output;
    local_24 = _e550;
    type_10 _e552 = local_24;
    local_134 = _e552;
    uint _e555 = local_134.inner[0];
    local_135 = static_cast<uint>(_e555);
    uint _e559 = local_134.inner[1];
    local_136 = static_cast<uint>(_e559);
    uint _e563 = local_134.inner[2];
    local_137 = static_cast<uint>(_e563);
    output_1[base] = before;
    type_10 _e568 = output;
    local_25 = _e568;
    local_26 = static_cast<uint>(base + 1u);
    type_10 _e574 = local_25;
    local_138 = _e574;
    uint _e577 = local_138.inner[0];
    local_139 = static_cast<uint>(_e577);
    uint _e581 = local_138.inner[1];
    local_140 = static_cast<uint>(_e581);
    uint _e585 = local_138.inner[2];
    local_141 = static_cast<uint>(_e585);
    uint _e588 = local_26;
    output_1[_e588] = after;
    type_10 _e591 = snapshot;
    local_29 = _e591;
    index_5 = uint {};
    local_74 = uint {};
    local_75 = int {};
    type_10 _e601 = local_29;
    view_6 = _e601;
    index_5 = static_cast<uint>(1);
    type_10 _e605 = view_6;
    local_73 = _e605;
    uint _e607 = index_5;
    local_74 = _e607;
    type_10 _e609 = local_73;
    local_142 = _e609;
    uint _e612 = local_142.inner[0];
    local_143 = static_cast<uint>(_e612);
    uint _e616 = local_142.inner[1];
    local_144 = static_cast<uint>(_e616);
    uint _e620 = local_142.inner[2];
    local_145 = static_cast<uint>(_e620);
    uint _e623 = local_143;
    switch(_e623) {
        case 4u: {
            uint _e624 = local_74;
            int _e626 = small.inner[_e624];
            local_146 = _e626;
            break;
        }
        default: {
            uint _e628 = local_74;
            int _e630 = large.inner[_e628];
            local_146 = _e630;
            break;
        }
    }
    int _e633 = local_146;
    local_75 = _e633;
    int _e635 = local_75;
    type_10 _e636 = output;
    local_27 = _e636;
    local_28 = static_cast<uint>(base + 2u);
    type_10 _e642 = local_27;
    local_147 = _e642;
    uint _e645 = local_147.inner[0];
    local_148 = static_cast<uint>(_e645);
    uint _e649 = local_147.inner[1];
    local_149 = static_cast<uint>(_e649);
    uint _e653 = local_147.inner[2];
    local_150 = static_cast<uint>(_e653);
    uint _e656 = local_28;
    output_1[_e656] = _e635;
    type_10 _e659 = large_view;
    local_32 = _e659;
    index_6 = uint {};
    local_77 = uint {};
    local_78 = int {};
    type_10 _e669 = local_32;
    view_7 = _e669;
    index_6 = static_cast<uint>(1);
    type_10 _e673 = view_7;
    local_76 = _e673;
    uint _e675 = index_6;
    local_77 = _e675;
    type_10 _e677 = local_76;
    local_151 = _e677;
    uint _e680 = local_151.inner[0];
    local_152 = static_cast<uint>(_e680);
    uint _e684 = local_151.inner[1];
    local_153 = static_cast<uint>(_e684);
    uint _e688 = local_151.inner[2];
    local_154 = static_cast<uint>(_e688);
    uint _e691 = local_152;
    switch(_e691) {
        case 4u: {
            uint _e692 = local_77;
            int _e694 = small.inner[_e692];
            local_155 = _e694;
            break;
        }
        default: {
            uint _e696 = local_77;
            int _e698 = large.inner[_e696];
            local_155 = _e698;
            break;
        }
    }
    int _e701 = local_155;
    local_78 = _e701;
    int _e703 = local_78;
    type_10 _e704 = output;
    local_30 = _e704;
    local_31 = static_cast<uint>(base + 3u);
    type_10 _e710 = local_30;
    local_156 = _e710;
    uint _e713 = local_156.inner[0];
    local_157 = static_cast<uint>(_e713);
    uint _e717 = local_156.inner[1];
    local_158 = static_cast<uint>(_e717);
    uint _e721 = local_156.inner[2];
    local_159 = static_cast<uint>(_e721);
    uint _e724 = local_31;
    output_1[_e724] = _e703;
    type_10 _e726 = selected;
    local_35 = _e726;
    index_7 = uint {};
    local_80 = uint {};
    local_81 = int {};
    type_10 _e736 = local_35;
    view_8 = _e736;
    index_7 = static_cast<uint>(1);
    type_10 _e740 = view_8;
    local_79 = _e740;
    uint _e742 = index_7;
    local_80 = _e742;
    type_10 _e744 = local_79;
    local_160 = _e744;
    uint _e747 = local_160.inner[0];
    local_161 = static_cast<uint>(_e747);
    uint _e751 = local_160.inner[1];
    local_162 = static_cast<uint>(_e751);
    uint _e755 = local_160.inner[2];
    local_163 = static_cast<uint>(_e755);
    uint _e758 = local_161;
    switch(_e758) {
        case 4u: {
            uint _e759 = local_80;
            int _e761 = small.inner[_e759];
            local_164 = _e761;
            break;
        }
        default: {
            uint _e763 = local_80;
            int _e765 = large.inner[_e763];
            local_164 = _e765;
            break;
        }
    }
    int _e768 = local_164;
    local_81 = _e768;
    int _e770 = local_81;
    type_10 _e771 = output;
    local_33 = _e771;
    local_34 = static_cast<uint>(base + 4u);
    type_10 _e777 = local_33;
    local_165 = _e777;
    uint _e780 = local_165.inner[0];
    local_166 = static_cast<uint>(_e780);
    uint _e784 = local_165.inner[1];
    local_167 = static_cast<uint>(_e784);
    uint _e788 = local_165.inner[2];
    local_168 = static_cast<uint>(_e788);
    uint _e791 = local_34;
    output_1[_e791] = _e770;
    int _e793 = optional;
    type_10 _e794 = output;
    local_36 = _e794;
    local_37 = static_cast<uint>(base + 5u);
    type_10 _e800 = local_36;
    local_169 = _e800;
    uint _e803 = local_169.inner[0];
    local_170 = static_cast<uint>(_e803);
    uint _e807 = local_169.inner[1];
    local_171 = static_cast<uint>(_e807);
    uint _e811 = local_169.inner[2];
    local_172 = static_cast<uint>(_e811);
    uint _e814 = local_37;
    output_1[_e814] = _e793;
    type_10 _e817 = roundtrip;
    local_40 = _e817;
    index_8 = uint {};
    local_83 = uint {};
    local_84 = int {};
    type_10 _e827 = local_40;
    view_9 = _e827;
    index_8 = static_cast<uint>(0);
    type_10 _e831 = view_9;
    local_82 = _e831;
    uint _e833 = index_8;
    local_83 = _e833;
    type_10 _e835 = local_82;
    local_173 = _e835;
    uint _e838 = local_173.inner[0];
    local_174 = static_cast<uint>(_e838);
    uint _e842 = local_173.inner[1];
    local_175 = static_cast<uint>(_e842);
    uint _e846 = local_173.inner[2];
    local_176 = static_cast<uint>(_e846);
    uint _e849 = local_174;
    switch(_e849) {
        case 4u: {
            uint _e850 = local_83;
            int _e852 = small.inner[_e850];
            local_177 = _e852;
            break;
        }
        default: {
            uint _e854 = local_83;
            int _e856 = large.inner[_e854];
            local_177 = _e856;
            break;
        }
    }
    int _e859 = local_177;
    local_84 = _e859;
    int _e861 = local_84;
    type_10 _e862 = output;
    local_38 = _e862;
    local_39 = static_cast<uint>(base + 6u);
    type_10 _e868 = local_38;
    local_178 = _e868;
    uint _e871 = local_178.inner[0];
    local_179 = static_cast<uint>(_e871);
    uint _e875 = local_178.inner[1];
    local_180 = static_cast<uint>(_e875);
    uint _e879 = local_178.inner[2];
    local_181 = static_cast<uint>(_e879);
    uint _e882 = local_39;
    output_1[_e882] = _e861;
    type_10 _e884 = nullable;
    local_43 = _e884;
    type_10 _e886 = local_43;
    local_182 = _e886;
    uint _e889 = local_182.inner[0];
    local_44 = _e889 != 1u;
    bool _e893 = local_44;
    type_10 _e894 = output;
    local_41 = _e894;
    local_42 = static_cast<uint>(base + 7u);
    type_10 _e901 = local_41;
    local_183 = _e901;
    uint _e904 = local_183.inner[0];
    local_184 = static_cast<uint>(_e904);
    uint _e908 = local_183.inner[1];
    local_185 = static_cast<uint>(_e908);
    uint _e912 = local_183.inner[2];
    local_186 = static_cast<uint>(_e912);
    uint _e915 = local_42;
    output_1[_e915] = static_cast<int>(_e893);
    type_10 _e917 = output;
    local_45 = _e917;
    local_46 = static_cast<uint>(base + 8u);
    type_10 _e923 = local_45;
    local_187 = _e923;
    uint _e926 = local_187.inner[0];
    local_188 = static_cast<uint>(_e926);
    uint _e930 = local_187.inner[1];
    local_189 = static_cast<uint>(_e930);
    uint _e934 = local_187.inner[2];
    local_190 = static_cast<uint>(_e934);
    uint _e937 = local_46;
    output_1[_e937] = row_first;
    type_10 _e939 = output;
    local_47 = _e939;
    local_48 = static_cast<uint>(base + 9u);
    type_10 _e945 = local_47;
    local_191 = _e945;
    uint _e948 = local_191.inner[0];
    local_192 = static_cast<uint>(_e948);
    uint _e952 = local_191.inner[1];
    local_193 = static_cast<uint>(_e952);
    uint _e956 = local_191.inner[2];
    local_194 = static_cast<uint>(_e956);
    uint _e959 = local_48;
    output_1[_e959] = row_second;
    type_10 _e961 = elements;
    local_51 = _e961;
    type_10 _e963 = local_51;
    local_195 = _e963;
    uint _e966 = local_195.inner[0];
    local_196 = static_cast<uint>(_e966);
    uint _e970 = local_195.inner[1];
    local_197 = static_cast<uint>(_e970);
    uint _e974 = local_195.inner[2];
    local_198 = static_cast<uint>(_e974);
    uint _e977 = local_198;
    uint _e979 = local_197;
    int _e981 = pairs.inner[_e977].inner[_e979];
    type_10 _e982 = output;
    local_49 = _e982;
    local_50 = static_cast<uint>(base + 10u);
    type_10 _e988 = local_49;
    local_199 = _e988;
    uint _e991 = local_199.inner[0];
    local_200 = static_cast<uint>(_e991);
    uint _e995 = local_199.inner[1];
    local_201 = static_cast<uint>(_e995);
    uint _e999 = local_199.inner[2];
    local_202 = static_cast<uint>(_e999);
    uint _e1002 = local_50;
    output_1[_e1002] = _e981;
    type_10 _e1004 = view;
    local_54 = _e1004;
    index_9 = uint {};
    local_86 = uint {};
    local_87 = int {};
    type_10 _e1014 = local_54;
    view_10 = _e1014;
    index_9 = static_cast<uint>(1);
    type_10 _e1018 = view_10;
    local_85 = _e1018;
    uint _e1020 = index_9;
    local_86 = _e1020;
    type_10 _e1022 = local_85;
    local_203 = _e1022;
    uint _e1025 = local_203.inner[0];
    local_204 = static_cast<uint>(_e1025);
    uint _e1029 = local_203.inner[1];
    local_205 = static_cast<uint>(_e1029);
    uint _e1033 = local_203.inner[2];
    local_206 = static_cast<uint>(_e1033);
    uint _e1036 = local_204;
    switch(_e1036) {
        case 4u: {
            uint _e1037 = local_86;
            int _e1039 = small.inner[_e1037];
            local_207 = _e1039;
            break;
        }
        default: {
            uint _e1041 = local_86;
            int _e1043 = large.inner[_e1041];
            local_207 = _e1043;
            break;
        }
    }
    int _e1046 = local_207;
    local_87 = _e1046;
    int _e1048 = local_87;
    type_10 _e1049 = output;
    local_52 = _e1049;
    local_53 = static_cast<uint>(base + 11u);
    type_10 _e1055 = local_52;
    local_208 = _e1055;
    uint _e1058 = local_208.inner[0];
    local_209 = static_cast<uint>(_e1058);
    uint _e1062 = local_208.inner[1];
    local_210 = static_cast<uint>(_e1062);
    uint _e1066 = local_208.inner[2];
    local_211 = static_cast<uint>(_e1066);
    uint _e1069 = local_53;
    output_1[_e1069] = _e1048;
}
