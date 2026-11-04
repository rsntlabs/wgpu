struct NagaConstants {
    int first_vertex;
    int first_instance;
    uint other;
};
ConstantBuffer<NagaConstants> _NagaConstants: register(b0, space1);

struct UniformCompatible {
    uint val_u32_;
    int val_i32_;
    float val_f32_;
    int _pad3_0;
    uint64_t val_u64_;
    int _pad4_0;
    int _pad4_1;
    uint64_t2 val_u64_2_;
    int _pad5_0;
    int _pad5_1;
    int _pad5_2;
    int _pad5_3;
    uint64_t3 val_u64_3_;
    int _pad6_0;
    int _pad6_1;
    uint64_t4 val_u64_4_;
    int64_t val_i64_;
    int _pad8_0;
    int _pad8_1;
    int64_t2 val_i64_2_;
    int64_t3 val_i64_3_;
    int _pad10_0;
    int _pad10_1;
    int64_t4 val_i64_4_;
    uint64_t final_value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
    int _end_pad_3;
    int _end_pad_4;
    int _end_pad_5;
};

struct StorageCompatible {
    uint64_t val_u64_array_2_[2];
    int64_t val_i64_array_2_[2];
};

static const uint64_t constant_variable = 20uL;

static int64_t private_variable = 1L;
cbuffer input_uniform : register(b0) { UniformCompatible input_uniform; }
ByteAddressBuffer input_storage : register(t1);
ByteAddressBuffer input_arrays : register(t2);
RWByteAddressBuffer output : register(u3);
RWByteAddressBuffer output_arrays : register(u4);

int64_t naga_f2i64(float value) {
    return int64_t(clamp(value, -9.223372e18, 9.2233715e18));
}

typedef int64_t ret_Constructarray2_int64_t_[2];
ret_Constructarray2_int64_t_ Constructarray2_int64_t_(int64_t arg0, int64_t arg1) {
    int64_t ret[2] = { arg0, arg1 };
    return ret;
}

int64_t int64_function(int64_t x)
{
    int64_t val = 20L;

    int64_t phony = private_variable;
    int64_t _e5 = val;
    val = (_e5 + 9222370033850770834L);
    int64_t _e8 = val;
    int64_t _e9 = val;
    val = (_e8 + (_e9 + 5L));
    int64_t _e13 = val;
    uint _e16 = input_uniform.val_u32_;
    int64_t _e17 = val;
    val = (_e13 + int64_t((_e16 + uint(_e17))));
    int64_t _e22 = val;
    int _e25 = input_uniform.val_i32_;
    int64_t _e26 = val;
    val = (_e22 + int64_t(asint(asuint(_e25) + asuint(int(_e26)))));
    int64_t _e31 = val;
    float _e34 = input_uniform.val_f32_;
    int64_t _e35 = val;
    val = (_e31 + naga_f2i64((_e34 + float(_e35))));
    int64_t _e40 = val;
    int64_t _e43 = input_uniform.val_i64_;
    val = (_e40 + (_e43).xxx.z);
    int64_t _e47 = val;
    uint64_t _e50 = input_uniform.val_u64_;
    val = (_e47 + _e50);
    int64_t _e53 = val;
    uint64_t2 _e56 = input_uniform.val_u64_2_;
    val = (_e53 + _e56.y);
    int64_t _e60 = val;
    uint64_t3 _e63 = input_uniform.val_u64_3_;
    val = (_e60 + _e63.z);
    int64_t _e67 = val;
    uint64_t4 _e70 = input_uniform.val_u64_4_;
    val = (_e67 + _e70.w);
    int64_t _e74 = val;
    val = (_e74 + (-9223372036854775807L - 1L));
    int64_t _e81 = input_uniform.val_i64_;
    int64_t _e84 = input_storage.Load<int64_t>(128);
    output.Store(128, (_e81 + _e84));
    int64_t2 _e90 = input_uniform.val_i64_2_;
    int64_t2 _e93 = input_storage.Load<int64_t2>(144);
    output.Store(144, (_e90 + _e93));
    int64_t3 _e99 = input_uniform.val_i64_3_;
    int64_t3 _e102 = input_storage.Load<int64_t3>(160);
    output.Store(160, (_e99 + _e102));
    int64_t4 _e108 = input_uniform.val_i64_4_;
    int64_t4 _e111 = input_storage.Load<int64_t4>(192);
    output.Store(192, (_e108 + _e111));
    int64_t _e117[2] = Constructarray2_int64_t_(input_arrays.Load<int64_t>(16+0), input_arrays.Load<int64_t>(16+8));
    {
        int64_t _value2[2] = _e117;
        output_arrays.Store(16+0, _value2[0]);
        output_arrays.Store(16+8, _value2[1]);
    }
    int64_t _e118 = val;
    int64_t _e119 = val;
    val = (_e118 + abs(_e119));
    int64_t _e122 = val;
    int64_t _e123 = val;
    int64_t _e124 = val;
    int64_t _e125 = val;
    val = (_e122 + clamp(_e123, _e124, _e125));
    int64_t _e128 = val;
    int64_t _e129 = val;
    int64_t _e131 = val;
    val = (_e128 + dot((_e129).xx, (_e131).xx));
    int64_t _e135 = val;
    int64_t _e136 = val;
    int64_t _e137 = val;
    val = (_e135 + max(_e136, _e137));
    int64_t _e140 = val;
    int64_t _e141 = val;
    int64_t _e142 = val;
    val = (_e140 + min(_e141, _e142));
    int64_t _e145 = val;
    int64_t _e146 = val;
    val = (_e145 + sign(_e146));
    int64_t _e149 = val;
    return _e149;
}

