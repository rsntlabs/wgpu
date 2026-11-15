const Initial_1: i32 = 6i;

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<storage> input: array<i32>;

fn chain_6_6u_6_() -> u32 {
    return u32(6i);
}

fn chain_7_7u_7_() -> u32 {
    return u32(7i);
}

fn merged_8_8_() -> i32 {
    return 8i;
}

fn flag_0_false() -> u32 {
    return u32(false);
}

fn flag_1_true() -> u32 {
    return u32(true);
}

fn cross_u002d_1_7u() -> u32 {
    return 7u;
}

fn wide_65535ULL_65535u() -> u32 {
    return 65535u;
}

fn mixed_unsigned_4_4_() -> u32 {
    return u32(4i);
}

fn mixed_int_9_9_() -> i32 {
    return 9i;
}

fn choose_3_3_unsigned(value: u32) -> u32 {
    return (value + u32(3i));
}

@compute @workgroup_size(4, 1, 1)
fn dependent_integral_defaults(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var Initial: i32;
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
    var state: i32;
    var local_11: u32;
    var local_12: bool;
    var local_13: i32;
    var local_14: bool;
    var local_15: i32;
    var local_16: u32;
    var index: i32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var old: i32;
    var old_1: i32;
    var local_20: i32;
    var local_21: i32;
    var old_2: i32;
    var local_22: i32;
    var local_23: i32;
    var old_3: i32;

    let lane = threadIdx.x;
    let base = (4u + (lane * 16u));
    Initial = 99i;
    let _e8 = chain_6_6u_6_();
    output[base] = _e8;
    let _e11 = chain_6_6u_6_();
    local = u32((base + 1u));
    let _e16 = local;
    output[_e16] = _e11;
    let _e18 = chain_6_6u_6_();
    local_1 = u32((base + 2u));
    let _e23 = local_1;
    output[_e23] = _e18;
    let _e25 = chain_7_7u_7_();
    local_2 = u32((base + 3u));
    let _e30 = local_2;
    output[_e30] = _e25;
    let _e32 = merged_8_8_();
    local_3 = u32((base + 4u));
    let _e38 = local_3;
    output[_e38] = u32(_e32);
    let _e40 = flag_0_false();
    local_4 = u32((base + 5u));
    let _e45 = local_4;
    output[_e45] = _e40;
    let _e47 = flag_1_true();
    local_5 = u32((base + 6u));
    let _e52 = local_5;
    output[_e52] = _e47;
    let _e54 = cross_u002d_1_7u();
    local_6 = u32((base + 7u));
    let _e59 = local_6;
    output[_e59] = _e54;
    let _e61 = wide_65535ULL_65535u();
    local_7 = u32((base + 8u));
    let _e66 = local_7;
    output[_e66] = _e61;
    let _e68 = mixed_unsigned_4_4_();
    local_8 = u32((base + 9u));
    let _e73 = local_8;
    output[_e73] = _e68;
    let _e75 = mixed_int_9_9_();
    local_9 = u32((base + 10u));
    let _e81 = local_9;
    output[_e81] = u32(_e75);
    let _e84 = choose_3_3_unsigned(2u);
    local_10 = u32((base + 11u));
    let _e89 = local_10;
    output[_e89] = _e84;
    state = (i32(lane) + 1i);
    old = i32();
    let _e97 = state;
    old = _e97;
    let _e99 = state;
    state = (_e99 + 2i);
    let _e102 = old;
    local_11 = u32((base + 12u));
    let _e108 = local_11;
    output[_e108] = u32(_e102);
    local_12 = false;
    if false {
        old_1 = i32();
        let _e114 = state;
        local_20 = _e114;
        let _e116 = local_20;
        old_1 = _e116;
        let _e118 = state;
        local_21 = _e118;
        let _e120 = local_21;
        state = (_e120 + 99i);
        let _e123 = old_1;
        local_13 = _e123;
        let _e125 = local_13;
        local_12 = (_e125 != 0i);
    }
    local_14 = true;
    if true {
    } else {
        old_2 = i32();
        let _e132 = state;
        local_22 = _e132;
        let _e134 = local_22;
        old_2 = _e134;
        let _e136 = state;
        local_23 = _e136;
        let _e138 = local_23;
        state = (_e138 + 99i);
        let _e141 = old_2;
        local_15 = _e141;
        let _e143 = local_15;
        local_14 = (_e143 != 0i);
    }
    old_3 = i32();
    let _e148 = state;
    old_3 = _e148;
    let _e150 = state;
    state = (_e150 + 3i);
    let _e153 = state;
    local_16 = u32((base + 13u));
    let _e159 = local_16;
    output[_e159] = u32(_e153);
    index = 0i;
    let _e163 = index;
    index = (_e163 + 1i);
    local_18 = u32(_e163);
    let _e168 = local_18;
    let _e171 = input[_e168];
    let _e173 = choose_3_3_unsigned(u32(_e171));
    local_17 = u32((base + 14u));
    let _e178 = local_17;
    output[_e178] = _e173;
    let _e180 = index;
    local_19 = u32((base + 15u));
    let _e186 = local_19;
    output[_e186] = u32(_e180);
}
