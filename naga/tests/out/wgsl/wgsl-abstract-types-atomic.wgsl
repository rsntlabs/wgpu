@group(0) @binding(0)
var<storage, read_write> atomic_i32_: atomic<i32>;
@group(0) @binding(1)
var<storage, read_write> atomic_u32_: atomic<u32>;

fn test_atomic_i32_() {
    atomicStore((&atomic_i32_), 1i);
    let phony = atomicCompareExchangeWeak((&atomic_i32_), 1i, 1i);
    let phony_1 = atomicCompareExchangeWeak((&atomic_i32_), 1i, 1i);
    let phony_2 = atomicAdd((&atomic_i32_), 1i);
    let phony_3 = atomicSub((&atomic_i32_), 1i);
    let phony_4 = atomicAnd((&atomic_i32_), 1i);
    let phony_5 = atomicXor((&atomic_i32_), 1i);
    let phony_6 = atomicOr((&atomic_i32_), 1i);
    let phony_7 = atomicMin((&atomic_i32_), 1i);
    let phony_8 = atomicMax((&atomic_i32_), 1i);
    let phony_9 = atomicExchange((&atomic_i32_), 1i);
    return;
}

fn test_atomic_u32_() {
    atomicStore((&atomic_u32_), 1u);
    let phony_10 = atomicCompareExchangeWeak((&atomic_u32_), 1u, 1u);
    let phony_11 = atomicCompareExchangeWeak((&atomic_u32_), 1u, 1u);
    let phony_12 = atomicAdd((&atomic_u32_), 1u);
    let phony_13 = atomicSub((&atomic_u32_), 1u);
    let phony_14 = atomicAnd((&atomic_u32_), 1u);
    let phony_15 = atomicXor((&atomic_u32_), 1u);
    let phony_16 = atomicOr((&atomic_u32_), 1u);
    let phony_17 = atomicMin((&atomic_u32_), 1u);
    let phony_18 = atomicMax((&atomic_u32_), 1u);
    let phony_19 = atomicExchange((&atomic_u32_), 1u);
    return;
}

@compute @workgroup_size(1, 1, 1)
fn main() {
    test_atomic_i32_();
    test_atomic_u32_();
    return;
}
