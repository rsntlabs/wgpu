#[derive(Clone, Copy, Debug, Default, Eq, Hash, PartialEq)]
pub(super) struct Qualifiers {
    pub(super) is_const: bool,
    pub(super) is_volatile: bool,
}

impl Qualifiers {
    pub(super) const NONE: Self = Self {
        is_const: false,
        is_volatile: false,
    };

    pub(super) const CONST: Self = Self {
        is_const: true,
        is_volatile: false,
    };

    pub(super) const fn union(self, other: Self) -> Self {
        Self {
            is_const: self.is_const || other.is_const,
            is_volatile: self.is_volatile || other.is_volatile,
        }
    }

    pub(super) const fn contains(self, other: Self) -> bool {
        (!other.is_const || self.is_const) && (!other.is_volatile || self.is_volatile)
    }

    pub(super) const fn without(self, other: Self) -> Self {
        Self {
            is_const: self.is_const && !other.is_const,
            is_volatile: self.is_volatile && !other.is_volatile,
        }
    }

    pub(super) const fn qualification_rank(self, source: Self) -> Option<u8> {
        if self.contains(source) {
            Some(
                (self.is_const && !source.is_const) as u8
                    + (self.is_volatile && !source.is_volatile) as u8,
            )
        } else {
            None
        }
    }
}
