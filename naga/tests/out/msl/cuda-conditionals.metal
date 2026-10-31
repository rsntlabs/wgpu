// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size2;
};

typedef int type_1[1];
struct type_3 {
    uint value;
    char _pad1[12];
};
struct type_4 {
    int inner[64];
};

int shifted(
    int value_1
) {
    return as_type<int>(as_type<uint>(value_1) + as_type<uint>(10));
}

void discard(
    int value_2
) {
    int value_3 = {};
    value_3 = value_2;
    int _e3 = value_3;
    value_3 = as_type<int>(as_type<uint>(_e3) + as_type<uint>(1));
    return;
}

int pair(
    int x,
    int y
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(x) * as_type<uint>(10))) + as_type<uint>(y));
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


struct conditionalsInput {
};
kernel void conditionals(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, device type_1 const& input_a [[user(fake0)]]
, device type_1 const& input_b [[user(fake0)]]
, constant type_3& n [[user(fake0)]]
, threadgroup type_4& shared_values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint base = {};
    bool choose_a = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    int local_3 = {};
    int a = {};
    int b = {};
    uint local_4 = {};
    int local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    int index_a = {};
    int index_b = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    int local_14 = {};
    uint local_15 = {};
    int local_16 = {};
    uint local_17 = {};
    int c = {};
    uint local_18 = {};
    int local_19 = {};
    uint local_20 = {};
    int condition = {};
    uint local_21 = {};
    uint local_22 = {};
    uint lane = {};
    int local_value = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    float local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    bool local_31 = {};
    uint local_32 = {};
    int local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    int shift_value = {};
    uint local_36 = {};
    int local_37 = {};
    uint local_38 = {};
    int value = {};
    int other = {};
    uint local_39 = {};
    int local_40 = {};
    int count = {};
    int left = {};
    int right = {};
    uint local_41 = {};
    int local_42 = {};
    int local_43 = {};
    uint local_44 = {};
    int local_45 = {};
    uint local_46 = {};
    int local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 25u;
        choose_a = naga_mod(i, 2u) == 0u;
        bool _e19 = choose_a;
        if (_e19) {
            local_1 = i;
            uint _e21 = local_1;
            local_44 = _e21;
            uint _e23 = local_44;
            int _e26 = input_a[_e23];
            local_45 = _e26;
            int _e28 = local_45;
            local_42 = _e28;
            int _e30 = local_42;
            local_3 = _e30;
        } else {
            local_2 = i;
            uint _e33 = local_2;
            local_46 = _e33;
            uint _e35 = local_46;
            int _e38 = input_b[_e35];
            local_47 = _e38;
            int _e40 = local_47;
            local_43 = _e40;
            int _e42 = local_43;
            local_3 = _e42;
        }
        int _e45 = local_3;
        uint _e46 = base;
        local = _e46;
        uint _e48 = local;
        local_48 = _e48;
        uint _e50 = local_48;
        out[_e50] = _e45;
        a = 3;
        b = 5;
        bool _e57 = choose_a;
        if (_e57) {
            int _e58 = a;
            a = as_type<int>(as_type<uint>(_e58) + as_type<uint>(1));
            int _e61 = shifted(_e58);
            local_5 = _e61;
        } else {
            int _e63 = b;
            b = as_type<int>(as_type<uint>(_e63) + as_type<uint>(1));
            int _e66 = shifted(_e63);
            local_5 = _e66;
        }
        int _e69 = local_5;
        uint _e70 = base;
        local_4 = static_cast<uint>(_e70 + 1u);
        uint _e75 = local_4;
        local_49 = _e75;
        uint _e77 = local_49;
        out[_e77] = _e69;
        int _e79 = a;
        int _e82 = b;
        uint _e84 = base;
        local_6 = static_cast<uint>(_e84 + 2u);
        uint _e89 = local_6;
        local_50 = _e89;
        uint _e91 = local_50;
        out[_e91] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e79) * as_type<uint>(10))) + as_type<uint>(_e82));
        bool _e93 = choose_a;
        if (_e93) {
            int _e94 = a;
            a = as_type<int>(as_type<uint>(_e94) + as_type<uint>(1));
            discard(_e94);
        } else {
            int _e97 = b;
            b = as_type<int>(as_type<uint>(_e97) + as_type<uint>(1));
            discard(_e97);
        }
        int _e100 = a;
        int _e103 = b;
        uint _e105 = base;
        local_7 = static_cast<uint>(_e105 + 3u);
        uint _e110 = local_7;
        local_51 = _e110;
        uint _e112 = local_51;
        out[_e112] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e100) * as_type<uint>(10))) + as_type<uint>(_e103));
        index_a = 0;
        index_b = 0;
        bool _e118 = choose_a;
        if (_e118) {
            int _e119 = index_a;
            index_a = as_type<int>(as_type<uint>(_e119) + as_type<uint>(1));
            local_8 = static_cast<uint>(_e119);
        } else {
            int _e124 = index_b;
            index_b = as_type<int>(as_type<uint>(_e124) + as_type<uint>(1));
            local_9 = static_cast<uint>(_e124);
        }
        int _e129 = index_a;
        int _e132 = index_b;
        uint _e134 = base;
        local_10 = static_cast<uint>(_e134 + 4u);
        uint _e139 = local_10;
        local_52 = _e139;
        uint _e141 = local_52;
        out[_e141] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e129) * as_type<uint>(10))) + as_type<uint>(_e132));
        a = 3;
        b = 5;
        bool _e145 = choose_a;
        if (_e145) {
            a = 7;
        } else {
            b = 7;
        }
        int _e148 = a;
        int _e151 = b;
        uint _e153 = base;
        local_11 = static_cast<uint>(_e153 + 5u);
        uint _e158 = local_11;
        local_53 = _e158;
        uint _e160 = local_53;
        out[_e160] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e148) * as_type<uint>(10))) + as_type<uint>(_e151));
        bool _e162 = choose_a;
        if (_e162) {
            int _e163 = a;
            a = as_type<int>(as_type<uint>(_e163) + as_type<uint>(2));
        } else {
            int _e166 = b;
            b = as_type<int>(as_type<uint>(_e166) + as_type<uint>(2));
        }
        int _e169 = a;
        int _e172 = b;
        uint _e174 = base;
        local_12 = static_cast<uint>(_e174 + 6u);
        uint _e179 = local_12;
        local_54 = _e179;
        uint _e181 = local_54;
        out[_e181] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e169) * as_type<uint>(10))) + as_type<uint>(_e172));
        bool _e183 = choose_a;
        if (_e183) {
            int _e184 = a;
            a = as_type<int>(as_type<uint>(_e184) + as_type<uint>(1));
            int _e187 = a;
            local_14 = _e187;
        } else {
            int _e189 = b;
            b = as_type<int>(as_type<uint>(_e189) + as_type<uint>(1));
            int _e192 = b;
            local_14 = _e192;
        }
        int _e195 = local_14;
        uint _e196 = base;
        local_13 = static_cast<uint>(_e196 + 7u);
        uint _e201 = local_13;
        local_55 = _e201;
        uint _e203 = local_55;
        out[_e203] = _e195;
        bool _e205 = choose_a;
        if (_e205) {
            int _e206 = a;
            a = as_type<int>(as_type<uint>(_e206) + as_type<uint>(1));
            local_16 = _e206;
        } else {
            int _e210 = b;
            b = as_type<int>(as_type<uint>(_e210) + as_type<uint>(1));
            local_16 = _e210;
        }
        int _e215 = local_16;
        uint _e216 = base;
        local_15 = static_cast<uint>(_e216 + 8u);
        uint _e221 = local_15;
        local_56 = _e221;
        uint _e223 = local_56;
        out[_e223] = _e215;
        int _e225 = a;
        int _e228 = b;
        uint _e230 = base;
        local_17 = static_cast<uint>(_e230 + 9u);
        uint _e235 = local_17;
        local_57 = _e235;
        uint _e237 = local_57;
        out[_e237] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e225) * as_type<uint>(100))) + as_type<uint>(_e228));
        bool _e239 = choose_a;
        c = static_cast<int>(_e239);
        b = 7;
        int _e243 = c;
        if (_e243 != 0) {
            c = 0;
            int _e247 = c;
            c = as_type<int>(as_type<uint>(_e247) + as_type<uint>(1));
            local_19 = _e247;
        } else {
            b = 0;
            int _e252 = b;
            b = as_type<int>(as_type<uint>(_e252) + as_type<uint>(1));
            local_19 = _e252;
        }
        int _e257 = local_19;
        uint _e258 = base;
        local_18 = static_cast<uint>(_e258 + 10u);
        uint _e263 = local_18;
        local_58 = _e263;
        uint _e265 = local_58;
        out[_e265] = _e257;
        int _e267 = c;
        int _e270 = b;
        uint _e272 = base;
        local_20 = static_cast<uint>(_e272 + 11u);
        uint _e277 = local_20;
        local_59 = _e277;
        uint _e279 = local_59;
        out[_e279] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e267) * as_type<uint>(10))) + as_type<uint>(_e270));
        condition = 0;
        a = 2;
        b = 4;
        condition = 1;
        int _e286 = condition;
        int _e287 = condition;
        if (_e287 != 0) {
            a = _e286;
        } else {
            b = _e286;
        }
        int _e290 = a;
        int _e293 = b;
        uint _e295 = base;
        local_21 = static_cast<uint>(_e295 + 12u);
        uint _e300 = local_21;
        local_60 = _e300;
        uint _e302 = local_60;
        out[_e302] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e290) * as_type<uint>(10))) + as_type<uint>(_e293));
        a = 2;
        b = 4;
        c = 6;
        bool _e307 = choose_a;
        if (_e307) {
            if (naga_mod(i, 4u) == 0u) {
                int _e312 = a;
                a = as_type<int>(as_type<uint>(_e312) + as_type<uint>(3));
            } else {
                int _e315 = b;
                b = as_type<int>(as_type<uint>(_e315) + as_type<uint>(3));
            }
        } else {
            int _e318 = c;
            c = as_type<int>(as_type<uint>(_e318) + as_type<uint>(3));
        }
        int _e321 = a;
        int _e324 = b;
        int _e328 = c;
        uint _e330 = base;
        local_22 = static_cast<uint>(_e330 + 13u);
        uint _e335 = local_22;
        local_61 = _e335;
        uint _e337 = local_61;
        out[_e337] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e321) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e324) * as_type<uint>(10))))) + as_type<uint>(_e328));
        lane = threadIdx.x;
        uint _e341 = lane;
        shared_values.inner[_e341] = 20;
        local_value = 10;
        bool _e347 = choose_a;
        if (_e347) {
            int _e348 = local_value;
            local_value = as_type<int>(as_type<uint>(_e348) + as_type<uint>(5));
        } else {
            uint _e351 = lane;
            int _e353 = shared_values.inner[_e351];
            shared_values.inner[_e351] = as_type<int>(as_type<uint>(_e353) + as_type<uint>(5));
        }
        int _e356 = local_value;
        uint _e359 = lane;
        int _e361 = shared_values.inner[_e359];
        uint _e363 = base;
        local_23 = static_cast<uint>(_e363 + 14u);
        uint _e368 = local_23;
        local_62 = _e368;
        uint _e370 = local_62;
        out[_e370] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e356) * as_type<uint>(100))) + as_type<uint>(_e361));
        bool _e372 = choose_a;
        if (_e372) {
            uint _e373 = lane;
            shared_values.inner[_e373] = 30;
        } else {
            uint _e376 = base;
            local_24 = static_cast<uint>(_e376 + 15u);
            uint _e381 = local_24;
            local_63 = _e381;
            uint _e383 = local_63;
            out[_e383] = 30;
        }
        uint _e386 = lane;
        int _e388 = shared_values.inner[_e386];
        uint _e389 = base;
        local_25 = static_cast<uint>(_e389 + 16u);
        uint _e394 = local_25;
        local_64 = _e394;
        uint _e396 = local_64;
        out[_e396] = _e388;
        bool _e398 = choose_a;
        if (_e398) {
            local_27 = 1.5;
        } else {
            local_27 = static_cast<float>(3);
        }
        float _e405 = local_27;
        uint _e406 = base;
        local_26 = static_cast<uint>(_e406 + 17u);
        uint _e412 = local_26;
        local_65 = _e412;
        uint _e414 = local_65;
        out[_e414] = naga_f2i32(_e405);
        bool _e416 = choose_a;
        if (_e416) {
            local_29 = static_cast<uint>(naga_neg(1));
        } else {
            local_29 = 2u;
        }
        uint _e424 = local_29;
        uint _e425 = base;
        local_28 = static_cast<uint>(_e425 + 18u);
        uint _e431 = local_28;
        local_66 = _e431;
        uint _e433 = local_66;
        out[_e433] = static_cast<int>(_e424);
        bool _e435 = choose_a;
        if (_e435) {
            local_31 = true;
        } else {
            local_31 = false;
        }
        bool _e441 = local_31;
        uint _e442 = base;
        local_30 = static_cast<uint>(_e442 + 19u);
        uint _e448 = local_30;
        local_67 = _e448;
        uint _e450 = local_67;
        out[_e450] = static_cast<int>(_e441);
        bool _e452 = choose_a;
        if (_e452) {
            local_33 = static_cast<int>(true);
        } else {
            local_33 = 2;
        }
        int _e459 = local_33;
        uint _e460 = base;
        local_32 = static_cast<uint>(_e460 + 20u);
        uint _e465 = local_32;
        local_68 = _e465;
        uint _e467 = local_68;
        out[_e467] = _e459;
        bool _e469 = choose_a;
        if (_e469) {
            local_35 = 4u;
        } else {
            local_35 = 8u;
        }
        uint _e475 = local_35;
        uint _e476 = base;
        local_34 = static_cast<uint>(_e476 + 21u);
        uint _e482 = local_34;
        local_69 = _e482;
        uint _e484 = local_69;
        out[_e484] = static_cast<int>(_e475);
        a = 3;
        shift_value = 2;
        bool _e489 = choose_a;
        if (_e489) {
            int _e490 = shift_value;
            local_37 = _e490;
        } else {
            int _e492 = a;
            local_37 = _e492;
        }
        int _e495 = local_37;
        shift_value = 1;
        int _e497 = shift_value;
        local_38 = static_cast<uint>(_e497);
        uint _e500 = local_38;
        uint _e502 = base;
        local_36 = static_cast<uint>(_e502 + 22u);
        uint _e507 = local_36;
        local_70 = _e507;
        uint _e509 = local_70;
        out[_e509] = _e495 << _e500;
        value = 3;
        other = 7;
        bool _e515 = choose_a;
        if (_e515) {
            int _e516 = value;
            local_40 = _e516;
        } else {
            int _e518 = other;
            local_40 = _e518;
        }
        int _e521 = local_40;
        int _e522 = value;
        value = as_type<int>(as_type<uint>(_e522) + as_type<uint>(1));
        int _e525 = pair(_e521, _e522);
        uint _e526 = base;
        local_39 = static_cast<uint>(_e526 + 23u);
        uint _e531 = local_39;
        local_71 = _e531;
        uint _e533 = local_71;
        out[_e533] = _e525;
        count = 0;
        left = 0;
        right = 0;
        {
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    bool _e550 = choose_a;
                    if (_e550) {
                        int _e551 = left;
                        left = as_type<int>(as_type<uint>(_e551) + as_type<uint>(1));
                    } else {
                        int _e554 = right;
                        right = as_type<int>(as_type<uint>(_e554) + as_type<uint>(1));
                    }
                }
                loop_init = false;
                int _e541 = count;
                if (_e541 < 3) {
                } else {
                    break;
                }
                int _e544 = count;
                count = as_type<int>(as_type<uint>(_e544) + as_type<uint>(1));
                int _e547 = count;
                if (_e547 == 2) {
                    continue;
                }
            }
        }
        int _e557 = left;
        int _e560 = right;
        int _e564 = count;
        uint _e566 = base;
        local_41 = static_cast<uint>(_e566 + 24u);
        uint _e571 = local_41;
        local_72 = _e571;
        uint _e573 = local_72;
        out[_e573] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e557) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e560) * as_type<uint>(10))))) + as_type<uint>(_e564));
    }
}
