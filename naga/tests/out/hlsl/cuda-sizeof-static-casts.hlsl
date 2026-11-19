ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

int ZeroValueint() {
    return (int)0;
}

[numthreads(4, 1, 1)]
void sizeof_static_casts(uint3 threadIdx : SV_GroupThreadID)
{
    int counter = (int)0;
    int matrix_[2][3] = (int[2][3])0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint Short = (uint)0;
    uint Boolean = (uint)0;
    uint Alias = (uint)0;
    uint Wide = (uint)0;
    uint Real = (uint)0;
    uint Nested = (uint)0;
    uint Comma = (uint)0;
    uint SameType = (uint)0;
    uint Mixed = (uint)0;
    uint Row = (uint)0;
    uint InvalidRange = (uint)0;
    uint InvalidMath = (uint)0;
    uint Binding = (uint)0;
    uint Shift = (uint)0;
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
    counter = int(7);
    local = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e28 = local;
            local = (_e28 + 1u);
        }
        loop_init = false;
        uint _e13 = local;
        if ((_e13 >= 2u)) {
            break;
        }
        local_1 = 0u;
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                uint _e25 = local_1;
                local_1 = (_e25 + 1u);
            }
            loop_init_1 = false;
            uint _e20 = local_1;
            if ((_e20 >= 3u)) {
                break;
            }
            matrix_[min(uint(_e13), 1u)][min(uint(_e20), 2u)] = ZeroValueint();
        }
    }
    Short = 2u;
    Boolean = 1u;
    Alias = 4u;
    Wide = 8u;
    Real = 4u;
    Nested = 2u;
    Comma = 1u;
    SameType = 2u;
    Mixed = 4u;
    Row = 12u;
    InvalidRange = 4u;
    InvalidMath = 1u;
    Binding = 3u;
    Shift = 4u;
    uint _e59 = Short;
    output.Store(base*4, asuint(_e59));
    uint _e62 = Boolean;
    local_2 = uint((base + 1u));
    uint _e67 = local_2;
    output.Store(_e67*4, asuint(_e62));
    uint _e69 = Alias;
    local_3 = uint((base + 2u));
    uint _e74 = local_3;
    output.Store(_e74*4, asuint(_e69));
    uint _e76 = Wide;
    local_4 = uint((base + 3u));
    uint _e81 = local_4;
    output.Store(_e81*4, asuint(_e76));
    uint _e83 = Real;
    local_5 = uint((base + 4u));
    uint _e88 = local_5;
    output.Store(_e88*4, asuint(_e83));
    uint _e90 = Nested;
    local_6 = uint((base + 5u));
    uint _e95 = local_6;
    output.Store(_e95*4, asuint(_e90));
    uint _e97 = Comma;
    local_7 = uint((base + 6u));
    uint _e102 = local_7;
    output.Store(_e102*4, asuint(_e97));
    uint _e104 = SameType;
    local_8 = uint((base + 7u));
    uint _e109 = local_8;
    output.Store(_e109*4, asuint(_e104));
    uint _e111 = Mixed;
    local_9 = uint((base + 8u));
    uint _e116 = local_9;
    output.Store(_e116*4, asuint(_e111));
    uint _e118 = Row;
    local_10 = uint((base + 9u));
    uint _e123 = local_10;
    output.Store(_e123*4, asuint(_e118));
    uint _e125 = InvalidRange;
    local_11 = uint((base + 10u));
    uint _e130 = local_11;
    output.Store(_e130*4, asuint(_e125));
    uint _e132 = InvalidMath;
    local_12 = uint((base + 11u));
    uint _e137 = local_12;
    output.Store(_e137*4, asuint(_e132));
    uint _e139 = Binding;
    local_13 = uint((base + 12u));
    uint _e144 = local_13;
    output.Store(_e144*4, asuint(_e139));
    uint _e146 = Shift;
    local_14 = uint((base + 13u));
    uint _e151 = local_14;
    output.Store(_e151*4, asuint(_e146));
    int _e153 = counter;
    local_15 = uint((base + 14u));
    uint _e159 = local_15;
    output.Store(_e159*4, asuint(uint(_e153)));
    int _e162 = asint(input.Load(lane*4));
    local_16 = uint((base + 15u));
    uint _e168 = local_16;
    output.Store(_e168*4, asuint(uint(_e162)));
}
