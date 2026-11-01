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
    var local_12: i32;
    var local_13: array<i32, 3>;
    var total: i32;
    var i_1: i32;

    runtime_1 = runtime;
    Size_1 = 3i;
    local_13 = array<i32, 3>();
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
            local_13[_e16] = (_e18 + _e19);
            let _e21 = i_1;
            let _e23 = local_13[_e21];
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
    var Chosen: i32;
    var local: i32;
    var Size: i32;
    var values: array<i32, 5>;
    var SignedHigh: i32;
    var local_1: u32;
    var Negative: i32;
    var local_2: u32;
    var All: u32;
    var Wrapped: u32;
    var local_3: u32;
    var TruncatedZero: u32;
    var Minimum: i32;
    var Large: u32;
    var Ready: bool;
    var Comma: i32;
    var Lazy: i32;
    var local_4: i32;
    var Skipped: bool;
    var local_5: bool;
    var Yes: bool;
    var local_6: bool;
    var VectorCount: i32;
    var vectors: array<float3_, 2>;
    var Base: array<i32, 2>;
    var local_7: u32;
    var i: i32;
    var Count: i32;
    var scratch: array<i32, 3>;
    var local_8: u32;
    var Safe: i32;
    var local_9: i32;
    var local_10: u32;
    var local_11: u32;

    let runtime_2 = input[u32(0i)];
    Chosen = 3i;
    Size = 4i;
    values = array<i32, 5>();
    values[0i] = runtime_2;
    let _e16 = input[u32(1i)];
    let _e17 = Size;
    values[_e17] = _e16;
    out[u32(0i)] = u32(Base_1);
    out[u32(1i)] = High;
    out[u32(2i)] = bitcast<u32>(Scale);
    let _e34 = Chosen;
    out[u32(3i)] = u32(_e34);
    let _e39 = accumulate(runtime_2);
    out[u32(4i)] = u32(_e39);
    let _e44 = Size;
    let _e46 = values[_e44];
    out[u32(5i)] = u32(_e46);
    let _e53 = values[1i];
    out[u32(6i)] = u32(_e53);
    out[u32(7i)] = u32((f32(runtime_2) * Scale));
    SignedHigh = i32(-2147483648);
    Negative = -2i;
    All = 4294967295u;
    Wrapped = 0u;
    let _e73 = SignedHigh;
    out[u32(8i)] = u32(_e73);
    let _e78 = Negative;
    out[u32(9i)] = u32(_e78);
    let _e83 = All;
    out[u32(10i)] = _e83;
    let _e87 = Wrapped;
    out[u32(11i)] = _e87;
    TruncatedZero = 0u;
    Minimum = i32(-2147483648);
    Large = 4294967040u;
    Ready = true;
    let _e99 = TruncatedZero;
    out[u32(12i)] = _e99;
    let _e103 = Minimum;
    out[u32(13i)] = u32(_e103);
    let _e108 = Large;
    out[u32(14i)] = _e108;
    let _e112 = Ready;
    out[u32(15i)] = u32(_e112);
    Comma = 4i;
    Lazy = 6i;
    let _e121 = Comma;
    out[u32(16i)] = u32(_e121);
    let _e126 = Lazy;
    out[u32(17i)] = u32(_e126);
    out[u32(18i)] = u32(runtime_2);
    Skipped = false;
    Yes = true;
    let _e139 = Skipped;
    out[u32(19i)] = u32(_e139);
    let _e144 = Yes;
    out[u32(20i)] = u32(_e144);
    out[u32(21i)] = u32(runtime_2);
    VectorCount = 2i;
    vectors = array<float3_, 2>();
    let _e160 = input[u32(1i)];
    vectors[1i].y = f32(_e160);
    let _e168 = vectors[1i].y;
    out[u32(22i)] = u32(_e168);
    {
        Base = array<i32, 2>();
        let _e177 = Base[1i];
        local_7 = u32(23i);
        let _e182 = local_7;
        local_10 = _e182;
        let _e184 = local_10;
        out[_e184] = u32(_e177);
    }
    {
        i = 0i;
        loop {
            let _e188 = i;
            if (_e188 < 3i) {
            } else {
                break;
            }
            Count = 3i;
            scratch = array<i32, 3>();
            let _e197 = scratch[2i];
            let _e199 = i;
            local_8 = u32((24i + _e199));
            let _e204 = local_8;
            local_11 = _e204;
            let _e206 = local_11;
            out[_e206] = u32(_e197);
            let _e208 = i;
            scratch[2i] = (runtime_2 + _e208);
            continuing {
                let _e212 = i;
                i = (_e212 + 1i);
            }
        }
    }
    let _e218 = input[u32(1i)];
    let _e219 = accumulate(_e218);
    out[u32(27i)] = u32(_e219);
    out[u32(28i)] = u32(Second);
    Safe = 3i;
    let _e234 = input[u32(1i)];
    let _e236 = Safe;
    out[u32(29i)] = u32((((runtime_2 + _e234) + _e236) - 3i));
}
