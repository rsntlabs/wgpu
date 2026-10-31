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
, constant type_3& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    int sum = {};
    int i = {};
    int i_1 = {};
    uint local = {};
    uint local_1 = {};
    int n_1 = n.value;
    sum = 0;
    {
        i = 0;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e19 = i;
                i = as_type<int>(as_type<uint>(_e19) + as_type<uint>(1));
            }
            loop_init = false;
            int _e8 = i;
            if (_e8 < n_1) {
            } else {
                break;
            }
            int _e10 = i;
            if (_e10 == 2) {
                continue;
            }
            int _e13 = i;
            if (_e13 == 7) {
                break;
            }
            int _e16 = sum;
            int _e17 = i;
            sum = as_type<int>(as_type<uint>(_e16) + as_type<uint>(_e17));
        }
    }
    i_1 = 0;
    uint2 loop_bound_1 = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        int _e24 = i_1;
        if (_e24 < 3) {
        } else {
            break;
        }
        {
            int _e27 = i_1;
            i_1 = as_type<int>(as_type<uint>(_e27) + as_type<uint>(1));
            int _e30 = i_1;
            if (_e30 == 2) {
                continue;
            }
            int _e33 = sum;
            sum = as_type<int>(as_type<uint>(_e33) + as_type<uint>(10));
        }
    }
    uint2 loop_bound_2 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_2 == uint2(0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_1) {
            int _e42 = sum;
            if (!((sum < 150))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e36 = sum;
        sum = as_type<int>(as_type<uint>(_e36) + as_type<uint>(100));
        int _e39 = sum;
        if (_e39 > 200) {
            break;
        }
    }
    int _e46 = sum;
    local = static_cast<uint>(threadIdx.x);
    uint _e50 = local;
    local_1 = static_cast<uint>(_e50);
    uint _e53 = local_1;
    out[_e53] = _e46;
}
