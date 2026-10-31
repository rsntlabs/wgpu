struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer n : register(b2) { type_3 n; }

void consume(int value_1)
{
    if ((value_1 < int(0))) {
        return;
    } else {
        return;
    }
}

int pair_add(int left_1, int right_1)
{
    return asint(asuint(left_1) + asuint(right_1));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

[numthreads(64, 1, 1)]
void comma(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint base = (uint)0;
    int value = (int)0;
    uint local = (uint)0;
    bool choose = (bool)0;
    int x = (int)0;
    int sequenced = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int target = (int)0;
    uint local_3 = (uint)0;
    int rhs = (int)0;
    uint local_4 = (uint)0;
    int middle = (int)0;
    int selected = (int)0;
    int local_5 = (int)0;
    uint local_6 = (uint)0;
    int left = (int)0;
    int right = (int)0;
    uint local_7 = (uint)0;
    int identity = (int)0;
    uint local_8 = (uint)0;
    uint position = (uint)0;
    uint local_9 = (uint)0;
    int effect = (int)0;
    uint local_10 = (uint)0;
    int total = (int)0;
    int iteration = (int)0;
    int current = (int)0;
    uint local_11 = (uint)0;
    int ticks = (int)0;
    int passes = (int)0;
    uint local_12 = (uint)0;
    int argument = (int)0;
    int first = (int)0;
    int second = (int)0;
    uint local_13 = (uint)0;
    int local_14 = (int)0;
    uint local_15 = (uint)0;
    int local_16 = (int)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;

    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        local = i;
        uint _e15 = local;
        local_15 = _e15;
        uint _e17 = local_15;
        int _e20 = asint(input.Load(_e17*4));
        local_16 = _e20;
        int _e22 = local_16;
        local_14 = _e22;
        int _e24 = local_14;
        value = _e24;
        choose = (naga_mod(i, 2u) == 0u);
        int _e31 = value;
        x = _e31;
        int _e33 = x;
        x = asint(asuint(_e33) + asuint(int(2)));
        int _e36 = x;
        x = asint(asuint(_e36) * asuint(int(3)));
        int _e39 = x;
        sequenced = asint(asuint(_e39) - asuint(int(1)));
        int _e43 = sequenced;
        uint _e44 = base;
        local_1 = _e44;
        uint _e46 = local_1;
        local_17 = _e46;
        uint _e48 = local_17;
        out_.Store(_e48*4, asuint(_e43));
        int _e51 = x;
        uint _e52 = base;
        local_2 = uint((_e52 + 1u));
        uint _e57 = local_2;
        local_18 = _e57;
        uint _e59 = local_18;
        out_.Store(_e59*4, asuint(_e51));
        target = int(0);
        int _e63 = value;
        target = _e63;
        int _e64 = target;
        target = asint(asuint(_e64) + asuint(int(4)));
        int _e67 = target;
        uint _e68 = base;
        local_3 = uint((_e68 + 2u));
        uint _e73 = local_3;
        local_19 = _e73;
        uint _e75 = local_19;
        out_.Store(_e75*4, asuint(_e67));
        int _e77 = value;
        target = asint(asuint(_e77) + asuint(int(1)));
        int _e80 = target;
        rhs = asint(asuint(_e80) + asuint(int(3)));
        int _e84 = rhs;
        int _e87 = target;
        uint _e89 = base;
        local_4 = uint((_e89 + 3u));
        uint _e94 = local_4;
        local_20 = _e94;
        uint _e96 = local_20;
        out_.Store(_e96*4, asuint(asint(asuint(asint(asuint(_e84) * asuint(int(10)))) + asuint(_e87))));
        middle = int(0);
        bool _e100 = choose;
        if (_e100) {
            int _e101 = value;
            middle = asint(asuint(_e101) + asuint(int(2)));
            int _e104 = middle;
            local_5 = asint(asuint(_e104) + asuint(int(3)));
        } else {
            int _e108 = value;
            local_5 = asint(asuint(_e108) - asuint(int(2)));
        }
        int _e113 = local_5;
        selected = _e113;
        int _e115 = selected;
        int _e118 = middle;
        uint _e120 = base;
        local_6 = uint((_e120 + 4u));
        uint _e125 = local_6;
        local_21 = _e125;
        uint _e127 = local_21;
        out_.Store(_e127*4, asuint(asint(asuint(asint(asuint(_e115) * asuint(int(10)))) + asuint(_e118))));
        int _e129 = value;
        left = _e129;
        int _e131 = value;
        right = asint(asuint(_e131) + asuint(int(10)));
        int _e135 = value;
        consume(_e135);
        bool _e136 = choose;
        if (_e136) {
            int _e137 = left;
            left = asint(asuint(_e137) + asuint(int(3)));
        } else {
            int _e140 = right;
            right = asint(asuint(_e140) + asuint(int(3)));
        }
        int _e143 = left;
        int _e146 = right;
        uint _e148 = base;
        local_7 = uint((_e148 + 5u));
        uint _e153 = local_7;
        local_22 = _e153;
        uint _e155 = local_22;
        out_.Store(_e155*4, asuint(asint(asuint(asint(asuint(_e143) * asuint(int(100)))) + asuint(_e146))));
        int _e157 = value;
        identity = _e157;
        int _e159 = identity;
        identity = asint(asuint(_e159) + asuint(int(1)));
        consume(_e159);
        int _e162 = identity;
        identity = asint(asuint(_e162) + asuint(int(1)));
        int _e165 = identity;
        uint _e166 = base;
        local_8 = uint((_e166 + 6u));
        uint _e171 = local_8;
        local_23 = _e171;
        uint _e173 = local_23;
        out_.Store(_e173*4, asuint(_e165));
        uint _e175 = base;
        position = (_e175 + 4u);
        uint _e179 = position;
        position = (_e179 + 2u);
        int _e182 = value;
        uint _e187 = position;
        position = (_e187 + uint(int(1)));
        uint _e191 = position;
        local_9 = _e191;
        uint _e193 = local_9;
        local_24 = _e193;
        uint _e195 = local_24;
        out_.Store(_e195*4, asuint(asint(asuint(asint(asuint(_e182) * asuint(int(2)))) + asuint(int(2)))));
        int _e197 = value;
        effect = _e197;
        int _e199 = effect;
        effect = asint(asuint(_e199) + asuint(int(1)));
        consume(_e199);
        int _e202 = effect;
        effect = asint(asuint(_e202) + asuint(int(1)));
        consume(_e202);
        int _e205 = effect;
        effect = asint(asuint(_e205) + asuint(int(1)));
        consume(_e205);
        int _e208 = effect;
        effect = asint(asuint(_e208) + asuint(int(1)));
        consume(_e208);
        int _e211 = effect;
        uint _e212 = base;
        local_10 = uint((_e212 + 8u));
        uint _e217 = local_10;
        local_25 = _e217;
        uint _e219 = local_25;
        out_.Store(_e219*4, asuint(_e211));
        total = int(0);
        {
            iteration = int(0);
            int _e225 = value;
            current = _e225;
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e236 = iteration;
                    iteration = asint(asuint(_e236) + asuint(int(1)));
                    int _e239 = current;
                    current = asint(asuint(_e239) + asuint(int(2)));
                }
                loop_init = false;
                int _e227 = iteration;
                if ((_e227 < int(4))) {
                } else {
                    break;
                }
                int _e230 = iteration;
                if ((_e230 != int(1))) {
                    int _e233 = current;
                    int _e234 = total;
                    total = asint(asuint(_e234) + asuint(_e233));
                } else {
                    continue;
                }
            }
        }
        int _e242 = total;
        uint _e243 = base;
        local_11 = uint((_e243 + 9u));
        uint _e248 = local_11;
        local_26 = _e248;
        uint _e250 = local_26;
        out_.Store(_e250*4, asuint(_e242));
        int _e252 = value;
        ticks = _e252;
        passes = int(0);
        {
            int _e256 = value;
            ticks = asint(asuint(_e256) + asuint(int(1)));
            passes = int(0);
            uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e266 = ticks;
                    ticks = asint(asuint(_e266) + asuint(int(2)));
                }
                loop_init_1 = false;
                int _e260 = passes;
                passes = asint(asuint(_e260) + asuint(int(1)));
                int _e263 = passes;
                if ((_e263 < int(4))) {
                } else {
                    break;
                }
            }
        }
        int _e269 = ticks;
        int _e272 = passes;
        uint _e274 = base;
        local_12 = uint((_e274 + 10u));
        uint _e279 = local_12;
        local_27 = _e279;
        uint _e281 = local_27;
        out_.Store(_e281*4, asuint(asint(asuint(asint(asuint(_e269) * asuint(int(10)))) + asuint(_e272))));
        int _e283 = value;
        argument = _e283;
        int _e285 = argument;
        argument = asint(asuint(_e285) + asuint(int(1)));
        int _e288 = argument;
        const int _e290 = pair_add(_e288, int(2));
        first = _e290;
        int _e292 = first;
        const int _e294 = pair_add(_e292, int(3));
        second = _e294;
        int _e296 = second;
        int _e299 = argument;
        uint _e301 = base;
        local_13 = uint((_e301 + 11u));
        uint _e306 = local_13;
        local_28 = _e306;
        uint _e308 = local_28;
        out_.Store(_e308*4, asuint(asint(asuint(asint(asuint(_e296) * asuint(int(10)))) + asuint(_e299))));
    }
}
