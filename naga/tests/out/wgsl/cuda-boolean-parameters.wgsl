struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<uniform> enabled_1: type_3;
@group(0) @binding(1)
var<uniform> frozen: type_3;
@group(0) @binding(2)
var<storage, read_write> output: array<u32>;

fn flag_overload(value: bool) -> i32 {
    var local_8: i32;

    if value {
        local_8 = 31i;
    } else {
        local_8 = 17i;
    }
    let _e6 = local_8;
    return _e6;
}

@compute @workgroup_size(4, 1, 1)
fn boolean_parameters(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var enabled: bool;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: i32;

    let _e3 = enabled_1.value;
    enabled = ((_e3 & 255u) != 0u);
    let _e11 = frozen.value;
    let frozen_1 = ((_e11 & 255u) != 0u);
    let index = (4u + (threadIdx.x * 8u));
    let original = enabled;
    let _e22 = enabled;
    output[index] = u32(_e22);
    let _e26 = enabled;
    let _e27 = flag_overload(_e26);
    local = u32((index + 1u));
    let _e33 = local;
    output[_e33] = u32(_e27);
    let _e35 = enabled;
    enabled = !(_e35);
    let _e37 = enabled;
    local_1 = u32((index + 2u));
    let _e43 = local_1;
    output[_e43] = u32(_e37);
    let _e45 = enabled;
    let _e46 = flag_overload(_e45);
    local_2 = u32((index + 3u));
    let _e52 = local_2;
    output[_e52] = u32(_e46);
    local_3 = u32((index + 4u));
    let _e59 = local_3;
    output[_e59] = u32(frozen_1);
    local_7 = i32();
    if frozen_1 {
        local_7 = 7i;
    } else {
        local_7 = 9i;
    }
    let _e68 = local_7;
    local_4 = u32((index + 5u));
    let _e74 = local_4;
    output[_e74] = u32(_e68);
    let _e76 = flag_overload(original);
    local_5 = u32((index + 6u));
    let _e82 = local_5;
    output[_e82] = u32(_e76);
    let _e84 = enabled;
    local_6 = u32((index + 7u));
    let _e93 = local_6;
    output[_e93] = u32((i32(_e84) != i32(frozen_1)));
}
