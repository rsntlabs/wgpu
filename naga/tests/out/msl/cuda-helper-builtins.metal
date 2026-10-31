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
, device type_4 const& input_1 [[user(fake0)]]
, constant type_5& scale_1 [[user(fake0)]]
, device type_6 const& points_1 [[user(fake0)]]
, constant type_7& limit_1 [[user(fake0)]]
, device type_8& out_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::uint3 threadIdx_1 = {};
    metal::uint3 blockIdx_1 = {};
    metal::uint3 gridDim_1 = {};
    type_9 input = {};
    float scale = {};
    type_9 points = {};
    uint limit = {};
    type_9 out = {};
    type_9 local = {};
    uint local_1 = {};
    type_9 local_2 = {};
    uint local_3 = {};
    type_9 local_4 = {};
    uint local_5 = {};
    type_9 local_6 = {};
    uint local_7 = {};
    type_9 local_8 = {};
    uint local_9 = {};
    type_9 local_10 = {};
    uint local_11 = {};
    type_9 local_12 = {};
    uint local_13 = {};
    type_9 local_14 = {};
    uint local_15 = {};
    type_9 local_16 = {};
    uint local_17 = {};
    type_9 local_18 = {};
    uint local_19 = {};
    type_9 local_20 = {};
    uint local_21 = {};
    type_9 local_22 = {};
    uint local_23 = {};
    type_9 local_24 = {};
    uint local_25 = {};
    type_9 local_26 = {};
    uint local_27 = {};
    type_9 local_28 = {};
    uint local_29 = {};
    type_9 local_30 = {};
    uint local_31 = {};
    type_9 local_32 = {};
    uint local_33 = {};
    type_9 local_34 = {};
    uint local_35 = {};
    type_9 local_36 = {};
    uint local_37 = {};
    type_9 local_38 = {};
    uint local_39 = {};
    type_9 local_40 = {};
    uint local_41 = {};
    type_9 local_42 = {};
    uint local_43 = {};
    type_9 local_44 = {};
    uint local_45 = {};
    type_9 local_46 = {};
    uint local_47 = {};
    type_9 local_48 = {};
    uint local_49 = {};
    type_9 local_50 = {};
    uint local_51 = {};
    type_9 local_52 = {};
    uint local_53 = {};
    type_9 local_54 = {};
    uint local_55 = {};
    type_9 local_56 = {};
    uint local_57 = {};
    type_9 local_58 = {};
    uint local_59 = {};
    type_9 local_60 = {};
    uint local_61 = {};
    type_9 local_62 = {};
    uint local_63 = {};
    type_9 local_64 = {};
    uint local_65 = {};
    type_9 local_66 = {};
    uint local_67 = {};
    type_9 local_68 = {};
    uint local_69 = {};
    type_9 local_70 = {};
    uint local_71 = {};
    int local_72 = {};
    float local_73 = {};
    float local_74 = {};
    float local_75 = {};
    int local_76 = {};
    float local_77 = {};
    type_9 local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
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
    int local_138 = {};
    type_9 local_139 = {};
    uint local_140 = {};
    uint local_141 = {};
    type_9 local_142 = {};
    uint local_143 = {};
    uint local_144 = {};
    type_9 local_145 = {};
    uint local_146 = {};
    uint local_147 = {};
    float local_148 = {};
    type_9 local_149 = {};
    uint local_150 = {};
    uint local_151 = {};
    type_9 local_152 = {};
    uint local_153 = {};
    uint local_154 = {};
    float local_155 = {};
    type_9 local_156 = {};
    uint local_157 = {};
    uint local_158 = {};
    type_9 local_159 = {};
    uint local_160 = {};
    uint local_161 = {};
    float local_162 = {};
    type_9 local_163 = {};
    uint local_164 = {};
    uint local_165 = {};
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
    int local_178 = {};
    type_9 local_179 = {};
    uint local_180 = {};
    uint local_181 = {};
    float local_182 = {};
    type_9 local_183 = {};
    uint local_184 = {};
    uint local_185 = {};
    type_9 local_186 = {};
    uint local_187 = {};
    uint local_188 = {};
    type_9 local_189 = {};
    uint local_190 = {};
    uint local_191 = {};
    input = type_9 {};
    input.inner[0] = 0u;
    input.inner[1] = 0u;
    float _e12 = scale_1.value;
    scale = _e12;
    points = type_9 {};
    points.inner[0] = 1u;
    points.inner[1] = 0u;
    uint _e23 = limit_1.value;
    limit = _e23;
    out = type_9 {};
    out.inner[0] = 2u;
    out.inner[1] = 0u;
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
    type_9 _e42 = out;
    local = _e42;
    local_1 = static_cast<uint>(0);
    type_9 _e47 = local;
    local_78 = _e47;
    uint _e48 = local_1;
    uint _e50 = local_78.inner[1];
    local_78.inner[1] = _e50 + _e48;
    uint _e54 = local_78.inner[0];
    local_79 = static_cast<uint>(_e54);
    uint _e58 = local_78.inner[1];
    local_80 = static_cast<uint>(_e58);
    uint _e61 = local_80;
    out_1[_e61] = _e39;
    uint _e64 = thread_component(1u, threadIdx_1);
    type_9 _e66 = out;
    local_2 = _e66;
    local_3 = static_cast<uint>(1);
    type_9 _e71 = local_2;
    local_81 = _e71;
    uint _e72 = local_3;
    uint _e74 = local_81.inner[1];
    local_81.inner[1] = _e74 + _e72;
    uint _e78 = local_81.inner[0];
    local_82 = static_cast<uint>(_e78);
    uint _e82 = local_81.inner[1];
    local_83 = static_cast<uint>(_e82);
    uint _e85 = local_83;
    out_1[_e85] = _e64;
    uint _e88 = thread_component(2u, threadIdx_1);
    type_9 _e90 = out;
    local_4 = _e90;
    local_5 = static_cast<uint>(2);
    type_9 _e95 = local_4;
    local_84 = _e95;
    uint _e96 = local_5;
    uint _e98 = local_84.inner[1];
    local_84.inner[1] = _e98 + _e96;
    uint _e102 = local_84.inner[0];
    local_85 = static_cast<uint>(_e102);
    uint _e106 = local_84.inner[1];
    local_86 = static_cast<uint>(_e106);
    uint _e109 = local_86;
    out_1[_e109] = _e88;
    uint _e112 = group_component(0u, blockIdx_1);
    type_9 _e114 = out;
    local_6 = _e114;
    local_7 = static_cast<uint>(3);
    type_9 _e119 = local_6;
    local_87 = _e119;
    uint _e120 = local_7;
    uint _e122 = local_87.inner[1];
    local_87.inner[1] = _e122 + _e120;
    uint _e126 = local_87.inner[0];
    local_88 = static_cast<uint>(_e126);
    uint _e130 = local_87.inner[1];
    local_89 = static_cast<uint>(_e130);
    uint _e133 = local_89;
    out_1[_e133] = _e112;
    uint _e136 = group_component(1u, blockIdx_1);
    type_9 _e138 = out;
    local_8 = _e138;
    local_9 = static_cast<uint>(4);
    type_9 _e143 = local_8;
    local_90 = _e143;
    uint _e144 = local_9;
    uint _e146 = local_90.inner[1];
    local_90.inner[1] = _e146 + _e144;
    uint _e150 = local_90.inner[0];
    local_91 = static_cast<uint>(_e150);
    uint _e154 = local_90.inner[1];
    local_92 = static_cast<uint>(_e154);
    uint _e157 = local_92;
    out_1[_e157] = _e136;
    uint _e160 = group_component(2u, blockIdx_1);
    type_9 _e162 = out;
    local_10 = _e162;
    local_11 = static_cast<uint>(5);
    type_9 _e167 = local_10;
    local_93 = _e167;
    uint _e168 = local_11;
    uint _e170 = local_93.inner[1];
    local_93.inner[1] = _e170 + _e168;
    uint _e174 = local_93.inner[0];
    local_94 = static_cast<uint>(_e174);
    uint _e178 = local_93.inner[1];
    local_95 = static_cast<uint>(_e178);
    uint _e181 = local_95;
    out_1[_e181] = _e160;
    uint _e184 = shape_component(0u);
    type_9 _e186 = out;
    local_12 = _e186;
    local_13 = static_cast<uint>(6);
    type_9 _e191 = local_12;
    local_96 = _e191;
    uint _e192 = local_13;
    uint _e194 = local_96.inner[1];
    local_96.inner[1] = _e194 + _e192;
    uint _e198 = local_96.inner[0];
    local_97 = static_cast<uint>(_e198);
    uint _e202 = local_96.inner[1];
    local_98 = static_cast<uint>(_e202);
    uint _e205 = local_98;
    out_1[_e205] = _e184;
    uint _e208 = shape_component(1u);
    type_9 _e210 = out;
    local_14 = _e210;
    local_15 = static_cast<uint>(7);
    type_9 _e215 = local_14;
    local_99 = _e215;
    uint _e216 = local_15;
    uint _e218 = local_99.inner[1];
    local_99.inner[1] = _e218 + _e216;
    uint _e222 = local_99.inner[0];
    local_100 = static_cast<uint>(_e222);
    uint _e226 = local_99.inner[1];
    local_101 = static_cast<uint>(_e226);
    uint _e229 = local_101;
    out_1[_e229] = _e208;
    uint _e232 = shape_component(2u);
    type_9 _e234 = out;
    local_16 = _e234;
    local_17 = static_cast<uint>(8);
    type_9 _e239 = local_16;
    local_102 = _e239;
    uint _e240 = local_17;
    uint _e242 = local_102.inner[1];
    local_102.inner[1] = _e242 + _e240;
    uint _e246 = local_102.inner[0];
    local_103 = static_cast<uint>(_e246);
    uint _e250 = local_102.inner[1];
    local_104 = static_cast<uint>(_e250);
    uint _e253 = local_104;
    out_1[_e253] = _e232;
    uint _e256 = grid_component(0u, gridDim_1);
    type_9 _e258 = out;
    local_18 = _e258;
    local_19 = static_cast<uint>(9);
    type_9 _e263 = local_18;
    local_105 = _e263;
    uint _e264 = local_19;
    uint _e266 = local_105.inner[1];
    local_105.inner[1] = _e266 + _e264;
    uint _e270 = local_105.inner[0];
    local_106 = static_cast<uint>(_e270);
    uint _e274 = local_105.inner[1];
    local_107 = static_cast<uint>(_e274);
    uint _e277 = local_107;
    out_1[_e277] = _e256;
    uint _e280 = grid_component(1u, gridDim_1);
    type_9 _e282 = out;
    local_20 = _e282;
    local_21 = static_cast<uint>(10);
    type_9 _e287 = local_20;
    local_108 = _e287;
    uint _e288 = local_21;
    uint _e290 = local_108.inner[1];
    local_108.inner[1] = _e290 + _e288;
    uint _e294 = local_108.inner[0];
    local_109 = static_cast<uint>(_e294);
    uint _e298 = local_108.inner[1];
    local_110 = static_cast<uint>(_e298);
    uint _e301 = local_110;
    out_1[_e301] = _e280;
    uint _e304 = grid_component(2u, gridDim_1);
    type_9 _e306 = out;
    local_22 = _e306;
    local_23 = static_cast<uint>(11);
    type_9 _e311 = local_22;
    local_111 = _e311;
    uint _e312 = local_23;
    uint _e314 = local_111.inner[1];
    local_111.inner[1] = _e314 + _e312;
    uint _e318 = local_111.inner[0];
    local_112 = static_cast<uint>(_e318);
    uint _e322 = local_111.inner[1];
    local_113 = static_cast<uint>(_e322);
    uint _e325 = local_113;
    out_1[_e325] = _e304;
    uint _e327 = global_x(threadIdx_1, blockIdx_1);
    type_9 _e329 = out;
    local_24 = _e329;
    local_25 = static_cast<uint>(12);
    type_9 _e334 = local_24;
    local_114 = _e334;
    uint _e335 = local_25;
    uint _e337 = local_114.inner[1];
    local_114.inner[1] = _e337 + _e335;
    uint _e341 = local_114.inner[0];
    local_115 = static_cast<uint>(_e341);
    uint _e345 = local_114.inner[1];
    local_116 = static_cast<uint>(_e345);
    uint _e348 = local_116;
    out_1[_e348] = _e327;
    uint _e351 = component(0u, threadIdx_1);
    type_9 _e353 = out;
    local_26 = _e353;
    local_27 = static_cast<uint>(13);
    type_9 _e358 = local_26;
    local_117 = _e358;
    uint _e359 = local_27;
    uint _e361 = local_117.inner[1];
    local_117.inner[1] = _e361 + _e359;
    uint _e365 = local_117.inner[0];
    local_118 = static_cast<uint>(_e365);
    uint _e369 = local_117.inner[1];
    local_119 = static_cast<uint>(_e369);
    uint _e372 = local_119;
    out_1[_e372] = _e351;
    float _e375 = component_1(2.5, blockIdx_1);
    type_9 _e378 = out;
    local_28 = _e378;
    local_29 = static_cast<uint>(14);
    type_9 _e383 = local_28;
    local_120 = _e383;
    uint _e384 = local_29;
    uint _e386 = local_120.inner[1];
    local_120.inner[1] = _e386 + _e384;
    uint _e390 = local_120.inner[0];
    local_121 = static_cast<uint>(_e390);
    uint _e394 = local_120.inner[1];
    local_122 = static_cast<uint>(_e394);
    uint _e397 = local_122;
    out_1[_e397] = as_type<uint>(_e375);
    type_9 _e401 = out;
    local_30 = _e401;
    local_31 = static_cast<uint>(15);
    type_9 _e406 = local_30;
    local_123 = _e406;
    uint _e407 = local_31;
    uint _e409 = local_123.inner[1];
    local_123.inner[1] = _e409 + _e407;
    uint _e413 = local_123.inner[0];
    local_124 = static_cast<uint>(_e413);
    uint _e417 = local_123.inner[1];
    local_125 = static_cast<uint>(_e417);
    uint _e420 = local_125;
    out_1[_e420] = threadIdx.x;
    type_9 _e424 = out;
    local_32 = _e424;
    local_33 = static_cast<uint>(16);
    type_9 _e429 = local_32;
    local_126 = _e429;
    uint _e430 = local_33;
    uint _e432 = local_126.inner[1];
    local_126.inner[1] = _e432 + _e430;
    uint _e436 = local_126.inner[0];
    local_127 = static_cast<uint>(_e436);
    uint _e440 = local_126.inner[1];
    local_128 = static_cast<uint>(_e440);
    uint _e443 = local_128;
    out_1[_e443] = blockIdx.y;
    type_9 _e447 = out;
    local_34 = _e447;
    local_35 = static_cast<uint>(17);
    type_9 _e452 = local_34;
    local_129 = _e452;
    uint _e453 = local_35;
    uint _e455 = local_129.inner[1];
    local_129.inner[1] = _e455 + _e453;
    uint _e459 = local_129.inner[0];
    local_130 = static_cast<uint>(_e459);
    uint _e463 = local_129.inner[1];
    local_131 = static_cast<uint>(_e463);
    uint _e466 = local_131;
    out_1[_e466] = gridDim.z;
    type_9 _e469 = out;
    local_36 = _e469;
    local_37 = static_cast<uint>(18);
    type_9 _e474 = local_36;
    local_132 = _e474;
    uint _e475 = local_37;
    uint _e477 = local_132.inner[1];
    local_132.inner[1] = _e477 + _e475;
    uint _e481 = local_132.inner[0];
    local_133 = static_cast<uint>(_e481);
    uint _e485 = local_132.inner[1];
    local_134 = static_cast<uint>(_e485);
    uint _e489 = local_134;
    out_1[_e489] = 1u;
    type_9 _e493 = input;
    local_40 = _e493;
    local_41 = static_cast<uint>(0);
    type_9 _e498 = local_40;
    local_135 = _e498;
    uint _e499 = local_41;
    uint _e501 = local_135.inner[1];
    local_135.inner[1] = _e501 + _e499;
    uint _e505 = local_135.inner[0];
    local_136 = static_cast<uint>(_e505);
    uint _e509 = local_135.inner[1];
    local_137 = static_cast<uint>(_e509);
    uint _e513 = local_137;
    int _e515 = input_1[_e513];
    local_138 = _e515;
    int _e516 = local_138;
    local_72 = _e516;
    int _e518 = local_72;
    type_9 _e521 = out;
    local_38 = _e521;
    local_39 = static_cast<uint>(19);
    type_9 _e526 = local_38;
    local_139 = _e526;
    uint _e527 = local_39;
    uint _e529 = local_139.inner[1];
    local_139.inner[1] = _e529 + _e527;
    uint _e533 = local_139.inner[0];
    local_140 = static_cast<uint>(_e533);
    uint _e537 = local_139.inner[1];
    local_141 = static_cast<uint>(_e537);
    uint _e540 = local_141;
    out_1[_e540] = static_cast<uint>(_e518);
    float _e542 = scale;
    type_9 _e545 = out;
    local_42 = _e545;
    local_43 = static_cast<uint>(20);
    type_9 _e550 = local_42;
    local_142 = _e550;
    uint _e551 = local_43;
    uint _e553 = local_142.inner[1];
    local_142.inner[1] = _e553 + _e551;
    uint _e557 = local_142.inner[0];
    local_143 = static_cast<uint>(_e557);
    uint _e561 = local_142.inner[1];
    local_144 = static_cast<uint>(_e561);
    uint _e564 = local_144;
    out_1[_e564] = as_type<uint>(_e542);
    type_9 _e568 = points;
    local_46 = _e568;
    local_47 = static_cast<uint>(0);
    type_9 _e573 = local_46;
    local_145 = _e573;
    uint _e574 = local_47;
    uint _e576 = local_145.inner[1];
    local_145.inner[1] = _e576 + _e574;
    uint _e580 = local_145.inner[0];
    local_146 = static_cast<uint>(_e580);
    uint _e584 = local_145.inner[1];
    local_147 = static_cast<uint>(_e584);
    uint _e588 = local_147;
    float _e591 = points_1[_e588].x;
    local_148 = _e591;
    float _e592 = local_148;
    local_73 = _e592;
    float _e594 = local_73;
    type_9 _e597 = out;
    local_44 = _e597;
    local_45 = static_cast<uint>(21);
    type_9 _e602 = local_44;
    local_149 = _e602;
    uint _e603 = local_45;
    uint _e605 = local_149.inner[1];
    local_149.inner[1] = _e605 + _e603;
    uint _e609 = local_149.inner[0];
    local_150 = static_cast<uint>(_e609);
    uint _e613 = local_149.inner[1];
    local_151 = static_cast<uint>(_e613);
    uint _e616 = local_151;
    out_1[_e616] = as_type<uint>(_e594);
    type_9 _e619 = points;
    local_50 = _e619;
    local_51 = static_cast<uint>(0);
    type_9 _e624 = local_50;
    local_152 = _e624;
    uint _e625 = local_51;
    uint _e627 = local_152.inner[1];
    local_152.inner[1] = _e627 + _e625;
    uint _e631 = local_152.inner[0];
    local_153 = static_cast<uint>(_e631);
    uint _e635 = local_152.inner[1];
    local_154 = static_cast<uint>(_e635);
    uint _e639 = local_154;
    float _e642 = points_1[_e639].y;
    local_155 = _e642;
    float _e643 = local_155;
    local_74 = _e643;
    float _e645 = local_74;
    type_9 _e648 = out;
    local_48 = _e648;
    local_49 = static_cast<uint>(22);
    type_9 _e653 = local_48;
    local_156 = _e653;
    uint _e654 = local_49;
    uint _e656 = local_156.inner[1];
    local_156.inner[1] = _e656 + _e654;
    uint _e660 = local_156.inner[0];
    local_157 = static_cast<uint>(_e660);
    uint _e664 = local_156.inner[1];
    local_158 = static_cast<uint>(_e664);
    uint _e667 = local_158;
    out_1[_e667] = as_type<uint>(_e645);
    type_9 _e670 = points;
    local_54 = _e670;
    local_55 = static_cast<uint>(0);
    type_9 _e675 = local_54;
    local_159 = _e675;
    uint _e676 = local_55;
    uint _e678 = local_159.inner[1];
    local_159.inner[1] = _e678 + _e676;
    uint _e682 = local_159.inner[0];
    local_160 = static_cast<uint>(_e682);
    uint _e686 = local_159.inner[1];
    local_161 = static_cast<uint>(_e686);
    uint _e690 = local_161;
    float _e693 = points_1[_e690].z;
    local_162 = _e693;
    float _e694 = local_162;
    local_75 = _e694;
    float _e696 = local_75;
    type_9 _e699 = out;
    local_52 = _e699;
    local_53 = static_cast<uint>(23);
    type_9 _e704 = local_52;
    local_163 = _e704;
    uint _e705 = local_53;
    uint _e707 = local_163.inner[1];
    local_163.inner[1] = _e707 + _e705;
    uint _e711 = local_163.inner[0];
    local_164 = static_cast<uint>(_e711);
    uint _e715 = local_163.inner[1];
    local_165 = static_cast<uint>(_e715);
    uint _e718 = local_165;
    out_1[_e718] = as_type<uint>(_e696);
    uint _e720 = limit;
    type_9 _e722 = out;
    local_56 = _e722;
    local_57 = static_cast<uint>(24);
    type_9 _e727 = local_56;
    local_166 = _e727;
    uint _e728 = local_57;
    uint _e730 = local_166.inner[1];
    local_166.inner[1] = _e730 + _e728;
    uint _e734 = local_166.inner[0];
    local_167 = static_cast<uint>(_e734);
    uint _e738 = local_166.inner[1];
    local_168 = static_cast<uint>(_e738);
    uint _e741 = local_168;
    out_1[_e741] = _e720;
    uint _e744 = thread_component(0u, threadIdx_1);
    uint _e746 = group_component(1u, blockIdx_1);
    uint _e749 = shape_component(2u);
    uint _e752 = grid_component(0u, gridDim_1);
    type_9 _e755 = out;
    local_58 = _e755;
    local_59 = static_cast<uint>(25);
    type_9 _e760 = local_58;
    local_169 = _e760;
    uint _e761 = local_59;
    uint _e763 = local_169.inner[1];
    local_169.inner[1] = _e763 + _e761;
    uint _e767 = local_169.inner[0];
    local_170 = static_cast<uint>(_e767);
    uint _e771 = local_169.inner[1];
    local_171 = static_cast<uint>(_e771);
    uint _e774 = local_171;
    out_1[_e774] = ((_e744 + _e746) + _e749) + _e752;
    uint _e776 = global_x(threadIdx_1, blockIdx_1);
    uint _e777 = global_x(threadIdx_1, blockIdx_1);
    type_9 _e780 = out;
    local_60 = _e780;
    local_61 = static_cast<uint>(26);
    type_9 _e785 = local_60;
    local_172 = _e785;
    uint _e786 = local_61;
    uint _e788 = local_172.inner[1];
    local_172.inner[1] = _e788 + _e786;
    uint _e792 = local_172.inner[0];
    local_173 = static_cast<uint>(_e792);
    uint _e796 = local_172.inner[1];
    local_174 = static_cast<uint>(_e796);
    uint _e799 = local_174;
    out_1[_e799] = _e776 + _e777;
    type_9 _e802 = input;
    local_64 = _e802;
    local_65 = static_cast<uint>(0);
    type_9 _e807 = local_64;
    local_175 = _e807;
    uint _e808 = local_65;
    uint _e810 = local_175.inner[1];
    local_175.inner[1] = _e810 + _e808;
    uint _e814 = local_175.inner[0];
    local_176 = static_cast<uint>(_e814);
    uint _e818 = local_175.inner[1];
    local_177 = static_cast<uint>(_e818);
    uint _e822 = local_177;
    int _e824 = input_1[_e822];
    local_178 = _e824;
    int _e825 = local_178;
    local_76 = _e825;
    int _e827 = local_76;
    float _e829 = scale;
    type_9 _e832 = points;
    local_66 = _e832;
    local_67 = static_cast<uint>(0);
    type_9 _e837 = local_66;
    local_179 = _e837;
    uint _e838 = local_67;
    uint _e840 = local_179.inner[1];
    local_179.inner[1] = _e840 + _e838;
    uint _e844 = local_179.inner[0];
    local_180 = static_cast<uint>(_e844);
    uint _e848 = local_179.inner[1];
    local_181 = static_cast<uint>(_e848);
    uint _e852 = local_181;
    float _e855 = points_1[_e852].x;
    local_182 = _e855;
    float _e856 = local_182;
    local_77 = _e856;
    float _e858 = local_77;
    type_9 _e862 = out;
    local_62 = _e862;
    local_63 = static_cast<uint>(27);
    type_9 _e867 = local_62;
    local_183 = _e867;
    uint _e868 = local_63;
    uint _e870 = local_183.inner[1];
    local_183.inner[1] = _e870 + _e868;
    uint _e874 = local_183.inner[0];
    local_184 = static_cast<uint>(_e874);
    uint _e878 = local_183.inner[1];
    local_185 = static_cast<uint>(_e878);
    uint _e881 = local_185;
    out_1[_e881] = as_type<uint>((static_cast<float>(_e827) * _e829) + _e858);
    uint _e884 = kind(threadIdx.x);
    type_9 _e886 = out;
    local_68 = _e886;
    local_69 = static_cast<uint>(28);
    type_9 _e891 = local_68;
    local_186 = _e891;
    uint _e892 = local_69;
    uint _e894 = local_186.inner[1];
    local_186.inner[1] = _e894 + _e892;
    uint _e898 = local_186.inner[0];
    local_187 = static_cast<uint>(_e898);
    uint _e902 = local_186.inner[1];
    local_188 = static_cast<uint>(_e902);
    uint _e905 = local_188;
    out_1[_e905] = _e884;
    uint _e908 = grid_component(2u, gridDim_1);
    type_9 _e910 = out;
    local_70 = _e910;
    local_71 = static_cast<uint>(29);
    type_9 _e915 = local_70;
    local_189 = _e915;
    uint _e916 = local_71;
    uint _e918 = local_189.inner[1];
    local_189.inner[1] = _e918 + _e916;
    uint _e922 = local_189.inner[0];
    local_190 = static_cast<uint>(_e922);
    uint _e926 = local_189.inner[1];
    local_191 = static_cast<uint>(_e926);
    uint _e929 = local_191;
    out_1[_e929] = _e908;
}
