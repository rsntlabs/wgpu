struct Record_cuda_record_0_ {
    int first;
    uint second;
    float third;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

int ZeroValueint() {
    return (int)0;
}

Record_cuda_record_0_ ZeroValueRecord_cuda_record_0_() {
    return (Record_cuda_record_0_)0;
}

[numthreads(4, 1, 1)]
void sizeof_comma(uint3 threadIdx : SV_GroupThreadID)
{
    int counter = (int)0;
    int matrix_[2][3] = (int[2][3])0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    Record_cuda_record_0_ record = (Record_cuda_record_0_)0;
    uint Scalar = (uint)0;
    uint Boolean = (uint)0;
    uint Array = (uint)0;
    uint Row = (uint)0;
    uint Element = (uint)0;
    uint Member = (uint)0;
    uint Pointer = (uint)0;
    uint Null = (uint)0;
    uint Middle = (uint)0;
    uint Outer = (uint)0;
    uint Nested = (uint)0;
    uint NoRead = (uint)0;
    uint InvalidMath = (uint)0;
    uint NullArm = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 16u));
    int seed = asint(input.Load(lane*4));
    bool flag = (seed != int(0));
    counter = int(7);
    local = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e30 = local;
            local = (_e30 + 1u);
        }
        loop_init = false;
        uint _e15 = local;
        if ((_e15 >= 2u)) {
            break;
        }
        local_1 = 0u;
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                uint _e27 = local_1;
                local_1 = (_e27 + 1u);
            }
            loop_init_1 = false;
            uint _e22 = local_1;
            if ((_e22 >= 3u)) {
                break;
            }
            matrix_[min(uint(_e15), 1u)][min(uint(_e22), 2u)] = ZeroValueint();
        }
    }
    record = ZeroValueRecord_cuda_record_0_();
    Scalar = 4u;
    Boolean = 1u;
    Array = 24u;
    Row = 12u;
    Element = 4u;
    Member = 4u;
    Pointer = 8u;
    Null = 8u;
    Middle = 1u;
    Outer = 1u;
    Nested = 1u;
    NoRead = 4u;
    InvalidMath = 1u;
    NullArm = 8u;
    uint _e63 = Scalar;
    output.Store(base*4, asuint(_e63));
    uint _e66 = Boolean;
    local_2 = uint((base + 1u));
    uint _e71 = local_2;
    output.Store(_e71*4, asuint(_e66));
    uint _e73 = Array;
    local_3 = uint((base + 2u));
    uint _e78 = local_3;
    output.Store(_e78*4, asuint(_e73));
    uint _e80 = Row;
    local_4 = uint((base + 3u));
    uint _e85 = local_4;
    output.Store(_e85*4, asuint(_e80));
    uint _e87 = Element;
    local_5 = uint((base + 4u));
    uint _e92 = local_5;
    output.Store(_e92*4, asuint(_e87));
    uint _e94 = Member;
    local_6 = uint((base + 5u));
    uint _e99 = local_6;
    output.Store(_e99*4, asuint(_e94));
    uint _e101 = Pointer;
    local_7 = uint((base + 6u));
    uint _e106 = local_7;
    output.Store(_e106*4, asuint(_e101));
    uint _e108 = Null;
    local_8 = uint((base + 7u));
    uint _e113 = local_8;
    output.Store(_e113*4, asuint(_e108));
    uint _e115 = Middle;
    local_9 = uint((base + 8u));
    uint _e120 = local_9;
    output.Store(_e120*4, asuint(_e115));
    uint _e122 = Outer;
    local_10 = uint((base + 9u));
    uint _e127 = local_10;
    output.Store(_e127*4, asuint(_e122));
    uint _e129 = Nested;
    local_11 = uint((base + 10u));
    uint _e134 = local_11;
    output.Store(_e134*4, asuint(_e129));
    uint _e136 = NoRead;
    local_12 = uint((base + 11u));
    uint _e141 = local_12;
    output.Store(_e141*4, asuint(_e136));
    uint _e143 = InvalidMath;
    local_13 = uint((base + 12u));
    uint _e148 = local_13;
    output.Store(_e148*4, asuint(_e143));
    uint _e150 = NullArm;
    local_14 = uint((base + 13u));
    uint _e155 = local_14;
    output.Store(_e155*4, asuint(_e150));
    int _e157 = counter;
    local_15 = uint((base + 14u));
    uint _e163 = local_15;
    output.Store(_e163*4, asuint(uint(_e157)));
    int _e166 = asint(input.Load(lane*4));
    local_16 = uint((base + 15u));
    uint _e172 = local_16;
    output.Store(_e172*4, asuint(uint(_e166)));
}
