typedef signed Whole;
using Number = int signed;
struct Sample { signed int value; int signed samples[2]; };

static __device__ inline int signed combine(signed first, int signed second) {
    return first + second;
}

__global__ void kernel(signed *__restrict__ output, const int signed *__restrict input) {
    const signed int bias = 3;
    constexpr signed int Count = 2;
    Number values[Count]{input[0], input[1]};
    Sample sample{combine(values[0], bias), {values[1], -2}};
    output[0] = sample.value;
    output[1] = sample.samples[0] + sample.samples[1];
    output[2] = signed(-3.75f);
    output[3] = (int signed)(input[0] < 1u);
    output[4] = (signed int)-2.75f;
    output[5] = static_cast<int signed>(3.75f);
}
