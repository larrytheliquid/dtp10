module Slides where
open import Data.Bool

data Method : Set where
  GET POST : Method

_==_ : Method → Method → Bool
GET == GET = true
POST == POST = true
_ == _ = false

record Request : Set where
  field
    method : Method

data Status : Set where
  OK Created InternalError : Status

end : Request → Status
end _ = InternalError

d2 : Request → Status
d2 r with Request.method r == POST
... | true = Created
... | false = end r

-- TODO: show this versus casing on Method directly
d1 : Request → Status
d1 r with Request.method r == GET
... | true  = OK
... | false = d2 r

resolve : Request → Status
resolve = d1
