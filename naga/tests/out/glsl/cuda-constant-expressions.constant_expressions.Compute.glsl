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
    int local_12 = 0;
    int local_13[3] = int[3](0, 0, 0);
    int total = 0;
    int i_1 = 0;
    runtime_1 = runtime;
    Size_1 = 3;
    local_13 = int[3](0, 0, 0);
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
            local_13[_e16] = (_e18 + _e19);
            int _e21 = i_1;
            int _e23 = local_13[_e21];
            int _e24 = total;
            total = (_e24 + _e23);
        }
    }
    int _e26 = total;
    return _e26;
}

void main() {
    int Chosen = 0;
    int local = 0;
    int Size = 0;
    int values[5] = int[5](0, 0, 0, 0, 0);
    int SignedHigh = 0;
    uint local_1 = 0u;
    int Negative = 0;
    uint local_2 = 0u;
    uint All = 0u;
    uint Wrapped = 0u;
    uint local_3 = 0u;
    uint TruncatedZero = 0u;
    int Minimum = 0;
    uint Large = 0u;
    bool Ready = false;
    int Comma = 0;
    int Lazy = 0;
    int local_4 = 0;
    bool Skipped = false;
    bool local_5 = false;
    bool Yes = false;
    bool local_6 = false;
    int VectorCount = 0;
    float3_ vectors[2] = float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
    int Base[2] = int[2](0, 0);
    uint local_7 = 0u;
    int i = 0;
    int Count = 0;
    int scratch[3] = int[3](0, 0, 0);
    uint local_8 = 0u;
    int Safe = 0;
    int local_9 = 0;
    uint local_10 = 0u;
    uint local_11 = 0u;
    int runtime_2 = _group_0_binding_0_cs[uint(0)];
    Chosen = 3;
    Size = 4;
    values = int[5](0, 0, 0, 0, 0);
    values[0] = runtime_2;
    int _e16 = _group_0_binding_0_cs[uint(1)];
    int _e17 = Size;
    values[_e17] = _e16;
    _group_0_binding_1_cs[uint(0)] = uint(Base_1);
    _group_0_binding_1_cs[uint(1)] = High;
    _group_0_binding_1_cs[uint(2)] = floatBitsToUint(Scale);
    int _e34 = Chosen;
    _group_0_binding_1_cs[uint(3)] = uint(_e34);
    int _e39 = accumulate(runtime_2);
    _group_0_binding_1_cs[uint(4)] = uint(_e39);
    int _e44 = Size;
    int _e46 = values[_e44];
    _group_0_binding_1_cs[uint(5)] = uint(_e46);
    int _e53 = values[1];
    _group_0_binding_1_cs[uint(6)] = uint(_e53);
    _group_0_binding_1_cs[uint(7)] = uint((float(runtime_2) * Scale));
    SignedHigh = -2147483648;
    Negative = -2;
    All = 4294967295u;
    Wrapped = 0u;
    int _e73 = SignedHigh;
    _group_0_binding_1_cs[uint(8)] = uint(_e73);
    int _e78 = Negative;
    _group_0_binding_1_cs[uint(9)] = uint(_e78);
    uint _e83 = All;
    _group_0_binding_1_cs[uint(10)] = _e83;
    uint _e87 = Wrapped;
    _group_0_binding_1_cs[uint(11)] = _e87;
    TruncatedZero = 0u;
    Minimum = -2147483648;
    Large = 4294967040u;
    Ready = true;
    uint _e99 = TruncatedZero;
    _group_0_binding_1_cs[uint(12)] = _e99;
    int _e103 = Minimum;
    _group_0_binding_1_cs[uint(13)] = uint(_e103);
    uint _e108 = Large;
    _group_0_binding_1_cs[uint(14)] = _e108;
    bool _e112 = Ready;
    _group_0_binding_1_cs[uint(15)] = uint(_e112);
    Comma = 4;
    Lazy = 6;
    int _e121 = Comma;
    _group_0_binding_1_cs[uint(16)] = uint(_e121);
    int _e126 = Lazy;
    _group_0_binding_1_cs[uint(17)] = uint(_e126);
    _group_0_binding_1_cs[uint(18)] = uint(runtime_2);
    Skipped = false;
    Yes = true;
    bool _e139 = Skipped;
    _group_0_binding_1_cs[uint(19)] = uint(_e139);
    bool _e144 = Yes;
    _group_0_binding_1_cs[uint(20)] = uint(_e144);
    _group_0_binding_1_cs[uint(21)] = uint(runtime_2);
    VectorCount = 2;
    vectors = float3_[2](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
    int _e160 = _group_0_binding_0_cs[uint(1)];
    vectors[1].y = float(_e160);
    float _e168 = vectors[1].y;
    _group_0_binding_1_cs[uint(22)] = uint(_e168);
    {
        Base = int[2](0, 0);
        int _e177 = Base[1];
        local_7 = uint(23);
        uint _e182 = local_7;
        local_10 = _e182;
        uint _e184 = local_10;
        _group_0_binding_1_cs[_e184] = uint(_e177);
    }
    {
        i = 0;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                int _e212 = i;
                i = (_e212 + 1);
            }
            loop_init_1 = false;
            int _e188 = i;
            if ((_e188 < 3)) {
            } else {
                break;
            }
            Count = 3;
            scratch = int[3](0, 0, 0);
            int _e197 = scratch[2];
            int _e199 = i;
            local_8 = uint((24 + _e199));
            uint _e204 = local_8;
            local_11 = _e204;
            uint _e206 = local_11;
            _group_0_binding_1_cs[_e206] = uint(_e197);
            int _e208 = i;
            scratch[2] = (runtime_2 + _e208);
        }
    }
    int _e218 = _group_0_binding_0_cs[uint(1)];
    int _e219 = accumulate(_e218);
    _group_0_binding_1_cs[uint(27)] = uint(_e219);
    _group_0_binding_1_cs[uint(28)] = uint(Second);
    Safe = 3;
    int _e234 = _group_0_binding_0_cs[uint(1)];
    int _e236 = Safe;
    _group_0_binding_1_cs[uint(29)] = uint((((runtime_2 + _e234) + _e236) - 3));
}

