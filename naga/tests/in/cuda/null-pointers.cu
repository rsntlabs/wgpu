__device__ unsigned read_or_default(const unsigned *values, unsigned fallback) {
    return values != 0 ? values[0] : fallback;
}

extern "C" __global__ void nullable(unsigned *output, const unsigned *first,
                                   const unsigned *second) {
    unsigned choice = output[0];
    const unsigned *selected{};
    if (choice == 1u) selected = first + 1;
    else if (choice == 2u) selected = second + 1;
    const unsigned *saved = selected;
    selected = 0;
    output[1] = unsigned(bool(selected));
    output[2] = read_or_default(saved, 17u);
    output[3] = unsigned(0 == saved);
    output[4] = read_or_default(choice ? first : 0, 19u);
    output[5] = read_or_default(0, 23u);
}
