module One where
open import Core

resolve : Request → Status
resolve r with method r
... | GET = OK
... | POST = Created
... | _ = InternalError

assertion : resolve (req GET) ≡ OK
assertion = refl

-- assertEqual (resolve (req GET)) OK

-- badAssertion : resolve (req GET) ≡ Created
-- badAssertion = refl
-- 
-- /Users/larrytheliquid/src/dtp10/One.agda:14,16-20
-- OK != Created of type Status
-- when checking that the expression refl has type OK ≡ Created

-- ... except at compile time instead of run time!

getOK : ∀ r → method r ≡ GET
            → resolve r ≡ OK
getOK r p rewrite p = refl

-- compare to casing on method

-- postCreated : ∀ r → method r ≡ POST
--                   → resolve r ≡ Created
-- postCreated r p rewrite p = refl

postCreated : ∀ r → method r ≡ POST
                  → resolve r ≡ Created
postCreated r p with method r | p
... | .POST | refl = refl

putInternalError : ∀ r → method r ≡ PUT
                   → resolve r ≡ InternalError
putInternalError r p rewrite p = refl

