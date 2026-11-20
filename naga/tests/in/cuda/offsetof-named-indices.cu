#include <cstddef>
constexpr unsigned RowIndex = 1u;
constexpr int ColumnIndex = 2;
#define COLUMN (ColumnIndex)
struct Leaf { int first; int values[3]; };
struct Outer { int prefix; Leaf leaves[2]; int grid[2][3]; };
template<unsigned Index> __device__ unsigned selected_offset() {
    constexpr unsigned offset = unsigned(offsetof(Outer, leaves[(((+(Index) * 2u / 2u + 0u) << 1u) >> 1u) & 1u].values[ColumnIndex]));
    return offset;
}
__global__ void named_offsets(unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 10u;
    int cursor = 7;
    constexpr unsigned LocalColumn = 1u;
    const int LocalRow = 1;
    const auto Zero = 0u;
    constexpr bool LastRow = true;
    constexpr unsigned Global = unsigned(offsetof(Outer, grid[((+RowIndex * 3u % 2u + 1u - 1u) << 0u) ^ 0u][((-(-ColumnIndex) * 3 / 2 - 1 + 0) >> 0) | 0]));
    constexpr unsigned Local = unsigned(__builtin_offsetof(Outer, grid[-(-LocalRow) - 0][+LocalColumn + 0u]));
    constexpr unsigned Mixed = unsigned(offsetof(Outer, leaves[(1u)].values[((LocalColumn))]));
    constexpr unsigned ZeroIndex = unsigned(offsetof(Outer, leaves[~(~Zero) * 7u + 1u - 1u].values[!LastRow % 2 + 0]));
    constexpr unsigned BoolIndex = unsigned(offsetof(Outer, grid[!!LastRow % 2 + 0][!LocalRow - 0]));
    constexpr unsigned Macro = unsigned(__builtin_offsetof(Outer, grid[RowIndex][COLUMN]));
    output[base] = Global; output[base + 1u] = Local;
    output[base + 2u] = Mixed; output[base + 3u] = ZeroIndex;
    output[base + 4u] = BoolIndex; output[base + 5u] = Macro;
    output[base + 6u] = selected_offset<0u>();
    output[base + 7u] = selected_offset<1u>();
    output[base + 8u] = unsigned(cursor); output[base + 9u] = lane;
}
