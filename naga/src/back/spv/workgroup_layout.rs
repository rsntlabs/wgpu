use alloc::{vec, vec::Vec};

use spirv::Word;

use super::{
    Block, Error, Function, FunctionArgument, Instruction, LookupFunctionType, WrappedFunction,
    Writer,
};
use crate::arena::{Handle, HandleSet};

#[derive(Clone, Copy, Debug, Eq, Hash, PartialEq)]
pub(super) enum Conversion {
    ToWorkgroup,
    FromWorkgroup,
}

pub(super) fn required_types(module: &crate::Module) -> HandleSet<crate::Type> {
    let mut required = HandleSet::for_arena(&module.types);
    for (_, var) in module.global_variables.iter() {
        if var.space == crate::AddressSpace::WorkGroup {
            required.insert(var.ty);
        }
    }
    for (_, ty) in module.types.iter() {
        if let crate::TypeInner::Pointer {
            base,
            space: crate::AddressSpace::WorkGroup,
        } = ty.inner
        {
            required.insert(base);
        }
    }
    for (handle, ty) in module.types.iter().rev() {
        if required.contains(handle) {
            match ty.inner {
                crate::TypeInner::Array { base, .. } => {
                    required.insert(base);
                }
                crate::TypeInner::Struct { ref members, .. } => {
                    required.insert_iter(members.iter().map(|member| member.ty));
                }
                _ => {}
            }
        }
    }
    required
}

impl Writer {
    pub(super) fn get_workgroup_type_id(&mut self, ty: Handle<crate::Type>) -> Word {
        self.workgroup_type_ids
            .get(ty)
            .copied()
            .unwrap_or_else(|| self.get_handle_type_id(ty))
    }

    pub(super) fn write_workgroup_type_declaration(
        &mut self,
        module: &crate::Module,
        ty: Handle<crate::Type>,
        required: &HandleSet<crate::Type>,
    ) -> Result<(), Error> {
        let canonical_id = self.get_handle_type_id(ty);
        let id = if required.contains(ty) {
            match module.types[ty].inner {
                crate::TypeInner::Array { base, size, .. } => {
                    let id = self.id_gen.next();
                    let base_id = self.get_workgroup_type_id(base);
                    let instruction = match size.resolve(module.to_ctx())? {
                        crate::proc::IndexableLength::Known(length) => {
                            let length_id = self.get_index_constant(length);
                            Instruction::type_array(id, base_id, length_id)
                        }
                        crate::proc::IndexableLength::Dynamic => {
                            Instruction::type_runtime_array(id, base_id)
                        }
                    };
                    instruction.to_words(&mut self.logical_layout.declarations);
                    id
                }
                crate::TypeInner::Struct { ref members, .. } => {
                    let id = self.id_gen.next();
                    let member_ids: Vec<_> = members
                        .iter()
                        .map(|member| self.get_workgroup_type_id(member.ty))
                        .collect();
                    Instruction::type_struct(id, &member_ids)
                        .to_words(&mut self.logical_layout.declarations);
                    id
                }
                _ => canonical_id,
            }
        } else {
            canonical_id
        };
        self.workgroup_type_ids.insert(ty, id);
        Ok(())
    }

    fn workgroup_conversion_types(
        &mut self,
        ty: Handle<crate::Type>,
        conversion: Conversion,
    ) -> (Word, Word) {
        let canonical = self.get_handle_type_id(ty);
        let workgroup = self.get_workgroup_type_id(ty);
        match conversion {
            Conversion::ToWorkgroup => (canonical, workgroup),
            Conversion::FromWorkgroup => (workgroup, canonical),
        }
    }

    pub(super) fn convert_workgroup_value(
        &mut self,
        module: &crate::Module,
        ty: Handle<crate::Type>,
        conversion: Conversion,
        value: Word,
        block: &mut Block,
    ) -> Result<Word, Error> {
        let (source_type, target_type) = self.workgroup_conversion_types(ty, conversion);
        if source_type == target_type {
            return Ok(value);
        }
        let id = self.id_gen.next();
        let instruction = if self.physical_layout.version >= 0x10400 {
            Instruction::unary(spirv::Op::CopyLogical, target_type, id, value)
        } else {
            let function = self.write_workgroup_conversion(module, ty, conversion)?;
            Instruction::function_call(target_type, id, function, &[value])
        };
        block.body.push(instruction);
        Ok(id)
    }

    fn write_workgroup_conversion(
        &mut self,
        module: &crate::Module,
        ty: Handle<crate::Type>,
        conversion: Conversion,
    ) -> Result<Word, Error> {
        let key = WrappedFunction::WorkgroupLayout {
            r#type: ty,
            conversion,
        };
        if let Some(&id) = self.wrapped_functions.get(&key) {
            return Ok(id);
        }
        let mut pending = vec![(ty, false)];
        while let Some((current, ready)) = pending.pop() {
            let key = WrappedFunction::WorkgroupLayout {
                r#type: current,
                conversion,
            };
            if self.wrapped_functions.contains_key(&key) {
                continue;
            }
            let (source, target) = self.workgroup_conversion_types(current, conversion);
            if source == target {
                continue;
            }
            if ready {
                self.write_workgroup_conversion_function(module, current, conversion)?;
            } else {
                pending.push((current, true));
                match module.types[current].inner {
                    crate::TypeInner::Array { base, .. } => pending.push((base, false)),
                    crate::TypeInner::Struct { ref members, .. } => {
                        pending.extend(members.iter().map(|member| (member.ty, false)));
                    }
                    _ => unreachable!("Only array and struct workgroup types need conversion"),
                }
            }
        }
        Ok(self.wrapped_functions[&key])
    }

