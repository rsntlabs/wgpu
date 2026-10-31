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
    if (axis == 0u) {
        metal::uint3 _e4 = threadIdx_1;
        return _e4.x;
    }
    if (axis == 1u) {
        metal::uint3 _e9 = threadIdx_1;
        return _e9.y;
    }
    metal::uint3 _e12 = threadIdx_1;
    return _e12.z;
}

uint group_component(
    uint axis_1,
    thread metal::uint3& blockIdx_1
) {
    if (axis_1 == 0u) {
        metal::uint3 _e4 = blockIdx_1;
        return _e4.x;
    }
    if (axis_1 == 1u) {
        metal::uint3 _e9 = blockIdx_1;
        return _e9.y;
    }
    metal::uint3 _e12 = blockIdx_1;
    return _e12.z;
}

uint shape_component(
    uint axis_2
) {
    if (axis_2 == 0u) {
        return 1u;
    }
    if (axis_2 == 1u) {
        return 1u;
    }
    return 1u;
}

uint grid_component(
    uint axis_3,
    thread metal::uint3& gridDim_1
) {
    if (axis_3 == 0u) {
        metal::uint3 _e4 = gridDim_1;
        return _e4.x;
    }
    if (axis_3 == 1u) {
        metal::uint3 _e9 = gridDim_1;
        return _e9.y;
    }
    metal::uint3 _e12 = gridDim_1;
    return _e12.z;
}

uint component(
    uint axis_4,
    thread metal::uint3& threadIdx_1
) {
    uint _e1 = thread_component(axis_4, threadIdx_1);
    return _e1;
}

