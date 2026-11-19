struct Record_cuda_record_0_ {
    first: i32,
    second: u32,
    third: f32,
}

@group(0) @binding(0)
var<storage> input: array<i32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

@compute @workgroup_size(4, 1, 1)
fn sizeof_comma(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var counter: i32;
    var matrix: array<array<i32, 3>, 2>;
    var local: u32;
    var local_1: u32;
    var record: Record_cuda_record_0_;
    var Scalar: u32;
    var Boolean: u32;
    var Array: u32;
    var Row: u32;
    var Element: u32;
    var Member: u32;
    var Pointer: u32;
    var Null: u32;
    var Middle: u32;
    var Outer: u32;
    var Nested: u32;
    var NoRead: u32;
    var InvalidMath: u32;
    var NullArm: u32;
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
    let flag = (seed != 0i);
    counter = 7i;
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
            matrix[_e15][_e22] = i32();
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
    record = Record_cuda_record_0_();
    Scalar = 4u;
    Boolean = 1u;
    Array = 24u;
    Row = 12u;
    Element = 4u;
    Member = 4u;
    Pointer = 8u;
    Null = 8u;
    Middle = 1u;
    Outer = 1u;
    Nested = 1u;
    NoRead = 4u;
    InvalidMath = 1u;
    NullArm = 8u;
    let _e63 = Scalar;
    output[base] = _e63;
    let _e66 = Boolean;
    local_2 = u32((base + 1u));
    let _e71 = local_2;
    output[_e71] = _e66;
    let _e73 = Array;
    local_3 = u32((base + 2u));
    let _e78 = local_3;
    output[_e78] = _e73;
    let _e80 = Row;
    local_4 = u32((base + 3u));
    let _e85 = local_4;
    output[_e85] = _e80;
    let _e87 = Element;
    local_5 = u32((base + 4u));
    let _e92 = local_5;
    output[_e92] = _e87;
    let _e94 = Member;
    local_6 = u32((base + 5u));
    let _e99 = local_6;
    output[_e99] = _e94;
    let _e101 = Pointer;
    local_7 = u32((base + 6u));
    let _e106 = local_7;
    output[_e106] = _e101;
    let _e108 = Null;
    local_8 = u32((base + 7u));
    let _e113 = local_8;
    output[_e113] = _e108;
    let _e115 = Middle;
    local_9 = u32((base + 8u));
    let _e120 = local_9;
    output[_e120] = _e115;
    let _e122 = Outer;
    local_10 = u32((base + 9u));
    let _e127 = local_10;
    output[_e127] = _e122;
    let _e129 = Nested;
    local_11 = u32((base + 10u));
    let _e134 = local_11;
    output[_e134] = _e129;
    let _e136 = NoRead;
    local_12 = u32((base + 11u));
    let _e141 = local_12;
    output[_e141] = _e136;
    let _e143 = InvalidMath;
    local_13 = u32((base + 12u));
    let _e148 = local_13;
    output[_e148] = _e143;
    let _e150 = NullArm;
    local_14 = u32((base + 13u));
    let _e155 = local_14;
    output[_e155] = _e150;
    let _e157 = counter;
    local_15 = u32((base + 14u));
    let _e163 = local_15;
    output[_e163] = u32(_e157);
    let _e166 = input[lane];
    local_16 = u32((base + 15u));
    let _e172 = local_16;
    output[_e172] = u32(_e166);
}
