using Count = const unsigned;
using Sample = float;
using Flag = bool;
using Null = decltype(nullptr);
constexpr int GlobalCount(3.75f);

__device__ unsigned selected(unsigned *value) { return value ? 19u : 11u; }
__device__ unsigned selected(dim3 value) { return 41u + value.x; }

__global__ void scalar_initialization(unsigned *output) {
    int seed(7);
    int negative(-2.75f);
    unsigned wrapped(-1);
    Sample floating(seed);
    bool nonzero(seed), zero(0);
    Count bound(3u);
    constexpr unsigned LocalIndex(2);
    int values[bound]{5, 7, 11};
    const int snapshot(seed);
    seed = 13;
    Null empty(nullptr);
    Flag literal(nullptr), named(empty);
    int named_zero(0);
    const int frozen_zero(0);
    constexpr int constant_zero(0);
    auto deduced_zero(0);
    unsigned *real = output + 24;
    unsigned *missing = nullptr;
    bool real_flag(real), missing_flag(missing);
    output[0] = GlobalCount;
    output[1] = unsigned(negative + 10);
    output[2] = wrapped;
    output[3] = unsigned(floating);
    output[4] = unsigned(nonzero);
    output[5] = unsigned(zero);
    output[6] = values[LocalIndex];
    output[7] = snapshot;
    output[8] = seed;
    output[9] = unsigned(literal);
    output[10] = unsigned(named);
    output[11] = selected(nullptr);
    output[12] = selected(0);
    output[13] = selected(named_zero);
    output[14] = selected(frozen_zero);
    output[15] = selected(constant_zero);
    output[16] = selected(deduced_zero);
    output[17] = unsigned(real_flag);
    output[18] = unsigned(missing_flag);
    output[19] = bound;
    output[20] = output[24];
}
