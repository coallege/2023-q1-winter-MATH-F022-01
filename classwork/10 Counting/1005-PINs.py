# 2240
from typing import *

digits = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}

def even(n: int) -> bool:
   return n % 2 == 1

def choose(n: int = 1, bag: Set[int] = digits, chosen = "") -> int:
   if n == 1:
      for digit in bag - {0}:
         choose(2, bag - {digit}, f"{digit}")
      return

   if n == 2 or n == 3:
      for digit in bag:
         choose(n + 1, bag - {digit}, f"{chosen}{digit}")

   if n == 4:
      for digit in bag - {0, 2, 4, 6, 8}:
         print(f"{chosen}{digit}")

choose()
