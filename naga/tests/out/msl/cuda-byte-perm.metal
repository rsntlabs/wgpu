// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_1[1];
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


struct byte_permInput {
};
kernel void byte_perm(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& output [[buffer(0)]]
, device type_1 const& input [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint row = {};
    uint at = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint value = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    bool local_9 = {};
    bool local_10 = {};
    uint local_11 = {};
    uint index = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint scale = {};
    uint bias = {};
    uint scale_1 = {};
    uint bias_1 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
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
                uint _e119 = row;
                row = _e119 + 64u;
            }
            loop_init = false;
            uint _e8 = row;
            if (_e8 < count) {
            } else {
                break;
            }
            uint _e10 = row;
            at = 1u + (_e10 * 3u);
            uint _e16 = at;
            local_1 = _e16;
            uint _e18 = local_1;
            local_22 = _e18;
            uint _e20 = local_22;
            uint _e22 = input[_e20];
            local_23 = _e22;
            uint _e24 = local_23;
            local_19 = _e24;
            uint _e26 = local_19;
            uint _e27 = at;
            local_2 = static_cast<uint>(_e27 + 1u);
            uint _e32 = local_2;
            local_24 = _e32;
            uint _e34 = local_24;
            uint _e36 = input[_e34];
            local_25 = _e36;
            uint _e38 = local_25;
            local_20 = _e38;
            uint _e40 = local_20;
            uint _e41 = at;
            local_3 = static_cast<uint>(_e41 + 2u);
            uint _e46 = local_3;
            local_26 = _e46;
            uint _e48 = local_26;
            uint _e50 = input[_e48];
            local_27 = _e50;
            uint _e52 = local_27;
            local_21 = _e52;
            uint _e54 = local_21;
            uint _e58 = (_e54 >> 0u) & 7u;
            uint _e75 = (_e54 >> 4u) & 7u;
            uint _e87 = (_e54 >> 8u) & 7u;
            uint _e99 = (_e54 >> 12u) & 7u;
            uint _e109 = row;
            local = static_cast<uint>(4u + _e109);
            uint _e114 = local;
            local_28 = _e114;
            uint _e116 = local_28;
            output[_e116] = (((0u | (((((_e58 < 4u) ? _e26 : _e40) >> ((_e58 & 3u) * 8u)) & 255u) << 0u)) | (((((_e75 < 4u) ? _e26 : _e40) >> ((_e75 & 3u) * 8u)) & 255u) << 8u)) | (((((_e87 < 4u) ? _e26 : _e40) >> ((_e87 & 3u) * 8u)) & 255u) << 16u)) | (((((_e99 < 4u) ? _e26 : _e40) >> ((_e99 & 3u) * 8u)) & 255u) << 24u);
        }
    }
    uint base = (4u + count) + (lane * 10u);
    value = 1u;
    scale = uint {};
    bias = uint {};
    scale = 16909060u;
    bias = 2164195711u;
    uint _e137 = value;
    value = _e137 + static_cast<uint>(1);
    uint _e141 = scale;
    uint _e143 = bias;
    local_4 = (_e137 * _e141) ^ _e143;
    uint _e146 = local_4;
    scale_1 = uint {};
    bias_1 = uint {};
    scale_1 = 50661129u;
    bias_1 = 4261576960u;
    uint _e155 = value;
    value = _e155 + static_cast<uint>(1);
    uint _e159 = scale_1;
    uint _e161 = bias_1;
    local_5 = (_e155 * _e159) ^ _e161;
    uint _e164 = local_5;
    uint _e165 = value;
    value = _e165 + static_cast<uint>(1);
    local_6 = (_e165 * 258u) ^ 30006u;
    uint _e174 = local_6;
    uint _e178 = (_e174 >> 0u) & 7u;
    uint _e195 = (_e174 >> 4u) & 7u;
    uint _e207 = (_e174 >> 8u) & 7u;
    uint _e219 = (_e174 >> 12u) & 7u;
    output[base] = (((0u | (((((_e178 < 4u) ? _e146 : _e164) >> ((_e178 & 3u) * 8u)) & 255u) << 0u)) | (((((_e195 < 4u) ? _e146 : _e164) >> ((_e195 & 3u) * 8u)) & 255u) << 8u)) | (((((_e207 < 4u) ? _e146 : _e164) >> ((_e207 & 3u) * 8u)) & 255u) << 16u)) | (((((_e219 < 4u) ? _e146 : _e164) >> ((_e219 & 3u) * 8u)) & 255u) << 24u);
    if ((lane & 1u) == 0u) {
        uint _e235 = value;
        value = _e235 + static_cast<uint>(1);
        uint _e239 = value;
        value = _e239 + static_cast<uint>(1);
        uint _e243 = value;
        value = _e243 + static_cast<uint>(1);
        uint _e250 = (_e243 >> 0u) & 7u;
        uint _e267 = (_e243 >> 4u) & 7u;
        uint _e279 = (_e243 >> 8u) & 7u;
        uint _e291 = (_e243 >> 12u) & 7u;
        local_7 = (((0u | (((((_e250 < 4u) ? _e235 : _e239) >> ((_e250 & 3u) * 8u)) & 255u) << 0u)) | (((((_e267 < 4u) ? _e235 : _e239) >> ((_e267 & 3u) * 8u)) & 255u) << 8u)) | (((((_e279 < 4u) ? _e235 : _e239) >> ((_e279 & 3u) * 8u)) & 255u) << 16u)) | (((((_e291 < 4u) ? _e235 : _e239) >> ((_e291 & 3u) * 8u)) & 255u) << 24u);
    } else {
        local_7 = 0u;
    }
    uint _e304 = value;
    local_8 = static_cast<uint>(base + 1u);
    uint _e309 = local_8;
    output[_e309] = _e304;
    local_9 = false;
    if (false) {
        uint _e313 = value;
        value = _e313 + static_cast<uint>(1);
        uint _e317 = value;
        value = _e317 + static_cast<uint>(1);
        uint _e321 = value;
        value = _e321 + static_cast<uint>(1);
        uint _e328 = (_e321 >> 0u) & 7u;
        uint _e345 = (_e321 >> 4u) & 7u;
        uint _e357 = (_e321 >> 8u) & 7u;
        uint _e369 = (_e321 >> 12u) & 7u;
        local_9 = ((((0u | (((((_e328 < 4u) ? _e313 : _e317) >> ((_e328 & 3u) * 8u)) & 255u) << 0u)) | (((((_e345 < 4u) ? _e313 : _e317) >> ((_e345 & 3u) * 8u)) & 255u) << 8u)) | (((((_e357 < 4u) ? _e313 : _e317) >> ((_e357 & 3u) * 8u)) & 255u) << 16u)) | (((((_e369 < 4u) ? _e313 : _e317) >> ((_e369 & 3u) * 8u)) & 255u) << 24u)) != 0u;
    }
    local_10 = true;
    if (true) {
    } else {
        uint _e383 = value;
        value = _e383 + static_cast<uint>(1);
        uint _e387 = value;
        value = _e387 + static_cast<uint>(1);
        uint _e391 = value;
        value = _e391 + static_cast<uint>(1);
        uint _e398 = (_e391 >> 0u) & 7u;
        uint _e415 = (_e391 >> 4u) & 7u;
        uint _e427 = (_e391 >> 8u) & 7u;
        uint _e439 = (_e391 >> 12u) & 7u;
        local_10 = ((((0u | (((((_e398 < 4u) ? _e383 : _e387) >> ((_e398 & 3u) * 8u)) & 255u) << 0u)) | (((((_e415 < 4u) ? _e383 : _e387) >> ((_e415 & 3u) * 8u)) & 255u) << 8u)) | (((((_e427 < 4u) ? _e383 : _e387) >> ((_e427 & 3u) * 8u)) & 255u) << 16u)) | (((((_e439 < 4u) ? _e383 : _e387) >> ((_e439 & 3u) * 8u)) & 255u) << 24u)) != 0u;
    }
    uint _e451 = value;
    value = _e451 + static_cast<uint>(1);
    uint _e455 = value;
    value = _e455 + static_cast<uint>(1);
    uint _e459 = value;
    value = _e459 + static_cast<uint>(1);
    uint _e463 = value;
    local_11 = static_cast<uint>(base + 2u);
    uint _e468 = local_11;
    output[_e468] = _e463;
    index = 1u;
    uint _e472 = index;
    index = _e472 + static_cast<uint>(1);
    uint _e477 = input[_e472];
    uint _e478 = index;
    index = _e478 + static_cast<uint>(1);
    uint _e483 = input[_e478];
    uint _e484 = index;
    index = _e484 + static_cast<uint>(1);
    uint _e489 = input[_e484];
    uint _e493 = (_e489 >> 0u) & 7u;
    uint _e510 = (_e489 >> 4u) & 7u;
    uint _e522 = (_e489 >> 8u) & 7u;
    uint _e534 = (_e489 >> 12u) & 7u;
    local_12 = static_cast<uint>(base + 3u);
    uint _e548 = local_12;
    output[_e548] = (((0u | (((((_e493 < 4u) ? _e477 : _e483) >> ((_e493 & 3u) * 8u)) & 255u) << 0u)) | (((((_e510 < 4u) ? _e477 : _e483) >> ((_e510 & 3u) * 8u)) & 255u) << 8u)) | (((((_e522 < 4u) ? _e477 : _e483) >> ((_e522 & 3u) * 8u)) & 255u) << 16u)) | (((((_e534 < 4u) ? _e477 : _e483) >> ((_e534 & 3u) * 8u)) & 255u) << 24u);
    uint _e550 = index;
    local_13 = static_cast<uint>(base + 4u);
    uint _e555 = local_13;
    output[_e555] = _e550;
    uint _e561 = (65535u >> 0u) & 7u;
    uint _e580 = (65535u >> 4u) & 7u;
    uint _e592 = (65535u >> 8u) & 7u;
    uint _e604 = (65535u >> 12u) & 7u;
    local_14 = static_cast<uint>(base + 5u);
    uint _e618 = local_14;
    output[_e618] = (((0u | (((((_e561 < 4u) ? 2164195711u : 4261576960u) >> ((_e561 & 3u) * 8u)) & 255u) << 0u)) | (((((_e580 < 4u) ? 2164195711u : 4261576960u) >> ((_e580 & 3u) * 8u)) & 255u) << 8u)) | (((((_e592 < 4u) ? 2164195711u : 4261576960u) >> ((_e592 & 3u) * 8u)) & 255u) << 16u)) | (((((_e604 < 4u) ? 2164195711u : 4261576960u) >> ((_e604 & 3u) * 8u)) & 255u) << 24u);
    uint _e624 = (65535u >> 0u) & 7u;
    uint _e643 = (65535u >> 4u) & 7u;
    uint _e655 = (65535u >> 8u) & 7u;
    uint _e667 = (65535u >> 12u) & 7u;
    local_15 = static_cast<uint>(base + 6u);
    uint _e681 = local_15;
    output[_e681] = (((0u | (((((_e624 < 4u) ? 4294967295u : 0u) >> ((_e624 & 3u) * 8u)) & 255u) << 0u)) | (((((_e643 < 4u) ? 4294967295u : 0u) >> ((_e643 & 3u) * 8u)) & 255u) << 8u)) | (((((_e655 < 4u) ? 4294967295u : 0u) >> ((_e655 & 3u) * 8u)) & 255u) << 16u)) | (((((_e667 < 4u) ? 4294967295u : 0u) >> ((_e667 & 3u) * 8u)) & 255u) << 24u);
    uint _e687 = (4294932052u >> 0u) & 7u;
    uint _e706 = (4294932052u >> 4u) & 7u;
    uint _e718 = (4294932052u >> 8u) & 7u;
    uint _e730 = (4294932052u >> 12u) & 7u;
    local_16 = static_cast<uint>(base + 7u);
    uint _e744 = local_16;
    output[_e744] = (((0u | (((((_e687 < 4u) ? 2164195711u : 4261576960u) >> ((_e687 & 3u) * 8u)) & 255u) << 0u)) | (((((_e706 < 4u) ? 2164195711u : 4261576960u) >> ((_e706 & 3u) * 8u)) & 255u) << 8u)) | (((((_e718 < 4u) ? 2164195711u : 4261576960u) >> ((_e718 & 3u) * 8u)) & 255u) << 16u)) | (((((_e730 < 4u) ? 2164195711u : 4261576960u) >> ((_e730 & 3u) * 8u)) & 255u) << 24u);
    uint _e748 = static_cast<uint>(naga_neg(1));
    uint _e752 = (_e748 >> 0u) & 7u;
    uint _e771 = (_e748 >> 4u) & 7u;
    uint _e783 = (_e748 >> 8u) & 7u;
    uint _e795 = (_e748 >> 12u) & 7u;
    local_17 = static_cast<uint>(base + 8u);
    uint _e809 = local_17;
    output[_e809] = (((0u | (((((_e752 < 4u) ? 2164195711u : 4261576960u) >> ((_e752 & 3u) * 8u)) & 255u) << 0u)) | (((((_e771 < 4u) ? 2164195711u : 4261576960u) >> ((_e771 & 3u) * 8u)) & 255u) << 8u)) | (((((_e783 < 4u) ? 2164195711u : 4261576960u) >> ((_e783 & 3u) * 8u)) & 255u) << 16u)) | (((((_e795 < 4u) ? 2164195711u : 4261576960u) >> ((_e795 & 3u) * 8u)) & 255u) << 24u);
    uint _e813 = static_cast<uint>(naga_neg(1));
    uint _e818 = (12816u >> 0u) & 7u;
    uint _e836 = (12816u >> 4u) & 7u;
    uint _e848 = (12816u >> 8u) & 7u;
    uint _e860 = (12816u >> 12u) & 7u;
    local_18 = static_cast<uint>(base + 9u);
    uint _e874 = local_18;
    output[_e874] = (((0u | (((((_e818 < 4u) ? _e813 : 0u) >> ((_e818 & 3u) * 8u)) & 255u) << 0u)) | (((((_e836 < 4u) ? _e813 : 0u) >> ((_e836 & 3u) * 8u)) & 255u) << 8u)) | (((((_e848 < 4u) ? _e813 : 0u) >> ((_e848 & 3u) * 8u)) & 255u) << 16u)) | (((((_e860 < 4u) ? _e813 : 0u) >> ((_e860 & 3u) * 8u)) & 255u) << 24u);
}
