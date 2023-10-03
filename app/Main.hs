{-# LANGUAGE LambdaCase #-}

module Main
  ( main
  ) where

import           Lib
import           System.Environment             ( getArgs )
import           Term

reduce :: String -> IO ()
reduce path = do
  file <- readFile path
  let termified = fromJotter file
  putStrLn $ "input: " ++ show termified
  normal <- nf termified
  putStrLn $ "reduced: " ++ show normal

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["reduce", path] -> reduce path
    _                -> putStrLn "Usage: jotter [transpile|reduce] <file>"
