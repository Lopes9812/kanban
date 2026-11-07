module Model where

-- Unique identifier for a task
type TaskId = Int

-- Current status of a task on the Kanban board
data Status = Todo | Doing | Done
    deriving (Eq, Show)

-- Priority assigned to a task
data Priority = Low | Medium | High
    deriving (Eq, Ord, Show)

-- Data that describes a task
data Task = Task
    { taskId       :: TaskId
    , title        :: String
    , status       :: Status
    , priority     :: Priority
    , deadline     :: Maybe String
    , dependencies :: [TaskId]
    } deriving (Eq)

instance Show Task where
    show task =
        "Task #" ++ show (taskId task) ++
        "\n  Title: " ++ title task ++
        "\n  Status: " ++ show (status task) ++
        "\n  Priority: " ++ show (priority task) ++
        "\n  Deadline: " ++ showDeadline (deadline task) ++
        "\n  Dependencies: " ++ showDependencies (dependencies task)

showDeadline :: Maybe String -> String
showDeadline Nothing = "Not set"
showDeadline (Just date) = date

showDependencies :: [TaskId] -> String
showDependencies [] = "none"
showDependencies ids = show ids

-- A board is a list of tasks
type Board = [Task]

-- Tree representing a task and its dependencies
data DependencyTree = Node Task [DependencyTree]
    deriving (Eq, Show)
