// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_1[1];

struct packed_unsigned_saturatingInput {
};
kernel void packed_unsigned_saturating(
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
                uint _e196 = row;
                row = _e196 + 64u;
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
            uint _e68 = base;
            local_2 = _e68;
            uint _e70 = local_2;
            local_34 = _e70;
            uint _e72 = local_34;
            output[_e72] = (metal::min((_e50 & 65535u) + (_e51 & 65535u), 65535u) & 65535u) | ((metal::min(((_e50 >> 16u) & 65535u) + ((_e51 >> 16u) & 65535u), 65535u) & 65535u) << 16u);
            uint _e75 = a;
            uint _e76 = b;
            uint _e113 = base;
            local_3 = static_cast<uint>(_e113 + 1u);
            uint _e118 = local_3;
            local_35 = _e118;
            uint _e120 = local_35;
            output[_e120] = (((metal::min((_e75 & 255u) + (_e76 & 255u), 255u) & 255u) | ((metal::min(((_e75 >> 8u) & 255u) + ((_e76 >> 8u) & 255u), 255u) & 255u) << 8u)) | ((metal::min(((_e75 >> 16u) & 255u) + ((_e76 >> 16u) & 255u), 255u) & 255u) << 16u)) | ((metal::min(((_e75 >> 24u) & 255u) + ((_e76 >> 24u) & 255u), 255u) & 255u) << 24u);
            uint _e122 = a;
            uint _e123 = b;
            uint _e126 = _e123 & 65535u;
            uint _e134 = (_e123 >> 16u) & 65535u;
            uint _e140 = base;
            local_4 = static_cast<uint>(_e140 + 2u);
            uint _e145 = local_4;
            local_36 = _e145;
            uint _e147 = local_36;
            output[_e147] = ((metal::max(_e122 & 65535u, _e126) - _e126) & 65535u) | (((metal::max((_e122 >> 16u) & 65535u, _e134) - _e134) & 65535u) << 16u);
            uint _e149 = a;
            uint _e150 = b;
            uint _e153 = _e150 & 255u;
            uint _e161 = (_e150 >> 8u) & 255u;
            uint _e171 = (_e150 >> 16u) & 255u;
            uint _e181 = (_e150 >> 24u) & 255u;
            uint _e187 = base;
            local_5 = static_cast<uint>(_e187 + 3u);
            uint _e192 = local_5;
            local_37 = _e192;
            uint _e194 = local_37;
            output[_e194] = ((((metal::max(_e149 & 255u, _e153) - _e153) & 255u) | (((metal::max((_e149 >> 8u) & 255u, _e161) - _e161) & 255u) << 8u)) | (((metal::max((_e149 >> 16u) & 255u, _e171) - _e171) & 255u) << 16u)) | (((metal::max((_e149 >> 24u) & 255u, _e181) - _e181) & 255u) << 24u);
        }
    }
    uint base_1 = (4u + (count * 4u)) + (lane * 12u);
    value = 1u;
    scale = uint {};
    bias = uint {};
    scale = 16909060u;
    bias = 2164195711u;
    uint _e216 = value;
    value = _e216 + static_cast<uint>(1);
    uint _e220 = scale;
    uint _e222 = bias;
    local_6 = (_e216 * _e220) ^ _e222;
    uint _e225 = local_6;
    scale_1 = uint {};
    bias_1 = uint {};
    scale_1 = 50661129u;
    bias_1 = 4261576960u;
    uint _e234 = value;
    value = _e234 + static_cast<uint>(1);
    uint _e238 = scale_1;
    uint _e240 = bias_1;
    local_7 = (_e234 * _e238) ^ _e240;
    uint _e243 = local_7;
    output[base_1] = (metal::min((_e225 & 65535u) + (_e243 & 65535u), 65535u) & 65535u) | ((metal::min(((_e225 >> 16u) & 65535u) + ((_e243 >> 16u) & 65535u), 65535u) & 65535u) << 16u);
    scale_2 = uint {};
    bias_2 = uint {};
    scale_2 = 16909060u;
    bias_2 = 2164195711u;
    uint _e270 = value;
    value = _e270 + static_cast<uint>(1);
    uint _e274 = scale_2;
    uint _e276 = bias_2;
    local_9 = (_e270 * _e274) ^ _e276;
    uint _e279 = local_9;
    scale_3 = uint {};
    bias_3 = uint {};
    scale_3 = 50661129u;
    bias_3 = 4261576960u;
    uint _e288 = value;
    value = _e288 + static_cast<uint>(1);
    uint _e292 = scale_3;
    uint _e294 = bias_3;
    local_10 = (_e288 * _e292) ^ _e294;
    uint _e297 = local_10;
    local_8 = static_cast<uint>(base_1 + 1u);
    uint _e338 = local_8;
    output[_e338] = (((metal::min((_e279 & 255u) + (_e297 & 255u), 255u) & 255u) | ((metal::min(((_e279 >> 8u) & 255u) + ((_e297 >> 8u) & 255u), 255u) & 255u) << 8u)) | ((metal::min(((_e279 >> 16u) & 255u) + ((_e297 >> 16u) & 255u), 255u) & 255u) << 16u)) | ((metal::min(((_e279 >> 24u) & 255u) + ((_e297 >> 24u) & 255u), 255u) & 255u) << 24u);
    scale_4 = uint {};
    bias_4 = uint {};
    scale_4 = 16909060u;
    bias_4 = 2164195711u;
    uint _e348 = value;
    value = _e348 + static_cast<uint>(1);
    uint _e352 = scale_4;
    uint _e354 = bias_4;
    local_12 = (_e348 * _e352) ^ _e354;
    uint _e357 = local_12;
    scale_5 = uint {};
    bias_5 = uint {};
    scale_5 = 50661129u;
    bias_5 = 4261576960u;
    uint _e366 = value;
    value = _e366 + static_cast<uint>(1);
    uint _e370 = scale_5;
    uint _e372 = bias_5;
    local_13 = (_e366 * _e370) ^ _e372;
    uint _e375 = local_13;
    uint _e378 = _e375 & 65535u;
    uint _e386 = (_e375 >> 16u) & 65535u;
    local_11 = static_cast<uint>(base_1 + 2u);
    uint _e396 = local_11;
    output[_e396] = ((metal::max(_e357 & 65535u, _e378) - _e378) & 65535u) | (((metal::max((_e357 >> 16u) & 65535u, _e386) - _e386) & 65535u) << 16u);
    scale_6 = uint {};
    bias_6 = uint {};
    scale_6 = 16909060u;
    bias_6 = 2164195711u;
    uint _e406 = value;
    value = _e406 + static_cast<uint>(1);
    uint _e410 = scale_6;
    uint _e412 = bias_6;
    local_15 = (_e406 * _e410) ^ _e412;
    uint _e415 = local_15;
    scale_7 = uint {};
    bias_7 = uint {};
    scale_7 = 50661129u;
    bias_7 = 4261576960u;
    uint _e424 = value;
    value = _e424 + static_cast<uint>(1);
    uint _e428 = scale_7;
    uint _e430 = bias_7;
    local_16 = (_e424 * _e428) ^ _e430;
    uint _e433 = local_16;
    uint _e436 = _e433 & 255u;
    uint _e444 = (_e433 >> 8u) & 255u;
    uint _e454 = (_e433 >> 16u) & 255u;
    uint _e464 = (_e433 >> 24u) & 255u;
    local_14 = static_cast<uint>(base_1 + 3u);
    uint _e474 = local_14;
    output[_e474] = ((((metal::max(_e415 & 255u, _e436) - _e436) & 255u) | (((metal::max((_e415 >> 8u) & 255u, _e444) - _e444) & 255u) << 8u)) | (((metal::max((_e415 >> 16u) & 255u, _e454) - _e454) & 255u) << 16u)) | (((metal::max((_e415 >> 24u) & 255u, _e464) - _e464) & 255u) << 24u);
    if ((lane & 1u) == 0u) {
        uint _e480 = value;
        value = _e480 + static_cast<uint>(1);
        uint _e484 = value;
        value = _e484 + static_cast<uint>(1);
        local_17 = (metal::min((_e480 & 65535u) + (_e484 & 65535u), 65535u) & 65535u) | ((metal::min(((_e480 >> 16u) & 65535u) + ((_e484 >> 16u) & 65535u), 65535u) & 65535u) << 16u);
    } else {
        local_17 = 0u;
    }
    uint _e507 = value;
    local_18 = static_cast<uint>(base_1 + 4u);
    uint _e512 = local_18;
    output[_e512] = _e507;
    local_19 = false;
    if (false) {
        uint _e516 = value;
        value = _e516 + static_cast<uint>(1);
        uint _e520 = value;
        value = _e520 + static_cast<uint>(1);
        uint _e526 = _e520 & 65535u;
        uint _e534 = (_e520 >> 16u) & 65535u;
        local_19 = (((metal::max(_e516 & 65535u, _e526) - _e526) & 65535u) | (((metal::max((_e516 >> 16u) & 65535u, _e534) - _e534) & 65535u) << 16u)) != 0u;
    }
    local_20 = true;
    if (true) {
    } else {
        uint _e544 = value;
        value = _e544 + static_cast<uint>(1);
        uint _e548 = value;
        value = _e548 + static_cast<uint>(1);
        local_20 = ((((metal::min((_e544 & 255u) + (_e548 & 255u), 255u) & 255u) | ((metal::min(((_e544 >> 8u) & 255u) + ((_e548 >> 8u) & 255u), 255u) & 255u) << 8u)) | ((metal::min(((_e544 >> 16u) & 255u) + ((_e548 >> 16u) & 255u), 255u) & 255u) << 16u)) | ((metal::min(((_e544 >> 24u) & 255u) + ((_e548 >> 24u) & 255u), 255u) & 255u) << 24u)) != 0u;
    }
    uint _e590 = value;
    value = _e590 + static_cast<uint>(1);
    uint _e594 = value;
    value = _e594 + static_cast<uint>(1);
    uint _e598 = value;
    local_21 = static_cast<uint>(base_1 + 5u);
    uint _e603 = local_21;
    output[_e603] = _e598;
    index = 1u;
    uint _e607 = index;
    index = _e607 + static_cast<uint>(1);
    uint _e612 = input[_e607];
    uint _e613 = index;
    index = _e613 + static_cast<uint>(1);
    uint _e618 = input[_e613];
    uint _e621 = _e618 & 255u;
    uint _e629 = (_e618 >> 8u) & 255u;
    uint _e639 = (_e618 >> 16u) & 255u;
    uint _e649 = (_e618 >> 24u) & 255u;
    local_22 = static_cast<uint>(base_1 + 6u);
    uint _e659 = local_22;
    output[_e659] = ((((metal::max(_e612 & 255u, _e621) - _e621) & 255u) | (((metal::max((_e612 >> 8u) & 255u, _e629) - _e629) & 255u) << 8u)) | (((metal::max((_e612 >> 16u) & 255u, _e639) - _e639) & 255u) << 16u)) | (((metal::max((_e612 >> 24u) & 255u, _e649) - _e649) & 255u) << 24u);
    uint _e661 = index;
    local_23 = static_cast<uint>(base_1 + 7u);
    uint _e666 = local_23;
    output[_e666] = _e661;
    local_24 = static_cast<uint>(base_1 + 8u);
    uint _e690 = local_24;
    output[_e690] = (metal::min((4294967295u & 65535u) + (65537u & 65535u), 65535u) & 65535u) | ((metal::min(((4294967295u >> 16u) & 65535u) + ((65537u >> 16u) & 65535u), 65535u) & 65535u) << 16u);
    local_25 = static_cast<uint>(base_1 + 9u);
    uint _e734 = local_25;
    output[_e734] = (((metal::min((4294967295u & 255u) + (16843009u & 255u), 255u) & 255u) | ((metal::min(((4294967295u >> 8u) & 255u) + ((16843009u >> 8u) & 255u), 255u) & 255u) << 8u)) | ((metal::min(((4294967295u >> 16u) & 255u) + ((16843009u >> 16u) & 255u), 255u) & 255u) << 16u)) | ((metal::min(((4294967295u >> 24u) & 255u) + ((16843009u >> 24u) & 255u), 255u) & 255u) << 24u);
    uint _e740 = 65537u & 65535u;
    uint _e748 = (65537u >> 16u) & 65535u;
    local_26 = static_cast<uint>(base_1 + 10u);
    uint _e758 = local_26;
    output[_e758] = ((metal::max(0u & 65535u, _e740) - _e740) & 65535u) | (((metal::max((0u >> 16u) & 65535u, _e748) - _e748) & 65535u) << 16u);
    uint _e764 = 16843009u & 255u;
    uint _e772 = (16843009u >> 8u) & 255u;
    uint _e782 = (16843009u >> 16u) & 255u;
    uint _e792 = (16843009u >> 24u) & 255u;
    local_27 = static_cast<uint>(base_1 + 11u);
    uint _e802 = local_27;
    output[_e802] = ((((metal::max(0u & 255u, _e764) - _e764) & 255u) | (((metal::max((0u >> 8u) & 255u, _e772) - _e772) & 255u) << 8u)) | (((metal::max((0u >> 16u) & 255u, _e782) - _e782) & 255u) << 16u)) | (((metal::max((0u >> 24u) & 255u, _e792) - _e792) & 255u) << 24u);
}
