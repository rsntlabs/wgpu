#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _6_5
{
    int _m0[];
} _5;

int _12(int _9, int _10, int _11)
{
    return ((_9 + _10) + _11) + 100;
}

int _21(int _20)
{
    int _25 = -2;
    return min(max(_20, _25), 2);
}

void main()
{
    int _68 = 0;
    int _71 = 0;
    int _73 = 0;
    uint _76 = uint(0);
    int _79 = _5._m0[_76];
    int _80 = -7;
    _5._m0[uint(0)] = min(_79, _80);
    int _84 = -7;
    _5._m0[uint(1)] = max(_79, _84);
    uint _88 = min(3u, 9u);
    _5._m0[uint(2)] = int(_88);
    uint _92 = max(3u, 9u);
    _5._m0[uint(3)] = int(_92);
    int _96 = -1;
    _5._m0[uint(4)] = int(min(uint(_96), 2u) == 2u);
    int _103 = -1;
    _5._m0[uint(5)] = int(max(uint(_103), 2u) == 4294967295u);
    int _110 = -1;
    _5._m0[uint(6)] = int(min(2u, uint(_110)) == 2u);
    int _117 = -1;
    _5._m0[uint(7)] = int(max(2u, uint(_117)) == 4294967295u);
    _5._m0[uint(8)] = min(int(true), int(false));
    _5._m0[uint(9)] = max(int(false), int(true));
    int _134 = -5;
    _5._m0[uint(10)] = min(max(_79, _134), 2);
    int _139 = -2;
    _5._m0[uint(11)] = int(min(uint(_139), 4u) == 4u);
    _5._m0[uint(12)] = _12(_79, 4, 5);
    _5._m0[uint(13)] = _21(_79);
    _68 = 3;
    _71 = 7;
    int _152 = _68;
    _68 = _152 + 1;
    int _154 = _71;
    _71 = _154 + 1;
    _5._m0[uint(14)] = max(_152, _154);
    _5._m0[uint(15)] = _68;
    _5._m0[uint(16)] = _71;
    _73 = _79;
    int _165 = _73;
    int _166 = _73;
    _73 = _166 + 1;
    _5._m0[uint(17)] = max(_165, _166);
    _5._m0[uint(18)] = _73;
    int _174 = -2147483647;
    int _177 = -2147483647;
    _5._m0[uint(19)] = int(min((_174 - 1), 2147483647) == (_177 - 1));
    uint _183 = max(4294967295u, 0u);
    _5._m0[uint(20)] = int(_183 == 4294967295u);
    _5._m0[uint(21)] = int(min(uint(false), 3u) == 0u);
    _5._m0[uint(22)] = int(max(uint(true), 0u) == 1u);
    _5._m0[uint(23)] = min(_79, _79);
}

