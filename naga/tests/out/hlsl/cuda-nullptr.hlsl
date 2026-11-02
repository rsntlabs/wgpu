RWByteAddressBuffer output_1 : register(u0);
groupshared uint values[4];

void synchronize()
{
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    return;
}

uint selected()
{
    return 7u;
}

uint selected_1(int value)
{
    return 13u;
}

void copied_decltype_u0028_nullptr_u0029_()
{
    return;
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(4, 1, 1)]
void source_null(uint3 threadIdx : SV_GroupThreadID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        values = (uint[4])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint output[2] = (uint[2])0;
    uint counter = (uint)0;
    uint pointer[2] = (uint[2])0;
    uint local[2] = (uint[2])0;
    uint local_1[2] = (uint[2])0;
    uint local_2 = (uint)0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint local_7[2] = (uint[2])0;
    bool local_8 = (bool)0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13[2] = (uint[2])0;
    uint local_14 = (uint)0;
    uint local_15[2] = (uint[2])0;
    uint local_16 = (uint)0;
    uint local_17[2] = (uint[2])0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23[2] = (uint[2])0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26[2] = (uint[2])0;
    uint local_27[2] = (uint[2])0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30[2] = (uint[2])0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33[2] = (uint[2])0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36[2] = (uint[2])0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39[2] = (uint[2])0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;

    output = ZeroValuearray2_uint_();
    output[0] = 2u;
    output[1] = 0u;
    uint lane = threadIdx.x;
    counter = 0u;
    copied_decltype_u0028_nullptr_u0029_();
    uint _e10 = counter;
    counter = (_e10 + uint(int(1)));
    pointer = ZeroValuearray2_uint_();
    pointer[0] = 1u;
    values[min(uint(lane), 3u)] = (lane + 3u);
    synchronize();
    uint base = (lane * 8u);
    uint _e27 = values[min(uint((3u - lane)), 3u)];
    uint _e29[2] = output;
    local = _e29;
    uint _e31[2] = local;
    local_17 = _e31;
    uint _e34 = local_17[1];
    local_17[1] = (_e34 + base);
    uint _e38 = local_17[0];
    local_18 = uint(_e38);
    uint _e42 = local_17[1];
    local_19 = uint(_e42);
    uint _e45 = local_19;
    output_1.Store(_e45*4, asuint(_e27));
    const uint _e48 = selected();
    uint _e49[2] = output;
    local_1 = _e49;
    local_2 = uint((base + 1u));
    uint _e55[2] = local_1;
    local_20 = _e55;
    uint _e57 = local_2;
    uint _e59 = local_20[1];
    local_20[1] = (_e59 + _e57);
    uint _e63 = local_20[0];
    local_21 = uint(_e63);
    uint _e67 = local_20[1];
    local_22 = uint(_e67);
    uint _e70 = local_22;
    output_1.Store(_e70*4, asuint(_e48));
    const uint _e73 = selected_1(int(0));
    uint _e74[2] = output;
    local_3 = _e74;
    local_4 = uint((base + 2u));
    uint _e80[2] = local_3;
    local_23 = _e80;
    uint _e82 = local_4;
    uint _e84 = local_23[1];
    local_23[1] = (_e84 + _e82);
    uint _e88 = local_23[0];
    local_24 = uint(_e88);
    uint _e92 = local_23[1];
    local_25 = uint(_e92);
    uint _e95 = local_25;
    output_1.Store(_e95*4, asuint(_e73));
    uint _e98[2] = pointer;
    local_7 = _e98;
    uint _e100[2] = local_7;
    local_26 = _e100;
    uint _e103 = local_26[0];
    local_8 = (_e103 == 1u);
    bool _e107 = local_8;
    uint _e109[2] = output;
    local_5 = _e109;
    local_6 = uint((base + 3u));
    uint _e115[2] = local_5;
    local_27 = _e115;
    uint _e117 = local_6;
    uint _e119 = local_27[1];
    local_27[1] = (_e119 + _e117);
    uint _e123 = local_27[0];
    local_28 = uint(_e123);
    uint _e127 = local_27[1];
    local_29 = uint(_e127);
    uint _e130 = local_29;
    output_1.Store(_e130*4, asuint(uint(_e107)));
    uint _e132 = counter;
    uint _e133[2] = output;
    local_9 = _e133;
    local_10 = uint((base + 4u));
    uint _e139[2] = local_9;
    local_30 = _e139;
    uint _e141 = local_10;
    uint _e143 = local_30[1];
    local_30[1] = (_e143 + _e141);
    uint _e147 = local_30[0];
    local_31 = uint(_e147);
    uint _e151 = local_30[1];
    local_32 = uint(_e151);
    uint _e154 = local_32;
    output_1.Store(_e154*4, asuint(_e132));
    copied_decltype_u0028_nullptr_u0029_();
    const uint _e156 = selected();
    uint _e157[2] = output;
    local_11 = _e157;
    local_12 = uint((base + 5u));
    uint _e163[2] = local_11;
    local_33 = _e163;
    uint _e165 = local_12;
    uint _e167 = local_33[1];
    local_33[1] = (_e167 + _e165);
    uint _e171 = local_33[0];
    local_34 = uint(_e171);
    uint _e175 = local_33[1];
    local_35 = uint(_e175);
    uint _e178 = local_35;
    output_1.Store(_e178*4, asuint(_e156));
    const uint _e180 = selected();
    uint _e181[2] = output;
    local_13 = _e181;
    local_14 = uint((base + 6u));
    uint _e187[2] = local_13;
    local_36 = _e187;
    uint _e189 = local_14;
    uint _e191 = local_36[1];
    local_36[1] = (_e191 + _e189);
    uint _e195 = local_36[0];
    local_37 = uint(_e195);
    uint _e199 = local_36[1];
    local_38 = uint(_e199);
    uint _e202 = local_38;
    output_1.Store(_e202*4, asuint(_e180));
    uint _e206[2] = output;
    local_15 = _e206;
    local_16 = uint((base + 7u));
    uint _e212[2] = local_15;
    local_39 = _e212;
    uint _e214 = local_16;
    uint _e216 = local_39[1];
    local_39[1] = (_e216 + _e214);
    uint _e220 = local_39[0];
    local_40 = uint(_e220);
    uint _e224 = local_39[1];
    local_41 = uint(_e224);
    uint _e227 = local_41;
    output_1.Store(_e227*4, asuint(uint(false)));
}
