#define CONCATENATE_RAW(left, right) left ## right
#define CONCATENATE(left, right) CONCATENATE_RAW(left, right)
#define SOURCE_NAME expanded
#define JOINED_NUMBER 6 ## 3
#define SELECTED 29u
#define CALL_JOINED(prefix, suffix, counter, value) prefix ## suffix(counter, value)

__device__ unsigned int CONCATENATE_RAW(ad, just)(unsigned int value) {
    return value + 3u;
}

__device__ unsigned int observe(unsigned int &counter, unsigned int value) {
    counter += 1u;
    return value;
}

extern "C" __global__ void token_pasting(unsigned int *out) {
    CONCATENATE_RAW(un, signed) int typed_value = 7u;
    unsigned int local_value = 11u;
    unsigned int SOURCE_NAME_tail = 13u;
    unsigned int expanded_tail = 17u;

    out[0] = typed_value;
    out[1] = CONCATENATE_RAW(local, _value);
    out[2] = CONCATENATE_RAW(SOURCE_NAME, _tail);
    out[3] = CONCATENATE(SOURCE_NAME, _tail);
    out[4] = CONCATENATE_RAW(23, u);
    out[5] = CONCATENATE_RAW(0x2a, u);
    out[6] = __float_as_uint(CONCATENATE_RAW(1.5, f));
    out[7] = __float_as_uint(CONCATENATE_RAW(0x1p, 2f));
    out[8] = (3u CONCATENATE_RAW(<, =) 4u) ? 1u : 0u;
    out[9] = 32u CONCATENATE_RAW(>, >) 2u;

    unsigned int updated = 9u;
    updated CONCATENATE_RAW(+, =) 5u;
    out[10] = updated;
    out[11] = JOINED_NUMBER;
    out[12] = CONCATENATE_RAW(SE, LECTED);
    out[13] = CONCATENATE_RAW(ad, just)(5u);
    out[14] = CONCATENATE_RAW(, 19u);
    out[15] = CONCATENATE_RAW(21u, );
    out[16] = 4u CONCATENATE_RAW(, ) + 5u;
    out[17] = CONCATENATE_RAW(/*empty*/, 23u);

    unsigned int value = 10u;
    out[18] = CONCATENATE_RAW(3u + val, ue + 2u);
    out[19] = CONCATENATE_RAW(2, u + 3u);

    unsigned int counter = 0u;
    out[20] = CONCATENATE_RAW(ob, serve)(counter, (++counter, 7u));
    out[21] = counter;
    out[22] = CALL_JOINED(ob, serve, counter, (++counter, 9u));
    out[23] = counter;
}
