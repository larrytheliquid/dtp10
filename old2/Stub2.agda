module Stub2 where
open import Core

-- postulate
--   created? : Request → Bool
--   resolve : Request → Status

test-POST-resolve : ∀ {r} →
                    created? r ≡ true →
                    resolve r ≡ Created
test-POST-resolve p = {!!}
