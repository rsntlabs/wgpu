use super::{shader_input_output_test, InputStorageType, ShaderBuffer, ShaderTest};
use wgpu_test::{apply, gpu_test, GpuTestConfiguration, GpuTestInitializer, TestParameters};

const WORKGROUP_VOLATILE: wgpu::Features = wgpu::Features::MEMORY_DECORATION_VOLATILE_WORKGROUP;

pub fn all_tests(tests: &mut Vec<GpuTestInitializer>) {
    tests.push(WORKGROUP_VOLATILE_MEMORY);
}

#[apply(gpu_test!)]
static WORKGROUP_VOLATILE_MEMORY: GpuTestConfiguration = GpuTestConfiguration::new()
    .parameters(
        TestParameters::default()
            .features(WORKGROUP_VOLATILE)
            .limits(wgpu::Limits::default()),
    )
    .run_async(|ctx| {
        let source = "@volatile var<workgroup> values: array<u32, 64>;
            @group(0) @binding(0) var<storage, read_write> output: array<u32>;
            @compute @workgroup_size(64) fn main(
                @builtin(local_invocation_index) lane: u32,
                @builtin(workgroup_id) group: vec3<u32>,
            ) {
                values[lane] = group.x * 1000u + lane;
                workgroupBarrier();
                let previous = values[(lane + 63u) & 63u] + 17u;
                workgroupBarrier();
                values[lane] = previous;
                workgroupBarrier();
                output[group.x * 64u + lane] = values[(lane + 1u) & 63u];
            }";
        let expected: Vec<u32> = (0..3)
            .flat_map(|group| (0..64).map(move |lane| group * 1000 + lane + 17))
            .collect();
        let case = ShaderTest::new(
            "volatile shared-memory exchange".into(),
            String::new(),
            String::new(),
            &[0u32],
            &expected,
        )
        .module_source(source.into(), "main".into())
        .module_buffers(
            vec![ShaderBuffer::new(
                0,
                wgpu::BufferBindingType::Storage { read_only: false },
                &[0u32; 192],
            )],
            0,
            [3, 1, 1],
        );
        shader_input_output_test(ctx, InputStorageType::Storage, vec![case])
    });
