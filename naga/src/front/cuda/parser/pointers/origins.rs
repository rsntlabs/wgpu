use super::*;

#[derive(Debug)]
pub(super) enum PointerOrigin {
    Array {
        address: BoundAddress,
        initial_index: Option<AddressProjection>,
    },
    Object(BoundAddress),
}

impl Parser<'_> {
    pub(super) fn analyze_pointer_origin(
        &mut self,
        mut address: BoundAddress,
        is_array: bool,
        span: Span,
    ) -> Result<PointerOrigin, ParseError> {
        let mut parent_ty = self
            .address_root_type(address.root)
            .ok_or_else(|| ParseError {
                message: String::from("unknown CUDA pointer origin"),
                span,
            })?;
        let mut last_parent = None;
        for projection in &address.projections {
            last_parent = Some(parent_ty);
            parent_ty = self.projected_address_type(parent_ty, projection, span)?;
        }
        if is_array {
            Ok(PointerOrigin::Array {
                address,
                initial_index: None,
            })
        } else if last_parent.is_some_and(|parent| {
            matches!(self.module.types[parent].inner, TypeInner::Array { .. })
        }) {
            let initial_index = address.projections.pop();
            Ok(PointerOrigin::Array {
                address,
                initial_index,
            })
        } else {
            Ok(PointerOrigin::Object(address))
        }
    }
}
