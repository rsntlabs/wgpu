ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

int ZeroValueint() {
    return (int)0;
}

[numthreads(4, 1, 1)]
void sizeof_binary(uint3 threadIdx : SV_GroupThreadID)
{
    uint other = (uint)0;
    float real = (float)0;
    int counter = (int)0;
    int grid[2][3] = (int[2][3])0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint Add = (uint)0;
    uint Subtract = (uint)0;
    uint Multiply = (uint)0;
    uint Divide = (uint)0;
    uint Modulo = (uint)0;
    uint Left = (uint)0;
    uint Right = (uint)0;
    uint And = (uint)0;
    uint Or = (uint)0;
    uint Xor = (uint)0;
    uint Less = (uint)0;
    uint Equal = (uint)0;
    uint LogicalAnd = (uint)0;
    uint LogicalOr = (uint)0;
    uint Nested = (uint)0;
    uint Row = (uint)0;
    uint Element = (uint)0;
    uint Reference = (uint)0;
    uint BinaryIndex = (uint)0;
    uint InvalidShift = (uint)0;
    uint ReferenceDivide = (uint)0;
    uint GroupedComparison = (uint)0;
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
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 24u));
    int seed = asint(input.Load(lane*4));
    other = 33u;
    real = 2.0;
    counter = int(7);
    local = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e32 = local;
            local = (_e32 + 1u);
        }
        loop_init = false;
        uint _e17 = local;
        if ((_e17 >= 2u)) {
            break;
        }
        local_1 = 0u;
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                uint _e29 = local_1;
                local_1 = (_e29 + 1u);
            }
            loop_init_1 = false;
            uint _e24 = local_1;
            if ((_e24 >= 3u)) {
                break;
            }
            grid[min(uint(_e17), 1u)][min(uint(_e24), 2u)] = ZeroValueint();
        }
    }
    Add = 4u;
    Subtract = 4u;
    Multiply = 4u;
    Divide = 4u;
    Modulo = 4u;
    Left = 4u;
    Right = 4u;
    And = 4u;
    Or = 4u;
    Xor = 4u;
    Less = 1u;
    Equal = 1u;
    LogicalAnd = 1u;
    LogicalOr = 1u;
    Nested = 4u;
    Row = 12u;
    Element = 4u;
    Reference = 4u;
    BinaryIndex = 12u;
    InvalidShift = 4u;
    ReferenceDivide = 4u;
    GroupedComparison = 1u;
    uint _e79 = Add;
    output.Store(base*4, asuint(_e79));
    uint _e82 = Subtract;
    local_2 = uint((base + 1u));
    uint _e87 = local_2;
    output.Store(_e87*4, asuint(_e82));
    uint _e89 = Multiply;
    local_3 = uint((base + 2u));
    uint _e94 = local_3;
    output.Store(_e94*4, asuint(_e89));
    uint _e96 = Divide;
    local_4 = uint((base + 3u));
    uint _e101 = local_4;
    output.Store(_e101*4, asuint(_e96));
    uint _e103 = Modulo;
    local_5 = uint((base + 4u));
    uint _e108 = local_5;
    output.Store(_e108*4, asuint(_e103));
    uint _e110 = Left;
    local_6 = uint((base + 5u));
    uint _e115 = local_6;
    output.Store(_e115*4, asuint(_e110));
    uint _e117 = Right;
    local_7 = uint((base + 6u));
    uint _e122 = local_7;
    output.Store(_e122*4, asuint(_e117));
    uint _e124 = And;
    local_8 = uint((base + 7u));
    uint _e129 = local_8;
    output.Store(_e129*4, asuint(_e124));
    uint _e131 = Or;
    local_9 = uint((base + 8u));
    uint _e136 = local_9;
    output.Store(_e136*4, asuint(_e131));
    uint _e138 = Xor;
    local_10 = uint((base + 9u));
    uint _e143 = local_10;
    output.Store(_e143*4, asuint(_e138));
    uint _e145 = Less;
    local_11 = uint((base + 10u));
    uint _e150 = local_11;
    output.Store(_e150*4, asuint(_e145));
    uint _e152 = Equal;
    local_12 = uint((base + 11u));
    uint _e157 = local_12;
    output.Store(_e157*4, asuint(_e152));
    uint _e159 = LogicalAnd;
    local_13 = uint((base + 12u));
    uint _e164 = local_13;
    output.Store(_e164*4, asuint(_e159));
    uint _e166 = LogicalOr;
    local_14 = uint((base + 13u));
    uint _e171 = local_14;
    output.Store(_e171*4, asuint(_e166));
    uint _e173 = Nested;
    local_15 = uint((base + 14u));
    uint _e178 = local_15;
    output.Store(_e178*4, asuint(_e173));
    uint _e180 = Row;
    local_16 = uint((base + 15u));
    uint _e185 = local_16;
    output.Store(_e185*4, asuint(_e180));
    uint _e187 = Element;
    local_17 = uint((base + 16u));
    uint _e192 = local_17;
    output.Store(_e192*4, asuint(_e187));
    uint _e194 = Reference;
    local_18 = uint((base + 17u));
    uint _e199 = local_18;
    output.Store(_e199*4, asuint(_e194));
    uint _e201 = BinaryIndex;
    local_19 = uint((base + 18u));
    uint _e206 = local_19;
    output.Store(_e206*4, asuint(_e201));
    uint _e208 = InvalidShift;
    local_20 = uint((base + 19u));
    uint _e213 = local_20;
    output.Store(_e213*4, asuint(_e208));
    int _e215 = counter;
    local_21 = uint((base + 20u));
    uint _e221 = local_21;
    output.Store(_e221*4, asuint(uint(_e215)));
    local_22 = uint((base + 21u));
    uint _e228 = local_22;
    output.Store(_e228*4, asuint(uint(seed)));
    uint _e230 = ReferenceDivide;
    local_23 = uint((base + 22u));
    uint _e235 = local_23;
    output.Store(_e235*4, asuint(_e230));
    uint _e237 = GroupedComparison;
    local_24 = uint((base + 23u));
    uint _e242 = local_24;
    output.Store(_e242*4, asuint(_e237));
}