    fn write_workgroup_conversion_function(
        &mut self,
        module: &crate::Module,
        ty: Handle<crate::Type>,
        conversion: Conversion,
    ) -> Result<(), Error> {
        let key = WrappedFunction::WorkgroupLayout {
            r#type: ty,
            conversion,
        };
        let function_id = self.id_gen.next();
        self.wrapped_functions.insert(key, function_id);
        let (source_type, target_type) = self.workgroup_conversion_types(ty, conversion);
        let function_type = self.get_function_type(LookupFunctionType {
            parameter_type_ids: vec![source_type],
            return_type_id: target_type,
        });
        let mut function = Function {
            signature: Some(Instruction::function(
                target_type,
                function_id,
                spirv::FunctionControl::empty(),
                function_type,
            )),
            ..Function::default()
        };
        let parameter = self.id_gen.next();
        function.parameters.push(FunctionArgument {
            instruction: Instruction::function_parameter(source_type, parameter),
            handle_id: 0,
        });
        let mut block = Block::new(self.id_gen.next());
        let result = match module.types[ty].inner {
            crate::TypeInner::Struct { ref members, .. } => {
                let mut member_values = Vec::with_capacity(members.len());
                for (index, member) in members.iter().enumerate() {
                    let (member_source_type, _) =
                        self.workgroup_conversion_types(member.ty, conversion);
                    let member_value = self.id_gen.next();
                    block.body.push(Instruction::composite_extract(
                        member_source_type,
                        member_value,
                        parameter,
                        &[index as u32],
                    ));
                    let converted = self.convert_workgroup_value(
                        module,
                        member.ty,
                        conversion,
                        member_value,
                        &mut block,
                    )?;
                    member_values.push(converted);
                }
                let result = self.id_gen.next();
                block.body.push(Instruction::composite_construct(
                    target_type,
                    result,
                    &member_values,
                ));
                result
            }
            crate::TypeInner::Array { base, size, .. } => {
                let length = match size.resolve(module.to_ctx())? {
                    crate::proc::IndexableLength::Known(length) => length,
                    crate::proc::IndexableLength::Dynamic => {
                        return Err(Error::Validation("Workgroup arrays must be sized"));
                    }
                };
                let source_pointer =
                    self.get_pointer_type_id(source_type, spirv::StorageClass::Function);
                let target_pointer =
                    self.get_pointer_type_id(target_type, spirv::StorageClass::Function);
                let source = self.id_gen.next();
                let target = self.id_gen.next();
                block.body.push(Instruction::variable(
                    source_pointer,
                    source,
                    spirv::StorageClass::Function,
                    None,
                ));
                block.body.push(Instruction::variable(
                    target_pointer,
                    target,
                    spirv::StorageClass::Function,
                    None,
                ));
                block.body.push(Instruction::store(source, parameter, None));

                let entry = block.label_id;
                let header = self.id_gen.next();
                let body = self.id_gen.next();
                let continuing = self.id_gen.next();
                let merge = self.id_gen.next();
                let index = self.id_gen.next();
                let next_index = self.id_gen.next();
                let uint_type = self.get_u32_type_id();
                let zero = self.get_index_constant(0);
                let one = self.get_index_constant(1);
                let length = self.get_index_constant(length);
                function.consume(block, Instruction::branch(header));

                block = Block::new(header);
                block.body.push(Instruction::phi(
                    uint_type,
                    index,
                    &[(zero, entry), (next_index, continuing)],
                ));
                let in_bounds = self.id_gen.next();
                let bool_type = self.get_bool_type_id();
                block.body.push(Instruction::binary(
                    spirv::Op::ULessThan,
                    bool_type,
                    in_bounds,
                    index,
                    length,
                ));
                block.body.push(Instruction::loop_merge(
                    merge,
                    continuing,
                    spirv::SelectionControl::NONE,
                ));
                function.consume(
                    block,
                    Instruction::branch_conditional(in_bounds, body, merge),
                );

                block = Block::new(body);
                let (element_source_type, element_target_type) =
                    self.workgroup_conversion_types(base, conversion);
                let source_element_pointer =
                    self.get_pointer_type_id(element_source_type, spirv::StorageClass::Function);
                let target_element_pointer =
                    self.get_pointer_type_id(element_target_type, spirv::StorageClass::Function);
                let source_element = self.id_gen.next();
                let target_element = self.id_gen.next();
                block.body.push(Instruction::access_chain(
                    source_element_pointer,
                    source_element,
                    source,
                    &[index],
                ));
                block.body.push(Instruction::access_chain(
                    target_element_pointer,
                    target_element,
                    target,
                    &[index],
                ));
                let element_value = self.id_gen.next();
                block.body.push(Instruction::load(
                    element_source_type,
                    element_value,
                    source_element,
                    None,
                ));
                let converted = self.convert_workgroup_value(
                    module,
                    base,
                    conversion,
                    element_value,
                    &mut block,
                )?;
                block
                    .body
                    .push(Instruction::store(target_element, converted, None));
                function.consume(block, Instruction::branch(continuing));

                block = Block::new(continuing);
                block.body.push(Instruction::binary(
                    spirv::Op::IAdd,
                    uint_type,
                    next_index,
                    index,
                    one,
                ));
                function.consume(block, Instruction::branch(header));

                block = Block::new(merge);
                let result = self.id_gen.next();
                block
                    .body
                    .push(Instruction::load(target_type, result, target, None));
                result
            }
            _ => unreachable!("Only array and struct workgroup types need conversion"),
        };
        function.consume(block, Instruction::return_value(result));
        function.to_words(&mut self.logical_layout.function_definitions);
        Ok(())
    }
}
