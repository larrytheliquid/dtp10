module Four where
open import Core

created? : Request → Bool
created? r with method r
... | POST = true
... | _ = false

test-POST-created : ∀ {r} →
  method r ≡ POST →
  created? r ≡ true
test-POST-created p rewrite p = refl

test-else-not-created : ∀ {r} →
  method r ≢ POST →
  created? r ≡ false
test-else-not-created {r} p with method r
... | GET = refl
... | POST = ⊥-elim (p refl)
... | PUT = refl
... | DELETE = refl

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

test-POST-resolve : ∀ {r} →
  method r ≡ POST →
  resolve r ≡ Created
test-POST-resolve p =
  test-created-resolve (test-POST-created p)
