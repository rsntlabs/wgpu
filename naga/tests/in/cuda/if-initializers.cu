__device__ void touch(int &value) { ++value; }
__global__ void if_initializers(const int *input, unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 16u;
    int seed = input[lane];
    int other = input[lane + 4u];
    int state = int(lane) + 1;
    if (; seed > 0) state += 10; else state += 20;
    output[base] = unsigned(state);
    if (touch(state); false) state += 99; else output[base + 1u] = unsigned(state);
    int index = 0;
    if (index++, state += 2; seed < other) state += 3; else state += 5;
    output[base + 2u] = unsigned(index);
    output[base + 3u] = unsigned(state);
    if (int left = seed, right = other; left < right) output[base + 4u] = unsigned(left + 100);
    else output[base + 4u] = unsigned(right + 200);
    if (auto copy = seed; true) output[base + 5u] = unsigned(copy + 300);
    if (int &alias = state; alias > 0) alias += 7;
    output[base + 6u] = unsigned(state);
    int header = 50;
    if (int header = seed; header > 0) output[base + 7u] = unsigned(header + 400);
    else if (int header = other; header > 0) output[base + 7u] = unsigned(header + 500);
    else output[base + 7u] = unsigned(header + 600);
    output[base + 8u] = unsigned(header);
    if (int header = seed; true) {
        { int header = 9; state += header; }
        output[base + 9u] = unsigned(header + 20);
    }
    output[base + 10u] = unsigned(state);
    for (int pass = 0; pass < 4; ++pass) {
        if (int selected = pass; selected == 1) continue;
        if (int selected = pass; selected == 3) break;
        state += pass + 1;
    }
    output[base + 11u] = unsigned(state);
    if ((void)touch(state); true) output[base + 12u] = unsigned(state);
    int read = 0;
    if (int saved = input[lane + unsigned(read++)]; saved > 0) output[base + 13u] = unsigned(read + 100);
    else output[base + 13u] = unsigned(read + 200);
    output[base + 14u] = unsigned(state);
    output[base + 15u] = unsigned(index);
}
