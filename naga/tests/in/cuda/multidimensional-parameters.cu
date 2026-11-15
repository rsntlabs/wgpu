using Row = int[3];
__device__ int read_grid(const int[][3]);
__device__ int read_grid(const int values[4294967295u][3]) { return values[0][0] + values[1][2]; }
__device__ int adjust_grid(int values[][3], int amount) { values[1][2] += amount; return values[1][2]; }
__device__ int read_cube(const int values[][2][3]) { return values[0][0][0] + values[1][1][2]; }
__device__ int read_alias(const Row values[][2]) { return values[0][0][0] + values[1][1][2]; }
__global__ void multidimensional_parameters(const int input[][3], unsigned output[4][20]) {
    unsigned lane = threadIdx.x;
    output[lane][4] = unsigned(input[lane][0]);
    output[lane][5] = unsigned(input[lane][1]);
    output[lane][6] = unsigned(input[lane][2]);
    int values[2][3] = {{input[lane][0], 2, 3}, {4, 5, 6}};
    output[lane][7] = unsigned(read_grid(values));
    adjust_grid(values, input[lane][1]);
    output[lane][8] = unsigned(read_grid(values));
    int cube[2][2][3] = {{{1, 2, 3}, {4, 5, 6}}, {{7, 8, 9}, {10, 11, 12}}};
    int cursor = 0;
    output[lane][9] = unsigned(read_grid(cube[cursor++]));
    output[lane][10] = unsigned(cursor);
    output[lane][11] = unsigned(read_cube(cube));
    output[lane][12] = unsigned(read_alias(cube));
    output[lane][13] = unsigned(adjust_grid(values, cursor++));
    output[lane][14] = unsigned(cursor);
    output[lane][15] = unsigned(values[1][2]);
}
