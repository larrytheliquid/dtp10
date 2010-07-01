module Core where
open import Data.Bool public hiding (decSetoid;preorder;setoid)
open import Relation.Binary.PropositionalEquality public

data Method : Set where
  GET PUT POST DELETE : Method

record Request : Set where
  constructor req
  field
    method : Method

open Request public

data Status : Set where
  OK Created InternalError : Status
