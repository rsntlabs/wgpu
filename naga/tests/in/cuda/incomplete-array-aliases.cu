using Values = int[];
using Row = int[3];
using Rows = Row[];
using Frozen = const Values;
using Unused = dim3[];

__device__ int element(const Values values, unsigned index) {
    return values[index];
}

extern "C" __global__ void incomplete_array_aliases(const Rows input, unsigned *output, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;
    int value = input[index][0] & 255;
    Values first{value};
    Values second(value, value + 1);
    Values third{value, value + 1, value + 2};
    Frozen frozen{value + 3, value + 4};
    Rows rows{{value + 5}, {value + 6, value + 7}};
    value = 0;
    unsigned base = (index + 1u) * 16u;
    output[base] = unsigned(first[0]);
    output[base + 1u] = unsigned(second[0]);
    output[base + 2u] = unsigned(second[1]);
    output[base + 3u] = unsigned(third[0]);
    output[base + 4u] = unsigned(third[1]);
    output[base + 5u] = unsigned(third[2]);
    output[base + 6u] = unsigned(frozen[0]);
    output[base + 7u] = unsigned(frozen[1]);
    output[base + 8u] = unsigned(rows[0][0]);
    output[base + 9u] = unsigned(rows[0][1]);
    output[base + 10u] = unsigned(rows[0][2]);
    output[base + 11u] = unsigned(rows[1][0]);
    output[base + 12u] = unsigned(rows[1][1]);
    output[base + 13u] = unsigned(rows[1][2]);
    output[base + 14u] = unsigned(element(first, 0));
    output[base + 15u] = unsigned(element(third, 2));
}
