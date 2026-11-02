use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;

pub(super) fn cases() -> Vec<ShaderTest> {
    vec![
        returned_class_values(),
        qualified_construction_and_members(),
        conditional_class_values(),
        conditional_member_values(),
    ]
}

fn returned_class_values() -> ShaderTest {
    let source = "struct Record { unsigned value; };
        using FrozenRecord = const Record;
        __device__ unsigned kind(Record &value) { return 10u; }
        __device__ unsigned kind(const Record &value) { return 20u; }
        template<class Value> __device__ unsigned value_kind(Value value) {
            return kind(value) + value.value;
        }
        template<class Value> __device__ unsigned reference_kind(Value &value) {
            return kind(value) + value.value;
        }
        __device__ const Record ordinary_record(unsigned value) { return Record{value}; }
        template<class Value> __device__ const Value frozen_record(unsigned value) {
            return Value{value};
        }
        template<class Value> __device__ Value exact_record(unsigned value) {
            return Value{value};
        }
        __global__ void kernel(unsigned *output) {
            output[0] = value_kind(ordinary_record(3u));
            output[1] = reference_kind(ordinary_record(5u));
            output[2] = value_kind(frozen_record<Record>(7u));
            output[3] = reference_kind(frozen_record<Record>(11u));
            output[4] = value_kind(exact_record<FrozenRecord>(13u));
            output[5] = reference_kind(exact_record<FrozenRecord>(17u));
            FrozenRecord immutable{19u};
            output[6] = value_kind(immutable);
            output[7] = reference_kind(immutable);
            Record mutable_record{21u};
            output[8] = reference_kind(mutable_record);
            output[9] = value_kind(mutable_record);
        }";
    guarded_case(
        "const class results keep reference constness while value deduction copies mutable values",
        source,
        &[13, 25, 17, 31, 23, 37, 29, 39, 31, 31],
    )
}

fn qualified_construction_and_members() -> ShaderTest {
    let source = "struct Leaf { unsigned value; };
        struct Record { Leaf nested; unsigned scalar; };
        using FrozenLeaf = const Leaf;
        using FrozenRecord = const Record;
        using FrozenScalar = const unsigned;
        __device__ unsigned kind(Leaf &value) { return 1u; }
        __device__ unsigned kind(const Leaf &value) { return 2u; }
        __device__ unsigned kind(unsigned &value) { return 3u; }
        __device__ unsigned kind(const unsigned &value) { return 4u; }
        template<class Value> __device__ unsigned value_kind(Value value) { return kind(value); }
        template<class Value> __device__ unsigned reference_kind(Value &value) { return kind(value); }
        __device__ const Record make_record(unsigned value) {
            return Record{Leaf{value}, value + 1u};
        }
        __global__ void kernel(unsigned *output) {
            output[0] = reference_kind(FrozenLeaf{3u});
            output[1] = value_kind(FrozenLeaf{5u});
            output[2] = reference_kind(make_record(7u).nested);
            output[3] = reference_kind(make_record(11u).scalar);
            output[4] = value_kind(make_record(13u).nested);
            output[5] = value_kind(make_record(17u).scalar);
            output[6] = unsigned(make_record(19u).scalar);
            output[7] = FrozenScalar(23u);
            output[8] = FrozenScalar(29u);
            output[9] = value_kind(FrozenScalar(31u));
            output[10] = value_kind(FrozenScalar(37u));
            output[11] = reference_kind(FrozenRecord{Leaf{41u}, 43u}.nested);
            output[12] = reference_kind(FrozenRecord{Leaf{47u}, 53u}.scalar);
            output[13] = make_record(59u).nested.value;
            output[14] = make_record(61u).scalar;
            output[15] = reference_kind(make_record(67u).nested.value);
            output[16] = value_kind(make_record(71u).nested.value);
            output[17] = unsigned(make_record(73u).nested.value);
        }";
    guarded_case(
        "qualified list construction preserves nested member constness and scalar casts keep their values",
        source,
        &[2, 1, 2, 4, 1, 3, 20, 23, 29, 3, 3, 2, 4, 59, 62, 4, 3, 73],
    )
}

