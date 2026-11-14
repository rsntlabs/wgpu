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


struct multiply_highInput {
};
kernel void multiply_high(
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
    bool local_11 = {};
    bool local_12 = {};
    uint local_13 = {};
    uint index = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint scale = {};
    uint scale_1 = {};
    uint scale_2 = {};
    uint scale_3 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
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
                uint _e113 = row;
                row = _e113 + 4u;
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
            local_22 = _e17;
            uint _e19 = local_22;
            uint _e21 = input[_e19];
            local_23 = _e21;
            uint _e23 = local_23;
            local_20 = _e23;
            uint _e25 = local_20;
            a = _e25;
            uint _e27 = row;
            local_1 = static_cast<uint>(2u + (_e27 * 2u));
            uint _e34 = local_1;
            local_24 = _e34;
            uint _e36 = local_24;
            uint _e38 = input[_e36];
            local_25 = _e38;
            uint _e40 = local_25;
            local_21 = _e40;
            uint _e42 = local_21;
            b = _e42;
            uint _e44 = a;
            uint _e45 = b;
            uint _e47 = _e44 & 65535u;
            uint _e48 = _e45 & 65535u;
            uint _e50 = _e44 >> 16u;
            uint _e51 = _e45 >> 16u;
            uint _e55 = (_e50 * _e48) + ((_e47 * _e48) >> 16u);
            uint _e64 = row;
            local_2 = static_cast<uint>(4u + (_e64 * 2u));
            uint _e71 = local_2;
            local_26 = _e71;
            uint _e73 = local_26;
            output[_e73] = ((_e50 * _e51) + (_e55 >> 16u)) + (((_e47 * _e51) + (_e55 & 65535u)) >> 16u);
            uint _e76 = a;
            int _e77 = static_cast<int>(_e76);
            uint _e78 = b;
            int _e79 = static_cast<int>(_e78);
            int _e81 = _e77 & 65535;
            int _e82 = _e79 & 65535;
            int _e84 = _e77 >> 16u;
            int _e85 = _e79 >> 16u;
            int _e92 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e84) * as_type<uint>(_e82))) + as_type<uint>(static_cast<int>((static_cast<uint>(_e81) * static_cast<uint>(_e82)) >> 16u)));
            uint _e102 = row;
            local_3 = static_cast<uint>(5u + (_e102 * 2u));
            uint _e109 = local_3;
            local_27 = _e109;
            uint _e111 = local_27;
            output[_e111] = static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e84) * as_type<uint>(_e85))) + as_type<uint>(_e92 >> 16u))) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e81) * as_type<uint>(_e85))) + as_type<uint>(_e92 & 65535)) >> 16u)));
        }
    }
    uint base = (4u + (count * 2u)) + (lane * 10u);
    value = 1u;
    scale = uint {};
    scale = 1073741825u;
    uint _e129 = value;
    value = _e129 + static_cast<uint>(1);
    uint _e133 = scale;
    local_4 = _e129 * _e133;
    uint _e136 = local_4;
    scale_1 = uint {};
    scale_1 = 536870915u;
    uint _e141 = value;
    value = _e141 + static_cast<uint>(1);
    uint _e145 = scale_1;
    local_5 = _e141 * _e145;
    uint _e148 = local_5;
    uint _e150 = _e136 & 65535u;
    uint _e151 = _e148 & 65535u;
    uint _e153 = _e136 >> 16u;
    uint _e154 = _e148 >> 16u;
    uint _e158 = (_e153 * _e151) + ((_e150 * _e151) >> 16u);
    output[base] = ((_e153 * _e154) + (_e158 >> 16u)) + (((_e150 * _e154) + (_e158 & 65535u)) >> 16u);
    scale_2 = uint {};
    scale_2 = 1073741825u;
    uint _e173 = value;
    value = _e173 + static_cast<uint>(1);
    uint _e177 = scale_2;
    local_7 = _e173 * _e177;
    uint _e180 = local_7;
    int _e181 = static_cast<int>(_e180);
    scale_3 = uint {};
    scale_3 = 536870915u;
    uint _e186 = value;
    value = _e186 + static_cast<uint>(1);
    uint _e190 = scale_3;
    local_8 = _e186 * _e190;
    uint _e193 = local_8;
    int _e194 = static_cast<int>(_e193);
    int _e196 = _e181 & 65535;
    int _e197 = _e194 & 65535;
    int _e199 = _e181 >> 16u;
    int _e200 = _e194 >> 16u;
    int _e207 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e199) * as_type<uint>(_e197))) + as_type<uint>(static_cast<int>((static_cast<uint>(_e196) * static_cast<uint>(_e197)) >> 16u)));
    local_6 = static_cast<uint>(base + 1u);
    uint _e221 = local_6;
    output[_e221] = static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e199) * as_type<uint>(_e200))) + as_type<uint>(_e207 >> 16u))) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e196) * as_type<uint>(_e200))) + as_type<uint>(_e207 & 65535)) >> 16u)));
    if ((lane & 1u) == 0u) {
        uint _e227 = value;
        value = _e227 + static_cast<uint>(1);
        uint _e231 = value;
        value = _e231 + static_cast<uint>(1);
        uint _e236 = _e227 & 65535u;
        uint _e237 = _e231 & 65535u;
        uint _e239 = _e227 >> 16u;
        uint _e240 = _e231 >> 16u;
        uint _e244 = (_e239 * _e237) + ((_e236 * _e237) >> 16u);
        local_9 = ((_e239 * _e240) + (_e244 >> 16u)) + (((_e236 * _e240) + (_e244 & 65535u)) >> 16u);
    } else {
        local_9 = 0u;
    }
    uint _e256 = value;
    local_10 = static_cast<uint>(base + 2u);
    uint _e261 = local_10;
    output[_e261] = _e256;
    local_11 = false;
    if (false) {
        uint _e265 = value;
        value = _e265 + static_cast<uint>(1);
        int _e269 = static_cast<int>(_e265);
        uint _e270 = value;
        value = _e270 + static_cast<uint>(1);
        int _e274 = static_cast<int>(_e270);
        int _e276 = _e269 & 65535;
        int _e277 = _e274 & 65535;
        int _e279 = _e269 >> 16u;
        int _e280 = _e274 >> 16u;
        int _e287 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e279) * as_type<uint>(_e277))) + as_type<uint>(static_cast<int>((static_cast<uint>(_e276) * static_cast<uint>(_e277)) >> 16u)));
        local_11 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e279) * as_type<uint>(_e280))) + as_type<uint>(_e287 >> 16u))) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e276) * as_type<uint>(_e280))) + as_type<uint>(_e287 & 65535)) >> 16u)) != 0;
    }
    local_12 = true;
    if (true) {
    } else {
        uint _e300 = value;
        value = _e300 + static_cast<uint>(1);
        uint _e304 = value;
        value = _e304 + static_cast<uint>(1);
        uint _e309 = _e300 & 65535u;
        uint _e310 = _e304 & 65535u;
        uint _e312 = _e300 >> 16u;
        uint _e313 = _e304 >> 16u;
        uint _e317 = (_e312 * _e310) + ((_e309 * _e310) >> 16u);
        local_12 = (((_e312 * _e313) + (_e317 >> 16u)) + (((_e309 * _e313) + (_e317 & 65535u)) >> 16u)) != 0u;
    }
    uint _e328 = value;
    value = _e328 + static_cast<uint>(1);
    uint _e332 = value;
    value = _e332 + static_cast<uint>(1);
    uint _e336 = value;
    local_13 = static_cast<uint>(base + 3u);
    uint _e341 = local_13;
    output[_e341] = _e336;
    index = 1u;
    uint _e345 = index;
    index = _e345 + static_cast<uint>(1);
    uint _e350 = input[_e345];
    uint _e351 = index;
    index = _e351 + static_cast<uint>(1);
    uint _e356 = input[_e351];
    uint _e358 = _e350 & 65535u;
    uint _e359 = _e356 & 65535u;
    uint _e361 = _e350 >> 16u;
    uint _e362 = _e356 >> 16u;
    uint _e366 = (_e361 * _e359) + ((_e358 * _e359) >> 16u);
    local_14 = static_cast<uint>(base + 4u);
    uint _e379 = local_14;
    output[_e379] = ((_e361 * _e362) + (_e366 >> 16u)) + (((_e358 * _e362) + (_e366 & 65535u)) >> 16u);
    uint _e381 = index;
    local_15 = static_cast<uint>(base + 5u);
    uint _e386 = local_15;
    output[_e386] = _e381;
    int _e389 = naga_neg(1);
    int _e391 = _e389 & 65535;
    int _e393 = 1 & 65535;
    int _e395 = _e389 >> 16u;
    int _e396 = 1 >> 16u;
    int _e403 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e395) * as_type<uint>(_e393))) + as_type<uint>(static_cast<int>((static_cast<uint>(_e391) * static_cast<uint>(_e393)) >> 16u)));
    local_16 = static_cast<uint>(base + 6u);
    uint _e417 = local_16;
    output[_e417] = static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e395) * as_type<uint>(_e396))) + as_type<uint>(_e403 >> 16u))) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e391) * as_type<uint>(_e396))) + as_type<uint>(_e403 & 65535)) >> 16u)));
    int _e422 = as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1));
    int _e426 = as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1));
    int _e428 = _e422 & 65535;
    int _e429 = _e426 & 65535;
    int _e431 = _e422 >> 16u;
    int _e432 = _e426 >> 16u;
    int _e439 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e431) * as_type<uint>(_e429))) + as_type<uint>(static_cast<int>((static_cast<uint>(_e428) * static_cast<uint>(_e429)) >> 16u)));
    local_17 = static_cast<uint>(base + 7u);
    uint _e453 = local_17;
    output[_e453] = static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e431) * as_type<uint>(_e432))) + as_type<uint>(_e439 >> 16u))) + as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e428) * as_type<uint>(_e432))) + as_type<uint>(_e439 & 65535)) >> 16u)));
    uint _e457 = 4294967295u & 65535u;
    uint _e459 = 4294967295u & 65535u;
    uint _e461 = 4294967295u >> 16u;
    uint _e462 = 4294967295u >> 16u;
    uint _e466 = (_e461 * _e459) + ((_e457 * _e459) >> 16u);
    local_18 = static_cast<uint>(base + 8u);
    uint _e479 = local_18;
    output[_e479] = ((_e461 * _e462) + (_e466 >> 16u)) + (((_e457 * _e462) + (_e466 & 65535u)) >> 16u);
    uint _e483 = static_cast<uint>(naga_neg(1));
    uint _e485 = _e483 & 65535u;
    uint _e487 = 2u & 65535u;
    uint _e489 = _e483 >> 16u;
    uint _e490 = 2u >> 16u;
    uint _e494 = (_e489 * _e487) + ((_e485 * _e487) >> 16u);
    local_19 = static_cast<uint>(base + 9u);
    uint _e507 = local_19;
    output[_e507] = ((_e489 * _e490) + (_e494 >> 16u)) + (((_e485 * _e490) + (_e494 & 65535u)) >> 16u);
}
