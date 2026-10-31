use super::*;

#[test]
fn value_cache_does_not_reserve_inline_reference_types() {
    assert!(size_of::<Option<CachedExpression>>() < size_of::<Option<MappedExpression>>());
}
