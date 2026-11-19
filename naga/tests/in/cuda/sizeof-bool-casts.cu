__global__ void sizeof_bool_casts(const int *input, unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 12u;
    int seed = input[lane];
    int counter = 7;
    int values[3]{};
    int matrix[2][3]{};
    using Row = int[3];
    Row *row = nullptr;
    auto empty = nullptr;
    using Truth = bool;
    constexpr unsigned Pointer = unsigned(sizeof(static_cast<bool>(input)));
    constexpr unsigned RowPointer = unsigned(sizeof(static_cast<Truth>(row)));
    constexpr unsigned Array = unsigned(sizeof(static_cast<bool>(values)));
    constexpr unsigned Matrix = unsigned(sizeof(static_cast<bool>(matrix)));
    constexpr unsigned Literal = unsigned(sizeof(static_cast<bool>(nullptr)));
    constexpr unsigned Named = unsigned(sizeof(static_cast<const volatile Truth>(empty)));
    constexpr unsigned Comma = unsigned(sizeof(static_cast<bool>(input[counter], matrix)));
    constexpr unsigned Nested = unsigned(sizeof(static_cast<bool>(static_cast<bool>(input))));
    constexpr unsigned Conditional = unsigned(sizeof(static_cast<bool>(seed ? input : 0)));
    constexpr unsigned RowSize = unsigned(sizeof(*(seed ? row : nullptr)));
    output[base] = Pointer; output[base + 1u] = RowPointer;
    output[base + 2u] = Array; output[base + 3u] = Matrix;
    output[base + 4u] = Literal; output[base + 5u] = Named;
    output[base + 6u] = Comma; output[base + 7u] = Nested;
    output[base + 8u] = Conditional; output[base + 9u] = RowSize;
    output[base + 10u] = unsigned(counter); output[base + 11u] = unsigned(input[lane]);
}
