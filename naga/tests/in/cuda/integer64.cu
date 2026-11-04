__device__ unsigned wide_type(long long value) { return 6u; }
__device__ unsigned wide_type(unsigned long long value) { return 3u; }

__device__ void store_pair(unsigned *output, unsigned offset, unsigned long long value) {
    output[offset] = unsigned(value);
    output[offset + 1u] = unsigned(value >> 32u);
}

extern "C" __global__ void integer64(const long long *signed_values,
                                   const unsigned long long *unsigned_values,
                                   const unsigned *controls,
                                   unsigned *output,
                                   unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;

    long long signed_value = signed_values[index + 1u];
    unsigned input_offset = (index + 1u) * 2u;
    unsigned long long unsigned_value = unsigned_values[input_offset];
    unsigned long long unsigned_divisor = unsigned_values[input_offset + 1u];
    unsigned shift = controls[input_offset];
    long long signed_divisor = static_cast<long long>(int(controls[input_offset + 1u]));
    unsigned offset = (index + 1u) * 48u;

    store_pair(output, offset, signed_value + 0xffffffffu);
    store_pair(output, offset + 2u, signed_value - 0xffffffffu);
    store_pair(output, offset + 4u, signed_value + unsigned_value);
    store_pair(output, offset + 6u, unsigned_value + 0x100000001ULL);
    store_pair(output, offset + 8u, signed_value * 3LL);
    store_pair(output, offset + 10u, signed_value / signed_divisor);
    store_pair(output, offset + 12u, signed_value % signed_divisor);
    store_pair(output, offset + 14u, unsigned_value / unsigned_divisor);
    store_pair(output, offset + 16u, unsigned_value % unsigned_divisor);
    store_pair(output, offset + 18u, unsigned_value & 0xffffffff00000000ULL);
    store_pair(output, offset + 20u, unsigned_value ^ 0x5aa55aa5a55aa55aULL);
    store_pair(output, offset + 22u, ~unsigned_value);
    store_pair(output, offset + 24u, unsigned_value << shift);
    store_pair(output, offset + 26u, unsigned_value >> shift);
    store_pair(output, offset + 28u, signed_value >> shift);
    store_pair(output, offset + 30u, signed_value << shift);

    long long updated = signed_value;
    long long previous = updated++;
    long long next = ++updated;
    updated += 0xffffffffu;
    store_pair(output, offset + 32u, previous);
    store_pair(output, offset + 34u, next);
    store_pair(output, offset + 36u, updated);
    store_pair(output, offset + 38u, (index & 1u) ? signed_value : 0xffffffffu);
    output[offset + 40u] = unsigned(signed_value);
    output[offset + 41u] = unsigned(bool(signed_value));
    output[offset + 42u] = unsigned(signed_value < 0xffffffffu);
    output[offset + 43u] = unsigned(signed_value < unsigned_value);
    output[offset + 44u] = wide_type(signed_value + 0xffffffffu);
    output[offset + 45u] = wide_type(signed_value + unsigned_value);
    output[offset + 46u] = wide_type((index & 1u) ? signed_value : 0xffffffffu);
    output[offset + 47u] = wide_type(9223372036854775808LL);
}
