static const uint RowIndex = 1u;
static const int ColumnIndex = int(2);

RWByteAddressBuffer output : register(u0);

uint selected_offset_0u()
{
    uint offset = (uint)0;

    offset = 16u;
    uint _e2 = offset;
    return _e2;
}

uint selected_offset_1u()
{
    uint offset_1 = (uint)0;

    offset_1 = 32u;
    uint _e2 = offset_1;
    return _e2;
}

[numthreads(4, 1, 1)]
void named_offsets(uint3 threadIdx : SV_GroupThreadID)
{
    int cursor = (int)0;
    uint LocalColumn = (uint)0;
    int LocalRow = (int)0;
    uint Zero = (uint)0;
    bool LastRow = (bool)0;
    uint Global = (uint)0;
    uint Local = (uint)0;
    uint Mixed = (uint)0;
    uint ZeroIndex = (uint)0;
    uint BoolIndex = (uint)0;
    uint Macro = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 10u));
    cursor = int(7);
    LocalColumn = 1u;
    LocalRow = int(1);
    Zero = 0u;
    LastRow = true;
    Global = 56u;
    Local = 52u;
    Mixed = 28u;
    ZeroIndex = 8u;
    BoolIndex = 48u;
    Macro = 56u;
    uint _e28 = Global;
    output.Store(base*4, asuint(_e28));
    uint _e31 = Local;
    local = uint((base + 1u));
    uint _e36 = local;
    output.Store(_e36*4, asuint(_e31));
    uint _e38 = Mixed;
    local_1 = uint((base + 2u));
    uint _e43 = local_1;
    output.Store(_e43*4, asuint(_e38));
    uint _e45 = ZeroIndex;
    local_2 = uint((base + 3u));
    uint _e50 = local_2;
    output.Store(_e50*4, asuint(_e45));
    uint _e52 = BoolIndex;
    local_3 = uint((base + 4u));
    uint _e57 = local_3;
    output.Store(_e57*4, asuint(_e52));
    uint _e59 = Macro;
    local_4 = uint((base + 5u));
    uint _e64 = local_4;
    output.Store(_e64*4, asuint(_e59));
    const uint _e66 = selected_offset_0u();
    local_5 = uint((base + 6u));
    uint _e71 = local_5;
    output.Store(_e71*4, asuint(_e66));
    const uint _e73 = selected_offset_1u();
    local_6 = uint((base + 7u));
    uint _e78 = local_6;
    output.Store(_e78*4, asuint(_e73));
    int _e80 = cursor;
    local_7 = uint((base + 8u));
    uint _e86 = local_7;
    output.Store(_e86*4, asuint(uint(_e80)));
    local_8 = uint((base + 9u));
    uint _e92 = local_8;
    output.Store(_e92*4, asuint(lane));
}
