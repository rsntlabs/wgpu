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
, device type_3& out [[user(fake0)]]
, device type_4 const& input [[user(fake0)]]
, constant type_5& n_1 [[user(fake0)]]
, threadgroup type_6& shared_values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_9 local = {};
    type_9 local_1 = {};
    uint n = {};
    uint i = {};
    uint base = {};
    uint lane = {};
    type_9 local_2 = {};
    uint local_3 = {};
    type_9 local_4 = {};
    uint local_5 = {};
    type_9 local_6 = {};
    uint local_7 = {};
    int signed_count = {};
    type_9 local_8 = {};
    uint local_9 = {};
    float fraction = {};
    type_9 local_10 = {};
    uint local_11 = {};
    int after_block = {};
    type_9 local_12 = {};
    uint local_13 = {};
    float coefficient = {};
    type_9 local_14 = {};
    uint local_15 = {};
    bool selected = {};
    type_9 local_16 = {};
    uint local_17 = {};
    int total = {};
    int current = {};
    type_9 local_18 = {};
    uint local_19 = {};
    float after_loop = {};
    type_9 local_20 = {};
    uint local_21 = {};
    type_9 local_22 = {};
    uint local_23 = {};
    int local_24 = {};
    type_9 local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    type_9 local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    int local_31 = {};
    type_9 local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    type_9 local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    type_9 local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    type_9 local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    type_9 local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    type_9 local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    type_9 local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    type_9 local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    type_9 local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    local = type_9 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    local_1 = type_9 {};
    local_1.inner[0] = 1u;
    local_1.inner[1] = 0u;
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
        type_9 _e46 = local;
        local_2 = _e46;
        uint _e47 = base;
        local_3 = static_cast<uint>(_e47);
        type_9 _e51 = local_2;
        local_25 = _e51;
        uint _e52 = local_3;
        uint _e54 = local_25.inner[1];
        local_25.inner[1] = _e54 + _e52;
        uint _e58 = local_25.inner[0];
        local_26 = static_cast<uint>(_e58);
        uint _e62 = local_25.inner[1];
        local_27 = static_cast<uint>(_e62);
        uint _e65 = local_27;
        out[_e65] = _e43;
        type_9 _e69 = local_1;
        local_6 = _e69;
        uint _e70 = i;
        local_7 = static_cast<uint>(_e70);
        type_9 _e74 = local_6;
        local_28 = _e74;
        uint _e75 = local_7;
        uint _e77 = local_28.inner[1];
        local_28.inner[1] = _e77 + _e75;
        uint _e81 = local_28.inner[0];
        local_29 = static_cast<uint>(_e81);
        uint _e85 = local_28.inner[1];
        local_30 = static_cast<uint>(_e85);
        uint _e89 = local_30;
        int _e91 = input[_e89];
        local_31 = _e91;
        int _e92 = local_31;
        local_24 = _e92;
        int _e94 = local_24;
        int _e98 = transform(static_cast<float>(_e94), 2.0, 1);
        type_9 _e101 = local;
        local_4 = _e101;
        uint _e102 = base;
        local_5 = static_cast<uint>(_e102 + 1u);
        type_9 _e108 = local_4;
        local_32 = _e108;
        uint _e109 = local_5;
        uint _e111 = local_32.inner[1];
        local_32.inner[1] = _e111 + _e109;
        uint _e115 = local_32.inner[0];
        local_33 = static_cast<uint>(_e115);
        uint _e119 = local_32.inner[1];
        local_34 = static_cast<uint>(_e119);
        uint _e122 = local_34;
        out[_e122] = static_cast<uint>(_e98);
        signed_count = naga_neg(3);
        int _e127 = signed_count;
        type_9 _e130 = local;
        local_8 = _e130;
        uint _e131 = base;
        local_9 = static_cast<uint>(_e131 + 2u);
        type_9 _e137 = local_8;
        local_35 = _e137;
        uint _e138 = local_9;
        uint _e140 = local_35.inner[1];
        local_35.inner[1] = _e140 + _e138;
        uint _e144 = local_35.inner[0];
        local_36 = static_cast<uint>(_e144);
        uint _e148 = local_35.inner[1];
        local_37 = static_cast<uint>(_e148);
        uint _e151 = local_37;
        out[_e151] = static_cast<uint>(_e127);
        {
            fraction = 3.75;
            float _e155 = fraction;
            type_9 _e158 = local;
            local_10 = _e158;
            uint _e159 = base;
            local_11 = static_cast<uint>(_e159 + 3u);
            type_9 _e165 = local_10;
            local_38 = _e165;
            uint _e166 = local_11;
            uint _e168 = local_38.inner[1];
            local_38.inner[1] = _e168 + _e166;
            uint _e172 = local_38.inner[0];
            local_39 = static_cast<uint>(_e172);
            uint _e176 = local_38.inner[1];
            local_40 = static_cast<uint>(_e176);
            uint _e179 = local_40;
            out[_e179] = naga_f2u32(_e155);
        }
        after_block = naga_neg(5);
        int _e184 = after_block;
        type_9 _e187 = local;
        local_12 = _e187;
        uint _e188 = base;
        local_13 = static_cast<uint>(_e188 + 4u);
        type_9 _e194 = local_12;
        local_41 = _e194;
        uint _e195 = local_13;
        uint _e197 = local_41.inner[1];
        local_41.inner[1] = _e197 + _e195;
        uint _e201 = local_41.inner[0];
        local_42 = static_cast<uint>(_e201);
        uint _e205 = local_41.inner[1];
        local_43 = static_cast<uint>(_e205);
        uint _e208 = local_43;
        out[_e208] = static_cast<uint>(_e184);
        coefficient = 1.25;
        float _e212 = coefficient;
        type_9 _e217 = local;
        local_14 = _e217;
        uint _e218 = base;
        local_15 = static_cast<uint>(_e218 + 5u);
        type_9 _e224 = local_14;
        local_44 = _e224;
        uint _e225 = local_15;
        uint _e227 = local_44.inner[1];
        local_44.inner[1] = _e227 + _e225;
        uint _e231 = local_44.inner[0];
        local_45 = static_cast<uint>(_e231);
        uint _e235 = local_44.inner[1];
        local_46 = static_cast<uint>(_e235);
        uint _e238 = local_46;
        out[_e238] = naga_f2u32(_e212 * 4.0);
        uint _e240 = i;
        selected = naga_mod(_e240, 2u) == 0u;
        bool _e246 = selected;
        type_9 _e249 = local;
        local_16 = _e249;
        uint _e250 = base;
        local_17 = static_cast<uint>(_e250 + 6u);
        type_9 _e256 = local_16;
        local_47 = _e256;
        uint _e257 = local_17;
        uint _e259 = local_47.inner[1];
        local_47.inner[1] = _e259 + _e257;
        uint _e263 = local_47.inner[0];
        local_48 = static_cast<uint>(_e263);
        uint _e267 = local_47.inner[1];
        local_49 = static_cast<uint>(_e267);
        uint _e270 = local_49;
        out[_e270] = static_cast<uint>(_e246);
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
        type_9 _e285 = local;
        local_18 = _e285;
        uint _e286 = base;
        local_19 = static_cast<uint>(_e286 + 7u);
        type_9 _e292 = local_18;
        local_50 = _e292;
        uint _e293 = local_19;
        uint _e295 = local_50.inner[1];
        local_50.inner[1] = _e295 + _e293;
        uint _e299 = local_50.inner[0];
        local_51 = static_cast<uint>(_e299);
        uint _e303 = local_50.inner[1];
        local_52 = static_cast<uint>(_e303);
        uint _e306 = local_52;
        out[_e306] = static_cast<uint>(_e282);
        after_loop = 1.5;
        float _e310 = after_loop;
        type_9 _e315 = local;
        local_20 = _e315;
        uint _e316 = base;
        local_21 = static_cast<uint>(_e316 + 8u);
        type_9 _e322 = local_20;
        local_53 = _e322;
        uint _e323 = local_21;
        uint _e325 = local_53.inner[1];
        local_53.inner[1] = _e325 + _e323;
        uint _e329 = local_53.inner[0];
        local_54 = static_cast<uint>(_e329);
        uint _e333 = local_53.inner[1];
        local_55 = static_cast<uint>(_e333);
        uint _e336 = local_55;
        out[_e336] = naga_f2u32(_e310 * 2.0);
        uint _e338 = n;
        type_9 _e342 = local;
        local_22 = _e342;
        uint _e343 = base;
        local_23 = static_cast<uint>(_e343 + 9u);
        type_9 _e349 = local_22;
        local_56 = _e349;
        uint _e350 = local_23;
        uint _e352 = local_56.inner[1];
        local_56.inner[1] = _e352 + _e350;
        uint _e356 = local_56.inner[0];
        local_57 = static_cast<uint>(_e356);
        uint _e360 = local_56.inner[1];
        local_58 = static_cast<uint>(_e360);
        uint _e363 = local_58;
        out[_e363] = naga_f2u32(static_cast<float>(_e338));
    }
}
