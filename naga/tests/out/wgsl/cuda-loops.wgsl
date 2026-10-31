struct type_3 {
    value: i32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
@group(0) @binding(1)
var<uniform> n_1: type_3;

@compute @workgroup_size(1, 1, 1)
fn loops(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var out: array<u32, 2>;
    var n: i32;
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
    let _e10 = n_1.value;
    n = _e10;
    sum = 0i;
    {
        i = 0i;
        loop {
            let _e16 = i;
            let _e17 = n;
            if (_e16 < _e17) {
            } else {
                break;
            }
            let _e19 = i;
            if (_e19 == 2i) {
                continue;
            }
            let _e22 = i;
            if (_e22 == 7i) {
                break;
            }
            let _e25 = sum;
            let _e26 = i;
            sum = (_e25 + _e26);
            continuing {
                let _e28 = i;
                i = (_e28 + 1i);
            }
        }
    }
    i_1 = 0i;
    loop {
        let _e33 = i_1;
        if (_e33 < 3i) {
        } else {
            break;
        }
        {
            let _e36 = i_1;
            i_1 = (_e36 + 1i);
            let _e39 = i_1;
            if (_e39 == 2i) {
                continue;
            }
            let _e42 = sum;
            sum = (_e42 + 10i);
        }
    }
    loop {
        let _e45 = sum;
        sum = (_e45 + 100i);
        let _e48 = sum;
        if (_e48 > 200i) {
            break;
        }
        continuing {
            let _e51 = sum;
            break if !((_e51 < 150i));
        }
    }
    let _e55 = sum;
    let _e58 = out;
    local = _e58;
    local_1 = u32(threadIdx.x);
    let _e63 = local;
    local_2 = _e63;
    let _e64 = local_1;
    let _e66 = local_2[1];
    local_2[1] = (_e66 + _e64);
    let _e70 = local_2[0];
    local_3 = u32(_e70);
    let _e74 = local_2[1];
    local_4 = u32(_e74);
    let _e77 = local_4;
    out_1[_e77] = _e55;
}
