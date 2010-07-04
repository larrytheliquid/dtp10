module Two where
open import Core

postulate created? : Request → Bool

resolve : Request → Status
resolve _ = Created

test-created-resolve :
  created? (req POST) ≡ true →
  resolve (req POST) ≡ Created
test-created-resolve p rewrite p = refl

