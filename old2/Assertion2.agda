module Assertion2 where
open import Core public

created? : Request → Bool
created? r with method r
... | PUT  = true
... | POST = true
... | _    = false

test-POST-created? : created? (req POST) ≡ true
test-POST-created? = refl

-- test-GET-created? : created? (req GET) ≡ true
-- test-GET-created? = refl

-- false != true of type Bool
-- when checking that the expression refl has type false ≡ true
