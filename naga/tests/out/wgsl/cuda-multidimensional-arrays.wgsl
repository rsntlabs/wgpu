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
    var local_69: u32;
    var local_70: u32;
    var local_71: u32;

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
        let _e29 = local;
        local_42 = u32(_e29);
        let _e32 = local_42;
        out[_e32] = _e24;
        let _e39 = points[1i][1i].x;
        local_1 = u32(1i);
        let _e43 = local_1;
        local_43 = u32(_e43);
        let _e46 = local_43;
        out[_e46] = _e39;
        let _e53 = points[1i][1i].y;
        local_2 = u32(2i);
        let _e57 = local_2;
        local_44 = u32(_e57);
        let _e60 = local_44;
        out[_e60] = _e53;
    }
    {
        original_1.x = 1i;
        original_1.y = 2i;
        original_1.z = 3i;
        let _e72 = original_1;
        points_1[0][0] = _e72;
        points_1[0][1] = int3_();
        let _e77 = original_1;
        points_1[1][0] = _e77;
        points_1[1][1].x = 5i;
        points_1[1][1].y = i32();
        points_1[1][1].z = i32();
        let _e90 = points_1[0i][0i].z;
        local_3 = u32(3i);
        let _e94 = local_3;
        local_45 = u32(_e94);
        let _e97 = local_45;
        out[_e97] = _e90;
        let _e104 = points_1[1i][1i].x;
        local_4 = u32(4i);
        let _e108 = local_4;
        local_46 = u32(_e108);
        let _e111 = local_46;
        out[_e111] = _e104;
        let _e118 = points_1[1i][1i].z;
        local_5 = u32(5i);
        let _e122 = local_5;
        local_47 = u32(_e122);
        let _e125 = local_47;
        out[_e125] = _e118;
    }
    {
        original_2.x = 1i;
        original_2.y = 2i;
        original_2.z = 3i;
        original_2.w = 4i;
        let _e139 = original_2;
        points_2[0][0] = _e139;
        points_2[0][1] = vec4<i32>();
        let _e144 = original_2;
        points_2[1][0] = _e144;
        points_2[1][1].x = 5i;
        points_2[1][1].y = i32();
        points_2[1][1].z = i32();
        points_2[1][1].w = i32();
        let _e159 = points_2[0i][0i].w;
        local_6 = u32(6i);
        let _e163 = local_6;
        local_48 = u32(_e163);
        let _e166 = local_48;
        out[_e166] = _e159;
        let _e173 = points_2[1i][1i].x;
        local_7 = u32(7i);
        let _e177 = local_7;
        local_49 = u32(_e177);
        let _e180 = local_49;
        out[_e180] = _e173;
        let _e187 = points_2[1i][1i].w;
        local_8 = u32(8i);
        let _e191 = local_8;
        local_50 = u32(_e191);
        let _e194 = local_50;
        out[_e194] = _e187;
    }
    {
        original_3.x = u32(1i);
        original_3.y = u32(2i);
        let _e206 = original_3;
        points_3[0][0] = _e206;
        points_3[0][1] = vec2<u32>();
        let _e211 = original_3;
        points_3[1][0] = _e211;
        points_3[1][1].x = u32(5i);
        points_3[1][1].y = u32();
        let _e223 = points_3[0i][0i].y;
        local_9 = u32(9i);
        let _e228 = local_9;
        local_51 = u32(_e228);
        let _e231 = local_51;
        out[_e231] = i32(_e223);
        let _e238 = points_3[1i][1i].x;
        local_10 = u32(10i);
        let _e243 = local_10;
        local_52 = u32(_e243);
        let _e246 = local_52;
        out[_e246] = i32(_e238);
        let _e253 = points_3[1i][1i].y;
        local_11 = u32(11i);
        let _e258 = local_11;
        local_53 = u32(_e258);
        let _e261 = local_53;
        out[_e261] = i32(_e253);
    }
    {
        original_4.x = u32(1i);
        original_4.y = u32(2i);
        original_4.z = u32(3i);
        let _e276 = original_4;
        points_4[0][0] = _e276;
        points_4[0][1] = uint3_();
        let _e281 = original_4;
        points_4[1][0] = _e281;
        points_4[1][1].x = u32(5i);
        points_4[1][1].y = u32();
        points_4[1][1].z = u32();
        let _e295 = points_4[0i][0i].z;
        local_12 = u32(12i);
        let _e300 = local_12;
        local_54 = u32(_e300);
        let _e303 = local_54;
        out[_e303] = i32(_e295);
        let _e310 = points_4[1i][1i].x;
        local_13 = u32(13i);
        let _e315 = local_13;
        local_55 = u32(_e315);
        let _e318 = local_55;
        out[_e318] = i32(_e310);
        let _e325 = points_4[1i][1i].z;
        local_14 = u32(14i);
        let _e330 = local_14;
        local_56 = u32(_e330);
        let _e333 = local_56;
        out[_e333] = i32(_e325);
    }
    {
        original_5.x = u32(1i);
        original_5.y = u32(2i);
        original_5.z = u32(3i);
        original_5.w = u32(4i);
        let _e351 = original_5;
        points_5[0][0] = _e351;
        points_5[0][1] = vec4<u32>();
        let _e356 = original_5;
        points_5[1][0] = _e356;
        points_5[1][1].x = u32(5i);
        points_5[1][1].y = u32();
        points_5[1][1].z = u32();
        points_5[1][1].w = u32();
        let _e372 = points_5[0i][0i].w;
        local_15 = u32(15i);
        let _e377 = local_15;
        local_57 = u32(_e377);
        let _e380 = local_57;
        out[_e380] = i32(_e372);
        let _e387 = points_5[1i][1i].x;
        local_16 = u32(16i);
        let _e392 = local_16;
        local_58 = u32(_e392);
        let _e395 = local_58;
        out[_e395] = i32(_e387);
        let _e402 = points_5[1i][1i].w;
        local_17 = u32(17i);
        let _e407 = local_17;
        local_59 = u32(_e407);
        let _e410 = local_59;
        out[_e410] = i32(_e402);
    }
    {
        original_6.x = f32(1i);
        original_6.y = f32(2i);
        let _e422 = original_6;
        points_6[0][0] = _e422;
        points_6[0][1] = vec2<f32>();
        let _e427 = original_6;
        points_6[1][0] = _e427;
        points_6[1][1].x = f32(5i);
        points_6[1][1].y = f32();
        let _e439 = points_6[0i][0i].y;
        local_18 = u32(18i);
        let _e444 = local_18;
        local_60 = u32(_e444);
        let _e447 = local_60;
        out[_e447] = i32(_e439);
        let _e454 = points_6[1i][1i].x;
        local_19 = u32(19i);
        let _e459 = local_19;
        local_61 = u32(_e459);
        let _e462 = local_61;
        out[_e462] = i32(_e454);
        let _e469 = points_6[1i][1i].y;
        local_20 = u32(20i);
        let _e474 = local_20;
        local_62 = u32(_e474);
        let _e477 = local_62;
        out[_e477] = i32(_e469);
    }
    {
        original_7.x = f32(1i);
        original_7.y = f32(2i);
        original_7.z = f32(3i);
        let _e492 = original_7;
        points_7[0][0] = _e492;
        points_7[0][1] = float3_();
        let _e497 = original_7;
        points_7[1][0] = _e497;
        points_7[1][1].x = f32(5i);
        points_7[1][1].y = f32();
        points_7[1][1].z = f32();
        let _e511 = points_7[0i][0i].z;
        local_21 = u32(21i);
        let _e516 = local_21;
        local_63 = u32(_e516);
        let _e519 = local_63;
        out[_e519] = i32(_e511);
        let _e526 = points_7[1i][1i].x;
        local_22 = u32(22i);
        let _e531 = local_22;
        local_64 = u32(_e531);
        let _e534 = local_64;
        out[_e534] = i32(_e526);
        let _e541 = points_7[1i][1i].z;
        local_23 = u32(23i);
        let _e546 = local_23;
        local_65 = u32(_e546);
        let _e549 = local_65;
        out[_e549] = i32(_e541);
    }
    {
        original_8.x = f32(1i);
        original_8.y = f32(2i);
        original_8.z = f32(3i);
        original_8.w = f32(4i);
        let _e567 = original_8;
        points_8[0][0] = _e567;
        points_8[0][1] = vec4<f32>();
        let _e572 = original_8;
        points_8[1][0] = _e572;
        points_8[1][1].x = f32(5i);
        points_8[1][1].y = f32();
        points_8[1][1].z = f32();
        points_8[1][1].w = f32();
        let _e588 = points_8[0i][0i].w;
        local_24 = u32(24i);
        let _e593 = local_24;
        local_66 = u32(_e593);
        let _e596 = local_66;
        out[_e596] = i32(_e588);
        let _e603 = points_8[1i][1i].x;
        local_25 = u32(25i);
        let _e608 = local_25;
        local_67 = u32(_e608);
        let _e611 = local_67;
        out[_e611] = i32(_e603);
        let _e618 = points_8[1i][1i].w;
        local_26 = u32(26i);
        let _e623 = local_26;
        local_68 = u32(_e623);
        let _e626 = local_68;
        out[_e626] = i32(_e618);
    }
    changed[0][0] = 1i;
    local_27 = 1u;
    loop {
        let _e634 = local_27;
        if (_e634 >= 2u) {
            break;
        }
        changed[0][_e634] = i32();
        continuing {
            let _e639 = local_27;
            local_27 = (_e639 + 1u);
        }
    }
    changed[0i][1i] = 9i;
    changed[1][0] = 2i;
    changed[1][1] = 3i;
    local_28 = 0u;
    loop {
        let _e654 = local_28;
        if (_e654 >= 2u) {
            break;
        }
        local_29 = 0u;
        loop {
            let _e661 = local_29;
            if (_e661 >= 3u) {
                break;
            }
            nested_empty[_e654][_e661] = i32();
            continuing {
                let _e666 = local_29;
                local_29 = (_e666 + 1u);
            }
        }
        continuing {
            let _e669 = local_28;
            local_28 = (_e669 + 1u);
        }
    }
    partial[0][0] = 1i;
    local_30 = 1u;
    loop {
        let _e678 = local_30;
        if (_e678 >= 3u) {
            break;
        }
        partial[0][_e678] = i32();
        continuing {
            let _e683 = local_30;
            local_30 = (_e683 + 1u);
        }
    }
    local_31 = 1u;
    loop {
        let _e688 = local_31;
        if (_e688 >= 2u) {
            break;
        }
        local_32 = 0u;
        loop {
            let _e694 = local_32;
            if (_e694 >= 3u) {
                break;
            }
            partial[_e688][_e694] = i32();
            continuing {
                let _e699 = local_32;
                local_32 = (_e699 + 1u);
            }
        }
        continuing {
            let _e702 = local_31;
            local_31 = (_e702 + 1u);
        }
    }
    volume[0][0][0] = 1i;
    local_33 = 1u;
    loop {
        let _e712 = local_33;
        if (_e712 >= 3u) {
            break;
        }
        volume[0][0][_e712] = i32();
        continuing {
            let _e717 = local_33;
            local_33 = (_e717 + 1u);
        }
    }
    local_34 = 1u;
    loop {
        let _e722 = local_34;
        if (_e722 >= 2u) {
            break;
        }
        local_35 = 0u;
        loop {
            let _e728 = local_35;
            if (_e728 >= 3u) {
                break;
            }
            volume[0][_e722][_e728] = i32();
            continuing {
                let _e733 = local_35;
                local_35 = (_e733 + 1u);
            }
        }
        continuing {
            let _e736 = local_34;
            local_34 = (_e736 + 1u);
        }
    }
    local_36 = 1u;
    loop {
        let _e741 = local_36;
        if (_e741 >= 2u) {
            break;
        }
        local_37 = 0u;
        loop {
            let _e747 = local_37;
            if (_e747 >= 2u) {
                break;
            }
            local_38 = 0u;
            loop {
                let _e753 = local_38;
                if (_e753 >= 3u) {
                    break;
                }
                volume[_e741][_e747][_e753] = i32();
                continuing {
                    let _e758 = local_38;
                    local_38 = (_e758 + 1u);
                }
            }
            continuing {
                let _e761 = local_37;
                local_37 = (_e761 + 1u);
            }
        }
        continuing {
            let _e764 = local_36;
            local_36 = (_e764 + 1u);
        }
    }
    let _e771 = changed[0i][1i];
    shared_values[1i][2i] = _e771;
    let _e781 = changed[1i][0i];
    let _e786 = changed[1i][1i];
    shared_points[1i][0i] = float3_(f32(_e781), f32(_e786), f32(4i));
    storageBarrier();
    workgroupBarrier();
    let _e806 = shared_values[1i][2i];
    let _e807 = nested_empty[1i][2i];
    let _e813 = partial[1i][2i];
    let _e821 = volume[1i][1i][2i];
    local_39 = u32(27i);
    let _e826 = local_39;
    local_69 = u32(_e826);
    let _e829 = local_69;
    out[_e829] = (((_e806 + _e807) + _e813) + _e821);
    let _e836 = shared_points[1i][0i].x;
    local_40 = u32(28i);
    let _e841 = local_40;
    local_70 = u32(_e841);
    let _e844 = local_70;
    out[_e844] = i32(_e836);
    let _e851 = shared_points[1i][0i].y;
    local_41 = u32(29i);
    let _e856 = local_41;
    local_71 = u32(_e856);
    let _e859 = local_71;
    out[_e859] = i32(_e851);
}
