#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_16bit_storage : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _11
{
    int16_t _m0;
    uint16_t _m1;
    i16vec2 _m2;
    u16vec2 _m3;
    i16vec3 _m4;
    u16vec3 _m5;
    i16vec4 _m6;
    u16vec4 _m7;
};

struct _12
{
    _11 _m0;
    _11 _m1;
    _11 _m2;
    _11 _m3;
};

layout(set = 0, binding = 0, std430) readonly buffer _16_15
{
    _11 _m0[];
} _15;

layout(set = 0, binding = 1, std430) buffer _19_18
{
    _12 _m0[];
} _18;

void main()
{
    _11 _33 = _15._m0[0u];
    _18._m0[0u]._m0 = _11(int16_t(15 - int(uint(findMSB(uint(uint16_t(_33._m0)))))), uint16_t(15 - int(uint(findMSB(uint(_33._m1))))), i16vec2(ivec2(15) - ivec2(uvec2(findMSB(uvec2(u16vec2(_33._m2)))))), u16vec2(ivec2(15) - ivec2(uvec2(findMSB(uvec2(_33._m3))))), i16vec3(ivec3(15) - ivec3(uvec3(findMSB(uvec3(u16vec3(_33._m4)))))), u16vec3(ivec3(15) - ivec3(uvec3(findMSB(uvec3(_33._m5))))), i16vec4(ivec4(15) - ivec4(uvec4(findMSB(uvec4(u16vec4(_33._m6)))))), u16vec4(ivec4(15) - ivec4(uvec4(findMSB(uvec4(_33._m7))))));
    uint _110 = uint(uint16_t(_33._m0));
    uint _118 = uint(_33._m1);
    uvec2 _126 = uvec2(u16vec2(_33._m2));
    uvec2 _134 = uvec2(_33._m3);
    uvec3 _142 = uvec3(u16vec3(_33._m4));
    uvec3 _150 = uvec3(_33._m5);
    uvec4 _158 = uvec4(u16vec4(_33._m6));
    uvec4 _166 = uvec4(_33._m7);
    _18._m0[0u]._m1 = _11(int16_t((_110 != 0u) ? int(uint(findLSB(_110))) : 16), uint16_t((_118 != 0u) ? int(uint(findLSB(_118))) : 16), i16vec2(mix(ivec2(16), ivec2(uvec2(findLSB(_126))), notEqual(_126, uvec2(0u)))), u16vec2(mix(ivec2(16), ivec2(uvec2(findLSB(_134))), notEqual(_134, uvec2(0u)))), i16vec3(mix(ivec3(16), ivec3(uvec3(findLSB(_142))), notEqual(_142, uvec3(0u)))), u16vec3(mix(ivec3(16), ivec3(uvec3(findLSB(_150))), notEqual(_150, uvec3(0u)))), i16vec4(mix(ivec4(16), ivec4(uvec4(findLSB(_158))), notEqual(_158, uvec4(0u)))), u16vec4(mix(ivec4(16), ivec4(uvec4(findLSB(_166))), notEqual(_166, uvec4(0u)))));
    _18._m0[0u]._m2 = _11(int16_t(15 - (15 - int(uint(findMSB(uint(uint16_t((_33._m0 < 0s) ? (~_33._m0) : _33._m0))))))), uint16_t(15 - (15 - int(uint(findMSB(uint(_33._m1)))))), i16vec2(ivec2(15) - (ivec2(15) - ivec2(uvec2(findMSB(uvec2(u16vec2(mix(_33._m2, ~_33._m2, lessThan(_33._m2, i16vec2(0)))))))))), u16vec2(ivec2(15) - (ivec2(15) - ivec2(uvec2(findMSB(uvec2(_33._m3)))))), i16vec3(ivec3(15) - (ivec3(15) - ivec3(uvec3(findMSB(uvec3(u16vec3(mix(_33._m4, ~_33._m4, lessThan(_33._m4, i16vec3(0)))))))))), u16vec3(ivec3(15) - (ivec3(15) - ivec3(uvec3(findMSB(uvec3(_33._m5)))))), i16vec4(ivec4(15) - (ivec4(15) - ivec4(uvec4(findMSB(uvec4(u16vec4(mix(_33._m6, ~_33._m6, lessThan(_33._m6, i16vec4(0)))))))))), u16vec4(ivec4(15) - (ivec4(15) - ivec4(uvec4(findMSB(uvec4(_33._m7)))))));
    uint _256 = uint(uint16_t(_33._m0));
    int _259 = (_256 != 0u) ? int(uint(findLSB(_256))) : 16;
    uint _266 = uint(_33._m1);
    int _269 = (_266 != 0u) ? int(uint(findLSB(_266))) : 16;
    uvec2 _276 = uvec2(u16vec2(_33._m2));
    ivec2 _279 = mix(ivec2(16), ivec2(uvec2(findLSB(_276))), notEqual(_276, uvec2(0u)));
    uvec2 _286 = uvec2(_33._m3);
    ivec2 _289 = mix(ivec2(16), ivec2(uvec2(findLSB(_286))), notEqual(_286, uvec2(0u)));
    uvec3 _296 = uvec3(u16vec3(_33._m4));
    ivec3 _299 = mix(ivec3(16), ivec3(uvec3(findLSB(_296))), notEqual(_296, uvec3(0u)));
    uvec3 _306 = uvec3(_33._m5);
    ivec3 _309 = mix(ivec3(16), ivec3(uvec3(findLSB(_306))), notEqual(_306, uvec3(0u)));
    uvec4 _316 = uvec4(u16vec4(_33._m6));
    ivec4 _319 = mix(ivec4(16), ivec4(uvec4(findLSB(_316))), notEqual(_316, uvec4(0u)));
    uvec4 _326 = uvec4(_33._m7);
    ivec4 _329 = mix(ivec4(16), ivec4(uvec4(findLSB(_326))), notEqual(_326, uvec4(0u)));
    _18._m0[0u]._m3 = _11(int16_t((_259 == 16) ? (-1) : _259), uint16_t((_269 == 16) ? (-1) : _269), i16vec2(mix(_279, ivec2(-1), equal(_279, ivec2(16)))), u16vec2(mix(_289, ivec2(-1), equal(_289, ivec2(16)))), i16vec3(mix(_299, ivec3(-1), equal(_299, ivec3(16)))), u16vec3(mix(_309, ivec3(-1), equal(_309, ivec3(16)))), i16vec4(mix(_319, ivec4(-1), equal(_319, ivec4(16)))), u16vec4(mix(_329, ivec4(-1), equal(_329, ivec4(16)))));
}

