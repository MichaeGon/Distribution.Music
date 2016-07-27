module MP3Hooks
    ( playMp3
    , playMp3'
    , stopMp3
    , stopMp3'
    ) where

import Control.Monad
import Data.List
import Data.Ord
import System.Directory
import System.Process
import System.Random

playMp3 :: IO ()
playMp3 = pconfig >>= play
    where
        play [] = return ()
        play xs = void . runCommand . (\x -> "afplay \"" ++ x ++ "\" &") . head $  xs

playMp3' :: IO (Maybe ProcessHandle)
playMp3' = pconfig >>= play
        where
            play [] = return Nothing
            play xs = Just <$> (spawnCommand . (\x -> "afplay \"" ++ x ++ "\" &") . head) xs

pconfig :: IO [FilePath]
pconfig = getCurrentDirectory
    >>= getDirectoryContents
    >>= shuffle . mp3s

stopMp3 :: IO ()
stopMp3 = callCommand "killall afplay"

stopMp3' :: ProcessHandle -> IO ()
stopMp3' = terminateProcess

mp3s :: [FilePath] -> [FilePath]
mp3s = filter (".mp3" `isSuffixOf`)

shuffle :: [a] -> IO [a]
shuffle xs = map fst . sortBy (comparing snd) <$> ys
    where
        ys = zip xs <$> (getRandoms :: IO [Int])

getRandoms :: (Random a) => IO [a]
getRandoms = randoms <$> getStdGen
