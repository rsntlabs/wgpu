// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_2[1];
typedef uint type_3[1];
struct type_5 {
    uint inner[2];
};

struct for_conditionsInput {
};
kernel void for_conditions(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_2 const& input_4 [[buffer(0)]]
, device type_3& output_1 [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    type_5 input = {};
    type_5 output = {};
    int cursor = {};
    int total = {};
    uint iterations = {};
    uint observed = {};
    int value = {};
    type_5 local = {};
    int local_1 = {};
    type_5 local_2 = {};
    type_5 local_3 = {};
    uint local_4 = {};
    type_5 local_5 = {};
    uint local_6 = {};
    type_5 local_7 = {};
    uint local_8 = {};
    int inferred_cursor = {};
    int inferred_total = {};
    type_5 local_9 = {};
    int local_10 = {};
    int value_1 = {};
    type_5 local_11 = {};
    uint local_12 = {};
    type_5 local_13 = {};
    uint local_14 = {};
    int break_cursor = {};
    int first = {};
    uint continued = {};
    type_5 local_15 = {};
    int local_16 = {};
    int value_2 = {};
    type_5 local_17 = {};
    uint local_18 = {};
    type_5 local_19 = {};
    uint local_20 = {};
    type_5 input_1 = {};
    uint offset = {};
    type_5 local_21 = {};
    uint local_22 = {};
    int local_23 = {};
    int local_24 = {};
    int local_25 = {};
    type_5 input_2 = {};
    uint offset_1 = {};
    type_5 local_26 = {};
    uint local_27 = {};
    int local_28 = {};
    int local_29 = {};
    int local_30 = {};
    type_5 input_3 = {};
    uint offset_2 = {};
    type_5 local_31 = {};
    uint local_32 = {};
    int local_33 = {};
    int local_34 = {};
    int local_35 = {};
    type_5 local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    int local_39 = {};
    type_5 local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    type_5 local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    type_5 local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    type_5 local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    type_5 local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    int local_55 = {};
    type_5 local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    type_5 local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    type_5 local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    int local_65 = {};
    type_5 local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    type_5 local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    input = type_5 {};
    input.inner[0] = 2u;
    input.inner[1] = 0u;
    output = type_5 {};
    output.inner[0] = 3u;
    output.inner[1] = 0u;
    uint lane = threadIdx.x + (blockIdx.x * 4u);
    if (lane >= 4u) {
        return;
    }
    uint offset_3 = lane * 4u;
    uint base = 4u + (lane * 8u);
    cursor = 0;
    total = 0;
    iterations = 0u;
    observed = 0u;
    {
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e102 = value;
                uint _e104 = observed;
                observed = _e104 + static_cast<uint>(_e102);
                uint _e106 = iterations;
                iterations = _e106 + static_cast<uint>(1);
            }
            loop_init = false;
            type_5 _e36 = input;
            local = _e36;
            offset = uint {};
            local_22 = uint {};
            local_23 = int {};
            type_5 _e44 = local;
            input_1 = _e44;
            offset = offset_3;
            type_5 _e48 = input_1;
            local_21 = _e48;
            int _e50 = cursor;
            local_24 = _e50;
            int _e52 = local_24;
            cursor = as_type<int>(as_type<uint>(_e52) + as_type<uint>(1));
            uint _e56 = offset;
            local_22 = static_cast<uint>(_e56 + static_cast<uint>(_e52));
            type_5 _e60 = local_21;
            local_36 = _e60;
            uint _e62 = local_22;
            uint _e64 = local_36.inner[1];
            local_36.inner[1] = _e64 + _e62;
            uint _e68 = local_36.inner[0];
            local_37 = static_cast<uint>(_e68);
            uint _e72 = local_36.inner[1];
            local_38 = static_cast<uint>(_e72);
            uint _e75 = local_38;
            int _e78 = input_4[_e75];
            local_39 = _e78;
            int _e80 = local_39;
            local_25 = _e80;
            int _e82 = local_25;
            local_23 = _e82;
            int _e84 = local_23;
            local_1 = _e84;
            int _e86 = local_1;
            value = _e86;
            int _e88 = value;
            if (_e88 != 0) {
            } else {
                break;
            }
            int _e91 = value;
            int _e92 = total;
            total = as_type<int>(as_type<uint>(_e92) + as_type<uint>(_e91));
            uint _e94 = iterations;
            value = as_type<int>(as_type<uint>(10) + as_type<uint>(static_cast<int>(_e94)));
            uint _e98 = iterations;
            if (_e98 == 0u) {
                continue;
            }
        }
    }
    int _e110 = total;
    type_5 _e113 = output;
    local_2 = _e113;
    type_5 _e115 = local_2;
    local_40 = _e115;
    uint _e118 = local_40.inner[1];
    local_40.inner[1] = _e118 + base;
    uint _e122 = local_40.inner[0];
    local_41 = static_cast<uint>(_e122);
    uint _e126 = local_40.inner[1];
    local_42 = static_cast<uint>(_e126);
    uint _e129 = local_42;
    output_1[_e129] = static_cast<uint>(_e110);
    int _e132 = cursor;
    type_5 _e134 = output;
    local_3 = _e134;
    local_4 = static_cast<uint>(base + 1u);
    type_5 _e140 = local_3;
    local_43 = _e140;
    uint _e142 = local_4;
    uint _e144 = local_43.inner[1];
    local_43.inner[1] = _e144 + _e142;
    uint _e148 = local_43.inner[0];
    local_44 = static_cast<uint>(_e148);
    uint _e152 = local_43.inner[1];
    local_45 = static_cast<uint>(_e152);
    uint _e155 = local_45;
    output_1[_e155] = static_cast<uint>(_e132);
    uint _e157 = iterations;
    type_5 _e158 = output;
    local_5 = _e158;
    local_6 = static_cast<uint>(base + 2u);
    type_5 _e164 = local_5;
    local_46 = _e164;
    uint _e166 = local_6;
    uint _e168 = local_46.inner[1];
    local_46.inner[1] = _e168 + _e166;
    uint _e172 = local_46.inner[0];
    local_47 = static_cast<uint>(_e172);
    uint _e176 = local_46.inner[1];
    local_48 = static_cast<uint>(_e176);
    uint _e179 = local_48;
    output_1[_e179] = _e157;
    uint _e181 = observed;
    type_5 _e182 = output;
    local_7 = _e182;
    local_8 = static_cast<uint>(base + 3u);
    type_5 _e188 = local_7;
    local_49 = _e188;
    uint _e190 = local_8;
    uint _e192 = local_49.inner[1];
    local_49.inner[1] = _e192 + _e190;
    uint _e196 = local_49.inner[0];
    local_50 = static_cast<uint>(_e196);
    uint _e200 = local_49.inner[1];
    local_51 = static_cast<uint>(_e200);
    uint _e203 = local_51;
    output_1[_e203] = _e181;
    inferred_cursor = 0;
    inferred_total = 0;
    {
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                value_1 = 0;
            }
            loop_init_1 = false;
            type_5 _e210 = input;
            local_9 = _e210;
            offset_1 = uint {};
            local_27 = uint {};
            local_28 = int {};
            type_5 _e218 = local_9;
            input_2 = _e218;
            offset_1 = offset_3;
            type_5 _e222 = input_2;
            local_26 = _e222;
            int _e224 = inferred_cursor;
            local_29 = _e224;
            int _e226 = local_29;
            inferred_cursor = as_type<int>(as_type<uint>(_e226) + as_type<uint>(1));
            uint _e230 = offset_1;
            local_27 = static_cast<uint>(_e230 + static_cast<uint>(_e226));
            type_5 _e234 = local_26;
            local_52 = _e234;
            uint _e236 = local_27;
            uint _e238 = local_52.inner[1];
            local_52.inner[1] = _e238 + _e236;
            uint _e242 = local_52.inner[0];
            local_53 = static_cast<uint>(_e242);
            uint _e246 = local_52.inner[1];
            local_54 = static_cast<uint>(_e246);
            uint _e249 = local_54;
            int _e252 = input_4[_e249];
            local_55 = _e252;
            int _e254 = local_55;
            local_30 = _e254;
            int _e256 = local_30;
            local_28 = _e256;
            int _e258 = local_28;
            local_10 = _e258;
            int _e260 = local_10;
            value_1 = _e260;
            int _e262 = value_1;
            if (_e262 != 0) {
            } else {
                break;
            }
            int _e265 = value_1;
            int _e266 = inferred_total;
            inferred_total = as_type<int>(as_type<uint>(_e266) + as_type<uint>(_e265));
            value_1 = 99;
        }
    }
    int _e271 = inferred_total;
    type_5 _e273 = output;
    local_11 = _e273;
    local_12 = static_cast<uint>(base + 4u);
    type_5 _e279 = local_11;
    local_56 = _e279;
    uint _e281 = local_12;
    uint _e283 = local_56.inner[1];
    local_56.inner[1] = _e283 + _e281;
    uint _e287 = local_56.inner[0];
    local_57 = static_cast<uint>(_e287);
    uint _e291 = local_56.inner[1];
    local_58 = static_cast<uint>(_e291);
    uint _e294 = local_58;
    output_1[_e294] = static_cast<uint>(_e271);
    int _e296 = inferred_cursor;
    type_5 _e298 = output;
    local_13 = _e298;
    local_14 = static_cast<uint>(base + 5u);
    type_5 _e304 = local_13;
    local_59 = _e304;
    uint _e306 = local_14;
    uint _e308 = local_59.inner[1];
    local_59.inner[1] = _e308 + _e306;
    uint _e312 = local_59.inner[0];
    local_60 = static_cast<uint>(_e312);
    uint _e316 = local_59.inner[1];
    local_61 = static_cast<uint>(_e316);
    uint _e319 = local_61;
    output_1[_e319] = static_cast<uint>(_e296);
    break_cursor = 0;
    first = 0;
    continued = 0u;
    {
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e384 = continued;
                continued = _e384 + static_cast<uint>(1);
            }
            loop_init_2 = false;
            type_5 _e328 = input;
            local_15 = _e328;
            offset_2 = uint {};
            local_32 = uint {};
            local_33 = int {};
            type_5 _e336 = local_15;
            input_3 = _e336;
            offset_2 = offset_3;
            type_5 _e340 = input_3;
            local_31 = _e340;
            int _e342 = break_cursor;
            local_34 = _e342;
            int _e344 = local_34;
            break_cursor = as_type<int>(as_type<uint>(_e344) + as_type<uint>(1));
            uint _e348 = offset_2;
            local_32 = static_cast<uint>(_e348 + static_cast<uint>(_e344));
            type_5 _e352 = local_31;
            local_62 = _e352;
            uint _e354 = local_32;
            uint _e356 = local_62.inner[1];
            local_62.inner[1] = _e356 + _e354;
            uint _e360 = local_62.inner[0];
            local_63 = static_cast<uint>(_e360);
            uint _e364 = local_62.inner[1];
            local_64 = static_cast<uint>(_e364);
            uint _e367 = local_64;
            int _e370 = input_4[_e367];
            local_65 = _e370;
            int _e372 = local_65;
            local_35 = _e372;
            int _e374 = local_35;
            local_33 = _e374;
            int _e376 = local_33;
            local_16 = _e376;
            int _e378 = local_16;
            value_2 = _e378;
            int _e380 = value_2;
            if (_e380 != 0) {
            } else {
                break;
            }
            int _e383 = value_2;
            first = _e383;
            break;
        }
    }
    int _e388 = break_cursor;
    type_5 _e390 = output;
    local_17 = _e390;
    local_18 = static_cast<uint>(base + 6u);
    type_5 _e396 = local_17;
    local_66 = _e396;
    uint _e398 = local_18;
    uint _e400 = local_66.inner[1];
    local_66.inner[1] = _e400 + _e398;
    uint _e404 = local_66.inner[0];
    local_67 = static_cast<uint>(_e404);
    uint _e408 = local_66.inner[1];
    local_68 = static_cast<uint>(_e408);
    uint _e411 = local_68;
    output_1[_e411] = static_cast<uint>(_e388);
    int _e413 = first;
    uint _e415 = continued;
    type_5 _e419 = output;
    local_19 = _e419;
    local_20 = static_cast<uint>(base + 7u);
    type_5 _e425 = local_19;
    local_69 = _e425;
    uint _e427 = local_20;
    uint _e429 = local_69.inner[1];
    local_69.inner[1] = _e429 + _e427;
    uint _e433 = local_69.inner[0];
    local_70 = static_cast<uint>(_e433);
    uint _e437 = local_69.inner[1];
    local_71 = static_cast<uint>(_e437);
    uint _e440 = local_71;
    output_1[_e440] = static_cast<uint>(_e413) + (100u * _e415);
}
