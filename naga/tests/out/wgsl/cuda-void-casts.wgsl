@group(0) @binding(0)
var<storage, read_write> output: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;

@compute @workgroup_size(4, 1, 1)
fn void_casts(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var value: i32;
    var local: i32;
    var local_1: i32;
    var local_2: u32;
    var local_3: u32;
    var index: i32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var turn: i32;
    var local_9: u32;
    var Count: i32;
    var array_: array<i32, 3>;
    var local_10: u32;
    var step_: i32;
    var previous: i32;
    var local_11: i32;
    var local_12: i32;
    var step_1: i32;
    var previous_1: i32;
    var local_13: i32;
    var local_14: i32;
    var local_15: i32;

    let lane = threadIdx.x;
    let base = (4u + (lane * 8u));
    value = (i32(lane) + 1i);
    let _e10 = value;
    value = (_e10 + 1i);
    let _e13 = value;
    value = (_e13 + 1i);
    let _e16 = value;
    value = (_e16 + 1i);
    let _e19 = value;
    output[base] = _e19;
    let choose = ((lane & 1u) == 0u);
    if choose {
        step_ = i32();
        previous = i32();
        step_ = 3i;
        let _e32 = value;
        local_11 = _e32;
        let _e34 = local_11;
        previous = _e34;
        let _e36 = step_;
        let _e37 = value;
        local_12 = _e37;
        let _e39 = local_12;
        value = (_e39 + _e36);
        let _e41 = previous;
        local = _e41;
    } else {
        step_1 = i32();
        previous_1 = i32();
        step_1 = 7i;
        let _e49 = value;
        local_13 = _e49;
        let _e51 = local_13;
        previous_1 = _e51;
        let _e53 = step_1;
        let _e54 = value;
        local_14 = _e54;
        let _e56 = local_14;
        value = (_e56 + _e53);
        let _e58 = previous_1;
        local_1 = _e58;
    }
    let _e60 = value;
    local_2 = u32((base + 1u));
    let _e65 = local_2;
    output[_e65] = _e60;
    let _e67 = value;
    value = (_e67 + 1i);
    let _e70 = value;
    value = (_e70 + 1i);
    let _e73 = value;
    local_3 = u32((base + 2u));
    let _e78 = local_3;
    output[_e78] = _e73;
    index = 0i;
    let _e82 = index;
    index = (_e82 + 1i);
    local_4 = u32(_e82);
    let _e87 = index;
    index = (_e87 + 1i);
    local_5 = u32(_e87);
    let _e92 = index;
    local_6 = u32((base + 3u));
    let _e97 = local_6;
    output[_e97] = _e92;
    let _e103 = input[u32(0i)];
    local_7 = u32((base + 4u));
    let _e108 = local_7;
    output[_e108] = _e103;
    local_15 = i32();
    let _e112 = value;
    local_15 = _e112;
    let _e114 = local_15;
    value = (_e114 + 1i);
    let _e117 = value;
    local_8 = u32((base + 5u));
    let _e122 = local_8;
    output[_e122] = _e117;
    {
        turn = 0i;
        loop {
            let _e126 = turn;
            if (_e126 < 2i) {
            } else {
                break;
            }
            let _e129 = value;
            value = (_e129 + 1i);
            continuing {
                let _e132 = turn;
                turn = (_e132 + 1i);
            }
        }
    }
    let _e135 = value;
    local_9 = u32((base + 6u));
    let _e140 = local_9;
    output[_e140] = _e135;
    let runtime = input[u32(1i)];
    Count = 3i;
    array_ = array<i32, 3>();
    let _e152 = array_[2i];
    local_10 = u32((base + 7u));
    let _e157 = local_10;
    output[_e157] = _e152;
}
