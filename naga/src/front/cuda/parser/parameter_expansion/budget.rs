use super::*;

const NODE_LIMIT: usize = 1_048_576;
const WORK_LIMIT: usize = 4_194_304;
const BYTE_LIMIT: usize = 67_108_864;

#[derive(Default)]
pub(in super::super) struct ExpansionBudget {
    active: bool,
    exhausted: bool,
    nodes: usize,
    work: usize,
    bytes: usize,
}

impl ExpansionBudget {
    pub(in super::super) const fn activate(&mut self) -> bool {
        let newly_active = !self.active;
        self.active = true;
        newly_active
    }

    pub(in super::super) const fn is_exhausted(&self) -> bool {
        self.exhausted
    }

    fn charge(
        active: bool,
        exhausted: &mut bool,
        used: &mut usize,
        count: usize,
        limit: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        if active {
            if count > limit - *used {
                *exhausted = true;
                return Err(limit_error(span));
            }
            *used += count;
        }
        Ok(())
    }

    pub(in super::super) fn charge_nodes(
        &mut self,
        count: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        Self::charge(
            self.active,
            &mut self.exhausted,
            &mut self.nodes,
            count,
            NODE_LIMIT,
            span,
        )
    }

    pub(in super::super) fn charge_work(
        &mut self,
        count: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        Self::charge(
            self.active,
            &mut self.exhausted,
            &mut self.work,
            count,
            WORK_LIMIT,
            span,
        )
    }

    pub(in super::super) fn charge_bytes(
        &mut self,
        count: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        Self::charge(
            self.active,
            &mut self.exhausted,
            &mut self.bytes,
            count,
            BYTE_LIMIT,
            span,
        )
    }

    pub(in super::super) fn charge_slice<T>(
        &mut self,
        count: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        let bytes = count
            .checked_mul(size_of::<T>())
            .ok_or_else(|| limit_error(span))?;
        self.charge_bytes(bytes, span)
    }

    pub(in super::super) fn charge_map_entry<K, V>(
        &mut self,
        count: usize,
        span: Span,
    ) -> Result<(), ParseError> {
        let entry = size_of::<K>()
            .checked_add(size_of::<V>())
            .and_then(|size| size.checked_add(size_of::<usize>()))
            .and_then(|size| size.checked_mul(2))
            .and_then(|size| size.checked_mul(count))
            .ok_or_else(|| limit_error(span))?;
        self.charge_bytes(entry, span)
    }
}

pub(super) fn limit_error(span: Span) -> ParseError {
    ParseError {
        message: String::from("CUDA helper parameter expansion limit exceeded"),
        span,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn dynamic_shared_source(calls: usize) -> String {
        let mut source = String::from("__device__ void no_op() {} __global__ void kernel() {");
        for index in 0..64 {
            source.push_str(&format!("__shared__ int fixed_{index};"));
        }
        source.push_str("extern __shared__ int dynamic[]; dynamic[0] = 1; {");
        for _ in 0..calls {
            source.push_str("no_op();");
        }
        source.push_str("} }");
        source
    }

    fn closed_dynamic_shared_parser(source: &str) -> Parser<'_> {
        let mut parser = Parser::new(Lexer::new(source).unwrap(), &Options::default());
        while parser.lexer.peek().unwrap().0 != Token::End {
            parser.function_definition().unwrap();
        }
        parser.finish_kernels().unwrap();
        parser.finish_functions().unwrap();
        parser.upgrade_atomic_storage().unwrap();
        parser.parameter_expansion_budget = ExpansionBudget::default();
        parser.parameter_expansion_budget.activate();
        parser
    }

    #[test]
    fn dynamic_shared_validation_charges_globals_for_repeated_nested_calls() {
        let single_source = dynamic_shared_source(1);
        let mut single = closed_dynamic_shared_parser(&single_source);
        single.check_dynamic_shared_views().unwrap();
        let single_work = single.parameter_expansion_budget.work;
        let globals = single.module.global_variables.len();
        assert_eq!(globals, 65);

        let repeated_source = dynamic_shared_source(2);
        let mut repeated = closed_dynamic_shared_parser(&repeated_source);
        let remaining = single_work + globals - 1;
        let span = Span::new(0, repeated_source.len() as u32);
        repeated
            .parameter_expansion_budget
            .charge_work(WORK_LIMIT - remaining, span)
            .unwrap();
        let error = repeated.check_dynamic_shared_views().unwrap_err();
        assert!(error.message.contains("limit"), "{error}");
        assert!(repeated.parameter_expansion_budget.is_exhausted());
    }
}