uint64_t naga_f2u64(float value) {
    return uint64_t(clamp(value, 0.0, 1.8446743e19));
}

typedef uint64_t ret_Constructarray2_uint64_t_[2];
ret_Constructarray2_uint64_t_ Constructarray2_uint64_t_(uint64_t arg0, uint64_t arg1) {
    uint64_t ret[2] = { arg0, arg1 };
    return ret;
}

uint64_t uint64_function(uint64_t x_1)
{
    uint64_t val_1 = 20uL;

    uint64_t _e3 = val_1;
    val_1 = (_e3 + 31uL);
    uint64_t _e6 = val_1;
    uint64_t _e7 = val_1;
    val_1 = (_e6 + (_e7 + 5uL));
    uint64_t _e11 = val_1;
    uint _e14 = input_uniform.val_u32_;
    uint64_t _e15 = val_1;
    val_1 = (_e11 + uint64_t((_e14 + uint(_e15))));
    uint64_t _e20 = val_1;
    int _e23 = input_uniform.val_i32_;
    uint64_t _e24 = val_1;
    val_1 = (_e20 + uint64_t(asint(asuint(_e23) + asuint(int(_e24)))));
    uint64_t _e29 = val_1;
    float _e32 = input_uniform.val_f32_;
    uint64_t _e33 = val_1;
    val_1 = (_e29 + naga_f2u64((_e32 + float(_e33))));
    uint64_t _e38 = val_1;
    uint64_t _e41 = input_uniform.val_u64_;
    val_1 = (_e38 + (_e41).xxx.z);
    uint64_t _e45 = val_1;
    int64_t _e48 = input_uniform.val_i64_;
    val_1 = (_e45 + _e48);
    uint64_t _e51 = val_1;
    int64_t2 _e54 = input_uniform.val_i64_2_;
    val_1 = (_e51 + _e54.y);
    uint64_t _e58 = val_1;
    int64_t3 _e61 = input_uniform.val_i64_3_;
    val_1 = (_e58 + _e61.z);
    uint64_t _e65 = val_1;
    int64_t4 _e68 = input_uniform.val_i64_4_;
    val_1 = (_e65 + _e68.w);
    uint64_t _e76 = input_uniform.val_u64_;
    uint64_t _e79 = input_storage.Load<uint64_t>(16);
    output.Store(16, (_e76 + _e79));
    uint64_t2 _e85 = input_uniform.val_u64_2_;
    uint64_t2 _e88 = input_storage.Load<uint64_t2>(32);
    output.Store(32, (_e85 + _e88));
    uint64_t3 _e94 = input_uniform.val_u64_3_;
    uint64_t3 _e97 = input_storage.Load<uint64_t3>(64);
    output.Store(64, (_e94 + _e97));
    uint64_t4 _e103 = input_uniform.val_u64_4_;
    uint64_t4 _e106 = input_storage.Load<uint64_t4>(96);
    output.Store(96, (_e103 + _e106));
    uint64_t _e112[2] = Constructarray2_uint64_t_(input_arrays.Load<uint64_t>(0+0), input_arrays.Load<uint64_t>(0+8));
    {
        uint64_t _value2[2] = _e112;
        output_arrays.Store(0+0, _value2[0]);
        output_arrays.Store(0+8, _value2[1]);
    }
    uint64_t _e113 = val_1;
    uint64_t _e114 = val_1;
    val_1 = (_e113 + abs(_e114));
    uint64_t _e117 = val_1;
    uint64_t _e118 = val_1;
    uint64_t _e119 = val_1;
    uint64_t _e120 = val_1;
    val_1 = (_e117 + clamp(_e118, _e119, _e120));
    uint64_t _e123 = val_1;
    uint64_t _e124 = val_1;
    uint64_t _e126 = val_1;
    val_1 = (_e123 + dot((_e124).xx, (_e126).xx));
    uint64_t _e130 = val_1;
    uint64_t _e131 = val_1;
    uint64_t _e132 = val_1;
    val_1 = (_e130 + max(_e131, _e132));
    uint64_t _e135 = val_1;
    uint64_t _e136 = val_1;
    uint64_t _e137 = val_1;
    val_1 = (_e135 + min(_e136, _e137));
    uint64_t _e140 = val_1;
    return _e140;
}

[numthreads(1, 1, 1)]
void main()
{
    const uint64_t _e3 = uint64_function(67uL);
    const int64_t _e5 = int64_function(60L);
    output.Store(224, (_e3 + _e5));
    return;
}
