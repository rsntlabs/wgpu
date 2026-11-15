const Count_1: i32 = 5i;

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<storage> input: array<i32>;

fn kind(value_6: u32) -> i32 {
    return 2i;
}

fn value_unsigned_5_() -> u32 {
    return u32(5i);
}

fn self_named_unsigned() -> u32 {
    return u32(9i);
}

fn choose_3_(value_7: i32) -> i32 {
    return (3i + value_7);
}

fn choose_5_(value_8: u32) -> i32 {
    return ((20i + 5i) + i32(value_8));
}

fn choose_7_(value_9: i32) -> i32 {
    return (7i + value_9);
}

fn caller_1_() -> u32 {
    let _e0 = value_unsigned_5_();
    return _e0;
}

@compute @workgroup_size(4, 1, 1)
fn template_default_merging(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var Count: i32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var state: i32;
    var local_9: u32;
    var local_10: u32;
    var local_11: bool;
    var local_12: i32;
    var local_13: bool;
    var local_14: i32;
    var local_15: u32;
    var index: i32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var value: i32;
    var old: i32;
    var value_1: u32;
    var old_1: i32;
    var value_2: i32;
    var old_2: i32;
    var local_20: i32;
    var local_21: i32;
    var value_3: i32;
    var old_3: i32;
    var local_22: i32;
    var local_23: i32;
    var value_4: i32;
    var old_4: i32;
    var value_5: i32;
    var old_5: i32;

    let lane = threadIdx.x;
    let base = (4u + (lane * 16u));
    Count = 99i;
    let _e8 = value_unsigned_5_();
    output[base] = _e8;
    let _e11 = value_unsigned_5_();
    local = u32((base + 1u));
    let _e16 = local;
    output[_e16] = _e11;
    let _e18 = value_unsigned_5_();
    local_1 = u32((base + 2u));
    let _e23 = local_1;
    output[_e23] = _e18;
    let _e25 = value_unsigned_5_();
    local_2 = u32((base + 3u));
    let _e30 = local_2;
    output[_e30] = _e25;
    let _e32 = self_named_unsigned();
    local_3 = u32((base + 4u));
    let _e37 = local_3;
    output[_e37] = _e32;
    let _e39 = value_unsigned_5_();
    let _e40 = kind(_e39);
    local_4 = u32((base + 5u));
    let _e46 = local_4;
    output[_e46] = u32(_e40);
    let _e49 = choose_3_(1i);
    local_5 = u32((base + 6u));
    let _e55 = local_5;
    output[_e55] = u32(_e49);
    let _e58 = choose_5_(1u);
    local_6 = u32((base + 7u));
    let _e64 = local_6;
    output[_e64] = u32(_e58);
    let _e67 = choose_7_(1i);
    local_7 = u32((base + 8u));
    let _e73 = local_7;
    output[_e73] = u32(_e67);
    let _e75 = caller_1_();
    local_8 = u32((base + 9u));
    let _e80 = local_8;
    output[_e80] = _e75;
    state = (i32(lane) + 1i);
    value = i32();
    old = i32();
    value = 1i;
    let _e92 = state;
    old = _e92;
    let _e94 = value;
    let _e97 = state;
    state = (_e97 + (2i + _e94));
    let _e99 = old;
    local_9 = u32((base + 10u));
    let _e105 = local_9;
    output[_e105] = u32(_e99);
    value_1 = u32();
    old_1 = i32();
    value_1 = 2u;
    let _e113 = state;
    old_1 = _e113;
    let _e115 = value_1;
    let _e119 = state;
    state = (_e119 + (3i + i32(_e115)));
    let _e121 = old_1;
    local_10 = u32((base + 11u));
    let _e127 = local_10;
    output[_e127] = u32(_e121);
    local_11 = false;
    if false {
        value_2 = i32();
        old_2 = i32();
        value_2 = 9i;
        let _e137 = state;
        local_20 = _e137;
        let _e139 = local_20;
        old_2 = _e139;
        let _e141 = value_2;
        let _e144 = state;
        local_21 = _e144;
        let _e146 = local_21;
        state = (_e146 + (2i + _e141));
        let _e148 = old_2;
        local_12 = _e148;
        let _e150 = local_12;
        local_11 = (_e150 != 0i);
    }
    local_13 = true;
    if true {
    } else {
        value_3 = i32();
        old_3 = i32();
        value_3 = 9i;
        let _e161 = state;
        local_22 = _e161;
        let _e163 = local_22;
        old_3 = _e163;
        let _e165 = value_3;
        let _e168 = state;
        local_23 = _e168;
        let _e170 = local_23;
        state = (_e170 + (2i + _e165));
        let _e172 = old_3;
        local_14 = _e172;
        let _e174 = local_14;
        local_13 = (_e174 != 0i);
    }
    value_4 = i32();
    old_4 = i32();
    value_4 = 0i;
    let _e183 = state;
    old_4 = _e183;
    let _e185 = value_4;
    let _e188 = state;
    state = (_e188 + (2i + _e185));
    let _e190 = state;
    local_15 = u32((base + 12u));
    let _e196 = local_15;
    output[_e196] = u32(_e190);
    index = 0i;
    let _e200 = index;
    index = (_e200 + 1i);
    local_17 = u32(_e200);
    let _e205 = local_17;
    let _e208 = input[_e205];
    value_5 = i32();
    old_5 = i32();
    value_5 = _e208;
    let _e214 = state;
    old_5 = _e214;
    let _e216 = value_5;
    let _e219 = state;
    state = (_e219 + (2i + _e216));
    let _e221 = old_5;
    local_16 = u32((base + 13u));
    let _e227 = local_16;
    output[_e227] = u32(_e221);
    let _e229 = state;
    local_18 = u32((base + 14u));
    let _e235 = local_18;
    output[_e235] = u32(_e229);
    let _e237 = index;
    local_19 = u32((base + 15u));
    let _e243 = local_19;
    output[_e243] = u32(_e237);
}
