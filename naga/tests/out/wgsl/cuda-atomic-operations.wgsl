@group(0) @binding(0)
var<storage, read_write> output: array<atomic<i32>>;

@compute @workgroup_size(1, 1, 1)
fn kernel() {
    let _e6 = atomicSub((&output[u32(0u)]), -(3i));
    atomicStore((&output[u32(8i)]), _e6);
    let _e14 = atomicMin((&output[u32(1i)]), 3i);
    atomicStore((&output[u32(9i)]), _e14);
    let _e22 = atomicMax((&output[u32(2i)]), 3i);
    atomicStore((&output[u32(10i)]), _e22);
    let _e31 = atomicAnd((&output[u32(3i)]), -(13i));
    atomicStore((&output[u32(11i)]), _e31);
    let _e39 = atomicOr((&output[u32(4i)]), 15i);
    atomicStore((&output[u32(12i)]), _e39);
    let _e50 = atomicXor((&output[u32(5i)]), (-(2147483647i) - 1i));
    atomicStore((&output[u32(13i)]), _e50);
    let _e59 = atomicExchange((&output[u32(6i)]), i32(4.75f));
    atomicStore((&output[u32(14i)]), _e59);
    let _e66 = atomicLoad((&output[u32(0i)]));
    atomicStore((&output[u32(16i)]), _e66);
    let _e73 = atomicLoad((&output[u32(1i)]));
    atomicStore((&output[u32(17i)]), _e73);
    let _e80 = atomicLoad((&output[u32(2i)]));
    atomicStore((&output[u32(18i)]), _e80);
    let _e87 = atomicLoad((&output[u32(3i)]));
    atomicStore((&output[u32(19i)]), _e87);
    let _e94 = atomicLoad((&output[u32(4i)]));
    atomicStore((&output[u32(20i)]), _e94);
    let _e101 = atomicLoad((&output[u32(5i)]));
    atomicStore((&output[u32(21i)]), _e101);
    let _e108 = atomicLoad((&output[u32(6i)]));
    atomicStore((&output[u32(22i)]), _e108);
    let _e117 = atomicSub((&output[u32(0u)]), i32(2.75f));
    let _e121 = atomicLoad((&output[u32(0i)]));
    atomicStore((&output[u32(23i)]), _e121);
}
