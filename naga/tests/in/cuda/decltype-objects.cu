constexpr unsigned GlobalWord = 7u;
using Hidden = float;
using Null = decltype(nullptr);
struct DecltypeRecord { int tag; float3 vector; };
__device__ decltype(GlobalWord) global_decltype_value() { return GlobalWord; }
__device__ Null old_nullptr_value() { return nullptr; }
__device__ int next_decltype_value(int &value) { return value++; }
__device__ int const_decltype_kind(int &value) { return 1; }
__device__ int const_decltype_kind(const int &value) { return 2; }
__device__ int vector_decltype_kind(float value) { return 1; }
__device__ int vector_decltype_kind(float1 value) { return 2; }
template<class T> __device__ int copied_decltype_value(T value) { decltype(value) copy(value); return int(copy); }
extern "C" __global__ void decltype_objects(unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 25u;
    int source = 1;
    int counter = int(lane) + 1;
    using Copy = decltype(source);
    Copy first = next_decltype_value(counter);
    decltype(source) second{next_decltype_value(counter)};
    decltype(source) third(next_decltype_value(counter));
    int fourth = static_cast<decltype(source)>(next_decltype_value(counter));
    int fifth = (decltype(source))next_decltype_value(counter);
    int sixth = decltype(source)(next_decltype_value(counter));
    int seventh = decltype(source){next_decltype_value(counter)};
    output[base] = unsigned(first + second + third + fourth + fifth + sixth + seventh);
    output[base + 1u] = unsigned(counter);
    int mutable_value = 1;
    const int frozen_value = 2;
    constexpr int Constant = 3;
    decltype(mutable_value) mutable_copy = 4;
    decltype(frozen_value) frozen_copy = 5;
    decltype(Constant) constant_copy = 6;
    output[base + 2u] = unsigned(const_decltype_kind(mutable_copy));
    output[base + 3u] = unsigned(const_decltype_kind(frozen_copy));
    output[base + 4u] = unsigned(const_decltype_kind(constant_copy));
    output[base + 5u] = global_decltype_value();
    float1 one = make_float1(2.0f);
    decltype(one) one_copy{3.0f};
    float2 two = make_float2(1.0f, 2.0f);
    decltype(two) two_copy{3.0f, 4.0f};
    float3 three = make_float3(1.0f, 2.0f, 3.0f);
    decltype(three) three_copy{4.0f, 5.0f, 6.0f};
    float4 four = make_float4(1.0f, 2.0f, 3.0f, 4.0f);
    decltype(four) four_copy{5.0f, 6.0f, 7.0f, 8.0f};
    output[base + 6u] = unsigned(one_copy.x);
    output[base + 7u] = unsigned(vector_decltype_kind(one_copy));
    output[base + 8u] = unsigned(two_copy.y);
    output[base + 9u] = unsigned(three_copy.z);
    output[base + 10u] = unsigned(four_copy.w);
    DecltypeRecord record{1, {2.0f, 3.0f, 4.0f}};
    decltype(record) record_copy{9, {5.0f, 6.0f, 7.0f}};
    decltype(record) records[2]{{2, {3.0f, 4.0f, 5.0f}}, {6, {7.0f, 8.0f, 9.0f}}};
    output[base + 11u] = unsigned(record_copy.tag) + unsigned(record_copy.vector.y);
    output[base + 12u] = unsigned(records[1].vector.z);
    dim3 shape;
    decltype(shape) default_shape;
    decltype(shape) explicit_shape(2u, 3u);
    using Shape = decltype(shape);
    Shape braced_shape{4u, 5u};
    output[base + 13u] = default_shape.x + 10u * default_shape.y + 100u * default_shape.z;
    output[base + 14u] = explicit_shape.x + 10u * explicit_shape.y + 100u * explicit_shape.z;
    output[base + 15u] = braced_shape.x + 10u * braced_shape.y + 100u * braced_shape.z;
    output[base + 16u] = unsigned(copied_decltype_value(7));
    output[base + 17u] = unsigned(copied_decltype_value(9u));
    int Hidden = 3;
    decltype(Hidden) outer_copy = 4;
    output[base + 18u] = unsigned(outer_copy);
    { float Hidden = 2.0f; decltype(Hidden) inner_copy = 3.0f; output[base + 19u] = unsigned(inner_copy); }
    decltype(Hidden) after_copy = 5;
    output[base + 20u] = unsigned(after_copy);
    Null null_value = old_nullptr_value();
    output[base + 21u] = unsigned(null_value == nullptr);
    decltype(one) singles[2]{{2.0f}, {5.0f}};
    decltype(three) triples[2]{{1.0f, 2.0f, 3.0f}, {4.0f, 5.0f, 6.0f}};
    output[base + 22u] = unsigned(singles[1].x);
    output[base + 23u] = unsigned(triples[1].z);
    DecltypeRecord expression = decltype(record){10, {11.0f, 12.0f, 13.0f}};
    output[base + 24u] = unsigned(expression.tag) + unsigned(expression.vector.z);
}
