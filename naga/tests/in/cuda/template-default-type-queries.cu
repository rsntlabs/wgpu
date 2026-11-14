using Null = decltype(nullptr);
using Alias = float2;
constexpr int Item = 7;
struct QueryRecord { int value; int pair[2]; };
template<int N> __device__ int own_query(int value = sizeof(value)) { return value + N; }
template<class T> __device__ int scalar_query(T unused, int value, int bytes = sizeof(value)) { return bytes; }
template<class T> __device__ int reference_query(T unused, const int &value, int bytes = sizeof(value)) { return bytes; }
template<class T> __device__ int pointer_query(T unused, const int *value, int bytes = sizeof(value), int element = sizeof(*value)) { return bytes * 100 + element; }
template<class T> __device__ int array_query(T unused, const int value[3], int bytes = sizeof(value), int element = sizeof(value[0])) { return bytes * 100 + element; }
template<class T> __device__ int record_query(T unused, const QueryRecord &item, int bytes = sizeof(item), int pair = sizeof(item.pair), int element = sizeof(item.pair[0])) { return bytes * 100 + pair * 10 + element; }
template<class T> __device__ int vector_query(T unused, float2 item, int bytes = sizeof(item), int element = sizeof(item.x)) { return bytes * 10 + element; }
template<class T> __device__ int member_query(T unused, const QueryRecord *item, int bytes = sizeof(item->pair)) { return bytes; }
template<class T> __device__ int null_query(T unused, Null item, int bytes = sizeof(item)) { return bytes; }
template<class T> __device__ int frozen_query(T unused, float2 original, int bytes = sizeof(original));
template<class U> __device__ int frozen_query(U renamed, float2 other, int width) { return width; }
template<class T> __device__ int shadow_query(T unused, float2 Item, int bytes = sizeof(Item)) { return bytes; }
template<class T> __device__ int alias_query(T unused, int Alias, int bytes = sizeof(Alias)) { return bytes; }
using Row = int[3];
using Grid = int[2][3];
template<int N> __device__ int row_alias_query(Row value, int bytes = sizeof(value), int element = sizeof(*value)) { return bytes + element + N; }
template<int N> __device__ int grid_alias_query(Grid value, int bytes = sizeof(value), int row = sizeof(*value)) { return bytes + row + N; }
template<int N> __device__ int row_pointer_query(Row *value, int bytes = sizeof(value), int row = sizeof(*value)) { return bytes + row + N; }
extern "C" __global__ void template_default_type_queries(unsigned *output, const int *input) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 19u;
    int value = int(lane) + 1;
    int original = 99;
    QueryRecord item{1, {2, 3}};
    float2 pair = make_float2(1.0f, 2.0f);
    Row row{1, 2, 3};
    Grid grid{{4, 5, 6}, {7, 8, 9}};
    output[base] = unsigned(scalar_query(1, value++));
    output[base + 1u] = unsigned(scalar_query(1, value++, 9));
    output[base + 2u] = unsigned(value);
    output[base + 3u] = unsigned(own_query<3>());
    output[base + 4u] = unsigned(reference_query(1, value));
    output[base + 5u] = unsigned(pointer_query(1, input));
    output[base + 6u] = unsigned(array_query(1, input));
    output[base + 7u] = unsigned(record_query(1, item));
    output[base + 8u] = unsigned(vector_query(1, pair));
    output[base + 9u] = unsigned(member_query(1, &item));
    output[base + 10u] = unsigned(null_query(1, nullptr));
    output[base + 11u] = unsigned(frozen_query(1, pair));
    output[base + 12u] = unsigned(shadow_query(1, pair));
    output[base + 13u] = unsigned(alias_query(1, 9));
    int index = 0;
    output[base + 14u] = unsigned(pointer_query(1, input + index++));
    output[base + 15u] = unsigned(index + input[0]);
    output[base + 16u] = unsigned(row_alias_query<0>(row));
    output[base + 17u] = unsigned(grid_alias_query<0>(grid));
    output[base + 18u] = unsigned(row_pointer_query<0>(&row));
}
