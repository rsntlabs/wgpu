# Experimental CUDA frontend

The `cuda-in` feature parses a restricted subset of CUDA kernel source directly
into Naga IR. The resulting module uses the existing WGSL, SPIR-V, GLSL, HLSL,
and Metal backends. It does not require an NVIDIA driver or CUDA toolkit.
The initial implementation accepts the source subset described below.

```cuda
extern "C" __global__ void add(const float *a, const float *b, float *out, unsigned int n) {
    unsigned int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n) {
        out[i] = a[i] + b[i] * 2.0f;
    }
}
```

Convert this kernel with:

```sh
cargo run -p naga-cli -- input.cu output.wgsl --cuda-workgroup-size 64,1,1
```

For a source with several kernels, add `--entry-point add` to emit only that
kernel. Add `--compact` to require removal of declarations unreachable from it.
WGSL output without an entry-point selection preserves all kernels. Selection
does not skip parsing or validation of the other CUDA kernel bodies.

The library entry point is `naga::front::cuda::parse_str(source, &options)`, where
`naga::front::cuda::Options::workgroup_size` supplies the CUDA launch block shape.
The default is `[1, 1, 1]`; each dimension must be in `1..=16384`, and their
product must fit in `u32`. One supplied shape applies to every kernel in the
module. Validate the returned module with
`naga::valid::Validator` before passing it to a backend, as with other frontends.
Device and backend resource limits still apply.

## Generated code

Scalar locals assigned once at function scope can become named values, emitted
as `let` bindings in WGSL. The frontend also removes redundant scalar copy
temporaries while retaining named values and the original timing of memory reads.
It keeps storage when mutation, aliases, control flow, or expression limits require
it. Backend naming rules can sanitize identifiers or add suffixes.

Unchanged kernel buffer pointers can use direct resource accesses. Pointers that
need runtime address tracking keep their private state and captured indices.
Nonnegative literal indices and value-preserving 32-bit integer casts can avoid
capture storage after bounds and use checks. Mutable indices, runtime arithmetic,
and captures that fail these checks retain their existing storage and evaluation
timing.

CUDA floating-point division, remainder, absolute value, rounding, and square root use
cached compatibility helpers. Calls reuse each helper across the module, keeping the
integer algorithms out of source functions while preserving their numerical
behavior. Other operations can still produce temporary expressions.

