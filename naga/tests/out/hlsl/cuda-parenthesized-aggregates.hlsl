struct Pair_cuda_record_0_ {
    int first;
    int second;
};

struct Snapshot_cuda_record_1_ {
    Pair_cuda_record_0_ pair;
    int marker;
};

struct Packet_cuda_record_2_ {
    int head;
    int values[2];
    Pair_cuda_record_0_ pair;
};

struct int1_ {
    int x;
};

struct SingleBox_cuda_record_3_ {
    int1_ value;
    int tail;
};

struct VectorBox_cuda_record_4_ {
    int2 value;
    uint tail;
    int _end_pad_0;
};

struct ArrayBox_cuda_record_5_ {
    int values[2];
    int tail;
};

struct dim3_ {
    uint x;
    uint y;
    uint z;
};

struct DimBox_cuda_record_6_ {
    dim3_ shape;
    int tail;
};

struct type_6 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

struct float1_ {
    float x;
};

struct float3_ {
    float x;
    float y;
    float z;
};

struct int3_ {
    int x;
    int y;
    int z;
};

struct uint1_ {
    uint x;
};

struct uint3_ {
    uint x;
    uint y;
    uint z;
};

struct short1_ {
    int16_t x;
};

struct short3_ {
    int16_t x;
    int16_t y;
    int16_t z;
};

struct ushort1_ {
    uint16_t x;
};

