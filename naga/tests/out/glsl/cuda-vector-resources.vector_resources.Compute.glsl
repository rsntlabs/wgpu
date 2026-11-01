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
    int index = 0;
    uint local_2 = 0u;
    bool choose_first = false;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    float local_7 = 0.0;
    uint local_8 = 0u;
    uint local_9 = 0u;
    float local_10 = 0.0;
    float3_ local_11 = float3_(0.0, 0.0, 0.0);
    bool pick_local = false;
    uint local_12 = 0u;
    float3_ snapshot = float3_(0.0, 0.0, 0.0);
    float3_ local_13 = float3_(0.0, 0.0, 0.0);
    float3_ local_14 = float3_(0.0, 0.0, 0.0);
    float3_ local_15 = float3_(0.0, 0.0, 0.0);
    float local_16 = 0.0;
    float local_17 = 0.0;
    float local_18 = 0.0;
    float local_19 = 0.0;
    float3_ local_20 = float3_(0.0, 0.0, 0.0);
    float local_21 = 0.0;
    float local_22 = 0.0;
    float3_ local_23 = float3_(0.0, 0.0, 0.0);
    float3_ local_24 = float3_(0.0, 0.0, 0.0);
    uint local_25 = 0u;
    float3_ local_26 = float3_(0.0, 0.0, 0.0);
    uint local_27 = 0u;
    float3_ local_28 = float3_(0.0, 0.0, 0.0);
    float3_ local_29 = float3_(0.0, 0.0, 0.0);
    uint local_30 = 0u;
    float local_31 = 0.0;
    uint local_32 = 0u;
    float local_33 = 0.0;
    uint local_34 = 0u;
    float local_35 = 0.0;
    uint local_36 = 0u;
    float local_37 = 0.0;
    float3_ local_38 = float3_(0.0, 0.0, 0.0);
    uint local_39 = 0u;
    uint local_40 = 0u;
    float local_41 = 0.0;
    uint local_42 = 0u;
    uint local_43 = 0u;
    float local_44 = 0.0;
    float3_ local_45 = float3_(0.0, 0.0, 0.0);
    uint local_46 = 0u;
    float3_ local_47 = float3_(0.0, 0.0, 0.0);
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
            local_25 = _e8;
            uint _e10 = local_25;
            float3_ _e13 = _group_0_binding_0_cs[_e10];
            local_26 = _e13;
            float3_ _e15 = local_26;
            local_13 = _e15;
            float3_ _e17 = local_13;
            copied = _e17;
            float3_ _e19 = copied;
            float3_ _e20 = shift(_e19);
            int _e21 = i;
            local_1 = uint(_e21);
            uint _e24 = local_1;
            local_27 = _e24;
            uint _e26 = local_27;
            _group_0_binding_1_cs[_e26] = _e20;
        }
    }
    float3_ _e36 = _group_0_binding_0_cs[uint(0)];
    local_28 = _e36;
    float3_ _e38 = local_28;
    local_14 = _e38;
    float3_ _e40 = local_14;
    _group_0_binding_1_cs[uint(3)] = _e40;
    float3_ _e48 = _group_0_binding_0_cs[uint(1)];
    local_29 = _e48;
    float3_ _e50 = local_29;
    local_15 = _e50;
    float3_ _e52 = local_15;
    float3_ _e53 = shift(_e52);
    _group_0_binding_1_cs[uint(3)].y = _e53.x;
    index = 0;
    index = 1;
    float _e66 = _group_0_binding_0_cs[uint(2)].x;
    int _e67 = index;
    index = (_e67 + 1);
    local_2 = uint(_e67);
    uint _e72 = local_2;
    _group_0_binding_1_cs[_e72].x = _e66;
    int _e75 = index;
    float _e80 = _group_0_binding_0_cs[uint(0)].x;
    float _e85 = _group_0_binding_0_cs[uint(1)].x;
    _group_0_binding_1_cs[uint(4)] = float3_(float(_e75), _e80, _e85);
    choose_first = true;
    bool _e93 = choose_first;
    if (_e93) {
        local_3 = uint(0);
        uint _e97 = local_3;
        local_30 = _e97;
        uint _e99 = local_30;
        float _e102 = _group_0_binding_1_cs[_e99].y;
        local_31 = _e102;
        float _e104 = local_31;
        local_16 = _e104;
        float _e106 = local_16;
        uint _e109 = local_30;
        _group_0_binding_1_cs[_e109].y = (_e106 + 2.0);
    } else {
        local_4 = uint(2);
        uint _e115 = local_4;
        local_32 = _e115;
        uint _e117 = local_32;
        float _e120 = _group_0_binding_1_cs[_e117].y;
        local_33 = _e120;
        float _e122 = local_33;
        local_17 = _e122;
        float _e124 = local_17;
        uint _e127 = local_32;
        _group_0_binding_1_cs[_e127].y = (_e124 + 2.0);
    }
    bool _e130 = choose_first;
    if (_e130) {
        local_5 = uint(0);
        uint _e134 = local_5;
        local_34 = _e134;
        uint _e136 = local_34;
        float _e139 = _group_0_binding_1_cs[_e136].z;
        local_35 = _e139;
        float _e141 = local_35;
        local_18 = _e141;
        float _e143 = local_18;
        uint _e147 = local_34;
        _group_0_binding_1_cs[_e147].z = (_e143 + float(1));
        local_7 = _e143;
    } else {
        local_6 = uint(2);
        uint _e154 = local_6;
        local_36 = _e154;
        uint _e156 = local_36;
        float _e159 = _group_0_binding_1_cs[_e156].z;
        local_37 = _e159;
        float _e161 = local_37;
        local_19 = _e161;
        float _e163 = local_19;
        uint _e167 = local_36;
        _group_0_binding_1_cs[_e167].z = (_e163 + float(1));
        local_7 = _e163;
    }
    float _e172 = local_7;
    _group_0_binding_1_cs[uint(4)].x = _e172;
    int _e177 = index;
    _group_0_binding_1_cs[uint(4)].z = float(_e177);
    float3_ _e186 = _group_0_binding_0_cs[uint(1)];
    local_38 = _e186;
    float3_ _e188 = local_38;
    local_20 = _e188;
    float3_ _e190 = local_20;
    bool _e191 = choose_first;
    if (_e191) {
        local_8 = uint(0);
        uint _e195 = local_8;
        local_39 = _e195;
        uint _e197 = local_39;
        _group_0_binding_1_cs[_e197] = _e190;
        uint _e199 = local_8;
        local_40 = _e199;
        uint _e201 = local_40;
        float _e204 = _group_0_binding_1_cs[_e201].x;
        local_41 = _e204;
        float _e206 = local_41;
        local_21 = _e206;
        float _e208 = local_21;
        uint _e212 = local_40;
        _group_0_binding_1_cs[_e212].x = (_e208 + float(1));
        local_10 = _e208;
    } else {
        local_9 = uint(2);
        uint _e219 = local_9;
        local_42 = _e219;
        uint _e221 = local_42;
        _group_0_binding_1_cs[_e221] = _e190;
        uint _e223 = local_9;
        local_43 = _e223;
        uint _e225 = local_43;
        float _e228 = _group_0_binding_1_cs[_e225].x;
        local_44 = _e228;
        float _e230 = local_44;
        local_22 = _e230;
        float _e232 = local_22;
        uint _e236 = local_43;
        _group_0_binding_1_cs[_e236].x = (_e232 + float(1));
        local_10 = _e232;
    }
    float3_ _e243 = _group_0_binding_1_cs[uint(0)];
    local_45 = _e243;
    float3_ _e245 = local_45;
    local_23 = _e245;
    float3_ _e247 = local_23;
    _group_0_binding_1_cs[uint(5)] = _e247;
    local_11 = float3_(float(20), float(30), float(40));
    pick_local = false;
    pick_local = true;
    bool _e262 = pick_local;
    if (_e262) {
        local_11.z = 7.0;
    } else {
        local_12 = uint(1);
        uint _e268 = local_12;
        local_46 = _e268;
        uint _e270 = local_46;
        _group_0_binding_1_cs[_e270].z = 7.0;
    }
    float3_ _e274 = local_11;
    _group_0_binding_1_cs[uint(6)] = _e274;
    float _e282 = _group_0_binding_1_cs[uint(1)].z;
    _group_0_binding_1_cs[uint(6)].x = _e282;
    float _e291 = _group_0_binding_1_cs[uint(0)].x;
    float _e296 = _group_0_binding_1_cs[uint(1)].x;
    float _e301 = _group_0_binding_1_cs[uint(2)].x;
    _group_0_binding_1_cs[uint(7)] = float3_(_e291, _e296, _e301);
    float3_ _e309 = _group_0_binding_0_cs[uint(0)];
    local_47 = _e309;
    float3_ _e311 = local_47;
    local_24 = _e311;
    float3_ _e313 = local_24;
    snapshot = _e313;
    float3_ _e315 = snapshot;
    snapshot.x = 9.0;
    float _e319 = pair(_e315, 4);
    float _e321 = snapshot.x;
    float _e326 = _group_0_binding_0_cs[uint(2)].z;
    _group_0_binding_1_cs[uint(8)] = float3_(_e319, _e321, _e326);
}

