struct Five { int a; unsigned b; float c; unsigned d; int e; };
struct Six { int a; unsigned b; float c; unsigned d; int e; unsigned f; };
struct Seven { int a; unsigned b; float c; unsigned d; int e; unsigned f; float g; };
struct Eight { int a; unsigned b; float c; unsigned d; int e; unsigned f; float g; unsigned h; };
struct Small { unsigned value; };
__device__ void update(Five &value, unsigned lane) { value.e += int(lane); }
__global__ void record32_values(unsigned *output, Five five, const Six six,
                               Seven seven, Eight eight, const Small small,
                               const Five *input) {
    unsigned lane = threadIdx.x + blockIdx.x * blockDim.x;
    if (lane >= 4u) return;
    unsigned base = 4u + lane * 12u;
    Five original = five;
    Seven saved = seven;
    update(five, lane);
    seven.g += float(lane);
    Eight changed = eight;
    changed.h += lane;
    eight = changed;
    Five stored = input[lane];
    output[base] = unsigned(original.e + 30);
    output[base + 1u] = unsigned(five.e + 30);
    output[base + 2u] = unsigned(six.e + 30);
    output[base + 3u] = six.f;
    output[base + 4u] = __float_as_uint(seven.g);
    output[base + 5u] = __float_as_uint(saved.g);
    output[base + 6u] = eight.h;
    output[base + 7u] = eight.f;
    output[base + 8u] = __float_as_uint(eight.g);
    output[base + 9u] = unsigned(eight.e + 30);
    output[base + 10u] = small.value;
    output[base + 11u] = unsigned(stored.a + stored.e) + stored.b + stored.d + unsigned(stored.c);
}
