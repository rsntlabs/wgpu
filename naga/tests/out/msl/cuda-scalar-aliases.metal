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
    float value_1 = {};
    float multiplier_1 = {};
    int offset_1 = {};
    value_1 = value;
    multiplier_1 = multiplier;
    offset_1 = offset;
    float _e6 = value_1;
    float _e7 = multiplier_1;
    int _e9 = offset_1;
    return naga_f2i32((_e6 * _e7) + static_cast<float>(_e9));
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
, constant type_5& n_1 [[user(fake0)]]
, threadgroup type_6& shared_values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_9 out = {};
    type_9 input = {};
    uint n = {};
    uint i = {};
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
    uint _e18 = n_1.value;
    n = _e18;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e26 = i;
    uint _e27 = n;
    if (_e26 < _e27) {
        uint _e29 = i;
        base = _e29 * 10u;
        lane = threadIdx.x;
        uint _e35 = i;
        uint _e38 = lane;
        shared_values.inner[_e38] = _e35 + 10u;
        uint _e41 = lane;
        uint _e43 = shared_values.inner[_e41];
        type_9 _e46 = out;
        local = _e46;
        uint _e47 = base;
        local_1 = static_cast<uint>(_e47);
        type_9 _e51 = local;
        local_23 = _e51;
        uint _e52 = local_1;
        uint _e54 = local_23.inner[1];
        local_23.inner[1] = _e54 + _e52;
        uint _e58 = local_23.inner[0];
        local_24 = static_cast<uint>(_e58);
        uint _e62 = local_23.inner[1];
        local_25 = static_cast<uint>(_e62);
        uint _e65 = local_25;
        out_1[_e65] = _e43;
        type_9 _e69 = input;
        local_4 = _e69;
        uint _e70 = i;
        local_5 = static_cast<uint>(_e70);
        type_9 _e74 = local_4;
        local_26 = _e74;
        uint _e75 = local_5;
        uint _e77 = local_26.inner[1];
        local_26.inner[1] = _e77 + _e75;
        uint _e81 = local_26.inner[0];
        local_27 = static_cast<uint>(_e81);
        uint _e85 = local_26.inner[1];
        local_28 = static_cast<uint>(_e85);
        uint _e89 = local_28;
        int _e91 = input_1[_e89];
        local_29 = _e91;
        int _e92 = local_29;
        local_22 = _e92;
        int _e94 = local_22;
        int _e98 = transform(static_cast<float>(_e94), 2.0, 1);
        type_9 _e101 = out;
        local_2 = _e101;
        uint _e102 = base;
        local_3 = static_cast<uint>(_e102 + 1u);
        type_9 _e108 = local_2;
        local_30 = _e108;
        uint _e109 = local_3;
        uint _e111 = local_30.inner[1];
        local_30.inner[1] = _e111 + _e109;
        uint _e115 = local_30.inner[0];
        local_31 = static_cast<uint>(_e115);
        uint _e119 = local_30.inner[1];
        local_32 = static_cast<uint>(_e119);
        uint _e122 = local_32;
        out_1[_e122] = static_cast<uint>(_e98);
        signed_count = naga_neg(3);
        int _e127 = signed_count;
        type_9 _e130 = out;
        local_6 = _e130;
        uint _e131 = base;
        local_7 = static_cast<uint>(_e131 + 2u);
        type_9 _e137 = local_6;
        local_33 = _e137;
        uint _e138 = local_7;
        uint _e140 = local_33.inner[1];
        local_33.inner[1] = _e140 + _e138;
        uint _e144 = local_33.inner[0];
        local_34 = static_cast<uint>(_e144);
        uint _e148 = local_33.inner[1];
        local_35 = static_cast<uint>(_e148);
        uint _e151 = local_35;
        out_1[_e151] = static_cast<uint>(_e127);
        {
            fraction = 3.75;
            float _e155 = fraction;
            type_9 _e158 = out;
            local_8 = _e158;
            uint _e159 = base;
            local_9 = static_cast<uint>(_e159 + 3u);
            type_9 _e165 = local_8;
            local_36 = _e165;
            uint _e166 = local_9;
            uint _e168 = local_36.inner[1];
            local_36.inner[1] = _e168 + _e166;
            uint _e172 = local_36.inner[0];
            local_37 = static_cast<uint>(_e172);
            uint _e176 = local_36.inner[1];
            local_38 = static_cast<uint>(_e176);
            uint _e179 = local_38;
            out_1[_e179] = naga_f2u32(_e155);
        }
        after_block = naga_neg(5);
        int _e184 = after_block;
        type_9 _e187 = out;
        local_10 = _e187;
        uint _e188 = base;
        local_11 = static_cast<uint>(_e188 + 4u);
        type_9 _e194 = local_10;
        local_39 = _e194;
        uint _e195 = local_11;
        uint _e197 = local_39.inner[1];
        local_39.inner[1] = _e197 + _e195;
        uint _e201 = local_39.inner[0];
        local_40 = static_cast<uint>(_e201);
        uint _e205 = local_39.inner[1];
        local_41 = static_cast<uint>(_e205);
        uint _e208 = local_41;
        out_1[_e208] = static_cast<uint>(_e184);
        coefficient = 1.25;
        float _e212 = coefficient;
        type_9 _e217 = out;
        local_12 = _e217;
        uint _e218 = base;
        local_13 = static_cast<uint>(_e218 + 5u);
        type_9 _e224 = local_12;
        local_42 = _e224;
        uint _e225 = local_13;
        uint _e227 = local_42.inner[1];
        local_42.inner[1] = _e227 + _e225;
        uint _e231 = local_42.inner[0];
        local_43 = static_cast<uint>(_e231);
        uint _e235 = local_42.inner[1];
        local_44 = static_cast<uint>(_e235);
        uint _e238 = local_44;
        out_1[_e238] = naga_f2u32(_e212 * 4.0);
        uint _e240 = i;
        selected = naga_mod(_e240, 2u) == 0u;
        bool _e246 = selected;
        type_9 _e249 = out;
        local_14 = _e249;
        uint _e250 = base;
        local_15 = static_cast<uint>(_e250 + 6u);
        type_9 _e256 = local_14;
        local_45 = _e256;
        uint _e257 = local_15;
        uint _e259 = local_45.inner[1];
        local_45.inner[1] = _e259 + _e257;
        uint _e263 = local_45.inner[0];
        local_46 = static_cast<uint>(_e263);
        uint _e267 = local_45.inner[1];
        local_47 = static_cast<uint>(_e267);
        uint _e270 = local_47;
        out_1[_e270] = static_cast<uint>(_e246);
        total = 0;
        {
            uint2 loop_bound = uint2(4294967295u);
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                int _e274 = total;
                if (_e274 < 3) {
                } else {
                    break;
                }
                int _e277 = total;
                current = _e277;
                int _e279 = current;
                total = as_type<int>(as_type<uint>(_e279) + as_type<uint>(1));
            }
        }
        int _e282 = total;
        type_9 _e285 = out;
        local_16 = _e285;
        uint _e286 = base;
        local_17 = static_cast<uint>(_e286 + 7u);
        type_9 _e292 = local_16;
        local_48 = _e292;
        uint _e293 = local_17;
        uint _e295 = local_48.inner[1];
        local_48.inner[1] = _e295 + _e293;
        uint _e299 = local_48.inner[0];
        local_49 = static_cast<uint>(_e299);
        uint _e303 = local_48.inner[1];
        local_50 = static_cast<uint>(_e303);
        uint _e306 = local_50;
        out_1[_e306] = static_cast<uint>(_e282);
        after_loop = 1.5;
        float _e310 = after_loop;
        type_9 _e315 = out;
        local_18 = _e315;
        uint _e316 = base;
        local_19 = static_cast<uint>(_e316 + 8u);
        type_9 _e322 = local_18;
        local_51 = _e322;
        uint _e323 = local_19;
        uint _e325 = local_51.inner[1];
        local_51.inner[1] = _e325 + _e323;
        uint _e329 = local_51.inner[0];
        local_52 = static_cast<uint>(_e329);
        uint _e333 = local_51.inner[1];
        local_53 = static_cast<uint>(_e333);
        uint _e336 = local_53;
        out_1[_e336] = naga_f2u32(_e310 * 2.0);
        uint _e338 = n;
        type_9 _e342 = out;
        local_20 = _e342;
        uint _e343 = base;
        local_21 = static_cast<uint>(_e343 + 9u);
        type_9 _e349 = local_20;
        local_54 = _e349;
        uint _e350 = local_21;
        uint _e352 = local_54.inner[1];
        local_54.inner[1] = _e352 + _e350;
        uint _e356 = local_54.inner[0];
        local_55 = static_cast<uint>(_e356);
        uint _e360 = local_54.inner[1];
        local_56 = static_cast<uint>(_e360);
        uint _e363 = local_56;
        out_1[_e363] = naga_f2u32(static_cast<float>(_e338));
    }
}
