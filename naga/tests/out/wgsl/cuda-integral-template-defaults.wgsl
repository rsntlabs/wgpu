const N_1: i32 = 4i;

var<private> threadIdx_1: vec3<u32>;
@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<storage> input: array<i32>;

fn choose(value: i32) -> i32 {
    return (value + 10i);
}

fn self_named_4_() -> i32 {
    return 4i;
}

fn inherited_5_() -> i32 {
    return 5i;
}

fn value_7_() -> i32 {
    return 7i;
}

fn add_3_int(value_1: i32) -> i32 {
    return (value_1 + 3i);
}

fn add_7_unsigned(value_2: u32) -> u32 {
    return (value_2 + u32(7i));
}

fn mixed_unsigned_5_() -> u32 {
    return u32(5i);
}

fn mixed_int_8_() -> i32 {
    return 8i;
}

fn flags_true_4u() -> u32 {
    return (u32(true) + 4u);
}

fn cast_value_3_() -> i32 {
    return 3i;
}

fn comma_value_2_() -> i32 {
    return 2i;
}

fn shifted_4_() -> i32 {
    return 4i;
}

fn choose_20_unsigned(value_3: u32) -> i32 {
    return (i32(value_3) + 20i);
}

fn choose_20_int(value_4: i32) -> i32 {
    return (value_4 + 20i);
}

fn skipped_thread_true() -> i32 {
    return i32(true);
}

fn skipped_grid_false() -> i32 {
    return i32(false);
}

fn skipped_call_true() -> i32 {
    return i32(true);
}

@compute @workgroup_size(4, 1, 1)
fn integral_template_defaults(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var N: i32;
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
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var state: i32;
    var local_15: u32;
    var local_16: u32;
    var local_17: bool;
    var local_18: i32;
    var local_19: bool;
    var local_20: i32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var index: i32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var old: i32;
    var old_1: i32;
    var old_2: i32;
    var local_28: i32;
    var local_29: i32;
    var old_3: i32;
    var local_30: i32;
    var local_31: i32;
    var old_4: i32;

    threadIdx_1 = threadIdx;
    let lane = threadIdx.x;
    let base = (4u + (lane * 24u));
    N = 99i;
    let _e9 = self_named_4_();
    output[base] = u32(_e9);
    let _e13 = inherited_5_();
    local = u32((base + 1u));
    let _e19 = local;
    output[_e19] = u32(_e13);
    let _e21 = value_7_();
    local_1 = u32((base + 2u));
    let _e27 = local_1;
    output[_e27] = u32(_e21);
    let _e29 = value_7_();
    local_2 = u32((base + 3u));
    let _e35 = local_2;
    output[_e35] = u32(_e29);
    let _e37 = value_7_();
    local_3 = u32((base + 4u));
    let _e43 = local_3;
    output[_e43] = u32(_e37);
    let _e46 = add_3_int(2i);
    local_4 = u32((base + 5u));
    let _e52 = local_4;
    output[_e52] = u32(_e46);
    let _e55 = add_7_unsigned(3u);
    local_5 = u32((base + 6u));
    let _e60 = local_5;
    output[_e60] = _e55;
    let _e62 = mixed_unsigned_5_();
    local_6 = u32((base + 7u));
    let _e67 = local_6;
    output[_e67] = _e62;
    let _e69 = mixed_int_8_();
    local_7 = u32((base + 8u));
    let _e75 = local_7;
    output[_e75] = u32(_e69);
    let _e77 = flags_true_4u();
    local_8 = u32((base + 9u));
    let _e82 = local_8;
    output[_e82] = _e77;
    let _e84 = cast_value_3_();
    local_9 = u32((base + 10u));
    let _e90 = local_9;
    output[_e90] = u32(_e84);
    let _e92 = comma_value_2_();
    local_10 = u32((base + 11u));
    let _e98 = local_10;
    output[_e98] = u32(_e92);
    let _e100 = shifted_4_();
    local_11 = u32((base + 12u));
    let _e106 = local_11;
    output[_e106] = u32(_e100);
    let _e109 = choose(1i);
    local_12 = u32((base + 13u));
    let _e115 = local_12;
    output[_e115] = u32(_e109);
    let _e118 = choose_20_unsigned(1u);
    local_13 = u32((base + 14u));
    let _e124 = local_13;
    output[_e124] = u32(_e118);
    let _e127 = choose_20_int(1i);
    local_14 = u32((base + 15u));
    let _e133 = local_14;
    output[_e133] = u32(_e127);
    state = (i32(lane) + 1i);
    old = i32();
    let _e141 = state;
    old = _e141;
    let _e143 = state;
    state = (_e143 + 2i);
    let _e146 = old;
    local_15 = u32((base + 16u));
    let _e152 = local_15;
    output[_e152] = u32(_e146);
    old_1 = i32();
    let _e156 = state;
    old_1 = _e156;
    let _e158 = state;
    state = (_e158 + 3i);
    let _e161 = old_1;
    local_16 = u32((base + 17u));
    let _e167 = local_16;
    output[_e167] = u32(_e161);
    local_17 = false;
    if false {
        old_2 = i32();
        let _e173 = state;
        local_28 = _e173;
        let _e175 = local_28;
        old_2 = _e175;
        let _e177 = state;
        local_29 = _e177;
        let _e179 = local_29;
        state = (_e179 + 2i);
        let _e182 = old_2;
        local_18 = _e182;
        let _e184 = local_18;
        local_17 = (_e184 != 0i);
    }
    local_19 = true;
    if true {
    } else {
        old_3 = i32();
        let _e191 = state;
        local_30 = _e191;
        let _e193 = local_30;
        old_3 = _e193;
        let _e195 = state;
        local_31 = _e195;
        let _e197 = local_31;
        state = (_e197 + 2i);
        let _e200 = old_3;
        local_20 = _e200;
        let _e202 = local_20;
        local_19 = (_e202 != 0i);
    }
    old_4 = i32();
    let _e207 = state;
    old_4 = _e207;
    let _e209 = state;
    state = (_e209 + 2i);
    let _e212 = state;
    local_21 = u32((base + 18u));
    let _e218 = local_21;
    output[_e218] = u32(_e212);
    let _e220 = skipped_thread_true();
    local_22 = u32((base + 19u));
    let _e226 = local_22;
    output[_e226] = u32(_e220);
    let _e228 = skipped_grid_false();
    local_23 = u32((base + 20u));
    let _e234 = local_23;
    output[_e234] = u32(_e228);
    let _e236 = skipped_call_true();
    local_24 = u32((base + 21u));
    let _e242 = local_24;
    output[_e242] = u32(_e236);
    index = 0i;
    let _e246 = index;
    index = (_e246 + 1i);
    local_26 = u32(_e246);
    let _e251 = local_26;
    let _e254 = input[_e251];
    let _e255 = add_3_int(_e254);
    local_25 = u32((base + 22u));
    let _e261 = local_25;
    output[_e261] = u32(_e255);
    let _e263 = index;
    local_27 = u32((base + 23u));
    let _e269 = local_27;
    output[_e269] = u32(_e263);
}
