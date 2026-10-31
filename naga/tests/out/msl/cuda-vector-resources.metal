// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

struct float3_ {
    float x;
    float y;
    float z;
};
typedef float3_ type_2[1];

float3_ shift(
    float3_ value
) {
    float3_ value_1 = {};
    value_1 = value;
    float _e4 = value_1.x;
    value_1.x = _e4 + 1.0;
    float _e9 = value_1.y;
    float _e10 = value_1.z;
    value_1.z = _e9 + _e10;
    float3_ _e12 = value_1;
    return _e12;
}

float pair(
    float3_ value_2,
    int digit
) {
    float3_ value_3 = {};
    value_3 = value_2;
    float _e4 = value_3.x;
    return (_e4 * 10.0) + static_cast<float>(digit);
}

kernel void vector_resources(
  device type_2 const& input [[user(fake0)]]
, device type_2& output [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    int i = {};
    float3_ copied = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    int index = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    bool choose_first = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    float local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    float local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    float3_ local_24 = {};
    bool pick_local = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    float3_ snapshot = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    float3_ local_36 = {};
    float3_ local_37 = {};
    float3_ local_38 = {};
    float local_39 = {};
    float local_40 = {};
    float local_41 = {};
    float local_42 = {};
    float3_ local_43 = {};
    float local_44 = {};
    float local_45 = {};
    float3_ local_46 = {};
    float3_ local_47 = {};
    uint local_48 = {};
    float3_ local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    float3_ local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    float3_ local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    float local_63 = {};
    uint local_64 = {};
    float local_65 = {};
    uint local_66 = {};
    float local_67 = {};
    uint local_68 = {};
    float local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    float3_ local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    float local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    float local_79 = {};
    uint local_80 = {};
    float3_ local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    uint local_91 = {};
    float3_ local_92 = {};
    uint local_93 = {};
    uint local_94 = {};
    {
        i = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e31 = i;
                i = as_type<int>(as_type<uint>(_e31) + as_type<uint>(1));
            }
            loop_init = false;
            int _e2 = i;
            if (_e2 < 3) {
            } else {
                break;
            }
            int _e5 = i;
            local = static_cast<uint>(_e5);
            uint _e8 = local;
            local_48 = static_cast<uint>(_e8);
            uint _e11 = local_48;
            float3_ _e14 = input[_e11];
            local_49 = _e14;
            float3_ _e16 = local_49;
            local_36 = _e16;
            float3_ _e18 = local_36;
            copied = _e18;
            float3_ _e20 = copied;
            float3_ _e21 = shift(_e20);
            int _e22 = i;
            local_1 = static_cast<uint>(_e22);
            uint _e25 = local_1;
            local_50 = static_cast<uint>(_e25);
            uint _e28 = local_50;
            output[_e28] = _e21;
        }
    }
    local_3 = static_cast<uint>(0);
    uint _e37 = local_3;
    local_51 = static_cast<uint>(_e37);
    uint _e40 = local_51;
    float3_ _e43 = input[_e40];
    local_52 = _e43;
    float3_ _e45 = local_52;
    local_37 = _e45;
    float3_ _e47 = local_37;
    local_2 = static_cast<uint>(3);
    uint _e51 = local_2;
    local_53 = static_cast<uint>(_e51);
    uint _e54 = local_53;
    output[_e54] = _e47;
    local_5 = static_cast<uint>(1);
    uint _e60 = local_5;
    local_54 = static_cast<uint>(_e60);
    uint _e63 = local_54;
    float3_ _e65 = input[_e63];
    local_55 = _e65;
    float3_ _e67 = local_55;
    local_38 = _e67;
    float3_ _e69 = local_38;
    float3_ _e70 = shift(_e69);
    local_4 = static_cast<uint>(3);
    uint _e75 = local_4;
    local_56 = static_cast<uint>(_e75);
    uint _e78 = local_56;
    output[_e78].y = _e70.x;
    index = 0;
    index = 1;
    local_7 = static_cast<uint>(2);
    uint _e87 = local_7;
    local_57 = static_cast<uint>(_e87);
    uint _e90 = local_57;
    float _e93 = input[_e90].x;
    int _e94 = index;
    index = as_type<int>(as_type<uint>(_e94) + as_type<uint>(1));
    local_6 = static_cast<uint>(_e94);
    uint _e99 = local_6;
    local_58 = static_cast<uint>(_e99);
    uint _e102 = local_58;
    output[_e102].x = _e93;
    int _e105 = index;
    local_9 = static_cast<uint>(0);
    uint _e109 = local_9;
    local_59 = static_cast<uint>(_e109);
    uint _e112 = local_59;
    float _e115 = input[_e112].x;
    local_10 = static_cast<uint>(1);
    uint _e119 = local_10;
    local_60 = static_cast<uint>(_e119);
    uint _e122 = local_60;
    float _e125 = input[_e122].x;
    local_8 = static_cast<uint>(4);
    uint _e131 = local_8;
    local_61 = static_cast<uint>(_e131);
    uint _e134 = local_61;
    output[_e134] = float3_ {static_cast<float>(_e105), _e115, _e125};
    choose_first = true;
    bool _e138 = choose_first;
    if (_e138) {
        local_11 = static_cast<uint>(0);
        uint _e142 = local_11;
        local_62 = static_cast<uint>(_e142);
        uint _e145 = local_62;
        float _e148 = output[_e145].y;
        local_63 = _e148;
        float _e150 = local_63;
        local_39 = _e150;
        float _e152 = local_39;
        uint _e155 = local_62;
        output[_e155].y = _e152 + 2.0;
    } else {
        local_12 = static_cast<uint>(2);
        uint _e161 = local_12;
        local_64 = static_cast<uint>(_e161);
        uint _e164 = local_64;
        float _e167 = output[_e164].y;
        local_65 = _e167;
        float _e169 = local_65;
        local_40 = _e169;
        float _e171 = local_40;
        uint _e174 = local_64;
        output[_e174].y = _e171 + 2.0;
    }
    bool _e177 = choose_first;
    if (_e177) {
        local_14 = static_cast<uint>(0);
        uint _e181 = local_14;
        local_66 = static_cast<uint>(_e181);
        uint _e184 = local_66;
        float _e187 = output[_e184].z;
        local_67 = _e187;
        float _e189 = local_67;
        local_41 = _e189;
        float _e191 = local_41;
        uint _e195 = local_66;
        output[_e195].z = _e191 + static_cast<float>(1);
        local_16 = _e191;
    } else {
        local_15 = static_cast<uint>(2);
        uint _e202 = local_15;
        local_68 = static_cast<uint>(_e202);
        uint _e205 = local_68;
        float _e208 = output[_e205].z;
        local_69 = _e208;
        float _e210 = local_69;
        local_42 = _e210;
        float _e212 = local_42;
        uint _e216 = local_68;
        output[_e216].z = _e212 + static_cast<float>(1);
        local_16 = _e212;
    }
    float _e221 = local_16;
    local_13 = static_cast<uint>(4);
    uint _e225 = local_13;
    local_70 = static_cast<uint>(_e225);
    uint _e228 = local_70;
    output[_e228].x = _e221;
    int _e231 = index;
    local_17 = static_cast<uint>(4);
    uint _e236 = local_17;
    local_71 = static_cast<uint>(_e236);
    uint _e239 = local_71;
    output[_e239].z = static_cast<float>(_e231);
    local_20 = static_cast<uint>(1);
    uint _e245 = local_20;
    local_72 = static_cast<uint>(_e245);
    uint _e248 = local_72;
    float3_ _e250 = input[_e248];
    local_73 = _e250;
    float3_ _e252 = local_73;
    local_43 = _e252;
    float3_ _e254 = local_43;
    bool _e255 = choose_first;
    if (_e255) {
        local_18 = static_cast<uint>(0);
        uint _e259 = local_18;
        local_74 = static_cast<uint>(_e259);
        uint _e262 = local_74;
        output[_e262] = _e254;
        uint _e264 = local_18;
        local_75 = static_cast<uint>(_e264);
        uint _e267 = local_75;
        float _e270 = output[_e267].x;
        local_76 = _e270;
        float _e272 = local_76;
        local_44 = _e272;
        float _e274 = local_44;
        uint _e278 = local_75;
        output[_e278].x = _e274 + static_cast<float>(1);
        local_21 = _e274;
    } else {
        local_19 = static_cast<uint>(2);
        uint _e285 = local_19;
        local_77 = static_cast<uint>(_e285);
        uint _e288 = local_77;
        output[_e288] = _e254;
        uint _e290 = local_19;
        local_78 = static_cast<uint>(_e290);
        uint _e293 = local_78;
        float _e296 = output[_e293].x;
        local_79 = _e296;
        float _e298 = local_79;
        local_45 = _e298;
        float _e300 = local_45;
        uint _e304 = local_78;
        output[_e304].x = _e300 + static_cast<float>(1);
        local_21 = _e300;
    }
    local_23 = static_cast<uint>(0);
    uint _e311 = local_23;
    local_80 = static_cast<uint>(_e311);
    uint _e314 = local_80;
    float3_ _e316 = output[_e314];
    local_81 = _e316;
    float3_ _e318 = local_81;
    local_46 = _e318;
    float3_ _e320 = local_46;
    local_22 = static_cast<uint>(5);
    uint _e324 = local_22;
    local_82 = static_cast<uint>(_e324);
    uint _e327 = local_82;
    output[_e327] = _e320;
    local_24 = float3_ {static_cast<float>(20), static_cast<float>(30), static_cast<float>(40)};
    pick_local = false;
    pick_local = true;
    bool _e340 = pick_local;
    if (_e340) {
        local_24.z = 7.0;
    } else {
        local_25 = static_cast<uint>(1);
        uint _e346 = local_25;
        local_83 = static_cast<uint>(_e346);
        uint _e349 = local_83;
        output[_e349].z = 7.0;
    }
    float3_ _e353 = local_24;
    local_26 = static_cast<uint>(6);
    uint _e357 = local_26;
    local_84 = static_cast<uint>(_e357);
    uint _e360 = local_84;
    output[_e360] = _e353;
    local_28 = static_cast<uint>(1);
    uint _e365 = local_28;
    local_85 = static_cast<uint>(_e365);
    uint _e368 = local_85;
    float _e371 = output[_e368].z;
    local_27 = static_cast<uint>(6);
    uint _e375 = local_27;
    local_86 = static_cast<uint>(_e375);
    uint _e378 = local_86;
    output[_e378].x = _e371;
    local_30 = static_cast<uint>(0);
    uint _e384 = local_30;
    local_87 = static_cast<uint>(_e384);
    uint _e387 = local_87;
    float _e390 = output[_e387].x;
    local_31 = static_cast<uint>(1);
    uint _e394 = local_31;
    local_88 = static_cast<uint>(_e394);
    uint _e397 = local_88;
    float _e400 = output[_e397].x;
    local_32 = static_cast<uint>(2);
    uint _e404 = local_32;
    local_89 = static_cast<uint>(_e404);
    uint _e407 = local_89;
    float _e410 = output[_e407].x;
    local_29 = static_cast<uint>(7);
    uint _e415 = local_29;
    local_90 = static_cast<uint>(_e415);
    uint _e418 = local_90;
    output[_e418] = float3_ {_e390, _e400, _e410};
    local_33 = static_cast<uint>(0);
    uint _e423 = local_33;
    local_91 = static_cast<uint>(_e423);
    uint _e426 = local_91;
    float3_ _e428 = input[_e426];
    local_92 = _e428;
    float3_ _e430 = local_92;
    local_47 = _e430;
    float3_ _e432 = local_47;
    snapshot = _e432;
    float3_ _e434 = snapshot;
    snapshot.x = 9.0;
    float _e438 = pair(_e434, 4);
    float _e440 = snapshot.x;
    local_35 = static_cast<uint>(2);
    uint _e444 = local_35;
    local_93 = static_cast<uint>(_e444);
    uint _e447 = local_93;
    float _e450 = input[_e447].z;
    local_34 = static_cast<uint>(8);
    uint _e455 = local_34;
    local_94 = static_cast<uint>(_e455);
    uint _e458 = local_94;
    output[_e458] = float3_ {_e438, _e440, _e450};
}
