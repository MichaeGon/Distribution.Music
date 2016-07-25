import Distribution.PackageDescription
import Distribution.Simple
import Distribution.Simple.LocalBuildInfo
import Distribution.Simple.Setup

main :: IO ()
main = defaultMainWithHooks simpleUserHooks { preBuild = myPreBuildHook
                                            , postBuild = myPostBuildHook }

myPreBuildHook :: Args -> BuildFlags -> IO HookedBuildInfo
myPreBuildHook arg bf = undefined
                    >> simplePreBuild arg bf

myPostBuildHook :: Args -> BuildFlags -> PackageDescription -> LocalBuildInfo -> IO ()
myPostBuildHook arg bf pd lbi = simplePostBuild arg bf pd lbi
                            >> undefined

simplePreBuild ::  Args -> BuildFlags -> IO HookedBuildInfo
simplePreBuild = preBuild simpleUserHooks

simplePostBuild :: Args -> BuildFlags -> PackageDescription -> LocalBuildInfo -> IO ()
simplePostBuild = postBuild simpleUserHooks
