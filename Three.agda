module Three where
open import Core

postulate created? : Request → Bool

resolve : Request → Status
resolve r with created? r
... | true = Created
... | false = InternalError

test-created-resolve : ∀ {r} →
  created? r ≡ true →
  resolve r ≡ Created
test-created-resolve p rewrite p = refl

test-internal-error-resolve : ∀ {r} →
  created? r ≡ false →
  resolve r ≡ InternalError
test-internal-error-resolve p rewrite p = refl

