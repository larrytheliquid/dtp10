module Assertion where
open import Core public

created? : Method → Bool
created? PUT  = true
created? POST = true
created? _    = false

test-POST-created? : created? POST ≡ true
test-POST-created? = refl

-- test-GET-created? : created? GET ≡ true
-- test-GET-created? = refl

-- false != true of type Bool
-- when checking that the expression refl has type false ≡ true
