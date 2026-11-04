typedef int Row[3], Scalar;
using Matrix = Row[2];
using FrozenRow = const Row;
using Shapes = dim3[2];
struct Packet { Row values; int marker; };

__device__ int update(Row values) {
    values[1] += 4;
    return values[1];
}

__device__ int matrix_sum(const Matrix rows);

__device__ int outer_sum(const Row rows[]) {
    return rows[1][0] + rows[1][1];
}

extern "C" __global__ void array_aliases(const Matrix input, unsigned *output, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;
    int value = (input[index][0] ^ input[index][1] ^ input[index][2]) & 255;
    Row row(value, value + 1);
    FrozenRow frozen{value + 7, value + 8};
    Matrix matrix{{value + 2}, {value + 3, value + 4}};
    Packet packet{{value + 5, value + 6}, value + 7};
    Shapes shapes;
    Row inferred[]{{value + 10}, {value + 11, value + 12}};
    int changed = update(row);
    Row *selected = &matrix[0];
    ++selected;
    selected[0][2] = value + 13;
    int total = matrix_sum(matrix);
    int outer = outer_sum(matrix);
    Scalar marker = value + 9;
    unsigned base = (index + 1u) * 32u;
    output[base] = unsigned(row[0]);
    output[base + 1u] = unsigned(row[1]);
    output[base + 2u] = unsigned(row[2]);
    output[base + 3u] = unsigned(changed);
    output[base + 4u] = unsigned(frozen[0]);
    output[base + 5u] = unsigned(frozen[1]);
    output[base + 6u] = unsigned(frozen[2]);
    output[base + 7u] = unsigned(matrix[0][0]);
    output[base + 8u] = unsigned(matrix[0][1]);
    output[base + 9u] = unsigned(matrix[0][2]);
    output[base + 10u] = unsigned(matrix[1][0]);
    output[base + 11u] = unsigned(matrix[1][1]);
    output[base + 12u] = unsigned(matrix[1][2]);
    output[base + 13u] = unsigned(total);
    output[base + 14u] = unsigned(outer);
    output[base + 15u] = unsigned(packet.values[0]);
    output[base + 16u] = unsigned(packet.values[1]);
    output[base + 17u] = unsigned(packet.values[2]);
    output[base + 18u] = unsigned(packet.marker);
    output[base + 19u] = shapes[0].x;
    output[base + 20u] = shapes[0].y;
    output[base + 21u] = shapes[0].z;
    output[base + 22u] = shapes[1].x;
    output[base + 23u] = shapes[1].y;
    output[base + 24u] = shapes[1].z;
    output[base + 25u] = unsigned(inferred[0][0]);
    output[base + 26u] = unsigned(inferred[0][1]);
    output[base + 27u] = unsigned(inferred[0][2]);
    output[base + 28u] = unsigned(inferred[1][0]);
    output[base + 29u] = unsigned(inferred[1][1]);
    output[base + 30u] = unsigned(inferred[1][2]);
    output[base + 31u] = unsigned(marker);
}

__device__ int matrix_sum(const Matrix rows) {
    return rows[0][0] + rows[1][2];
}
