typedef int *IntPointer, Integer, *const FixedPointer;
using ReadPointer = const int *;
using Chain = IntPointer;
using FrozenPointer = Chain const;
using VectorPointer = int2 *;
struct Record { int value; int2 pair; };
using RecordPointer = Record *;

__device__ int bump(IntPointer value);
__device__ int bump(int *const value) { return (*value)++; }
__device__ void copy(int &destination, const int &source) { destination = source; }
__device__ int atomicAdd(IntPointer, int);

__global__ void kernel(const Chain output) {
    int values[3]{2, 3, 5};
    IntPointer cursor = values, saved = cursor++;
    output[0] = *saved; output[1] = *cursor;
    FixedPointer fixed = values + 2; *fixed += 2;
    FrozenPointer frozen = values;
    auto movable = frozen; ++movable; *movable += 4;
    ReadPointer read = values;
    auto readable = read; ++readable; output[2] = *readable;
    Integer index = 0;
    IntPointer pending; pending = &values[index++]; index = 2;
    *pending += 1; output[3] = *pending; output[4] = index;
    output[5] = bump(cursor); copy(output[6], values[1]);
    int2 point{11, 13}; VectorPointer point_alias = &point;
    (*point_alias).x += 2; output[7] = point.x; output[8] = point.y;
    Record record{17, {19, 23}}; RecordPointer record_alias = &record;
    record_alias->pair.y += 2; output[9] = record.value; output[10] = record.pair.y;
    { using IntPointer = const int *; IntPointer local = values; output[11] = *local; }
    IntPointer restored = values + 2; output[12] = *restored;
    output[13] = atomicAdd(output + 20, 3); output[14] = *saved;
}
