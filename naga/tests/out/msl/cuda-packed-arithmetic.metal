// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_1[1];

struct packed_arithmeticInput {
};
kernel void packed_arithmetic(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& output [[buffer(0)]]
, device type_1 const& input [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint row = {};
    uint a = {};
    uint local = {};
    uint b = {};
    uint local_1 = {};
    uint base = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint value = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    bool local_19 = {};
    bool local_20 = {};
    uint local_21 = {};
    uint index = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint scale = {};
    uint bias = {};
    uint scale_1 = {};
    uint bias_1 = {};
    uint scale_2 = {};
    uint bias_2 = {};
    uint scale_3 = {};
    uint bias_3 = {};
    uint scale_4 = {};
    uint bias_4 = {};
    uint scale_5 = {};
    uint bias_5 = {};
    uint scale_6 = {};
    uint bias_6 = {};
    uint scale_7 = {};
    uint bias_7 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint lane = threadIdx.x;
    uint count = input[static_cast<uint>(0)];
    {
        row = lane;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e192 = row;
                row = _e192 + 64u;
            }
            loop_init = false;
            uint _e8 = row;
            if (_e8 < count) {
            } else {
                break;
            }
            uint _e10 = row;
            local = static_cast<uint>(1u + (_e10 * 2u));
            uint _e17 = local;
            local_30 = _e17;
            uint _e19 = local_30;
            uint _e21 = input[_e19];
            local_31 = _e21;
            uint _e23 = local_31;
            local_28 = _e23;
            uint _e25 = local_28;
            a = _e25;
            uint _e27 = row;
            local_1 = static_cast<uint>(2u + (_e27 * 2u));
            uint _e34 = local_1;
            local_32 = _e34;
            uint _e36 = local_32;
            uint _e38 = input[_e36];
            local_33 = _e38;
            uint _e40 = local_33;
            local_29 = _e40;
            uint _e42 = local_29;
            b = _e42;
            uint _e44 = row;
            base = 4u + (_e44 * 4u);
            uint _e50 = a;
            uint _e51 = b;
            uint _e66 = base;
            local_2 = _e66;
            uint _e68 = local_2;
            local_34 = _e68;
            uint _e70 = local_34;
            output[_e70] = (((_e50 & 65535u) + (_e51 & 65535u)) & 65535u) | (((((_e50 >> 16u) & 65535u) + ((_e51 >> 16u) & 65535u)) & 65535u) << 16u);
            uint _e73 = a;
            uint _e74 = b;
            uint _e107 = base;
            local_3 = static_cast<uint>(_e107 + 1u);
            uint _e112 = local_3;
            local_35 = _e112;
            uint _e114 = local_35;
            output[_e114] = (((((_e73 & 255u) + (_e74 & 255u)) & 255u) | (((((_e73 >> 8u) & 255u) + ((_e74 >> 8u) & 255u)) & 255u) << 8u)) | (((((_e73 >> 16u) & 255u) + ((_e74 >> 16u) & 255u)) & 255u) << 16u)) | (((((_e73 >> 24u) & 255u) + ((_e74 >> 24u) & 255u)) & 255u) << 24u);
            uint _e116 = a;
            uint _e117 = b;
            uint _e135 = base;
            local_4 = static_cast<uint>(_e135 + 2u);
            uint _e140 = local_4;
            local_36 = _e140;
            uint _e142 = local_36;
            output[_e142] = ((((_e116 & 65535u) + 65536u) - (_e117 & 65535u)) & 65535u) | ((((((_e116 >> 16u) & 65535u) + 65536u) - ((_e117 >> 16u) & 65535u)) & 65535u) << 16u);
            uint _e144 = a;
            uint _e145 = b;
            uint _e183 = base;
            local_5 = static_cast<uint>(_e183 + 3u);
            uint _e188 = local_5;
            local_37 = _e188;
            uint _e190 = local_37;
            output[_e190] = ((((((_e144 & 255u) + 256u) - (_e145 & 255u)) & 255u) | ((((((_e144 >> 8u) & 255u) + 256u) - ((_e145 >> 8u) & 255u)) & 255u) << 8u)) | ((((((_e144 >> 16u) & 255u) + 256u) - ((_e145 >> 16u) & 255u)) & 255u) << 16u)) | ((((((_e144 >> 24u) & 255u) + 256u) - ((_e145 >> 24u) & 255u)) & 255u) << 24u);
        }
    }
    uint base_1 = (4u + (count * 4u)) + (lane * 12u);
    value = 1u;
    scale = uint {};
    bias = uint {};
    scale = 16909060u;
    bias = 2164195711u;
    uint _e212 = value;
    value = _e212 + static_cast<uint>(1);
    uint _e216 = scale;
    uint _e218 = bias;
    local_6 = (_e212 * _e216) ^ _e218;
    uint _e221 = local_6;
    scale_1 = uint {};
    bias_1 = uint {};
    scale_1 = 50661129u;
    bias_1 = 4261576960u;
    uint _e230 = value;
    value = _e230 + static_cast<uint>(1);
    uint _e234 = scale_1;
    uint _e236 = bias_1;
    local_7 = (_e230 * _e234) ^ _e236;
    uint _e239 = local_7;
    output[base_1] = (((_e221 & 65535u) + (_e239 & 65535u)) & 65535u) | (((((_e221 >> 16u) & 65535u) + ((_e239 >> 16u) & 65535u)) & 65535u) << 16u);
    scale_2 = uint {};
    bias_2 = uint {};
    scale_2 = 16909060u;
    bias_2 = 2164195711u;
    uint _e264 = value;
    value = _e264 + static_cast<uint>(1);
    uint _e268 = scale_2;
    uint _e270 = bias_2;
    local_9 = (_e264 * _e268) ^ _e270;
    uint _e273 = local_9;
    scale_3 = uint {};
    bias_3 = uint {};
    scale_3 = 50661129u;
    bias_3 = 4261576960u;
    uint _e282 = value;
    value = _e282 + static_cast<uint>(1);
    uint _e286 = scale_3;
    uint _e288 = bias_3;
    local_10 = (_e282 * _e286) ^ _e288;
    uint _e291 = local_10;
    local_8 = static_cast<uint>(base_1 + 1u);
    uint _e328 = local_8;
    output[_e328] = (((((_e273 & 255u) + (_e291 & 255u)) & 255u) | (((((_e273 >> 8u) & 255u) + ((_e291 >> 8u) & 255u)) & 255u) << 8u)) | (((((_e273 >> 16u) & 255u) + ((_e291 >> 16u) & 255u)) & 255u) << 16u)) | (((((_e273 >> 24u) & 255u) + ((_e291 >> 24u) & 255u)) & 255u) << 24u);
    scale_4 = uint {};
    bias_4 = uint {};
    scale_4 = 16909060u;
    bias_4 = 2164195711u;
    uint _e338 = value;
    value = _e338 + static_cast<uint>(1);
    uint _e342 = scale_4;
    uint _e344 = bias_4;
    local_12 = (_e338 * _e342) ^ _e344;
    uint _e347 = local_12;
    scale_5 = uint {};
    bias_5 = uint {};
    scale_5 = 50661129u;
    bias_5 = 4261576960u;
    uint _e356 = value;
    value = _e356 + static_cast<uint>(1);
    uint _e360 = scale_5;
    uint _e362 = bias_5;
    local_13 = (_e356 * _e360) ^ _e362;
    uint _e365 = local_13;
    local_11 = static_cast<uint>(base_1 + 2u);
    uint _e387 = local_11;
    output[_e387] = ((((_e347 & 65535u) + 65536u) - (_e365 & 65535u)) & 65535u) | ((((((_e347 >> 16u) & 65535u) + 65536u) - ((_e365 >> 16u) & 65535u)) & 65535u) << 16u);
    scale_6 = uint {};
    bias_6 = uint {};
    scale_6 = 16909060u;
    bias_6 = 2164195711u;
    uint _e397 = value;
    value = _e397 + static_cast<uint>(1);
    uint _e401 = scale_6;
    uint _e403 = bias_6;
    local_15 = (_e397 * _e401) ^ _e403;
    uint _e406 = local_15;
    scale_7 = uint {};
    bias_7 = uint {};
    scale_7 = 50661129u;
    bias_7 = 4261576960u;
    uint _e415 = value;
    value = _e415 + static_cast<uint>(1);
    uint _e419 = scale_7;
    uint _e421 = bias_7;
    local_16 = (_e415 * _e419) ^ _e421;
    uint _e424 = local_16;
    local_14 = static_cast<uint>(base_1 + 3u);
    uint _e466 = local_14;
    output[_e466] = ((((((_e406 & 255u) + 256u) - (_e424 & 255u)) & 255u) | ((((((_e406 >> 8u) & 255u) + 256u) - ((_e424 >> 8u) & 255u)) & 255u) << 8u)) | ((((((_e406 >> 16u) & 255u) + 256u) - ((_e424 >> 16u) & 255u)) & 255u) << 16u)) | ((((((_e406 >> 24u) & 255u) + 256u) - ((_e424 >> 24u) & 255u)) & 255u) << 24u);
    if ((lane & 1u) == 0u) {
        uint _e472 = value;
        value = _e472 + static_cast<uint>(1);
        uint _e476 = value;
        value = _e476 + static_cast<uint>(1);
        local_17 = (((_e472 & 65535u) + (_e476 & 65535u)) & 65535u) | (((((_e472 >> 16u) & 65535u) + ((_e476 >> 16u) & 65535u)) & 65535u) << 16u);
    } else {
        local_17 = 0u;
    }
    uint _e497 = value;
    local_18 = static_cast<uint>(base_1 + 4u);
    uint _e502 = local_18;
    output[_e502] = _e497;
    local_19 = false;
    if (false) {
        uint _e506 = value;
        value = _e506 + static_cast<uint>(1);
        uint _e510 = value;
        value = _e510 + static_cast<uint>(1);
        local_19 = (((((_e506 & 65535u) + 65536u) - (_e510 & 65535u)) & 65535u) | ((((((_e506 >> 16u) & 65535u) + 65536u) - ((_e510 >> 16u) & 65535u)) & 65535u) << 16u)) != 0u;
    }
    local_20 = true;
    if (true) {
    } else {
        uint _e535 = value;
        value = _e535 + static_cast<uint>(1);
        uint _e539 = value;
        value = _e539 + static_cast<uint>(1);
        local_20 = ((((((_e535 & 255u) + (_e539 & 255u)) & 255u) | (((((_e535 >> 8u) & 255u) + ((_e539 >> 8u) & 255u)) & 255u) << 8u)) | (((((_e535 >> 16u) & 255u) + ((_e539 >> 16u) & 255u)) & 255u) << 16u)) | (((((_e535 >> 24u) & 255u) + ((_e539 >> 24u) & 255u)) & 255u) << 24u)) != 0u;
    }
    uint _e577 = value;
    value = _e577 + static_cast<uint>(1);
    uint _e581 = value;
    value = _e581 + static_cast<uint>(1);
    uint _e585 = value;
    local_21 = static_cast<uint>(base_1 + 5u);
    uint _e590 = local_21;
    output[_e590] = _e585;
    index = 1u;
    uint _e594 = index;
    index = _e594 + static_cast<uint>(1);
    uint _e599 = input[_e594];
    uint _e600 = index;
    index = _e600 + static_cast<uint>(1);
    uint _e605 = input[_e600];
    local_22 = static_cast<uint>(base_1 + 6u);
    uint _e647 = local_22;
    output[_e647] = ((((((_e599 & 255u) + 256u) - (_e605 & 255u)) & 255u) | ((((((_e599 >> 8u) & 255u) + 256u) - ((_e605 >> 8u) & 255u)) & 255u) << 8u)) | ((((((_e599 >> 16u) & 255u) + 256u) - ((_e605 >> 16u) & 255u)) & 255u) << 16u)) | ((((((_e599 >> 24u) & 255u) + 256u) - ((_e605 >> 24u) & 255u)) & 255u) << 24u);
    uint _e649 = index;
    local_23 = static_cast<uint>(base_1 + 7u);
    uint _e654 = local_23;
    output[_e654] = _e649;
    local_24 = static_cast<uint>(base_1 + 8u);
    uint _e676 = local_24;
    output[_e676] = (((4294967295u & 65535u) + (65537u & 65535u)) & 65535u) | (((((4294967295u >> 16u) & 65535u) + ((65537u >> 16u) & 65535u)) & 65535u) << 16u);
    local_25 = static_cast<uint>(base_1 + 9u);
    uint _e716 = local_25;
    output[_e716] = (((((4294967295u & 255u) + (16843009u & 255u)) & 255u) | (((((4294967295u >> 8u) & 255u) + ((16843009u >> 8u) & 255u)) & 255u) << 8u)) | (((((4294967295u >> 16u) & 255u) + ((16843009u >> 16u) & 255u)) & 255u) << 16u)) | (((((4294967295u >> 24u) & 255u) + ((16843009u >> 24u) & 255u)) & 255u) << 24u);
    local_26 = static_cast<uint>(base_1 + 10u);
    uint _e741 = local_26;
    output[_e741] = ((((0u & 65535u) + 65536u) - (65537u & 65535u)) & 65535u) | ((((((0u >> 16u) & 65535u) + 65536u) - ((65537u >> 16u) & 65535u)) & 65535u) << 16u);
    local_27 = static_cast<uint>(base_1 + 11u);
    uint _e786 = local_27;
    output[_e786] = ((((((0u & 255u) + 256u) - (16843009u & 255u)) & 255u) | ((((((0u >> 8u) & 255u) + 256u) - ((16843009u >> 8u) & 255u)) & 255u) << 8u)) | ((((((0u >> 16u) & 255u) + 256u) - ((16843009u >> 16u) & 255u)) & 255u) << 16u)) | ((((((0u >> 24u) & 255u) + 256u) - ((16843009u >> 24u) & 255u)) & 255u) << 24u);
}
