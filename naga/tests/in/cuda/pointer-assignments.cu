__global__ void pointer_assignments(int *out) {
    int first[4]{2, 3, 5, 7};
    int second[4]{11, 13, 17, 19};
    bool choose = bool(out[30]);
    int *pointer = first;
    int *copy = pointer;
    int &bound = *pointer;
    pointer = second + 1;
    out[0] = *pointer;
    out[1] = *copy;
    out[2] = bound;
    if (choose) pointer = first + 2;
    else pointer = second + 2;
    out[3] = *pointer;
    int *selected = pointer;
    pointer = first + 1;
    *selected += 20;
    out[4] = *pointer;
    out[5] = *selected;
    out[6] = *copy;
    out[7] = first[2];
    out[8] = second[2];
    pointer = first;
    for (int iteration = 0; iteration < 3; ++iteration) {
        out[9 + iteration] = *pointer;
        if (iteration == 0) pointer = second + 1;
        else pointer = first + 3;
    }
    out[12] = *pointer;
    pointer = copy;
    pointer = pointer + 1;
    out[13] = *pointer;
    pointer = copy;
    copy = pointer;
    out[14] = *copy;
    int *end = first + 4;
    pointer = end;
    out[15] = *(pointer - 1);
    (pointer = second)++;
    out[16] = *pointer;
    out[17] = *copy;
}
