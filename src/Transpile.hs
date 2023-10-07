-- This code partly uses algorithms (drip/abstract) created by John Tromp.
-- Since they did not license their code (afaik), I assume it's okay to reuse it.

module Transpile
  ( transpileSKI
  , transpileJottary
  ) where

import           Term
import           Utils

data SKI = S | K | I | AppSKI SKI SKI | IdxSKI Int
  deriving (Eq, Ord)

instance Show SKI where
  showsPrec _ S = showString "s"
  showsPrec _ K = showString "k"
  showsPrec _ I = showString "i"
  showsPrec _ (AppSKI x y) =
    showString "(" . shows x . showString " " . shows y . showString ")"
  showsPrec _ (IdxSKI i) = shows i

drip :: SKI -> SKI
drip i@(AppSKI (AppSKI S K) _) = i
drip (  IdxSKI 0             ) = invalid
drip (  IdxSKI i             ) = IdxSKI (i - 1)
drip (  AppSKI x y           ) = AppSKI (drip x) (drip y)
drip x                         = x

abstract :: SKI -> SKI
abstract (AppSKI sk@(AppSKI S K) _) = sk
abstract e = if freeIn (== 0) e then occabstract e else AppSKI K (drip e) where
  freeIn _  (AppSKI (AppSKI S K) _) = False
  freeIn fv (AppSKI x            y) = freeIn fv x || freeIn fv y
  freeIn fv (IdxSKI i             ) = fv i
  freeIn _  _                       = False
  isConst = not . freeIn (const True)
  occabstract (IdxSKI 0) = I
  occabstract (AppSKI m (IdxSKI 0)) | not (freeIn (== 0) m) = drip m
  occabstract (AppSKI (AppSKI l m) l') | l == l' =
    occabstract (AppSKI (AppSKI (AppSKI (AppSKI S S) K) l) m)
  occabstract (AppSKI m (AppSKI n l)) | isConst m && isConst n =
    occabstract (AppSKI (AppSKI (AppSKI S (abstract m)) n) l)
  occabstract (AppSKI (AppSKI m n) l) | isConst m && isConst l =
    occabstract (AppSKI (AppSKI (AppSKI S m) (abstract l)) n)
  occabstract (AppSKI (AppSKI m l) (AppSKI n l'))
    | l == l' && isConst m && isConst n = occabstract
      (AppSKI (AppSKI (AppSKI S m) n) l)
  occabstract (AppSKI e1 e2) = AppSKI (AppSKI S (abstract e1)) (abstract e2)
  occabstract _              = invalid

transpileSKI :: Term -> SKI
transpileSKI (Idx i  ) = IdxSKI i
transpileSKI (App m n) = AppSKI (transpileSKI m) (transpileSKI n)
transpileSKI (Abs m  ) = abstract (transpileSKI m)

fromBinary :: [Bool] -> Int
fromBinary (x : xs) = fromEnum x + 2 * fromBinary xs
fromBinary []       = 0

jottarify :: SKI -> Int
jottarify s = fromBinary (reverse $ True : go s) - 1
 where
  go S            = [True, True, True, True, True, False, False, False]
  go K            = [True, True, True, False, False]
  go I            = go $ AppSKI (AppSKI S K) K
  go (AppSKI a b) = True : (go a ++ go b)
  go _            = invalid

transpileJottary :: SKI -> String
transpileJottary s = replicate (jottarify s) '1'
