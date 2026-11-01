use std::io::Write as _;
use std::process::{Command, Stdio};

pub fn validate_spirv(words: &[u32]) {
    validate_spirv_with_target_env(words, None);
}

pub fn validate_spirv_with_target_env(words: &[u32], target_env: Option<&str>) {
    let mut bytes = Vec::with_capacity(words.len() * 4);
    for word in words {
        bytes.extend_from_slice(&word.to_le_bytes());
    }

    let mut command = Command::new("spirv-val");
    if let Some(target_env) = target_env {
        command.args(["--target-env", target_env]);
    }
    let mut child = command
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .expect(
            "Failed to execute spirv-val. It can be installed \
            by installing the Vulkan SDK and adding it to your path.",
        );

    child
        .stdin
        .as_mut()
        .unwrap()
        .write_all(&bytes)
        .expect("failed to write SPIR-V module to spirv-val stdin");

    let output = child
        .wait_with_output()
        .expect("failed to wait for spirv-val");

    assert!(
        output.status.success(),
        "spirv-val rejected naga output:\n{}",
        String::from_utf8_lossy(&output.stderr)
    );
}
