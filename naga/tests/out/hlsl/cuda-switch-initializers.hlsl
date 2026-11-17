ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

[numthreads(4, 1, 1)]
void switch_initializers(uint3 threadIdx : SV_GroupThreadID)
{
    int state = (int)0;
    uint local = (uint)0;
    int bias = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    int key = (int)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    int key_1 = (int)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    int One = (int)0;
    uint local_11 = (uint)0;
    int pass_ = (int)0;
    int selected = (int)0;
    uint local_12 = (uint)0;
    int counter = (int)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    int inner = (int)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 16u));
    int seed = asint(input.Load(lane*4));
    state = asint(asuint(int(lane)) + asuint(int(1)));
    switch(seed) {
        case 0: {
            int _e13 = state;
            state = asint(asuint(_e13) + asuint(int(1)));
            break;
        }
        default: {
            int _e16 = state;
            state = asint(asuint(_e16) + asuint(int(2)));
            break;
        }
    }
    int _e19 = state;
    output.Store(base*4, asuint(uint(_e19)));
    int _e23 = state;
    state = asint(asuint(_e23) + asuint(int(1)));
    switch(seed) {
        case 0: {
            int _e26 = state;
            state = asint(asuint(_e26) + asuint(int(10)));
            break;
        }
        case 1: {
            int _e29 = state;
            state = asint(asuint(_e29) + asuint(int(20)));
            int _e32 = state;
            state = asint(asuint(_e32) + asuint(int(30)));
            break;
        }
        case 2: {
            int _e35 = state;
            state = asint(asuint(_e35) + asuint(int(30)));
            break;
        }
        default: {
            int _e38 = state;
            state = asint(asuint(_e38) + asuint(int(40)));
            break;
        }
    }
    int _e41 = state;
    local = uint((base + 1u));
    uint _e47 = local;
    output.Store(_e47*4, asuint(uint(_e41)));
    bias = int(5);
    switch(seed) {
        case 0: {
            int _e51 = bias;
            local_1 = uint((base + 2u));
            uint _e57 = local_1;
            local_18 = _e57;
            uint _e59 = local_18;
            output.Store(_e59*4, asuint(uint(_e51)));
            break;
        }
        case 1: {
            int _e61 = bias;
            local_2 = uint((base + 2u));
            uint _e68 = local_2;
            local_19 = _e68;
            uint _e70 = local_19;
            output.Store(_e70*4, asuint(uint(asint(asuint(_e61) + asuint(seed)))));
            break;
        }
        default: {
            int _e72 = bias;
            local_3 = uint((base + 2u));
            uint _e79 = local_3;
            local_20 = _e79;
            uint _e81 = local_20;
            output.Store(_e81*4, asuint(uint(asint(asuint(_e72) + asuint(seed)))));
            break;
        }
    }
    int key_2 = asint(asuint(seed) + asuint(int(1)));
    switch(key_2) {
        case 1: {
            int _e85 = state;
            state = asint(asuint(_e85) + asuint(int(3)));
            break;
        }
        default: {
            int _e88 = state;
            state = asint(asuint(_e88) + asuint(int(4)));
            break;
        }
    }
    int _e91 = state;
    local_4 = uint((base + 3u));
    uint _e97 = local_4;
    output.Store(_e97*4, asuint(uint(_e91)));
    int _e99 = state;
    do {
        int _e100 = state;
        state = asint(asuint(_e100) + asuint(int(7)));
    } while(false);
    int _e103 = state;
    local_5 = uint((base + 4u));
    uint _e109 = local_5;
    output.Store(_e109*4, asuint(uint(_e103)));
    key = int(99);
    switch(seed) {
        case 0: {
            local_6 = uint((base + 5u));
            uint _e120 = local_6;
            local_21 = _e120;
            uint _e122 = local_21;
            output.Store(_e122*4, asuint(uint(asint(asuint(seed) + asuint(int(10))))));
            break;
        }
        default: {
            local_7 = uint((base + 5u));
            uint _e131 = local_7;
            local_22 = _e131;
            uint _e133 = local_22;
            output.Store(_e133*4, asuint(uint(asint(asuint(seed) + asuint(int(20))))));
            break;
        }
    }
    int _e135 = key;
    local_8 = uint((base + 6u));
    uint _e141 = local_8;
    output.Store(_e141*4, asuint(uint(_e135)));
    do {
        {
            {
                key_1 = int(9);
                int _e145 = key_1;
                int _e146 = state;
                state = asint(asuint(_e146) + asuint(_e145));
            }
            local_9 = uint((base + 7u));
            uint _e155 = local_9;
            local_23 = _e155;
            uint _e157 = local_23;
            output.Store(_e157*4, asuint(uint(asint(asuint(seed) + asuint(int(30))))));
        }
    } while(false);
    int _e159 = state;
    local_10 = uint((base + 8u));
    uint _e165 = local_10;
    output.Store(_e165*4, asuint(uint(_e159)));
    One = int(1);
    switch(seed) {
        case 1: {
            int _e169 = state;
            state = asint(asuint(_e169) + asuint(int(1)));
            break;
        }
        default: {
            int _e172 = state;
            state = asint(asuint(_e172) + asuint(int(2)));
            break;
        }
    }
    int _e175 = state;
    local_11 = uint((base + 9u));
    uint _e181 = local_11;
    output.Store(_e181*4, asuint(uint(_e175)));
    {
        pass_ = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e200 = pass_;
                pass_ = asint(asuint(_e200) + asuint(int(1)));
            }
            loop_init = false;
            int _e185 = pass_;
            if ((_e185 < int(4))) {
            } else {
                break;
            }
            int _e188 = pass_;
            selected = _e188;
            int _e190 = selected;
            bool should_continue = false;
            switch(_e190) {
                case 1: {
                    should_continue = true;
                    break;
                }
                case 2: {
                    int _e191 = state;
                    state = asint(asuint(_e191) + asuint(int(10)));
                    break;
                }
                default: {
                    int _e194 = state;
                    state = asint(asuint(_e194) + asuint(int(1)));
                    break;
                }
            }
            if (should_continue) {
                continue;
            }
            int _e197 = state;
            state = asint(asuint(_e197) + asuint(int(2)));
        }
    }
    int _e203 = state;
    local_12 = uint((base + 10u));
    uint _e209 = local_12;
    output.Store(_e209*4, asuint(uint(_e203)));
    counter = int(0);
    int _e213 = counter;
    counter = asint(asuint(_e213) + asuint(int(1)));
    int _e216 = state;
    state = asint(asuint(_e216) + asuint(int(2)));
    do {
        int _e219 = state;
        state = asint(asuint(_e219) + asuint(int(3)));
    } while(false);
    int _e222 = counter;
    local_13 = uint((base + 11u));
    uint _e228 = local_13;
    output.Store(_e228*4, asuint(uint(_e222)));
    int _e230 = state;
    local_14 = uint((base + 12u));
    uint _e236 = local_14;
    output.Store(_e236*4, asuint(uint(_e230)));
    switch(seed) {
        case 0: {
            inner = asint(asuint(seed) + asuint(int(1)));
            int _e241 = inner;
            do {
                int _e242 = inner;
                int _e243 = state;
                state = asint(asuint(_e243) + asuint(_e242));
            } while(false);
            break;
        }
        default: {
            int _e245 = state;
            state = asint(asuint(_e245) + asuint(int(4)));
            break;
        }
    }
    int _e248 = state;
    local_15 = uint((base + 13u));
    uint _e254 = local_15;
    output.Store(_e254*4, asuint(uint(_e248)));
    local_16 = uint((base + 14u));
    uint _e261 = local_16;
    output.Store(_e261*4, asuint(uint(seed)));
    int _e263 = counter;
    local_17 = uint((base + 15u));
    uint _e269 = local_17;
    output.Store(_e269*4, asuint(uint(_e263)));
}
