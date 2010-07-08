module Three where
open import Core

postulate created? : Request → Bool

resolve : Request → Status
resolve r with created? r
... | true = Created
... | false = InternalError

test-created-resolve :
  created? req-post ≡ true →
  resolve req-post ≡ Created
test-created-resolve p rewrite p = refl

test-internal-error-resolve :
  created? req-delete ≡ false →
  resolve req-delete ≡ InternalError
test-internal-error-resolve p rewrite p = refl