float component_1(
    float offset,
    thread metal::uint3& blockIdx_1
) {
    metal::uint3 _e2 = blockIdx_1;
    return static_cast<float>(_e2.x) + offset;
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
, constant type_5& scale [[user(fake0)]]
, device type_6 const& points_1 [[user(fake0)]]
, constant type_7& limit [[user(fake0)]]
, device type_8& out_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::uint3 threadIdx_1 = {};
    metal::uint3 blockIdx_1 = {};
    metal::uint3 gridDim_1 = {};
    type_9 input = {};
    type_9 points = {};
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
    float scale_1 = scale.value;
    points = type_9 {};
    points.inner[0] = 1u;
    points.inner[1] = 0u;
    uint limit_1 = limit.value;
    out = type_9 {};
    out.inner[0] = 2u;
    out.inner[1] = 0u;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    gridDim_1 = gridDim;
    uint _e30 = global_x(threadIdx_1, blockIdx_1);
    if (_e30 >= limit_1) {
        return;
    }
    observe(gridDim_1);
    uint _e33 = thread_component(0u, threadIdx_1);
    type_9 _e35 = out;
    local = _e35;
    local_1 = static_cast<uint>(0);
    type_9 _e40 = local;
    local_78 = _e40;
    uint _e42 = local_1;
    uint _e44 = local_78.inner[1];
    local_78.inner[1] = _e44 + _e42;
    uint _e48 = local_78.inner[0];
    local_79 = static_cast<uint>(_e48);
    uint _e52 = local_78.inner[1];
    local_80 = static_cast<uint>(_e52);
    uint _e55 = local_80;
    out_1[_e55] = _e33;
    uint _e59 = thread_component(1u, threadIdx_1);
    type_9 _e60 = out;
    local_2 = _e60;
    local_3 = static_cast<uint>(1);
    type_9 _e65 = local_2;
    local_81 = _e65;
    uint _e67 = local_3;
    uint _e69 = local_81.inner[1];
    local_81.inner[1] = _e69 + _e67;
    uint _e73 = local_81.inner[0];
    local_82 = static_cast<uint>(_e73);
    uint _e77 = local_81.inner[1];
    local_83 = static_cast<uint>(_e77);
    uint _e80 = local_83;
    out_1[_e80] = _e59;
    uint _e83 = thread_component(2u, threadIdx_1);
    type_9 _e84 = out;
    local_4 = _e84;
    local_5 = static_cast<uint>(2);
    type_9 _e89 = local_4;
    local_84 = _e89;
    uint _e91 = local_5;
    uint _e93 = local_84.inner[1];
    local_84.inner[1] = _e93 + _e91;
    uint _e97 = local_84.inner[0];
    local_85 = static_cast<uint>(_e97);
    uint _e101 = local_84.inner[1];
    local_86 = static_cast<uint>(_e101);
    uint _e104 = local_86;
    out_1[_e104] = _e83;
    uint _e107 = group_component(0u, blockIdx_1);
    type_9 _e108 = out;
    local_6 = _e108;
    local_7 = static_cast<uint>(3);
    type_9 _e113 = local_6;
    local_87 = _e113;
    uint _e115 = local_7;
    uint _e117 = local_87.inner[1];
    local_87.inner[1] = _e117 + _e115;
    uint _e121 = local_87.inner[0];
    local_88 = static_cast<uint>(_e121);
    uint _e125 = local_87.inner[1];
    local_89 = static_cast<uint>(_e125);
    uint _e128 = local_89;
    out_1[_e128] = _e107;
    uint _e131 = group_component(1u, blockIdx_1);
    type_9 _e132 = out;
    local_8 = _e132;
    local_9 = static_cast<uint>(4);
    type_9 _e137 = local_8;
    local_90 = _e137;
    uint _e139 = local_9;
    uint _e141 = local_90.inner[1];
    local_90.inner[1] = _e141 + _e139;
    uint _e145 = local_90.inner[0];
    local_91 = static_cast<uint>(_e145);
    uint _e149 = local_90.inner[1];
    local_92 = static_cast<uint>(_e149);
    uint _e152 = local_92;
    out_1[_e152] = _e131;
    uint _e155 = group_component(2u, blockIdx_1);
    type_9 _e156 = out;
    local_10 = _e156;
    local_11 = static_cast<uint>(5);
    type_9 _e161 = local_10;
    local_93 = _e161;
    uint _e163 = local_11;
    uint _e165 = local_93.inner[1];
    local_93.inner[1] = _e165 + _e163;
    uint _e169 = local_93.inner[0];
    local_94 = static_cast<uint>(_e169);
    uint _e173 = local_93.inner[1];
    local_95 = static_cast<uint>(_e173);
    uint _e176 = local_95;
    out_1[_e176] = _e155;
    uint _e179 = shape_component(0u);
    type_9 _e180 = out;
    local_12 = _e180;
    local_13 = static_cast<uint>(6);
    type_9 _e185 = local_12;
    local_96 = _e185;
    uint _e187 = local_13;
    uint _e189 = local_96.inner[1];
    local_96.inner[1] = _e189 + _e187;
    uint _e193 = local_96.inner[0];
    local_97 = static_cast<uint>(_e193);
    uint _e197 = local_96.inner[1];
    local_98 = static_cast<uint>(_e197);
    uint _e200 = local_98;
    out_1[_e200] = _e179;
    uint _e203 = shape_component(1u);
    type_9 _e204 = out;
    local_14 = _e204;
    local_15 = static_cast<uint>(7);
    type_9 _e209 = local_14;
    local_99 = _e209;
    uint _e211 = local_15;
    uint _e213 = local_99.inner[1];
    local_99.inner[1] = _e213 + _e211;
    uint _e217 = local_99.inner[0];
    local_100 = static_cast<uint>(_e217);
    uint _e221 = local_99.inner[1];
    local_101 = static_cast<uint>(_e221);
    uint _e224 = local_101;
    out_1[_e224] = _e203;
    uint _e227 = shape_component(2u);
    type_9 _e228 = out;
    local_16 = _e228;
    local_17 = static_cast<uint>(8);
    type_9 _e233 = local_16;
    local_102 = _e233;
    uint _e235 = local_17;
    uint _e237 = local_102.inner[1];
    local_102.inner[1] = _e237 + _e235;
    uint _e241 = local_102.inner[0];
    local_103 = static_cast<uint>(_e241);
    uint _e245 = local_102.inner[1];
    local_104 = static_cast<uint>(_e245);
    uint _e248 = local_104;
    out_1[_e248] = _e227;
    uint _e251 = grid_component(0u, gridDim_1);
    type_9 _e252 = out;
    local_18 = _e252;
    local_19 = static_cast<uint>(9);
    type_9 _e257 = local_18;
    local_105 = _e257;
    uint _e259 = local_19;
    uint _e261 = local_105.inner[1];
    local_105.inner[1] = _e261 + _e259;
    uint _e265 = local_105.inner[0];
    local_106 = static_cast<uint>(_e265);
    uint _e269 = local_105.inner[1];
    local_107 = static_cast<uint>(_e269);
    uint _e272 = local_107;
    out_1[_e272] = _e251;
    uint _e275 = grid_component(1u, gridDim_1);
    type_9 _e276 = out;
    local_20 = _e276;
    local_21 = static_cast<uint>(10);
    type_9 _e281 = local_20;
    local_108 = _e281;
    uint _e283 = local_21;
    uint _e285 = local_108.inner[1];
    local_108.inner[1] = _e285 + _e283;
    uint _e289 = local_108.inner[0];
    local_109 = static_cast<uint>(_e289);
    uint _e293 = local_108.inner[1];
    local_110 = static_cast<uint>(_e293);
    uint _e296 = local_110;
    out_1[_e296] = _e275;
    uint _e299 = grid_component(2u, gridDim_1);
    type_9 _e300 = out;
    local_22 = _e300;
    local_23 = static_cast<uint>(11);
    type_9 _e305 = local_22;
    local_111 = _e305;
    uint _e307 = local_23;
    uint _e309 = local_111.inner[1];
    local_111.inner[1] = _e309 + _e307;
    uint _e313 = local_111.inner[0];
    local_112 = static_cast<uint>(_e313);
    uint _e317 = local_111.inner[1];
    local_113 = static_cast<uint>(_e317);
    uint _e320 = local_113;
    out_1[_e320] = _e299;
    uint _e322 = global_x(threadIdx_1, blockIdx_1);
    type_9 _e323 = out;
    local_24 = _e323;
    local_25 = static_cast<uint>(12);
    type_9 _e328 = local_24;
    local_114 = _e328;
    uint _e330 = local_25;
    uint _e332 = local_114.inner[1];
    local_114.inner[1] = _e332 + _e330;
    uint _e336 = local_114.inner[0];
    local_115 = static_cast<uint>(_e336);
    uint _e340 = local_114.inner[1];
    local_116 = static_cast<uint>(_e340);
    uint _e343 = local_116;
    out_1[_e343] = _e322;
    uint _e346 = component(0u, threadIdx_1);
    type_9 _e347 = out;
    local_26 = _e347;
    local_27 = static_cast<uint>(13);
    type_9 _e352 = local_26;
    local_117 = _e352;
    uint _e354 = local_27;
    uint _e356 = local_117.inner[1];
    local_117.inner[1] = _e356 + _e354;
    uint _e360 = local_117.inner[0];
    local_118 = static_cast<uint>(_e360);
    uint _e364 = local_117.inner[1];
    local_119 = static_cast<uint>(_e364);
    uint _e367 = local_119;
    out_1[_e367] = _e346;
    float _e370 = component_1(2.5, blockIdx_1);
    type_9 _e372 = out;
    local_28 = _e372;
    local_29 = static_cast<uint>(14);
    type_9 _e377 = local_28;
    local_120 = _e377;
    uint _e379 = local_29;
    uint _e381 = local_120.inner[1];
    local_120.inner[1] = _e381 + _e379;
    uint _e385 = local_120.inner[0];
    local_121 = static_cast<uint>(_e385);
    uint _e389 = local_120.inner[1];
    local_122 = static_cast<uint>(_e389);
    uint _e392 = local_122;
    out_1[_e392] = as_type<uint>(_e370);
    type_9 _e395 = out;
    local_30 = _e395;
    local_31 = static_cast<uint>(15);
    type_9 _e400 = local_30;
    local_123 = _e400;
    uint _e402 = local_31;
    uint _e404 = local_123.inner[1];
    local_123.inner[1] = _e404 + _e402;
    uint _e408 = local_123.inner[0];
    local_124 = static_cast<uint>(_e408);
    uint _e412 = local_123.inner[1];
    local_125 = static_cast<uint>(_e412);
    uint _e415 = local_125;
    out_1[_e415] = threadIdx.x;
    type_9 _e418 = out;
    local_32 = _e418;
    local_33 = static_cast<uint>(16);
    type_9 _e423 = local_32;
    local_126 = _e423;
    uint _e425 = local_33;
    uint _e427 = local_126.inner[1];
    local_126.inner[1] = _e427 + _e425;
    uint _e431 = local_126.inner[0];
    local_127 = static_cast<uint>(_e431);
    uint _e435 = local_126.inner[1];
    local_128 = static_cast<uint>(_e435);
    uint _e438 = local_128;
    out_1[_e438] = blockIdx.y;
    type_9 _e441 = out;
    local_34 = _e441;
    local_35 = static_cast<uint>(17);
    type_9 _e446 = local_34;
    local_129 = _e446;
    uint _e448 = local_35;
    uint _e450 = local_129.inner[1];
    local_129.inner[1] = _e450 + _e448;
    uint _e454 = local_129.inner[0];
    local_130 = static_cast<uint>(_e454);
    uint _e458 = local_129.inner[1];
    local_131 = static_cast<uint>(_e458);
    uint _e461 = local_131;
    out_1[_e461] = gridDim.z;
    type_9 _e463 = out;
    local_36 = _e463;
    local_37 = static_cast<uint>(18);
    type_9 _e468 = local_36;
    local_132 = _e468;
    uint _e470 = local_37;
    uint _e472 = local_132.inner[1];
    local_132.inner[1] = _e472 + _e470;
    uint _e476 = local_132.inner[0];
    local_133 = static_cast<uint>(_e476);
    uint _e480 = local_132.inner[1];
    local_134 = static_cast<uint>(_e480);
    uint _e483 = local_134;
    out_1[_e483] = 1u;
    type_9 _e487 = input;
    local_40 = _e487;
    local_41 = static_cast<uint>(0);
    type_9 _e492 = local_40;
    local_135 = _e492;
    uint _e494 = local_41;
    uint _e496 = local_135.inner[1];
    local_135.inner[1] = _e496 + _e494;
    uint _e500 = local_135.inner[0];
    local_136 = static_cast<uint>(_e500);
    uint _e504 = local_135.inner[1];
    local_137 = static_cast<uint>(_e504);
    uint _e507 = local_137;
    int _e510 = input_1[_e507];
    local_138 = _e510;
    int _e512 = local_138;
    local_72 = _e512;
    int _e514 = local_72;
    type_9 _e516 = out;
    local_38 = _e516;
    local_39 = static_cast<uint>(19);
    type_9 _e521 = local_38;
    local_139 = _e521;
    uint _e523 = local_39;
    uint _e525 = local_139.inner[1];
    local_139.inner[1] = _e525 + _e523;
    uint _e529 = local_139.inner[0];
    local_140 = static_cast<uint>(_e529);
    uint _e533 = local_139.inner[1];
    local_141 = static_cast<uint>(_e533);
    uint _e536 = local_141;
    out_1[_e536] = static_cast<uint>(_e514);
    type_9 _e539 = out;
    local_42 = _e539;
    local_43 = static_cast<uint>(20);
    type_9 _e544 = local_42;
    local_142 = _e544;
    uint _e546 = local_43;
    uint _e548 = local_142.inner[1];
    local_142.inner[1] = _e548 + _e546;
    uint _e552 = local_142.inner[0];
    local_143 = static_cast<uint>(_e552);
    uint _e556 = local_142.inner[1];
    local_144 = static_cast<uint>(_e556);
    uint _e559 = local_144;
    out_1[_e559] = as_type<uint>(scale_1);
    type_9 _e562 = points;
    local_46 = _e562;
    local_47 = static_cast<uint>(0);
    type_9 _e567 = local_46;
    local_145 = _e567;
    uint _e569 = local_47;
    uint _e571 = local_145.inner[1];
    local_145.inner[1] = _e571 + _e569;
    uint _e575 = local_145.inner[0];
    local_146 = static_cast<uint>(_e575);
    uint _e579 = local_145.inner[1];
    local_147 = static_cast<uint>(_e579);
    uint _e582 = local_147;
    float _e586 = points_1[_e582].x;
    local_148 = _e586;
    float _e588 = local_148;
    local_73 = _e588;
    float _e590 = local_73;
    type_9 _e592 = out;
    local_44 = _e592;
    local_45 = static_cast<uint>(21);
    type_9 _e597 = local_44;
    local_149 = _e597;
    uint _e599 = local_45;
    uint _e601 = local_149.inner[1];
    local_149.inner[1] = _e601 + _e599;
    uint _e605 = local_149.inner[0];
    local_150 = static_cast<uint>(_e605);
    uint _e609 = local_149.inner[1];
    local_151 = static_cast<uint>(_e609);
    uint _e612 = local_151;
    out_1[_e612] = as_type<uint>(_e590);
    type_9 _e614 = points;
    local_50 = _e614;
    local_51 = static_cast<uint>(0);
    type_9 _e619 = local_50;
    local_152 = _e619;
    uint _e621 = local_51;
    uint _e623 = local_152.inner[1];
    local_152.inner[1] = _e623 + _e621;
    uint _e627 = local_152.inner[0];
    local_153 = static_cast<uint>(_e627);
    uint _e631 = local_152.inner[1];
    local_154 = static_cast<uint>(_e631);
    uint _e634 = local_154;
    float _e637 = points_1[_e634].y;
    local_155 = _e637;
    float _e639 = local_155;
    local_74 = _e639;
    float _e641 = local_74;
    type_9 _e643 = out;
    local_48 = _e643;
    local_49 = static_cast<uint>(22);
    type_9 _e648 = local_48;
    local_156 = _e648;
    uint _e650 = local_49;
    uint _e652 = local_156.inner[1];
    local_156.inner[1] = _e652 + _e650;
    uint _e656 = local_156.inner[0];
    local_157 = static_cast<uint>(_e656);
    uint _e660 = local_156.inner[1];
    local_158 = static_cast<uint>(_e660);
    uint _e663 = local_158;
    out_1[_e663] = as_type<uint>(_e641);
    type_9 _e665 = points;
    local_54 = _e665;
    local_55 = static_cast<uint>(0);
    type_9 _e670 = local_54;
    local_159 = _e670;
    uint _e672 = local_55;
    uint _e674 = local_159.inner[1];
    local_159.inner[1] = _e674 + _e672;
    uint _e678 = local_159.inner[0];
    local_160 = static_cast<uint>(_e678);
    uint _e682 = local_159.inner[1];
    local_161 = static_cast<uint>(_e682);
    uint _e685 = local_161;
    float _e688 = points_1[_e685].z;
    local_162 = _e688;
    float _e690 = local_162;
    local_75 = _e690;
    float _e692 = local_75;
    type_9 _e694 = out;
    local_52 = _e694;
    local_53 = static_cast<uint>(23);
    type_9 _e699 = local_52;
    local_163 = _e699;
    uint _e701 = local_53;
    uint _e703 = local_163.inner[1];
    local_163.inner[1] = _e703 + _e701;
    uint _e707 = local_163.inner[0];
    local_164 = static_cast<uint>(_e707);
    uint _e711 = local_163.inner[1];
    local_165 = static_cast<uint>(_e711);
    uint _e714 = local_165;
    out_1[_e714] = as_type<uint>(_e692);
    type_9 _e716 = out;
    local_56 = _e716;
    local_57 = static_cast<uint>(24);
    type_9 _e721 = local_56;
    local_166 = _e721;
    uint _e723 = local_57;
    uint _e725 = local_166.inner[1];
    local_166.inner[1] = _e725 + _e723;
    uint _e729 = local_166.inner[0];
    local_167 = static_cast<uint>(_e729);
    uint _e733 = local_166.inner[1];
    local_168 = static_cast<uint>(_e733);
    uint _e736 = local_168;
    out_1[_e736] = limit_1;
    uint _e739 = thread_component(0u, threadIdx_1);
    uint _e741 = group_component(1u, blockIdx_1);
    uint _e744 = shape_component(2u);
    uint _e747 = grid_component(0u, gridDim_1);
    type_9 _e749 = out;
    local_58 = _e749;
    local_59 = static_cast<uint>(25);
    type_9 _e754 = local_58;
    local_169 = _e754;
    uint _e756 = local_59;
    uint _e758 = local_169.inner[1];
    local_169.inner[1] = _e758 + _e756;
    uint _e762 = local_169.inner[0];
    local_170 = static_cast<uint>(_e762);
    uint _e766 = local_169.inner[1];
    local_171 = static_cast<uint>(_e766);
    uint _e769 = local_171;
    out_1[_e769] = ((_e739 + _e741) + _e744) + _e747;
    uint _e771 = global_x(threadIdx_1, blockIdx_1);
    uint _e772 = global_x(threadIdx_1, blockIdx_1);
    type_9 _e774 = out;
    local_60 = _e774;
    local_61 = static_cast<uint>(26);
    type_9 _e779 = local_60;
    local_172 = _e779;
    uint _e781 = local_61;
    uint _e783 = local_172.inner[1];
    local_172.inner[1] = _e783 + _e781;
    uint _e787 = local_172.inner[0];
    local_173 = static_cast<uint>(_e787);
    uint _e791 = local_172.inner[1];
    local_174 = static_cast<uint>(_e791);
    uint _e794 = local_174;
    out_1[_e794] = _e771 + _e772;
    type_9 _e796 = input;
    local_64 = _e796;
    local_65 = static_cast<uint>(0);
    type_9 _e801 = local_64;
    local_175 = _e801;
    uint _e803 = local_65;
    uint _e805 = local_175.inner[1];
    local_175.inner[1] = _e805 + _e803;
    uint _e809 = local_175.inner[0];
    local_176 = static_cast<uint>(_e809);
    uint _e813 = local_175.inner[1];
    local_177 = static_cast<uint>(_e813);
    uint _e816 = local_177;
    int _e818 = input_1[_e816];
    local_178 = _e818;
    int _e820 = local_178;
    local_76 = _e820;
    int _e822 = local_76;
    type_9 _e825 = points;
    local_66 = _e825;
    local_67 = static_cast<uint>(0);
    type_9 _e830 = local_66;
    local_179 = _e830;
    uint _e832 = local_67;
    uint _e834 = local_179.inner[1];
    local_179.inner[1] = _e834 + _e832;
    uint _e838 = local_179.inner[0];
    local_180 = static_cast<uint>(_e838);
    uint _e842 = local_179.inner[1];
    local_181 = static_cast<uint>(_e842);
    uint _e845 = local_181;
    float _e848 = points_1[_e845].x;
    local_182 = _e848;
    float _e850 = local_182;
    local_77 = _e850;
    float _e852 = local_77;
    type_9 _e855 = out;
    local_62 = _e855;
    local_63 = static_cast<uint>(27);
    type_9 _e860 = local_62;
    local_183 = _e860;
    uint _e862 = local_63;
    uint _e864 = local_183.inner[1];
    local_183.inner[1] = _e864 + _e862;
    uint _e868 = local_183.inner[0];
    local_184 = static_cast<uint>(_e868);
    uint _e872 = local_183.inner[1];
    local_185 = static_cast<uint>(_e872);
    uint _e875 = local_185;
    out_1[_e875] = as_type<uint>((static_cast<float>(_e822) * scale_1) + _e852);
    uint _e878 = kind(threadIdx.x);
    type_9 _e879 = out;
    local_68 = _e879;
    local_69 = static_cast<uint>(28);
    type_9 _e884 = local_68;
    local_186 = _e884;
    uint _e886 = local_69;
    uint _e888 = local_186.inner[1];
    local_186.inner[1] = _e888 + _e886;
    uint _e892 = local_186.inner[0];
    local_187 = static_cast<uint>(_e892);
    uint _e896 = local_186.inner[1];
    local_188 = static_cast<uint>(_e896);
    uint _e899 = local_188;
    out_1[_e899] = _e878;
    uint _e902 = grid_component(2u, gridDim_1);
    type_9 _e903 = out;
    local_70 = _e903;
    local_71 = static_cast<uint>(29);
    type_9 _e908 = local_70;
    local_189 = _e908;
    uint _e910 = local_71;
    uint _e912 = local_189.inner[1];
    local_189.inner[1] = _e912 + _e910;
    uint _e916 = local_189.inner[0];
    local_190 = static_cast<uint>(_e916);
    uint _e920 = local_189.inner[1];
    local_191 = static_cast<uint>(_e920);
    uint _e923 = local_191;
    out_1[_e923] = _e902;
}
