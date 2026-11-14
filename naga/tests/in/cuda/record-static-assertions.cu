struct Inner { float3 vector; int row[3]; };

struct Record {
    static_assert(sizeof(int) == 4, "integer width");
    int scalar;
    static_assert(sizeof(scalar) == 4);
    float3 vector;
    static_assert(sizeof(vector) == 12, "packed " "vector");
    int matrix[2][3];
    static_assert(sizeof(matrix) == 24);
    static_assert(sizeof(matrix[0]) == 12);
    Inner nested;
    static_assert(sizeof(nested.row) == 12);
    static_assert(sizeof(nested.vector.z) == 4);
};

extern "C" __global__ void record_assertions(unsigned *output) {
    typedef struct {
        unsigned token;
        static_assert(sizeof(token) == 4);
    } Local;
    unsigned lane = threadIdx.x;
    Record value;
    value.scalar = int(lane + 3u);
    value.vector = make_float3(1.0f, 2.0f, float(lane + 5u));
    value.matrix[1][2] = int(lane + 9u);
    value.nested.row[2] = int(lane + 15u);
    Local local{lane + 21u};
    unsigned index = 4u + lane * 8u;
    output[index] = unsigned(value.scalar);
    output[index + 1u] = unsigned(value.vector.z);
    output[index + 2u] = unsigned(value.matrix[1][2]);
    output[index + 3u] = unsigned(value.nested.row[2]);
    output[index + 4u] = unsigned(sizeof(Record));
    output[index + 5u] = unsigned(sizeof(value.matrix));
    output[index + 6u] = unsigned(sizeof(value.nested.vector));
    output[index + 7u] = local.token;
}
