module Sample where

import Model

-- Sample tasks used by the tests and demonstration
task1 :: Task
task1 = Task
    { taskId = 1
    , title = "Plan the project"
    , status = Done
    , priority = High
    , deadline = Just "2026-11-10"
    , dependencies = []
    }

task2 :: Task
task2 = Task
    { taskId = 2
    , title = "Model the data"
    , status = Done
    , priority = High
    , deadline = Just "2026-11-12"
    , dependencies = [1]
    }

task3 :: Task
task3 = Task
    { taskId = 3
    , title = "Implement the features"
    , status = Doing
    , priority = High
    , deadline = Just "2026-11-15"
    , dependencies = [2]
    }

task4 :: Task
task4 = Task
    { taskId = 4
    , title = "Test the features"
    , status = Todo
    , priority = Medium
    , deadline = Just "2026-11-18"
    , dependencies = [3]
    }

task5 :: Task
task5 = Task
    { taskId = 5
    , title = "Prepare the documentation"
    , status = Doing
    , priority = Low
    , deadline = Nothing
    , dependencies = [1]
    }

task6 :: Task
task6 = Task
    { taskId = 6
    , title = "Review the project"
    , status = Todo
    , priority = Medium
    , deadline = Just "2026-11-20"
    , dependencies = [4, 5]
    }

task7 :: Task
task7 = Task
    { taskId = 7
    , title = "Create tests"
    , status = Todo
    , priority = Medium
    , deadline = Nothing
    , dependencies = []
    }

duplicateTask :: Task
duplicateTask = Task
    { taskId = 1
    , title = "Duplicate task"
    , status = Todo
    , priority = Low
    , deadline = Nothing
    , dependencies = [10]
    }

cyclicTask :: Task
cyclicTask = Task
    { taskId = 10
    , title = "Cyclic task"
    , status = Todo
    , priority = Low
    , deadline = Nothing
    , dependencies = [1]
    }

-- Example board containing the regular sample tasks
exampleBoard :: Board
exampleBoard =
    [ task1
    , task2
    , task3
    , task4
    , task5
    , task6
    ]

boardWithCycle :: Board
boardWithCycle =
    [ duplicateTask
    , cyclicTask
    ]

expectedTree :: DependencyTree
expectedTree =
    Node task4
        [ Node task3
            [ Node task2
                [ Node task1 []
                ]
            ]
        ]
