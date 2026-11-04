using Row = float3[2];
struct Record { float3 position; long tag; };

template<class Value>
__device__ size_t byte_count() { return sizeof(Value); }

extern "C" __global__ void type_queries(unsigned long *output, size_t base) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    output[index] = (base + byte_count<float3>() + sizeof(Row)) * alignof(Record) + sizeof(void *);
}
