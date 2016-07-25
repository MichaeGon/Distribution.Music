{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}
module MP3Hooks.Core
    ( mp3PreBuildHookQ
    , mp3PostBuildHookQ
    ) where

import Control.Monad
import Data.List
import Data.Ord
import Language.Haskell.TH
import System.Directory
import System.Process
import System.Random

mp3PreBuildHookQ :: ExpQ
mp3PreBuildHookQ = runIO ioActions >> [| return () |]
    where
        ioActions = getCurrentDirectory
                >>= getDirectoryContents
                >>= shuffle . mp3s
                >>= br
        br [] = return ()
        br xs = (void . runCommand . (\x -> "afplay \"" ++ x ++ "\" &") . head) xs

mp3PostBuildHookQ :: ExpQ
mp3PostBuildHookQ = runIO ioActions >> [| return () |]
    where
        ioActions = void (runCommand "killall afplay")

mp3s :: [FilePath] -> [FilePath]
mp3s = filter (".mp3" `isSuffixOf`)

shuffle :: [a] -> IO [a]
shuffle xs = map fst . sortBy (comparing snd) <$> ys
    where
        ys = zip xs <$> (getRandoms :: IO [Int])

getRandoms :: (Random a) => IO [a]
getRandoms = randoms <$> getStdGen
