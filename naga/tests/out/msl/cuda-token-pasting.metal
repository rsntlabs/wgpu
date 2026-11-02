// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_1[1];

uint adjust(
    uint value_3
) {
    return value_3 + 3u;
}

kernel void token_pasting(
  device type_1& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint typed_value = {};
    uint local_value = {};
    uint SOURCE_NAME_tail = {};
    uint expanded_tail = {};
    uint local = {};
    uint updated = {};
    uint value = {};
    uint counter = {};
    uint value_1 = {};
    uint value_2 = {};
    typed_value = 7u;
    local_value = 11u;
    SOURCE_NAME_tail = 13u;
    expanded_tail = 17u;
    uint _e8 = typed_value;
    out[static_cast<uint>(0)] = _e8;
    uint _e13 = local_value;
    out[static_cast<uint>(1)] = _e13;
    uint _e17 = SOURCE_NAME_tail;
    out[static_cast<uint>(2)] = _e17;
    uint _e21 = expanded_tail;
    out[static_cast<uint>(3)] = _e21;
    out[static_cast<uint>(4)] = 23u;
    out[static_cast<uint>(5)] = 42u;
    out[static_cast<uint>(6)] = as_type<uint>(1.5);
    out[static_cast<uint>(7)] = as_type<uint>(4.0);
    if (3u <= 4u) {
        local = 1u;
    } else {
        local = 0u;
    }
    uint _e51 = local;
    out[static_cast<uint>(8)] = _e51;
    out[static_cast<uint>(9)] = 32u >> 2u;
    updated = 9u;
    uint _e63 = updated;
    updated = _e63 + 5u;
    uint _e66 = updated;
    out[static_cast<uint>(10)] = _e66;
    out[static_cast<uint>(11)] = static_cast<uint>(63);
    out[static_cast<uint>(12)] = 29u;
    uint _e80 = adjust(5u);
    out[static_cast<uint>(13)] = _e80;
    out[static_cast<uint>(14)] = 19u;
    out[static_cast<uint>(15)] = 21u;
    out[static_cast<uint>(16)] = 4u + 5u;
    out[static_cast<uint>(17)] = 23u;
    value = 10u;
    uint _e104 = value;
    out[static_cast<uint>(18)] = (3u + _e104) + 2u;
    out[static_cast<uint>(19)] = 2u + 3u;
    counter = 0u;
    uint _e120 = counter;
    counter = _e120 + static_cast<uint>(1);
    value_1 = uint {};
    value_1 = 7u;
    uint _e128 = counter;
    counter = _e128 + 1u;
    uint _e131 = value_1;
    out[static_cast<uint>(20)] = _e131;
    uint _e135 = counter;
    out[static_cast<uint>(21)] = _e135;
    uint _e139 = counter;
    counter = _e139 + static_cast<uint>(1);
    value_2 = uint {};
    value_2 = 9u;
    uint _e147 = counter;
    counter = _e147 + 1u;
    uint _e150 = value_2;
    out[static_cast<uint>(22)] = _e150;
    uint _e154 = counter;
    out[static_cast<uint>(23)] = _e154;
}
