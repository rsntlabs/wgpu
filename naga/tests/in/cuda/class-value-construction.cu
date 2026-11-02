struct Leaf {
    unsigned values[2];
    dim3 shape;
};

struct Record {
    unsigned tag;
    Leaf leaves[2];
    int2 pair;
};

using FrozenRecord = const Record;
using FrozenPair = const int2;
using FrozenTriple = const uint3;

__device__ unsigned reference_kind(Record &value) { return 11u; }
__device__ unsigned reference_kind(const Record &value) { return 13u; }
__device__ unsigned reference_kind(int2 &value) { return 17u; }
__device__ unsigned reference_kind(const int2 &value) { return 19u; }
__device__ unsigned reference_kind(uint3 &value) { return 23u; }
__device__ unsigned reference_kind(const uint3 &value) { return 29u; }

template<class Value> __device__ unsigned inspect(Value &value) {
    return reference_kind(value);
}

__device__ Record produce_record(unsigned &counter) {
    ++counter;
    Record value = Record();
    value.tag = counter;
    value.leaves[0].values[0] = counter + 10u;
    return value;
}

__device__ int2 produce_pair(unsigned &counter) {
    ++counter;
    int2 value{int(counter), int(counter + 1u)};
    return value;
}

__global__ void class_value_construction(unsigned *output) {
    const int2 pair_source{61, 67};
    int2 pair_functional = int2(pair_source);
    int2 pair_named = static_cast<int2>(pair_source);
    int2 pair_c_style = (int2)pair_source;
    int2 pair_empty = int2();
    pair_functional.x = 71;
    pair_named.y = 73;
    pair_c_style.x = 79;

    const uint3 triple_source{83u, 89u, 97u};
    uint3 triple_functional = uint3(triple_source);
    uint3 triple_named = static_cast<uint3>(triple_source);
    uint3 triple_c_style = (uint3)triple_source;
    uint3 triple_empty = uint3();
    triple_functional.x = 101u;
    triple_named.y = 103u;
    triple_c_style.z = 107u;

    const Record record_source{
        3u,
        {
            {{5u, 7u}, dim3(11u, 13u, 17u)},
            {{19u, 23u}, dim3(29u, 31u, 37u)}
        },
        {41, 43}
    };
    Record record_functional = Record(record_source);
    Record record_named = static_cast<Record>(record_source);
    Record record_c_style = (Record)record_source;
    Record record_empty = Record();
    record_functional.leaves[0].values[0] = 47u;
    record_named.leaves[1].shape.y = 53u;
    record_c_style.leaves[0].shape.x = 59u;

    unsigned counter = 0u;
    Record first = Record(produce_record(counter));
    Record second = static_cast<Record>(++counter, produce_record(counter));
    Record third = (Record)(++counter, produce_record(counter));
    Record fourth = Record((++counter, produce_record(counter)));
    Record first_snapshot = Record(first);
    first.tag = 109u;
    first.leaves[0].values[0] = 113u;
    int2 effect_pair = int2((++counter, produce_pair(counter)));

    output[0] = unsigned(pair_source.x);
    output[1] = unsigned(pair_functional.x);
    output[2] = unsigned(pair_named.y);
    output[3] = unsigned(pair_c_style.x);
    output[4] = unsigned(pair_functional.y);
    output[5] = unsigned(pair_empty.x + pair_empty.y);
    output[6] = triple_source.y;
    output[7] = triple_functional.x;
    output[8] = triple_named.y;
    output[9] = triple_c_style.z;
    output[10] = triple_functional.z;
    output[11] = triple_empty.x + triple_empty.y + triple_empty.z;
    output[12] = record_source.leaves[0].values[0];
    output[13] = record_functional.leaves[0].values[0];
    output[14] = record_named.leaves[1].shape.y;
    output[15] = record_c_style.leaves[0].shape.x;
    output[16] = record_source.leaves[1].shape.y;
    output[17] = unsigned(record_functional.pair.x);
    output[18] = record_empty.tag + record_empty.leaves[0].values[0]
        + record_empty.leaves[0].values[1] + record_empty.leaves[1].values[0]
        + record_empty.leaves[1].values[1] + unsigned(record_empty.pair.x)
        + unsigned(record_empty.pair.y);
    output[19] = record_empty.leaves[0].shape.x + record_empty.leaves[0].shape.y
        + record_empty.leaves[0].shape.z + record_empty.leaves[1].shape.x
        + record_empty.leaves[1].shape.y + record_empty.leaves[1].shape.z;
    output[20] = first_snapshot.tag;
    output[21] = second.tag;
    output[22] = third.tag;
    output[23] = fourth.tag;
    output[24] = counter;
    output[25] = first_snapshot.leaves[0].values[0];
    output[26] = first.tag;
    output[27] = first.leaves[0].values[0];
    output[28] = unsigned(effect_pair.x);
    output[29] = unsigned(effect_pair.y);
    output[30] = inspect(FrozenRecord(record_source))
        + inspect(static_cast<FrozenRecord>(record_source))
        + inspect((FrozenRecord)record_source);
    output[31] = inspect(FrozenPair(pair_source))
        + inspect(static_cast<FrozenPair>(pair_source))
        + inspect((FrozenPair)pair_source);
    output[32] = inspect(FrozenTriple(triple_source))
        + inspect(static_cast<FrozenTriple>(triple_source))
        + inspect((FrozenTriple)triple_source);
    output[33] = inspect(record_functional) + inspect(pair_functional) + inspect(triple_functional);
    output[34] = record_empty.leaves[0].shape.x;
    output[35] = record_empty.leaves[1].shape.z;
    output[36] = record_source.tag;
    output[37] = unsigned(first_snapshot.pair.x);
    output[38] = second.leaves[1].shape.z;
    output[39] = third.leaves[0].values[1];
}
