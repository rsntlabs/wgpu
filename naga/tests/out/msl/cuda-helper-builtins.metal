// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size3;
    uint size5;
    uint size7;
};

typedef int type_4[1];
struct type_5 {
    float value;
    char _pad1[12];
};
struct float3_ {
    float x;
    float y;
    float z;
};
typedef float3_ type_6[1];
struct type_7 {
    uint value;
    char _pad1[12];
};
typedef uint type_8[1];
struct type_9 {
    uint inner[2];
};

uint thread_component(
    uint axis,
    thread metal::uint3& threadIdx_1
) {
    uint axis_1 = {};
    axis_1 = axis;
    uint _e3 = axis_1;
    if (_e3 == 0u) {
        metal::uint3 _e6 = threadIdx_1;
        return _e6.x;
    }
    uint _e9 = axis_1;
    if (_e9 == 1u) {
        metal::uint3 _e12 = threadIdx_1;
        return _e12.y;
    }
    metal::uint3 _e15 = threadIdx_1;
    return _e15.z;
}

uint group_component(
    uint axis_2,
    thread metal::uint3& blockIdx_1
) {
    uint axis_3 = {};
    axis_3 = axis_2;
    uint _e3 = axis_3;
    if (_e3 == 0u) {
        metal::uint3 _e6 = blockIdx_1;
        return _e6.x;
    }
    uint _e9 = axis_3;
    if (_e9 == 1u) {
        metal::uint3 _e12 = blockIdx_1;
        return _e12.y;
    }
    metal::uint3 _e15 = blockIdx_1;
    return _e15.z;
}

uint shape_component(
    uint axis_4
) {
    uint axis_5 = {};
    axis_5 = axis_4;
    uint _e3 = axis_5;
    if (_e3 == 0u) {
        return 1u;
    }
    uint _e7 = axis_5;
    if (_e7 == 1u) {
        return 1u;
    }
    return 1u;
}

uint grid_component(
    uint axis_6,
    thread metal::uint3& gridDim_1
) {
    uint axis_7 = {};
    axis_7 = axis_6;
    uint _e3 = axis_7;
    if (_e3 == 0u) {
        metal::uint3 _e6 = gridDim_1;
        return _e6.x;
    }
    uint _e9 = axis_7;
    if (_e9 == 1u) {
        metal::uint3 _e12 = gridDim_1;
        return _e12.y;
    }
    metal::uint3 _e15 = gridDim_1;
    return _e15.z;
}

uint component(
    uint axis_8,
    thread metal::uint3& threadIdx_1
) {
    uint axis_9 = {};
    axis_9 = axis_8;
    uint _e2 = axis_9;
    uint _e3 = thread_component(_e2, threadIdx_1);
    return _e3;
}

float component_1(
    float offset,
    thread metal::uint3& blockIdx_1
) {
    float offset_1 = {};
    offset_1 = offset;
    metal::uint3 _e3 = blockIdx_1;
    float _e6 = offset_1;
    return static_cast<float>(_e3.x) + _e6;
}

uint global_x(
    thread metal::uint3& threadIdx_1,
    thread metal::uint3& blockIdx_1
) {
    uint _e1 = group_component(0u, blockIdx_1);
    uint _e3 = shape_component(0u);
    uint _e6 = component(0u, threadIdx_1);
    return (_e1 * _e3) + _e6;
}

uint kind(
    uint value
) {
    uint value_1 = {};
    value_1 = value;
    return 11u;
}

void observe(
    thread metal::uint3& gridDim_1
) {
    metal::uint3 _e1 = gridDim_1;
    if (_e1.z != 0u) {
        return;
    } else {
        return;
    }
}

