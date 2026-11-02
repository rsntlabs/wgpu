// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size2;
};

typedef uint type_2[1];
struct type_3 {
    uint inner[2];
};

kernel void nullable(
  device type_2& output_1 [[user(fake0)]]
, device type_2 const& first_1 [[user(fake0)]]
, device type_2 const& second_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_3 output = {};
    type_3 first = {};
    type_3 second = {};
    type_3 local = {};
    uint local_1 = {};
    type_3 selected = {};
    type_3 local_2 = {};
    uint local_3 = {};
    type_3 local_4 = {};
    uint local_5 = {};
    type_3 local_6 = {};
    type_3 saved = {};
    type_3 local_7 = {};
    uint local_8 = {};
    type_3 local_9 = {};
    bool local_10 = {};
    type_3 local_11 = {};
    uint local_12 = {};
    type_3 local_13 = {};
    type_3 local_14 = {};
    uint local_15 = {};
    type_3 local_16 = {};
    bool local_17 = {};
    type_3 local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    type_3 local_22 = {};
    type_3 local_23 = {};
    uint local_24 = {};
    type_3 values = {};
    uint fallback = {};
    type_3 local_25 = {};
    bool local_26 = {};
    type_3 local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    type_3 values_1 = {};
    uint fallback_1 = {};
    type_3 local_32 = {};
    bool local_33 = {};
    type_3 local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    type_3 values_2 = {};
    uint fallback_2 = {};
    type_3 local_39 = {};
    bool local_40 = {};
    type_3 local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    type_3 local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    type_3 local_49 = {};
    type_3 local_50 = {};
    type_3 local_51 = {};
    type_3 local_52 = {};
    type_3 local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    type_3 local_56 = {};
    type_3 local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    type_3 local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    type_3 local_64 = {};
    type_3 local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    type_3 local_68 = {};
    type_3 local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    type_3 local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    type_3 local_76 = {};
    type_3 local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    type_3 local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    output = type_3 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    first = type_3 {};
    first.inner[0] = 3u;
    first.inner[1] = 0u;
    second = type_3 {};
    second.inner[0] = 4u;
    second.inner[1] = 0u;
    type_3 _e19 = output;
    local = _e19;
    local_1 = static_cast<uint>(0);
    type_3 _e24 = local;
    local_46 = _e24;
    uint _e26 = local_1;
    uint _e28 = local_46.inner[1];
    local_46.inner[1] = _e28 + _e26;
    uint _e32 = local_46.inner[0];
    local_47 = static_cast<uint>(_e32);
    uint _e36 = local_46.inner[1];
    local_48 = static_cast<uint>(_e36);
    uint _e39 = local_48;
    uint choice = output_1[_e39];
    selected = type_3 {};
    selected.inner[0] = 1u;
    if (choice == 1u) {
        type_3 _e50 = first;
        local_2 = _e50;
        local_3 = static_cast<uint>(1);
        type_3 _e55 = local_2;
        local_49 = _e55;
        uint _e57 = local_3;
        uint _e59 = local_49.inner[1];
        local_49.inner[1] = _e59 + _e57;
        type_3 _e62 = local_49;
        selected = _e62;
    } else {
        if (choice == 2u) {
            type_3 _e67 = second;
            local_4 = _e67;
            local_5 = static_cast<uint>(1);
            type_3 _e72 = local_4;
            local_50 = _e72;
            uint _e74 = local_5;
            uint _e76 = local_50.inner[1];
            local_50.inner[1] = _e76 + _e74;
            type_3 _e79 = local_50;
            selected = _e79;
        }
    }
    type_3 _e82 = selected;
    local_6 = _e82;
    type_3 _e84 = local_6;
    saved = _e84;
    local_51 = type_3 {};
    local_51.inner[0] = 1u;
    type_3 _e90 = local_51;
    selected = _e90;
    type_3 _e91 = selected;
    local_9 = _e91;
    type_3 _e93 = local_9;
    local_52 = _e93;
    uint _e96 = local_52.inner[0];
    local_10 = _e96 != 1u;
    bool _e100 = local_10;
    type_3 _e102 = output;
    local_7 = _e102;
    local_8 = static_cast<uint>(1);
    type_3 _e107 = local_7;
    local_53 = _e107;
    uint _e109 = local_8;
    uint _e111 = local_53.inner[1];
    local_53.inner[1] = _e111 + _e109;
    uint _e115 = local_53.inner[0];
    local_54 = static_cast<uint>(_e115);
    uint _e119 = local_53.inner[1];
    local_55 = static_cast<uint>(_e119);
    uint _e122 = local_55;
    output_1[_e122] = static_cast<uint>(_e100);
    type_3 _e125 = saved;
    local_13 = _e125;
    fallback = uint {};
    local_26 = bool {};
    local_28 = uint {};
    local_29 = uint {};
    local_30 = uint {};
    type_3 _e137 = local_13;
    values = _e137;
    fallback = 17u;
    type_3 _e142 = values;
    local_25 = _e142;
    type_3 _e144 = local_25;
    local_56 = _e144;
    uint _e147 = local_56.inner[0];
    local_26 = _e147 != 1u;
    bool _e151 = local_26;
    if (_e151) {
        type_3 _e152 = values;
        local_27 = _e152;
        local_28 = static_cast<uint>(0);
        type_3 _e157 = local_27;
        local_57 = _e157;
        uint _e159 = local_28;
        uint _e161 = local_57.inner[1];
        local_57.inner[1] = _e161 + _e159;
        uint _e165 = local_57.inner[0];
        local_58 = static_cast<uint>(_e165);
        uint _e169 = local_57.inner[1];
        local_59 = static_cast<uint>(_e169);
        local_60 = uint {};
        uint _e174 = local_58;
        switch(_e174) {
            case 4u: {
                uint _e175 = local_59;
                uint _e178 = second_1[_e175];
                local_60 = _e178;
                break;
            }
            case 3u: {
                uint _e179 = local_59;
                uint _e182 = first_1[_e179];
                local_60 = _e182;
                break;
            }
            default: {
                break;
            }
        }
        uint _e183 = local_60;
        local_31 = _e183;
        uint _e185 = local_31;
        local_30 = _e185;
        uint _e187 = local_30;
        local_29 = _e187;
    } else {
        uint _e189 = fallback;
        local_29 = _e189;
    }
    uint _e192 = local_29;
    type_3 _e193 = output;
    local_11 = _e193;
    local_12 = static_cast<uint>(2);
    type_3 _e198 = local_11;
    local_61 = _e198;
    uint _e200 = local_12;
    uint _e202 = local_61.inner[1];
    local_61.inner[1] = _e202 + _e200;
    uint _e206 = local_61.inner[0];
    local_62 = static_cast<uint>(_e206);
    uint _e210 = local_61.inner[1];
    local_63 = static_cast<uint>(_e210);
    uint _e213 = local_63;
    output_1[_e213] = _e192;
    type_3 _e215 = saved;
    local_16 = _e215;
    type_3 _e217 = local_16;
    local_64 = _e217;
    uint _e220 = local_64.inner[0];
    local_17 = _e220 == 1u;
    bool _e224 = local_17;
    type_3 _e226 = output;
    local_14 = _e226;
    local_15 = static_cast<uint>(3);
    type_3 _e231 = local_14;
    local_65 = _e231;
    uint _e233 = local_15;
    uint _e235 = local_65.inner[1];
    local_65.inner[1] = _e235 + _e233;
    uint _e239 = local_65.inner[0];
    local_66 = static_cast<uint>(_e239);
    uint _e243 = local_65.inner[1];
    local_67 = static_cast<uint>(_e243);
    uint _e246 = local_67;
    output_1[_e246] = static_cast<uint>(_e224);
    if (choice != 0u) {
        type_3 _e251 = first;
        local_22 = _e251;
        local_21 = 0u;
        local_20 = 1u;
    } else {
        local_21 = 0u;
        local_20 = 0u;
    }
    fallback_1 = uint {};
    local_33 = bool {};
    local_35 = uint {};
    local_36 = uint {};
    local_37 = uint {};
    uint _e272 = local_20;
    if (_e272 != 0u) {
        type_3 _e276 = local_22;
        values_1 = _e276;
    } else {
        values_1 = type_3 {};
        values_1.inner[0] = 1u;
    }
    uint _e283 = local_21;
    uint _e286 = values_1.inner[1];
    values_1.inner[1] = _e286 + _e283;
    fallback_1 = 19u;
    type_3 _e292 = values_1;
    local_32 = _e292;
    type_3 _e294 = local_32;
    local_68 = _e294;
    uint _e297 = local_68.inner[0];
    local_33 = _e297 != 1u;
    bool _e301 = local_33;
    if (_e301) {
        type_3 _e302 = values_1;
        local_34 = _e302;
        local_35 = static_cast<uint>(0);
        type_3 _e307 = local_34;
        local_69 = _e307;
        uint _e309 = local_35;
        uint _e311 = local_69.inner[1];
        local_69.inner[1] = _e311 + _e309;
        uint _e315 = local_69.inner[0];
        local_70 = static_cast<uint>(_e315);
        uint _e319 = local_69.inner[1];
        local_71 = static_cast<uint>(_e319);
        local_72 = uint {};
        uint _e324 = local_70;
        switch(_e324) {
            case 3u: {
                uint _e325 = local_71;
                uint _e328 = first_1[_e325];
                local_72 = _e328;
                break;
            }
            default: {
                break;
            }
        }
        uint _e329 = local_72;
        local_38 = _e329;
        uint _e331 = local_38;
        local_37 = _e331;
        uint _e333 = local_37;
        local_36 = _e333;
    } else {
        uint _e335 = fallback_1;
        local_36 = _e335;
    }
    uint _e338 = local_36;
    type_3 _e339 = output;
    local_18 = _e339;
    local_19 = static_cast<uint>(4);
    type_3 _e344 = local_18;
    local_73 = _e344;
    uint _e346 = local_19;
    uint _e348 = local_73.inner[1];
    local_73.inner[1] = _e348 + _e346;
    uint _e352 = local_73.inner[0];
    local_74 = static_cast<uint>(_e352);
    uint _e356 = local_73.inner[1];
    local_75 = static_cast<uint>(_e356);
    uint _e359 = local_75;
    output_1[_e359] = _e338;
    fallback_2 = uint {};
    local_40 = bool {};
    local_42 = uint {};
    local_43 = uint {};
    local_44 = uint {};
    values_2 = type_3 {};
    values_2.inner[0] = 1u;
    fallback_2 = 23u;
    type_3 _e378 = values_2;
    local_39 = _e378;
    type_3 _e380 = local_39;
    local_76 = _e380;
    uint _e383 = local_76.inner[0];
    local_40 = _e383 != 1u;
    bool _e387 = local_40;
    if (_e387) {
        type_3 _e388 = values_2;
        local_41 = _e388;
        local_42 = static_cast<uint>(0);
        type_3 _e393 = local_41;
        local_77 = _e393;
        uint _e395 = local_42;
        uint _e397 = local_77.inner[1];
        local_77.inner[1] = _e397 + _e395;
        uint _e401 = local_77.inner[0];
        local_78 = static_cast<uint>(_e401);
        uint _e405 = local_77.inner[1];
        local_79 = static_cast<uint>(_e405);
        local_80 = uint {};
        uint _e410 = local_80;
        local_45 = _e410;
        uint _e412 = local_45;
        local_44 = _e412;
        uint _e414 = local_44;
        local_43 = _e414;
    } else {
        uint _e416 = fallback_2;
        local_43 = _e416;
    }
    uint _e419 = local_43;
    type_3 _e420 = output;
    local_23 = _e420;
    local_24 = static_cast<uint>(5);
    type_3 _e425 = local_23;
    local_81 = _e425;
    uint _e427 = local_24;
    uint _e429 = local_81.inner[1];
    local_81.inner[1] = _e429 + _e427;
    uint _e433 = local_81.inner[0];
    local_82 = static_cast<uint>(_e433);
    uint _e437 = local_81.inner[1];
    local_83 = static_cast<uint>(_e437);
    uint _e440 = local_83;
    output_1[_e440] = _e419;
}
