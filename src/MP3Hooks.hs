module MP3Hooks
    ( mp3PreBuildHook
    , mp3PostBuildHook
    ) where

import Control.Monad
import Data.List
import Data.Ord
import System.Directory
import System.Process
import System.Random


mp3PreBuildHook :: IO ()
mp3PreBuildHook = getCurrentDirectory
            >>= getDirectoryContents
            >>= shuffle . mp3s
            >>= br
            where
                br [] = return ()
                br xs = (void . runCommand . (\x -> "afplay \"" ++ x ++ "\" &") . head) xs


mp3PostBuildHook :: IO ()
mp3PostBuildHook = void (runCommand "killall afplay")

{-}
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
-}

mp3s :: [FilePath] -> [FilePath]
mp3s = filter (".mp3" `isSuffixOf`)

shuffle :: [a] -> IO [a]
shuffle xs = map fst . sortBy (comparing snd) <$> ys
    where
        ys = zip xs <$> (getRandoms :: IO [Int])

getRandoms :: (Random a) => IO [a]
getRandoms = randoms <$> getStdGen
