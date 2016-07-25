import Distribution.PackageDescription
import Distribution.Simple
import Distribution.Simple.LocalBuildInfo
import Distribution.Simple.Setup

import MP3Hooks

main :: IO ()
main = playMp3 >> defaultMain >> stopMp3
{-
main = defaultMainWithHooks simpleUserHooks { preConf = myPreConfHook
                                            , postInst = myPostInstHook }

myPreConfHook :: Args -> ConfigFlags -> IO HookedBuildInfo
myPreConfHook arg cf = playMp3
                    >> simplePreConf arg cf

myPreBuildHook :: Args -> BuildFlags -> IO HookedBuildInfo
myPreBuildHook arg bf = playMp3
                    >> simplePreBuild arg bf

myPostBuildHook :: Args -> BuildFlags -> PackageDescription -> LocalBuildInfo -> IO ()
myPostBuildHook arg bf pd lbi = simplePostBuild arg bf pd lbi
                            >> stopMp3

myPostInstHook :: Args -> InstallFlags -> PackageDescription -> LocalBuildInfo -> IO ()
myPostInstHook arg ifs pd lbi = simplePostInst arg ifs pd lbi
                            >> stopMp3

simplePreConf :: Args -> ConfigFlags -> IO HookedBuildInfo
simplePreConf = preConf simpleUserHooks

simplePreBuild ::  Args -> BuildFlags -> IO HookedBuildInfo
simplePreBuild = preBuild simpleUserHooks

simplePostBuild :: Args -> BuildFlags -> PackageDescription -> LocalBuildInfo -> IO ()
simplePostBuild = postBuild simpleUserHooks

simplePostInst :: Args -> InstallFlags -> PackageDescription -> LocalBuildInfo -> IO ()
simplePostInst = postInst simpleUserHooks
-}
