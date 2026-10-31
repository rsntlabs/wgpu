use naga::front::cuda::{parse_str, Options};

#[track_caller]
pub(crate) fn validate(source: &str) -> (naga::Module, naga::valid::ModuleInfo) {
    validate_with_options(source, &Options::default())
}

#[track_caller]
pub(crate) fn validate_with_options(
    source: &str,
    options: &Options,
) -> (naga::Module, naga::valid::ModuleInfo) {
    let module = parse_str(source, options).unwrap();
    let info = naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    )
    .validate(&module)
    .unwrap();
    (module, info)
}

#[track_caller]
pub(crate) fn parse_and_validate(source: &str) -> naga::Module {
    validate(source).0
}

pub(crate) fn root_expression(
    function: &naga::Function,
    mut pointer: naga::Handle<naga::Expression>,
) -> naga::Handle<naga::Expression> {
    loop {
        match function.expressions[pointer] {
            naga::Expression::Access { base, .. } | naga::Expression::AccessIndex { base, .. } => {
                pointer = base
            }
            _ => return pointer,
        }
    }
}

#[track_caller]
pub(crate) fn source_binding_initializer(
    function: &naga::Function,
    name: &str,
) -> naga::Handle<naga::Expression> {
    let named: Vec<_> = function
        .named_expressions
        .iter()
        .filter_map(|(&handle, actual)| (actual == name).then_some(handle))
        .collect();
    let locals: Vec<_> = function
        .local_variables
        .iter()
        .filter_map(|(handle, variable)| (variable.name.as_deref() == Some(name)).then_some(handle))
        .collect();
    assert_eq!(
        named.len() + locals.len(),
        1,
        "expected one source binding {name}"
    );
    if let Some(&value) = named.first() {
        return value;
    }
    let mut values = Vec::new();
    naga::proc::any_statement(&function.body, &mut |statement| {
        if let naga::Statement::Store { pointer, value } = *statement {
            if matches!(function.expressions[pointer], naga::Expression::LocalVariable(local) if local == locals[0])
            {
                values.push(value);
            }
        }
        false
    });
    assert_eq!(
        values.len(),
        1,
        "expected one initializer for source binding {name}"
    );
    values[0]
}

#[cfg(all(feature = "wgsl-in", feature = "wgsl-out"))]
#[track_caller]
pub(crate) fn wgsl_roundtrip(
    module: &naga::Module,
    info: &naga::valid::ModuleInfo,
    flags: naga::back::wgsl::WriterFlags,
) -> (String, naga::Module) {
    let output = naga::back::wgsl::write_string(module, info, flags).unwrap();
    let reparsed =
        naga::front::wgsl::parse_str(&output).unwrap_or_else(|error| panic!("{error:?}\n{output}"));
    naga::valid::Validator::new(
        naga::valid::ValidationFlags::all(),
        naga::valid::Capabilities::empty(),
    )
    .validate(&reparsed)
    .unwrap();
    (output, reparsed)
}
