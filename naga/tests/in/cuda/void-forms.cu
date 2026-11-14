__device__ int take_form(int &value) { return value++; }
__device__ void bump_form(int &value) { return void(value++); }
extern "C" __global__ void void_forms(int *output, const int *input) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 6u;
    int value = int(lane);
    void(); void{};
    (void(take_form(value)));
    (void(bump_form(value)));
    output[base] = value;
    (const volatile void)value++;
    static_cast<void const>(value++);
    output[base + 1u] = value;
    (lane & 1u) == 0u ? void(value += 3) : void(value += 7);
    output[base + 2u] = value;
    void((value++, void(value++)));
    output[base + 3u] = value;
    int index = 0;
    static_cast<volatile void>(input[index++]);
    (void(input[index++]));
    output[base + 4u] = index;
    constexpr int Count = (void{}, static_cast<const void>(value), 3);
    static_assert((true ? void() : void(take_form(value)), true));
    int array[Count]{};
    output[base + 5u] = array[2];
}
