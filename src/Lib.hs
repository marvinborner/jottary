{-# LANGUAGE LambdaCase #-}

module Lib
  ( fromJotter
  ) where

import           Term

data State = L | R

s :: Term
s = Abs (Abs (Abs (App (App (Idx 2) (Idx 0)) (App (Idx 1) (Idx 0)))))

k :: Term
k = Abs (Abs (Idx 1))

i :: Term
i = Abs (Idx 0)

-- reverse wouldn't be needed if [0F] instead of [F0]
fromJotter :: String -> Term
fromJotter = go L . reverse
 where
  go L ('0' : xs) = App s (go R xs)
  go R ('0' : xs) = App (go L xs) s
  go L ('1' : xs) = App k (go R xs)
  go R ('1' : xs) = App (go L xs) k
  go d (_   : xs) = go d xs
  go _ []         = i
