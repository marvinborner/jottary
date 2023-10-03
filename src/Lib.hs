{-# LANGUAGE LambdaCase #-}

module Lib
  ( fromJotter
  ) where

import           Term
import           Utils

data State = L | R

s :: Term
s = Abs (Abs (Abs (App (App (Idx 2) (Idx 0)) (App (Idx 1) (Idx 0)))))

k :: Term
k = Abs (Abs (Idx 1))

i :: Term
i = Abs (Idx 0)

clean :: String -> String
clean (x : xs) | x == '0' || x == '1' = x : clean xs
               | otherwise            = clean xs
clean [] = []

-- reverse wouldn't be needed if [0F] instead of [F0]
fromCleanJotter :: String -> Term
fromCleanJotter t | even $ length t = go L $ reverse t
                  | otherwise       = go R $ reverse t
 where
  go L ('0' : xs) = App s (go R xs)
  go R ('0' : xs) = App (go L xs) s
  go L ('1' : xs) = App k (go R xs)
  go R ('1' : xs) = App (go L xs) k
  go _ []         = i
  go _ _          = invalid

fromJotter :: String -> Term
fromJotter = fromCleanJotter . clean
