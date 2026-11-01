using Shape = dim3;
__device__ unsigned encode(Shape value) { return value.x + 10u * value.y + 100u * value.z; }
__device__ Shape grow(Shape value) { ++value.y; return value; }
__device__ unsigned kind(dim3 value) { return 11u; }
__device__ unsigned kind(uint3 value) { return 22u; }

__global__ void dimensions(unsigned *output) {
    dim3 default_shape; const Shape fixed;
    dim3 first(2u), second(3u, 4u), third(5u, 6u, 7u), zero(0u, 0u, 0u);
    Shape copied = third; ++copied.x;
    uint3 packed = copied; dim3 rebuilt = packed;
    auto automatic = fixed; automatic.z = 9u;
    output[0] = default_shape.x; output[1] = default_shape.y; output[2] = default_shape.z;
    output[3] = encode(fixed); output[4] = encode(first); output[5] = encode(second);
    output[6] = encode(third); output[7] = encode(copied); output[8] = encode(rebuilt);
    output[9] = encode(automatic); output[10] = zero.x + zero.y + zero.z;
    Shape grown = grow(third); output[11] = grown.y; output[12] = third.y;
    output[13] = kind(rebuilt); output[14] = kind(packed);
    dim3 scalar_copy = 8u; output[15] = encode(scalar_copy);
    dim3 converted(1.75f, 2, true); output[16] = encode(converted);
    uint3 direct(copied); uint3 expression = uint3(copied); dim3 braced{packed};
    output[17] = direct.x; output[18] = expression.z; output[19] = encode(braced);
    uint3 raw{2u, 3u, 4u}; const dim3 &snapshot = raw; ++raw.x;
    output[20] = snapshot.x; output[21] = raw.x;
    dim3 source(5u, 6u, 7u); const uint3 &reverse = source; ++source.y;
    output[22] = reverse.y; output[23] = source.y;
    const dim3 &live{source}; ++source.z;
    output[24] = live.z; output[25] = source.z;
    dim3 object((dim3())); output[26] = encode(object);
}
