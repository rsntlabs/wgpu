struct Data {
    values: array<u32>,
}

@group(0) @binding(0)
@volatile var<storage, read_write> watched: Data;
@group(0) @binding(1)
var<storage, read_write> ordinary: Data;
@group(0) @binding(2)
var<storage, read_write> output: Data;

@compute @workgroup_size(1, 1, 1)
fn main(@builtin(local_invocation_index) lane: u32) {
    var iteration: u32 = 0u;

    let phony = watched.values[0];
    watched.values[0] = 7u;
    let phony_1 = watched.values[0];
    let _e19 = watched.values[1];
    let _e23 = watched.values[1];
    output.values[0] = (_e19 + _e23);
    let shared_read = watched.values[2];
    output.values[1] = (shared_read + shared_read);
    let _e36 = watched.values[2];
    let _e40 = watched.values[3];
    let phony_2 = (_e36 + _e40);
    if (lane == 0u) {
        let phony_3 = watched.values[3];
    }
    loop {
        let _e50 = iteration;
        if (_e50 < 2u) {
        } else {
            break;
        }
        {
            let _e55 = iteration;
            let phony_4 = watched.values[_e55];
        }
        continuing {
            let _e59 = iteration;
            iteration = (_e59 + 1u);
        }
    }
    let phony_5 = ordinary.values[0];
    let _e70 = watched.values[0];
    let phony_6 = ordinary.values[(_e70 & 3u)];
    return;
}
