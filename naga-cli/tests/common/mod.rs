use std::{
    fs,
    path::{Path, PathBuf},
    process::{Command, Output},
    sync::atomic::{AtomicUsize, Ordering},
};

pub(crate) struct TestFiles {
    directory: PathBuf,
    pub(crate) input: PathBuf,
    pub(crate) output: PathBuf,
}

impl TestFiles {
    pub(crate) fn new(extension: &str, source: &str) -> Self {
        static NEXT_ID: AtomicUsize = AtomicUsize::new(0);
        let directory = std::env::temp_dir().join(format!(
            "naga-cli-test-{}-{}",
            std::process::id(),
            NEXT_ID.fetch_add(1, Ordering::Relaxed)
        ));
        fs::create_dir(&directory).unwrap();
        let input = directory.join(format!("input.{extension}"));
        let output = directory.join("kernel.wgsl");
        fs::write(&input, source).unwrap();
        Self {
            directory,
            input,
            output,
        }
    }

    pub(crate) fn translate(&self, arguments: &[&str]) -> Output {
        self.translate_outputs(arguments, &[self.output.as_path()])
    }

    pub(crate) fn translate_outputs(&self, arguments: &[&str], outputs: &[&Path]) -> Output {
        Command::new(env!("CARGO_BIN_EXE_naga"))
            .args(arguments)
            .arg(&self.input)
            .args(outputs)
            .output()
            .unwrap()
    }

    pub(crate) fn read_module(&self) -> naga::Module {
        self.read_module_with_capabilities(naga::valid::Capabilities::empty())
    }

    pub(crate) fn read_module_with_capabilities(
        &self,
        capabilities: naga::valid::Capabilities,
    ) -> naga::Module {
        let source = fs::read_to_string(&self.output).unwrap();
        let module = naga::front::wgsl::parse_str(&source).unwrap();
        naga::valid::Validator::new(naga::valid::ValidationFlags::all(), capabilities)
            .validate(&module)
            .unwrap();
        module
    }
}

impl Drop for TestFiles {
    fn drop(&mut self) {
        fs::remove_dir_all(&self.directory).unwrap();
    }
}
