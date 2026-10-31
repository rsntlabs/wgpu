// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_3[1];
typedef int type_4[1];
struct type_5 {
    uint value;
    char _pad1[12];
};
struct type_6 {
    uint inner[64];
};
struct type_9 {
    uint inner[2];
};

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int transform(
    float value,
    float multiplier,
    int offset
) {
    return naga_f2i32((value * multiplier) + static_cast<float>(offset));
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct scalar_aliasesInput {
};
kernel void scalar_aliases(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_3& out_1 [[user(fake0)]]
, device type_4 const& input_1 [[user(fake0)]]
, constant type_5& n [[user(fake0)]]
, threadgroup type_6& shared_values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_9 out = {};
    type_9 input = {};
    uint base = {};
    uint lane = {};
    type_9 local = {};
    uint local_1 = {};
    type_9 local_2 = {};
    uint local_3 = {};
    type_9 local_4 = {};
    uint local_5 = {};
    int signed_count = {};
    type_9 local_6 = {};
    uint local_7 = {};
    float fraction = {};
    type_9 local_8 = {};
    uint local_9 = {};
    int after_block = {};
    type_9 local_10 = {};
    uint local_11 = {};
    float coefficient = {};
    type_9 local_12 = {};
    uint local_13 = {};
    bool selected = {};
    type_9 local_14 = {};
    uint local_15 = {};
    int total = {};
    int current = {};
    type_9 local_16 = {};
    uint local_17 = {};
    float after_loop = {};
    type_9 local_18 = {};
    uint local_19 = {};
    type_9 local_20 = {};
    uint local_21 = {};
    int local_22 = {};
    type_9 local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    type_9 local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    int local_29 = {};
    type_9 local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    type_9 local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    type_9 local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    type_9 local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    type_9 local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    type_9 local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    type_9 local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    type_9 local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    type_9 local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    out = type_9 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    input = type_9 {};
    input.inner[0] = 1u;
    input.inner[1] = 0u;
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 10u;
        lane = threadIdx.x;
        uint _e30 = lane;
        shared_values.inner[_e30] = i + 10u;
        uint _e33 = lane;
        uint _e35 = shared_values.inner[_e33];
        type_9 _e37 = out;
        local = _e37;
        uint _e39 = base;
        local_1 = static_cast<uint>(_e39);
        type_9 _e42 = local;
        local_23 = _e42;
        uint _e44 = local_1;
        uint _e46 = local_23.inner[1];
        local_23.inner[1] = _e46 + _e44;
        uint _e50 = local_23.inner[0];
        local_24 = static_cast<uint>(_e50);
        uint _e54 = local_23.inner[1];
        local_25 = static_cast<uint>(_e54);
        uint _e57 = local_25;
        out_1[_e57] = _e35;
        type_9 _e61 = input;
        local_4 = _e61;
        local_5 = static_cast<uint>(i);
        type_9 _e65 = local_4;
        local_26 = _e65;
        uint _e67 = local_5;
        uint _e69 = local_26.inner[1];
        local_26.inner[1] = _e69 + _e67;
        uint _e73 = local_26.inner[0];
        local_27 = static_cast<uint>(_e73);
        uint _e77 = local_26.inner[1];
        local_28 = static_cast<uint>(_e77);
        uint _e80 = local_28;
        int _e83 = input_1[_e80];
        local_29 = _e83;
        int _e85 = local_29;
        local_22 = _e85;
        int _e87 = local_22;
        int _e91 = transform(static_cast<float>(_e87), 2.0, 1);
        type_9 _e93 = out;
        local_2 = _e93;
        uint _e95 = base;
        local_3 = static_cast<uint>(_e95 + 1u);
        type_9 _e100 = local_2;
        local_30 = _e100;
        uint _e102 = local_3;
        uint _e104 = local_30.inner[1];
        local_30.inner[1] = _e104 + _e102;
        uint _e108 = local_30.inner[0];
        local_31 = static_cast<uint>(_e108);
        uint _e112 = local_30.inner[1];
        local_32 = static_cast<uint>(_e112);
        uint _e115 = local_32;
        out_1[_e115] = static_cast<uint>(_e91);
        signed_count = naga_neg(3);
        int _e120 = signed_count;
        type_9 _e122 = out;
        local_6 = _e122;
        uint _e124 = base;
        local_7 = static_cast<uint>(_e124 + 2u);
        type_9 _e129 = local_6;
        local_33 = _e129;
        uint _e131 = local_7;
        uint _e133 = local_33.inner[1];
        local_33.inner[1] = _e133 + _e131;
        uint _e137 = local_33.inner[0];
        local_34 = static_cast<uint>(_e137);
        uint _e141 = local_33.inner[1];
        local_35 = static_cast<uint>(_e141);
        uint _e144 = local_35;
        out_1[_e144] = static_cast<uint>(_e120);
        {
            fraction = 3.75;
            float _e148 = fraction;
            type_9 _e150 = out;
            local_8 = _e150;
            uint _e152 = base;
            local_9 = static_cast<uint>(_e152 + 3u);
            type_9 _e157 = local_8;
            local_36 = _e157;
            uint _e159 = local_9;
            uint _e161 = local_36.inner[1];
            local_36.inner[1] = _e161 + _e159;
            uint _e165 = local_36.inner[0];
            local_37 = static_cast<uint>(_e165);
            uint _e169 = local_36.inner[1];
            local_38 = static_cast<uint>(_e169);
            uint _e172 = local_38;
            out_1[_e172] = naga_f2u32(_e148);
        }
        after_block = naga_neg(5);
        int _e177 = after_block;
        type_9 _e179 = out;
        local_10 = _e179;
        uint _e181 = base;
        local_11 = static_cast<uint>(_e181 + 4u);
        type_9 _e186 = local_10;
        local_39 = _e186;
        uint _e188 = local_11;
        uint _e190 = local_39.inner[1];
        local_39.inner[1] = _e190 + _e188;
        uint _e194 = local_39.inner[0];
        local_40 = static_cast<uint>(_e194);
        uint _e198 = local_39.inner[1];
        local_41 = static_cast<uint>(_e198);
        uint _e201 = local_41;
        out_1[_e201] = static_cast<uint>(_e177);
        coefficient = 1.25;
        float _e205 = coefficient;
        type_9 _e209 = out;
        local_12 = _e209;
        uint _e211 = base;
        local_13 = static_cast<uint>(_e211 + 5u);
        type_9 _e216 = local_12;
        local_42 = _e216;
        uint _e218 = local_13;
        uint _e220 = local_42.inner[1];
        local_42.inner[1] = _e220 + _e218;
        uint _e224 = local_42.inner[0];
        local_43 = static_cast<uint>(_e224);
        uint _e228 = local_42.inner[1];
        local_44 = static_cast<uint>(_e228);
        uint _e231 = local_44;
        out_1[_e231] = naga_f2u32(_e205 * 4.0);
        selected = naga_mod(i, 2u) == 0u;
        bool _e238 = selected;
        type_9 _e240 = out;
        local_14 = _e240;
        uint _e242 = base;
        local_15 = static_cast<uint>(_e242 + 6u);
        type_9 _e247 = local_14;
        local_45 = _e247;
        uint _e249 = local_15;
        uint _e251 = local_45.inner[1];
        local_45.inner[1] = _e251 + _e249;
        uint _e255 = local_45.inner[0];
        local_46 = static_cast<uint>(_e255);
        uint _e259 = local_45.inner[1];
        local_47 = static_cast<uint>(_e259);
        uint _e262 = local_47;
        out_1[_e262] = static_cast<uint>(_e238);
        total = 0;
        {
            uint2 loop_bound = uint2(4294967295u);
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                int _e266 = total;
                if (_e266 < 3) {
                } else {
                    break;
                }
                int _e269 = total;
                current = _e269;
                int _e271 = current;
                total = as_type<int>(as_type<uint>(_e271) + as_type<uint>(1));
            }
        }
        int _e274 = total;
        type_9 _e276 = out;
        local_16 = _e276;
        uint _e278 = base;
        local_17 = static_cast<uint>(_e278 + 7u);
        type_9 _e283 = local_16;
        local_48 = _e283;
        uint _e285 = local_17;
        uint _e287 = local_48.inner[1];
        local_48.inner[1] = _e287 + _e285;
        uint _e291 = local_48.inner[0];
        local_49 = static_cast<uint>(_e291);
        uint _e295 = local_48.inner[1];
        local_50 = static_cast<uint>(_e295);
        uint _e298 = local_50;
        out_1[_e298] = static_cast<uint>(_e274);
        after_loop = 1.5;
        float _e302 = after_loop;
        type_9 _e306 = out;
        local_18 = _e306;
        uint _e308 = base;
        local_19 = static_cast<uint>(_e308 + 8u);
        type_9 _e313 = local_18;
        local_51 = _e313;
        uint _e315 = local_19;
        uint _e317 = local_51.inner[1];
        local_51.inner[1] = _e317 + _e315;
        uint _e321 = local_51.inner[0];
        local_52 = static_cast<uint>(_e321);
        uint _e325 = local_51.inner[1];
        local_53 = static_cast<uint>(_e325);
        uint _e328 = local_53;
        out_1[_e328] = naga_f2u32(_e302 * 2.0);
        type_9 _e332 = out;
        local_20 = _e332;
        uint _e334 = base;
        local_21 = static_cast<uint>(_e334 + 9u);
        type_9 _e339 = local_20;
        local_54 = _e339;
        uint _e341 = local_21;
        uint _e343 = local_54.inner[1];
        local_54.inner[1] = _e343 + _e341;
        uint _e347 = local_54.inner[0];
        local_55 = static_cast<uint>(_e347);
        uint _e351 = local_54.inner[1];
        local_56 = static_cast<uint>(_e351);
        uint _e354 = local_56;
        out_1[_e354] = naga_f2u32(static_cast<float>(n_1));
    }
}
