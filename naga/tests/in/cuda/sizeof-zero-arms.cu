#define NULL 0
#define ZERO 0u
struct Record { int first; unsigned second; float third; };
__global__ void sizeof_zero_arms(const int *input, unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 16u;
    int seed = input[lane];
    bool flag = seed != 0;
    int counter = 7;
    using Row = int[3];
    Row *row = nullptr;
    Record *record = nullptr;
    constexpr unsigned Plain = unsigned(sizeof(flag ? input : 0));
    constexpr unsigned Reverse = unsigned(sizeof(flag ? 0 : input));
    constexpr unsigned Grouped = unsigned(sizeof(flag ? input : ((0u))));
    constexpr unsigned Octal = unsigned(sizeof(flag ? 00 : input));
    constexpr unsigned Hex = unsigned(sizeof(flag ? input : 0x0));
    constexpr unsigned Binary = unsigned(sizeof(flag ? 0b0 : input));
    constexpr unsigned Separated = unsigned(sizeof(flag ? input : 0'0));
    constexpr unsigned Macro = unsigned(sizeof(flag ? input : NULL));
    constexpr unsigned MacroReverse = unsigned(sizeof(flag ? ZERO : input));
    constexpr unsigned Dereference = unsigned(sizeof(*(flag ? input : (0))));
    constexpr unsigned RowValue = unsigned(sizeof(*(flag ? 0u : row)));
    constexpr unsigned RowElement = unsigned(sizeof((flag ? row : 0)[counter][seed]));
    constexpr unsigned Member = unsigned(sizeof((flag ? 0 : record)->third));
    constexpr unsigned ScalarZero = unsigned(sizeof(flag ? 0u : 0));
    output[base] = Plain; output[base + 1u] = Reverse;
    output[base + 2u] = Grouped; output[base + 3u] = Octal;
    output[base + 4u] = Hex; output[base + 5u] = Binary;
    output[base + 6u] = Separated; output[base + 7u] = Macro;
    output[base + 8u] = MacroReverse; output[base + 9u] = Dereference;
    output[base + 10u] = RowValue; output[base + 11u] = RowElement;
    output[base + 12u] = Member; output[base + 13u] = ScalarZero;
    output[base + 14u] = unsigned(counter); output[base + 15u] = unsigned(input[lane]);
}
