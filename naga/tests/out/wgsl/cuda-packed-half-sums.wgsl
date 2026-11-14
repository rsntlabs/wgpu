@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<storage> input: array<u32>;

@compute @workgroup_size(64, 1, 1)
fn packed_half_sums(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var row: u32;
    var a: u32;
    var local: u32;
    var b: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var value: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: bool;
    var local_14: bool;
    var local_15: u32;
    var index: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var scale: u32;
    var bias: u32;
    var scale_1: u32;
    var bias_1: u32;
    var scale_2: u32;
    var bias_2: u32;
    var scale_3: u32;
    var bias_3: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;

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
            local = u32((1u + (_e10 * 2u)));
            let _e17 = local;
            local_25 = _e17;
            let _e19 = local_25;
            let _e21 = input[_e19];
            local_26 = _e21;
            let _e23 = local_26;
            local_23 = _e23;
            let _e25 = local_23;
            a = _e25;
            let _e27 = row;
            local_1 = u32((2u + (_e27 * 2u)));
            let _e34 = local_1;
            local_27 = _e34;
            let _e36 = local_27;
            let _e38 = input[_e36];
            local_28 = _e38;
            let _e40 = local_28;
            local_24 = _e40;
            let _e42 = local_24;
            b = _e42;
            let _e44 = a;
            let _e45 = b;
            let _e63 = row;
            local_2 = u32((4u + (_e63 * 2u)));
            let _e70 = local_2;
            local_29 = _e70;
            let _e72 = local_29;
            output[_e72] = (((((_e44 & 65535u) + (_e45 & 65535u)) >> 1u) & 65535u) | ((((((_e44 >> 16u) & 65535u) + ((_e45 >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
            let _e75 = a;
            let _e76 = b;
            let _e114 = row;
            local_3 = u32((5u + (_e114 * 2u)));
            let _e121 = local_3;
            local_30 = _e121;
            let _e123 = local_30;
            output[_e123] = (((((((_e75 & 255u) + (_e76 & 255u)) >> 1u) & 255u) | ((((((_e75 >> 8u) & 255u) + ((_e76 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e75 >> 16u) & 255u) + ((_e76 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e75 >> 24u) & 255u) + ((_e76 >> 24u) & 255u)) >> 1u) & 255u) << 24u));
            continuing {
                let _e125 = row;
                row = (_e125 + 64u);
            }
        }
    }
    let base = ((4u + (count * 2u)) + (lane * 13u));
    value = 1u;
    scale = u32();
    bias = u32();
    scale = 16909060u;
    bias = 2164195711u;
    let _e145 = value;
    value = (_e145 + u32(1i));
    let _e149 = scale;
    let _e151 = bias;
    local_4 = ((_e145 * _e149) ^ _e151);
    let _e154 = local_4;
    scale_1 = u32();
    bias_1 = u32();
    scale_1 = 50661129u;
    bias_1 = 4261576960u;
    let _e163 = value;
    value = (_e163 + u32(1i));
    let _e167 = scale_1;
    let _e169 = bias_1;
    local_5 = ((_e163 * _e167) ^ _e169);
    let _e172 = local_5;
    output[base] = (((((_e154 & 65535u) + (_e172 & 65535u)) >> 1u) & 65535u) | ((((((_e154 >> 16u) & 65535u) + ((_e172 >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
    scale_2 = u32();
    bias_2 = u32();
    scale_2 = 16909060u;
    bias_2 = 2164195711u;
    let _e200 = value;
    value = (_e200 + u32(1i));
    let _e204 = scale_2;
    let _e206 = bias_2;
    local_7 = ((_e200 * _e204) ^ _e206);
    let _e209 = local_7;
    scale_3 = u32();
    bias_3 = u32();
    scale_3 = 50661129u;
    bias_3 = 4261576960u;
    let _e218 = value;
    value = (_e218 + u32(1i));
    let _e222 = scale_3;
    let _e224 = bias_3;
    local_8 = ((_e218 * _e222) ^ _e224);
    let _e227 = local_8;
    local_6 = u32((base + 1u));
    let _e269 = local_6;
    output[_e269] = (((((((_e209 & 255u) + (_e227 & 255u)) >> 1u) & 255u) | ((((((_e209 >> 8u) & 255u) + ((_e227 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e209 >> 16u) & 255u) + ((_e227 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e209 >> 24u) & 255u) + ((_e227 >> 24u) & 255u)) >> 1u) & 255u) << 24u));
    let _e271 = value;
    value = (_e271 + u32(1i));
    let _e292 = (((((_e271 & 65535u) + (1u & 65535u)) >> 1u) & 65535u) | ((((((_e271 >> 16u) & 65535u) + ((1u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
    local_9 = u32((base + 2u));
    let _e315 = local_9;
    output[_e315] = (((((_e292 & 65535u) + (1u & 65535u)) >> 1u) & 65535u) | ((((((_e292 >> 16u) & 65535u) + ((1u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
    let _e317 = value;
    local_10 = u32((base + 3u));
    let _e322 = local_10;
    output[_e322] = _e317;
    if ((lane & 1u) == 0u) {
        let _e328 = value;
        value = (_e328 + u32(1i));
        let _e332 = value;
        value = (_e332 + u32(1i));
        local_11 = (((((((_e328 & 255u) + (_e332 & 255u)) >> 1u) & 255u) | ((((((_e328 >> 8u) & 255u) + ((_e332 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e328 >> 16u) & 255u) + ((_e332 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e328 >> 24u) & 255u) + ((_e332 >> 24u) & 255u)) >> 1u) & 255u) << 24u));
    } else {
        local_11 = 0u;
    }
    let _e376 = value;
    local_12 = u32((base + 4u));
    let _e381 = local_12;
    output[_e381] = _e376;
    local_13 = false;
    if false {
        let _e385 = value;
        value = (_e385 + u32(1i));
        let _e389 = value;
        value = (_e389 + u32(1i));
        local_13 = ((((((_e385 & 65535u) + (_e389 & 65535u)) >> 1u) & 65535u) | ((((((_e385 >> 16u) & 65535u) + ((_e389 >> 16u) & 65535u)) >> 1u) & 65535u) << 16u)) != 0u);
    }
    local_14 = true;
    if true {
    } else {
        let _e414 = value;
        value = (_e414 + u32(1i));
        let _e418 = value;
        value = (_e418 + u32(1i));
        local_14 = ((((((((_e414 & 255u) + (_e418 & 255u)) >> 1u) & 255u) | ((((((_e414 >> 8u) & 255u) + ((_e418 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e414 >> 16u) & 255u) + ((_e418 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e414 >> 24u) & 255u) + ((_e418 >> 24u) & 255u)) >> 1u) & 255u) << 24u)) != 0u);
    }
    let _e461 = value;
    value = (_e461 + u32(1i));
    let _e465 = value;
    value = (_e465 + u32(1i));
    let _e469 = value;
    local_15 = u32((base + 5u));
    let _e474 = local_15;
    output[_e474] = _e469;
    index = 1u;
    let _e478 = index;
    index = (_e478 + u32(1i));
    let _e483 = input[_e478];
    let _e484 = index;
    index = (_e484 + u32(1i));
    let _e489 = input[_e484];
    local_16 = u32((base + 6u));
    let _e531 = local_16;
    output[_e531] = (((((((_e483 & 255u) + (_e489 & 255u)) >> 1u) & 255u) | ((((((_e483 >> 8u) & 255u) + ((_e489 >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((_e483 >> 16u) & 255u) + ((_e489 >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((_e483 >> 24u) & 255u) + ((_e489 >> 24u) & 255u)) >> 1u) & 255u) << 24u));
    let _e533 = index;
    local_17 = u32((base + 7u));
    let _e538 = local_17;
    output[_e538] = _e533;
    local_18 = u32((base + 8u));
    let _e563 = local_18;
    output[_e563] = (((((4294967295u & 65535u) + (4294967295u & 65535u)) >> 1u) & 65535u) | ((((((4294967295u >> 16u) & 65535u) + ((4294967295u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
    local_19 = u32((base + 9u));
    let _e608 = local_19;
    output[_e608] = (((((((4294967295u & 255u) + (0u & 255u)) >> 1u) & 255u) | ((((((4294967295u >> 8u) & 255u) + ((0u >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((4294967295u >> 16u) & 255u) + ((0u >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((4294967295u >> 24u) & 255u) + ((0u >> 24u) & 255u)) >> 1u) & 255u) << 24u));
    local_20 = u32((base + 10u));
    let _e633 = local_20;
    output[_e633] = (((((4294967295u & 65535u) + (0u & 65535u)) >> 1u) & 65535u) | ((((((4294967295u >> 16u) & 65535u) + ((0u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
    local_21 = u32((base + 11u));
    let _e678 = local_21;
    output[_e678] = (((((((0u & 255u) + (16843009u & 255u)) >> 1u) & 255u) | ((((((0u >> 8u) & 255u) + ((16843009u >> 8u) & 255u)) >> 1u) & 255u) << 8u)) | ((((((0u >> 16u) & 255u) + ((16843009u >> 16u) & 255u)) >> 1u) & 255u) << 16u)) | ((((((0u >> 24u) & 255u) + ((16843009u >> 24u) & 255u)) >> 1u) & 255u) << 24u));
    local_22 = u32((base + 12u));
    let _e703 = local_22;
    output[_e703] = (((((4294901761u & 65535u) + (131071u & 65535u)) >> 1u) & 65535u) | ((((((4294901761u >> 16u) & 65535u) + ((131071u >> 16u) & 65535u)) >> 1u) & 65535u) << 16u));
}
