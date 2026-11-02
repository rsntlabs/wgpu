using Flag = bool;
using FrozenSigned = const int;
using ObservedUnsigned = volatile unsigned;
using FrozenFloat = const float;

constexpr unsigned Extent = unsigned() + 3u;

template<class Value> __device__ Value value_zero() {
    return Value();
}

template<class Value> __device__ Value zero_after_increment(unsigned &counter) {
    ++counter;
    return Value();
}

__device__ unsigned scalar_kind(bool value) { return 3u; }
__device__ unsigned scalar_kind(int value) { return 5u; }
__device__ unsigned scalar_kind(unsigned value) { return 7u; }
__device__ unsigned scalar_kind(float value) { return 11u; }
__device__ unsigned scalar_kind(int *value) { return 13u; }

__global__ void empty_scalar_construction(float *output) {
    constexpr int offset = int();
    int values[Extent]{11, 17, 23};

    unsigned counter = 0u;
    int comma_zero = (++counter, int());
    unsigned comma_call = (++counter, zero_after_increment<unsigned>(counter));
    unsigned after_comma = counter;
    float selected = counter == 3u ? zero_after_increment<float>(counter)
        : (counter += 100u, 1.0f);
    float skipped = counter != 4u ? zero_after_increment<float>(counter) : float();
    unsigned after_conditionals = counter;
    bool logical = bool() && (++counter, true);
    bool alternate = bool() || (++counter, true);
    int call_comma = (zero_after_increment<int>(counter), ++counter, int());
    unsigned after_calls = counter;
    const float &positive_zero = float();
    int forced_object((int()));
    float nested = float(int(unsigned(bool())));
    int braced_integer{};
    bool braced_flag{};
    unsigned braced_unsigned{};
    float braced_float{};
    float zero_snapshot = selected;
    selected = 29.0f;

    output[0] = float(bool());
    output[1] = float(int());
    output[2] = float(unsigned());
    output[3] = float();
    output[4] = float(Flag());
    output[5] = float(FrozenSigned());
    output[6] = float(ObservedUnsigned());
    output[7] = FrozenFloat();
    output[8] = float(value_zero<bool>());
    output[9] = float(value_zero<int>());
    output[10] = float(value_zero<unsigned>());
    output[11] = value_zero<float>();
    output[12] = float(braced_integer);
    output[13] = float(braced_flag);
    output[14] = float(braced_unsigned);
    output[15] = braced_float;
    output[16] = float(values[offset]);
    output[17] = float(values[offset + 1]);
    output[18] = float(values[offset + 2]);
    output[19] = float(Extent);
    output[20] = float(scalar_kind(bool()));
    output[21] = float(scalar_kind(int()));
    output[22] = float(scalar_kind(unsigned()));
    output[23] = float(scalar_kind(float()));
    output[24] = float(scalar_kind(nullptr));
    output[25] = float(comma_zero);
    output[26] = float(comma_call);
    output[27] = float(after_comma);
    output[28] = zero_snapshot;
    output[29] = selected;
    output[30] = skipped;
    output[31] = float(after_conditionals);
    output[32] = float(logical);
    output[33] = float(alternate);
    output[34] = float(call_comma);
    output[35] = float(after_calls);
    output[36] = positive_zero;
    output[37] = float(forced_object);
    output[38] = nested;
    output[39] = float(counter);
}
