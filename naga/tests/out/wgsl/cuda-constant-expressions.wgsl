struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

const Base_1: i32 = 2i;
const High: u32 = 2147483648u;
const Scale: f32 = 0.5f;
const Second: i32 = 3i;
const After: i32 = 4i;

@group(0) @binding(0)
var<storage> input: array<i32>;
@group(0) @binding(1)
var<storage, read_write> out: array<u32>;

fn accumulate(runtime: i32) -> i32 {
    var runtime_1: i32;
    var Size_1: i32;
    var local_43: i32;
    var local_44: array<i32, 3>;
    var total: i32;
    var i_1: i32;

    runtime_1 = runtime;
    Size_1 = 3i;
    local_44 = array<i32, 3>();
    total = 0i;
    {
        i_1 = 0i;
        loop {
            let _e10 = i_1;
            let _e11 = Size_1;
            if (_e10 < _e11) {
            } else {
                break;
            }
            let _e18 = runtime_1;
            let _e19 = i_1;
            let _e16 = i_1;
            local_44[_e16] = (_e18 + _e19);
            let _e21 = i_1;
            let _e23 = local_44[_e21];
            let _e24 = total;
            total = (_e24 + _e23);
            continuing {
                let _e13 = i_1;
                i_1 = (_e13 + 1i);
            }
        }
    }
    let _e26 = total;
    return _e26;
}

