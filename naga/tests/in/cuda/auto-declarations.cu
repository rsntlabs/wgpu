constexpr auto GlobalCount = 3u;
using Sample = const int;
struct Record { int value; int2 pair; };

__device__ int next(int &value) { return value++; }

__global__ void kernel(int *output) {
    Sample seed = 4;
    auto copied = seed;
    copied += 1;
    auto &alias = copied;
    alias += 2;
    const auto &view = copied;
    output[0] = copied;
    output[1] = seed;
    copied += 1;
    auto point = make_int2(1, 2);
    auto point_copy{point};
    point_copy.x = 11;
    auto &point_alias(point);
    point_alias.y += 3;
    output[2] = point_copy.x;
    output[3] = point_copy.y;
    output[4] = point.x;
    output[5] = point.y;
    auto record = Record{3, make_int2(5, 7)};
    auto record_copy(record);
    auto &record_alias = record;
    record_alias.value = 9;
    record_copy.pair.x = 13;
    output[6] = record.value;
    output[7] = record_copy.value;
    output[8] = record.pair.x;
    output[9] = record_copy.pair.x;
    int counter = 2;
    auto first = next(counter), second = next(counter);
    output[10] = first;
    output[11] = second;
    output[12] = counter;
    constexpr auto Count{GlobalCount};
    const auto Last = Count - 1u;
    int values[Count]{2, 3, 5};
    auto *pointer = values;
    auto saved = pointer++;
    *saved += 1;
    *pointer += 4;
    output[13] = *saved;
    output[14] = *pointer;
    output[15] = values[Last];
    output[16] = view;
    const auto fixed = values;
    *fixed += 2;
    output[17] = values[0];
    auto sample(1.25f);
    sample += 0.5f;
    output[18] = int(sample * 4.0f);
    auto enabled = sample > 1.0f;
    output[19] = int(enabled);
}
