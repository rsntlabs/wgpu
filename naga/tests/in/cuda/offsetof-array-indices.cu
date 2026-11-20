#include <cstddef>
#define LAST 2u
struct Leaf { int first; int values[3]; };
struct Outer { int prefix; Leaf leaves[2]; int grid[2][3]; };
struct Vectors { int prefix; float2 pairs[2]; float4 quads[2]; float3 triples[2]; };
__global__ void indexed_offsets(unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 12u;
    int cursor = 7;
    constexpr unsigned LeafValue = unsigned(offsetof(Outer, leaves[1].values[2]));
    constexpr unsigned GridFirst = unsigned(__builtin_offsetof(Outer, grid[0][1]));
    constexpr unsigned GridLast = unsigned(offsetof(Outer, grid[1][LAST]));
    constexpr unsigned Row = unsigned(__builtin_offsetof(Outer, grid[1]));
    constexpr unsigned LeafObject = unsigned(offsetof(Outer, leaves[1u]));
    constexpr unsigned Hex = unsigned(offsetof(Outer, leaves[0x1].values[0b10]));
    constexpr unsigned Octal = unsigned(__builtin_offsetof(Outer, grid[01][02]));
    constexpr unsigned WideZero = unsigned(offsetof(Outer, leaves[0ULL].values[0]));
    constexpr unsigned Pair = unsigned(offsetof(Vectors, pairs[1]));
    constexpr unsigned Quad = unsigned(__builtin_offsetof(Vectors, quads[1]));
    constexpr unsigned Triple = unsigned(offsetof(Vectors, triples[1]));
    output[base] = LeafValue; output[base + 1u] = GridFirst;
    output[base + 2u] = GridLast; output[base + 3u] = Row;
    output[base + 4u] = LeafObject; output[base + 5u] = Hex;
    output[base + 6u] = Octal; output[base + 7u] = WideZero;
    output[base + 8u] = Pair; output[base + 9u] = Quad;
    output[base + 10u] = Triple; output[base + 11u] = unsigned(cursor) + lane;
}
