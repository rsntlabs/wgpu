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
struct type_5 {
    uint inner[2];
};

struct loopsInput {
};
kernel void loops(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out_1 [[user(fake0)]]
, constant type_3& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_5 out = {};
    int sum = {};
    int i = {};
    int i_1 = {};
    type_5 local = {};
    uint local_1 = {};
    type_5 local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    out = type_5 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
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
                int _e25 = i;
                i = as_type<int>(as_type<uint>(_e25) + as_type<uint>(1));
            }
            loop_init = false;
            int _e14 = i;
            if (_e14 < n_1) {
            } else {
                break;
            }
            int _e16 = i;
            if (_e16 == 2) {
                continue;
            }
            int _e19 = i;
            if (_e19 == 7) {
                break;
            }
            int _e22 = sum;
            int _e23 = i;
            sum = as_type<int>(as_type<uint>(_e22) + as_type<uint>(_e23));
        }
    }
    i_1 = 0;
    uint2 loop_bound_1 = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        int _e30 = i_1;
        if (_e30 < 3) {
        } else {
            break;
        }
        {
            int _e33 = i_1;
            i_1 = as_type<int>(as_type<uint>(_e33) + as_type<uint>(1));
            int _e36 = i_1;
            if (_e36 == 2) {
                continue;
            }
            int _e39 = sum;
            sum = as_type<int>(as_type<uint>(_e39) + as_type<uint>(10));
        }
    }
    uint2 loop_bound_2 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_2 == uint2(0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_1) {
            int _e48 = sum;
            if (!((sum < 150))) {
                break;
            }
        }
        loop_init_1 = false;
        int _e42 = sum;
        sum = as_type<int>(as_type<uint>(_e42) + as_type<uint>(100));
        int _e45 = sum;
        if (_e45 > 200) {
            break;
        }
    }
    int _e52 = sum;
    type_5 _e54 = out;
    local = _e54;
    local_1 = static_cast<uint>(threadIdx.x);
    type_5 _e59 = local;
    local_2 = _e59;
    uint _e61 = local_1;
    uint _e63 = local_2.inner[1];
    local_2.inner[1] = _e63 + _e61;
    uint _e67 = local_2.inner[0];
    local_3 = static_cast<uint>(_e67);
    uint _e71 = local_2.inner[1];
    local_4 = static_cast<uint>(_e71);
    uint _e74 = local_4;
    out_1[_e74] = _e52;
}
