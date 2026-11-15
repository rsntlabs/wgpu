// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_1[1];
typedef uint type_3[1];

struct if_initializersInput {
};
kernel void if_initializers(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& input [[buffer(0)]]
, device type_3& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    uint local = {};
    int state = {};
    uint local_1 = {};
    int index = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    int header = {};
    uint local_8 = {};
    int header_1 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    int header_2 = {};
    uint local_12 = {};
    uint local_13 = {};
    int pass = {};
    int selected = {};
    int selected_1 = {};
    uint local_14 = {};
    uint local_15 = {};
    int read = {};
    uint local_16 = {};
    uint local_17 = {};
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
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 16u);
    int seed = input[lane];
    local = static_cast<uint>(lane + 4u);
    uint _e13 = local;
    int other = input[_e13];
    state = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    if (seed > 0) {
        int _e22 = state;
        state = as_type<int>(as_type<uint>(_e22) + as_type<uint>(10));
    } else {
        int _e25 = state;
        state = as_type<int>(as_type<uint>(_e25) + as_type<uint>(20));
    }
    int _e28 = state;
    output[base] = static_cast<uint>(_e28);
    int _e32 = state;
    state = as_type<int>(as_type<uint>(_e32) + as_type<uint>(1));
    if (false) {
        int _e36 = state;
        state = as_type<int>(as_type<uint>(_e36) + as_type<uint>(99));
    } else {
        int _e39 = state;
        local_1 = static_cast<uint>(base + 1u);
        uint _e45 = local_1;
        local_21 = _e45;
        uint _e47 = local_21;
        output[_e47] = static_cast<uint>(_e39);
    }
    index = 0;
    int _e51 = index;
    index = as_type<int>(as_type<uint>(_e51) + as_type<uint>(1));
    int _e54 = state;
    state = as_type<int>(as_type<uint>(_e54) + as_type<uint>(2));
    if (seed < other) {
        int _e58 = state;
        state = as_type<int>(as_type<uint>(_e58) + as_type<uint>(3));
    } else {
        int _e61 = state;
        state = as_type<int>(as_type<uint>(_e61) + as_type<uint>(5));
    }
    int _e64 = index;
    local_2 = static_cast<uint>(base + 2u);
    uint _e70 = local_2;
    output[_e70] = static_cast<uint>(_e64);
    int _e72 = state;
    local_3 = static_cast<uint>(base + 3u);
    uint _e78 = local_3;
    output[_e78] = static_cast<uint>(_e72);
    if (seed < other) {
        local_4 = static_cast<uint>(base + 4u);
        uint _e88 = local_4;
        local_22 = _e88;
        uint _e90 = local_22;
        output[_e90] = static_cast<uint>(as_type<int>(as_type<uint>(seed) + as_type<uint>(100)));
    } else {
        local_5 = static_cast<uint>(base + 4u);
        uint _e99 = local_5;
        local_23 = _e99;
        uint _e101 = local_23;
        output[_e101] = static_cast<uint>(as_type<int>(as_type<uint>(other) + as_type<uint>(200)));
    }
    if (true) {
        local_6 = static_cast<uint>(base + 5u);
        uint _e111 = local_6;
        local_24 = _e111;
        uint _e113 = local_24;
        output[_e113] = static_cast<uint>(as_type<int>(as_type<uint>(seed) + as_type<uint>(300)));
    }
    int _e115 = state;
    if (_e115 > 0) {
        int _e118 = state;
        state = as_type<int>(as_type<uint>(_e118) + as_type<uint>(7));
    }
    int _e121 = state;
    local_7 = static_cast<uint>(base + 6u);
    uint _e127 = local_7;
    output[_e127] = static_cast<uint>(_e121);
    header = 50;
    if (seed > 0) {
        local_8 = static_cast<uint>(base + 7u);
        uint _e140 = local_8;
        local_25 = _e140;
        uint _e142 = local_25;
        output[_e142] = static_cast<uint>(as_type<int>(as_type<uint>(seed) + as_type<uint>(400)));
    } else {
        header_1 = other;
        int _e145 = header_1;
        if (_e145 > 0) {
            int _e148 = header_1;
            local_9 = static_cast<uint>(base + 7u);
            uint _e156 = local_9;
            local_26 = _e156;
            uint _e158 = local_26;
            output[_e158] = static_cast<uint>(as_type<int>(as_type<uint>(_e148) + as_type<uint>(500)));
        } else {
            int _e160 = header_1;
            local_10 = static_cast<uint>(base + 7u);
            uint _e168 = local_10;
            local_27 = _e168;
            uint _e170 = local_27;
            output[_e170] = static_cast<uint>(as_type<int>(as_type<uint>(_e160) + as_type<uint>(600)));
        }
    }
    int _e172 = header;
    local_11 = static_cast<uint>(base + 8u);
    uint _e178 = local_11;
    output[_e178] = static_cast<uint>(_e172);
    if (true) {
        {
            header_2 = 9;
            int _e183 = header_2;
            int _e184 = state;
            state = as_type<int>(as_type<uint>(_e184) + as_type<uint>(_e183));
        }
        local_12 = static_cast<uint>(base + 9u);
        uint _e193 = local_12;
        local_28 = _e193;
        uint _e195 = local_28;
        output[_e195] = static_cast<uint>(as_type<int>(as_type<uint>(seed) + as_type<uint>(20)));
    }
    int _e197 = state;
    local_13 = static_cast<uint>(base + 10u);
    uint _e203 = local_13;
    output[_e203] = static_cast<uint>(_e197);
    {
        pass = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e225 = pass;
                pass = as_type<int>(as_type<uint>(_e225) + as_type<uint>(1));
            }
            loop_init = false;
            int _e207 = pass;
            if (_e207 < 4) {
            } else {
                break;
            }
            int _e210 = pass;
            selected = _e210;
            int _e212 = selected;
            if (_e212 == 1) {
                continue;
            }
            int _e215 = pass;
            selected_1 = _e215;
            int _e217 = selected_1;
            if (_e217 == 3) {
                break;
            }
            int _e220 = pass;
            int _e223 = state;
            state = as_type<int>(as_type<uint>(_e223) + as_type<uint>(as_type<int>(as_type<uint>(_e220) + as_type<uint>(1))));
        }
    }
    int _e228 = state;
    local_14 = static_cast<uint>(base + 11u);
    uint _e234 = local_14;
    output[_e234] = static_cast<uint>(_e228);
    int _e236 = state;
    state = as_type<int>(as_type<uint>(_e236) + as_type<uint>(1));
    if (true) {
        int _e240 = state;
        local_15 = static_cast<uint>(base + 12u);
        uint _e246 = local_15;
        local_29 = _e246;
        uint _e248 = local_29;
        output[_e248] = static_cast<uint>(_e240);
    }
    read = 0;
    int _e252 = read;
    read = as_type<int>(as_type<uint>(_e252) + as_type<uint>(1));
    local_16 = static_cast<uint>(lane + static_cast<uint>(_e252));
    uint _e259 = local_16;
    int saved = input[_e259];
    if (saved > 0) {
        int _e264 = read;
        local_17 = static_cast<uint>(base + 13u);
        uint _e272 = local_17;
        local_30 = _e272;
        uint _e274 = local_30;
        output[_e274] = static_cast<uint>(as_type<int>(as_type<uint>(_e264) + as_type<uint>(100)));
    } else {
        int _e276 = read;
        local_18 = static_cast<uint>(base + 13u);
        uint _e284 = local_18;
        local_31 = _e284;
        uint _e286 = local_31;
        output[_e286] = static_cast<uint>(as_type<int>(as_type<uint>(_e276) + as_type<uint>(200)));
    }
    int _e288 = state;
    local_19 = static_cast<uint>(base + 14u);
    uint _e294 = local_19;
    output[_e294] = static_cast<uint>(_e288);
    int _e296 = index;
    local_20 = static_cast<uint>(base + 15u);
    uint _e302 = local_20;
    output[_e302] = static_cast<uint>(_e296);
}
