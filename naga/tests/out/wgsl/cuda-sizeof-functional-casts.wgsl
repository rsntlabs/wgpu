@group(0) @binding(0)
var<storage> input: array<i32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

@compute @workgroup_size(4, 1, 1)
fn sizeof_functional_casts(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var counter: i32;
    var matrix: array<array<i32, 3>, 2>;
    var local: u32;
    var local_1: u32;
    var Integer: u32;
    var Short: u32;
    var WideAlias: u32;
    var Real: u32;
    var Pointer: u32;
    var Array: u32;
    var Null: u32;
    var Group: u32;
    var Nested: u32;
    var Middle: u32;
    var Row: u32;
    var Range: u32;
    var Binding: u32;
    var Shift: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;

    let lane = threadIdx.x;
    let base = (4u + (lane * 16u));
    let seed = input[lane];
    counter = 7i;
    local = 0u;
    loop {
        let _e13 = local;
        if (_e13 >= 2u) {
            break;
        }
        local_1 = 0u;
        loop {
            let _e20 = local_1;
            if (_e20 >= 3u) {
                break;
            }
            matrix[_e13][_e20] = i32();
            continuing {
                let _e25 = local_1;
                local_1 = (_e25 + 1u);
            }
        }
        continuing {
            let _e28 = local;
            local = (_e28 + 1u);
        }
    }
    Integer = 4u;
    Short = 2u;
    WideAlias = 8u;
    Real = 4u;
    Pointer = 1u;
    Array = 1u;
    Null = 1u;
    Group = 4u;
    Nested = 2u;
    Middle = 1u;
    Row = 12u;
    Range = 4u;
    Binding = 3u;
    Shift = 4u;
    let _e59 = Integer;
    output[base] = _e59;
    let _e62 = Short;
    local_2 = u32((base + 1u));
    let _e67 = local_2;
    output[_e67] = _e62;
    let _e69 = WideAlias;
    local_3 = u32((base + 2u));
    let _e74 = local_3;
    output[_e74] = _e69;
    let _e76 = Real;
    local_4 = u32((base + 3u));
    let _e81 = local_4;
    output[_e81] = _e76;
    let _e83 = Pointer;
    local_5 = u32((base + 4u));
    let _e88 = local_5;
    output[_e88] = _e83;
    let _e90 = Array;
    local_6 = u32((base + 5u));
    let _e95 = local_6;
    output[_e95] = _e90;
    let _e97 = Null;
    local_7 = u32((base + 6u));
    let _e102 = local_7;
    output[_e102] = _e97;
    let _e104 = Group;
    local_8 = u32((base + 7u));
    let _e109 = local_8;
    output[_e109] = _e104;
    let _e111 = Nested;
    local_9 = u32((base + 8u));
    let _e116 = local_9;
    output[_e116] = _e111;
    let _e118 = Middle;
    local_10 = u32((base + 9u));
    let _e123 = local_10;
    output[_e123] = _e118;
    let _e125 = Row;
    local_11 = u32((base + 10u));
    let _e130 = local_11;
    output[_e130] = _e125;
    let _e132 = Range;
    local_12 = u32((base + 11u));
    let _e137 = local_12;
    output[_e137] = _e132;
    let _e139 = Binding;
    local_13 = u32((base + 12u));
    let _e144 = local_13;
    output[_e144] = _e139;
    let _e146 = Shift;
    local_14 = u32((base + 13u));
    let _e151 = local_14;
    output[_e151] = _e146;
    let _e153 = counter;
    local_15 = u32((base + 14u));
    let _e159 = local_15;
    output[_e159] = u32(_e153);
    let _e162 = input[lane];
    local_16 = u32((base + 15u));
    let _e168 = local_16;
    output[_e168] = u32(_e162);
}
