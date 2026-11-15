const Safe: bool = true;

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

fn choose_noexcept(value_1: i32) -> i32 {
    return (10i + value_1);
}

fn choose_noexcept_1(value_2: u32) -> i32 {
    return (20i + i32(value_2));
}

fn combined_noexcept(a: u32, b: u32) -> u32 {
    return ((((a & 65535u) + (b & 65535u)) & 65535u) | (((((a >> 16u) & 65535u) + ((b >> 16u) & 65535u)) & 65535u) << 16u));
}

fn skipped_noexcept() -> i32 {
    var local_37: bool;

    return 7i;
}

fn converted_noexcept() -> i32 {
    return 9i;
}

fn false_noexcept() -> i32 {
    return 13i;
}

fn reverse_noexcept() -> i32 {
    return 14i;
}

fn default_noexcept(value_3: i32) -> i32 {
    return (value_3 + 4i);
}

fn float_bool_noexcept() -> i32 {
    return 15i;
}

@compute @workgroup_size(4, 1, 1)
fn noexcept_helpers(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var value: i32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: bool;
    var local_9: i32;
    var local_10: bool;
    var local_11: i32;
    var local_12: i32;
    var local_13: i32;
    var local_14: i32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: i32;
    var local_19: u32;
    var local_20: i32;
    var local_21: u32;
    var local_22: i32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var amount: i32;
    var old: i32;
    var amount_1: i32;
    var old_1: i32;
    var scale: u32;
    var scale_1: u32;
    var amount_2: i32;
    var old_2: i32;
    var local_29: i32;
    var local_30: i32;
    var amount_3: i32;
    var old_3: i32;
    var local_31: i32;
    var local_32: i32;
    var amount_4: i32;
    var old_4: i32;
    var local_33: i32;
    var local_34: i32;
    var amount_5: i32;
    var old_5: i32;
    var local_35: i32;
    var local_36: i32;
    var amount_6: i32;
    var old_6: i32;

    let lane = threadIdx.x;
    let base = (4u + (lane * 18u));
    value = (i32(lane) + 1i);
    amount = i32();
    old = i32();
    amount = 2i;
    let _e16 = value;
    old = _e16;
    let _e18 = amount;
    let _e19 = value;
    value = (_e19 + _e18);
    let _e21 = old;
    output[base] = u32(_e21);
    amount_1 = i32();
    old_1 = i32();
    amount_1 = 5i;
    let _e31 = value;
    old_1 = _e31;
    let _e33 = amount_1;
    let _e34 = value;
    value = (_e34 + _e33);
    let _e36 = old_1;
    local = u32((base + 1u));
    let _e42 = local;
    output[_e42] = u32(_e36);
    let _e44 = value;
    local_1 = u32((base + 2u));
    let _e50 = local_1;
    output[_e50] = u32(_e44);
    let _e53 = choose_noexcept(1i);
    local_2 = u32((base + 3u));
    let _e59 = local_2;
    output[_e59] = u32(_e53);
    let _e62 = choose_noexcept_1(1u);
    local_3 = u32((base + 4u));
    let _e68 = local_3;
    output[_e68] = u32(_e62);
    scale = u32();
    scale = 3u;
    let _e74 = value;
    value = (_e74 + 1i);
    let _e78 = scale;
    local_5 = (u32(_e74) * _e78);
    let _e81 = local_5;
    scale_1 = u32();
    scale_1 = 5u;
    let _e86 = value;
    value = (_e86 + 1i);
    let _e90 = scale_1;
    local_6 = (u32(_e86) * _e90);
    let _e93 = local_6;
    let _e94 = combined_noexcept(_e81, _e93);
    local_4 = u32((base + 5u));
    let _e99 = local_4;
    output[_e99] = _e94;
    let _e101 = value;
    local_7 = u32((base + 6u));
    let _e107 = local_7;
    output[_e107] = u32(_e101);
    local_8 = false;
    if false {
        amount_2 = i32();
        old_2 = i32();
        amount_2 = 2i;
        let _e117 = value;
        local_29 = _e117;
        let _e119 = local_29;
        old_2 = _e119;
        let _e121 = amount_2;
        let _e122 = value;
        local_30 = _e122;
        let _e124 = local_30;
        value = (_e124 + _e121);
        let _e126 = old_2;
        local_9 = _e126;
        let _e128 = local_9;
        local_8 = (_e128 != 0i);
    }
    local_10 = true;
    if true {
    } else {
        amount_3 = i32();
        old_3 = i32();
        amount_3 = 2i;
        let _e139 = value;
        local_31 = _e139;
        let _e141 = local_31;
        old_3 = _e141;
        let _e143 = amount_3;
        let _e144 = value;
        local_32 = _e144;
        let _e146 = local_32;
        value = (_e146 + _e143);
        let _e148 = old_3;
        local_11 = _e148;
        let _e150 = local_11;
        local_10 = (_e150 != 0i);
    }
    if ((lane & 1u) == 0u) {
        amount_4 = i32();
        old_4 = i32();
        amount_4 = 2i;
        let _e163 = value;
        local_33 = _e163;
        let _e165 = local_33;
        old_4 = _e165;
        let _e167 = amount_4;
        let _e168 = value;
        local_34 = _e168;
        let _e170 = local_34;
        value = (_e170 + _e167);
        let _e172 = old_4;
        local_12 = _e172;
        let _e174 = local_12;
        local_14 = _e174;
    } else {
        amount_5 = i32();
        old_5 = i32();
        amount_5 = 3i;
        let _e182 = value;
        local_35 = _e182;
        let _e184 = local_35;
        old_5 = _e184;
        let _e186 = amount_5;
        let _e187 = value;
        local_36 = _e187;
        let _e189 = local_36;
        value = (_e189 + _e186);
        let _e191 = old_5;
        local_13 = _e191;
        let _e193 = local_13;
        local_14 = _e193;
    }
    let _e195 = value;
    local_15 = u32((base + 7u));
    let _e201 = local_15;
    output[_e201] = u32(_e195);
    amount_6 = i32();
    old_6 = i32();
    amount_6 = 2i;
    let _e209 = value;
    old_6 = _e209;
    let _e211 = amount_6;
    let _e212 = value;
    value = (_e212 + _e211);
    let _e214 = value;
    local_16 = u32((base + 8u));
    let _e220 = local_16;
    output[_e220] = u32(_e214);
    let _e222 = value;
    local_18 = (_e222 + 1i);
    let _e226 = local_18;
    local_17 = u32((base + 9u));
    let _e232 = local_17;
    output[_e232] = u32(_e226);
    let _e234 = value;
    local_20 = (_e234 + 2i);
    let _e238 = local_20;
    local_19 = u32((base + 10u));
    let _e244 = local_19;
    output[_e244] = u32(_e238);
    let _e246 = value;
    local_22 = (_e246 + 3i);
    let _e250 = local_22;
    local_21 = u32((base + 11u));
    let _e256 = local_21;
    output[_e256] = u32(_e250);
    let _e258 = skipped_noexcept();
    local_23 = u32((base + 12u));
    let _e264 = local_23;
    output[_e264] = u32(_e258);
    let _e266 = converted_noexcept();
    local_24 = u32((base + 13u));
    let _e272 = local_24;
    output[_e272] = u32(_e266);
    let _e274 = false_noexcept();
    local_25 = u32((base + 14u));
    let _e280 = local_25;
    output[_e280] = u32(_e274);
    let _e282 = reverse_noexcept();
    local_26 = u32((base + 15u));
    let _e288 = local_26;
    output[_e288] = u32(_e282);
    let _e291 = default_noexcept(3i);
    local_27 = u32((base + 16u));
    let _e297 = local_27;
    output[_e297] = u32(_e291);
    let _e299 = float_bool_noexcept();
    local_28 = u32((base + 17u));
    let _e305 = local_28;
    output[_e305] = u32(_e299);
}
