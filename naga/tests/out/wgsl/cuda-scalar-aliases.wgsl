struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;
@group(0) @binding(1)
var<storage> input: array<i32>;
@group(0) @binding(2)
var<uniform> n_1: type_5;
var<workgroup> shared_values: array<u32, 64>;

fn transform(value: f32, multiplier: f32, offset: i32) -> i32 {
    var value_1: f32;
    var multiplier_1: f32;
    var offset_1: i32;

    value_1 = value;
    multiplier_1 = multiplier;
    offset_1 = offset;
    let _e6 = value_1;
    let _e7 = multiplier_1;
    let _e9 = offset_1;
    return i32(((_e6 * _e7) + f32(_e9)));
}

@compute @workgroup_size(64, 1, 1)
fn scalar_aliases(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var n: u32;
    var i: u32;
    var base: u32;
    var lane: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var signed_count: i32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var fraction: f32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var after_block: i32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var coefficient: f32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var selected: bool;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var total: i32;
    var current: i32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var after_loop: f32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: i32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var local_46: u32;

    local = 0u;
    local_1 = 0u;
    let _e8 = n_1.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e16 = i;
    let _e17 = n;
    if (_e16 < _e17) {
        let _e19 = i;
        base = (_e19 * 10u);
        lane = threadIdx.x;
        let _e25 = i;
        let _e28 = lane;
        shared_values[_e28] = (_e25 + 10u);
        let _e31 = lane;
        let _e33 = shared_values[_e31];
        let _e34 = local;
        local_2 = _e34;
        let _e36 = local_2;
        local_3 = u32(_e36);
        let _e39 = base;
        local_4 = u32(_e39);
        let _e43 = local_3;
        let _e44 = local_4;
        local_35 = u32((_e43 + _e44));
        let _e48 = local_35;
        out[_e48] = _e33;
        let _e50 = local_1;
        local_8 = _e50;
        let _e52 = local_8;
        local_9 = u32(_e52);
        let _e55 = i;
        local_10 = u32(_e55);
        let _e59 = local_9;
        let _e60 = local_10;
        local_36 = u32((_e59 + _e60));
        let _e65 = local_36;
        let _e67 = input[_e65];
        local_37 = _e67;
        let _e68 = local_37;
        let _e72 = transform(f32(_e68), 2f, 1i);
        let _e74 = local;
        local_5 = _e74;
        let _e76 = local_5;
        local_6 = u32(_e76);
        let _e79 = base;
        local_7 = u32((_e79 + 1u));
        let _e84 = local_6;
        let _e85 = local_7;
        local_38 = u32((_e84 + _e85));
        let _e89 = local_38;
        out[_e89] = u32(_e72);
        signed_count = -(3i);
        let _e94 = signed_count;
        let _e96 = local;
        local_11 = _e96;
        let _e98 = local_11;
        local_12 = u32(_e98);
        let _e101 = base;
        local_13 = u32((_e101 + 2u));
        let _e106 = local_12;
        let _e107 = local_13;
        local_39 = u32((_e106 + _e107));
        let _e111 = local_39;
        out[_e111] = u32(_e94);
        {
            fraction = 3.75f;
            let _e115 = fraction;
            let _e117 = local;
            local_14 = _e117;
            let _e119 = local_14;
            local_15 = u32(_e119);
            let _e122 = base;
            local_16 = u32((_e122 + 3u));
            let _e127 = local_15;
            let _e128 = local_16;
            local_40 = u32((_e127 + _e128));
            let _e132 = local_40;
            out[_e132] = u32(_e115);
        }
        after_block = -(5i);
        let _e137 = after_block;
        let _e139 = local;
        local_17 = _e139;
        let _e141 = local_17;
        local_18 = u32(_e141);
        let _e144 = base;
        local_19 = u32((_e144 + 4u));
        let _e149 = local_18;
        let _e150 = local_19;
        local_41 = u32((_e149 + _e150));
        let _e154 = local_41;
        out[_e154] = u32(_e137);
        coefficient = 1.25f;
        let _e158 = coefficient;
        let _e162 = local;
        local_20 = _e162;
        let _e164 = local_20;
        local_21 = u32(_e164);
        let _e167 = base;
        local_22 = u32((_e167 + 5u));
        let _e172 = local_21;
        let _e173 = local_22;
        local_42 = u32((_e172 + _e173));
        let _e177 = local_42;
        out[_e177] = u32((_e158 * 4f));
        let _e179 = i;
        selected = ((_e179 % 2u) == 0u);
        let _e185 = selected;
        let _e187 = local;
        local_23 = _e187;
        let _e189 = local_23;
        local_24 = u32(_e189);
        let _e192 = base;
        local_25 = u32((_e192 + 6u));
        let _e197 = local_24;
        let _e198 = local_25;
        local_43 = u32((_e197 + _e198));
        let _e202 = local_43;
        out[_e202] = u32(_e185);
        total = 0i;
        {
            loop {
                let _e206 = total;
                if (_e206 < 3i) {
                } else {
                    break;
                }
                let _e209 = total;
                current = _e209;
                let _e211 = current;
                total = (_e211 + 1i);
            }
        }
        let _e214 = total;
        let _e216 = local;
        local_26 = _e216;
        let _e218 = local_26;
        local_27 = u32(_e218);
        let _e221 = base;
        local_28 = u32((_e221 + 7u));
        let _e226 = local_27;
        let _e227 = local_28;
        local_44 = u32((_e226 + _e227));
        let _e231 = local_44;
        out[_e231] = u32(_e214);
        after_loop = 1.5f;
        let _e235 = after_loop;
        let _e239 = local;
        local_29 = _e239;
        let _e241 = local_29;
        local_30 = u32(_e241);
        let _e244 = base;
        local_31 = u32((_e244 + 8u));
        let _e249 = local_30;
        let _e250 = local_31;
        local_45 = u32((_e249 + _e250));
        let _e254 = local_45;
        out[_e254] = u32((_e235 * 2f));
        let _e256 = n;
        let _e259 = local;
        local_32 = _e259;
        let _e261 = local_32;
        local_33 = u32(_e261);
        let _e264 = base;
        local_34 = u32((_e264 + 9u));
        let _e269 = local_33;
        let _e270 = local_34;
        local_46 = u32((_e269 + _e270));
        let _e274 = local_46;
        out[_e274] = u32(f32(_e256));
    }
}
