struct UniformCompatible {
    val_u32_: u32,
    val_i32_: i32,
    val_f32_: f32,
    val_u64_: u64,
    val_u64_2_: vec2<u64>,
    val_u64_3_: vec3<u64>,
    val_u64_4_: vec4<u64>,
    val_i64_: i64,
    val_i64_2_: vec2<i64>,
    val_i64_3_: vec3<i64>,
    val_i64_4_: vec4<i64>,
    final_value: u64,
}

struct StorageCompatible {
    val_u64_array_2_: array<u64, 2>,
    val_i64_array_2_: array<i64, 2>,
}

const constant_variable: u64 = 20lu;

var<private> private_variable: i64 = 1li;
@group(0) @binding(0)
var<uniform> input_uniform: UniformCompatible;
@group(0) @binding(1)
var<storage> input_storage: UniformCompatible;
@group(0) @binding(2)
var<storage> input_arrays: StorageCompatible;
@group(0) @binding(3)
var<storage, read_write> output: UniformCompatible;
@group(0) @binding(4)
var<storage, read_write> output_arrays: StorageCompatible;

fn int64_function(x: i64) -> i64 {
    var val: i64 = 20li;

    let phony = private_variable;
    let _e5 = val;
    val = (_e5 + 9222370033850770834li);
    let _e8 = val;
    let _e9 = val;
    val = (_e8 + (_e9 + 5li));
    let _e13 = val;
    let _e16 = input_uniform.val_u32_;
    let _e17 = val;
    val = (_e13 + i64((_e16 + u32(_e17))));
    let _e22 = val;
    let _e25 = input_uniform.val_i32_;
    let _e26 = val;
    val = (_e22 + i64((_e25 + i32(_e26))));
    let _e31 = val;
    let _e34 = input_uniform.val_f32_;
    let _e35 = val;
    val = (_e31 + i64((_e34 + f32(_e35))));
    let _e40 = val;
    let _e43 = input_uniform.val_i64_;
    val = (_e40 + vec3(_e43).z);
    let _e47 = val;
    let _e50 = input_uniform.val_u64_;
    val = (_e47 + bitcast<i64>(_e50));
    let _e53 = val;
    let _e56 = input_uniform.val_u64_2_;
    val = (_e53 + bitcast<vec2<i64>>(_e56).y);
    let _e60 = val;
    let _e63 = input_uniform.val_u64_3_;
    val = (_e60 + bitcast<vec3<i64>>(_e63).z);
    let _e67 = val;
    let _e70 = input_uniform.val_u64_4_;
    val = (_e67 + bitcast<vec4<i64>>(_e70).w);
    let _e74 = val;
    val = (_e74 + i64(-9223372036854775807 - 1));
    let _e81 = input_uniform.val_i64_;
    let _e84 = input_storage.val_i64_;
    output.val_i64_ = (_e81 + _e84);
    let _e90 = input_uniform.val_i64_2_;
    let _e93 = input_storage.val_i64_2_;
    output.val_i64_2_ = (_e90 + _e93);
    let _e99 = input_uniform.val_i64_3_;
    let _e102 = input_storage.val_i64_3_;
    output.val_i64_3_ = (_e99 + _e102);
    let _e108 = input_uniform.val_i64_4_;
    let _e111 = input_storage.val_i64_4_;
    output.val_i64_4_ = (_e108 + _e111);
    let _e117 = input_arrays.val_i64_array_2_;
    output_arrays.val_i64_array_2_ = _e117;
    let _e118 = val;
    let _e119 = val;
    val = (_e118 + abs(_e119));
    let _e122 = val;
    let _e123 = val;
    let _e124 = val;
    let _e125 = val;
    val = (_e122 + clamp(_e123, _e124, _e125));
    let _e128 = val;
    let _e129 = val;
    let _e131 = val;
    val = (_e128 + dot(vec2(_e129), vec2(_e131)));
    let _e135 = val;
    let _e136 = val;
    let _e137 = val;
    val = (_e135 + max(_e136, _e137));
    let _e140 = val;
    let _e141 = val;
    let _e142 = val;
    val = (_e140 + min(_e141, _e142));
    let _e145 = val;
    let _e146 = val;
    val = (_e145 + sign(_e146));
    let _e149 = val;
    return _e149;
}

