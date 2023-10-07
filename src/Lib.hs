{-# LANGUAGE LambdaCase #-}

module Lib
  ( fromJottary
  , s
  , k
  , i
  ) where

import           Control.Monad                  ( replicateM )
import           Debug.Trace                    ( trace )
import           Term

s :: Term
s = Abs (Abs (Abs (App (App (Idx 2) (Idx 0)) (App (Idx 1) (Idx 0)))))

k :: Term
k = Abs (Abs (Idx 1))

i :: Term
i = Abs (Idx 0)

count :: String -> Int
count (x : xs) | x == '1'  = 1 + count xs
               | otherwise = count xs
count [] = 0

fromDecimalJottary :: Int -> Term
fromDecimalJottary p = foldr1 App (reverse (gen !! p) ++ [i])
 where
  lio = Abs (App (App (Idx 0) s) k)
  rio = Abs (App s (App k (Idx 0)))
  gen = [0 ..] >>= (`replicateM` [lio, rio])

fromJottary :: String -> Term
fromJottary t = trace (show $ count t) (fromDecimalJottary $ count t)
