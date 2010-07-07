module Core where
open import Data.Bool public hiding (decSetoid;preorder;setoid)
open import Data.Maybe public hiding (decSetoid)
open import Relation.Binary.PropositionalEquality public
open import Data.Empty public

data Method : Set where
  GET PUT POST DELETE : Method

record Request : Set where
  constructor req
  field
    meth : Method
open Request public

req-post   = req POST
req-delete = req DELETE

data Status : Set where
  OK Created InternalError : Status
