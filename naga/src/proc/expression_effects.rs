use crate::{
    arena::HandleSet, Arena, Expression, Function, GlobalVariable, Handle, MemoryDecorations,
};

#[derive(Debug, Default)]
pub(crate) struct ExpressionEffects {
    #[cfg(spv_out)]
    volatile_pointers: HandleSet<Expression>,
    volatile_reads: HandleSet<Expression>,
}

impl ExpressionEffects {
    /// Requires validated IR, whose storage and workgroup pointers derive only from globals.
    pub(crate) fn new(function: &Function, globals: &Arena<GlobalVariable>) -> Self {
        let mut volatile_pointers = HandleSet::for_arena(&function.expressions);
        let mut volatile_reads = HandleSet::for_arena(&function.expressions);
        for (handle, expression) in function.expressions.iter() {
            match *expression {
                Expression::GlobalVariable(global)
                    if globals[global]
                        .memory_decorations
                        .contains(MemoryDecorations::VOLATILE) =>
                {
                    volatile_pointers.insert(handle);
                }
                Expression::Access { base, .. } | Expression::AccessIndex { base, .. }
                    if volatile_pointers.contains(base) =>
                {
                    volatile_pointers.insert(handle);
                }
                Expression::Load { pointer } if volatile_pointers.contains(pointer) => {
                    volatile_reads.insert(handle);
                }
                _ => {}
            }
        }
        Self {
            #[cfg(spv_out)]
            volatile_pointers,
            volatile_reads,
        }
    }

    pub(crate) fn must_evaluate(&self, expression: Handle<Expression>) -> bool {
        self.volatile_reads.contains(expression)
    }

    #[cfg(spv_out)]
    pub(crate) fn is_volatile_pointer(&self, expression: Handle<Expression>) -> bool {
        self.volatile_pointers.contains(expression)
    }
}
