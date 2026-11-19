@group(0) @binding(0)
var<storage> input: array<i32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

@compute @workgroup_size(4, 1, 1)
fn sizeof_conditionals(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var small: i32;
    var other: i32;
    var unknown: bool;
    var cursor: i32;
    var grid: array<array<i32, 3>, 2>;
    var local: u32;
    var local_1: u32;
    var SameType: u32;
    var Boolean: u32;
    var Promoted: u32;
    var BoolInt: u32;
    var Real: u32;
    var NestedMiddle: u32;
    var NestedFinal: u32;
    var Grouped: u32;
    var Logical: u32;
    var Row: u32;
    var Element: u32;
    var InvalidDivide: u32;
    var InvalidShift: u32;
    var Reference: u32;
    var Storage: u32;
    var UnaryBinding: u32;
    var local_2: u32;
    var AddBinding: u32;
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
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;

    let lane = threadIdx.x;
    let base = (4u + (lane * 20u));
    let seed = input[lane];
    let flag = (seed != 0i);
    cursor = 7i;
    local = 0u;
    loop {
        let _e15 = local;
        if (_e15 >= 2u) {
            break;
        }
        local_1 = 0u;
        loop {
            let _e22 = local_1;
            if (_e22 >= 3u) {
                break;
            }
            grid[_e15][_e22] = i32();
            continuing {
                let _e27 = local_1;
                local_1 = (_e27 + 1u);
            }
        }
        continuing {
            let _e30 = local;
            local = (_e30 + 1u);
        }
    }
    SameType = 4u;
    Boolean = 1u;
    Promoted = 4u;
    BoolInt = 4u;
    Real = 4u;
    NestedMiddle = 4u;
    NestedFinal = 4u;
    Grouped = 4u;
    Logical = 4u;
    Row = 12u;
    Element = 4u;
    InvalidDivide = 4u;
    InvalidShift = 4u;
    Reference = 4u;
    Storage = 4u;
    UnaryBinding = 7u;
    AddBinding = 5u;
    let _e67 = SameType;
    output[base] = _e67;
    let _e70 = Boolean;
    local_3 = u32((base + 1u));
    let _e75 = local_3;
    output[_e75] = _e70;
    let _e77 = Promoted;
    local_4 = u32((base + 2u));
    let _e82 = local_4;
    output[_e82] = _e77;
    let _e84 = BoolInt;
    local_5 = u32((base + 3u));
    let _e89 = local_5;
    output[_e89] = _e84;
    let _e91 = Real;
    local_6 = u32((base + 4u));
    let _e96 = local_6;
    output[_e96] = _e91;
    let _e98 = NestedMiddle;
    local_7 = u32((base + 5u));
    let _e103 = local_7;
    output[_e103] = _e98;
    let _e105 = NestedFinal;
    local_8 = u32((base + 6u));
    let _e110 = local_8;
    output[_e110] = _e105;
    let _e112 = Grouped;
    local_9 = u32((base + 7u));
    let _e117 = local_9;
    output[_e117] = _e112;
    let _e119 = Logical;
    local_10 = u32((base + 8u));
    let _e124 = local_10;
    output[_e124] = _e119;
    let _e126 = Row;
    local_11 = u32((base + 9u));
    let _e131 = local_11;
    output[_e131] = _e126;
    let _e133 = Element;
    local_12 = u32((base + 10u));
    let _e138 = local_12;
    output[_e138] = _e133;
    let _e140 = InvalidDivide;
    local_13 = u32((base + 11u));
    let _e145 = local_13;
    output[_e145] = _e140;
    let _e147 = InvalidShift;
    local_14 = u32((base + 12u));
    let _e152 = local_14;
    output[_e152] = _e147;
    let _e154 = Reference;
    local_15 = u32((base + 13u));
    let _e159 = local_15;
    output[_e159] = _e154;
    let _e161 = Storage;
    local_16 = u32((base + 14u));
    let _e166 = local_16;
    output[_e166] = _e161;
    let _e168 = UnaryBinding;
    local_17 = u32((base + 15u));
    let _e173 = local_17;
    output[_e173] = _e168;
    let _e175 = AddBinding;
    local_18 = u32((base + 16u));
    let _e180 = local_18;
    output[_e180] = _e175;
    let _e182 = cursor;
    local_19 = u32((base + 17u));
    let _e188 = local_19;
    output[_e188] = u32(_e182);
    local_20 = u32((base + 18u));
    let _e195 = local_20;
    output[_e195] = u32(seed);
    local_21 = u32((base + 19u));
    let _e202 = local_21;
    output[_e202] = u32(flag);
}
