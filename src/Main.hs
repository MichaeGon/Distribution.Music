import Distribution.Simple

import MP3Hooks

main :: IO ()
main = playMp3 >>= main'
    where
        main' (Just h) = defaultMain >> stopMp3 h
        main' _ = defaultMain 
