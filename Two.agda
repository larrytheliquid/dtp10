module Two where
open import Core

postulate created? : Request → Bool

resolve : Request → Status
resolve _ = Created

test-created-resolve : ∀ {r} →
  created? r ≡ true →
  resolve r ≡ Created
test-created-resolve p rewrite p = refl

