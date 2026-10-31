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
        local = i;
        uint _e15 = local;
        local_15 = _e15;
        uint _e17 = local_15;
        int _e20 = input[_e17];
        local_16 = _e20;
        int _e22 = local_16;
        local_14 = _e22;
        int _e24 = local_14;
        value = _e24;
        choose = naga_mod(i, 2u) == 0u;
        int _e31 = value;
        x = _e31;
        int _e33 = x;
        x = as_type<int>(as_type<uint>(_e33) + as_type<uint>(2));
        int _e36 = x;
        x = as_type<int>(as_type<uint>(_e36) * as_type<uint>(3));
        int _e39 = x;
        sequenced = as_type<int>(as_type<uint>(_e39) - as_type<uint>(1));
        int _e43 = sequenced;
        uint _e44 = base;
        local_1 = _e44;
        uint _e46 = local_1;
        local_17 = _e46;
        uint _e48 = local_17;
        out[_e48] = _e43;
        int _e51 = x;
        uint _e52 = base;
        local_2 = static_cast<uint>(_e52 + 1u);
        uint _e57 = local_2;
        local_18 = _e57;
        uint _e59 = local_18;
        out[_e59] = _e51;
        target = 0;
        int _e63 = value;
        target = _e63;
        int _e64 = target;
        target = as_type<int>(as_type<uint>(_e64) + as_type<uint>(4));
        int _e67 = target;
        uint _e68 = base;
        local_3 = static_cast<uint>(_e68 + 2u);
        uint _e73 = local_3;
        local_19 = _e73;
        uint _e75 = local_19;
        out[_e75] = _e67;
        int _e77 = value;
        target = as_type<int>(as_type<uint>(_e77) + as_type<uint>(1));
        int _e80 = target;
        rhs = as_type<int>(as_type<uint>(_e80) + as_type<uint>(3));
        int _e84 = rhs;
        int _e87 = target;
        uint _e89 = base;
        local_4 = static_cast<uint>(_e89 + 3u);
        uint _e94 = local_4;
        local_20 = _e94;
        uint _e96 = local_20;
        out[_e96] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e84) * as_type<uint>(10))) + as_type<uint>(_e87));
        middle = 0;
        bool _e100 = choose;
        if (_e100) {
            int _e101 = value;
            middle = as_type<int>(as_type<uint>(_e101) + as_type<uint>(2));
            int _e104 = middle;
            local_5 = as_type<int>(as_type<uint>(_e104) + as_type<uint>(3));
        } else {
            int _e108 = value;
            local_5 = as_type<int>(as_type<uint>(_e108) - as_type<uint>(2));
        }
        int _e113 = local_5;
        selected = _e113;
        int _e115 = selected;
        int _e118 = middle;
        uint _e120 = base;
        local_6 = static_cast<uint>(_e120 + 4u);
        uint _e125 = local_6;
        local_21 = _e125;
        uint _e127 = local_21;
        out[_e127] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e115) * as_type<uint>(10))) + as_type<uint>(_e118));
        int _e129 = value;
        left = _e129;
        int _e131 = value;
        right = as_type<int>(as_type<uint>(_e131) + as_type<uint>(10));
        int _e135 = value;
        consume(_e135);
        bool _e136 = choose;
        if (_e136) {
            int _e137 = left;
            left = as_type<int>(as_type<uint>(_e137) + as_type<uint>(3));
        } else {
            int _e140 = right;
            right = as_type<int>(as_type<uint>(_e140) + as_type<uint>(3));
        }
        int _e143 = left;
        int _e146 = right;
        uint _e148 = base;
        local_7 = static_cast<uint>(_e148 + 5u);
        uint _e153 = local_7;
        local_22 = _e153;
        uint _e155 = local_22;
        out[_e155] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e143) * as_type<uint>(100))) + as_type<uint>(_e146));
        int _e157 = value;
        identity = _e157;
        int _e159 = identity;
        identity = as_type<int>(as_type<uint>(_e159) + as_type<uint>(1));
        consume(_e159);
        int _e162 = identity;
        identity = as_type<int>(as_type<uint>(_e162) + as_type<uint>(1));
        int _e165 = identity;
        uint _e166 = base;
        local_8 = static_cast<uint>(_e166 + 6u);
        uint _e171 = local_8;
        local_23 = _e171;
        uint _e173 = local_23;
        out[_e173] = _e165;
        uint _e175 = base;
        position = _e175 + 4u;
        uint _e179 = position;
        position = _e179 + 2u;
        int _e182 = value;
        uint _e187 = position;
        position = _e187 + static_cast<uint>(1);
        uint _e191 = position;
        local_9 = _e191;
        uint _e193 = local_9;
        local_24 = _e193;
        uint _e195 = local_24;
        out[_e195] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e182) * as_type<uint>(2))) + as_type<uint>(2));
        int _e197 = value;
        effect = _e197;
        int _e199 = effect;
        effect = as_type<int>(as_type<uint>(_e199) + as_type<uint>(1));
        consume(_e199);
        int _e202 = effect;
        effect = as_type<int>(as_type<uint>(_e202) + as_type<uint>(1));
        consume(_e202);
        int _e205 = effect;
        effect = as_type<int>(as_type<uint>(_e205) + as_type<uint>(1));
        consume(_e205);
        int _e208 = effect;
        effect = as_type<int>(as_type<uint>(_e208) + as_type<uint>(1));
        consume(_e208);
        int _e211 = effect;
        uint _e212 = base;
        local_10 = static_cast<uint>(_e212 + 8u);
        uint _e217 = local_10;
        local_25 = _e217;
        uint _e219 = local_25;
        out[_e219] = _e211;
        total = 0;
        {
            iteration = 0;
            int _e225 = value;
            current = _e225;
            uint2 loop_bound = uint2(4294967295u);
            bool loop_init = true;
            while(true) {
                if (metal::all(loop_bound == uint2(0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e236 = iteration;
                    iteration = as_type<int>(as_type<uint>(_e236) + as_type<uint>(1));
                    int _e239 = current;
                    current = as_type<int>(as_type<uint>(_e239) + as_type<uint>(2));
                }
                loop_init = false;
                int _e227 = iteration;
                if (_e227 < 4) {
                } else {
                    break;
                }
                int _e230 = iteration;
                if (_e230 != 1) {
                    int _e233 = current;
                    int _e234 = total;
                    total = as_type<int>(as_type<uint>(_e234) + as_type<uint>(_e233));
                } else {
                    continue;
                }
            }
        }
        int _e242 = total;
        uint _e243 = base;
        local_11 = static_cast<uint>(_e243 + 9u);
        uint _e248 = local_11;
        local_26 = _e248;
        uint _e250 = local_26;
        out[_e250] = _e242;
        int _e252 = value;
        ticks = _e252;
        passes = 0;
        {
            int _e256 = value;
            ticks = as_type<int>(as_type<uint>(_e256) + as_type<uint>(1));
            passes = 0;
            uint2 loop_bound_1 = uint2(4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (metal::all(loop_bound_1 == uint2(0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e266 = ticks;
                    ticks = as_type<int>(as_type<uint>(_e266) + as_type<uint>(2));
                }
                loop_init_1 = false;
                int _e260 = passes;
                passes = as_type<int>(as_type<uint>(_e260) + as_type<uint>(1));
                int _e263 = passes;
                if (_e263 < 4) {
                } else {
                    break;
                }
            }
        }
        int _e269 = ticks;
        int _e272 = passes;
        uint _e274 = base;
        local_12 = static_cast<uint>(_e274 + 10u);
        uint _e279 = local_12;
        local_27 = _e279;
        uint _e281 = local_27;
        out[_e281] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e269) * as_type<uint>(10))) + as_type<uint>(_e272));
        int _e283 = value;
        argument = _e283;
        int _e285 = argument;
        argument = as_type<int>(as_type<uint>(_e285) + as_type<uint>(1));
        int _e288 = argument;
        int _e290 = pair_add(_e288, 2);
        first = _e290;
        int _e292 = first;
        int _e294 = pair_add(_e292, 3);
        second = _e294;
        int _e296 = second;
        int _e299 = argument;
        uint _e301 = base;
        local_13 = static_cast<uint>(_e301 + 11u);
        uint _e306 = local_13;
        local_28 = _e306;
        uint _e308 = local_28;
        out[_e308] = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e296) * as_type<uint>(10))) + as_type<uint>(_e299));
    }
}
