module Karazie where
open import Data.Bool
open import Data.Nat
open import Data.Vec
open import Relation.Binary.PropositionalEquality

data Morality : Set where
  black white gray : Morality

karazie : Bool → ℕ
karazie _ with true
... | true  = 0
... | _ = 1337

alwaysZero : ∀ {b} → karazie b ≡ zero
alwaysZero = refl

andNow : ∀ {b} →
          karazie b ≡ 7 →
          Morality
andNow p rewrite p | p = {!!}

doitbabe : Bool → ℕ
doitbabe _ with gray
... | black = 0
... | _ = 1337

alwaysLeet : ∀ {b} → doitbabe b ≡ 1337
alwaysLeet = refl

apologiessir : Vec Morality 0
apologiessir = []

herewegooo : Bool → ℕ
herewegooo _ with apologiessir
... | [] = 7

luckynumbershweven : ∀ {b} → herewegooo b ≡ 7
luckynumbershweven = refl
