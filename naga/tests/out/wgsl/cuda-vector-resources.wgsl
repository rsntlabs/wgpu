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
    var index: i32;
    var local_2: u32;
    var choose_first: bool;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: f32;
    var local_8: u32;
    var local_9: u32;
    var local_10: f32;
    var local_11: float3_;
    var pick_local: bool;
    var local_12: u32;
    var snapshot: float3_;
    var local_13: float3_;
    var local_14: float3_;
    var local_15: float3_;
    var local_16: f32;
    var local_17: f32;
    var local_18: f32;
    var local_19: f32;
    var local_20: float3_;
    var local_21: f32;
    var local_22: f32;
    var local_23: float3_;
    var local_24: float3_;
    var local_25: u32;
    var local_26: float3_;
    var local_27: u32;
    var local_28: float3_;
    var local_29: float3_;
    var local_30: u32;
    var local_31: f32;
    var local_32: u32;
    var local_33: f32;
    var local_34: u32;
    var local_35: f32;
    var local_36: u32;
    var local_37: f32;
    var local_38: float3_;
    var local_39: u32;
    var local_40: u32;
    var local_41: f32;
    var local_42: u32;
    var local_43: u32;
    var local_44: f32;
    var local_45: float3_;
    var local_46: u32;
    var local_47: float3_;

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
            local_25 = _e8;
            let _e10 = local_25;
            let _e13 = input[_e10];
            local_26 = _e13;
            let _e15 = local_26;
            local_13 = _e15;
            let _e17 = local_13;
            copied = _e17;
            let _e19 = copied;
            let _e20 = shift(_e19);
            let _e21 = i;
            local_1 = u32(_e21);
            let _e24 = local_1;
            local_27 = _e24;
            let _e26 = local_27;
            output[_e26] = _e20;
            continuing {
                let _e29 = i;
                i = (_e29 + 1i);
            }
        }
    }
    let _e36 = input[u32(0i)];
    local_28 = _e36;
    let _e38 = local_28;
    local_14 = _e38;
    let _e40 = local_14;
    output[u32(3i)] = _e40;
    let _e48 = input[u32(1i)];
    local_29 = _e48;
    let _e50 = local_29;
    local_15 = _e50;
    let _e52 = local_15;
    let _e53 = shift(_e52);
    output[u32(3i)].y = _e53.x;
    index = 0i;
    index = 1i;
    let _e66 = input[u32(2i)].x;
    let _e67 = index;
    index = (_e67 + 1i);
    local_2 = u32(_e67);
    let _e72 = local_2;
    output[_e72].x = _e66;
    let _e75 = index;
    let _e80 = input[u32(0i)].x;
    let _e85 = input[u32(1i)].x;
    output[u32(4i)] = float3_(f32(_e75), _e80, _e85);
    choose_first = true;
    let _e93 = choose_first;
    if _e93 {
        local_3 = u32(0i);
        let _e97 = local_3;
        local_30 = _e97;
        let _e99 = local_30;
        let _e102 = output[_e99].y;
        local_31 = _e102;
        let _e104 = local_31;
        local_16 = _e104;
        let _e106 = local_16;
        let _e109 = local_30;
        output[_e109].y = (_e106 + 2f);
    } else {
        local_4 = u32(2i);
        let _e115 = local_4;
        local_32 = _e115;
        let _e117 = local_32;
        let _e120 = output[_e117].y;
        local_33 = _e120;
        let _e122 = local_33;
        local_17 = _e122;
        let _e124 = local_17;
        let _e127 = local_32;
        output[_e127].y = (_e124 + 2f);
    }
    let _e130 = choose_first;
    if _e130 {
        local_5 = u32(0i);
        let _e134 = local_5;
        local_34 = _e134;
        let _e136 = local_34;
        let _e139 = output[_e136].z;
        local_35 = _e139;
        let _e141 = local_35;
        local_18 = _e141;
        let _e143 = local_18;
        let _e147 = local_34;
        output[_e147].z = (_e143 + f32(1i));
        local_7 = _e143;
    } else {
        local_6 = u32(2i);
        let _e154 = local_6;
        local_36 = _e154;
        let _e156 = local_36;
        let _e159 = output[_e156].z;
        local_37 = _e159;
        let _e161 = local_37;
        local_19 = _e161;
        let _e163 = local_19;
        let _e167 = local_36;
        output[_e167].z = (_e163 + f32(1i));
        local_7 = _e163;
    }
    let _e172 = local_7;
    output[u32(4i)].x = _e172;
    let _e177 = index;
    output[u32(4i)].z = f32(_e177);
    let _e186 = input[u32(1i)];
    local_38 = _e186;
    let _e188 = local_38;
    local_20 = _e188;
    let _e190 = local_20;
    let _e191 = choose_first;
    if _e191 {
        local_8 = u32(0i);
        let _e195 = local_8;
        local_39 = _e195;
        let _e197 = local_39;
        output[_e197] = _e190;
        let _e199 = local_8;
        local_40 = _e199;
        let _e201 = local_40;
        let _e204 = output[_e201].x;
        local_41 = _e204;
        let _e206 = local_41;
        local_21 = _e206;
        let _e208 = local_21;
        let _e212 = local_40;
        output[_e212].x = (_e208 + f32(1i));
        local_10 = _e208;
    } else {
        local_9 = u32(2i);
        let _e219 = local_9;
        local_42 = _e219;
        let _e221 = local_42;
        output[_e221] = _e190;
        let _e223 = local_9;
        local_43 = _e223;
        let _e225 = local_43;
        let _e228 = output[_e225].x;
        local_44 = _e228;
        let _e230 = local_44;
        local_22 = _e230;
        let _e232 = local_22;
        let _e236 = local_43;
        output[_e236].x = (_e232 + f32(1i));
        local_10 = _e232;
    }
    let _e243 = output[u32(0i)];
    local_45 = _e243;
    let _e245 = local_45;
    local_23 = _e245;
    let _e247 = local_23;
    output[u32(5i)] = _e247;
    local_11 = float3_(f32(20i), f32(30i), f32(40i));
    pick_local = false;
    pick_local = true;
    let _e262 = pick_local;
    if _e262 {
        local_11.z = 7f;
    } else {
        local_12 = u32(1i);
        let _e268 = local_12;
        local_46 = _e268;
        let _e270 = local_46;
        output[_e270].z = 7f;
    }
    let _e274 = local_11;
    output[u32(6i)] = _e274;
    let _e282 = output[u32(1i)].z;
    output[u32(6i)].x = _e282;
    let _e291 = output[u32(0i)].x;
    let _e296 = output[u32(1i)].x;
    let _e301 = output[u32(2i)].x;
    output[u32(7i)] = float3_(_e291, _e296, _e301);
    let _e309 = input[u32(0i)];
    local_47 = _e309;
    let _e311 = local_47;
    local_24 = _e311;
    let _e313 = local_24;
    snapshot = _e313;
    let _e315 = snapshot;
    snapshot.x = 9f;
    let _e319 = pair(_e315, 4i);
    let _e321 = snapshot.x;
    let _e326 = input[u32(2i)].z;
    output[u32(8i)] = float3_(_e319, _e321, _e326);
}
