module Hmm where
open import Data.Bool
open import Data.Nat
open import Relation.Binary.PropositionalEquality

hmm : (3 * 4) ≡ 7 → Bool
hmm p with 7 | p
... | .12 | refl = {!!}

hmm2 : (3 * 4) ≡ 7 → Bool
hmm2 ()

sevener : Bool → ℕ 
sevener true = 7
sevener false = 11

-- this false versus vec head/tail
hmm3 : (b : Bool) → sevener b ≡ 7 → Bool
hmm3 true p = {!!}
hmm3 false p with 7 | p
... | .(sevener false) | refl = {!!}
-- hmm3 false ()
