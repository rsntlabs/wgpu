__global__ void pointer_updates(int *out) {
    int values[8]{2, 3, 5, 7, 11, 13, 17, 19};
    int *pointer = values, *saved = pointer;
    int total = 0;
    for (int iteration = 0; iteration < 4; ++iteration) {
        total += *pointer;
        ++pointer;
    }
    out[0] = total;
    out[1] = *pointer;
    out[2] = *saved;
    int *old = pointer++;
    out[3] = *old;
    out[4] = *pointer;
    out[5] = *--pointer;
    pointer += 2;
    out[6] = *pointer;
    pointer -= 3;
    out[7] = *pointer;
    ++(++pointer);
    out[8] = *pointer;
    --(--pointer);
    out[9] = *pointer;
    int *updated = (pointer += 2);
    ++pointer;
    out[10] = *updated;
    out[11] = *pointer;
    bool choose = bool(out[30]);
    if (choose) --pointer;
    else pointer -= 2;
    out[12] = *pointer;
    values[0] = 23;
    out[13] = *saved;
    const int *view = pointer;
    ++view;
    out[14] = *view;
    int *const fixed = values + 1;
    *fixed += 4;
    out[15] = *fixed;
    int iteration = 0;
    while (iteration < 3) {
        out[16 + iteration] = *pointer;
        ++pointer;
        ++iteration;
    }
    --pointer;
    out[19] = *pointer;
    int reset_total = 0;
    for (int item = 0; item < 3; ++item) {
        int *local = values + item;
        reset_total += *local;
        ++local;
        reset_total += *local;
    }
    out[20] = reset_total;
    int *reference_pointer = values + 1;
    int &bound = *reference_pointer;
    ++reference_pointer;
    bound += 2;
    out[21] = bound;
    out[22] = *reference_pointer;
    out[23] = *saved;
    int *end = values + 8;
    --end;
    out[24] = *end;
    end -= 2;
    out[25] = *end;
    out[31] = iteration;
}
