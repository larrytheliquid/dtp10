module Zero where
open import Core

test-created-resolve :
  created? req-post ≡ true →
  resolve r ≡ Created
test-created-resolve p = {!!}

-- Not in scope: created?
-- when scope checking created? (req POST) ≡ true

