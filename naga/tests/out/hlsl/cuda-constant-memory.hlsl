struct Settings_cuda_record_0_ {
    uint scale;
    uint bias;
};

struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer addend : register(t0, space1);
ByteAddressBuffer weights : register(t1, space1);
ByteAddressBuffer settings : register(t2, space1);
RWByteAddressBuffer output_2 : register(u0);
ByteAddressBuffer input_3 : register(t1);
cbuffer count : register(b2) { type_3 count; }
RWByteAddressBuffer output_3 : register(u0);
ByteAddressBuffer input_4 : register(t1);
cbuffer count_1 : register(b2) { type_3 count_1; }

uint ZeroValueuint() {
    return (uint)0;
}

uint weighted_unsigned(uint input_2, uint index_1)
{
    uint index_2 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;

    uint _e4 = asuint(settings.Load(0));
    index_2 = ZeroValueuint();
    local_31 = ZeroValueuint();
    local_32 = ZeroValueuint();
    index_2 = index_1;
    uint _e13 = index_2;
    local_31 = _e13;
    uint _e15 = local_31;
    uint _e18 = asuint(weights.Load(_e15*4));
    local_32 = _e18;
    uint _e20 = local_32;
    uint _e23 = asuint(addend.Load(0));
    return (((input_2 * _e4) + _e20) + _e23);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(4, 1, 1)]
void constant_memory(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint output[2] = (uint[2])0;
    uint input[2] = (uint[2])0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint value[2] = (uint[2])0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;

    output = ZeroValuearray2_uint_();
    output[0] = 2u;
    output[1] = 0u;
    input = ZeroValuearray2_uint_();
    input[0] = 3u;
    input[1] = 0u;
    uint count_2 = count.value;
    uint index_3 = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index_3 < count_2)) {
        uint _e24[2] = input;
        local_2 = _e24;
        local_3 = index_3;
        uint _e27[2] = local_2;
        local_7 = _e27;
        uint _e29 = local_3;
        uint _e31 = local_7[1];
        local_7[1] = (_e31 + _e29);
        uint _e35 = local_7[0];
        local_8 = uint(_e35);
        uint _e39 = local_7[1];
        local_9 = uint(_e39);
        uint _e42 = local_9;
        uint _e45 = asuint(input_3.Load(_e42*4));
        local_10 = _e45;
        uint _e47 = local_10;
        local_6 = _e47;
        uint _e49 = local_6;
        const uint _e52 = weighted_unsigned(_e49, naga_mod(index_3, 4u));
        uint _e55 = asuint(settings.Load(4));
        value = ZeroValuearray2_uint_();
        value[0] = 4u;
        value[1] = 0u;
        local_4 = 31u;
        uint _e65 = local_4;
        local_5 = 41u;
        uint _e69 = local_5;
        uint _e72[2] = output;
        local = _e72;
        local_1 = index_3;
        uint _e75[2] = local;
        local_11 = _e75;
        uint _e77 = local_1;
        uint _e79 = local_11[1];
        local_11[1] = (_e79 + _e77);
        uint _e83 = local_11[0];
        local_12 = uint(_e83);
        uint _e87 = local_11[1];
        local_13 = uint(_e87);
        uint _e90 = local_13;
        output_2.Store(_e90*4, asuint((((_e52 + _e55) + _e65) + _e69)));
    }
}

Settings_cuda_record_0_ ConstructSettings_cuda_record_0_(uint arg0, uint arg1) {
    Settings_cuda_record_0_ ret = (Settings_cuda_record_0_)0;
    ret.scale = arg0;
    ret.bias = arg1;
    return ret;
}

[numthreads(4, 1, 1)]
void constant_references(uint3 blockIdx_1 : SV_GroupID, uint3 threadIdx_1 : SV_GroupThreadID)
{
    uint output_1[2] = (uint[2])0;
    uint input_1[2] = (uint[2])0;
    Settings_cuda_record_0_ current = (Settings_cuda_record_0_)0;
    uint view[2] = (uint[2])0;
    uint local_14[2] = (uint[2])0;
    uint local_15[2] = (uint[2])0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint values[2] = (uint[2])0;
    uint index = (uint)0;
    uint local_19[2] = (uint[2])0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint value_1[2] = (uint[2])0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25[2] = (uint[2])0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28[2] = (uint[2])0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;

    output_1 = ZeroValuearray2_uint_();
    output_1[0] = 2u;
    output_1[1] = 0u;
    input_1 = ZeroValuearray2_uint_();
    input_1[0] = 3u;
    input_1[1] = 0u;
    uint count_3 = count_1.value;
    uint index_4 = ((blockIdx_1.x * 4u) + threadIdx_1.x);
    if ((index_4 >= count_3)) {
        return;
    }
    Settings_cuda_record_0_ _e24 = ConstructSettings_cuda_record_0_(asuint(settings.Load(0)), asuint(settings.Load(4)));
    current = _e24;
    view = ZeroValuearray2_uint_();
    view[0] = 4u;
    view[1] = 0u;
    uint _e33[2] = input_1;
    local_15 = _e33;
    index = ZeroValueuint();
    local_20 = ZeroValueuint();
    local_21 = ZeroValueuint();
    values = ZeroValuearray2_uint_();
    values[0] = 4u;
    values[1] = 0u;
    index = naga_mod((index_4 + 1u), 4u);
    uint _e53[2] = values;
    local_19 = _e53;
    uint _e55 = index;
    local_20 = _e55;
    uint _e57[2] = local_19;
    local_22 = _e57;
    uint _e59 = local_20;
    uint _e61 = local_22[1];
    local_22[1] = (_e61 + _e59);
    uint _e65 = local_22[0];
    local_23 = uint(_e65);
    uint _e69 = local_22[1];
    local_24 = uint(_e69);
    uint _e72 = local_24;
    uint _e75 = asuint(weights.Load(_e72*4));
    local_21 = _e75;
    uint _e77 = local_21;
    uint _e78[2] = local_15;
    local_25 = _e78;
    uint _e81 = local_25[1];
    local_25[1] = (_e81 + index_4);
    uint _e85 = local_25[0];
    local_26 = uint(_e85);
    uint _e89 = local_25[1];
    local_27 = uint(_e89);
    uint _e92 = local_27;
    uint _e95 = asuint(input_4.Load(_e92*4));
    uint _e98 = asuint(addend.Load(0));
    uint _e101 = current.scale;
    uint _e104 = current.bias;
    uint _e107[2] = view;
    local_16 = _e107;
    uint _e109[2] = local_16;
    value_1 = _e109;
    local_17 = 37u;
    uint _e113 = local_17;
    local_18 = 43u;
    uint _e117 = local_18;
    uint _e120[2] = output_1;
    local_14 = _e120;
    uint _e122[2] = local_14;
    local_28 = _e122;
    uint _e125 = local_28[1];
    local_28[1] = (_e125 + index_4);
    uint _e129 = local_28[0];
    local_29 = uint(_e129);
    uint _e133 = local_28[1];
    local_30 = uint(_e133);
    uint _e136 = local_30;
    output_3.Store(_e136*4, asuint(((((((_e95 + _e77) + _e98) + _e101) + _e104) + _e113) + _e117)));
}
