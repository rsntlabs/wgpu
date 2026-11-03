enable wgpu_int16;

struct Pair_cuda_record_0_ {
    first: i32,
    second: i32,
}

struct Snapshot_cuda_record_1_ {
    pair: Pair_cuda_record_0_,
    marker: i32,
}

struct Packet_cuda_record_2_ {
    head: i32,
    values: array<i32, 2>,
    pair: Pair_cuda_record_0_,
}

struct int1_ {
    x: i32,
}

struct SingleBox_cuda_record_3_ {
    value: int1_,
    tail: i32,
}

struct VectorBox_cuda_record_4_ {
    value: vec2<i32>,
    tail: u32,
}

struct ArrayBox_cuda_record_5_ {
    values: array<i32, 2>,
    tail: i32,
}

struct dim3_ {
    x: u32,
    y: u32,
    z: u32,
}

struct DimBox_cuda_record_6_ {
    shape: dim3_,
    tail: i32,
}

struct type_6 {
    value: u32,
}

struct float1_ {
    x: f32,
}

struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

struct int3_ {
    x: i32,
    y: i32,
    z: i32,
}

struct uint1_ {
    x: u32,
}

struct uint3_ {
    x: u32,
    y: u32,
    z: u32,
}

struct short1_ {
    x: i16,
}

struct short3_ {
    x: i16,
    y: i16,
    z: i16,
}

struct ushort1_ {
    x: u16,
}

struct ushort3_ {
    x: u16,
    y: u16,
    z: u16,
}

@group(0) @binding(0)
var<storage> input: array<i32>;
@group(0) @binding(1)
var<storage, read_write> observations: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_6;

