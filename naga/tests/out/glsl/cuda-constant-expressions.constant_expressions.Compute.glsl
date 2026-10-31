#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct float3_ {
    float x;
    float y;
    float z;
};
const int Base_1 = 2;
const uint High = 2147483648u;
const float Scale = 0.5;
const int Second = 3;
const int After = 4;

layout(std430) readonly buffer type_4_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std430) buffer type_5_block_1Compute { uint _group_0_binding_1_cs[]; };


int accumulate(int runtime) {
    int runtime_1 = 0;
    int Size_1 = 0;
    int local_43 = 0;
    int local_44[3] = int[3](0, 0, 0);
    int total = 0;
    int i_1 = 0;
    runtime_1 = runtime;
    Size_1 = 3;
    local_44 = int[3](0, 0, 0);
    total = 0;
    {
        i_1 = 0;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                int _e13 = i_1;
                i_1 = (_e13 + 1);
            }
            loop_init = false;
            int _e10 = i_1;
            int _e11 = Size_1;
            if ((_e10 < _e11)) {
            } else {
                break;
            }
            int _e18 = runtime_1;
            int _e19 = i_1;
            int _e16 = i_1;
            local_44[_e16] = (_e18 + _e19);
            int _e21 = i_1;
            int _e23 = local_44[_e21];
            int _e24 = total;
            total = (_e24 + _e23);
        }
    }
    int _e26 = total;
    return _e26;
}

