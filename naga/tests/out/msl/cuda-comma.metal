// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_1[1];
struct type_3 {
    uint value;
    char _pad1[12];
};

void consume(
    int value_1
) {
    if (value_1 < 0) {
        return;
    } else {
        return;
    }
}

int pair_add(
    int left_1,
    int right_1
) {
    return as_type<int>(as_type<uint>(left_1) + as_type<uint>(right_1));
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct commaInput {
};
kernel void comma(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, device type_1 const& input [[user(fake0)]]
, constant type_3& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint base = {};
    int value = {};
    uint local = {};
    bool choose = {};
    int x = {};
    int sequenced = {};
    uint local_1 = {};
    uint local_2 = {};
    int target = {};
    uint local_3 = {};
    int rhs = {};
    uint local_4 = {};
    int middle = {};
    int selected = {};
    int local_5 = {};
    uint local_6 = {};
    int left = {};
    int right = {};
    uint local_7 = {};
    int identity = {};
    uint local_8 = {};
    uint position = {};
    uint local_9 = {};
    int effect = {};
    uint local_10 = {};
    int total = {};
    int iteration = {};
    int current = {};
    uint local_11 = {};
    int ticks = {};
    int passes = {};
    uint local_12 = {};
    int argument = {};
    int first = {};
    int second = {};
    uint local_13 = {};
    int local_14 = {};
    uint local_15 = {};
    int local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint n_1 = n.value;
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        base = i * 12u;
        local = static_cast<uint>(i);
        uint _e16 = local;
        local_15 = static_cast<uint>(_e16);
        uint _e19 = local_15;
        int _e22 = input[_e19];
        local_16 = _e22;
        int _e24 = local_16;
        local_14 = _e24;
        int _e26 = local_14;
        value = _e26;
        choose = naga_mod(i, 2u) == 0u;
        int _e33 = value;
        x = _e33;
        int _e35 = x;
        x = as_type<int>(as_type<uint>(_e35) + as_type<uint>(2));
        int _e38 = x;
        x = as_type<int>(as_type<uint>(_e38) * as_type<uint>(3));
        int _e41 = x;
        sequenced = as_type<int>(as_type<uint>(_e41) - as_type<uint>(1));
        int _e45 = sequenced;
        uint _e46 = base;
        local_1 = static_cast<uint>(_e46);
        uint _e49 = local_1;
        local_17 = static_cast<uint>(_e49);
        uint _e52 = local_17;
        out[_e52] = _e45;
        int _e55 = x;
        uint _e56 = base;
        local_2 = static_cast<uint>(_e56 + 1u);
        uint _e61 = local_2;
        local_18 = static_cast<uint>(_e61);
        uint _e64 = local_18;
        out[_e64] = _e55;
        target = 0;
        int _e68 = value;
        target = _e68;
        int _e69 = target;
        target = as_type<int>(as_type<uint>(_e69) + as_type<uint>(4));
        int _e72 = target;
        uint _e73 = base;
        local_3 = static_cast<uint>(_e73 + 2u);
        uint _e78 = local_3;
        local_19 = static_cast<uint>(_e78);
        uint _e81 = local_19;
        out[_e81] = _e72;
        int _e83 = value;
        target = as_type<int>(as_type<uint>(_e83) + as_type<uint>(1));
        int _e86 = target;
        rhs = as_type<int>(as_type<uint>(_e86) + as_type<uint>(3));
        int _e90 = rhs;
        int _e93 = target;
        uint _e95 = base;
        local_4 = static_cast<uint>(_e95 + 3u);
        uint _e100 = local_4;
        local_20 = static_cast<uint>(_e100);
        uint _e103 = local_20;
        out[_e103] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e90) * as_type<uint>(10))) + as_type<uint>(_e93));
        middle = 0;
        bool _e107 = choose;
        if (_e107) {
            int _e108 = value;
            middle = as_type<int>(as_type<uint>(_e108) + as_type<uint>(2));
            int _e111 = middle;
            local_5 = as_type<int>(as_type<uint>(_e111) + as_type<uint>(3));
        } else {
            int _e115 = value;
            local_5 = as_type<int>(as_type<uint>(_e115) - as_type<uint>(2));
        }
        int _e120 = local_5;
        selected = _e120;
        int _e122 = selected;
        int _e125 = middle;
        uint _e127 = base;
        local_6 = static_cast<uint>(_e127 + 4u);
        uint _e132 = local_6;
        local_21 = static_cast<uint>(_e132);
        uint _e135 = local_21;
        out[_e135] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e122) * as_type<uint>(10))) + as_type<uint>(_e125));
        int _e137 = value;
        left = _e137;
        int _e139 = value;
        right = as_type<int>(as_type<uint>(_e139) + as_type<uint>(10));
        int _e143 = value;
        consume(_e143);
        bool _e144 = choose;
        if (_e144) {
            int _e145 = left;
            left = as_type<int>(as_type<uint>(_e145) + as_type<uint>(3));
        } else {
            int _e148 = right;
            right = as_type<int>(as_type<uint>(_e148) + as_type<uint>(3));
        }
        int _e151 = left;
        int _e154 = right;
        uint _e156 = base;
        local_7 = static_cast<uint>(_e156 + 5u);
        uint _e161 = local_7;
        local_22 = static_cast<uint>(_e161);
        uint _e164 = local_22;
        out[_e164] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e151) * as_type<uint>(100))) + as_type<uint>(_e154));
        int _e166 = value;
        identity = _e166;
        int _e168 = identity;
        identity = as_type<int>(as_type<uint>(_e168) + as_type<uint>(1));
        consume(_e168);
        int _e171 = identity;
        identity = as_type<int>(as_type<uint>(_e171) + as_type<uint>(1));
        int _e174 = identity;
        uint _e175 = base;
        local_8 = static_cast<uint>(_e175 + 6u);
        uint _e180 = local_8;
        local_23 = static_cast<uint>(_e180);
        uint _e183 = local_23;
        out[_e183] = _e174;
        uint _e185 = base;
        position = _e185 + 4u;
        uint _e189 = position;
        position = _e189 + 2u;
        int _e192 = value;
        uint _e197 = position;
        position = _e197 + static_cast<uint>(1);
        uint _e201 = position;
        local_9 = static_cast<uint>(_e201);
        uint _e204 = local_9;
        local_24 = static_cast<uint>(_e204);
        uint _e207 = local_24;
        out[_e207] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e192) * as_type<uint>(2))) + as_type<uint>(2));
        int _e209 = value;
        effect = _e209;
        int _e211 = effect;
        effect = as_type<int>(as_type<uint>(_e211) + as_type<uint>(1));
        consume(_e211);
        int _e214 = effect;
        effect = as_type<int>(as_type<uint>(_e214) + as_type<uint>(1));
        consume(_e214);
        int _e217 = effect;
        effect = as_type<int>(as_type<uint>(_e217) + as_type<uint>(1));
        consume(_e217);
        int _e220 = effect;
        effect = as_type<int>(as_type<uint>(_e220) + as_type<uint>(1));
        consume(_e220);
        int _e223 = effect;
        uint _e224 = base;
        local_10 = static_cast<uint>(_e224 + 8u);
        uint _e229 = local_10;
        local_25 = static_cast<uint>(_e229);
        uint _e232 = local_25;
        out[_e232] = _e223;
        total = 0;
        {
            iteration = 0;
            int _e238 = value;
            current = _e238;
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e249 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e249) + as_type<uint>(1));
                    int _e252 = current;
                    current = as_type<int>(as_type<uint>(_e252) + as_type<uint>(2));
                }
                loop_init = false;
                int _e240 = iteration;
                if (_e240 < 4) {
                } else {
                    break;
                }
                int _e243 = iteration;
                if (_e243 != 1) {
                    int _e246 = current;
                    int _e247 = total;
                    total = as_type<int>(as_type<uint>(_e247) + as_type<uint>(_e246));
                } else {
                    continue;
                }
            }
        }
        int _e255 = total;
        uint _e256 = base;
        local_11 = static_cast<uint>(_e256 + 9u);
        uint _e261 = local_11;
        local_26 = static_cast<uint>(_e261);
        uint _e264 = local_26;
        out[_e264] = _e255;
        int _e266 = value;
        ticks = _e266;
        passes = 0;
        {
            int _e270 = value;
            ticks = as_type<int>(as_type<uint>(_e270) + as_type<uint>(1));
            passes = 0;
            uint2 loop_bound_1 = uint2(4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (metal::all(loop_bound_1 == uint2(0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e280 = ticks;
                    ticks = as_type<int>(as_type<uint>(_e280) + as_type<uint>(2));
                }
                loop_init_1 = false;
                int _e274 = passes;
                passes = as_type<int>(as_type<uint>(_e274) + as_type<uint>(1));
                int _e277 = passes;
                if (_e277 < 4) {
                } else {
                    break;
                }
            }
        }
        int _e283 = ticks;
        int _e286 = passes;
        uint _e288 = base;
        local_12 = static_cast<uint>(_e288 + 10u);
        uint _e293 = local_12;
        local_27 = static_cast<uint>(_e293);
        uint _e296 = local_27;
        out[_e296] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e283) * as_type<uint>(10))) + as_type<uint>(_e286));
        int _e298 = value;
        argument = _e298;
        int _e300 = argument;
        argument = as_type<int>(as_type<uint>(_e300) + as_type<uint>(1));
        int _e303 = argument;
        int _e305 = pair_add(_e303, 2);
        first = _e305;
        int _e307 = first;
        int _e309 = pair_add(_e307, 3);
        second = _e309;
        int _e311 = second;
        int _e314 = argument;
        uint _e316 = base;
        local_13 = static_cast<uint>(_e316 + 11u);
        uint _e321 = local_13;
        local_28 = static_cast<uint>(_e321);
        uint _e324 = local_28;
        out[_e324] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e311) * as_type<uint>(10))) + as_type<uint>(_e314));
    }
}
