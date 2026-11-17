#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _9_8
{
    int _m0[];
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    uint _m0[];
} _11;

void main()
{
    uint _116 = 0u;
    uint _110 = 0u;
    uint _104 = 0u;
    uint _98 = 0u;
    int _92 = 0;
    int _86 = 0;
    int _80 = 0;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _62 = 0u;
    int _54 = 0;
    uint _118 = 0u;
    uint _112 = 0u;
    uint _106 = 0u;
    uint _100 = 0u;
    uint _94 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _64 = 0u;
    uint _57 = 0u;
    uint _120 = 0u;
    uint _114 = 0u;
    uint _108 = 0u;
    int _102 = 0;
    int _96 = 0;
    uint _84 = 0u;
    uint _78 = 0u;
    int _72 = 0;
    uint _66 = 0u;
    int _60 = 0;
    uvec2 _276 = uvec2(4294967295u);
    uint _125 = 4u + (gl_LocalInvocationID.x * 16u);
    int _128 = _8._m0[gl_LocalInvocationID.x];
    _54 = int(gl_LocalInvocationID.x) + 1;
    switch (_128)
    {
        case 0:
        {
            _54++;
            break;
        }
        default:
        {
            _54 += 2;
            break;
        }
    }
    _11._m0[_125] = uint(_54);
    _54++;
    switch (_128)
    {
        case 0:
        {
            _54 += 10;
            break;
        }
        case 1:
        {
            _54 += 20;
            _54 += 30;
            break;
        }
        case 2:
        {
            _54 += 30;
            break;
        }
        default:
        {
            _54 += 40;
            break;
        }
    }
    _57 = _125 + 1u;
    _11._m0[_57] = uint(_54);
    _60 = 5;
    switch (_128)
    {
        case 0:
        {
            _62 = _125 + 2u;
            _110 = _62;
            _11._m0[_110] = uint(_60);
            break;
        }
        case 1:
        {
            _64 = _125 + 2u;
            _112 = _64;
            _11._m0[_112] = uint(_60 + _128);
            break;
        }
        default:
        {
            _66 = _125 + 2u;
            _114 = _66;
            _11._m0[_114] = uint(_60 + _128);
            break;
        }
    }
    switch (_128 + 1)
    {
        case 1:
        {
            _54 += 3;
            break;
        }
        default:
        {
            _54 += 4;
            break;
        }
    }
    _68 = _125 + 3u;
    _11._m0[_68] = uint(_54);
    do
    {
        _54 += 7;
        break;
    } while(false);
    _70 = _125 + 4u;
    _11._m0[_70] = uint(_54);
    _72 = 99;
    switch (_128)
    {
        case 0:
        {
            _74 = _125 + 5u;
            _116 = _74;
            _11._m0[_116] = uint(_128 + 10);
            break;
        }
        default:
        {
            _76 = _125 + 5u;
            _118 = _76;
            _11._m0[_118] = uint(_128 + 20);
            break;
        }
    }
    _78 = _125 + 6u;
    _11._m0[_78] = uint(_72);
    do
    {
        _80 = 9;
        _54 += _80;
        _82 = _125 + 7u;
        _120 = _82;
        _11._m0[_120] = uint(_128 + 30);
        break;
    } while(false);
    _84 = _125 + 8u;
    _11._m0[_84] = uint(_54);
    _86 = 1;
    switch (_128)
    {
        case 1:
        {
            _54++;
            break;
        }
        default:
        {
            _54 += 2;
            break;
        }
    }
    _88 = _125 + 9u;
    _11._m0[_88] = uint(_54);
    int _90 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _276)))
        {
            break;
        }
        _276 -= uvec2(uint(_276.y == 0u), 1u);
        if (!(_90 < 4))
        {
            break;
        }
        _92 = _90;
        switch (_92)
        {
            case 1:
            {
                int _303 = _90;
                _90 = _303 + 1;
                continue;
            }
            case 2:
            {
                _54 += 10;
                break;
            }
            default:
            {
                _54++;
                break;
            }
        }
        _54 += 2;
        int _303 = _90;
        _90 = _303 + 1;
        continue;
    }
    _94 = _125 + 10u;
    _11._m0[_94] = uint(_54);
    _96 = 0;
    _96++;
    _54 += 2;
    do
    {
        _54 += 3;
        break;
    } while(false);
    _98 = _125 + 11u;
    _11._m0[_98] = uint(_96);
    _100 = _125 + 12u;
    _11._m0[_100] = uint(_54);
    switch (_128)
    {
        case 0:
        {
            _102 = _128 + 1;
            do
            {
                _54 += _102;
                break;
            } while(false);
            break;
        }
        default:
        {
            _54 += 4;
            break;
        }
    }
    _104 = _125 + 13u;
    _11._m0[_104] = uint(_54);
    _106 = _125 + 14u;
    _11._m0[_106] = uint(_128);
    _108 = _125 + 15u;
    _11._m0[_108] = uint(_96);
}

