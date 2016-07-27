module MP3Hooks
    ( playMp3
    , stopMp3
    ) where

import Control.Monad
import Data.List
import Data.Ord
import System.Directory
import System.Process
import System.Random


playMp3 :: IO (Maybe ProcessHandle)
playMp3 = getCurrentDirectory
        >>= getDirectoryContents
        >>= shuffle . mp3s
        >>= br
        where
            br [] = return Nothing
            br xs = Just <$> (spawnCommand . (\x -> "afplay \"" ++ x ++ "\" &") . head) xs


stopMp3 :: ProcessHandle -> IO ()
stopMp3 = terminateProcess

mp3s :: [FilePath] -> [FilePath]
mp3s = filter (".mp3" `isSuffixOf`)

shuffle :: [a] -> IO [a]
shuffle xs = map fst . sortBy (comparing snd) <$> ys
    where
        ys = zip xs <$> (getRandoms :: IO [Int])

getRandoms :: (Random a) => IO [a]
getRandoms = randoms <$> getStdGen
