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
  created? (req POST) ≡ true →
  resolve (req POST) ≡ Created
test-created-resolve p = refl

test-internal-error-resolve :
  created? (req DELETE) ≡ false →
  resolve (req DELETE) ≡ InternalError
test-internal-error-resolve p = refl
