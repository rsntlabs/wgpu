struct int3_ {
    x: i32,
    y: i32,
    z: i32,
}

struct uint3_ {
    x: u32,
    y: u32,
    z: u32,
}

struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
var<workgroup> shared_values: array<array<i32, 3>, 2>;
var<workgroup> shared_points: array<array<float3_, 2>, 2>;

@compute @workgroup_size(1, 1, 1)
fn multidimensional_arrays() {
    var original: vec2<i32>;
    var points: array<array<vec2<i32>, 2>, 2>;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var original_1: int3_;
    var points_1: array<array<int3_, 2>, 2>;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var original_2: vec4<i32>;
    var points_2: array<array<vec4<i32>, 2>, 2>;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var original_3: vec2<u32>;
    var points_3: array<array<vec2<u32>, 2>, 2>;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var original_4: uint3_;
    var points_4: array<array<uint3_, 2>, 2>;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var original_5: vec4<u32>;
    var points_5: array<array<vec4<u32>, 2>, 2>;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var original_6: vec2<f32>;
    var points_6: array<array<vec2<f32>, 2>, 2>;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var original_7: float3_;
    var points_7: array<array<float3_, 2>, 2>;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var original_8: vec4<f32>;
    var points_8: array<array<vec4<f32>, 2>, 2>;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var changed: array<array<i32, 2>, 2>;
    var local_27: u32;
    var nested_empty: array<array<i32, 3>, 2>;
    var local_28: u32;
    var local_29: u32;
    var partial: array<array<i32, 3>, 2>;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var volume: array<array<array<i32, 3>, 2>, 2>;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
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

    {
        original.x = 1i;
        original.y = 2i;
        let _e8 = original;
        points[0][0] = _e8;
        points[0][1] = vec2<i32>();
        let _e13 = original;
        points[1][0] = _e13;
        points[1][1].x = 5i;
        points[1][1].y = i32();
        let _e24 = points[0i][0i].y;
        local = u32(0i);
        let _e28 = local;
        local_42 = _e28;
        let _e30 = local_42;
        out[_e30] = _e24;
        let _e38 = points[1i][1i].x;
        local_1 = u32(1i);
        let _e42 = local_1;
        local_43 = _e42;
        let _e44 = local_43;
        out[_e44] = _e38;
        let _e51 = points[1i][1i].y;
        local_2 = u32(2i);
        let _e55 = local_2;
        local_44 = _e55;
        let _e57 = local_44;
        out[_e57] = _e51;
    }
    {
        original_1.x = 1i;
        original_1.y = 2i;
        original_1.z = 3i;
        let _e69 = original_1;
        points_1[0][0] = _e69;
        points_1[0][1] = int3_();
        let _e74 = original_1;
        points_1[1][0] = _e74;
        points_1[1][1].x = 5i;
        points_1[1][1].y = i32();
        points_1[1][1].z = i32();
        let _e87 = points_1[0i][0i].z;
        local_3 = u32(3i);
        let _e91 = local_3;
        local_45 = _e91;
        let _e93 = local_45;
        out[_e93] = _e87;
        let _e100 = points_1[1i][1i].x;
        local_4 = u32(4i);
        let _e104 = local_4;
        local_46 = _e104;
        let _e106 = local_46;
        out[_e106] = _e100;
        let _e113 = points_1[1i][1i].z;
        local_5 = u32(5i);
        let _e117 = local_5;
        local_47 = _e117;
        let _e119 = local_47;
        out[_e119] = _e113;
    }
    {
        original_2.x = 1i;
        original_2.y = 2i;
        original_2.z = 3i;
        original_2.w = 4i;
        let _e133 = original_2;
        points_2[0][0] = _e133;
        points_2[0][1] = vec4<i32>();
        let _e138 = original_2;
        points_2[1][0] = _e138;
        points_2[1][1].x = 5i;
        points_2[1][1].y = i32();
        points_2[1][1].z = i32();
        points_2[1][1].w = i32();
        let _e153 = points_2[0i][0i].w;
        local_6 = u32(6i);
        let _e157 = local_6;
        local_48 = _e157;
        let _e159 = local_48;
        out[_e159] = _e153;
        let _e166 = points_2[1i][1i].x;
        local_7 = u32(7i);
        let _e170 = local_7;
        local_49 = _e170;
        let _e172 = local_49;
        out[_e172] = _e166;
        let _e179 = points_2[1i][1i].w;
        local_8 = u32(8i);
        let _e183 = local_8;
        local_50 = _e183;
        let _e185 = local_50;
        out[_e185] = _e179;
    }
    {
        original_3.x = u32(1i);
        original_3.y = u32(2i);
        let _e197 = original_3;
        points_3[0][0] = _e197;
        points_3[0][1] = vec2<u32>();
        let _e202 = original_3;
        points_3[1][0] = _e202;
        points_3[1][1].x = u32(5i);
        points_3[1][1].y = u32();
        let _e214 = points_3[0i][0i].y;
        local_9 = u32(9i);
        let _e219 = local_9;
        local_51 = _e219;
        let _e221 = local_51;
        out[_e221] = i32(_e214);
        let _e228 = points_3[1i][1i].x;
        local_10 = u32(10i);
        let _e233 = local_10;
        local_52 = _e233;
        let _e235 = local_52;
        out[_e235] = i32(_e228);
        let _e242 = points_3[1i][1i].y;
        local_11 = u32(11i);
        let _e247 = local_11;
        local_53 = _e247;
        let _e249 = local_53;
        out[_e249] = i32(_e242);
    }
    {
        original_4.x = u32(1i);
        original_4.y = u32(2i);
        original_4.z = u32(3i);
        let _e264 = original_4;
        points_4[0][0] = _e264;
        points_4[0][1] = uint3_();
        let _e269 = original_4;
        points_4[1][0] = _e269;
        points_4[1][1].x = u32(5i);
        points_4[1][1].y = u32();
        points_4[1][1].z = u32();
        let _e283 = points_4[0i][0i].z;
        local_12 = u32(12i);
        let _e288 = local_12;
        local_54 = _e288;
        let _e290 = local_54;
        out[_e290] = i32(_e283);
        let _e297 = points_4[1i][1i].x;
        local_13 = u32(13i);
        let _e302 = local_13;
        local_55 = _e302;
        let _e304 = local_55;
        out[_e304] = i32(_e297);
        let _e311 = points_4[1i][1i].z;
        local_14 = u32(14i);
        let _e316 = local_14;
        local_56 = _e316;
        let _e318 = local_56;
        out[_e318] = i32(_e311);
    }
    {
        original_5.x = u32(1i);
        original_5.y = u32(2i);
        original_5.z = u32(3i);
        original_5.w = u32(4i);
        let _e336 = original_5;
        points_5[0][0] = _e336;
        points_5[0][1] = vec4<u32>();
        let _e341 = original_5;
        points_5[1][0] = _e341;
        points_5[1][1].x = u32(5i);
        points_5[1][1].y = u32();
        points_5[1][1].z = u32();
        points_5[1][1].w = u32();
        let _e357 = points_5[0i][0i].w;
        local_15 = u32(15i);
        let _e362 = local_15;
        local_57 = _e362;
        let _e364 = local_57;
        out[_e364] = i32(_e357);
        let _e371 = points_5[1i][1i].x;
        local_16 = u32(16i);
        let _e376 = local_16;
        local_58 = _e376;
        let _e378 = local_58;
        out[_e378] = i32(_e371);
        let _e385 = points_5[1i][1i].w;
        local_17 = u32(17i);
        let _e390 = local_17;
        local_59 = _e390;
        let _e392 = local_59;
        out[_e392] = i32(_e385);
    }
    {
        original_6.x = f32(1i);
        original_6.y = f32(2i);
        let _e404 = original_6;
        points_6[0][0] = _e404;
        points_6[0][1] = vec2<f32>();
        let _e409 = original_6;
        points_6[1][0] = _e409;
        points_6[1][1].x = f32(5i);
        points_6[1][1].y = f32();
        let _e421 = points_6[0i][0i].y;
        local_18 = u32(18i);
        let _e426 = local_18;
        local_60 = _e426;
        let _e428 = local_60;
        out[_e428] = i32(_e421);
        let _e435 = points_6[1i][1i].x;
        local_19 = u32(19i);
        let _e440 = local_19;
        local_61 = _e440;
        let _e442 = local_61;
        out[_e442] = i32(_e435);
        let _e449 = points_6[1i][1i].y;
        local_20 = u32(20i);
        let _e454 = local_20;
        local_62 = _e454;
        let _e456 = local_62;
        out[_e456] = i32(_e449);
    }
    {
        original_7.x = f32(1i);
        original_7.y = f32(2i);
        original_7.z = f32(3i);
        let _e471 = original_7;
        points_7[0][0] = _e471;
        points_7[0][1] = float3_();
        let _e476 = original_7;
        points_7[1][0] = _e476;
        points_7[1][1].x = f32(5i);
        points_7[1][1].y = f32();
        points_7[1][1].z = f32();
        let _e490 = points_7[0i][0i].z;
        local_21 = u32(21i);
        let _e495 = local_21;
        local_63 = _e495;
        let _e497 = local_63;
        out[_e497] = i32(_e490);
        let _e504 = points_7[1i][1i].x;
        local_22 = u32(22i);
        let _e509 = local_22;
        local_64 = _e509;
        let _e511 = local_64;
        out[_e511] = i32(_e504);
        let _e518 = points_7[1i][1i].z;
        local_23 = u32(23i);
        let _e523 = local_23;
        local_65 = _e523;
        let _e525 = local_65;
        out[_e525] = i32(_e518);
    }
    {
        original_8.x = f32(1i);
        original_8.y = f32(2i);
        original_8.z = f32(3i);
        original_8.w = f32(4i);
        let _e543 = original_8;
        points_8[0][0] = _e543;
        points_8[0][1] = vec4<f32>();
        let _e548 = original_8;
        points_8[1][0] = _e548;
        points_8[1][1].x = f32(5i);
        points_8[1][1].y = f32();
        points_8[1][1].z = f32();
        points_8[1][1].w = f32();
        let _e564 = points_8[0i][0i].w;
        local_24 = u32(24i);
        let _e569 = local_24;
        local_66 = _e569;
        let _e571 = local_66;
        out[_e571] = i32(_e564);
        let _e578 = points_8[1i][1i].x;
        local_25 = u32(25i);
        let _e583 = local_25;
        local_67 = _e583;
        let _e585 = local_67;
        out[_e585] = i32(_e578);
        let _e592 = points_8[1i][1i].w;
        local_26 = u32(26i);
        let _e597 = local_26;
        local_68 = _e597;
        let _e599 = local_68;
        out[_e599] = i32(_e592);
    }
    changed[0][0] = 1i;
    local_27 = 1u;
    loop {
        let _e607 = local_27;
        if (_e607 >= 2u) {
            break;
        }
        changed[0][_e607] = i32();
        continuing {
            let _e612 = local_27;
            local_27 = (_e612 + 1u);
        }
    }
    changed[0i][1i] = 9i;
    changed[1][0] = 2i;
    changed[1][1] = 3i;
    local_28 = 0u;
    loop {
        let _e627 = local_28;
        if (_e627 >= 2u) {
            break;
        }
        local_29 = 0u;
        loop {
            let _e634 = local_29;
            if (_e634 >= 3u) {
                break;
            }
            nested_empty[_e627][_e634] = i32();
            continuing {
                let _e639 = local_29;
                local_29 = (_e639 + 1u);
            }
        }
        continuing {
            let _e642 = local_28;
            local_28 = (_e642 + 1u);
        }
    }
    partial[0][0] = 1i;
    local_30 = 1u;
    loop {
        let _e651 = local_30;
        if (_e651 >= 3u) {
            break;
        }
        partial[0][_e651] = i32();
        continuing {
            let _e656 = local_30;
            local_30 = (_e656 + 1u);
        }
    }
    local_31 = 1u;
    loop {
        let _e661 = local_31;
        if (_e661 >= 2u) {
            break;
        }
        local_32 = 0u;
        loop {
            let _e667 = local_32;
            if (_e667 >= 3u) {
                break;
            }
            partial[_e661][_e667] = i32();
            continuing {
                let _e672 = local_32;
                local_32 = (_e672 + 1u);
            }
        }
        continuing {
            let _e675 = local_31;
            local_31 = (_e675 + 1u);
        }
    }
    volume[0][0][0] = 1i;
    local_33 = 1u;
    loop {
        let _e685 = local_33;
        if (_e685 >= 3u) {
            break;
        }
        volume[0][0][_e685] = i32();
        continuing {
            let _e690 = local_33;
            local_33 = (_e690 + 1u);
        }
    }
    local_34 = 1u;
    loop {
        let _e695 = local_34;
        if (_e695 >= 2u) {
            break;
        }
        local_35 = 0u;
        loop {
            let _e701 = local_35;
            if (_e701 >= 3u) {
                break;
            }
            volume[0][_e695][_e701] = i32();
            continuing {
                let _e706 = local_35;
                local_35 = (_e706 + 1u);
            }
        }
        continuing {
            let _e709 = local_34;
            local_34 = (_e709 + 1u);
        }
    }
    local_36 = 1u;
    loop {
        let _e714 = local_36;
        if (_e714 >= 2u) {
            break;
        }
        local_37 = 0u;
        loop {
            let _e720 = local_37;
            if (_e720 >= 2u) {
                break;
            }
            local_38 = 0u;
            loop {
                let _e726 = local_38;
                if (_e726 >= 3u) {
                    break;
                }
                volume[_e714][_e720][_e726] = i32();
                continuing {
                    let _e731 = local_38;
                    local_38 = (_e731 + 1u);
                }
            }
            continuing {
                let _e734 = local_37;
                local_37 = (_e734 + 1u);
            }
        }
        continuing {
            let _e737 = local_36;
            local_36 = (_e737 + 1u);
        }
    }
    let _e744 = changed[0i][1i];
    shared_values[1i][2i] = _e744;
    let _e754 = changed[1i][0i];
    let _e759 = changed[1i][1i];
    shared_points[1i][0i] = float3_(f32(_e754), f32(_e759), f32(4i));
    storageBarrier();
    workgroupBarrier();
    let _e779 = shared_values[1i][2i];
    let _e780 = nested_empty[1i][2i];
    let _e786 = partial[1i][2i];
    let _e794 = volume[1i][1i][2i];
    local_39 = u32(27i);
    let _e799 = local_39;
    out[_e799] = (((_e779 + _e780) + _e786) + _e794);
    let _e806 = shared_points[1i][0i].x;
    local_40 = u32(28i);
    let _e811 = local_40;
    out[_e811] = i32(_e806);
    let _e818 = shared_points[1i][0i].y;
    local_41 = u32(29i);
    let _e823 = local_41;
    out[_e823] = i32(_e818);
}
