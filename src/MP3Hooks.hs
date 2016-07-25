{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}
module MP3Hooks
    ( mp3PreBuildHook
    , mp3PostBuildHook
    ) where

import Data.List
import Language.Haskell.TH

import MP3Hooks.Core

mp3PreBuildHook :: IO ()
mp3PreBuildHook = $(mp3PreBuildHookQ)

mp3PostBuildHook :: IO ()
mp3PostBuildHook = $(mp3PostBuildHookQ)
