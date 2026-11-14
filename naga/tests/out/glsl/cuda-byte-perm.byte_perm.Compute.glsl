#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { uint _group_0_binding_1_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint row = 0u;
    uint at = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint value = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    bool local_9 = false;
    bool local_10 = false;
    uint local_11 = 0u;
    uint index = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint scale = 0u;
    uint bias = 0u;
    uint scale_1 = 0u;
    uint bias_1 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint lane = threadIdx.x;
    uint count = _group_0_binding_1_cs[uint(0)];
    {
        row = lane;
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e119 = row;
                row = (_e119 + 64u);
            }
            loop_init = false;
            uint _e8 = row;
            if ((_e8 < count)) {
            } else {
                break;
            }
            uint _e10 = row;
            at = (1u + (_e10 * 3u));
            uint _e16 = at;
            local_1 = _e16;
            uint _e18 = local_1;
            local_22 = _e18;
            uint _e20 = local_22;
            uint _e22 = _group_0_binding_1_cs[_e20];
            local_23 = _e22;
            uint _e24 = local_23;
            local_19 = _e24;
            uint _e26 = local_19;
            uint _e27 = at;
            local_2 = uint((_e27 + 1u));
            uint _e32 = local_2;
            local_24 = _e32;
            uint _e34 = local_24;
            uint _e36 = _group_0_binding_1_cs[_e34];
            local_25 = _e36;
            uint _e38 = local_25;
            local_20 = _e38;
            uint _e40 = local_20;
            uint _e41 = at;
            local_3 = uint((_e41 + 2u));
            uint _e46 = local_3;
            local_26 = _e46;
            uint _e48 = local_26;
            uint _e50 = _group_0_binding_1_cs[_e48];
            local_27 = _e50;
            uint _e52 = local_27;
            local_21 = _e52;
            uint _e54 = local_21;
            uint _e58 = ((_e54 >> 0u) & 7u);
            uint _e75 = ((_e54 >> 4u) & 7u);
            uint _e87 = ((_e54 >> 8u) & 7u);
            uint _e99 = ((_e54 >> 12u) & 7u);
            uint _e109 = row;
            local = uint((4u + _e109));
            uint _e114 = local;
            local_28 = _e114;
            uint _e116 = local_28;
            _group_0_binding_0_cs[_e116] = ((((0u | (((((_e58 < 4u) ? _e26 : _e40) >> ((_e58 & 3u) * 8u)) & 255u) << 0u)) | (((((_e75 < 4u) ? _e26 : _e40) >> ((_e75 & 3u) * 8u)) & 255u) << 8u)) | (((((_e87 < 4u) ? _e26 : _e40) >> ((_e87 & 3u) * 8u)) & 255u) << 16u)) | (((((_e99 < 4u) ? _e26 : _e40) >> ((_e99 & 3u) * 8u)) & 255u) << 24u));
        }
    }
    uint base = ((4u + count) + (lane * 10u));
    value = 1u;
    scale = 0u;
    bias = 0u;
    scale = 16909060u;
    bias = 2164195711u;
    uint _e137 = value;
    value = (_e137 + uint(1));
    uint _e141 = scale;
    uint _e143 = bias;
    local_4 = ((_e137 * _e141) ^ _e143);
    uint _e146 = local_4;
    scale_1 = 0u;
    bias_1 = 0u;
    scale_1 = 50661129u;
    bias_1 = 4261576960u;
    uint _e155 = value;
    value = (_e155 + uint(1));
    uint _e159 = scale_1;
    uint _e161 = bias_1;
    local_5 = ((_e155 * _e159) ^ _e161);
    uint _e164 = local_5;
    uint _e165 = value;
    value = (_e165 + uint(1));
    local_6 = ((_e165 * 258u) ^ 30006u);
    uint _e174 = local_6;
    uint _e178 = ((_e174 >> 0u) & 7u);
    uint _e195 = ((_e174 >> 4u) & 7u);
    uint _e207 = ((_e174 >> 8u) & 7u);
    uint _e219 = ((_e174 >> 12u) & 7u);
    _group_0_binding_0_cs[base] = ((((0u | (((((_e178 < 4u) ? _e146 : _e164) >> ((_e178 & 3u) * 8u)) & 255u) << 0u)) | (((((_e195 < 4u) ? _e146 : _e164) >> ((_e195 & 3u) * 8u)) & 255u) << 8u)) | (((((_e207 < 4u) ? _e146 : _e164) >> ((_e207 & 3u) * 8u)) & 255u) << 16u)) | (((((_e219 < 4u) ? _e146 : _e164) >> ((_e219 & 3u) * 8u)) & 255u) << 24u));
    if (((lane & 1u) == 0u)) {
        uint _e235 = value;
        value = (_e235 + uint(1));
        uint _e239 = value;
        value = (_e239 + uint(1));
        uint _e243 = value;
        value = (_e243 + uint(1));
        uint _e250 = ((_e243 >> 0u) & 7u);
        uint _e267 = ((_e243 >> 4u) & 7u);
        uint _e279 = ((_e243 >> 8u) & 7u);
        uint _e291 = ((_e243 >> 12u) & 7u);
        local_7 = ((((0u | (((((_e250 < 4u) ? _e235 : _e239) >> ((_e250 & 3u) * 8u)) & 255u) << 0u)) | (((((_e267 < 4u) ? _e235 : _e239) >> ((_e267 & 3u) * 8u)) & 255u) << 8u)) | (((((_e279 < 4u) ? _e235 : _e239) >> ((_e279 & 3u) * 8u)) & 255u) << 16u)) | (((((_e291 < 4u) ? _e235 : _e239) >> ((_e291 & 3u) * 8u)) & 255u) << 24u));
    } else {
        local_7 = 0u;
    }
    uint _e304 = value;
    local_8 = uint((base + 1u));
    uint _e309 = local_8;
    _group_0_binding_0_cs[_e309] = _e304;
    local_9 = false;
    if (false) {
        uint _e313 = value;
        value = (_e313 + uint(1));
        uint _e317 = value;
        value = (_e317 + uint(1));
        uint _e321 = value;
        value = (_e321 + uint(1));
        uint _e328 = ((_e321 >> 0u) & 7u);
        uint _e345 = ((_e321 >> 4u) & 7u);
        uint _e357 = ((_e321 >> 8u) & 7u);
        uint _e369 = ((_e321 >> 12u) & 7u);
        local_9 = (((((0u | (((((_e328 < 4u) ? _e313 : _e317) >> ((_e328 & 3u) * 8u)) & 255u) << 0u)) | (((((_e345 < 4u) ? _e313 : _e317) >> ((_e345 & 3u) * 8u)) & 255u) << 8u)) | (((((_e357 < 4u) ? _e313 : _e317) >> ((_e357 & 3u) * 8u)) & 255u) << 16u)) | (((((_e369 < 4u) ? _e313 : _e317) >> ((_e369 & 3u) * 8u)) & 255u) << 24u)) != 0u);
    }
    local_10 = true;
    if (true) {
    } else {
        uint _e383 = value;
        value = (_e383 + uint(1));
        uint _e387 = value;
        value = (_e387 + uint(1));
        uint _e391 = value;
        value = (_e391 + uint(1));
        uint _e398 = ((_e391 >> 0u) & 7u);
        uint _e415 = ((_e391 >> 4u) & 7u);
        uint _e427 = ((_e391 >> 8u) & 7u);
        uint _e439 = ((_e391 >> 12u) & 7u);
        local_10 = (((((0u | (((((_e398 < 4u) ? _e383 : _e387) >> ((_e398 & 3u) * 8u)) & 255u) << 0u)) | (((((_e415 < 4u) ? _e383 : _e387) >> ((_e415 & 3u) * 8u)) & 255u) << 8u)) | (((((_e427 < 4u) ? _e383 : _e387) >> ((_e427 & 3u) * 8u)) & 255u) << 16u)) | (((((_e439 < 4u) ? _e383 : _e387) >> ((_e439 & 3u) * 8u)) & 255u) << 24u)) != 0u);
    }
    uint _e451 = value;
    value = (_e451 + uint(1));
    uint _e455 = value;
    value = (_e455 + uint(1));
    uint _e459 = value;
    value = (_e459 + uint(1));
    uint _e463 = value;
    local_11 = uint((base + 2u));
    uint _e468 = local_11;
    _group_0_binding_0_cs[_e468] = _e463;
    index = 1u;
    uint _e472 = index;
    index = (_e472 + uint(1));
    uint _e477 = _group_0_binding_1_cs[_e472];
    uint _e478 = index;
    index = (_e478 + uint(1));
    uint _e483 = _group_0_binding_1_cs[_e478];
    uint _e484 = index;
    index = (_e484 + uint(1));
    uint _e489 = _group_0_binding_1_cs[_e484];
    uint _e493 = ((_e489 >> 0u) & 7u);
    uint _e510 = ((_e489 >> 4u) & 7u);
    uint _e522 = ((_e489 >> 8u) & 7u);
    uint _e534 = ((_e489 >> 12u) & 7u);
    local_12 = uint((base + 3u));
    uint _e548 = local_12;
    _group_0_binding_0_cs[_e548] = ((((0u | (((((_e493 < 4u) ? _e477 : _e483) >> ((_e493 & 3u) * 8u)) & 255u) << 0u)) | (((((_e510 < 4u) ? _e477 : _e483) >> ((_e510 & 3u) * 8u)) & 255u) << 8u)) | (((((_e522 < 4u) ? _e477 : _e483) >> ((_e522 & 3u) * 8u)) & 255u) << 16u)) | (((((_e534 < 4u) ? _e477 : _e483) >> ((_e534 & 3u) * 8u)) & 255u) << 24u));
    uint _e550 = index;
    local_13 = uint((base + 4u));
    uint _e555 = local_13;
    _group_0_binding_0_cs[_e555] = _e550;
    uint _e561 = ((65535u >> 0u) & 7u);
    uint _e580 = ((65535u >> 4u) & 7u);
    uint _e592 = ((65535u >> 8u) & 7u);
    uint _e604 = ((65535u >> 12u) & 7u);
    local_14 = uint((base + 5u));
    uint _e618 = local_14;
    _group_0_binding_0_cs[_e618] = ((((0u | (((((_e561 < 4u) ? 2164195711u : 4261576960u) >> ((_e561 & 3u) * 8u)) & 255u) << 0u)) | (((((_e580 < 4u) ? 2164195711u : 4261576960u) >> ((_e580 & 3u) * 8u)) & 255u) << 8u)) | (((((_e592 < 4u) ? 2164195711u : 4261576960u) >> ((_e592 & 3u) * 8u)) & 255u) << 16u)) | (((((_e604 < 4u) ? 2164195711u : 4261576960u) >> ((_e604 & 3u) * 8u)) & 255u) << 24u));
    uint _e624 = ((65535u >> 0u) & 7u);
    uint _e643 = ((65535u >> 4u) & 7u);
    uint _e655 = ((65535u >> 8u) & 7u);
    uint _e667 = ((65535u >> 12u) & 7u);
    local_15 = uint((base + 6u));
    uint _e681 = local_15;
    _group_0_binding_0_cs[_e681] = ((((0u | (((((_e624 < 4u) ? 4294967295u : 0u) >> ((_e624 & 3u) * 8u)) & 255u) << 0u)) | (((((_e643 < 4u) ? 4294967295u : 0u) >> ((_e643 & 3u) * 8u)) & 255u) << 8u)) | (((((_e655 < 4u) ? 4294967295u : 0u) >> ((_e655 & 3u) * 8u)) & 255u) << 16u)) | (((((_e667 < 4u) ? 4294967295u : 0u) >> ((_e667 & 3u) * 8u)) & 255u) << 24u));
    uint _e687 = ((4294932052u >> 0u) & 7u);
    uint _e706 = ((4294932052u >> 4u) & 7u);
    uint _e718 = ((4294932052u >> 8u) & 7u);
    uint _e730 = ((4294932052u >> 12u) & 7u);
    local_16 = uint((base + 7u));
    uint _e744 = local_16;
    _group_0_binding_0_cs[_e744] = ((((0u | (((((_e687 < 4u) ? 2164195711u : 4261576960u) >> ((_e687 & 3u) * 8u)) & 255u) << 0u)) | (((((_e706 < 4u) ? 2164195711u : 4261576960u) >> ((_e706 & 3u) * 8u)) & 255u) << 8u)) | (((((_e718 < 4u) ? 2164195711u : 4261576960u) >> ((_e718 & 3u) * 8u)) & 255u) << 16u)) | (((((_e730 < 4u) ? 2164195711u : 4261576960u) >> ((_e730 & 3u) * 8u)) & 255u) << 24u));
    uint _e748 = uint(-(1));
    uint _e752 = ((_e748 >> 0u) & 7u);
    uint _e771 = ((_e748 >> 4u) & 7u);
    uint _e783 = ((_e748 >> 8u) & 7u);
    uint _e795 = ((_e748 >> 12u) & 7u);
    local_17 = uint((base + 8u));
    uint _e809 = local_17;
    _group_0_binding_0_cs[_e809] = ((((0u | (((((_e752 < 4u) ? 2164195711u : 4261576960u) >> ((_e752 & 3u) * 8u)) & 255u) << 0u)) | (((((_e771 < 4u) ? 2164195711u : 4261576960u) >> ((_e771 & 3u) * 8u)) & 255u) << 8u)) | (((((_e783 < 4u) ? 2164195711u : 4261576960u) >> ((_e783 & 3u) * 8u)) & 255u) << 16u)) | (((((_e795 < 4u) ? 2164195711u : 4261576960u) >> ((_e795 & 3u) * 8u)) & 255u) << 24u));
    uint _e813 = uint(-(1));
    uint _e818 = ((12816u >> 0u) & 7u);
    uint _e836 = ((12816u >> 4u) & 7u);
    uint _e848 = ((12816u >> 8u) & 7u);
    uint _e860 = ((12816u >> 12u) & 7u);
    local_18 = uint((base + 9u));
    uint _e874 = local_18;
    _group_0_binding_0_cs[_e874] = ((((0u | (((((_e818 < 4u) ? _e813 : 0u) >> ((_e818 & 3u) * 8u)) & 255u) << 0u)) | (((((_e836 < 4u) ? _e813 : 0u) >> ((_e836 & 3u) * 8u)) & 255u) << 8u)) | (((((_e848 < 4u) ? _e813 : 0u) >> ((_e848 & 3u) * 8u)) & 255u) << 16u)) | (((((_e860 < 4u) ? _e813 : 0u) >> ((_e860 & 3u) * 8u)) & 255u) << 24u));
}

