@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<storage> input: array<u32>;

@compute @workgroup_size(64, 1, 1)
fn packed_negation(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var row: u32;
    var value: u32;
    var local: u32;
    var base: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var value_1: u32;
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
    var local_15: bool;
    var local_16: bool;
    var local_17: u32;
    var index: u32;
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
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;

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
            local_29 = _e15;
            let _e17 = local_29;
            let _e19 = input[_e17];
            local_30 = _e19;
            let _e21 = local_30;
            local_28 = _e21;
            let _e23 = local_28;
            value = _e23;
            let _e25 = row;
            base = (4u + (_e25 * 4u));
            let _e31 = value;
            let _e44 = base;
            local_1 = _e44;
            let _e46 = local_1;
            local_31 = _e46;
            let _e48 = local_31;
            output[_e48] = (((65536u - (_e31 & 65535u)) & 65535u) | (((65536u - ((_e31 >> 16u) & 65535u)) & 65535u) << 16u));
            let _e51 = value;
            let _e78 = base;
            local_2 = u32((_e78 + 1u));
            let _e83 = local_2;
            local_32 = _e83;
            let _e85 = local_32;
            output[_e85] = (((((256u - (_e51 & 255u)) & 255u) | (((256u - ((_e51 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e51 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e51 >> 24u) & 255u)) & 255u) << 24u));
            let _e87 = value;
            let _e89 = (_e87 & 65535u);
            let _e99 = ((_e87 >> 16u) & 65535u);
            let _e106 = base;
            local_3 = u32((_e106 + 2u));
            let _e111 = local_3;
            local_33 = _e111;
            let _e113 = local_33;
            output[_e113] = (select(((65536u - _e89) & 65535u), 32767u, (_e89 == 32768u)) | (select(((65536u - _e99) & 65535u), 32767u, (_e99 == 32768u)) << 16u));
            let _e115 = value;
            let _e117 = (_e115 & 255u);
            let _e127 = ((_e115 >> 8u) & 255u);
            let _e136 = ((_e115 >> 16u) & 255u);
            let _e145 = ((_e115 >> 24u) & 255u);
            let _e152 = base;
            local_4 = u32((_e152 + 3u));
            let _e157 = local_4;
            local_34 = _e157;
            let _e159 = local_34;
            output[_e159] = (((select(((256u - _e117) & 255u), 127u, (_e117 == 128u)) | (select(((256u - _e127) & 255u), 127u, (_e127 == 128u)) << 8u)) | (select(((256u - _e136) & 255u), 127u, (_e136 == 128u)) << 16u)) | (select(((256u - _e145) & 255u), 127u, (_e145 == 128u)) << 24u));
            continuing {
                let _e161 = row;
                row = (_e161 + 64u);
            }
        }
    }
    let base_1 = ((4u + (count * 4u)) + (lane * 17u));
    value_1 = 1u;
    let _e173 = value_1;
    value_1 = (_e173 + u32(1i));
    local_5 = ((_e173 * 16909060u) ^ 2164195711u);
    let _e182 = local_5;
    output[base_1] = (((65536u - (_e182 & 65535u)) & 65535u) | (((65536u - ((_e182 >> 16u) & 65535u)) & 65535u) << 16u));
    let _e197 = value_1;
    value_1 = (_e197 + u32(1i));
    local_7 = ((_e197 * 16909060u) ^ 2164195711u);
    let _e206 = local_7;
    local_6 = u32((base_1 + 1u));
    let _e237 = local_6;
    output[_e237] = (((((256u - (_e206 & 255u)) & 255u) | (((256u - ((_e206 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e206 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e206 >> 24u) & 255u)) & 255u) << 24u));
    let _e239 = value_1;
    value_1 = (_e239 + u32(1i));
    local_9 = ((_e239 * 16909060u) ^ 2164195711u);
    let _e248 = local_9;
    let _e250 = (_e248 & 65535u);
    let _e260 = ((_e248 >> 16u) & 65535u);
    local_8 = u32((base_1 + 2u));
    let _e271 = local_8;
    output[_e271] = (select(((65536u - _e250) & 65535u), 32767u, (_e250 == 32768u)) | (select(((65536u - _e260) & 65535u), 32767u, (_e260 == 32768u)) << 16u));
    let _e273 = value_1;
    value_1 = (_e273 + u32(1i));
    local_11 = ((_e273 * 16909060u) ^ 2164195711u);
    let _e282 = local_11;
    let _e284 = (_e282 & 255u);
    let _e294 = ((_e282 >> 8u) & 255u);
    let _e303 = ((_e282 >> 16u) & 255u);
    let _e312 = ((_e282 >> 24u) & 255u);
    local_10 = u32((base_1 + 3u));
    let _e323 = local_10;
    output[_e323] = (((select(((256u - _e284) & 255u), 127u, (_e284 == 128u)) | (select(((256u - _e294) & 255u), 127u, (_e294 == 128u)) << 8u)) | (select(((256u - _e303) & 255u), 127u, (_e303 == 128u)) << 16u)) | (select(((256u - _e312) & 255u), 127u, (_e312 == 128u)) << 24u));
    let _e325 = value_1;
    value_1 = (_e325 + u32(1i));
    let _e354 = (((((256u - (_e325 & 255u)) & 255u) | (((256u - ((_e325 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e325 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e325 >> 24u) & 255u)) & 255u) << 24u));
    local_12 = u32((base_1 + 4u));
    let _e385 = local_12;
    output[_e385] = (((((256u - (_e354 & 255u)) & 255u) | (((256u - ((_e354 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e354 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e354 >> 24u) & 255u)) & 255u) << 24u));
    if ((lane & 1u) == 0u) {
        let _e391 = value_1;
        value_1 = (_e391 + u32(1i));
        let _e396 = (_e391 & 255u);
        let _e406 = ((_e391 >> 8u) & 255u);
        let _e415 = ((_e391 >> 16u) & 255u);
        let _e424 = ((_e391 >> 24u) & 255u);
        local_13 = (((select(((256u - _e396) & 255u), 127u, (_e396 == 128u)) | (select(((256u - _e406) & 255u), 127u, (_e406 == 128u)) << 8u)) | (select(((256u - _e415) & 255u), 127u, (_e415 == 128u)) << 16u)) | (select(((256u - _e424) & 255u), 127u, (_e424 == 128u)) << 24u));
    } else {
        local_13 = 0u;
    }
    let _e434 = value_1;
    local_14 = u32((base_1 + 5u));
    let _e439 = local_14;
    output[_e439] = _e434;
    local_15 = false;
    if false {
        let _e443 = value_1;
        value_1 = (_e443 + u32(1i));
        local_15 = ((((65536u - (_e443 & 65535u)) & 65535u) | (((65536u - ((_e443 >> 16u) & 65535u)) & 65535u) << 16u)) != 0u);
    }
    local_16 = true;
    if true {
    } else {
        let _e463 = value_1;
        value_1 = (_e463 + u32(1i));
        local_16 = ((((((256u - (_e463 & 255u)) & 255u) | (((256u - ((_e463 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e463 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e463 >> 24u) & 255u)) & 255u) << 24u)) != 0u);
    }
    let _e495 = value_1;
    value_1 = (_e495 + u32(1i));
    let _e499 = value_1;
    local_17 = u32((base_1 + 6u));
    let _e504 = local_17;
    output[_e504] = _e499;
    index = 1u;
    let _e508 = index;
    index = (_e508 + u32(1i));
    let _e513 = input[_e508];
    let _e515 = (_e513 & 65535u);
    let _e525 = ((_e513 >> 16u) & 65535u);
    local_18 = u32((base_1 + 7u));
    let _e536 = local_18;
    output[_e536] = (select(((65536u - _e515) & 65535u), 32767u, (_e515 == 32768u)) | (select(((65536u - _e525) & 65535u), 32767u, (_e525 == 32768u)) << 16u));
    let _e538 = index;
    local_19 = u32((base_1 + 8u));
    let _e543 = local_19;
    output[_e543] = _e538;
    local_20 = u32((base_1 + 9u));
    let _e562 = local_20;
    output[_e562] = (((65536u - (2147516416u & 65535u)) & 65535u) | (((65536u - ((2147516416u >> 16u) & 65535u)) & 65535u) << 16u));
    let _e566 = (2147516416u & 65535u);
    let _e576 = ((2147516416u >> 16u) & 65535u);
    local_21 = u32((base_1 + 10u));
    let _e587 = local_21;
    output[_e587] = (select(((65536u - _e566) & 65535u), 32767u, (_e566 == 32768u)) | (select(((65536u - _e576) & 65535u), 32767u, (_e576 == 32768u)) << 16u));
    local_22 = u32((base_1 + 11u));
    let _e620 = local_22;
    output[_e620] = (((((256u - (2155905152u & 255u)) & 255u) | (((256u - ((2155905152u >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((2155905152u >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((2155905152u >> 24u) & 255u)) & 255u) << 24u));
    let _e624 = (2155905152u & 255u);
    let _e634 = ((2155905152u >> 8u) & 255u);
    let _e643 = ((2155905152u >> 16u) & 255u);
    let _e652 = ((2155905152u >> 24u) & 255u);
    local_23 = u32((base_1 + 12u));
    let _e663 = local_23;
    output[_e663] = (((select(((256u - _e624) & 255u), 127u, (_e624 == 128u)) | (select(((256u - _e634) & 255u), 127u, (_e634 == 128u)) << 8u)) | (select(((256u - _e643) & 255u), 127u, (_e643 == 128u)) << 16u)) | (select(((256u - _e652) & 255u), 127u, (_e652 == 128u)) << 24u));
    let _e677 = (((65536u - (2147516416u & 65535u)) & 65535u) | (((65536u - ((2147516416u >> 16u) & 65535u)) & 65535u) << 16u));
    local_24 = u32((base_1 + 13u));
    let _e694 = local_24;
    output[_e694] = (((65536u - (_e677 & 65535u)) & 65535u) | (((65536u - ((_e677 >> 16u) & 65535u)) & 65535u) << 16u));
    let _e722 = (((((256u - (2155905152u & 255u)) & 255u) | (((256u - ((2155905152u >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((2155905152u >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((2155905152u >> 24u) & 255u)) & 255u) << 24u));
    local_25 = u32((base_1 + 14u));
    let _e753 = local_25;
    output[_e753] = (((((256u - (_e722 & 255u)) & 255u) | (((256u - ((_e722 >> 8u) & 255u)) & 255u) << 8u)) | (((256u - ((_e722 >> 16u) & 255u)) & 255u) << 16u)) | (((256u - ((_e722 >> 24u) & 255u)) & 255u) << 24u));
    let _e757 = (2147516416u & 65535u);
    let _e767 = ((2147516416u >> 16u) & 65535u);
    let _e773 = (select(((65536u - _e757) & 65535u), 32767u, (_e757 == 32768u)) | (select(((65536u - _e767) & 65535u), 32767u, (_e767 == 32768u)) << 16u));
    let _e775 = (_e773 & 65535u);
    let _e785 = ((_e773 >> 16u) & 65535u);
    local_26 = u32((base_1 + 15u));
    let _e796 = local_26;
    output[_e796] = (select(((65536u - _e775) & 65535u), 32767u, (_e775 == 32768u)) | (select(((65536u - _e785) & 65535u), 32767u, (_e785 == 32768u)) << 16u));
    let _e800 = (2155905152u & 255u);
    let _e810 = ((2155905152u >> 8u) & 255u);
    let _e819 = ((2155905152u >> 16u) & 255u);
    let _e828 = ((2155905152u >> 24u) & 255u);
    let _e834 = (((select(((256u - _e800) & 255u), 127u, (_e800 == 128u)) | (select(((256u - _e810) & 255u), 127u, (_e810 == 128u)) << 8u)) | (select(((256u - _e819) & 255u), 127u, (_e819 == 128u)) << 16u)) | (select(((256u - _e828) & 255u), 127u, (_e828 == 128u)) << 24u));
    let _e836 = (_e834 & 255u);
    let _e846 = ((_e834 >> 8u) & 255u);
    let _e855 = ((_e834 >> 16u) & 255u);
    let _e864 = ((_e834 >> 24u) & 255u);
    local_27 = u32((base_1 + 16u));
    let _e875 = local_27;
    output[_e875] = (((select(((256u - _e836) & 255u), 127u, (_e836 == 128u)) | (select(((256u - _e846) & 255u), 127u, (_e846 == 128u)) << 8u)) | (select(((256u - _e855) & 255u), 127u, (_e855 == 128u)) << 16u)) | (select(((256u - _e864) & 255u), 127u, (_e864 == 128u)) << 24u));
}
