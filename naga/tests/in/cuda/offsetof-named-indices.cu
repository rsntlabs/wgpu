#include <cstddef>
constexpr unsigned RowIndex = 1u;
constexpr int ColumnIndex = 2;
#define COLUMN (ColumnIndex)
struct Leaf { int first; int values[3]; };
struct Outer { int prefix; Leaf leaves[2]; int grid[2][3]; };
template<unsigned Index> __device__ unsigned selected_offset() {
    constexpr unsigned offset = unsigned(offsetof(Outer, leaves[(Index)].values[ColumnIndex]));
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
    constexpr unsigned Global = unsigned(offsetof(Outer, grid[RowIndex][ColumnIndex]));
    constexpr unsigned Local = unsigned(__builtin_offsetof(Outer, grid[LocalRow][LocalColumn]));
    constexpr unsigned Mixed = unsigned(offsetof(Outer, leaves[(1u)].values[((LocalColumn))]));
    constexpr unsigned ZeroIndex = unsigned(offsetof(Outer, leaves[Zero].values[Zero]));
    constexpr unsigned BoolIndex = unsigned(offsetof(Outer, grid[LastRow][Zero]));
    constexpr unsigned Macro = unsigned(__builtin_offsetof(Outer, grid[RowIndex][COLUMN]));
    output[base] = Global; output[base + 1u] = Local;
    output[base + 2u] = Mixed; output[base + 3u] = ZeroIndex;
    output[base + 4u] = BoolIndex; output[base + 5u] = Macro;
    output[base + 6u] = selected_offset<0u>();
    output[base + 7u] = selected_offset<1u>();
    output[base + 8u] = unsigned(cursor); output[base + 9u] = lane;
}
