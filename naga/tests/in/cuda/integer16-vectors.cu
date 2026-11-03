using Triple = short3;
using UnsignedPair = ushort2;

template<class Value>
__device__ Value identity(Value value) { return value; }

__device__ Triple altered(const Triple &value) {
    Triple result = value;
    result.x += 3;
    result.y = short(-result.y);
    result.z ^= 0x1357;
    return result;
}

__device__ unsigned promoted(int value) { return 31u; }
__device__ unsigned promoted(unsigned value) { return 37u; }
__device__ unsigned field_kind(short value) { return 41u; }
__device__ unsigned field_kind(unsigned short value) { return 43u; }

extern "C" __global__ void integer16_vectors(const Triple *input, Triple *output,
                                            unsigned *observations, unsigned short count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;

    Triple signed_triple = identity<Triple>(input[index]);
    short2 signed_pair = make_short2(signed_triple.x, signed_triple.y);
    short4 signed_quad = make_short4(signed_triple.x, signed_triple.y, signed_triple.z, 7);
    short4 copied_quad = static_cast<short4>(signed_quad);
    copied_quad.w += signed_triple.x;
    UnsignedPair unsigned_pair = make_ushort2(signed_triple.x, signed_triple.y);
    unsigned_pair.x++;
    ++unsigned_pair.y;
    ushort3 unsigned_triple = (ushort3)make_ushort3(signed_triple.x, signed_triple.y, signed_triple.z);
    ushort4 unsigned_quad = identity<ushort4>(make_ushort4(signed_triple.z, signed_triple.y, signed_triple.x, 65535u));
    unsigned_quad.w += 2;
    output[index] = altered(signed_triple);

    unsigned base = index * 16u;
    observations[base] = unsigned(signed_pair.x);
    observations[base + 1u] = unsigned(signed_pair.y);
    observations[base + 2u] = unsigned(copied_quad.x);
    observations[base + 3u] = unsigned(copied_quad.y);
    observations[base + 4u] = unsigned(copied_quad.z);
    observations[base + 5u] = unsigned(copied_quad.w);
    observations[base + 6u] = unsigned(unsigned_pair.x);
    observations[base + 7u] = unsigned(unsigned_pair.y);
    observations[base + 8u] = unsigned(unsigned_triple.x + 3 * unsigned_triple.y);
    observations[base + 9u] = unsigned(unsigned_triple.z);
    observations[base + 10u] = unsigned(unsigned_quad.x);
    observations[base + 11u] = unsigned(unsigned_quad.y);
    observations[base + 12u] = unsigned(unsigned_quad.z);
    observations[base + 13u] = unsigned(unsigned_quad.w);
    observations[base + 14u] = promoted(unsigned_triple.x);
    observations[base + 15u] = field_kind(unsigned_triple.z);
}
