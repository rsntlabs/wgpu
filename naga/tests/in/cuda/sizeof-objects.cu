struct Record { float3 vector; int matrix[2][3]; };

extern "C" __global__ void object_sizes(unsigned *output) {
    float3 values[2];
    float3 &reference = values[0];
    Record record;
    Record records[2];
    output[0] = unsigned(sizeof values);
    output[1] = unsigned(sizeof(reference));
    output[2] = unsigned(sizeof(output));
    output[3] = unsigned(sizeof(record.vector));
    output[4] = unsigned(sizeof records->matrix);
    output[5] = unsigned(sizeof(records->vector.z));
    output[6] = unsigned(sizeof values->x);
    output[7] = unsigned(sizeof *values);
    output[8] = unsigned(sizeof(*record.matrix));
    output[9] = unsigned(sizeof(**record.matrix));
    output[10] = unsigned(sizeof(*records));
}
