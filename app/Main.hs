module Main where

import Model
import Domain
import Sample

main :: IO ()
main = do
    putStrLn "Kanban Task Manager"
    putStrLn "Functional Programming Project"
    putStrLn ""

    putStrLn "Tasks in progress:"
    mapM_ print (tasksByStatus Doing exampleBoard)

    putStrLn ""
    putStrLn "Task with ID 6:"
    case findTask 6 exampleBoard of
        Just task -> print task
        Nothing -> putStrLn "Task not found."

    putStrLn ""
    putStrLn "Transitive dependencies of task 6:"
    print (transitiveDependencies 6 exampleBoard)

    putStrLn ""
    putStrLn "Does the example board contain a closed cycle?"
    if hasCycle exampleBoard==True then
        putStrLn "Yes"
    else
        putStrLn "No"
