// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_1[1];

struct packed_negationInput {
};
kernel void packed_negation(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& output [[buffer(0)]]
, device type_1 const& input [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint row = {};
    uint value = {};
    uint local = {};
    uint base = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint value_1 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    bool local_15 = {};
    bool local_16 = {};
    uint local_17 = {};
    uint index = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
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
                uint _e161 = row;
                row = _e161 + 64u;
            }
            loop_init = false;
            uint _e8 = row;
            if (_e8 < count) {
            } else {
                break;
            }
            uint _e10 = row;
            local = static_cast<uint>(1u + _e10);
            uint _e15 = local;
            local_29 = _e15;
            uint _e17 = local_29;
            uint _e19 = input[_e17];
            local_30 = _e19;
            uint _e21 = local_30;
            local_28 = _e21;
            uint _e23 = local_28;
            value = _e23;
            uint _e25 = row;
            base = 4u + (_e25 * 4u);
            uint _e31 = value;
            uint _e44 = base;
            local_1 = _e44;
            uint _e46 = local_1;
            local_31 = _e46;
            uint _e48 = local_31;
            output[_e48] = ((65536u - (_e31 & 65535u)) & 65535u) | (((65536u - ((_e31 >> 16u) & 65535u)) & 65535u) << 16u);
            uint _e51 = value;
            uint _e78 = base;
            local_2 = static_cast<uint>(_e78 + 1u);
            uint _e83 = local_2;
            local_32 = _e83;
            uint _e85 = local_32;
            output[_e85] = ((((256u - (_e51 & 255u)) & 255u) | (((256u - ((_e51 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e51 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e51 >> 24u) & 255u)) & 255u) << 24u);
            uint _e87 = value;
            uint _e89 = _e87 & 65535u;
            uint _e99 = (_e87 >> 16u) & 65535u;
            uint _e106 = base;
            local_3 = static_cast<uint>(_e106 + 2u);
            uint _e111 = local_3;
            local_33 = _e111;
            uint _e113 = local_33;
            output[_e113] = ((_e89 == 32768u) ? 32767u : ((65536u - _e89) & 65535u)) | (((_e99 == 32768u) ? 32767u : ((65536u - _e99) & 65535u)) << 16u);
            uint _e115 = value;
            uint _e117 = _e115 & 255u;
            uint _e127 = (_e115 >> 8u) & 255u;
            uint _e136 = (_e115 >> 16u) & 255u;
            uint _e145 = (_e115 >> 24u) & 255u;
            uint _e152 = base;
            local_4 = static_cast<uint>(_e152 + 3u);
            uint _e157 = local_4;
            local_34 = _e157;
            uint _e159 = local_34;
            output[_e159] = ((((_e117 == 128u) ? 127u : ((256u - _e117) & 255u)) | (((_e127 == 128u) ? 127u : ((256u - _e127) & 255u)) << 8u)) | (((_e136 == 128u) ? 127u : ((256u - _e136) & 255u)) << 16u)) | (((_e145 == 128u) ? 127u : ((256u - _e145) & 255u)) << 24u);
        }
    }
    uint base_1 = (4u + (count * 4u)) + (lane * 17u);
    value_1 = 1u;
    uint _e173 = value_1;
    value_1 = _e173 + static_cast<uint>(1);
    local_5 = (_e173 * 16909060u) ^ 2164195711u;
    uint _e182 = local_5;
    output[base_1] = ((65536u - (_e182 & 65535u)) & 65535u) | (((65536u - ((_e182 >> 16u) & 65535u)) & 65535u) << 16u);
    uint _e197 = value_1;
    value_1 = _e197 + static_cast<uint>(1);
    local_7 = (_e197 * 16909060u) ^ 2164195711u;
    uint _e206 = local_7;
    local_6 = static_cast<uint>(base_1 + 1u);
    uint _e237 = local_6;
    output[_e237] = ((((256u - (_e206 & 255u)) & 255u) | (((256u - ((_e206 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e206 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e206 >> 24u) & 255u)) & 255u) << 24u);
    uint _e239 = value_1;
    value_1 = _e239 + static_cast<uint>(1);
    local_9 = (_e239 * 16909060u) ^ 2164195711u;
    uint _e248 = local_9;
    uint _e250 = _e248 & 65535u;
    uint _e260 = (_e248 >> 16u) & 65535u;
    local_8 = static_cast<uint>(base_1 + 2u);
    uint _e271 = local_8;
    output[_e271] = ((_e250 == 32768u) ? 32767u : ((65536u - _e250) & 65535u)) | (((_e260 == 32768u) ? 32767u : ((65536u - _e260) & 65535u)) << 16u);
    uint _e273 = value_1;
    value_1 = _e273 + static_cast<uint>(1);
    local_11 = (_e273 * 16909060u) ^ 2164195711u;
    uint _e282 = local_11;
    uint _e284 = _e282 & 255u;
    uint _e294 = (_e282 >> 8u) & 255u;
    uint _e303 = (_e282 >> 16u) & 255u;
    uint _e312 = (_e282 >> 24u) & 255u;
    local_10 = static_cast<uint>(base_1 + 3u);
    uint _e323 = local_10;
    output[_e323] = ((((_e284 == 128u) ? 127u : ((256u - _e284) & 255u)) | (((_e294 == 128u) ? 127u : ((256u - _e294) & 255u)) << 8u)) | (((_e303 == 128u) ? 127u : ((256u - _e303) & 255u)) << 16u)) | (((_e312 == 128u) ? 127u : ((256u - _e312) & 255u)) << 24u);
    uint _e325 = value_1;
    value_1 = _e325 + static_cast<uint>(1);
    uint _e354 = ((((256u - (_e325 & 255u)) & 255u) | (((256u - ((_e325 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e325 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e325 >> 24u) & 255u)) & 255u) << 24u);
    local_12 = static_cast<uint>(base_1 + 4u);
    uint _e385 = local_12;
    output[_e385] = ((((256u - (_e354 & 255u)) & 255u) | (((256u - ((_e354 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e354 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e354 >> 24u) & 255u)) & 255u) << 24u);
    if ((lane & 1u) == 0u) {
        uint _e391 = value_1;
        value_1 = _e391 + static_cast<uint>(1);
        uint _e396 = _e391 & 255u;
        uint _e406 = (_e391 >> 8u) & 255u;
        uint _e415 = (_e391 >> 16u) & 255u;
        uint _e424 = (_e391 >> 24u) & 255u;
        local_13 = ((((_e396 == 128u) ? 127u : ((256u - _e396) & 255u)) | (((_e406 == 128u) ? 127u : ((256u - _e406) & 255u)) << 8u)) | (((_e415 == 128u) ? 127u : ((256u - _e415) & 255u)) << 16u)) | (((_e424 == 128u) ? 127u : ((256u - _e424) & 255u)) << 24u);
    } else {
        local_13 = 0u;
    }
    uint _e434 = value_1;
    local_14 = static_cast<uint>(base_1 + 5u);
    uint _e439 = local_14;
    output[_e439] = _e434;
    local_15 = false;
    if (false) {
        uint _e443 = value_1;
        value_1 = _e443 + static_cast<uint>(1);
        local_15 = (((65536u - (_e443 & 65535u)) & 65535u) | (((65536u - ((_e443 >> 16u) & 65535u)) & 65535u) << 16u)) != 0u;
    }
    local_16 = true;
    if (true) {
    } else {
        uint _e463 = value_1;
        value_1 = _e463 + static_cast<uint>(1);
        local_16 = (((((256u - (_e463 & 255u)) & 255u) | (((256u - ((_e463 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e463 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e463 >> 24u) & 255u)) & 255u) << 24u)) != 0u;
    }
    uint _e495 = value_1;
    value_1 = _e495 + static_cast<uint>(1);
    uint _e499 = value_1;
    local_17 = static_cast<uint>(base_1 + 6u);
    uint _e504 = local_17;
    output[_e504] = _e499;
    index = 1u;
    uint _e508 = index;
    index = _e508 + static_cast<uint>(1);
    uint _e513 = input[_e508];
    uint _e515 = _e513 & 65535u;
    uint _e525 = (_e513 >> 16u) & 65535u;
    local_18 = static_cast<uint>(base_1 + 7u);
    uint _e536 = local_18;
    output[_e536] = ((_e515 == 32768u) ? 32767u : ((65536u - _e515) & 65535u)) | (((_e525 == 32768u) ? 32767u : ((65536u - _e525) & 65535u)) << 16u);
    uint _e538 = index;
    local_19 = static_cast<uint>(base_1 + 8u);
    uint _e543 = local_19;
    output[_e543] = _e538;
    local_20 = static_cast<uint>(base_1 + 9u);
    uint _e562 = local_20;
    output[_e562] = ((65536u - (2147516416u & 65535u)) & 65535u) | (((65536u - ((2147516416u >> 16u) & 65535u)) & 65535u) << 16u);
    uint _e566 = 2147516416u & 65535u;
    uint _e576 = (2147516416u >> 16u) & 65535u;
    local_21 = static_cast<uint>(base_1 + 10u);
    uint _e587 = local_21;
    output[_e587] = ((_e566 == 32768u) ? 32767u : ((65536u - _e566) & 65535u)) | (((_e576 == 32768u) ? 32767u : ((65536u - _e576) & 65535u)) << 16u);
    local_22 = static_cast<uint>(base_1 + 11u);
    uint _e620 = local_22;
    output[_e620] = ((((256u - (2155905152u & 255u)) & 255u) | (((256u - ((2155905152u >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((2155905152u >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((2155905152u >> 24u) & 255u)) & 255u) << 24u);
    uint _e624 = 2155905152u & 255u;
    uint _e634 = (2155905152u >> 8u) & 255u;
    uint _e643 = (2155905152u >> 16u) & 255u;
    uint _e652 = (2155905152u >> 24u) & 255u;
    local_23 = static_cast<uint>(base_1 + 12u);
    uint _e663 = local_23;
    output[_e663] = ((((_e624 == 128u) ? 127u : ((256u - _e624) & 255u)) | (((_e634 == 128u) ? 127u : ((256u - _e634) & 255u)) << 8u)) | (((_e643 == 128u) ? 127u : ((256u - _e643) & 255u)) << 16u)) | (((_e652 == 128u) ? 127u : ((256u - _e652) & 255u)) << 24u);
    uint _e677 = ((65536u - (2147516416u & 65535u)) & 65535u) | (((65536u - ((2147516416u >> 16u) & 65535u)) & 65535u) << 16u);
    local_24 = static_cast<uint>(base_1 + 13u);
    uint _e694 = local_24;
    output[_e694] = ((65536u - (_e677 & 65535u)) & 65535u) | (((65536u - ((_e677 >> 16u) & 65535u)) & 65535u) << 16u);
    uint _e722 = ((((256u - (2155905152u & 255u)) & 255u) | (((256u - ((2155905152u >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((2155905152u >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((2155905152u >> 24u) & 255u)) & 255u) << 24u);
    local_25 = static_cast<uint>(base_1 + 14u);
    uint _e753 = local_25;
    output[_e753] = ((((256u - (_e722 & 255u)) & 255u) | (((256u - ((_e722 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e722 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e722 >> 24u) & 255u)) & 255u) << 24u);
    uint _e757 = 2147516416u & 65535u;
    uint _e767 = (2147516416u >> 16u) & 65535u;
    uint _e773 = ((_e757 == 32768u) ? 32767u : ((65536u - _e757) & 65535u)) | (((_e767 == 32768u) ? 32767u : ((65536u - _e767) & 65535u)) << 16u);
    uint _e775 = _e773 & 65535u;
    uint _e785 = (_e773 >> 16u) & 65535u;
    local_26 = static_cast<uint>(base_1 + 15u);
    uint _e796 = local_26;
    output[_e796] = ((_e775 == 32768u) ? 32767u : ((65536u - _e775) & 65535u)) | (((_e785 == 32768u) ? 32767u : ((65536u - _e785) & 65535u)) << 16u);
    uint _e800 = 2155905152u & 255u;
    uint _e810 = (2155905152u >> 8u) & 255u;
    uint _e819 = (2155905152u >> 16u) & 255u;
    uint _e828 = (2155905152u >> 24u) & 255u;
    uint _e834 = ((((_e800 == 128u) ? 127u : ((256u - _e800) & 255u)) | (((_e810 == 128u) ? 127u : ((256u - _e810) & 255u)) << 8u)) | (((_e819 == 128u) ? 127u : ((256u - _e819) & 255u)) << 16u)) | (((_e828 == 128u) ? 127u : ((256u - _e828) & 255u)) << 24u);
    uint _e836 = _e834 & 255u;
    uint _e846 = (_e834 >> 8u) & 255u;
    uint _e855 = (_e834 >> 16u) & 255u;
    uint _e864 = (_e834 >> 24u) & 255u;
    local_27 = static_cast<uint>(base_1 + 16u);
    uint _e875 = local_27;
    output[_e875] = ((((_e836 == 128u) ? 127u : ((256u - _e836) & 255u)) | (((_e846 == 128u) ? 127u : ((256u - _e846) & 255u)) << 8u)) | (((_e855 == 128u) ? 127u : ((256u - _e855) & 255u)) << 16u)) | (((_e864 == 128u) ? 127u : ((256u - _e864) & 255u)) << 24u);
}
