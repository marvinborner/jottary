module Main
  ( main
  ) where

import           Lib
import           System.Environment             ( getArgs )
import           Term
import           Transpile

transpile :: String -> IO ()
transpile path = do
  file <- readFile path
  let term    = fromBLC file
  let ski     = transpileSKI term
  let jottary = transpileJottary ski
  putStrLn jottary

reduce :: String -> IO ()
reduce path = do
  file <- readFile path
  let termified = fromJottary file
  putStrLn $ "input: " ++ show termified
  normal <- nf termified
  putStrLn $ "reduced: " ++ show normal

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["transpile", path] -> transpile path
    ["reduce"   , path] -> reduce path
    _                   -> putStrLn "Usage: jottary [transpile|reduce] <file>"