fn uint64_function(x_1: u64) -> u64 {
    var val_1: u64 = 20lu;

    let _e3 = val_1;
    val_1 = (_e3 + 31lu);
    let _e6 = val_1;
    let _e7 = val_1;
    val_1 = (_e6 + (_e7 + 5lu));
    let _e11 = val_1;
    let _e14 = input_uniform.val_u32_;
    let _e15 = val_1;
    val_1 = (_e11 + u64((_e14 + u32(_e15))));
    let _e20 = val_1;
    let _e23 = input_uniform.val_i32_;
    let _e24 = val_1;
    val_1 = (_e20 + u64((_e23 + i32(_e24))));
    let _e29 = val_1;
    let _e32 = input_uniform.val_f32_;
    let _e33 = val_1;
    val_1 = (_e29 + u64((_e32 + f32(_e33))));
    let _e38 = val_1;
    let _e41 = input_uniform.val_u64_;
    val_1 = (_e38 + vec3(_e41).z);
    let _e45 = val_1;
    let _e48 = input_uniform.val_i64_;
    val_1 = (_e45 + bitcast<u64>(_e48));
    let _e51 = val_1;
    let _e54 = input_uniform.val_i64_2_;
    val_1 = (_e51 + bitcast<vec2<u64>>(_e54).y);
    let _e58 = val_1;
    let _e61 = input_uniform.val_i64_3_;
    val_1 = (_e58 + bitcast<vec3<u64>>(_e61).z);
    let _e65 = val_1;
    let _e68 = input_uniform.val_i64_4_;
    val_1 = (_e65 + bitcast<vec4<u64>>(_e68).w);
    let _e76 = input_uniform.val_u64_;
    let _e79 = input_storage.val_u64_;
    output.val_u64_ = (_e76 + _e79);
    let _e85 = input_uniform.val_u64_2_;
    let _e88 = input_storage.val_u64_2_;
    output.val_u64_2_ = (_e85 + _e88);
    let _e94 = input_uniform.val_u64_3_;
    let _e97 = input_storage.val_u64_3_;
    output.val_u64_3_ = (_e94 + _e97);
    let _e103 = input_uniform.val_u64_4_;
    let _e106 = input_storage.val_u64_4_;
    output.val_u64_4_ = (_e103 + _e106);
    let _e112 = input_arrays.val_u64_array_2_;
    output_arrays.val_u64_array_2_ = _e112;
    let _e113 = val_1;
    let _e114 = val_1;
    val_1 = (_e113 + abs(_e114));
    let _e117 = val_1;
    let _e118 = val_1;
    let _e119 = val_1;
    let _e120 = val_1;
    val_1 = (_e117 + clamp(_e118, _e119, _e120));
    let _e123 = val_1;
    let _e124 = val_1;
    let _e126 = val_1;
    val_1 = (_e123 + dot(vec2(_e124), vec2(_e126)));
    let _e130 = val_1;
    let _e131 = val_1;
    let _e132 = val_1;
    val_1 = (_e130 + max(_e131, _e132));
    let _e135 = val_1;
    let _e136 = val_1;
    let _e137 = val_1;
    val_1 = (_e135 + min(_e136, _e137));
    let _e140 = val_1;
    return _e140;
}

@compute @workgroup_size(1, 1, 1)
fn main() {
    let _e3 = uint64_function(67lu);
    let _e5 = int64_function(60li);
    output.final_value = (_e3 + bitcast<u64>(_e5));
    return;
}
