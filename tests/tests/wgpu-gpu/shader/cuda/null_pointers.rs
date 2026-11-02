use super::{module_case, ShaderBuffer, ShaderTest};

const SENTINEL: u32 = 0xdead_beef;
const VALUE_INDEX: usize = 24;
const CHOICE_INDEX: usize = 28;

const HELPERS: &str = "
    __device__ unsigned present(const unsigned *values) { return values != 0 ? 1u : 0u; }
    __device__ unsigned guarded_read(const unsigned *values, unsigned fallback) {
        if (!values) return fallback;
        return values[0];
    }
    __device__ void bump(unsigned *values, unsigned amount) {
        if (values) values[0] += amount;
    }
    __device__ void forward(unsigned *values, unsigned amount) { bump(values, amount); }
";

pub(super) fn cases() -> Vec<ShaderTest> {
    let mut tests = vec![transitions()];
    tests.extend([single_family(0), single_family(1)]);
    tests.extend([
        multiple_families(0),
        multiple_families(1),
        multiple_families(2),
    ]);
    tests.push(literal_argument_winners());
    tests.extend([
        transitions_and_calls(),
        conditional_guards(),
        helper_reentry(),
    ]);
    tests
}

fn literal_argument_winners() -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..14].copy_from_slice(&[
        101, 101, 113, 125, 117, 131, 143, 157, 169, 183, 159, 171, 187, 201,
    ]);
    output_case(
        "literal zero selects pointer overloads in ordinary explicit binary and logical calls",
        "struct Box { unsigned value; };
        __device__ unsigned selected(unsigned *value) { return value == 0 ? 101u : 901u; }
        __device__ unsigned selected(dim3 value) { return 1101u; }
        __device__ unsigned operator+(Box left, unsigned *right) {
            if (right) return 901u;
            return 110u + left.value;
        }
        __device__ unsigned operator+(Box left, dim3 right) { return 1110u + left.value; }
        __device__ unsigned operator+(unsigned *left, Box right) { return left == 0 ? 120u + right.value : 901u; }
        __device__ unsigned operator+(dim3 left, Box right) { return 1120u + right.value; }
        __device__ unsigned operator&&(Box left, unsigned *right) { return right == 0 ? 130u + left.value : 901u; }
        __device__ unsigned operator&&(Box left, dim3 right) { return 1130u + left.value; }
        __device__ unsigned operator&&(unsigned *left, Box right) { return left == 0 ? 140u + right.value : 901u; }
        __device__ unsigned operator&&(dim3 left, Box right) { return 1140u + right.value; }
        __device__ unsigned operator||(Box left, unsigned *right) { return right == 0 ? 150u + left.value : 901u; }
        __device__ unsigned operator||(Box left, dim3 right) { return 1150u + left.value; }
        __device__ unsigned operator||(unsigned *left, Box right) { return left == 0 ? 160u + right.value : 901u; }
        __device__ unsigned operator||(dim3 left, Box right) { return 1160u + right.value; }
        __global__ void kernel(unsigned *output) {
            output[0] = selected(0);
            output[1] = selected((0u));
            output[2] = operator+(Box{3u}, 0);
            output[3] = operator+(0, Box{5u});
            output[4] = Box{7u} + 0;
            output[5] = 0 + Box{11u};
            output[6] = Box{13u} && 0;
            output[7] = 0 && Box{17u};
            output[8] = Box{19u} || 0;
            output[9] = 0 || Box{23u};
            output[10] = operator&&(Box{29u}, 0);
            output[11] = operator&&(0, Box{31u});
            output[12] = operator||(Box{37u}, 0);
            output[13] = operator||(0, Box{41u});
        }",
        &initial,
        &expected,
    )
}

fn transitions() -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[VALUE_INDEX] = 53;
    let mut expected = initial;
    expected[..15].copy_from_slice(&[0, 1, 71, 0, 1, 60, 73, 1, 1, 0, 60, 0, 1, 0, 63]);
    expected[VALUE_INDEX] = 63;
    let source = format!(
        "{HELPERS}
        __global__ void kernel(unsigned *output) {{
            unsigned *selected = 0;
            output[0] = unsigned(bool(selected));
            output[1] = unsigned(selected == 0);
            forward(selected, 1000u);
            output[2] = guarded_read(selected, 71u);
            selected = output + 24;
            unsigned *saved = selected;
            selected = 0;
            output[3] = present(selected);
            output[4] = present(saved);
            forward(saved, 7u);
            forward(selected, 1000u);
            output[5] = guarded_read(saved, 73u);
            output[6] = guarded_read(selected, 73u);
            saved = 0;
            output[7] = unsigned(!saved);
            output[8] = unsigned(0 == saved);
            output[9] = unsigned(0 != saved);
            output[10] = output[24];
            for (unsigned iteration = 0; iteration < 3u; ++iteration) {{
                unsigned *temporary = 0;
                if (iteration == 1u) temporary = output + 24;
                forward(temporary, 3u);
                output[11u + iteration] = present(temporary);
            }}
            output[14] = output[24];
        }}"
    );
    output_case(
        "typed null values retain copies, guarded helper arguments and fresh null loop initialization",
        &source,
        &initial,
        &expected,
    )
}

