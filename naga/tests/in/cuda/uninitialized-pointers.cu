__global__ void kernel(int *out) {
    int first[3]{2, 3, 5};
    int second[3]{7, 11, 13};
    int *selected;
    selected = first + 1;
    int *saved;
    saved = selected;
    selected = second + 2;
    const int *view;
    view = selected;
    out[0] = *saved;
    out[1] = *selected;
    out[2] = *view;
}
