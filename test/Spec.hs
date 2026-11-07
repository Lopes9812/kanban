module Main where

import Domain
import Model
import Sample
import Data.List (sort)

testFindTask :: String
testFindTask =
    let result1 =
            case findTask 1 exampleBoard of
                Just task
                    | taskId task == 1 -> "Passed"
                    | otherwise -> "Failed: a task with the wrong ID was found."
                Nothing -> "Failed: task with ID 1 was not found."
        result2 =
            case findTask (-1) exampleBoard of
                Just _ -> "Failed: a task was found when none should exist."
                Nothing -> "Passed"
    in "Find existing task: " ++ result1
       ++ "\nFind non-existing task: " ++ result2

testAddTask :: String
testAddTask =
    let result1 =
            case addTask task7 exampleBoard of
                Left _  -> "Failed"
                Right _ -> "Passed"
        result2 =
            case addTask task1 exampleBoard of
                Left _  -> "Passed"
                Right _ -> "Failed: a task with a duplicate ID was added."
    in "Add new task: " ++ result1
       ++ "\nAdd duplicate task: " ++ result2

testRemoveTask :: String
testRemoveTask =
    let result1 =
            case removeTask 6 exampleBoard of
                Left _  -> "Failed"
                Right _ -> "Passed"
        result2 =
            case removeTask (-1) exampleBoard of
                Left _  -> "Passed"
                Right _ -> "Failed"
    in "Remove existing task: " ++ result1
       ++ "\nRemove non-existing task: " ++ result2

testStatuses :: String
testStatuses =
    let result1 =
            if countByStatus Todo exampleBoard == 2
                then "Passed"
                else "Failed: incorrect Todo count"
        result2 =
            if countByStatus Doing exampleBoard == 2
                then "Passed"
                else "Failed: incorrect Doing count"
    in "Count Todo tasks: " ++ result1
       ++ "\nCount Doing tasks: " ++ result2

testDependencies :: String
testDependencies =
    let result1 =
            if sort (directDependencies 4 exampleBoard) == [3]
                then "Passed"
                else "Failed"
        result2 =
            if sort (transitiveDependencies 6 exampleBoard) == [1, 2, 3, 4, 5]
                then "Passed"
                else "Failed"
    in "Direct dependencies: " ++ result1
       ++ "\nTransitive dependencies: " ++ result2

testCycles :: String
testCycles =
    let result1 =
            if hasCycle boardWithCycle
                then "Passed"
                else "Failed: cycle was not detected"
        result2 =
            if not (hasCycle exampleBoard)
                then "Passed"
                else "Failed: a non-existent cycle was detected"
    in "Detect existing cycle: " ++ result1
       ++ "\nDetect absent cycle: " ++ result2

testBuildTree :: String
testBuildTree =
    let result1 =
            case buildDependencyTree 4 exampleBoard of
                Just tree ->
                    if tree == expectedTree
                        then "Passed"
                        else "Failed: tree differs from expected result"
                Nothing -> "Failed: could not build the tree"
        result2 =
            case buildDependencyTree 10 boardWithCycle of
                Just _ -> "Failed: built a tree with circular dependencies"
                Nothing -> "Passed"
    in "Build dependency tree: " ++ result1
       ++ "\nReject cyclic dependency tree: " ++ result2

testTreeDepth :: String
testTreeDepth =
    let result =
            if treeDepth expectedTree == 4
                then "Passed"
                else "Failed"
    in "Tree depth: " ++ result

main :: IO ()
main = do
    putStrLn "Running tests..."
    putStrLn testFindTask
    putStrLn testAddTask
    putStrLn testRemoveTask
    putStrLn testStatuses
    putStrLn testDependencies
    putStrLn testCycles
    putStrLn testBuildTree
    putStrLn testTreeDepth
