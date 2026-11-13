const Count: u32 = 4u;

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

fn verified_unsigned_4u(value: u32) -> u32 {
    return value;
}

@compute @workgroup_size(4, 1, 1)
fn assertions(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var VectorBytes: u32;
    var local: u32;

    VectorBytes = 12u;
    let _e6 = verified_unsigned_4u((threadIdx.x + 7u));
    local = u32(threadIdx.x);
    let _e10 = local;
    output[_e10] = _e6;
}
