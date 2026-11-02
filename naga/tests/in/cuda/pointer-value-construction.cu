using Pointer = unsigned *;
using ReadPointer = const unsigned *;
using FixedPointer = Pointer const;

template<class Value> __device__ unsigned absent() {
    Value value = Value{};
    return value ? 37u : 41u;
}

template<class Value> __device__ unsigned read_copy(Value source) {
    Value copy = Value(source);
    return *copy;
}

__device__ void bump(Pointer value, unsigned &counter, unsigned amount) {
    ++counter;
    if (value) *value += amount;
}

__global__ void pointer_value_construction(unsigned *output) {
    unsigned local[4]{3u, 5u, 7u, 11u};
    __shared__ unsigned shared[3];
    shared[0] = 13u;
    shared[1] = 17u;
    shared[2] = 19u;
    output[32] = 23u;
    output[33] = 29u;
    output[34] = 31u;

    Pointer empty = Pointer();
    Pointer braced_empty = Pointer{};
    Pointer from_zero = Pointer(0);
    Pointer from_braced_zero = Pointer{0u};
    ReadPointer qualified_null = static_cast<ReadPointer>(nullptr);
    Pointer cast_null = (Pointer)nullptr;

    Pointer cursor = local;
    Pointer functional = Pointer(cursor);
    Pointer braced = Pointer{cursor + 1};
    Pointer named = static_cast<Pointer>(cursor + 2);
    Pointer c_style = (Pointer)(cursor + 3);
    cursor = shared;
    *functional += 2u;
    *braced += 3u;
    *named += 5u;
    *c_style += 7u;
    unsigned first_copy = *functional;

    ReadPointer read_functional = ReadPointer(functional);
    ReadPointer read_braced = ReadPointer{braced};
    ReadPointer read_named = static_cast<ReadPointer>(named);
    ReadPointer read_c_style = (ReadPointer)c_style;
    unsigned qualified_sum = *read_functional + *read_braced + *read_named + *read_c_style;

    FixedPointer fixed = shared + 1;
    auto mutable_copy = FixedPointer(fixed);
    ++mutable_copy;
    *mutable_copy += 11u;
    auto braced_fixed = FixedPointer{fixed};
    ++braced_fixed;
    unsigned fixed_snapshot = *fixed;

    cursor = local;
    unsigned functional_snapshot = Pointer(cursor)[(cursor = shared, 1u)];
    cursor = shared;
    unsigned braced_snapshot = Pointer{cursor}[(cursor = output + 32, 2u)];
    cursor = output + 32;
    unsigned named_snapshot = static_cast<Pointer>(cursor)[(cursor = local, 1u)];
    cursor = local;
    unsigned c_style_snapshot = ((Pointer)cursor)[(cursor = shared, 0u)];

    unsigned counter = 0u;
    unsigned index = 0u;
    Pointer captured = Pointer{(++counter, &local[index++])};
    unsigned &live = *Pointer(captured);
    captured = Pointer(shared + 1);
    index = 3u;
    live += 13u;
    ReadPointer frozen = static_cast<ReadPointer>((++counter, &local[index--]));
    index = 0u;
    *functional += 2u;
    unsigned after_capture = counter;

    Pointer selected = Pointer{};
    unsigned guarded_total = 0u;
    for (unsigned branch = 0u; branch < 3u; ++branch) {
        selected = branch == 0u ? Pointer{} : branch == 1u
            ? Pointer{shared + 1} : Pointer(output + 32);
        Pointer saved = static_cast<Pointer>(selected);
        selected = (Pointer)nullptr;
        if (saved) {
            *saved += branch;
            guarded_total += *saved;
        }
        output[22u + branch] = unsigned(!selected) + 2u * unsigned(bool(saved));
    }

    Pointer kept = Pointer(output + 33);
    Pointer old_null = Pointer(selected);
    selected = Pointer{kept};
    kept = Pointer{};
    if (old_null) output[34] += 1000u;
    if (selected) *selected += 5u;
    unsigned selected_snapshot = *selected;
    const bool &present = Pointer{selected};
    selected = Pointer();
    bump(Pointer{(++counter, output + 34)}, counter, 7u);
    bump(Pointer(), counter, 1000u);

    output[0] = unsigned(!empty) + unsigned(!braced_empty) + unsigned(!from_zero)
        + unsigned(!from_braced_zero) + unsigned(!qualified_null) + unsigned(!cast_null);
    output[1] = absent<Pointer>() + absent<ReadPointer>();
    output[2] = first_copy;
    output[3] = *braced;
    output[4] = *named;
    output[5] = *c_style;
    output[6] = *cursor;
    output[7] = qualified_sum;
    output[8] = fixed_snapshot;
    output[9] = *mutable_copy;
    output[10] = *braced_fixed;
    output[11] = functional_snapshot;
    output[12] = braced_snapshot;
    output[13] = named_snapshot;
    output[14] = c_style_snapshot;
    output[15] = *cursor;
    output[16] = live;
    output[17] = *captured;
    output[18] = *frozen;
    output[19] = index;
    output[20] = after_capture;
    output[21] = read_copy<Pointer>(Pointer(local))
        + read_copy<ReadPointer>(static_cast<ReadPointer>(shared));
    output[25] = guarded_total;
    output[26] = unsigned(!kept) + unsigned(!old_null);
    output[27] = selected_snapshot;
    output[28] = unsigned(present) + 2u * unsigned(!selected);
    output[29] = counter;
    output[30] = read_copy<Pointer>(Pointer(local + 2));
    output[31] = unsigned(!Pointer()) + unsigned(!Pointer{});
    output[35] = local[0];
    output[36] = local[1];
    output[37] = shared[1];
    output[38] = shared[2];
    output[39] = unsigned(!old_null) + unsigned(present) + unsigned(!selected);
}
