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


struct sadInput {
};
kernel void sad(
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
    uint accumulator = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint value = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    bool local_14 = {};
    bool local_15 = {};
    uint local_16 = {};
    uint index = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint scale = {};
    uint scale_1 = {};
    uint scale_2 = {};
    uint scale_3 = {};
    uint scale_4 = {};
    uint scale_5 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
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
                uint _e131 = row;
                row = _e131 + 4u;
            }
            loop_init = false;
            uint _e8 = row;
            if (_e8 < count) {
            } else {
                break;
            }
            uint _e10 = row;
            local = static_cast<uint>(1u + (_e10 * 3u));
            uint _e17 = local;
            local_26 = _e17;
            uint _e19 = local_26;
            uint _e21 = input[_e19];
            local_27 = _e21;
            uint _e23 = local_27;
            local_23 = _e23;
            uint _e25 = local_23;
            a = _e25;
            uint _e27 = row;
            local_1 = static_cast<uint>(2u + (_e27 * 3u));
            uint _e34 = local_1;
            local_28 = _e34;
            uint _e36 = local_28;
            uint _e38 = input[_e36];
            local_29 = _e38;
            uint _e40 = local_29;
            local_24 = _e40;
            uint _e42 = local_24;
            b = _e42;
            uint _e44 = row;
            local_2 = static_cast<uint>(3u + (_e44 * 3u));
            uint _e51 = local_2;
            local_30 = _e51;
            uint _e53 = local_30;
            uint _e55 = input[_e53];
            local_31 = _e55;
            uint _e57 = local_31;
            local_25 = _e57;
            uint _e59 = local_25;
            accumulator = _e59;
            uint _e61 = a;
            uint _e63 = b;
            uint _e65 = accumulator;
            uint _e68 = as_type<uint>(static_cast<int>(_e61)) ^ 2147483648u;
            uint _e70 = as_type<uint>(static_cast<int>(_e63)) ^ 2147483648u;
            uint _e73 = metal::max(_e68, _e70) - metal::min(_e68, _e70);
            uint _e77 = (_e73 & 65535u) + (_e65 & 65535u);
            uint _e88 = row;
            local_3 = static_cast<uint>(4u + (_e88 * 2u));
            uint _e95 = local_3;
            local_32 = _e95;
            uint _e97 = local_32;
            output[_e97] = (((((_e73 >> 16u) + (_e65 >> 16u)) + (_e77 >> 16u)) & 65535u) << 16u) | (_e77 & 65535u);
            uint _e100 = a;
            uint _e101 = b;
            uint _e102 = accumulator;
            uint _e105 = metal::max(_e100, _e101) - metal::min(_e100, _e101);
            uint _e109 = (_e105 & 65535u) + (_e102 & 65535u);
            uint _e120 = row;
            local_4 = static_cast<uint>(5u + (_e120 * 2u));
            uint _e127 = local_4;
            local_33 = _e127;
            uint _e129 = local_33;
            output[_e129] = (((((_e105 >> 16u) + (_e102 >> 16u)) + (_e109 >> 16u)) & 65535u) << 16u) | (_e109 & 65535u);
        }
    }
    uint base = (4u + (count * 2u)) + (lane * 10u);
    value = 1u;
    scale = uint {};
    scale = 3u;
    uint _e147 = value;
    value = _e147 + static_cast<uint>(1);
    uint _e151 = scale;
    local_5 = _e147 * _e151;
    uint _e154 = local_5;
    scale_1 = uint {};
    scale_1 = 5u;
    uint _e160 = value;
    value = _e160 + static_cast<uint>(1);
    uint _e164 = scale_1;
    local_6 = _e160 * _e164;
    uint _e167 = local_6;
    scale_2 = uint {};
    scale_2 = 7u;
    uint _e173 = value;
    value = _e173 + static_cast<uint>(1);
    uint _e177 = scale_2;
    local_7 = _e173 * _e177;
    uint _e180 = local_7;
    uint _e183 = static_cast<uint>(naga_neg(static_cast<int>(_e180)));
    uint _e186 = as_type<uint>(static_cast<int>(_e154)) ^ 2147483648u;
    uint _e188 = as_type<uint>(static_cast<int>(_e167)) ^ 2147483648u;
    uint _e191 = metal::max(_e186, _e188) - metal::min(_e186, _e188);
    uint _e195 = (_e191 & 65535u) + (_e183 & 65535u);
    output[base] = (((((_e191 >> 16u) + (_e183 >> 16u)) + (_e195 >> 16u)) & 65535u) << 16u) | (_e195 & 65535u);
    scale_3 = uint {};
    scale_3 = 3u;
    uint _e212 = value;
    value = _e212 + static_cast<uint>(1);
    uint _e216 = scale_3;
    local_9 = _e212 * _e216;
    uint _e219 = local_9;
    scale_4 = uint {};
    scale_4 = 5u;
    uint _e224 = value;
    value = _e224 + static_cast<uint>(1);
    uint _e228 = scale_4;
    local_10 = _e224 * _e228;
    uint _e231 = local_10;
    scale_5 = uint {};
    scale_5 = 7u;
    uint _e236 = value;
    value = _e236 + static_cast<uint>(1);
    uint _e240 = scale_5;
    local_11 = _e236 * _e240;
    uint _e243 = local_11;
    uint _e246 = static_cast<uint>(naga_neg(static_cast<int>(_e243)));
    uint _e249 = metal::max(_e219, _e231) - metal::min(_e219, _e231);
    uint _e253 = (_e249 & 65535u) + (_e246 & 65535u);
    local_8 = static_cast<uint>(base + 1u);
    uint _e268 = local_8;
    output[_e268] = (((((_e249 >> 16u) + (_e246 >> 16u)) + (_e253 >> 16u)) & 65535u) << 16u) | (_e253 & 65535u);
    if ((lane & 1u) == 0u) {
        uint _e274 = value;
        value = _e274 + static_cast<uint>(1);
        uint _e279 = value;
        value = _e279 + static_cast<uint>(1);
        uint _e284 = value;
        value = _e284 + static_cast<uint>(1);
        uint _e290 = as_type<uint>(static_cast<int>(_e274)) ^ 2147483648u;
        uint _e292 = as_type<uint>(static_cast<int>(_e279)) ^ 2147483648u;
        uint _e295 = metal::max(_e290, _e292) - metal::min(_e290, _e292);
        uint _e299 = (_e295 & 65535u) + (_e284 & 65535u);
        local_12 = (((((_e295 >> 16u) + (_e284 >> 16u)) + (_e299 >> 16u)) & 65535u) << 16u) | (_e299 & 65535u);
    } else {
        local_12 = 0u;
    }
    uint _e313 = value;
    local_13 = static_cast<uint>(base + 2u);
    uint _e318 = local_13;
    output[_e318] = _e313;
    local_14 = false;
    if (false) {
        uint _e322 = value;
        value = _e322 + static_cast<uint>(1);
        uint _e327 = value;
        value = _e327 + static_cast<uint>(1);
        uint _e332 = value;
        value = _e332 + static_cast<uint>(1);
        uint _e338 = as_type<uint>(static_cast<int>(_e322)) ^ 2147483648u;
        uint _e340 = as_type<uint>(static_cast<int>(_e327)) ^ 2147483648u;
        uint _e343 = metal::max(_e338, _e340) - metal::min(_e338, _e340);
        uint _e347 = (_e343 & 65535u) + (_e332 & 65535u);
        local_14 = ((((((_e343 >> 16u) + (_e332 >> 16u)) + (_e347 >> 16u)) & 65535u) << 16u) | (_e347 & 65535u)) != 0u;
    }
    local_15 = true;
    if (true) {
    } else {
        uint _e362 = value;
        value = _e362 + static_cast<uint>(1);
        uint _e366 = value;
        value = _e366 + static_cast<uint>(1);
        uint _e370 = value;
        value = _e370 + static_cast<uint>(1);
        uint _e376 = metal::max(_e362, _e366) - metal::min(_e362, _e366);
        uint _e380 = (_e376 & 65535u) + (_e370 & 65535u);
        local_15 = ((((((_e376 >> 16u) + (_e370 >> 16u)) + (_e380 >> 16u)) & 65535u) << 16u) | (_e380 & 65535u)) != 0u;
    }
    uint _e393 = value;
    value = _e393 + static_cast<uint>(1);
    uint _e397 = value;
    value = _e397 + static_cast<uint>(1);
    uint _e401 = value;
    value = _e401 + static_cast<uint>(1);
    uint _e405 = value;
    local_16 = static_cast<uint>(base + 3u);
    uint _e410 = local_16;
    output[_e410] = _e405;
    index = 1u;
    uint _e414 = index;
    index = _e414 + static_cast<uint>(1);
    uint _e419 = input[_e414];
    uint _e420 = index;
    index = _e420 + static_cast<uint>(1);
    uint _e425 = input[_e420];
    uint _e426 = index;
    index = _e426 + static_cast<uint>(1);
    uint _e431 = input[_e426];
    uint _e434 = metal::max(_e419, _e425) - metal::min(_e419, _e425);
    uint _e438 = (_e434 & 65535u) + (_e431 & 65535u);
    local_17 = static_cast<uint>(base + 4u);
    uint _e453 = local_17;
    output[_e453] = (((((_e434 >> 16u) + (_e431 >> 16u)) + (_e438 >> 16u)) & 65535u) << 16u) | (_e438 & 65535u);
    uint _e455 = index;
    local_18 = static_cast<uint>(base + 5u);
    uint _e460 = local_18;
    output[_e460] = _e455;
    uint _e468 = as_type<uint>(as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1))) ^ 2147483648u;
    uint _e471 = as_type<uint>(2147483647) ^ 2147483648u;
    uint _e474 = metal::max(_e468, _e471) - metal::min(_e468, _e471);
    uint _e479 = (_e474 & 65535u) + (1u & 65535u);
    local_19 = static_cast<uint>(base + 6u);
    uint _e494 = local_19;
    output[_e494] = (((((_e474 >> 16u) + (1u >> 16u)) + (_e479 >> 16u)) & 65535u) << 16u) | (_e479 & 65535u);
    uint _e500 = as_type<uint>(naga_neg(1)) ^ 2147483648u;
    uint _e503 = as_type<uint>(0) ^ 2147483648u;
    uint _e506 = metal::max(_e500, _e503) - metal::min(_e500, _e503);
    uint _e511 = (_e506 & 65535u) + (4294967295u & 65535u);
    local_20 = static_cast<uint>(base + 7u);
    uint _e526 = local_20;
    output[_e526] = (((((_e506 >> 16u) + (4294967295u >> 16u)) + (_e511 >> 16u)) & 65535u) << 16u) | (_e511 & 65535u);
    uint _e532 = metal::max(0u, 4294967295u) - metal::min(0u, 4294967295u);
    uint _e537 = (_e532 & 65535u) + (4294967295u & 65535u);
    local_21 = static_cast<uint>(base + 8u);
    uint _e552 = local_21;
    output[_e552] = (((((_e532 >> 16u) + (4294967295u >> 16u)) + (_e537 >> 16u)) & 65535u) << 16u) | (_e537 & 65535u);
    uint _e560 = as_type<uint>(static_cast<int>(4294967295u)) ^ 2147483648u;
    uint _e562 = as_type<uint>(static_cast<int>(0u)) ^ 2147483648u;
    uint _e565 = metal::max(_e560, _e562) - metal::min(_e560, _e562);
    uint _e570 = (_e565 & 65535u) + (0u & 65535u);
    local_22 = static_cast<uint>(base + 9u);
    uint _e585 = local_22;
    output[_e585] = (((((_e565 >> 16u) + (0u >> 16u)) + (_e570 >> 16u)) & 65535u) << 16u) | (_e570 & 65535u);
}