void main() {
    uint local = 0u;
    int Chosen = 0;
    int local_1 = 0;
    int Size = 0;
    int values[5] = int[5](0, 0, 0, 0, 0);
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    int SignedHigh = 0;
    uint local_11 = 0u;
    int Negative = 0;
    uint local_12 = 0u;
    uint All = 0u;
    uint Wrapped = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint TruncatedZero = 0u;
    int Minimum = 0;
    uint Large = 0u;
    bool Ready = false;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    int Comma = 0;
    int Lazy = 0;
    int local_22 = 0;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    bool Skipped = false;
    bool local_26 = false;
    bool Yes = false;
    bool local_27 = false;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    int VectorCount = 0;
    float3_ vectors[2] = float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
    uint local_31 = 0u;
    uint local_32 = 0u;
    int Base[2] = int[2](0, 0);
    uint local_33 = 0u;
    int i = 0;
    int Count = 0;
    int scratch[3] = int[3](0, 0, 0);
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    uint local_37 = 0u;
    int Safe = 0;
    int local_38 = 0;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
    local = uint(0);
    uint _e3 = local;
    int runtime_2 = _group_0_binding_0_cs[_e3];
    Chosen = 3;
    Size = 4;
    values = int[5](0, 0, 0, 0, 0);
    values[0] = runtime_2;
    local_2 = uint(1);
    uint _e18 = local_2;
    int _e20 = _group_0_binding_0_cs[_e18];
    int _e21 = Size;
    values[_e21] = _e20;
    local_3 = uint(0);
    uint _e28 = local_3;
    _group_0_binding_1_cs[_e28] = uint(Base_1);
    local_4 = uint(1);
    uint _e34 = local_4;
    _group_0_binding_1_cs[_e34] = High;
    local_5 = uint(2);
    uint _e42 = local_5;
    _group_0_binding_1_cs[_e42] = floatBitsToUint(Scale);
    int _e44 = Chosen;
    local_6 = uint(3);
    uint _e49 = local_6;
    _group_0_binding_1_cs[_e49] = uint(_e44);
    int _e51 = accumulate(runtime_2);
    local_7 = uint(4);
    uint _e56 = local_7;
    _group_0_binding_1_cs[_e56] = uint(_e51);
    int _e58 = Size;
    int _e60 = values[_e58];
    local_8 = uint(5);
    uint _e65 = local_8;
    _group_0_binding_1_cs[_e65] = uint(_e60);
    int _e69 = values[1];
    local_9 = uint(6);
    uint _e74 = local_9;
    _group_0_binding_1_cs[_e74] = uint(_e69);
    local_10 = uint(7);
    uint _e83 = local_10;
    _group_0_binding_1_cs[_e83] = uint((float(runtime_2) * Scale));
    SignedHigh = -2147483648;
    Negative = -2;
    All = 4294967295u;
    Wrapped = 0u;
    int _e93 = SignedHigh;
    local_14 = uint(8);
    uint _e98 = local_14;
    _group_0_binding_1_cs[_e98] = uint(_e93);
    int _e100 = Negative;
    local_15 = uint(9);
    uint _e105 = local_15;
    _group_0_binding_1_cs[_e105] = uint(_e100);
    uint _e107 = All;
    local_16 = uint(10);
    uint _e111 = local_16;
    _group_0_binding_1_cs[_e111] = _e107;
    uint _e113 = Wrapped;
    local_17 = uint(11);
    uint _e117 = local_17;
    _group_0_binding_1_cs[_e117] = _e113;
    TruncatedZero = 0u;
    Minimum = -2147483648;
    Large = 4294967040u;
    Ready = true;
    uint _e127 = TruncatedZero;
    local_18 = uint(12);
    uint _e131 = local_18;
    _group_0_binding_1_cs[_e131] = _e127;
    int _e133 = Minimum;
    local_19 = uint(13);
    uint _e138 = local_19;
    _group_0_binding_1_cs[_e138] = uint(_e133);
    uint _e140 = Large;
    local_20 = uint(14);
    uint _e144 = local_20;
    _group_0_binding_1_cs[_e144] = _e140;
    bool _e146 = Ready;
    local_21 = uint(15);
    uint _e151 = local_21;
    _group_0_binding_1_cs[_e151] = uint(_e146);
    Comma = 4;
    Lazy = 6;
    int _e157 = Comma;
    local_23 = uint(16);
    uint _e162 = local_23;
    _group_0_binding_1_cs[_e162] = uint(_e157);
    int _e164 = Lazy;
    local_24 = uint(17);
    uint _e169 = local_24;
    _group_0_binding_1_cs[_e169] = uint(_e164);
    local_25 = uint(18);
    uint _e175 = local_25;
    _group_0_binding_1_cs[_e175] = uint(runtime_2);
    Skipped = false;
    Yes = true;
    bool _e181 = Skipped;
    local_28 = uint(19);
    uint _e186 = local_28;
    _group_0_binding_1_cs[_e186] = uint(_e181);
    bool _e188 = Yes;
    local_29 = uint(20);
    uint _e193 = local_29;
    _group_0_binding_1_cs[_e193] = uint(_e188);
    local_30 = uint(21);
    uint _e199 = local_30;
    _group_0_binding_1_cs[_e199] = uint(runtime_2);
    VectorCount = 2;
    vectors = float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
    local_31 = uint(1);
    uint _e208 = local_31;
    int _e210 = _group_0_binding_0_cs[_e208];
    vectors[1].y = float(_e210);
    float _e218 = vectors[1].y;
    local_32 = uint(22);
    uint _e223 = local_32;
    _group_0_binding_1_cs[_e223] = uint(_e218);
    {
        Base = int[2](0, 0);
        int _e229 = Base[1];
        local_33 = uint(23);
        uint _e234 = local_33;
        local_41 = _e234;
        uint _e236 = local_41;
        _group_0_binding_1_cs[_e236] = uint(_e229);
    }
    {
        i = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e264 = i;
                i = (_e264 + 1);
            }
            loop_init_1 = false;
            int _e240 = i;
            if ((_e240 < 3)) {
            } else {
                break;
            }
            Count = 3;
            scratch = int[3](0, 0, 0);
            int _e249 = scratch[2];
            int _e251 = i;
            local_34 = uint((24 + _e251));
            uint _e256 = local_34;
            local_42 = _e256;
            uint _e258 = local_42;
            _group_0_binding_1_cs[_e258] = uint(_e249);
            int _e260 = i;
            scratch[2] = (runtime_2 + _e260);
        }
    }
    local_36 = uint(1);
    uint _e270 = local_36;
    int _e272 = _group_0_binding_0_cs[_e270];
    int _e273 = accumulate(_e272);
    local_35 = uint(27);
    uint _e278 = local_35;
    _group_0_binding_1_cs[_e278] = uint(_e273);
    local_37 = uint(28);
    uint _e285 = local_37;
    _group_0_binding_1_cs[_e285] = uint(Second);
    Safe = 3;
    local_40 = uint(1);
    uint _e292 = local_40;
    int _e294 = _group_0_binding_0_cs[_e292];
    int _e296 = Safe;
    local_39 = uint(29);
    uint _e304 = local_39;
    _group_0_binding_1_cs[_e304] = uint((((runtime_2 + _e294) + _e296) - 3));
}

