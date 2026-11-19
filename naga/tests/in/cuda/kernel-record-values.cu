struct One { int x; };
struct Two { unsigned x; float y; };
struct Trio { int x; unsigned y; float z; };
struct Four { int x; unsigned y; float z; unsigned w; };
struct Twin { int x; unsigned y; float z; };
__device__ unsigned kind(Trio) { return 11u; }
__device__ unsigned kind(Twin) { return 22u; }
__device__ void bump(Trio &value, unsigned lane) { value.y += lane; }
__global__ void record_values(unsigned *output, One one, const Two two,
                             Trio three, Four four, const Trio *input) {
    unsigned lane = threadIdx.x + blockIdx.x * blockDim.x;
    if (lane >= 4u) return;
    unsigned base = 4u + lane * 12u;
    Trio original = three;
    one.x += int(lane);
    bump(three, lane);
    three.x -= int(lane);
    Four changed = four;
    changed.x += int(lane);
    changed.y += 1u;
    changed.z *= 2.0f;
    four = changed;
    Twin other;
    other.x = original.x; other.y = original.y; other.z = original.z;
    Trio stored = input[lane];
    output[base] = unsigned(one.x + 10);
    output[base + 1u] = two.x;
    output[base + 2u] = __float_as_uint(two.y);
    output[base + 3u] = unsigned(three.x + 20);
    output[base + 4u] = three.y;
    output[base + 5u] = __float_as_uint(three.z);
    output[base + 6u] = unsigned(four.x + 20);
    output[base + 7u] = four.y;
    output[base + 8u] = __float_as_uint(four.z);
    output[base + 9u] = four.w;
    output[base + 10u] = original.y;
    output[base + 11u] = kind(three) + kind(other) + unsigned(stored.x) + stored.y + unsigned(stored.z);
}
