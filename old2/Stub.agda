module Stub where
open import Assertion

-- TODO: can we get around method r with matching req?
-- ... maybe index record on Method?
resolve : Request → Status
resolve r with method r
resolve r | m   with created? m
resolve r | _   | true  = Created
-- TODO: consider ok?/found? here
-- resolve r | GET | false = OK
resolve r | _   | false = InternalError

-- test-POST-resolve : ∀ r →
--                     resolve r ≡ Created
-- test-POST-resolve r = {!!}

-- r : Request
-- ————————————————————————————————————————————————————————————
-- Goal: (resolve r | method r) ≡ Created

-- we actually care about the order that the function implementation calls
-- methods b/c each call creates a proof obligation
test-POST-resolve : ∀ {r m} →
                    method r ≡ m →
                    created? m ≡ true →
                    resolve r ≡ Created
test-POST-resolve p₁ p₂ rewrite p₁ | p₂ = refl
