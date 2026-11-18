mod common;
use common::TestFiles;

#[test]
fn cuda_while_declaration_conditions_cli_emits_all_backends_and_preserves_resources() {
    let source = r#"__device__ int next(const int *input, int &cursor) { return input[cursor++]; }
        __global__ void kernel(const int *input, unsigned *output) {
            int cursor = 0, total = 0;
            while (int item = next(input, cursor)) {
                if (item == 1) { item = 99; continue; }
                { int item = 3; total += item; }
                total += item;
                if (cursor > 3) break;
            }
            int item = 17;
            while (const auto selected{input[0],}) { total += selected; break; }
            while (auto empty = 0) ++total;
            while (constexpr auto fixed = 1) { total += fixed; break; }
            while (float fraction{0.5f}) { ++total; break; }
            switch (0) { case 0: while (int ended=0) {} break; case 1: break; }
            output[0] = unsigned(total + item + cursor);
        }"#;
    for compact in [false, true] {
        let files = TestFiles::new("cu", source);
        let outputs: Vec<_> = ["wgsl", "spv", "hlsl", "metal", "comp"]
            .iter()
            .map(|ext| files.output.with_extension(ext))
            .collect();
        let paths: Vec<_> = outputs.iter().map(|p| p.as_path()).collect();
        let mut arguments = vec!["--entry-point", "kernel", "--cuda-workgroup-size", "4,1,1"];
        if compact {
            arguments.push("--compact");
        }
        let result = files.translate_outputs(&arguments, &paths);
        assert!(
            result.status.success(),
            "{}",
            String::from_utf8_lossy(&result.stderr)
        );
        for output in outputs {
            assert!(std::fs::metadata(output).unwrap().len() > 0);
        }
        let module = files.read_module();
        assert_eq!(module.entry_points[0].workgroup_size, [4, 1, 1]);
        let resources: Vec<_> = module
            .global_variables
            .iter()
            .filter_map(|(_, g)| g.binding.map(|b| (b, g)))
            .collect();
        assert_eq!(resources.len(), 2);
        for (binding, global) in resources {
            assert_eq!(binding.group, 0);
            let naga::TypeInner::Array { base, stride, size } = module.types[global.ty].inner
            else {
                panic!("storage array");
            };
            assert_eq!(stride, 4);
            assert_eq!(size, naga::ArraySize::Dynamic);
            if binding.binding == 0 {
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::I32)
                );
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: naga::StorageAccess::LOAD
                    }
                );
            } else {
                assert_eq!(binding.binding, 1);
                assert_eq!(
                    global.space,
                    naga::AddressSpace::Storage {
                        access: naga::StorageAccess::LOAD | naga::StorageAccess::STORE
                    }
                );
                assert_eq!(
                    module.types[base].inner,
                    naga::TypeInner::Scalar(naga::Scalar::U32)
                );
            }
        }
    }
}

#[test]
fn cuda_while_declaration_conditions_cli_rejects_scope_escapes_redeclarations_and_invalid_headers()
{
    for source in [
        "__global__ void kernel() { int value=1; while(int item=1){int item=2;} }",
        "__global__ void kernel() { int value=1; while(int item=0){} int escaped=item; }",
        "__global__ void kernel() { int value=1; while(auto value=value){} }",
        "__global__ void kernel() { int value=1; while(int item=1;item){} }",
        "__global__ void kernel() { int value=1; do{}while(int item=0); }",
        "__global__ void kernel() { int value=1; while(int first=1,second=2){} }",
        "__global__ void kernel() { int value=1; while(int item){} }",
        "__global__ void kernel() { int value=1; while(int item(1)){} }",
        "__global__ void kernel() { int value=1; while(auto item={1}){} }",
        "__global__ void kernel() { int value=1; while(auto item{}){} }",
        "__global__ void kernel() { int value=1; while(int *item=&value){} }",
        "__global__ void kernel() { int value=1; while(int &item=value){} }",
        "__global__ void kernel() { int value=1; while(auto item=float2{1,2}){} }",
        "__global__ void kernel() { int value=1; while(volatile int item=1){} }",
        "__global__ void kernel() { int value=1; while(const auto item=1){item=2;} }",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "unexpectedacceptance:{source}");
    }
}
