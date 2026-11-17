__device__ void bump(int &value) { ++value; }
__global__ void switch_initializers(const int *input, unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 16u;
    int seed = input[lane];
    int state = int(lane) + 1;
    switch (; seed) { case 0: state += 1; break; default: state += 2; }
    output[base] = unsigned(state);
    switch (bump(state); seed) {
        case 0: state += 10; break;
        case 1: state += 20;
        case 2: state += 30; break;
        default: state += 40;
    }
    output[base + 1u] = unsigned(state);
    switch (int key = seed, bias = 5; key) {
        case 0: output[base + 2u] = unsigned(bias); break;
        case 1: output[base + 2u] = unsigned(bias + key); break;
        default: output[base + 2u] = unsigned(bias + key);
    }
    switch (auto key = seed + 1; key) { case 1: state += 3; break; default: state += 4; }
    output[base + 3u] = unsigned(state);
    switch (int &alias = state; alias) { default: alias += 7; }
    output[base + 4u] = unsigned(state);
    int key = 99;
    switch (int key = seed; key) {
        case 0: output[base + 5u] = unsigned(key + 10); break;
        default: output[base + 5u] = unsigned(key + 20);
    }
    output[base + 6u] = unsigned(key);
    switch (int key = seed; key) {
        default: { { int key = 9; state += key; } output[base + 7u] = unsigned(key + 30); }
    }
    output[base + 8u] = unsigned(state);
    switch (constexpr int One = 1; seed) { case One: state += 1; break; default: state += 2; }
    output[base + 9u] = unsigned(state);
    for (int pass = 0; pass < 4; ++pass) {
        switch (int selected = pass; selected) {
            case 1: continue;
            case 2: state += 10; break;
            default: state += 1;
        }
        state += 2;
    }
    output[base + 10u] = unsigned(state);
    int counter = 0;
    switch (counter++, state += 2; seed) { default: state += 3; }
    output[base + 11u] = unsigned(counter);
    output[base + 12u] = unsigned(state);
    switch (int selected = seed; selected) {
        case 0: switch (auto inner = selected + 1; inner) { default: state += inner; } break;
        default: state += 4;
    }
    output[base + 13u] = unsigned(state);
    output[base + 14u] = unsigned(seed);
    output[base + 15u] = unsigned(counter);
}
