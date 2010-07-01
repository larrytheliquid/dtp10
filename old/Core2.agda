module Core2 where
open import Data.Bool public hiding (decSetoid;preorder;setoid)
open import Relation.Binary.PropositionalEquality public

data Method : Set where
  GET PUT POST DELETE : Method

data Request : Set where
  req : (method : Method) → Request

method : Request → Method
method (req m) = m

data Status : Set where
  OK Created InternalError : Status
