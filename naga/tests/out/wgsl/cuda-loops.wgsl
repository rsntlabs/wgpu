struct type_3 {
    value: i32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
@group(0) @binding(1)
var<uniform> n: type_3;

@compute @workgroup_size(1, 1, 1)
fn loops(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var out: array<u32, 2>;
    var sum: i32;
    var i: i32;
    var i_1: i32;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    let n_1 = n.value;
    sum = 0i;
    {
        i = 0i;
        loop {
            let _e14 = i;
            if (_e14 < n_1) {
            } else {
                break;
            }
            let _e16 = i;
            if (_e16 == 2i) {
                continue;
            }
            let _e19 = i;
            if (_e19 == 7i) {
                break;
            }
            let _e22 = sum;
            let _e23 = i;
            sum = (_e22 + _e23);
            continuing {
                let _e25 = i;
                i = (_e25 + 1i);
            }
        }
    }
    i_1 = 0i;
    loop {
        let _e30 = i_1;
        if (_e30 < 3i) {
        } else {
            break;
        }
        {
            let _e33 = i_1;
            i_1 = (_e33 + 1i);
            let _e36 = i_1;
            if (_e36 == 2i) {
                continue;
            }
            let _e39 = sum;
            sum = (_e39 + 10i);
        }
    }
    loop {
        let _e42 = sum;
        sum = (_e42 + 100i);
        let _e45 = sum;
        if (_e45 > 200i) {
            break;
        }
        continuing {
            let _e48 = sum;
            break if !((_e48 < 150i));
        }
    }
    let _e52 = sum;
    let _e54 = out;
    local = _e54;
    local_1 = u32(threadIdx.x);
    let _e59 = local;
    local_2 = _e59;
    let _e61 = local_1;
    let _e63 = local_2[1];
    local_2[1] = (_e63 + _e61);
    let _e67 = local_2[0];
    local_3 = u32(_e67);
    let _e71 = local_2[1];
    local_4 = u32(_e71);
    let _e74 = local_4;
    out_1[_e74] = _e52;
}
