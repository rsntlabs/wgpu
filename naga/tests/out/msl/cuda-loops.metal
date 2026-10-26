// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef int type_1[1];
struct type_3 {
    int value;
    char _pad1[12];
};

struct loopsInput {
};
kernel void loops(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, constant type_3& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    int n = {};
    int sum = {};
    int i = {};
    int i_1 = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    local = 0u;
    int _e5 = n_1.value;
    n = _e5;
    sum = 0;
    {
        i = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e23 = i;
                i = as_type<int>(as_type<uint>(_e23) + as_type<uint>(1));
            }
            loop_init = false;
            int _e11 = i;
            int _e12 = n;
            if (_e11 < _e12) {
            } else {
                break;
            }
            int _e14 = i;
            if (_e14 == 2) {
                continue;
            }
            int _e17 = i;
            if (_e17 == 7) {
                break;
            }
            int _e20 = sum;
            int _e21 = i;
            sum = as_type<int>(as_type<uint>(_e20) + as_type<uint>(_e21));
        }
    }
    i_1 = 0;
    uint2 loop_bound_1 = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        int _e28 = i_1;
        if (_e28 < 3) {
        } else {
            break;
        }
        {
            int _e31 = i_1;
            i_1 = as_type<int>(as_type<uint>(_e31) + as_type<uint>(1));
            int _e34 = i_1;
            if (_e34 == 2) {
                continue;
            }
            int _e37 = sum;
            sum = as_type<int>(as_type<uint>(_e37) + as_type<uint>(10));
        }
    }
    uint2 loop_bound_2 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_2 == uint2(0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_1) {
            int _e46 = sum;
            if (!((sum < 150))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e40 = sum;
        sum = as_type<int>(as_type<uint>(_e40) + as_type<uint>(100));
        int _e43 = sum;
        if (_e43 > 200) {
            break;
        }
    }
    int _e50 = sum;
    uint _e51 = local;
    local_1 = _e51;
    uint _e53 = local_1;
    local_2 = static_cast<uint>(_e53);
    local_3 = static_cast<uint>(threadIdx.x);
    uint _e60 = local_2;
    uint _e61 = local_3;
    local_4 = static_cast<uint>(_e60 + _e61);
    uint _e65 = local_4;
    out[_e65] = _e50;
}
