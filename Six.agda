module Six where
open import Core

created? : Request → Bool
created? r with meth r
... | POST = true
... | _ = false

test-POST-created : ∀ {r} →
  meth r ≡ POST →
  created? r ≡ true
test-POST-created p rewrite p = refl

test-else-not-created : ∀ {r} →
  meth r ≢ POST →
  created? r ≡ false
test-else-not-created {r} p with meth r
... | GET = refl
... | PUT = refl
... | POST = ⊥-elim (p refl)
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
  meth r ≡ POST →
  resolve r ≡ Created
test-POST-resolve p =
  test-created-resolve (test-POST-created p)

test-POST-resolve2 : ∀ {r} →
  meth r ≡ POST →
  resolve r ≡ Created
test-POST-resolve2 p rewrite p = refl

test-else-resolve : ∀ {r} →
  meth r ≢ POST →
  resolve r ≡ InternalError
test-else-resolve p =
  test-internal-error-resolve (test-else-not-created p)
