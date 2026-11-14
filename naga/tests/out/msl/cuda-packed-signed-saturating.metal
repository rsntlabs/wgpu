// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_1[1];

struct packed_signed_saturatingInput {
};
kernel void packed_signed_saturating(
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
                uint _e312 = row;
                row = _e312 + 64u;
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
            uint _e89 = base;
            local_2 = _e89;
            uint _e91 = local_2;
            local_34 = _e91;
            uint _e93 = local_34;
            output[_e93] = (static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e50 & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e51 & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e50 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e51 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) << 16u);
            uint _e96 = a;
            uint _e97 = b;
            uint _e171 = base;
            local_3 = static_cast<uint>(_e171 + 1u);
            uint _e176 = local_3;
            local_35 = _e176;
            uint _e178 = local_35;
            output[_e178] = (((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e96 & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e97 & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e96 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e97 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e96 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e97 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e96 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e97 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 24u);
            uint _e180 = a;
            uint _e181 = b;
            uint _e219 = base;
            local_4 = static_cast<uint>(_e219 + 2u);
            uint _e224 = local_4;
            local_36 = _e224;
            uint _e226 = local_36;
            output[_e226] = (static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e180 & 65535u) ^ 32768u)) - as_type<uint>(32768))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e181 & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e180 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e181 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) << 16u);
            uint _e228 = a;
            uint _e229 = b;
            uint _e303 = base;
            local_5 = static_cast<uint>(_e303 + 3u);
            uint _e308 = local_5;
            local_37 = _e308;
            uint _e310 = local_37;
            output[_e310] = (((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e228 & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e229 & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e228 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e229 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e228 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e229 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e228 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e229 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 24u);
        }
    }
    uint base_1 = (4u + (count * 4u)) + (lane * 12u);
    value = 1u;
    scale = uint {};
    bias = uint {};
    scale = 16909060u;
    bias = 2164195711u;
    uint _e332 = value;
    value = _e332 + static_cast<uint>(1);
    uint _e336 = scale;
    uint _e338 = bias;
    local_6 = (_e332 * _e336) ^ _e338;
    uint _e341 = local_6;
    scale_1 = uint {};
    bias_1 = uint {};
    scale_1 = 50661129u;
    bias_1 = 4261576960u;
    uint _e350 = value;
    value = _e350 + static_cast<uint>(1);
    uint _e354 = scale_1;
    uint _e356 = bias_1;
    local_7 = (_e350 * _e354) ^ _e356;
    uint _e359 = local_7;
    output[base_1] = (static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e341 & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e359 & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e341 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e359 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) << 16u);
    scale_2 = uint {};
    bias_2 = uint {};
    scale_2 = 16909060u;
    bias_2 = 2164195711u;
    uint _e407 = value;
    value = _e407 + static_cast<uint>(1);
    uint _e411 = scale_2;
    uint _e413 = bias_2;
    local_9 = (_e407 * _e411) ^ _e413;
    uint _e416 = local_9;
    scale_3 = uint {};
    bias_3 = uint {};
    scale_3 = 50661129u;
    bias_3 = 4261576960u;
    uint _e425 = value;
    value = _e425 + static_cast<uint>(1);
    uint _e429 = scale_3;
    uint _e431 = bias_3;
    local_10 = (_e425 * _e429) ^ _e431;
    uint _e434 = local_10;
    local_8 = static_cast<uint>(base_1 + 1u);
    uint _e512 = local_8;
    output[_e512] = (((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e416 & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e434 & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e416 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e434 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e416 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e434 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e416 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e434 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 24u);
    scale_4 = uint {};
    bias_4 = uint {};
    scale_4 = 16909060u;
    bias_4 = 2164195711u;
    uint _e522 = value;
    value = _e522 + static_cast<uint>(1);
    uint _e526 = scale_4;
    uint _e528 = bias_4;
    local_12 = (_e522 * _e526) ^ _e528;
    uint _e531 = local_12;
    scale_5 = uint {};
    bias_5 = uint {};
    scale_5 = 50661129u;
    bias_5 = 4261576960u;
    uint _e540 = value;
    value = _e540 + static_cast<uint>(1);
    uint _e544 = scale_5;
    uint _e546 = bias_5;
    local_13 = (_e540 * _e544) ^ _e546;
    uint _e549 = local_13;
    local_11 = static_cast<uint>(base_1 + 2u);
    uint _e591 = local_11;
    output[_e591] = (static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e531 & 65535u) ^ 32768u)) - as_type<uint>(32768))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e549 & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e531 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e549 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) << 16u);
    scale_6 = uint {};
    bias_6 = uint {};
    scale_6 = 16909060u;
    bias_6 = 2164195711u;
    uint _e601 = value;
    value = _e601 + static_cast<uint>(1);
    uint _e605 = scale_6;
    uint _e607 = bias_6;
    local_15 = (_e601 * _e605) ^ _e607;
    uint _e610 = local_15;
    scale_7 = uint {};
    bias_7 = uint {};
    scale_7 = 50661129u;
    bias_7 = 4261576960u;
    uint _e619 = value;
    value = _e619 + static_cast<uint>(1);
    uint _e623 = scale_7;
    uint _e625 = bias_7;
    local_16 = (_e619 * _e623) ^ _e625;
    uint _e628 = local_16;
    local_14 = static_cast<uint>(base_1 + 3u);
    uint _e706 = local_14;
    output[_e706] = (((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e610 & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e628 & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e610 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e628 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e610 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e628 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e610 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e628 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 24u);
    if ((lane & 1u) == 0u) {
        uint _e712 = value;
        value = _e712 + static_cast<uint>(1);
        uint _e716 = value;
        value = _e716 + static_cast<uint>(1);
        local_17 = (static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e712 & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e716 & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e712 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e716 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) << 16u);
    } else {
        local_17 = 0u;
    }
    uint _e760 = value;
    local_18 = static_cast<uint>(base_1 + 4u);
    uint _e765 = local_18;
    output[_e765] = _e760;
    local_19 = false;
    if (false) {
        uint _e769 = value;
        value = _e769 + static_cast<uint>(1);
        uint _e773 = value;
        value = _e773 + static_cast<uint>(1);
        local_19 = ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e769 & 65535u) ^ 32768u)) - as_type<uint>(32768))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e773 & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e769 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e773 >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) << 16u)) != 0u;
    }
    local_20 = true;
    if (true) {
    } else {
        uint _e818 = value;
        value = _e818 + static_cast<uint>(1);
        uint _e822 = value;
        value = _e822 + static_cast<uint>(1);
        local_20 = ((((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e818 & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e822 & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e818 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e822 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e818 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e822 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e818 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e822 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 24u)) != 0u;
    }
    uint _e901 = value;
    value = _e901 + static_cast<uint>(1);
    uint _e905 = value;
    value = _e905 + static_cast<uint>(1);
    uint _e909 = value;
    local_21 = static_cast<uint>(base_1 + 5u);
    uint _e914 = local_21;
    output[_e914] = _e909;
    index = 1u;
    uint _e918 = index;
    index = _e918 + static_cast<uint>(1);
    uint _e923 = input[_e918];
    uint _e924 = index;
    index = _e924 + static_cast<uint>(1);
    uint _e929 = input[_e924];
    local_22 = static_cast<uint>(base_1 + 6u);
    uint _e1007 = local_22;
    output[_e1007] = (((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e923 & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((_e929 & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e923 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e929 >> 8u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e923 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e929 >> 16u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e923 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((_e929 >> 24u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 24u);
    uint _e1009 = index;
    local_23 = static_cast<uint>(base_1 + 7u);
    uint _e1014 = local_23;
    output[_e1014] = _e1009;
    local_24 = static_cast<uint>(base_1 + 8u);
    uint _e1059 = local_24;
    output[_e1059] = (static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((2147450879u & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((65537u & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((2147450879u >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((65537u >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) << 16u);
    local_25 = static_cast<uint>(base_1 + 9u);
    uint _e1140 = local_25;
    output[_e1140] = (((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((2139062143u & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((16843009u & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((2139062143u >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((16843009u >> 8u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((2139062143u >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((16843009u >> 16u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((2139062143u >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) + as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((16843009u >> 24u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 24u);
    local_26 = static_cast<uint>(base_1 + 10u);
    uint _e1185 = local_26;
    output[_e1185] = (static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((2147516416u & 65535u) ^ 32768u)) - as_type<uint>(32768))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((65537u & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((2147516416u >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((65537u >> 16u) & 65535u) ^ 32768u)) - as_type<uint>(32768)))), -32768, 32767)) + as_type<uint>(65536))) & 65535u) << 16u);
    local_27 = static_cast<uint>(base_1 + 11u);
    uint _e1266 = local_27;
    output[_e1266] = (((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((2155905152u & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>((16843009u & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((2155905152u >> 8u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((16843009u >> 8u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 8u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((2155905152u >> 16u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((16843009u >> 16u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 16u)) | ((static_cast<uint>(as_type<int>(as_type<uint>(metal::clamp(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((2155905152u >> 24u) & 255u) ^ 128u)) - as_type<uint>(128))) - as_type<uint>(as_type<int>(as_type<uint>(static_cast<int>(((16843009u >> 24u) & 255u) ^ 128u)) - as_type<uint>(128)))), -128, 127)) + as_type<uint>(256))) & 255u) << 24u);
}
