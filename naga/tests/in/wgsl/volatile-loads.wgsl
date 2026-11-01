struct Data {
    values: array<u32>,
}

@group(0) @binding(0) @volatile
var<storage, read_write> watched: Data;
@group(0) @binding(1)
var<storage, read_write> ordinary: Data;
@group(0) @binding(2)
var<storage, read_write> output: Data;

@compute @workgroup_size(1)
fn main(@builtin(local_invocation_index) lane: u32) {
    _ = watched.values[0];
    watched.values[0] = 7u;
    _ = watched.values[0];
    output.values[0] = watched.values[1] + watched.values[1];
    let shared_read = watched.values[2];
    output.values[1] = shared_read + shared_read;
    _ = watched.values[2] + watched.values[3];
    if lane == 0u {
        _ = watched.values[3];
    }
    for (var iteration = 0u; iteration < 2u; iteration++) {
        _ = watched.values[iteration];
    }
    _ = ordinary.values[0];
    _ = ordinary.values[watched.values[0] & 3u];
}
