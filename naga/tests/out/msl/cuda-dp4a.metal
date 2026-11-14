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


struct dp4aInput {
};
kernel void dp4a(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& output [[buffer(0)]]
, device type_1 const& input [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint row = {};
    uint at = {};
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
                uint _e126 = row;
                row = _e126 + 4u;
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
            local = _e16;
            uint _e18 = local;
            local_26 = _e18;
            uint _e20 = local_26;
            uint _e22 = input[_e20];
            local_27 = _e22;
            uint _e24 = local_27;
            local_23 = _e24;
            uint _e26 = local_23;
            a = _e26;
            uint _e28 = at;
            local_1 = static_cast<uint>(_e28 + 1u);
            uint _e33 = local_1;
            local_28 = _e33;
            uint _e35 = local_28;
            uint _e37 = input[_e35];
            local_29 = _e37;
            uint _e39 = local_29;
            local_24 = _e39;
            uint _e41 = local_24;
            b = _e41;
            uint _e43 = at;
            local_2 = static_cast<uint>(_e43 + 2u);
            uint _e48 = local_2;
            local_30 = _e48;
            uint _e50 = local_30;
            uint _e52 = input[_e50];
            local_31 = _e52;
            uint _e54 = local_31;
            local_25 = _e54;
            uint _e56 = local_25;
            accumulator = _e56;
            uint _e58 = a;
            uint _e60 = b;
            uint _e62 = accumulator;
            uint _e64 = as_type<uint>(static_cast<int>(_e58));
            uint _e65 = as_type<uint>(static_cast<int>(_e60));
            uint _e67 = as_type<uint>(( + (int(_e64) << 24 >> 24) * (int(_e65) << 24 >> 24) + (int(_e64) << 16 >> 24) * (int(_e65) << 16 >> 24) + (int(_e64) << 8 >> 24) * (int(_e65) << 8 >> 24) + (int(_e64) >> 24) * (int(_e65) >> 24)));
            uint _e68 = as_type<uint>(static_cast<int>(_e62));
            uint _e72 = (_e67 & 65535u) + (_e68 & 65535u);
            uint _e85 = row;
            local_3 = static_cast<uint>(4u + (_e85 * 2u));
            uint _e92 = local_3;
            local_32 = _e92;
            uint _e94 = local_32;
            output[_e94] = static_cast<uint>(as_type<int>((((((_e67 >> 16u) + (_e68 >> 16u)) + (_e72 >> 16u)) & 65535u) << 16u) | (_e72 & 65535u)));
            uint _e97 = a;
            uint _e98 = b;
            uint _e99 = accumulator;
            uint _e100 = ( + ((_e97) << 24 >> 24) * ((_e98) << 24 >> 24) + ((_e97) << 16 >> 24) * ((_e98) << 16 >> 24) + ((_e97) << 8 >> 24) * ((_e98) << 8 >> 24) + ((_e97) >> 24) * ((_e98) >> 24));
            uint _e104 = (_e100 & 65535u) + (_e99 & 65535u);
            uint _e115 = row;
            local_4 = static_cast<uint>(5u + (_e115 * 2u));
            uint _e122 = local_4;
            local_33 = _e122;
            uint _e124 = local_33;
            output[_e124] = (((((_e100 >> 16u) + (_e99 >> 16u)) + (_e104 >> 16u)) & 65535u) << 16u) | (_e104 & 65535u);
        }
    }
    uint base = (4u + (count * 2u)) + (lane * 10u);
    value = 1u;
    scale = uint {};
    bias = uint {};
    scale = 16909060u;
    bias = 2164195711u;
    uint _e146 = value;
    value = _e146 + static_cast<uint>(1);
    uint _e150 = scale;
    uint _e152 = bias;
    local_5 = (_e146 * _e150) ^ _e152;
    uint _e155 = local_5;
    scale_1 = uint {};
    bias_1 = uint {};
    scale_1 = 50661129u;
    bias_1 = 4261576960u;
    uint _e164 = value;
    value = _e164 + static_cast<uint>(1);
    uint _e168 = scale_1;
    uint _e170 = bias_1;
    local_6 = (_e164 * _e168) ^ _e170;
    uint _e173 = local_6;
    scale_2 = uint {};
    bias_2 = uint {};
    scale_2 = 17u;
    bias_2 = 0u;
    uint _e182 = value;
    value = _e182 + static_cast<uint>(1);
    uint _e186 = scale_2;
    uint _e188 = bias_2;
    local_7 = (_e182 * _e186) ^ _e188;
    uint _e191 = local_7;
    uint _e194 = static_cast<uint>(naga_neg(static_cast<int>(_e191)));
    uint _e195 = ( + ((_e155) << 24 >> 24) * ((_e173) << 24 >> 24) + ((_e155) << 16 >> 24) * ((_e173) << 16 >> 24) + ((_e155) << 8 >> 24) * ((_e173) << 8 >> 24) + ((_e155) >> 24) * ((_e173) >> 24));
    uint _e199 = (_e195 & 65535u) + (_e194 & 65535u);
    output[base] = (((((_e195 >> 16u) + (_e194 >> 16u)) + (_e199 >> 16u)) & 65535u) << 16u) | (_e199 & 65535u);
    scale_3 = uint {};
    bias_3 = uint {};
    scale_3 = 16909060u;
    bias_3 = 2164195711u;
    uint _e220 = value;
    value = _e220 + static_cast<uint>(1);
    uint _e224 = scale_3;
    uint _e226 = bias_3;
    local_9 = (_e220 * _e224) ^ _e226;
    uint _e229 = local_9;
    scale_4 = uint {};
    bias_4 = uint {};
    scale_4 = 50661129u;
    bias_4 = 4261576960u;
    uint _e239 = value;
    value = _e239 + static_cast<uint>(1);
    uint _e243 = scale_4;
    uint _e245 = bias_4;
    local_10 = (_e239 * _e243) ^ _e245;
    uint _e248 = local_10;
    scale_5 = uint {};
    bias_5 = uint {};
    scale_5 = 17u;
    bias_5 = 0u;
    uint _e258 = value;
    value = _e258 + static_cast<uint>(1);
    uint _e262 = scale_5;
    uint _e264 = bias_5;
    local_11 = (_e258 * _e262) ^ _e264;
    uint _e267 = local_11;
    uint _e270 = as_type<uint>(static_cast<int>(_e229));
    uint _e271 = as_type<uint>(static_cast<int>(_e248));
    uint _e273 = as_type<uint>(( + (int(_e270) << 24 >> 24) * (int(_e271) << 24 >> 24) + (int(_e270) << 16 >> 24) * (int(_e271) << 16 >> 24) + (int(_e270) << 8 >> 24) * (int(_e271) << 8 >> 24) + (int(_e270) >> 24) * (int(_e271) >> 24)));
    uint _e274 = as_type<uint>(naga_neg(static_cast<int>(_e267)));
    uint _e278 = (_e273 & 65535u) + (_e274 & 65535u);
    local_8 = static_cast<uint>(base + 1u);
    uint _e295 = local_8;
    output[_e295] = static_cast<uint>(as_type<int>((((((_e273 >> 16u) + (_e274 >> 16u)) + (_e278 >> 16u)) & 65535u) << 16u) | (_e278 & 65535u)));
    if ((lane & 1u) == 0u) {
        uint _e301 = value;
        value = _e301 + static_cast<uint>(1);
        uint _e305 = value;
        value = _e305 + static_cast<uint>(1);
        uint _e309 = value;
        value = _e309 + static_cast<uint>(1);
        uint _e313 = ( + ((_e301) << 24 >> 24) * ((_e305) << 24 >> 24) + ((_e301) << 16 >> 24) * ((_e305) << 16 >> 24) + ((_e301) << 8 >> 24) * ((_e305) << 8 >> 24) + ((_e301) >> 24) * ((_e305) >> 24));
        uint _e317 = (_e313 & 65535u) + (_e309 & 65535u);
        local_12 = (((((_e313 >> 16u) + (_e309 >> 16u)) + (_e317 >> 16u)) & 65535u) << 16u) | (_e317 & 65535u);
    } else {
        local_12 = 0u;
    }
    uint _e331 = value;
    local_13 = static_cast<uint>(base + 2u);
    uint _e336 = local_13;
    output[_e336] = _e331;
    local_14 = false;
    if (false) {
        uint _e340 = value;
        value = _e340 + static_cast<uint>(1);
        uint _e344 = value;
        value = _e344 + static_cast<uint>(1);
        uint _e348 = value;
        value = _e348 + static_cast<uint>(1);
        uint _e352 = ( + ((_e340) << 24 >> 24) * ((_e344) << 24 >> 24) + ((_e340) << 16 >> 24) * ((_e344) << 16 >> 24) + ((_e340) << 8 >> 24) * ((_e344) << 8 >> 24) + ((_e340) >> 24) * ((_e344) >> 24));
        uint _e356 = (_e352 & 65535u) + (_e348 & 65535u);
        local_14 = ((((((_e352 >> 16u) + (_e348 >> 16u)) + (_e356 >> 16u)) & 65535u) << 16u) | (_e356 & 65535u)) != 0u;
    }
    local_15 = true;
    if (true) {
    } else {
        uint _e371 = value;
        value = _e371 + static_cast<uint>(1);
        uint _e375 = value;
        value = _e375 + static_cast<uint>(1);
        uint _e379 = value;
        value = _e379 + static_cast<uint>(1);
        uint _e383 = ( + ((_e371) << 24 >> 24) * ((_e375) << 24 >> 24) + ((_e371) << 16 >> 24) * ((_e375) << 16 >> 24) + ((_e371) << 8 >> 24) * ((_e375) << 8 >> 24) + ((_e371) >> 24) * ((_e375) >> 24));
        uint _e387 = (_e383 & 65535u) + (_e379 & 65535u);
        local_15 = ((((((_e383 >> 16u) + (_e379 >> 16u)) + (_e387 >> 16u)) & 65535u) << 16u) | (_e387 & 65535u)) != 0u;
    }
    uint _e400 = value;
    value = _e400 + static_cast<uint>(1);
    uint _e404 = value;
    value = _e404 + static_cast<uint>(1);
    uint _e408 = value;
    value = _e408 + static_cast<uint>(1);
    uint _e412 = value;
    local_16 = static_cast<uint>(base + 3u);
    uint _e417 = local_16;
    output[_e417] = _e412;
    index = 1u;
    uint _e421 = index;
    index = _e421 + static_cast<uint>(1);
    uint _e426 = input[_e421];
    uint _e427 = index;
    index = _e427 + static_cast<uint>(1);
    uint _e432 = input[_e427];
    uint _e433 = index;
    index = _e433 + static_cast<uint>(1);
    uint _e438 = input[_e433];
    uint _e439 = ( + ((_e426) << 24 >> 24) * ((_e432) << 24 >> 24) + ((_e426) << 16 >> 24) * ((_e432) << 16 >> 24) + ((_e426) << 8 >> 24) * ((_e432) << 8 >> 24) + ((_e426) >> 24) * ((_e432) >> 24));
    uint _e443 = (_e439 & 65535u) + (_e438 & 65535u);
    local_17 = static_cast<uint>(base + 4u);
    uint _e458 = local_17;
    output[_e458] = (((((_e439 >> 16u) + (_e438 >> 16u)) + (_e443 >> 16u)) & 65535u) << 16u) | (_e443 & 65535u);
    uint _e460 = index;
    local_18 = static_cast<uint>(base + 5u);
    uint _e465 = local_18;
    output[_e465] = _e460;
    uint _e469 = ( + ((4294967295u) << 24 >> 24) * ((4294967295u) << 24 >> 24) + ((4294967295u) << 16 >> 24) * ((4294967295u) << 16 >> 24) + ((4294967295u) << 8 >> 24) * ((4294967295u) << 8 >> 24) + ((4294967295u) >> 24) * ((4294967295u) >> 24));
    uint _e474 = (_e469 & 65535u) + (4294967295u & 65535u);
    local_19 = static_cast<uint>(base + 6u);
    uint _e489 = local_19;
    output[_e489] = (((((_e469 >> 16u) + (4294967295u >> 16u)) + (_e474 >> 16u)) & 65535u) << 16u) | (_e474 & 65535u);
    uint _e495 = as_type<uint>(static_cast<int>(2155905152u));
    uint _e496 = as_type<uint>(static_cast<int>(2155905152u));
    uint _e498 = as_type<uint>(( + (int(_e495) << 24 >> 24) * (int(_e496) << 24 >> 24) + (int(_e495) << 16 >> 24) * (int(_e496) << 16 >> 24) + (int(_e495) << 8 >> 24) * (int(_e496) << 8 >> 24) + (int(_e495) >> 24) * (int(_e496) >> 24)));
    uint _e500 = as_type<uint>(2147483647);
    uint _e504 = (_e498 & 65535u) + (_e500 & 65535u);
    local_20 = static_cast<uint>(base + 7u);
    uint _e521 = local_20;
    output[_e521] = static_cast<uint>(as_type<int>((((((_e498 >> 16u) + (_e500 >> 16u)) + (_e504 >> 16u)) & 65535u) << 16u) | (_e504 & 65535u)));
    uint _e531 = as_type<uint>(static_cast<int>(2155905152u));
    uint _e532 = as_type<uint>(static_cast<int>(2139062143u));
    uint _e534 = as_type<uint>(( + (int(_e531) << 24 >> 24) * (int(_e532) << 24 >> 24) + (int(_e531) << 16 >> 24) * (int(_e532) << 16 >> 24) + (int(_e531) << 8 >> 24) * (int(_e532) << 8 >> 24) + (int(_e531) >> 24) * (int(_e532) >> 24)));
    uint _e535 = as_type<uint>(as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)));
    uint _e539 = (_e534 & 65535u) + (_e535 & 65535u);
    local_21 = static_cast<uint>(base + 8u);
    uint _e556 = local_21;
    output[_e556] = static_cast<uint>(as_type<int>((((((_e534 >> 16u) + (_e535 >> 16u)) + (_e539 >> 16u)) & 65535u) << 16u) | (_e539 & 65535u)));
    uint _e560 = ( + ((16843009u) << 24 >> 24) * ((16843009u) << 24 >> 24) + ((16843009u) << 16 >> 24) * ((16843009u) << 16 >> 24) + ((16843009u) << 8 >> 24) * ((16843009u) << 8 >> 24) + ((16843009u) >> 24) * ((16843009u) >> 24));
    uint _e565 = (_e560 & 65535u) + (65535u & 65535u);
    local_22 = static_cast<uint>(base + 9u);
    uint _e580 = local_22;
    output[_e580] = (((((_e560 >> 16u) + (65535u >> 16u)) + (_e565 >> 16u)) & 65535u) << 16u) | (_e565 & 65535u);
}
