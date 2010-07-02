module One where
open import Core

test-created-resolve : ∀ {r} →
  created? r ≡ true →
  resolve r ≡ Created
test-created-resolve p = {!!}

-- Not in scope:
--   created? at /Users/larrytheliquid/src/dtp10/One.agda:8,21-29
--   ≡ at /Users/larrytheliquid/src/dtp10/One.agda:8,32-33
--   true at /Users/larrytheliquid/src/dtp10/One.agda:8,34-38
-- when scope checking created? r ≡ true
