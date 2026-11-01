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
    int index = {};
    uint local_2 = {};
    bool choose_first = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    float local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    float local_10 = {};
    float3_ local_11 = {};
    bool pick_local = {};
    uint local_12 = {};
    float3_ snapshot = {};
    float3_ local_13 = {};
    float3_ local_14 = {};
    float3_ local_15 = {};
    float local_16 = {};
    float local_17 = {};
    float local_18 = {};
    float local_19 = {};
    float3_ local_20 = {};
    float local_21 = {};
    float local_22 = {};
    float3_ local_23 = {};
    float3_ local_24 = {};
    uint local_25 = {};
    float3_ local_26 = {};
    uint local_27 = {};
    float3_ local_28 = {};
    float3_ local_29 = {};
    uint local_30 = {};
    float local_31 = {};
    uint local_32 = {};
    float local_33 = {};
    uint local_34 = {};
    float local_35 = {};
    uint local_36 = {};
    float local_37 = {};
    float3_ local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    float local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    float local_44 = {};
    float3_ local_45 = {};
    uint local_46 = {};
    float3_ local_47 = {};
    {
        i = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e29 = i;
                i = as_type<int>(as_type<uint>(_e29) + as_type<uint>(1));
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
            local_25 = _e8;
            uint _e10 = local_25;
            float3_ _e13 = input[_e10];
            local_26 = _e13;
            float3_ _e15 = local_26;
            local_13 = _e15;
            float3_ _e17 = local_13;
            copied = _e17;
            float3_ _e19 = copied;
            float3_ _e20 = shift(_e19);
            int _e21 = i;
            local_1 = static_cast<uint>(_e21);
            uint _e24 = local_1;
            local_27 = _e24;
            uint _e26 = local_27;
            output[_e26] = _e20;
        }
    }
    float3_ _e36 = input[static_cast<uint>(0)];
    local_28 = _e36;
    float3_ _e38 = local_28;
    local_14 = _e38;
    float3_ _e40 = local_14;
    output[static_cast<uint>(3)] = _e40;
    float3_ _e48 = input[static_cast<uint>(1)];
    local_29 = _e48;
    float3_ _e50 = local_29;
    local_15 = _e50;
    float3_ _e52 = local_15;
    float3_ _e53 = shift(_e52);
    output[static_cast<uint>(3)].y = _e53.x;
    index = 0;
    index = 1;
    float _e66 = input[static_cast<uint>(2)].x;
    int _e67 = index;
    index = as_type<int>(as_type<uint>(_e67) + as_type<uint>(1));
    local_2 = static_cast<uint>(_e67);
    uint _e72 = local_2;
    output[_e72].x = _e66;
    int _e75 = index;
    float _e80 = input[static_cast<uint>(0)].x;
    float _e85 = input[static_cast<uint>(1)].x;
    output[static_cast<uint>(4)] = float3_ {static_cast<float>(_e75), _e80, _e85};
    choose_first = true;
    bool _e93 = choose_first;
    if (_e93) {
        local_3 = static_cast<uint>(0);
        uint _e97 = local_3;
        local_30 = _e97;
        uint _e99 = local_30;
        float _e102 = output[_e99].y;
        local_31 = _e102;
        float _e104 = local_31;
        local_16 = _e104;
        float _e106 = local_16;
        uint _e109 = local_30;
        output[_e109].y = _e106 + 2.0;
    } else {
        local_4 = static_cast<uint>(2);
        uint _e115 = local_4;
        local_32 = _e115;
        uint _e117 = local_32;
        float _e120 = output[_e117].y;
        local_33 = _e120;
        float _e122 = local_33;
        local_17 = _e122;
        float _e124 = local_17;
        uint _e127 = local_32;
        output[_e127].y = _e124 + 2.0;
    }
    bool _e130 = choose_first;
    if (_e130) {
        local_5 = static_cast<uint>(0);
        uint _e134 = local_5;
        local_34 = _e134;
        uint _e136 = local_34;
        float _e139 = output[_e136].z;
        local_35 = _e139;
        float _e141 = local_35;
        local_18 = _e141;
        float _e143 = local_18;
        uint _e147 = local_34;
        output[_e147].z = _e143 + static_cast<float>(1);
        local_7 = _e143;
    } else {
        local_6 = static_cast<uint>(2);
        uint _e154 = local_6;
        local_36 = _e154;
        uint _e156 = local_36;
        float _e159 = output[_e156].z;
        local_37 = _e159;
        float _e161 = local_37;
        local_19 = _e161;
        float _e163 = local_19;
        uint _e167 = local_36;
        output[_e167].z = _e163 + static_cast<float>(1);
        local_7 = _e163;
    }
    float _e172 = local_7;
    output[static_cast<uint>(4)].x = _e172;
    int _e177 = index;
    output[static_cast<uint>(4)].z = static_cast<float>(_e177);
    float3_ _e186 = input[static_cast<uint>(1)];
    local_38 = _e186;
    float3_ _e188 = local_38;
    local_20 = _e188;
    float3_ _e190 = local_20;
    bool _e191 = choose_first;
    if (_e191) {
        local_8 = static_cast<uint>(0);
        uint _e195 = local_8;
        local_39 = _e195;
        uint _e197 = local_39;
        output[_e197] = _e190;
        uint _e199 = local_8;
        local_40 = _e199;
        uint _e201 = local_40;
        float _e204 = output[_e201].x;
        local_41 = _e204;
        float _e206 = local_41;
        local_21 = _e206;
        float _e208 = local_21;
        uint _e212 = local_40;
        output[_e212].x = _e208 + static_cast<float>(1);
        local_10 = _e208;
    } else {
        local_9 = static_cast<uint>(2);
        uint _e219 = local_9;
        local_42 = _e219;
        uint _e221 = local_42;
        output[_e221] = _e190;
        uint _e223 = local_9;
        local_43 = _e223;
        uint _e225 = local_43;
        float _e228 = output[_e225].x;
        local_44 = _e228;
        float _e230 = local_44;
        local_22 = _e230;
        float _e232 = local_22;
        uint _e236 = local_43;
        output[_e236].x = _e232 + static_cast<float>(1);
        local_10 = _e232;
    }
    float3_ _e243 = output[static_cast<uint>(0)];
    local_45 = _e243;
    float3_ _e245 = local_45;
    local_23 = _e245;
    float3_ _e247 = local_23;
    output[static_cast<uint>(5)] = _e247;
    local_11 = float3_ {static_cast<float>(20), static_cast<float>(30), static_cast<float>(40)};
    pick_local = false;
    pick_local = true;
    bool _e262 = pick_local;
    if (_e262) {
        local_11.z = 7.0;
    } else {
        local_12 = static_cast<uint>(1);
        uint _e268 = local_12;
        local_46 = _e268;
        uint _e270 = local_46;
        output[_e270].z = 7.0;
    }
    float3_ _e274 = local_11;
    output[static_cast<uint>(6)] = _e274;
    float _e282 = output[static_cast<uint>(1)].z;
    output[static_cast<uint>(6)].x = _e282;
    float _e291 = output[static_cast<uint>(0)].x;
    float _e296 = output[static_cast<uint>(1)].x;
    float _e301 = output[static_cast<uint>(2)].x;
    output[static_cast<uint>(7)] = float3_ {_e291, _e296, _e301};
    float3_ _e309 = input[static_cast<uint>(0)];
    local_47 = _e309;
    float3_ _e311 = local_47;
    local_24 = _e311;
    float3_ _e313 = local_24;
    snapshot = _e313;
    float3_ _e315 = snapshot;
    snapshot.x = 9.0;
    float _e319 = pair(_e315, 4);
    float _e321 = snapshot.x;
    float _e326 = input[static_cast<uint>(2)].z;
    output[static_cast<uint>(8)] = float3_ {_e319, _e321, _e326};
}
