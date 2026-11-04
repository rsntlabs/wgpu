#version 460
#if defined(GL_ARB_gpu_shader_int64)
#extension GL_ARB_gpu_shader_int64 : require
#else
#error No extension available for 64-bit integers.
#endif
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _11
{
    int64_t _m0;
    uint64_t _m1;
    i64vec2 _m2;
    u64vec2 _m3;
    i64vec3 _m4;
    u64vec3 _m5;
    i64vec4 _m6;
    u64vec4 _m7;
};

layout(set = 0, binding = 0, std430) readonly buffer _14_13
{
    _11 _m0[];
} _13;

layout(set = 0, binding = 1, std430) buffer _17_16
{
    _11 _m0[];
} _16;

layout(set = 0, binding = 2, std430) buffer _20_19
{
    _11 _m0[];
} _19;

int64_t _22(int64_t _24, int64_t _25)
{
    return _24 / (((_25 == 0l) || ((_24 == int64_t(0x8000000000000000ul)) && (_25 == (-1l)))) ? 1l : _25);
}

uint64_t _39(uint64_t _41, uint64_t _42)
{
    return _41 / ((_42 == 0ul) ? 1ul : _42);
}

i64vec2 _49(i64vec2 _51, i64vec2 _52)
{
    bvec2 _56 = equal(_52, i64vec2(0l));
    bvec2 _59 = equal(_51, i64vec2(int64_t(0x8000000000000000ul)));
    bvec2 _60 = equal(_52, i64vec2(-1l));
    bvec2 _61 = bvec2(_59.x && _60.x, _59.y && _60.y);
    return _51 / mix(_52, i64vec2(1l), bvec2(_56.x || _61.x, _56.y || _61.y));
}

u64vec2 _66(u64vec2 _68, u64vec2 _69)
{
    return _68 / mix(_69, u64vec2(1ul), equal(_69, u64vec2(0ul)));
}

i64vec3 _76(i64vec3 _78, i64vec3 _79)
{
    bvec3 _83 = equal(_79, i64vec3(0l));
    bvec3 _86 = equal(_78, i64vec3(int64_t(0x8000000000000000ul)));
    bvec3 _87 = equal(_79, i64vec3(-1l));
    bvec3 _88 = bvec3(_86.x && _87.x, _86.y && _87.y, _86.z && _87.z);
    return _78 / mix(_79, i64vec3(1l), bvec3(_83.x || _88.x, _83.y || _88.y, _83.z || _88.z));
}

u64vec3 _93(u64vec3 _95, u64vec3 _96)
{
    return _95 / mix(_96, u64vec3(1ul), equal(_96, u64vec3(0ul)));
}

i64vec4 _103(i64vec4 _105, i64vec4 _106)
{
    bvec4 _110 = equal(_106, i64vec4(0l));
    bvec4 _113 = equal(_105, i64vec4(int64_t(0x8000000000000000ul)));
    bvec4 _114 = equal(_106, i64vec4(-1l));
    bvec4 _115 = bvec4(_113.x && _114.x, _113.y && _114.y, _113.z && _114.z, _113.w && _114.w);
    return _105 / mix(_106, i64vec4(1l), bvec4(_110.x || _115.x, _110.y || _115.y, _110.z || _115.z, _110.w || _115.w));
}

u64vec4 _120(u64vec4 _122, u64vec4 _123)
{
    return _122 / mix(_123, u64vec4(1ul), equal(_123, u64vec4(0ul)));
}

int64_t _130(int64_t _131, int64_t _132)
{
    int64_t _139 = ((_132 == 0l) || ((_131 == int64_t(0x8000000000000000ul)) && (_132 == (-1l)))) ? 1l : _132;
    return _131 - ((_131 / _139) * _139);
}

uint64_t _143(uint64_t _144, uint64_t _145)
{
    return _144 % ((_145 == 0ul) ? 1ul : _145);
}

i64vec2 _150(i64vec2 _151, i64vec2 _152)
{
    bvec2 _154 = equal(_152, i64vec2(0l));
    bvec2 _155 = equal(_151, i64vec2(int64_t(0x8000000000000000ul)));
    bvec2 _156 = equal(_152, i64vec2(-1l));
    bvec2 _157 = bvec2(_155.x && _156.x, _155.y && _156.y);
    i64vec2 _159 = mix(_152, i64vec2(1l), bvec2(_154.x || _157.x, _154.y || _157.y));
    return _151 - ((_151 / _159) * _159);
}

u64vec2 _163(u64vec2 _164, u64vec2 _165)
{
    return _164 % mix(_165, u64vec2(1ul), equal(_165, u64vec2(0ul)));
}

i64vec3 _170(i64vec3 _171, i64vec3 _172)
{
    bvec3 _174 = equal(_172, i64vec3(0l));
    bvec3 _175 = equal(_171, i64vec3(int64_t(0x8000000000000000ul)));
    bvec3 _176 = equal(_172, i64vec3(-1l));
    bvec3 _177 = bvec3(_175.x && _176.x, _175.y && _176.y, _175.z && _176.z);
    i64vec3 _179 = mix(_172, i64vec3(1l), bvec3(_174.x || _177.x, _174.y || _177.y, _174.z || _177.z));
    return _171 - ((_171 / _179) * _179);
}

u64vec3 _183(u64vec3 _184, u64vec3 _185)
{
    return _184 % mix(_185, u64vec3(1ul), equal(_185, u64vec3(0ul)));
}

i64vec4 _190(i64vec4 _191, i64vec4 _192)
{
    bvec4 _194 = equal(_192, i64vec4(0l));
    bvec4 _195 = equal(_191, i64vec4(int64_t(0x8000000000000000ul)));
    bvec4 _196 = equal(_192, i64vec4(-1l));
    bvec4 _197 = bvec4(_195.x && _196.x, _195.y && _196.y, _195.z && _196.z, _195.w && _196.w);
    i64vec4 _199 = mix(_192, i64vec4(1l), bvec4(_194.x || _197.x, _194.y || _197.y, _194.z || _197.z, _194.w || _197.w));
    return _191 - ((_191 / _199) * _199);
}

u64vec4 _203(u64vec4 _204, u64vec4 _205)
{
    return _204 % mix(_205, u64vec4(1ul), equal(_205, u64vec4(0ul)));
}

void main()
{
    _11 _222 = _13._m0[0u];
    _11 _225 = _13._m0[1u];
    _16._m0[0u] = _11(_22(_222._m0, _225._m0), _39(_222._m1, _225._m1), _49(_222._m2, _225._m2), _66(_222._m3, _225._m3), _76(_222._m4, _225._m4), _93(_222._m5, _225._m5), _103(_222._m6, _225._m6), _120(_222._m7, _225._m7));
    _19._m0[0u] = _11(_130(_222._m0, _225._m0), _143(_222._m1, _225._m1), _150(_222._m2, _225._m2), _163(_222._m3, _225._m3), _170(_222._m4, _225._m4), _183(_222._m5, _225._m5), _190(_222._m6, _225._m6), _203(_222._m7, _225._m7));
}

