#include <cstddef>
struct Leaf { int first; float2 pair; int tail[3]; };
struct Middle { float4 prefix; Leaf leaf; unsigned last; };
struct Outer { int first; Middle middle; float end; };
using Alias = Outer;
__global__ void nested_offsets(unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 12u;
    int pair = 7;
    struct Local { unsigned first; Outer nested; };
    constexpr unsigned MiddleStart = unsigned(offsetof(Outer, middle));
    constexpr unsigned LeafStart = unsigned(__builtin_offsetof(Outer, middle.leaf));
    constexpr unsigned First = unsigned(offsetof(Outer, middle.leaf.first));
    constexpr unsigned Pair = unsigned(__builtin_offsetof(Alias, middle.leaf.pair));
    constexpr unsigned Tail = unsigned(offsetof(const Alias, middle.leaf.tail));
    constexpr unsigned Last = unsigned(__builtin_offsetof(volatile Alias, middle.last));
    constexpr unsigned End = unsigned(offsetof(Outer, end));
    constexpr unsigned LocalPair = unsigned(offsetof(Local, nested.middle.leaf.pair));
    constexpr unsigned LeafPair = unsigned(offsetof(Leaf, pair));
    constexpr unsigned Sum = unsigned(offsetof(Outer, middle) + offsetof(Middle, leaf) + offsetof(Leaf, pair));
    output[base] = MiddleStart; output[base + 1u] = LeafStart;
    output[base + 2u] = First; output[base + 3u] = Pair;
    output[base + 4u] = Tail; output[base + 5u] = Last;
    output[base + 6u] = End; output[base + 7u] = LocalPair;
    output[base + 8u] = LeafPair; output[base + 9u] = Sum;
    output[base + 10u] = unsigned(pair); output[base + 11u] = lane;
}