fn single_family(choice: u32) -> ShaderTest {
    let mut initial = [SENTINEL; 32];
    initial[VALUE_INDEX] = 53;
    initial[CHOICE_INDEX] = choice;
    let mut expected = initial;
    let values = if choice == 0 {
        [1, 0, 97, 1, 1, 58, 58, 7]
    } else {
        [3, 1, 56, 3, 0, 99, 56, 4]
    };
    expected[..8].copy_from_slice(&values);
    expected[VALUE_INDEX] = values[6];
    let source = format!(
        "{HELPERS}
        __global__ void kernel(unsigned *output) {{
            bool choose = output[28] != 0u;
            unsigned counter = 0u;
            unsigned *selected = (++counter, choose) ? (counter += 2u, output + 24) : 0;
            output[0] = counter;
            output[1] = present(selected);
            if (selected) *selected += 3u;
            const unsigned *view = selected;
            output[2] = guarded_read(view, 97u);
            output[3] = counter;
            selected = (++counter, choose) ? 0 : (counter += 5u, output + 24);
            output[4] = present(selected);
            forward(selected, 5u);
            output[5] = guarded_read(selected, 99u);
            output[6] = output[24];
            output[7] = counter;
        }}"
    );
    output_case(
        &format!("one real pointer origin and null preserve branch effects for choice {choice}"),
        &source,
        &initial,
        &expected,
    )
}

fn multiple_families(choice: u32) -> ShaderTest {
    let first = [13, 17, 19, 23];
    let second = [29, 41, 43, 47];
    let mut initial = [SENTINEL; 32];
    initial[CHOICE_INDEX] = choice;
    let mut expected = initial;
    let (leading, final_first, final_second, effects) = match choice {
        0 => ([0, 0, 83, 0, 89, 0, 0, 1], first, second, 0),
        1 => (
            [0, 1, 24, 1, 40, 1, 1, 1],
            [13, 24, 19, 23],
            [40, 41, 43, 47],
            2,
        ),
        2 => (
            [0, 1, 48, 1, 24, 1, 1, 1],
            [24, 17, 19, 23],
            [29, 48, 43, 47],
            2,
        ),
        _ => unreachable!(),
    };
    expected[..8].copy_from_slice(&leading);
    expected[8..12].copy_from_slice(&final_first);
    expected[12..16].copy_from_slice(&final_second);
    expected[16] = effects;
    let source = format!(
        "{HELPERS}
        __global__ void kernel(unsigned *output, unsigned *first, unsigned *second) {{
            unsigned choice = output[28];
            unsigned *selected = 0;
            if (choice == 1u) selected = first + 1;
            else if (choice == 2u) selected = second + 1;
            unsigned *saved = selected;
            selected = 0;
            forward(saved, 7u);
            forward(selected, 1000u);
            output[0] = present(selected);
            output[1] = present(saved);
            output[2] = guarded_read(saved, 83u);
            output[3] = unsigned(saved != 0);
            selected = choice == 0u ? 0 : (choice == 1u ? second : first);
            forward(selected, 11u);
            output[4] = guarded_read(selected, 89u);
            output[5] = present(selected);
            unsigned effects = 0u;
            output[6] = unsigned(selected && (++effects, true));
            output[7] = unsigned(!selected || (++effects, true));
            for (unsigned index = 0; index < 4u; ++index) {{
                output[8u + index] = first[index];
                output[12u + index] = second[index];
            }}
            output[16] = effects;
        }}"
    );
    module_case(
        &format!(
            "nullable pointers preserve two real origins and helper remapping for choice {choice}"
        ),
        &source,
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![
            ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: false },
                &initial,
            ),
            ShaderBuffer::new(
                1,
                wgpu::BufferBindingType::Storage { read_only: false },
                &first,
            ),
            ShaderBuffer::new(
                2,
                wgpu::BufferBindingType::Storage { read_only: false },
                &second,
            ),
        ],
        0,
        [1, 1, 1],
    )
}

fn output_case(name: &str, source: &str, initial: &[u32], expected: &[u32]) -> ShaderTest {
    module_case(name, source, [1, 1, 1], expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            initial,
        )],
        0,
        [1, 1, 1],
    )
}

