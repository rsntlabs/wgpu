struct Packet_cuda_record_0_ {
    first: u32,
    second: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn later(value: u32) -> u32 {
    return (value + 5u);
}

@compute @workgroup_size(2, 1, 1)
fn preprocessing(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var original: Packet_cuda_record_0_;
    var copied: Packet_cuda_record_0_;
    var local_8: u32;
    var local_9: u32;
    var SELF: u32;
    var LEFT: u32;
    var RIGHT: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var counter: u32;
    var ordered: Packet_cuda_record_0_;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var values: array<u32, 3>;
    var local_17: u32;
    var index: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;

    let lane = threadIdx.x;
    if (lane >= 2u) {
        return;
    }
    let start = (lane * 24u);
    local = u32((start + 0u));
    let _e10 = local;
    out[_e10] = 7u;
    local_1 = u32((start + 1u));
    let _e18 = local_1;
    out[_e18] = 11u;
    local_2 = u32((start + 2u));
    let _e25 = local_2;
    out[_e25] = 22u;
    local_3 = u32((start + 3u));
    let _e37 = local_3;
    out[_e37] = (2u + (3u * 4u));
    local_4 = u32((start + 4u));
    let _e46 = local_4;
    out[_e46] = (2u + 3u);
    local_6 = 2u;
    let _e50 = local_6;
    local_5 = u32((start + 5u));
    let _e57 = local_5;
    out[_e57] = (3u << _e50);
    let _e59 = later(lane);
    local_7 = u32((start + 6u));
    let _e64 = local_7;
    out[_e64] = _e59;
    original.first = (lane + 1u);
    original.second = (lane + 2u);
    let _e73 = original;
    copied = _e73;
    let _e76 = copied.first;
    local_8 = u32((start + 7u));
    let _e81 = local_8;
    out[_e81] = _e76;
    let _e84 = copied.second;
    local_9 = u32((start + 8u));
    let _e89 = local_9;
    out[_e89] = _e84;
    SELF = 17u;
    LEFT = 19u;
    RIGHT = 23u;
    let _e97 = SELF;
    local_10 = u32((start + 9u));
    let _e102 = local_10;
    out[_e102] = _e97;
    let _e104 = LEFT;
    local_11 = u32((start + 10u));
    let _e109 = local_11;
    out[_e109] = _e104;
    let _e111 = RIGHT;
    local_12 = u32((start + 11u));
    let _e116 = local_12;
    out[_e116] = _e111;
    counter = 0u;
    let _e120 = counter;
    counter = (_e120 + u32(1i));
    let _e124 = counter;
    ordered.first = _e124;
    let _e128 = counter;
    counter = (_e128 + u32(1i));
    let _e132 = counter;
    ordered.second = _e132;
    let _e134 = ordered.first;
    local_13 = u32((start + 12u));
    let _e139 = local_13;
    out[_e139] = _e134;
    let _e142 = ordered.second;
    local_14 = u32((start + 13u));
    let _e147 = local_14;
    out[_e147] = _e142;
    let _e149 = counter;
    local_15 = u32((start + 14u));
    let _e154 = local_15;
    out[_e154] = _e149;
    local_16 = u32((start + 15u));
    let _e160 = local_16;
    out[_e160] = 31u;
    values[0] = 2u;
    values[1] = 4u;
    values[2] = 6u;
    let _e171 = values[lane];
    local_17 = u32((start + 16u));
    let _e176 = local_17;
    out[_e176] = _e171;
    index = 0u;
    let _e180 = index;
    index = (_e180 + u32(1i));
    let _e185 = values[_e180];
    local_18 = u32((start + 17u));
    let _e190 = local_18;
    out[_e190] = _e185;
    let _e192 = index;
    local_19 = u32((start + 18u));
    let _e197 = local_19;
    out[_e197] = _e192;
    local_20 = u32((start + 19u));
    let _e205 = local_20;
    out[_e205] = u32(true);
    local_21 = u32((start + 20u));
    let _e211 = local_21;
    out[_e211] = 61u;
    local_22 = u32((start + 21u));
    let _e218 = local_22;
    out[_e218] = lane;
    local_23 = u32((start + 22u));
    let _e227 = local_23;
    out[_e227] = bitcast<u32>(-(0f));
    local_24 = u32((start + 23u));
    let _e233 = local_24;
    out[_e233] = 4294967295u;
}
