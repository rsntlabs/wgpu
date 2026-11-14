// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_1[1];
struct type_4 {
    int inner[3];
};

struct void_castsInput {
};
kernel void void_casts(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& output [[buffer(0)]]
, device type_1 const& input [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    int value = {};
    int local = {};
    int local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    int index = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    int turn = {};
    uint local_9 = {};
    int Count = {};
    type_4 array = {};
    uint local_10 = {};
    int step = {};
    int previous = {};
    int local_11 = {};
    int local_12 = {};
    int step_1 = {};
    int previous_1 = {};
    int local_13 = {};
    int local_14 = {};
    int local_15 = {};
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 8u);
    value = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    int _e10 = value;
    value = as_type<int>(as_type<uint>(_e10) + as_type<uint>(1));
    int _e13 = value;
    value = as_type<int>(as_type<uint>(_e13) + as_type<uint>(1));
    int _e16 = value;
    value = as_type<int>(as_type<uint>(_e16) + as_type<uint>(1));
    int _e19 = value;
    output[base] = _e19;
    bool choose = (lane & 1u) == 0u;
    if (choose) {
        step = int {};
        previous = int {};
        step = 3;
        int _e32 = value;
        local_11 = _e32;
        int _e34 = local_11;
        previous = _e34;
        int _e36 = step;
        int _e37 = value;
        local_12 = _e37;
        int _e39 = local_12;
        value = as_type<int>(as_type<uint>(_e39) + as_type<uint>(_e36));
        int _e41 = previous;
        local = _e41;
    } else {
        step_1 = int {};
        previous_1 = int {};
        step_1 = 7;
        int _e49 = value;
        local_13 = _e49;
        int _e51 = local_13;
        previous_1 = _e51;
        int _e53 = step_1;
        int _e54 = value;
        local_14 = _e54;
        int _e56 = local_14;
        value = as_type<int>(as_type<uint>(_e56) + as_type<uint>(_e53));
        int _e58 = previous_1;
        local_1 = _e58;
    }
    int _e60 = value;
    local_2 = static_cast<uint>(base + 1u);
    uint _e65 = local_2;
    output[_e65] = _e60;
    int _e67 = value;
    value = as_type<int>(as_type<uint>(_e67) + as_type<uint>(1));
    int _e70 = value;
    value = as_type<int>(as_type<uint>(_e70) + as_type<uint>(1));
    int _e73 = value;
    local_3 = static_cast<uint>(base + 2u);
    uint _e78 = local_3;
    output[_e78] = _e73;
    index = 0;
    int _e82 = index;
    index = as_type<int>(as_type<uint>(_e82) + as_type<uint>(1));
    local_4 = static_cast<uint>(_e82);
    int _e87 = index;
    index = as_type<int>(as_type<uint>(_e87) + as_type<uint>(1));
    local_5 = static_cast<uint>(_e87);
    int _e92 = index;
    local_6 = static_cast<uint>(base + 3u);
    uint _e97 = local_6;
    output[_e97] = _e92;
    int _e103 = input[static_cast<uint>(0)];
    local_7 = static_cast<uint>(base + 4u);
    uint _e108 = local_7;
    output[_e108] = _e103;
    local_15 = int {};
    int _e112 = value;
    local_15 = _e112;
    int _e114 = local_15;
    value = as_type<int>(as_type<uint>(_e114) + as_type<uint>(1));
    int _e117 = value;
    local_8 = static_cast<uint>(base + 5u);
    uint _e122 = local_8;
    output[_e122] = _e117;
    {
        turn = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e132 = turn;
                turn = as_type<int>(as_type<uint>(_e132) + as_type<uint>(1));
            }
            loop_init = false;
            int _e126 = turn;
            if (_e126 < 2) {
            } else {
                break;
            }
            int _e129 = value;
            value = as_type<int>(as_type<uint>(_e129) + as_type<uint>(1));
        }
    }
    int _e135 = value;
    local_9 = static_cast<uint>(base + 6u);
    uint _e140 = local_9;
    output[_e140] = _e135;
    int runtime = input[static_cast<uint>(1)];
    Count = 3;
    array = type_4 {};
    int _e152 = array.inner[2];
    local_10 = static_cast<uint>(base + 7u);
    uint _e157 = local_10;
    output[_e157] = _e152;
}
