struct Record { float3 vector; int tag; };
static_assert(sizeof(Record) == 16, "record layout");
static_assert(alignof(Record) == 4);
constexpr unsigned Count = 4u;

template<class Value, unsigned Width>
__device__ unsigned verified(Value value) {
    static_assert(sizeof(Value) == 4, "element width");
    static_assert(Width == Count, "launch width");
    return unsigned(value);
}

extern "C" __global__ void assertions(unsigned *output) {
    static_assert(sizeof(output) == 8, "LP64 pointer");
    constexpr unsigned VectorBytes = unsigned(sizeof(float3));
    static_assert(VectorBytes == 12, "packed vector");
    output[threadIdx.x] = verified<unsigned, Count>(threadIdx.x + 7u);
}
