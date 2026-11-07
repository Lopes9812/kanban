module Sample where

import Model

--tarefas para teste
tarefa1 :: Tarefa
tarefa1 = Tarefa
    { tarefaId = 1
    , titulo = "Planear o projeto"
    , estado = Done
    , prioridade = Alta
    , prazo = Just "2026-11-10"
    , dependencias = []
    }

tarefa2 :: Tarefa
tarefa2 = Tarefa
    { tarefaId = 2
    , titulo = "Modelar os dados"
    , estado = Done
    , prioridade = Alta
    , prazo = Just "2026-11-12"
    , dependencias = [1]
    }

tarefa3 :: Tarefa
tarefa3 = Tarefa
    { tarefaId = 3
    , titulo = "Implementar as funcionalidades"
    , estado = Doing
    , prioridade = Alta
    , prazo = Just "2026-11-15"
    , dependencias = [2]
    }

tarefa4 :: Tarefa
tarefa4 = Tarefa
    { tarefaId = 4
    , titulo = "Testar as funcionalidades"
    , estado = Todo
    , prioridade = Media
    , prazo = Just "2026-11-18"
    , dependencias = [3]
    }

tarefa5 :: Tarefa
tarefa5 = Tarefa
    { tarefaId = 5
    , titulo = "Preparar a documentação"
    , estado = Doing
    , prioridade = Baixa
    , prazo = Nothing
    , dependencias = [1]
    }

tarefa6 :: Tarefa
tarefa6 = Tarefa
    { tarefaId = 6
    , titulo = "Rever o projeto"
    , estado = Todo
    , prioridade = Media
    , prazo = Just "2026-11-20"
    , dependencias = [4, 5]
    }

tarefa7 :: Tarefa
tarefa7 = Tarefa
    { tarefaId = 7
    , titulo = "Criar testes"
    , estado = Todo
    , prioridade = Media
    , prazo = Nothing
    , dependencias = []
    }

tarefaDuplicada :: Tarefa
tarefaDuplicada = Tarefa
    { tarefaId = 1
    , titulo = "Tarefa duplicada"
    , estado = Todo
    , prioridade = Baixa
    , prazo = Nothing
    , dependencias = [10]
    }

tarefaciclo :: Tarefa
tarefaciclo = Tarefa
    { tarefaId = 10
    , titulo = "Tarefa duplicada"
    , estado = Todo
    , prioridade = Baixa
    , prazo = Nothing
    , dependencias = [1]
    }
-- Quadro completo com as tarefas de exemplo

quadroExemplo :: Quadro
quadroExemplo =
    [ tarefa1
    , tarefa2
    , tarefa3
    , tarefa4
    , tarefa5
    , tarefa6
    ]
quadrocomciclo :: Quadro
quadrocomciclo =
    [ tarefaDuplicada
    , tarefaciclo  
    ]

arvoreEsperada :: ArvoreDeps
arvoreEsperada =
    No tarefa4
        [ No tarefa3
            [ No tarefa2
                [ No tarefa1 []
                ]
            ]
        ]