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
    uint _44 = uint(int64_t(uint64_t(_33._m0) >> 32ul));
    uint _59 = uint(_33._m1 >> 32ul);
    uvec2 _77 = uvec2(i64vec2(u64vec2(_33._m2) >> u64vec2(32ul)));
    uvec2 _92 = uvec2(_33._m3 >> u64vec2(32ul));
    uvec3 _110 = uvec3(i64vec3(u64vec3(_33._m4) >> u64vec3(32ul)));
    uvec3 _125 = uvec3(_33._m5 >> u64vec3(32ul));
    uvec4 _143 = uvec4(i64vec4(u64vec4(_33._m6) >> u64vec4(32ul)));
    uvec4 _158 = uvec4(_33._m7 >> u64vec4(32ul));
    _18._m0[0u]._m0 = _11(int64_t((_44 != 0u) ? (31 - int(uint(findMSB(_44)))) : (63 - int(uint(findMSB(uint(_33._m0)))))), uint64_t((_59 != 0u) ? (31 - int(uint(findMSB(_59)))) : (63 - int(uint(findMSB(uint(_33._m1)))))), i64vec2(mix(ivec2(63) - ivec2(uvec2(findMSB(uvec2(_33._m2)))), ivec2(31) - ivec2(uvec2(findMSB(_77))), notEqual(_77, uvec2(0u)))), u64vec2(mix(ivec2(63) - ivec2(uvec2(findMSB(uvec2(_33._m3)))), ivec2(31) - ivec2(uvec2(findMSB(_92))), notEqual(_92, uvec2(0u)))), i64vec3(mix(ivec3(63) - ivec3(uvec3(findMSB(uvec3(_33._m4)))), ivec3(31) - ivec3(uvec3(findMSB(_110))), notEqual(_110, uvec3(0u)))), u64vec3(mix(ivec3(63) - ivec3(uvec3(findMSB(uvec3(_33._m5)))), ivec3(31) - ivec3(uvec3(findMSB(_125))), notEqual(_125, uvec3(0u)))), i64vec4(mix(ivec4(63) - ivec4(uvec4(findMSB(uvec4(_33._m6)))), ivec4(31) - ivec4(uvec4(findMSB(_143))), notEqual(_143, uvec4(0u)))), u64vec4(mix(ivec4(63) - ivec4(uvec4(findMSB(uvec4(_33._m7)))), ivec4(31) - ivec4(uvec4(findMSB(_158))), notEqual(_158, uvec4(0u)))));
    uint _169 = uint(_33._m0);
    uint _173 = uint(int64_t(uint64_t(_33._m0) >> 32ul));
    uint _185 = uint(_33._m1);
    uint _189 = uint(_33._m1 >> 32ul);
    uvec2 _199 = uvec2(_33._m2);
    uvec2 _203 = uvec2(i64vec2(u64vec2(_33._m2) >> u64vec2(32ul)));
    uvec2 _215 = uvec2(_33._m3);
    uvec2 _219 = uvec2(_33._m3 >> u64vec2(32ul));
    uvec3 _229 = uvec3(_33._m4);
    uvec3 _233 = uvec3(i64vec3(u64vec3(_33._m4) >> u64vec3(32ul)));
    uvec3 _245 = uvec3(_33._m5);
    uvec3 _249 = uvec3(_33._m5 >> u64vec3(32ul));
    uvec4 _259 = uvec4(_33._m6);
    uvec4 _263 = uvec4(i64vec4(u64vec4(_33._m6) >> u64vec4(32ul)));
    uvec4 _275 = uvec4(_33._m7);
    uvec4 _279 = uvec4(_33._m7 >> u64vec4(32ul));
    _18._m0[0u]._m1 = _11(int64_t((_169 != 0u) ? int(uint(findLSB(_169))) : ((_173 != 0u) ? (int(uint(findLSB(_173))) + 32) : 64)), uint64_t((_185 != 0u) ? int(uint(findLSB(_185))) : ((_189 != 0u) ? (int(uint(findLSB(_189))) + 32) : 64)), i64vec2(mix(mix(ivec2(64), ivec2(uvec2(findLSB(_203))) + ivec2(32), notEqual(_203, uvec2(0u))), ivec2(uvec2(findLSB(_199))), notEqual(_199, uvec2(0u)))), u64vec2(mix(mix(ivec2(64), ivec2(uvec2(findLSB(_219))) + ivec2(32), notEqual(_219, uvec2(0u))), ivec2(uvec2(findLSB(_215))), notEqual(_215, uvec2(0u)))), i64vec3(mix(mix(ivec3(64), ivec3(uvec3(findLSB(_233))) + ivec3(32), notEqual(_233, uvec3(0u))), ivec3(uvec3(findLSB(_229))), notEqual(_229, uvec3(0u)))), u64vec3(mix(mix(ivec3(64), ivec3(uvec3(findLSB(_249))) + ivec3(32), notEqual(_249, uvec3(0u))), ivec3(uvec3(findLSB(_245))), notEqual(_245, uvec3(0u)))), i64vec4(mix(mix(ivec4(64), ivec4(uvec4(findLSB(_263))) + ivec4(32), notEqual(_263, uvec4(0u))), ivec4(uvec4(findLSB(_259))), notEqual(_259, uvec4(0u)))), u64vec4(mix(mix(ivec4(64), ivec4(uvec4(findLSB(_279))) + ivec4(32), notEqual(_279, uvec4(0u))), ivec4(uvec4(findLSB(_275))), notEqual(_275, uvec4(0u)))));
    int64_t _295 = (_33._m0 < 0l) ? (~_33._m0) : _33._m0;
    uint _300 = uint(int64_t(uint64_t(_295) >> 32ul));
    uint _314 = uint(_33._m1 >> 32ul);
    i64vec2 _327 = mix(_33._m2, ~_33._m2, lessThan(_33._m2, i64vec2(0l)));
    uvec2 _332 = uvec2(i64vec2(u64vec2(_327) >> u64vec2(32ul)));
    uvec2 _346 = uvec2(_33._m3 >> u64vec2(32ul));
    i64vec3 _359 = mix(_33._m4, ~_33._m4, lessThan(_33._m4, i64vec3(0l)));
    uvec3 _364 = uvec3(i64vec3(u64vec3(_359) >> u64vec3(32ul)));
    uvec3 _378 = uvec3(_33._m5 >> u64vec3(32ul));
    i64vec4 _391 = mix(_33._m6, ~_33._m6, lessThan(_33._m6, i64vec4(0l)));
    uvec4 _396 = uvec4(i64vec4(u64vec4(_391) >> u64vec4(32ul)));
    uvec4 _410 = uvec4(_33._m7 >> u64vec4(32ul));
    _18._m0[0u]._m2 = _11(int64_t(63 - ((_300 != 0u) ? (31 - int(uint(findMSB(_300)))) : (63 - int(uint(findMSB(uint(_295))))))), uint64_t(63 - ((_314 != 0u) ? (31 - int(uint(findMSB(_314)))) : (63 - int(uint(findMSB(uint(_33._m1))))))), i64vec2(ivec2(63) - mix(ivec2(63) - ivec2(uvec2(findMSB(uvec2(_327)))), ivec2(31) - ivec2(uvec2(findMSB(_332))), notEqual(_332, uvec2(0u)))), u64vec2(ivec2(63) - mix(ivec2(63) - ivec2(uvec2(findMSB(uvec2(_33._m3)))), ivec2(31) - ivec2(uvec2(findMSB(_346))), notEqual(_346, uvec2(0u)))), i64vec3(ivec3(63) - mix(ivec3(63) - ivec3(uvec3(findMSB(uvec3(_359)))), ivec3(31) - ivec3(uvec3(findMSB(_364))), notEqual(_364, uvec3(0u)))), u64vec3(ivec3(63) - mix(ivec3(63) - ivec3(uvec3(findMSB(uvec3(_33._m5)))), ivec3(31) - ivec3(uvec3(findMSB(_378))), notEqual(_378, uvec3(0u)))), i64vec4(ivec4(63) - mix(ivec4(63) - ivec4(uvec4(findMSB(uvec4(_391)))), ivec4(31) - ivec4(uvec4(findMSB(_396))), notEqual(_396, uvec4(0u)))), u64vec4(ivec4(63) - mix(ivec4(63) - ivec4(uvec4(findMSB(uvec4(_33._m7)))), ivec4(31) - ivec4(uvec4(findMSB(_410))), notEqual(_410, uvec4(0u)))));
    uint _423 = uint(_33._m0);
    uint _427 = uint(int64_t(uint64_t(_33._m0) >> 32ul));
    int _431 = (_423 != 0u) ? int(uint(findLSB(_423))) : ((_427 != 0u) ? (int(uint(findLSB(_427))) + 32) : 64);
    uint _440 = uint(_33._m1);
    uint _444 = uint(_33._m1 >> 32ul);
    int _448 = (_440 != 0u) ? int(uint(findLSB(_440))) : ((_444 != 0u) ? (int(uint(findLSB(_444))) + 32) : 64);
    uvec2 _456 = uvec2(_33._m2);
    uvec2 _460 = uvec2(i64vec2(u64vec2(_33._m2) >> u64vec2(32ul)));
    ivec2 _464 = mix(mix(ivec2(64), ivec2(uvec2(findLSB(_460))) + ivec2(32), notEqual(_460, uvec2(0u))), ivec2(uvec2(findLSB(_456))), notEqual(_456, uvec2(0u)));
    uvec2 _473 = uvec2(_33._m3);
    uvec2 _477 = uvec2(_33._m3 >> u64vec2(32ul));
    ivec2 _481 = mix(mix(ivec2(64), ivec2(uvec2(findLSB(_477))) + ivec2(32), notEqual(_477, uvec2(0u))), ivec2(uvec2(findLSB(_473))), notEqual(_473, uvec2(0u)));
    uvec3 _489 = uvec3(_33._m4);
    uvec3 _493 = uvec3(i64vec3(u64vec3(_33._m4) >> u64vec3(32ul)));
    ivec3 _497 = mix(mix(ivec3(64), ivec3(uvec3(findLSB(_493))) + ivec3(32), notEqual(_493, uvec3(0u))), ivec3(uvec3(findLSB(_489))), notEqual(_489, uvec3(0u)));
    uvec3 _506 = uvec3(_33._m5);
    uvec3 _510 = uvec3(_33._m5 >> u64vec3(32ul));
    ivec3 _514 = mix(mix(ivec3(64), ivec3(uvec3(findLSB(_510))) + ivec3(32), notEqual(_510, uvec3(0u))), ivec3(uvec3(findLSB(_506))), notEqual(_506, uvec3(0u)));
    uvec4 _522 = uvec4(_33._m6);
    uvec4 _526 = uvec4(i64vec4(u64vec4(_33._m6) >> u64vec4(32ul)));
    ivec4 _530 = mix(mix(ivec4(64), ivec4(uvec4(findLSB(_526))) + ivec4(32), notEqual(_526, uvec4(0u))), ivec4(uvec4(findLSB(_522))), notEqual(_522, uvec4(0u)));
    uvec4 _539 = uvec4(_33._m7);
    uvec4 _543 = uvec4(_33._m7 >> u64vec4(32ul));
    ivec4 _547 = mix(mix(ivec4(64), ivec4(uvec4(findLSB(_543))) + ivec4(32), notEqual(_543, uvec4(0u))), ivec4(uvec4(findLSB(_539))), notEqual(_539, uvec4(0u)));
    _18._m0[0u]._m3 = _11(int64_t((_431 == 64) ? (-1) : _431), uint64_t((_448 == 64) ? (-1) : _448), i64vec2(mix(_464, ivec2(-1), equal(_464, ivec2(64)))), u64vec2(mix(_481, ivec2(-1), equal(_481, ivec2(64)))), i64vec3(mix(_497, ivec3(-1), equal(_497, ivec3(64)))), u64vec3(mix(_514, ivec3(-1), equal(_514, ivec3(64)))), i64vec4(mix(_530, ivec4(-1), equal(_530, ivec4(64)))), u64vec4(mix(_547, ivec4(-1), equal(_547, ivec4(64)))));
}

