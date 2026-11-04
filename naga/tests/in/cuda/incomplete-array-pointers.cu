using Values = int[];
using Small = int[3];
using Large = int[5];
using Row = int[2];

__device__ int element(const Values *view, unsigned index) {
    return (*view)[index];
}

__device__ void bump(int &value) {
    value += 7;
}

extern "C" __global__ void incomplete_array_pointers(const Values *input, Values *output, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;
    int value = (*input)[index] & 255;
    Small small{value, value + 1, value + 2};
    Large large{value + 3, value + 4, value + 5, value + 6, value + 7};
    Values *view = &small;
    int before = element(view, 1);
    Values *snapshot = view;
    view = &large;
    Values *large_view = view;
    int after = element(view, 3);
    Values *selected = (index & 1u) == 0u ? snapshot : view;
    bump((*selected)[1]);
    Values *nullable = nullptr;
    if (index % 3u != 0u) nullable = selected;
    int optional = -1;
    if (nullable) optional = element(nullable, 0);
    Values *roundtrip = &*selected;
    Row pairs[2]{{value + 8, value + 9}, {value + 10, value + 11}};
    Row *row = &pairs[1];
    Values *row_view = row;
    int row_first = element(row_view, 0);
    int row_second = element(row_view, 1);
    int *elements = *row_view;
    ++elements;
    *elements += 1;
    for (unsigned phase = 0; phase < 3u; ++phase) {
        view = (phase & 1u) == 0u ? snapshot : large_view;
    }
    unsigned base = (index + 1u) * 12u;
    (*output)[base] = before;
    (*output)[base + 1u] = after;
    (*output)[base + 2u] = element(snapshot, 1);
    (*output)[base + 3u] = element(large_view, 1);
    (*output)[base + 4u] = element(selected, 1);
    (*output)[base + 5u] = optional;
    (*output)[base + 6u] = element(roundtrip, 0);
    (*output)[base + 7u] = nullable != nullptr;
    (*output)[base + 8u] = row_first;
    (*output)[base + 9u] = row_second;
    (*output)[base + 10u] = *elements;
    (*output)[base + 11u] = element(view, 1);
}
