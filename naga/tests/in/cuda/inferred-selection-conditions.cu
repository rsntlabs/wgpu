using Scalar = int;
__global__ void inferred_conditions(const int *input, unsigned *output) {
    unsigned lane = threadIdx.x + blockIdx.x * blockDim.x;
    if (lane >= 4u) return;
    unsigned base = 4u + lane * 13u;
    int cursor = 0;
    if (auto selected = input[lane + unsigned(cursor++)]) output[base] = unsigned(selected + 100);
    else output[base] = unsigned(selected + 200);
    output[base + 1u] = unsigned(cursor);
    int header = 50;
    if (const auto header{input[lane],}) output[base + 2u] = unsigned(header + 300);
    else output[base + 2u] = unsigned(header + 400);
    output[base + 3u] = unsigned(header);
    if (int seed = input[lane + 4u]; auto ready{seed > 0}) output[base + 4u] = unsigned(seed + 500);
    else output[base + 4u] = unsigned(seed + 600);
    int state = 0;
    switch (cursor++; auto mode{lane % 3u}) {
        case 0u: state += 10; break;
        case 1u: state += 20;
        default: state += 30; break;
    }
    output[base + 5u] = unsigned(state);
    switch (constexpr auto fixed = 2) { case fixed: state += 7; break; }
    for (int pass = 0; pass < 4; ++pass) {
        if (auto skip = pass == 1) continue;
        if (auto stop{pass == 3}) break;
        state += pass + 1;
    }
    output[base + 6u] = unsigned(state);
    if (auto nested = input[lane]) {
        { int nested = 9; state += nested; }
        output[base + 7u] = unsigned(nested + 700);
    } else output[base + 7u] = 800u;
    output[base + 8u] = unsigned(state);
    if (; auto fraction = 0.5f) ++state;
    output[base + 9u] = unsigned(state);
    if (int(input[lane]), input[lane]) ++state;
    output[base + 10u] = unsigned(state);
    output[base + 11u] = unsigned(cursor);
    const int original = input[lane];
    if (auto mutable_copy = original) {
        ++mutable_copy;
        output[base + 12u] = unsigned(mutable_copy + 900);
    } else {
        mutable_copy = 3;
        output[base + 12u] = unsigned(mutable_copy + 900);
    }
}
