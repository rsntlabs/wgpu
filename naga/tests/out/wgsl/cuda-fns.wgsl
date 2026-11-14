@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<storage> input: array<u32>;
var<workgroup> shared_values: array<u32, 4>;

fn gen__naga_fns(mask: u32, base: u32, offset: i32) -> u32 {
    var position: i32;
    var remaining: i32;

    if (base > 31u) {
        return 4294967295u;
    }
    let _e8 = (base & 31u);
    if (offset == 0i) {
        return select(4294967295u, base, (((mask >> _e8) & 1u) != 0u));
    }
    let _e18 = select(-1i, 1i, (offset > 0i));
    position = i32(_e8);
    remaining = offset;
    loop {
        let _e23 = position;
        if ((_e23 < 0i) || (_e23 > 31i)) {
            break;
        }
        let _e27 = u32(_e23);
        if (((mask >> (_e27 & 31u)) & 1u) != 0u) {
            let _e32 = remaining;
            if (_e32 == _e18) {
                return _e27;
            }
            remaining = (_e32 - _e18);
        }
        position = (_e23 + _e18);
    }
    return 4294967295u;
}

@compute @workgroup_size(4, 1, 1)
fn fns(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var row: u32;
    var at: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var value: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: i32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: bool;
    var local_11: bool;
    var local_12: u32;
    var index: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;

    let lane = threadIdx.x;
    let count = input[u32(0i)];
    shared_values[lane] = (lane + 1u);
    let _e14 = gen__naga_fns(1u, 0u, 1i);
    if (_e14 == 0u) {
        storageBarrier();
        workgroupBarrier();
    }
    {
        row = lane;
        loop {
            let _e18 = row;
            if (_e18 < count) {
            } else {
                break;
            }
            let _e20 = row;
            at = (1u + (_e20 * 3u));
            let _e26 = at;
            local_1 = _e26;
            let _e28 = local_1;
            local_23 = _e28;
            let _e30 = local_23;
            let _e32 = input[_e30];
            local_24 = _e32;
            let _e34 = local_24;
            local_20 = _e34;
            let _e36 = local_20;
            let _e37 = at;
            local_2 = u32((_e37 + 1u));
            let _e42 = local_2;
            local_25 = _e42;
            let _e44 = local_25;
            let _e46 = input[_e44];
            local_26 = _e46;
            let _e48 = local_26;
            local_21 = _e48;
            let _e50 = local_21;
            let _e51 = at;
            local_3 = u32((_e51 + 2u));
            let _e56 = local_3;
            local_27 = _e56;
            let _e58 = local_27;
            let _e60 = input[_e58];
            local_28 = _e60;
            let _e62 = local_28;
            local_22 = _e62;
            let _e64 = local_22;
            let _e66 = gen__naga_fns(_e36, _e50, i32(_e64));
            let _e67 = row;
            local = u32((4u + _e67));
            let _e72 = local;
            local_29 = _e72;
            let _e74 = local_29;
            output[_e74] = _e66;
            continuing {
                let _e77 = row;
                row = (_e77 + 4u);
            }
        }
    }
    let base_1 = ((4u + count) + (lane * 11u));
    value = 1u;
    let _e87 = value;
    value = (_e87 + u32(1i));
    local_4 = ((_e87 * 16909060u) ^ 2164195711u);
    let _e96 = local_4;
    let _e97 = value;
    value = (_e97 + u32(1i));
    local_5 = ((_e97 * 5u) & 31u);
    let _e106 = local_5;
    let _e107 = value;
    value = (_e107 + u32(1i));
    local_6 = (2i - i32(_e107));
    let _e115 = local_6;
    let _e116 = gen__naga_fns(_e96, _e106, _e115);
    output[base_1] = _e116;
    let _e119 = value;
    local_7 = u32((base_1 + 1u));
    let _e124 = local_7;
    output[_e124] = _e119;
    if ((lane & 1u) == 0u) {
        let _e130 = value;
        value = (_e130 + u32(1i));
        let _e136 = gen__naga_fns(_e130, 0u, 1i);
        local_8 = _e136;
    } else {
        local_8 = 0u;
    }
    let _e140 = value;
    local_9 = u32((base_1 + 2u));
    let _e145 = local_9;
    output[_e145] = _e140;
    local_10 = false;
    if false {
        let _e149 = value;
        value = (_e149 + u32(1i));
        let _e155 = gen__naga_fns(_e149, 0u, 1i);
        local_10 = (_e155 != 0u);
    }
    local_11 = true;
    if true {
    } else {
        let _e160 = value;
        value = (_e160 + u32(1i));
        let _e166 = gen__naga_fns(_e160, 0u, 1i);
        local_11 = (_e166 != 0u);
    }
    let _e169 = value;
    value = (_e169 + u32(1i));
    let _e175 = gen__naga_fns(_e169, 0u, 1i);
    let _e176 = value;
    local_12 = u32((base_1 + 3u));
    let _e181 = local_12;
    output[_e181] = _e176;
    index = 1u;
    let _e185 = index;
    index = (_e185 + u32(1i));
    let _e190 = input[_e185];
    let _e191 = index;
    index = (_e191 + u32(1i));
    let _e196 = input[_e191];
    let _e197 = index;
    index = (_e197 + u32(1i));
    let _e202 = input[_e197];
    let _e204 = gen__naga_fns(_e190, _e196, i32(_e202));
    local_13 = u32((base_1 + 4u));
    let _e209 = local_13;
    output[_e209] = _e204;
    let _e211 = index;
    local_14 = u32((base_1 + 5u));
    let _e216 = local_14;
    output[_e216] = _e211;
    let _e221 = gen__naga_fns(2863311530u, 2u, 0i);
    local_15 = u32((base_1 + 6u));
    let _e226 = local_15;
    output[_e226] = _e221;
    let _e231 = gen__naga_fns(2863311530u, 2u, 1i);
    local_16 = u32((base_1 + 7u));
    let _e236 = local_16;
    output[_e236] = _e231;
    let _e242 = gen__naga_fns(2863311530u, 2u, -(1i));
    local_17 = u32((base_1 + 8u));
    let _e247 = local_17;
    output[_e247] = _e242;
    let _e255 = gen__naga_fns(4294967295u, 31u, (-(2147483647i) - 1i));
    local_18 = u32((base_1 + 9u));
    let _e260 = local_18;
    output[_e260] = _e255;
    let _e267 = shared_values[((lane + 1u) & 3u)];
    local_19 = u32((base_1 + 10u));
    let _e272 = local_19;
    output[_e272] = _e267;
}