fn conditional_class_values() -> ShaderTest {
    let source = "struct Record { unsigned value; };
        __device__ unsigned kind(Record &value) { return 1u; }
        __device__ unsigned kind(const Record &value) { return 2u; }
        template<class Value> __device__ unsigned value_score(Value value) {
            return kind(value) * 100u + value.value;
        }
        template<class Value> __device__ unsigned reference_score(Value &value) {
            return kind(value) * 100u + value.value;
        }
        __device__ const Record frozen_record(unsigned value) { return Record{value}; }
        __device__ Record mutable_record(unsigned value) { return Record{value}; }
        __global__ void kernel(unsigned *output) {
            bool choose = threadIdx.x == 0u;
            unsigned counter = 0u;
            output[0] = reference_score(choose ? frozen_record(++counter) : mutable_record(counter += 100u));
            output[1] = counter;
            output[2] = reference_score(choose ? mutable_record(++counter) : frozen_record(counter += 100u));
            output[3] = counter;
            output[4] = reference_score(!choose ? frozen_record(counter += 100u) : mutable_record(++counter));
            output[5] = counter;
            output[6] = reference_score(!choose ? mutable_record(counter += 100u) : frozen_record(++counter));
            output[7] = counter;
            output[8] = value_score(choose ? frozen_record(++counter) : mutable_record(counter += 100u));
            output[9] = counter;
            output[10] = value_score(!choose ? mutable_record(counter += 100u) : frozen_record(++counter));
            output[11] = counter;
        }";
    guarded_case(
        "class conditionals keep common constness and run only the chosen arm in either order",
        source,
        &[201, 1, 202, 2, 203, 3, 204, 4, 105, 5, 106, 6],
    )
}

fn conditional_member_values() -> ShaderTest {
    let source = "struct Leaf { unsigned value; };
        struct Record { Leaf nested; unsigned scalar; };
        __device__ unsigned kind(Leaf &value) { return 1u; }
        __device__ unsigned kind(const Leaf &value) { return 2u; }
        __device__ unsigned kind(unsigned &value) { return 3u; }
        __device__ unsigned kind(const unsigned &value) { return 4u; }
        template<class Value> __device__ unsigned value_leaf(Value value) {
            return kind(value) * 100u + value.value;
        }
        template<class Value> __device__ unsigned reference_leaf(Value &value) {
            return kind(value) * 100u + value.value;
        }
        template<class Value> __device__ unsigned value_scalar(Value value) {
            return kind(value) * 100u + value;
        }
        template<class Value> __device__ unsigned reference_scalar(Value &value) {
            return kind(value) * 100u + value;
        }
        __device__ const Record frozen_record(unsigned value) {
            return Record{Leaf{value}, value + 1u};
        }
        __device__ Record mutable_record(unsigned value) {
            return Record{Leaf{value}, value + 1u};
        }
        __global__ void kernel(unsigned *output) {
            bool choose = threadIdx.x == 0u;
            unsigned counter = 0u;
            output[0] = reference_leaf(choose ? frozen_record(++counter).nested : mutable_record(counter += 100u).nested);
            output[1] = reference_leaf(choose ? mutable_record(++counter).nested : frozen_record(counter += 100u).nested);
            output[2] = reference_scalar(!choose ? frozen_record(counter += 100u).scalar : mutable_record(++counter).scalar);
            output[3] = reference_scalar(!choose ? mutable_record(counter += 100u).scalar : frozen_record(++counter).scalar);
            output[4] = counter;
            output[5] = value_leaf(choose ? frozen_record(++counter).nested : mutable_record(counter += 100u).nested);
            output[6] = value_scalar(!choose ? mutable_record(counter += 100u).scalar : frozen_record(++counter).scalar);
            output[7] = counter;
        }";
    guarded_case(
        "nested class and scalar conditional members preserve xvalue constness and branch effects",
        source,
        &[201, 202, 404, 405, 4, 105, 307, 6],
    )
}

fn guarded_case(name: &str, source: &str, values: &[u32]) -> ShaderTest {
    let mut expected = [SENTINEL; 32];
    expected[..values.len()].copy_from_slice(values);
    module_case(name, source, [1, 1, 1], &expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &[SENTINEL; 32],
        )],
        0,
        [1, 1, 1],
    )
}