@compute @workgroup_size(1, 1, 1)
fn constant_expressions() {
    var local: u32;
    var Chosen: i32;
    var local_1: i32;
    var Size: i32;
    var values: array<i32, 5>;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var SignedHigh: i32;
    var local_11: u32;
    var Negative: i32;
    var local_12: u32;
    var All: u32;
    var Wrapped: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var TruncatedZero: u32;
    var Minimum: i32;
    var Large: u32;
    var Ready: bool;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var Comma: i32;
    var Lazy: i32;
    var local_22: i32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var Skipped: bool;
    var local_26: bool;
    var Yes: bool;
    var local_27: bool;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var VectorCount: i32;
    var vectors: array<float3_, 2>;
    var local_31: u32;
    var local_32: u32;
    var Base: array<i32, 2>;
    var local_33: u32;
    var i: i32;
    var Count: i32;
    var scratch: array<i32, 3>;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var Safe: i32;
    var local_38: i32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;

    local = u32(0i);
    let _e3 = local;
    let runtime_2 = input[_e3];
    Chosen = 3i;
    Size = 4i;
    values = array<i32, 5>();
    values[0i] = runtime_2;
    local_2 = u32(1i);
    let _e18 = local_2;
    let _e20 = input[_e18];
    let _e21 = Size;
    values[_e21] = _e20;
    local_3 = u32(0i);
    let _e28 = local_3;
    out[_e28] = u32(Base_1);
    local_4 = u32(1i);
    let _e34 = local_4;
    out[_e34] = High;
    local_5 = u32(2i);
    let _e42 = local_5;
    out[_e42] = bitcast<u32>(Scale);
    let _e44 = Chosen;
    local_6 = u32(3i);
    let _e49 = local_6;
    out[_e49] = u32(_e44);
    let _e51 = accumulate(runtime_2);
    local_7 = u32(4i);
    let _e56 = local_7;
    out[_e56] = u32(_e51);
    let _e58 = Size;
    let _e60 = values[_e58];
    local_8 = u32(5i);
    let _e65 = local_8;
    out[_e65] = u32(_e60);
    let _e69 = values[1i];
    local_9 = u32(6i);
    let _e74 = local_9;
    out[_e74] = u32(_e69);
    local_10 = u32(7i);
    let _e83 = local_10;
    out[_e83] = u32((f32(runtime_2) * Scale));
    SignedHigh = i32(-2147483648);
    Negative = -2i;
    All = 4294967295u;
    Wrapped = 0u;
    let _e93 = SignedHigh;
    local_14 = u32(8i);
    let _e98 = local_14;
    out[_e98] = u32(_e93);
    let _e100 = Negative;
    local_15 = u32(9i);
    let _e105 = local_15;
    out[_e105] = u32(_e100);
    let _e107 = All;
    local_16 = u32(10i);
    let _e111 = local_16;
    out[_e111] = _e107;
    let _e113 = Wrapped;
    local_17 = u32(11i);
    let _e117 = local_17;
    out[_e117] = _e113;
    TruncatedZero = 0u;
    Minimum = i32(-2147483648);
    Large = 4294967040u;
    Ready = true;
    let _e127 = TruncatedZero;
    local_18 = u32(12i);
    let _e131 = local_18;
    out[_e131] = _e127;
    let _e133 = Minimum;
    local_19 = u32(13i);
    let _e138 = local_19;
    out[_e138] = u32(_e133);
    let _e140 = Large;
    local_20 = u32(14i);
    let _e144 = local_20;
    out[_e144] = _e140;
    let _e146 = Ready;
    local_21 = u32(15i);
    let _e151 = local_21;
    out[_e151] = u32(_e146);
    Comma = 4i;
    Lazy = 6i;
    let _e157 = Comma;
    local_23 = u32(16i);
    let _e162 = local_23;
    out[_e162] = u32(_e157);
    let _e164 = Lazy;
    local_24 = u32(17i);
    let _e169 = local_24;
    out[_e169] = u32(_e164);
    local_25 = u32(18i);
    let _e175 = local_25;
    out[_e175] = u32(runtime_2);
    Skipped = false;
    Yes = true;
    let _e181 = Skipped;
    local_28 = u32(19i);
    let _e186 = local_28;
    out[_e186] = u32(_e181);
    let _e188 = Yes;
    local_29 = u32(20i);
    let _e193 = local_29;
    out[_e193] = u32(_e188);
    local_30 = u32(21i);
    let _e199 = local_30;
    out[_e199] = u32(runtime_2);
    VectorCount = 2i;
    vectors = array<float3_, 2>();
    local_31 = u32(1i);
    let _e208 = local_31;
    let _e210 = input[_e208];
    vectors[1i].y = f32(_e210);
    let _e218 = vectors[1i].y;
    local_32 = u32(22i);
    let _e223 = local_32;
    out[_e223] = u32(_e218);
    {
        Base = array<i32, 2>();
        let _e229 = Base[1i];
        local_33 = u32(23i);
        let _e234 = local_33;
        local_41 = _e234;
        let _e236 = local_41;
        out[_e236] = u32(_e229);
    }
    {
        i = 0i;
        loop {
            let _e240 = i;
            if (_e240 < 3i) {
            } else {
                break;
            }
            Count = 3i;
            scratch = array<i32, 3>();
            let _e249 = scratch[2i];
            let _e251 = i;
            local_34 = u32((24i + _e251));
            let _e256 = local_34;
            local_42 = _e256;
            let _e258 = local_42;
            out[_e258] = u32(_e249);
            let _e260 = i;
            scratch[2i] = (runtime_2 + _e260);
            continuing {
                let _e264 = i;
                i = (_e264 + 1i);
            }
        }
    }
    local_36 = u32(1i);
    let _e270 = local_36;
    let _e272 = input[_e270];
    let _e273 = accumulate(_e272);
    local_35 = u32(27i);
    let _e278 = local_35;
    out[_e278] = u32(_e273);
    local_37 = u32(28i);
    let _e285 = local_37;
    out[_e285] = u32(Second);
    Safe = 3i;
    local_40 = u32(1i);
    let _e292 = local_40;
    let _e294 = input[_e292];
    let _e296 = Safe;
    local_39 = u32(29i);
    let _e304 = local_39;
    out[_e304] = u32((((runtime_2 + _e294) + _e296) - 3i));
}
