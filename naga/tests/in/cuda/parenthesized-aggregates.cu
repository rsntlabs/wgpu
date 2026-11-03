struct Pair { int first; int second; };
struct Snapshot { Pair pair; int marker; };
struct Packet { int head; int values[2]; Pair pair; };
struct SingleBox { int1 value; int tail; };
struct VectorBox { int2 value; unsigned tail; };
struct ArrayBox { int values[2]; int tail; };
struct DimBox { dim3 shape; int tail; };

__device__ int mutate(Pair &value) {
    value.first += 100;
    return value.first;
}

__device__ int tag(const Pair &value) { return value.second; }

extern "C" __global__ void parenthesized_aggregates(const int *input, unsigned *observations,
                                                   unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;
    int value = input[index] & 255;
    float real = float(value) + 0.5f;

    float1 floating_one(real);
    float2 floating_two = float2(real);
    float3 floating_three = static_cast<float3>(real);
    float4 floating_four = (float4)real;
    int1 signed_one(value - 128);
    int2 signed_two = int2(value - 128);
    int3 signed_three = static_cast<int3>(value - 128);
    int4 signed_four = (int4)(value - 128);
    uint1 unsigned_one(unsigned(value) + 65535u);
    uint2 unsigned_two = uint2(unsigned(value) + 65535u);
    uint3 unsigned_three = static_cast<uint3>(unsigned(value) + 65535u);
    uint4 unsigned_four = (uint4)(unsigned(value) + 65535u);
    short1 half_one(value + 32768);
    short2 half_two = short2(value + 32768);
    short3 half_three = static_cast<short3>(value + 32768);
    short4 half_four = (short4)(value + 32768);
    ushort1 unsigned_half_one(value + 65536);
    ushort2 unsigned_half_two = ushort2(value + 65536);
    ushort3 unsigned_half_three = static_cast<ushort3>(value + 65536);
    ushort4 unsigned_half_four = (ushort4)(value + 65536);

    Pair self(value, self.first + 1);
    int2 self_vector(value, self_vector.x + 2);
    short4 self_half(value + 32768, self_half.x + 1, self_half.y + 1, self_half.z + 1);
    Pair source(value, value + 1);
    Snapshot captured(source, mutate(source));
    Packet packet(value);
    dim3 shape = dim3(unsigned(value));
    dim3 empty = dim3();
    int checksum = 0;
    for (int iteration = 0; iteration < 2; ++iteration) {
        int3 reset(value);
        checksum += reset.y + reset.z;
        reset.y = 7;
        reset.z = 11;
    }
    Pair tagged(value, 7);
    Pair truncated(real, 3.75f);
    Pair modified(value, ++modified.first);

    Snapshot flattened_pair(value, value + 1, value + 2);
    SingleBox flattened_single(value, value + 3);
    VectorBox flattened_vector(value + 4);
    ArrayBox flattened_array(value + 5, value + 6);
    ArrayBox flattened_comma((value + 7, value + 8), value + 9);
    Snapshot named_nested = static_cast<Snapshot>(value + 10);
    Snapshot c_style_nested = (Snapshot)(value + 11);
    DimBox shaped(2u, 3);

    unsigned base = index * 64u;
    observations[base] = __float_as_uint(floating_one.x);
    observations[base + 1u] = __float_as_uint(floating_two.x);
    observations[base + 2u] = __float_as_uint(floating_three.x);
    observations[base + 3u] = __float_as_uint(floating_four.x);
    observations[base + 4u] = unsigned(signed_one.x);
    observations[base + 5u] = unsigned(signed_two.x);
    observations[base + 6u] = unsigned(signed_three.x);
    observations[base + 7u] = unsigned(signed_four.x);
    observations[base + 8u] = unsigned_one.x;
    observations[base + 9u] = unsigned_two.x;
    observations[base + 10u] = unsigned_three.x;
    observations[base + 11u] = unsigned_four.x;
    observations[base + 12u] = unsigned(half_one.x);
    observations[base + 13u] = unsigned(half_two.x);
    observations[base + 14u] = unsigned(half_three.x);
    observations[base + 15u] = unsigned(half_four.x);
    observations[base + 16u] = unsigned(unsigned_half_one.x);
    observations[base + 17u] = unsigned(unsigned_half_two.x);
    observations[base + 18u] = unsigned(unsigned_half_three.x);
    observations[base + 19u] = unsigned(unsigned_half_four.x);
    observations[base + 20u] = unsigned(floating_four.y + floating_four.z + floating_four.w)
        | unsigned(signed_four.y + signed_four.z + signed_four.w)
        | unsigned_four.y | unsigned_four.z | unsigned_four.w
        | unsigned(half_four.y + half_four.z + half_four.w)
        | unsigned(unsigned_half_four.y + unsigned_half_four.z + unsigned_half_four.w);
    observations[base + 21u] = unsigned(self.first);
    observations[base + 22u] = unsigned(self.second);
    observations[base + 23u] = unsigned(self_vector.x);
    observations[base + 24u] = unsigned(self_vector.y);
    observations[base + 25u] = unsigned(self_half.w);
    observations[base + 26u] = unsigned(captured.pair.first);
    observations[base + 27u] = unsigned(captured.pair.second);
    observations[base + 28u] = unsigned(captured.marker);
    observations[base + 29u] = unsigned(source.first);
    observations[base + 30u] = unsigned(packet.values[0]);
    observations[base + 31u] = unsigned(packet.pair.second);
    observations[base + 32u] = shape.y;
    observations[base + 33u] = shape.z;
    observations[base + 34u] = empty.x + empty.y + empty.z;
    observations[base + 35u] = unsigned(checksum);
    observations[base + 36u] = unsigned(tag(tagged));
    observations[base + 37u] = unsigned(truncated.second);
    observations[base + 38u] = unsigned(modified.first);
    observations[base + 39u] = unsigned(modified.second);
    observations[base + 40u] = unsigned(flattened_pair.pair.first);
    observations[base + 41u] = unsigned(flattened_pair.pair.second);
    observations[base + 42u] = unsigned(flattened_pair.marker);
    observations[base + 43u] = unsigned(flattened_single.value.x);
    observations[base + 44u] = unsigned(flattened_single.tail);
    observations[base + 45u] = unsigned(flattened_vector.value.x);
    observations[base + 46u] = unsigned(flattened_vector.value.y);
    observations[base + 47u] = flattened_vector.tail;
    observations[base + 48u] = unsigned(flattened_array.values[0]);
    observations[base + 49u] = unsigned(flattened_array.values[1]);
    observations[base + 50u] = unsigned(flattened_array.tail);
    observations[base + 51u] = unsigned(flattened_comma.values[0]);
    observations[base + 52u] = unsigned(flattened_comma.values[1]);
    observations[base + 53u] = unsigned(flattened_comma.tail);
    observations[base + 54u] = unsigned(named_nested.pair.first);
    observations[base + 55u] = unsigned(named_nested.pair.second);
    observations[base + 56u] = unsigned(named_nested.marker);
    observations[base + 57u] = unsigned(c_style_nested.pair.first);
    observations[base + 58u] = unsigned(c_style_nested.pair.second);
    observations[base + 59u] = unsigned(c_style_nested.marker);
    observations[base + 60u] = shaped.shape.x;
    observations[base + 61u] = shaped.shape.y;
    observations[base + 62u] = shaped.shape.z;
    observations[base + 63u] = unsigned(shaped.tail);
}
