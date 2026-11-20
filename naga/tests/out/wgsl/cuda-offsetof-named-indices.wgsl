const RowIndex: u32 = 1u;
const ColumnIndex: i32 = 2i;

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

fn selected_offset_0u() -> u32 {
    var offset: u32;

    offset = 16u;
    let _e2 = offset;
    return _e2;
}

fn selected_offset_1u() -> u32 {
    var offset_1: u32;

    offset_1 = 32u;
    let _e2 = offset_1;
    return _e2;
}

@compute @workgroup_size(4, 1, 1)
fn named_offsets(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var cursor: i32;
    var LocalColumn: u32;
    var LocalRow: i32;
    var Zero: u32;
    var LastRow: bool;
    var Global: u32;
    var Local: u32;
    var Mixed: u32;
    var ZeroIndex: u32;
    var BoolIndex: u32;
    var Macro: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;

    let lane = threadIdx.x;
    let base = (4u + (lane * 10u));
    cursor = 7i;
    LocalColumn = 1u;
    LocalRow = 1i;
    Zero = 0u;
    LastRow = true;
    Global = 56u;
    Local = 52u;
    Mixed = 28u;
    ZeroIndex = 8u;
    BoolIndex = 48u;
    Macro = 56u;
    let _e28 = Global;
    output[base] = _e28;
    let _e31 = Local;
    local = u32((base + 1u));
    let _e36 = local;
    output[_e36] = _e31;
    let _e38 = Mixed;
    local_1 = u32((base + 2u));
    let _e43 = local_1;
    output[_e43] = _e38;
    let _e45 = ZeroIndex;
    local_2 = u32((base + 3u));
    let _e50 = local_2;
    output[_e50] = _e45;
    let _e52 = BoolIndex;
    local_3 = u32((base + 4u));
    let _e57 = local_3;
    output[_e57] = _e52;
    let _e59 = Macro;
    local_4 = u32((base + 5u));
    let _e64 = local_4;
    output[_e64] = _e59;
    let _e66 = selected_offset_0u();
    local_5 = u32((base + 6u));
    let _e71 = local_5;
    output[_e71] = _e66;
    let _e73 = selected_offset_1u();
    local_6 = u32((base + 7u));
    let _e78 = local_6;
    output[_e78] = _e73;
    let _e80 = cursor;
    local_7 = u32((base + 8u));
    let _e86 = local_7;
    output[_e86] = u32(_e80);
    local_8 = u32((base + 9u));
    let _e92 = local_8;
    output[_e92] = lane;
}
