struct Counter { unsigned value; };
using Record = Counter;

__device__ void operator+=(Counter &left, unsigned right) {
    left.value += right;
}

__device__ Counter operator-=(Counter &left, unsigned right) {
    left.value -= right;
    return Counter{left.value + 100u};
}

__device__ unsigned operator*=(Counter &left, unsigned right) {
    left.value *= right;
    return left.value + 200u;
}

__device__ void operator/=(Counter &left, unsigned right) {
    left.value /= right;
}

__device__ Counter operator%=(Counter &left, unsigned right) {
    left.value %= right;
    return Counter{left.value + 400u};
}

__device__ unsigned operator&=(Counter &left, unsigned right) {
    left.value &= right;
    return left.value + 700u;
}

__device__ void operator|=(Counter &left, unsigned right) {
    left.value |= right;
}

__device__ Counter operator^=(Counter &left, unsigned right) {
    left.value ^= right;
    return Counter{left.value + 500u};
}

__device__ unsigned operator<<=(Counter &left, unsigned right) {
    left.value <<= right;
    return left.value + 600u;
}

__device__ void operator>>=(Counter &left, unsigned right) {
    left.value >>= right;
}

__device__ unsigned operator+=(unsigned &left, Counter right) {
    left += right.value;
    return left + 300u;
}

__device__ unsigned operator|=(Counter left, Counter right) {
    return left.value | right.value;
}

__device__ unsigned operator+=(const unsigned *left, Counter right) {
    return left[0] + right.value;
}

__device__ unsigned operator|=(unsigned left, Counter right) {
    return left + right.value;
}

__device__ unsigned operator&=(Counter &left, Counter right) {
    ++left.value;
    return right.value;
}

__device__ unsigned operator^=(Counter &left, const Counter &right) {
    ++left.value;
    return right.value;
}

__device__ unsigned operator+=(decltype(nullptr), Counter &right) {
    right.value += 7u;
    return right.value + 500u;
}

__device__ unsigned operator-=(Counter &left, decltype(nullptr)) {
    left.value -= 2u;
    return left.value + 600u;
}

__global__ void compound_operators(unsigned *output) {
    unsigned lane = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned base = lane * 40u;
    Record value{100u + lane};
    value += 5u;
    output[base] = value.value;
    Counter difference = (value -= 3u);
    output[base + 1u] = value.value;
    output[base + 2u] = difference.value;
    unsigned product = (value *= 2u);
    output[base + 3u] = value.value;
    output[base + 4u] = product;
    value /= 4u;
    output[base + 5u] = value.value;
    Counter remainder = (value %= 7u);
    output[base + 6u] = value.value;
    output[base + 7u] = remainder.value;
    unsigned masked = (value &= 3u);
    output[base + 8u] = value.value;
    output[base + 9u] = masked;
    value |= 8u;
    output[base + 10u] = value.value;
    Counter toggled = (value ^= 5u);
    output[base + 11u] = value.value;
    output[base + 12u] = toggled.value;
    unsigned shifted = (value <<= 2u);
    output[base + 13u] = value.value;
    output[base + 14u] = shifted;
    value >>= 1u;
    output[base + 15u] = value.value;
    unsigned scalar = 100u + lane;
    unsigned scalar_result = (scalar += Counter{3u});
    output[base + 16u] = scalar;
    output[base + 17u] = scalar_result;
    output[base + 18u] = (Counter{16u + lane} |= Counter{3u});
    operator+=(value, 2u);
    output[base + 19u] = value.value;
    output[base + 20u] = (value += 3u, value.value);
    const Counter fixed{9u + lane};
    output[base + 21u] = (fixed |= Counter{2u});
    output[base + 22u] = fixed.value;
}

__global__ void compound_order(unsigned *output) {
    unsigned lane = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned base = lane * 40u;
    Counter values[3]{{10u + lane}, {20u + lane}, {30u + lane}};
    unsigned index = 0u;
    values[index++] += (index = 1u, 5u);
    output[base] = values[0].value;
    output[base + 1u] = values[1].value;
    output[base + 2u] = values[2].value;
    output[base + 3u] = index;
    index = 0u;
    operator+=(values[index++], (index = 1u, 7u));
    output[base + 4u] = values[0].value;
    output[base + 5u] = index;
    Counter grid[2][2]{{{1u + lane}, {2u + lane}}, {{30u + lane}, {40u + lane}}};
    Counter *row = grid[1];
    Counter &row_alias = row[0];
    row_alias += 5u;
    output[base + 6u] = row[0].value;
    output[base + 7u] = grid[1][0].value;
    output[base + 8u] = grid[0][0].value;
    unsigned plain = 10u;
    unsigned plain_result = (plain += Counter{(plain = 20u, 3u)});
    output[base + 9u] = plain;
    output[base + 10u] = plain_result;
    Counter copied{7u};
    unsigned copied_result = (copied |= Counter{(copied.value = 11u, 3u)});
    output[base + 11u] = copied.value;
    output[base + 12u] = copied_result;
    Counter &alias = values[1];
    alias -= 2u;
    output[base + 13u] = alias.value;
    output[base + 14u] = values[1].value;
    unsigned calls = 0u;
    unsigned changed = (values[2] *= (calls++, (values[2].value = 4u, 3u)));
    output[base + 15u] = values[2].value;
    output[base + 16u] = changed;
    output[base + 17u] = calls;
    unsigned scalar = 7u;
    scalar += 3u;
    scalar <<= 1u;
    scalar &= 13u;
    output[base + 18u] = scalar;
    scalar += (scalar = 2u, 5u);
    output[base + 19u] = scalar;
    Counter snapshot{10u + lane};
    unsigned held = (snapshot &= snapshot);
    output[base + 20u] = snapshot.value;
    output[base + 21u] = held;
    Counter live{20u + lane};
    unsigned observed = (live ^= live);
    output[base + 22u] = live.value;
    output[base + 23u] = observed;
    Counter erased{30u + lane};
    unsigned first = (nullptr += erased);
    output[base + 24u] = erased.value;
    output[base + 25u] = first;
    unsigned second = (erased -= nullptr);
    output[base + 26u] = erased.value;
    output[base + 27u] = second;
    Counter views[2]{{5u + lane}, {7u + lane}};
    unsigned selected = 0u;
    unsigned capture = (views[(selected = 1u, 0u)] ^= views[selected]);
    output[base + 28u] = capture;
    output[base + 29u] = views[0].value;
    output[base + 30u] = views[1].value;
    output[base + 31u] = selected;
    selected = 0u;
    unsigned frozen = (views[(selected = 1u, 0u)] &= views[selected]);
    output[base + 32u] = frozen;
    output[base + 33u] = views[0].value;
    output[base + 34u] = views[1].value;
    output[base + 35u] = selected;
    unsigned pointees[2]{40u + lane, 50u + lane};
    unsigned *copied_pointer = pointees;
    output[base + 36u] = (copied_pointer += Counter{3u});
    output[base + 37u] = *copied_pointer;
    unsigned original = 40u + lane;
    output[base + 38u] = (original |= Counter{2u});
    output[base + 39u] = original;
}
