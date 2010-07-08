module Four where
open import Core

created? : Request → Bool
created? r with meth r
... | POST = true
... | _ = false

resolve : Request → Status
resolve r with created? r
... | true = Created
... | false = InternalError

test-created-resolve :
  created? req-post ≡ true →
  resolve req-post ≡ Created
test-created-resolve p = refl

test-internal-error-resolve :
  created? req-delete ≡ false →
  resolve req-delete ≡ InternalError
test-internal-error-resolve p = refl
