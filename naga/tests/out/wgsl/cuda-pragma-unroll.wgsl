const Factor: u32 = 4u;

@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn accumulate(seed: u32) -> u32 {
    var seed_1: u32;
    var Count: i32;
    var index_4: u32;

    seed_1 = seed;
    Count = 3i;
    {
        index_4 = 0u;
        loop {
            let _e7 = index_4;
            if (_e7 < 3u) {
            } else {
                break;
            }
            let _e14 = seed_1;
            let _e16 = index_4;
            seed_1 = ((_e14 * 2u) + _e16);
            continuing {
                let _e9 = index_4;
                index_4 = (_e9 + u32(1i));
            }
        }
    }
    let _e18 = seed_1;
    return _e18;
}

@compute @workgroup_size(4, 1, 1)
fn loops(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var tests: u32;
    var steps: u32;
    var total: u32;
    var index: u32;
    var while_index: u32;
    var while_total: u32;
    var do_index: u32;
    var do_total: u32;
    var nested: u32;
    var outer: u32;
    var inner: u32;
    var converted: u32;
    var index_1: u32;
    var index_2: u32;
    var index_3: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;

    let lane = ((blockIdx.x * 4u) + threadIdx.x);
    if (lane >= 4u) {
        return;
    }
    let count = input[lane];
    tests = 0u;
    steps = 0u;
    total = 0u;
    {
        index = 0u;
        loop {
            let _e20 = tests;
            tests = (_e20 + u32(1i));
            let _e24 = index;
            if (_e24 < count) {
            } else {
                break;
            }
            let _e26 = index;
            if (_e26 == 2u) {
                continue;
            }
            let _e29 = index;
            if (_e29 == 5u) {
                break;
            }
            let _e32 = index;
            let _e35 = total;
            total = (_e35 + (_e32 + 1u));
            continuing {
                let _e37 = index;
                index = (_e37 + u32(1i));
                let _e41 = steps;
                steps = (_e41 + u32(1i));
            }
        }
    }
    while_index = 0u;
    while_total = 0u;
    loop {
        let _e49 = while_index;
        if (_e49 < 3u) {
        } else {
            break;
        }
        {
            let _e52 = while_index;
            while_index = (_e52 + u32(1i));
            let _e56 = while_index;
            let _e57 = while_total;
            while_total = (_e57 + _e56);
        }
    }
    do_index = 0u;
    do_total = 0u;
    loop {
        let _e63 = do_index;
        let _e66 = do_total;
        do_total = (_e66 + (_e63 + 1u));
        let _e68 = do_index;
        do_index = (_e68 + u32(1i));
        continuing {
            let _e72 = do_index;
            break if !((_e72 < 2u));
        }
    }
    nested = 0u;
    {
        outer = 0u;
        loop {
            let _e80 = outer;
            if (_e80 < 2u) {
            } else {
                break;
            }
            {
                inner = 0u;
                loop {
                    let _e85 = inner;
                    if (_e85 < 3u) {
                    } else {
                        break;
                    }
                    let _e88 = outer;
                    let _e91 = inner;
                    let _e93 = nested;
                    nested = (_e93 + ((_e88 * 10u) + _e91));
                    continuing {
                        let _e95 = inner;
                        inner = (_e95 + u32(1i));
                    }
                }
            }
            continuing {
                let _e99 = outer;
                outer = (_e99 + u32(1i));
            }
        }
    }
    converted = 0u;
    {
        index_1 = 0u;
        loop {
            let _e107 = index_1;
            if (_e107 < 1u) {
            } else {
                break;
            }
            let _e110 = converted;
            converted = (_e110 + 5u);
            continuing {
                let _e113 = index_1;
                index_1 = (_e113 + u32(1i));
            }
        }
    }
    {
        index_2 = 0u;
        loop {
            let _e119 = index_2;
            if (_e119 < 1u) {
            } else {
                break;
            }
            let _e122 = converted;
            converted = (_e122 + 7u);
            continuing {
                let _e125 = index_2;
                index_2 = (_e125 + u32(1i));
            }
        }
    }
    {
        index_3 = 0u;
        loop {
            let _e131 = index_3;
            if (_e131 < 2u) {
            } else {
                break;
            }
            let _e134 = index_3;
            let _e135 = converted;
            converted = (_e135 + _e134);
            continuing {
                let _e137 = index_3;
                index_3 = (_e137 + u32(1i));
            }
        }
    }
    let offset = (lane * 12u);
    let _e143 = total;
    output[offset] = _e143;
    let _e146 = tests;
    local = u32((offset + 1u));
    let _e151 = local;
    output[_e151] = _e146;
    let _e153 = steps;
    local_1 = u32((offset + 2u));
    let _e158 = local_1;
    output[_e158] = _e153;
    let _e160 = while_total;
    local_2 = u32((offset + 3u));
    let _e165 = local_2;
    output[_e165] = _e160;
    let _e167 = while_index;
    local_3 = u32((offset + 4u));
    let _e172 = local_3;
    output[_e172] = _e167;
    let _e174 = do_total;
    local_4 = u32((offset + 5u));
    let _e179 = local_4;
    output[_e179] = _e174;
    let _e181 = do_index;
    local_5 = u32((offset + 6u));
    let _e186 = local_5;
    output[_e186] = _e181;
    let _e188 = accumulate(lane);
    local_6 = u32((offset + 7u));
    let _e193 = local_6;
    output[_e193] = _e188;
    let _e195 = nested;
    local_7 = u32((offset + 8u));
    let _e200 = local_7;
    output[_e200] = _e195;
    let _e202 = converted;
    local_8 = u32((offset + 9u));
    let _e207 = local_8;
    output[_e207] = _e202;
    local_9 = u32((offset + 10u));
    let _e213 = local_9;
    output[_e213] = Factor;
    local_10 = u32((offset + 11u));
    let _e220 = local_10;
    output[_e220] = count;
}
