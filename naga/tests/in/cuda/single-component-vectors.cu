using Signed = int1;

template<class Value>
__device__ Value identity(Value value) { return value; }

__device__ Signed altered(const Signed &value) {
    Signed result = value;
    result.x ^= 0x13579bdf;
    return result;
}

__device__ unsigned kind(float1 value) { return 11u; }
__device__ unsigned kind(int1 value) { return 13u; }
__device__ unsigned kind(uint1 value) { return 17u; }
__device__ unsigned kind(short1 value) { return 19u; }
__device__ unsigned kind(ushort1 value) { return 23u; }
__device__ unsigned kind(float value) { return 31u; }
__device__ unsigned kind(int value) { return 37u; }
__device__ unsigned kind(unsigned value) { return 41u; }
__device__ unsigned kind(short value) { return 43u; }
__device__ unsigned kind(unsigned short value) { return 47u; }

extern "C" __global__ void single_component_vectors(const Signed *input, Signed *output,
                                                    unsigned *observations, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;

    Signed signed_value = identity<Signed>(make_int1(input[index].x));
    uint1 unsigned_value = identity<uint1>(make_uint1(signed_value.x));
    float1 floating = make_float1(float(signed_value.x & 7) + 0.5f);
    short1 signed_half = make_short1(signed_value.x);
    ushort1 unsigned_half = make_ushort1(signed_value.x);
    signed_half.x += 1;
    unsigned_half.x++;
    Signed changed = altered(signed_value);
    output[index] = changed;

    unsigned base = index * 16u;
    observations[base] = unsigned(signed_value.x);
    observations[base + 1u] = unsigned(changed.x);
    observations[base + 2u] = unsigned_value.x;
    observations[base + 3u] = __float_as_uint(floating.x);
    observations[base + 4u] = unsigned(signed_half.x);
    observations[base + 5u] = unsigned(unsigned_half.x);
    observations[base + 6u] = kind(floating);
    observations[base + 7u] = kind(signed_value);
    observations[base + 8u] = kind(unsigned_value);
    observations[base + 9u] = kind(signed_half);
    observations[base + 10u] = kind(unsigned_half);
    observations[base + 11u] = kind(floating.x);
    observations[base + 12u] = kind(signed_value.x);
    observations[base + 13u] = kind(unsigned_value.x);
    observations[base + 14u] = kind(signed_half.x);
    observations[base + 15u] = kind(unsigned_half.x);
}
