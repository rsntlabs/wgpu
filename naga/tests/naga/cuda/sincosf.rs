use super::helpers::validate;
use naga::front::cuda::{parse_str, Options};

#[test]
fn cuda_sincosf_writes_local_and_storage_float_outputs_using_shared_trig_helper() {
    let (module, info) = validate(
        "__host__ __device__ void sincosf(float,float*,float*);
        __global__ void kernel(float *output,float value) {
            float sine; float cosine;
            sincosf(value,&sine,&cosine); output[0]=sine; output[1]=cosine;
            sincosf(3,output+2,output+3);
        }",
    );
    assert_eq!(
        module
            .functions
            .iter()
            .filter(|(_, f)| f.name.as_deref() == Some("_naga_trigonometry"))
            .count(),
        1
    );
    #[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
    super::helpers::wgsl_roundtrip(
        &module,
        &info,
        naga::back::wgsl::WriterFlags::EXPLICIT_TYPES,
    );
    let _ = info;
}

#[test]
fn cuda_sincosf_evaluates_input_and_pointer_arguments_once() {
    let (module, _) = validate(
        "__device__ float next(float value) { return value; }
        __global__ void kernel(float *output,float value) {
            unsigned cursor=0u;
            sincosf(next(value++),output+cursor++,output+cursor++);
            output[2]=float(cursor); output[3]=value;
        }",
    );
    let mut calls = 0;
    naga::proc::any_statement(&module.entry_points[0].function.body, &mut |statement| {
        if let naga::Statement::Call { function, .. } = statement {
            if module.functions[*function].name.as_deref() == Some("next") {
                calls += 1;
            }
        }
        false
    });
    assert_eq!(calls, 1);
}

#[test]
fn cuda_sincosf_writes_forwarded_and_selected_pointer_targets() {
    validate(
        "__device__ void pair(float x, float *s, float *c);
        __global__ void kernel(float *output, float value) {
            float *target = value > 0.0f ? output : output + 2;
            pair(value, target, output + 1);
            target = output + 3;
            pair(value, output, target);
        }
        __device__ void pair(float x, float *s, float *c) { sincosf(x,s,c); }",
    );
}

#[test]
fn cuda_sincosf_rejects_bad_signatures_results_and_output_pointers() {
    for source in [
        "__device__ float sincosf(float,float*,float*); __global__ void kernel() {}",
        "__device__ void sincosf(float x,float *s,float *c) {} __global__ void kernel() {}",
        "__global__ void kernel(float *p) { sincosf(1.0f,p); }",
        "__global__ void kernel(float *p) { float value=sincosf(1.0f,p,p); }",
        "__global__ void kernel(float *p) { sincosf(1.0f,1.0f,p); }",
        "__global__ void kernel(float *p,int *q) { sincosf(1.0f,q,p); }",
        "__global__ void kernel(float *p,const float *q) { sincosf(1.0f,p,q); }",
        "__global__ void kernel(float *p) { const float x=1.0f; sincosf(1.0f,&x,p); }",
        "__global__ void kernel(float *p) { sincosf(1.0f,nullptr,p); }",
    ] {
        assert!(parse_str(source, &Options::default()).is_err(), "{source}");
    }
}
