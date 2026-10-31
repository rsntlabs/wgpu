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
    var local_74: i32;
    var local_75: array<i32, 3>;
    var total: i32;
    var i_1: i32;

    runtime_1 = runtime;
    Size_1 = 3i;
    local_75 = array<i32, 3>();
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
            local_75[_e16] = (_e18 + _e19);
            let _e21 = i_1;
            let _e23 = local_75[_e21];
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
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;
    var local_66: u32;
    var local_67: u32;
    var local_68: u32;
    var local_69: u32;
    var local_70: u32;
    var local_71: u32;
    var local_72: u32;
    var local_73: u32;

    local = u32(0i);
    let _e3 = local;
    local_41 = u32(_e3);
    let _e6 = local_41;
    let runtime_2 = input[_e6];
    Chosen = 3i;
    Size = 4i;
    values = array<i32, 5>();
    values[0i] = runtime_2;
    local_2 = u32(1i);
    let _e21 = local_2;
    local_42 = u32(_e21);
    let _e24 = local_42;
    let _e26 = input[_e24];
    let _e27 = Size;
    values[_e27] = _e26;
    local_3 = u32(0i);
    let _e34 = local_3;
    local_43 = u32(_e34);
    let _e37 = local_43;
    out[_e37] = u32(Base_1);
    local_4 = u32(1i);
    let _e43 = local_4;
    local_44 = u32(_e43);
    let _e46 = local_44;
    out[_e46] = High;
    local_5 = u32(2i);
    let _e54 = local_5;
    local_45 = u32(_e54);
    let _e57 = local_45;
    out[_e57] = bitcast<u32>(Scale);
    let _e59 = Chosen;
    local_6 = u32(3i);
    let _e64 = local_6;
    local_46 = u32(_e64);
    let _e67 = local_46;
    out[_e67] = u32(_e59);
    let _e69 = accumulate(runtime_2);
    local_7 = u32(4i);
    let _e74 = local_7;
    local_47 = u32(_e74);
    let _e77 = local_47;
    out[_e77] = u32(_e69);
    let _e79 = Size;
    let _e81 = values[_e79];
    local_8 = u32(5i);
    let _e86 = local_8;
    local_48 = u32(_e86);
    let _e89 = local_48;
    out[_e89] = u32(_e81);
    let _e93 = values[1i];
    local_9 = u32(6i);
    let _e98 = local_9;
    local_49 = u32(_e98);
    let _e101 = local_49;
    out[_e101] = u32(_e93);
    local_10 = u32(7i);
    let _e110 = local_10;
    local_50 = u32(_e110);
    let _e113 = local_50;
    out[_e113] = u32((f32(runtime_2) * Scale));
    SignedHigh = i32(-2147483648);
    Negative = -2i;
    All = 4294967295u;
    Wrapped = 0u;
    let _e123 = SignedHigh;
    local_14 = u32(8i);
    let _e128 = local_14;
    local_51 = u32(_e128);
    let _e131 = local_51;
    out[_e131] = u32(_e123);
    let _e133 = Negative;
    local_15 = u32(9i);
    let _e138 = local_15;
    local_52 = u32(_e138);
    let _e141 = local_52;
    out[_e141] = u32(_e133);
    let _e143 = All;
    local_16 = u32(10i);
    let _e147 = local_16;
    local_53 = u32(_e147);
    let _e150 = local_53;
    out[_e150] = _e143;
    let _e152 = Wrapped;
    local_17 = u32(11i);
    let _e156 = local_17;
    local_54 = u32(_e156);
    let _e159 = local_54;
    out[_e159] = _e152;
    TruncatedZero = 0u;
    Minimum = i32(-2147483648);
    Large = 4294967040u;
    Ready = true;
    let _e169 = TruncatedZero;
    local_18 = u32(12i);
    let _e173 = local_18;
    local_55 = u32(_e173);
    let _e176 = local_55;
    out[_e176] = _e169;
    let _e178 = Minimum;
    local_19 = u32(13i);
    let _e183 = local_19;
    local_56 = u32(_e183);
    let _e186 = local_56;
    out[_e186] = u32(_e178);
    let _e188 = Large;
    local_20 = u32(14i);
    let _e192 = local_20;
    local_57 = u32(_e192);
    let _e195 = local_57;
    out[_e195] = _e188;
    let _e197 = Ready;
    local_21 = u32(15i);
    let _e202 = local_21;
    local_58 = u32(_e202);
    let _e205 = local_58;
    out[_e205] = u32(_e197);
    Comma = 4i;
    Lazy = 6i;
    let _e211 = Comma;
    local_23 = u32(16i);
    let _e216 = local_23;
    local_59 = u32(_e216);
    let _e219 = local_59;
    out[_e219] = u32(_e211);
    let _e221 = Lazy;
    local_24 = u32(17i);
    let _e226 = local_24;
    local_60 = u32(_e226);
    let _e229 = local_60;
    out[_e229] = u32(_e221);
    local_25 = u32(18i);
    let _e235 = local_25;
    local_61 = u32(_e235);
    let _e238 = local_61;
    out[_e238] = u32(runtime_2);
    Skipped = false;
    Yes = true;
    let _e244 = Skipped;
    local_28 = u32(19i);
    let _e249 = local_28;
    local_62 = u32(_e249);
    let _e252 = local_62;
    out[_e252] = u32(_e244);
    let _e254 = Yes;
    local_29 = u32(20i);
    let _e259 = local_29;
    local_63 = u32(_e259);
    let _e262 = local_63;
    out[_e262] = u32(_e254);
    local_30 = u32(21i);
    let _e268 = local_30;
    local_64 = u32(_e268);
    let _e271 = local_64;
    out[_e271] = u32(runtime_2);
    VectorCount = 2i;
    vectors = array<float3_, 2>();
    local_31 = u32(1i);
    let _e280 = local_31;
    local_65 = u32(_e280);
    let _e283 = local_65;
    let _e285 = input[_e283];
    vectors[1i].y = f32(_e285);
    let _e293 = vectors[1i].y;
    local_32 = u32(22i);
    let _e298 = local_32;
    local_66 = u32(_e298);
    let _e301 = local_66;
    out[_e301] = u32(_e293);
    {
        Base = array<i32, 2>();
        let _e307 = Base[1i];
        local_33 = u32(23i);
        let _e312 = local_33;
        local_67 = u32(_e312);
        let _e315 = local_67;
        out[_e315] = u32(_e307);
    }
    {
        i = 0i;
        loop {
            let _e319 = i;
            if (_e319 < 3i) {
            } else {
                break;
            }
            Count = 3i;
            scratch = array<i32, 3>();
            let _e328 = scratch[2i];
            let _e330 = i;
            local_34 = u32((24i + _e330));
            let _e335 = local_34;
            local_68 = u32(_e335);
            let _e338 = local_68;
            out[_e338] = u32(_e328);
            let _e340 = i;
            scratch[2i] = (runtime_2 + _e340);
            continuing {
                let _e344 = i;
                i = (_e344 + 1i);
            }
        }
    }
    local_36 = u32(1i);
    let _e350 = local_36;
    local_69 = u32(_e350);
    let _e353 = local_69;
    let _e355 = input[_e353];
    let _e356 = accumulate(_e355);
    local_35 = u32(27i);
    let _e361 = local_35;
    local_70 = u32(_e361);
    let _e364 = local_70;
    out[_e364] = u32(_e356);
    local_37 = u32(28i);
    let _e371 = local_37;
    local_71 = u32(_e371);
    let _e374 = local_71;
    out[_e374] = u32(Second);
    Safe = 3i;
    local_40 = u32(1i);
    let _e381 = local_40;
    local_72 = u32(_e381);
    let _e384 = local_72;
    let _e386 = input[_e384];
    let _e388 = Safe;
    local_39 = u32(29i);
    let _e396 = local_39;
    local_73 = u32(_e396);
    let _e399 = local_73;
    out[_e399] = u32((((runtime_2 + _e386) + _e388) - 3i));
}
