@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn adjust(value_3: u32) -> u32 {
    return (value_3 + 3u);
}

@compute @workgroup_size(1, 1, 1)
fn token_pasting() {
    var typed_value: u32;
    var local_value: u32;
    var SOURCE_NAME_tail: u32;
    var expanded_tail: u32;
    var local: u32;
    var updated: u32;
    var value: u32;
    var counter: u32;
    var value_1: u32;
    var value_2: u32;

    typed_value = 7u;
    local_value = 11u;
    SOURCE_NAME_tail = 13u;
    expanded_tail = 17u;
    let _e8 = typed_value;
    out[u32(0i)] = _e8;
    let _e13 = local_value;
    out[u32(1i)] = _e13;
    let _e17 = SOURCE_NAME_tail;
    out[u32(2i)] = _e17;
    let _e21 = expanded_tail;
    out[u32(3i)] = _e21;
    out[u32(4i)] = 23u;
    out[u32(5i)] = 42u;
    out[u32(6i)] = bitcast<u32>(1.5f);
    out[u32(7i)] = bitcast<u32>(4f);
    if (3u <= 4u) {
        local = 1u;
    } else {
        local = 0u;
    }
    let _e51 = local;
    out[u32(8i)] = _e51;
    out[u32(9i)] = (32u >> 2u);
    updated = 9u;
    let _e63 = updated;
    updated = (_e63 + 5u);
    let _e66 = updated;
    out[u32(10i)] = _e66;
    out[u32(11i)] = u32(63i);
    out[u32(12i)] = 29u;
    let _e80 = adjust(5u);
    out[u32(13i)] = _e80;
    out[u32(14i)] = 19u;
    out[u32(15i)] = 21u;
    out[u32(16i)] = (4u + 5u);
    out[u32(17i)] = 23u;
    value = 10u;
    let _e104 = value;
    out[u32(18i)] = ((3u + _e104) + 2u);
    out[u32(19i)] = (2u + 3u);
    counter = 0u;
    let _e120 = counter;
    counter = (_e120 + u32(1i));
    value_1 = u32();
    value_1 = 7u;
    let _e128 = counter;
    counter = (_e128 + 1u);
    let _e131 = value_1;
    out[u32(20i)] = _e131;
    let _e135 = counter;
    out[u32(21i)] = _e135;
    let _e139 = counter;
    counter = (_e139 + u32(1i));
    value_2 = u32();
    value_2 = 9u;
    let _e147 = counter;
    counter = (_e147 + 1u);
    let _e150 = value_2;
    out[u32(22i)] = _e150;
    let _e154 = counter;
    out[u32(23i)] = _e154;
}
