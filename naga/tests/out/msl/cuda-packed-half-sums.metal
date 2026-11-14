// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_1[1];

struct packed_half_sumsInput {
};
kernel void packed_half_sums(
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
    uint local_2 = {};
    uint local_3 = {};
    uint value = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    bool local_13 = {};
    bool local_14 = {};
    uint local_15 = {};
    uint index = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint scale = {};
    uint bias = {};
    uint scale_1 = {};
    uint bias_1 = {};
    uint scale_2 = {};
    uint bias_2 = {};
    uint scale_3 = {};
    uint bias_3 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
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
                uint _e125 = row;
                row = _e125 + 64u;
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
            local_25 = _e17;
            uint _e19 = local_25;
            uint _e21 = input[_e19];
            local_26 = _e21;
            uint _e23 = local_26;
            local_23 = _e23;
            uint _e25 = local_23;
            a = _e25;
            uint _e27 = row;
            local_1 = static_cast<uint>(2u + (_e27 * 2u));
            uint _e34 = local_1;
            local_27 = _e34;
            uint _e36 = local_27;
            uint _e38 = input[_e36];
            local_28 = _e38;
            uint _e40 = local_28;
            local_24 = _e40;
            uint _e42 = local_24;
            b = _e42;
            uint _e44 = a;
            uint _e45 = b;
            uint _e63 = row;
            local_2 = static_cast<uint>(4u + (_e63 * 2u));
            uint _e70 = local_2;
            local_29 = _e70;
            uint _e72 = local_29;
            output[_e72] = ((((_e44 & 65535u) + (_e45 & 65535u)) >> 1u) & 65535u) | ((((((_e44 >> 16u) & 65535u) + ((_e45 >> 16u) & 65535u)) >> 1u) & 65535u) << 16u);
            uint _e75 = a;
            uint _e76 = b;
            uint _e114 = row;
            local_3 = static_cast<uint>(5u + (_e114 * 2u));
            uint _e121 = local_3;
            local_30 = _e121;
            uint _e123 = local_30;
            output[_e123] = ((((((_e75 & 255u) + (_e76 & 255u)) >> 1u) & 255u) | ((((((_e75 >> 8u) & 255u) + ((_e76 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e75 >> 16u) & 255u) + ((_e76 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e75 >> 24u) & 255u) + ((_e76 >> 24u) & 255u)) >> 1u) & 255u) << 24u);
        }
    }
    uint base = (4u + (count * 2u)) + (lane * 13u);
    value = 1u;
    scale = uint {};
    bias = uint {};
    scale = 16909060u;
    bias = 2164195711u;
    uint _e145 = value;
    value = _e145 + static_cast<uint>(1);
    uint _e149 = scale;
    uint _e151 = bias;
    local_4 = (_e145 * _e149) ^ _e151;
    uint _e154 = local_4;
    scale_1 = uint {};
    bias_1 = uint {};
    scale_1 = 50661129u;
    bias_1 = 4261576960u;
    uint _e163 = value;
    value = _e163 + static_cast<uint>(1);
    uint _e167 = scale_1;
    uint _e169 = bias_1;
    local_5 = (_e163 * _e167) ^ _e169;
    uint _e172 = local_5;
    output[base] = ((((_e154 & 65535u) + (_e172 & 65535u)) >> 1u) & 65535u) | ((((((_e154 >> 16u) & 65535u) + ((_e172 >> 16u) & 65535u)) >> 1u) & 65535u) << 16u);
    scale_2 = uint {};
    bias_2 = uint {};
    scale_2 = 16909060u;
    bias_2 = 2164195711u;
    uint _e200 = value;
    value = _e200 + static_cast<uint>(1);
    uint _e204 = scale_2;
    uint _e206 = bias_2;
    local_7 = (_e200 * _e204) ^ _e206;
    uint _e209 = local_7;
    scale_3 = uint {};
    bias_3 = uint {};
    scale_3 = 50661129u;
    bias_3 = 4261576960u;
    uint _e218 = value;
    value = _e218 + static_cast<uint>(1);
    uint _e222 = scale_3;
    uint _e224 = bias_3;
    local_8 = (_e218 * _e222) ^ _e224;
    uint _e227 = local_8;
    local_6 = static_cast<uint>(base + 1u);
    uint _e269 = local_6;
    output[_e269] = ((((((_e209 & 255u) + (_e227 & 255u)) >> 1u) & 255u) | ((((((_e209 >> 8u) & 255u) + ((_e227 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e209 >> 16u) & 255u) + ((_e227 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e209 >> 24u) & 255u) + ((_e227 >> 24u) & 255u)) >> 1u) & 255u) << 24u);
    uint _e271 = value;
    value = _e271 + static_cast<uint>(1);
    uint _e292 = ((((_e271 & 65535u) + (1u & 65535u)) >> 1u) & 65535u) | ((((((_e271 >> 16u) & 65535u) + ((1u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u);
    local_9 = static_cast<uint>(base + 2u);
    uint _e315 = local_9;
    output[_e315] = ((((_e292 & 65535u) + (1u & 65535u)) >> 1u) & 65535u) | ((((((_e292 >> 16u) & 65535u) + ((1u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u);
    uint _e317 = value;
    local_10 = static_cast<uint>(base + 3u);
    uint _e322 = local_10;
    output[_e322] = _e317;
    if ((lane & 1u) == 0u) {
        uint _e328 = value;
        value = _e328 + static_cast<uint>(1);
        uint _e332 = value;
        value = _e332 + static_cast<uint>(1);
        local_11 = ((((((_e328 & 255u) + (_e332 & 255u)) >> 1u) & 255u) | ((((((_e328 >> 8u) & 255u) + ((_e332 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e328 >> 16u) & 255u) + ((_e332 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e328 >> 24u) & 255u) + ((_e332 >> 24u) & 255u)) >> 1u) & 255u) << 24u);
    } else {
        local_11 = 0u;
    }
    uint _e376 = value;
    local_12 = static_cast<uint>(base + 4u);
    uint _e381 = local_12;
    output[_e381] = _e376;
    local_13 = false;
    if (false) {
        uint _e385 = value;
        value = _e385 + static_cast<uint>(1);
        uint _e389 = value;
        value = _e389 + static_cast<uint>(1);
        local_13 = (((((_e385 & 65535u) + (_e389 & 65535u)) >> 1u) & 65535u) | ((((((_e385 >> 16u) & 65535u) + ((_e389 >> 16u) & 65535u)) >> 1u) & 65535u) << 16u)) != 0u;
    }
    local_14 = true;
    if (true) {
    } else {
        uint _e414 = value;
        value = _e414 + static_cast<uint>(1);
        uint _e418 = value;
        value = _e418 + static_cast<uint>(1);
        local_14 = (((((((_e414 & 255u) + (_e418 & 255u)) >> 1u) & 255u) | ((((((_e414 >> 8u) & 255u) + ((_e418 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e414 >> 16u) & 255u) + ((_e418 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e414 >> 24u) & 255u) + ((_e418 >> 24u) & 255u)) >> 1u) & 255u) << 24u)) != 0u;
    }
    uint _e461 = value;
    value = _e461 + static_cast<uint>(1);
    uint _e465 = value;
    value = _e465 + static_cast<uint>(1);
    uint _e469 = value;
    local_15 = static_cast<uint>(base + 5u);
    uint _e474 = local_15;
    output[_e474] = _e469;
    index = 1u;
    uint _e478 = index;
    index = _e478 + static_cast<uint>(1);
    uint _e483 = input[_e478];
    uint _e484 = index;
    index = _e484 + static_cast<uint>(1);
    uint _e489 = input[_e484];
    local_16 = static_cast<uint>(base + 6u);
    uint _e531 = local_16;
    output[_e531] = ((((((_e483 & 255u) + (_e489 & 255u)) >> 1u) & 255u) | ((((((_e483 >> 8u) & 255u) + ((_e489 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e483 >> 16u) & 255u) + ((_e489 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e483 >> 24u) & 255u) + ((_e489 >> 24u) & 255u)) >> 1u) & 255u) << 24u);
    uint _e533 = index;
    local_17 = static_cast<uint>(base + 7u);
    uint _e538 = local_17;
    output[_e538] = _e533;
    local_18 = static_cast<uint>(base + 8u);
    uint _e563 = local_18;
    output[_e563] = ((((4294967295u & 65535u) + (4294967295u & 65535u)) >> 1u) & 65535u) | ((((((4294967295u >> 16u) & 65535u) + ((4294967295u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u);
    local_19 = static_cast<uint>(base + 9u);
    uint _e608 = local_19;
    output[_e608] = ((((((4294967295u & 255u) + (0u & 255u)) >> 1u) & 255u) | ((((((4294967295u >> 8u) & 255u) + ((0u >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((4294967295u >> 16u) & 255u) + ((0u >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((4294967295u >> 24u) & 255u) + ((0u >> 24u) & 255u)) >> 1u) & 255u) << 24u);
    local_20 = static_cast<uint>(base + 10u);
    uint _e633 = local_20;
    output[_e633] = ((((4294967295u & 65535u) + (0u & 65535u)) >> 1u) & 65535u) | ((((((4294967295u >> 16u) & 65535u) + ((0u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u);
    local_21 = static_cast<uint>(base + 11u);
    uint _e678 = local_21;
    output[_e678] = ((((((0u & 255u) + (16843009u & 255u)) >> 1u) & 255u) | ((((((0u >> 8u) & 255u) + ((16843009u >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((0u >> 16u) & 255u) + ((16843009u >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((0u >> 24u) & 255u) + ((16843009u >> 24u) & 255u)) >> 1u) & 255u) << 24u);
    local_22 = static_cast<uint>(base + 12u);
    uint _e703 = local_22;
    output[_e703] = ((((4294901761u & 65535u) + (131071u & 65535u)) >> 1u) & 65535u) | ((((((4294901761u >> 16u) & 65535u) + ((131071u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u);
}
