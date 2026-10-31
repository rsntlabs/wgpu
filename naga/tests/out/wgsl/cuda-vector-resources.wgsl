struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

@group(0) @binding(0)
var<storage> input: array<float3_>;
@group(0) @binding(1)
var<storage, read_write> output: array<float3_>;

fn shift(value: float3_) -> float3_ {
    var value_1: float3_;

    value_1 = value;
    let _e4 = value_1.x;
    value_1.x = (_e4 + 1f);
    let _e9 = value_1.y;
    let _e10 = value_1.z;
    value_1.z = (_e9 + _e10);
    let _e12 = value_1;
    return _e12;
}

fn pair(value_2: float3_, digit: i32) -> f32 {
    var value_3: float3_;

    value_3 = value_2;
    let _e4 = value_3.x;
    return ((_e4 * 10f) + f32(digit));
}

@compute @workgroup_size(1, 1, 1)
fn vector_resources() {
    var i: i32;
    var copied: float3_;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var index: i32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var choose_first: bool;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: f32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: f32;
    var local_22: u32;
    var local_23: u32;
    var local_24: float3_;
    var pick_local: bool;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var snapshot: float3_;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: float3_;
    var local_37: float3_;
    var local_38: float3_;
    var local_39: f32;
    var local_40: f32;
    var local_41: f32;
    var local_42: f32;
    var local_43: float3_;
    var local_44: f32;
    var local_45: f32;
    var local_46: float3_;
    var local_47: float3_;
    var local_48: u32;
    var local_49: float3_;
    var local_50: u32;
    var local_51: float3_;
    var local_52: float3_;
    var local_53: u32;
    var local_54: f32;
    var local_55: u32;
    var local_56: f32;
    var local_57: u32;
    var local_58: f32;
    var local_59: u32;
    var local_60: f32;
    var local_61: float3_;
    var local_62: u32;
    var local_63: u32;
    var local_64: f32;
    var local_65: u32;
    var local_66: u32;
    var local_67: f32;
    var local_68: float3_;
    var local_69: u32;
    var local_70: float3_;

    {
        i = 0i;
        loop {
            let _e2 = i;
            if (_e2 < 3i) {
            } else {
                break;
            }
            let _e5 = i;
            local = u32(_e5);
            let _e8 = local;
            local_48 = _e8;
            let _e10 = local_48;
            let _e13 = input[_e10];
            local_49 = _e13;
            let _e15 = local_49;
            local_36 = _e15;
            let _e17 = local_36;
            copied = _e17;
            let _e19 = copied;
            let _e20 = shift(_e19);
            let _e21 = i;
            local_1 = u32(_e21);
            let _e24 = local_1;
            local_50 = _e24;
            let _e26 = local_50;
            output[_e26] = _e20;
            continuing {
                let _e29 = i;
                i = (_e29 + 1i);
            }
        }
    }
    local_3 = u32(0i);
    let _e35 = local_3;
    let _e38 = input[_e35];
    local_51 = _e38;
    let _e40 = local_51;
    local_37 = _e40;
    let _e42 = local_37;
    local_2 = u32(3i);
    let _e46 = local_2;
    output[_e46] = _e42;
    local_5 = u32(1i);
    let _e52 = local_5;
    let _e54 = input[_e52];
    local_52 = _e54;
    let _e56 = local_52;
    local_38 = _e56;
    let _e58 = local_38;
    let _e59 = shift(_e58);
    local_4 = u32(3i);
    let _e64 = local_4;
    output[_e64].y = _e59.x;
    index = 0i;
    index = 1i;
    local_7 = u32(2i);
    let _e73 = local_7;
    let _e76 = input[_e73].x;
    let _e77 = index;
    index = (_e77 + 1i);
    local_6 = u32(_e77);
    let _e82 = local_6;
    output[_e82].x = _e76;
    let _e85 = index;
    local_9 = u32(0i);
    let _e89 = local_9;
    let _e92 = input[_e89].x;
    local_10 = u32(1i);
    let _e96 = local_10;
    let _e99 = input[_e96].x;
    local_8 = u32(4i);
    let _e105 = local_8;
    output[_e105] = float3_(f32(_e85), _e92, _e99);
    choose_first = true;
    let _e109 = choose_first;
    if _e109 {
        local_11 = u32(0i);
        let _e113 = local_11;
        local_53 = _e113;
        let _e115 = local_53;
        let _e118 = output[_e115].y;
        local_54 = _e118;
        let _e120 = local_54;
        local_39 = _e120;
        let _e122 = local_39;
        let _e125 = local_53;
        output[_e125].y = (_e122 + 2f);
    } else {
        local_12 = u32(2i);
        let _e131 = local_12;
        local_55 = _e131;
        let _e133 = local_55;
        let _e136 = output[_e133].y;
        local_56 = _e136;
        let _e138 = local_56;
        local_40 = _e138;
        let _e140 = local_40;
        let _e143 = local_55;
        output[_e143].y = (_e140 + 2f);
    }
    let _e146 = choose_first;
    if _e146 {
        local_14 = u32(0i);
        let _e150 = local_14;
        local_57 = _e150;
        let _e152 = local_57;
        let _e155 = output[_e152].z;
        local_58 = _e155;
        let _e157 = local_58;
        local_41 = _e157;
        let _e159 = local_41;
        let _e163 = local_57;
        output[_e163].z = (_e159 + f32(1i));
        local_16 = _e159;
    } else {
        local_15 = u32(2i);
        let _e170 = local_15;
        local_59 = _e170;
        let _e172 = local_59;
        let _e175 = output[_e172].z;
        local_60 = _e175;
        let _e177 = local_60;
        local_42 = _e177;
        let _e179 = local_42;
        let _e183 = local_59;
        output[_e183].z = (_e179 + f32(1i));
        local_16 = _e179;
    }
    let _e188 = local_16;
    local_13 = u32(4i);
    let _e192 = local_13;
    output[_e192].x = _e188;
    let _e195 = index;
    local_17 = u32(4i);
    let _e200 = local_17;
    output[_e200].z = f32(_e195);
    local_20 = u32(1i);
    let _e206 = local_20;
    let _e208 = input[_e206];
    local_61 = _e208;
    let _e210 = local_61;
    local_43 = _e210;
    let _e212 = local_43;
    let _e213 = choose_first;
    if _e213 {
        local_18 = u32(0i);
        let _e217 = local_18;
        local_62 = _e217;
        let _e219 = local_62;
        output[_e219] = _e212;
        let _e221 = local_18;
        local_63 = _e221;
        let _e223 = local_63;
        let _e226 = output[_e223].x;
        local_64 = _e226;
        let _e228 = local_64;
        local_44 = _e228;
        let _e230 = local_44;
        let _e234 = local_63;
        output[_e234].x = (_e230 + f32(1i));
        local_21 = _e230;
    } else {
        local_19 = u32(2i);
        let _e241 = local_19;
        local_65 = _e241;
        let _e243 = local_65;
        output[_e243] = _e212;
        let _e245 = local_19;
        local_66 = _e245;
        let _e247 = local_66;
        let _e250 = output[_e247].x;
        local_67 = _e250;
        let _e252 = local_67;
        local_45 = _e252;
        let _e254 = local_45;
        let _e258 = local_66;
        output[_e258].x = (_e254 + f32(1i));
        local_21 = _e254;
    }
    local_23 = u32(0i);
    let _e265 = local_23;
    let _e267 = output[_e265];
    local_68 = _e267;
    let _e269 = local_68;
    local_46 = _e269;
    let _e271 = local_46;
    local_22 = u32(5i);
    let _e275 = local_22;
    output[_e275] = _e271;
    local_24 = float3_(f32(20i), f32(30i), f32(40i));
    pick_local = false;
    pick_local = true;
    let _e288 = pick_local;
    if _e288 {
        local_24.z = 7f;
    } else {
        local_25 = u32(1i);
        let _e294 = local_25;
        local_69 = _e294;
        let _e296 = local_69;
        output[_e296].z = 7f;
    }
    let _e300 = local_24;
    local_26 = u32(6i);
    let _e304 = local_26;
    output[_e304] = _e300;
    local_28 = u32(1i);
    let _e309 = local_28;
    let _e312 = output[_e309].z;
    local_27 = u32(6i);
    let _e316 = local_27;
    output[_e316].x = _e312;
    local_30 = u32(0i);
    let _e322 = local_30;
    let _e325 = output[_e322].x;
    local_31 = u32(1i);
    let _e329 = local_31;
    let _e332 = output[_e329].x;
    local_32 = u32(2i);
    let _e336 = local_32;
    let _e339 = output[_e336].x;
    local_29 = u32(7i);
    let _e344 = local_29;
    output[_e344] = float3_(_e325, _e332, _e339);
    local_33 = u32(0i);
    let _e349 = local_33;
    let _e351 = input[_e349];
    local_70 = _e351;
    let _e353 = local_70;
    local_47 = _e353;
    let _e355 = local_47;
    snapshot = _e355;
    let _e357 = snapshot;
    snapshot.x = 9f;
    let _e361 = pair(_e357, 4i);
    let _e363 = snapshot.x;
    local_35 = u32(2i);
    let _e367 = local_35;
    let _e370 = input[_e367].z;
    local_34 = u32(8i);
    let _e375 = local_34;
    output[_e375] = float3_(_e361, _e363, _e370);
}
