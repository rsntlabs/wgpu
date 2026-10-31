ByteAddressBuffer a_1 : register(t0);
ByteAddressBuffer b_1 : register(t1);
RWByteAddressBuffer out_1 : register(u2);

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void add(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint a[2] = (uint[2])0;
    uint b[2] = (uint[2])0;
    uint out_[2] = (uint[2])0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    float local_6 = (float)0;
    float local_7 = (float)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    float local_11 = (float)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    float local_15 = (float)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;

    a = ZeroValuearray2_uint_();
    a[0] = 0u;
    a[1] = 0u;
    b = ZeroValuearray2_uint_();
    b[0] = 1u;
    b[1] = 0u;
    out_ = ZeroValuearray2_uint_();
    out_[0] = 2u;
    out_[1] = 0u;
    uint i = ((blockIdx.x * 1u) + threadIdx.x);
    uint _e26[2] = a;
    local_2 = _e26;
    local_3 = uint(i);
    uint _e31[2] = b;
    local_4 = _e31;
    local_5 = uint(i);
    uint _e35[2] = local_4;
    local_8 = _e35;
    uint _e37 = local_5;
    uint _e39 = local_8[1];
    local_8[1] = (_e39 + _e37);
    uint _e43 = local_8[0];
    local_9 = uint(_e43);
    uint _e47 = local_8[1];
    local_10 = uint(_e47);
    uint _e50 = local_10;
    float _e53 = asfloat(b_1.Load(_e50*4));
    local_11 = _e53;
    float _e55 = local_11;
    local_6 = _e55;
    float _e57 = local_6;
    uint _e60[2] = local_2;
    local_12 = _e60;
    uint _e62 = local_3;
    uint _e64 = local_12[1];
    local_12[1] = (_e64 + _e62);
    uint _e68 = local_12[0];
    local_13 = uint(_e68);
    uint _e72 = local_12[1];
    local_14 = uint(_e72);
    uint _e75 = local_14;
    float _e78 = asfloat(a_1.Load(_e75*4));
    local_15 = _e78;
    float _e80 = local_15;
    local_7 = _e80;
    float _e82 = local_7;
    uint _e85[2] = out_;
    local = _e85;
    local_1 = uint(i);
    uint _e89[2] = local;
    local_16 = _e89;
    uint _e91 = local_1;
    uint _e93 = local_16[1];
    local_16[1] = (_e93 + _e91);
    uint _e97 = local_16[0];
    local_17 = uint(_e97);
    uint _e101 = local_16[1];
    local_18 = uint(_e101);
    uint _e104 = local_18;
    out_1.Store(_e104*4, asuint((_e82 + (_e57 * 2.0))));
}