Floating-point addition, subtraction, and multiplication follow the target
language's guarantees.
WGSL permits either sign for zero, so reinterpreting an arithmetic result can
expose a difference from CUDA. See the
[WGSL floating-point rules](https://gpuweb.github.io/gpuweb/wgsl/#differences-from-ieee754).

## Function templates

Device helpers accept `typename` and `class` type parameters using the frontend's
supported scalar, vector, record, `dim3`, Cooperative Groups, and pointer types.
Type aliases name the same specialization as their underlying types. Explicit
type arguments retain source qualification; ordinary parameter and return-type
restrictions still apply after substitution.

```cuda
template<class Value>
__device__ Value copied(Value value) {
    return value;
}

template<class Result, class Input>
__device__ Result converted(Input value) {
    return Result(value);
}
```

Calls can supply type arguments explicitly, as in `copied<unsigned>(3)`, or
deduce them from arguments, as in `copied(3u)` and `copied<>(3u)`. Trailing type
arguments can be deduced after an explicit prefix: `converted<int>(2.75f)`
deduces `Input` as `float`. Value parameters discard an argument's top-level
qualification and allow array decay; reference and pointer parameters retain
the applicable source qualifiers. Repeated deductions must agree on the type;
`sum(1, 2u)` cannot deduce a common arithmetic type for two `Value` parameters.
Explicitly supplied parameters use the ordinary argument conversion rules.

Device and kernel templates accept concrete type defaults:

```cuda
template<class Result = unsigned, class Input>
__device__ Result converted_default(Input value) {
    return Result(value);
}
```

`converted_default(3)` deduces `Input` as `int` and uses `unsigned` for `Result`.
Supplied function arguments are deduced before defaults fill unresolved template
parameters. A deduced type overrides its default; conflicting deductions remain
errors. Explicit arguments, deduction, and defaults normalize to the same
specialization key. Defaults do not affect overload ranking.

Type defaults can also directly name an earlier type parameter:

```cuda
template<class Value, class Copy = Value>
__device__ Copy copied_default(Value value) { return Copy(value); }
```

`copied_default(3u)` deduces `Value` as `unsigned` and then uses that type for
`Copy`. Explicit or deduced arguments take precedence over defaults. Direct
defaults can form chains and add `const` or `volatile`, such as
`class Last = const Copy`. They retain the earlier parameter's resolved source
type and qualification. For a pointer type, added qualification applies to the
pointer object and preserves its pointee qualification. A default does not deduce an
earlier missing parameter from a later one.

Each default type name binds where its default is declared. The parameter's own
name becomes visible after its default, while earlier parameters can shadow
outer names. Compatible declarations and definitions inherit defaults and may
add defaults for parameters that do not yet have one. Repeating a default is an
error, even with the same value or type. Calls use only defaults visible at their
source position, including calls in template bodies. For example:

```cuda
template<class Value, int Count>
__device__ Value seed() { return Value(Count); }
template<class Value = unsigned, int Count> __device__ Value seed();
template<class Value, int Count = 4> __device__ Value seed();
```

After these declarations, `seed<>()` and `seed<unsigned, 4>()` use the same
specialization. Defaults can be added before or after a definition. Dependent
pointer, reference, array, and member declarators such as `Other = Value*` and
`Other = Value::member` remain unsupported. Existing restrictions on explicit
type arguments also apply to defaults. These forms use C++
[template parameters](https://eel.is/c++draft/temp.param) within this subset.

Integral template parameters also accept fixed constant defaults:

```cuda
constexpr int DefaultCount = 4;
template<int Count = DefaultCount>
__device__ unsigned count() { return unsigned(Count); }
```

`count()`, `count<>()`, and `count<4>()` reuse the same specialization. Default
names and converted values bind where each default is declared; later
definitions can rename parameters and inherit their defaults. Conversion must
preserve the value in the declared integral type. Boolean defaults require zero or one;
floating values require an explicit integral or Boolean cast. These checks run
when the default is declared.

An integral default can directly name an earlier integral template parameter:

```cuda
template<int Count = 4, unsigned Copy = Count, int Last = Copy>
__device__ unsigned copied_count() { return unsigned(Last); }
```

Omitted defaults resolve from left to right after deduction. Each reference uses
the earlier parameter's value and checks conversion to its own declared type.
For example, an omitted unsigned default cannot copy a negative value, and an
omitted Boolean default can copy only zero or one. An invalid conversion removes
that function-template candidate from overload selection. Explicit arguments
bypass their defaults. Chained defaults and renamed declarations retain the
same normalized specialization keys and source visibility rules as fixed defaults.

Type and integral defaults can be mixed, including before parameters that are
deduced from function arguments. Other dependent integral expressions remain
unsupported, including parenthesized references, arithmetic, and references
inside unevaluated or discarded expressions.
Shifts, greater-than comparisons, and comma expressions require parentheses, as with
explicit template arguments. Selected calls to function templates in default
expressions remain unsupported. Runtime builtins are not constants; discarded
operands can form a constant default without adding runtime inputs or bindings.

Templates participate alongside ordinary helper overloads. Better argument
conversions take precedence, followed by ordinary overloads on ties and partial
ordering of the supported template parameter patterns. An explicit `<...>` or
`<>` selects only templates. Equal normalized template arguments reuse one
helper instance regardless of whether arguments were explicit or deduced.

Device function templates accept constant defaults on fixed scalar parameters:

```cuda
template<class Value>
__device__ Value adjusted(Value value, int bias = 3) {
    return value + Value(bias);
}
```

`adjusted(2)` deduces `Value` from the supplied argument and uses the default
bias. Defaults do not contribute to deduction, conversion ranking, or call-context
partial ordering. Function-parameter defaults must appear on the initial
template declaration; later declarations and definitions inherit them and
cannot add or repeat them.
Their names and converted values bind at that initial declaration, even if the
definition or caller uses different names. The default parameter's type and
expression must not mention template parameters. Defaults that query function
parameters with known nondependent types are accepted, such as
`int count, int bytes = sizeof(count)`. These queries use source types without
reading parameter values. References query their referents, and array parameters
query their adjusted pointer types. Pointer dereference, subscript, and member
queries follow the ordinary `sizeof` rules below. Evaluated parameter uses remain
invalid, including discarded values and unselected conditional arms. Queries of
dependent parameter types, dependent defaults such as `Value extra = Value(1)`,
and defaults on kernel templates remain unsupported.

Class-valued function results and qualified constructors retain source
qualification. Members of temporary class values retain that qualification when
binding references; creating a scalar value removes its top-level qualification.
These rules also apply to ordinary helpers. Repeated helper declarations must
agree on result qualification.

Device helpers accept explicit `short`, `unsigned short`, `int`, `unsigned int`,
and `bool` template parameters, including aliases and top-level `const` or
`volatile` qualification.
Template arguments must be scalar constant expressions that convert to the
parameter type without narrowing. Parameters behave as immutable values and do
not add shader arguments or buffers. Equal converted arguments reuse the same
helper instance.

```cuda
template<int Bias>
__device__ unsigned adjusted(unsigned value) {
    return value + unsigned(Bias);
}

__global__ void apply(unsigned *output) {
    output[threadIdx.x] = adjusted<3>(threadIdx.x);
}
```

Template parameters can supply local and shared array bounds and arguments to
other templates. Helpers retain the ordinary rules for overloads, pointer and
reference arguments, Cooperative Groups handles, and synchronization. Names in
a template body use its definition's scope.

Kernel templates require explicit instantiation definitions in the source:

```cuda
template<int Width>
__global__ void fill(unsigned *output) {
    __shared__ unsigned values[Width];
    values[threadIdx.x] = threadIdx.x;
    __syncthreads();
    output[threadIdx.x] = values[threadIdx.x];
}

template __global__ void fill<4>(unsigned *);
```

This example requires `--cuda-workgroup-size 4,1,1` to match its launch shape.
`Options::workgroup_size` still applies to every emitted kernel; template
arguments do not select a workgroup size. Requested kernel instances appear in
request order with canonical source selectors such as `fill<4>`. Use
`--entry-point 'fill<4>'` to select one in the CLI. Backend identifier rules can
change the emitted entry name, so library callers should inspect the generated
backend entry names.

Type and integral parameters can appear in the same template. Integral arguments
without defaults must be supplied explicitly. Kernel instantiation definitions
require every template argument without a default. Typed kernel selectors use
canonical source type names, such as `copy_typed<unsigned>`, even when the
instantiation uses a type alias.
Class templates, dependent non-type parameter types, other dependent template
defaults, parameter packs, explicit specializations, `if constexpr`, and
overloaded kernel templates are unsupported.
Selected array-reference and pointer-reference instances remain unsupported.
Unrequested template bodies receive structural checks; full semantic checking
happens when an instance is requested. This does not yet implement all C++
diagnostics for unused template bodies. Instance creation and source replay use
the frontend's compilation budgets, and recursive calls are rejected.

## Volatile access

`volatile` scalar accesses through pointers and references can target kernel
storage buffers and static or dynamic shared memory. Pointee qualifiers survive
aliases, `auto`, helper parameters, and supported conditional expressions.
Adding `const` or `volatile` is allowed; dropping either qualifier is rejected.
Top-level qualification of a pointer object remains distinct from qualification
of its pointee.

An actual volatile read or write marks its existing backing allocation as
volatile without changing its binding or layout. Forming an address, binding a
reference, or decaying an array does not itself read the contents. Discarded
volatile scalar lvalues retain their reads, and assignment and update expressions
retain their evaluation order. Scalar members of records and vector components
can be accessed through volatile views; whole volatile record and vector copies
are unsupported.

Validation requires `MEMORY_DECORATION_VOLATILE` for storage buffers and
`MEMORY_DECORATION_VOLATILE_WORKGROUP` for shared memory. The corresponding native
wgpu features must also be enabled. Backend support still applies: volatile
shared memory currently requires Vulkan. Generated WGSL uses Naga's native
`@volatile` extension.

Volatile access does not provide atomicity or synchronization; use supported
atomic operations and barriers for those purposes. Volatile automatic objects,
volatile pointer objects, accesses to function or private memory through volatile
views, and volatile shared allocations containing atomics remain unsupported.

## Constant memory

File-scope `__constant__` declarations expose host-supplied, device-read-only
storage. Supported declarations use the existing numeric scalar, vector, and
record types, including fixed arrays.

```cuda
__constant__ float weights[17];

__global__ void scale(float *output, const float *input) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    output[index] = input[index] * weights[0];
}
```

These objects become read-only storage buffers in group 1. Bindings follow first
declaration order, starting at zero, and compatible `extern` declarations reuse
the same binding. Kernel parameters use group 0. Arrays and records use the
packed CUDA layouts described below. The `weights` array occupies 68 bytes.
The caller binds these buffers and uploads their contents, including updates
between dispatches. Generated shaders load their current contents at runtime.
When relying on CUDA's default zero initialization, bind zero-filled buffers.

An unqualified `__constant__` declaration retains a mutable C++ source type for
address formation, overload selection, and pointer or reference arguments.
The frontend rejects device writes through every view. Values are runtime
expressions, so constant-expression contexts reject their use. Const-qualified
objects require an `extern` declaration. Individual `extern "C"` declarations
participate in the same compatible redeclaration checks. The frontend rejects
source initializers and incomplete arrays.

## Kernel interface

Each source contains one or more `__global__ void` kernels, optionally preceded by
`extern "C"`. Entry points preserve source order. Device helper declarations and
definitions can surround the kernels and are shared across the module. Every
kernel body is parsed and checked, including kernels a caller does not dispatch.
Parameters accept the scalar types described below, either by value or as flat
pointers, including the 64-bit integer types and `size_t`. Pointer
parameters also accept `float1`, `float2`, `float3`, `float4`, `int1`, `int2`,
`int3`, `int4`, `uint1`, `uint2`, `uint3`, `uint4`, `short1`, `short2`, `short3`,
`short4`, `ushort1`, `ushort2`, `ushort3`, and `ushort4`. Aliases and pointee
`const` qualification preserve the underlying element type.
Pointer parameters also accept completed named structs described below.
Parameter number `i` uses group 0, binding `i` independently for each kernel,
preserving source order across both parameter kinds. Kernels can reuse binding
numbers with different parameter types and access modes; each entry accesses its
own parameter resources and shared declarations.
The caller supplies these buffers and dispatches the resulting compute entry
point by its original kernel name.

`signed`, `signed int`, and `int signed` name the existing 32-bit `int` type in
declarations, signatures, aliases, and scalar casts. Supported qualifier orders
include `const signed int` and `signed constexpr int`; single-word functional
casts can use `signed(value)`. These spellings preserve `int`'s literal ranges,
arithmetic conversions, overload identity, and buffer layout.

`short`, `short int`, and `signed short` name the signed 16-bit type. Adding
`unsigned` selects the unsigned 16-bit type. The integer specifiers can appear in
any valid order. Aliases, references, overloads, and template parameters preserve
the distinct source types.

Validate modules containing these types with `Capabilities::SHADER_INT16` and
request `wgpu::Features::SHADER_I16` for native execution. Generated WGSL uses
`enable wgpu_int16`. HLSL uses Shader Model 6.2 or later with
`-enable-16bit-types`. GLSL uses `GL_EXT_shader_explicit_arithmetic_types_int16`.
Brace conversions from integer to float require a constant expression whose value
is exactly representable, including 16-bit sources.

The frontend uses an LP64 data model: `long`, `unsigned long`, `long long`, and
`unsigned long long` are 64-bit scalar types. Valid orders of `signed`,
`unsigned`, `long`, and `int` preserve the corresponding type. `long` and
`long long` have distinct overload and template identities despite sharing the
same storage representation; the unsigned types are distinct too. Aliases,
references, and pointers retain those identities. The built-in `size_t` alias
names `unsigned long` and is also available as `::size_t` and `std::size_t`.
It follows ordinary alias scope and shadowing rules; `<cstddef>` is accepted.
Validate these modules with `Capabilities::SHADER_INT64` and request
`wgpu::Features::SHADER_INT64` for native execution. Generated WGSL uses
`i64` and `u64`. HLSL requires Shader Model 6.0 or later, and GLSL uses
`GL_ARB_gpu_shader_int64`.

Pointer parameters become storage buffers with runtime arrays of the corresponding
element type. A `const` pointee produces a read-only buffer; other buffers permit
reads and writes. Element layouts are:

| Element type | Size | Alignment | Array stride |
| --- | --- | --- | --- |
| `short` or `unsigned short` | 2 bytes | 2 bytes | 2 bytes |
| 32-bit scalar | 4 bytes | 4 bytes | 4 bytes |
| `long`, `unsigned long`, `long long`, or `unsigned long long` | 8 bytes | 8 bytes | 8 bytes |
| One-component 16-bit vector | 2 bytes | 2 bytes | 2 bytes |
| One-component 32-bit vector | 4 bytes | 4 bytes | 4 bytes |
| Two-component 16-bit vector | 4 bytes | 4 bytes | 4 bytes |
| Three-component 16-bit vector | 6 bytes | 2 bytes | 6 bytes |
| Four-component 16-bit vector | 8 bytes | 8 bytes | 8 bytes |
| Two-component 32-bit vector | 8 bytes | 8 bytes | 8 bytes |
| Three-component 32-bit vector | 12 bytes | 4 bytes | 12 bytes |
| Four-component 32-bit vector | 16 bytes | 16 bytes | 16 bytes |

Struct fields use their element alignment, with padding before a field when
needed. The struct's alignment is its greatest field alignment, and its size
rounds up to that alignment. Arrays of structs use that rounded size as their
stride. Copies preserve field values; padding bytes are unspecified.

`decltype(name)` accepts a direct, unqualified name of a supported scalar,
CUDA vector, record, `dim3`, pointer, or complete array value object. It works
with local and shared value objects, by-value function parameters, and scalar
`constexpr` constants.
The result preserves the declared type and its `const`/`volatile` qualifiers,
including the distinction between `long` and `long long` and the identities of
CUDA vector types. The operand is unevaluated: querying an object adds no read
or initializer evaluation. This follows the named-entity rule for
[`decltype`](https://eel.is/c++draft/dcl.type.decltype).

Pointer queries preserve pointee qualifiers separately from the pointer
object's `const` qualifier. Array queries preserve every extent without decay,
including arrays of vectors or records. Supported array parameters have already adjusted
to pointers, so querying a parameter preserves that pointer type and any row
extent. A query does not initialize or read an uninitialized pointer object.

Queried types can be used in aliases, declarations, supported casts and value
construction, and helper return types where the object name is visible:

```cuda
__device__ unsigned copy_value(unsigned value) {
    using Value = decltype(value);
    Value copy = decltype(value){value};
    return copy;
}
```

`decltype(nullptr)` remains supported. Queries of references (including
reference parameters), incomplete or currently inferred arrays, named
`nullptr_t` or `thread_block` objects, dynamic shared or constant-memory storage
objects, and template parameter names remain unsupported. Parenthesized lvalues such as `decltype((value))`, member access,
calls, and other expression operands are also unsupported. Ordinary value
parameters in instantiated template bodies can be queried once their types are
known. Existing restrictions on the resulting type's use still apply, including
volatile automatic storage and backend support for 64-bit values.

`sizeof(type)` and `alignof(type)` produce integral constant expressions of
the built-in `size_t` type, preserving `unsigned long` overload and template
identity. `alignof` requires a parenthesized type-id. Operands can use
qualified scalar, vector, `dim3`, completed struct, and array types, including
aliases and dependent template types. Queries use the CUDA layouts above,
including packed three-component vectors and struct padding. References use
the referred type's layout. Pointer types, including `void*`, and
`decltype(nullptr)` have size and alignment eight in the LP64 data model.
These rules follow the C++ definitions of
[`sizeof`](https://eel.is/c++draft/expr.sizeof) and
[`alignof`](https://eel.is/c++draft/expr.alignof).

Abstract array suffixes follow the existing array extent, rank, and type-size
limits. `sizeof` requires a complete type. `alignof` accepts an unknown-bound
array whose element type is complete and returns its element alignment.
Query constants can supply global and local initializers, array bounds,
template arguments, and launch bounds. Template instantiation resolves
dependent operands such as `sizeof(Value)`.

`__builtin_offsetof(Record, member)` is a `size_t` integral constant
giving the byte offset of a member of a complete record. A path such as
`outer.inner.value` can traverse nested record fields, and the final member
may have any supported field type. The record type can be qualified, named
through an alias, or resolved during template instantiation. The offset
includes preceding members and padding at each level. Use a
narrower constant type if the target shader needs only 32-bit values.
Designators can also index fixed array fields, as in `grid[1][2]` or
`leaves[1].value`. Index operands can be integer literals, Boolean literals
`true` and `false`, or unqualified integral constant names, including global
`constexpr` values, local integral constants and instantiated integral
template parameters. Indices may use
parentheses, unary `+`, `-`, `~` and `!`, arithmetic `+`, `-`, `*`, `/`
and `%`, shifts `<<` and `>>`, relational `<`, `<=`, `>` and `>=`, equality
`==` and `!=`, bitwise `&`, `^` and `|`, logical `&&` and `||`, and the
conditional operator `?:`. Operators follow C++ precedence. Binary
operators associate left to right and conditional operators associate right
to left. Binary arithmetic, comparison and bitwise operators apply the
usual arithmetic conversions after integer promotion. Comparisons and
logical operators produce Boolean values. Logical operators short-circuit.
A skipped right operand must still use supported integral expressions and visible names,
but its values are never evaluated. This permits skipped reads of named
runtime integral objects and skipped arithmetic with invalid values.
Conditional indices likewise evaluate only the selected arm. Both arms
determine the result type, and reading a volatile conditional result is
invalid in a constant index.
Indices also support `static_cast<T>(expression)` between integral scalar
types, including Boolean types and aliases. Integral casts wrap at the
destination width, and conversions to `bool` test for a nonzero value.
Integral type names and aliases also accept functional cast syntax, such as
`int(value)`, `std::size_t(value)`, `decltype(count)(value)` or `bool()`.
Empty parentheses produce the type's zero value.
C-style casts such as `(unsigned short)value` use the same integral
conversion rules and bind to the next unary operand.
Nested `sizeof(T)` accepts scalar types, CUDA vectors, complete records, and
fixed-array type names. Record sizes include padding and array sizes use the
declared stride. Nested `alignof(T)` accepts scalar types, CUDA vectors,
complete records, and array type names with supported elements. Array
alignment follows the element type, including for an unknown outer bound.
Both queries produce `size_t` values before the index is folded.
Inside an index, `sizeof(name)` and `sizeof name` also accept direct,
unqualified object names. They use the source object type without reading
the object. Fixed arrays retain their full extent and array parameters
use their adjusted pointer type.
Member paths rooted in a named object can use `.` and `->`, as in
`sizeof(record.field)` and `sizeof pointer->field`. Array fields retain
their full extent.
These paths can also subscript arrays and pointers, as in
`sizeof(record.grid[row + 1])` and `sizeof pointer[index].field`.
The subscript index must have an integral type. It can use the supported
unevaluated expressions, including scalar comparisons, casts,
conditionals, and grouped commas. Runtime and volatile values are left
unevaluated. Selecting a row preserves its array type.
The commuted form, such as `sizeof(row[record.grid])`, selects the
same element type and also leaves both operands unevaluated.
Grouping and unary dereference also work on these named operands, as in
`sizeof((*pointer).field)` and `sizeof *grid`. Dereferencing a
multidimensional array preserves the selected row's extent.
Nested `sizeof` also accepts supported numeric, Boolean, and `nullptr`
literals with or without parentheses. It uses their CUDA source type sizes
without emitting the literal values.
Unary `+`, `-`, `~`, and `!` use the same operand rules and scalar
promotions as standalone `sizeof`. Unary `+` on an array gives the
pointer size, and dereferencing that pointer in the query preserves the
element type, as in `sizeof *+grid`.
Parenthesized operands can also use scalar binary operators, as in
`sizeof(value + 1)`. These expressions use the same type conversions
and precedence as standalone `sizeof`. They are checked for operand type
errors without evaluating their values.
Parenthesized conditional expressions such as `sizeof(flag ? a : b)`
use the same supported scalar and pointer arm types as standalone
`sizeof`. Both arms are type-checked without evaluating the condition
or either arm.
Comma expressions in grouped operands and in the middle arm of a
conditional use the final operand's type, including the full extent
of an array. Every operand is type-checked without being evaluated.
An arithmetic `static_cast` operand uses the cast target's size, as in
`sizeof(static_cast<short>(value))`. It follows the same conversion rules
as standalone `sizeof` and emits no conversion.
Arithmetic C-style casts also work in grouped operands such as
`sizeof((short)value)`. The cast binds to its next operand, so
`sizeof((short)value + 1)` uses the promoted type of the sum.
Functional-style casts such as `sizeof(short(value))` accept a single
operand and use a scalar type name or alias as the target. Qualified
aliases such as `std::size_t` also work. A supported scalar
`decltype(name)` can supply the target, as in `sizeof(decltype(count)(value))`.
Empty scalar casts work in expression forms such as `sizeof((int()))`
or `sizeof int()`. The form `sizeof(int())` selects a function type,
which these size queries reject.
Pointer type queries, including `void*`, use the CUDA source ABI size and
alignment of eight bytes. Reference type queries use the referent's layout.
Function pointer queries such as `sizeof(int (*)(const int *, unsigned &))`
also use the pointer layout. The parameter list may be empty, `(void)`, or
a list of unnamed supported types with optional pointer or reference suffixes.
Direct array suffixes, such as `int[2][3]` and `void *[2]`, use the layout
query rules for array bounds, including an optional outer bound. C++ adjusts
these array parameters to pointers.
Grouped parameter types such as `int (&)[3]` and `int (*)[3]` also check
their array bounds and retain their reference or pointer declarator.
A parameter may itself be a function pointer, as in `int (*)(void (*)(int))`.
The nested signature follows the same type rules and nesting limit.
Plain function parameters such as `void(int)` in `int (*)(void(int))`
undergo the C++ function-to-pointer parameter adjustment.
Grouped function reference parameters such as `void (&)(int)` retain their
reference type and follow the same signature validation rules.
Function signatures may return references to supported types, including
array aliases, as in `Row &(*)(int)`.
Arrays of function pointers such as `int (*[3])(int)` use the pointer
element stride. Their bounds and signatures use the same validation rules
when queried directly or used as parameters in another signature.
A variadic signature may use `(...)` or end its parameter list with `...`,
with an optional comma before the ellipsis.
The signature may end with `noexcept` or `noexcept(expression)`. The expression
uses the integral constant expression rules for `offsetof` indices and must
produce `false`, `true`, `0`, or `1`.
Grouped type operands such as `int (*)[3]` and `int (**)[3]` also use the
pointer layout. Both queries accept an omitted outer bound in the array,
as in `sizeof(int (*)[])`.
An array of pointers to arrays, such as `int (*[2])[3]`, uses the outer
shape to compute the layout and validates the pointee shape independently.
With additional grouping, `int ((*[2])[3])[4]` still has two pointer
elements. Both `[3]` and `[4]` belong to the pointee. A function signature
may also appear inside an enclosing group, as in `int ((*[2])(int))`.
Pointers and references to arrays may split their pointee dimensions the
same way, as in `int ((&)[2])[3]`.
A reference to either kind of pointer array, such as `int (*(&)[2])[3]`
or `int (*(&)[2])(int)`, uses the referred array's layout.
The referenced array can split its dimensions across inner groups, as in
`int (*((&)[2])[3])[4]`. Here `[2][3]` is the pointer array's shape.
The same shape can be written without a reference as `int (*([2])[3])[4]`.
An additional pointer, as in `int (*(*)[2])[3]`, uses the pointer layout.
The pointed-to array may have an omitted outer bound.
References to those pointers, such as `int (*&)[3]` and `int (*&&)[3]`,
have the same layout for both queries.
Grouped array references such as `int (&)[3]` and `int (&&)[3]` follow the
array's layout. `alignof` also accepts references to arrays with omitted
outer bounds.
Grouped declarators also accept pointer elements, as in `int *(&)[3]` or
`int *(*)[3]`. The same array bound rules apply to these types.
Consecutive enclosing parentheses are accepted around indirect declarators,
as in `int ((&))[3]`, `void ((*))(int)`, and `int ((*))`.
Grouping is also accepted for a pointer array with no following suffix,
as in `int ((*[2]))`.
Enclosing parentheses around array dimensions, as in `int ([3])` or
`int *([3])`, use the same layout and bound rules as ungrouped dimensions.
Dimensions after a closing parenthesis, as in `int ([3])[2]`, belong to
the same array shape and share its bound, rank, and size limits.
Array type operands can include dimensions such as `int[2][3]`. Every
explicit bound must be a positive integral constant, even in a skipped
query. Only `alignof` accepts an omitted outer bound in this syntax.
Arrays of pointers such as `int *[3]` use an eight-byte element stride and
alignment in layout queries.
Arithmetic that computes the `offsetof` index rejects signed overflow and
zero divisors and wraps unsigned results at the operation's width. Shift
counts must be nonnegative and less than the promoted left operand's bit
width. Left shifts wrap at that width and signed right shifts are arithmetic.
The final `offsetof` index must be nonnegative and in bounds. The offset
uses the declared stride of each array dimension.
The synthetic `<cstddef>` and `<stddef.h>` headers define the function-like
macro `offsetof(Record, member)` on the first active inclusion of either
header. The macro follows the normal `#undef` and redefinition rules.

`sizeof(object)` and `sizeof object` also accept a direct, unqualified object
name. Supported objects include scalar, vector, record, and array variables,
parameters, references, pointers, and constants, including integral template
parameters. Arrays retain their complete extent; references use the referred
object's type. The operand is unevaluated, so querying an uninitialized object
or a volatile reference emits no read. Member chains rooted in these names also
support `.` and `->`, including nested records, vector components, and complete
array fields. Pointer operands can be null or uninitialized because they are not
read. Arrays can decay for `->`; querying an element member of an incomplete
dynamic shared array does not allocate launch storage. The array itself remains
incomplete regardless of the configured launch allocation size. Leading unary
`*` operators also accept these named operands and member chains, as in
`sizeof(*pointer)`, `sizeof *array`, and `sizeof(**record.matrix)`. They use
pointee and array element types without reading pointers; multidimensional array
elements retain their full extent. Postfix member access binds before these
operators. Grouping parentheses can surround these operands and combine with
member access and dereferences, as in `sizeof((*pointer).matrix)` and
`sizeof *((record).matrix)`. Member access after a closing parenthesis still
belongs to the unevaluated operand, so `sizeof (record).matrix` queries the
matrix field. Grouping and unary nesting share the expression nesting limit.
Numeric, Boolean, and `nullptr` literals are also accepted, including grouped
and unparenthesized forms. Numeric literals use the same supported suffixes,
separators, ranges, and source types as evaluated literals; querying them does
not emit their values. Built-in unary `+`, `-`, `~`, and `!` also use operand
types without reading them. Arithmetic unary operators apply the usual integral
promotions, so `sizeof(+short_value)` is four; logical negation has Boolean type.
Unary `+` preserves pointers and decays arrays once, so `sizeof(+matrix)` is
eight while `sizeof(*+matrix)` retains the complete row extent. Record and
vector operator overloads are not resolved within these queries. Built-in
subscripts accept integral indices from these named, literal, grouped,
member, unary, scalar binary, and scalar conditional operand forms. Subscripts
preserve multidimensional array extents.
Commuted forms such as `index[pointer]` are also supported. Neither pointer nor
index values are read or bounds-checked, and indexing dynamic shared arrays does
not allocate launch storage. The selected element type must be complete before
further subscripts or member access; dereferencing a pointer to an incomplete
array first permits indexing the array's complete elements.

Built-in scalar binary arithmetic, bitwise, shift, comparison, and logical
operators also use operand types without evaluating their values. Arithmetic
operators apply the existing usual arithmetic conversions, including integral
promotions and the distinct source ranks of `long` and `long long`. Shift
results use the promoted left operand's type. Comparisons and logical operators
produce Boolean types. Remainder, bitwise, and shift operators require integral
operands. Grouping and ordinary operator precedence are preserved;
`sizeof small + 1` still adds one to the size of `small`.
Both operands must have supported types, even for logical operators. Values are
not checked for division by zero, overflow, invalid shift counts, or out-of-range
indices, so `sizeof(1 / 0)` is four.

A grouped conditional operand such as `sizeof(flag ? left : right)` uses
the types of its condition and both arms without evaluating them. Conditions
may be scalar values, pointers, arrays, or `nullptr`. Matching scalar arms
retain their source type, including `short` and `bool`. Mixed scalar arms use
the usual arithmetic conversions. A typed pointer paired with a `nullptr`
operand or an integer literal of value zero retains the pointer's source type, so
`sizeof(*(flag ? pointer : nullptr))` gives the pointee size. Two `nullptr`
arms give the size of `decltype(nullptr)`. Two single-level pointers to the
same pointee type retain that pointee type, including any array extents.
Conditional expressions also work in integral subscript indices within a query.

Parentheses and macros that expand to a zero literal preserve its use as a
null pointer constant. A zero literal keeps its integer type in scalar
queries such as `sizeof(0u)`. Pointer pairs with different pointee types or
pointer-to-pointer types and array arms are unsupported in these queries.

Built-in comma expressions type-check each operand and use the final operand's
type and array extents without evaluating any operand. They are supported in
grouped queries, subscript indices, and the middle arm of a conditional.
For example, `sizeof((value, matrix))` gives the full size of `matrix`.
A comma expression ending in `0` has integer type and cannot serve as a null
pointer constant.

Within a `sizeof` operand, nested queries such as `sizeof(sizeof(value))`
and `sizeof(alignof(int))` use the inner query's `size_t` type. The inner
query follows the layout rules for `offsetof` indices, including validation
of explicit array bounds, and emits no shader expression.

Pointer, array, record, and vector binary operators, calls, updates, and
assignments remain unsupported within these queries.

`sizeof(static_cast<short>(value))` uses the cast's destination type and gives
two bytes. This form supports existing arithmetic scalar types as both source
and destination. A `bool` destination also accepts pointers, complete or
incomplete arrays, and `nullptr`. The query checks the operand type without
evaluating the value or performing the conversion. The argument may be a
supported comma expression.

Functional casts such as `sizeof(short(value))` also use the destination
type's size. They accept an empty argument list or a single parenthesized
argument. The target can be a single-word arithmetic type name, a scalar
alias such as `std::size_t`, or a supported scalar `decltype(name)`.
A grouped comma expression
such as `int((left, right))` counts as one argument. Functional casts in these
queries use the same type conversion rules as `static_cast`.

C-style casts such as `sizeof((unsigned long)value)` support qualified
arithmetic targets and the same operand types as these casts. The cast binds
to its unary operand, so `sizeof((short)value + 1)` uses the promoted type of
the addition, while `sizeof((short)(value + 1))` uses `short` directly.
`sizeof(short)` still queries the type, including in expressions such as
`sizeof(short) + 1`.

`static_assert(condition);` declarations are accepted at global, function, and
record scope, including local records in instantiated function templates.
Record assertions may use `sizeof` on previously declared members, preserving
their complete array and record types. Members still require an object in
ordinary expressions, and the record being defined remains incomplete.
Conditions use the supported scalar constant-expression rules and contextual
Boolean conversion. Assertions are checked even after a return or inside an
unreachable runtime branch; unused template bodies retain the ordinary
deferred-checking rules above. A false condition produces a source-spanned
diagnostic, including an optional plain string message. Adjacent plain strings
concatenate; escaped or prefixed strings and C++26 message expressions remain
unsupported. Successful assertions add no runtime checks. Requested template
instances are checked before CLI entry selection.

Vector elements support whole-value copies and scalar field access, including
assignments and updates to writable fields. Kernel value parameters accept the
one-, two-, three-, and four-component `int`, `uint`, and `float` vectors. Each
uses a separate 16-byte uniform buffer at the parameter's source binding index.
Components occupy four bytes each in `x`, `y`, `z`, `w` order starting at byte
offset 0. Bytes after the final component are padding. Source queries still see
the four-byte size of a one-component vector and the 12-byte size of a
three-component vector. Other kernel vector parameters require pointers or
adjusted array declarators.

Kernels can take a record by value when it has one to eight tightly packed
`int`, `unsigned int`, or `float` fields and requires no default constructor.
Each record uses a uniform buffer at its source binding index. Allocate 16
bytes for one to four fields and 32 bytes for five to eight fields. Write the
fields in declaration order at four-byte intervals starting at offset 0. The
remaining bytes are padding. The source record keeps its natural size and
alignment. The kernel receives a separate copy in every invocation.

Scalar parameters use 16-byte uniform buffers containing the two-, four-, or eight-byte
numeric value at byte offset 0. Boolean value parameters use a `u32` field at offset
0: its low byte is decoded as false when zero and true otherwise; the upper three
bytes are ignored. Hosts should write 0 or 1 in the low byte. The CUDA parameter
retains type `bool`, including its one-byte source size and alignment. Each
invocation receives its own parameter value. Assigning to a non-`const` parameter
changes only that invocation's copy. Boolean kernel buffers remain unsupported.

The frontend maps CUDA's built-in variables as follows:

| CUDA expression | Naga representation |
| --- | --- |
| `threadIdx.x`, `.y`, `.z` | Component of `LocalInvocationId` |
| `blockIdx.x`, `.y`, `.z` | Component of `WorkGroupId` |
| `gridDim.x`, `.y`, `.z` | Component of `NumWorkGroups` |
| `blockDim.x`, `.y`, `.z` | Component of `Options::workgroup_size` |

CUDA chooses block dimensions at launch. Naga compute shaders encode their
workgroup shape in the module, so compile a separate module for each required
block shape.
These mappings follow NVIDIA's [built-in variable definitions](https://docs.nvidia.com/cuda/archive/13.0.0/cuda-c-programming-guide/index.html#built-in-variables)
and WGSL's [compute built-in inputs](https://gpuweb.github.io/gpuweb/wgsl/#builtin-inputs-outputs).

`__launch_bounds__(max_threads, min_blocks, max_cluster_blocks)` accepts one to
three integral constant arguments, including macros and template parameters.
Dependent template operands receive structural checks before instantiation;
instantiated bounds require integral constant values.
A signed 64-bit argument must fit `int`, and an unsigned 64-bit argument must
fit `unsigned int`. Arguments become signed 32-bit attribute values. Nonpositive values impose no
bound. For a positive first argument on a kernel, the product of all three
`Options::workgroup_size` dimensions must not exceed it. The attribute does not
choose the workgroup shape. Attributes on device helpers are validated but do
not limit the caller's workgroup.

The current execution model launches individual workgroups. Cluster launches
and cluster builtins remain unsupported, and occupancy and cluster arguments
do not become backend tuning metadata. NVIDIA describes CUDA's scheduling
hints and launch limits in its
[launch-bound definitions](https://docs.nvidia.com/cuda/archive/13.1.0/cuda-programming-guide/05-appendices/cpp-language-extensions.html#launch-bounds).

### HLSL dispatch dimensions

HLSL needs a host-supplied constants buffer to implement `gridDim`. Select its
constant-buffer register and register space explicitly:

```sh
cargo run -p naga-cli -- input.cu output.hlsl --hlsl-special-constants-binding 0,1
```

This example uses `b0, space1`. At dispatch, supply the three workgroup counts
as 32-bit values at byte offsets 0, 4, and 8. The library equivalent is
`naga::back::hlsl::Options::special_constants_binding`. Kernels that use
`gridDim` produce an HLSL error if this binding is missing. Kernels using only
`threadIdx`, `blockIdx`, and `blockDim` do not need this buffer.

Inputs referenced by helper definitions are retained even when those helpers
are unused. An unused helper that reads `gridDim` can therefore require this
HLSL constants binding. Helper builtin reads do not add kernel buffer bindings.

## Device helpers

`__device__` functions accept the scalar, vector, and struct value types described
above and return a supported value or `void`. Helpers can use
local declarations, arithmetic, control flow, and calls to previously declared helpers:

```cuda
__device__ unsigned global_index();
__device__ float scale(float, float);

__global__ void apply(float *out, const float *input) {
    unsigned i = global_index();
    out[i] = scale(input[i], 2.0f);
}
__device__ unsigned global_index() {
    return blockIdx.x * blockDim.x + threadIdx.x;
}
__device__ float scale(float value, float factor) {
    value *= factor;
    return value;
}
```

Prototypes end with `;` and can omit parameter names. Compatible declarations
can repeat before or after a definition; parameter names, aliases, and top-level
by-value parameter `const` do not distinguish signatures. Reference parameters
retain their referent's constness. The definition determines its
parameter names and constness. Conflicting result types and duplicate definitions
produce errors. These rules follow C++ [function declarations](https://eel.is/c++draft/dcl.fct).

Ordinary device helpers accept `noexcept` and `noexcept(condition)` after their
parameter list. The condition must be a supported constant expression of type
`bool`, or an integral constant with value zero or one. Other integral values
and floating values require an explicit conversion to `bool`. For example:

```cuda
__device__ unsigned copy(unsigned value) noexcept(sizeof(value) == 4) {
    return value;
}
```

Bare `noexcept` equals `noexcept(true)`; absence equals `noexcept(false)`.
Declarations of the same helper must agree on that value. It does not create
an overload or affect overload ranking. Parameters may appear in supported
unevaluated type queries such as `sizeof(value)`, but cannot be read by the
condition, including in a discarded branch. Conditions are checked during
translation and add no runtime resource bindings.
These rules follow C++ [exception specifications](https://eel.is/c++draft/except.spec).
Device function templates accept `noexcept`, `noexcept(true)`, and
`noexcept(false)`. Redeclarations must agree on the effective Boolean value,
and each instantiation inherits that value. Template specifications with
other expressions remain unsupported. Specifications on kernels, explicit
kernel instantiation directives, and predefined intrinsic signatures remain
unsupported. Calls to function templates inside conditions, exception
handling, and the `noexcept` expression operator are also unsupported.

Ordinary helpers accept trailing scalar constant default arguments:

```cuda
__device__ float scale(float value, float factor = 2.0f);
__device__ float scale(float value, float factor) { return value * factor; }
```

`scale(value)` uses the default, while `scale(value, factor)` supplies both
arguments. Defaults are checked and converted to the parameter type where they
are declared. Calls use only defaults visible at their source position, including
calls in template bodies. Compatible declarations may add defaults, but cannot
repeat an existing default. After combining visible declarations, every parameter
following one with a default must also have a default. Overload ranking compares
only supplied arguments; `f(int)` and `f(int, int = 0)` make `f(1)` ambiguous.
These rules follow C++ [default arguments](https://eel.is/c++draft/dcl.fct.default).
Defaults on kernels, predefined intrinsic signatures, and nonscalar
or reference parameters remain unsupported. Default expressions must be supported
scalar constant expressions; runtime calls and parameter value reads are rejected.

Each called helper needs a definition in the same source. An unused prototype
does not emit a function. Missing definitions and direct or indirect recursion
are rejected even in unused helpers or discarded source statements. A prototype
for an existing intrinsic preserves its builtin implementation; a conflicting
result or a source definition of the builtin signature produces an error.

Helpers can read `.x`, `.y`, and `.z` of `threadIdx`, `blockIdx`, `blockDim`,
and `gridDim`. Each component is a read-only 32-bit unsigned integer and has
the same invocation or dispatch value as a read in the kernel. `blockDim`
comes from `Options::workgroup_size`; none of these reads is a C++ constant
expression, including `blockDim`.

Helpers may also carry `__host__`. Translation checks and emits their device
implementation, including calls to previously declared device-only helpers; the host
implementation is not checked or emitted. Host-only definitions remain unsupported.
Repeated source declarations must agree on whether the helper also has `__host__`.

The frontend evaluates arguments left to right. By-value arguments convert to the
parameter types and are copied before later arguments execute. Assignments affect
only those copies; `const` parameters cannot be assigned. Return values convert to the declared
result type. Value-returning helpers must explicitly return on every supported
path; a return inside a loop alone does not satisfy this conservative check.

Void helpers support bare `return;`, implicit fallthrough, and
`return other_void_helper(...);`. Void calls are accepted as discarded
expressions, including parenthesized calls and `for` initializer/update clauses.
Using a void call where a value is required produces a parse error.

`(void)expression` and `static_cast<void>(expression)` discard supported values
or void expressions. They preserve calls, updates, and required volatile reads;
ordinary nonvolatile glvalues are discarded without reading their value. These
casts work in comma expressions, both-void conditional arms, and void returns.
Their constant-expression eligibility follows the discarded operand and the
selected conditional arm. Discarding a value does not make runtime calls,
updates, or volatile reads constant expressions. Cast targets may include `const`
and `volatile`; these target qualifiers do not change operand-read behavior.
Functional forms `void()`, `void(expression)`, and `void{}` are also accepted.
Parenthesized functional forms accept a single expression, including a grouped
comma expression such as `void((first, second))`. Nonempty braced forms and
multiple functional arguments remain unsupported. At statement scope, forms such
as `void(name);` and `void(function());` follow declaration parsing and retain the
existing restrictions on parenthesized declarators; wrapping the whole expression
as `(void(function()));` selects expression parsing.

Helpers can share a name when their parameter types or counts differ.
Calls prefer exact argument types, then promotion from `bool` to `int`, then
other scalar conversions. The selected overload must be no worse for every
argument and better for at least one; otherwise the call is ambiguous.
Return types, aliases, and top-level parameter `const` do not distinguish
by-value signatures. Mutable and const reference parameters distinguish overloads.
When both candidates bind references, a mutable lvalue prefers `T&` over
`const T&`. An equally ranked by-value candidate and reference candidate remain
ambiguous. Each call uses only the overloads visible at that point in the source;
later declarations do not change its selection. These rules follow
C++ [conversion ranking](https://eel.is/c++draft/over.ics.rank) and
[overload selection](https://eel.is/c++draft/over.match.best.general).

Helpers accept `T&` and `const T&` for the scalar, vector, and struct types above.
A mutable reference requires a writable lvalue of exactly the same type. A const
reference keeps a live alias to a same-type lvalue; a supported scalar conversion
or typed temporary instead creates a private snapshot for that call. Arguments
can refer to local, shared, or buffer storage, including overlapping objects:

```cuda
__device__ void combine(int &first, int &second) {
    first = 5;
    second += 2;
    first += second;
}
__global__ void aliases(int *out) {
    int value = 1;
    combine(value, value);
    out[0] = value; // 14
}
```

Each reference argument's address is selected once, before later arguments
execute. Binding an output-only parameter does not read the referenced value.
Reference helpers are expanded into their callers to preserve live aliases across
backends; nested calls, ordinary returns, and early returns keep their source
behavior. This expansion does not make calls constant expressions. Formal
references also retain unknown constant-expression provenance, even when an
actual argument names fixed shared storage. Invalid unused definitions and
discarded calls are still checked before expansion.

Helpers also accept `T*` and `const T*`, including `T const*`, for the same
scalar, vector, and struct types. Pointer arguments borrow local, shared, or
buffer storage. Fixed arrays decay to their first element; `&object` and
`&array[index]` borrow an existing lvalue. Pointee types must match exactly,
and conversion may add `const` but cannot remove it:

```cuda
__device__ void add_next(int *destination, const int *source) {
    destination[0] += source[1];
}
__global__ void update(int *out) {
    int values[3]{2, 3, 5};
    add_next(out, values + 1);
}
```

Pointers preserve live aliases, including overlapping arguments and forwarding
through reference parameters. Selecting an argument's address happens once,
before later arguments execute, without reading the pointee. Pointer helpers
use the same caller expansion as reference helpers.

During overload resolution, integer literal zero is a
[null pointer constant](https://timsong-cpp.github.io/cppwp/n4659/conv.ptr),
including when parenthesized or supplied by a macro. Named constants, casts,
and computed zeros do not qualify. Ordinary calls, explicit operator calls,
and operator expressions use the same rule. Pointer candidates participate
before checking whether the selected call can be lowered.

Literal zero can initialize or assign a typed null pointer, pass to a pointer
parameter, or form a conditional arm alongside a compatible pointer. Empty
pointer initializers, `T *pointer{}` and `T *pointer = {}`, also produce null.
Copies and qualification conversions preserve the null value.

Pointer aliases support `Pointer()`, `Pointer{}`, `Pointer(source)`, and
`Pointer{source}`. Empty construction produces a typed null pointer. Nonempty
construction accepts null pointer constants, compatible pointer values, and
array decay. Compatible `static_cast<T*>(source)` and C-style pointer casts use
the same address-preserving conversion path, including alias targets. Pointee
types must match, and conversions may add `const` or `volatile` but cannot remove
them. Integer-address conversions and reinterpretation remain unsupported.
Pointer values discard the target's top-level qualification while retaining
pointee qualification. Copies capture the source pointer before later expressions
can retarget it.
Scalar constant expressions may discard pure pointer constructions and checked
local or shared address calculations.

Pointers support conditions, logical negation, Boolean conversions, and
`==` or `!=` with literal zero in either operand order. Null converts to `false`;
object pointers and one-past pointers convert to `true`, following the C++
[Boolean conversion rules](https://timsong-cpp.github.io/cppwp/n4659/conv.bool).
Boolean helper parameters also accept pointers. These conversions do not read
the pointed-to object. Guard a pointer before accessing it when it may be null.
Comparisons between two pointers remain unsupported.

`nullptr` has its own source type, available as `decltype(nullptr)` or
`std::nullptr_t`. It supports named
`auto` values, aliases,
local objects, mutable and const references, helper parameters and results,
and function template deduction. These values convert to compatible pointers
without becoming integer zero. Direct and contextual Boolean conversions
produce `false`; implicit Boolean and numeric conversions are rejected.
Named reads can be constant expressions even after an effectful initializer;
the initializer and calls still execute where written.

The source type has no shader storage representation. Null-valued helper
parameters and results are erased from the shader signature while calls,
side effects, barriers, and source return checks remain effective. Kernel
parameters, arrays, object addresses, shared storage, and volatile objects or
references of this type remain unsupported.
Parenthesized initializers follow the C++ [declaration ambiguity rules](https://timsong-cpp.github.io/cppwp/n4659/dcl.ambig.res):
`Null value(Null());` declares an unsupported function; `Null value((Null()));`
creates a null object.

Borrowed expressions support `*pointer`, unary `+pointer`, `pointer + index`,
`index + pointer`, `pointer - index`, and both subscript orders. Indices must
have integral types; `bool` promotes to `int`. Parentheses and comma expressions
preserve pointer values, and conditional expressions select compatible views,
adding pointee `const` when either arm requires it. Offsets retain the original
array or individual object's extent. Forming a one-past address does not access
storage, so `*(&values[3] - 1)` can read the final element of a three-element
array. Accesses must remain within the original object and the existing 32-bit
buffer-index domain.

Pointer member access, `pointer->field`, uses the same dereference and field
rules as `(*pointer).field`. It supports struct fields and individual numeric
vector components, including chained fields, array subscripts, assignments,
updates, and reference arguments. The pointer operand is evaluated once, and
pointee `const` remains effective throughout the member chain. An array of
structs or vectors can decay to its first element for member access.
Overloaded `operator->` and pointer-to-member operators remain unsupported.

Local pointers can be declared without an initializer, `T *value;`, and assigned
later. Assign a value before using the pointer; the declaration does not provide
a null pointer. Top-level `const` pointers require an initializer.
Initialized forms are `T *value = source`, `T *value{source}`,
`T *value = {source}`, and `T *value(source)`. They accept the same array decays,
object addresses, pointer expressions, and pointee qualifications as helper
arguments. Initializers evaluate once, so later changes to an index or condition
do not retarget a pointer. Locals preserve live aliases in kernels and helpers,
including mixed declaration lists and block or loop scopes. Pointee `const`
prevents writes; top-level pointer `const` prevents modifying the pointer itself.
Generated shaders retain source names for pointers, with backend-specific
sanitization and suffixes to distinguish overlapping scopes.

Kernel and helper pointer parameters and local pointer declarators accept
`__restrict__` and `__restrict` after `*`. They can precede or follow top-level
pointer `const`, as in `T *const __restrict__` or `T *__restrict const`.
These qualifiers do not change bindings, pointee constness, or helper signatures.
The frontend preserves conservative aliasing behavior and does not apply
optimizations based on these qualifiers.

Mutable local pointers and pointer parameters support `++`, `--`, `+=`, and `-=`
with integral displacements. Updates preserve the original array or object origin.
Plain assignment, `pointer = replacement`, captures the replacement's origin,
offset, and evaluated array indices. It can select another compatible array or
object at runtime, including across branches and loop iterations. Assignment
allows adding pointee `const`, and rejects removing it or changing the pointee type.
Prefix updates and compound assignments return pointer lvalues; postfix updates
capture the previous address. Conditional and comma expressions preserve compatible
pointer lvalues. Plain assignment also returns the destination pointer lvalue,
allowing chained assignments and subsequent updates. Kernel and helper parameters
have private pointer values, so their assignments and updates do not retarget the
caller's pointer or change buffer bindings. Copies and bound references retain
their previously selected addresses. `constexpr` pointer declarations remain
unsupported.

Array parameters in ordinary helpers and kernels adjust to pointers. For
example, `T values[]` adjusts to `T*`, and `T values[2][3]` adjusts to a
pointer to `T[3]`. The first bound may be omitted; a written first bound must be
a positive integral constant expression but does not constrain the argument's
length or allocate an outer array. Retained inner bounds must be positive
integral constant expressions. The retained row supports up to 64 dimensions,
including dimensions supplied by an array alias, in addition to the ignored
outer dimension.

Pointer parameters and adjusted array parameters share overload signatures.
Different first bounds do not distinguish signatures; different inner bounds
do. Top-level parameter `const`, as in `T* const`, does not distinguish
signatures; pointee `const` does. Kernel array parameters expose storage buffers
whose elements are the retained rows, preserving their row stride and element
qualifiers. Explicit multidimensional array declarators in template parameters,
arrays of pointers, and whole-array references remain unsupported.

Discarding a bare pointer parameter or local, as in `(pointer, 4)`, does not read
its value. Reading an unknown formal pointer or a local pointer through
indirection, indexing, unary `+`, or offset arithmetic prevents a required constant expression under
the frontend's C++20 constant-expression rules. Caller expansion does not make
those expressions constant.
Constant-address proofs currently cover shared storage; automatic local
addresses cannot establish a required constant expression.
Constant-address evaluation through a named reference currently uses a
one-element extent. Runtime pointer forwarding retains the original array
extent, including neighboring elements.

Indirect parameter expansion has cumulative limits of 1,048,576 generated nodes,
4,194,304 work steps, and 64 MiB of accounted additional owned payload. Generated
expression depth is limited to 64 and generated control depth to 127, accounting
for backend scopes. These limits are checked before copying generated payload;
they do not describe an exact allocator or process memory limit.

Helpers have no resource bindings. Pointer and reference results,
whole-array references, and kernel prototypes remain unsupported.
Pointer members, general pointer comparisons and differences, casts that change
the addressed type or remove pointee qualifiers, and general pointer declarators
remain unsupported. Arrays selected from temporary struct values
cannot supply borrowed pointers.

Both helpers and kernels accept `static` and standard `inline` in the function
header. `static` cannot be combined with the direct `extern "C"` prefix.
A helper first declared `static` retains that linkage when later declarations
omit the specifier. Adding `static` after an external declaration is rejected.
Device helpers, including dual-qualified helpers, also accept `__forceinline__`
or `__noinline__`. These CUDA specifiers cannot be combined with each other or
with standard `inline`, including across compatible helper redeclarations,
and cannot be applied to kernels. Their optimization
behavior depends on the target backend and compiler; forced inlining or preserved
calls are not guaranteed. Functions and calls use the existing Naga lowering.
These constraints follow NVIDIA's [inlining rules](https://docs.nvidia.com/cuda/archive/13.0.0/cuda-c-programming-guide/index.html#noinline-and-forceinline)
and C++ [linkage rules](https://eel.is/c++draft/dcl.link#8).
Execution-space, function, return-type, and `const` specifiers may appear in any
valid order; `unsigned`, `signed`, and `int` may be interleaved with those specifiers.
Static variables and the `__inline_hint__` specifier remain unsupported.
Top-level return `const`, including `const void`, does not change the result type.
The frontend preserves ordinary value-only function calls; `inline` does not
force substitution. Indirect parameter helpers require expansion even with `__noinline__`.

## Floating-point division

Scalar `float` division and `/=` use round-to-nearest, ties-to-even results,
including gradual underflow and overflow. Integer operations on the received
operand representations preserve subnormal inputs, signed zero results, and
infinities. NaNs and invalid operations such as zero divided by zero produce the
canonical quiet NaN `0x7fc00000`. This matches CUDA's default
[`prec-div=true` mode](https://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/index.html#prec-div-true-false-prec-div).
Mixed scalar operands receive the usual arithmetic conversions before division.
Source-defined vector operators can use the same scalar divisions componentwise.

`__fdiv_rn(float, float)` exposes the same correctly rounded operation through
CUDA's fixed single-precision intrinsic signature, following NVIDIA's
[`__fdiv_rn` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Scalar arguments convert to `float` first, and the result is `float`. Calls share
the existing integer division helper with `/` and `/=`, including its subnormal,
signed-zero, infinity, and canonical-NaN behavior. Intrinsic calls execute at
runtime and are not source constant expressions.

`__fdividef(float, float)` implements CUDA's approximate division intrinsic.
For a finite divisor with magnitude strictly greater than 2^126, a finite
numerator yields zero with the quotient's sign, and an infinite numerator
yields canonical NaN. Other operand combinations use the exact nearest-even
division helper, including subnormal inputs and results. Arguments convert to
`float` before division. Calls execute at runtime. See NVIDIA's
[`__fdividef` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).

`__fdiv_rz(float, float)` computes a single-precision quotient rounded toward
zero, following NVIDIA's
[`__fdiv_rz` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Scalar arguments convert to `float` first. It shares the exact integer division
algorithm through a separate cached helper, preserving received subnormal inputs
and truncating inexact results toward signed zero. Finite overflow saturates to
the signed largest finite value. Actual infinity inputs, zero denominators,
NaNs, and signed-zero cases follow `__fdiv_rn`. Calls execute at runtime and are
not source constant expressions.

`__fdiv_rd(float, float)` rounds the single-precision quotient toward negative
infinity. Finite positive overflow returns the largest finite `float`, and
finite negative overflow returns negative infinity. A finite negative quotient
too small for a subnormal rounds to the smallest negative subnormal.
Zero, infinity, and NaN operands follow `__fdiv_rn`. See NVIDIA's
[`__fdiv_rd` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).

`__fdiv_ru(float, float)` rounds the single-precision quotient toward positive
infinity. Finite positive overflow returns positive infinity, and finite
negative overflow returns the most negative finite `float`. A finite
positive quotient too small for a subnormal rounds to the smallest positive
subnormal. A negative quotient of that magnitude rounds to negative zero.
Zero, infinity, and NaN operands follow `__fdiv_rn`. See NVIDIA's
[`__fdiv_ru` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).

`__frcp_rn(float)` computes the correctly rounded single-precision reciprocal,
following NVIDIA's
[`__frcp_rn` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Its scalar argument converts to `float`, then the existing division helper
computes `1.0f / x` with round-to-nearest, ties-to-even results. Signed zeros
produce signed infinities, signed infinities produce signed zeros, and NaNs
produce the canonical quiet NaN `0x7fc00000`. Finite results preserve gradual
underflow; overflow rounds to signed infinity. Calls execute at runtime and are
not source constant expressions.

`__frcp_rz(float)` computes the single-precision reciprocal rounded toward zero,
following NVIDIA's
[`__frcp_rz` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Its scalar argument converts to `float` before the cached `__fdiv_rz` helper
computes `1.0f / x`. Received subnormal inputs and subnormal results are
preserved. Finite overflow saturates to the signed largest finite value;
signed-zero, infinity, and canonical-NaN cases follow `__frcp_rn`. Calls execute
at runtime and are not source constant expressions.

`__frcp_rd(float)` converts its scalar argument to `float` and shares the
`__fdiv_rd` helper for `1.0f / x`, including its subnormal, overflow, and
exceptional-value rules. Both downward-rounding intrinsics execute at runtime.
See NVIDIA's [`__frcp_rd` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).

`__frcp_ru(float)` converts its scalar argument to `float` and shares the
`__fdiv_ru` helper for `1.0f / x`, including its subnormal, overflow, and
exceptional-value rules. Both upward-rounding intrinsics execute at runtime.
See NVIDIA's [`__frcp_ru` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).

## Mathematical functions

The 32-bit `min` and `max` overloads accept `int` and `unsigned int` operands in
either order. Boolean arguments promote to `int`. If either operand is unsigned, both values
convert to `unsigned int` and the result is unsigned; otherwise the result is
`int`. For example, `min(-1, 2u)` is `2u`, while `max(-1, 2u)` is `0xffffffffu`.
These rules follow NVIDIA's [integer overloads](https://docs.nvidia.com/cuda/archive/13.0.0/cuda-math-api/cuda_math_api/group__CUDA__MATH__INT.html).

The `long` and `long long` overload families each accept their signed and
unsigned types. Mixing signedness within either family selects its unsigned
type. Mixing the two families can be ambiguous and is rejected when no single
overload is best.

The `float, float` overloads of `min` and `max`, and the functions `fminf` and
`fmaxf`, return `float`. `fminf` and `fmaxf` also accept scalar arguments that
convert to `float`, including integers and booleans. Mixed floating-point and
integer calls to `min` or `max` can be ambiguous.

These floating-point functions choose the numeric argument when the other is
NaN, and return a quiet NaN when both are NaNs. The frontend chooses the
canonical bits `0x7fc00000` for that result; CUDA does not specify its payload.
The lowering orders negative zero below positive zero and preserves subnormal
operand bits, following the default PTX
[`min`](https://docs.nvidia.com/cuda/parallel-thread-execution/#floating-point-instructions-min)
and [`max`](https://docs.nvidia.com/cuda/parallel-thread-execution/#floating-point-instructions-max)
rules. Floating `min` and `max` are equivalent to `fminf` and `fmaxf`, as described
in NVIDIA's [single-precision functions](https://docs.nvidia.com/cuda/archive/13.0.0/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).

`fabsf(float)` and the `fabs(float)` overload return the absolute value as
`float`. Integer operations preserve the magnitude of the received representation,
including subnormal inputs. Both signed zeros produce positive zero, both
infinities produce positive infinity, and NaNs produce the canonical quiet NaN
`0x7fc00000`; CUDA leaves the NaN representation unspecified.
These results follow NVIDIA's
[`fabsf` specification](https://docs.nvidia.com/cuda/archive/13.0.1/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).
`fabsf` converts scalar arguments to `float` before taking the absolute value.
Integral arguments to `fabs` select unsupported double-precision overloads;
use `fabsf` or explicitly convert to `float`. Exact user-defined integral
overloads still participate and take precedence over the library templates.
Calls execute at runtime and are not constant expressions.

`__fadd_rn(float, float)` computes a single-precision sum rounded once to nearest,
with ties to even. Scalar arguments convert to `float` first. A cached integer
helper aligns significands, retains guard, round, and sticky bits, and rounds the
result without native floating-point addition or wider shader types. This also
prevents contraction with a preceding multiplication, as required by NVIDIA's
[`__fadd_rn` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).

The calculation uses the received operand representations, preserving subnormal
inputs and results. Overflow rounds to signed infinity. Equal signed infinities
retain their sign; opposite infinities and NaN inputs produce the canonical quiet
NaN `0x7fc00000`, whose payload is a frontend choice. Adding two negative zeros
returns negative zero; mixed zeros and exact cancellation return positive zero.
Calls execute at runtime and are not source constant expressions.

`__fadd_rz(float, float)` adds single-precision operands and rounds toward zero,
following NVIDIA's
[`__fadd_rz` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Scalar arguments convert to `float` first. It shares the integer addition
algorithm with `__fadd_rn` through a separate cached helper, preserving received
subnormals and preventing contraction with preceding multiplication. Discarded
bits still affect opposite-sign subtraction: `1.0f` plus a negative minimum
subnormal rounds to the representable value immediately below `1.0f`.
Finite overflow saturates to the largest finite value with the result's sign.
Actual infinity inputs, NaNs, and signed-zero cases retain the same special
behavior as `__fadd_rn`. Calls execute at runtime and are not source constant
expressions.

`__fadd_rd(float, float)` rounds the sum toward negative infinity and
`__fadd_ru(float, float)` rounds it toward positive infinity. The helpers
increment the magnitude of an inexact sum when rounding away from zero.
Overflow in that direction returns signed infinity. Overflow in the other
direction returns the signed largest finite value. Exact cancellation and
mixed-sign zeros yield negative zero with `__fadd_rd` and positive zero with
`__fadd_ru`. Same-sign zeros retain their sign. Argument conversion, infinity
and NaN handling, and runtime evaluation follow `__fadd_rn`.

`__fsub_rn(float, float)` computes a single-precision difference rounded once to
nearest, with ties to even, following NVIDIA's
[`__fsub_rn` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Scalar arguments convert to `float` before the second operand's sign bit is
flipped with integer operations. Subtraction then reuses the same exact addition
helper, preserving received subnormal representations and preventing contraction
with preceding multiplication. NaN inputs and equal signed infinities produce
the canonical quiet NaN `0x7fc00000`. Subtracting positive zero from negative zero
returns negative zero; all other zero pairs and exact cancellation return positive
zero. Calls execute at runtime and are not source constant expressions.

`__fsub_rz(float, float)` computes a single-precision difference rounded toward
zero, following NVIDIA's
[`__fsub_rz` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Scalar arguments convert to `float` before the second operand's sign bit is
flipped. It shares the cached integer helper with `__fadd_rz`, preserving
received subnormals and preventing contraction with preceding multiplication.
Finite overflow saturates to the signed largest finite value. Infinity, NaN,
and signed-zero cases follow `__fsub_rn`. Calls execute at runtime and are not
source constant expressions.

`__fsub_rd(float, float)` and `__fsub_ru(float, float)` reuse the corresponding
directed addition helpers after flipping the second operand's sign bit.

`__fmul_rn(float, float)` computes a single-precision product rounded once to
nearest, with ties to even, following NVIDIA's
[`__fmul_rn` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Scalar arguments convert to `float` first. A cached integer helper multiplies
their significands using 32-bit integer operations and rounds the exact product.
It preserves received subnormal inputs and gradually underflowed results, using
no native floating-point multiplication or wider shader types. This prevents
contraction with following addition or subtraction. A non-NaN result's sign is
the exclusive OR of the operand signs, including zero, infinity, and underflow
to zero. NaN inputs and zero multiplied by infinity produce the canonical quiet
NaN `0x7fc00000`, whose payload is a frontend choice. Overflow rounds to signed infinity. Calls
execute at runtime and are not source constant expressions.

`__fmul_rz(float, float)` computes a single-precision product rounded toward
zero, following NVIDIA's
[`__fmul_rz` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Scalar arguments convert to `float` first. It shares the exact integer product
algorithm with `__fmul_rn` through a separate cached helper, preserving received
subnormal inputs and preventing contraction with following addition or
subtraction. Finite overflow saturates to the signed largest finite value;
inexact underflow truncates toward signed zero. Actual infinity inputs, NaNs,
and zero products follow `__fmul_rn`. Calls execute at runtime and are not
source constant expressions.

`__fmul_rd(float, float)` rounds toward negative infinity and
`__fmul_ru(float, float)` rounds toward positive infinity. They share the
exact integer product algorithm with separate cached helpers. If a finite
product is inexact, the helper increases the magnitude by one representable
step when rounding away from zero. In that direction, overflow returns signed
infinity and a nonzero product below the minimum subnormal rounds to the signed
minimum subnormal. Rounding toward zero saturates finite overflow and preserves
the sign of underflow to zero. Argument conversion, special values, and
runtime-only evaluation follow `__fmul_rn`.

`__fmaf_rn(float, float, float)` computes `x * y + z` as one operation rounded
once to nearest, with ties to even, following NVIDIA's
[`__fmaf_rn` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
All three scalar arguments convert to `float` first. A cached integer helper
retains the full product through addition and rounds only the final sum, using
32-bit integer operations without native FMA or wider shader types. This retains
subnormal contributions and permits a finite sum when the intermediate product
would overflow or underflow if rounded separately.

NaN inputs, zero multiplied by infinity, and an infinite product added to an
oppositely signed infinity produce the canonical quiet NaN `0x7fc00000`, whose
payload is a frontend choice. An exact zero is negative only when both the
product and addend are negative zeros; other exact cancellation returns positive
zero. Nonzero sums that underflow retain their sign, and overflow rounds to
signed infinity. Calls execute at runtime and are not source constant
expressions.

`__fmaf_rz(float, float, float)` computes `x * y + z` as one operation rounded
once toward zero, following NVIDIA's
[`__fmaf_rz` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
All three scalar arguments convert to `float` first. A separate cached helper
shares the exact integer product and addition algorithm, retaining subnormal
contributions through cancellation. For example, `1.0f * 1.0f` plus a negative
minimum subnormal rounds to the representable value immediately below `1.0f`.
Finite overflow saturates to the signed largest finite value; underflowed
results retain their sign. Special values and exact-zero cases follow
`__fmaf_rn`. Calls execute at runtime and are not source constant expressions.

`__fmaf_rd(float, float, float)` rounds the exact fused result toward negative
infinity and `__fmaf_ru(float, float, float)` rounds it toward positive
infinity. Both reuse the integer product and addition algorithm. Rounding
away from zero gives signed infinity on overflow and the signed minimum
subnormal for nonzero results below that magnitude. Rounding toward zero
saturates finite overflow and preserves the sign of underflow to zero. Exact
cancellation and mixed-sign zero terms produce negative zero with `__fmaf_rd`
and positive zero with `__fmaf_ru`. Same-sign zero terms retain their sign.

`__fmaf_ieee_rn`, `__fmaf_ieee_rz`, `__fmaf_ieee_rd`, and `__fmaf_ieee_ru`
share the corresponding FMA helpers. These helpers preserve subnormal inputs
and results, matching the IEEE variants' behavior under CUDA's
`-ftz=true` flag. See NVIDIA's
[`__fmaf_ieee_*` specifications](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).

`fmaf(float, float, float)` uses the same single-rounded operation, following
NVIDIA's
[`fmaf` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).
All three scalar arguments convert to `float`, and the result is `float`.
Calls share the existing integer helper with `__fmaf_rn`, including its special
values, signed-zero, subnormal, and overflow behavior. Calls execute at runtime
and are not source constant expressions. The unsuffixed `fma` family remains
unsupported.

`copysignf(float, float)` returns the first argument's magnitude with the second
argument's sign. Scalar arguments convert to `float` before integer bit operations
combine their received representations. This preserves zeros, subnormals,
infinities, and NaN magnitude bits. A NaN first argument produces a NaN with the
second argument's sign, following NVIDIA's
[`copysignf` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).
Preserving the received NaN payload and signaling bit is this frontend's choice;
CUDA does not specify a payload. A NaN second argument contributes only its sign.
Calls execute at runtime and are not source constant expressions. Double-precision
`copysign` remains unsupported.

`nextafterf(float, float)` steps from the first argument to the adjacent
single-precision value in the direction of the second argument. Scalar arguments
convert to `float` before a cached integer helper computes the result. Equal
arguments return the second argument, including its sign when both arguments
are zero. Stepping from zero toward a nonzero value produces the smallest
subnormal with the target's sign. The helper also handles transitions between
subnormals, normals, and infinities. A NaN argument produces the canonical
quiet NaN `0x7fc00000`. See NVIDIA's
[`nextafterf` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).
Calls execute at runtime and do not qualify as source constant expressions.

`fdimf(float, float)` returns the single-precision difference of its
arguments when the first is greater than the second. If the first argument
is less than or equal to the second, the result is positive zero. This
includes equal infinities and signed zeros.
Scalar arguments convert to `float` before subtraction. The operation
shares the integer helper used by `__fsub_rn`, including ties-to-even
rounding and subnormal results. A NaN argument produces the canonical
quiet NaN `0x7fc00000`. Calls execute at runtime.
See NVIDIA's [`fdimf` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).

`ilogbf(float)` returns the unbiased binary exponent as a signed `int`.
Scalar arguments convert to `float` before the calculation. The result has
the same exponent for either input sign and ranges from −149 to 127 for
finite nonzero inputs, including subnormals. Both signs of zero and all
NaNs produce `INT_MIN`. Both infinities produce `INT_MAX`.
Calls execute at runtime. See NVIDIA's
[`ilogbf` specification](https://docs.nvidia.com/cuda/libdevice-users-guide/__nv_ilogbf.html).

`logbf(float)` returns that same unbiased exponent as a `float` for
finite nonzero inputs. Scalar arguments convert to `float` first. Both
signs of zero produce negative infinity, both infinities produce positive
infinity, and NaNs produce the canonical quiet NaN `0x7fc00000`.
Calls execute at runtime. See NVIDIA's
[`logbf` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).

`ldexpf(float, int)` and `scalbnf(float, int)` multiply the first argument
by two raised to the second argument. Scalar arguments convert to `float`
and `int` before scaling. Both names share an integer helper that preserves
both signs of zero and infinity,
normalizes subnormal inputs, and rounds underflow to nearest with ties
to even. Overflow produces infinity with the input sign. NaNs produce
the canonical quiet NaN `0x7fc00000`. Calls execute at runtime.
See NVIDIA's [single-precision math specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).

`remainderf(float, float)` subtracts the divisor multiplied by the nearest
integer quotient from the dividend. A quotient exactly halfway between two
integers selects the even integer. For example, `remainderf(3.0f, 2.0f)`
returns `-1.0f`, and `remainderf(5.0f, 2.0f)` returns `1.0f`.
The integer helper preserves the sign of the dividend on zero results
and passes finite dividends through when the divisor is infinite.
An infinite dividend, zero divisor, or NaN argument produces the
canonical quiet NaN `0x7fc00000`. Arguments convert to `float` and the
call executes at runtime. See NVIDIA's
[`remainderf` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).

`isfinite(float)`, `isinf(float)`, `isnan(float)`, and `signbit(float)` classify
the received single-precision representation using integer bit operations.
They return `int`, following NVIDIA's default
[classification signatures](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html),
with zero for false and one for true.

| Function | True condition |
| --- | --- |
| `isfinite` | Zero, subnormal, or normal finite value |
| `isinf` | Positive or negative infinity |
| `isnan` | Any quiet or signaling NaN, regardless of sign or payload |
| `signbit` | Sign bit set, including negative zero, infinities, and NaNs |

These builtins require `float` arguments. Explicitly cast integral values to
`float` to classify them; winning user-defined overloads still participate in
ordinary and template lookup. Calls execute at runtime and are not source
constant expressions. Double-precision classification remains unsupported.

The libdevice functions `__nv_finitef`, `__nv_isinff`, `__nv_isnanf`, and
`__nv_signbitf` use the same bit tests and return `int`. Their fixed
`int(float)` signatures convert scalar arguments to `float` before
classification. See NVIDIA's
[libdevice function signatures](https://docs.nvidia.com/cuda/libdevice-users-guide/libdevice_users_guide/functions.html).

`fmodf(float, float)` returns the remainder after dividing the first argument
by the second with the quotient truncated toward zero. Scalar arguments convert
to `float` first. Integer significand reduction computes exact finite remainders,
preserving subnormal values and the first argument's sign, including signed zero.
A finite first argument and an infinite second argument return the first argument.
An infinite first argument, a zero second argument, or a NaN argument produces
the canonical quiet NaN `0x7fc00000`. CUDA leaves its representation unspecified.
These results follow NVIDIA's
[`fmodf` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).
Calls execute at runtime and are not constant expressions.

`sqrtf(float)` returns `float` and accepts scalar arguments that convert to
`float`. The `sqrt(float)` overload uses the same implementation, following
CUDA's [overloaded math functions](https://docs.nvidia.com/cuda/archive/13.0.1/cuda-math-api/index.html).
Integral arguments to `sqrt` select unsupported double-precision overloads;
use `sqrtf` or explicitly convert to `float`. Exact user-defined integral
overloads still participate and take precedence over the library templates.
Positive finite inputs use correctly rounded, round-to-nearest
ties-to-even results, matching CUDA's default
[`prec-sqrt=true`](https://docs.nvidia.com/cuda/archive/13.0.1/cuda-compiler-driver-nvcc/index.html#prec-sqrt-true-false-prec-sqrt).
The calculation uses integer operations on the input representation, including
subnormal inputs. Both signed zeros and positive infinity retain their bits;
negative nonzero inputs and NaNs produce the canonical quiet NaN `0x7fc00000`.
Calls execute at runtime and are not constant expressions, including calls with
literal arguments. The double-precision `sqrt` remains unsupported.

`__fsqrt_rn(float)` exposes the same correctly rounded square-root operation
through CUDA's fixed single-precision intrinsic signature, following NVIDIA's
[`__fsqrt_rn` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Scalar arguments, including integral arguments, convert to `float` first, and
the result is `float`. Calls share the existing integer helper with `sqrtf` and
`sqrt(float)`, preserving subnormal inputs, both zero signs, positive infinity,
and the same canonical-NaN policy. Calls execute at runtime and are not source
constant expressions.

`__fsqrt_rz(float)` computes a single-precision square root rounded toward zero,
following NVIDIA's
[`__fsqrt_rz` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Scalar arguments convert to `float` first. A separate cached helper shares the
integer restoring-root algorithm, returning the representable value at or below
the exact positive root. Received subnormal inputs are preserved. Both zero
signs and positive infinity retain their bits; negative nonzero inputs and NaNs
produce the canonical quiet NaN `0x7fc00000`. Calls execute at runtime and are
not source constant expressions.

`__fsqrt_rd(float)` rounds toward negative infinity. It shares the
`__fsqrt_rz` helper because finite square roots are nonnegative.
`__fsqrt_ru(float)` rounds toward positive infinity. Its helper advances
an inexact root to the next representable value and preserves an exact root.
Both modes use the same scalar conversions and special-value rules as
`__fsqrt_rz`. See NVIDIA's
[single-precision intrinsics](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).

`rsqrtf(float)` returns the reciprocal square root and accepts scalar arguments
that convert to `float`. Positive finite inputs use a correctly rounded square
root followed by correctly rounded division of one by that root. This composition
is within one representable single-precision step of the correctly rounded
reciprocal square root, including subnormal inputs. Signed zeros produce the
corresponding signed infinity, and positive infinity produces positive zero.
Negative nonzero inputs and NaNs produce the canonical quiet NaN `0x7fc00000`.
These special cases follow the
[CUDA math reference](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).
Calls share the existing square-root and division helpers and require a runtime
context, including calls with literal arguments.

`__frsqrt_rn(float)` computes the single-precision reciprocal square root with
one round-to-nearest, ties-to-even step, following NVIDIA's
[`__frsqrt_rn` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Scalar arguments convert to `float` first. A cached helper selects the nearest
representable result using exact integer midpoint comparisons and only 32-bit
integer arithmetic. It preserves received subnormal inputs without native
square-root or division operations and requires no wider shader types.
Finite positive inputs produce normal results. Signed zeros produce the
corresponding signed infinity, and positive infinity produces positive zero.
Negative nonzero inputs and NaNs produce the canonical quiet NaN `0x7fc00000`,
whose payload is a frontend choice. Calls execute at runtime and are not source
constant expressions.

`floorf(float)` returns the greatest integral value no greater than its argument,
represented as `float`. Scalar arguments convert to `float` before rounding.
For example, `floorf(-0.25f)` returns `-1.0f`; negative nonzero subnormal inputs
also produce `-1.0f`. Integer operations on the received representation preserve
both signed zeros, both infinities, and large integral values. NaNs produce the
canonical quiet NaN `0x7fc00000`. These results follow NVIDIA's
[`floorf` specification](https://docs.nvidia.com/cuda/archive/13.0.1/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).
Calls execute at runtime and are not constant expressions. Double-precision
`floor` remains unsupported.

`ceilf(float)` returns the least integral value no less than its argument,
represented as `float`. Scalar arguments convert to `float` first. Positive
nonzero subnormals produce `1.0f`; negative values between `-1.0f` and zero
produce negative zero. Integer operations preserve both signed zeros, infinities,
and large integral values. NaNs produce the canonical quiet NaN `0x7fc00000`.
These results follow NVIDIA's
[`ceilf` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).
Calls execute at runtime and are not constant expressions. Double-precision
`ceil` remains unsupported.

`roundf(float)` returns the nearest integral value as `float`, with halfway
cases rounded away from zero. Scalar arguments convert to `float` first.
Integer operations preserve signed zero, infinity, and large integral values.
Values with magnitude below `0.5f`, including subnormals, produce zero with
the input sign. NaNs produce the canonical quiet NaN `0x7fc00000`.
These results follow NVIDIA's
[`roundf` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).
Calls execute at runtime and are not constant expressions.

`truncf(float)` rounds toward zero and returns the integral result as `float`.
Scalar arguments convert to `float` first. Values with magnitude below one,
including subnormals, produce zero with the input sign. Integer operations
preserve infinities and large integral values. NaNs produce the canonical quiet
NaN `0x7fc00000`. These results follow NVIDIA's
[`truncf` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).
Calls execute at runtime. Double-precision `trunc` remains unsupported.

`rintf(float)` returns the nearest integral value as `float`, with halfway
cases rounded to the even integer. For example, `rintf(-0.5f)` returns negative
zero and `rintf(2.5f)` returns `2.0f`. Scalar arguments convert to `float` first.
Integer operations preserve signed zeros, infinities, and large integral values.
NaNs produce the canonical quiet NaN `0x7fc00000`. These results follow NVIDIA's
[`rintf` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__SINGLE.html).
`nearbyintf(float)` uses the same nearest-even result and conversion rules.
Both functions execute at runtime and share one generated helper. The
unsuffixed `rint` and `nearbyint` forms remain unsupported.

`__saturatef(float)` clamps its argument to `[+0.0, 1.0]` and returns `float`.
Scalar arguments convert to `float` first. Negative values, both signed zeros,
and NaNs produce positive zero; values greater than one produce one. Positive
values below one retain their received bits, including subnormals. These results
follow NVIDIA's
[`__saturatef` specification](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SINGLE.html).
Calls execute at runtime and are not constant expressions.

`sinf(float)` and `cosf(float)` return `float` and accept scalar arguments that
convert to `float`. Integer range reduction and polynomial evaluation cover
the full finite input range, with results within two ULP of the exact sine or
cosine rounded to `float`. This matches the accuracy reported for NVIDIA's
[single-precision functions](https://docs.nvidia.com/cuda/archive/13.1.0/cuda-programming-guide/05-appendices/mathematical-functions.html).
The calculation uses the received input representation, including subnormals.
`sinf` preserves signed zero, and `cosf` returns `1.0f` for both signed zeros.
Infinities and NaNs produce the canonical quiet NaN `0x7fc00000`.
Calls execute at runtime and are not constant expressions. Double-precision
`sin` and `cos`, fast intrinsics, and `sincosf` remain unsupported.

Small `floorf`, `ceilf`, `sinf`, and `cosf` results assemble their bit patterns
with integer arithmetic to preserve zero signs through shader optimization.

Target floating-point rules still apply. In particular, WGSL permits
[finite-math assumptions, changes to zero signs, and flushing subnormals](https://gpuweb.github.io/gpuweb/wgsl/#floating-point-evaluation),
so exceptional values are not guaranteed to retain these bits on every target.

These names use the same argument sequencing and overload ranking as device
helpers.
Additional user-defined overloads participate alongside the predefined ones;
definitions repeating a predefined parameter signature are rejected, including
through aliases or top-level `const`. Local values and type names can hide these
functions. Kernels and file-scope type aliases named `min`, `max`, `fminf`,
`fmaxf`, `fabs`, `fabsf`, `__fadd_rn`, `__fadd_rz`, `__fadd_rd`, `__fadd_ru`, `__fsub_rn`, `__fsub_rz`, `__fsub_rd`, `__fsub_ru`, `__fmul_rn`, `__fmul_rz`, `__fmul_rd`, `__fmul_ru`, `__fdiv_rn`, `__fdividef`, `__fdiv_rz`, `__fdiv_rd`, `__fdiv_ru`, `__frcp_rn`, `__frcp_rz`, `__frcp_rd`, `__frcp_ru`, `__fsqrt_rn`, `__fsqrt_rz`, `__fsqrt_rd`, `__fsqrt_ru`, `__frsqrt_rn`, `__fmaf_rn`, `__fmaf_rz`, `__fmaf_rd`, `__fmaf_ru`, `__fmaf_ieee_rn`, `__fmaf_ieee_rz`, `__fmaf_ieee_rd`, `__fmaf_ieee_ru`, `fmaf`, `copysignf`, `nextafterf`, `fdimf`, `ilogbf`, `logbf`, `ldexpf`, `scalbnf`, `fmodf`, `remainderf`, `sqrt`, `sqrtf`, `rsqrtf`, `floorf`, `ceilf`, `roundf`, `truncf`, `rintf`, `nearbyintf`, `__saturatef`, `sinf`, `cosf`, `isfinite`, `isinf`, `isnan`, `signbit`, `__nv_finitef`, `__nv_isinff`, `__nv_isnanf`, or `__nv_signbitf` remain unsupported.

## Bit reinterpretation

These predefined functions reinterpret a 32-bit scalar's representation:

| Function | Parameter | Result |
| --- | --- | --- |
| `__float_as_int` | `float` | `int` |
| `__float_as_uint` | `float` | `unsigned int` |
| `__int_as_float` | `int` | `float` |
| `__uint_as_float` | `unsigned int` | `float` |

Each call first converts its argument to the parameter type, then reinterprets
the bits as the result type. For example, `__float_as_uint(1u)` returns
`0x3f800000u`, the representation of `1.0f`. Ordinary casts still perform numeric
conversions. These signatures follow NVIDIA's
[type casting intrinsics](https://docs.nvidia.com/cuda/archive/13.0.0/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__CAST.html).

Calls use the same argument evaluation, overload selection, and name hiding
rules as other predefined functions. Additional user-defined overloads are
accepted; definitions repeating a predefined parameter signature are rejected,
including through aliases or top-level `const`. Kernels and file-scope aliases
cannot use these function names. Other bit reinterpretation intrinsics remain
unsupported.

Floating-point results execute at runtime, including calls with literal bit
patterns for infinity and NaN. Target floating-point rules still apply:
WGSL permits [changes to zero signs, subnormal flushing, and finite-math assumptions](https://gpuweb.github.io/gpuweb/wgsl/#floating-point-evaluation),
so exceptional bit patterns are not guaranteed to survive every target.

## Integer intrinsics

`__float2int_rz(float)` and `__float2uint_rz(float)` convert their arguments to
`float`, truncate toward zero, and return `int` and `unsigned int`, respectively.
CUDA leaves the result undefined when the truncated value falls outside the
return type's range or the input is nonfinite. In the unsigned form, negative
fractions greater than `-1` truncate to zero. Both intrinsics follow the runtime
and overload rules for predefined device functions.

`__float2int_rd(float)` and `__float2int_ru(float)` convert their arguments
to `float`, round toward negative and positive infinity respectively, and
return `int`. They reuse the integer helpers for `floorf` and `ceilf`.
For example, `__float2int_rd` rounds negative subnormals to `-1` and
`__float2int_ru` rounds positive subnormals to `1`. CUDA leaves nonfinite
inputs and rounded values outside the signed integer range undefined.
Both intrinsics follow the same runtime and overload rules as the
round-toward-zero forms.

`__float2int_rn(float)` converts its argument to `float` and returns the
nearest `int`, choosing the even integer on a tie. It shares the integer
rounding helper with `rintf`. For example, both `1.5f` and `2.5f`
round to `2`, and both `-1.5f` and `-2.5f` round to `-2`.
The same range, runtime, and overload rules apply.

`__float2uint_rd(float)`, `__float2uint_ru(float)`, and `__float2uint_rn(float)`
use the same rounding as their signed counterparts and return `unsigned int`.
Both zero signs produce zero. Rounding down sends every negative nonzero
input below zero. Rounding up sends inputs strictly between `-1` and `0`
to zero and positive subnormals to `1`. Rounding to nearest sends negative
inputs from `-0.5` through zero to zero and chooses the even integer on ties.
A rounded value outside the unsigned range has an undefined result.
See NVIDIA's [conversion intrinsics](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__CAST.html).

`__int2float_rz(int)` and `__uint2float_rz(unsigned int)` convert the argument
to the declared integer parameter type first, then round toward zero to produce
a `float`. For example, `2147483647` becomes `2147483520.0f` in the signed
form, and `4294967295u` becomes `4294967040.0f` in the unsigned form. Both
conversions are exact for integers representable as `float`, including zero.

`__int2float_rn(int)` and `__uint2float_rn(unsigned int)` convert the argument
to the declared integer type first, then round to the nearest representable
`float`, choosing the even significand on a tie. For example, `16777217` becomes
`16777216.0f`, `16777219` becomes `16777220.0f`, and `4294967295u` becomes
`4294967296.0f`.

`__int2float_rd(int)` and `__uint2float_rd(unsigned int)` convert the argument
to the declared integer type first, then round toward negative infinity. For
example, `16777217` becomes `16777216.0f` and `-16777217` becomes `-16777218.0f`
in the signed form. The unsigned form gives the same result as
`__uint2float_rz` because every converted argument is nonnegative.

`__int2float_ru(int)` and `__uint2float_ru(unsigned int)` convert the argument
to the declared integer type first, then round toward positive infinity. For
example, `16777217` becomes `16777218.0f`, `-16777217` becomes `-16777216.0f`,
and `4294967041u` becomes `4294967296.0f`.

These predefined functions operate on integer representations:

| Function | Parameters | Result | Operation |
| --- | --- | --- | --- |
| `__clz` | `int` | `int` | Count leading zero bits; zero returns 32. |
| `__clzll` | `long long` | `int` | Count leading zero bits across all 64 bits; zero returns 64. |
| `__ffs` | `int` | `int` | Return the first set bit's position, starting at 1; zero returns 0. |
| `__ffsll` | `long long` | `int` | Return the first set bit's position across all 64 bits, starting at 1; zero returns 0. |
| `__fns` | `unsigned int mask, unsigned int base, int offset` | `unsigned int` | Find a set bit by signed rank from a base position; return `0xffffffffu` when none is found. |
| `__popc` | `unsigned int` | `int` | Count set bits. |
| `__popcll` | `unsigned long long` | `int` | Count set bits across all 64 bits. |
| `__brev` | `unsigned int` | `unsigned int` | Reverse all 32 bits. |
| `__brevll` | `unsigned long long` | `unsigned long long` | Reverse all 64 bits. |
| `__nv_bswap32` | `unsigned int` | `unsigned int` | Reverse the order of the four bytes of a 32-bit word. |
| `__mul24` | `int, int` | `int` | Multiply signed 24-bit operands and return the low 32 product bits. |
| `__umul24` | `unsigned int, unsigned int` | `unsigned int` | Multiply unsigned 24-bit operands and return the low 32 product bits. |
| `__mulhi` | `int, int` | `int` | Return the high 32 bits of the signed 64-bit product. |
| `__umulhi` | `unsigned int, unsigned int` | `unsigned int` | Return the high 32 bits of the unsigned 64-bit product. |
| `__hadd` | `int, int` | `int` | Compute the exact signed average, rounded down, without overflowing the sum. |
| `__rhadd` | `int, int` | `int` | Compute the exact signed average, rounded up, without overflowing the sum. |
| `__uhadd` | `unsigned int, unsigned int` | `unsigned int` | Compute the exact unsigned average, rounded down, without overflowing the sum. |
| `__urhadd` | `unsigned int, unsigned int` | `unsigned int` | Compute the exact unsigned average, rounded up, without overflowing the sum. |
| `__vabs2` | `unsigned int` | `unsigned int` | Take the absolute value of two packed signed 16-bit lanes, returning unsigned lane magnitudes. |
| `__vabs4` | `unsigned int` | `unsigned int` | Take the absolute value of four packed signed 8-bit lanes, returning unsigned lane magnitudes. |
| `__vabsss2` | `unsigned int` | `unsigned int` | Take the absolute value of two packed signed 16-bit lanes, saturating to the signed lane maximum. |
| `__vabsss4` | `unsigned int` | `unsigned int` | Take the absolute value of four packed signed 8-bit lanes, saturating to the signed lane maximum. |
| `__vabsdiffs2` | `unsigned int, unsigned int` | `unsigned int` | Take the absolute differences of two packed signed 16-bit lanes, returning unsigned magnitudes. |
| `__vabsdiffs4` | `unsigned int, unsigned int` | `unsigned int` | Take the absolute differences of four packed signed 8-bit lanes, returning unsigned magnitudes. |
| `__vabsdiffu2` | `unsigned int, unsigned int` | `unsigned int` | Take the absolute differences of two packed unsigned 16-bit lanes. |
| `__vabsdiffu4` | `unsigned int, unsigned int` | `unsigned int` | Take the absolute differences of four packed unsigned 8-bit lanes. |
| `__vmins2` | `unsigned int, unsigned int` | `unsigned int` | Select signed minima in two packed 16-bit lanes. |
| `__vmins4` | `unsigned int, unsigned int` | `unsigned int` | Select signed minima in four packed 8-bit lanes. |
| `__vminu2` | `unsigned int, unsigned int` | `unsigned int` | Select unsigned minima in two packed 16-bit lanes. |
| `__vminu4` | `unsigned int, unsigned int` | `unsigned int` | Select unsigned minima in four packed 8-bit lanes. |
| `__vmaxs2` | `unsigned int, unsigned int` | `unsigned int` | Select signed maxima in two packed 16-bit lanes. |
| `__vmaxs4` | `unsigned int, unsigned int` | `unsigned int` | Select signed maxima in four packed 8-bit lanes. |
| `__vmaxu2` | `unsigned int, unsigned int` | `unsigned int` | Select unsigned maxima in two packed 16-bit lanes. |
| `__vmaxu4` | `unsigned int, unsigned int` | `unsigned int` | Select unsigned maxima in four packed 8-bit lanes. |
| `__vcmpeq2` | `unsigned int, unsigned int` | `unsigned int` | Return equality masks in two packed 16-bit lanes. |
| `__vcmpeq4` | `unsigned int, unsigned int` | `unsigned int` | Return equality masks in four packed 8-bit lanes. |
| `__vcmpne2` | `unsigned int, unsigned int` | `unsigned int` | Return inequality masks in two packed 16-bit lanes. |
| `__vcmpne4` | `unsigned int, unsigned int` | `unsigned int` | Return inequality masks in four packed 8-bit lanes. |
| `__vseteq2` | `unsigned int, unsigned int` | `unsigned int` | Return equality as 0 or 1 in each of two packed 16-bit lanes. |
| `__vseteq4` | `unsigned int, unsigned int` | `unsigned int` | Return equality as 0 or 1 in each of four packed 8-bit lanes. |
| `__vsetne2` | `unsigned int, unsigned int` | `unsigned int` | Return inequality as 0 or 1 in each of two packed 16-bit lanes. |
| `__vsetne4` | `unsigned int, unsigned int` | `unsigned int` | Return inequality as 0 or 1 in each of four packed 8-bit lanes. |
| `__vcmplts2` | `unsigned int, unsigned int` | `unsigned int` | Return signed less-than masks in two packed 16-bit lanes. |
| `__vcmplts4` | `unsigned int, unsigned int` | `unsigned int` | Return signed less-than masks in four packed 8-bit lanes. |
| `__vcmpltu2` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned less-than masks in two packed 16-bit lanes. |
| `__vcmpltu4` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned less-than masks in four packed 8-bit lanes. |
| `__vsetlts2` | `unsigned int, unsigned int` | `unsigned int` | Return signed less-than as 0 or 1 in each of two packed 16-bit lanes. |
| `__vsetlts4` | `unsigned int, unsigned int` | `unsigned int` | Return signed less-than as 0 or 1 in each of four packed 8-bit lanes. |
| `__vsetltu2` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned less-than as 0 or 1 in each of two packed 16-bit lanes. |
| `__vsetltu4` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned less-than as 0 or 1 in each of four packed 8-bit lanes. |
| `__vcmples2` | `unsigned int, unsigned int` | `unsigned int` | Return signed less-than-or-equal masks in two packed 16-bit lanes. |
| `__vcmples4` | `unsigned int, unsigned int` | `unsigned int` | Return signed less-than-or-equal masks in four packed 8-bit lanes. |
| `__vcmpleu2` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned less-than-or-equal masks in two packed 16-bit lanes. |
| `__vcmpleu4` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned less-than-or-equal masks in four packed 8-bit lanes. |
| `__vsetles2` | `unsigned int, unsigned int` | `unsigned int` | Return signed less-than-or-equal as 0 or 1 in each of two packed 16-bit lanes. |
| `__vsetles4` | `unsigned int, unsigned int` | `unsigned int` | Return signed less-than-or-equal as 0 or 1 in each of four packed 8-bit lanes. |
| `__vsetleu2` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned less-than-or-equal as 0 or 1 in each of two packed 16-bit lanes. |
| `__vsetleu4` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned less-than-or-equal as 0 or 1 in each of four packed 8-bit lanes. |
| `__vcmpgts2` | `unsigned int, unsigned int` | `unsigned int` | Return signed greater-than masks in two packed 16-bit lanes. |
| `__vcmpgts4` | `unsigned int, unsigned int` | `unsigned int` | Return signed greater-than masks in four packed 8-bit lanes. |
| `__vcmpgtu2` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned greater-than masks in two packed 16-bit lanes. |
| `__vcmpgtu4` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned greater-than masks in four packed 8-bit lanes. |
| `__vsetgts2` | `unsigned int, unsigned int` | `unsigned int` | Return signed greater-than as 0 or 1 in each of two packed 16-bit lanes. |
| `__vsetgts4` | `unsigned int, unsigned int` | `unsigned int` | Return signed greater-than as 0 or 1 in each of four packed 8-bit lanes. |
| `__vsetgtu2` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned greater-than as 0 or 1 in each of two packed 16-bit lanes. |
| `__vsetgtu4` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned greater-than as 0 or 1 in each of four packed 8-bit lanes. |
| `__vcmpges2` | `unsigned int, unsigned int` | `unsigned int` | Return signed greater-than-or-equal masks in two packed 16-bit lanes. |
| `__vcmpges4` | `unsigned int, unsigned int` | `unsigned int` | Return signed greater-than-or-equal masks in four packed 8-bit lanes. |
| `__vcmpgeu2` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned greater-than-or-equal masks in two packed 16-bit lanes. |
| `__vcmpgeu4` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned greater-than-or-equal masks in four packed 8-bit lanes. |
| `__vsetges2` | `unsigned int, unsigned int` | `unsigned int` | Return signed greater-than-or-equal as 0 or 1 in each of two packed 16-bit lanes. |
| `__vsetges4` | `unsigned int, unsigned int` | `unsigned int` | Return signed greater-than-or-equal as 0 or 1 in each of four packed 8-bit lanes. |
| `__vsetgeu2` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned greater-than-or-equal as 0 or 1 in each of two packed 16-bit lanes. |
| `__vsetgeu4` | `unsigned int, unsigned int` | `unsigned int` | Return unsigned greater-than-or-equal as 0 or 1 in each of four packed 8-bit lanes. |
| `__vneg2` | `unsigned int` | `unsigned int` | Negate two packed signed 16-bit lanes with lane-width wrapping. |
| `__vneg4` | `unsigned int` | `unsigned int` | Negate four packed signed 8-bit lanes with lane-width wrapping. |
| `__vnegss2` | `unsigned int` | `unsigned int` | Negate two packed signed 16-bit lanes with signed saturation. |
| `__vnegss4` | `unsigned int` | `unsigned int` | Negate four packed signed 8-bit lanes with signed saturation. |
| `__vadd2` | `unsigned int, unsigned int` | `unsigned int` | Add two packed 16-bit lanes independently, wrapping each lane. |
| `__vadd4` | `unsigned int, unsigned int` | `unsigned int` | Add four packed 8-bit lanes independently, wrapping each lane. |
| `__vsub2` | `unsigned int, unsigned int` | `unsigned int` | Subtract two packed 16-bit lanes independently, wrapping each lane. |
| `__vsub4` | `unsigned int, unsigned int` | `unsigned int` | Subtract four packed 8-bit lanes independently, wrapping each lane. |
| `__vaddus2` | `unsigned int, unsigned int` | `unsigned int` | Add two packed unsigned 16-bit lanes, saturating each sum at `0xffff`. |
| `__vaddus4` | `unsigned int, unsigned int` | `unsigned int` | Add four packed unsigned 8-bit lanes, saturating each sum at `0xff`. |
| `__vsubus2` | `unsigned int, unsigned int` | `unsigned int` | Subtract two packed unsigned 16-bit lanes, saturating each difference at zero. |
| `__vsubus4` | `unsigned int, unsigned int` | `unsigned int` | Subtract four packed unsigned 8-bit lanes, saturating each difference at zero. |
| `__vaddss2` | `unsigned int, unsigned int` | `unsigned int` | Add two packed signed 16-bit lanes, saturating each sum to the signed lane range. |
| `__vaddss4` | `unsigned int, unsigned int` | `unsigned int` | Add four packed signed 8-bit lanes, saturating each sum to the signed lane range. |
| `__vsubss2` | `unsigned int, unsigned int` | `unsigned int` | Subtract two packed signed 16-bit lanes, saturating each difference to the signed lane range. |
| `__vsubss4` | `unsigned int, unsigned int` | `unsigned int` | Subtract four packed signed 8-bit lanes, saturating each difference to the signed lane range. |
| `__vavgs2` | `unsigned int, unsigned int` | `unsigned int` | Average two packed signed 16-bit lanes, rounding ties away from zero. |
| `__vavgs4` | `unsigned int, unsigned int` | `unsigned int` | Average four packed signed 8-bit lanes, rounding ties away from zero. |
| `__vavgu2` | `unsigned int, unsigned int` | `unsigned int` | Average two packed unsigned 16-bit lanes, rounding upward. |
| `__vavgu4` | `unsigned int, unsigned int` | `unsigned int` | Average four packed unsigned 8-bit lanes, rounding upward. |
| `__vhaddu2` | `unsigned int, unsigned int` | `unsigned int` | Average two packed unsigned 16-bit lanes, rounding downward. |
| `__vhaddu4` | `unsigned int, unsigned int` | `unsigned int` | Average four packed unsigned 8-bit lanes, rounding downward. |
| `__vsads2` | `unsigned int, unsigned int` | `unsigned int` | Sum absolute differences in two packed signed 16-bit lanes into a scalar. |
| `__vsads4` | `unsigned int, unsigned int` | `unsigned int` | Sum absolute differences in four packed signed 8-bit lanes into a scalar. |
| `__vsadu2` | `unsigned int, unsigned int` | `unsigned int` | Sum absolute differences in two packed unsigned 16-bit lanes into a scalar. |
| `__vsadu4` | `unsigned int, unsigned int` | `unsigned int` | Sum absolute differences in four packed unsigned 8-bit lanes into a scalar. |
| `__sad` | `int, int, unsigned int` | `unsigned int` | Add the absolute signed difference to an unsigned accumulator, wrapping to 32 bits. |
| `__usad` | `unsigned int, unsigned int, unsigned int` | `unsigned int` | Add the absolute unsigned difference to an unsigned accumulator, wrapping to 32 bits. |
| `__byte_perm` | `unsigned int, unsigned int, unsigned int` | `unsigned int` | Select four output bytes from eight input bytes using four selector nibbles. |
| `__dp4a` | `int, int, int` | `int` | Sum four signed packed-byte products and a signed accumulator, wrapping to 32 bits. |
| `__dp4a` | `unsigned int, unsigned int, unsigned int` | `unsigned int` | Sum four unsigned packed-byte products and an unsigned accumulator, wrapping to 32 bits. |
| `__dp2a_lo` | `int, int, int` | `int` | Multiply two signed 16-bit lanes by the low two signed byte lanes and accumulate with 32-bit wrapping. |
| `__dp2a_lo` | `unsigned int, unsigned int, unsigned int` | `unsigned int` | Multiply two unsigned 16-bit lanes by the low two unsigned byte lanes and accumulate with 32-bit wrapping. |
| `__dp2a_hi` | `int, int, int` | `int` | Multiply two signed 16-bit lanes by the high two signed byte lanes and accumulate with 32-bit wrapping. |
| `__dp2a_hi` | `unsigned int, unsigned int, unsigned int` | `unsigned int` | Multiply two unsigned 16-bit lanes by the high two unsigned byte lanes and accumulate with 32-bit wrapping. |
| `__funnelshift_l` | `unsigned int lo, unsigned int hi, unsigned int shift` | `unsigned int` | Shift the concatenation `hi:lo` left and return its high word. |
| `__funnelshift_r` | `unsigned int lo, unsigned int hi, unsigned int shift` | `unsigned int` | Shift the concatenation `hi:lo` right and return its low word. |
| `__funnelshift_lc` | `unsigned int lo, unsigned int hi, unsigned int shift` | `unsigned int` | Shift `hi:lo` left by a count clamped to 32 and return its high word. |
| `__funnelshift_rc` | `unsigned int lo, unsigned int hi, unsigned int shift` | `unsigned int` | Shift `hi:lo` right by a count clamped to 32 and return its low word. |

Negative `int` arguments use their two's-complement representation. For example,
`__clz(-1)` is 0, `__ffs(-2)` is 2, and `__brev(1u)` is `0x80000000u`.
Arguments convert to the declared parameter type before the operation, so
`__popc(3.75f)` is 2. The signed result of `__popc` is preserved: `__popc(3u) - 3`
is -1. These signatures and results follow NVIDIA's
[integer intrinsics](https://docs.nvidia.com/cuda/archive/13.0.0/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__INT.html).

Packed addition and subtraction convert both arguments to `unsigned int`, then
operate independently on matching lanes. Carries and borrows stay within their
lanes: `__vadd2(0x0000ffffu, 1u)` is zero, and `__vsub4(0u, 1u)` is
`0x000000ffu`. These operations follow NVIDIA's
[SIMD intrinsics](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__SIMD.html).
The lowering uses bounded 32-bit arithmetic, masks, and shifts, without requiring
64-bit shader support or a newer Metal language version.

The unsigned saturating variants clamp each lane separately. For example,
`__vaddus2(0x0000ffffu, 1u)` is `0x0000ffffu`, and
`__vsubus4(0u, 1u)` is zero. Arguments convert to `unsigned int` before lane
extraction, so signed source arguments still supply unsigned lane values.
These variants also use only bounded 32-bit operations and support the default
Metal language version.

The signed saturating variants interpret each lane as a two's-complement signed
integer and clamp to `[-32768, 32767]` or `[-128, 127]`. Their public parameter
and result types remain `unsigned int`. For example,
`__vaddss4(0x7f7f7f7fu, 0x01010101u)` is `0x7f7f7f7fu`, and
`__vsubss4(0x80808080u, 0x01010101u)` is `0x80808080u`. The implementation
decodes, clamps, and repacks lanes using bounded 32-bit operations, including
for negative results; it supports the default Metal language version.

Packed absolute values interpret each input lane as signed while retaining
unsigned public parameter and result types. The ordinary variants preserve the
full magnitude of the most negative lane: `__vabs2(0x80008000u)` is
`0x80008000u`, and `__vabs4(0x80808080u)` is `0x80808080u`. The signed
saturating variants clamp those magnitudes to the positive signed limit:
`__vabsss2(0x80008000u)` is `0x7fff7fffu`, and
`__vabsss4(0x80808080u)` is `0x7f7f7f7fu`. Lanes remain independent, using
bounded 32-bit operations compatible with the default Metal language version.

Packed absolute differences return each lane's full unsigned magnitude,
without wrapping the subtraction first or saturating to a signed limit. The
signed variants interpret input lanes as signed; the unsigned variants use
unsigned input lanes. For example,
`__vabsdiffs2(0x80008000u, 0x7fff7fffu)` is `0xffffffffu`, while
`__vabsdiffu2(0x80008000u, 0x7fff7fffu)` is `0x00010001u`. Equal lanes
produce zero. All four functions retain unsigned public parameter and result
types, use bounded 32-bit operations, and support the default Metal language
version.

Packed sums of absolute differences add the full lane magnitudes into one
unsigned scalar result. The `s` variants interpret input lanes as signed; the
`u` variants use unsigned lanes. For example,
`__vsads2(0x80008000u, 0x7fff7fffu)` is `131070u`, while
`__vsadu2(0x80008000u, 0x7fff7fffu)` is `2u`. The maximum sum is `131070u`
for two 16-bit lanes or `1020u` for four 8-bit lanes, with no lane-width
truncation of the result. All four functions have two unsigned parameters
and an unsigned result, using bounded 32-bit operations compatible with the
default Metal language version.

Packed minimum and maximum select each lane independently using signed
ordering for the `s` variants and unsigned ordering for the `u` variants.
They preserve the selected lane's original bits, including negative signed
values, while retaining unsigned public parameter and result types. For example,
`__vmins4(0x80808080u, 0x7f7f7f7fu)` is `0x80808080u`, while
`__vminu4(0x80808080u, 0x7f7f7f7fu)` is `0x7f7f7f7fu`. The corresponding
signed and unsigned maxima select `0x7f7f7f7fu` and `0x80808080u`, respectively.
All eight functions use bounded 32-bit operations compatible with the default
Metal language version.

Packed equality and inequality compare the raw bits of each corresponding
lane independently. The `cmp` forms return `0xffff` or `0xff` in each true
lane and zero in each false lane. The `set` forms place `1` in each true
lane and zero in each false lane. For example,
`__vcmpeq2(0x12345678u, 0x1234abcdu)` is `0xffff0000u`, while
`__vseteq2(0x12345678u, 0x1234abcdu)` is `0x00010000u`.
`__vseteq4(0u, 0u)` is `0x01010101u`. Public parameters and results remain
`unsigned int`; all eight functions use bounded 32-bit operations compatible
with the default Metal language version.

Packed less-than comparisons use signed lane ordering for the `s` variants
and unsigned ordering for the `u` variants. Each true lane contains a full
lane mask for `cmp` or `1` for `set`; false lanes contain zero. Equal lanes
are false because the comparison is strict. For example,
`__vcmplts2(0x80007fffu, 0x7fff8000u)` is `0xffff0000u`, while
`__vcmpltu2(0x80007fffu, 0x7fff8000u)` is `0x0000ffffu`.
The corresponding `set` results are `0x00010000u` and `0x00000001u`.
All eight functions retain unsigned public parameter and result types and use
bounded 32-bit operations compatible with the default Metal language version.

Packed less-than-or-equal comparisons use the same signed or unsigned lane
ordering and mask or per-lane `1` result shapes, with equal lanes evaluating
true. For example, `__vcmples4(0xffffffffu, 0xffffffffu)` is `0xffffffffu`,
and `__vsetles4(0xffffffffu, 0xffffffffu)` is `0x01010101u`. Each lane is
compared independently. All eight functions retain unsigned public parameter
and result types and use bounded 32-bit operations compatible with the default
Metal language version.

Packed greater-than comparisons use signed or unsigned lane ordering and
return full lane masks for `cmp` or per-lane `1` for `set`. Equal lanes
return zero because the comparison is strict. For example,
`__vcmpgts2(0x80007fffu, 0x7fff8000u)` is `0x0000ffffu`, while
`__vcmpgtu2(0x80007fffu, 0x7fff8000u)` is `0xffff0000u`. The corresponding
`set` results are `0x00000001u` and `0x00010000u`. All eight functions
retain unsigned public parameter and result types and use bounded 32-bit
operations compatible with the default Metal language version.

Packed greater-than-or-equal comparisons include equal lanes while retaining
the same signed or unsigned ordering and mask or per-lane `1` result shapes.
For example, `__vcmpges4(0xffffffffu, 0xffffffffu)` is `0xffffffffu`, and
`__vsetges4(0xffffffffu, 0xffffffffu)` is `0x01010101u`. Each lane is
compared independently. All eight functions retain unsigned public parameter
and result types and use bounded 32-bit operations compatible with the default
Metal language version.

Packed negation also interprets each lane as signed while keeping unsigned
public parameter and result types. Wrapping negation leaves the most negative
lane unchanged: `__vneg2(0x80008000u)` is `0x80008000u`, and
`__vneg4(0x80808080u)` is `0x80808080u`. Signed saturating negation maps
those lanes to the positive signed limit: `__vnegss2(0x80008000u)` is
`0x7fff7fffu`, and `__vnegss4(0x80808080u)` is `0x7f7f7f7fu`. Other lanes
negate normally; for example, `__vnegss4(0x01010101u)` is `0xffffffffu`.
Each lane wraps or saturates independently using bounded 32-bit operations,
including zero lanes, and supports the default Metal language version.

Packed averages preserve each lane independently and retain unsigned public
parameter and result types. Signed half-integer averages round away from zero;
unsigned half-integer averages round upward. For example,
`__vavgs4(0xffffffffu, 0u)` is `0xffffffffu`, while
`__vavgu4(0xffffffffu, 0u)` is `0x80808080u`. Exact integer averages remain
unchanged. These operations use bounded 32-bit intermediates and support the
default Metal language version.

Packed unsigned half sums (`__vhaddu2` and `__vhaddu4`) instead round
half-integer averages toward zero, which is downward for unsigned values.
They halve each lane's full sum without wrapping it to the lane width first.
For example, `__vhaddu4(0xffffffffu, 0u)` is `0x7f7f7f7fu`, while
`__vhaddu4(0xffffffffu, 0xffffffffu)` is `0xffffffffu`. Public parameters
and results remain `unsigned int`, with independent lanes and bounded 32-bit
intermediates compatible with the default Metal language version.

Nth-set-bit searches convert the mask and base to `unsigned int` and the offset
to `int`. `__fns` searches upward for positive offsets and downward for negative
offsets, counting set bits starting at the base position inclusively. Offset
zero returns the base only when its bit is set. An unsuccessful search returns
`0xffffffffu`. For example, `__fns(0xaaaaaaaau, 2u, 1)` is 3, while offset -1
returns 1 and offset zero finds no bit. CUDA requires the converted base to be
between 0 and 31; other bases have undefined CUDA behavior. A single cached
32-bit helper examines at most 32 positions and handles the full signed offset
range without negating `INT_MIN`.

Byte-order reversal converts its argument to `unsigned int` before reversing
its four bytes. For example, `__nv_bswap32(0x12345678u)` is `0x78563412u`.
Its result remains unsigned, including for signed source arguments. Canonical
`__host__ __device__` prototypes are accepted. The lowering uses only 32-bit
masks and fixed shifts and works with the default Metal language version.

The 24-bit multiply functions ignore the upper eight bits of each converted argument.
`__mul24` interprets bit 23 as the sign bit; `__umul24` treats the low 24 bits as
unsigned. Results retain all 32 low product bits, including when the mathematical
product exceeds 32 bits. For example, `__mul24(0x00800000, 1)` is -8388608, while
`__umul24(0x00ffffffu, 0x00ffffffu)` is `0xfe000001u`. This follows NVIDIA's
[24-bit multiply intrinsics](https://docs.nvidia.com/cuda/cuda-math-api/cuda_math_api/group__CUDA__MATH__INTRINSIC__INT.html).
Calls do not provide source constant expressions, including calls with literal
arguments.

High-half multiplication converts both arguments to the declared 32-bit parameter
type before multiplication. For example, `__mulhi(-1, 1)` is -1, while
`__umulhi(0xffffffffu, 0xffffffffu)` is `0xfffffffeu`. Both use 16-bit limbs
and 32-bit operations, so they do not require 64-bit shader support. Signed
high limbs use arithmetic shifts, and intermediate products and sums stay in
range even when a backend evaluates literal arguments during translation.

Half-add functions convert arguments to their declared 32-bit type before
computing the mathematical average. The unrounded forms round toward negative
infinity, and the rounded forms round toward positive infinity. For example,
`__hadd(-1, 0)` is -1 while `__rhadd(-1, 0)` is 0; `__uhadd(0u, 0xffffffffu)`
is `0x7fffffffu` while `__urhadd(0u, 0xffffffffu)` is `0x80000000u`. Equal
extreme values remain unchanged. Bitwise identities avoid an overflowing sum
and use only 32-bit operations, including when backends evaluate literal calls.

Sum-of-absolute-difference functions convert their first two arguments to the
listed operand type and the accumulator to `unsigned int`. Both return an
unsigned result. The absolute difference uses the full mathematical range:
`__sad(-2147483647 - 1, 2147483647, 0u)` is `0xffffffffu`. Adding an accumulator
wraps modulo 2^32, so the same call with `1u` returns zero, and
`__usad(0u, 0xffffffffu, 0xffffffffu)` is `0xfffffffeu`. Signed operands use
order-preserving unsigned keys; accumulation uses 16-bit limbs. This requires
only 32-bit operations and avoids overflowing intermediate constants.

Byte permutation converts all arguments to `unsigned int`. Each of the four
low selector nibbles uses its low three bits to choose a byte: indices 0–3
select from the first word, and 4–7 select from the second. Bytes and selector
fields are numbered from least significant to most significant. Nibble bit 3
and selector bits 16–31 are ignored; bytes are copied without sign extension.
For example, `__byte_perm(0x33221100u, 0x77665544u, 0x7531u)` is
`0x77553311u`. The lowering uses 32-bit operations with bounded shift counts.

Packed four-way dot products convert all three arguments to the selected
signature's type. The first two words each contain four byte lanes; matching
lanes are multiplied and summed with the accumulator. The signed overload
interprets each byte as a two's-complement signed value. For example,
`__dp4a(0x01020304, 0x01010101, 0)` is 10. Accumulation wraps modulo 2^32,
including signed overflow. Both overloads use Naga's packed-dot operations
and bounded 32-bit accumulation, preserving backend compatibility without
64-bit shader support. Vector-argument overloads remain unsupported.

Two-way packed dot products interpret the first word as two 16-bit lanes.
`__dp2a_lo` pairs them with bytes 0 and 1 of the second word;
`__dp2a_hi` pairs them with bytes 2 and 3. The unused half of the second word
has no effect. Signed overloads sign-extend both lane widths; unsigned
overloads zero-extend them. Arguments convert to the selected signature before
extraction, and accumulation wraps to 32 bits. Both variants use 32-bit
operations without requiring 64-bit shader support. Vector-argument overloads
remain unsupported.

The Metal backend requires MSL 1.2 or later for these two-way lane extractions.

Funnel shifts convert all three arguments to `unsigned int` first. The
`__funnelshift_l` and `__funnelshift_r` variants reduce the count modulo 32;
`__funnelshift_lc` and `__funnelshift_rc` clamp it to 32. At zero, left shifts
return `hi` and right shifts return `lo`. At counts of 32 or more, the clamped
left shift returns `lo` and the clamped right shift returns `hi`. Conversion
precedes clamping, so a count of `0x100000000ULL` converts to zero. All four
variants use only 32-bit operations, masking both emitted shift amounts even
when the clamped result selects a whole word.

These names use the same argument evaluation, overload selection, name hiding,
and predefined-signature restrictions as the bit reinterpretation functions
above. `__popcll` converts its argument to `unsigned long long` before counting,
so `__popcll(-1)` is 64 while `__popcll(0xffffffffu)` is 32. Its signed `int`
result ranges from zero through 64. The implementation counts two 32-bit words,
so it does not require native 64-bit population-count operations from a backend.
`__clzll` converts its argument to `long long` before examining its representation.
For example, `__clzll(-1)` is 0 and `__clzll(0xffffffffu)` is 32. It counts the
leading zeros of the high 32-bit word, or adds 32 to the low word's count when
the high word is zero. Its signed `int` result ranges from zero through 64.
`__ffsll` also converts its argument to `long long`. It counts trailing zeros
in two 32-bit words and returns the first nonzero word's bit position, starting
at one. For example, `__ffsll(-2)` is 2, `__ffsll(0x100000000LL)` is 33, and
`__ffsll(0LL)` is 0. Its signed `int` result ranges from zero through 64.
`__brevll` also converts its argument to `unsigned long long` first, so
`__brevll(-1)` is `0xffffffffffffffffULL`, while `__brevll(0xffffffffu)` is
`0xffffffff00000000ULL`. Its result retains type `unsigned long long`,
distinct from LP64 `unsigned long`. It reverses two 32-bit words and exchanges
their positions, avoiding native 64-bit bit-reversal operations.
Other integer intrinsics remain unsupported.
Metal output for `__brev` and `__brevll` requires MSL version 1.2 or newer.

## Read-only loads

`__ldg(const T *address)` returns the value at the address for `int`,
`unsigned int`, `float`, `int2`, `uint2`, `float2`, `int4`, `uint4`,
and `float4` pointees. It accepts offsets such as `__ldg(input + i)` and
element addresses such as `__ldg(&input[i])`. Vector offsets count whole
vectors. The pointer can pass through device helpers and local aliases.
Each possible origin must be a read-only kernel
buffer, such as a `const unsigned int *` kernel parameter. A `const` alias of
a writable buffer is rejected.

Naga emits an ordinary unsynchronized storage load using the target backend's
cache policy. The source requires a valid address and data that stay read-only
during the kernel.

## Integer atomics

These functions accept `int *address, int value` or
`unsigned int *address, unsigned int value`, update writable global buffer or
`__shared__` storage, and return its previous value:

| Function | Update |
| --- | --- |
| `atomicAdd` | Add `value`. |
| `atomicSub` | Subtract `value`. |
| `atomicMin` | Store the smaller value, using the pointee's signedness. |
| `atomicMax` | Store the larger value, using the pointee's signedness. |
| `atomicAnd` | Bitwise AND with `value`. |
| `atomicOr` | Bitwise OR with `value`. |
| `atomicXor` | Bitwise XOR with `value`. |
| `atomicExch` | Store `value`. |

Arguments are evaluated once, and `value` uses the usual scalar argument conversions.

`atomicCAS(int *address, int compare, int value)` and its `unsigned int`
overload return the previous value at `address`, replacing it with `value` only
when it equals `compare`. Both scalar operands use the usual argument conversions.
The operation is strong: a target's weak compare-exchange failure retries when
the observed value still equals `compare`. The address, comparison, and replacement
are each evaluated once before any retries.

`atomicInc(unsigned int *address, unsigned int limit)` stores zero when the old
value is at least `limit`, otherwise the old value plus one.
`atomicDec(unsigned int *address, unsigned int limit)` stores `limit` when the old
value is zero or greater than `limit`, otherwise the old value minus one.
Both return the old value and use the usual scalar conversions for `limit`.
The address and limit are evaluated once. Retries handle spurious weak failures
and recompute the update when another thread changes the observed value.

The address can pass through local aliases and device helpers, including struct
fields and individual integer vector components. Ordinary accesses and aggregate
copies retain their source value types and byte layouts.

These unsuffixed operations have relaxed device-scope semantics. They do not
provide a memory fence or replace synchronization between threads; shared storage
remains local to its thread block. Floating-point, 16-bit, 64-bit, and 128-bit overloads
and block- and system-scope variants remain unsupported.

## Constant expressions

Scalar `constexpr` variables support `bool`, `short`, `unsigned short`, `int`,
`unsigned int`, `float`,
and their aliases with copy, braced, or single-expression parenthesized
initialization. They are read-only and
can appear in blocks, `for` initializers, and at file scope before, between,
or after functions. Apart from `__constant__` storage described above, file-scope
variables require `constexpr`; they become Naga constants without consuming
buffer bindings.

For example, `constexpr int Width = 4 + 4;` can provide the extent in both
`int local[Width]{};` and `__shared__ float3 shared[Width];`.
Ordinary `const` integral locals also supply constant values when initialized
by constant expressions. An ordinary `const float` local does not; use
`constexpr float` when its value is needed during compilation.

Constant evaluation supports the existing scalar operators and casts with
C++20 [constant-expression rules](https://timsong-cpp.github.io/cppwp/n4861/expr.const).
Unsigned arithmetic and left shifts wrap; signed
arithmetic overflow, invalid shift counts, integer division by zero, and out-of-range
float-to-integer conversions cannot provide required constant values.
Floating-point constant evaluation includes infinities, NaNs, overflow, and
finite results recovered through nonfinite intermediates. For example,
`constexpr float Infinity = 1.0f / 0.0f;` can supply both a device value and
`constexpr bool Positive = Infinity > 0.0f;`.
Nonfinite globals use integer bit constants, and device reads reconstruct the
source `float` value. Known constant comparisons and arithmetic fold before
backend emission. Binary operations producing NaN use the canonical quiet NaN
`0x7fc00000`; unary negation flips its sign bit. Floating-point values must have
finite, representable truncated results when converted to integer constants.

Only evaluated operands contribute to constant-expression eligibility, so
`true ? 3 : runtime_value` and `false && helper()` can be constant expressions.
Every operand is still parsed and type-checked. Discarding a nonvolatile local
variable, as in `(runtime_value, 3)`, does not load its value. Address
computations must still be valid; discarded array elements require an index
within the array, following the
[indirection clarification](https://cplusplus.github.io/CWG/issues/2823.html).
Reading parameters or buffers, modifying variables, and
calling the supported functions cannot supply constant values. Compute
builtins, including `blockDim`, are not C++ constant expressions.

`constexpr` arrays, vectors, structs, functions, and reference declarations remain unsupported.

A declared reference has separate constant-expression restrictions. References
to automatic objects or temporaries cannot supply constant values or be discarded
in a required constant expression. A reference bound to a fixed shared-memory
location can be discarded, as in `(alias, 3)`, when its address selection uses only
constant, in-bounds indices. Reading the shared value remains a runtime operation.
Runtime address choices, indices, and initializer side effects prevent this
discardability. The existing lazy rules still apply to unevaluated operands.
File-scope `constexpr` scalars can supply device values but cannot be bound
directly to references, following CUDA's
[host-object address restrictions](https://docs.nvidia.com/cuda/cuda-programming-guide/05-appendices/cpp-language-support.html#constexpr-variables).
An arithmetic expression or conversion to a different scalar type can instead
initialize a const reference's temporary, as in `const int &value = Width + 0;`
or `const float &converted = Width;`.

## Source subset

Aliases support `typedef` and `using` for `bool`, `short`, `unsigned short`,
`int`, `unsigned int`, `float`, and the vector and struct types below,
including alias chains and `const` qualification. For example,
`typedef unsigned int Count, Index;` and `using Sample = const float;` preserve
the underlying type and its layout. Repeating an alias declaration
with the same type and qualification is allowed. Explicit duplicate `const`
qualifiers are rejected; requalifying an already const alias is allowed.

Aliases can appear at file scope before, between, or after functions, and in
blocks and `for` initializers. Local values can hide outer type names, and local
aliases can hide outer values or functions. A `using` alias in a `for` initializer
uses C++23 syntax. Function and void aliases remain unsupported.

Array aliases support both declaration forms and compose through
earlier aliases.

```cuda
typedef int Row[3], Scalar;
using Matrix = Row[2];
using FrozenRow = const Row;
```

Each `typedef` declarator starts from its declared base type. Array aliases retain
their element types, extents, layout and qualification. They work in local
declarations, record members, and the supported shared and constant storage
forms. Additional written dimensions surround the aliased array, so
`Row values[2];` has two rows of three integers. Existing initialization and
constructor defaults apply to the complete array. All aliased extents must be
positive integral constant expressions when specified. The 64-dimension limit
includes inherited and written dimensions.

An alias can leave its outermost bound unknown, as in `using Values = int[];`
or `using Rows = Row[];`. Each local object infers its own bound from a nonempty
brace, copy-list or parenthesized initializer. For example, `Values first{1};`
and `Values second(2, 3);` have lengths one and two. The alias retains its unknown
bound after both declarations. Inner dimensions require complete element types.
Record members, static shared storage and constant memory require known bounds.
Dynamic shared declarations accept an incomplete alias directly, as in
`extern __shared__ Values values;`.

Array parameters adjust their outermost dimension to a pointer. A `Row` parameter
becomes `int *`, and a `Matrix` parameter becomes `Row *`. A written outer bound,
as in `Row values[2]`, also produces `Row *`. These forms work in kernel and device
helper parameters, including prototypes. Const array qualification follows the
elements, preserving read-only storage bindings. Pointers to aliased rows retain
their row stride through indexing, arithmetic and helper calls.
Incomplete aliases use the same adjustment, so a `Values` parameter becomes
`int *` and a `Rows` parameter becomes `Row *`.

Pointers to incomplete arrays retain their unknown outer bound while borrowing
completed arrays. Each pointer can select arrays with different outer lengths,
provided their element types and inner dimensions match.

```cuda
using Values = int[];
int first[3]{2, 3, 5};
int second[5]{7, 11, 13, 17, 19};
Values *view = &first;
(*view)[1] += 7;
view = &second;
int *elements = *view;
++elements;
```

Local pointers support initialization, captures, assignment, conditional
selection and null values under the existing pointer rules. Pointee qualifiers
follow the array elements. Helper parameters accept these pointers, including
prototypes and nondependent parameters in templates. Kernel pointers to
incomplete arrays expose the array elements through the existing storage buffer
interface. Fixed inner dimensions retain their native row stride.

Whole-array pointer arithmetic requires a known outer bound. Dereferencing an
incomplete-array pointer permits element indexing and decay to an element
pointer, which supports the existing arithmetic operations.

Typed array temporaries, whole-array references and explicit array template
type arguments require further frontend support.

Pointer aliases use the existing scalar, vector, and completed struct pointee
types, including packed three-component vectors. Both alias forms accept a
pointer declarator, and each `typedef` declarator starts from the base type:

```cuda
typedef int *Pointer, Integer, *const FixedPointer;
using ReadPointer = const int *;
using FrozenPointer = Pointer const;
```

`Integer` denotes `int`. `FixedPointer`, `FrozenPointer`, and `const Pointer`
denote a constant pointer to writable integers; `ReadPointer` denotes a mutable
pointer to constant integers. Alias chains retain both levels of qualification.
These rules follow C++20 [type aliases](https://timsong-cpp.github.io/cppwp/n4861/dcl.typedef)
and [pointer declarators](https://timsong-cpp.github.io/cppwp/n4861/dcl.ptr).

Pointer aliases work in kernel and helper parameters and in local declarations,
with the same captures, assignments, updates, and borrowing rules as explicit
pointers. Kernel bindings retain their pointee layout and access mode. Helper
prototypes and overloads use the underlying pointer type; top-level pointer
`const` affects the parameter's private copy and does not change its signature.
Mutable pointer aliases may omit an initializer; constant pointers require one.
`auto` copies retain pointee constness and discard the source pointer object's
constness.

Aliases preserve the current restrictions on nested pointers, pointer references,
pointer arrays and members, shared pointer objects, pointer `constexpr`
declarations, pointer function results, and casts that change the addressed type
or remove pointee qualifiers. Aliases cannot supply boolean kernel buffer
parameters.

Vector values support `float1`, `float2`, `float3`, `float4`, `int1`, `int2`,
`int3`, `int4`, `uint1`, `uint2`, `uint3`, `uint4`, `short1`, `short2`, `short3`,
`short4`, `ushort1`, `ushort2`, `ushort3`, and `ushort4`. These types can appear in local variables,
fixed local arrays, kernel buffer elements, and helper parameters and results.
Copies, assignments, and conditional arms require matching vector types. Const
qualification prevents writes to individual fields as well as the complete value.

One-component vectors have one `.x` field and retain their own type identity.
`make_float1(value)` and its integer counterparts construct these aggregates.
Brace initialization such as `int1{3}` uses the existing narrowing rules.
Parenthesized forms such as `int1(3)` and `static_cast<int1>(3)` initialize
the same scalar field through ordinary numeric conversions.

The fields `.x`, `.y`, `.z`, and `.w` select one scalar component, up to the
vector's width. Field access works on locals, array elements, helper results,
and conditional references. Individual fields use the existing scalar operators;
modifiable fields also support assignments and updates.
`make_float3(x, y, z)` and the corresponding `make_` functions take exactly
one scalar argument per component, with the existing scalar conversions and
left-to-right argument evaluation. Additional user-defined overloads participate
in the same overload resolution as other helpers.

These types follow CUDA's [built-in vector definitions](https://docs.nvidia.com/cuda/archive/13.0.0/cuda-c-programming-guide/index.html#built-in-vector-types).
Three-component 16-bit arrays have a six-byte element stride and two-byte
alignment. Three-component 32-bit arrays have a 12-byte element stride and
four-byte alignment. Vector comparisons, truthiness, indexing, and swizzles remain
unsupported. Vector arithmetic requires a visible source-defined operator.
Same-type vector copies support `float2(source)`, `static_cast<float2>(source)`,
and `(float2)source`. Empty `float2()` construction zeroes every component.
Parenthesized component lists such as `float3(1.0f, 2.0f)` initialize components
in order and zero omitted components. Named locals accept the same lists, as in
`float3 point(1.0f, 2.0f);`. Explicit casts from one scalar initialize `.x` and
zero the other components. These forms permit ordinary numeric conversions,
including narrowing conversions. Braced initialization retains its narrowing
checks. Casts between unrelated vector types remain unsupported, apart from
the `dim3` conversions below. Named vector copies also
accept one parenthesized expression, such as `float2 copied(source);`. By-value kernel
parameters require the scalar types described in the kernel interface.
Typed vector temporaries such as `float2{1.0f, 2.0f}` use the same list
initialization and narrowing rules as vector declarations.

`dim3` is distinct from `uint3`, with unsigned `.x`, `.y`, and `.z` fields,
12-byte size and array stride, and 4-byte alignment. It supports aliases, `auto`,
mutable fields, value copies, local arrays, record members, helper value results,
and helper value, reference, and pointer parameters. Kernels accept `dim3` by
value or through a pointer. Each value uses a 16-byte uniform buffer at the
parameter's source binding index. Write `x`, `y`, and `z` as `u32` words at byte
offsets 0, 4, and 8. The fourth word is padding. Each invocation receives its own
copy, including any zero components supplied by the host.

Default construction produces `(1, 1, 1)`, including `dim3 shape;`,
`dim3{}`, and `dim3()`. Constructors accept zero to three scalar arguments;
omitted components are one. For example, `dim3 shape = 2u;` produces `(2, 1, 1)`.
Parenthesized arguments use the existing scalar conversions; explicit
`dim3{...}` arguments enforce list-initialization narrowing checks.
Local declarations follow the usual function-declaration rules:
`dim3 copied(dim3(source));` declares an unsupported function;
`dim3 copied((dim3(source)));` initializes a value.
Array and record scalar initializer clauses use copy initialization for a
`dim3` subobject; explicit inner braces retain narrowing checks.

Conversions between `dim3` and `uint3` are implicit. `dim3{packed}` and
`uint3(shape)` are accepted; `uint3{shape}` and `uint3 packed = {shape};`
are rejected. Overloads retain both types' identities and prefer standard
conversions over a user conversion. Pointer types remain distinct.

Default construction recurses through bare local arrays, omitted array elements,
and nested records. Numeric subobjects retain their existing initialization rules.
Shared storage containing `dim3` is rejected because its constructor is nonempty.
Aggregate `constexpr` declarations and constant member evaluation remain
unsupported. Pure constant construction can be discarded in a scalar constant
comma expression, such as `(dim3(3), 4)`.
Whole built-in values such as `blockDim` remain unsupported.

Nonmember binary operators `+`, `-`, `*`, `/`, `%`, `&`, `|`, `^`, `<<`, and `>>`
take two parameters, using the helper value, reference, and pointer binding rules above.
Prefix unary operators `+`, `-`, `~`, `!`, `*`, and
`&` take one. At least one parameter must have a supported vector or struct type;
a pointer to such a type alone does not satisfy this requirement.
For example:

```cuda
__device__ float2 operator+(float2 left, float2 right) {
    return make_float2(left.x + right.x, left.y + right.y);
}
```

Both `first + second` and `operator+(first, second)` select from declarations
visible before the call, using the existing helper overload and conversion
rules, including prototypes with later definitions. Scalar-only expressions
retain the existing built-in operators. Operators can return a supported scalar,
vector, or struct value, or `void`; void results can only
appear where an ordinary void helper call is accepted. Calls remain runtime
expressions and obey the existing helper recursion restrictions.

The unary and binary operators above evaluate their operands once, from left to
right. Explicit function calls use the frontend's chosen left-to-right argument
order. Shift expressions evaluate the left operand before evaluating the right. A
by-value parameter captures the left value, while a reference parameter captures
its address and observes subsequent changes to the object.
Source expressions must still obey the C++ rules for unsequenced side effects.
C++ specifies sequencing separately for
[operator notation](https://timsong-cpp.github.io/cppwp/n4861/over.match.oper#2)
and [explicit function calls](https://timsong-cpp.github.io/cppwp/n4861/expr.call#8).

Source-defined binary `operator&&` and `operator||` also take two parameters,
with at least one supported vector or struct parameter. Both operands are
evaluated once, from left to right, before the helper call; the left value is
copied before right-hand side effects when the selected parameter is by value;
reference parameters retain live aliases. These calls preserve the original operand
types for overload selection and can return any supported helper result, including
`void`. Scalar-only `&&` and `||` retain Boolean results and short-circuiting,
including when unrelated class overloads are visible. This follows the C++ rules
for [operator calls](https://eel.is/c++draft/over.match.oper),
[logical AND](https://eel.is/c++draft/expr.log.and), and
[logical OR](https://eel.is/c++draft/expr.log.or).
Overloaded unary `*` and `&` accept class values, including temporaries, and call
the declared helper. Unary `&` uses the builtin address operation when no source
overload is viable; an ambiguous overload remains an error. An explicit
`operator&(...)` call requires a viable source overload.

Nonmember compound assignment operators `+=`, `-=`, `*=`, `/=`, `%=`, `&=`, `|=`,
`^=`, `<<=`, and `>>=` take two parameters and use the same helper overload rules.
Operator notation evaluates the right operand before the left operand. Value
parameters capture copies at their evaluation point. Reference parameters capture
an address and observe the live object through that address. The selected helper's
parameter modes and body determine mutations, and its declared return type supplies
the expression's result, including `void`. Temporary and const class values
participate when the selected parameters accept them. These rules follow C++
[assignment sequencing](https://timsong-cpp.github.io/cppwp/n4861/expr.ass#1).

The frontend rejects overloaded comparisons, plain assignment `=`, increment and
decrement operators, member operators, reference results, and operator templates.

Standalone named struct definitions are accepted at file and block scope:

```cuda
struct Sample {
    unsigned tag;
    float3 position;
    float weights[2];
};

__device__ Sample shift_sample(Sample value) {
    value.position.x += value.weights[0];
    return value;
}
```

Fields can use `float`, `int`, `unsigned int`, the supported vector types,
previously completed structs, and fixed arrays of these types. Field-array
bounds use the existing integral constant-expression rules. Aliases of a struct
preserve its type; separate definitions remain different types even when their
fields match. Local definitions can hide outer type names.

Struct definitions can also appear in `typedef` declarations at file and block
scope, with or without a tag:

```cuda
typedef struct {
    unsigned low, high;
} Pair, PairAlias;

typedef struct PacketTag {
    Pair pair;
    unsigned samples[2];
} Packet;
```

Aliases from one definition name the same record. A named definition retains
its tag as the canonical type name, so `Packet` and `PacketTag` select the same
template instance. An anonymous definition uses its first direct record alias,
such as `Pair`, for template selectors. Pointer-only aliases do not supply a
canonical record name for template arguments. These forms use the same field
layout, initialization, and member restrictions as standalone definitions.

Locals support same-type copies, assignments, and braced or parenthesized element
initialization. `Sample copied(source);` copies the complete object.
Braced initialization includes partial initialization and brace elision for nested
aggregates.
Omitted fields use zero initialization, with `dim3` subobjects using their
constructor defaults. Typed expressions such as `Sample{}` can
be passed to helpers, returned, grouped in parentheses, discarded as statements,
or read through their fields. Copying a struct
also copies its fixed-array fields. Standalone arrays still cannot be copied
or passed by value. Braced forms follow C++
[aggregate initialization](https://eel.is/c++draft/dcl.init.aggr).

Struct value construction also supports `Sample(source)`,
`static_cast<Sample>(source)`, and `(Sample)source` for a source of the same type.
Parenthesized forms also accept element expressions, such as `Pair(3, 5)`.
The CUDA compiler's recursive member initialization applies to nested records,
vectors, and array members. For `struct Pair { int x; int y; };` and
`struct Box { Pair pair; int tag; };`, `Box value(1, 2, 3);` initializes
`pair.x`, `pair.y`, and `tag` in that order. Explicit inner braces select the
existing braced-initialization rules. A single braced argument initializes the
complete object, as in `Pair({1, 2})`.

Each member is stored before the next initializer expression is evaluated.
`Pair value(3, value.x + 1);` produces `(3, 4)`, and
`Pair value(3, ++value.x);` produces `(4, 4)`.
A constructor expression used to initialize a local writes directly into that
local, including grouped and conditional forms.
Explicit `static_cast` and C-style casts accept one expression, including a
comma expression, and apply the same member conversions and omitted defaults.
Empty `Sample()` construction zeroes numeric subobjects and applies the existing
`dim3` defaults recursively. Class values retain the requested target's `const`
qualification; an unqualified copy of a const source is mutable. Empty class
constructors can be discarded in scalar constant expressions when C++17 permits
their default construction there. Aggregate constant expressions remain unsupported.

Arbitrary field names and indexed fields use the existing value/reference
rules, including `samples[index].weights[element]`. Const objects and
`const Sample*` buffers prevent writes to every nested field. Conditional
struct lvalues support field access. Subscripting an array directly selected by
a conditional expression remains unsupported; first binding the selected struct
to a local reference supports indexing its array members.

The initial record subset rejects empty definitions, `bool` fields, const data
members, pointer/reference members, default member initializers, methods,
inheritance, nested type definitions, unions, and explicit alignment or packing.
Forward declarations and elaborated type spellings such as `struct Sample value`
remain unsupported; use the completed bare type name `Sample`. Struct kernel
parameters require pointers. Aggregate constant expressions and untyped braced
call arguments or returns remain unsupported.

Empty local vector initialization, such as `float3 value{};` or
`const float4 value = {};`, zeroes every field each time execution reaches the
declaration, including inside loops.

Mutable scalar and vector locals can omit an initializer and be assigned before
reading.
Const `dim3` locals, and const arrays or records containing only such subobjects,
support default construction. Other const locals require an initializer.
Local declarations can list comma-separated names, as in
`int first = 1, next = first + 1;`. Each initializer finishes before the next
declarator, and all names share the declared type and qualification.

Scalar declarations accept one parenthesized expression, including through
aliases: `int count(4);`, `float scale(count);`, and `const unsigned size(3);`.
They use ordinary scalar conversions, so `int truncated(3.75f);` is valid while
the corresponding braced initializer rejects narrowing. A comma expression
requires inner parentheses, as in `int next((counter += 1, counter));`.
Empty parentheses and ambiguous type-headed forms follow the C++
[declaration rules](https://timsong-cpp.github.io/cppwp/n4659/dcl.ambig.res):
`int value();` and `int value(int(seed));` declare unsupported functions;
`int value((int(seed)));` initializes an object.

`auto` declarations infer the supported value or borrowed pointer type from an
initializer. Values copy scalars, vectors, or structs without retaining a source
reference or top-level `const`. Arrays decay to pointers, including pointers to
rows of multidimensional arrays. The existing pointer bounds, aliases, and
pointee constness remain effective.

`auto&` binds a live reference to a scalar, vector, or struct lvalue and preserves
its constness. `const auto&` also accepts temporary values. For pointer values,
`const auto pointer = source;` makes the pointer object constant, while
`const auto *pointer = source;` makes its pointee constant. `auto *const pointer`
also makes the pointer object constant.

Every declarator needs an initializer, evaluated once. Supported forms are
`auto value = expression;`, `auto value{expression};`, and
`auto value(expression);`. A direct braced initializer may have a trailing comma.
Comma declarators must deduce the same placeholder type, even when their final
types differ:

```cuda
auto value = 3, *pointer = &value, &alias = value;
```

Here the placeholder is `int`; the declarations produce an integer, a pointer,
and a reference. These rules follow C++20
[placeholder deduction](https://timsong-cpp.github.io/cppwp/n4861/dcl.type.auto.deduct)
and [declaration consistency](https://timsong-cpp.github.io/cppwp/n4861/dcl.spec.auto#7).
A name with an undeduced type cannot appear in its own initializer, including
unselected branches or expressions that would otherwise name an outer variable.

`const auto` follows the existing integral constant-expression rules.
`constexpr auto` accepts supported scalar constant expressions locally or at file
scope. Pointer and aggregate `constexpr` declarations remain unsupported.
Copy-list deduction such as `auto value = {1};`, empty or multiple-element direct
lists, `decltype(auto)`, rvalue references, pointer or whole-array references,
and `auto` array declarators, parameters, and function results remain unsupported.

Local `T&` and `const T&` declarations support the scalar, vector, and struct
types above in kernels and device helpers. A mutable reference requires a writable
lvalue of the same type. A const reference keeps a live view of a compatible
lvalue; it can also retain a temporary value, using existing scalar conversion
and aggregate initialization rules. Assignment through a reference changes the
bound object. The address is selected once when the declaration executes,
including conditional branches and array-index side effects:

```cuda
int values[2]{3, 5};
int index = 0;
int &element = values[index++];
const int &view = element;
element += 2;
```

Both `element` and `view` subsequently observe `values[0]`, whose value is `5`.
References require initializers and use the existing block and loop scopes.
Equals, single-expression parentheses, direct-list, and copy-list initializers
are accepted, including `int &alias(value);`. A singleton list
with a matching lvalue binds that object, while const temporary lists apply the
existing narrowing checks. Each comma declarator needs its own `&`, as in
`int &alias = value, copy = alias;`. Reference results, type aliases,
array references, and reference members remain unsupported. Binding an unresolved
reference to itself is also unsupported. Parenthesized reference temporaries
use implicit conversion: `const bool &value(nullptr);` is invalid, while
`const bool &value(bool(nullptr));` is accepted. Empty parentheses and ambiguous
type-headed forms still declare unsupported functions. Reference lowering has a per-function
work limit of 65,536 units to bound generated address dispatch and projections.

Fixed local arrays support the scalar, vector, and struct types above
and their aliases, in both kernels and device helpers. Written extents
must be positive integral constant expressions. Each invocation owns its array storage;
elements use the same indexing, assignments, and updates as buffer elements.
Arrays and other locals can share a declaration, as in `int values[3], next = 1;`.

An empty initializer, `int values[3]{};` or `int values[3] = {};`, zeroes every
element each time execution reaches the declaration, including inside loops.
Const arrays require an initializer and their elements cannot be modified.
Bare mutable arrays must be assigned before reading. These rules follow C++
[array declarations](https://eel.is/c++draft/dcl.array) and
[aggregate initialization](https://eel.is/c++draft/dcl.init.aggr).

Parenthesized lists also initialize local arrays, as in
`int values[4](1, 2);`. Each element is initialized before the next expression
runs. Omitted elements use value initialization, including constructor defaults
for `dim3` subobjects. Scalar clauses use ordinary conversions, so
`int values[2](1.75f, 2.75f);` produces `1, 2`. Explicit inner braces use the
existing list-initialization checks. These forms follow C++20
[direct initialization](https://eel.is/c++draft/dcl.init#general-15.5).

CUDA's recursive member initialization applies to vector, record, and nested
array elements. `int2 values[](1, 2, 3);` infers two complete elements,
`(1, 2)` and `(3, 0)`. Complete class values also initialize elements, as in
`Pair values[](source, Pair(3, 4));`. Fresh constructor expressions initialize
their array element directly. Copies capture the source value before later
initializers run.

Direct parenthesized lists require expressions and separators between clauses.
`int values[2](int(seed));` follows function-declarator parsing and receives a
diagnostic. Extra grouping makes the initializer an expression, as in
`int values[2]((int(seed)));`. Equals initialization uses the braced forms.

The outermost local array bound may be omitted when a nonempty initializer list
determines the element count, following C++ [array declarations](https://timsong-cpp.github.io/cppwp/n4861/dcl.array#7).
For example, `int values[]{1, 2, 3};` declares three elements.
Vector arrays count complete vector elements after brace elision and copies:
`int3 values[]{1, 2, 3, 4};` declares two elements, `(1, 2, 3)` and `(4, 0, 0)`.
Empty lists cannot determine a bound; `int values[]{};` is rejected, while
`int values[]{{}};` declares one zero element.

The array's bound remains unknown inside its initializer for constant-expression
checks. A discarded self-reference at index zero can qualify, as in
`float values[]{1.0f, (values[0], 2)};`. Nonzero self-indices cannot provide a
constant value there, even when the eventual bound contains them, following the
[unknown-bound clarification](https://cplusplus.github.io/CWG/issues/3004.html).
Ordinary expressions can still read earlier initialized elements at nonzero
indices. After the declaration, constant-address checks use the completed bound.
Multidimensional arrays use nested array types and row-major layout. Every inner
bound must be explicit. Initializers accept nested lists and brace elision;
`int matrix[][2]{{1}, 2, 3, 4};` has three rows: `(1, 0)`, `(2, 3)`, and `(4, 0)`.
Each row's omitted elements become zero before the next row's initializer runs.
Index every dimension to access a scalar or vector element, as in
`matrix[1][0]`. Borrowing a row preserves its own extent; whole-array and row
copies remain unsupported. Ordinary parameters such as `int values[][3]`
adjust to pointers to rows. Array aliases also provide row types for adjusted
parameters such as `Row values[]` and `Matrix values`.
Constant-address checks require each index to fit its own dimension.

Local scalars, vectors, and fixed arrays accept direct-list and copy-list
initialization, including partial lists and a trailing comma:

```cuda
int count{3};
float3 point = {1.0f, 2.0f};
int values[3]{1, values[0] + 1};
int2 pairs[2]{1, 2, 3};
```

Omitted elements become zero when their turn to initialize is reached.
Each element finishes initialization before the next clause is evaluated, so
the example initializes `values` to `1, 2, 0` and `pairs` to `(1, 2), (3, 0)`.
Arrays of vectors accept nested lists, brace elision, and whole-value copies
from matching vector types. A vector list containing one matching vector
expression copies it, as in `int3 copied{original};`.

List initialization follows C++20
[narrowing rules](https://timsong-cpp.github.io/cppwp/n4861/dcl.init.list#7).
Float-to-integer conversions are rejected, including conversions to `bool`.
Integer conversions that cannot represent every source value require a constant
expression whose value fits the destination. Integer-to-float conversions require
a constant expression whose value is represented exactly, including when the
source type is `bool`. Explicit casts can perform an ordinary conversion first.
For example, `float value{runtime_integer};` is rejected, while
`float value{float(runtime_integer)};` is accepted.

Scalar lists contain at most one expression; extra scalar brace nesting is
rejected, following the
[nested-brace clarification](https://cplusplus.github.io/CWG/issues/cwg_closed.html#1501).
Thus `int values[2]{{1}, {}};` is valid and `int value{{1}};` is not.
Typed scalar, vector, and struct temporaries also use these initialization rules.
Scalar expressions accept empty braces, one element, and a trailing comma:
`float{}`, `unsigned{3}`, and `bool{1,}`. Aliases and template `Value{value}`
expressions use the same rules. `bool{nullptr}` is direct list initialization
and produces `false`. Typed expressions can nest, as in `int{int{3}}`.
Bare initializer lists in assignments, returns, and helper arguments remain
unsupported, as do designated initializers and shared-storage initializers.

Supported expressions include indexed buffer reads, scalar locals,
parentheses, arithmetic and comparisons with scalar conversions, and the logical operators
`!`, `&&`, and `||`. Built-in scalar `&&` and `||` preserve short-circuit evaluation.
Numeric conditions are false when equal to zero; boolean locals and `true`/`false`
literals are supported.

Conditional expressions `condition ? accept : reject` evaluate the condition
once and only evaluate the selected arm. They associate right to left. Matching
scalar or vector lvalue arms preserve their reference when one arm's qualifiers
include the other's, and support assignment when mutable.
Scalar references and vector fields also support compound assignments and
prefix/postfix updates; a const arm prevents modification.
Discarding a nonvolatile reference preserves its side effects without reading
the selected storage value. Other scalar arms use a common arithmetic type, with matching
boolean arms retaining `bool`. Matching vector arms retain their exact type;
other vector combinations are unsupported. Both arms may be void in discarded
expressions or void returns; mixing void and value arms is unsupported.

Statements include local declarations, expression statements, scoped blocks,
`if`/`else`, `switch`, `for`, `while`, `do`/`while`, `break`, `continue`, and `return`.

C++17 `if (init; condition)` accepts an empty initializer, an expression
including a void call, or a supported local simple declaration, including
`auto`, references, `typedef`, and record definitions. The initializer executes
once before the condition, even when the condition is false. Its names are
visible in the condition and both branches, then leave scope after the entire
`if`/`else`. They cannot be redeclared in an outermost branch block; a nested
block or a new `else if` initializer may shadow them. These rules follow C++17
[if statements](https://timsong-cpp.github.io/cppwp/n4659/stmt.if) and
[block scope](https://timsong-cpp.github.io/cppwp/n4659/basic.scope.block).
An `if` condition can declare one scalar variable with an equals or brace
initializer, as in `if (int value = input[index])`. The
initializer runs once, and the stored value determines the branch. The name is
visible in both branches and leaves scope after the selection. An optional
initializer statement shares this scope with the condition declaration. The
supported types include scalar aliases and `decltype` of scalar objects.
Const and `constexpr` follow the ordinary scalar initializer rules.
Value declarations with `auto`, `const auto`, or `constexpr auto` deduce a
scalar type from an equals expression or a direct brace initializer with one
element. Top-level qualifiers of the initializer do not transfer to the new
variable. Copy-list forms such as `auto value = {1}` require initializer-list
deduction and remain unsupported in these conditions.
`if constexpr` and C++23 `using` alias initializers remain unsupported.

At statement start, C++ parses `int(value);` as a declaration. Parenthesized
declarators are unsupported; use `int value = ...;` for a local declaration or
`(int(value));` for a discarded cast expression.
A `while` condition can use a scalar expression or the same scalar declaration
forms as `if`. A condition declaration initializes its variable on every test,
including the test that ends the loop. Its name is visible in the body and leaves
scope after the loop. A `continue` checks the condition again, and a `break`
exits without another check. The outermost body scope cannot redeclare the
condition variable. A nested block can shadow it.

The middle clause of a `for` loop accepts the same scalar declarations as
`while`. The variable is initialized on every condition test and is visible in
the body and the update expression. The update sees changes made by the body,
including changes before a `continue`. A false condition or a `break` skips the
update. The condition variable shares a scope with the initializer clause and
leaves scope after the loop. `for` initializers can declare scalar or array
locals, declare scalar aliases, or evaluate an expression. Empty `for` clauses
are supported. `do`/`while` conditions use scalar expressions. A `while` header
takes one condition.

Switch selectors accept `int`, `unsigned int`, and `bool`; booleans promote to
`int`. The selector is evaluated once. Case labels require integral constant
expressions that fit the promoted selector type without narrowing. Duplicate
converted values and multiple defaults are rejected, following C++
[switch statements](https://timsong-cpp.github.io/cppwp/n4861/stmt.switch).
The default label can appear anywhere. Execution falls through subsequent labels
until a jump or the end of the body; an unmatched selector without a default
executes no body statements. `break` exits the nearest loop or switch, while
`continue` targets the nearest enclosing loop.

A switch can have a compound body or a single statement, including a leading
case/default label chain. An unlabeled body is checked but never executed.
Declarations share the switch body's scope, so bare locals and aliases can be
used by later cases. Entering a label that bypasses an active local initializer,
including a `constexpr`, array, or reference initializer, is rejected. Initializers inside
closed nested scopes do not block later labels, following C++
[declaration statements](https://timsong-cpp.github.io/cppwp/n4861/stmt.dcl#3).
Nested switches and C++17 initialization statements are supported. For example,
`switch (unsigned mode = flags[index]; mode & 3u)` initializes `mode` before
selecting a case. The initializer can be empty, an expression, or a supported
simple declaration. Its declarations are visible in the selector and switch
body, and their scope ends after the switch. Initialization runs once even if
no case matches. A case label cannot bypass an initializer in the body.
A switch can also declare its selector, as in
`switch (const unsigned mode{flags[index]})`. The stored value is promoted by
the ordinary selector rules, and cases can access the declared name. The
condition declaration runs before dispatch, so its initializer does not make
case labels invalid. Declaration conditions for `if` and `switch` accept
explicit or inferred scalar value types. Labels that enter a nested block, branch,
or loop remain unsupported.

Comma expressions evaluate left to right and preserve the final operand's type
and value category, including lvalues and void. Earlier operands are discarded.
Discarded lvalues evaluate their addresses without loading their referenced
storage. Comma sequences are supported in
expression statements, `for` updates, conditions, returns, and the middle arm of
`?:`. Commas separating declarators or helper arguments retain their list meaning.
Use parentheses for a comma expression within one initializer, helper argument,
scalar functional cast, or buffer index, as in `int((a, b))` or `out[(a, b)]`.
`static_cast<int>(a, b)` accepts a full expression. `__syncthreads()` remains a
standalone statement.
`continue` executes a `for` loop's update before testing the condition again,
and checks a `do`/`while` condition before the next iteration. A `for` initializer
is scoped to the loop. Nested blocks support local shadowing. Statements after a
guaranteed jump are still checked for source errors and then omitted.
Line and block comments are accepted. Expression nesting, conditional reference
nesting, and generated expression depth are bounded. Trigraphs are unsupported.

Source preprocessing supports object-like and fixed-arity function-like
`#define`, `#undef`, and conditional groups using `#if`, `#elif`, `#ifdef`,
`#ifndef`, `#elifdef`, `#elifndef`, `#else`, and `#endif`. Macro names use ASCII
identifiers; `defined` and alternative operator spellings cannot be macro names.
Definitions follow source order, and replacement tokens are expanded when used.
Empty replacements and nested conditional groups are accepted. Redefinitions
must preserve the macro kind, ordered parameter names, replacement token spelling,
and internal replacement whitespace separation. Expansion preserves token
boundaries and reports language errors at the original invocation.

Function-like macros follow C++23
[macro replacement](https://timsong-cpp.github.io/cppwp/n4950/cpp.replace).
Their definitions require an adjacent `(` after the name and accept zero or more
unique parameters. Invocations may have whitespace, comments, or ordinary
newlines before `(`. Arguments are collected before expansion; only parentheses
protect commas within an argument. Parameters substitute expanded tokens
textually, so repeated parameters can duplicate evaluation and unused parameters
discard their arguments. Replacement does not add parentheses. Replacement tails
can form further invocations with following source tokens. A directive between
the name and `(` leaves the name unexpanded; directives inside an open invocation
are unsupported.

Object-like and function-like replacements support `##` token pasting, following
the C++ [token-pasting rules](https://timsong-cpp.github.io/cppwp/n4659/cpp.concat). Parameters
next to `##` substitute their unexpanded argument tokens; other occurrences use
the expanded argument. A wrapper macro can expand arguments before pasting them.
Pasting joins only the adjacent boundary tokens, preserving the rest of a
multi-token argument. Empty arguments act as placemarkers and disappear after
pasting. Each nonempty concatenation must form exactly one preprocessing token,
which is then rescanned for macro replacement. For example, `JOIN(0x1p, 2f)`
with `#define JOIN(left, right) left ## right` produces `0x1p2f`.
Leading or trailing `##` in a replacement and invalid pasted tokens produce
diagnostics. The order of multiple pastes is unspecified. Macro expansion retains
the ordinary recursion and resource limits.

An initial UTF-8 BOM and LF, CRLF, or CR line endings are accepted. Backslash
line continuations are joined before recognizing comments and tokens, including
optional whitespace before the newline. Quoted and raw literals are opaque
during preprocessing. String and character values remain unsupported in kernel
expressions.
Raw literal bodies preserve backslash-newline pairs, following C++23
[translation phases](https://eel.is/c++draft/lex.phases).

Conditions use signed and unsigned 64-bit preprocessing integers, following
C++23 [conditional inclusion](https://timsong-cpp.github.io/cppwp/n4950/cpp.cond).
Integer bases, separators, and `u`, `l`, `ll`, and `z` suffixes are accepted.
These values select source branches; kernel value types retain the limits below.
Conditions accept arithmetic, shifts, comparisons, bitwise and logical
operators, `?:`, and alternative spellings such as `and` and `not`. Left shifts
wrap, and signed right shifts are arithmetic. Comma expressions are accepted
only inside parentheses and the middle `?:` operand.
Signed arithmetic overflow, zero divisors, and invalid shift counts produce
diagnostics when evaluated. Logical operators and `?:` skip unselected value
operations while still checking their syntax and literal types.

`defined(NAME)` and `defined NAME` query a macro name without expanding its
replacement. A `defined` token returned by macro expansion is unsupported.
Unused function-macro arguments are not expanded or interpreted as conditions.
Other remaining names become zero, except `true` and `false`.
Ordinary single ASCII character constants and simple, octal, or hexadecimal
escapes with values in `0..=127` are accepted in conditions. Other character
forms, floating constants, casts, calls, and assignments remain unsupported.
Only the first selected group is processed. Inactive groups skip ordinary
directives and unevaluated conditions while checking conditional structure.

Variadic macros, stringization, includes, predefined macro
providers, universal character names, and digraphs remain unsupported. No host
or device macros are supplied implicitly; source may explicitly define
compiler-specific names such as `__CUDACC__`. Needed provider use, query,
definition, or removal of standard predefined names such as `__LINE__`, `__cplusplus`,
`__has_include`, and `__has_cpp_attribute` produces a diagnostic, including
inside a short-circuited expression. Preparation bounds source size, condition
nesting, expansion depth, stored and emitted tokens, and expansion work.

Loop hints accept `#pragma unroll` with an optional integral constant expression
before a `for`, `while`, or `do` loop, following NVIDIA's
[`unroll` pragma](https://docs.nvidia.com/cuda/archive/13.0.0/cuda-c-programming-guide/index.html#pragma-unroll).
Factors use the existing `bool`, `int`, and `unsigned int` constant-expression
subset, including scalar casts and source `const` or `constexpr` bindings.
Floating-point results, runtime values, and invalid constant expressions remain
errors. Existing constant-expression limits, including rejection of signed
overflow, still apply.

Pragma payloads are not macro-expanded. A factor name resolves its source
binding even when a macro has the same name; a macro alone does not provide a
factor. Lookup precedes the loop initializer's scope. The loop itself and its
body retain normal macro expansion. The frontend preserves ordinary loop
lowering and does not guarantee unrolling. Factors that are zero, negative, or
greater than `2147483647` are accepted as ignored hints.

Misplaced hints are ignored without evaluating their payloads. Trailing tokens
after a complete integral factor are also ignored without resolving names or
evaluating effects, while invalid tokens still produce lexical errors. Each
stacked hint immediately before a loop has its factor checked. Inactive
preprocessing groups continue to skip pragma payloads.

Kernel integer literals support decimal, leading-zero octal, `0x`/`0X`
hexadecimal, and `0b`/`0B` binary notation. Apostrophes may separate digits, as in
`1'000` or `0xffff'ffff`. Unsuffixed decimal literals select `int`, then `long`,
then `unsigned long long` as their value grows. Unsuffixed nondecimal literals
select the first fitting type from `int`, `unsigned int`, `long`, and
`unsigned long`. The `u`/`U` suffix selects `unsigned int`, then `unsigned long`.
The `l`/`L` suffix selects `long`, then `unsigned long long` for decimal or
`unsigned long` for nondecimal values. Combining `u` and `l` selects
`unsigned long`. The `ll`/`LL` suffix selects `long long`, then
`unsigned long long`; either case is accepted for each letter. Adding `u`/`U`
before or after the pair selects `unsigned long long` directly. Values above
the unsigned 64-bit maximum are rejected.
The signed minimum can be written `-9223372036854775807LL - 1LL`.
Decimal floating literals require the `f`/`F` suffix,
such as `2.0f`. Apostrophes may separate decimal digits in the significand and
exponent, as in `1'024.5f` or `1.25e+0'2f`. Hexadecimal floating literals also
require `f`/`F` and a binary exponent introduced by `p`/`P`, as in `0x1.8p+1f`
(3.0). The significand may contain a decimal point and hexadecimal digit
separators; exponent digits are decimal and may also contain separators.
Literals round directly to binary32 using round-to-nearest, ties-to-even,
including subnormal and signed-zero results. Values that round to infinity
are rejected. Unsuffixed and long floating literals remain unsupported.
Arithmetic promotes `bool`, `short`, and `unsigned short` to `int`. Common
arithmetic types prefer `float`, then apply integer ranks in the order
`long long`, `long`, and `int`. Equal-rank signed and unsigned operands use the
unsigned type. A higher-rank signed type is used when it represents every value
of the unsigned operand; otherwise its unsigned counterpart is used. For example,
`long` plus `unsigned int` produces `long`, while `long long` plus
`unsigned long` produces `unsigned long long`.
Scalar assignments and ordinary `= expression` initializers convert to the
destination type; brace initializers use the narrowing rules above. C-style casts,
`static_cast`, and single-token functional casts such as `int(value)` are
supported for these scalar types. Float-to-integer conversions truncate toward
zero within the destination range. Integer conversions to a narrower type retain
the low destination-width bits. Unsigned negation wraps at the operand's width.

Empty scalar constructors `bool()`, `short()`, `int()`, `unsigned()`, and `float()`
produce
`false` or a typed zero, including scalar aliases and template `Value()`
expressions. These values support constant evaluation and array bounds. Scalar
prvalues discard top-level `const` and `volatile` qualification. Constructed
zeros are not integer literals and cannot initialize null pointers. Named
declarations such as `int value();` retain their function interpretation;
`int value((int()));` initializes an object.

Remainder `%`, bitwise `~`, `&`, `|`, and `^`, and shifts `<<` and `>>` accept
integer and boolean operands using the integral promotions above. Shift operands
are promoted independently, and the result has the promoted left operand's type.
For either shift operator, the left operand is evaluated before the right.
Signed right shifts are arithmetic, matching C++20. Source operations with
undefined C++ behavior have no specified result, including integer division or
remainder by zero, signed minimum divided or reduced modulo `-1`, and shift
counts outside the promoted left operand's bit width.

Assignments are expressions and associate right to left. Compound assignments
`+=`, `-=`, `*=`, `/=`, `%=`, `&=`, `|=`, `^=`, `<<=`, and `>>=` evaluate the
indexed destination once; both prefix and postfix `++`/`--` are supported on
mutable numeric scalars, including vector fields. Assignment evaluates its right
operand before its left operand. Built-in scalar logical short-circuiting also
applies to assignments and updates inside the right operand.

Static `__shared__` declarations support `float`, `short`, `unsigned short`,
`int`, `unsigned int`, `long`, `unsigned long`, `long long`, and `unsigned long long`
scalars, the numeric vector and struct types above, and fixed arrays of
those types inside kernels and device helpers. Their aliases are also accepted;
const-qualified shared types remain unsupported. Vector elements use the sizes, alignments, and
array strides listed in the kernel interface, including packed three-component
structures. Whole-value copies and scalar component updates use the same rules
as local vectors. Array extents must
be positive integral constant expressions using the scalar rules above, including
every dimension of a multidimensional array such as `__shared__ float tile[16][17];`.
Shared variables become workgroup storage without resource bindings; names obey
the surrounding block scope, and each workgroup has its own storage. Declarations
cannot contain initializers, following NVIDIA's
[shared memory constraints](https://docs.nvidia.com/cuda/cuda-programming-guide/05-appendices/cpp-language-extensions.html).

A helper's fixed shared declaration names the same workgroup allocation across
repeated calls, including calls expanded for pointer or reference parameters.
Different declarations and template specializations have separate allocations;
nested declarations with the same name remain distinct. Calls do not initialize
or clear this storage. Write values before reading them and synchronize accesses
between invocations. For `__host__ __device__` helpers, these rules apply to the
device implementation; the host implementation remains unchecked.

Dynamic shared arrays use the launch byte count supplied through
`Options::dynamic_shared_memory_size` or CLI option
`--cuda-dynamic-shared-memory-size BYTES`. It defaults to zero and applies to
every entry in the module, in addition to each entry's static shared storage.
For example:

```cuda
extern __shared__ unsigned values[];

__global__ void exchange(unsigned *output) {
    extern __shared__ unsigned aliases[];
    unsigned lane = threadIdx.x;
    values[lane] = lane;
    __syncthreads();
    output[lane] = aliases[(lane + 1u) % 4u];
}
```

Translate this kernel with workgroup size `4,1,1` and dynamic shared memory size
`16`. Compatible declarations at file, kernel, and helper scope name the same
allocation. Repeated declarations of one external name must agree on its type.
Static shared variables have separate storage.

The outer array dimension must be omitted. Its complete element type can be a
supported numeric scalar, vector, POD struct, or fixed inner array, such as
`extern __shared__ int rows[][4];`. One entry can currently use one such element
type across its reachable helpers. Different entries can use different element
types. Using incompatible typed views of the same allocation in one entry
produces an unsupported-feature diagnostic.

The emitted workgroup array rounds the byte count up to complete elements,
including a private dummy element for a referenced zero-byte view. Unused
declarations create no allocation. Zero and nonmultiple byte counts are valid
launch values; private padding does not extend the valid CUDA storage or make
the source array complete. Workgroup storage limits apply to the emitted
allocation, including padding. Dynamic addresses and discarded address
expressions do not expose an array bound derived from the launch option.

Accesses to shared values from different invocations require
synchronization when any invocation writes them.

`__syncthreads();` synchronizes a thread block and makes earlier shared and
global buffer accesses visible to other invocations in that block. It lowers to
a control barrier covering both workgroup and storage memory, following
[CUDA's synchronization semantics](https://docs.nvidia.com/cuda/archive/13.0.0/cuda-c-programming-guide/index.html#synchronization-functions).
This zero-argument statement supports kernels and device helpers, including
`if` branches, switch cases, and `for`, `while`, and `do` loops proven uniform
for the block.
A bounded CUDA-specific proof tracks scalar counters, updates, uniform kernel
parameters, and workgroup builtins. A switch also needs uniform case exits:
a divergent `break` can skip a barrier even when its selector is uniform.
Divergent branches and gathers can reconverge before a barrier when they do not
return or make later control nonuniform. Storage and shared memory reads and
opaque helper results remain unproved controls. Predefined math functions and
`__fns` preserve uniformity when all converted arguments are workgroup-uniform.
This includes rounding, absolute value, square root, remainder, trigonometry,
and floating division. User-defined overloads retain the ordinary helper
restrictions.

Calls to synchronizing helpers require uniform control flow. Uniform scalar
arguments can control helper branches and loops; varying data arguments can
participate in computations that do not control synchronization. This applies
through chains of helpers and forward declarations. For example:

```cuda
__device__ void synchronize(unsigned count) {
    for (unsigned iteration = 0u; iteration < count; ++iteration)
        __syncthreads();
}

__global__ void kernel(unsigned count) { synchronize(count); }
```

By-value helpers remain ordinary functions in the generated code. Block and grid
identifiers preserve their uniformity through value arguments. A helper return
ends that call, so a return after its last barrier does not prevent a later
kernel barrier.

Barriers after a possible earlier return in the same function remain
unsupported. Branches and loops containing barriers are rejected when their
control is unproved or exits diverge. This conservative proof can reject valid
CUDA programs and does not implement complete WGSL uniformity analysis.
Synchronization does not extend across workgroups.

## Cooperative Groups

`cooperative_groups::thread_block` represents the current thread block.
`this_thread_block()` creates its handle. Handles support typed, `const`, and
`auto` locals, aliases, and copies, including one-argument copy construction.
They require an initializer; default construction is unsupported. This follows
CUDA's [group-handle rules](https://docs.nvidia.com/cuda/cuda-programming-guide/04-special-topics/cooperative-groups.html).

Namespace aliases can appear at file or block scope and can name earlier aliases:

```cuda
namespace cg = cooperative_groups;
namespace blocks = cg;
using Block = blocks::thread_block;
```

Qualification also supports a leading `::`. Lookup before `::` ignores ordinary
value bindings and respects intervening type or namespace bindings, following
C++20 [qualified lookup](https://timsong-cpp.github.io/cppwp/n4861/basic.lookup.qual).
Namespace-alias targets use namespace-only lookup. Repeating an alias for the
same namespace is allowed; general namespace definitions and `using namespace`
directives remain unsupported.

`cg::sync(group)`, `group.sync()`, and `Block::sync()` synchronize the whole
block with the same workgroup and storage-memory barriers as `__syncthreads()`.
Every spelling uses the same kernel and helper call checks above, including
proven uniform loops and rejection after a possible earlier return in that
function. These operations follow CUDA's
[full-block synchronization semantics](https://docs.nvidia.com/cuda/cuda-programming-guide/04-special-topics/cooperative-groups.html#sync).

`thread_rank()`, `num_threads()`, and its alias `size()` return `unsigned int`.
They accept member or type-qualified calls, including calls on a temporary from
`this_thread_block()`. Rank is `threadIdx.x + blockDim.x * (threadIdx.y +
blockDim.y * threadIdx.z)`; size is the product of the launch block dimensions.

The following zero-argument queries return nominal `dim3` values:

| Query | Coordinates |
| --- | --- |
| `group_index()` | Current block's `blockIdx` coordinates |
| `thread_index()` | Current thread's `threadIdx` coordinates |
| `dim_threads()` | Launch block dimensions (`blockDim`) |
| `group_dim()` | Alias of `dim_threads()` |

Dimension queries accept member, type-qualified, and temporary-handle calls,
including through namespace and type aliases. Their results are independent
values: modifying a copy leaves subsequent queries and the launch coordinates
unchanged. Device helpers can create local handles and use both scalar and
dimension queries. All queries remain runtime expressions and cannot supply
`constexpr` values or array bounds, even when the launch shape is fixed.

Device helpers accept `thread_block` by value, including `const` parameters,
namespace and type aliases, prototypes, and forwarding to other helpers. Copies
and temporary handles can be passed directly. Group parameters participate in
source argument counts and overload selection, and argument expressions retain
their left-to-right evaluation order. Helpers that synchronize still require
uniform calls and control flow across the block.

Handles and their by-value helper parameters do not consume shader variables or
buffer bindings. Group kernel parameters, function results, pointers, references,
arrays, struct members, shared storage, and `constexpr` handles remain unsupported.
Split-phase barriers, grid and cluster groups, coalesced groups, partitions, and
partial-block collectives are not yet supported. These operations are described in CUDA's
[`thread_block` API](https://docs.nvidia.com/cuda/cuda-programming-guide/05-appendices/device-callable-apis.html#class-thread-block).

Unsupported syntax produces a parse error with a source span. This includes
includes and other preprocessing forms outside the subset above, host code and launch syntax,
pointer operations outside the borrowed subset above,
mixed-type dynamic shared views, volatile objects and views outside the subset above,
atomic operations outside the integer overloads above,
other synchronization primitives, template forms outside the subset above,
double precision, and inline PTX. No CUDA runtime ABI or NVIDIA device code is
generated.

## Further increments

Add each capability with a failing acceptance test and rejection tests before
changing the parser or lowering. Useful next increments are more device-function
signatures, mixed-type dynamic shared views, and more general barrier placement. Each
increment must preserve validation and backend compatibility; CUDA-specific
features need an explicit portable representation or an unsupported-feature
diagnostic.
