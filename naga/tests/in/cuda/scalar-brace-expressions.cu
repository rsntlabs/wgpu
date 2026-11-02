using Flag = bool;
using FrozenSigned = const int;
using ObservedUnsigned = volatile unsigned;
using FrozenFloat = const float;

constexpr unsigned Extent = unsigned{int{3},};

template<class Value> __device__ Value value_zero() {
    return Value{};
}

template<class Value> __device__ Value copied(Value value) {
    return Value{value};
}

__device__ int advance(unsigned &counter) {
    ++counter;
    return int(counter * 10u);
}

__device__ unsigned scalar_kind(bool value) { return 3u; }
__device__ unsigned scalar_kind(int value) { return 5u; }
__device__ unsigned scalar_kind(unsigned value) { return 7u; }
__device__ unsigned scalar_kind(float value) { return 11u; }
__device__ unsigned scalar_kind(int *value) { return 13u; }

__global__ void scalar_brace_expressions(float *output) {
    constexpr unsigned offset = unsigned{};
    int values[Extent]{29, 31, 37};
    unsigned counter = 0u;
    int first = int{advance(counter),};
    int comma = int{(++counter, advance(counter)),};
    int selected = bool{1} ? int{advance(counter)} : int{(counter += 100u, -1)};
    int skipped = bool{} ? int{advance(counter)} : int{7};
    int first_snapshot = int{first};
    first = 59;
    const float &zero_reference = float{};

    output[0] = float(bool{});
    output[1] = float(int{});
    output[2] = float(unsigned{});
    output[3] = float{};
    output[4] = float(bool{1u,});
    output[5] = float(int{-7,});
    output[6] = float(unsigned{11,});
    output[7] = float{1.5f,};
    output[8] = float(FrozenSigned{17u,});
    output[9] = float(ObservedUnsigned{19,});
    output[10] = FrozenFloat{2.5f};
    output[11] = float(Flag{0});
    output[12] = float(value_zero<bool>());
    output[13] = float(value_zero<int>());
    output[14] = float(value_zero<unsigned>());
    output[15] = value_zero<float>();
    output[16] = float(copied<int>(23));
    output[17] = copied<float>(-0.0f);
    output[18] = float(Extent);
    output[19] = float(values[offset]);
    output[20] = float(values[offset + 1u]);
    output[21] = float(values[offset + 2u]);
    output[22] = float(scalar_kind(int{}));
    output[23] = float(scalar_kind(bool{}));
    output[24] = float(scalar_kind(unsigned{}));
    output[25] = float(scalar_kind(float{}));
    output[26] = float(scalar_kind(nullptr));
    output[27] = float(first_snapshot);
    output[28] = float(first);
    output[29] = float(comma);
    output[30] = float(selected);
    output[31] = float(skipped);
    output[32] = float(counter);
    output[33] = float(bool{nullptr});
    output[34] = float{16777218};
    output[35] = float(unsigned{true});
    output[36] = float(int{bool{false}});
    output[37] = zero_reference;
    output[38] = float{-0.0f,};
    output[39] = float(copied<unsigned>(counter));
}
