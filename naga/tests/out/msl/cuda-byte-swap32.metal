// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_2[1];

int swap_result(
    uint value_2
) {
    return 1;
}

struct byte_swap32_Input {
};
kernel void byte_swap32_(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2& output [[buffer(0)]]
, device type_2 const& input [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint row = {};
    uint value = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint value_1 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    bool local_7 = {};
    bool local_8 = {};
    uint local_9 = {};
    uint index = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
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
                uint _e92 = row;
                row = _e92 + 4u;
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
            local_16 = _e15;
            uint _e17 = local_16;
            uint _e19 = input[_e17];
            local_17 = _e19;
            uint _e21 = local_17;
            local_15 = _e21;
            uint _e23 = local_15;
            value = _e23;
            uint _e25 = value;
            uint _e40 = row;
            local_1 = static_cast<uint>(4u + (_e40 * 2u));
            uint _e47 = local_1;
            local_18 = _e47;
            uint _e49 = local_18;
            output[_e49] = (((_e25 & 255u) << 24u) | ((_e25 & 65280u) << 8u)) | (((_e25 >> 8u) & 65280u) | (_e25 >> 24u));
            uint _e52 = value;
            uint _e66 = (((_e52 & 255u) << 24u) | ((_e52 & 65280u) << 8u)) | (((_e52 >> 8u) & 65280u) | (_e52 >> 24u));
            uint _e81 = row;
            local_2 = static_cast<uint>(5u + (_e81 * 2u));
            uint _e88 = local_2;
            local_19 = _e88;
            uint _e90 = local_19;
            output[_e90] = (((_e66 & 255u) << 24u) | ((_e66 & 65280u) << 8u)) | (((_e66 >> 8u) & 65280u) | (_e66 >> 24u));
        }
    }
    uint base = (4u + (count * 2u)) + (lane * 10u);
    value_1 = 16909060u + lane;
    uint _e105 = value_1;
    value_1 = _e105 + static_cast<uint>(1);
    output[base] = (((_e105 & 255u) << 24u) | ((_e105 & 65280u) << 8u)) | (((_e105 >> 8u) & 65280u) | (_e105 >> 24u));
    uint _e125 = value_1;
    value_1 = _e125 + static_cast<uint>(1);
    local_3 = static_cast<uint>(base + 1u);
    uint _e147 = local_3;
    output[_e147] = (((_e125 & 255u) << 24u) | ((_e125 & 65280u) << 8u)) | (((_e125 >> 8u) & 65280u) | (_e125 >> 24u));
    uint _e149 = value_1;
    local_4 = static_cast<uint>(base + 2u);
    uint _e154 = local_4;
    output[_e154] = _e149;
    if ((lane & 1u) == 0u) {
        uint _e160 = value_1;
        value_1 = _e160 + static_cast<uint>(1);
        local_5 = (((_e160 & 255u) << 24u) | ((_e160 & 65280u) << 8u)) | (((_e160 >> 8u) & 65280u) | (_e160 >> 24u));
    } else {
        local_5 = 0u;
    }
    uint _e181 = value_1;
    local_6 = static_cast<uint>(base + 3u);
    uint _e186 = local_6;
    output[_e186] = _e181;
    local_7 = false;
    if (false) {
        uint _e190 = value_1;
        value_1 = _e190 + static_cast<uint>(1);
        local_7 = ((((_e190 & 255u) << 24u) | ((_e190 & 65280u) << 8u)) | (((_e190 >> 8u) & 65280u) | (_e190 >> 24u))) != 0u;
    }
    local_8 = true;
    if (true) {
    } else {
        uint _e212 = value_1;
        value_1 = _e212 + static_cast<uint>(1);
        local_8 = ((((_e212 & 255u) << 24u) | ((_e212 & 65280u) << 8u)) | (((_e212 >> 8u) & 65280u) | (_e212 >> 24u))) != 0u;
    }
    uint _e232 = value_1;
    value_1 = _e232 + static_cast<uint>(1);
    uint _e236 = value_1;
    local_9 = static_cast<uint>(base + 4u);
    uint _e241 = local_9;
    output[_e241] = _e236;
    index = 1u;
    uint _e245 = index;
    index = _e245 + static_cast<uint>(1);
    uint _e250 = input[_e245];
    local_10 = static_cast<uint>(base + 5u);
    uint _e269 = local_10;
    output[_e269] = (((_e250 & 255u) << 24u) | ((_e250 & 65280u) << 8u)) | (((_e250 >> 8u) & 65280u) | (_e250 >> 24u));
    uint _e271 = index;
    local_11 = static_cast<uint>(base + 6u);
    uint _e276 = local_11;
    output[_e276] = _e271;
    uint _e278 = value_1;
    int _e293 = swap_result((((_e278 & 255u) << 24u) | ((_e278 & 65280u) << 8u)) | (((_e278 >> 8u) & 65280u) | (_e278 >> 24u)));
    local_12 = static_cast<uint>(base + 7u);
    uint _e299 = local_12;
    output[_e299] = static_cast<uint>(_e293);
    local_13 = static_cast<uint>(base + 8u);
    uint _e320 = local_13;
    output[_e320] = (((4294967295u & 255u) << 24u) | ((4294967295u & 65280u) << 8u)) | (((4294967295u >> 8u) & 65280u) | (4294967295u >> 24u));
    uint _e322 = value_1;
    uint _e336 = (((_e322 & 255u) << 24u) | ((_e322 & 65280u) << 8u)) | (((_e322 >> 8u) & 65280u) | (_e322 >> 24u));
    local_14 = static_cast<uint>(base + 9u);
    uint _e355 = local_14;
    output[_e355] = (((_e336 & 255u) << 24u) | ((_e336 & 65280u) << 8u)) | (((_e336 >> 8u) & 65280u) | (_e336 >> 24u));
}
