module Two where
open import Core

end : Request → Status
end _ = InternalError

d2 : Request → Status
d2 r with method r
... | POST = Created
... | _    = end r

d1 : Request → Status
d1 r with method r
... | GET = OK
... | _   = d2 r

resolve : Request → Status
resolve = d1

getOK : ∀ r → method r ≡ GET
            → resolve r ≡ OK
getOK r p rewrite p = refl

-- postCreated : ∀ r → method r ≡ POST
--                   → resolve r ≡ Created
-- postCreated r p rewrite p | p = refl

postCreated : ∀ r → method r ≡ POST
                  → resolve r ≡ Created
postCreated r p with method r | p
... | .POST | refl with method r | p
... | .POST | refl = refl

-- putInternalError : ∀ r → method r ≡ PUT
--                    → resolve r ≡ InternalError
-- putInternalError r p rewrite p | p = refl
