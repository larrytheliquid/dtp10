module Five where
open import Core

created? : Request → Bool
created? r with meth r
... | POST = true
... | _ = false

resolve : Request → Status
resolve r with created? r
... | true = Created
... | false = InternalError

test-created-resolve : ∀ {r} →
  created? r ≡ true →
  resolve r ≡ Created
test-created-resolve {r} p with created? r | p
... | ._ | refl = refl

test-internal-error-resolve : ∀ {r} →
  created? r ≡ false →
  resolve r ≡ InternalError
test-internal-error-resolve {r} p with created? r | p
... | ._ | refl = refl
