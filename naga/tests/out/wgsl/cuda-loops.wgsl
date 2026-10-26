struct type_3 {
    value: i32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<uniform> n_1: type_3;

@compute @workgroup_size(1, 1, 1)
fn loops(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var n: i32;
    var sum: i32;
    var i: i32;
    var i_1: i32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;

    local = 0u;
    let _e5 = n_1.value;
    n = _e5;
    sum = 0i;
    {
        i = 0i;
        loop {
            let _e11 = i;
            let _e12 = n;
            if (_e11 < _e12) {
            } else {
                break;
            }
            let _e14 = i;
            if (_e14 == 2i) {
                continue;
            }
            let _e17 = i;
            if (_e17 == 7i) {
                break;
            }
            let _e20 = sum;
            let _e21 = i;
            sum = (_e20 + _e21);
            continuing {
                let _e23 = i;
                i = (_e23 + 1i);
            }
        }
    }
    i_1 = 0i;
    loop {
        let _e28 = i_1;
        if (_e28 < 3i) {
        } else {
            break;
        }
        {
            let _e31 = i_1;
            i_1 = (_e31 + 1i);
            let _e34 = i_1;
            if (_e34 == 2i) {
                continue;
            }
            let _e37 = sum;
            sum = (_e37 + 10i);
        }
    }
    loop {
        let _e40 = sum;
        sum = (_e40 + 100i);
        let _e43 = sum;
        if (_e43 > 200i) {
            break;
        }
        continuing {
            let _e46 = sum;
            break if !((_e46 < 150i));
        }
    }
    let _e50 = sum;
    let _e51 = local;
    local_1 = _e51;
    let _e53 = local_1;
    local_2 = u32(_e53);
    local_3 = u32(threadIdx.x);
    let _e60 = local_2;
    let _e61 = local_3;
    local_4 = u32((_e60 + _e61));
    let _e65 = local_4;
    out[_e65] = _e50;
}
