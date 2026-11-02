#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };


uint adjust(uint value_3) {
    return (value_3 + 3u);
}

void main() {
    uint typed_value = 0u;
    uint local_value = 0u;
    uint SOURCE_NAME_tail = 0u;
    uint expanded_tail = 0u;
    uint local = 0u;
    uint updated = 0u;
    uint value = 0u;
    uint counter = 0u;
    uint value_1 = 0u;
    uint value_2 = 0u;
    typed_value = 7u;
    local_value = 11u;
    SOURCE_NAME_tail = 13u;
    expanded_tail = 17u;
    uint _e8 = typed_value;
    _group_0_binding_0_cs[uint(0)] = _e8;
    uint _e13 = local_value;
    _group_0_binding_0_cs[uint(1)] = _e13;
    uint _e17 = SOURCE_NAME_tail;
    _group_0_binding_0_cs[uint(2)] = _e17;
    uint _e21 = expanded_tail;
    _group_0_binding_0_cs[uint(3)] = _e21;
    _group_0_binding_0_cs[uint(4)] = 23u;
    _group_0_binding_0_cs[uint(5)] = 42u;
    _group_0_binding_0_cs[uint(6)] = floatBitsToUint(1.5);
    _group_0_binding_0_cs[uint(7)] = floatBitsToUint(4.0);
    if ((3u <= 4u)) {
        local = 1u;
    } else {
        local = 0u;
    }
    uint _e51 = local;
    _group_0_binding_0_cs[uint(8)] = _e51;
    _group_0_binding_0_cs[uint(9)] = (32u >> 2u);
    updated = 9u;
    uint _e63 = updated;
    updated = (_e63 + 5u);
    uint _e66 = updated;
    _group_0_binding_0_cs[uint(10)] = _e66;
    _group_0_binding_0_cs[uint(11)] = uint(63);
    _group_0_binding_0_cs[uint(12)] = 29u;
    uint _e80 = adjust(5u);
    _group_0_binding_0_cs[uint(13)] = _e80;
    _group_0_binding_0_cs[uint(14)] = 19u;
    _group_0_binding_0_cs[uint(15)] = 21u;
    _group_0_binding_0_cs[uint(16)] = (4u + 5u);
    _group_0_binding_0_cs[uint(17)] = 23u;
    value = 10u;
    uint _e104 = value;
    _group_0_binding_0_cs[uint(18)] = ((3u + _e104) + 2u);
    _group_0_binding_0_cs[uint(19)] = (2u + 3u);
    counter = 0u;
    uint _e120 = counter;
    counter = (_e120 + uint(1));
    value_1 = 0u;
    value_1 = 7u;
    uint _e128 = counter;
    counter = (_e128 + 1u);
    uint _e131 = value_1;
    _group_0_binding_0_cs[uint(20)] = _e131;
    uint _e135 = counter;
    _group_0_binding_0_cs[uint(21)] = _e135;
    uint _e139 = counter;
    counter = (_e139 + uint(1));
    value_2 = 0u;
    value_2 = 9u;
    uint _e147 = counter;
    counter = (_e147 + 1u);
    uint _e150 = value_2;
    _group_0_binding_0_cs[uint(22)] = _e150;
    uint _e154 = counter;
    _group_0_binding_0_cs[uint(23)] = _e154;
}

