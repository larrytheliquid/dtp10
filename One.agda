module One where
open import Core

postulate created? : Request → Bool

test-created-resolve :
  created? (req POST) ≡ true →
  resolve r ≡ Created
test-created-resolve p = {!!}

-- Not in scope: resolve
-- when scope checking resolve r ≡ Created

