#include <cstddef>
#include <stddef.h>
struct Plain { unsigned first; float second; int third; };
struct Vectors { int first; float2 pair; float3 triple; float4 quad; unsigned tail; };
struct ArrayField { unsigned first; int items[3]; unsigned tail; };
using Alias = Vectors;
__global__ void record_offsets(unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 12u;
    int counter = 7;
    struct Local { float first; unsigned second; };
    constexpr unsigned First = unsigned(offsetof(Plain, first));
    constexpr unsigned Second = unsigned(__builtin_offsetof(Plain, second));
    constexpr unsigned Third = unsigned(__builtin_offsetof(Plain, third));
    constexpr unsigned Pair = unsigned(__builtin_offsetof(Vectors, pair));
    constexpr unsigned Triple = unsigned(offsetof(Alias, triple));
    constexpr unsigned Quad = unsigned(__builtin_offsetof(const Alias, quad));
    constexpr unsigned Tail = unsigned(offsetof(volatile Alias, tail));
    constexpr unsigned Items = unsigned(__builtin_offsetof(ArrayField, items));
    constexpr unsigned ArrayTail = unsigned(__builtin_offsetof(ArrayField, tail));
    constexpr unsigned LocalSecond = unsigned(offsetof(Local, second));
    output[base] = First; output[base + 1u] = Second;
    output[base + 2u] = Third; output[base + 3u] = Pair;
    output[base + 4u] = Triple; output[base + 5u] = Quad;
    output[base + 6u] = Tail; output[base + 7u] = Items;
    output[base + 8u] = ArrayTail; output[base + 9u] = LocalSecond;
    output[base + 10u] = unsigned(counter); output[base + 11u] = lane;
}
