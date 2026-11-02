using Pointer = unsigned *;
using Null = decltype(nullptr);

__device__ Null counted(unsigned &counter) { ++counter; return nullptr; }

__global__ void direct_pointer_reference_initialization(unsigned *output) {
    unsigned values[3]{3u, 7u, 11u};
    unsigned index = 0u;
    Pointer pointer(values), saved(pointer + index++);
    const unsigned *view(saved);
    unsigned *const fixed(&values[1]);
    unsigned &alias(values[index++]);
    const unsigned &live(alias);
    const unsigned &temporary(5u + values[0]);
    Pointer boolean_source(pointer);
    const bool &present(boolean_source);
    boolean_source = nullptr;
    const bool &absent(bool(nullptr));
    alias += *saved;
    pointer = values + 2;
    index = 2u;
    *fixed += 2u;
    unsigned counter = 0u;
    Null source(nullptr);
    Null &source_alias(source);
    const Null &observed(Null(counted(counter)));
    source_alias = 0;
    Pointer missing(0), other(nullptr);
    output[0] = *saved;
    output[1] = *pointer;
    output[2] = *view;
    output[3] = *fixed;
    output[4] = alias;
    output[5] = live;
    output[6] = temporary;
    output[7] = index;
    output[8] = unsigned(present);
    output[9] = unsigned(absent);
    output[10] = unsigned(missing == nullptr);
    output[11] = unsigned(other == nullptr);
    output[12] = counter;
    output[13] = unsigned(source == nullptr);
    output[14] = unsigned(observed == nullptr);
    output[15] = values[0] + values[1] + values[2];
}