@compute @workgroup_size(4, 1, 1)
fn parenthesized_aggregates(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var floating_one: float1_;
    var floating_two: vec2<f32>;
    var floating_three: float3_;
    var floating_four: vec4<f32>;
    var signed_one: int1_;
    var signed_two: vec2<i32>;
    var signed_three: int3_;
    var signed_four: vec4<i32>;
    var unsigned_one: uint1_;
    var unsigned_two: vec2<u32>;
    var unsigned_three: uint3_;
    var unsigned_four: vec4<u32>;
    var half_one: short1_;
    var half_two: vec2<i16>;
    var half_three: short3_;
    var half_four: vec4<i16>;
    var unsigned_half_one: ushort1_;
    var unsigned_half_two: vec2<u16>;
    var unsigned_half_three: ushort3_;
    var unsigned_half_four: vec4<u16>;
    var self_: Pair_cuda_record_0_;
    var self_vector: vec2<i32>;
    var self_half: vec4<i16>;
    var source: Pair_cuda_record_0_;
    var captured: Snapshot_cuda_record_1_;
    var packet: Packet_cuda_record_2_;
    var shape: dim3_;
    var empty: dim3_;
    var checksum: i32;
    var iteration: i32;
    var reset: int3_;
    var tagged: Pair_cuda_record_0_;
    var truncated: Pair_cuda_record_0_;
    var modified: Pair_cuda_record_0_;
    var flattened_pair: Snapshot_cuda_record_1_;
    var flattened_single: SingleBox_cuda_record_3_;
    var flattened_vector: VectorBox_cuda_record_4_;
    var flattened_array: ArrayBox_cuda_record_5_;
    var flattened_comma: ArrayBox_cuda_record_5_;
    var named_nested: Snapshot_cuda_record_1_;
    var c_style_nested: Snapshot_cuda_record_1_;
    var shaped: DimBox_cuda_record_6_;
    var local: u32;
    var local_1: u32;
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
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
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

    let count_1 = count.value;
    let index = ((blockIdx.x * 4u) + threadIdx.x);
    if (index >= count_1) {
        return;
    }
    let _e13 = input[index];
    let value = (_e13 & 255i);
    let real = (f32(value) + 0.5f);
    floating_one.x = real;
    floating_two.x = real;
    floating_two.y = f32();
    floating_three.x = real;
    floating_three.y = f32();
    floating_three.z = f32();
    floating_four.x = real;
    floating_four.y = f32();
    floating_four.z = f32();
    floating_four.w = f32();
    signed_one.x = (value - 128i);
    signed_two.x = (value - 128i);
    signed_two.y = i32();
    signed_three.x = (value - 128i);
    signed_three.y = i32();
    signed_three.z = i32();
    signed_four.x = (value - 128i);
    signed_four.y = i32();
    signed_four.z = i32();
    signed_four.w = i32();
    unsigned_one.x = (u32(value) + 65535u);
    unsigned_two.x = (u32(value) + 65535u);
    unsigned_two.y = u32();
    unsigned_three.x = (u32(value) + 65535u);
    unsigned_three.y = u32();
    unsigned_three.z = u32();
    unsigned_four.x = (u32(value) + 65535u);
    unsigned_four.y = u32();
    unsigned_four.z = u32();
    unsigned_four.w = u32();
    half_one.x = i16((value + 32768i));
    half_two.x = i16((value + 32768i));
    half_two.y = i16();
    half_three.x = i16((value + 32768i));
    half_three.y = i16();
    half_three.z = i16();
    half_four.x = i16((value + 32768i));
    half_four.y = i16();
    half_four.z = i16();
    half_four.w = i16();
    unsigned_half_one.x = u16((value + 65536i));
    unsigned_half_two.x = u16((value + 65536i));
    unsigned_half_two.y = u16();
    unsigned_half_three.x = u16((value + 65536i));
    unsigned_half_three.y = u16();
    unsigned_half_three.z = u16();
    unsigned_half_four.x = u16((value + 65536i));
    unsigned_half_four.y = u16();
    unsigned_half_four.z = u16();
    unsigned_half_four.w = u16();
    self_.first = value;
    let _e167 = self_.first;
    self_.second = (_e167 + 1i);
    self_vector.x = value;
    let _e174 = self_vector.x;
    self_vector.y = (_e174 + 2i);
    self_half.x = i16((value + 32768i));
    let _e184 = self_half.x;
    self_half.y = i16((i32(_e184) + 1i));
    let _e191 = self_half.y;
    self_half.z = i16((i32(_e191) + 1i));
    let _e198 = self_half.z;
    self_half.w = i16((i32(_e198) + 1i));
    source.first = value;
    source.second = (value + 1i);
    let _e208 = source;
    captured.pair = _e208;
    let _e213 = source.first;
    source.first = (_e213 + 100i);
    let _e218 = source.first;
    captured.marker = _e218;
    packet.head = value;
    packet.values = array<i32, 2>();
    packet.pair = Pair_cuda_record_0_();
    shape = dim3_(u32(value), 1u, 1u);
    empty = dim3_(1u, 1u, 1u);
    checksum = 0i;
    {
        iteration = 0i;
        loop {
            let _e239 = iteration;
            if (_e239 < 2i) {
            } else {
                break;
            }
            reset.x = value;
            reset.y = i32();
            reset.z = i32();
            let _e250 = reset.y;
            let _e251 = reset.z;
            let _e253 = checksum;
            checksum = (_e253 + (_e250 + _e251));
            reset.y = 7i;
            reset.z = 11i;
            continuing {
                let _e259 = iteration;
                iteration = (_e259 + 1i);
            }
        }
    }
    tagged.first = value;
    tagged.second = 7i;
    truncated.first = i32(real);
    truncated.second = i32(3.75f);
    modified.first = value;
    let _e276 = modified.first;
    modified.first = (_e276 + 1i);
    let _e279 = modified.first;
    modified.second = _e279;
    flattened_pair.pair.first = value;
    flattened_pair.pair.second = (value + 1i);
    flattened_pair.marker = (value + 2i);
    flattened_single.value.x = value;
    flattened_single.tail = (value + 3i);
    flattened_vector.value.x = (value + 4i);
    flattened_vector.value.y = i32();
    flattened_vector.tail = u32();
    flattened_array.values[0] = (value + 5i);
    flattened_array.values[1] = (value + 6i);
    flattened_array.tail = i32();
    flattened_comma.values[0] = (value + 8i);
    flattened_comma.values[1] = (value + 9i);
    flattened_comma.tail = i32();
    named_nested.pair.first = (value + 10i);
    named_nested.pair.second = i32();
    named_nested.marker = i32();
    c_style_nested.pair.first = (value + 11i);
    c_style_nested.pair.second = i32();
    c_style_nested.marker = i32();
    shaped.shape = dim3_(2u, 1u, 1u);
    shaped.tail = 3i;
    let base = (index * 64u);
    let _e353 = floating_one.x;
    observations[base] = bitcast<u32>(_e353);
    let _e358 = floating_two.x;
    local = u32((base + 1u));
    let _e364 = local;
    observations[_e364] = bitcast<u32>(_e358);
    let _e367 = floating_three.x;
    local_1 = u32((base + 2u));
    let _e373 = local_1;
    observations[_e373] = bitcast<u32>(_e367);
    let _e376 = floating_four.x;
    local_2 = u32((base + 3u));
    let _e382 = local_2;
    observations[_e382] = bitcast<u32>(_e376);
    let _e385 = signed_one.x;
    local_3 = u32((base + 4u));
    let _e391 = local_3;
    observations[_e391] = u32(_e385);
    let _e394 = signed_two.x;
    local_4 = u32((base + 5u));
    let _e400 = local_4;
    observations[_e400] = u32(_e394);
    let _e403 = signed_three.x;
    local_5 = u32((base + 6u));
    let _e409 = local_5;
    observations[_e409] = u32(_e403);
    let _e412 = signed_four.x;
    local_6 = u32((base + 7u));
    let _e418 = local_6;
    observations[_e418] = u32(_e412);
    let _e421 = unsigned_one.x;
    local_7 = u32((base + 8u));
    let _e426 = local_7;
    observations[_e426] = _e421;
    let _e429 = unsigned_two.x;
    local_8 = u32((base + 9u));
    let _e434 = local_8;
    observations[_e434] = _e429;
    let _e437 = unsigned_three.x;
    local_9 = u32((base + 10u));
    let _e442 = local_9;
    observations[_e442] = _e437;
    let _e445 = unsigned_four.x;
    local_10 = u32((base + 11u));
    let _e450 = local_10;
    observations[_e450] = _e445;
    let _e453 = half_one.x;
    local_11 = u32((base + 12u));
    let _e459 = local_11;
    observations[_e459] = u32(_e453);
    let _e462 = half_two.x;
    local_12 = u32((base + 13u));
    let _e468 = local_12;
    observations[_e468] = u32(_e462);
    let _e471 = half_three.x;
    local_13 = u32((base + 14u));
    let _e477 = local_13;
    observations[_e477] = u32(_e471);
    let _e480 = half_four.x;
    local_14 = u32((base + 15u));
    let _e486 = local_14;
    observations[_e486] = u32(_e480);
    let _e489 = unsigned_half_one.x;
    local_15 = u32((base + 16u));
    let _e495 = local_15;
    observations[_e495] = u32(_e489);
    let _e498 = unsigned_half_two.x;
    local_16 = u32((base + 17u));
    let _e504 = local_16;
    observations[_e504] = u32(_e498);
    let _e507 = unsigned_half_three.x;
    local_17 = u32((base + 18u));
    let _e513 = local_17;
    observations[_e513] = u32(_e507);
    let _e516 = unsigned_half_four.x;
    local_18 = u32((base + 19u));
    let _e522 = local_18;
    observations[_e522] = u32(_e516);
    let _e526 = floating_four.y;
    let _e527 = floating_four.z;
    let _e530 = floating_four.w;
    let _e535 = signed_four.y;
    let _e536 = signed_four.z;
    let _e539 = signed_four.w;
    let _e544 = unsigned_four.y;
    let _e547 = unsigned_four.z;
    let _e550 = unsigned_four.w;
    let _e554 = half_four.y;
    let _e556 = half_four.z;
    let _e560 = half_four.w;
    let _e567 = unsigned_half_four.y;
    let _e569 = unsigned_half_four.z;
    let _e573 = unsigned_half_four.w;
    local_19 = u32((base + 20u));
    let _e582 = local_19;
    observations[_e582] = ((((((u32(((_e526 + _e527) + _e530)) | u32(((_e535 + _e536) + _e539))) | _e544) | _e547) | _e550) | u32(((i32(_e554) + i32(_e556)) + i32(_e560)))) | u32(((i32(_e567) + i32(_e569)) + i32(_e573))));
    let _e585 = self_.first;
    local_20 = u32((base + 21u));
    let _e591 = local_20;
    observations[_e591] = u32(_e585);
    let _e594 = self_.second;
    local_21 = u32((base + 22u));
    let _e600 = local_21;
    observations[_e600] = u32(_e594);
    let _e603 = self_vector.x;
    local_22 = u32((base + 23u));
    let _e609 = local_22;
    observations[_e609] = u32(_e603);
    let _e612 = self_vector.y;
    local_23 = u32((base + 24u));
    let _e618 = local_23;
    observations[_e618] = u32(_e612);
    let _e621 = self_half.w;
    local_24 = u32((base + 25u));
    let _e627 = local_24;
    observations[_e627] = u32(_e621);
    let _e631 = captured.pair.first;
    local_25 = u32((base + 26u));
    let _e637 = local_25;
    observations[_e637] = u32(_e631);
    let _e641 = captured.pair.second;
    local_26 = u32((base + 27u));
    let _e647 = local_26;
    observations[_e647] = u32(_e641);
    let _e650 = captured.marker;
    local_27 = u32((base + 28u));
    let _e656 = local_27;
    observations[_e656] = u32(_e650);
    let _e659 = source.first;
    local_28 = u32((base + 29u));
    let _e665 = local_28;
    observations[_e665] = u32(_e659);
    let _e670 = packet.values[0i];
    local_29 = u32((base + 30u));
    let _e676 = local_29;
    observations[_e676] = u32(_e670);
    let _e680 = packet.pair.second;
    local_30 = u32((base + 31u));
    let _e686 = local_30;
    observations[_e686] = u32(_e680);
    let _e689 = shape.y;
    local_31 = u32((base + 32u));
    let _e694 = local_31;
    observations[_e694] = _e689;
    let _e697 = shape.z;
    local_32 = u32((base + 33u));
    let _e702 = local_32;
    observations[_e702] = _e697;
    let _e706 = empty.x;
    let _e707 = empty.y;
    let _e710 = empty.z;
    local_33 = u32((base + 34u));
    let _e716 = local_33;
    observations[_e716] = ((_e706 + _e707) + _e710);
    let _e718 = checksum;
    local_34 = u32((base + 35u));
    let _e724 = local_34;
    observations[_e724] = u32(_e718);
    let _e727 = tagged.second;
    local_35 = u32((base + 36u));
    let _e733 = local_35;
    observations[_e733] = u32(_e727);
    let _e736 = truncated.second;
    local_36 = u32((base + 37u));
    let _e742 = local_36;
    observations[_e742] = u32(_e736);
    let _e745 = modified.first;
    local_37 = u32((base + 38u));
    let _e751 = local_37;
    observations[_e751] = u32(_e745);
    let _e754 = modified.second;
    local_38 = u32((base + 39u));
    let _e760 = local_38;
    observations[_e760] = u32(_e754);
    let _e764 = flattened_pair.pair.first;
    local_39 = u32((base + 40u));
    let _e770 = local_39;
    observations[_e770] = u32(_e764);
    let _e774 = flattened_pair.pair.second;
    local_40 = u32((base + 41u));
    let _e780 = local_40;
    observations[_e780] = u32(_e774);
    let _e783 = flattened_pair.marker;
    local_41 = u32((base + 42u));
    let _e789 = local_41;
    observations[_e789] = u32(_e783);
    let _e793 = flattened_single.value.x;
    local_42 = u32((base + 43u));
    let _e799 = local_42;
    observations[_e799] = u32(_e793);
    let _e802 = flattened_single.tail;
    local_43 = u32((base + 44u));
    let _e808 = local_43;
    observations[_e808] = u32(_e802);
    let _e812 = flattened_vector.value.x;
    local_44 = u32((base + 45u));
    let _e818 = local_44;
    observations[_e818] = u32(_e812);
    let _e822 = flattened_vector.value.y;
    local_45 = u32((base + 46u));
    let _e828 = local_45;
    observations[_e828] = u32(_e822);
    let _e831 = flattened_vector.tail;
    local_46 = u32((base + 47u));
    let _e836 = local_46;
    observations[_e836] = _e831;
    let _e841 = flattened_array.values[0i];
    local_47 = u32((base + 48u));
    let _e847 = local_47;
    observations[_e847] = u32(_e841);
    let _e852 = flattened_array.values[1i];
    local_48 = u32((base + 49u));
    let _e858 = local_48;
    observations[_e858] = u32(_e852);
    let _e861 = flattened_array.tail;
    local_49 = u32((base + 50u));
    let _e867 = local_49;
    observations[_e867] = u32(_e861);
    let _e872 = flattened_comma.values[0i];
    local_50 = u32((base + 51u));
    let _e878 = local_50;
    observations[_e878] = u32(_e872);
    let _e883 = flattened_comma.values[1i];
    local_51 = u32((base + 52u));
    let _e889 = local_51;
    observations[_e889] = u32(_e883);
    let _e892 = flattened_comma.tail;
    local_52 = u32((base + 53u));
    let _e898 = local_52;
    observations[_e898] = u32(_e892);
    let _e902 = named_nested.pair.first;
    local_53 = u32((base + 54u));
    let _e908 = local_53;
    observations[_e908] = u32(_e902);
    let _e912 = named_nested.pair.second;
    local_54 = u32((base + 55u));
    let _e918 = local_54;
    observations[_e918] = u32(_e912);
    let _e921 = named_nested.marker;
    local_55 = u32((base + 56u));
    let _e927 = local_55;
    observations[_e927] = u32(_e921);
    let _e931 = c_style_nested.pair.first;
    local_56 = u32((base + 57u));
    let _e937 = local_56;
    observations[_e937] = u32(_e931);
    let _e941 = c_style_nested.pair.second;
    local_57 = u32((base + 58u));
    let _e947 = local_57;
    observations[_e947] = u32(_e941);
    let _e950 = c_style_nested.marker;
    local_58 = u32((base + 59u));
    let _e956 = local_58;
    observations[_e956] = u32(_e950);
    let _e960 = shaped.shape.x;
    local_59 = u32((base + 60u));
    let _e965 = local_59;
    observations[_e965] = _e960;
    let _e969 = shaped.shape.y;
    local_60 = u32((base + 61u));
    let _e974 = local_60;
    observations[_e974] = _e969;
    let _e978 = shaped.shape.z;
    local_61 = u32((base + 62u));
    let _e983 = local_61;
    observations[_e983] = _e978;
    let _e986 = shaped.tail;
    local_62 = u32((base + 63u));
    let _e992 = local_62;
    observations[_e992] = u32(_e986);
}
