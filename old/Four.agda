module Four where
open import Core

resolve : Request → Status
resolve r with method r
... | GET = OK
... | m with method r
... | POST = Created
... | _ = InternalError

assertion : resolve (req GET) ≡ OK
assertion = refl

postCreated : ∀ r → method r ≡ POST
                  → resolve r ≡ Created
postCreated r p rewrite p | p = refl
