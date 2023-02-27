module Padovan
open FStar.Mul

let rec padovan (n:nat) : nat =
   if n <= 2
      then 1
      else padovan (n - 2) + padovan (n - 3)

let rec sum (s : nat) (e : nat) (f : nat -> nat) : Tot nat (decreases e - s) =
   if s = e
      then f e
      else if s < e
         then f s + sum (s + 1) e f
         else 0

let sum1 (n:nat) = sum 0 n padovan
let sum2 (n:nat) = sum 0 n (fun (m:nat) -> padovan 2 * m)

let rec problem1 (n:nat{n > 2}) : Lemma ((sum1 n) = (padovan (n + 5)) - 2) =
   if n = 3
      then ()
      else problem1 (n - 1)
