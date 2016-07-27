{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}

-- dummy
module Main where

import Language.Haskell.TH
import System.Process

$( runIO (runCommand "pwd" >> runCommand "touch test.txt") >> [d| main = return () |] )
