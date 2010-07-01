module Three where
open import Core

_==_ : Method → Method → Bool
GET == GET = true
PUT == PUT = true
POST == POST = true
DELETE == DELETE = true
_ == _ = false

end : Request → Status
end _ = InternalError

d2 : Request → Status
d2 r with method r == POST
... | true  = Created
... | false = end r

d1 : Request → Status
d1 r with method r == GET
... | true  = OK
... | false = d2 r

resolve : Request → Status
resolve = d1

getOK : ∀ r → method r ≡ GET
            → resolve r ≡ OK
getOK r p rewrite p = refl

postCreated : ∀ r → method r == POST ≡ true
                  → resolve r ≡ Created
postCreated r p with true | p
... | .(method r == POST) | refl = {!!}

-- putInternalError : ∀ r → method r ≡ PUT
--                    → resolve r ≡ InternalError
-- putInternalError r p rewrite p | p = refl
