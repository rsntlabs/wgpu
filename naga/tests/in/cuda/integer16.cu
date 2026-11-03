typedef unsigned short int uint16;
using Int16 = short;

struct Record {
    short signed_value;
    uint16 unsigned_value;
    unsigned wide;
    short tail;
    uint16 tag;
};

__device__ int promoted(int value) { return 31; }
__device__ int promoted(unsigned value) { return 37; }
__device__ int exact(short value) { return 41; }
__device__ int exact(uint16 value) { return 43; }
__device__ short observe(const short &value) { return value; }

template<class Value>
__device__ Value identity(Value value) { return value; }

template<short Value>
__device__ int signed_type() { return exact(Value); }

template<uint16 Value>
__device__ int unsigned_type() { return exact(Value); }

extern "C" __global__ void integer16(const Record *input, Record *output,
                                    unsigned *observations, uint16 count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;

    Record original = input[index];
    Record result = original;
    auto promoted_sum = original.unsigned_value + original.unsigned_value;
    short signed_value = identity<Int16>(original.signed_value);
    uint16 unsigned_value = identity<uint16>(original.unsigned_value);
    signed_value += 3;
    signed_value /= short(-1);
    unsigned_value += uint16(1);
    unsigned_value <<= 1;
    result.signed_value = short(float(signed_value));
    result.unsigned_value = uint16(float(unsigned_value));
    result.wide = unsigned(promoted_sum);
    result.tail = short(~original.tail);
    result.tag = uint16(original.tag + 1);
    output[index] = result;

    unsigned base = index * 16u;
    observations[base] = unsigned(promoted_sum);
    observations[base + 1u] = unsigned(promoted(original.unsigned_value));
    observations[base + 2u] = unsigned(exact(original.signed_value));
    observations[base + 3u] = unsigned(exact(original.unsigned_value));
    observations[base + 4u] = unsigned(signed_type<-1>());
    observations[base + 5u] = unsigned(unsigned_type<uint16(-1)>());
    observations[base + 6u] = unsigned(+original.unsigned_value);
    observations[base + 7u] = unsigned(-original.unsigned_value);
    observations[base + 8u] = unsigned(~original.unsigned_value);
    observations[base + 9u] = unsigned(short(-32768) / short(-1));
    observations[base + 10u] = unsigned(original.signed_value < original.unsigned_value);
    observations[base + 11u] = unsigned(original.signed_value < 1u);
    observations[base + 12u] = unsigned(result.signed_value);
    observations[base + 13u] = unsigned(result.unsigned_value);
    observations[base + 14u] = unsigned(observe(original.tail));
    observations[base + 15u] = unsigned(exact((index & 1u) ? original.signed_value : result.tail));
}
