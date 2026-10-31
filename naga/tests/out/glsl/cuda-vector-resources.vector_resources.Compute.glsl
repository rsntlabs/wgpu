#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct float3_ {
    float x;
    float y;
    float z;
};
layout(std430) readonly buffer type_2_block_0Compute { float3_ _group_0_binding_0_cs[]; };

layout(std430) buffer type_2_block_1Compute { float3_ _group_0_binding_1_cs[]; };


float3_ shift(float3_ value) {
    float3_ value_1 = float3_(0.0, 0.0, 0.0);
    value_1 = value;
    float _e4 = value_1.x;
    value_1.x = (_e4 + 1.0);
    float _e9 = value_1.y;
    float _e10 = value_1.z;
    value_1.z = (_e9 + _e10);
    float3_ _e12 = value_1;
    return _e12;
}

float pair(float3_ value_2, int digit) {
    float3_ value_3 = float3_(0.0, 0.0, 0.0);
    value_3 = value_2;
    float _e4 = value_3.x;
    return ((_e4 * 10.0) + float(digit));
}

void main() {
    int i = 0;
    float3_ copied = float3_(0.0, 0.0, 0.0);
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    int index = 0;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    bool choose_first = false;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    float local_16 = 0.0;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    float local_21 = 0.0;
    uint local_22 = 0u;
    uint local_23 = 0u;
    float3_ local_24 = float3_(0.0, 0.0, 0.0);
    bool pick_local = false;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    float3_ snapshot = float3_(0.0, 0.0, 0.0);
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    float3_ local_36 = float3_(0.0, 0.0, 0.0);
    float3_ local_37 = float3_(0.0, 0.0, 0.0);
    float3_ local_38 = float3_(0.0, 0.0, 0.0);
    float local_39 = 0.0;
    float local_40 = 0.0;
    float local_41 = 0.0;
    float local_42 = 0.0;
    float3_ local_43 = float3_(0.0, 0.0, 0.0);
    float local_44 = 0.0;
    float local_45 = 0.0;
    float3_ local_46 = float3_(0.0, 0.0, 0.0);
    float3_ local_47 = float3_(0.0, 0.0, 0.0);
    uint local_48 = 0u;
    float3_ local_49 = float3_(0.0, 0.0, 0.0);
    uint local_50 = 0u;
    float3_ local_51 = float3_(0.0, 0.0, 0.0);
    float3_ local_52 = float3_(0.0, 0.0, 0.0);
    uint local_53 = 0u;
    float local_54 = 0.0;
    uint local_55 = 0u;
    float local_56 = 0.0;
    uint local_57 = 0u;
    float local_58 = 0.0;
    uint local_59 = 0u;
    float local_60 = 0.0;
    float3_ local_61 = float3_(0.0, 0.0, 0.0);
    uint local_62 = 0u;
    uint local_63 = 0u;
    float local_64 = 0.0;
    uint local_65 = 0u;
    uint local_66 = 0u;
    float local_67 = 0.0;
    float3_ local_68 = float3_(0.0, 0.0, 0.0);
    uint local_69 = 0u;
    float3_ local_70 = float3_(0.0, 0.0, 0.0);
    {
        i = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e29 = i;
                i = (_e29 + 1);
            }
            loop_init = false;
            int _e2 = i;
            if ((_e2 < 3)) {
            } else {
                break;
            }
            int _e5 = i;
            local = uint(_e5);
            uint _e8 = local;
            local_48 = _e8;
            uint _e10 = local_48;
            float3_ _e13 = _group_0_binding_0_cs[_e10];
            local_49 = _e13;
            float3_ _e15 = local_49;
            local_36 = _e15;
            float3_ _e17 = local_36;
            copied = _e17;
            float3_ _e19 = copied;
            float3_ _e20 = shift(_e19);
            int _e21 = i;
            local_1 = uint(_e21);
            uint _e24 = local_1;
            local_50 = _e24;
            uint _e26 = local_50;
            _group_0_binding_1_cs[_e26] = _e20;
        }
    }
    local_3 = uint(0);
    uint _e35 = local_3;
    float3_ _e38 = _group_0_binding_0_cs[_e35];
    local_51 = _e38;
    float3_ _e40 = local_51;
    local_37 = _e40;
    float3_ _e42 = local_37;
    local_2 = uint(3);
    uint _e46 = local_2;
    _group_0_binding_1_cs[_e46] = _e42;
    local_5 = uint(1);
    uint _e52 = local_5;
    float3_ _e54 = _group_0_binding_0_cs[_e52];
    local_52 = _e54;
    float3_ _e56 = local_52;
    local_38 = _e56;
    float3_ _e58 = local_38;
    float3_ _e59 = shift(_e58);
    local_4 = uint(3);
    uint _e64 = local_4;
    _group_0_binding_1_cs[_e64].y = _e59.x;
    index = 0;
    index = 1;
    local_7 = uint(2);
    uint _e73 = local_7;
    float _e76 = _group_0_binding_0_cs[_e73].x;
    int _e77 = index;
    index = (_e77 + 1);
    local_6 = uint(_e77);
    uint _e82 = local_6;
    _group_0_binding_1_cs[_e82].x = _e76;
    int _e85 = index;
    local_9 = uint(0);
    uint _e89 = local_9;
    float _e92 = _group_0_binding_0_cs[_e89].x;
    local_10 = uint(1);
    uint _e96 = local_10;
    float _e99 = _group_0_binding_0_cs[_e96].x;
    local_8 = uint(4);
    uint _e105 = local_8;
    _group_0_binding_1_cs[_e105] = float3_(float(_e85), _e92, _e99);
    choose_first = true;
    bool _e109 = choose_first;
    if (_e109) {
        local_11 = uint(0);
        uint _e113 = local_11;
        local_53 = _e113;
        uint _e115 = local_53;
        float _e118 = _group_0_binding_1_cs[_e115].y;
        local_54 = _e118;
        float _e120 = local_54;
        local_39 = _e120;
        float _e122 = local_39;
        uint _e125 = local_53;
        _group_0_binding_1_cs[_e125].y = (_e122 + 2.0);
    } else {
        local_12 = uint(2);
        uint _e131 = local_12;
        local_55 = _e131;
        uint _e133 = local_55;
        float _e136 = _group_0_binding_1_cs[_e133].y;
        local_56 = _e136;
        float _e138 = local_56;
        local_40 = _e138;
        float _e140 = local_40;
        uint _e143 = local_55;
        _group_0_binding_1_cs[_e143].y = (_e140 + 2.0);
    }
    bool _e146 = choose_first;
    if (_e146) {
        local_14 = uint(0);
        uint _e150 = local_14;
        local_57 = _e150;
        uint _e152 = local_57;
        float _e155 = _group_0_binding_1_cs[_e152].z;
        local_58 = _e155;
        float _e157 = local_58;
        local_41 = _e157;
        float _e159 = local_41;
        uint _e163 = local_57;
        _group_0_binding_1_cs[_e163].z = (_e159 + float(1));
        local_16 = _e159;
    } else {
        local_15 = uint(2);
        uint _e170 = local_15;
        local_59 = _e170;
        uint _e172 = local_59;
        float _e175 = _group_0_binding_1_cs[_e172].z;
        local_60 = _e175;
        float _e177 = local_60;
        local_42 = _e177;
        float _e179 = local_42;
        uint _e183 = local_59;
        _group_0_binding_1_cs[_e183].z = (_e179 + float(1));
        local_16 = _e179;
    }
    float _e188 = local_16;
    local_13 = uint(4);
    uint _e192 = local_13;
    _group_0_binding_1_cs[_e192].x = _e188;
    int _e195 = index;
    local_17 = uint(4);
    uint _e200 = local_17;
    _group_0_binding_1_cs[_e200].z = float(_e195);
    local_20 = uint(1);
    uint _e206 = local_20;
    float3_ _e208 = _group_0_binding_0_cs[_e206];
    local_61 = _e208;
    float3_ _e210 = local_61;
    local_43 = _e210;
    float3_ _e212 = local_43;
    bool _e213 = choose_first;
    if (_e213) {
        local_18 = uint(0);
        uint _e217 = local_18;
        local_62 = _e217;
        uint _e219 = local_62;
        _group_0_binding_1_cs[_e219] = _e212;
        uint _e221 = local_18;
        local_63 = _e221;
        uint _e223 = local_63;
        float _e226 = _group_0_binding_1_cs[_e223].x;
        local_64 = _e226;
        float _e228 = local_64;
        local_44 = _e228;
        float _e230 = local_44;
        uint _e234 = local_63;
        _group_0_binding_1_cs[_e234].x = (_e230 + float(1));
        local_21 = _e230;
    } else {
        local_19 = uint(2);
        uint _e241 = local_19;
        local_65 = _e241;
        uint _e243 = local_65;
        _group_0_binding_1_cs[_e243] = _e212;
        uint _e245 = local_19;
        local_66 = _e245;
        uint _e247 = local_66;
        float _e250 = _group_0_binding_1_cs[_e247].x;
        local_67 = _e250;
        float _e252 = local_67;
        local_45 = _e252;
        float _e254 = local_45;
        uint _e258 = local_66;
        _group_0_binding_1_cs[_e258].x = (_e254 + float(1));
        local_21 = _e254;
    }
    local_23 = uint(0);
    uint _e265 = local_23;
    float3_ _e267 = _group_0_binding_1_cs[_e265];
    local_68 = _e267;
    float3_ _e269 = local_68;
    local_46 = _e269;
    float3_ _e271 = local_46;
    local_22 = uint(5);
    uint _e275 = local_22;
    _group_0_binding_1_cs[_e275] = _e271;
    local_24 = float3_(float(20), float(30), float(40));
    pick_local = false;
    pick_local = true;
    bool _e288 = pick_local;
    if (_e288) {
        local_24.z = 7.0;
    } else {
        local_25 = uint(1);
        uint _e294 = local_25;
        local_69 = _e294;
        uint _e296 = local_69;
        _group_0_binding_1_cs[_e296].z = 7.0;
    }
    float3_ _e300 = local_24;
    local_26 = uint(6);
    uint _e304 = local_26;
    _group_0_binding_1_cs[_e304] = _e300;
    local_28 = uint(1);
    uint _e309 = local_28;
    float _e312 = _group_0_binding_1_cs[_e309].z;
    local_27 = uint(6);
    uint _e316 = local_27;
    _group_0_binding_1_cs[_e316].x = _e312;
    local_30 = uint(0);
    uint _e322 = local_30;
    float _e325 = _group_0_binding_1_cs[_e322].x;
    local_31 = uint(1);
    uint _e329 = local_31;
    float _e332 = _group_0_binding_1_cs[_e329].x;
    local_32 = uint(2);
    uint _e336 = local_32;
    float _e339 = _group_0_binding_1_cs[_e336].x;
    local_29 = uint(7);
    uint _e344 = local_29;
    _group_0_binding_1_cs[_e344] = float3_(_e325, _e332, _e339);
    local_33 = uint(0);
    uint _e349 = local_33;
    float3_ _e351 = _group_0_binding_0_cs[_e349];
    local_70 = _e351;
    float3_ _e353 = local_70;
    local_47 = _e353;
    float3_ _e355 = local_47;
    snapshot = _e355;
    float3_ _e357 = snapshot;
    snapshot.x = 9.0;
    float _e361 = pair(_e357, 4);
    float _e363 = snapshot.x;
    local_35 = uint(2);
    uint _e367 = local_35;
    float _e370 = _group_0_binding_0_cs[_e367].z;
    local_34 = uint(8);
    uint _e375 = local_34;
    _group_0_binding_1_cs[_e375] = float3_(_e361, _e363, _e370);
}

