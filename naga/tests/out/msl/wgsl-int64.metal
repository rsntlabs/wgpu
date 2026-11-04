// language: metal2.3
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct UniformCompatible {
    uint val_u32_;
    int val_i32_;
    float val_f32_;
    char _pad3[4];
    ulong val_u64_;
    char _pad4[8];
    metal::ulong2 val_u64_2_;
    char _pad5[16];
    metal::ulong3 val_u64_3_;
    metal::ulong4 val_u64_4_;
    long val_i64_;
    char _pad8[8];
    metal::long2 val_i64_2_;
    metal::long3 val_i64_3_;
    metal::long4 val_i64_4_;
    ulong final_value;
    char _pad12[24];
};
struct type_11 {
    ulong inner[2];
};
struct type_12 {
    long inner[2];
};
struct StorageCompatible {
    type_11 val_u64_array_2_;
    type_12 val_i64_array_2_;
};
constant ulong constant_variable = 20uL;

long naga_f2i64(float value) {
    return static_cast<long>(metal::clamp(value, -9223372000000000000.0, 9223371500000000000.0));
}

long naga_abs(long val) {
    return metal::select(as_type<long>(-as_type<ulong>(val)), val, val >= 0);
}

long naga_dot_long2(metal::long2 a, metal::long2 b) {
    return ( + a.x * b.x + a.y * b.y);
}

long int64_function(
    long x,
    thread long& private_variable,
    constant UniformCompatible& input_uniform,
    device UniformCompatible const& input_storage,
    device StorageCompatible const& input_arrays,
    device UniformCompatible& output,
    device StorageCompatible& output_arrays
) {
    long val = 20L;
    long phony = private_variable;
    long _e5 = val;
    val = as_type<long>(as_type<ulong>(_e5) + as_type<ulong>(9222370033850770834L));
    long _e8 = val;
    long _e9 = val;
    val = as_type<long>(as_type<ulong>(_e8) + as_type<ulong>(as_type<long>(as_type<ulong>(_e9) + as_type<ulong>(5L))));
    long _e13 = val;
    uint _e16 = input_uniform.val_u32_;
    long _e17 = val;
    val = as_type<long>(as_type<ulong>(_e13) + as_type<ulong>(static_cast<long>(_e16 + static_cast<uint>(_e17))));
    long _e22 = val;
    int _e25 = input_uniform.val_i32_;
    long _e26 = val;
    val = as_type<long>(as_type<ulong>(_e22) + as_type<ulong>(static_cast<long>(as_type<int>(as_type<uint>(_e25) + as_type<uint>(static_cast<int>(_e26))))));
    long _e31 = val;
    float _e34 = input_uniform.val_f32_;
    long _e35 = val;
    val = as_type<long>(as_type<ulong>(_e31) + as_type<ulong>(naga_f2i64(_e34 + static_cast<float>(_e35))));
    long _e40 = val;
    long _e43 = input_uniform.val_i64_;
    val = as_type<long>(as_type<ulong>(_e40) + as_type<ulong>(metal::long3(_e43).z));
    long _e47 = val;
    ulong _e50 = input_uniform.val_u64_;
    val = as_type<long>(as_type<ulong>(_e47) + as_type<ulong>(as_type<long>(_e50)));
    long _e53 = val;
    metal::ulong2 _e56 = input_uniform.val_u64_2_;
    val = as_type<long>(as_type<ulong>(_e53) + as_type<ulong>(as_type<metal::long2>(_e56).y));
    long _e60 = val;
    metal::ulong3 _e63 = input_uniform.val_u64_3_;
    val = as_type<long>(as_type<ulong>(_e60) + as_type<ulong>(as_type<metal::long3>(_e63).z));
    long _e67 = val;
    metal::ulong4 _e70 = input_uniform.val_u64_4_;
    val = as_type<long>(as_type<ulong>(_e67) + as_type<ulong>(as_type<metal::long4>(_e70).w));
    long _e74 = val;
    val = as_type<long>(as_type<ulong>(_e74) + as_type<ulong>((-9223372036854775807L - 1L)));
    long _e81 = input_uniform.val_i64_;
    long _e84 = input_storage.val_i64_;
    output.val_i64_ = as_type<long>(as_type<ulong>(_e81) + as_type<ulong>(_e84));
    metal::long2 _e90 = input_uniform.val_i64_2_;
    metal::long2 _e93 = input_storage.val_i64_2_;
    output.val_i64_2_ = as_type<metal::long2>(as_type<metal::ulong2>(_e90) + as_type<metal::ulong2>(_e93));
    metal::long3 _e99 = input_uniform.val_i64_3_;
    metal::long3 _e102 = input_storage.val_i64_3_;
    output.val_i64_3_ = as_type<metal::long3>(as_type<metal::ulong3>(_e99) + as_type<metal::ulong3>(_e102));
    metal::long4 _e108 = input_uniform.val_i64_4_;
    metal::long4 _e111 = input_storage.val_i64_4_;
    output.val_i64_4_ = as_type<metal::long4>(as_type<metal::ulong4>(_e108) + as_type<metal::ulong4>(_e111));
    type_12 _e117 = input_arrays.val_i64_array_2_;
    output_arrays.val_i64_array_2_ = _e117;
    long _e118 = val;
    long _e119 = val;
    val = as_type<long>(as_type<ulong>(_e118) + as_type<ulong>(naga_abs(_e119)));
    long _e122 = val;
    long _e123 = val;
    long _e124 = val;
    long _e125 = val;
    val = as_type<long>(as_type<ulong>(_e122) + as_type<ulong>(metal::clamp(_e123, _e124, _e125)));
    long _e128 = val;
    long _e129 = val;
    long _e131 = val;
    val = as_type<long>(as_type<ulong>(_e128) + as_type<ulong>(naga_dot_long2(metal::long2(_e129), metal::long2(_e131))));
    long _e135 = val;
    long _e136 = val;
    long _e137 = val;
    val = as_type<long>(as_type<ulong>(_e135) + as_type<ulong>(metal::max(_e136, _e137)));
    long _e140 = val;
    long _e141 = val;
    long _e142 = val;
    val = as_type<long>(as_type<ulong>(_e140) + as_type<ulong>(metal::min(_e141, _e142)));
    long _e145 = val;
    long _e146 = val;
    val = as_type<long>(as_type<ulong>(_e145) + as_type<ulong>(metal::select(metal::select(long(-1), long(1), (_e146 > 0)), long(0), (_e146 == 0))));
    long _e149 = val;
    return _e149;
}

