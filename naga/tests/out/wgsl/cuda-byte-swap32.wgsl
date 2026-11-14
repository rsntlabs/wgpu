@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<storage> input: array<u32>;

fn swap_result(value_2: u32) -> i32 {
    return 1i;
}

@compute @workgroup_size(4, 1, 1)
fn byte_swap32_(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var row: u32;
    var value: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var value_1: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: bool;
    var local_8: bool;
    var local_9: u32;
    var index: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;

    let lane = threadIdx.x;
    let count = input[u32(0i)];
    {
        row = lane;
        loop {
            let _e8 = row;
            if (_e8 < count) {
            } else {
                break;
            }
            let _e10 = row;
            local = u32((1u + _e10));
            let _e15 = local;
            local_16 = _e15;
            let _e17 = local_16;
            let _e19 = input[_e17];
            local_17 = _e19;
            let _e21 = local_17;
            local_15 = _e21;
            let _e23 = local_15;
            value = _e23;
            let _e25 = value;
            let _e40 = row;
            local_1 = u32((4u + (_e40 * 2u)));
            let _e47 = local_1;
            local_18 = _e47;
            let _e49 = local_18;
            output[_e49] = ((((_e25 & 255u) << 24u) | ((_e25 & 65280u) << 8u)) | (((_e25 >> 8u) & 65280u) | (_e25 >> 24u)));
            let _e52 = value;
            let _e66 = ((((_e52 & 255u) << 24u) | ((_e52 & 65280u) << 8u)) | (((_e52 >> 8u) & 65280u) | (_e52 >> 24u)));
            let _e81 = row;
            local_2 = u32((5u + (_e81 * 2u)));
            let _e88 = local_2;
            local_19 = _e88;
            let _e90 = local_19;
            output[_e90] = ((((_e66 & 255u) << 24u) | ((_e66 & 65280u) << 8u)) | (((_e66 >> 8u) & 65280u) | (_e66 >> 24u)));
            continuing {
                let _e92 = row;
                row = (_e92 + 4u);
            }
        }
    }
    let base = ((4u + (count * 2u)) + (lane * 10u));
    value_1 = (16909060u + lane);
    let _e105 = value_1;
    value_1 = (_e105 + u32(1i));
    output[base] = ((((_e105 & 255u) << 24u) | ((_e105 & 65280u) << 8u)) | (((_e105 >> 8u) & 65280u) | (_e105 >> 24u)));
    let _e125 = value_1;
    value_1 = (_e125 + u32(1i));
    local_3 = u32((base + 1u));
    let _e147 = local_3;
    output[_e147] = ((((_e125 & 255u) << 24u) | ((_e125 & 65280u) << 8u)) | (((_e125 >> 8u) & 65280u) | (_e125 >> 24u)));
    let _e149 = value_1;
    local_4 = u32((base + 2u));
    let _e154 = local_4;
    output[_e154] = _e149;
    if ((lane & 1u) == 0u) {
        let _e160 = value_1;
        value_1 = (_e160 + u32(1i));
        local_5 = ((((_e160 & 255u) << 24u) | ((_e160 & 65280u) << 8u)) | (((_e160 >> 8u) & 65280u) | (_e160 >> 24u)));
    } else {
        local_5 = 0u;
    }
    let _e181 = value_1;
    local_6 = u32((base + 3u));
    let _e186 = local_6;
    output[_e186] = _e181;
    local_7 = false;
    if false {
        let _e190 = value_1;
        value_1 = (_e190 + u32(1i));
        local_7 = (((((_e190 & 255u) << 24u) | ((_e190 & 65280u) << 8u)) | (((_e190 >> 8u) & 65280u) | (_e190 >> 24u))) != 0u);
    }
    local_8 = true;
    if true {
    } else {
        let _e212 = value_1;
        value_1 = (_e212 + u32(1i));
        local_8 = (((((_e212 & 255u) << 24u) | ((_e212 & 65280u) << 8u)) | (((_e212 >> 8u) & 65280u) | (_e212 >> 24u))) != 0u);
    }
    let _e232 = value_1;
    value_1 = (_e232 + u32(1i));
    let _e236 = value_1;
    local_9 = u32((base + 4u));
    let _e241 = local_9;
    output[_e241] = _e236;
    index = 1u;
    let _e245 = index;
    index = (_e245 + u32(1i));
    let _e250 = input[_e245];
    local_10 = u32((base + 5u));
    let _e269 = local_10;
    output[_e269] = ((((_e250 & 255u) << 24u) | ((_e250 & 65280u) << 8u)) | (((_e250 >> 8u) & 65280u) | (_e250 >> 24u)));
    let _e271 = index;
    local_11 = u32((base + 6u));
    let _e276 = local_11;
    output[_e276] = _e271;
    let _e278 = value_1;
    let _e293 = swap_result(((((_e278 & 255u) << 24u) | ((_e278 & 65280u) << 8u)) | (((_e278 >> 8u) & 65280u) | (_e278 >> 24u))));
    local_12 = u32((base + 7u));
    let _e299 = local_12;
    output[_e299] = u32(_e293);
    local_13 = u32((base + 8u));
    let _e320 = local_13;
    output[_e320] = ((((4294967295u & 255u) << 24u) | ((4294967295u & 65280u) << 8u)) | (((4294967295u >> 8u) & 65280u) | (4294967295u >> 24u)));
    let _e322 = value_1;
    let _e336 = ((((_e322 & 255u) << 24u) | ((_e322 & 65280u) << 8u)) | (((_e322 >> 8u) & 65280u) | (_e322 >> 24u)));
    local_14 = u32((base + 9u));
    let _e355 = local_14;
    output[_e355] = ((((_e336 & 255u) << 24u) | ((_e336 & 65280u) << 8u)) | (((_e336 >> 8u) & 65280u) | (_e336 >> 24u)));
}
