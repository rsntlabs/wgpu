struct Pair { int first; int second; };
using Number = int;

__device__ int next_value(int &counter) { return counter++; }

__device__ int sum_values(int seed) {
    int values[3](seed, seed + 1);
    return values[0] + values[1] + values[2];
}

template<class Value> __device__ Value first_value(Value seed) {
    Value values[2](seed);
    return values[0];
}

__device__ int last_value(const int *values) { return values[1]; }

extern "C" __global__ void parenthesized_arrays(const int *input, unsigned *observations,
                                               unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;
    int value = input[index] & 255;

    int fixed[4](value, value + 1);
    int inferred[](value, value + 2, value + 4);
    int changed[3](value, ++changed[0], changed[0]);
    int comma[3]((value, value + 1), (value + 2, value + 3));
    int counter = value;
    int ordered[3](next_value(counter), next_value(counter), counter);
    short signed_values[3](value + 32768, -1);
    unsigned short unsigned_values[3](value + 65536, -1);
    float samples[3](float(value) + 0.5f, 3.75f);
    bool flags[3](value, false);
    const int const_values[3](value, value + 1);
    int2 vectors[3](value, value + 1, value + 2);
    Pair self[2](Pair(value, self[0].first + 1), Pair(self[0].second + 1));
    Number first[2](value), next_values[](first[0] + 1, first[1] + 2),
           scalar(next_values[0] + next_values[1]);
    int reset_sum = 0;
    for (int iteration = 0; iteration < 3; ++iteration) {
        int reset[3](value);
        reset_sum += reset[1] + reset[2];
        reset[1] = 9;
        reset[2] = 11;
    }
    dim3 shapes[3]((dim3(unsigned(value))), (dim3()));
    Pair source{value, value + 9};
    Pair copies[2](source, value, value + 9);
    source.first = value + 100;
    unsigned matrix[2][2](value, -1);
    int grouped[]((value, value + 11), ((value + 12)));

    unsigned base = index * 64u;
    observations[base] = unsigned(fixed[0]);
    observations[base + 1u] = unsigned(fixed[1]);
    observations[base + 2u] = unsigned(fixed[2]);
    observations[base + 3u] = unsigned(fixed[3]);
    observations[base + 4u] = unsigned(inferred[0]);
    observations[base + 5u] = unsigned(inferred[1]);
    observations[base + 6u] = unsigned(inferred[2]);
    observations[base + 7u] = unsigned(changed[0]);
    observations[base + 8u] = unsigned(changed[1]);
    observations[base + 9u] = unsigned(changed[2]);
    observations[base + 10u] = unsigned(comma[0]);
    observations[base + 11u] = unsigned(comma[1]);
    observations[base + 12u] = unsigned(comma[2]);
    observations[base + 13u] = unsigned(ordered[0]);
    observations[base + 14u] = unsigned(ordered[1]);
    observations[base + 15u] = unsigned(ordered[2]);
    observations[base + 16u] = unsigned(counter);
    observations[base + 17u] = unsigned(signed_values[0]);
    observations[base + 18u] = unsigned(signed_values[1]);
    observations[base + 19u] = unsigned(signed_values[2]);
    observations[base + 20u] = unsigned(unsigned_values[0]);
    observations[base + 21u] = unsigned(unsigned_values[1]);
    observations[base + 22u] = unsigned(unsigned_values[2]);
    observations[base + 23u] = __float_as_uint(samples[0]);
    observations[base + 24u] = __float_as_uint(samples[1]);
    observations[base + 25u] = __float_as_uint(samples[2]);
    observations[base + 26u] = unsigned(flags[0]);
    observations[base + 27u] = unsigned(flags[1]);
    observations[base + 28u] = unsigned(flags[2]);
    observations[base + 29u] = unsigned(const_values[0]);
    observations[base + 30u] = unsigned(const_values[1]);
    observations[base + 31u] = unsigned(const_values[2]);
    observations[base + 32u] = unsigned(vectors[0].x);
    observations[base + 33u] = unsigned(vectors[0].y);
    observations[base + 34u] = unsigned(vectors[1].x);
    observations[base + 35u] = unsigned(vectors[1].y);
    observations[base + 36u] = unsigned(vectors[2].x);
    observations[base + 37u] = unsigned(vectors[2].y);
    observations[base + 38u] = unsigned(self[0].first);
    observations[base + 39u] = unsigned(self[0].second);
    observations[base + 40u] = unsigned(self[1].first);
    observations[base + 41u] = unsigned(self[1].second);
    observations[base + 42u] = unsigned(next_values[0]);
    observations[base + 43u] = unsigned(next_values[1]);
    observations[base + 44u] = unsigned(scalar);
    observations[base + 45u] = unsigned(reset_sum);
    observations[base + 46u] = shapes[0].x;
    observations[base + 47u] = shapes[0].y;
    observations[base + 48u] = shapes[0].z;
    observations[base + 49u] = shapes[2].x;
    observations[base + 50u] = shapes[2].y;
    observations[base + 51u] = shapes[2].z;
    observations[base + 52u] = unsigned(sum_values(value));
    observations[base + 53u] = unsigned(first_value<int>(value + 7));
    observations[base + 54u] = unsigned(copies[0].first);
    observations[base + 55u] = unsigned(copies[1].second);
    observations[base + 56u] = unsigned(source.first);
    observations[base + 57u] = matrix[0][0];
    observations[base + 58u] = matrix[0][1];
    observations[base + 59u] = matrix[1][0];
    observations[base + 60u] = matrix[1][1];
    observations[base + 61u] = unsigned(grouped[0]);
    observations[base + 62u] = unsigned(grouped[1]);
    observations[base + 63u] = unsigned(last_value(grouped));
}
