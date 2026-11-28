module Domain where

import Model
import Data.List (sortBy)

findTask :: TaskId -> Board -> Maybe Task
findTask _ [] = Nothing
findTask target (task:tasks)
    | taskId task == target = Just task
    | otherwise = findTask target tasks

addTask :: Task -> Board -> Either String Board
addTask task board =
    case findTask (taskId task) board of
        Just _  -> Left ("A task with ID " ++ show (taskId task) ++ " already exists")
        Nothing -> Right (board ++ [task])

removeTask :: TaskId -> Board -> Either String Board
removeTask target board =
    if any (\task -> taskId task == target) board
        then Right (filter (\task -> taskId task /= target) board)
        else Left "No task exists with the given ID"

tasksByStatus :: Status -> Board -> [Task]
tasksByStatus selectedStatus board =
    filter (\task -> status task == selectedStatus) board

tasksByPriority :: Priority -> Board -> [Task]
tasksByPriority selectedPriority board =
    filter (\task -> priority task == selectedPriority) board

directDependencies :: TaskId -> Board -> [TaskId]
directDependencies target board =
    case findTask target board of
        Nothing -> []
        Just task -> dependencies task

countByStatus :: Status -> Board -> Int
countByStatus selectedStatus board =
    length (tasksByStatus selectedStatus board)

countByPriority :: Priority -> Board -> Int
countByPriority selectedPriority =
    length . tasksByPriority selectedPriority

transitiveDependencies :: TaskId -> Board -> [TaskId]
transitiveDependencies target board =
    filter (/= target) (walk (directDependencies target board) [target] board)
    where
        walk :: [TaskId] -> [TaskId] -> Board -> [TaskId]
        walk [] visited _ = visited
        walk (current:remaining) visited currentBoard
            | elem current visited =
                walk remaining visited currentBoard
            | otherwise =
                walk (remaining ++ directDependencies current currentBoard)
                     (current:visited)
                     currentBoard

hasCycle :: Board -> Bool
hasCycle board = checkBoard board board
    where
        checkBoard [] _ = False
        checkBoard (task:remaining) currentBoard
            | visit (taskId task) [] currentBoard = True
            | otherwise = checkBoard remaining currentBoard

        visit target path currentBoard
            | elem target path = True
            | otherwise = checkDependencies deps newPath currentBoard
            where
                newPath = target : path
                deps = directDependencies target currentBoard

        checkDependencies :: [TaskId] -> [TaskId] -> Board -> Bool
        checkDependencies [] _ _ = False
        checkDependencies (target:remaining) path currentBoard
            | visit target path currentBoard = True
            | otherwise = checkDependencies remaining path currentBoard

buildDependencyTree :: TaskId -> Board -> Maybe DependencyTree
buildDependencyTree target board = build target []
    where
        build current path
            | current `elem` path = Nothing
            | otherwise =
                case findTask current board of
                    Nothing -> Nothing
                    Just task ->
                        let deps = directDependencies current board
                            newPath = current : path
                        in case buildChildren deps newPath of
                            Nothing -> Nothing
                            Just children -> Just (Node task children)

        buildChildren :: [TaskId] -> [TaskId] -> Maybe [DependencyTree]
        buildChildren [] _ = Just []
        buildChildren (current:remaining) path =
            case build current path of
                Nothing -> Nothing
                Just tree ->
                    case buildChildren remaining path of
                        Nothing -> Nothing
                        Just rest -> Just (tree : rest)

treeDepth :: DependencyTree -> Int
treeDepth (Node _ []) = 1
treeDepth (Node _ children) = 1 + maximum (map treeDepth children)

blockedTasks :: Board -> [Task]
blockedTasks board =
    filter aux board
    where
        aux :: Task -> Bool
        aux task =
            any (\depId ->
                case findTask depId board of
                    Nothing  -> True
                    Just dep -> status dep /= Done
                ) (dependencies task) 

readyTasks :: Board -> [Task]
readyTasks board =
    filter aux board
    where
        aux :: Task -> Bool
        aux task = 
            status task /= Done &&
            all (\depId ->
                case findTask depId board of
                    Nothing  -> False
                    Just dep -> status dep == Done
                ) (dependencies task)

overdueTasks :: String -> Board -> [Task]
overdueTasks currentDate board =
    filter aux board
    where
        aux :: Task -> Bool
        aux task =
            case deadline task of
                Nothing   -> False
                Just date -> date < currentDate

completionRate :: Board -> Float
completionRate [] = 0
completionRate board =
    (fromIntegral (countByStatus Done board) / fromIntegral (length board)) * 100

-- Pipeline 1: Checks what high-priority tasks are ready to be completed (tasks which are not currently ready, but whose dependencies are)
readyHighPriority :: Board -> [TaskId]
readyHighPriority board =
    (map taskId . tasksByPriority High . readyTasks) board

-- Pipeline 2: Counts how many tasks of a certain priority (chosen by the user as input) are currently overdue and not listed as "done"
countOverdueByPriority :: String -> Priority -> Board -> Int
countOverdueByPriority currentDate selectedPriority =
    foldr (\_ acc -> acc + 1) 0 . filter (\task -> status task /= Done) . tasksByPriority selectedPriority . overdueTasks currentDate

-- Pipeline 3: Gives a list of titles of blocked tasks (tasks whose dependencies aren't completed), organized by priority
blockedTasksByPriority :: Board -> [String]
blockedTasksByPriority =
    map title .
    sortBy (\task1 task2 -> compare (priority task1) (priority task2)) . blockedTasks
