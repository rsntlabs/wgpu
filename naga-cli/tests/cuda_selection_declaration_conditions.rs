mod common;
use common::TestFiles;

#[test]
fn cuda_selection_declaration_conditions_cli_emits_all_backends_and_preserves_resources() {
    let source = r#"using Scalar = int;
        __global__ void kernel(const int *input, unsigned *output) {
            int value = 0;
            if (int selected = input[0]) value += selected; else value += 10;
            if (int seed = input[1]; bool ready{seed > 0}) value += seed;
            else if (const Scalar fallback{2}) { { int fallback = 3; value += fallback; } value += fallback; }
            if (; float fraction = 0.5f) ++value;
            if (int(value), value) ++value;
            switch (unsigned mode{unsigned(input[0])}) {
                case 0u: value += 20; break;
                default: value += int(mode); break;
            }
            switch (value++; constexpr int fixed = 2) { case fixed: ++value; break; }
            output[0] = unsigned(value);
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
fn cuda_selection_declaration_conditions_cli_rejects_scope_escapes_redeclarations_and_invalid_headers(
) {
    for source in [
        "__global__ void kernel() { int value=1; if(int item=1){} int escaped=item; }",
        "__global__ void kernel() { int value=1; if(int item=1){int item=2;} }",
        "__global__ void kernel() { int value=1; if(int item=1){}else{int item=2;} }",
        "__global__ void kernel() { int value=1; if(int item=1;int item=2){} }",
        "__global__ void kernel() { int value=1; if(int item){} }",
        "__global__ void kernel() { int value=1; if(int item(1)){} }",
        "__global__ void kernel() { int value=1; if(int one=1,two=2){} }",
        "__global__ void kernel() { int value=1; if(auto item={1}){} }",
        "__global__ void kernel() { int value=1; if(int *item=0){} }",
        "__global__ void kernel() { int value=1; if(int &item=value){} }",
        "__global__ void kernel() { int value=1; if(int item[2]={1,2}){} }",
        "__global__ void kernel() { int value=1; if(float2 item{1,2}){} }",
        "__global__ void kernel() { int value=1; if(volatile int item=1){} }",
        "__global__ void kernel() { int value=1; switch(float item=1.0f){} }",
        "__global__ void kernel() { int value=1; switch(int item=1){} int escaped=item; }",
        "__global__ void kernel() { int value=1; while(int item=1){} }",
        "__global__ void kernel() { int value=1; if constexpr(int item=1){} }",
    ] {
        let files = TestFiles::new("cu", source);
        let result = files.translate(&[]);
        assert!(!result.status.success(), "unexpectedacceptance:{source}");
    }
}
