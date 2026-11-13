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
    output[11] = unsigned(sizeof((values)));
    output[12] = unsigned(sizeof (record).matrix);
    output[13] = unsigned(sizeof *((record).matrix));
    output[14] = unsigned(sizeof (*(records)).vector);
    output[15] = unsigned(sizeof(1LL));
    output[16] = unsigned(sizeof true);
    output[17] = unsigned(sizeof((nullptr)));
    output[18] = unsigned(sizeof(0x1.8p+2f));
    output[19] = unsigned(sizeof(+reference.z));
    output[20] = unsigned(sizeof(!output));
    output[21] = unsigned(sizeof(~true));
    output[22] = unsigned(sizeof(-1L));
    output[23] = unsigned(sizeof(+values));
    output[24] = unsigned(sizeof(*+values));
    output[25] = unsigned(sizeof values[0]);
    output[26] = unsigned(sizeof record.matrix[0]);
    output[27] = unsigned(sizeof 0[record.matrix][1]);
    output[28] = unsigned(sizeof records[999].vector.z);
    output[29] = unsigned(sizeof values[0xffffffffffffffffULL].x);
}
