module Two where
open import Core

postulate created? : Request → Bool

resolve : Request → Status
resolve _ = Created

test-created-resolve :
  created? req-post ≡ true →
  resolve req-post ≡ Created
test-created-resolve p rewrite p = refl

