module Five where
open import Core2

-- resolve : Request → Status
-- resolve r with method r
-- ... | GET = OK
-- ... | POST = Created
-- ... | _ = InternalError

resolve : Request → Status
resolve (req GET) = OK
resolve (req POST) = Created
resolve (req _) = InternalError

helper : ∀ {r m} → method r ≡ m → r ≡ (req m)
helper {r} {POST} _ = {!!}
helper {r} {m} _ = {!!}

assertion : resolve (req GET) ≡ OK
assertion = refl

postCreated : ∀ r → method r ≡ POST
                  → resolve r ≡ Created
postCreated r p rewrite p = {!!}