struct ushort3_ {
    uint16_t x;
    uint16_t y;
    uint16_t z;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer observations : register(u1);
cbuffer count : register(b2) { type_6 count; }

dim3_ Constructdim3_(uint arg0, uint arg1, uint arg2) {
    dim3_ ret = (dim3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

float ZeroValuefloat() {
    return (float)0;
}

int ZeroValueint() {
    return (int)0;
}

uint ZeroValueuint() {
    return (uint)0;
}

int16_t ZeroValueint16_t() {
    return (int16_t)0;
}

uint16_t ZeroValueuint16_t() {
    return (uint16_t)0;
}

typedef int ret_ZeroValuearray2_int_[2];
ret_ZeroValuearray2_int_ ZeroValuearray2_int_() {
    return (int[2])0;
}

Pair_cuda_record_0_ ZeroValuePair_cuda_record_0_() {
    return (Pair_cuda_record_0_)0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

[numthreads(4, 1, 1)]
void parenthesized_aggregates(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    float1_ floating_one = (float1_)0;
    float2 floating_two = (float2)0;
    float3_ floating_three = (float3_)0;
    float4 floating_four = (float4)0;
    int1_ signed_one = (int1_)0;
    int2 signed_two = (int2)0;
    int3_ signed_three = (int3_)0;
    int4 signed_four = (int4)0;
    uint1_ unsigned_one = (uint1_)0;
    uint2 unsigned_two = (uint2)0;
    uint3_ unsigned_three = (uint3_)0;
    uint4 unsigned_four = (uint4)0;
    short1_ half_one = (short1_)0;
    int16_t2 half_two = (int16_t2)0;
    short3_ half_three = (short3_)0;
    int16_t4 half_four = (int16_t4)0;
    ushort1_ unsigned_half_one = (ushort1_)0;
    uint16_t2 unsigned_half_two = (uint16_t2)0;
    ushort3_ unsigned_half_three = (ushort3_)0;
    uint16_t4 unsigned_half_four = (uint16_t4)0;
    Pair_cuda_record_0_ self = (Pair_cuda_record_0_)0;
    int2 self_vector = (int2)0;
    int16_t4 self_half = (int16_t4)0;
    Pair_cuda_record_0_ source = (Pair_cuda_record_0_)0;
    Snapshot_cuda_record_1_ captured = (Snapshot_cuda_record_1_)0;
    Packet_cuda_record_2_ packet = (Packet_cuda_record_2_)0;
    dim3_ shape = (dim3_)0;
    dim3_ empty = (dim3_)0;
    int checksum = (int)0;
    int iteration = (int)0;
    int3_ reset = (int3_)0;
    Pair_cuda_record_0_ tagged = (Pair_cuda_record_0_)0;
    Pair_cuda_record_0_ truncated = (Pair_cuda_record_0_)0;
    Pair_cuda_record_0_ modified = (Pair_cuda_record_0_)0;
    Snapshot_cuda_record_1_ flattened_pair = (Snapshot_cuda_record_1_)0;
    SingleBox_cuda_record_3_ flattened_single = (SingleBox_cuda_record_3_)0;
    VectorBox_cuda_record_4_ flattened_vector = (VectorBox_cuda_record_4_)0;
    ArrayBox_cuda_record_5_ flattened_array = (ArrayBox_cuda_record_5_)0;
    ArrayBox_cuda_record_5_ flattened_comma = (ArrayBox_cuda_record_5_)0;
    Snapshot_cuda_record_1_ named_nested = (Snapshot_cuda_record_1_)0;
    Snapshot_cuda_record_1_ c_style_nested = (Snapshot_cuda_record_1_)0;
    DimBox_cuda_record_6_ shaped = (DimBox_cuda_record_6_)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;

    uint count_1 = count.value;
    uint index = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index >= count_1)) {
        return;
    }
    int _e13 = asint(input.Load(index*4));
    int value = (_e13 & int(255));
    float real = (float(value) + 0.5);
    floating_one.x = real;
    floating_two.x = real;
    floating_two.y = ZeroValuefloat();
    floating_three.x = real;
    floating_three.y = ZeroValuefloat();
    floating_three.z = ZeroValuefloat();
    floating_four.x = real;
    floating_four.y = ZeroValuefloat();
    floating_four.z = ZeroValuefloat();
    floating_four.w = ZeroValuefloat();
    signed_one.x = asint(asuint(value) - asuint(int(128)));
    signed_two.x = asint(asuint(value) - asuint(int(128)));
    signed_two.y = ZeroValueint();
    signed_three.x = asint(asuint(value) - asuint(int(128)));
    signed_three.y = ZeroValueint();
    signed_three.z = ZeroValueint();
    signed_four.x = asint(asuint(value) - asuint(int(128)));
    signed_four.y = ZeroValueint();
    signed_four.z = ZeroValueint();
    signed_four.w = ZeroValueint();
    unsigned_one.x = (uint(value) + 65535u);
    unsigned_two.x = (uint(value) + 65535u);
    unsigned_two.y = ZeroValueuint();
    unsigned_three.x = (uint(value) + 65535u);
    unsigned_three.y = ZeroValueuint();
    unsigned_three.z = ZeroValueuint();
    unsigned_four.x = (uint(value) + 65535u);
    unsigned_four.y = ZeroValueuint();
    unsigned_four.z = ZeroValueuint();
    unsigned_four.w = ZeroValueuint();
    half_one.x = int16_t(asint(asuint(value) + asuint(int(32768))));
    half_two.x = int16_t(asint(asuint(value) + asuint(int(32768))));
    half_two.y = ZeroValueint16_t();
    half_three.x = int16_t(asint(asuint(value) + asuint(int(32768))));
    half_three.y = ZeroValueint16_t();
    half_three.z = ZeroValueint16_t();
    half_four.x = int16_t(asint(asuint(value) + asuint(int(32768))));
    half_four.y = ZeroValueint16_t();
    half_four.z = ZeroValueint16_t();
    half_four.w = ZeroValueint16_t();
    unsigned_half_one.x = uint16_t(asint(asuint(value) + asuint(int(65536))));
    unsigned_half_two.x = uint16_t(asint(asuint(value) + asuint(int(65536))));
    unsigned_half_two.y = ZeroValueuint16_t();
    unsigned_half_three.x = uint16_t(asint(asuint(value) + asuint(int(65536))));
    unsigned_half_three.y = ZeroValueuint16_t();
    unsigned_half_three.z = ZeroValueuint16_t();
    unsigned_half_four.x = uint16_t(asint(asuint(value) + asuint(int(65536))));
    unsigned_half_four.y = ZeroValueuint16_t();
    unsigned_half_four.z = ZeroValueuint16_t();
    unsigned_half_four.w = ZeroValueuint16_t();
    self.first = value;
    int _e167 = self.first;
    self.second = asint(asuint(_e167) + asuint(int(1)));
    self_vector.x = value;
    int _e174 = self_vector.x;
    self_vector.y = asint(asuint(_e174) + asuint(int(2)));
    self_half.x = int16_t(asint(asuint(value) + asuint(int(32768))));
    int16_t _e184 = self_half.x;
    self_half.y = int16_t(asint(asuint(int(_e184)) + asuint(int(1))));
    int16_t _e191 = self_half.y;
    self_half.z = int16_t(asint(asuint(int(_e191)) + asuint(int(1))));
    int16_t _e198 = self_half.z;
    self_half.w = int16_t(asint(asuint(int(_e198)) + asuint(int(1))));
    source.first = value;
    source.second = asint(asuint(value) + asuint(int(1)));
    Pair_cuda_record_0_ _e208 = source;
    captured.pair = _e208;
    int _e213 = source.first;
    source.first = asint(asuint(_e213) + asuint(int(100)));
    int _e218 = source.first;
    captured.marker = _e218;
    packet.head = value;
    packet.values = ZeroValuearray2_int_();
    packet.pair = ZeroValuePair_cuda_record_0_();
    shape = Constructdim3_(uint(value), 1u, 1u);
    empty = Constructdim3_(1u, 1u, 1u);
    checksum = int(0);
    {
        iteration = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e259 = iteration;
                iteration = asint(asuint(_e259) + asuint(int(1)));
            }
            loop_init = false;
            int _e239 = iteration;
            if ((_e239 < int(2))) {
            } else {
                break;
            }
            reset.x = value;
            reset.y = ZeroValueint();
            reset.z = ZeroValueint();
            int _e250 = reset.y;
            int _e251 = reset.z;
            int _e253 = checksum;
            checksum = asint(asuint(_e253) + asuint(asint(asuint(_e250) + asuint(_e251))));
            reset.y = int(7);
            reset.z = int(11);
        }
    }
    tagged.first = value;
    tagged.second = int(7);
    truncated.first = naga_f2i32(real);
    truncated.second = naga_f2i32(3.75);
    modified.first = value;
    int _e276 = modified.first;
    modified.first = asint(asuint(_e276) + asuint(int(1)));
    int _e279 = modified.first;
    modified.second = _e279;
    flattened_pair.pair.first = value;
    flattened_pair.pair.second = asint(asuint(value) + asuint(int(1)));
    flattened_pair.marker = asint(asuint(value) + asuint(int(2)));
    flattened_single.value.x = value;
    flattened_single.tail = asint(asuint(value) + asuint(int(3)));
    flattened_vector.value.x = asint(asuint(value) + asuint(int(4)));
    flattened_vector.value.y = ZeroValueint();
    flattened_vector.tail = ZeroValueuint();
    flattened_array.values[0] = asint(asuint(value) + asuint(int(5)));
    flattened_array.values[1] = asint(asuint(value) + asuint(int(6)));
    flattened_array.tail = ZeroValueint();
    flattened_comma.values[0] = asint(asuint(value) + asuint(int(8)));
    flattened_comma.values[1] = asint(asuint(value) + asuint(int(9)));
    flattened_comma.tail = ZeroValueint();
    named_nested.pair.first = asint(asuint(value) + asuint(int(10)));
    named_nested.pair.second = ZeroValueint();
    named_nested.marker = ZeroValueint();
    c_style_nested.pair.first = asint(asuint(value) + asuint(int(11)));
    c_style_nested.pair.second = ZeroValueint();
    c_style_nested.marker = ZeroValueint();
    shaped.shape = Constructdim3_(2u, 1u, 1u);
    shaped.tail = int(3);
    uint base = (index * 64u);
    float _e353 = floating_one.x;
    observations.Store(base*4, asuint(asuint(_e353)));
    float _e358 = floating_two.x;
    local = uint((base + 1u));
    uint _e364 = local;
    observations.Store(_e364*4, asuint(asuint(_e358)));
    float _e367 = floating_three.x;
    local_1 = uint((base + 2u));
    uint _e373 = local_1;
    observations.Store(_e373*4, asuint(asuint(_e367)));
    float _e376 = floating_four.x;
    local_2 = uint((base + 3u));
    uint _e382 = local_2;
    observations.Store(_e382*4, asuint(asuint(_e376)));
    int _e385 = signed_one.x;
    local_3 = uint((base + 4u));
    uint _e391 = local_3;
    observations.Store(_e391*4, asuint(uint(_e385)));
    int _e394 = signed_two.x;
    local_4 = uint((base + 5u));
    uint _e400 = local_4;
    observations.Store(_e400*4, asuint(uint(_e394)));
    int _e403 = signed_three.x;
    local_5 = uint((base + 6u));
    uint _e409 = local_5;
    observations.Store(_e409*4, asuint(uint(_e403)));
    int _e412 = signed_four.x;
    local_6 = uint((base + 7u));
    uint _e418 = local_6;
    observations.Store(_e418*4, asuint(uint(_e412)));
    uint _e421 = unsigned_one.x;
    local_7 = uint((base + 8u));
    uint _e426 = local_7;
    observations.Store(_e426*4, asuint(_e421));
    uint _e429 = unsigned_two.x;
    local_8 = uint((base + 9u));
    uint _e434 = local_8;
    observations.Store(_e434*4, asuint(_e429));
    uint _e437 = unsigned_three.x;
    local_9 = uint((base + 10u));
    uint _e442 = local_9;
    observations.Store(_e442*4, asuint(_e437));
    uint _e445 = unsigned_four.x;
    local_10 = uint((base + 11u));
    uint _e450 = local_10;
    observations.Store(_e450*4, asuint(_e445));
    int16_t _e453 = half_one.x;
    local_11 = uint((base + 12u));
    uint _e459 = local_11;
    observations.Store(_e459*4, asuint(uint(_e453)));
    int16_t _e462 = half_two.x;
    local_12 = uint((base + 13u));
    uint _e468 = local_12;
    observations.Store(_e468*4, asuint(uint(_e462)));
    int16_t _e471 = half_three.x;
    local_13 = uint((base + 14u));
    uint _e477 = local_13;
    observations.Store(_e477*4, asuint(uint(_e471)));
    int16_t _e480 = half_four.x;
    local_14 = uint((base + 15u));
    uint _e486 = local_14;
    observations.Store(_e486*4, asuint(uint(_e480)));
    uint16_t _e489 = unsigned_half_one.x;
    local_15 = uint((base + 16u));
    uint _e495 = local_15;
    observations.Store(_e495*4, asuint(uint(_e489)));
    uint16_t _e498 = unsigned_half_two.x;
    local_16 = uint((base + 17u));
    uint _e504 = local_16;
    observations.Store(_e504*4, asuint(uint(_e498)));
    uint16_t _e507 = unsigned_half_three.x;
    local_17 = uint((base + 18u));
    uint _e513 = local_17;
    observations.Store(_e513*4, asuint(uint(_e507)));
    uint16_t _e516 = unsigned_half_four.x;
    local_18 = uint((base + 19u));
    uint _e522 = local_18;
    observations.Store(_e522*4, asuint(uint(_e516)));
    float _e526 = floating_four.y;
    float _e527 = floating_four.z;
    float _e530 = floating_four.w;
    int _e535 = signed_four.y;
    int _e536 = signed_four.z;
    int _e539 = signed_four.w;
    uint _e544 = unsigned_four.y;
    uint _e547 = unsigned_four.z;
    uint _e550 = unsigned_four.w;
    int16_t _e554 = half_four.y;
    int16_t _e556 = half_four.z;
    int16_t _e560 = half_four.w;
    uint16_t _e567 = unsigned_half_four.y;
    uint16_t _e569 = unsigned_half_four.z;
    uint16_t _e573 = unsigned_half_four.w;
    local_19 = uint((base + 20u));
    uint _e582 = local_19;
    observations.Store(_e582*4, asuint(((((((naga_f2u32(((_e526 + _e527) + _e530)) | uint(asint(asuint(asint(asuint(_e535) + asuint(_e536))) + asuint(_e539)))) | _e544) | _e547) | _e550) | uint(asint(asuint(asint(asuint(int(_e554)) + asuint(int(_e556)))) + asuint(int(_e560))))) | uint(asint(asuint(asint(asuint(int(_e567)) + asuint(int(_e569)))) + asuint(int(_e573)))))));
    int _e585 = self.first;
    local_20 = uint((base + 21u));
    uint _e591 = local_20;
    observations.Store(_e591*4, asuint(uint(_e585)));
    int _e594 = self.second;
    local_21 = uint((base + 22u));
    uint _e600 = local_21;
    observations.Store(_e600*4, asuint(uint(_e594)));
    int _e603 = self_vector.x;
    local_22 = uint((base + 23u));
    uint _e609 = local_22;
    observations.Store(_e609*4, asuint(uint(_e603)));
    int _e612 = self_vector.y;
    local_23 = uint((base + 24u));
    uint _e618 = local_23;
    observations.Store(_e618*4, asuint(uint(_e612)));
    int16_t _e621 = self_half.w;
    local_24 = uint((base + 25u));
    uint _e627 = local_24;
    observations.Store(_e627*4, asuint(uint(_e621)));
    int _e631 = captured.pair.first;
    local_25 = uint((base + 26u));
    uint _e637 = local_25;
    observations.Store(_e637*4, asuint(uint(_e631)));
    int _e641 = captured.pair.second;
    local_26 = uint((base + 27u));
    uint _e647 = local_26;
    observations.Store(_e647*4, asuint(uint(_e641)));
    int _e650 = captured.marker;
    local_27 = uint((base + 28u));
    uint _e656 = local_27;
    observations.Store(_e656*4, asuint(uint(_e650)));
    int _e659 = source.first;
    local_28 = uint((base + 29u));
    uint _e665 = local_28;
    observations.Store(_e665*4, asuint(uint(_e659)));
    int _e670 = packet.values[int(0)];
    local_29 = uint((base + 30u));
    uint _e676 = local_29;
    observations.Store(_e676*4, asuint(uint(_e670)));
    int _e680 = packet.pair.second;
    local_30 = uint((base + 31u));
    uint _e686 = local_30;
    observations.Store(_e686*4, asuint(uint(_e680)));
    uint _e689 = shape.y;
    local_31 = uint((base + 32u));
    uint _e694 = local_31;
    observations.Store(_e694*4, asuint(_e689));
    uint _e697 = shape.z;
    local_32 = uint((base + 33u));
    uint _e702 = local_32;
    observations.Store(_e702*4, asuint(_e697));
    uint _e706 = empty.x;
    uint _e707 = empty.y;
    uint _e710 = empty.z;
    local_33 = uint((base + 34u));
    uint _e716 = local_33;
    observations.Store(_e716*4, asuint(((_e706 + _e707) + _e710)));
    int _e718 = checksum;
    local_34 = uint((base + 35u));
    uint _e724 = local_34;
    observations.Store(_e724*4, asuint(uint(_e718)));
    int _e727 = tagged.second;
    local_35 = uint((base + 36u));
    uint _e733 = local_35;
    observations.Store(_e733*4, asuint(uint(_e727)));
    int _e736 = truncated.second;
    local_36 = uint((base + 37u));
    uint _e742 = local_36;
    observations.Store(_e742*4, asuint(uint(_e736)));
    int _e745 = modified.first;
    local_37 = uint((base + 38u));
    uint _e751 = local_37;
    observations.Store(_e751*4, asuint(uint(_e745)));
    int _e754 = modified.second;
    local_38 = uint((base + 39u));
    uint _e760 = local_38;
    observations.Store(_e760*4, asuint(uint(_e754)));
    int _e764 = flattened_pair.pair.first;
    local_39 = uint((base + 40u));
    uint _e770 = local_39;
    observations.Store(_e770*4, asuint(uint(_e764)));
    int _e774 = flattened_pair.pair.second;
    local_40 = uint((base + 41u));
    uint _e780 = local_40;
    observations.Store(_e780*4, asuint(uint(_e774)));
    int _e783 = flattened_pair.marker;
    local_41 = uint((base + 42u));
    uint _e789 = local_41;
    observations.Store(_e789*4, asuint(uint(_e783)));
    int _e793 = flattened_single.value.x;
    local_42 = uint((base + 43u));
    uint _e799 = local_42;
    observations.Store(_e799*4, asuint(uint(_e793)));
    int _e802 = flattened_single.tail;
    local_43 = uint((base + 44u));
    uint _e808 = local_43;
    observations.Store(_e808*4, asuint(uint(_e802)));
    int _e812 = flattened_vector.value.x;
    local_44 = uint((base + 45u));
    uint _e818 = local_44;
    observations.Store(_e818*4, asuint(uint(_e812)));
    int _e822 = flattened_vector.value.y;
    local_45 = uint((base + 46u));
    uint _e828 = local_45;
    observations.Store(_e828*4, asuint(uint(_e822)));
    uint _e831 = flattened_vector.tail;
    local_46 = uint((base + 47u));
    uint _e836 = local_46;
    observations.Store(_e836*4, asuint(_e831));
    int _e841 = flattened_array.values[int(0)];
    local_47 = uint((base + 48u));
    uint _e847 = local_47;
    observations.Store(_e847*4, asuint(uint(_e841)));
    int _e852 = flattened_array.values[int(1)];
    local_48 = uint((base + 49u));
    uint _e858 = local_48;
    observations.Store(_e858*4, asuint(uint(_e852)));
    int _e861 = flattened_array.tail;
    local_49 = uint((base + 50u));
    uint _e867 = local_49;
    observations.Store(_e867*4, asuint(uint(_e861)));
    int _e872 = flattened_comma.values[int(0)];
    local_50 = uint((base + 51u));
    uint _e878 = local_50;
    observations.Store(_e878*4, asuint(uint(_e872)));
    int _e883 = flattened_comma.values[int(1)];
    local_51 = uint((base + 52u));
    uint _e889 = local_51;
    observations.Store(_e889*4, asuint(uint(_e883)));
    int _e892 = flattened_comma.tail;
    local_52 = uint((base + 53u));
    uint _e898 = local_52;
    observations.Store(_e898*4, asuint(uint(_e892)));
    int _e902 = named_nested.pair.first;
    local_53 = uint((base + 54u));
    uint _e908 = local_53;
    observations.Store(_e908*4, asuint(uint(_e902)));
    int _e912 = named_nested.pair.second;
    local_54 = uint((base + 55u));
    uint _e918 = local_54;
    observations.Store(_e918*4, asuint(uint(_e912)));
    int _e921 = named_nested.marker;
    local_55 = uint((base + 56u));
    uint _e927 = local_55;
    observations.Store(_e927*4, asuint(uint(_e921)));
    int _e931 = c_style_nested.pair.first;
    local_56 = uint((base + 57u));
    uint _e937 = local_56;
    observations.Store(_e937*4, asuint(uint(_e931)));
    int _e941 = c_style_nested.pair.second;
    local_57 = uint((base + 58u));
    uint _e947 = local_57;
    observations.Store(_e947*4, asuint(uint(_e941)));
    int _e950 = c_style_nested.marker;
    local_58 = uint((base + 59u));
    uint _e956 = local_58;
    observations.Store(_e956*4, asuint(uint(_e950)));
    uint _e960 = shaped.shape.x;
    local_59 = uint((base + 60u));
    uint _e965 = local_59;
    observations.Store(_e965*4, asuint(_e960));
    uint _e969 = shaped.shape.y;
    local_60 = uint((base + 61u));
    uint _e974 = local_60;
    observations.Store(_e974*4, asuint(_e969));
    uint _e978 = shaped.shape.z;
    local_61 = uint((base + 62u));
    uint _e983 = local_61;
    observations.Store(_e983*4, asuint(_e978));
    int _e986 = shaped.tail;
    local_62 = uint((base + 63u));
    uint _e992 = local_62;
    observations.Store(_e992*4, asuint(uint(_e986)));
}
