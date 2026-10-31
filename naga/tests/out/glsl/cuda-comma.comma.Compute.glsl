#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { int _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_2Compute { type_3 _group_0_binding_2_cs; };


void consume(int value_1) {
    if ((value_1 < 0)) {
        return;
    } else {
        return;
    }
}

int pair_add(int left_1, int right_1) {
    return (left_1 + right_1);
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint base = 0u;
    int value = 0;
    uint local = 0u;
    bool choose = false;
    int x = 0;
    int sequenced = 0;
    uint local_1 = 0u;
    uint local_2 = 0u;
    int target = 0;
    uint local_3 = 0u;
    int rhs = 0;
    uint local_4 = 0u;
    int middle = 0;
    int selected = 0;
    int local_5 = 0;
    uint local_6 = 0u;
    int left = 0;
    int right = 0;
    uint local_7 = 0u;
    int identity = 0;
    uint local_8 = 0u;
    uint position = 0u;
    uint local_9 = 0u;
    int effect = 0;
    uint local_10 = 0u;
    int total = 0;
    int iteration = 0;
    int current = 0;
    uint local_11 = 0u;
    int ticks = 0;
    int passes = 0;
    uint local_12 = 0u;
    int argument = 0;
    int first = 0;
    int second = 0;
    uint local_13 = 0u;
    int local_14 = 0;
    uint local_15 = 0u;
    int local_16 = 0;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        local = i;
        uint _e15 = local;
        local_15 = _e15;
        uint _e17 = local_15;
        int _e20 = _group_0_binding_1_cs[_e17];
        local_16 = _e20;
        int _e22 = local_16;
        local_14 = _e22;
        int _e24 = local_14;
        value = _e24;
        choose = ((i - 2u * (i / 2u)) == 0u);
        int _e31 = value;
        x = _e31;
        int _e33 = x;
        x = (_e33 + 2);
        int _e36 = x;
        x = (_e36 * 3);
        int _e39 = x;
        sequenced = (_e39 - 1);
        int _e43 = sequenced;
        uint _e44 = base;
        local_1 = _e44;
        uint _e46 = local_1;
        local_17 = _e46;
        uint _e48 = local_17;
        _group_0_binding_0_cs[_e48] = _e43;
        int _e51 = x;
        uint _e52 = base;
        local_2 = uint((_e52 + 1u));
        uint _e57 = local_2;
        local_18 = _e57;
        uint _e59 = local_18;
        _group_0_binding_0_cs[_e59] = _e51;
        target = 0;
        int _e63 = value;
        target = _e63;
        int _e64 = target;
        target = (_e64 + 4);
        int _e67 = target;
        uint _e68 = base;
        local_3 = uint((_e68 + 2u));
        uint _e73 = local_3;
        local_19 = _e73;
        uint _e75 = local_19;
        _group_0_binding_0_cs[_e75] = _e67;
        int _e77 = value;
        target = (_e77 + 1);
        int _e80 = target;
        rhs = (_e80 + 3);
        int _e84 = rhs;
        int _e87 = target;
        uint _e89 = base;
        local_4 = uint((_e89 + 3u));
        uint _e94 = local_4;
        local_20 = _e94;
        uint _e96 = local_20;
        _group_0_binding_0_cs[_e96] = ((_e84 * 10) + _e87);
        middle = 0;
        bool _e100 = choose;
        if (_e100) {
            int _e101 = value;
            middle = (_e101 + 2);
            int _e104 = middle;
            local_5 = (_e104 + 3);
        } else {
            int _e108 = value;
            local_5 = (_e108 - 2);
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
        _group_0_binding_0_cs[_e127] = ((_e115 * 10) + _e118);
        int _e129 = value;
        left = _e129;
        int _e131 = value;
        right = (_e131 + 10);
        int _e135 = value;
        consume(_e135);
        bool _e136 = choose;
        if (_e136) {
            int _e137 = left;
            left = (_e137 + 3);
        } else {
            int _e140 = right;
            right = (_e140 + 3);
        }
        int _e143 = left;
        int _e146 = right;
        uint _e148 = base;
        local_7 = uint((_e148 + 5u));
        uint _e153 = local_7;
        local_22 = _e153;
        uint _e155 = local_22;
        _group_0_binding_0_cs[_e155] = ((_e143 * 100) + _e146);
        int _e157 = value;
        identity = _e157;
        int _e159 = identity;
        identity = (_e159 + 1);
        consume(_e159);
        int _e162 = identity;
        identity = (_e162 + 1);
        int _e165 = identity;
        uint _e166 = base;
        local_8 = uint((_e166 + 6u));
        uint _e171 = local_8;
        local_23 = _e171;
        uint _e173 = local_23;
        _group_0_binding_0_cs[_e173] = _e165;
        uint _e175 = base;
        position = (_e175 + 4u);
        uint _e179 = position;
        position = (_e179 + 2u);
        int _e182 = value;
        uint _e187 = position;
        position = (_e187 + uint(1));
        uint _e191 = position;
        local_9 = _e191;
        uint _e193 = local_9;
        local_24 = _e193;
        uint _e195 = local_24;
        _group_0_binding_0_cs[_e195] = ((_e182 * 2) + 2);
        int _e197 = value;
        effect = _e197;
        int _e199 = effect;
        effect = (_e199 + 1);
        consume(_e199);
        int _e202 = effect;
        effect = (_e202 + 1);
        consume(_e202);
        int _e205 = effect;
        effect = (_e205 + 1);
        consume(_e205);
        int _e208 = effect;
        effect = (_e208 + 1);
        consume(_e208);
        int _e211 = effect;
        uint _e212 = base;
        local_10 = uint((_e212 + 8u));
        uint _e217 = local_10;
        local_25 = _e217;
        uint _e219 = local_25;
        _group_0_binding_0_cs[_e219] = _e211;
        total = 0;
        {
            iteration = 0;
            int _e225 = value;
            current = _e225;
            bool loop_init = true;
            while(true) {
                if (!loop_init) {
                    int _e236 = iteration;
                    iteration = (_e236 + 1);
                    int _e239 = current;
                    current = (_e239 + 2);
                }
                loop_init = false;
                int _e227 = iteration;
                if ((_e227 < 4)) {
                } else {
                    break;
                }
                int _e230 = iteration;
                if ((_e230 != 1)) {
                    int _e233 = current;
                    int _e234 = total;
                    total = (_e234 + _e233);
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
        _group_0_binding_0_cs[_e250] = _e242;
        int _e252 = value;
        ticks = _e252;
        passes = 0;
        {
            int _e256 = value;
            ticks = (_e256 + 1);
            passes = 0;
            bool loop_init_1 = true;
            while(true) {
                if (!loop_init_1) {
                    int _e266 = ticks;
                    ticks = (_e266 + 2);
                }
                loop_init_1 = false;
                int _e260 = passes;
                passes = (_e260 + 1);
                int _e263 = passes;
                if ((_e263 < 4)) {
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
        _group_0_binding_0_cs[_e281] = ((_e269 * 10) + _e272);
        int _e283 = value;
        argument = _e283;
        int _e285 = argument;
        argument = (_e285 + 1);
        int _e288 = argument;
        int _e290 = pair_add(_e288, 2);
        first = _e290;
        int _e292 = first;
        int _e294 = pair_add(_e292, 3);
        second = _e294;
        int _e296 = second;
        int _e299 = argument;
        uint _e301 = base;
        local_13 = uint((_e301 + 11u));
        uint _e306 = local_13;
        local_28 = _e306;
        uint _e308 = local_28;
        _group_0_binding_0_cs[_e308] = ((_e296 * 10) + _e299);
    }
}

