ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

int ZeroValueint() {
    return (int)0;
}

[numthreads(4, 1, 1)]
void sizeof_conditionals(uint3 threadIdx : SV_GroupThreadID)
{
    int small = (int)0;
    int other = (int)0;
    bool unknown = (bool)0;
    int cursor = (int)0;
    int grid[2][3] = (int[2][3])0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint SameType = (uint)0;
    uint Boolean = (uint)0;
    uint Promoted = (uint)0;
    uint BoolInt = (uint)0;
    uint Real = (uint)0;
    uint NestedMiddle = (uint)0;
    uint NestedFinal = (uint)0;
    uint Grouped = (uint)0;
    uint Logical = (uint)0;
    uint Row = (uint)0;
    uint Element = (uint)0;
    uint InvalidDivide = (uint)0;
    uint InvalidShift = (uint)0;
    uint Reference = (uint)0;
    uint Storage = (uint)0;
    uint UnaryBinding = (uint)0;
    uint local_2 = (uint)0;
    uint AddBinding = (uint)0;
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
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 20u));
    int seed = asint(input.Load(lane*4));
    bool flag = (seed != int(0));
    cursor = int(7);
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
            grid[min(uint(_e15), 1u)][min(uint(_e22), 2u)] = ZeroValueint();
        }
    }
    SameType = 4u;
    Boolean = 1u;
    Promoted = 4u;
    BoolInt = 4u;
    Real = 4u;
    NestedMiddle = 4u;
    NestedFinal = 4u;
    Grouped = 4u;
    Logical = 4u;
    Row = 12u;
    Element = 4u;
    InvalidDivide = 4u;
    InvalidShift = 4u;
    Reference = 4u;
    Storage = 4u;
    UnaryBinding = 7u;
    AddBinding = 5u;
    uint _e67 = SameType;
    output.Store(base*4, asuint(_e67));
    uint _e70 = Boolean;
    local_3 = uint((base + 1u));
    uint _e75 = local_3;
    output.Store(_e75*4, asuint(_e70));
    uint _e77 = Promoted;
    local_4 = uint((base + 2u));
    uint _e82 = local_4;
    output.Store(_e82*4, asuint(_e77));
    uint _e84 = BoolInt;
    local_5 = uint((base + 3u));
    uint _e89 = local_5;
    output.Store(_e89*4, asuint(_e84));
    uint _e91 = Real;
    local_6 = uint((base + 4u));
    uint _e96 = local_6;
    output.Store(_e96*4, asuint(_e91));
    uint _e98 = NestedMiddle;
    local_7 = uint((base + 5u));
    uint _e103 = local_7;
    output.Store(_e103*4, asuint(_e98));
    uint _e105 = NestedFinal;
    local_8 = uint((base + 6u));
    uint _e110 = local_8;
    output.Store(_e110*4, asuint(_e105));
    uint _e112 = Grouped;
    local_9 = uint((base + 7u));
    uint _e117 = local_9;
    output.Store(_e117*4, asuint(_e112));
    uint _e119 = Logical;
    local_10 = uint((base + 8u));
    uint _e124 = local_10;
    output.Store(_e124*4, asuint(_e119));
    uint _e126 = Row;
    local_11 = uint((base + 9u));
    uint _e131 = local_11;
    output.Store(_e131*4, asuint(_e126));
    uint _e133 = Element;
    local_12 = uint((base + 10u));
    uint _e138 = local_12;
    output.Store(_e138*4, asuint(_e133));
    uint _e140 = InvalidDivide;
    local_13 = uint((base + 11u));
    uint _e145 = local_13;
    output.Store(_e145*4, asuint(_e140));
    uint _e147 = InvalidShift;
    local_14 = uint((base + 12u));
    uint _e152 = local_14;
    output.Store(_e152*4, asuint(_e147));
    uint _e154 = Reference;
    local_15 = uint((base + 13u));
    uint _e159 = local_15;
    output.Store(_e159*4, asuint(_e154));
    uint _e161 = Storage;
    local_16 = uint((base + 14u));
    uint _e166 = local_16;
    output.Store(_e166*4, asuint(_e161));
    uint _e168 = UnaryBinding;
    local_17 = uint((base + 15u));
    uint _e173 = local_17;
    output.Store(_e173*4, asuint(_e168));
    uint _e175 = AddBinding;
    local_18 = uint((base + 16u));
    uint _e180 = local_18;
    output.Store(_e180*4, asuint(_e175));
    int _e182 = cursor;
    local_19 = uint((base + 17u));
    uint _e188 = local_19;
    output.Store(_e188*4, asuint(uint(_e182)));
    local_20 = uint((base + 18u));
    uint _e195 = local_20;
    output.Store(_e195*4, asuint(uint(seed)));
    local_21 = uint((base + 19u));
    uint _e202 = local_21;
    output.Store(_e202*4, asuint(uint(flag)));
}