struct coordinatesInput {
};
kernel void coordinates(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 gridDim [[threadgroups_per_grid]]
, device type_4 const& input [[user(fake0)]]
, constant type_5& scale_1 [[user(fake0)]]
, device type_6 const& points [[user(fake0)]]
, constant type_7& limit_1 [[user(fake0)]]
, device type_8& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::uint3 threadIdx_1 = {};
    metal::uint3 blockIdx_1 = {};
    metal::uint3 gridDim_1 = {};
    type_9 local = {};
    float scale = {};
    type_9 local_1 = {};
    uint limit = {};
    type_9 local_2 = {};
    type_9 local_3 = {};
    uint local_4 = {};
    type_9 local_5 = {};
    uint local_6 = {};
    type_9 local_7 = {};
    uint local_8 = {};
    type_9 local_9 = {};
    uint local_10 = {};
    type_9 local_11 = {};
    uint local_12 = {};
    type_9 local_13 = {};
    uint local_14 = {};
    type_9 local_15 = {};
    uint local_16 = {};
    type_9 local_17 = {};
    uint local_18 = {};
    type_9 local_19 = {};
    uint local_20 = {};
    type_9 local_21 = {};
    uint local_22 = {};
    type_9 local_23 = {};
    uint local_24 = {};
    type_9 local_25 = {};
    uint local_26 = {};
    type_9 local_27 = {};
    uint local_28 = {};
    type_9 local_29 = {};
    uint local_30 = {};
    type_9 local_31 = {};
    uint local_32 = {};
    type_9 local_33 = {};
    uint local_34 = {};
    type_9 local_35 = {};
    uint local_36 = {};
    type_9 local_37 = {};
    uint local_38 = {};
    type_9 local_39 = {};
    uint local_40 = {};
    type_9 local_41 = {};
    uint local_42 = {};
    type_9 local_43 = {};
    uint local_44 = {};
    type_9 local_45 = {};
    uint local_46 = {};
    type_9 local_47 = {};
    uint local_48 = {};
    type_9 local_49 = {};
    uint local_50 = {};
    type_9 local_51 = {};
    uint local_52 = {};
    type_9 local_53 = {};
    uint local_54 = {};
    type_9 local_55 = {};
    uint local_56 = {};
    type_9 local_57 = {};
    uint local_58 = {};
    type_9 local_59 = {};
    uint local_60 = {};
    type_9 local_61 = {};
    uint local_62 = {};
    type_9 local_63 = {};
    uint local_64 = {};
    type_9 local_65 = {};
    uint local_66 = {};
    type_9 local_67 = {};
    uint local_68 = {};
    type_9 local_69 = {};
    uint local_70 = {};
    type_9 local_71 = {};
    uint local_72 = {};
    type_9 local_73 = {};
    uint local_74 = {};
    int local_75 = {};
    float local_76 = {};
    float local_77 = {};
    float local_78 = {};
    int local_79 = {};
    float local_80 = {};
    type_9 local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    type_9 local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    type_9 local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    type_9 local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    type_9 local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    type_9 local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    type_9 local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    type_9 local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    type_9 local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    type_9 local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    type_9 local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    type_9 local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    type_9 local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    type_9 local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    type_9 local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    type_9 local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    type_9 local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    type_9 local_132 = {};
    uint local_133 = {};
    uint local_134 = {};
    type_9 local_135 = {};
    uint local_136 = {};
    uint local_137 = {};
    type_9 local_138 = {};
    uint local_139 = {};
    uint local_140 = {};
    int local_141 = {};
    type_9 local_142 = {};
    uint local_143 = {};
    uint local_144 = {};
    type_9 local_145 = {};
    uint local_146 = {};
    uint local_147 = {};
    type_9 local_148 = {};
    uint local_149 = {};
    uint local_150 = {};
    float local_151 = {};
    type_9 local_152 = {};
    uint local_153 = {};
    uint local_154 = {};
    type_9 local_155 = {};
    uint local_156 = {};
    uint local_157 = {};
    float local_158 = {};
    type_9 local_159 = {};
    uint local_160 = {};
    uint local_161 = {};
    type_9 local_162 = {};
    uint local_163 = {};
    uint local_164 = {};
    float local_165 = {};
    type_9 local_166 = {};
    uint local_167 = {};
    uint local_168 = {};
    type_9 local_169 = {};
    uint local_170 = {};
    uint local_171 = {};
    type_9 local_172 = {};
    uint local_173 = {};
    uint local_174 = {};
    type_9 local_175 = {};
    uint local_176 = {};
    uint local_177 = {};
    type_9 local_178 = {};
    uint local_179 = {};
    uint local_180 = {};
    int local_181 = {};
    type_9 local_182 = {};
    uint local_183 = {};
    uint local_184 = {};
    float local_185 = {};
    type_9 local_186 = {};
    uint local_187 = {};
    uint local_188 = {};
    type_9 local_189 = {};
    uint local_190 = {};
    uint local_191 = {};
    type_9 local_192 = {};
    uint local_193 = {};
    uint local_194 = {};
    local = type_9 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    float _e12 = scale_1.value;
    scale = _e12;
    local_1 = type_9 {};
    local_1.inner[0] = 1u;
    local_1.inner[1] = 0u;
    uint _e23 = limit_1.value;
    limit = _e23;
    local_2 = type_9 {};
    local_2.inner[0] = 2u;
    local_2.inner[1] = 0u;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    gridDim_1 = gridDim;
    uint _e35 = global_x(threadIdx_1, blockIdx_1);
    uint _e36 = limit;
    if (_e35 >= _e36) {
        return;
    }
    observe(gridDim_1);
    uint _e39 = thread_component(0u, threadIdx_1);
    type_9 _e42 = local_2;
    local_3 = _e42;
    local_4 = static_cast<uint>(0);
    type_9 _e47 = local_3;
    local_81 = _e47;
    uint _e48 = local_4;
    uint _e50 = local_81.inner[1];
    local_81.inner[1] = _e50 + _e48;
    uint _e54 = local_81.inner[0];
    local_82 = static_cast<uint>(_e54);
    uint _e58 = local_81.inner[1];
    local_83 = static_cast<uint>(_e58);
    uint _e61 = local_83;
    out[_e61] = _e39;
    uint _e64 = thread_component(1u, threadIdx_1);
    type_9 _e66 = local_2;
    local_5 = _e66;
    local_6 = static_cast<uint>(1);
    type_9 _e71 = local_5;
    local_84 = _e71;
    uint _e72 = local_6;
    uint _e74 = local_84.inner[1];
    local_84.inner[1] = _e74 + _e72;
    uint _e78 = local_84.inner[0];
    local_85 = static_cast<uint>(_e78);
    uint _e82 = local_84.inner[1];
    local_86 = static_cast<uint>(_e82);
    uint _e85 = local_86;
    out[_e85] = _e64;
    uint _e88 = thread_component(2u, threadIdx_1);
    type_9 _e90 = local_2;
    local_7 = _e90;
    local_8 = static_cast<uint>(2);
    type_9 _e95 = local_7;
    local_87 = _e95;
    uint _e96 = local_8;
    uint _e98 = local_87.inner[1];
    local_87.inner[1] = _e98 + _e96;
    uint _e102 = local_87.inner[0];
    local_88 = static_cast<uint>(_e102);
    uint _e106 = local_87.inner[1];
    local_89 = static_cast<uint>(_e106);
    uint _e109 = local_89;
    out[_e109] = _e88;
    uint _e112 = group_component(0u, blockIdx_1);
    type_9 _e114 = local_2;
    local_9 = _e114;
    local_10 = static_cast<uint>(3);
    type_9 _e119 = local_9;
    local_90 = _e119;
    uint _e120 = local_10;
    uint _e122 = local_90.inner[1];
    local_90.inner[1] = _e122 + _e120;
    uint _e126 = local_90.inner[0];
    local_91 = static_cast<uint>(_e126);
    uint _e130 = local_90.inner[1];
    local_92 = static_cast<uint>(_e130);
    uint _e133 = local_92;
    out[_e133] = _e112;
    uint _e136 = group_component(1u, blockIdx_1);
    type_9 _e138 = local_2;
    local_11 = _e138;
    local_12 = static_cast<uint>(4);
    type_9 _e143 = local_11;
    local_93 = _e143;
    uint _e144 = local_12;
    uint _e146 = local_93.inner[1];
    local_93.inner[1] = _e146 + _e144;
    uint _e150 = local_93.inner[0];
    local_94 = static_cast<uint>(_e150);
    uint _e154 = local_93.inner[1];
    local_95 = static_cast<uint>(_e154);
    uint _e157 = local_95;
    out[_e157] = _e136;
    uint _e160 = group_component(2u, blockIdx_1);
    type_9 _e162 = local_2;
    local_13 = _e162;
    local_14 = static_cast<uint>(5);
    type_9 _e167 = local_13;
    local_96 = _e167;
    uint _e168 = local_14;
    uint _e170 = local_96.inner[1];
    local_96.inner[1] = _e170 + _e168;
    uint _e174 = local_96.inner[0];
    local_97 = static_cast<uint>(_e174);
    uint _e178 = local_96.inner[1];
    local_98 = static_cast<uint>(_e178);
    uint _e181 = local_98;
    out[_e181] = _e160;
    uint _e184 = shape_component(0u);
    type_9 _e186 = local_2;
    local_15 = _e186;
    local_16 = static_cast<uint>(6);
    type_9 _e191 = local_15;
    local_99 = _e191;
    uint _e192 = local_16;
    uint _e194 = local_99.inner[1];
    local_99.inner[1] = _e194 + _e192;
    uint _e198 = local_99.inner[0];
    local_100 = static_cast<uint>(_e198);
    uint _e202 = local_99.inner[1];
    local_101 = static_cast<uint>(_e202);
    uint _e205 = local_101;
    out[_e205] = _e184;
    uint _e208 = shape_component(1u);
    type_9 _e210 = local_2;
    local_17 = _e210;
    local_18 = static_cast<uint>(7);
    type_9 _e215 = local_17;
    local_102 = _e215;
    uint _e216 = local_18;
    uint _e218 = local_102.inner[1];
    local_102.inner[1] = _e218 + _e216;
    uint _e222 = local_102.inner[0];
    local_103 = static_cast<uint>(_e222);
    uint _e226 = local_102.inner[1];
    local_104 = static_cast<uint>(_e226);
    uint _e229 = local_104;
    out[_e229] = _e208;
    uint _e232 = shape_component(2u);
    type_9 _e234 = local_2;
    local_19 = _e234;
    local_20 = static_cast<uint>(8);
    type_9 _e239 = local_19;
    local_105 = _e239;
    uint _e240 = local_20;
    uint _e242 = local_105.inner[1];
    local_105.inner[1] = _e242 + _e240;
    uint _e246 = local_105.inner[0];
    local_106 = static_cast<uint>(_e246);
    uint _e250 = local_105.inner[1];
    local_107 = static_cast<uint>(_e250);
    uint _e253 = local_107;
    out[_e253] = _e232;
    uint _e256 = grid_component(0u, gridDim_1);
    type_9 _e258 = local_2;
    local_21 = _e258;
    local_22 = static_cast<uint>(9);
    type_9 _e263 = local_21;
    local_108 = _e263;
    uint _e264 = local_22;
    uint _e266 = local_108.inner[1];
    local_108.inner[1] = _e266 + _e264;
    uint _e270 = local_108.inner[0];
    local_109 = static_cast<uint>(_e270);
    uint _e274 = local_108.inner[1];
    local_110 = static_cast<uint>(_e274);
    uint _e277 = local_110;
    out[_e277] = _e256;
    uint _e280 = grid_component(1u, gridDim_1);
    type_9 _e282 = local_2;
    local_23 = _e282;
    local_24 = static_cast<uint>(10);
    type_9 _e287 = local_23;
    local_111 = _e287;
    uint _e288 = local_24;
    uint _e290 = local_111.inner[1];
    local_111.inner[1] = _e290 + _e288;
    uint _e294 = local_111.inner[0];
    local_112 = static_cast<uint>(_e294);
    uint _e298 = local_111.inner[1];
    local_113 = static_cast<uint>(_e298);
    uint _e301 = local_113;
    out[_e301] = _e280;
    uint _e304 = grid_component(2u, gridDim_1);
    type_9 _e306 = local_2;
    local_25 = _e306;
    local_26 = static_cast<uint>(11);
    type_9 _e311 = local_25;
    local_114 = _e311;
    uint _e312 = local_26;
    uint _e314 = local_114.inner[1];
    local_114.inner[1] = _e314 + _e312;
    uint _e318 = local_114.inner[0];
    local_115 = static_cast<uint>(_e318);
    uint _e322 = local_114.inner[1];
    local_116 = static_cast<uint>(_e322);
    uint _e325 = local_116;
    out[_e325] = _e304;
    uint _e327 = global_x(threadIdx_1, blockIdx_1);
    type_9 _e329 = local_2;
    local_27 = _e329;
    local_28 = static_cast<uint>(12);
    type_9 _e334 = local_27;
    local_117 = _e334;
    uint _e335 = local_28;
    uint _e337 = local_117.inner[1];
    local_117.inner[1] = _e337 + _e335;
    uint _e341 = local_117.inner[0];
    local_118 = static_cast<uint>(_e341);
    uint _e345 = local_117.inner[1];
    local_119 = static_cast<uint>(_e345);
    uint _e348 = local_119;
    out[_e348] = _e327;
    uint _e351 = component(0u, threadIdx_1);
    type_9 _e353 = local_2;
    local_29 = _e353;
    local_30 = static_cast<uint>(13);
    type_9 _e358 = local_29;
    local_120 = _e358;
    uint _e359 = local_30;
    uint _e361 = local_120.inner[1];
    local_120.inner[1] = _e361 + _e359;
    uint _e365 = local_120.inner[0];
    local_121 = static_cast<uint>(_e365);
    uint _e369 = local_120.inner[1];
    local_122 = static_cast<uint>(_e369);
    uint _e372 = local_122;
    out[_e372] = _e351;
    float _e375 = component_1(2.5, blockIdx_1);
    type_9 _e378 = local_2;
    local_31 = _e378;
    local_32 = static_cast<uint>(14);
    type_9 _e383 = local_31;
    local_123 = _e383;
    uint _e384 = local_32;
    uint _e386 = local_123.inner[1];
    local_123.inner[1] = _e386 + _e384;
    uint _e390 = local_123.inner[0];
    local_124 = static_cast<uint>(_e390);
    uint _e394 = local_123.inner[1];
    local_125 = static_cast<uint>(_e394);
    uint _e397 = local_125;
    out[_e397] = as_type<uint>(_e375);
    type_9 _e401 = local_2;
    local_33 = _e401;
    local_34 = static_cast<uint>(15);
    type_9 _e406 = local_33;
    local_126 = _e406;
    uint _e407 = local_34;
    uint _e409 = local_126.inner[1];
    local_126.inner[1] = _e409 + _e407;
    uint _e413 = local_126.inner[0];
    local_127 = static_cast<uint>(_e413);
    uint _e417 = local_126.inner[1];
    local_128 = static_cast<uint>(_e417);
    uint _e420 = local_128;
    out[_e420] = threadIdx.x;
    type_9 _e424 = local_2;
    local_35 = _e424;
    local_36 = static_cast<uint>(16);
    type_9 _e429 = local_35;
    local_129 = _e429;
    uint _e430 = local_36;
    uint _e432 = local_129.inner[1];
    local_129.inner[1] = _e432 + _e430;
    uint _e436 = local_129.inner[0];
    local_130 = static_cast<uint>(_e436);
    uint _e440 = local_129.inner[1];
    local_131 = static_cast<uint>(_e440);
    uint _e443 = local_131;
    out[_e443] = blockIdx.y;
    type_9 _e447 = local_2;
    local_37 = _e447;
    local_38 = static_cast<uint>(17);
    type_9 _e452 = local_37;
    local_132 = _e452;
    uint _e453 = local_38;
    uint _e455 = local_132.inner[1];
    local_132.inner[1] = _e455 + _e453;
    uint _e459 = local_132.inner[0];
    local_133 = static_cast<uint>(_e459);
    uint _e463 = local_132.inner[1];
    local_134 = static_cast<uint>(_e463);
    uint _e466 = local_134;
    out[_e466] = gridDim.z;
    type_9 _e469 = local_2;
    local_39 = _e469;
    local_40 = static_cast<uint>(18);
    type_9 _e474 = local_39;
    local_135 = _e474;
    uint _e475 = local_40;
    uint _e477 = local_135.inner[1];
    local_135.inner[1] = _e477 + _e475;
    uint _e481 = local_135.inner[0];
    local_136 = static_cast<uint>(_e481);
    uint _e485 = local_135.inner[1];
    local_137 = static_cast<uint>(_e485);
    uint _e489 = local_137;
    out[_e489] = 1u;
    type_9 _e493 = local;
    local_43 = _e493;
    local_44 = static_cast<uint>(0);
    type_9 _e498 = local_43;
    local_138 = _e498;
    uint _e499 = local_44;
    uint _e501 = local_138.inner[1];
    local_138.inner[1] = _e501 + _e499;
    uint _e505 = local_138.inner[0];
    local_139 = static_cast<uint>(_e505);
    uint _e509 = local_138.inner[1];
    local_140 = static_cast<uint>(_e509);
    uint _e513 = local_140;
    int _e515 = input[_e513];
    local_141 = _e515;
    int _e516 = local_141;
    local_75 = _e516;
    int _e518 = local_75;
    type_9 _e521 = local_2;
    local_41 = _e521;
    local_42 = static_cast<uint>(19);
    type_9 _e526 = local_41;
    local_142 = _e526;
    uint _e527 = local_42;
    uint _e529 = local_142.inner[1];
    local_142.inner[1] = _e529 + _e527;
    uint _e533 = local_142.inner[0];
    local_143 = static_cast<uint>(_e533);
    uint _e537 = local_142.inner[1];
    local_144 = static_cast<uint>(_e537);
    uint _e540 = local_144;
    out[_e540] = static_cast<uint>(_e518);
    float _e542 = scale;
    type_9 _e545 = local_2;
    local_45 = _e545;
    local_46 = static_cast<uint>(20);
    type_9 _e550 = local_45;
    local_145 = _e550;
    uint _e551 = local_46;
    uint _e553 = local_145.inner[1];
    local_145.inner[1] = _e553 + _e551;
    uint _e557 = local_145.inner[0];
    local_146 = static_cast<uint>(_e557);
    uint _e561 = local_145.inner[1];
    local_147 = static_cast<uint>(_e561);
    uint _e564 = local_147;
    out[_e564] = as_type<uint>(_e542);
    type_9 _e568 = local_1;
    local_49 = _e568;
    local_50 = static_cast<uint>(0);
    type_9 _e573 = local_49;
    local_148 = _e573;
    uint _e574 = local_50;
    uint _e576 = local_148.inner[1];
    local_148.inner[1] = _e576 + _e574;
    uint _e580 = local_148.inner[0];
    local_149 = static_cast<uint>(_e580);
    uint _e584 = local_148.inner[1];
    local_150 = static_cast<uint>(_e584);
    uint _e588 = local_150;
    float _e591 = points[_e588].x;
    local_151 = _e591;
    float _e592 = local_151;
    local_76 = _e592;
    float _e594 = local_76;
    type_9 _e597 = local_2;
    local_47 = _e597;
    local_48 = static_cast<uint>(21);
    type_9 _e602 = local_47;
    local_152 = _e602;
    uint _e603 = local_48;
    uint _e605 = local_152.inner[1];
    local_152.inner[1] = _e605 + _e603;
    uint _e609 = local_152.inner[0];
    local_153 = static_cast<uint>(_e609);
    uint _e613 = local_152.inner[1];
    local_154 = static_cast<uint>(_e613);
    uint _e616 = local_154;
    out[_e616] = as_type<uint>(_e594);
    type_9 _e619 = local_1;
    local_53 = _e619;
    local_54 = static_cast<uint>(0);
    type_9 _e624 = local_53;
    local_155 = _e624;
    uint _e625 = local_54;
    uint _e627 = local_155.inner[1];
    local_155.inner[1] = _e627 + _e625;
    uint _e631 = local_155.inner[0];
    local_156 = static_cast<uint>(_e631);
    uint _e635 = local_155.inner[1];
    local_157 = static_cast<uint>(_e635);
    uint _e639 = local_157;
    float _e642 = points[_e639].y;
    local_158 = _e642;
    float _e643 = local_158;
    local_77 = _e643;
    float _e645 = local_77;
    type_9 _e648 = local_2;
    local_51 = _e648;
    local_52 = static_cast<uint>(22);
    type_9 _e653 = local_51;
    local_159 = _e653;
    uint _e654 = local_52;
    uint _e656 = local_159.inner[1];
    local_159.inner[1] = _e656 + _e654;
    uint _e660 = local_159.inner[0];
    local_160 = static_cast<uint>(_e660);
    uint _e664 = local_159.inner[1];
    local_161 = static_cast<uint>(_e664);
    uint _e667 = local_161;
    out[_e667] = as_type<uint>(_e645);
    type_9 _e670 = local_1;
    local_57 = _e670;
    local_58 = static_cast<uint>(0);
    type_9 _e675 = local_57;
    local_162 = _e675;
    uint _e676 = local_58;
    uint _e678 = local_162.inner[1];
    local_162.inner[1] = _e678 + _e676;
    uint _e682 = local_162.inner[0];
    local_163 = static_cast<uint>(_e682);
    uint _e686 = local_162.inner[1];
    local_164 = static_cast<uint>(_e686);
    uint _e690 = local_164;
    float _e693 = points[_e690].z;
    local_165 = _e693;
    float _e694 = local_165;
    local_78 = _e694;
    float _e696 = local_78;
    type_9 _e699 = local_2;
    local_55 = _e699;
    local_56 = static_cast<uint>(23);
    type_9 _e704 = local_55;
    local_166 = _e704;
    uint _e705 = local_56;
    uint _e707 = local_166.inner[1];
    local_166.inner[1] = _e707 + _e705;
    uint _e711 = local_166.inner[0];
    local_167 = static_cast<uint>(_e711);
    uint _e715 = local_166.inner[1];
    local_168 = static_cast<uint>(_e715);
    uint _e718 = local_168;
    out[_e718] = as_type<uint>(_e696);
    uint _e720 = limit;
    type_9 _e722 = local_2;
    local_59 = _e722;
    local_60 = static_cast<uint>(24);
    type_9 _e727 = local_59;
    local_169 = _e727;
    uint _e728 = local_60;
    uint _e730 = local_169.inner[1];
    local_169.inner[1] = _e730 + _e728;
    uint _e734 = local_169.inner[0];
    local_170 = static_cast<uint>(_e734);
    uint _e738 = local_169.inner[1];
    local_171 = static_cast<uint>(_e738);
    uint _e741 = local_171;
    out[_e741] = _e720;
    uint _e744 = thread_component(0u, threadIdx_1);
    uint _e746 = group_component(1u, blockIdx_1);
    uint _e749 = shape_component(2u);
    uint _e752 = grid_component(0u, gridDim_1);
    type_9 _e755 = local_2;
    local_61 = _e755;
    local_62 = static_cast<uint>(25);
    type_9 _e760 = local_61;
    local_172 = _e760;
    uint _e761 = local_62;
    uint _e763 = local_172.inner[1];
    local_172.inner[1] = _e763 + _e761;
    uint _e767 = local_172.inner[0];
    local_173 = static_cast<uint>(_e767);
    uint _e771 = local_172.inner[1];
    local_174 = static_cast<uint>(_e771);
    uint _e774 = local_174;
    out[_e774] = ((_e744 + _e746) + _e749) + _e752;
    uint _e776 = global_x(threadIdx_1, blockIdx_1);
    uint _e777 = global_x(threadIdx_1, blockIdx_1);
    type_9 _e780 = local_2;
    local_63 = _e780;
    local_64 = static_cast<uint>(26);
    type_9 _e785 = local_63;
    local_175 = _e785;
    uint _e786 = local_64;
    uint _e788 = local_175.inner[1];
    local_175.inner[1] = _e788 + _e786;
    uint _e792 = local_175.inner[0];
    local_176 = static_cast<uint>(_e792);
    uint _e796 = local_175.inner[1];
    local_177 = static_cast<uint>(_e796);
    uint _e799 = local_177;
    out[_e799] = _e776 + _e777;
    type_9 _e802 = local;
    local_67 = _e802;
    local_68 = static_cast<uint>(0);
    type_9 _e807 = local_67;
    local_178 = _e807;
    uint _e808 = local_68;
    uint _e810 = local_178.inner[1];
    local_178.inner[1] = _e810 + _e808;
    uint _e814 = local_178.inner[0];
    local_179 = static_cast<uint>(_e814);
    uint _e818 = local_178.inner[1];
    local_180 = static_cast<uint>(_e818);
    uint _e822 = local_180;
    int _e824 = input[_e822];
    local_181 = _e824;
    int _e825 = local_181;
    local_79 = _e825;
    int _e827 = local_79;
    float _e829 = scale;
    type_9 _e832 = local_1;
    local_69 = _e832;
    local_70 = static_cast<uint>(0);
    type_9 _e837 = local_69;
    local_182 = _e837;
    uint _e838 = local_70;
    uint _e840 = local_182.inner[1];
    local_182.inner[1] = _e840 + _e838;
    uint _e844 = local_182.inner[0];
    local_183 = static_cast<uint>(_e844);
    uint _e848 = local_182.inner[1];
    local_184 = static_cast<uint>(_e848);
    uint _e852 = local_184;
    float _e855 = points[_e852].x;
    local_185 = _e855;
    float _e856 = local_185;
    local_80 = _e856;
    float _e858 = local_80;
    type_9 _e862 = local_2;
    local_65 = _e862;
    local_66 = static_cast<uint>(27);
    type_9 _e867 = local_65;
    local_186 = _e867;
    uint _e868 = local_66;
    uint _e870 = local_186.inner[1];
    local_186.inner[1] = _e870 + _e868;
    uint _e874 = local_186.inner[0];
    local_187 = static_cast<uint>(_e874);
    uint _e878 = local_186.inner[1];
    local_188 = static_cast<uint>(_e878);
    uint _e881 = local_188;
    out[_e881] = as_type<uint>((static_cast<float>(_e827) * _e829) + _e858);
    uint _e884 = kind(threadIdx.x);
    type_9 _e886 = local_2;
    local_71 = _e886;
    local_72 = static_cast<uint>(28);
    type_9 _e891 = local_71;
    local_189 = _e891;
    uint _e892 = local_72;
    uint _e894 = local_189.inner[1];
    local_189.inner[1] = _e894 + _e892;
    uint _e898 = local_189.inner[0];
    local_190 = static_cast<uint>(_e898);
    uint _e902 = local_189.inner[1];
    local_191 = static_cast<uint>(_e902);
    uint _e905 = local_191;
    out[_e905] = _e884;
    uint _e908 = grid_component(2u, gridDim_1);
    type_9 _e910 = local_2;
    local_73 = _e910;
    local_74 = static_cast<uint>(29);
    type_9 _e915 = local_73;
    local_192 = _e915;
    uint _e916 = local_74;
    uint _e918 = local_192.inner[1];
    local_192.inner[1] = _e918 + _e916;
    uint _e922 = local_192.inner[0];
    local_193 = static_cast<uint>(_e922);
    uint _e926 = local_192.inner[1];
    local_194 = static_cast<uint>(_e926);
    uint _e929 = local_194;
    out[_e929] = _e908;
}
