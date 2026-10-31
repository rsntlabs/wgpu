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
            local_1 = static_cast<uint>(i);
            uint _e22 = local_1;
            local_44 = static_cast<uint>(_e22);
            uint _e25 = local_44;
            int _e28 = input_a[_e25];
            local_45 = _e28;
            int _e30 = local_45;
            local_42 = _e30;
            int _e32 = local_42;
            local_3 = _e32;
        } else {
            local_2 = static_cast<uint>(i);
            uint _e36 = local_2;
            local_46 = static_cast<uint>(_e36);
            uint _e39 = local_46;
            int _e42 = input_b[_e39];
            local_47 = _e42;
            int _e44 = local_47;
            local_43 = _e44;
            int _e46 = local_43;
            local_3 = _e46;
        }
        int _e49 = local_3;
        uint _e50 = base;
        local = static_cast<uint>(_e50);
        uint _e53 = local;
        local_48 = static_cast<uint>(_e53);
        uint _e56 = local_48;
        out[_e56] = _e49;
        a = 3;
        b = 5;
        bool _e63 = choose_a;
        if (_e63) {
            int _e64 = a;
            a = as_type<int>(as_type<uint>(_e64) + as_type<uint>(1));
            int _e67 = shifted(_e64);
            local_5 = _e67;
        } else {
            int _e69 = b;
            b = as_type<int>(as_type<uint>(_e69) + as_type<uint>(1));
            int _e72 = shifted(_e69);
            local_5 = _e72;
        }
        int _e75 = local_5;
        uint _e76 = base;
        local_4 = static_cast<uint>(_e76 + 1u);
        uint _e81 = local_4;
        local_49 = static_cast<uint>(_e81);
        uint _e84 = local_49;
        out[_e84] = _e75;
        int _e86 = a;
        int _e89 = b;
        uint _e91 = base;
        local_6 = static_cast<uint>(_e91 + 2u);
        uint _e96 = local_6;
        local_50 = static_cast<uint>(_e96);
        uint _e99 = local_50;
        out[_e99] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e86) * as_type<uint>(10))) + as_type<uint>(_e89));
        bool _e101 = choose_a;
        if (_e101) {
            int _e102 = a;
            a = as_type<int>(as_type<uint>(_e102) + as_type<uint>(1));
            discard(_e102);
        } else {
            int _e105 = b;
            b = as_type<int>(as_type<uint>(_e105) + as_type<uint>(1));
            discard(_e105);
        }
        int _e108 = a;
        int _e111 = b;
        uint _e113 = base;
        local_7 = static_cast<uint>(_e113 + 3u);
        uint _e118 = local_7;
        local_51 = static_cast<uint>(_e118);
        uint _e121 = local_51;
        out[_e121] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e108) * as_type<uint>(10))) + as_type<uint>(_e111));
        index_a = 0;
        index_b = 0;
        bool _e127 = choose_a;
        if (_e127) {
            int _e128 = index_a;
            index_a = as_type<int>(as_type<uint>(_e128) + as_type<uint>(1));
            local_8 = static_cast<uint>(_e128);
        } else {
            int _e133 = index_b;
            index_b = as_type<int>(as_type<uint>(_e133) + as_type<uint>(1));
            local_9 = static_cast<uint>(_e133);
        }
        int _e138 = index_a;
        int _e141 = index_b;
        uint _e143 = base;
        local_10 = static_cast<uint>(_e143 + 4u);
        uint _e148 = local_10;
        local_52 = static_cast<uint>(_e148);
        uint _e151 = local_52;
        out[_e151] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e138) * as_type<uint>(10))) + as_type<uint>(_e141));
        a = 3;
        b = 5;
        bool _e155 = choose_a;
        if (_e155) {
            a = 7;
        } else {
            b = 7;
        }
        int _e158 = a;
        int _e161 = b;
        uint _e163 = base;
        local_11 = static_cast<uint>(_e163 + 5u);
        uint _e168 = local_11;
        local_53 = static_cast<uint>(_e168);
        uint _e171 = local_53;
        out[_e171] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e158) * as_type<uint>(10))) + as_type<uint>(_e161));
        bool _e173 = choose_a;
        if (_e173) {
            int _e174 = a;
            a = as_type<int>(as_type<uint>(_e174) + as_type<uint>(2));
        } else {
            int _e177 = b;
            b = as_type<int>(as_type<uint>(_e177) + as_type<uint>(2));
        }
        int _e180 = a;
        int _e183 = b;
        uint _e185 = base;
        local_12 = static_cast<uint>(_e185 + 6u);
        uint _e190 = local_12;
        local_54 = static_cast<uint>(_e190);
        uint _e193 = local_54;
        out[_e193] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e180) * as_type<uint>(10))) + as_type<uint>(_e183));
        bool _e195 = choose_a;
        if (_e195) {
            int _e196 = a;
            a = as_type<int>(as_type<uint>(_e196) + as_type<uint>(1));
            int _e199 = a;
            local_14 = _e199;
        } else {
            int _e201 = b;
            b = as_type<int>(as_type<uint>(_e201) + as_type<uint>(1));
            int _e204 = b;
            local_14 = _e204;
        }
        int _e207 = local_14;
        uint _e208 = base;
        local_13 = static_cast<uint>(_e208 + 7u);
        uint _e213 = local_13;
        local_55 = static_cast<uint>(_e213);
        uint _e216 = local_55;
        out[_e216] = _e207;
        bool _e218 = choose_a;
        if (_e218) {
            int _e219 = a;
            a = as_type<int>(as_type<uint>(_e219) + as_type<uint>(1));
            local_16 = _e219;
        } else {
            int _e223 = b;
            b = as_type<int>(as_type<uint>(_e223) + as_type<uint>(1));
            local_16 = _e223;
        }
        int _e228 = local_16;
        uint _e229 = base;
        local_15 = static_cast<uint>(_e229 + 8u);
        uint _e234 = local_15;
        local_56 = static_cast<uint>(_e234);
        uint _e237 = local_56;
        out[_e237] = _e228;
        int _e239 = a;
        int _e242 = b;
        uint _e244 = base;
        local_17 = static_cast<uint>(_e244 + 9u);
        uint _e249 = local_17;
        local_57 = static_cast<uint>(_e249);
        uint _e252 = local_57;
        out[_e252] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e239) * as_type<uint>(100))) + as_type<uint>(_e242));
        bool _e254 = choose_a;
        c = static_cast<int>(_e254);
        b = 7;
        int _e258 = c;
        if (_e258 != 0) {
            c = 0;
            int _e262 = c;
            c = as_type<int>(as_type<uint>(_e262) + as_type<uint>(1));
            local_19 = _e262;
        } else {
            b = 0;
            int _e267 = b;
            b = as_type<int>(as_type<uint>(_e267) + as_type<uint>(1));
            local_19 = _e267;
        }
        int _e272 = local_19;
        uint _e273 = base;
        local_18 = static_cast<uint>(_e273 + 10u);
        uint _e278 = local_18;
        local_58 = static_cast<uint>(_e278);
        uint _e281 = local_58;
        out[_e281] = _e272;
        int _e283 = c;
        int _e286 = b;
        uint _e288 = base;
        local_20 = static_cast<uint>(_e288 + 11u);
        uint _e293 = local_20;
        local_59 = static_cast<uint>(_e293);
        uint _e296 = local_59;
        out[_e296] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e283) * as_type<uint>(10))) + as_type<uint>(_e286));
        condition = 0;
        a = 2;
        b = 4;
        condition = 1;
        int _e303 = condition;
        int _e304 = condition;
        if (_e304 != 0) {
            a = _e303;
        } else {
            b = _e303;
        }
        int _e307 = a;
        int _e310 = b;
        uint _e312 = base;
        local_21 = static_cast<uint>(_e312 + 12u);
        uint _e317 = local_21;
        local_60 = static_cast<uint>(_e317);
        uint _e320 = local_60;
        out[_e320] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e307) * as_type<uint>(10))) + as_type<uint>(_e310));
        a = 2;
        b = 4;
        c = 6;
        bool _e325 = choose_a;
        if (_e325) {
            if (naga_mod(i, 4u) == 0u) {
                int _e330 = a;
                a = as_type<int>(as_type<uint>(_e330) + as_type<uint>(3));
            } else {
                int _e333 = b;
                b = as_type<int>(as_type<uint>(_e333) + as_type<uint>(3));
            }
        } else {
            int _e336 = c;
            c = as_type<int>(as_type<uint>(_e336) + as_type<uint>(3));
        }
        int _e339 = a;
        int _e342 = b;
        int _e346 = c;
        uint _e348 = base;
        local_22 = static_cast<uint>(_e348 + 13u);
        uint _e353 = local_22;
        local_61 = static_cast<uint>(_e353);
        uint _e356 = local_61;
        out[_e356] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e339) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e342) * as_type<uint>(10))))) + as_type<uint>(_e346));
        lane = threadIdx.x;
        uint _e360 = lane;
        shared_values.inner[_e360] = 20;
        local_value = 10;
        bool _e366 = choose_a;
        if (_e366) {
            int _e367 = local_value;
            local_value = as_type<int>(as_type<uint>(_e367) + as_type<uint>(5));
        } else {
            uint _e370 = lane;
            int _e372 = shared_values.inner[_e370];
            shared_values.inner[_e370] = as_type<int>(as_type<uint>(_e372) + as_type<uint>(5));
        }
        int _e375 = local_value;
        uint _e378 = lane;
        int _e380 = shared_values.inner[_e378];
        uint _e382 = base;
        local_23 = static_cast<uint>(_e382 + 14u);
        uint _e387 = local_23;
        local_62 = static_cast<uint>(_e387);
        uint _e390 = local_62;
        out[_e390] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e375) * as_type<uint>(100))) + as_type<uint>(_e380));
        bool _e392 = choose_a;
        if (_e392) {
            uint _e393 = lane;
            shared_values.inner[_e393] = 30;
        } else {
            uint _e396 = base;
            local_24 = static_cast<uint>(_e396 + 15u);
            uint _e401 = local_24;
            local_63 = static_cast<uint>(_e401);
            uint _e404 = local_63;
            out[_e404] = 30;
        }
        uint _e407 = lane;
        int _e409 = shared_values.inner[_e407];
        uint _e410 = base;
        local_25 = static_cast<uint>(_e410 + 16u);
        uint _e415 = local_25;
        local_64 = static_cast<uint>(_e415);
        uint _e418 = local_64;
        out[_e418] = _e409;
        bool _e420 = choose_a;
        if (_e420) {
            local_27 = 1.5;
        } else {
            local_27 = static_cast<float>(3);
        }
        float _e427 = local_27;
        uint _e428 = base;
        local_26 = static_cast<uint>(_e428 + 17u);
        uint _e434 = local_26;
        local_65 = static_cast<uint>(_e434);
        uint _e437 = local_65;
        out[_e437] = naga_f2i32(_e427);
        bool _e439 = choose_a;
        if (_e439) {
            local_29 = static_cast<uint>(naga_neg(1));
        } else {
            local_29 = 2u;
        }
        uint _e447 = local_29;
        uint _e448 = base;
        local_28 = static_cast<uint>(_e448 + 18u);
        uint _e454 = local_28;
        local_66 = static_cast<uint>(_e454);
        uint _e457 = local_66;
        out[_e457] = static_cast<int>(_e447);
        bool _e459 = choose_a;
        if (_e459) {
            local_31 = true;
        } else {
            local_31 = false;
        }
        bool _e465 = local_31;
        uint _e466 = base;
        local_30 = static_cast<uint>(_e466 + 19u);
        uint _e472 = local_30;
        local_67 = static_cast<uint>(_e472);
        uint _e475 = local_67;
        out[_e475] = static_cast<int>(_e465);
        bool _e477 = choose_a;
        if (_e477) {
            local_33 = static_cast<int>(true);
        } else {
            local_33 = 2;
        }
        int _e484 = local_33;
        uint _e485 = base;
        local_32 = static_cast<uint>(_e485 + 20u);
        uint _e490 = local_32;
        local_68 = static_cast<uint>(_e490);
        uint _e493 = local_68;
        out[_e493] = _e484;
        bool _e495 = choose_a;
        if (_e495) {
            local_35 = 4u;
        } else {
            local_35 = 8u;
        }
        uint _e501 = local_35;
        uint _e502 = base;
        local_34 = static_cast<uint>(_e502 + 21u);
        uint _e508 = local_34;
        local_69 = static_cast<uint>(_e508);
        uint _e511 = local_69;
        out[_e511] = static_cast<int>(_e501);
        a = 3;
        shift_value = 2;
        bool _e516 = choose_a;
        if (_e516) {
            int _e517 = shift_value;
            local_37 = _e517;
        } else {
            int _e519 = a;
            local_37 = _e519;
        }
        int _e522 = local_37;
        shift_value = 1;
        int _e524 = shift_value;
        local_38 = static_cast<uint>(_e524);
        uint _e527 = local_38;
        uint _e529 = base;
        local_36 = static_cast<uint>(_e529 + 22u);
        uint _e534 = local_36;
        local_70 = static_cast<uint>(_e534);
        uint _e537 = local_70;
        out[_e537] = _e522 << _e527;
        value = 3;
        other = 7;
        bool _e543 = choose_a;
        if (_e543) {
            int _e544 = value;
            local_40 = _e544;
        } else {
            int _e546 = other;
            local_40 = _e546;
        }
        int _e549 = local_40;
        int _e550 = value;
        value = as_type<int>(as_type<uint>(_e550) + as_type<uint>(1));
        int _e553 = pair(_e549, _e550);
        uint _e554 = base;
        local_39 = static_cast<uint>(_e554 + 23u);
        uint _e559 = local_39;
        local_71 = static_cast<uint>(_e559);
        uint _e562 = local_71;
        out[_e562] = _e553;
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
                    bool _e579 = choose_a;
                    if (_e579) {
                        int _e580 = left;
                        left = as_type<int>(as_type<uint>(_e580) + as_type<uint>(1));
                    } else {
                        int _e583 = right;
                        right = as_type<int>(as_type<uint>(_e583) + as_type<uint>(1));
                    }
                }
                loop_init = false;
                int _e570 = count;
                if (_e570 < 3) {
                } else {
                    break;
                }
                int _e573 = count;
                count = as_type<int>(as_type<uint>(_e573) + as_type<uint>(1));
                int _e576 = count;
                if (_e576 == 2) {
                    continue;
                }
            }
        }
        int _e586 = left;
        int _e589 = right;
        int _e593 = count;
        uint _e595 = base;
        local_41 = static_cast<uint>(_e595 + 24u);
        uint _e600 = local_41;
        local_72 = static_cast<uint>(_e600);
        uint _e603 = local_72;
        out[_e603] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e586) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e589) * as_type<uint>(10))))) + as_type<uint>(_e593));
    }
}