fn guarded_case(name: &str, source: &str, leading: &[u32], writes: &[(usize, u32)]) -> ShaderTest {
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..leading.len()].copy_from_slice(leading);
    for &(index, value) in writes {
        expected[index] = value;
    }
    module_case(name, source, [1, 1, 1], &expected).module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &initial,
        )],
        0,
        [1, 1, 1],
    )
}

fn transitions_and_calls() -> ShaderTest {
    guarded_case(
        "typed null pointers retain values across copies assignments and helper calls",
        "__device__ unsigned read(const unsigned *pointer) { return pointer ? *pointer : 7u; }
        __device__ unsigned flag(bool value) { return value ? 3u : 5u; }
        __device__ unsigned view(const bool &value) { return value ? 7u : 11u; }
        template<class Value> __device__ unsigned empty(const Value *pointer) { return unsigned(!pointer); }
        __global__ void kernel(unsigned *output) {
            unsigned values[2]{19u, 23u};
            unsigned *pointer = 0;
            const unsigned *saved = pointer;
            output[0] = read(pointer);
            output[1] = unsigned(!pointer);
            output[2] = unsigned(pointer == 0);
            output[3] = flag(pointer);
            output[4] = view(pointer);
            pointer = values + 1;
            output[5] = read(pointer);
            output[6] = unsigned(bool(pointer));
            output[7] = unsigned(0u != pointer);
            output[8] = flag(pointer);
            output[9] = view(pointer);
            output[10] = unsigned(bool(saved));
            pointer = 0;
            output[11] = read(pointer);
            output[12] = read(0);
            output[13] = unsigned(static_cast<bool>(pointer));
            output[14] = empty<unsigned>(0);
            output[15] = empty<const unsigned>(0);
        }",
        &[7, 1, 1, 5, 11, 23, 1, 1, 3, 7, 0, 7, 7, 0, 1, 1],
        &[],
    )
}

fn conditional_guards() -> ShaderTest {
    let source = "__global__ void kernel(unsigned *output) {
        unsigned values[2]{3u, 5u};
        bool choose = threadIdx.x == 0u;
        unsigned counter = 0u;
        unsigned *absent = choose ? 0 : output + 24;
        if (absent) *absent = 101u;
        else ++counter;
        output[0] = counter;
        counter = 0u;
        output[1] = unsigned(absent && (++counter != 0u));
        output[2] = counter;
        output[3] = unsigned(absent || (++counter != 0u));
        output[4] = counter;
        unsigned *present = choose ? output + 25 : 0;
        if (present != 0) *present = 13u;
        output[5] = unsigned(bool(present));
        const unsigned *also_absent = choose ? 0 : output + 26;
        output[6] = unsigned(also_absent == 0);
        unsigned *end = values + 2;
        output[7] = unsigned(bool(end));
        output[8] = unsigned(end == 0);
        unsigned *copied_empty{};
        unsigned *assigned_empty = {};
        output[9] = unsigned(!copied_empty);
        output[10] = unsigned(!assigned_empty);
    }";
    let initial = [SENTINEL; 32];
    let mut expected = initial;
    expected[..11].copy_from_slice(&[1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1]);
    expected[25] = 13;
    module_case(
        "nullable conditionals preserve guards short circuiting and one past truth",
        source,
        [1, 1, 1],
        &expected,
    )
    .module_buffers(
        vec![ShaderBuffer::new(
            0,
            wgpu::BufferBindingType::Storage { read_only: false },
            &initial,
        )],
        0,
        [1, 1, 1],
    )
}

fn helper_reentry() -> ShaderTest {
    guarded_case(
        "guarded nullable helper reentry preserves local workgroup and storage origins",
        "__device__ unsigned update(unsigned *pointer, unsigned &counter) {
            if (pointer == 0) return 7u;
            *pointer += ++counter;
            return *pointer;
        }
        __global__ void kernel(unsigned *output) {
            unsigned local = 3u;
            __shared__ unsigned shared[1];
            shared[0] = 11u;
            unsigned counter = 0u;
            unsigned *pointer{};
            output[0] = update(pointer, counter);
            pointer = &local;
            output[1] = update(pointer, counter);
            unsigned *saved = pointer;
            pointer = 0;
            output[2] = update(pointer, counter);
            output[3] = update(saved, counter);
            pointer = shared;
            output[4] = update(pointer, counter);
            pointer = output + 20;
            *pointer = 17u;
            output[5] = update(pointer, counter);
            pointer = 0;
            output[6] = update(pointer, counter);
            output[7] = local;
            output[8] = shared[0];
            output[9] = counter;
            output[10] = output[20];
        }",
        &[7, 4, 7, 6, 14, 21, 7, 6, 14, 4, 21],
        &[(20, 21)],
    )
}
