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

struct switch_initializersInput {
};
kernel void switch_initializers(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& input [[buffer(0)]]
, device type_3& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    int state = {};
    uint local = {};
    int bias = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    int key = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    int key_1 = {};
    uint local_9 = {};
    uint local_10 = {};
    int One = {};
    uint local_11 = {};
    int pass = {};
    int selected = {};
    uint local_12 = {};
    int counter = {};
    uint local_13 = {};
    uint local_14 = {};
    int inner = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 16u);
    int seed = input[lane];
    state = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    switch(seed) {
        case 0: {
            int _e13 = state;
            state = as_type<int>(as_type<uint>(_e13) + as_type<uint>(1));
            break;
        }
        default: {
            int _e16 = state;
            state = as_type<int>(as_type<uint>(_e16) + as_type<uint>(2));
            break;
        }
    }
    int _e19 = state;
    output[base] = static_cast<uint>(_e19);
    int _e23 = state;
    state = as_type<int>(as_type<uint>(_e23) + as_type<uint>(1));
    switch(seed) {
        case 0: {
            int _e26 = state;
            state = as_type<int>(as_type<uint>(_e26) + as_type<uint>(10));
            break;
        }
        case 1: {
            int _e29 = state;
            state = as_type<int>(as_type<uint>(_e29) + as_type<uint>(20));
            int _e32 = state;
            state = as_type<int>(as_type<uint>(_e32) + as_type<uint>(30));
            break;
        }
        case 2: {
            int _e35 = state;
            state = as_type<int>(as_type<uint>(_e35) + as_type<uint>(30));
            break;
        }
        default: {
            int _e38 = state;
            state = as_type<int>(as_type<uint>(_e38) + as_type<uint>(40));
            break;
        }
    }
    int _e41 = state;
    local = static_cast<uint>(base + 1u);
    uint _e47 = local;
    output[_e47] = static_cast<uint>(_e41);
    bias = 5;
    switch(seed) {
        case 0: {
            int _e51 = bias;
            local_1 = static_cast<uint>(base + 2u);
            uint _e57 = local_1;
            local_18 = _e57;
            uint _e59 = local_18;
            output[_e59] = static_cast<uint>(_e51);
            break;
        }
        case 1: {
            int _e61 = bias;
            local_2 = static_cast<uint>(base + 2u);
            uint _e68 = local_2;
            local_19 = _e68;
            uint _e70 = local_19;
            output[_e70] = static_cast<uint>(as_type<int>(as_type<uint>(_e61) + as_type<uint>(seed)));
            break;
        }
        default: {
            int _e72 = bias;
            local_3 = static_cast<uint>(base + 2u);
            uint _e79 = local_3;
            local_20 = _e79;
            uint _e81 = local_20;
            output[_e81] = static_cast<uint>(as_type<int>(as_type<uint>(_e72) + as_type<uint>(seed)));
            break;
        }
    }
    int key_2 = as_type<int>(as_type<uint>(seed) + as_type<uint>(1));
    switch(key_2) {
        case 1: {
            int _e85 = state;
            state = as_type<int>(as_type<uint>(_e85) + as_type<uint>(3));
            break;
        }
        default: {
            int _e88 = state;
            state = as_type<int>(as_type<uint>(_e88) + as_type<uint>(4));
            break;
        }
    }
    int _e91 = state;
    local_4 = static_cast<uint>(base + 3u);
    uint _e97 = local_4;
    output[_e97] = static_cast<uint>(_e91);
    int _e99 = state;
    switch(_e99) {
        default: {
            int _e100 = state;
            state = as_type<int>(as_type<uint>(_e100) + as_type<uint>(7));
            break;
        }
    }
    int _e103 = state;
    local_5 = static_cast<uint>(base + 4u);
    uint _e109 = local_5;
    output[_e109] = static_cast<uint>(_e103);
    key = 99;
    switch(seed) {
        case 0: {
            local_6 = static_cast<uint>(base + 5u);
            uint _e120 = local_6;
            local_21 = _e120;
            uint _e122 = local_21;
            output[_e122] = static_cast<uint>(as_type<int>(as_type<uint>(seed) + as_type<uint>(10)));
            break;
        }
        default: {
            local_7 = static_cast<uint>(base + 5u);
            uint _e131 = local_7;
            local_22 = _e131;
            uint _e133 = local_22;
            output[_e133] = static_cast<uint>(as_type<int>(as_type<uint>(seed) + as_type<uint>(20)));
            break;
        }
    }
    int _e135 = key;
    local_8 = static_cast<uint>(base + 6u);
    uint _e141 = local_8;
    output[_e141] = static_cast<uint>(_e135);
    switch(seed) {
        default: {
            {
                {
                    key_1 = 9;
                    int _e145 = key_1;
                    int _e146 = state;
                    state = as_type<int>(as_type<uint>(_e146) + as_type<uint>(_e145));
                }
                local_9 = static_cast<uint>(base + 7u);
                uint _e155 = local_9;
                local_23 = _e155;
                uint _e157 = local_23;
                output[_e157] = static_cast<uint>(as_type<int>(as_type<uint>(seed) + as_type<uint>(30)));
            }
            break;
        }
    }
    int _e159 = state;
    local_10 = static_cast<uint>(base + 8u);
    uint _e165 = local_10;
    output[_e165] = static_cast<uint>(_e159);
    One = 1;
    switch(seed) {
        case 1: {
            int _e169 = state;
            state = as_type<int>(as_type<uint>(_e169) + as_type<uint>(1));
            break;
        }
        default: {
            int _e172 = state;
            state = as_type<int>(as_type<uint>(_e172) + as_type<uint>(2));
            break;
        }
    }
    int _e175 = state;
    local_11 = static_cast<uint>(base + 9u);
    uint _e181 = local_11;
    output[_e181] = static_cast<uint>(_e175);
    {
        pass = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e200 = pass;
                pass = as_type<int>(as_type<uint>(_e200) + as_type<uint>(1));
            }
            loop_init = false;
            int _e185 = pass;
            if (_e185 < 4) {
            } else {
                break;
            }
            int _e188 = pass;
            selected = _e188;
            int _e190 = selected;
            switch(_e190) {
                case 1: {
                    continue;
                }
                case 2: {
                    int _e191 = state;
                    state = as_type<int>(as_type<uint>(_e191) + as_type<uint>(10));
                    break;
                }
                default: {
                    int _e194 = state;
                    state = as_type<int>(as_type<uint>(_e194) + as_type<uint>(1));
                    break;
                }
            }
            int _e197 = state;
            state = as_type<int>(as_type<uint>(_e197) + as_type<uint>(2));
        }
    }
    int _e203 = state;
    local_12 = static_cast<uint>(base + 10u);
    uint _e209 = local_12;
    output[_e209] = static_cast<uint>(_e203);
    counter = 0;
    int _e213 = counter;
    counter = as_type<int>(as_type<uint>(_e213) + as_type<uint>(1));
    int _e216 = state;
    state = as_type<int>(as_type<uint>(_e216) + as_type<uint>(2));
    switch(seed) {
        default: {
            int _e219 = state;
            state = as_type<int>(as_type<uint>(_e219) + as_type<uint>(3));
            break;
        }
    }
    int _e222 = counter;
    local_13 = static_cast<uint>(base + 11u);
    uint _e228 = local_13;
    output[_e228] = static_cast<uint>(_e222);
    int _e230 = state;
    local_14 = static_cast<uint>(base + 12u);
    uint _e236 = local_14;
    output[_e236] = static_cast<uint>(_e230);
    switch(seed) {
        case 0: {
            inner = as_type<int>(as_type<uint>(seed) + as_type<uint>(1));
            int _e241 = inner;
            switch(_e241) {
                default: {
                    int _e242 = inner;
                    int _e243 = state;
                    state = as_type<int>(as_type<uint>(_e243) + as_type<uint>(_e242));
                    break;
                }
            }
            break;
        }
        default: {
            int _e245 = state;
            state = as_type<int>(as_type<uint>(_e245) + as_type<uint>(4));
            break;
        }
    }
    int _e248 = state;
    local_15 = static_cast<uint>(base + 13u);
    uint _e254 = local_15;
    output[_e254] = static_cast<uint>(_e248);
    local_16 = static_cast<uint>(base + 14u);
    uint _e261 = local_16;
    output[_e261] = static_cast<uint>(seed);
    int _e263 = counter;
    local_17 = static_cast<uint>(base + 15u);
    uint _e269 = local_17;
    output[_e269] = static_cast<uint>(_e263);
}
