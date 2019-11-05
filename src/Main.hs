module Main where

import Data.Semigroup
import System.CPUTime
import Control.DeepSeq
import GHC.Real

-- Prelude> maxBound :: Word
-- 18446744073709551615

testStimes :: String
testStimes = stimes 1000000 "foo"

testIntegralPower :: Integer
testIntegralPower = 3 ^ 1000000

testFractionalPower :: Double
testFractionalPower = 5 ^^ 441

main :: IO ()
main = do
  measure "stimes : " testStimes
  measure "fractional power 1 : " testFractionalPower
  measure "fractional power 2 : " testFractionalPower
  measure "fractional power 3 : " testFractionalPower
  measure "integral power : " testIntegralPower

measure :: NFData a => String -> a -> IO ()
measure description f = do
  start <- getCPUTime
  let a = f
  end <- a `deepseq` getCPUTime
  let duration = (end - start) :: Integer
      durationInSeconds = duration `div` 1000000000
  print $ description ++ show durationInSeconds ++ " milli seconds -- " ++ show duration ++ " pico seconds"
