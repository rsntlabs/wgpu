use wgpu_test::{fail, valid};

const WORKGROUP_VOLATILE: wgpu::Features = wgpu::Features::MEMORY_DECORATION_VOLATILE_WORKGROUP;

const WORKGROUP_SOURCE: &str = "@volatile var<workgroup> values: array<u32, 4>;
    @compute @workgroup_size(1) fn main() { values[0] = 7u; }";
const STORAGE_SOURCE: &str = "@group(0) @binding(0)
    @volatile var<storage, read_write> values: array<u32>;
    @compute @workgroup_size(1) fn main() { values[0] = 7u; }";

#[test]
fn workgroup_volatile_requires_its_own_feature() {
    for required_features in [
        wgpu::Features::empty(),
        wgpu::Features::MEMORY_DECORATION_VOLATILE,
    ] {
        let (device, _) = wgpu::Device::noop(&wgpu::DeviceDescriptor {
            required_features,
            ..Default::default()
        });
        fail(
            &device,
            || {
                device.create_shader_module(wgpu::ShaderModuleDescriptor {
                    label: None,
                    source: wgpu::ShaderSource::Wgsl(WORKGROUP_SOURCE.into()),
                })
            },
            None,
        );
        if required_features.contains(wgpu::Features::MEMORY_DECORATION_VOLATILE) {
            valid(&device, || {
                device.create_shader_module(wgpu::ShaderModuleDescriptor {
                    label: None,
                    source: wgpu::ShaderSource::Wgsl(STORAGE_SOURCE.into()),
                })
            });
        }
    }
}

#[test]
fn workgroup_volatile_feature_does_not_enable_volatile_storage() {
    let (device, _) = wgpu::Device::noop(&wgpu::DeviceDescriptor {
        required_features: WORKGROUP_VOLATILE,
        ..Default::default()
    });
    valid(&device, || {
        device.create_shader_module(wgpu::ShaderModuleDescriptor {
            label: None,
            source: wgpu::ShaderSource::Wgsl(WORKGROUP_SOURCE.into()),
        })
    });
    fail(
        &device,
        || {
            device.create_shader_module(wgpu::ShaderModuleDescriptor {
                label: None,
                source: wgpu::ShaderSource::Wgsl(STORAGE_SOURCE.into()),
            })
        },
        None,
    );
}
