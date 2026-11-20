#include <cstddef>
constexpr unsigned RowIndex = 1u;
constexpr int ColumnIndex = 2;
#define COLUMN (ColumnIndex)
struct Leaf { int first; int values[3]; };
struct Outer { int prefix; Leaf leaves[2]; int grid[2][3]; };
using FixedRow = int[3];
template<unsigned Index> __device__ unsigned selected_offset() {
    constexpr unsigned offset = unsigned(offsetof(Outer, leaves[((((+(Index) * 2u / 2u + 0u) << 1u) >> 1u) & 1u) != 0u].values[ColumnIndex]));
    return offset;
}
__device__ void check_member_size(Outer *layout, unsigned index)
    noexcept(offsetof(Outer,
        grid[(sizeof((*layout).grid[index + (1 / 0)]) == 12u) && (sizeof nullptr == 8u)]
            [(sizeof (layout[index ? int(index) : -1]).prefix != 4u) || (sizeof(0x1.8p+2f) != 4u)
             || (sizeof *+layout->grid != 12u) || (sizeof(~true) != 4u) || (sizeof !layout != 1u)
             || (sizeof(index + 1L) != 8u) || (sizeof(layout->prefix / 0) != 4u)
             || (sizeof(index ? 1L : layout->prefix) != 8u)
             || (sizeof((index ? layout : nullptr)->grid) != 24u)
             || (sizeof(index, layout->grid) != 24u)
             || (sizeof(index ? index, 0L : 1L) != 8u)
             || (sizeof static_cast<unsigned short>(index) != 2u)
             || (sizeof(static_cast<bool>(layout)) != 1u)
             || (sizeof((unsigned short)(index + 1u)) != 2u)
             || (sizeof((bool)layout) != 1u)
             || (sizeof short(index) != 2u) || (sizeof(bool(layout)) != 1u)
             || (sizeof ::size_t(index) != 8u) || (sizeof(std::size_t(index)) != 8u)
             || (sizeof decltype(RowIndex)(index) != 4u)
             || (sizeof((short())) != 2u) || (sizeof ::size_t() != 8u)
             || (sizeof(sizeof layout->grid) != 8u) || (sizeof(alignof(::size_t)) != 8u)
             || (sizeof(FixedRow (*)[]) != 8u) || (alignof(short (*const)[2][3]) != 8u)
             || (sizeof(index[layout->grid]) != 12u)
             || (sizeof(layout->grid[layout->prefix < 1.0f]) != 12u)]) == 48u);

__global__ void named_offsets(unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 10u;
    int cursor = 7;
    constexpr unsigned LocalColumn = 1u;
    const int LocalRow = 1;
    const auto Zero = 0u;
    constexpr bool LastRow = true;
    constexpr unsigned Global = unsigned(offsetof(Outer, grid[((+RowIndex * 3u % 2u + 1u - 1u) << 0u) ^ 0u][((-(-ColumnIndex) * 3 / 2 - 1 + 0) >> 0) | 0]));
    constexpr unsigned Local = unsigned(__builtin_offsetof(Outer, grid[((-(-LocalRow) - 0) >= 1) || (1 / 0)][((+LocalColumn + 0u) <= 1u) || cursor]));
    constexpr unsigned Mixed = unsigned(offsetof(Outer, leaves[std::size_t((unsigned)unsigned(static_cast<unsigned>(true ? 1u : 0u)))].values[decltype(LocalColumn)((const int)int(static_cast<int>(Zero ? cursor : ((LocalColumn)))))]));
    constexpr unsigned ZeroIndex = unsigned(offsetof(Outer, leaves[((~(~Zero) * 7u + 1u - 1u) > 0u) && cursor].values[((!LastRow % 2 + 0) < 0) && (1 / 0)]));
    constexpr unsigned BoolIndex = unsigned(offsetof(Outer, grid[((!!LastRow % 2 + 0) == 1) * (sizeof(int) / alignof(int)) * (sizeof(Leaf) == 16u) * (alignof(Leaf) == 4u) * (sizeof(cursor) == 4u) * (sizeof(int*) == 8u) * (sizeof(int[2][3]) == 24u) * (alignof(const int*) == 8u)][((!LocalRow - unsigned()) != int()) + sizeof(bool) - alignof(bool) + sizeof(FixedRow) - 12u + (alignof(FixedRow) != 4u) + (sizeof(LocalColumn) != 4u) + (sizeof(int&) != 4u) + (alignof(int&) != 4u) + (alignof(int[2][3]) != 4u) + (alignof(int[][3]) != 4u)]));
    constexpr unsigned Macro = unsigned(__builtin_offsetof(Outer, grid[::size_t((bool)static_cast<bool>(true ? RowIndex : cursor))][static_cast<unsigned long long>(false ? (1 / 0) : COLUMN)]));
    output[base] = Global; output[base + 1u] = Local;
    output[base + 2u] = Mixed; output[base + 3u] = ZeroIndex;
    output[base + 4u] = BoolIndex; output[base + 5u] = Macro;
    output[base + 6u] = selected_offset<0u>();
    output[base + 7u] = selected_offset<1u>();
    output[base + 8u] = unsigned(cursor); output[base + 9u] = lane;
}