ulong naga_f2u64(float value) {
    return static_cast<ulong>(metal::clamp(value, 0.0, 18446743000000000000.0));
}

ulong naga_dot_ulong2(metal::ulong2 a, metal::ulong2 b) {
    return ( + a.x * b.x + a.y * b.y);
}

ulong uint64_function(
    ulong x_1,
    constant UniformCompatible& input_uniform,
    device UniformCompatible const& input_storage,
    device StorageCompatible const& input_arrays,
    device UniformCompatible& output,
    device StorageCompatible& output_arrays
) {
    ulong val_1 = 20uL;
    ulong _e3 = val_1;
    val_1 = _e3 + 31uL;
    ulong _e6 = val_1;
    ulong _e7 = val_1;
    val_1 = _e6 + (_e7 + 5uL);
    ulong _e11 = val_1;
    uint _e14 = input_uniform.val_u32_;
    ulong _e15 = val_1;
    val_1 = _e11 + static_cast<ulong>(_e14 + static_cast<uint>(_e15));
    ulong _e20 = val_1;
    int _e23 = input_uniform.val_i32_;
    ulong _e24 = val_1;
    val_1 = _e20 + static_cast<ulong>(as_type<int>(as_type<uint>(_e23) + as_type<uint>(static_cast<int>(_e24))));
    ulong _e29 = val_1;
    float _e32 = input_uniform.val_f32_;
    ulong _e33 = val_1;
    val_1 = _e29 + naga_f2u64(_e32 + static_cast<float>(_e33));
    ulong _e38 = val_1;
    ulong _e41 = input_uniform.val_u64_;
    val_1 = _e38 + metal::ulong3(_e41).z;
    ulong _e45 = val_1;
    long _e48 = input_uniform.val_i64_;
    val_1 = _e45 + as_type<ulong>(_e48);
    ulong _e51 = val_1;
    metal::long2 _e54 = input_uniform.val_i64_2_;
    val_1 = _e51 + as_type<metal::ulong2>(_e54).y;
    ulong _e58 = val_1;
    metal::long3 _e61 = input_uniform.val_i64_3_;
    val_1 = _e58 + as_type<metal::ulong3>(_e61).z;
    ulong _e65 = val_1;
    metal::long4 _e68 = input_uniform.val_i64_4_;
    val_1 = _e65 + as_type<metal::ulong4>(_e68).w;
    ulong _e76 = input_uniform.val_u64_;
    ulong _e79 = input_storage.val_u64_;
    output.val_u64_ = _e76 + _e79;
    metal::ulong2 _e85 = input_uniform.val_u64_2_;
    metal::ulong2 _e88 = input_storage.val_u64_2_;
    output.val_u64_2_ = _e85 + _e88;
    metal::ulong3 _e94 = input_uniform.val_u64_3_;
    metal::ulong3 _e97 = input_storage.val_u64_3_;
    output.val_u64_3_ = _e94 + _e97;
    metal::ulong4 _e103 = input_uniform.val_u64_4_;
    metal::ulong4 _e106 = input_storage.val_u64_4_;
    output.val_u64_4_ = _e103 + _e106;
    type_11 _e112 = input_arrays.val_u64_array_2_;
    output_arrays.val_u64_array_2_ = _e112;
    ulong _e113 = val_1;
    ulong _e114 = val_1;
    val_1 = _e113 + metal::abs(_e114);
    ulong _e117 = val_1;
    ulong _e118 = val_1;
    ulong _e119 = val_1;
    ulong _e120 = val_1;
    val_1 = _e117 + metal::clamp(_e118, _e119, _e120);
    ulong _e123 = val_1;
    ulong _e124 = val_1;
    ulong _e126 = val_1;
    val_1 = _e123 + naga_dot_ulong2(metal::ulong2(_e124), metal::ulong2(_e126));
    ulong _e130 = val_1;
    ulong _e131 = val_1;
    ulong _e132 = val_1;
    val_1 = _e130 + metal::max(_e131, _e132);
    ulong _e135 = val_1;
    ulong _e136 = val_1;
    ulong _e137 = val_1;
    val_1 = _e135 + metal::min(_e136, _e137);
    ulong _e140 = val_1;
    return _e140;
}

[[max_total_threads_per_threadgroup(1)]] kernel void main_(
  constant UniformCompatible& input_uniform [[user(fake0)]]
, device UniformCompatible const& input_storage [[user(fake0)]]
, device StorageCompatible const& input_arrays [[user(fake0)]]
, device UniformCompatible& output [[user(fake0)]]
, device StorageCompatible& output_arrays [[user(fake0)]]
) {
    long private_variable = 1L;
    ulong _e3 = uint64_function(67uL, input_uniform, input_storage, input_arrays, output, output_arrays);
    long _e5 = int64_function(60L, private_variable, input_uniform, input_storage, input_arrays, output, output_arrays);
    output.final_value = _e3 + as_type<ulong>(_e5);
    return;
}
