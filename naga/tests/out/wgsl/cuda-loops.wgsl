struct type_3 {
    value: i32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<uniform> n: type_3;

@compute @workgroup_size(1, 1, 1)
fn loops(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var sum: i32;
    var i: i32;
    var i_1: i32;
    var local: u32;
    var local_1: u32;

    let n_1 = n.value;
    sum = 0i;
    {
        i = 0i;
        loop {
            let _e8 = i;
            if (_e8 < n_1) {
            } else {
                break;
            }
            let _e10 = i;
            if (_e10 == 2i) {
                continue;
            }
            let _e13 = i;
            if (_e13 == 7i) {
                break;
            }
            let _e16 = sum;
            let _e17 = i;
            sum = (_e16 + _e17);
            continuing {
                let _e19 = i;
                i = (_e19 + 1i);
            }
        }
    }
    i_1 = 0i;
    loop {
        let _e24 = i_1;
        if (_e24 < 3i) {
        } else {
            break;
        }
        {
            let _e27 = i_1;
            i_1 = (_e27 + 1i);
            let _e30 = i_1;
            if (_e30 == 2i) {
                continue;
            }
            let _e33 = sum;
            sum = (_e33 + 10i);
        }
    }
    loop {
        let _e36 = sum;
        sum = (_e36 + 100i);
        let _e39 = sum;
        if (_e39 > 200i) {
            break;
        }
        continuing {
            let _e42 = sum;
            break if !((_e42 < 150i));
        }
    }
    let _e46 = sum;
    local = u32(threadIdx.x);
    let _e50 = local;
    local_1 = u32(_e50);
    let _e53 = local_1;
    out[_e53] = _e46;
}
